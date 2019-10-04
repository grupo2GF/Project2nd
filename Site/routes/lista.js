// não mexa nestas 3 linhas!
var express = require('express');
var router = express.Router();
var banco = require('../app-banco');
// não mexa nessas 3 linhas!

router.get('/servidor', function (req, res, next) {
    console.log(banco.conexao);
    banco.conectar().then(() => {
      return banco.sql.query(`select loginServidor, linkServidor, situacaoServidor from tbServidor`);
    }).then(consulta => {
  
      console.log(`Resultado da consulta de serviços: ${JSON.stringify(consulta.recordset)}`);
  
      if (consulta.recordset.length == 0) {
        res.status(404).send('Nenhum serviço encontrado');
      } else {
        res.send(consulta.recordset);
      }
  
    }).catch(err => {
  
      var erro = `Erro na pesquisa de serviços: ${err}`;
      console.error(erro);
      res.status(500).send(erro);
  
    }).finally(() => {
      banco.sql.close();
    });
  
  });
  
  
// não mexa nesta linha!
module.exports = router;
