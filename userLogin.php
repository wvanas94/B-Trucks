<?php
	$host = 'db.soic.indiana.edu';
	$user = 'caps16_team18';
	$password = 'my+sql=btrucks2017';
	$database = 'caps16_team18';

	$conn = mysqli_connect($host, $user, $password, $database);

	function login($Email, $Password, $conn) {

		$stmt = mysqli_query($conn,"SELECT * FROM Users WHERE Email = '".$Email."' and Password = '".$Password."';");
		$result = mysqli_fetch_array($stmt);

		$sizeOfArray = count($result);
		$loginResponse = array();
	
		if($sizeOfArray != 0){
		
			session_start();
			session_regenerate_id();
			
			$loginResponse['error'] = 'false';
			$loginResponse['type'] = 'user';
			$loginResponse['ID'] = $result[0];
			$loginResponse['Fname'] = $result[1];
			$loginResponse['Lname'] = $result[2];
			$loginResponse['Email'] = $result[3];
			$loginResponse['Password'] = $result[4];
			$loginResponse['Session'] = session_id();
			
			$stmt = mysqli_query($conn, "INSERT INTO userSessions (sessionID, userID, userType) VALUES ('".session_id()."', '".$result[0]."', 'userLogin')");
			$result = mysqli_fetch_array($stmt);
			
		} else{
		$truckStmt = mysqli_query($conn,"SELECT * FROM Truck WHERE Email = '".$Email."' and Password = '".$Password."';");
		$truckResult = mysqli_fetch_array($truckStmt);

		$sizeOfTruckArray = count($truckResult);
		
		
		if($sizeOfTruckArray != 0){
		
			session_start();
			session_regenerate_id();
			$_SESSION['login_user'] = $loginResponse['TruckID'];
			$_SESSION['user_type'] = 'employee';
			
			$loginResponse['error'] = 'false';
			$loginResponse['type'] = 'employee';
			$loginResponse['ID'] = $truckResult[0];
			$loginResponse['Email'] = $truckResult[3];
			$loginResponse['Password'] = $truckResult[4];
			$loginResponse['Name'] = $truckResult[8];
			$loginResponse['Session'] = session_id();
						
			$stmt = mysqli_query($conn, "INSERT INTO userSessions (sessionID, userID, userType) VALUES ('".session_id()."', '".$truckResult[0]."', 'employeeLogin')");
			$result = mysqli_fetch_array($stmt);
			
		}else {
		$ownerStmt = mysqli_query($conn,"SELECT * FROM Owner WHERE Email = '".$Email."' and Password = '".$Password."';");
		$ownerResult = mysqli_fetch_array($ownerStmt);

		$sizeOfOwnerArray = count($ownerResult);
		
		
		if($sizeOfOwnerArray != 0){
		
			session_start();
			session_regenerate_id();
			$_SESSION['login_user'] = $loginResponse['OwnerID'];
			$_SESSION['user_type'] = 'owner';
			
			$loginResponse['error'] = 'false';
			$loginResponse['type'] = 'owner';
			$loginResponse['ID'] = $ownerResult[0];
			$loginResponse['Fname'] = $ownerResult[1];
			$loginResponse['Lname'] = $ownerResult[2];
			$loginResponse['Email'] = $ownerResult[3];
			$loginResponse['Password'] = $ownerResult[4];
			$loginResponse['Session'] = session_id();
			
			$stmt = mysqli_query($conn, "INSERT INTO userSessions (sessionID, userID, userType) VALUES ('".session_id()."', '".$ownerResult[0]."', 'ownerLogin')");
			$result = mysqli_fetch_array($stmt);
			
		}else{
		
			$loginResponse['error'] = 'true';
			$loginResponse['type'] = "Invalid email or password";
		}}}
	
		$returnJSON = json_encode($loginResponse);
		echo($returnJSON);

	
		return $returnJSON;
	}

// 	$email = 'edmdemps@indiana.edu';
	$email = $_POST['email'];    
// 	$password = 'Password123'; 
	$password = $_POST['password'];  

	login($email,$password,$conn);

	mysqli_close($conn);	
?>
