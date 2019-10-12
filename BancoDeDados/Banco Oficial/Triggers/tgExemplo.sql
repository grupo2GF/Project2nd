create trigger auditoria on tbServidor
after insert
as
    begin
        declare
        @servidor varchar(100),
        @nomeServidor varchar(100)

        select @servidor = linkServidor, @nomeServidor = loginServidor from inserted
        insert into tbServidorMonitora
            values('INSERT', @servidor, @nomeServidor)
    end
go
