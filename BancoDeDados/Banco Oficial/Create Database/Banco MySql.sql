create database teste;
use teste;

create table tbFuncionario (
  codFuncionario int primary key auto_increment,
  nomeFuncionario varchar(40) not null,
  cpfFuncionario varchar(15) not null
  )auto_increment = 1;

create table tbUsuario (
  codUsuario int primary key auto_increment,
  loginUsuario varchar(40) not null,
  senhaUsuario varchar(255) not null,
  codFuncionario int,
  foreign key (codFuncionario) references tbFuncionario (codFuncionario),
  permissaoUsuario boolean not null
  )auto_increment = 1;

create table tbServidor (
  codServidor int primary key auto_increment,
  linkServidor varchar(100) not null,
  loginServidor varchar(70) not null,
  senhaServidor varchar(255) not null
  )auto_increment = 1;

create table tbServidor_has_tbUsuario (
	codUsuario int,
    foreign key (codUsuario) references tbUsuario(codUsuario),
    codServidor int,
    foreign key (codServidor) references tbServidor(codServidor)
);

create table tbStatusServidor (
  codStatusServidor int primary key auto_increment,
  cpuStatusServidor float not null,
  ramStatusServidor float not null,
  discoStatusServidor int not null,
  situacaoStatusServidor varchar(100) not null,
  tempoOffStatusServidor time not null,
  codServidor int,
  foreign key (codServidor) references tbServidor (codServidor),
  dataHoraStatusServidor date not null
  )auto_increment = 1;

create table tbProcessoServidor (
  codProcessoServidor int primary key auto_increment,
  nomeProcessoServidor varchar(100) not null,
  cpuProcessoServidor float not null,
  ramProcessoServidor float not null,
  codServidor int,
  foreign key (codServidor) references tbServidor (codServidor))
auto_increment = 1;

create table tbAuditoria (
  codAuditoria int not null,
  tbAuditada varchar(45) null,
  tipoAcao varchar(45) null,
  camposAuditados varchar(45) null,
  dataHoraAuditoria date null,
  codUsuario int null,
  nomeFuncionario varchar(100) null
  );