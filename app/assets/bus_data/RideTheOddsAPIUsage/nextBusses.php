<?

 $stop =  $_GET["stop"];
 $hours =  $_GET["hours"];
 
 //$stop = 60980;
 $hours = 3;
$st =  'http://api.translink.ca/rttiapi/v1/stops/'.$stop.'/estimates?apikey=PIKSmtxbKh01mhVAQ3sd&count='.$hours.'&timeframe=120';
 echo file_get_contents($st);
 
//echo file_get_contents('http://api.translink.ca/rttiapi/v1/stops/60980/estimates?apikey=PIKSmtxbKh01mhVAQ3sd&count=3&timeframe=120');

