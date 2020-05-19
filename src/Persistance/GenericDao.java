package Persistance;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GenericDao implements IGenericDao
{
	private Connection cn;
	
	@Override
	public Connection getConnection() throws SQLException
	{
		try 
		{
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
		} 
		catch (ClassNotFoundException e) 
		{
			e.printStackTrace();
		}
		cn = DriverManager.getConnection("jdbc:jtds:sqlserver://127.0.0.1:1433;DatabaseName=siga;namedPipes=true","Rafael","29112000");
		System.out.println("Conectado ao Banco de Dados !");
		return cn;
	}
}
