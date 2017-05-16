<?php
	$host = 'db.soic.indiana.edu';
	$user = 'caps16_team18';
	$password = 'my+sql=btrucks2017';
	$database = 'caps16_team18';

	$conn = mysqli_connect($host, $user, $password, $database);
	
	$trucks = array();
	$stmt = mysqli_query($conn,"SELECT * FROM Truck WHERE Latitude <> 0.00 and Longitude <> 0.00;");
	
	foreach ($stmt as $truck) {
		$trucks[] = $truck;
	}
	
	echo json_encode($trucks);

// 	$sizeOfArray = count($result);
// 	$loginResponse = array();
// 	
// 
// 	if($sizeOfArray != 0){
// 		
// 		$loginResponse['error'] = false;
// 		$loginResponse['truckID'] = $result[0];
// 		$loginResponse['description'] = $result[1];
// 		$loginResponse['foodType'] = $result[2];
// 		$loginResponse['logo'] = $result[5];
// 		$loginResponse['latitude'] = $result[6];
// 		$loginResponse['longitude'] = $result[7];
// 		$loginResponse['name'] = $result[8];
// 		
// 	} 
// else {
// 	
// 		//put owners sql crap here
// 	
// 		$loginResponse['error'] = true;
// 		$loginResponse['message'] = "There are no trucks";
// 	}
// 	echo json_encode($loginResponse);
// 
// 	$returnJSON = json_encode($loginResponse);
// 	echo($returnJSON);
// 
// 	$stmt->mysqli_close($conn);
// 
// 	return $returnJSON;
// 
// 
// 	$email = 'edmdemps@indiana.edu';
// 	//$_GET['email'];    
// 	$password = '5555'; 
// 	//$_GET['password'];  
// 
// 	echo(userLogin($email,$password,$conn));

	mysqli_close($conn);	
?>