<?php
require "connect.php";
if($_SERVER['REQUEST_METHOD']=="POST"){
    $data = json_decode(file_get_contents('php://input'), true);
    $response = array();
  
    $id = $data['userid'];
    $password = $data['password'];
 


        $insert = "UPDATE tbl_users SET password = '$password' WHERE userid ='$id'";
        if (mysqli_query($con,$insert)) {
            $response['value'] = 1;
            $response['message'] = "Successfully Updated";
            echo json_encode($response);
    
        }
        else{
            $response['value'] = 0;
            $response['message'] = "Failed to Update";
            echo json_encode($response);
        }

    

   
}

?>