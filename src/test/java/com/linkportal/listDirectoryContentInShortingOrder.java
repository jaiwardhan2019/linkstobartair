package com.linkportal;
import java.io.File;
import java.util.Arrays;

//https://www.boraji.com/how-to-sort-files-in-a-directory-in-java  
// All shorting type -----
public class listDirectoryContentInShortingOrder {

	public static void main(String[] args) {
		
		System.out.println("List Directory Content in Order.");
		
		listDirectContentInshortedOrder("C:/data/groundops/TRS");
		
	}

	
	
	
	private static void listDirectContentInshortedOrder(String directoryPath) {
		
		File dir = new File(directoryPath);

	      File[] files = dir.listFiles();

	      Arrays.sort(files, (f1, f2) -> f1.compareTo(f2));

	      for (File file : files) {
	         if (!file.isHidden()) {
	           if (!file.isDirectory()) {
	             //  System.out.println("DIR \t" + file.getName());
	            //} else {
	               System.out.println("FILE\t" + file.getName());
	            }
	         }
		
	      }//-- End of for 	
	
	      
	      
	      
	      
	      
	}// ------- End of Method -------	
	
	
	
	
}	
	
	