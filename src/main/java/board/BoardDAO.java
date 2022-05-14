package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

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

	public void insertBoard(BoardBean bb) {

		String sql = "select max(num) from board";
		try {
			con = getconnection();

			pstmt = con.prepareStatement(sql);
			// 4단계 실행
			rs = pstmt.executeQuery();
			// 5단계 첫행(다음행)으로 이동 데이터 있으면 rs에서 max(num) +1 가져와서 num저장
			if (rs.next()) {
				bb.setNum(rs.getInt("max(num)") + 1);
			}
			// 3단계 sql insert
			sql = "insert into board(num,name,pass,subject,content,readcount,date) values(?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			// ?값 넣기 set형(물음표 순서,값)
			pstmt.setInt(1, bb.getNum());
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, bb.getReadcount());
			pstmt.setTimestamp(7, bb.getDate());
			// 4단계 실행
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
			
	}

	public BoardBean contentview(int num) {
		BoardBean b = new BoardBean();

		try {
			con = getconnection();
			// 3단계 조회수 +1증가 update readcount= readcount+1 조건
			String sql = "update board set readcount=readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4단계 실행
			pstmt.executeUpdate();

			// 3단계 sql select where num=?
			sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4단계 rs = 실행 결과 저장
			rs = pstmt.executeQuery();
			// 5단계 rs 다음행 이동 num readcount name date subject content
			while (rs.next()) {
				b.setNum(rs.getInt(1));
				b.setName(rs.getString(2));
				b.setSubject(rs.getString(4));
				b.setDate(rs.getTimestamp(7));
				b.setReadcount(rs.getInt(6));
				b.setContent(rs.getString(5));
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

	public BoardBean checkContent(int num) {
		BoardBean bb = new BoardBean();

		try {
			con = getconnection();
			String sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4단계 rs = 실행 결과 저장
			rs = pstmt.executeQuery();

			if (rs.next()) {
				bb.setName(rs.getString("name"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return bb;
	}

	public int updateContent(BoardBean bb) {
		int a = 0;

		try {
			con = getconnection();
			String sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (bb.getPass().equals(rs.getString("pass"))) {
					// 3단계 sql update만들고 실행할수 있는 객체생성
					sql = "update board set name=?,subject=?,content=? where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bb.getName());
					pstmt.setString(2, bb.getSubject());
					pstmt.setString(3, bb.getContent());
					pstmt.setInt(4, bb.getNum());
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

	public int deleteContent(int num, String pass) {
		int a = 0;

		try {
			con = getconnection();
			String sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (pass.equals(rs.getString("pass"))) {
					// 3단계 sql update만들고 실행할수 있는 객체생성
					sql = "delete from board where num=?";
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

		try {
			con = getconnection();
			String sql = "select count(*) from board";
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

	public int countContent(String search) {
		int a = 0;

		try {
			con = getconnection();
			String sql = "select count(*) from board where subject like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,"%"+search+"%");
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

	public List<BoardBean> getBoardList(int startRow, int pageSize) {
		List<BoardBean> a = new ArrayList<BoardBean>();
		try {
			con = getconnection();

			String sql = "select * from board order by num desc limit ?,?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);

			// 4단계 실행
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt(1));
				bb.setName(rs.getString(2));
				bb.setSubject(rs.getString(4));
				bb.setDate(rs.getTimestamp(7));
				bb.setReadcount(rs.getInt(6));
				a.add(bb);
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

	public List<BoardBean> getBoardList(int startRow, int pageSize, String search) {
		List<BoardBean> a = new ArrayList<BoardBean>();
		try {
			con = getconnection();

			String sql = "select * from board where subject like ? order by num desc limit ?,?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow - 1);
			pstmt.setInt(3, pageSize);

			// 4단계 실행
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt(1));
				bb.setName(rs.getString(2));
				bb.setSubject(rs.getString(4));
				bb.setDate(rs.getTimestamp(7));
				bb.setReadcount(rs.getInt(6));
				a.add(bb);
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

	public List<BoardBean> getMainList() {
		List<BoardBean> a = new ArrayList<BoardBean>();
		try {
			con = getconnection();

			String sql = "select * from board order by num asc limit 5";

			pstmt = con.prepareStatement(sql);

			// 4단계 실행
			rs = pstmt.executeQuery();

			while (rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setSubject(rs.getString(4));
				bb.setNum(rs.getInt(1));
				bb.setDate(rs.getTimestamp(7));
				a.add(bb);
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
