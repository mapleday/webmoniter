<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

　<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>AdminLTE 2 | Starter</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->

  <link rel="stylesheet" href="resources/admin-lte/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="resources/admin-lte/Editor-1.6.1/css/editor.dataTables.css">
  <link rel="stylesheet" href="resources/admin-lte/Editor-1.6.1/css/jquery.dataTables.min.css">
  <link rel="stylesheet" href="resources/admin-lte/Editor-1.6.1/css/buttons.dataTables.min.css">
  <link rel="stylesheet" href="resources/admin-lte/Editor-1.6.1/css/select.dataTables.min.css">

  <!-- Font Awesome -->
  <!-- <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css"> -->
  <!-- Ionicons -->
  <!-- <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">-->

  <!-- Theme style -->
  <link rel="stylesheet" href="resources/admin-lte/dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
        page. However, you can choose any other skin. Make sure you
        apply the skin class to the body tag so the changes take effect.
  -->
  <link rel="stylesheet" href="resources/admin-lte/dist/css/skins/skin-blue.min.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>   <![endif]-->
  <!--<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>-->

  <script src="resources/admin-lte/Editor-1.6.1/js/jquery-1.12.4.js"></script>
  <script src="resources/admin-lte/Editor-1.6.1/js/jquery.dataTables.min.js"></script>
  <script src="resources/admin-lte/Editor-1.6.1/js/dataTables.buttons.min.js"></script>
  <script src="resources/admin-lte/Editor-1.6.1/js/dataTables.select.min.js"></script>
  <script src="resources/admin-lte/Editor-1.6.1/js/dataTables.editor.js"></script>

  <script type="text/javascript" class="init">

      var editor; // use a global for the submit and return data rendering in the examples
      $(document).ready(function() {
          //  var editor;
          editor = new $.fn.dataTable.Editor( {
              //ajax: "http://localhost:8080/addhttpResource",
              ajax: {
                  create: {
                      type: 'POST',
                      url:  'addhttpResource',
                      data: function (data) {
                          var result = {};
                          for (var i in data.data) {
                              var result = data.data[i];
                              result.id = i;
                              result.action = data.action;
                          }
                          return result;
                      },

                  },
                  edit: {
                      type: 'POST',
                      url:  'updatehttpResource',
                      data: function (data) {
                          var result = {};
                          for (var i in data.data) {
                              var result = data.data[i];
                              result.id = i;
                              result.action = data.action;
                          }
                          return result;
                      },
                  },
                  remove: {
                      type: 'POST',
                      url:  'deletehttpResource',
                      data: function (data) {
                          var result = {};
                          for (var i in data.data) {
                              var result = data.data[i];
                              result.id = i;
                              result.action = data.action;
                          }
                          return result;
                      },

                  },

              },

              table: "#example",
              idSrc:  'id',
              fields: [ {
                  label: "resourceName:",
                  name: "resourceName"
              }, {
                  label: "resourceAddress:",
                  name: "resourceAddress"
              },{
                  label: "monitorTimeOut:",
                  name: "monitorTimeOut"
              }, {
                  label: "monitorInterval:",
                  name: "monitorInterval"
              }, {
                  label: "monitorTimes:",
                  name: "monitorTimes"
              }, {
                  label: "alarmThresholdTimes:",
                  name: "alarmThresholdTimes"
              }
              ]
          } );


            var table = $('#example').DataTable( {
                dom: "Bfrtip",
                ajax: "getHttpResourcelist",
                "scrollX": true,
                "bAutoWidth": false,//自适应宽度
                "aoColumnDefs": [
                    {
                        "searchable": false,
                        "orderable": false,
                        "targets": 1
                    }, {
                        "targets": 2,
                        "searchable": false,
                        "orderable": false,
                    },
                    {"sWidth": "15%", "aTargets": [0]},
                    {"sWidth": "15%", "aTargets": [1]},
                    {"sWidth": "15%", "aTargets": [2]},
                    {"sWidth": "15%", "aTargets": [3]},
                    {"sWidth": "20%", "aTargets": [4]},
                    {"sWidth": "20%", "aTargets": [5]},
                    {"sWidth": "20%", "aTargets": [6]},
                ],
                columns: [
                    { data: "id"},
                    { data: "resourceName" },
                    { data: "resourceAddress"} ,
                    { data: "monitorTimeOut" },
                    { data: "monitorInterval" },
                    { data: "monitorTimes" },
                    { data: "alarmThresholdTimes" }
                ],

                select: true,
                buttons: [
                    { extend: "create", text:"新增",editor: editor },
                    { extend: "edit",  text:"修改", editor: editor },
                    { extend: "remove",  text:"删除",editor: editor }
                ]
            } );

          editor.on('postSubmit', function (e,o,action) {
              //console.log(e);
              if(o.responseText!='remove') {
                  var resourceName = editor.field('resourceName');
                  var resourceAddress = editor.field('resourceAddress');
                  var monitorTimeOut = editor.field('monitorTimeOut');
                  var monitorInterval = editor.field('monitorInterval');
                  var monitorTimes = editor.field('monitorTimes');
                  var alarmThresholdTimes = editor.field('alarmThresholdTimes');

                  if (!resourceName.val() || !resourceAddress.val()|| !monitorTimeOut.val()|| !monitorInterval.val()|| !monitorTimes.val()|| !alarmThresholdTimes.val()) {
                      if (!resourceName.val()) {
                          resourceName.error('resourceName must be given');
                      }
                      if (!resourceAddress.val()) {
                          resourceAddress.error('resourceAddress must be given');
                      }
                      if (!monitorTimeOut.val()) {
                          monitorTimeOut.error('monitorTimeOut must be given');
                      }
                      if (!monitorInterval.val()) {
                          monitorInterval.error('monitorInterval must be given');
                      }
                      if (!monitorTimes.val()) {
                          monitorTimes.error('monitorTimes must be given');
                      }
                      if (!alarmThresholdTimes.val()) {
                          alarmThresholdTimes.error('alarmThresholdTimes must be given');
                      }

                  } else {
                      console.log("have edit...");
                      editor.close();
                      table.ajax.reload(null, false);
                  }
              }else {
                  editor.close();
                  table.ajax.reload(null, false);
              }
          });
      } );

  </script>
