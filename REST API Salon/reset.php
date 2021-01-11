<?php
     $db = mysqli_connect("localhost","root","","salon");
     if(!$db){
         echo "Database connect error".mysqli.error();
     }

    $uesrid = $_GET['uesrid'];
    $email = $_GET['email'];

    $select = $db->query("SELECT * FROM tbl_users WHERE uesrid = '".$uesrid."' AND email = '".$email."' ");
    $count = mysqli_num_rows($select);

    $newPass =  rand(11111,9999);

    if($count == 1){
        $update = $db->query("UPDATE tbl_users SET password = '".$newPass."' WHERE uesrid = '".$uesrid."' AND email = '".$email."'");

        if($update){
            echo json_encode($newPass);
        }
    }

?>