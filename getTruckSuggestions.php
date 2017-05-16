<?php
	$host = 'db.soic.indiana.edu';
	$user = 'caps16_team18';
	$password = 'my+sql=btrucks2017';
	$database = 'caps16_team18';

	$conn = mysqli_connect($host, $user, $password, $database);
	
	$truckID = $_POST['TruckID'];
	
	print($truckID);
	
	$foodRecs = array();
	$stmt = mysqli_query($conn,"SELECT * FROM ItemRecommendations WHERE TruckID = '".$truckID."';");
	
	while($row = mysqli_fetch_assoc($stmt)) {
		$foodRecs[] = $row;
	}
	
	echo json_encode($foodRecs);

	mysqli_close($conn);	
?>