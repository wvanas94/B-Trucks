<?php

$host = 'db.soic.indiana.edu';
$user = 'caps16_team18';
$password = 'my+sql=btrucks2017';
$database = 'caps16_team18';

$conn = mysqli_connect($host, $user, $password, $database);

$response = array();

$tid = $_POST['truckID'];


if(!$conn){
    die('Connection Failed: ' . mysqli_connect_error());
  } else {
  	$truckQuery = mysqli_query($conn, "SELECT Name, Description, FoodType, Password FROM Truck WHERE TruckID = '" .$tid. "';");
  	$result = mysqli_fetch_array($truckQuery);

  	$response = array();

  	$response['Name'] = $result[0];
  	$response['Description'] = $result[1];
  	$response['FoodType'] = $result[2];
  	$response['Password'] = $result[3];


  	echo json_encode($response);
  }

mysqli_close($conn);


?>