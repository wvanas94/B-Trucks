<?php
	$host = 'db.soic.indiana.edu';
	$user = 'caps16_team18';
	$password = 'my+sql=btrucks2017';
	$database = 'caps16_team18';

	$conn = mysqli_connect($host, $user, $password, $database);

	function retrievePass($Email, $conn) {

		$stmt = mysqli_query($conn,"SELECT * FROM Users WHERE Email = '".$Email."';");
		$result = mysqli_fetch_array($stmt);

		$sizeOfArray = count($result);
		$loginResponse = array();
	
		if($sizeOfArray != 0){
			
			$loginResponse['error'] = 'false';
			$loginResponse['message'] = 'Your password was sent to the email associated with your account.';
			$retrievedEmail = $result[3];
			$retrievedPass = $result[4];
	
		} else{
		$truckStmt = mysqli_query($conn,"SELECT * FROM Truck WHERE Email = '".$Email."';");
		$truckResult = mysqli_fetch_array($truckStmt);

		$sizeOfTruckArray = count($truckResult);
		
		
		if($sizeOfTruckArray != 0){
			
			$loginResponse['error'] = 'false';
			$loginResponse['message'] = 'Your password was sent to the email associated with your account.';
			$retrievedEmail = $truckResult[3];
			$retrievedPass = $truckResult[4];
			
		}else {
		$ownerStmt = mysqli_query($conn,"SELECT * FROM Owner WHERE Email = '".$Email."';");
		$ownerResult = mysqli_fetch_array($ownerStmt);

		$sizeOfOwnerArray = count($ownerResult);
		
		
		if($sizeOfOwnerArray != 0){
			
			$loginResponse['error'] = 'false';
			$loginResponse['message'] = 'Your password was sent to the email associated with your account.';
			$retrievedEmail = $ownerResult[3];
			$retrievedPass = $ownerResult[4];

		}else{
		
			$loginResponse['error'] = 'true';
			$loginResponse['message'] = "Invalid email.";
		}}}
	
		$returnJSON = json_encode($loginResponse);
		echo($returnJSON);

	
		return $retrievedPass;
	}


	$email = $_POST['email'];     
	$subject = 'B-Trucks Password Recovery';

	$pass = retrievePass($email,$conn);

	$message = 'The password associated with your B-Trucks account is: '.$pass.'';
	mail($email, $subject, $message);

	mysqli_close($conn);	
?>
