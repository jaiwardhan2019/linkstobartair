package com.linkportal.controller;


import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.itextpdf.text.pdf.codec.Base64.OutputStream;
import com.linkportal.contractmanager.manageStobartContract;
import com.linkportal.datamodel.Product;
import com.linkportal.dbripostry.businessAreaContent;
import com.linkportal.dbripostry.linkUsers;
import com.linkportal.fltreport.flightReports;



@Controller
public class AdminHomeController {


    @Autowired
    businessAreaContent bac;




    @Autowired
    linkUsers lkuser;


    @Autowired
    manageStobartContract stobartcontract;


    //---------- Logger Initializer------------------------------- 
    private final Logger logger = Logger.getLogger(HomeController.class);


    //------------ FOR AJAX  SAMPLE CODE
    @GetMapping("/ajaxtest")
    public String index() {
        return "ajaxtest";
    }


    //--- THIS IS FOR Dicing traning      
    @GetMapping("/atrdicing")
    String atr_diccing_traning_page(ModelMap model) {
        return "atrdicing/index";
    }


    @GetMapping("/test")
    String test_page(ModelMap model) {
        logger.info("Info level log message");
        logger.debug("This is debug Message");
        logger.error("Error level log message");


        Map<String, String> map = new HashMap<String, String>();

        map.put("key1", "value1");
        map.put("key2", "value2");
        map.put("key3", "value3");

        System.out.println("using keySet");
        for (String key : map.keySet()) {
            System.out.println(key + "=" + map.get(key));
        }

        model.put("profilelist", map);


        Gson gsonObj = new Gson();
        Map<Object, Object> map1 = null;
        List<Map<Object, Object>> list = new ArrayList<Map<Object, Object>>();

        map1 = new HashMap<Object, Object>();
        map1.put("label", "Electrical");
        map1.put("y", 35);
        list.add(map1);
        map1 = new HashMap<Object, Object>();
        map1.put("label", "Transport");
        map1.put("y", 20);
        list.add(map1);
        map1 = new HashMap<Object, Object>();
        map1.put("label", "Cosumer Durables");
        map1.put("y", 18);
        list.add(map1);
        map1 = new HashMap<Object, Object>();
        map1.put("label", "Packaging");
        map1.put("y", 15);
        list.add(map1);
        map1 = new HashMap<Object, Object>();
        map1.put("label", "Construction");
        map1.put("y", 5);
        list.add(map1);
        map1 = new HashMap<Object, Object>();
        map1.put("label", "Machinery");
        map1.put("y", 7);
        list.add(map1);
        map1 = new HashMap<Object, Object>();
        map1.put("label", "Others");
        map1.put("y", 7);
        list.add(map1);

        String dataPoints = gsonObj.toJson(list);

        model.addAttribute("dataPoints", dataPoints);

        return "test";
        //return "testgraph";
        //return "atrdicing/index";
    }


    @RequestMapping(value = "/adminhome", method = {RequestMethod.POST, RequestMethod.GET})
    public String Admin_home_page(ModelMap model, HttpServletRequest req) {
        model.addAttribute("cat", "img");
        model.addAttribute("emailid", req.getParameter("emailid"));
        return "admin/adminhome";
    }


    @RequestMapping(value = "/businessareahome", method = {RequestMethod.POST, RequestMethod.GET})
    public String business_area_home(ModelMap model) {
        model.addAttribute("cat", "img");
        return "admin/contentmanagment/stobartairbusinessarea";
    }


    //------------  Call FOR UPDATE CONTENT Button ------------
    @RequestMapping(value = "/updatebusiness_area_content", method = {RequestMethod.POST, RequestMethod.GET})
    public String Update_BusinessAreaContent(HttpServletRequest req, ModelMap model) {
        boolean update_status = bac.Update_Content(req.getParameter("content"), Integer.parseInt(req.getParameter("cat")), req.getParameter("emailid"));
        model.addAttribute("cat", req.getParameter("cat"));
        model.addAttribute("content", req.getParameter("content"));
        return "admin/contentmanagment/stobartairbusinessarea";
    }


