<?php

$host = 'db.soic.indiana.edu';
$user = 'caps16_team18';
$password = 'my+sql=btrucks2017';
$database = 'caps16_team18';

$conn = mysqli_connect($host, $user, $password, $database);

$response = array();

$firstName = $_POST['fName'];
$lastName = $_POST['lName'];
$email = $_POST['email'];
$password = $_POST['password'];


if(!$conn){
    die('Connection Failed: ' . mysqli_connect_error());
  } else {
  
  		$existsUserQuery = mysqli_query($conn, "SELECT UserID FROM Users WHERE Email = '" .$email. "';");
  		$existsUserResults = mysqli_fetch_array($existsUserQuery);
    	$existsOwnerQuery = mysqli_query($conn, "SELECT OwnerID FROM Owner WHERE Email = '" .$email. "';");
  		$existsOwnerResults = mysqli_fetch_array($existsOwnerQuery);
    	
    	if (!$existsUserResults and !$existsOwnerResults) {
  			
  			//creating statement
  			$query = "INSERT INTO Users (Fname, Lname, Email, Password)
  				VALUES ('".$firstName."', '".$lastName."', '".$email."', '".$password."');";
  	
  			$result = mysqli_query($conn, $query);
  			
  			
  			if ($result) {
  				// return 0 means User created successfully
  				$response['error'] = false;
  				$response['message'] = "User successfully added.";
  				//echo json_encode(0);
  			} else {
  				// return 1 means failed to create User
  				$response['error'] = true;
  				$response['message'] = mysqli_error();
  				//echo json_encode(1);
  			}
    		} else {
    			$response['error'] = true;
    			$response['message'] = "That email already exists";
    			//echo "Duplicate emails exist";
    		}
    		echo json_encode($response);
}
mysqli_close($conn);


?>
