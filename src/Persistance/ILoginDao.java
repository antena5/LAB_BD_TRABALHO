package Persistance;

import java.sql.SQLException;
import Model.Login;

public interface ILoginDao 
{
	public String consultaLogin(Login l) throws SQLException;
}
