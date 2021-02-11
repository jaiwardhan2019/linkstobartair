package com.linkportal.crewripostry;

import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import java.io.StringWriter;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import org.xhtmlrenderer.pdf.ITextRenderer;

import freemarker.template.Configuration;
import freemarker.template.Template;

public class PDFTemplateUtil {

	/**
	  * Export pdf files via template
	  * @param data data
	  * @param templateFileName template file name
	 * @throws Exception
	 */
    public static ByteArrayOutputStream createSinglePagePDF(Map<String,Object> data, String templateFileName) throws Exception {


    	
    	// Create a FreeMarker instance, responsible for managing the Configuration instance of the FreeMarker template
        Configuration cfg = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);       
        // Specify the location of the FreeMarker template file 
        cfg.setClassForTemplateLoading(PDFTemplateUtil.class,"/templates");
       
        //helper.addAttachment("logo.png", new ClassPathResource("static/images/emaillogo.png"));
        
        ITextRenderer renderer = new ITextRenderer();
        OutputStream out = new ByteArrayOutputStream();
        try {
            
        	// Set the font style in css (temporary only supports Song and Black). Otherwise, Chinese does not display.
            //renderer.getFontResolver().addFont("/templates/font/SIMSUN.TTC", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
            // Set the encoding format of the template
            
        	cfg.setEncoding(Locale.UK,"UTF-8");
            // Get the template file 
            Template template = cfg.getTemplate(templateFileName, "UTF-8");
            StringWriter writer = new StringWriter();
            
            // Output data to html
            template.process(data, writer);
            writer.flush();

            String html = writer.toString();
            // Pass the html code into the renderer
            renderer.setDocumentFromString(html);

            // Solve the relative path of the image problem ## must set the image path after setting the document, otherwise it does not work
            renderer.getSharedContext().setBaseURL("images/");
            renderer.layout();
            
            renderer.createPDF(out, false);
            renderer.finishPDF();
            out.flush();
            return (ByteArrayOutputStream)out;
       
          } finally {if(out != null){out.close();}  }

    }
    
    
    
    
    
    
    
    /*
     * This method is going to create multipage Pdf File 
     * https://github.com/flyingsaucerproject/flyingsaucer/blob/master/flying-saucer-examples/src/main/java/PDFRenderToMultiplePages.java
     * 
     * */
    
    public static ByteArrayOutputStream createMultiplePagePDF(List<Map<String, Object>> mapArray, String templateFileName) throws Exception {

 
    	// Create a FreeMarker instance, responsible for managing the Configuration instance of the FreeMarker template
        Configuration cfg = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);       
        // Specify the location of the FreeMarker template file 
        cfg.setClassForTemplateLoading(PDFTemplateUtil.class,"/templates");
       
        //helper.addAttachment("logo.png", new ClassPathResource("static/images/emaillogo.png"));
        
        ITextRenderer renderer = new ITextRenderer();
        OutputStream out = new ByteArrayOutputStream();
        try {
            
        	// Set the font style in css (temporary only supports Song and Black). Otherwise, Chinese does not display.
            //renderer.getFontResolver().addFont("/templates/font/SIMSUN.TTC", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
            // Set the encoding format of the template
            
        	cfg.setEncoding(Locale.UK,"UTF-8");
            // Get the template file 
            Template template = cfg.getTemplate(templateFileName, "UTF-8");
            StringWriter writer = new StringWriter();
            
            
			// Output data to html
			template.process(mapArray.get(0), writer);
			writer.flush();		
			String html = writer.toString();
			renderer.setDocumentFromString(html);
			renderer.layout();			
			renderer.createPDF(out, false);

	        for(int intCtr=1; intCtr < mapArray.size();intCtr++){
				writer = new StringWriter();
				template.process(mapArray.get(intCtr), writer);
				writer.flush();
				renderer.setDocumentFromString(writer.toString());
				renderer.layout();
				renderer.writeNextDocument();
	  	    } 
           
	          
            renderer.finishPDF();
            out.flush();
            return (ByteArrayOutputStream)out;
       
          } finally {if(out != null){out.close();}  }

    }
    
    
}

