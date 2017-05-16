<?php

$host = 'db.soic.indiana.edu';
$user = 'caps16_team18';
$password = 'my+sql=btrucks2017';
$database = 'caps16_team18';

$conn = mysqli_connect($host, $user, $password, $database);

$response = array();

$id = $_POST['id'];
$firstName = $_POST['fName'];
$lastName = $_POST['lName'];
$phone = $_POST['phone'];
$password = $_POST['password'];


if(!$conn){
    die('Connection Failed: ' . mysqli_connect_error());
  } else {

		$updateQuery = "UPDATE Owner SET Fname = '".$firstName."', Lname = '".$lastName."', Password = '".$password."' WHERE OwnerID = '".$id."';";
		
		mysqli_query($conn, $updateQuery);
		
		$response['error'] = false;
		$response['message'] = "Owner updated";
  			
    	echo json_encode($response);
}

mysqli_close($conn);


?>
