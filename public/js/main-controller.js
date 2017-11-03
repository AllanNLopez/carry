var array;

/*
$(document).ready(function(){
  $('[data-toggle="popover"]').popover();




});
*/

/*   funciones para ocultar y aparecer el sidebar  */
if (screen.width < 480) {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("main").style.marginLeft = "0";
} else {
    $('#close-link').addClass('hidden');
    $('#btnOpciones').addClass('hidden');
}

function openNav() {
    if (screen.width < 480) {
        document.getElementById("mySidenav").style.width = "100%";
        document.getElementById("mySidenav").style.height = "100%";
        document.getElementById("mySidenav").style.position = "fixed";
        //document.getElementById("main").style.marginLeft = "250px";
        //document.getElementById("main").style.display = "none";
    } else {
        document.getElementById("mySidenav").style.width = "250px";
        document.getElementById("main").style.marginLeft = "250px";
        document.getElementById("mySidenav").style.height = "auto";
    }
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("main").style.marginLeft = "0";
    //document.getElementById("main").style.display = "block";
    $("#mySidenav").removeClass("sidenav-small");
}

/*
 * La funcion validarCampo sirve para comparar el valor de un input con el de una
 * expresion regular. Los campos validados son los que pertenecen a las formas
 * por ejemplo, nombre, apellido, correo etc.
 */

