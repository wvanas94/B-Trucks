<?php
	$host = 'db.soic.indiana.edu';
	$user = 'caps16_team18';
	$password = 'my+sql=btrucks2017';
	$database = 'caps16_team18';

	$conn = mysqli_connect($host, $user, $password, $database);
	
	$truckID = $_POST['TruckID'];
	
	print($truckID);
	
	$menuItems = array();
	$stmt = mysqli_query($conn,"SELECT * FROM MenuItem WHERE TruckID = '".$truckID."';");
	
	while($row = mysqli_fetch_assoc($stmt)) {
		$menuItems[] = $row;
	}
	
	echo json_encode($menuItems);

	mysqli_close($conn);	
?>