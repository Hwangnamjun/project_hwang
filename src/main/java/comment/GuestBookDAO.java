package comment;

import java.sql.*;

import javax.sql.*;

import board.BoardBean;

import javax.naming.*;
import java.util.*;

public class GuestBookDAO {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// DB연결
	public Connection getConnection() throws Exception {
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

	// DB연결 종료
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
	
	public int insert(GuestBookBean gb){
		int a = 0;
		try {
			con = getConnection();
			String sql = "insert into guestbook(date,id,subject,content) values(now(),?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gb.getId());
			pstmt.setString(2, gb.getSubject());
			pstmt.setString(3, gb.getContent());
			
			pstmt.executeUpdate();
			a = 1;
		} catch (SQLException e) {
			a = 0;
			e.printStackTrace();
		} catch (Exception e) {
			a = 0;
			e.printStackTrace();
		} finally {
			close();
		}
		return a;
	}

	public GuestBookBean check(int num)
	{
		GuestBookBean gb = new GuestBookBean();
		
		try {
			con = getConnection();
			String sql = "select * from guestbook where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				gb.setNum(rs.getInt(1));
				gb.setDate(rs.getTimestamp(2));
				gb.setId(rs.getString(3));
				gb.setSubject(rs.getString(4));
				gb.setContent(rs.getString(5));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return gb;
	}
	
	public int update(String subject, String content, int num) {
		int a = 0;
		try {
			con = getConnection();
			String sql = "update guestbook set subject=?,content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setInt(3, num);
			
			pstmt.executeUpdate();
			a = 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close();
		}
		return a;
	}
	
	public int delete(int num) {
		int a = 0;
		try {
			System.out.println(num);
			con = getConnection();
			String sql = "delete from guestbook where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
			sql = "select * from guestbook where subject like ? escape ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,num+"a_%");
			pstmt.setString(2,"a");
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				sql = "delete from guestbook where subject like ? escape ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,num+"a_%");
				pstmt.setString(2,"a");
				pstmt.executeUpdate();
			}
			a = 1;

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return a;
	}
	
	public int getCount() {
		int a = 0;
		try {
			con = getConnection();
			String sql = "select count(*) from guestbook where subject not like '%a_%' escape'a'";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) 
			{
				a = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
		} catch (Exception e) {
			// TODO Auto-generated catch block
		} finally {
			close();
		}
		return a;
	}
	
	public GuestBookBean getGuestBook (int num) {
		try {
			con = getConnection();
			String sql = "select * from guestbook where num=?";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				GuestBookBean gb = new GuestBookBean();
				gb.setNum(rs.getInt(1));
				gb.setDate(rs.getTimestamp(2));
				gb.setId(rs.getString(3));
				gb.setSubject(rs.getString(4));
				gb.setContent(rs.getString(5));
				
				return gb;
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
		return null;
	}

	public List<GuestBookBean> getlist(int startRow, int pageSize) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<GuestBookBean> a = new ArrayList<GuestBookBean>();
		
		try {
			con = getConnection();
			String sql = "select * from guestbook where subject not like '%a_%' escape'a' order by num desc limit ?,?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);

			// 4단계 실행
			rs = pstmt.executeQuery();

			while (rs.next()) {
				GuestBookBean gb = new GuestBookBean();
				gb.setNum(rs.getInt(1));
				gb.setDate(rs.getTimestamp(2));
				gb.setId(rs.getString(3));
				gb.setSubject(rs.getString(4));
				gb.setContent(rs.getString(5));
				a.add(gb);
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
		return a;
	}
	
	public GuestBookBean content(int num)
	{
		GuestBookBean gb = new GuestBookBean();
		try {
			con = getConnection();
			String sql = "select * from guestbook where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				gb.setNum(rs.getInt(1));
				gb.setDate(rs.getTimestamp(2));
				gb.setId(rs.getString(3));
				gb.setSubject(rs.getString(4));
				gb.setContent(rs.getString(5));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return gb;
	}

	public int addComm(GuestBookBean gb)
	{
		int a = 0;
		try {
			con = getConnection();
			String sql = "select * from guestbook where subject like ? order by subject asc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, gb.getNum()+"_"+"%");
			rs = pstmt.executeQuery();
			
			if(!(rs.next()))
			{
				sql = "insert into guestbook(date,id,subject,content) values(now(),?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, gb.getId());
				pstmt.setString(2, (String)(gb.getNum()+"_1"));
				pstmt.setString(3, gb.getContent());
				
				pstmt.executeUpdate();
			}
			else
			{
				rs.last();
				String comm_sub = rs.getString(4);
				String arry[] = comm_sub.split("_");
				int change = Integer.parseInt(arry[1]);
				change++;
				sql = "insert into guestbook(date,id,subject,content) values(now(),?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, gb.getId());
				pstmt.setString(2, (String)(gb.getNum()+"_"+change));
				pstmt.setString(3, gb.getContent());
				
				pstmt.executeUpdate();
			}

			a = 1;
		} catch (SQLException e) {
			a = 0;
			e.printStackTrace();
		} catch (Exception e) {
			a = 0;
			e.printStackTrace();
		} finally {
			close();
		}
		return a;
	}

	public List<GuestBookBean> getComment(int num)
	{

		List<GuestBookBean> a = new ArrayList<GuestBookBean>();
		try {
			con = getConnection();
			String sql = "select * from guestbook where subject like ? order by subject asc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, num+"_"+"%");
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				GuestBookBean gb = new GuestBookBean();
				gb.setNum(rs.getInt(1));
				gb.setSubject(rs.getString(4));
				gb.setDate(rs.getTimestamp(2));
				gb.setId(rs.getString(3));
				gb.setContent(rs.getString(5));
				a.add(gb);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return a;
	}

	public int checkCommNum(int num)
	{
		int a = 0;
		try {
			Connection con = getConnection();
			String sql = "select * from guestbook where subject like ? order by subject asc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, (String)(num+"_"+"%"));
			rs = pstmt.executeQuery();
			
			if(rs.next())
			{
				rs.last();
				String lastNum = rs.getString(4);
				String arry[] = lastNum.split("_");
				a = Integer.parseInt(arry[1]);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return a;
	}

	public List<GuestBookBean> main()
	{
		List<GuestBookBean> list = new ArrayList<GuestBookBean>();
		try {
			con = getConnection();
			String sql = "select * from guestbook where subject not like '%a_%' escape'a' order by num desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			for(int i = 0; i < 3; i++)
			{
				if(rs.next())
				{
				GuestBookBean gb = new GuestBookBean();
				gb.setSubject(rs.getString(4));
				gb.setContent(rs.getString(5));
				list.add(gb);
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}

}


