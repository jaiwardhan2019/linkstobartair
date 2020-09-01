package com.linkportal.docmanager;

import java.util.ArrayList;
import java.util.List;
import java.io.*;
import java.util.*;
import java.nio.file.Path;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

import java.io.*;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFCell;

abstract class xmlFileConverterToExcel {

	void shellInvoiceParser(Path path) throws ParserConfigurationException, SAXException, IOException {

		System.out.println(path.toString());

	}

	
	void worldFuelServiceInvoiceParser(Path path, File file) {

	}

	
}
