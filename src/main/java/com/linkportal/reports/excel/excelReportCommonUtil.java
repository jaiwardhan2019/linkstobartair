package com.linkportal.reports.excel;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFPrintSetup;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.ss.usermodel.CellStyle;

public abstract class excelReportCommonUtil {


	protected void setPrintSetup(HSSFSheet sheet) {
		HSSFPrintSetup ps = sheet.getPrintSetup();
		ps.setFitWidth((short) 1); // 1 page by blank pages wide.
		ps.setFitHeight((short) 0);
		sheet.setAutobreaks(true);
		ps.setLandscape(true); // set landscape

	}

	protected HSSFCell createCell(HSSFRow row, int column, String value) {

		HSSFCell cell = row.createCell(column);
		cell.setCellValue(value);

		return cell;
	}

	protected HSSFCell createCell(HSSFRow row, int column, Long value) {

		HSSFCell cell = row.createCell(column);
		cell.setCellValue(value);
		return cell;
	}

	protected HSSFCell createCell(HSSFRow row, int column, Integer value) {

		HSSFCell cell = row.createCell(column);
		cell.setCellValue(value);
		return cell;
	}

	/**
	 * Creates a cell Design Cell
	 * https://poi.apache.org/components/spreadsheet/quick-guide.html#FillsAndFrills
	 */
	protected HSSFCell createCell_Header(CellStyle style, HSSFRow row, int column, String value) {
		HSSFCell cell = row.createCell(column);
		cell.setCellValue(value);
		cell.setCellStyle(style);
		return cell;
	}

}
