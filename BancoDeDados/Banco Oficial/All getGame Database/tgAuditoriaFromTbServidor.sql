create trigger auditoria on tbServidor
after insert
as
    begin
        declare
		@codServidor int,
        @nomeServidor varchar(100),
		@loginUsuario varchar(100),
		@codUsuario int,
		@nomeFuncionario varchar(100)

        select @codServidor = i.codServidor, @nomeServidor = i.loginServidor, @codUsuario = i.codUsuario, @nomeFuncionario = f.nomeFuncionario from inserted as i
			inner join tbUsuario as u on (u.codUsuario = i.codUsuario)
				inner join tbFuncionario as f on (f.codFuncionario = u.codFuncionario)
        insert into tbAuditoria
            values(@codServidor, 'tbServidor' , 'INSERT', 'Link do Servidor | Nome do Servidor', getdate(), @codUsuario, @nomeFuncionario)
    end
go
