(function(){
  var allData;
  var breed = ["start"];
	$.ajax({
    type:"get",
    url:"/dashboard",
    dataType:"json",
    async:false,
    success:function(data){
      allData = data;
    }
  });
  
  var i_contracts = 0;
  var i_transplantNumber = 0;
  var i_purchase = 0;
  var i_area = 0;
  var f_contracts = 0;
  var f_transplantNumber = 0;
  var f_purchase = 0;
  var f_area = 0;

  for(var i=0;i<allData.length;i++){
    if(allData[i].initial_id == null){
      i_contracts += 1;
      i_transplantNumber += parseFloat(allData[i].transplant_number);
      i_purchase += parseFloat(allData[i].purchase);
      i_area += parseFloat(allData[i].cultivated_area);
    }else{
      f_contracts += 1;
      f_transplantNumber += parseFloat(allData[i].transplant_number);
      f_purchase += parseFloat(allData[i].purchase);
      f_area += parseFloat(allData[i].cultivated_area)
    }
    for(var j=0;j<breed.length;j++){
      if(allData[i].breed == breed[j])
        break;
      if(j == breed.length-1){
        breed.push(allData[i].breed);
      }
    }
  }
  
  $(".i_transplantNumber").text(i_transplantNumber);
  $(".i_purchase").text(i_purchase);
  $(".i_contracts").text(i_contracts);
  $(".i_area").text(i_area);
  $(".f_transplantNumber").text(f_transplantNumber);
  $(".f_purchase").text(f_purchase);
  $(".f_contracts").text(f_contracts);
  $(".f_area").text(f_area);

  var transplant_purchase = new CanvasJS.Chart("transplant_purchase",
    {
      title:{
        text: ""    
      },
      animationEnabled: true,
      legend: {
        verticalAlign: "bottom",
        horizontalAlign: "center"
      },
      theme: "theme2",
      data: [

      {        
        type: "column",  
        showInLegend: true, 
        legendMarkerColor: "grey",
        dataPoints: [      
        {y: i_transplantNumber+f_transplantNumber, label: "种植数量"},
        {y: i_purchase+f_purchase,  label: "收购数量" }       
        ]
      }   
      ]
    });
    transplant_purchase.render();

    var success_wait = new CanvasJS.Chart("success_wait",
    {
      title:{
        text: ""    
      },
      animationEnabled: true,
      legend: {
        verticalAlign: "bottom",
        horizontalAlign: "center"
      },
      theme: "theme2",
      data: [

      {        
        type: "column",  
        showInLegend: true, 
        legendMarkerColor: "grey",
        dataPoints: [      
        {y: i_contracts, label: "草签合同数"},
        {y: f_contracts,  label: "正式合同数" }       
        ]
      }   
      ]
    });

    success_wait.render();

})()