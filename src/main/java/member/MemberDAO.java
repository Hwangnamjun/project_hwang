package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public Connection getconnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");

		String dbUrl = "jdbc:mysql://localhost:3306/jspdb5";
		String dbUser = "jspid";
		String dbPass = "jsppass";
		con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
		
//		Context init = new InitialContext();
//		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
//		Connection con = ds.getConnection();
		
		return con;
	}
	public void close() {
		if (rs != null)
			try {
				rs.close();
			} catch (SQLException e2) {
			}
		if (pstmt != null)
			try {
				pstmt.close();
			} catch (SQLException e2) {
			}
		if (con != null)
			try {
				con.close();
			} catch (SQLException e2) {
			}
	}
	public void insertMember(MemberBean member_B) {
		try {

			String name = member_B.getName();
			String pass = member_B.getPass();
			String id = member_B.getId();
			Timestamp reg_date = member_B.getReg_data();
			String address = member_B.getAddress();
			String phone = member_B.getPhone();
			String mobile = member_B.getMobile();
			String email = member_B.getEmail();

			con = getconnection();

			String sql = "insert into member(id,pass,name,reg_date,email,address,phone,mobile) values(?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			pstmt.setString(3, name);
			pstmt.setTimestamp(4, reg_date);
			pstmt.setString(5, email);
			pstmt.setString(6, address);
			pstmt.setString(7, phone);
			pstmt.setString(8, mobile);

			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public MemberBean getMember(String id) {
		String Id = id;
		try {

			con = getconnection();

			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, Id);

			rs = pstmt.executeQuery();

			MemberBean mb = new MemberBean();
			if (rs.next()) {
				mb.setId(rs.getString("id"));
				mb.setName(rs.getString("name"));
				mb.setPass(rs.getString("pass"));
				mb.setReg_data(rs.getTimestamp("reg_date"));
				mb.setAddress(rs.getString("address"));
				mb.setEmail(rs.getString("email"));
				mb.setPhone(rs.getString("phone"));
				mb.setMobile(rs.getString("mobile"));
			}

			return mb;

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return null;
	}

	public int usercheck(String id, String pass) {
		try {

			con = getconnection();

			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (pass.equals(rs.getString("pass"))) {
					return 1;
				}

				else {
					return 0;
				}
			} else {
				return -1;
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return -1;
	}

	public void updateMember(MemberBean mb) {
		try {

			con = getconnection();

			String sql = "update member set pass=?, name=?, email=?, address=?, phone=?, mobile=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getPass());
			pstmt.setString(2, mb.getName());
			pstmt.setString(3, mb.getEmail());
			pstmt.setString(4, mb.getAddress());
			pstmt.setString(5, mb.getPhone());
			pstmt.setString(6, mb.getMobile());
			pstmt.setString(7, mb.getId());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public void deletemember(String id) {
		try {

			con = getconnection();

			String sql2 = "delete from member where id=?";
			pstmt = con.prepareStatement(sql2);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {

			e.printStackTrace();
		} catch (SQLException e) {

			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}

	}

	public List<Object> getMemberList() {
		try {

			con = getconnection();

			// 3단계 연결정보에 preparestatement 매서드 호출해서 sql구문 작성해서 실행할 수 있는 pstmt 생성
			String sql = "select * from member";
			pstmt = con.prepareStatement(sql);

			// 4단계 실행
			rs = pstmt.executeQuery();
			List<Object> a = new ArrayList<Object>();
			while (rs.next()) {
				MemberBean mb = new MemberBean();
				mb.setId(rs.getString(1));
				mb.setPass(rs.getString(2));
				mb.setName(rs.getString(3));
				mb.setReg_data(rs.getTimestamp(4));
				a.add(mb);
			}
			return a;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return null;
	}

	public void listDel(String id)
	{
		
		try {
			con = getconnection();
			String sql = "delete from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public boolean checkID(String id)
	{
		
		try {
			con = getconnection();
			String sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				return false;
			}
			else
			{
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close();
			}
		return false;
	}
}
