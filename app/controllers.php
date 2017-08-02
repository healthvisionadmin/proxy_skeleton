<?php
# -----------------------------------------------------------------------------
# Action factories Controllers
# -----------------------------------------------------------------------------


/* User service controllers */

$container['App\Action\userService\UserController'] = function ($container) {
    return new App\Action\userService\UserController($container);
};
