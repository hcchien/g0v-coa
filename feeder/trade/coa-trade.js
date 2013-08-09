var casper = require('casper').create();
casper.start('http://agrstat.coa.gov.tw/sdweb/public/trade/tradereport.aspx').thenEvaluate(function() {
	__doPostBack('ctl00$cphMain$uctlTradeList$grdTradeList','Report$0');
});
casper.thenEvaluate(function() {
	var year = document.getElementById('ctl00_cphMain_uctlTradeList_uctlTradeReport11_ddlYear');
	var year_options = year.getElementsByTagName('option');
	year_options[0].removeAttribute('selected');
	year_options[24].setAttribute('selected', 'selected');
	var month_end = document.getElementById('ctl00_cphMain_uctlTradeList_uctlTradeReport11_ddlMon_E');
	var month_end_options = month_end.getElementsByTagName('option');
	month_end_options[5].removeAttribute('selected');
	month_end_options[11].setAttribute('selected', 'selected');
	var rows = document.getElementById('ctl00_cphMain_uctlTradeList_uctlTradeReport11_ddlTopCnt');
	var rows_options = rows.getElementsByTagName('option');
	rows_options[1].removeAttribute('selected');
	rows_options[9].setAttribute('selected', 'selected');
	document.querySelector('input[id="ctl00_cphMain_uctlTradeList_uctlTradeReport11_btnQuery"]').click();
}); 
casper.then(function () {
	this.echo(this.getHTML());
});
casper.run();
