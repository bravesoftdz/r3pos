	var ds = new dataset();
	$().ready( function() {	
		var jsonObj = JSON.parse(rsp.getUserInfo());
		var tenantId = jsonObj.tenantId;
        if(tenantId=='' || tenantId == undefined){
			return;	
		}
		jypm_tj(tenantId,0);	//卷烟排名
		jypm_tj(tenantId,1);	//非烟排名
		jyfl_tj(tenantId);		//卷烟分类
		fyfl_tj(tenantId);		//非烟分类
		xstjqk(tenantId);		//销售统计情况
		jhtjqk(tenantId);		//进货统计情况		
		kc_tj(tenantId);		//库存统计情况
		yltjqk(tenantId);		//盈利统计情况
		$("#jyfl").click(function(){
				$(this).attr("src","images/jy_01.png");
				$("#fyfl").attr("src","images/jy_2.png");
				$("#jyfldiv").css("display","block");
				$("#fyfldiv").css("display","none");
			});
		$("#fyfl").click(function () {
				$(this).attr("src","images/jy_02.png");
				$("#jyfl").attr("src","images/jy_1.png");		
				$("#fyfldiv").css("display","block");
				$("#jyfldiv").css("display","none");
			});	
		$("#jypm").click(function(){
				$(this).attr("src","images/jypm_01.png");
				$("#fypm").attr("src","images/jypm_2.png");
				$("#jypmdiv").css("display","block");
				$("#fypmdiv").css("display","none");
			});
		$("#fypm").click(function () {
				$(this).attr("src","images/jypm_02.png");
				$("#jypm").attr("src","images/jypm_1.png");		
				$("#fypmdiv").css("display","block");
				$("#jypmdiv").css("display","none");
			});	
		
	});		
	
	/*****************************************************
	 *卷烟排名统计
	 * tenant_id 企业id
	 * type 0: 卷烟排名 1：非烟排名
	 *****************************************************
	*/
	function jypm_tj(tenant_id,type){
		try{
			var d = new Date();
			var d2 = d.format('yyyyMMdd');		//今天日期
			d.addMonths(-1);
			var d1 = d.format('yyyyMMdd');		//上个月今天日期
			var typeValue = "=";
			if(type=='0'){
			var typeValue = "=";				
			} else if(type=='1'){
				var typeValue = "!=";				
			}
			
			ds.createDataSet();	
			var sql = "select A.GODS_ID,B.GODS_NAME,sum(CALC_MONEY-A.CALC_AMOUNT*B.NEW_INPRICE) as PRF_MONEY from VIW_SALESDATA A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID="+tenant_id+" and A.SALES_DATE>="+d1+" and A.SALES_DATE<="+d2+" and B.RELATION_ID"+typeValue+"1000006 group by A.GODS_ID,B.GODS_NAME";
			//取前十条数据,根据不同数据库进行取数
			sql = rsp.fechTopResults(sql,10,'PRF_MONEY desc');
			rsp.setLocalJson('jypm_tj',"卷烟排名统计sql:"+sql);
			ds.setSQL(sql);
			var dataset = factor.open(ds);
			ds.first();
			var data = "<chart caption='销售利润前五名' xAxisName='' yAxisName='' showValues='1' formatNumberScale='0' useRoundEdges='0' baseFont='宋体' baseFontSize='12' canvasBgAlpha='100' showCanvasBg='1'>";			
			while(!ds.eof()){
				var goods_id = ds.getAsString("GODS_ID");
				var goods_name = ds.getAsString("GODS_NAME");
				var prf_money = ds.getAsString("PRF_MONEY");
				data +="<set label='"+goods_name+"' value='"+prf_money+"' color='003399'/>";
				ds.next();
			}
			data +="</chart>";
			var chart = new FusionCharts("./flash/Column2D.swf", "ChartId", "250", "210", "0", "0");			
		    chart.setDataXML(data);	
			if(type=='0'){
				chart.render("jypmdiv");	
			}else if(type=='1'){
				chart.render("fypmdiv");	
			}
		    			
			ds.eraseDataSet();
		}catch(e){
			alert(e.message);
			ds.eraseDataSet();
			return;
		}
	}
	
	/*****************************************************
	 *卷烟分类统计
	 * tenant_id 企业id
	 *****************************************************
	*/
	function jyfl_tj(tenant_id){
		try{
			var d = new Date();
			var d2 = d.format('yyyyMMdd');		//今天日期
			d.addMonths(-1);
			var d1 = d.format('yyyyMMdd');		//上个月今天日期
			
			ds.createDataSet();	
			var sql = "select j.SORT_ID,j.SORT_NAME,ifnull(c.CALC_MONEY,0) as CALC_MONEY from VIW_GOODSSORT j left outer join (select s.TENANT_ID,a.SORT_ID2,sum(s.CALC_MONEY) CALC_MONEY from VIW_SALESDATA s,VIW_GOODSINFO a where s.TENANT_ID=a.TENANT_ID and s.gods_id = a.gods_id and s.TENANT_ID="+tenant_id+" and s.SALES_DATE>="+d1+" and s.SALES_DATE<="+d2+" group by s.TENANT_ID,A.SORT_ID2) c on j.TENANT_ID=c.TENANT_ID and j.SORT_ID=c.SORT_ID2 where j.SORT_TYPE=2 and j.TENANT_ID="+tenant_id+" order by j.SEQ_NO";
			sql = rsp.parseSQL(sql);
			rsp.setLocalJson('jyfltjqk',"卷烟分类统计sql:"+sql);
			ds.setSQL(sql);
			var dataset = factor.open(ds);
			ds.first();
			var data = "<chart showValues='1' formatNumberScale='0' useRoundEdges='0' baseFont='宋体' baseFontSize='12' showBorder='0' bgColor='' showCanvasBg='0' >";			
			while(!ds.eof()){
				var sort_id = ds.getAsString("SORT_ID");
				var sort_name = ds.getAsString("SORT_NAME");
				var calc_money = ds.getAsString("CALC_MONEY");
				data +="<set label='"+sort_name+"' value='"+calc_money+"' color=''/>";
				ds.next();
			}
			data +="</chart>";
			var chart = new FusionCharts("./flash/Pie2D.swf", "ChartId", "250", "210", "0", "0");			
		    chart.setDataXML(data);			
			chart.render("jyfldiv");	
			ds.eraseDataSet();
		}catch(e){
			alert(e.message);
			ds.eraseDataSet();
			return;
		}
	}	
	
	
	/*****************************************************
	 *非烟分类统计
	 * tenant_id 企业id
	 *****************************************************
	*/
	function fyfl_tj(tenant_id){
		try{
			var d = new Date();
			var d2 = d.format('yyyyMMdd');		//今天日期
			d.addMonths(-1);
			var d1 = d.format('yyyyMMdd');		//上个月今天日期
			
			ds.createDataSet();	
			var sql = "select j.TENANT_ID,d.SORT_ID,ifnull(d.SORT_NAME,'无分类') as SORT_NAME,j.CALC_MONEY from (select A.TENANT_ID,substr(C.LEVEL_ID,1,4) as LEVEL_ID,b.RELATION_ID,1 as SORT_TYPE,sum(A.CALC_MONEY) as CALC_MONEY from VIW_SALESDATA A inner join VIW_GOODSINFO B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID left outer join VIW_GOODSSORT C on B.TENANT_ID=C.TENANT_ID and B.SORT_ID1=C.SORT_ID  where A.TENANT_ID="+tenant_id+" and A.SALES_DATE>="+d1+" and A.SALES_DATE<="+d2+" and B.RELATION_ID<>1000006 group by A.TENANT_ID,substr(C.LEVEL_ID,1,4),b.RELATION_ID) j left outer join VIW_GOODSSORT d on j.TENANT_ID=d.TENANT_ID and j.LEVEL_ID=d.LEVEL_ID and j.RELATION_ID=d.RELATION_ID and j.SORT_TYPE=d.SORT_TYPE order by d.SEQ_NO";
			sql = rsp.parseSQL(sql);
			rsp.setLocalJson('fyfltjqk',"非烟分类统计sql:"+sql);
			ds.setSQL(sql);
			var dataset = factor.open(ds);
			ds.first();
			var data = "<chart caption='' xAxisName='' yAxisName='' showValues='0' formatNumberScale='0' useRoundEdges='0' baseFont='宋体' baseFontSize='12' bgColor=''>";			
			while(!ds.eof()){
				var sort_id = ds.getAsString("SORT_ID");
				var sort_name = ds.getAsString("SORT_NAME");
				var calc_money = ds.getAsString("CALC_MONEY");
				data +="<set label='"+sort_name+"' value='"+calc_money+"' color=''/>";
				ds.next();
			}
			data +="</chart>";
			var chart = new FusionCharts("./flash/Pie2D.swf", "ChartId", "250", "210", "0", "0");			
		    chart.setDataXML(data);	
			chart.render("fyfldiv");	
			ds.eraseDataSet();
		}catch(e){
			alert(e.message);
			ds.eraseDataSet();
			return;
		}
	}
	
	/*************************************************
	 * 销售统计情况
	 *************************************************
	 */
	function xstjqk(tenant_id){

		try{
			var d = new Date();
			var d1 = d.format('yyyyMMdd');		//今天日期
			ds.createDataSet();	
		var sql = "select SALES_DATE,cacl_amount,jy_money,fy_money,round((JY_MONEY*1.0/(JY_MONEY+FY_MONEY)*100),1)||'%' as jyzb from (select A.SALES_DATE,b.RELATION_ID,sum(case when (b.RELATION_ID=1000006) then a.CALC_MONEY else 0 end ) JY_MONEY,sum(case when (b.RELATION_ID<>1000006) then a.CALC_MONEY else 0 end ) FY_MONEY,sum(A.CALC_AMOUNT) cacl_amount from VIW_SALESDATA A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID="+tenant_id+" and A.SALES_DATE="+d1+" group by A.SALES_DATE,b.RELATION_ID)";
			rsp.setLocalJson('xstjqk',"销售统计sql:"+sql);
			ds.setSQL(sql);
			var dataset = factor.open(ds);
			var flag = ds.locate('SALES_DATE',d1);
			if(flag){
				var amount = ds.getAsString("cacl_amount");
				var jy_money = ds.getAsString("jy_money");
				var fy_money = ds.getAsString("fy_money");
				var jyzb = ds.getAsString("jyzb");
				$("#tjqk").html("(今日销售卷烟"+amount+"盒，"+jy_money+"元，非烟"+fy_money+"元，烟类占比"+jyzb+"。)");		
			}else{
				$("#tjqk").html("今日销售卷烟0盒，0元，非烟0元，善类占比0。");		
			}
			ds.eraseDataSet();
		}catch(e){
			alert(e.message);
			ds.eraseDataSet();
			return;
		}
	}

	
	/*************************************************
	 * 进货统计情况
	 *************************************************
	 */
	function jhtjqk(tenant_id){

		try{
			var d = new Date();
			var d2 = d.format('yyyyMMdd');		//今天日期
			d = d.getWeekStartDate();
			var d1 = d.format('yyyyMMdd');		//本周第一天
			ds.createDataSet();	
		var sql = "select a.tenant_id,sum( a.amount) as amount,sum(case when b.RELATION_ID=1000006 then case b.SMALLTO_CALC when ifnull(b.smallto_calc,1) then CALC_AMOUNT/b.smallto_calc else Calc_amount end else 0 end ) as jy_amount,sum(case when b.RELATION_ID=1000006 then a.calc_money*b.NEW_OUTPRICE else 0 end ) as yj_money from VIW_STOCKDATA A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID="+tenant_id+" and A.STOCK_DATE>="+d1+" and A.STOCK_DATE<="+d2+" group by a.tenant_id";
			sql = rsp.parseSQL(sql);
			rsp.setLocalJson('jhtjqk',"进货统计sql:"+sql);
			ds.setSQL(sql);
			var dataset = factor.open(ds);
			var flag = ds.locate('tenant_id',tenant_id);
			if(flag){
				var amount = ds.getAsString("amount");
				var jy_amount = ds.getAsString("jy_amount");
				var jy_money = ds.getAsString("yj_money");
				$("#jhtjqk").html("(本周进货"+amount+"个规格，卷烟"+jy_amount+"条，"+jy_money+"元。)");		
			}else{
				$("#jhtjqk").html("(本周进货0个规格，卷烟0条，0元。)");		
			}
			ds.eraseDataSet();
		}catch(e){
			alert(e.message);
			ds.eraseDataSet();
			return;
		}
	}
	
	/****************************************************
	 *库存统计
	 *****************************************************
	*/
	function kc_tj(tenant_id){
		try{
			ds.createDataSet();	
			var sql = "select count(distinct b.GODS_ID) as GODS_AMT, count(distinct a.GODS_ID) as STO_AMT,sum(a.AMOUNT ) as AMOUNT,sum(A.AMOUNT*B.NEW_OUTPRICE) as AMONEY from  VIW_GOODSINFO B left outer join STO_STORAGE A on A.TENANT_ID=B.TENANT_ID and b.comm not in ('02','12') and A.GODS_ID=B.GODS_ID and A.TENANT_ID="+tenant_id;
			ds.setSQL(sql);	
			rsp.setLocalJson('kc_tj',"库存统计sql:"+sql);
			var dataset = factor.open(ds);
			ds.first();
			var goods_amt = ds.getAsString("GODS_AMT");
			var sto_amt = ds.getAsString("STO_AMT");
			var amount = ds.getAsString("AMOUNT");
			var amoney = ds.getAsString("AMONEY");
			$("#kcqk").html("(经营商品:"+goods_amt+"种,有效商品"+sto_amt+"种,库存数量:"+amount+",库存金额:"+amoney+"元。)");
			ds.eraseDataSet();
		}catch(e){
			alert(e.message);
			ds.eraseDataSet();
			return;
		}
	}	
	
	
	/*************************************************
	 * 盈利统计情况
	 *************************************************
	 */
	function yltjqk(tenant_id){

		try{
			var d = new Date();
			var d2 = d.format('yyyyMMdd');		//今天日期
			d = d.showMonthFirstDay();
			var d1 = d.format('yyyyMMdd');		//本月第一天
			ds.createDataSet();	
		var sql = "select b.TENANT_ID,sum(a.calc_money-a.CALC_AMOUNT*b.new_inprice) as calc_money, sum(case when (b.RELATION_ID=1000006) then (a.CALC_MONEY-a.CALC_AMOUNT*b.new_inprice)  else 0 end ) JY_MONEY,sum(case when (b.RELATION_ID<>1000006) then  (a.CALC_MONEY-a.CALC_AMOUNT*b.new_inprice) else 0 end ) FY_MONEY from VIW_SALESDATA A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID="+tenant_id+" and A.SALES_DATE>="+d1+" and A.SALES_DATE<="+d2+" group by b.TENANT_ID";
			rsp.setLocalJson('yltjqk',"盈利统计sql:"+sql);
			ds.setSQL(sql);
			var dataset = factor.open(ds);
			var flag = ds.locate('TENANT_ID',tenant_id);
			if(flag){
				var calc_money = ds.getAsString("calc_money");
				var jy_money = ds.getAsString("jy_money");
				var fy_money = ds.getAsString("fy_money");
				$("#yltjqk").html("(截止今日，本月盈利"+calc_money+"元，其中卷烟"+jy_money+"元，非烟"+fy_money+"元。)");		
			}else{
				$("#yltjqk").html("截止今日，本月盈利0元，其中卷烟0元，非烟0元。");		
			}
			ds.eraseDataSet();
		}catch(e){
			alert(e.message);
			ds.eraseDataSet();
			return;
		}
	}	