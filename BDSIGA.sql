CREATE DATABASE siga
go
use siga
go

create table aluno 
(
	ra int not null primary key,
	nome varchar(100) not null
)
go

create table disciplina
(
	codigo int not null primary key,
	nome varchar(50) not null,
	sigla varchar(10) not null,
	turno char(1) not null,
	numaulas int not null
)
go

CREATE TABLE avaliacao
(
	codigo int identity(1,1) not null primary key,
	tipo char(2) not null,
	peso int not null
)
go

CREATE TABLE faltas 
(
	aluno_ra int not null,
	disci_codigo int not null,
	data datetime not null,
	presencas nchar(1) not null,
	Primary key (aluno_ra,disci_codigo,data),
	FOREIGN KEY (aluno_ra) references aluno(ra),
	FOREIGN KEY (disci_codigo) references disciplina(codigo)
)
go

CREATE TABLE notas 
(
	aluno_ra int not null,
	disci_codigo int not null,
	aval_codigo int not null,
	nota decimal(2,1)not null,
	Primary key (aluno_ra,disci_codigo,aval_codigo),
	FOREIGN KEY (aluno_ra) references aluno(ra),
	FOREIGN KEY (disci_codigo) references disciplina(codigo),
	FOREIGN KEY (aval_codigo) references avaliacao(codigo)
)
go

/* a) Fazer o sistema, com Stored Procedure para inserção de notas e pesos;  */
	
/* b) Fazer o sistema com Stored Procedure para inserção de faltas; */

/* c) Apresentar em tela, a saída de uma UDF, com cursor, que apresenta um quadro com as notas da turma:  */
/* (RA_Aluno, Nome_Aluno, Nota1, Nota2, ..., Média_Final, Situação(Aprovado ou Reprovado)) */

/* d) Apresentar, em tela, a saída de uma UDF, com cursor, que apresenta um quadro com as faltas da turma, sendo que, para cada data deverá haver um F por falta e um P por presença: */
/* (RA_Aluno, Nome_Aluno, Data1, Data2, ..., Total_Faltas)  */

/* e) Apresentar, em browser se Web ou abrir o arquivo , se desktop, um relatório em PDF da mesma UDF da saída de tela de notas */

/* f) Apresentar, em browser se Web ou abrir o arquivo , se desktop,  um relatório em PDF da mesma UDF da saída de tela de faltas */

/* g) Fazer um gatilho que identifique se uma disciplina estiver sendo atualizada ou excluída, lance um erro e não permita que a operação ocorra */

create table logar
(
	RG varchar(9) primary key not null,
	senha varchar(30) not null
)
go

insert into logar values ('54633281X', 'admin')

create procedure sp_validaLogin(@RG varchar(9), @senha varchar(30), @Resultado varchar(30)output)
as
Declare
	@validaRG varchar(9),
	@validaSenha varchar(30)
	Set @validaRG = (select RG from logar where RG = @RG)
	Set @validaSenha = (select senha from logar where senha = @senha)
	if(@RG = @validaRG)
	Begin
		if(@senha = @validaSenha)
			Begin
				Set @Resultado = 'Conectado!'
			End
	End
	else
	Begin
		Set @Resultado = 'Usuário / Senha incorretos !'
	End
		
		

