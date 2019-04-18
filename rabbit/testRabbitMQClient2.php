<?php

require_once('path.inc');
require_once('get_host_info.inc');
require_once('rabbitMQLib.inc');


function checkVer($sqlStatement) {
        $client = new rabbitMQClient("testRabbitMQ.ini","testServer");
        if (isset($argv[1]))
        {
                $msg = $argv[1];
        }
        else
        {
                $msg = "test message";
        }

        $request = array();
        $request['type'] = "checkver";
        $request['sqlStatement'] = $sqlStatement;
        $request['message'] = $msg;
        $response = $client->send_request($request);

        return $response;


}


function updateDB($sqlStatement) {
        $client = new rabbitMQClient("testRabbitMQ.ini","testServer");
        if (isset($argv[1]))
        {
                $msg = $argv[1];
        }
        else
        {
                $msg = "test message";
        }

        $request = array();
        $request['type'] = "updatedb";
        $request['sqlStatement'] = $sqlStatement;
        $request['message'] = $msg;
        $response = $client->send_request($request);

        return $response;

}

?>



