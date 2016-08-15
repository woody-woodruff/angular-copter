<?php

require 'Slim/Slim.php';

//; DUE TO A "FEATURE" THIS NEEDS EXPLICTLY TURNED TO -1
//; Always populate the $HTTP_RAW_POST_DATA variable. PHP's default behavior is
//; to disable this feature and it will be removed in a future version.
//; If post reading is disabled through enable_post_data_reading,
//; $HTTP_RAW_POST_DATA is *NOT* populated.
//; http://php.net/always-populate-raw-post-data
//always_populate_raw_post_data = -1

$app = new Slim();

$app->get('/birds', 'getCopters');
$app->get('/birds/:id',	'getCopter');
$app->get('/birds/search/:query', 'findByName');

$app->post('/birds', 'addCopter');
$app->put('/birds/:id', 'updateCopter');
$app->delete('/birds/:id', 'deleteCopter');

$app->get('/birds/gettable/:tableName', 'getTable');

$app->get('/surgerys/:id', 'getSurgerys');

$app->post('/surgery', 'addSurgery');
$app->get('/surgery/:id', 'getSurgery');
$app->delete('/surgery/:id', 'deleteSurgery');

$app->get('/reports/:id', 'getReports');

$app->post('/report', 'addReport');
$app->get('/report/:id', 'getReport');
$app->delete('/report/:id', 'deleteReport');

$app->run();

function getTable($tableName) {
	myLogMsg("Getting table - " . $tableName);
		$colSuf = "name";
		if (strPos($tableName, "typ_", 0) === 0) {
			$colSuf = "desc";
		}
	$sql = "select ". $tableName . "_id as id, ". $tableName. "_" . $colSuf . " as name from ". $tableName;

	try {
		$db = getConnection();
		$stmt = $db->query($sql);
		$tableStuff = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;

		myLogMsg ("Get table Result-> " . json_encode($tableStuff));

		echo json_encode($tableStuff);
	} catch (Exception $ee) {
		echoError ($ee);
	}
}
////////////////////////////////////////////////////////////////////////////////////////
function getSurgerys($id) {
	myLogMsg("Getting repair List - " . $id);

	$sql = "SELECT * FROM view_surgery WHERE copter_id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$copter = $stmt->fetchAll();

		$db = null;



		myLogMsg ("Surgery Repair List: " . json_encode($copter));

		echo json_encode($copter);
	} catch (Exception $ee) {
		echoError ($ee);
	}
}

function getSurgery($id) {
	myLogMsg("Getting surgery - " . $id);

	$sql = "SELECT * FROM surgery WHERE surgery_id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$copter = $stmt->fetchObject();
		$db = null;

		myLogMsg ("Surgery Details: " . json_encode($copter));

		echo json_encode($copter);
	} catch (Exception $ee) {
		echoError ($ee);
	}
}

function addSurgery() {
	myLogMsg("ADDING Surgery");
	$sql = "INSERT INTO surgery (copter_id,surgery_date,comment_id) VALUES (:copter_id, :surgery_date,:comment_id)";

	try {
		$request = Slim::getInstance()->request();
		$body = $request->getBody();

		myLogMsg("Recieved in: " . $body);

		$surgery = json_decode($request->getBody());

		$comment_id = $surgery->comment_id;
		$db = getConnection();

	 		myLogMsg("Starting DB Work->\n\n\n");
	if ($comment_id == 0) {
			myLogMsg("Want to add Comment: " . $surgery->comment_text);
			$stmt2 = $db->prepare("insert into comment (comment_table,comment_text) values ('surgery',:comment_text)");
			$stmt2->bindParam("comment_text",$surgery->comment_text);
			$stmt2->execute();
			$comment_id =  $db->lastInsertId();
		}


		$stmt = $db->prepare($sql);
 		$stmt->bindParam("copter_id", $surgery->copter_id);
 		$stmt->bindParam("surgery_date", $surgery->surgery_date);
 		$stmt->bindParam("comment_id", $comment_id);
 		$stmt->execute();

 		myLogMsg("\n\nAdded Surgery  -> " .$db->lastInsertId() . "\n\n");

 		$surgery->id = $db->lastInsertId();
 		$surgery->surgery_id = $db->lastInsertId();
 		$db = null;

		myLogMsg ("Sending Back: " . json_encode($surgery));

		echo json_encode($surgery);
	} catch (Exception $ee) {
		echoError ($ee);
	}
}

