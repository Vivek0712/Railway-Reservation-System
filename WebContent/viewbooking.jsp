
    
<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="Chameleon Admin is a modern Bootstrap 4 webapp &amp; admin dashboard html template with a large number of components, elegant design, clean and organized code.">
    <meta name="keywords" content="admin template, Chameleon admin template, dashboard template, gradient admin template, responsive admin template, webapp, eCommerce dashboard, analytic dashboard">
    <meta name="author" content="ThemeSelect">
    <title>View Bookings</title>
   <link rel="icon" type="image/png" href="images/icons/train.png"/>
    <link href="https://fonts.googleapis.com/css?family=Muli:300,300i,400,400i,600,600i,700,700i%7CComfortaa:300,400,700" rel="stylesheet">
    <link href="https://maxcdn.icons8.com/fonts/line-awesome/1.1/css/line-awesome.min.css" rel="stylesheet">
    <!-- BEGIN VENDOR CSS-->
    <link rel="stylesheet" type="text/css" href="theme-assets/css/vendors.css">
    <!-- END VENDOR CSS-->
    <!-- BEGIN CHAMELEON  CSS-->
    <link rel="stylesheet" type="text/css" href="theme-assets/css/app-lite.css">
    <!-- END CHAMELEON  CSS-->
    <!-- BEGIN Page Level CSS-->
    <link rel="stylesheet" type="text/css" href="theme-assets/css/core/menu/menu-types/vertical-menu.css">
    <link rel="stylesheet" type="text/css" href="theme-assets/css/core/colors/palette-gradient.css">
    <!-- END Page Level CSS-->
    <!-- BEGIN Custom CSS-->
    <!-- END Custom CSS-->
    <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
    <script type="text/javascript">
    
    $(document).ready(function(){
    	
    	
		$("#results").hide();
			
				$.ajax({
				 	type: "post",
				 	url: "viewbooking",
				 	datatype: "text",
				 	success:  function(data){
				 		
				 		$("#results").show();
				 		
				 		var pnr=0;
				 		$.each(JSON.parse(data), function(index, itemData) {
							if(itemData!=null){
								
								if(pnr != itemData.pnr_no){
									pnr = itemData.pnr_no;
									var currentdate = new Date();
									var today = currentdate.getDate();
									var dd = '<div class="row">';
									dd = dd+'<div class="col-12">';
									dd=dd+'<div class="card">';									
									dd= dd+ '<div class="card-content collapse show">';
									dd=dd+'<div class="card-body">';
									if(itemData.jdate > today && itemData.status!="CAN")
										dd = dd + '<div class="text-right"> <input type="button" class="btn btn-danger btn-min-width mr-1 mb-1 text-right cancel" id="'+pnr+'" style="align : right;" value="Cancel Ticket"/></div>';
									
									
									dd = dd+"<h5>PNR NUMBER: "+itemData.pnr_no+"</h5><br/> Train : "+ itemData.train_name + "("+itemData.train_no+")<br/>Source Station : "+itemData.source_station_name+"("+itemData.source_station_code+")"; 
									dd = dd + "Class :"+itemData.cls+"<br/>";
									dd = dd + "Destination Station : "+itemData.dest_station_name+"("+itemData.dest_station_code+")<br/>";
									dd = dd + "Journey date : "+itemData.jdate+ "/06/2019<br/>"
									dd = dd+ "Booked By : "+itemData.user+" on "+itemData.booked_date+"/06/2019<br/>";
									dd = dd+ "Total Number of tickets : "+itemData.no_of_tickets+ " Fare : Rs."+itemData.fare+""; 
									
									dd= dd+'<details>'; 
									dd = dd+ '<summary><h5>Passenger Details</h5>';
									dd = dd+'</summary>';
									
									dd= dd+'<table class="table table-bordered mb-0">';
									dd = dd + '<thead>';
									dd =dd+'<tr>';
									dd = dd+'<tr>'	;
									dd = dd+'<th>Passenger Name</th>';
									dd = dd+'<th>Age</th>';
									dd = dd+'<th>Gender</th>';
									dd = dd+'<th>Status</th>';
									dd = dd+'<th>Seat#</th>';
									dd = dd+'	</tr>';
									dd = dd+'</thead>';
									dd = dd+'<tbody id="fill'+pnr+'">';
									dd= dd+"</tbody>";
									dd=dd + "</table>";
									dd = dd+"</div></div></div></div></div>";
									
									dd = dd+'</details>';
									
									$("#results").append(dd);
								}	
								if(pnr ==  itemData.pnr_no){
									
								var pdata = "<tr><td>"+itemData.pname+"</td><td>"+itemData.age+"</td><td>"+itemData.gen+"</td><td>"+itemData.status+"</td><td>"+itemData.seat+"";
								
								$("#fill"+pnr).append(pdata);
								}
							}
							
						});
				 		
				 		$('.cancel').click(function(event){  
				    	var id= event.target.id;
				    		$.ajax({
				    			type: "post",
							 	url: "cancelticket",
							 	datatype: "text",
							 	data : {cancelpnr: id},
							 	success: function(data){
							 		alert("Ticket has been succesfully cancelled");
							 		setTimeout(function(){// wait for 5 secs(2)
							            location.reload(); // then reload the page.(3)
							       }, 1000); 
							 		
							 	}
				    		
				    			
				    		
				    		});
				    		
				    	}); 
				    	
				 	}
					 	
		 		});
				
				
			
			
	});
    </script>
     </head>
  <body class="vertical-layout vertical-menu 2-columns   menu-expanded fixed-navbar" data-open="click" data-menu="vertical-menu" data-color="bg-gradient-x-purple-blue" data-col="2-columns">

    <!-- fixed-top-->
    <nav class="header-navbar navbar-expand-md navbar navbar-with-menu navbar-without-dd-arrow fixed-top navbar-semi-light">
      <div class="navbar-wrapper">
        <div class="navbar-container content">
          <div class="collapse navbar-collapse show" id="navbar-mobile">
           
          </div>
        </div>
      </div>
    </nav>

    <!-- ////////////////////////////////////////////////////////////////////////////-->


    <div class="main-menu menu-fixed menu-light menu-accordion    menu-shadow " data-scroll-to-active="true" data-img="theme-assets/images/backgrounds/02.jpg">
      <div class="navbar-header">
        <ul class="nav navbar-nav flex-row">       
          <li class="nav-item mr-auto"><a class="navbar-brand" href="index.html"><img class="brand-logo" alt="Chameleon admin logo" src="images/icons/train.png"/>
              <h3 class="brand-text">Indian Railway</h3></a></li>
          <li class="nav-item d-md-none"><a class="nav-link close-navbar"><i class="ft-x"></i></a></li>
        </ul>
      </div>
      <div class="main-menu-content">
        <ul class="navigation navigation-main" id="main-menu-navigation" data-menu="menu-navigation">
          <li class="nav-item"><a href="homepage.jsp"><i class="ft-tablet"></i><span class="menu-title" data-i18n="">Book Ticket</span></a>
          </li>
          <li class="nav-item"><a href="pnr.jsp"><i class="ft-trending-up"></i><span class="menu-title" data-i18n="">Check PNR Status</span></a>
          </li>
          <li class=" active"><a href="viewbooking.jsp"><i class="ft-eye"></i><span class="menu-title" data-i18n="">View Bookings</span></a>
          </li>
                 </ul>
    </div>
      <div class="navigation-background"></div>
    </div>

    <div class="app-content content">
      <div class="content-wrapper">
        <div class="content-wrapper-before"></div>
        <div class="content-header row">
          <div class="content-header-left col-md-4 col-12 mb-2">
            <h3 class="content-header-title">View Bookings</h3>
          </div>
          <div class="content-header-right col-md-8 col-12">
            <div class="breadcrumbs-top float-md-right">
               <div class="breadcrumb-wrapper mr-1">
                <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a href="index.html">Home</a>
                  </li>
                  <li class="breadcrumb-item-active" > - View Bookings
                  </li>
                 
                </ol>
                 <%
              HttpSession sess= request.getSession();
           	 	out.write(" <h3 class='content-header-title'>Hello ");
           	 	if(sess.getAttribute("username")== null)
           	 	out.write("Guest User !");
           	 	else
           	 	out.write(sess.getAttribute("username")+"!");
           %>
           <form action="logout">
                <div> <input type="submit" class="btn btn-danger btn-min-width mr-1 mb-1" id="logout" value="Logout"/></div>
             	</form>
           
              </div>
            </div>
          </div>
        </div>
       
        <div id="results">
       	
       </div>
        
      </div>
      </div>
      
    <% 
 	HttpSession sess1= request.getSession();
	if(sess1.getAttribute("username")== null)
	{
		response.sendRedirect("index.jsp");
	}

	%>
         <!-- BEGIN VENDOR JS-->
    <script src="theme-assets/vendors/js/vendors.min.js" type="text/javascript"></script>
    <!-- BEGIN VENDOR JS-->
    <!-- BEGIN PAGE VENDOR JS-->
    <!-- END PAGE VENDOR JS-->
    <!-- BEGIN CHAMELEON  JS-->
    <script src="theme-assets/js/core/app-menu-lite.js" type="text/javascript"></script>
    <script src="theme-assets/js/core/app-lite.js" type="text/javascript"></script>
    <!-- END CHAMELEON  JS-->
    <!-- BEGIN PAGE LEVEL JS-->
    <!-- END PAGE LEVEL JS-->
  </body>
</html>