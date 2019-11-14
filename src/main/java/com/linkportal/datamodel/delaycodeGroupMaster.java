package com.linkportal.datamodel;

import org.springframework.context.annotation.Scope;
import org.springframework.web.context.WebApplicationContext;


@Scope(WebApplicationContext.SCOPE_REQUEST)
public class delaycodeGroupMaster {
	
	private String delaycodegroupname;
	private String totaldelaycount;
	
	
	public delaycodeGroupMaster(String delaycodegroupname, String totaldelaycount) {
		super();
		this.delaycodegroupname = delaycodegroupname;
		this.totaldelaycount = totaldelaycount;
	}
	
	
	public String getDelaycodegroupname() {
		return delaycodegroupname;
	}
	public void setDelaycodegroupname(String delaycodegroupname) {
		this.delaycodegroupname = delaycodegroupname;
	}
	public String getTotaldelaycount() {
		return totaldelaycount;
	}
	public void setTotaldelaycount(String totaldelaycount) {
		this.totaldelaycount = totaldelaycount;
	}
	

}