function deleteSurgery($id) {
	myLogMsg("Deleting surgery - " . $id);
	$sql = "DELETE FROM surgery WHERE surgery_id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$db = null;
		echo '{"id":"0","ml_id":"0"}';
	} catch (Exception $ee) {
		echoError ($ee);
	}
}
/////////////////////////////////////////////////////////////////////////////////////////////
function getReports($id) {
	myLogMsg("Getting repair List - " . $id);

	$sql = "SELECT * FROM view_flight_report WHERE copter_id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$copter = $stmt->fetchAll();

		$db = null;



		myLogMsg ("Report List: " . json_encode($copter));

		echo json_encode($copter);
	} catch (Exception $ee) {
		echoError ($ee);
	}
}

function getReport($id) {
	myLogMsg("Getting Report - " . $id);

	$sql = "SELECT * FROM flight_report WHERE flight_report_id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$copter = $stmt->fetchObject();
		$db = null;

		myLogMsg ("Report Details: " . json_encode($copter));

		echo json_encode($copter);
	} catch (Exception $ee) {
		echoError ($ee);
	}
}

function addReport() {
	myLogMsg("ADDING Report");
	$sql = "INSERT INTO flight_report (copter_id,flight_report_date,comment_id,rating,wind_dir,wind_spd,temp_f,typ_weather_id) VALUES (:copter_id, :flight_report_date,:comment_id,:rating,:wind_dir,:wind_spd,:temp_f,:typ_weather_id)";

	try {
		$request = Slim::getInstance()->request();
		$body = $request->getBody();

		myLogMsg("Recieved in: " . $body);

		$report = json_decode($request->getBody());

		$comment_id = $report->comment_id;
		$db = getConnection();

	 		myLogMsg("Starting DB Work->\n\n\n");
	if ($comment_id == 0) {
			myLogMsg("Want to add Report comment: " . $report->comment_text);
			$stmt2 = $db->prepare("insert into comment (comment_table,comment_text) values ('flight_report',:comment_text)");
			$stmt2->bindParam("comment_text",$report->comment_text);
			$stmt2->execute();
			$comment_id =  $db->lastInsertId();
		}


		$stmt = $db->prepare($sql);
 		$stmt->bindParam("copter_id", $report->copter_id);
 		$stmt->bindParam("flight_report_date", $report->flight_report_date);
 		$stmt->bindParam("comment_id", $comment_id);
 		$stmt->bindParam("rating", $report->rating);
 		$stmt->bindParam("wind_dir", $report->wind_dir);
 		$stmt->bindParam("wind_spd", $report->wind_spd);
 		$stmt->bindParam("temp_f", $report->temp_f);
 		$stmt->bindParam("typ_weather_id", $report->typ_weather_id);
 		$stmt->execute();

 		myLogMsg("\n\nAdded Report  -> " .$db->lastInsertId() . "\n\n");

 		$report->id = $db->lastInsertId();
 		$report->flight_report_id = $db->lastInsertId();
 		$db = null;

		myLogMsg ("Sending Back: " . json_encode($report));

		echo json_encode($report);
	} catch (Exception $ee) {
		echoError ($ee);
	}
}

function deleteReport($id) {
	myLogMsg("Deleting REPORT - " . $id);
	$sql = "DELETE FROM flight_report WHERE flight_report_id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$db = null;
		echo '{"id":"0","ml_id":"0"}';
	} catch (Exception $ee) {
		echoError ($ee);
	}
}
/////////////////////////////////////////////////////////////////////////////////////////////
function getCopters() {
	myLogMsg("Getting Cotper List");

	$sql = "select c_id as id, c_name as name from view_copter ORDER BY c_name";
	try {
		$db = getConnection();
		$stmt = $db->query($sql);
		$copters = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		echo json_encode($copters);
	} catch (Exception $ee) {
		echoError ($ee);
	}
}

