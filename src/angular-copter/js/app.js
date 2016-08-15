var myCopterApp = angular.module('copterApp', ['ngRoute','ngResource']); //'movieApp.controllers','movieApp.services']);

myCopterApp.config(['$routeProvider', function($routeProvider) {
	$routeProvider
		.when('/birds', {
			templateUrl: "tpl/welcome.html"
		})
		.when('/birds/:copterId', {
			templateUrl: "tpl/copter-details.html",
			controller: "CopterDetailCtrl"
		})
		.when('/report/:copterId', {
			templateUrl: "tpl/flight-report.html",
			controller: "ReportDetailCtrl"
		})
		.when('/surgery/:copterId', {
			templateUrl: "tpl/copter-surgery.html",
			controller: "SurgeryDetailCtrl"
		})
		.otherwise({ redirectTo: '/birds' }) ;
}]);
