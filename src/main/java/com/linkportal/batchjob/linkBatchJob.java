package com.linkportal.batchjob;

import java.sql.SQLException;

public interface linkBatchJob {

	void notify_Contarct_Admin_About_ContractExpiry();  //  Disable
	
	void notify_PPS_Login_Token_LowLevel();            //  Not ready yet  

	void removeDelayFlightComment(int noOfDayOld)throws SQLException;
	
}
