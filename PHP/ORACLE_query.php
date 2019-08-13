<?php

function get_connection () {

    $db = "(DESCRIPTION=(ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = uxpck17d.ux.loc)(PORT = 1535)))(CONNECT_DATA=(SID=ONLD)))" ;

    if($c = OCILogon("USER", "PASSWORD", $db))
    {
        echo "Successfully connected to Oracle.\n";
        // OCILogoff($c);
    }
    else
    {
        $err = OCIError();
        echo "Connection failed." . $err[text];
    }
		
		$conn = $c;

		if (!$conn) {
				$e = oci_error();
				trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
		}
		
		return $conn;  

}

function run_and_print ($p_conn, $p_sql_statement) {
	// Prepare the statement
	// $stid = oci_parse($conn, 'SELECT * FROM tor01_ordens where rownum < 2');
	$stid = oci_parse($p_conn, $p_sql_statement);

	if (!$stid) {
			$e = oci_error($conn);
			trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
	}

	// Perform the logic of the query
	$r = oci_execute($stid);
	
	if (!$r) {
			$e = oci_error($stid);
			trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
	}

	// Fetch the results of the query
	$headers = false;
	print "<table border='1'>\n";
	while ($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
	
	    if (!$headers) {
        // this will only output the headers on the first iteration.
        // print_r(array_keys($row));

				print "<tr bgcolor=\"#FF6600\" >\n";
				foreach (array_keys($row) as $item) {
						print "    <td>" . ($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;") . "</td>\n";
				}
				print "</tr>\n";
				
        $headers = true;
      }
	
			print "<tr>\n";
			foreach ($row as $item) {
					print "    <td>" . ($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;") . "</td>\n";
			}
			print "</tr>\n";
	}
	print "</table>\n";

	oci_free_statement($stid);
}


$owner_v1_conn = get_connection();
		
		$sql_stat = '

			Select* from dual

			';

		run_and_print($owner_v1_conn, $sql_stat);
		
		
		$sql_stat = '

Select* from dual

			';
     
		echo '<BR/><BR/>'; 
		run_and_print($owner_v1_conn, $sql_stat);		
		
		

		$sql_stat = '

Select* from dual

			';
     
		echo '<BR/><BR/>'; 
		run_and_print($owner_v1_conn, $sql_stat);		
		

		$sql_stat = '
        Select to_char(sysdate, \'HH24:MI:SS\') last_update from dual
			';
     
		echo '<BR/><BR/>'; 
		run_and_print($owner_v1_conn, $sql_stat);				
		
		oci_close($owner_v1_conn);		
		
?>
