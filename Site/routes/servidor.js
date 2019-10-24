// não mexa nestas 3 linhas!
var express = require('express');
var router = express.Router();
var banco = require('../app-banco');
// não mexa nessas 3 linhas!

router.post('/ListarServidorAdm', function (req, res, next) {
  var usuario = req.body.usuario;
  console.log(usuario);
  console.log(banco.conexao);
  banco.conectar().then(() => {
    return banco.sql.query(`select codServidor, loginServidor, linkServidor from tbServidor`);
  }).then(consulta => {

    console.log(`Resultado da consulta de servidores: ${JSON.stringify(consulta.recordset)}`);

    if (consulta.recordset.length == 0) {
      res.status(404).send('Nenhum servidor encontrado');
    } else {
      res.send(consulta.recordset);
    }

  }).catch(err => {

    var erro = `Erro na pesquisa de servidores: ${err}`;
    console.error(erro);
    res.status(500).send(erro);

  }).finally(() => {
    banco.sql.close();
  });

});


router.post('/ListarServidor', function (req, res, next) {
    var usuario = req.body.usuario;
    console.log(usuario);
    console.log(banco.conexao);
    banco.conectar().then(() => {
      return banco.sql.query(`select s.codServidor, s.loginServidor, s.linkServidor from tbServidor as s
                                inner join tbAcesso as a on (s.codServidor = a.codServidor)
                                    inner join tbUsuario as u on (a.codUsuario = u.codUsuario)
                                      where u.nomeUsuario like '${usuario}'`);
    }).then(consulta => {
  
      console.log(`Resultado da consulta de servidores: ${JSON.stringify(consulta.recordset)}`);
  
      if (consulta.recordset.length == 0) {
        res.status(404).send('Nenhum servidor encontrado');
      } else {
        res.send(consulta.recordset);
      }
  
    }).catch(err => {
  
      var erro = `Erro na pesquisa de servidores: ${err}`;
      console.error(erro);
      res.status(500).send(erro);
  
    }).finally(() => {
      banco.sql.close();
    });
  
  });

  router.post('/cadastrar', function (req, res, next) {

    var link;
    var login;
    var senha;
    var usuario;
    var cadastro_valido = false;
  
    banco.conectar().then(() => {
      console.log(`Chegou p/ cadastro: ${JSON.stringify(req.body)}`);
      login = req.body.nomeServidor; // depois de .body, use o nome (name) do campo em seu formulário de login
      senha = req.body.senhaServidor; // depois de .body, use o nome (name) do campo em seu formulário de login
      link = req.body.linkServidor;
      usuario = req.body.nomeUsuario;
      if (login == undefined || senha == undefined || link == undefined || usuario == undefined) {
      // coloque a frase de erro que quiser aqui. Ela vai aparecer no formulário de cadastro
        throw new Error(`Dados de cadastro não chegaram completos: ${login} / ${senha} / ${link}/ ${usuario}`);
      }
      return banco.sql.query(`select count(*) as contagem from tbServidor where linkServidor = '${link}'`);
    }).then(consulta => {
  
    if (consulta.recordset[0].contagem >= 1) {
      res.status(400).send(`Já existe Servidor com o link "${link}"`);
      return;
      } else {
      console.log('válido!');
      cadastro_valido = true;
    }
  
    }).catch(err => {
  
      var erro = `Erro no cadastro: ${err}`;
      console.error(erro);
      res.status(500).send(erro);
  
    }).finally(() => {
      if (cadastro_valido) {		  
          
        banco.sql.query(`insert into tbServidor (loginServidor, linkServidor, senhaServidor, codUsuario) values ('${login}','${link}','${senha}'
          , (select codUsuario from tbUsuario where nomeUsuario = '${usuario}'))`).then(function() {
        console.log(`Servidor cadastrado com sucesso!`);
        res.sendStatus(201); 
        // status 201 significa que algo foi criado no back-end, 
          // no caso, um registro de usuário ;)		
      }).catch(err => {
  
        var erro = `Erro no cadastro: ${err}`;
        console.error(erro);
        res.status(500).send(erro);
  
      }).finally(() => {
        banco.sql.close();
      });
      }
    });
    
  
  });
  
  
  
// não mexa nesta linha!
module.exports = router;
