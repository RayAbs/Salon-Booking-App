<?php 
    $db = mysqli_connect("localhost","root","","salon");
    if(!$db){
        echo "Database connect error".mysqli.error();
    }

    $email = $_POST['email'];

    $select =  $db->query("SELECT * FROM tbl_users WHERE email= '".$email."' ");
    $count = mysqli_num_rows($select);
    $data = mysqli_fetch_assoc($select);

    $idData = $data['uesrid'];
    $emailData = $data['email'];

    if($count == 1){
        $url = 'http://'.$_SERVER['SERVER_NAME'].'/salon/reset.php?userid='.$idData.'&email='.$emailData;

        echo json_encode($url);
    }
     else{
        echo json_encode("INVALIDUSER");
      }



?>