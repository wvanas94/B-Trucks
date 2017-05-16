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
	$phone = $_POST['phone'];
	$password = $_POST['password'];
	$uid = $_POST['userid'];

	if(!$conn){
	    die('Connection Failed: ' . mysqli_connect_error());
	  } else {
	  			
	  			//creating statement
	  			if($firstName != "" && $lastName != "" && $email != "" && $phone != "" && $password != "x") { 
	  				
	  				$query = "UPDATE Owner SET Fname = '".$firstName."', Lname = '".$lastName."', Email = '".$email."', Phone = '".$phone."', Password = '".$password."' WHERE OwnerID = '".$uid."';";
	  				
	  				$result = mysqli_query($conn, $query);
	  			
	  			} elseif($firstName != "" && $lastName != "" && $email != "" && $phone != "") { 
	  				
	  				$query = "UPDATE Owner SET Fname = '".$firstName."', Lname = '".$lastName."', Email = '".$email."', Phone = '".$phone."' WHERE OwnerID = '".$uid."';";
	  				
	  				$result = mysqli_query($conn, $query);

	  			} elseif($firstName != "" && $lastName != "" && $phone != "" && $password != "x") { 
	  				
	  				$query = "UPDATE Owner SET Fname = '".$firstName."', Lname = '".$lastName."', Phone = '".$phone."', Password = '".$password."' WHERE OwnerID = '".$uid."';";
	  				
	  				$result = mysqli_query($conn, $query);

	  			} elseif($firstName != "" && $phone != "" && $email != "" && $password != "x") { 
	  				
	  				$query = "UPDATE Owner SET Fname = '".$firstName."', Phone = '".$phone."', Email = '".$email."', Password = '".$password."' WHERE OwnerID = '".$uid."';";
	  				
	  				$result = mysqli_query($conn, $query);

	  			} elseif($phone != "" && $lastName != "" && $email != "" && $password != "x") { 
	  				
	  				$query = "UPDATE Owner SET Phone = '".$phone."', Lname = '".$lastName."', Email = '".$email."', Password = '".$password."' WHERE OwnerID = '".$uid."';";
	  				
	  				$result = mysqli_query($conn, $query);

	  			} elseif($firstName != "" && $lastName != "" && $email != "" && $password != "x") { 
	  				
	  				$query = "UPDATE Owner SET Fname = '".$firstName."', Lname = '".$lastName."', Email = '".$email."', Password = '".$password."' WHERE OwnerID = '".$uid."';";
	  				
	  				$result = mysqli_query($conn, $query);

	  			} elseif($firstName && $lastName && $email) {
  					$query = "UPDATE Owner SET Fname = '".$firstName."', Lname = '".$lastName."', Email = '".$email."' WHERE OwnerID = '".$uid."';";
  				
  	
  					$result = mysqli_query($conn, $query);

	  			} elseif($firstName && $lastName && $password != "x") {
  						$query = "UPDATE Owner SET Fname = '".$firstName."', Lname = '".$lastName."', Password = '".$password."' WHERE OwnerID = '".$uid."';";
  				
  	
  						$result = mysqli_query($conn, $query);
				} elseif($firstName && $email && $password != "x") {
					$query = "UPDATE Owner SET Fname = '".$firstName."', Email = '".$email."', Password = '".$password."' WHERE OwnerID = '".$uid."';";
		

					$result = mysqli_query($conn, $query);

				} elseif($lastName && $email && $password != "x") {
					$query = "UPDATE Owner SET Lname = '".$lastName."', Email = '".$email."', Password = '".$password."' WHERE OwnerID = '".$uid."';";
	

					$result = mysqli_query($conn, $query);

				} elseif($firstName && $lastName && $phone) {
  					$query = "UPDATE Owner SET Fname = '".$firstName."', Lname = '".$lastName."', Phone = '".$phone."' WHERE OwnerID = '".$uid."';";
  				
  	
  					$result = mysqli_query($conn, $query);

  				} elseif($firstName && $phone && $email) {
  					$query = "UPDATE Owner SET Fname = '".$firstName."', Phone = '".$phone."', Email = '".$email."' WHERE OwnerID = '".$uid."';";
  				
  	
  					$result = mysqli_query($conn, $query);

  				} elseif($phone && $lastName && $email) {
  					$query = "UPDATE Owner SET Phone = '".$phone."', Lname = '".$lastName."', Email = '".$email."' WHERE OwnerID = '".$uid."';";
  				
  	
  					$result = mysqli_query($conn, $query);

  				} elseif($firstName && $password != "x" && $phone) {
  					$query = "UPDATE Owner SET Fname = '".$firstName."', Password = '".$password."', Phone = '".$phone."' WHERE OwnerID = '".$uid."';";
  				
  	
  					$result = mysqli_query($conn, $query);

  				} elseif($phone && $lastName && $password != "x") {
  					$query = "UPDATE Owner SET Phone = '".$Phone."', Lname = '".$lastName."', Password = '".$password."' WHERE OwnerID = '".$uid."';";
  				
  	
  					$result = mysqli_query($conn, $query);

  				} elseif($phone && $password != "x" && $email) {
  					$query = "UPDATE Owner SET Phone = '".$phone."', Password = '".$password."', Email = '".$email."' WHERE OwnerID = '".$uid."';";
  				
  	
  					$result = mysqli_query($conn, $query);

				} elseif($firstName && $lastName) {
					$query = "UPDATE Owner SET Fname = '".$firstName."', Lname = '".$lastName."' WHERE OwnerID = '".$uid."';";


					$result = mysqli_query($conn, $query);

				} elseif($firstName && $email) {
					$query = "UPDATE Owner SET Fname = '".$firstName."', Email = '".$email."' WHERE OwnerID = '".$uid."';";


					$result = mysqli_query($conn, $query);

				} elseif($firstName && $password != "x") {
					$query = "UPDATE Owner SET Fname = '".$firstName."', Password = '".$password."' WHERE OwnerID = '".$uid."';";


					$result = mysqli_query($conn, $query);

				} elseif($lastName && $email) {
					$query = "UPDATE Owner SET Lname = '".$lastName."', Email = '".$email."' WHERE OwnerID = '".$uid."';";


					$result = mysqli_query($conn, $query);

				} elseif($lastName && $password != "x") {
					$query = "UPDATE Owner SET Lname = '".$lastName."', Password = '".$password."' WHERE OwnerID = '".$uid."';";


					$result = mysqli_query($conn, $query);

				} elseif($email && $password != "x") {
					$query = "UPDATE Owner SET Email = '".$email."', Password = '".$password."' WHERE OwnerID = '".$uid."';";


					$result = mysqli_query($conn, $query);

				} elseif($firstName && $phone) {
					$query = "UPDATE Owner SET Fname = '".$firstName."', Phone = '".$phone."' WHERE OwnerID = '".$uid."';";


					$result = mysqli_query($conn, $query);

				} elseif($lastName && $phone) {
					$query = "UPDATE Owner SET Lname = '".$lastName."', Phone = '".$phone."' WHERE OwnerID = '".$uid."';";


					$result = mysqli_query($conn, $query);

				} elseif($email && $phone) {
					$query = "UPDATE Owner SET Email = '".$email."', Phone = '".$phone."' WHERE OwnerID = '".$uid."';";


					$result = mysqli_query($conn, $query);

				} elseif($phone && $password != "x") {
					$query = "UPDATE Owner SET Phone = '".$phone."', Password = '".$password."' WHERE OwnerID = '".$uid."';";


					$result = mysqli_query($conn, $query);

				} elseif($firstName) {
					$query = "UPDATE Owner SET Fname = '".$firstName."' WHERE OwnerID = '".$uid."';";


					$result = mysqli_query($conn, $query);

				} elseif($lastName) {
					$query = "UPDATE Owner SET Lname = '".$lastName."' WHERE OwnerID = '".$uid."';";


					$result = mysqli_query($conn, $query);

				} elseif($email) {
					$query = "UPDATE Owner SET Email = '".$email."' WHERE OwnerID = '".$uid."';";


					$result = mysqli_query($conn, $query);

				} elseif($phone) {
					$query = "UPDATE Owner SET Phone = '".$phone."' WHERE OwnerID = '".$uid."';";


					$result = mysqli_query($conn, $query);

				} elseif($password != "x") {
					$query = "UPDATE Owner SET Password = '".$password."' WHERE OwnerID = '".$uid."';";


					$result = mysqli_query($conn, $query);

	 				} else {
	 					echo "didn't work";

	   			}
	  			}

			if ($result) {
				// return 0 means changes successful
				$response['error'] = false;
				$response['message'] = "Changes successfully made!";
				
			} else {
				// return 1 means failed to make changes
				$response['error'] = true;
				$response['message'] = mysqli_error();
			}
		 
		
		echo json_encode($response);
	 



	mysqli_close($conn);	
?>