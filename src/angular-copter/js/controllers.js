myCopterApp.controller('dbCtrl', ['$scope', '$http','Copter', function ($scope, $http,Copter) {
	$scope.data = Copter.query();

	$scope.repairCopter = function (cid) {
		window.location = "#/surgery/" + cid;
	};

	$scope.reportFlight = function (cid) {
		window.location = "#/report/" + cid;
	};

	$scope.showCopter = function (cid) {
		window.location = "#/birds/" + cid;
	};
}]);

myCopterApp.controller('addCtrl', ['$scope', '$http', function ($scope, $http) {
	$scope.addCopter = function () {
		window.location = "#/birds/add";
	};
}]);

myCopterApp.controller('DropTableCtrl', ['$scope', '$http','DropTable', function ($scope, $http,DropTable) {
	$scope.init = function (p_tableName) {
		$scope.data = DropTable.query({tableName:p_tableName});
	};
}]);

/////////////////////////////////           Repairs         //////////////////////////////////////////////////////

myCopterApp.controller('SurgeryDetailCtrl',['$scope','$http','$routeParams','Surgerys','Surgery', 'Copter', function ($scope,$http,$routeParams,Surgerys,Surgery,Copter) {
	$scope.showAlerts = false;
	$scope.copter_id = $routeParams.copterId;
	$scope.surgery_date = new Date('12/31/2014');
	$scope.comment_text = 'Put your comment about this repair here.';
	$scope.comment_id = 0;
	$scope.surgery_id = 0;

	$scope.surgerys = Surgerys.get({copterId:$routeParams.copterId},
				function(surgeryList, putResponseHeaders) {
					if ($scope.showAlerts) alert("Got Surgery List." + angular.toJson(surgeryList,true));
				},
				function(putResponseHeaders) {
					alert("Get Surgery List failed.\n\n" + putResponseHeaders.data.error.text);
					//window.location = "";
				}
			);
	$scope.copter = Copter.get({copterId:$routeParams.copterId});

	$scope.saveSurgery = function (surg_id) {
		if ($scope.showAlerts) alert("Saving " + surg_id + " for Copter: " + $scope.copter_id + ".\n\nFunctionality 95% complete.");
		if (surg_id > 0) {
			if ($scope.showAlerts) alert('Surgery About to be UPDATED.');
			Surgery.update({surgeryId:$scope.surgId},{surgery_date:$scope.surgery_date,copter_id:$scope.copter_id,surgery_id:surg_id,comment_id:$scope.comment_id,comment_text:$scope.comment_text},
				function(retCopter, putResponseHeaders) {
					if ($scope.showAlerts) alert("Update Success." + angular.toJson(retCopter,true));
				},
				function(putResponseHeaders) {
					alert("Update failed.\n\n" + putResponseHeaders.data.error.text);
					//window.location = "";
				}
			);
		} else {
			if ($scope.showAlerts) alert('Surgery About to be ADDED./n' + $scope.surgery_date);
			Surgery.save({surgeryId:$scope.surgId},{surgery_date:$scope.surgery_date,copter_id:$scope.copter_id,comment_id:$scope.comment_id,comment_text:$scope.comment_text},
				function(retCopter, putResponseHeaders) {
					if ($scope.showAlerts) alert("Save Success.\n" + angular.toJson(retCopter,true));
				},
				function(putResponseHeaders) {
					alert("Save failed.\n\n" + putResponseHeaders.data.error.text);
					//window.location = "";
				}
			);
		}
	}
	$scope.deleteSurgery = function (surg_id) {
		if (confirm("Really delete this item?")) {
			Surgery.remove({surgeryId:surg_id},{},
			function(retStuff, putResponseHeaders) {
				if ($scope.showAlerts) alert("Delete Success.\n" + angular.toJson(retStuff,true));
			},
			function(putResponseHeaders) {
				alert("Delete failed.\n\n" + putResponseHeaders.data.error.text);
				//window.location = "";
			}
		);
		}
	}
}]);


/////////////////////////////////           Reports         //////////////////////////////////////////////////////

