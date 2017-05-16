<?php
	$host = 'db.soic.indiana.edu';
	$user = 'caps16_team18';
	$password = 'my+sql=btrucks2017';
	$database = 'caps16_team18';

	$conn = mysqli_connect($host, $user, $password, $database);

	$tid = $_POST['TruckID'];
	$latitude = $_POST['Latitude'];
	$longitude = $_POST['Longitude'];
	

	$response = array();

	if(!$conn){
    die('Connection Failed: ' . mysqli_connect_error());
  } else {

		$updateQuery = "UPDATE Truck SET Latitude = '".$latitude."', Longitude = '".$longitude."' WHERE TruckID = '".$tid."';";
		
		mysqli_query($conn, $updateQuery);
		
		$response['error'] = false;
		$response['message'] = "Truck location updated";
  			
    	echo json_encode($response);
}

		mysqli_close($conn);	
?>