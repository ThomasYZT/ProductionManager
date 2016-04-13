(function($){
	
  $.ajax({
  	type:"get",
    url:"/companies",
    dataType:"json",
    success:function(data){
      init_table(data);
    }
  });

  function init_table(data){
    $("#tTrolleys").dataTable({
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
        {data:'id',"sWidth":"100px",render:function(data,type,full){
          return "<p style='text-align:left'>"+data+"</p>"
        }},
        {data:'title',"sWidth":"100px",render:function(data,type,full){
          return "<p style='text-align:left'>"+data+"</p>"
        }},
        {data:'city_id',"sWidth":"100px",render:function(data,type,full){
          return "<p style='text-align:left'>"+data+"</p>"
        }}
      ]
    })
    $("#tTrolleys_filter input[type=search]").css({ width: "auto" });
    $("#tTrolleys_filter").find("input").wrap('<div class="box-tools"><div class="input-group input-group-sm" style="width:150px;"></div></div>');
    $("#tTrolleys_filter").find(".input-group").append('<div class="input-group-btn"><button type="submit" class="btn btn-default"><i class="fa fa-search"></i></button></div>');  
  }
  
})(jQuery)