function getCopter($id) {
	myLogMsg("Getting copter - " . $id);

	$sql = "SELECT * FROM view_copter_master WHERE ml_id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$copter = $stmt->fetchObject();
		$db = null;

		myLogMsg (json_encode($copter));

		echo json_encode($copter);
	} catch (Exception $ee) {
		echoError ($ee);
	}
}

function addCopter() {
	myLogMsg("ADDING Copter");
	$sql = "INSERT INTO copter (name_id, make_id, model_id, mfg_id) VALUES (:ml_name_id, :ml_make_id, :ml_model_id, :ml_mfg_id)";

	try {
		$request = Slim::getInstance()->request();
		$body = $request->getBody();

		myLogMsg("Recieved in: " . $body);

		$copter = json_decode($request->getBody());
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("ml_name_id", $copter->ml_name_id);
		$stmt->bindParam("ml_make_id", $copter->ml_make_id);
		$stmt->bindParam("ml_model_id", $copter->ml_model_id);
		$stmt->bindParam("ml_mfg_id", $copter->ml_mfg_id);
		$stmt->execute();

		myLogMsg("\n\nAdded Copter  -> " .$db->lastInsertId() . "\n\n");

		$copter->id = $db->lastInsertId();
		$copter->ml_id = $db->lastInsertId();
		$db = null;

		myLogMsg ("Sending Back: " . json_encode($copter));

		echo json_encode($copter);
	} catch (Exception $ee) {
		echoError ($ee);
	}
}

function updateCopter($id) {
	myLogMsg("update Copter - " . $id);
	$sql = "UPDATE copter SET name_id=:ml_name_id, make_id=:ml_make_id, model_id=:ml_model_id, mfg_id=:ml_mfg_id WHERE copter_id=:ml_id";

	try {
		$request = Slim::getInstance()->request();
		$body = $request->getBody();

		myLogMsg($body);

		$copter = json_decode($body);
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("ml_name_id", $copter->ml_name_id);
		$stmt->bindParam("ml_make_id", $copter->ml_make_id);
		$stmt->bindParam("ml_model_id", $copter->ml_model_id);
		$stmt->bindParam("ml_mfg_id", $copter->ml_mfg_id);
		$stmt->bindParam("ml_id", $id);
		$stmt->execute();
		$db = null;
		echo json_encode($copter);
	} catch (Exception $ee) {
		echoError ($ee);
	}
}

function deleteCopter($id) {
	myLogMsg("Deleting copter - " . $id);
	$sql = "DELETE FROM copter WHERE copter_id=:id";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$stmt->bindParam("id", $id);
		$stmt->execute();
		$db = null;
		echo '{"id":"0","ml_id":"0"}';
	} catch (Exception $ee) {
		echoError ($ee);
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////
function findByName($query) {
	myLogMsg( "Doing a Search: " . $query );

	$sql = "SELECT * FROM view_copter_master WHERE UPPER(ml_name) LIKE :query ORDER BY ml_name";
	try {
		$db = getConnection();
		$stmt = $db->prepare($sql);
		$query = "%".$query."%";
		$stmt->bindParam("query", $query);
		$stmt->execute();
		$copters = $stmt->fetchAll(PDO::FETCH_OBJ);
		$db = null;
		echo '{"copter": ' . json_encode($copters) . '}';
	} catch (Exception $ee) {
		echoError ($ee);
	}
}

function getConnection() {
	$dbhost="127.0.0.1";
	$dbuser="wwwphp";
	$dbpass="mmmmmm";
	$dbname="copters";
	$dbh = new PDO("mysql:host=$dbhost;dbname=$dbname", $dbuser, $dbpass);
	$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	return $dbh;
}
///////////////////////////////////////////////////////////////////////
function myLogMsg ($msg) {
	$MYLOGFILE = fopen ("copter.log","a+");
	fwrite( $MYLOGFILE , $msg . "\n");
	fclose($MYLOGFILE);
}

function echoError ($ee) {
	Slim::getInstance()->response()->status(500);

	myLogMsg('Had an Error: ' . $ee->getMessage() );
	echo '{"error":{"text":"'. $ee->getMessage() .'"}}';
}

?>
