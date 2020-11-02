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
   
	<footer class="text-center" style="padding-top:0px;">
   
        <div class="footer-below" style="background:#e9ebee;">
                         <div class="col-lg-12" style="color:black;font-size:09pt;">
                       					Ops. Controller : +353-1-8447617 &nbsp;
					                    Ops. Supervisor : +353-1-8447602 &nbsp;
					                    Customer & Handling Co-ordinator +353-1-8447618	
                          </div>
                         <br>
                          <div class="col-lg-12" style="color:black;font-size:08pt;font-weight:600;">
                        
                             © Stobart Air <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %>, All rights reserved.
                         
                          </div>
            </div>
      
    
    
    </footer>
       
        	
	
<script>
 // https://www.w3schools.com/bootstrap/tryit.asp?filename=trybs_ref_js_dropdown_multilevel_css&stacked=h
 // For Multilevel Menu event 		 
    $(document).ready(function(){
      $('.dropdown-submenu a.test').on("mouseover", function(e){
      //$('.dropdown-submenu a.test').on("click", function(e){
                    $('.dropdown-submenu>ul').hide();
                    $(this).next('ul').toggle();
                    e.stopPropagation();
                    e.preventDefault();
      });
    });
 
</script>
	

   