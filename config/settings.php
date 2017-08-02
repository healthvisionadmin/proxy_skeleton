<?php
/* mostly slim fixed-named settings , need to be in $settings['settings']*/
return [
    // 'determineRouteBeforeAppMiddleware' => true, // this a slim setting
    'debug'         => true, // this is used extensivly, make sure to turn off on live
    'only_ec'         => false, // when ON api is working only with ec (encrypted endpoints)
    'displayErrorDetails' => true, // 
    'environment' => "dev | live | production" // not used in moment
];
