<?php

  $host = 'db.soic.indiana.edu';
  $user = 'caps16_team18';
  $password = 'my+sql=btrucks2017';
  $database = 'caps16_team18';

  $conn = mysqli_connect($host, $user, $password, $database);

$response = array();
if(!$conn){
    die('Connection Failed: ' . mysqli_connect_error());
  }
$query = "SELECT * FROM UserLocations;";
$response['message'] = mysqli_query($conn, $query);

echo json_encode($response);

mysqli_close($conn);
?>
