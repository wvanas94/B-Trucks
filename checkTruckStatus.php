<?php
	$host = 'db.soic.indiana.edu';
	$user = 'caps16_team18';
	$password = 'my+sql=btrucks2017';
	$database = 'caps16_team18';

	$conn = mysqli_connect($host, $user, $password, $database);

	$tid = $_POST['TruckID'];
	
	

$response = array();

	if(!$conn){
    die('Connection Failed: ' . mysqli_connect_error());
  } else {

		$updateQuery = "UPDATE Truck SET Latitude = 0.00, Longitude = 0.00 WHERE TruckID = '".$tid."';";
		
		mysqli_query($conn, $updateQuery);
		
		$response['error'] = false;
		$response['message'] = "Truck location updated";
		$response['truckID'] = $tid;
  			
    	echo json_encode($response);
}

		mysqli_close($conn);	
?>