    //------------  This Will Call to SHOW BUSINESS CONTENT ------------
    @RequestMapping(value = "/showbusiness_area_content", method = {RequestMethod.POST, RequestMethod.GET})
    public String Show_Businessupdate(HttpServletRequest req, ModelMap model) {
        model.addAttribute("content", bac.Show_Content(Integer.parseInt(req.getParameter("cat"))));
        model.addAttribute("cat", req.getParameter("cat"));
        model.addAttribute("emailid", req.getParameter("emailid"));
        return "admin/contentmanagment/stobartairbusinessarea";
    }


    //---------- WILL SHOW LIST OF LINK USER BASED ON SEARCH CRITERIA  -----------------------------
    @RequestMapping(value = "/profilemanager", method = {RequestMethod.POST, RequestMethod.GET})
    public String profile_manager(ModelMap model, HttpServletRequest req) {

        model.put("linkuserlist", lkuser.getLinkUserListFromDatabase(req.getParameter("user")));
        model.put("emailid", req.getParameter("emailid"));
        return "admin/userprofile/profilemanager";
    }


    //---------- WILL SHOW USER DETAIL WITH PROFILE -----------------------------
    @RequestMapping(value = "/updatelinkuserprofile", method = {RequestMethod.POST, RequestMethod.GET})
    public String update_linkuser_profile(ModelMap model, HttpServletRequest req) {

        model.put("linkuserdetail", lkuser.getLinkUserDetails(req.getParameter("id")));

        String[] userprofile_linkprofile = new String[2];

        userprofile_linkprofile = lkuser.getUserpProfileAndLinkProfile(req.getParameter("id"));

        model.put("userprofilelist", userprofile_linkprofile[0]);
        model.put("linkprofilelist", userprofile_linkprofile[1]);


        model.put("emailid", req.getParameter("emailid"));
        return "admin/userprofile/updateuserprofile";
    }


    //---------- THIS PART WILL UPDATE NEW LINK PROFILE FOR A USER TO DATABASE -----------------------------
    @RequestMapping(value = "/updatelinkuserprofileToDataBase", method = {RequestMethod.POST, RequestMethod.GET})
    public String update_linkuser_profileToDatabase(ModelMap model, HttpServletRequest req) {

        lkuser.UpdateUserpProfileAndActiveStatustoDataBase(req.getParameter("id"), req.getParameter("activestatus"), req.getParameter("adminstatus"));
        if (req.getParameterValues("linkprofile") != null) {
            String[] selectedlikprofile = req.getParameterValues("linkprofile");
            List profilelist = Arrays.asList(selectedlikprofile);
            // THIS FUNCTION WILL UPDATE USER MASTER AND USER PROFILE LIST
            lkuser.UpdateLinkProfiletoDataBase(req.getParameter("id"), req.getParameter("activestatus"), req.getParameter("adminstatus"), profilelist);
        }


        //----------- This Part is to Built -  Next Page with the User Detail and Profile detail
        String[] userprofile_linkprofile = new String[2];
        userprofile_linkprofile = lkuser.getUserpProfileAndLinkProfile(req.getParameter("id"));
        model.put("userprofilelist", userprofile_linkprofile[0]);
        model.put("linkprofilelist", userprofile_linkprofile[1]);
        model.put("linkuserdetail", lkuser.getLinkUserDetails(req.getParameter("id")));
        model.put("emailid", req.getParameter("emailid"));


        return "admin/userprofile/updateuserprofile";
    }


    //---------- THIS PART WILL REMOVE EXISTING LINK PROFILE FROM DATABASE FOR A USER -----------------------------
    @RequestMapping(value = "/removelinkuserprofile", method = {RequestMethod.POST, RequestMethod.GET})
    public String remove_linkuser_profileToDatabase(ModelMap model, HttpServletRequest req) {

        lkuser.UpdateUserpProfileAndActiveStatustoDataBase(req.getParameter("id"), req.getParameter("activestatus"), req.getParameter("adminstatus"));

        if (req.getParameterValues("userprofile") != null) {
            String[] selectedUserprofile = req.getParameterValues("userprofile");
            List userprofilelist = Arrays.asList(selectedUserprofile);
            // THIS FUNCTION WILL UPDATE USER MASTER AND USER PROFILE LIST
            lkuser.RemoveUserpProfileAndLinkProfiletoDataBase(req.getParameter("id"), userprofilelist);

        }


        //----------- This Part is to Built -  Next Page with the User Detail and Profile detail
        String[] userprofile_linkprofile = new String[2];
        userprofile_linkprofile = lkuser.getUserpProfileAndLinkProfile(req.getParameter("id"));
        model.put("userprofilelist", userprofile_linkprofile[0]);
        model.put("linkprofilelist", userprofile_linkprofile[1]);
        model.put("linkuserdetail", lkuser.getLinkUserDetails(req.getParameter("id")));
        model.put("emailid", req.getParameter("emailid"));
        return "admin/userprofile/updateuserprofile";

    }


