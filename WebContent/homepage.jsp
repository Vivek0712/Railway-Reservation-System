<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="Chameleon Admin is a modern Bootstrap 4 webapp &amp; admin dashboard html template with a large number of components, elegant design, clean and organized code.">
    <meta name="keywords" content="admin template, Chameleon admin template, dashboard template, gradient admin template, responsive admin template, webapp, eCommerce dashboard, analytic dashboard">
    <meta name="author" content="ThemeSelect">
    <title>HomePage</title>
    <link rel="icon" type="image/png" href="images/icons/train.png"/>
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
 	var allocid=0;
 	var booked_train_no;
 	var booked_source;
 	var src_code;
 	var dest_code;
 	var booked_dest;
 	var booked_cls;
 	var array= [];
 	var plist = [];
 	var curr_avail = [];
 	$(document).on("click", ".rem", function(event){
 		var id = event.target.id;
 		console.log(id[3]);
		$("#"+id[3]).hide();
		var count = Number($("#no-passengers").attr('value')) ;
		$("#no-passengers").attr('value',count-1);
		
		
		var index = array.indexOf(Number(id[3]));
		if (index > -1) {
		  array.splice(index, 1);
		}
		
		
		 
 	});
 	
 	
 	
 	$(document).ready(function(){
 		
 		/*
 		
 		$(function () {
 		    $('#journeydate').datepicker({
 		        
 		        showButtonPanel: true,
 		        changeMonth: true,
 		        changeYear: true,
 		        minDate: 0,
 		        inline: true
 		    });
 		});
 		
 		*/
 		
 		$('#conf-book').click(function(event){
 			alert("Your Booking is confirmed")
			var no_of_tickets = Number($("#no-passengers").attr('value'));
			var currentdate = new Date();
			var date_of_booking = currentdate.getDate();
			var cls = $("#cls option:selected").text();
			
			console.log(cls);
			
				$.each(array, function(index,value){
					var p_array = []
					var pname = $("#pname"+value).val();
					var page = $("#page"+value).val();
					var pgen = $("input[name='gen"+value+"']:checked").val()
					
					p_array.push(pname);
					p_array.push(page);
					p_array.push(pgen);
					
					plist.push(p_array);
					
					
					/*console.log($("#pname"+value).val());
				  	console.log($("#page"+value).val());
				  	console.log($("input[name='gen"+allocid+"']:checked").val());*/
					
				})	;
				var stat;
				if(cls=="1A"){
					stat =  curr_avail[0];
				}
				else if (cls=="2A"){
					stat =  curr_avail[1];
				}
				else if (cls=="3A"){
					stat =  curr_avail[2];
				}
				else
				{
					stat = curr_avail[3];
				}
				var jdate = $("#journeydate").val();
			var to_data = "{train_no :  "+booked_train_no+", no_of_tickets : "+no_of_tickets+", date :"+date_of_booking+", booked_class :"+cls+", plist: ["+plist+"],curr_status : "+stat+",booked_source :"+src_code+",booked_dest: "+dest_code+", jdate : "+ jdate+"}";
			console.log(to_data);
			$.ajax({
		 	type: "post",
		 	url: "confBooking",
		 	data: to_data ,
		 	datatype: "text",
		 	success:  function(){
		 		
		 		console.log("booking req");
		 	}
			 	
 		});
		});
 		
 		
 		$("#details").show();
 		$("#results").show();
 		$("#book").hide();
 		
 	$("#fetch").click(function(){
 		$("#results").empty();
 	var form = $('#fetchdetails');
 	$.ajax({
 	type: "post",
 	url: "getTrainDetails",
 	data: form.serialize(),
 	datatype: "text",
	success : function(data){
		
		 
		var i=0;
		var flag=0;
		
		$.each(data, function(index, itemData) {
			
			if(itemData!=null){
				flag=1;
			var res = "<div class='card text-center' id='"+i+"'><div class='card-body'> <h3 class='card-title'>"+itemData.train_name+"("+itemData.train_no+")</h3> <h5 class='card-text'>"+itemData.source_station_name+"("+itemData.source_station_code+") ------------------- "+itemData.dest_station_name+"("+itemData.source_station_code+")</h5><br/><button  class='but btn btn-primary' id='"+i+"'>Check Availability</button ></div></div>";
			$("#results").append(res);}
			else
			{
				if(flag==0)
				{
					var res = "<div class='card text-center'><div class='card-body'><h3 class='card-title'>No trains found!</h3></div></div>"
						$("#results").append(res);
						flag=1;
				}
			}
			
			i++;
		});
		$('#back').click(function(event){
 			$("#details").show();
 	 		$("#results").show();
 	 		$("#book").hide();
 		});
		
		
		
		$('.ticket').click(function(event){
			var count = Number($("#no-passengers").attr('value')) ;
			if($("#no-passengers").attr('value')== 6 ){
				$(".ticket").hide();
			}
			else{
				allocid = allocid+1;
				array.push(allocid);
			$("#no-passengers").attr('value',count+1 ) ;
			console.log(allocid);
 			var passform= '<div class="pass-form ssscol-lg-4 col-md-12" id='+allocid+'> '+
			'<div class="card text-center"> '+
			'<div class="card-body">'+
				'<h4 class="card-title">Passenger Details</h4>'+
				
				'<p class="mt-2">Passenger Name: </h5><input type="text"  class="form-control" id="pname'+allocid+'"/></p>'+
				'<p class="mt-2">Age : <input type="number" min="1" class="form-control" id="page'+allocid+'"/></p>'+
				'<p class="mt-2">Gender : Male<input type="radio" name="gen'+allocid+'" value="M" id="pgen'+allocid+'" selected/> Female<input type="radio" name="gen'+allocid+'" value ="F"/></p>'+
				'</form>'+
				'<button id= id='+allocid+' class="rem btn btn-danger">Remove Passenger</button>'+
				
			'</div>'+
		'</div>'+
	'</div>';
		$("#passenger").append(passform);
			}
 		});
		
		
		$('.but').click(function(event){
			booked_train_no = data[event.target.id].train_no;
			booked_source = data[event.target.id].source_station_name;
		 	booked_dest =data[event.target.id].dest_station_name;
		 	src_code = data[event.target.id].source_station_code;
		 	dest_code = data[event.target.id].dest_station_code;
			$("#details").hide();
	 		$("#results").hide();
	 		$("#book").show();
	 		$("#book-train_no").empty().append(data[event.target.id].train_name+"("+data[event.target.id].train_no+")");
	 		$("#book-date").empty().append($("#journeydate").val()+"/06/2019");
	 		$("#book-station").empty().append(data[event.target.id].source_station_name+"("+data[event.target.id].source_station_code+")"+"-------------------------------------------"+data[event.target.id].dest_station_name+"("+data[event.target.id].dest_station_code+")"); 		
	 		$("#arr-time").empty().append("Arr Time:"+data[event.target.id].source_arrival+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Arr Time: "+data[event.target.id].dest_arrival);
	 		$("#dep-time").empty().append("Dep Time:"+data[event.target.id].source_departure+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dep Time: "+data[event.target.id].dest_departure);
	 		var json_data = "{ train_no:"+data[event.target.id].train_no+",date:"+ $('#journeydate').val()+", src:"+ data[event.target.id].source_station_code+", dest:"+ data[event.target.id].dest_station_code+"  }";
	 		console.log(json_data);
	 		$.ajax({
	 		 	type: "post",
	 		 	url: "SeatAvailability",
	 		 	dataType: 'json',
	 		 	data: json_data,
	 		 	contentType: 'application/json',
	 			success : function(data){
	 				$("#1a").empty().append("1A - "+data[0]); 
	 				$("#2a").empty().append("2A - "+data[1]);
	 				$("#3a").empty().append("3A - "+data[2]);
	 				$("#sl").empty().append("SL - "+data[3]);
	 				curr_avail.push(data[0]);
	 				curr_avail.push(data[1]);
	 				curr_avail.push(data[2]);
	 				curr_avail.push(data[3]);
	 				console.log(curr_avail);
	 			}
	 		});
	 		//
	 		
	 		
	 		
		});
	},
 	error: function()
 	{
 		alert("fail")
 	}
 	
 	});
 	}); 
 	
 	
	
	});
	
 		
 		
 		

    </script>
  </head>
  <body class="vertical-layout vertical-menu 2-columns   menu-expanded fixed-navbar" data-open="click" data-menu="vertical-menu" data-color="bg-gradient-x-purple-blue" data-col="2-columns">
	<% 
	 	HttpSession sess= request.getSession();
		if(sess.getAttribute("username")== null)
		{
			response.sendRedirect("index.jsp");
		}
	
	%>
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
          <li class="active"><a href="homepage.jsp"><i class="ft-tablet"></i><span class="menu-title" data-i18n="">Book Ticket</span></a>
          </li>
          <li class=" nav-item"><a href="pnr.jsp"><i class="ft-trending-up"></i><span class="menu-title" data-i18n="">Check PNR Status</span></a>
          </li>
          <li class=" nav-item"><a href="viewbooking.jsp"><i class="ft-eye"></i><span class="menu-title" data-i18n="">View Bookings</span></a>
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
            <h3 class="content-header-title">Book Ticket</h3>
          </div>
          <div class="content-header-right col-md-8 col-12">
            <div class="breadcrumbs-top float-md-right">
           
           <%
              HttpSession sess1= request.getSession();
           	 	out.write(" <h3 class='content-header-title'>Hello ");
           	 	out.write(sess1.getAttribute("username")+"!");
           %>
           </h3>
              <div class="breadcrumb-wrapper mr-1">
                <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a href="index.html">Home</a>
                  </li>
                  <li class="breadcrumb-item active">Book Ticket
                  </li>
                
                </ol>
                <form action="logout">
                <div> <input type="submit" class="btn btn-danger btn-min-width mr-1 mb-1" id="logout" value="Logout"/></div>
             	</form>
              </div>
            </div>
          </div>
        </div>

<div class="col-lg-12 col-md-12" id="details">
          <div class="card">
              <div class="card-header">
                  <h4 class="card-title">Enter Details</h4>
              </div>
              <div class="card-block">
                  <div class="card-body">
                  <form  id="fetchdetails">
                      <h5 class="mt-2">From Station</h5>
                      <fieldset class="form-group">
                          <select class="form-control" id="fromstation" name="fromstation">
                          <option value="">Select Option</option>
                            <option value="CBE">Coimbatore Jn(CBE)</option>
							<option value="ED">ErodeJn(ED)</option>
							<option value="MDU">Madurai Jn(MDU)</option>
							<option value="MS">Chennai Egmore(MS)</option>
							<option value="MYS">Mysore(MYS)</option>
							<option value="NCJ">Nagercoil Jn(NCJ)</option>
							<option value="RMM">Rameswaram(RMM)</option>
							<option value="SA">Salem Jn(SA)</option>
							<option value="TEN">Thirunelvessssli Jn(TEN)</option>
							<option value="TPJ">Tiruchchirapali(TPJ)</option>
							<option value="VPT">Virudhunagar Jn(VPT)</option>
                            
                          </select>
                      </fieldset>
                   <h5 class="mt-2">To Station</h5>
                      <fieldset class="form-group">
                          <select class="form-control" id="tostation" name="tostation">
                          	<option value="">Select Option</option>
                          	<option value="CBE">Coimbatore Jn(CBE)</option>
							<option value="ED">ErodeJn(ED)</option>
							<option value="MDU">Madurai Jn(MDU)</option>
							<option value="MS">Chennai Egmore(MS)</option>
							<option value="MYS">Mysore(MYS)</option>
							<option value="NCJ">Nagercoil Jn(NCJ)</option>
							<option value="RMM">Rameswaram(RMM)</option>
							<option value="SA">Salem Jn(SA)</option>
							<option value="TEN">Thirunelveli Jn(TEN)</option>
							<option value="TPJ">Tiruchchirapali(TPJ)</option>
							<option value="VPT">Virudhunagar Jn(VPT)</option>                           
                          </select>
                      </fieldset>
                    <h5 class="mt-2">Date of Journey (June Month)</h5>
                      <fieldset class="form-group">
                          <input type="number" id="journeydate" class="form-control" name="date" min="1" max="30"> 
                          <br/>
                         <input type="button" class="btn btn-success btn-min-width mr-1 mb-1" id="fetch" value="Fetch Train Details"/>
                      </fieldset>  
                     <!--   
                      <fieldset class="form-group">
                          <input type="date" id="journeydate" class="form-control" name="date" min="1" max="30"> 
                      </fieldset> -->
                  </form> 
       </div>
      </div>
      </div>
      </div>
      <div class="col-lg-12 col-md-12" id="results">
         
     </div>  
 <div id="book">      
	<section id="text-alignments">
	
		<div class="col-lg-12 col-md-12">
			<div class="card text-center">
				<div class="card-body">
					<<h2> <div id="book-train_no"></div> </h2>
					<h3><div id="book-date"></div></h3>
					<h4><div id="book-station"></h4>
					<h4><div id="arr-time"></div></h4>
					<h4><div id="dep-time"></div></h4>
					<br/>
					<h3>Seat Availability</h3>
					<div class="btn-group" role="group" aria-label="Basic example">
                                <p  class="btn btn-secondary" id="1a" ></p>
                                <p  class="btn btn-primary" id="2a" ></p>
                                <p  class="btn btn-light" id="3a" ></p>
                                <p  class="btn btn-dark" id="sl" ></p>
                    </div>
                    <br/>
					
					<button type="button" id="conf-book" class=" btn btn-success btn-min-width mr-1 mb-1">Confirm Booking</button>
					<button type="button" id="back" class="btn btn-danger btn-min-width mr-1 mb-1">Back to Results</button>
					
				</div>
			</div>
		</div>
</section>
<div id="num-pas">
 <fieldset class="form-group">
 <h5 class="mt-2">Number of Passengers</h5>  <input type="number" id="no-passengers" class="form-control" name="date" min="1" max="6" value="0" readonly> 
                          <br/>
                <p class="mt-2">Select Class: <select id ="cls" class="form-control"><option value ="1A">1A</option><option value ="2A">2A</option><option value ="3A">3A</option><option value ="SL">SL</option></select></p>
                      </fieldset>  
<button type="button"  class=" ticket btn btn-success btn-min-width mr-1 mb-1">Add Passenger</button>
</div>
<section>
<div id="passenger">
</div>

</section>
<section>

</section>
</div>
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