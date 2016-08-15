myCopterApp.service('Copter', function ($resource) {
	return $resource('api/birds/:copterId', {}, {
		update: {method:'PUT'},
		remove: {method:'DELETE'}
	 });
});

myCopterApp.service('Surgerys', function ($resource) {
	return $resource('api/surgerys/:copterId', {}, {
		get:    {method:'GET',isArray:true},
		save:   {method:'POST'},
		query:  {method:'GET', isArray:false},
		remove: {method:'DELETE'},
  });
});

myCopterApp.service('Surgery', function ($resource) {
	return $resource('api/surgery/:surgeryId', {}, {
		get:    {method:'GET',isArray:true},
		save:   {method:'POST'},
		query:  {method:'GET', isArray:false},
		remove: {method:'DELETE'},
  });
});

myCopterApp.service('Reports', function ($resource) {
	return $resource('api/reports/:copterId', {}, {
		get:    {method:'GET',isArray:true},
		save:   {method:'POST'},
		query:  {method:'GET', isArray:false},
		remove: {method:'DELETE'},
  });
});

myCopterApp.service('Report', function ($resource) {
	return $resource('api/report/:reportId', {}, {
		get:    {method:'GET',isArray:true},
		save:   {method:'POST'},
		query:  {method:'GET', isArray:false},
		remove: {method:'DELETE'},
  });
});

myCopterApp.service('DropTable', function ($resource) {
	 return $resource('api/birds/gettable/:tableName', {}, {
	 });
});
