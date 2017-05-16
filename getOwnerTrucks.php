<?php
	$host = 'db.soic.indiana.edu';
	$user = 'caps16_team18';
	$password = 'my+sql=btrucks2017';
	$database = 'caps16_team18';
	
	$ownerID = '1003'; //$_POST["ownerID"];

	$conn = mysqli_connect($host, $user, $password, $database);
		
	$trucks = array();
	
	$stmt = mysqli_query($conn,"SELECT * FROM Truck WHERE OwnerID = '".$ownerID."';");
	
	while($row = mysqli_fetch_assoc($stmt)) {
		$trucks[] = $row;
	}

	echo(json_encode($trucks));


	mysqli_close($conn);	
?>
