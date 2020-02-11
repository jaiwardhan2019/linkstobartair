package com.linkportal.security;

import java.security.spec.KeySpec;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;
import org.apache.commons.codec.binary.Base64;
import org.apache.poi.util.Beta;
import org.springframework.stereotype.Repository;



@Repository
public class EncryptDecrypt {
	
	
    private static final String UNICODE_FORMAT = "UTF8";
    public static final String DESEDE_ENCRYPTION_SCHEME = "DESede";
    private KeySpec ks;
    private SecretKeyFactory skf;
    private Cipher cipher;
    byte[] arrayBytes;
    private String myEncryptionKey;
    private String myEncryptionScheme;
    SecretKey key;
    
    
    

	public EncryptDecrypt() throws Exception {
        myEncryptionKey = "ThisIsSpartaThisIsSparta";
        myEncryptionScheme = DESEDE_ENCRYPTION_SCHEME;
        arrayBytes = myEncryptionKey.getBytes(UNICODE_FORMAT);
        ks = new DESedeKeySpec(arrayBytes);
        skf = SecretKeyFactory.getInstance(myEncryptionScheme);
        cipher = Cipher.getInstance(myEncryptionScheme);
        key = skf.generateSecret(ks);
    }


    public String encrypt(String unencryptedString) {
        String encryptedString = null;
        try {
            cipher.init(Cipher.ENCRYPT_MODE, key);
            byte[] plainText = unencryptedString.getBytes(UNICODE_FORMAT);
            byte[] encryptedText = cipher.doFinal(plainText);
            encryptedString = new String(Base64.encodeBase64(encryptedText));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return encryptedString;
    }


    public String decrypt(String encryptedString) {
        String decryptedText=null;
        try {
            cipher.init(Cipher.DECRYPT_MODE, key);
            byte[] encryptedText = Base64.decodeBase64(encryptedString.getBytes());
            byte[] plainText = cipher.doFinal(encryptedText);
            decryptedText= new String(plainText);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return decryptedText;
    }


    
    
    //---- Function will take string password and validated with the db stored encripted password
	public boolean validatePassword(String rawinputpassword , String storedpassword) throws Exception {
		    
		        //inputpassword="password@123";		     
		        String encrypted=encrypt(rawinputpassword);
		        String decrypted=decrypt(storedpassword);  	
		        
		        //System.out.println("Input String To Encrypt: "+ inputpassword);
		        //System.out.println("Encrypted String: " + encrypted);
		        //System.out.println("Decrypted String: " + decrypted);
		        if(encrypted.equalsIgnoreCase(storedpassword)) {return true; } else{return false;}
		        
	}

	
	public String Test_Message() {
		
		return "Hi this is test message";
	}


 
	
}