<?php

require __DIR__ . '/../vendor/autoload.php';

session_start();

// Instantiate the app

$settings = [];
$settings['urls'] = require __DIR__ . '/../config/urls.php';
// slim fixed-named settings , need to be in $settings['settings']
$settings['settings'] = require __DIR__ . '/../config/settings.php';
// database connection
$settings['database'] = require __DIR__ . '/../config/database.php';

// $settings['error_log'] = require __DIR__ . '/../config/error_log.php';

$settings['usage_log'] = require __DIR__ . '/../config/usage_log.php';
$settings['error_log']  = require __DIR__ . '/../config/error_logger.php';

$settings['alert_mail'] = require __DIR__ . '/../config/alert_mail.php';

$app = new \Slim\App($settings);

// Load App dependencies
require __DIR__ . '/../app/dependency.php';

// Register routes
require __DIR__ . '/../app/controllers.php';

// Register routes
require __DIR__ . '/../app/models.php';

// Register routes
require __DIR__ . '/../app/routes.php';


// Run!
$app->run();
