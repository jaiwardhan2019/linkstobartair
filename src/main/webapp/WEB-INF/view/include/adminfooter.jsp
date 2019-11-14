<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!--Footer--->
	<footer class="text-center" style="padding-top:0px;">

        
        
        <div class="footer-below" style="background:#0071ba;">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                         <%= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date()) %> © <a href="http://www.stobartair.com"> Stobart Air</a>.
                    </div>
                </div>
            </div>
        </div>
     
    
    
    	
	<!----------- Tooltip & popover initialization ------->
	<script>
		$(document).ready(function(){
			$('[data-toggle="tooltip"]').tooltip(); 
			$('[data-toggle="popover"]').popover();
		});
	</script>
	<!------------/-------------->