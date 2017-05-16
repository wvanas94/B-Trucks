<?php
	$host = 'db.soic.indiana.edu';
	$user = 'caps16_team18';
	$password = 'my+sql=btrucks2017';
	$database = 'caps16_team18';

	$session = $_POST['session'];
	
	$conn = mysqli_connect($host, $user, $password, $database);
	
	$login_response = array();

	$query = mysqli_query($conn, "SELECT * FROM userSessions WHERE sessionID = '".$session."';");
	$result = mysqli_fetch_array($query);
	
	$login_response['userID'] = $result[1];
	$login_response['userType'] = $result[2];
	
	
	$returnJSON = json_encode($login_response);
	
	echo($returnJSON);
	
	return $returnJSON;
	
	mysqli_close($conn);
?>
