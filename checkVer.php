<?php
include('rabbit/testRabbitMQClient2.php');

function devFE($level, $type) {
     $sqlStatement = "SELECT MAX(version) FROM dev WHERE level='$level' AND type='$type'";
     $version = checkVer($sqlStatement);
     foreach ($version as $tmpArray) {
          foreach($tmpArray as $key => $row) {
 	       $newVersion = (int) $row + 1;
               echo $newVersion;
          }
     }
     //Check devUpdate.php script for table updating
}

function devBE($level, $type) {
     $sqlStatement = "SELECT MAX(version) FROM dev WHERE level='$level' AND type='$type'";
     $version = checkVer($sqlStatement);
     foreach ($version as $tmpArray) {
          foreach($tmpArray as $key => $row) {
 	       $newVersion = (int) $row + 1;
               echo $newVersion;
          }
     }
     //Check devUpdate.php script for table updating
}


function prodFE($level, $type) {
     $sqlStatement = "SELECT MAX(version) FROM status WHERE level='$level' AND type='$type' AND status='good'";
     $version = checkVer($sqlStatement);
     foreach ($version as $tmpArray) {
          foreach($tmpArray as $key => $row) {
               $version = $row;
	       //echo $version;
          }
     }
     $sqlStatement2 = "SELECT filename FROM status WHERE status='good' AND level='$level' AND type='$type' AND version='$row'";
     $filename = checkVer($sqlStatement2);
     foreach ($filename as $tmpArray2) {
        foreach($tmpArray2 as $key => $row) {
	       $filename = $row;
               echo $filename;
        }
     }
     //Check devUpdate.php script for table updating
}


function prodBE($level, $type) {
     $sqlStatement = "SELECT MAX(version) FROM status WHERE level='$level' AND type='$type' AND status='good'";
     $version = checkVer($sqlStatement);
     foreach ($version as $tmpArray) {
          foreach($tmpArray as $key => $row) {
               $version = $row;
	       //echo $version;
          }
     }
     $sqlStatement2 = "SELECT filename FROM status WHERE status='good' AND level='$level' AND type='$type' AND version='$row'";
     $filename = checkVer($sqlStatement2);
     foreach ($filename as $tmpArray2) {
        foreach($tmpArray2 as $key => $row) {
	       $filename = $row;
               echo $filename;
        }
     }
     //Check devUpdate.php script for table updating
}


$ip = $argv[1];
$level = $argv[2];
$type = $argv[3];

if  ($ip == "192.168.1.6") {
    devFE($level, $type);
} else if ($ip == "192.168.1.7") {
    devBE($level, $type);
} else if ($ip == "192.168.1.5") {
    prodFE($level, $type);
} else if ($ip == "192.168.1.10") {
    prodBE($level, $type);
}



?>

