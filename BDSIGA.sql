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
create  procedure sp_Pesos
@disci_codigo        int,
@aval_codigo         int,
@aval_tipo            char(2),
@aval_peso            decimal(3,2),
@op                    CHAR(1)
as
begin
    if(UPPER(@op)='I')
    begin
        if(@aval_tipo is null OR @aval_peso is null OR @op is null or not exists(select disci_codigo from disciplina where disci_codigo = @disci_codigo))
            begin
            RAISERROR('Valores Inválidos ou Já Existentes', 16, 1)
            end
        else
        begin
            insert into avaliacao(aval_codigo,aval_tipo, aval_peso) values (@aval_codigo,@aval_tipo, @aval_peso)
        end
    end
    else
    begin
        if(UPPER(@op)='U')
        begin
        update avaliacao set aval_tipo  = @aval_tipo, aval_peso = @aval_peso where aval_tipo = @aval_tipo
        end
    end
end
--INSERE OS PESOS PARA CADA AVALIAÇÃO PARA CADA DISCIPLINA
--DISICPLINA, TIPO DE AV, PESO, OPÇÃO I = INSERE OU U = ATUALIZA

exec sp_Pesos 2,2,'P3', 0.2, 'i'
exec sp_Pesos 1,1,'P1', 0.22, 'i'
exec sp_Pesos 4,3,'P2', 0.35, 'i'
exec sp_Pesos 5,4,'MO', 0.85, 'i'
exec sp_Pesos 3,2,'MG', 0.8, 'i'
/*
select  av.aval_peso, av.aval_tipo, dc.disci_nome from avaliacao av inner join notas nt
on av.aval_codigo = nt.aval_codigo
inner join disciplina dc
on dc.disci_codigo = nt.disci_codigo
*/

--SELECT FEITO COM A CREATE VIEW CRIADA ABAIXO
SELECT * FROM avaliacao


--PROCEDURE CRIADA PARA INSERÇÃO DE NOTAS PARA CADA ALUNO DE CADA DISCIPLINA
create  procedure sp_Notas
@aluno_ra		 int,
@disci_codigo	 int,
@aval_codigo	 int,
@nota			 int
as
begin
		insert into notas values (@aluno_ra, @disci_codigo, @aval_codigo, @nota)
		declare @peso decimal(2,2), @media decimal(3,2)
end
--INSERE NOTAS SENDO RA, DISCIPLINA, TIPO DE AV, NOTA
exec sp_Notas 1458831, 0, 1, 9
exec sp_Notas 1459890, 1, 2, 8
exec sp_Notas 1450091, 2, 3, 7
exec sp_Notas 1456089, 1, 4, 2

--SELECT FEITO A PARTIR DE UMA CREATE VIEW MAIS ABAIXO
select * from notas
select * from NOTA_aluno where DISCIPLINA = 'COMERCIO EXTERIOR'
SELECT * FROM NOTA_aluno where DISCIPLINA = 'ANALISE E DESENVOLVIMENTO DE SOFTWARE'


--VISUALIZAÇÃO PREDEFINIDA COM VIEWS
create view Avaliacoes
as
select aval_tipo as 'Tipo', aval_peso as 'Peso' from avaliacao

create view NOTA_aluno
AS
select al.aluno_ra as 'RA', al.aluno_nome as 'NOME', dc.disci_nome as 'DISCIPLINA', aval_tipo as 'AVALIAÇÃO', nt.nota as 'NOTA' from aluno al inner join notas nt
on al.aluno_ra = nt.aluno_ra
inner join disciplina dc
on nt.disci_codigo = dc.disci_codigo
inner join avaliacao av
on nt.aval_codigo = av.aval_codigo



-- QUESTÃO B
create  procedure sp_faltas
@aluno_ra int, 
@disci_cod int,
@disci_numaulas int,
@faltas smallint
as
	begin
	declare @falta_dia	datetime 
	 set @falta_dia = getdate()
		if(@disci_numaulas = 80 and @faltas <= 4)
			begin 
				insert into faltas(aluno_ra,disci_codigo,falta_dia,faltas_presencas) VAlues (@aluno_ra,@disci_cod,@falta_dia,@faltas)
			end
		if(@disci_numaulas = 40 and @faltas <= 2)
			begin 
				insert into faltas(aluno_ra,disci_codigo,falta_dia,faltas_presencas) VAlues (@aluno_ra,@disci_cod,@falta_dia,@faltas)
			end
	end


/* c) Apresentar em tela, a saída de uma UDF, com cursor, que apresenta um quadro com as notas da turma:  */
/* (RA_Aluno, Nome_Aluno, Nota1, Nota2, ..., Média_Final, Situação(Aprovado ou Reprovado)) */

/* d) Apresentar, em tela, a saída de uma UDF, com cursor, que apresenta um quadro com as faltas da turma, sendo que, para cada data deverá haver um F por falta e um P por presença: */
/* (RA_Aluno, Nome_Aluno, Data1, Data2, ..., Total_Faltas)  */

/* e) Apresentar, em browser se Web ou abrir o arquivo , se desktop, um relatório em PDF da mesma UDF da saída de tela de notas */

/* f) Apresentar, em browser se Web ou abrir o arquivo , se desktop,  um relatório em PDF da mesma UDF da saída de tela de faltas */

/* g) Fazer um gatilho que identifique se uma disciplina estiver sendo atualizada ou excluída, lance um erro e não permita que a operação ocorra */

CREATE TRIGGER t_block on disciplina
for Update , Delete
as
begin
	declare
	@aux int
	set @aux =(select count(*) from deleted)
	if(@aux>0)
		BEGIN	
					ROLLBACK TRANSACTION
					RAISERROR ('Não é permitido alterar ou excluir as disciplinas ',16,2)
		end
end

INSERT INTO disciplina(codigo,nome, sigla, turno, numaulas) 
VALUES (0, 'ANALISE E DESENVOLVIMENTO DE SOFTWARE', 'ADS', 'T', 80),
	   (1, 'COMERCIO EXTERIOR', 'COM', 'N', 80),
	   (2, 'POLIMEROS', 'POL', 'M', 80),
	   (3, 'LOGISTICA', 'LOG', 'T', 80)

delete disciplina where codigo = 1

select * from disciplina



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
		
		

