var express = require('express');
var bodyParser = require("body-parser"); 
var realizarQuery = require('../modulos/conexion').realizarQuery;

var router = express.Router();
var urlEncodeParser = bodyParser.urlencoded({
  extended: false
});

router.use(bodyParser.json());

router.post("/getTiendas", urlEncodeParser, function(request, response){
    var sql = "SELECT codEmpresa, nombreEmpresa from tblempresas where codUsuario = ?";
    var values = [request.body.codigoUsuario];
    realizarQuery(sql,values, function(res){
      response.send(res);
    });
});

router.post("/guardarArticulo", urlEncodeParser, function(request, response){
  var sql = "INSERT INTO tblarticulos("
                            +"codArticulo, "
                            +"nombreArticulo, "
                            +"descripcion, "
                            +"precio, "
                            +"origenFabricacion, "
                            +"saldo, "
                            +"fechaPublicacion, "
                            +"estado, "
                            +"codCategoria, "
                           +" codUsuarioPublicador "
                          +") "
                +" VALUES (null,?,?,?,'Honduras',?,'NOW()',?,?,?)";
  var values = [ 
                request.body.nombreArticulo, 
                request.body.descripcion, 
                request.body.precio,  
                request.body.saldo,  
                request.body.estado, 
                request.body.codCategoria, 
                request.body.codUsuarioPublicador 
              ];
  realizarQuery(sql, values, function(res){
    response.send(res);
  })
});

router.get("/getTiendas", function(request, response){
    var sql = "SELECT codEmpresa, nombreEmpresa from tblempresas where codUsuario = 2";
    var values = [request.query.codigoUsuario];
    realizarQuery(sql,values, function(res){
      response.send(res);
    });
});

module.exports = router;