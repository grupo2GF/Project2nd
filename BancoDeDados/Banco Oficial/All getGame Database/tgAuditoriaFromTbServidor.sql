create trigger auditoria on tbServidor
after insert
as
    begin
        declare
		@codServidor int,
        @nomeServidor varchar(100),
		@codUsuario int,
		@nomeUsuario varchar(100)

        select @codServidor = i.codServidor, @nomeServidor = i.loginServidor, @codUsuario = i.codUsuario, @nomeUsuario = u.nomeUsuario from inserted as i
			inner join tbUsuario as u on (u.codUsuario = i.codUsuario)
        insert into tbAuditoria
            values(@codServidor, 'tbServidor' , 'INSERT', 'Link do Servidor | Nome do Servidor', getdate(), @codUsuario, @nomeUsuario)
    end
go
