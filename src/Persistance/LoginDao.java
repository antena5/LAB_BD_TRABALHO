package Persistance;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;

import javax.swing.JOptionPane;

import Model.Login;
import View.TelaLogin;
import View.TelaProfessor;

public class LoginDao implements ILoginDao
{
	private Connection cn;
	public LoginDao() throws SQLException
	{
		IGenericDao Dao = new GenericDao();
		cn = Dao.getConnection();
	}
	public String consultaLogin(Login l) throws SQLException 
	{
		String sql = "{CALL sp_validaLogin(?,?,?)}";
		CallableStatement cs = cn.prepareCall(sql);
		cs.setString(1, l.getRG());
		cs.setString(2, l.getSenha());
		cs.registerOutParameter(3, Types.VARCHAR);
		cs.execute();
		String saida = cs.getString(3);
		cs.close();
		System.out.println(saida);
		if(saida.contentEquals("Conectado!"))
		{
			new TelaProfessor().setVisible(true);;
			new TelaLogin().dispose();
		}
		else
		{
			JOptionPane.showMessageDialog(null, "Login Incorreto !");
		}
		return saida;
	}

}
