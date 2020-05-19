package View;

import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;

import Control.ControleLogin;
import Persistance.LoginDao;

public class TelaLogin extends JFrame 
{
	private static final long serialVersionUID = 1L;
	private JPanel contentPane;
	private JTextField txtUsuario;
	private JTextField txtSenha;
	public static void main(String[] args) 
	{
		EventQueue.invokeLater(new Runnable() 
		{
			public void run() 
			{
				try 
				{
					TelaLogin frame = new TelaLogin();
					frame.setVisible(true);
				} 
				catch (Exception e) 
				{
					e.printStackTrace();
				}
			}
		});
	}
	public TelaLogin()
	{
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 303, 219);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JLabel labelUsuario = new JLabel("Usu\u00E1rio");
		labelUsuario.setBounds(30, 39, 46, 14);
		contentPane.add(labelUsuario);
		
		JLabel labelSenha = new JLabel("Senha");
		labelSenha.setBounds(30, 81, 46, 14);
		contentPane.add(labelSenha);
		
		txtUsuario = new JTextField();
		txtUsuario.setBounds(86, 36, 135, 20);
		contentPane.add(txtUsuario);
		txtUsuario.setColumns(10);
		
		txtSenha = new JTextField();
		txtSenha.setBounds(86, 78, 135, 20);
		contentPane.add(txtSenha);
		txtSenha.setColumns(10);
		
		JButton btnLogar = new JButton("Login");
		btnLogar.setBounds(102, 125, 89, 23);
		contentPane.add(btnLogar);
		
		ActionListener chamadaLogin = new ControleLogin(txtUsuario, txtSenha);
		btnLogar.addActionListener(chamadaLogin);
		
	}
}
