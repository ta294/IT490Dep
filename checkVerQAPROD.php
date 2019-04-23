<?php
include('rabbit/testRabbitMQClient2.php');

function depqaFE($level, $type) {
     $sqlStatement = "SELECT MAX(version) FROM dev WHERE level='$level' AND type='$type'";
     $version = checkVer($sqlStatement);
     foreach ($version as $tmpArray) {
          foreach($tmpArray as $key => $row) {
              //$newVersion = (int) $row + 1;
              // echo $newVersion;
	      echo $row;
          }
     }
     //Check devUpdate.php script for table updating
}

function depqaBE($level, $type) {
     $sqlStatement = "SELECT MAX(version) FROM dev WHERE level='$level' AND type='$type'";
     $version = checkVer($sqlStatement);
     foreach ($version as $tmpArray) {
          foreach($tmpArray as $key => $row) {
              //$newVersion = (int) $row + 1;
              // echo $newVersion;
	      echo $row;
          }
     }
     //Check devUpdate.php script for table updating
}


function depprodFE($level, $type) {
     $sqlStatement = "SELECT MAX(version) FROM dev WHERE level='$level' AND type='$type'";
     $version = checkVer($sqlStatement);
     foreach ($version as $tmpArray) {
          foreach($tmpArray as $key => $row) {
              //$newVersion = (int) $row + 1;
              // echo $newVersion;
	      echo $row;
          }
     }
     //Check devUpdate.php script for table updating
}

function depprodBE($level, $type) {
     $sqlStatement = "SELECT MAX(version) FROM dev WHERE level='$level' AND type='$type'";
     $version = checkVer($sqlStatement);
     foreach ($version as $tmpArray) {
          foreach($tmpArray as $key => $row) {
              //$newVersion = (int) $row + 1;
              // echo $newVersion;
	      echo $row;
          }
     }
     //Check devUpdate.php script for table updating
}


$ip = $argv[1];
$level = $argv[2];
$type = $argv[3];
$sendto = $argv[4];

if ($ip == "192.168.1.3") {
     if ($sendto == "qa" && $type == "fe") {
        depqaFE($level, $type); 
     } else if ($sendto == "qa" && $type == "be" ) {
        depqaBE($level, $type);
     } else if ($sendto == "prod" && $type == "fe" ) {
        depprodFE($level, $type);
     } else if ($sendto == "prod" && $type == "be" ) {
        depprodBE($level, $type);
     }
} 



?>

