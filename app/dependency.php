<?php
/**
 DIC configuration, inject dependencies into container
 */
$container = $app->getContainer();

/**
 * adding overall error logger 
 * config file returns a logger function
 */
$error_logger = new App\Services\LoggerFactory($settings['error_log']);
$container['error_logger'] = $error_logger->getLogger();


// database, if set
if (isset($settings['database'])) {
  $capsule = (new Illuminate\Database\Capsule\Manager);
  $capsule->addConnection($settings['database']);
  $capsule->setAsGlobal();
  $capsule->bootEloquent();
  if (isset($settings['debug']) && $settings['debug'] == true) {
    if ($debug == true) {
      $capsule::connection()->enableQueryLog();
    }
  }
}

/* adding email as a convinient service*/
$mailer = new App\Services\Mailer($settings['alert_mail']);
$container["alert_mailer"] = $mailer;

/**
 * adding overall usage logger as middleware
 * log every access to every endpoint
 */
$app->add(new App\Middleware\LoggerUsage($settings['usage_log']));


/* app wide error handler service */
$container["phpErrorHandler"] = $container["errorHandler"] = function ($container) {
  return function ($request, $response, $exception) use ($container) {
    $data = [
      'code' => $exception->getCode(),
      'message' => $exception->getMessage(),
      'file' => $exception->getFile(),
      'line' => $exception->getLine(),
      'trace' => explode("\n", $exception->getTraceAsString()),
    ];
    // log to error
    $container["error_logger"]->alert(json_encode($data));
    /*send an alert email*/
    $container["alert_mailer"]->sendmail("testing",json_encode($data));

    if ($container['settings']['debug']) {
      return $container['response']
        ->withStatus(500)
        ->withHeader('Content-type', 'application/json')
        ->write(json_encode(["error"=>$data]));
    } else {
      return $container['response']
        ->withStatus(500)
        ->withHeader('Content-type', 'application/json')
        ->write(json_encode(["message"=>'Something went wrong']));
    }
  };
};

/* wrong method i.e. diffusing GET and POST */
$container["notAllowedHandler"] = function ($container) {
    return function ($request, $response, $methods) use ($container) {
        $warning = "405_method_not_allowed : " . $request->getUri()->__toString();
      if ($container['settings']['debug'] || $container["error_log"]['log_method_not_allowed']) {

        $container["error_logger"]->warn($warning);
      }
        return $container['response']
            ->withStatus(405)
            ->withHeader('Allow', implode(', ', $methods))
            ->withHeader('Content-type', 'application/json')
            ->write(json_encode(["message"=>'Method must be one of: ' . implode(', ', $methods)]));
    };
};


$container["notFoundHandler"] = function ($container) {
    return function ($request, $response) use ($container) {
      // dd($container['settings']);
      if ($container['settings']['debug'] 
        || $container["error_log"]['log_404']) 
      {
        $warning = "404_NotFound : " . $request->getUri()->__toString();
        $container["error_logger"]->warn($warning);
      }

        return $container['response']
            ->withStatus(404)
            ->withHeader('Content-Type', 'application/json')
            ->write(json_encode(["message"=>'Item not found']));
    };
};


$container['validator'] = function () {
  return new Awurth\SlimValidation\Validator();
  //return new \DavidePastore\Slim\Validation\Validation();
};