package Control;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

import javax.swing.JTextField;

import Model.Login;
import Persistance.LoginDao;

public class ControleLogin implements ActionListener
{
	private JTextField labelUsuario;
	private JTextField labelSenha;
	
	public ControleLogin(JTextField labelUsuario, JTextField labelSenha)
	{
		this.labelUsuario = labelUsuario;
		this.labelSenha = labelSenha;
	}
	
	private void InsereLogin() throws SQLException
	{
		Login l = new Login(null, null);
		l.setRG(labelUsuario.getText());
		l.setSenha(labelSenha.getText());
		
		LoginDao lDao = new LoginDao();
		String saida = lDao.consultaLogin(l);
	}
	
	@Override
	public void actionPerformed(ActionEvent arg0) 
	{
		try 
		{
			InsereLogin();
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		
	}
	
}
