
	<footer class="text-center" style="padding-top:0px;">
      <div class="footer-above" style="background:#e9ebee;">
            <div class="container-fluid">
                <div class="row">
					<div class="footer-col col-md-4">
                        <h5 style="color:black;font-weight:600;">Stobart Air - Link</h5>
                        <div style="color:black;text-align:justify;font-size:9pt;">                        
                        Welcome to Stobart Air Link  - providing you with seamless access to all your IT systems, company and HR information and more.
                        <br><br><span class="pull-left" style="font-weight:600;"> Employee Feedback</span><br>
                         Please send your feedback to HR : <b>human.resources@stobartair.com</b>
                           </div>
                    </div>					
                    <div class="footer-col col-md-3">
                        <h5 style="font-weight:600;color:black;">Contact information</h5>
                        <font style="color:black;font-size:9pt;">
						<!--Dublin address -->
							Stobart Air, 1, Northwood Avenue <br />
							Santry - Dublin 9, D09 V2F7
							Ireland<br>
							PH:(+353 1) 844 7600<br>
							Fax: (+353 1) 844 7701 
						</font>
                    </div>					
					
					<div class="footer-col col-md-3">
                        <h5 style="font-weight:600;color:black;">Our Data Promise</h5>
                        <a style="color:black;font-size:9pt;" target="_blank"   target="_new">Click Here For Detail</a><br>
                     
                    </div>
                    
                        <div class="footer-col col-md-2">
                        <h5 style="font-weight:600;color:black;">Around the Web</h5>
                          
                            <a href="https://www.youtube.com/channel/UCRg6Z-LUg80hxkL6LBoIRHQ" target="_blank"><i class="fa fa-fw fa-youtube"></i></a>&nbsp; 

                            <a href="https://www.linkedin.com/company/stobart-air/?originalSubdomain=ie" target="_blank"><i class="fa fa-fw fa-linkedin"></i></a>&nbsp; 
							
                            <a href="https://www.instagram.com/stobartair/?hl=en" target="_blank"><i class="fa fa-fw fa-instagram"></i></a> &nbsp;
							
                             <br>
                            <a target="_blank" href="http://www.stobartair.com">www.stobartair.com</a>
					</div>
                </div>
            </div>
        </div>	
        
        
        <div class="footer-below" style="background:#0071ba;">
                    <div class="col-lg-12">
                         © Stobart Air <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %>, All rights reserved.
                         
                    </div>
            </div>
      
    
    
    </footer>
       
        	
	<!----------- Tooltip & popover initialization ------->
	<script>
		$(document).ready(function(){
			$('[data-toggle="tooltip"]').tooltip(); 
			$('[data-toggle="popover"]').popover();

			
			//--Enable HTML inside POPOVER Content 
			$(function(){
				$('[rel="popover"]').popover({
					container: 'body',
					html: true,
					content: function () {
						var clone = $($(this).data('popover-content')).clone(true).removeClass('hide');
						return clone;
					}
				}).click(function(e) {
					e.preventDefault();
				});
			});
		});


	
	 
		
	</script>


	<!------------/-------------->
	
	
	
	



	
	
	
	
	
	
	
	