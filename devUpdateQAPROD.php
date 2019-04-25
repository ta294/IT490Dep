<?php
include('rabbit/testRabbitMQClient2.php');

function depqaFE($version, $filename) {
     $sqlStatement = "INSERT IGNORE INTO status(level, type, version, status, filename) VALUES('qa', 'fe', '$version', 'pending', '$filename')";
     updateDB($sqlStatement);

}

function depqaBE($version, $filename) {
     $sqlStatement = "INSERT IGNORE INTO status(level, type, version, status, filename) VALUES('qa', 'be', '$version', 'pending', '$filename')";
     updateDB($sqlStatement);

}

function depprodfe($version, $filename) {
     $sqlStatement = "INSERT IGNORE INTO status(level, type, version, status, filename) VALUES('prod', 'fe', '$version', 'pending', '$filename')";
     updateDB($sqlStatement);

}

function depprodbe($version, $filename) {
     $sqlStatement = "INSERT IGNORE INTO status(level, type, version, status, filename) VALUES('prod', 'be', '$version', 'pending', '$filename')";
     updateDB($sqlStatement);

}

$ip = $argv[1];
$version = $argv[2];
$filename = $argv[3];
$type = $argv[4];
$sendto = $argv[5];

if ($ip == "192.168.1.3") {
     if ($sendto == "qa" && $type == "fe") {
        depqaFE($version, $filename);
     } else if ($sendto == "qa" && $type == "be" ) {
        depqaBE($version, $filename);
     } else if ($sendto == "prod" && $type == "fe" ) {
        depprodFE($version, $filename);
     } else if ($sendto == "prod" && $type == "be" ) {
        depprodBE($version, $filename);
     }
}


?>
