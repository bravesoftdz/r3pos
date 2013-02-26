var dbfactor = function() {

	this.open = function(ds, params) {
		window.external.open(ds.getDataSet(), params);
	};

	this.beginBatch = function() {
		window.external.beginbatch();
	};

	this.addBatch = function(ds, ns, params) {
		window.external.addbatch(ds.getDataSet(), ns, params);
	};

	this.openBatch = function() {
		window.external.openBatch();
	};

	this.commitBatch = function() {
		window.external.commitBatch();
	};

	this.cancelBatch = function() {
		window.external.cancelBatch();
	};

	this.updateBatch = function(ds, ns, params) {
		window.external.updatebatch(ds.getDataSet(), ns, params);
	};

	this.execSQL = function(sql) {
		return window.external.execSQL(sql);
	};

	this.iDbType = function() {
		return window.external.iDbType();
	};

	this.moveToRemote = function() {
		window.external.moveToRemote();
	};

	this.moveToSqlite = function() {
		window.external.moveToSqlite();
	};

	this.getLastError = function() {
		return window.external.getLastError();
	};

};