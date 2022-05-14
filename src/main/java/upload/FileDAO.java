package upload;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardBean;

public class FileDAO {

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

	// 파일업로드
	public int uploadFile(String author, String title, String file, String pass) {

		try {
			con = getConnection();

			if (title == null) {
				title = "제목없음";
			}
			String sql = "insert into fileboard(author,title,fileName,day,pass) values(?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, author);
			pstmt.setString(2, title);
			pstmt.setString(3, file);
			pstmt.setString(4, pass);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			close();
		}
		return 1;
	}

	public ArrayList<FileBean> selectAll(int startRow, int pageSize) {
		ArrayList<FileBean> bean = new ArrayList<FileBean>();

		try {
			con = getConnection();

			String sql = "select * from fileboard order by num desc limit ?,?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				FileBean bb = new FileBean();
				bb.setNum(rs.getInt(1));
				bb.setAuthor(rs.getString(2));
				bb.setTitle(rs.getString(3));
				bb.setFile(rs.getString(4));
				bb.setDay(rs.getTimestamp(5));
				bean.add(bb);
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
		return bean;
	}

	public FileBean contentview(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		FileBean b = new FileBean();

		try {
			con = getConnection();

			// 3단계 sql select where num=?
			String sql = "select * from fileboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4단계 rs = 실행 결과 저장
			rs = pstmt.executeQuery();
			// 5단계 rs 다음행 이동 num readcount name date subject content
			while (rs.next()) {
				b.setNum(rs.getInt(1));
				b.setAuthor(rs.getString(2));
				b.setTitle(rs.getString(3));
				b.setFile(rs.getString(4));
				b.setDay(rs.getTimestamp(5));
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
		return b;
	}

	public int deleteContent(int num, String pass) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int a = 0;

		try {
			con = getConnection();
			String sql = "select * from fileboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (pass.equals(rs.getString("pass"))) {
					// 3단계 sql update만들고 실행할수 있는 객체생성
					sql = "delete from fileboard where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					// 4단계 실행
					pstmt.executeUpdate();

					a = 1;
				} else {
					// "비밀번호 틀림" 뒤로이동
					a = 0;
				}
			} else {
				// "num 없음" 뒤로이동
				a = -1;
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

	public int countContent() {
		int a = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConnection();
			String sql = "select count(*) from fileboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				a = rs.getInt(1);
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
}
