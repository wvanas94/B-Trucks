<?php

  $host = 'db.soic.indiana.edu';
  $user = 'caps16_team18';
  $password = 'my+sql=btrucks2017';
  $database = 'caps16_team18';

  $conn = mysqli_connect($host, $user, $password, $database);

//   $firstName = $_POST['Fname'];
//   $lastName = $_POST['Lname'];
//   $email = $_POST['Email'];
//   $password = $_POST['Password'];


if(!$conn){
    die('Connection Failed: ' . mysqli_connect_error());
  }
$query = "SELECT UserID, Fname, Lname FROM Users;";
// $query = "INSERT INTO Users (Fname, Lname, Email, Password)
//       VALUES ('$firstName', '$lastName', '$email', '$password');";
$result = mysqli_query($conn, $query);

if (mysqli_num_rows($result) > 0) {
    // output data of each row
    
      while($row = mysqli_fetch_assoc($result)) {
      echo "id: " . $row["UserID"]. " - Name: " . $row["Fname"]. " " . $row["Lname"]. "<br>";
    
    }
  } else {
  echo "No results.";
  }
mysqli_close($conn);


?>
