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
			var sql = "select A.GODS_ID,B.GODS_NAME,sum(A.PRF_MONEY) as PRF_MONEY from VIW_SALESDATA A,PUB_GOODSINFO B where A.GODS_ID=B.GODS_ID and A.TENANT_ID="+tenant_id+" and A.SALES_DATE>="+d1+" and A.SALES_DATE<="+d2+" and B.TENANT_ID"+typeValue+"110000001 group by A.GODS_ID,B.GODS_NAME";
			//取前十条数据,根据不同数据库进行取数
			sql = rsp.fechTopResults(sql,10,'PRF_MONEY desc');
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
			var sql = "select j.SORT_ID,j.SORT_NAME,ifnull(c.CALC_MONEY,0) as CALC_MONEY from (select SORT_ID,SORT_NAME,SEQ_NO from PUB_GOODSSORT WHERE TENANT_ID=110000001 and SORT_TYPE=2) j left outer join (select a.SORT_ID2,sum(s.CALC_MONEY) CALC_MONEY from VIW_SALESDATA s,PUB_GOODSINFO a where s.gods_id = a.gods_id and s.TENANT_ID="+tenant_id+" and s.SALES_DATE>="+d1+" and s.SALES_DATE<="+d2+" and A.TENANT_ID=110000001 group by a.SORT_ID2) c on j.SORT_ID=c.SORT_ID2  order by j.SEQ_NO";
			sql = rsp.parseSQL(sql);
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
			var sql = "select A.TENANT_ID,C.SORT_ID,COALESCE(C.SORT_NAME,'无分类') AS SORT_NAME,SUM(A.CALC_MONEY) AS CALC_MONEY from VIW_SALESDATA A inner join VIW_GOODSINFO B on A.TENANT_ID = B.TENANT_ID and A.GODS_ID = B.GODS_ID left outer join VIW_GOODSSORT C on B.TENANT_ID = C.TENANT_ID and B.SORT_ID1 = C.SORT_ID and C.SORT_TYPE = 1 where A.TENANT_ID = "+tenant_id+" and A.SALES_DATE >= "+d1+" and A.SALES_DATE <= "+d2+" and B.RELATION_ID <> 1000006 GROUP BY A.TENANT_ID,C.SORT_ID,C.SORT_NAME";
			sql = rsp.parseSQL(sql);
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
			var sql = "select SALES_DATE,CALC_AMOUNT,JY_MONEY,FY_MONEY,round((JY_MONEY*1.0/(JY_MONEY+FY_MONEY)*100),1) as jyzb from (select a.SALES_DATE,sum(case when (b.TENANT_ID=110000001) then a.CALC_MONEY  else 0 end) JY_MONEY,sum(case when (b.TENANT_ID<>110000001) then a.CALC_MONEY else 0 end) FY_MONEY,sum(case when (b.TENANT_ID=110000001) then a.CALC_AMOUNT else 0 end) CALC_AMOUNT from VIW_SALESDATA a,PUB_GOODSINFO b where a.GODS_ID=b.GODS_ID and a.TENANT_ID="+tenant_id+" and a.SALES_DATE="+d1+" group by a.SALES_DATE) j";
			ds.setSQL(sql);
			var dataset = factor.open(ds);
			var flag = ds.locate('SALES_DATE',d1);
			if(flag){
				var amount = ds.getAsString("calc_amount");
				var jy_money = ds.getAsString("jy_money");
				var fy_money = ds.getAsString("fy_money");
				var jyzb = ds.getAsString("jyzb");
				$("#tjqk").html("(今日销售卷烟"+amount+"盒，总计"+jy_money+"元，非烟"+fy_money+"元，其中烟类占比"+jyzb+"%。)");		
			}else{
				$("#tjqk").html("今日销售卷烟0盒，总计0元，非烟0元，其中烟类占比0%。");		
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
			var sql = "select case when (b.TENANT_ID=110000001) then 1000006 else 0 end as relation_id,count(distinct a.GODS_ID) as amount,sum(case b.SMALLTO_CALC when ifnull(b.SMALLTO_CALC,1) then CALC_AMOUNT/b.SMALLTO_CALC else CALC_AMOUNT end) as jy_amount,sum(a.CALC_MONEY) as jy_money from VIW_STOCKDATA a,PUB_GOODSINFO b where a.GODS_ID=b.GODS_ID and a.TENANT_ID="+tenant_id+" and a.STOCK_DATE>="+d1+" and a.STOCK_DATE<="+d2+" group by case when (b.TENANT_ID=110000001) then 1000006 else 0 end";
			sql = rsp.parseSQL(sql);
			ds.setSQL(sql);
			var dataset = factor.open(ds);
			var amount = 0;
			var jy_amount = 0;
			var jy_money = 0;
			var fy_amount = 0;
			var fy_money = 0;
			var flag = ds.locate('relation_id',1000006);		//定位卷烟商品
			if(flag){
				amount = ds.getAsString("amount");
				jy_amount = ds.getAsString("jy_amount");
				jy_money = ds.getAsString("jy_money");
			}
			flag = ds.locate('relation_id',0);		//定位非烟商品
			if(flag){
				fy_amount = ds.getAsString("amount");
				fy_money = ds.getAsString("jy_money");
			}			
			$("#jhtjqk").html("(本周进货"+amount+"种卷烟，共计"+jy_amount+"条，金额"+jy_money+"元；进货非烟"+fy_amount+"种，共计"+fy_money+"元。)");		
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
			var sql = "select COUNT(DISTINCT B.GODS_ID) AS GODS_AMT,COUNT(DISTINCT A.GODS_ID) AS STO_AMT,SUM(A.AMOUNT) AS AMOUNT,SUM(A.AMOUNT * B.NEW_OUTPRICE) AS AMONEY from VIW_GOODSINFO B left outer join STO_STORAGE A on B.TENANT_ID = A.TENANT_ID and B.GODS_ID = A.GODS_ID where B.COMM NOT IN ('02','12') and B.TENANT_ID = "+tenant_id;
			ds.setSQL(sql);	
			var dataset = factor.open(ds);
			ds.first();
			var goods_amt = ds.getAsString("GODS_AMT");
			var sto_amt = ds.getAsString("STO_AMT");
			var amount = ds.getAsString("AMOUNT");
			var amoney = ds.getAsString("AMONEY");
			$("#kcqk").html("(当前经营商品:"+goods_amt+"种,其中有效商品"+sto_amt+"种,总库存数量:"+amount+",库存金额:"+amoney+"元。)");
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
			var sql = "select a.TENANT_ID,sum(a.PRF_MONEY) as CALC_MONEY,sum(case when (b.TENANT_ID=110000001) then (a.PRF_MONEY) else 0 end ) JY_MONEY,sum(case when (b.TENANT_ID<>110000001) then (a.PRF_MONEY) else 0 end ) FY_MONEY from VIW_SALESDATA A,PUB_GOODSINFO B where A.GODS_ID=B.GODS_ID and A.TENANT_ID="+tenant_id+" and A.SALES_DATE>="+d1+" and A.SALES_DATE<="+d2+" group by a.TENANT_ID";
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