<?php
	$host = 'db.soic.indiana.edu';
	$user = 'caps16_team18';
	$password = 'my+sql=btrucks2017';
	$database = 'caps16_team18';

	$conn = mysqli_connect($host, $user, $password, $database);

	$tid = $_POST['truckID'];
	
	$trucks = array();
	$stmt = mysqli_query($conn,"SELECT * FROM Truck WHERE TruckID = '".$tid."';");
	
	foreach ($stmt as $truck) {
		$trucks[] = $truck;
	}
	
	echo json_encode($trucks);



	mysqli_close($conn);	
?>