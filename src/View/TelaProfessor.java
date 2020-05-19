package View;

import java.awt.Choice;
import java.awt.Color;
import java.awt.EventQueue;
import java.awt.Font;
import java.awt.Panel;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

import Model.Login;
import javafx.stage.Stage;

public class TelaProfessor extends JFrame 
{
	private static final long serialVersionUID = 1L;
	private JPanel contentPane;

	public static void main(String[] args)
	{
		EventQueue.invokeLater(new Runnable() 
		{
			public void run() 
			{
				try 
				{
					TelaProfessor frame = new TelaProfessor();
					frame.setVisible(true);
				} 
				catch (Exception e) 
				{
					e.printStackTrace();
				}
			}
		});
	}
	public TelaProfessor() 
	{
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 660, 375);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBackground(Color.WHITE);
		panel.setBounds(10, 11, 624, 79);
		contentPane.add(panel);
		panel.setLayout(null);
		
		JLabel lblBemVindo = new JLabel("Seja Bem Vindo ");
		lblBemVindo.setFont(new Font("Arial", Font.BOLD, 23));
		lblBemVindo.setBounds(232, 11, 180, 28);
		panel.add(lblBemVindo);
		
		JLabel lblNomeProf = new JLabel("");
		lblNomeProf.setFont(new Font("Arial", Font.BOLD, 18));
		lblNomeProf.setBounds(270, 50, 95, 14);
		panel.add(lblNomeProf);
		
		JPanel panel_1 = new JPanel();
		panel_1.setBackground(Color.WHITE);
		panel_1.setBounds(99, 101, 450, 193);
		contentPane.add(panel_1);
		panel_1.setLayout(null);
		
		Choice EscolhaCurso = new Choice();
		EscolhaCurso.setBounds(143, 36, 200, 32);
		panel_1.add(EscolhaCurso);
		
		JLabel lvlCurso = new JLabel("Curso :");
		lvlCurso.setBounds(82, 42, 42, 14);
		panel_1.add(lvlCurso);
		
		JLabel lblMateria = new JLabel("Mat\u00E9ria :");
		lblMateria.setBounds(82, 80, 55, 14);
		panel_1.add(lblMateria);
		
		Choice EscolhaMateria = new Choice();
		EscolhaMateria.setBounds(143, 74, 200, 20);
		panel_1.add(EscolhaMateria);
		
		JLabel lblTurno = new JLabel("Turno :");
		lblTurno.setBounds(82, 120, 46, 14);
		panel_1.add(lblTurno);
		
		Choice EscolhaTurno = new Choice();
		EscolhaTurno.setBounds(143, 114, 200, 20);
		panel_1.add(EscolhaTurno);
		
		JButton btnSelecionar = new JButton("Confirmar");
		btnSelecionar.addActionListener(new ActionListener() 
		{
			public void actionPerformed(ActionEvent arg0) 
			{
				
			}
		});
		btnSelecionar.setBounds(129, 155, 103, 23);
		panel_1.add(btnSelecionar);
		
		JButton btnSair = new JButton("Sair");
		btnSair.addActionListener(new ActionListener() 
		{
			public void actionPerformed(ActionEvent arg0)
			{
				new TelaLogin().setVisible(true);;
				dispose();
			}
		});
		btnSair.setBounds(254, 155, 103, 23);
		panel_1.add(btnSair);
		
		Panel panel_2 = new Panel();
		panel_2.setBackground(Color.WHITE);
		panel_2.setBounds(0, 316, 644, 20);
		contentPane.add(panel_2);
		
		JLabel lblRodape = new JLabel("SIGA V2 - Todos os Direitos Reservados");
		panel_2.add(lblRodape);
	}
}
