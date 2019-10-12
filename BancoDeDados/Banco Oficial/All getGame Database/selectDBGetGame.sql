select * from tbFuncionario;
select * from tbUsuario;
select * from tbServidor;
select * from tbAcesso;
select * from tbStatusServidor;
select * from tbProcessoServidor;
select codAuditoria, codServidor, tbAuditada as 'Tabela Auditada', tbCamposAuditados as 'Campos alterados',
tipoacao as 'Tipo de ação', datahoraauditoria as 'Data e Hora da alteração', codUsuario, nomeFuncionario as 'Nome do Funcionario'
 from tbAuditoria;