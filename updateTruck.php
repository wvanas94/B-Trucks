<?php

$host = 'db.soic.indiana.edu';
$user = 'caps16_team18';
$password = 'my+sql=btrucks2017';
$database = 'caps16_team18';

$conn = mysqli_connect($host, $user, $password, $database);

$response = array();

$id = $_POST['id'];
$truckName = $_POST['Name'];
$truckDesc = $_POST['Description'];
$truckFT = $_POST['FoodType'];
$truckPassword = $_POST['Password'];



if(!$conn){
    die('Connection Failed: ' . mysqli_connect_error());
  } else {

		$updateQuery = "UPDATE Truck SET Name = '".$truckName."', Description = '".$truckDesc."', FoodType = '".$truckFT."', Password = '".$truckPassword."' WHERE TruckID = '".$id."';";
		
		mysqli_query($conn, $updateQuery);
		
		$response['error'] = false;
		$response['message'] = "Truck updated";
  			
    	echo json_encode($response);
}

mysqli_close($conn);


?>
