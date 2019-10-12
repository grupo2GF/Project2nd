insert into tbFuncionario
values
('Eduardo', '00000000000'),
('Regino', '00000000000'),
('Saulo', '00000000000'),
('Livia', '00000000000');

insert into tbUsuario
values
('edu', '1234', 1, 1),
('regino', '1234', 2, 1),
('ggGetGame', '1234', 3, 1),
('cliente', '1234', 4, 0);

insert into tbServidor
values
('www.google.com.br', 'google', '1234', 1);

insert into tbStatusServidor
values(50, 50, 150, 'on', '00:00:00', 1, '01:00:00'); 

insert into tbAcesso
values 
(2,1);

insert into tbProcessoServidor
values
('windows', 45,32,1);

select * from tbFuncionario;
select * from tbUsuario;
select * from tbServidor;
select * from tbAcesso;
select * from tbProcessoServidor;
select * from tbStatusServidor;
select * from tbAuditoria;