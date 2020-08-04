package test;

import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport {

	
	private static final long serialVersionUID = 1L;
	
	private String account;
	private String password;
	@Override
	public String execute() throws Exception {
		if("demo".equalsIgnoreCase(account) && "demo12345".equals(password)){
			return SUCCESS;
		}
		return LOGIN;
	}
	
	

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	
}