function validarCampo(valor, tipoCampo, id) {
    var input = valor;
    var id = '#' + id;
    var is_correct;

    switch (tipoCampo) {
        case 'nombre':
            is_correct = /^[A-Za-z\'\s\.\,]+$/.test(input);
            break;
        case 'apellido':
            is_correct = /^[A-Za-z\'\s\.\,]+$/.test(input);
            break;
        case 'id':
            if (/\d{4}-\d{4}-\d{5}/.test(input) && (input.length == 15)) {
              is_correct = true;
            }
            else {
              is_correct = false;
            }
            break;
        case 'fecha':
            if (input) {
                is_correct = true;
                //alert(input);
            } else {
                is_correct = false;
                //  alert(input);
            }
            break;
        case 'phone':
            is_correct = /^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/.test(input);
            break;
        case 'email':
            is_correct = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/.test(input);
            break;
        case 'domicilio':
            if (input !== '') {
                is_correct = true;
            } else {
                is_correct = false;
            }
            break;
        case 'password':
            var passwordConfirm = id + 'Confirm';
            /*
             * Esta expresion regular admite contraseñas con los siguientes parametros:
             * At least one upper case English letter, (?=.*?[A-Z])
             * At least one lower case English letter, (?=.*?[a-z])
             * At least one digit, (?=.*?[0-9])
             * At least one special character, (?=.*?[#?!@$%^&*-])
             * Minimum eight in length .{8,} (with the anchors)
             */
            is_correct = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/.test(input);
            if (input == $(passwordConfirm).val() && is_correct) {
                $(passwordConfirm).removeClass("invalid").addClass("valid");
            } else {
                $(passwordConfirm).removeClass("valid").addClass("invalid");
                is_correct = false;
            }
            break;
        case 'rtn':
            if (/\d{4}-\d{4}-\d{6}/.test(input) && (input.length == 16)) {
              is_correct = true;
            }
            else {
              is_correct = false;
            }
            break;
        case 'website':
            is_correct = /^(http\:\/\/|https\:\/\/)?([a-z0-9][a-z0-9\-]*\.)+[a-z0-9][a-z0-9\-]*$/.test(input);
            break;
        default:
            break;
    }

    if (is_correct) {
        $(id).removeClass("invalid").addClass("valid");
    } else {
        $(id).removeClass("valid").addClass("invalid");
    }
    // modificando funcion para retonar el valor y aplicarlo para futuras soluciones
    return is_correct;
}

/*
 * La funcion validarSelect se utiliza en los campos que tienen una opcion
 * default al momento de cargar el formularo, por ejemplo, Dia, Mes, Año, etc.
 */
function validarSelect(id) {
    var id = '#' + id;
    var input = $(id).val();
    if (input === 'Seleccione oferta laboral' || input === 'Seleccione un rubro o actividad') {
        $(id).removeClass("valid").addClass("invalid");
    } else {
        $(id).removeClass("invalid").addClass("valid");
    }
}
/*-----------------------Funcion para SUMBIT las forms------------------------*/
function submitForm(formulario, tipoFormulario) {
    var id = '#' + formulario;
    var id2;
    console.log(id);
    var form_data = $(id).serializeArray();
    console.log(form_data);
    var suma = 0;

    for (var input in form_data) {
        var element = $("#" + form_data[input]['name']);
        var valid = element.hasClass("valid");
        if (!valid) {
            suma++;
        }
    }

    if (id == '#formularioEmpresa2') {
        suma = suma + validarForm('formularioEmpresa');
        id2= '#formularioEmpresa';
    }

    if (suma === 0) {
        $('#mensajeError').hide();
    } else {
        $('#mensajeError').show();
    }

    var valid = $('#checkTermino').is(':checked');
    if (!valid) {
        $('#mensajeErrorTerminos').show();
    } else {
        $('#mensajeErrorTerminos').hide();
    }

    if (!$("#mensajeError").is(":visible") && !$("#mensajeErrorTerminos").is(":visible")) {
        /*
         * Se podria agregar establecer el siguiente bloque de codigo en una funcion
         * aparte que reciba por parametro un tipoFormulario y dependiendo de este
         * se establezca la ruta a usarse
         */
        if (tipoFormulario == 'registroUsuario') {
            var data = $(id).serializeObject();
            $.ajax({
                type: "POST",
                url: "registro-usuario/",
                crossDomain: true,
                contentType: 'application/json',
                data: JSON.stringify(data)
            }).done(function (data) {});

            $(id).trigger("reset");
            $(':input').removeClass('valid');
            alert("Usuario registrado exitosamente.");
        }
        if (tipoFormulario == 'registroEmpleado') {
            var data = $(id).serializeObject();
            //console.log(data);
            $.ajax({
                type: "POST",
                url: "registro-aspirante/",
                crossDomain: true,
                contentType: 'application/json',
                data: JSON.stringify(data)
            }).done(function (data) {});

            $(id).trigger("reset");
            $(':input').removeClass('valid');
            alert("Aspirante registrado exitosamente.");
        }
        // NO BORRAR ESTE BLOQUE
        if (tipoFormulario == 'Empresa') {
            //console.log((JSON.stringify($('#formularioEmpresa').serializeObject())));
            var data = $(id).serializeObject();
            var data2 = $(id2).serializeObject();
            //consle.log()
            Object.assign(data2, array);
            //console.log(pedirValores);
            //console.log('SERIIALZED:::::');
            //console.log(data);
            //data2.nuevoValor = 'NUEVO valor!';
            //console.log(data2);
            Object.assign(data, data2);
            //console.log(data);
            //console.log('REGISTRO EMPRESA TRIGGERED');

            $.ajax({
                url: "registro-empresa/user",
                method: "POST",
                data: JSON.stringify(data),
                crossDomain: true,
                contentType: 'application/json',
                dataType: "json",
                success: function(respuesta) {
                  if (respuesta.affectedRows == 1){
                    alert("Usuario agregado con exito.")
                    $(id).trigger('reset');
                    $(id2).trigger('reset');
                    $(':input').removeClass('valid');
                    $(':select').removeClass('valid');
            			}
                },
              error: function(e) {
                alert("Ocurrio un error.");
                console.log(JSON.stringify(e));
              }
            });

            /*
            $.ajax({
              url: "/listas",
              data: "",
              method: "POST",
              dataType: "json",
              success: function(respuesta) {
                $('#contenedorTodo').html("");
                for (var i = 0; i < respuesta.length; i++) {
                  var str = respuesta[i].titulo_lista;
                  var res = str.replace(" ", "-");
                  $('#contenedorTodo').append(`<div class="col-md-4">
                    <div class="well list" id="` + res + `">
                      <h4>` + respuesta[i].titulo_lista + `</h4>
                    </div>
                  </div>`);
                }
                cargarTarjetas();
              },
              error: function(e) {
                alert("Error: " + JSON.stringify(e));
              }
            });

            */
            /*
            $.ajax({
                type: "POST",
                url: "registro-empresa/user",
                crossDomain: true,
                contentType: 'application/json',
                data: JSON.stringify(data)
            }).done(function (data) {});
                $(id).trigger("reset");
                $(':input').removeClass('valid');
                alert("Usuario registrado exitosamente.");
              */

            //funcional hasta este punto
            //registra el usuario que manejara la empresa sin problemas

            /*$.ajax({
                url: "/registro-empresa/empresa",
                method: "POST",
                data: JSON.stringify(data2),
                dataType: "json",
                success: function (response) {
                    if (response.affectedRows == 1) {
                        alert("Registro de empresa exitoso");
                    } else {
                        alert("Registro de empresa fallido");
                    }
                },
                error: function () {

                }
            });*/
        }
        //console.log((JSON.stringify($(id).serializeObject())));
        //console.log((JSON.stringify($(id2).serializeObject())));
    }
}
//}

/*
 * La funcion validarForm fue creada para validar un formulario adicional, como es
 * el caso de 'formulario-empresa' que contiene dos formularios.
 */
function validarForm(formulario) {
    var id = '#' + formulario;
    var form_data = $(id).serializeArray();
    var suma = 0;

    for (var input in form_data) {
        var element = $("#" + form_data[input]['name']);
        var valid = element.hasClass("valid");
        if (!valid) {
            suma++;
        }
    }

    return suma;
}

/*
 * La siguiente funcion convierte un objeto a formato JSON. Normalmente es llamada
 * luego de llamar a la funcion 'serializeArray'. La funcion serializeArray recibe
 * un formulario y retorna un arreglo que NO ES formato JSON.
 */
$.fn.serializeObject = function () {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

//eventos click

$('#btn-reg-user').click(function () {
    //Aqui por ejemplo capturar los valores de las cajas de texto del formulario y
    //luego imprimer esos valores como prueba de que se capturaron, luego se enviaran como parametros
    // para un query
    alert("Se debera guardar");

});

function setDireccionMaps(results,latlng){
        array = {
          latitud : latlng.lat(),
          longitud : latlng.lng(),
          region: results[1].address_components[0].long_name,
          ciudad: results[1].address_components[1].long_name,
          departamento: results[1].address_components[2].long_name,
          pais: results[1].address_components[3].long_name
        };
}
