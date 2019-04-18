#!/usr/bin/php
<?php

require_once('path.inc');
require_once('get_host_info.inc');
require_once('rabbitMQLib.inc');



function checkVer($sqlStatement) {
        $db = mysqli_connect("127.0.0.1", "admin", "password", "490db");
        $runQuery = mysqli_query($db, $sqlStatement);
        $queryResults = mysqli_num_rows($runQuery);     
        if (!$db) {
                die("MySQL Connection Failed: " . mysqli_connect_error() );
        } else {
             if ( $queryResults > 0 ) {
                while ($row = mysqli_fetch_assoc($runQuery)) {
                     $tmpArray[] = $row; 
                }
                print_r($tmpArray);
                return $tmpArray;
             }
       }

}


function updateDB($sqlStatement) {
        $db = mysqli_connect("127.0.0.1", "admin", "password", "490db");
	mysqli_query($db, $sqlStatement);
       //print_r("updateDB Query: $sqlStatement");

}


function requestProcessor($request)
{
  echo "received request".PHP_EOL;
  var_dump($request);
  if(!isset($request['type']))
  {
    return "ERROR: unsupported message type";
  }
  switch ($request['type'])
  {
    case "checkver":
      return checkVer($request['sqlStatement']);
    case "updatedb":
      return updateDB($request['sqlStatement']);
    case "good":
      return good($request['$type']);
    case "bad":
      return bad($request['$type']);
    //case "validate_session":
      //return doValidate($request['sessionId']);
  }
  return array("returnCode" => '0', 'message'=>"Server received request and processed");
}

$server = new rabbitMQServer("testRabbitMQ.ini","testServer");

echo "testRabbitMQServer BEGIN".PHP_EOL;
$server->process_requests('requestProcessor');
echo "testRabbitMQServer END".PHP_EOL;
exit();
?>