    //************** THIS PART FOR THE ACCESS PROFILE OF THE STOBART CONTRACT MANAGER


    //---------- WILL SHOW USER DETAIL WITH PROFILE -----------------------------
    @RequestMapping(value = "/showcontractaccessprofile", method = {RequestMethod.POST, RequestMethod.GET})
    public String show_user_profile_for_contract_access(ModelMap model, HttpServletRequest req) throws SQLException {

        model.put("emailid", req.getParameter("emailid"));
        model.put("userid", req.getParameter("userid"));


        //--- Add Profile Part ----------
        if (req.getParameter("operation") != null) {


            //-------- This Part will Add Data into database
            if (req.getParameter("operation").equals("ADD")) {

                int addingstatus = stobartcontract.addNewContractProfiletoUser(req);
                if (addingstatus == 1) {
                    model.put("statusmessage", "Profile Added..<i class='fa fa-thumbs-o-up fa-lg'></i>");
                } else {
                    model.put("statusmessage", "Not Added please try again.<i class='fa fa-thumbs-o-down fa-lg'></i>");
                }

                if (addingstatus == 0) {

                    model.put("statusmessage", "Profile Allready Exist..");
                }

                model.put("departmentlist", stobartcontract.populate_Department("ALL", req.getParameter("department")));
                model.put("subdepartmentlist", stobartcontract.populate_SubDepartment(req.getParameter("emailid"), req.getParameter("department"), req.getParameter("subdepartment")));
                model.put("usercontractprofilelist", stobartcontract.showProfileListOfUser(req.getParameter("userid")));
                return "admin/userprofile/viewcontractuserprofile";

            }


            if (req.getParameter("operation").equals("REM")) {

                stobartcontract.removeContractProfileofUser(Integer.parseInt(req.getParameter("profileid")), req.getParameter("userid"));
                model.put("statusmessage", "Profile Removed..<i class='fa fa-thumbs-o-up fa-lg'></i>");
                model.put("departmentlist", stobartcontract.populate_Department("ALL", req.getParameter("department")));
                model.put("subdepartmentlist", stobartcontract.populate_SubDepartment(req.getParameter("emailid"), req.getParameter("department"), req.getParameter("subdepartment")));
                model.put("usercontractprofilelist", stobartcontract.showProfileListOfUser(req.getParameter("userid")));
                return "admin/userprofile/viewcontractuserprofile";

            }


            //--- ON CHANGE OF DEPARTMENT THIS WILL BE CALLED ----------
            if (req.getParameter("operation").equals("LOAD")) {
                model.put("departmentlist", stobartcontract.populate_Department("ALL", req.getParameter("department")));
                model.put("subdepartmentlist", stobartcontract.populate_SubDepartment(req.getParameter("emailid"), req.getParameter("department"), req.getParameter("subdepartment")));
                model.put("usercontractprofilelist", stobartcontract.showProfileListOfUser(req.getParameter("userid")));
                return "admin/userprofile/viewcontractuserprofile";
            }//  End of Load


        }

        model.put("departmentlist", stobartcontract.populate_Department("ALL", "ALL"));
        model.put("subdepartmentlist", stobartcontract.populate_SubDepartment("ALL", "ALL", "ALL"));
        model.put("usercontractprofilelist", stobartcontract.showProfileListOfUser(req.getParameter("userid")));

        return "admin/userprofile/viewcontractuserprofile";
    }


/////////////////// FOR GROUND OPS USER PROFILE ////////////////////////-------


