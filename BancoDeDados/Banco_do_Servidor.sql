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
    senhaServidor varchar(255) not null
);
    
    
create table tbStatusServidor(
    codStatusServidor int primary key identity(1,1),
    cpuStatusServidor int not null,
    ramStatusServidor int not null,
    discoStatusServidor int not null,
    codServidor int foreign key (codServidor) references tbServidor(codServidor)
);

insert into tbFuncionario values
('Eduardo Kauan', '99999999999'),
('Regino Trindade', '98798798740'),
('Livia Nakashima', '78978978940');

insert into tbUsuario values
('Edu', '987654321', 1),
('Regino', '123456789', 2),
('Livia', '123459876', 3);

insert into tbServidor values
('regino.database.windows.net', 'bandtec', 'senhaqualquer');

insert into tbStatusServidor values
(10, 10, 1000, 1);

select * from tbFuncionario;
select * from tbUsuario;
select * from tbServidor;
select * from tbStatusServidor;