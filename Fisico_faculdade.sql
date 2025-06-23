create database db_faculdade;
use db_faculdade;


create table tbl_Aluno (
		id int not null primary key auto_increment,
        nome varchar(45) not null,
        cpf varchar(14) not null,
        data_nasc date not null,
        
        unique index(id, cpf)
    );
    
create table tbl_Professor (
		id int not null auto_increment primary key,
        cpf varchar(14) not null,
        nome varchar(45) not null,
        
        unique index(id, cpf)
	);
    
create table tbl_Curso (
		id int not null auto_increment primary key,
        nome varchar(45) not null,
        carga_horaria int not null,
        
        unique index(id)
	);
    
create table tbl_Disciplina (
		id int not null auto_increment primary key,
        nome varchar(45) not null,
        carga_horaria int not null,
        
        unique index(id)
	);

create table tbl_Endereco (
		id int not null auto_increment primary key,
        logradouro varchar(45) not null,
        bairro varchar(45) not null,
        cep varchar(10) not null,
        cidade varchar(45) not null,
        estado varchar(20) not null,
        id_Aluno int not null,
        
		constraint FK_Aluno_Endereco
        foreign key (id_Aluno)
        references tbl_Aluno(id),
        
        unique index (id)
	);
    
create table tbl_Telefone_aluno (
		id int not null auto_increment primary key,
        telefone varchar(20) not null,
        id_Aluno int not null,
        
        constraint FK_Aluno_Telefone_aluno
        foreign key (id_Aluno)
        references tbl_Aluno(id),
        
        unique index (id)
	);
    
create table tbl_Email_aluno (
		id int not null auto_increment primary key,
        email varchar(60) not null,
        id_Aluno int not null,
        
        constraint FK_Aluno_Email_aluno
        foreign key (id_Aluno)
        references tbl_Aluno(id),
        
        unique index (id)
	);
    
create table tbl_Matricula (
		id int not null auto_increment primary key,
        data_entrada date not null,
        id_Aluno int not null,
        id_Curso int not null,
        
        constraint FK_Aluno_Matricula
        foreign key (id_Aluno)
        references tbl_Aluno(id),
        
        constraint FK_Curso_Matricula
        foreign key (id_Curso)
        references tbl_Curso(id),
        
        unique index (id)
	);

create table tbl_Telefone_professor (
		id int not null auto_increment primary key,
        telefone varchar(20) not null,
        id_Professor int not null,
        
        constraint FK_Professor_Telefone_professor
        foreign key (id_Professor)
        references tbl_Professor(id),
        
        unique index (id)
	);
    
create table tbl_Email_professor (
		id int not null auto_increment primary key,
        email varchar(60) not null,
        id_Professor int not null,
        
        constraint FK_Professor_Email_professor
        foreign key (id_Professor)
        references tbl_Professor(id),
        
        unique index (id)
	);
    
create table tbl_Turma (
		id int not null auto_increment primary key,
        modalidade varchar(20) not null,
        horario time not null,
        ano varchar(15) not null,
        semestre varchar(15) not null,
        id_Disciplina int not null,
        id_Professor int not null,
        
        constraint FK_Disciplina_Turma
        foreign key (id_Disciplina)
        references tbl_Disciplina(id),
        
        constraint FK_Professor_Turma
        foreign key (id_Professor)
        references tbl_Professor(id),
        
        unique index (id)
	);
    
create table tbl_Aluno_turma (
		id int not null auto_increment primary key,
        id_Matricula int not null,
        id_Turma int not null,
        
        constraint FK_Matricula_Aluno_turma
        foreign key (id_Matricula)
        references tbl_Matricula(id),
        
        constraint FK_Turma_Aluno_turma
        foreign key (id_Turma)
        references tbl_Turma(id),
        
        unique index (id)
	);
    
create table tbl_Avaliacao (
		id int not null auto_increment primary key,
        nota float not null,
        avaliacao1 float not null,
        avaliacao2 float not null,
        recuperacao float not null,
        frequencia float not null,
        id_Aluno_turma int not null,
        
        constraint FK_Aluno_turma_Avaliacao
        foreign key (id_Aluno_turma)
        references tbl_Aluno_turma(id),
        
        unique index (id)
	);
    
