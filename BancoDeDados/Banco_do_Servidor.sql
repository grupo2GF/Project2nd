create table tbFuncionario(
    codFuncionario int primary key identity(1,1),
    nomeFuncionario varchar(40) not null,
    cpfFuncionario varchar(15) not null
);

create table tbUsuario(
        codUsuario int primary key identity(1,1),
        loginUsuario varchar(40) not null,
        senhaUsuario varchar(255) not null,
        codFuncionario int foreign key (codFuncionario) references tbFuncionario(codFuncionario)
);

create table tbServidor(
    codServidor int primary key identity(1,1),
    linkServidor varchar(100) not null,
    loginServidor varchar(70) not null,
    senhaServidor varchar(255) not null,
	situacaoServidor varchar(100) not null
);
    
    
create table tbStatusServidor(
    codStatusServidor int primary key identity(1,1),
    cpuStatusServidor float not null,
    ramStatusServidor float not null,
    discoStatusServidor int not null,
    codServidor int foreign key (codServidor) references tbServidor(codServidor)
);

create table tbProcessoServidor(
	codProcessoServidor int primary key identity(1,1),
	nomeProcessoServidor varchar(100) not null,
	cpuProcessoServidor float not null,
	ramProcessoServidor float not null,
	codServidor int foreign key (codServidor) references tbServidor(codServidor)
	)

insert into tbFuncionario values
('Eduardo Kauan', '99999999999'),
('Regino Trindade', '98798798740'),
('Livia Nakashima', '78978978940');

insert into tbUsuario values
('Edu', '987654321', 1),
('Regino', '123456789', 2),
('Livia', '123459876', 3);

insert into tbServidor values
('regino.database.windows.net', 'bandtec', 'senhaqualquer', 'on');

insert into tbStatusServidor values
(10, 10, 1000, 1);

insert into tbProcessoServidor values
('Redmi', 80.0, 80.0, 1);

select * from tbFuncionario;
select * from tbUsuario;
select * from tbServidor;
select * from tbStatusServidor;
select * from tbProcessoServidor;