myCopterApp.controller('ReportDetailCtrl',['$scope','$http','$routeParams','Reports','Report', 'Copter', function ($scope,$http,$routeParams,Reports,Report,Copter) {
	$scope.showAlerts = false;
	$scope.copter_id = $routeParams.copterId;
	$scope.flight_report_date = new Date('12/31/2014');
	$scope.comment_text = 'Flight Report Details here.';
	$scope.comment_id = 0;
	$scope.flight_report_id = 0;

	$scope.report = { rating:5, wind_dir:10,wind_spd:5,temp_f:72,typ_weather_id:2};

	$scope.reports = Reports.get({copterId:$routeParams.copterId},
				function(ReportList, putResponseHeaders) {
					if ($scope.showAlerts) alert("Got Report List." + angular.toJson(ReportList,true));
				},
				function(putResponseHeaders) {
					alert("Get Report List failed.\n\n" + putResponseHeaders.data.error.text);
					//window.location = "";
				}
			);
	$scope.copter = Copter.get({copterId:$routeParams.copterId});

	$scope.saveReport = function (surg_id) {
		if ($scope.showAlerts) alert("Saving " + surg_id + " for Copter: " + $scope.copter_id + ".\n\nFunctionality 85% complete.");
		if (surg_id > 0) {
			if ($scope.showAlerts) alert('Report About to be UPDATED.');
			Report.update({reportId:$scope.surgId},{flight_report_date:$scope.flight_report_date,copter_id:$scope.copter_id,flight_report_id:surg_id,comment_id:$scope.comment_id,comment_text:$scope.comment_text},
				function(retCopter, putResponseHeaders) {
					if ($scope.showAlerts) alert("Update Success." + angular.toJson(retCopter,true));
				},
				function(putResponseHeaders) {
					alert("Update failed.\n\n" + putResponseHeaders.data.error.text);
					//window.location = "";
				}
			);
		} else {
			if ($scope.showAlerts) alert('Report About to be ADDED.\n' + $scope.report.typ_weather_id);
			Report.save({
								flight_report_date:$scope.flight_report_date,
								copter_id:$scope.copter_id,
								comment_id:$scope.comment_id,
								comment_text:$scope.comment_text,
								temp_f:$scope.report.temp_f,
								typ_weather_id:$scope.report.typ_weather_id,
								rating:$scope.report.rating,
								wind_dir:$scope.report.wind_dir,
								wind_spd:$scope.report.wind_spd},
				function(retCopter, putResponseHeaders) {
					if ($scope.showAlerts) alert("Save Success.\n" + angular.toJson(retCopter,true));
				},
				function(putResponseHeaders) {
					alert("Save failed.\n\n" + putResponseHeaders.data.error.text);
					//window.location = "";
				}
			);
		}
	}
	$scope.deleteReport = function (surg_id) {
		if (confirm("Really delete this item?")) {
			Report.remove({reportId:surg_id},{},
			function(retStuff, putResponseHeaders) {
				if ($scope.showAlerts) alert("Delete Success.\n" + angular.toJson(retStuff,true));
			},
			function(putResponseHeaders) {
				alert("Delete failed.\n\n" + putResponseHeaders.data.error.text);
				//window.location = "";
			}
		);
		}
	}
}]);

//////////////////////////         Copter Detail       ///////////////////////////////////////////

myCopterApp.controller('CopterDetailCtrl',['$scope','$http','$routeParams','Copter',function ($scope,$http,$routeParams,Copter) {
	$scope.copter = Copter.get({copterId:$routeParams.copterId});
	$scope.showAlerts = false;

	$scope.saveCopter = function () {
		if ($scope.copter.ml_id > 0) {
			if ($scope.showAlerts) alert('Copter About to be UPDATED.');
			$scope.copter.$update({copterId:$scope.copter.ml_id},
				function(retCopter, putResponseHeaders) {
					if ($scope.showAlerts) alert("Update Success." + angular.toJson(retCopter,true));
					window.location = "#/birds/" + retCopter.ml_id;
				},
				function(putResponseHeaders) {
					alert("Update failed.\n\n" + putResponseHeaders.data.error.text);
					//window.location = "";
				}
			);
		} else {
			if ($scope.showAlerts) alert('Copter About to be ADDED.');
			$scope.copter.$save({copterId:$scope.copter.ml_id},
				function(retCopter, putResponseHeaders) {
					if ($scope.showAlerts) alert("Save Success.\n" + angular.toJson(retCopter,true));
					window.location = "";
				},
				function(putResponseHeaders) {
					alert("Save failed.\n\n" + putResponseHeaders.data.error.text);
					//window.location = "";
				}
			);
		}
	 }

	 $scope.deleteCopter = function () {
		if ($scope.showAlerts) alert('Copter ' + $scope.copter.ml_name + ' About to be DELETED.');
		$scope.copter.$remove({copterId:$scope.copter.ml_id},
			function(retStuff, putResponseHeaders) {
				if ($scope.showAlerts) alert("Delete Success.\n" + angular.toJson(retStuff,true));
				window.location = "";
			},
			function(putResponseHeaders) {
				alert("Delete failed.\n\n" + putResponseHeaders.data.error.text);
				//window.location = "";
			}
		);
	 };
}]);
