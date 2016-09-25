<?php
$lat = round(floatval($_GET['lat']),6);
$long = round(floatval($_GET['long']),6);

//echo $_GET['callback']."(".json_encode($arr).");";
 $xml_string= file_get_contents('http://api.translink.ca/rttiapi/v1/stops?apikey=PIKSmtxbKh01mhVAQ3sd&lat='.$lat.'&long='.$long);


  $xml = simplexml_load_string($xml_string);
$json = json_encode($xml);
//$array = json_decode($json,TRUE);
  
echo $_GET['callback']."(".$json.");";
  
  
  /*
  
  $apikey = $_GET['apikey']; 

  
  
  
  $res = file_get_contents('http://api.translink.ca/rttiapi/v1/stops?apikey=PIKSmtxbKh01mhVAQ3sd');
  echo json_encode($res);  // pass array in json_encode  
*/