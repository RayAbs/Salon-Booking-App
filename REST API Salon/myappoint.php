<?php

include "connect.php";

if($_SERVER['REQUEST_METHOD']=="GET"){
    $id = $_GET['clientid'];
 
 

	$queryResult = $con->query("SELECT tbl_transaction.*,tbl_users.name FROM tbl_transaction,tbl_users WHERE clientid=$id AND tbl_users.userid = tbl_transaction.clientid");
	
	// SELECT vessel_transaction.*,vessel_details.vesselname,vessel_details.scn,vessel_details.voyageno FROM vessel_transaction,vessel_details where client_signature=$id AND vessel_details.vesselid = vessel_transaction.vesselid 
	$result = array ();
	while($fetchData = $queryResult->fetch_assoc()){
	    $result[] = $fetchData;
	}
	echo json_encode($result);
   
}


?>
