<?php

$host = 'db.soic.indiana.edu';
$user = 'caps16_team18';
$password = 'my+sql=btrucks2017';
$database = 'caps16_team18';

$conn = mysqli_connect($host, $user, $password, $database);

$response = array();

$name = 'Pizza'; //$_POST['Name'];
$description = 'Pepperoni'; //$_POST['Description'];
$price = '1.52'; //$_POST['Price'];
$truckID = '1012'; //$POST['TruckID'];

if(!$conn){
    die('Connection Failed: ' . mysqli_connect_error());
  } else {

		//creating statement
		$query = "INSERT INTO MenuItem (Name, Description, Price, TruckID)
			VALUES ('".$name."', '".$description."', '".$price."', '".$truckID."');";

		$result = mysqli_query($conn, $query);
		
		
		if ($result) {
			// return 0 means menu item created successfully
			$response['error'] = false;
			$response['message'] = "User successfully added.";
			//echo json_encode(0);
		} else {
			// return 1 means failed to create menu item
			$response['error'] = true;
			$response['message'] = mysqli_error();
			//echo json_encode(1);
		}
		echo json_encode($response);
}
mysqli_close($conn);


?>
