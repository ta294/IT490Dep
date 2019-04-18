<?php
include('rabbit/testRabbitMQClient2.php');

function qaFE($level, $type) {
     $sqlStatement = "SELECT MAX(version) FROM status WHERE level='$level' AND type='$type'";
     $version = checkVer($sqlStatement);
     $newversion = NULL;
     foreach ($version as $tmpArray) {
          foreach($tmpArray as $key => $row) {
              $sqlStatement2 = "UPDATE status SET status='good' WHERE level='$level' AND type='$type' AND version='$row'";
              updateDB($sqlStatement2);

          }
     }

}

function qaBE($level, $type) {
     $sqlStatement = "SELECT MAX(version) FROM status WHERE level='$level' AND type='$type'";
     $version = checkVer($sqlStatement);
     $newversion = NULL;
     foreach ($version as $tmpArray) {
          foreach($tmpArray as $key => $row) {
              $sqlStatement2 = "UPDATE status SET status='good' WHERE level='$level' AND type='$type' AND version='$row'";
              updateDB($sqlStatement2);

          }
     }

}


$level = $argv[1];
$type = $argv[2];

if ($level == "qa" && $type == "fe" ) {
   qaFE($level, $type);
} else if ($level == "qa" && $type == "be") {
   qaBE($level, $type);
}

?>
