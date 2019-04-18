<?php
include('rabbit/testRabbitMQClient2.php');

function devFEUpdate($version, $filename) {
     $sqlStatement = "INSERT INTO dev(level, type, version, filename) VALUES('dev', 'fe', '$version', '$filename')";
     updateDB($sqlStatement);

}


function devBEUpdate($version, $filename) {
     $sqlStatement = "INSERT INTO dev(level, type, version, filename) VALUES('dev', 'be', '$version', '$filename')";
     updateDB($sqlStatement);

}

$ip = $argv[1];
$version = $argv[2];
$filename = $argv[3];

if  ($ip == "192.168.1.3") {
    devFEUpdate($version, $filename);
} else if ($ip == "192.168.1.19") {
    devBEUpdate($version, $filename);
}


?>