</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
  <header class="main-header">

    <!-- Logo -->
    <a href="index2.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>A</b>LT</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>Admin</b>LTE</span>
    </a>

    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- Messages: style can be found in dropdown.less-->
          <li class="dropdown messages-menu">
            <!-- Menu toggle button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-envelope-o"></i>
              <span class="label label-success">4</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 4 messages</li>
              <li>
                <!-- inner menu: contains the messages -->
                <ul class="menu">
                  <li><!-- start message -->
                    <a href="#">
                      <div class="pull-left">
                        <!-- User Image -->
                        <img src="resources/admin-lte/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                      </div>
                      <!-- Message title and timestamp -->
                      <h4>
                        Support Team
                        <small><i class="fa fa-clock-o"></i> 5 mins</small>
                      </h4>
                      <!-- The message -->
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <!-- end message -->
                </ul>
                <!-- /.menu -->
              </li>
              <li class="footer"><a href="#">See All Messages</a></li>
            </ul>
          </li>
          <!-- /.messages-menu -->

          <!-- Notifications Menu -->
          <li class="dropdown notifications-menu">
            <!-- Menu toggle button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-bell-o"></i>
              <span class="label label-warning">10</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 10 notifications</li>
              <li>
                <!-- Inner Menu: contains the notifications -->
                <ul class="menu">
                  <li><!-- start notification -->
                    <a href="#">
                      <i class="fa fa-users text-aqua"></i> 5 new members joined today
                    </a>
                  </li>
                  <!-- end notification -->
                </ul>
              </li>
              <li class="footer"><a href="#">View all</a></li>
            </ul>
          </li>
          <!-- Tasks Menu -->
          <li class="dropdown tasks-menu">
            <!-- Menu Toggle Button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-flag-o"></i>
              <span class="label label-danger">9</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 9 tasks</li>
              <li>
                <!-- Inner menu: contains the tasks -->
                <ul class="menu">
                  <li><!-- Task item -->
                    <a href="#">
                      <!-- Task title and progress text -->
                      <h3>
                        Design some buttons
                        <small class="pull-right">20%</small>
                      </h3>
                      <!-- The progress bar -->
                      <div class="progress xs">
                        <!-- Change the css width attribute to simulate progress -->
                        <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">20% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  <!-- end task item -->
                </ul>
              </li>
              <li class="footer">
                <a href="#">View all tasks</a>
              </li>
            </ul>
          </li>
          <!-- User Account Menu -->
          <li class="dropdown user user-menu">
            <!-- Menu Toggle Button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <!-- The user image in the navbar-->
              <img src="resources/admin-lte/dist/img/user2-160x160.jpg" class="user-image" alt="User Image">
              <!-- hidden-xs hides the username on small devices so only the image appears. -->
              <span class="hidden-xs">Alexander Pierce</span>
            </a>
            <ul class="dropdown-menu">
              <!-- The user image in the menu -->
              <li class="user-header">
                <img src="resources/admin-lte/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">

                <p>
                  Alexander Pierce - Web Developer
                  <small>Member since Nov. 2012</small>
                </p>
              </li>
              <!-- Menu Body -->
              <li class="user-body">
                <div class="row">
                  <div class="col-xs-4 text-center">
                    <a href="#">Followers</a>
                  </div>
                  <div class="col-xs-4 text-center">
                    <a href="#">Sales</a>
                  </div>
                  <div class="col-xs-4 text-center">
                    <a href="#">Friends</a>
                  </div>
                </div>
                <!-- /.row -->
              </li>
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left">
                  <a href="#" class="btn btn-default btn-flat">Profile</a>
                </div>
                <div class="pull-right">
                  <a href="#" class="btn btn-default btn-flat">Sign out</a>
                </div>
              </li>
            </ul>
          </li>
          <!-- Control Sidebar Toggle Button -->
          <li>
            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
          </li>
        </ul>
      </div>
    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

      <!-- Sidebar user panel (optional) -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="resources/admin-lte/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p>Alexander Pierce</p>
          <!-- Status -->
          <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
        </div>
      </div>

      <!-- search form (Optional) -->
      <form action="#" method="get" class="sidebar-form">
        <div class="input-group">
          <input type="text" name="q" class="form-control" placeholder="Search...">
              <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
        </div>
      </form>
      <!-- /.search form -->

      <!-- Sidebar Menu -->
      <ul class="sidebar-menu">
        <li class="header">HEADER</li>
        <!-- Optionally, you can add icons to the links -->
        <li class="active"><a href="#example"><i class="fa fa-circle-o"></i> <span>Link 123</span></a></li>
        <li><a href="#mqttmonitor"><i class="fa fa-link"></i> <span>Another Link 456</span></a></li>
        <li><a href="#notify"><i class="fa fa-link"></i> <span>Another Link 456</span></a></li>
        <li><a href="#redismeta"><i class="fa fa-link"></i> <span>Another Link 456</span></a></li>
        <li><a href="#timeoutapi"><i class="fa fa-link"></i> <span>Another Link 456</span></a></li>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>Multilevel</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="test.html">Link in level 2</a></li>
            <li><a href="#">Link in level 2</a></li>
          </ul>
        </li>
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>     Header...

        <small>Optional description</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
