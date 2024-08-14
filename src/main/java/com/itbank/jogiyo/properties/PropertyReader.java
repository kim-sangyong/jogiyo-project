package com.itbank.jogiyo.properties;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropertyReader {
	 private Properties properties;

	 public PropertyReader() {
	        properties = new Properties();
	        try (InputStream input = getClass().getClassLoader().getResourceAsStream("com/itbank/jogiyo/properties/jproperties.properties")) {
	            properties.load(input);
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    public String getProperty(String key) {
	        return properties.getProperty(key);
	    }
}
