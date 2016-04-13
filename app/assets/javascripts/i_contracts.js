(function($){
	var i_contracts_app = angular.module("i_contracts_app",["i_contracts_services","i_contracts_directives"])
    .controller("indexCtrl",["$scope","getiData",function($scope,getiData){
      $scope.iData = getiData.iData;
      $scope.contracts = $scope.iData.contracts;
      $scope.party_as = $scope.iData.party_as;
      $scope.party_bs = $scope.iData.party_bs;

      for(var i=0;i<$scope.contracts.length;i++){
        for(var j=0;j<$scope.party_as.length;j++){
          if($scope.contracts[i].party_a_id == $scope.party_as[j].id){
            $scope.contracts[i].party_a = $scope.party_as[j];
          }
        }

        for(var j=0;j<$scope.party_bs.length;j++){
          if($scope.contracts[i].party_b_id == $scope.party_bs[j].id){
            $scope.contracts[i].party_b = $scope.party_bs[j];
          }
        }
      }
      var table = init_table($scope.contracts);

      $('#tTrolleys tbody').find("tr").mouseover(function(){
        $(this).addClass('selected');
      }).mouseout(function(){
        $(this).removeClass('selected');
      }).click(function(){
        $("#alertModal").modal("toggle");
        var now_contract = $scope.now_contract = table.row(this).data();
        var element  = angular.element($("#myDatagrid"));
        var scope = element.scope();
        scope.$apply(function(){
          $scope.now_contract = now_contract;
        });
      });

      $(".search").click(function(){
        $(".details").remove();
        var datetime = $("#reservation").val();
        if(datetime != ""){
          table.search(datetime).draw();
          var tbody_tr = $("#tTrolleys tbody").find("tr");
          var contracts = tbody_tr.length;
          var transplantNumber = 0;
          var purchase = 0;
          var area = 0;
          for(var i=0;i<tbody_tr.length;i++){
            var o = table.row(tbody_tr[i]).data();
            transplantNumber += parseFloat(o.transplant_number);
            area += parseFloat(o.cultivated_area);
            purchase += parseFloat(o.purchase);
          }
          $(".statistic").append('<div class="box-body details"><p>'+
                                 '<span class="text-green">'+datetime+'合同数：</span>'+contracts+
                                 '&nbsp;&nbsp;<span class="text-green">种植数量:</span>'+transplantNumber+
                                 '&nbsp;&nbsp;<span class="text-light-blue">种植面积:</span>'+area+
                                 '&nbsp;&nbsp;<span class="text-muted">收购数量:</span>'+purchase+
                                 '</p></div>');
          
        }else{
          table.search("").draw();
          $(".statistic").append('<div class="box-body details"><p>请选择日期后再搜索</p></div>');
        }
        
      });

    }])
    .filter('datefilter2', function(){
      return function(item){
        var o = item.slice(0,10).split("-");
        item = o[0]+"年"+o[1]+"月"+o[2]+"日";
        return item;
      }
    });

  var i_contracts_services = angular.module("i_contracts_services",[])
    .factory("getiData",function(){
      var iData;
      $.ajax({
        type:"get",
        url:"/i_contracts",
        dataType:"json",
        async:false,
        success:function(data){
          iData = data;
        }
      });
      return {
        iData:iData
      }
    });

  var i_contracts_directives = angular.module("i_contracts_directives",[]);

  function init_table(data){
    var table = $("#tTrolleys").DataTable({
      paging: true,//分页
      ordering: false,//是否启用排序
      searching: true,//搜索
      language: {
        lengthMenu: '<select style="width:150px;" class="form-control input-xsmall">' + '<option value="1">1</option>' + '<option value="10">10</option>' + '<option value="20">20</option>' + '<option value="30">30</option>' + '<option value="40">40</option>' + '<option value="50">50</option>' + '</select> 条记录',//左上角的分页大小显示。
        search: '',//右上角的搜索文本，可以写html标签
        paginate: {//分页的样式内容。
          previous: "上一页",
          next: "下一页",
          first: "第一页",
          last: "最后"
        },
        zeroRecords: "没有内容",//table tbody内容为空时，tbody的内容。
        //下面三者构成了总体的左下角的内容。
        info: "总共_PAGES_ 页，显示第_START_ 到第 _END_ ，筛选之后得到 _TOTAL_ 条，初始_MAX_ 条 ",//左下角的信息显示，大写的词为关键字。
        infoEmpty: "0条记录",//筛选为空时左下角的显示。
        infoFiltered: ""//筛选之后的左下角筛选提示，
      },
      pagingType: "full_numbers",//分页样式的类型
      sScrollY: "100%",
      data:data,
      columns:[
        {data:'contract_no',render:function(data,type,full){
          return "<p style='text-align:left'>"+data+"</p>"
        }},  
        {data:'created_at',render:function(data,type,full){
          data = data.slice(0,10);
          return "<p style='text-align:left'>"+data+"</p>"
        }},
        {data:'party_a',render:function(data,type,full){
          return "<p style='text-align:left'>"+data.company+"</p>"
        }},
        {data:'party_a',render:function(data,type,full){
          return "<p style='text-align:left'>"+data.city+"</p>"
        }},
        {data:'party_b',render:function(data,type,full){
          return "<p style='text-align:left'>"+data.name+"</p>"
        }},
        {data:'party_b',render:function(data,type,full){
          return "<p style='text-align:left'>"+data.phone+"</p>"
        }}           
      ]
    })
    $("#tTrolleys_filter input[type=search]").css({ width: "auto" });
    $("#tTrolleys_filter").find("input").wrap('<div class="box-tools"><div class="input-group input-group-sm" style="width:150px;"></div></div>');
    $("#tTrolleys_filter").find(".input-group").append('<div class="input-group-btn"><button type="submit" class="btn btn-default"><i class="fa fa-search"></i></button></div>');  
    return table;
  }
  
})(jQuery)

