<?php

require "connect.php";

if($_SERVER['REQUEST_METHOD']=="POST"){
    $data = json_decode(file_get_contents('php://input'), true);
    $response = array();
    $typeofservice = $data['typeofservice'];
    $stylist = $data['stylist'];
    $trans_dt = $data['trans_dt'];
    $clientid = $data['clientid'];


    $insert = "INSERT INTO tbl_transaction VALUE(NULL,'$typeofservice','$stylist','$trans_dt','$clientid','ongoing')";
    if (mysqli_query($con,$insert))
    {
        $response['value'] = 1;
        $response['message'] = "Record Successfully";
        echo json_encode($response);
    }
    else
    {
        $response['value'] = 0;
        $response['message'] = "Record Failed";
        echo json_encode($response);
    }
     
    
    

  
   
 
}

?>