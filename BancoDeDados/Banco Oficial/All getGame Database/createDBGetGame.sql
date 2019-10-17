create table tbFuncionario (
	  codFuncionario int primary key identity(1,1),
	  nomeFuncionario varchar(40) not null,
	  cpfFuncionario varchar(15) not null
  );

create table tbUsuario (
	  codUsuario int primary key identity(1,1),
	  loginUsuario varchar(40) not null,
	  senhaUsuario varchar(255) not null,
	  codFuncionario int foreign key (codFuncionario) references tbFuncionario (codFuncionario),
	  permissaoUsuario bit not null
  );

create table tbServidor (
	  codServidor int primary key identity(1,1),
	  linkServidor varchar(100) not null,
	  loginServidor varchar(70) not null,
	  senhaServidor varchar(255) not null,
	  codUsuario int foreign key (codUsuario) references tbUsuario(codUsuario)
  );
	
create table tbAcesso (
	codUsuario int foreign key (codUsuario) references tbUsuario(codUsuario),
    codServidor int foreign key (codServidor) references tbServidor(codServidor)
);

create table tbStatusServidor (
	  codStatusServidor int primary key identity(1,1),
	  cpuStatusServidor float not null,
	  ramStatusServidor float not null,
	  discoStatusServidor int not null,
	  situacaoStatusServidor varchar(100) not null,
	  tempoOffStatusServidor time not null,
	  codServidor int foreign key (codServidor) references tbServidor (codServidor),
	  dataHoraStatusServidor date not null
  );

create table tbProcessoServidor (
	  codProcessoServidor int primary key identity(1,1),
	  nomeProcessoServidor varchar(100) not null,
	  cpuProcessoServidor float not null,
	  ramProcessoServidor float not null,
	  codServidor int foreign key (codServidor) references tbServidor (codServidor))
;

create table tbAuditoria (
	  codAuditoria int primary key identity(1,1),
	  codServidor int,
	  tbAuditada varchar(45) null,
	  tipoAcao varchar(45) null,
	  tbCamposAuditados varchar(255),
	  dataHoraAuditoria date null,
	  codUsuario int null,
	  nomeFuncionario varchar(100) null
  );