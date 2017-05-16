<?php

$host = 'db.soic.indiana.edu';
$user = 'caps16_team18';
$password = 'my+sql=btrucks2017';
$database = 'caps16_team18';

$conn = mysqli_connect($host, $user, $password, $database);

$response = array();

$userID = $_POST['userID'];
$truckID = $_POST['truckID'];
$title = $_POST['title'];
$description = $_POST['description'];


if(!$conn){
    die('Connection Failed: ' . mysqli_connect_error());
  } else {
  			
		//creating statement
		$query = "INSERT INTO ItemRecommendations (UserID, TruckID, Title, Description)
			VALUES ('".$userID."', '".$truckID."', '".$title."', '".$description."');";

		$result = mysqli_query($conn, $query);

		if ($result) {
			// return 0 means User created successfully
			$response['error'] = false;
			$response['message'] = "Recommendation sent successfuly.";
			//echo json_encode(0);
		} else {
			// return 1 means failed to create User
			$response['error'] = true;
			$response['message'] = mysqli_error();
			//echo json_encode(1);
		}
		echo json_encode($response);
}
mysqli_close($conn);


?>
