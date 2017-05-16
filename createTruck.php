<?php

$host = 'db.soic.indiana.edu';
$user = 'caps16_team18';
$password = 'my+sql=btrucks2017';
$database = 'caps16_team18';

$conn = mysqli_connect($host, $user, $password, $database);

$response = array();

$tName = $_POST['truckName'];
$tDesc = $_POST['truckDesc'];
$food = $_POST['foodType'];
$tPhone = $_POST['truckPhone'];
$tEmail = $_POST['truckEmail'];
$tPassword = $_POST['truckPassword'];
$tOwnerID = $_POST['ownerID'];


if(!$conn){
    die('Connection Failed: ' . mysqli_connect_error());
  } else {
  
  			if($tName == '' || $tDesc == '' || $food == '' || $tPhone == '' || $tEmail == '' || $tPassword == ''){
          $response['error'] = true;
          $response['message'] = "One or more fields is empty.";
        } else {
  			//creating statement
        // this is where I stopped
  			$query = "INSERT INTO Truck (Name, Description, FoodType, Phone, Email, Password, OwnerID)
  				VALUES ('".$tName."', '".$tDesc."', '".$food."', '".$tPhone."', '".$tEmail."', '".$tPassword."', '".$tOwnerID."');";
  	
  			$result = mysqli_query($conn, $query);
  			
  			if ($result) {
  				// return 0 means User created successfully
  				$response['error'] = false;
  				$response['message'] = "Truck successfully added.";
  				//echo json_encode(0);
  			} else {
  				// return 1 means failed to create User
  				$response['error'] = true;
  				$response['message'] = mysqli_error();
  				//echo json_encode(1);
  			}
    		}
    		echo json_encode($response);
}

mysqli_close($conn);


?>