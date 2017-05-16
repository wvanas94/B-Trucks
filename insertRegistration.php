<?php

  $host = 'db.soic.indiana.edu';
  $user = 'caps16_team18';
  $password = 'my+sql=caps16_team18';

  $connection = mysql_connect($host, $user, $password);

  $firstName = $_POST['fName'];
  $lastName = $_POST['lName'];
  $email = $_POST['email'];
  $password = $_POST['pass'];


  if(!$connection){
    die('Connection Failed');
  }
  else{
    $dbconnect = @mysql_select_db('caps16_team18', $connection);

    if(!$dbconnect){
      die('Could not connect to Database');
    }
    else{
      //$query = "SELECT * from Users;"
      $query = "INSERT INTO Users (firstName, lastName, email, password)
      VALUES ('$firstName', '$lastName', '$email', '$password');";
      mysql_query($query, $connection) or die(mysql_error());

      echo 'Successfully added.';
      echo $query;
    }
  }






?>