    //---------- WILL SHOW USER DETAIL WITH PROFILE OF GROUND OPS-----------------------------
    @RequestMapping(value = "/gopsprofilemanager", method = {RequestMethod.POST, RequestMethod.GET})
    public String gopsprofile_manager(ModelMap model, HttpServletRequest req) {

        model.put("linkuserdetail", lkuser.getLinkUserDetails(req.getParameter("userid")));

        String[] userprofile_linkprofile = new String[2];

        userprofile_linkprofile = lkuser.getUserpProfileandAllgroundopsProfile(req.getParameter("userid"));

        model.put("userprofilelist", userprofile_linkprofile[0]);
        model.put("gopsprofilelist", userprofile_linkprofile[1]);


        model.put("emailid", req.getParameter("emailid"));
        return "admin/userprofile/gopsuserprofilemanager";
    }


    //---------- THIS PART WILL UPDATE NEW LINK PROFILE FOR A USER TO DATABASE -----------------------------
    @RequestMapping(value = "/updateGopsProfileToDataBase", method = {RequestMethod.POST, RequestMethod.GET})
    public String update_Gops_profileToDatabase(ModelMap model, HttpServletRequest req) {
        model.put("linkuserdetail", lkuser.getLinkUserDetails(req.getParameter("userid")));

        if (req.getParameterValues("gopsprofile") != null) {
            String[] selectedGopsprofile = req.getParameterValues("gopsprofile");
            List profilelist = Arrays.asList(selectedGopsprofile);
            // THIS FUNCTION WILL UPDATE USER MASTER AND USER PROFILE LIST
            lkuser.UpdateGopsProfiletoDataBase(req.getParameter("userid"), profilelist);
            model.put("status", "Profile Updated..");
        }


        //----------- This Part is to Built -  Next Page with the User Detail and Profile detail
        String[] userprofile_linkprofile = new String[2];
        userprofile_linkprofile = lkuser.getUserpProfileandAllgroundopsProfile(req.getParameter("userid"));
        model.put("userprofilelist", userprofile_linkprofile[0]);
        model.put("gopsprofilelist", userprofile_linkprofile[1]);
        model.put("emailid", req.getParameter("emailid"));
        return "admin/userprofile/gopsuserprofilemanager";

    }


    //---------- THIS PART WILL REMOVE EXISTING LINK PROFILE FROM DATABASE FOR A USER -----------------------------
    @RequestMapping(value = "/removegopsprofile", method = {RequestMethod.POST, RequestMethod.GET})
    public String remove_Groundops_profilefromDatabase(ModelMap model, HttpServletRequest req) {

        if (req.getParameterValues("userprofile") != null) {
            String[] selectedUserprofile = req.getParameterValues("userprofile");
            List userprofilelist = Arrays.asList(selectedUserprofile);
            // THIS FUNCTION WILL UPDATE USER MASTER AND USER PROFILE LIST
            lkuser.RemoveUserpProfileAndLinkProfiletoDataBase(req.getParameter("userid"), userprofilelist);
            model.put("status", "Profile Removed...");

        }


        //----------- This Part is to Built -  Next Page with the User Detail and Profile detail
        String[] userprofile_linkprofile = new String[2];
        userprofile_linkprofile = lkuser.getUserpProfileandAllgroundopsProfile(req.getParameter("userid"));
        model.put("userprofilelist", userprofile_linkprofile[0]);
        model.put("gopsprofilelist", userprofile_linkprofile[1]);
        model.put("emailid", req.getParameter("emailid"));
        model.put("linkuserdetail", lkuser.getLinkUserDetails(req.getParameter("userid")));
        return "admin/userprofile/gopsuserprofilemanager";

    }


///////////////  FILE ADD UPDATE / VIEW/ DOWNLOAD FROM DATABASE 	 JAI


    @GetMapping("/fileuploadtest")
    String fileuploadTest(ModelMap model) {

        return "fileuploadtest";
    }


    //---------- THIS FUNCTION WILL ADD FILE INTO DATABASE -----------------------------
    @RequestMapping(value = "/uploadServlet", method = {RequestMethod.POST, RequestMethod.GET})
    public String upload_filetoDatabaseforTest(ModelMap model, HttpServletRequest req, HttpServletResponse response, @RequestParam("photo") MultipartFile file1) throws IOException, ServletException, InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {

        stobartcontract.appenFiletoDataBase(req, file1);
        model.put("status", "File Uploaded Success Fully ");

        return "Upload";
    }




}//----------- End Of Main Controller --------------------
