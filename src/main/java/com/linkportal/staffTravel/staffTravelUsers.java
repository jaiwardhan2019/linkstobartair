package com.linkportal.staffTravel;

public class staffTravelUsers {
	
	   private int id;
	   private String department;
	   private String email;
	   private String first_name;
	   private String surname;
	   private String status;
	   
		   
		public staffTravelUsers(int id, String department, String email, String first_name, String surname, String status) {
			super();
			this.id = id;
			this.department = department;
			this.email = email;
			this.first_name = first_name;
			this.surname = surname;
			this.status = status;
		}


		public int getId() {
			return id;
		}


		public void setId(int id) {
			this.id = id;
		}


		public String getDepartment() {
			return department;
		}


		public void setDepartment(String department) {
			this.department = department;
		}


		public String getEmail() {
			return email;
		}


		public void setEmail(String email) {
			this.email = email;
		}


		public String getFirst_name() {
			return first_name;
		}


		public void setFirst_name(String first_name) {
			this.first_name = first_name;
		}


		public String getSurname() {
			return surname;
		}


		public void setSurname(String surname) {
			this.surname = surname;
		}


		public String getStatus() {
			return status;
		}


		public void setStatus(String status) {
			this.status = status;
		}


		@Override
		public String toString() {
			return "staffTravelUsers [id=" + id + ", department=" + department + ", email=" + email + ", first_name="
					+ first_name + ", surname=" + surname + ", status=" + status + "]";
		}
		
		
		
		   
	

}
