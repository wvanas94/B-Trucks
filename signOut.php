<?php
	$host = 'db.soic.indiana.edu';
	$user = 'caps16_team18';
	$password = 'my+sql=btrucks2017';
	$database = 'caps16_team18';

	$session = $_POST['session'];
	
	$conn = mysqli_connect($host, $user, $password, $database);

	$query = mysqli_query($conn, "DELETE FROM userSessions WHERE sessionID = '".$session."';");
	
	mysqli_close($conn);
?>
