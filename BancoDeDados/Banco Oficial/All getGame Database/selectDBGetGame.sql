select * from tbUsuario;
select * from tbServidor;
select * from tbAcesso;
select * from tbStatusServidor;
select * from tbProcessoServidor;

select codAuditoria, codServidor, tbAuditada as 'Tabela Auditada', tbCamposAuditados as 'Campos alterados',
tipoacao as 'Tipo de ação', datahoraauditoria as 'Data e Hora da alteração', codUsuario, nomeUsuario as 'Nome do Funcionario'
 from tbAuditoria;

 use getGame;
 select s.codServidor, s.loginServidor, s.linkServidor, u.codUsuario, u.nomeUsuario from tbServidor as s
                                inner join tbAcesso as a on (s.codServidor = a.codServidor)
                                    inner join tbUsuario as u on (a.codUsuario = u.codUsuario)
                                      where u.nomeUsuario like 'Regino';


select s.codServidor, s.loginServidor, s.linkServidor, u.codUsuario, u.nomeUsuario from tbServidor as s
                                inner join tbAcesso as a on (s.codServidor = a.codServidor)
                                    inner join tbUsuario as u on (a.codUsuario = u.codUsuario)
                                      where u.nomeUsuario like 'Eduardo' or (select permissaoUsuario from tbUsuario as us where us.nomeUsuario like 'Eduardo') like 'true';

									  select linkServidor from tbServidor where (select permissaoUsuario from tbUsuario as us where us.nomeUsuario like 'Eduardo') = 1;


									  select s.codServidor, s.loginServidor, s.linkServidor, u.codUsuario, u.nomeUsuario from tbServidor as s
                                inner join tbAcesso as a on (s.codServidor = a.codServidor)
                                    inner join tbUsuario as u on (a.codUsuario = u.codUsuario)
                                      where u.nomeUsuario like 'cliente' or (select permissaoUsuario from tbUsuario as us where us.nomeUsuario like u.nomeUsuario) = 1;
									  select permissaoUsuario from tbUsuario as us where us.nomeUsuario like 'cliente';