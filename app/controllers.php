<?php
# -----------------------------------------------------------------------------
# Action factories Controllers
# -----------------------------------------------------------------------------


/* User service controllers */

$container['App\Action\userService\UserController'] = function ($container) {
    return new App\Action\userService\UserController($container);
};

/* core service controllers */

$container['App\Action\coreService\InitialisationController'] = function ($container) {
    return new App\Action\coreService\InitialisationController($container);
};

/* App service controllers */

$container['App\Action\appService\FontServiceController'] = function ($container) {
    return new App\Action\appService\FontServiceController($container);
};
