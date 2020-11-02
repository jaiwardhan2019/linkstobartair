package com.linkportal;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTest {

	public static void main(String[] args)  {
		// TODO Auto-generated method stub
		
		    SimpleDateFormat sdformat = new SimpleDateFormat("dd/MM/yyyy HH:mm");	
		    Date firstDate;
			try {
				
				firstDate = sdformat.parse("02/11/2020 12:58");
				Date secondDate = sdformat.parse(sdformat.format(new Date()));			
				System.out.println(((secondDate.getTime() - firstDate.getTime()) / (1000 * 60 * 60 * 24)));
				
				
				
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			

			
			
		

	}

}
