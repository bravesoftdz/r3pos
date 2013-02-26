var dataset = function() {

	var ds = undefined;

	this.getDataSet = function() {
		return ds;
	}

	this.createDataSet = function() {
		ds = window.external.createDataSet();
	};

	this.eraseDataSet = function() {
		window.external.eraseDataSet(ds);
		ds = undefined;
	};

	this.setSQL = function(SQL) {
		window.external.setSQL(ds, SQL);
	};

	this.append = function() {
		window.external.append(ds);
	};

	this.edit = function() {
		window.external.edit(ds);
	};

	this.post = function() {
		window.external.post(ds);
	};

	this.getAsString = function(fieldname) {
		return window.external.getAsString(ds, fieldname);
	};

	this.getAsInteger = function(fieldname) {
		return window.external.getAsInteger(ds, fieldname);
	};

	this.getAsValue = function(fieldname) {
		return window.external.getAsValue(ds, fieldname);
	};

	this.getAsDouble = function(fieldname) {
		return window.external.getAsDouble(ds, fieldname);
	};

	this.setAsString = function(fieldname, val) {
		window.external.setAsString(ds, fieldname, val);
	};

	this.setAsInteger = function(fieldname, val) {
		window.external.setAsInteger(ds, fieldname, val);
	};

	this.setAsValue = function(fieldname, val) {
		window.external.setAsValue(ds, fieldname, val);
	};

	this.setAsDouble = function(fieldname, val) {
		window.external.setAsDouble(ds, fieldname, val);
	};

	this.first = function() {
		window.external.first(ds);
	};

	this.last = function() {
		window.external.last(ds);
	};

	this.next = function() {
		window.external.next(ds);
	};

	this.prior = function() {
		window.external.prior(ds);
	};

	this.eof = function() {
		return window.external.eof(ds);
	};

	this.locate = function(fieldname, value) {
		return window.external.locate(ds, fieldname, value);
	};

	this.getLastError = function() {
		return window.external.getLastError();
	};

};