<!--
      <input type="button" value="增加资源"  onclick="javascript:alert('00')"/><br/>
        <table  id="table1" class="table table-striped table-bordered" cellspacing="0" width="100%">
          <tr>
              <td>资源ID：</td>
              <td>资源名称： </td>
              <td>监控资源超时时间： </td>
              <td>监控间隔：</td>
              <td>监控次数：</td>
              <td>报警阀值：</td>
              <td>操作 </td>
          </tr>
          <c:forEach var="httpResource" items="${httpResourcelist}">
          <tr>
            <td><c:out value='${httpResource.id}'/></td>
            <td><c:out value='${httpResource.resourceName}'/></td>
            <td><c:out value='${httpResource.monitorTimeOut}'/></td>
            <td><c:out value='${httpResource.monitorInterval}'/></td>
            <td><c:out value='${httpResource.monitorTimes}'/></td>
            <td><c:out value='${httpResource.alarmThresholdTimes}'/></td>
            <td><a href="">修改</a>/<a href="">删除</a></td>
          </tr>

        </c:forEach>
        </table>
-->

      <table id="example" class="display dataTable" cellspacing="0">
        <thead>
        <tr>
          <th>id</th>
          <th>resourceName</th>
          <th>resourceAddress</th>
          <th>monitorTimeOut</th>
          <th>monitorInterval</th>
          <th>monitorTimes</th>
          <th>alarmThresholdTimes</th>
        </tr>
        </thead>
      </table>
      <!-- Your Page Content Here -->

    </section>
    <section class="content">

      <table id="mqttmonitor" class="display dataTable" cellspacing="0">
      </table>


    </section>
    <section class="content">

      <table id="notify" class="display dataTable" cellspacing="0">
      </table>


    </section>
    <section class="content">

      <table id="redismeta" class="display dataTable" cellspacing="0">
      </table>


    </section>
    <section class="content">

      <table id="timeoutapi" class="display dataTable" cellspacing="0">
      </table>


    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <footer class="main-footer">
    <!-- To the right -->
    <div class="pull-right hidden-xs">
      Anything you want
    </div>
    <!-- Default to the left -->
    <strong>Copyright &copy; 2016 <a href="#">Company</a>.</strong> All rights reserved.
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane active" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">Recent Activity</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                <p>Will be 23 on April 24th</p>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">Tasks Progress</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <h4 class="control-sidebar-subheading">
                Custom Template Design
                <span class="pull-right-container">
                  <span class="label label-danger pull-right">70%</span>
                </span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->
      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 2.2.3 -->
<!-- <script src="resources/admin-lte/plugins/jQuery/jquery-2.2.3.min.js"></script>-->
<!-- Bootstrap 3.3.6 -->
<script src="resources/admin-lte/bootstrap/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="resources/admin-lte/dist/js/app.js"></script>

<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. Slimscroll is required when using the
     fixed layout. -->


</body>
</html>
