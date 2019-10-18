// não mexa nestas 3 linhas!
var express = require('express');
var router = express.Router();
var banco = require('../app-banco');
// não mexa nessas 3 linhas!

router.get('/ListarUsuario', function (req, res, next) {
    console.log(banco.conexao);
    banco.conectar().then(() => {
      return banco.sql.query(`select codUsuario, nomeUsuario, cpfUsuario, permissaoUsuario from tbUsuario`);
    }).then(consulta => {
  
      console.log(`Resultado da consulta de Usuarios: ${JSON.stringify(consulta.recordset)}`);
  
      if (consulta.recordset.length == 0) {
        res.status(404).send('Nenhum Usuario encontrado');
      } else {
        res.send(consulta.recordset);
      }
  
    }).catch(err => {
  
      var erro = `Erro na pesquisa de Usuarios: ${err}`;
      console.error(erro);
      res.status(500).send(erro);
  
    }).finally(() => {
      banco.sql.close();
    });
  
  });

  router.post('/cadastrar', function (req, res, next) {

    var nome;
    var cpf;
    var senha;
    var permissao;
    var cadastro_valido = false;
  
    banco.conectar().then(() => {
      console.log(`Chegou p/ cadastro: ${JSON.stringify(req.body)}`);
      nome = req.body.nomeFuncionario; // depois de .body, use o nome (name) do campo em seu formulário de login
      cpf = req.body.CPFFuncionario; // depois de .body, use o nome (name) do campo em seu formulário de login
      senha = req.body.senhaFuncionario;
      permissao = req.body.permissaoFuncionario;
      usuario = req.body.nomeUsuario;
      if (nome == undefined || senha == undefined || cpf == undefined || usuario == undefined || permissao == undefined) {
      // coloque a frase de erro que quiser aqui. Ela vai aparecer no formulário de cadastro
        throw new Error(`Dados de cadastro não chegaram completos: ${nome} / ${cpf} / ${senha}/ ${permissao}`);
      }
      return banco.sql.query(`select count(*) as contagem from tbUsuario where nomeUsuario = '${nome}'`);
    }).then(consulta => {
  
    if (consulta.recordset[0].contagem >= 1) {
      res.status(400).send(`Já existe Usuários com esse nome "${nome}"`);
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
          
      banco.sql.query(`insert into tbUsuario (nomeUsuario, cpfUsuario, senhaUsuario, permissaoUsuario) values ('${nome}','${cpf}','${senha}'
        , ${permissao})`).then(function() {
        console.log(`Usuário cadastrado com sucesso!`);
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