#testes
#alunos
insert into tbl_Aluno (nome, cpf, data_nasc) values 
('João da Silva', '123.456.789-00', '2000-01-15'),
('Ana Costa', '987.654.321-00', '2001-05-22');

insert into tbl_Endereco (logradouro, bairro, cep, cidade, estado, id_Aluno) values
('Rua das Flores', 'Centro', '12345-678', 'São Paulo', 'SP', 1),
('Av. Brasil', 'Jardins', '54321-000', 'Rio de Janeiro', 'RJ', 2);

insert into tbl_Telefone_aluno (telefone, id_Aluno) values
('(11) 99999-8888', 1),
('(21) 98888-7777', 2);

insert into tbl_Email_aluno (email, id_Aluno) values
('joao.silva@email.com', 1),
('ana.costa@email.com', 2);

#professores
insert into tbl_Professor (cpf, nome) values 
('111.222.333-44', 'Maria Oliveira'),
('555.666.777-88', 'Carlos Lima');

insert into tbl_Telefone_professor (telefone, id_Professor) values
('(11) 97777-6666', 1),
('(21) 96666-5555', 2);

insert into tbl_Email_professor (email, id_Professor) values
('maria.oliveira@faculdade.edu', 1),
('carlos.lima@faculdade.edu', 2);

#cursos
insert into tbl_Curso (nome, carga_horaria) values
('Ciência da Computação', 3600),
('Engenharia de Software', 4000);

#Disciplinas
insert into tbl_Disciplina (nome, carga_horaria) values
('Banco de Dados', 60),
('Estrutura de Dados', 60);

#Matriculas
insert into tbl_Matricula (data_entrada, id_Aluno, id_Curso) values
('2025-02-01', 1, 1),
('2025-02-01', 2, 2);

#Turmas
insert into tbl_Turma (modalidade, horario, ano, semestre, id_Disciplina, id_Professor) values
('Presencial', '19:00:00', '2025', '1', 1, 1),
('EAD', '20:00:00', '2025', '1', 2, 2);

#aluno->turma
insert into tbl_Aluno_turma (id_Matricula, id_Turma) values
(1, 1),
(2, 2);

#Avaliacao
insert into tbl_Avaliacao (nota, avaliacao1, avaliacao2, recuperacao, frequencia, id_Aluno_turma) values
(8.0, 7.0, 8.5, 9.0, 95.0, 1),
(6.5, 6.0, 6.5, 7.0, 88.0, 2);

#Visualizando as informações contidas 
SELECT * FROM tbl_Aluno;
SELECT * FROM tbl_Professor;
SELECT * FROM tbl_Disciplina;

#endereco do aluno
SELECT a.nome, e.logradouro, e.bairro, e.cidade, e.estado
FROM tbl_Aluno a
JOIN tbl_Endereco e ON a.id = e.id_Aluno;

#turma do professor
SELECT p.nome AS professor, d.nome AS disciplina, t.modalidade, t.ano, t.semestre
FROM tbl_Professor p
JOIN tbl_Turma t ON p.id = t.id_Professor
JOIN tbl_Disciplina d ON t.id_Disciplina = d.id;

#curso e matricula dos alunos
SELECT a.nome AS aluno, c.nome AS curso, m.data_entrada
FROM tbl_Aluno a
JOIN tbl_Matricula m ON a.id = m.id_Aluno
JOIN tbl_Curso c ON m.id_Curso = c.id;

#alunos e suas notas
SELECT a.nome AS aluno, d.nome AS disciplina, av.nota, av.avaliacao1, av.avaliacao2, av.recuperacao, av.frequencia
FROM tbl_Aluno a
JOIN tbl_Matricula m ON a.id = m.id_Aluno
JOIN tbl_Aluno_turma atur ON m.id = atur.id_Matricula
JOIN tbl_Turma t ON atur.id_Turma = t.id
JOIN tbl_Disciplina d ON t.id_Disciplina = d.id
JOIN tbl_Avaliacao av ON atur.id = av.id_Aluno_turma;

#apenas alunos com nota maior que 7
SELECT a.nome, av.nota
FROM tbl_Aluno a
JOIN tbl_Matricula m ON a.id = m.id_Aluno
JOIN tbl_Aluno_turma atur ON m.id = atur.id_Matricula
JOIN tbl_Avaliacao av ON atur.id = av.id_Aluno_turma
WHERE av.nota > 7
ORDER BY av.nota DESC;