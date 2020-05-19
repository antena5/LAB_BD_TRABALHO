package Model;

public class Login 
{
	private String RG;
	private String Senha;
	
	public Login(String RG, String Senha)
	{
		this.RG = RG;
		this.Senha = Senha;
	}
	public String getRG() 
	{
		return RG;
	}
	public void setRG(String rG) 
	{
		RG = rG;
	}
	public String getSenha() 
	{
		return Senha;
	}
	public void setSenha(String senha) 
	{
		this.Senha = senha;
	}
	@Override
	public String toString()
	{
		return super.toString();
	}
}
