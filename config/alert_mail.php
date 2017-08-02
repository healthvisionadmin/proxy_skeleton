<?php 
// return [
//     "from" => ["alert@hvaa.nl"],
//     // "to"=>['lars@felixexpress.de','s.rispens@knowledgeatwork.eu'],
//     "to"=>['lars@felixexpress.de'],
//     "smtp" => [
//         'host' => 'sslout.df.eu',
//         'username' => 'clever@cleverimpact.de',
//         'password' => 'qyJ)ja4fwx+z',
//         'secure' => 'ssl',
//         'port' => 465,
//         // 'context' =>  [
//         //     'ssl' => [
//         //         'capath' => '/var/www/cyclo/inquiry2017/mail_ssl_cert/sslout.df.eu.cer',
//         //      ],
//         // ],
//     ]
// ];
return [
    "from" => ["alert@hvaa.nl"],
    // "to"=>['lars@felixexpress.de','s.rispens@knowledgeatwork.eu'],
    "to"=>['lars@felixexpress.de'],
    "smtp" => [
        'host' => 'sslout.df.eu',
        'username' => 'clever@cleverimpact.de',
        'password' => 'qyJ)ja4fwx+z',
        'secure' => 'ssl',
        'port' => 465,
        // 'context' =>  [
        //     'ssl' => [
        //         'capath' => '/var/www/cyclo/inquiry2017/mail_ssl_cert/sslout.df.eu.cer',
        //      ],
        // ],
    ]
];

define('HOST','smtp.gmail.com');
define('SMTPAuth',true);
define('Username','testmail7x24@gmail.com');
define('Password','W3ltone432@');
define('SMTPSecure','tls');
define('Port',587);
define('Mailer','testmail7x24@gmail.com');