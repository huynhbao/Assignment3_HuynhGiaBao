/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.Normalizer;

/**
 *
 * @author HuynhBao
 */
public class MyUtils {
    public static final String FULLNAME_PATTERN = "[a-zA-Z\\s]+";
    public static final String EMAIL_PATTERN = "[a-zA-Z0-9]+[._a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]*[a-zA-Z]*@[a-zA-Z0-9]{2,8}.[a-zA-Z.]{2,6}";
    
    public static final String STUDENT_ROLLE = "student";
    public static final String ADMIN_ROLLE = "admin";
    public static final String DEFAULT_ACCOUNT_STATUS = "new";
    
    
    public static final int recordPerPage = 20;
    
    
    
    public static String capitalFullName(String fullName) {
        fullName = fullName.replaceAll("\\s+", " ").toLowerCase();
        String[] arr = fullName.split(" ");
        String newFullName = "";

        for (int i = 0; i < arr.length; i++) {
            newFullName += Character.toUpperCase(arr[i].charAt(0)) + arr[i].substring(1) + " ";
        }
        return newFullName.trim();
    }

    public static String removeAccent(String s) {
        s = Normalizer.normalize(s, Normalizer.Form.NFD);
        s = s.replaceAll("[\\p{InCombiningDiacriticalMarks}]", "");
        return s;
    }
    
    public static byte[] getSHA(String input) throws NoSuchAlgorithmException 
    {  
        // Static getInstance method is called with hashing SHA  
        MessageDigest md = MessageDigest.getInstance("SHA-256");  
  
        // digest() method called  
        // to calculate message digest of an input  
        // and return array of byte 
        return md.digest(input.getBytes(StandardCharsets.UTF_8));  
    } 
    
    public static String toHexString(byte[] hash) 
    { 
        // Convert byte array into signum representation  
        BigInteger number = new BigInteger(1, hash);  
  
        // Convert message digest into hex value  
        StringBuilder hexString = new StringBuilder(number.toString(16));  
  
        // Pad with leading zeros 
        while (hexString.length() < 32)  
        {  
            hexString.insert(0, '0');  
        }  
  
        return hexString.toString();  
    }
}
