	var ds = new dataset();
	$().ready( function() {	
		var jsonObj = JSON.parse(rsp.getUserInfo());
		var tenantId = jsonObj.tenantId;
		jypm_tj(tenantId,0);	//卷烟排名
		jypm_tj(tenantId,1);	//非烟排名
		jyfl_tj(tenantId);		//卷烟分类
		fyfl_tj(tenantId);		//非烟分类
		
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
			ds.setSQL("select * from (select A.GODS_ID,B.GODS_NAME,sum(CALC_MONEY-A.CALC_AMOUNT*B.NEW_INPRICE) as PRF_MONEY from VIW_SALESDATA A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='"+tenant_id+"' and A.SALES_DATE>='"+d1+"' and A.SALES_DATE<='"+d2+"' and B.RELATION_ID"+typeValue+"'1000006' group by A.GODS_ID,B.GODS_NAME) order by PRF_MONEY desc limit 10");
			var dataset = factor.open(ds);
			ds.first();
			var data = "<chart caption='销售数量前五名' xAxisName='' yAxisName='' showValues='0' formatNumberScale='0' useRoundEdges='0' baseFont='宋体' baseFontSize='12' bgColor=''>";			
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
			ds.setSQL("select j.SORT_ID,j.SORT_NAME,ifnull(c.CALC_MONEY,0) as CALC_MONEY from VIW_GOODSSORT j left outer join (select s.TENANT_ID,a.SORT_ID2,sum(s.CALC_MONEY) CALC_MONEY from VIW_SALESDATA s,VIW_GOODSINFO a where s.TENANT_ID=a.TENANT_ID and s.gods_id = a.gods_id and s.TENANT_ID="+tenant_id+" and s.SALES_DATE>="+d1+" and s.SALES_DATE<="+d2+" group by s.TENANT_ID,A.SORT_ID2) c on j.TENANT_ID=c.TENANT_ID and j.SORT_ID=c.SORT_ID2 where j.SORT_TYPE=2 and j.TENANT_ID="+tenant_id+" order by j.SEQ_NO");
			var dataset = factor.open(ds);
			ds.first();
			var data = "<chart caption='销售数量前五名' xAxisName='' yAxisName='' showValues='0' formatNumberScale='0' useRoundEdges='0' baseFont='宋体' baseFontSize='12' bgColor=''>";			
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
			ds.setSQL("select j.TENANT_ID,d.SORT_ID,ifnull(d.SORT_NAME,'无分类') as SORT_NAME,j.CALC_MONEY from (select A.TENANT_ID,substr(C.LEVEL_ID,1,4) as LEVEL_ID,b.RELATION_ID,1 as SORT_TYPE,sum(A.CALC_MONEY) as CALC_MONEY from VIW_SALESDATA A inner join VIW_GOODSINFO B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID left outer join VIW_GOODSSORT C on B.TENANT_ID=C.TENANT_ID and B.SORT_ID1=C.SORT_ID  where A.TENANT_ID="+tenant_id+" and A.SALES_DATE>="+d1+" and A.SALES_DATE<="+d2+" and B.RELATION_ID<>1000006 group by A.TENANT_ID,substr(C.LEVEL_ID,1,4),b.RELATION_ID) j left outer join VIW_GOODSSORT d on j.TENANT_ID=d.TENANT_ID and j.LEVEL_ID=d.LEVEL_ID and j.RELATION_ID=d.RELATION_ID and j.SORT_TYPE=d.SORT_TYPE order by d.SEQ_NO");
			var dataset = factor.open(ds);
			ds.first();
			var data = "<chart caption='销售数量前五名' xAxisName='' yAxisName='' showValues='0' formatNumberScale='0' useRoundEdges='0' baseFont='宋体' baseFontSize='12' bgColor=''>";			
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