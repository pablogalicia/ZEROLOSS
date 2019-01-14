var dataTable;

$(function () {
    initEventos();

    activarLinea();

});


function initEventos() {
    $("#fechaIni").datetimepicker({
        onShow: function (ct) {
            this.setOptions({
                maxDate: jQuery('#fechaFin').val() ? jQuery('#fechaFin').val() : false
            })
        },
        format: 'Y-m-d H:i'


    });
    $("#fechaFin").datetimepicker({
        onShow: function (ct) {
            this.setOptions({
                minDate: jQuery('#fechaIni').val() ? jQuery('#fechaIni').val() : false
            })
        },
        format: 'Y-m-d H:i'

    });
    $.datetimepicker.setLocale('es');

    llenaCombos();
    $("#paroProgramado").hide();
    $("#seccionsubCategoria").hide();
    $("#seccionParo").hide();
    $("#textArea").hide();

    $("#proceso").change(function () {
        $('#categoria option').remove();
        $.ajax({
            async: false,
            url: "paros.aspx/catagorias",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $('#categoria').append($('<option>', {
                    value: 0,
                    text: 'Seleccione la Opcion',

                }));
                if (response.d != "") {
                    $.each(response, function (item, index) {
                        $.each(jQuery.parseJSON(index), function (item, index) {
                            $('#categoria').append($('<option>', {
                                value: index.idCategoria,
                                text: index.nombreCategoria
                            }));
                        });

                    });
                }
            }
        });
    })

    $("#categoria").change(function () {
        if ($(this).val() == '0') {
            $("#seccionsubCategoria").hide();
            $("#subCategoria").val("0").trigger('change');
        } else {
            $('#subCategoria option').remove();
            $("#seccionsubCategoria").show();

            $.ajax({
                async: false,
                url: "paros.aspx/subCatagorias",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({
                    idProceso: $('#categoria').val(),
                }),
                success: function (response) {
                    $('#subCategoria').append($('<option>', {
                        value: 0,
                        text: 'Seleccione la Opcion',
                        idMotivoParo: 0
                    }));
                    console.log(response);
                    if (response.d != "") {
                        $.each(response, function (item, index) {
                            $.each(jQuery.parseJSON(index), function (item, index) {
                                $('#subCategoria').append("<option value='" + index.idSubcategoriaxCategoria + "' idMotivoParo='" + index.idMotivoParo + "'>" + index.descripcionSubcategoria + "</option>");
                            });

                        });
                    }
                }
            });
        }
    });

    $("#subCategoria").change(function () {
        if ($(this).val() == '0') {
            $("#seccionParo").hide();
            $("#paro").val("0").trigger('change');
        } else {
            $("#seccionParo").show();
            $('#paro option').remove();


            $.ajax({
                async: false,
                url: "paros.aspx/motivoParo",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({
                    idMotivo: $("#subCategoria option:selected").attr("idMotivoParo")
                }),
                success: function (response) {
                    $('#paro').append($('<option>', {
                        value: 0,
                        text: 'Seleccione la Opcion'
                    }));
                    if (response.d != "") {
                        $.each(response, function (item, index) {
                            $.each(jQuery.parseJSON(index), function (item, index) {
                                $('#paro').append($('<option>', {
                                    value: index.idMotivoParo,
                                    text: index.descripcionParo
                                }));
                            });

                        });

                    }


                }
            });
        }
    });

    $(".btnPlus").click(function () {

        $(".categoria").show();
        $(".linea").show();
        $(".fechaIni").show();
        $("#textArea").hide();

        $("#btnedit").hide();
        $("#btnSave").show();

        $('#tablaParos').hide('fast', function () {
            $('#paroProgramado').show('fast', function () {
                $("#btnSave").click(function () {
                    $.ajax({
                        async: false,
                        url: "paros.aspx/ActualizaEstatusLinea",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: JSON.stringify({
                            idLinea: $('#linea').val(),
                            idEstatusLinea: 7
                        }),
                        success: function (response) {
                            var resultado;
                            if (response.d != "") {
                                $.each(response, function (item, index) {
                                    resultado = index;
                                });
                            }

                            if (resultado == true) {
                                $.ajax({
                                    async: false,
                                    url: "paros.aspx/insertarParoLinea",
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    data: JSON.stringify({
                                        idLinea: $("#linea").val(),
                                        fechaHoraInicio: $("#fechaIni").val(),
                                        idMotivoParo: $("#paro").val(),
                                        idPersonal: 1
                                    }),
                                    success: function (response) {
                                        var resultado;
                                        if (response.d != "") {
                                            $.each(response, function (item, index) {
                                                resultado = index;
                                            });
                                        }

                                        if (resultado == true) {
                                            swal("Petición procesada", {
                                                icon: "success",
                                                allowOutsideClick: false,
                                                closeOnClickOutside: false
                                            });
                                            $(".swal-button").click(function () {
                                                $('#paroProgramado').hide('fast', function () {
                                                    $('#tablaParos').show('fast', function () {
                                                        $("#form")[0].reset();
                                                        dataTable.destroy();
                                                        initDataTable();
                                                        activarLinea();
                                                    });
                                                });

                                            });
                                        }
                                    }
                                });
                            }
                        }
                    });
                    
                })
            });
        });
    })

    $(".btnCancelar").click(function () {
        $('#paroProgramado').hide('fast', function () {
            $('#tablaParos').show('fast', function () {
                $("#form")[0].reset();
                $("#categoria").val("0").trigger('change');
            });
        });
    })

    $("#btnActivar").click(function () {
        $.ajax({
            async: false,
            url: "paros.aspx/ActualizaEstatusLinea",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify({
                idLinea: $('#lineaActivar').val(),
                idEstatusLinea: 1
            }),
            success: function (response) {
                var resultado;
                if (response.d != "") {
                    $.each(response, function (item, index) {
                        resultado = index;
                    });
                }

                if (resultado == true) {
                    swal("Linea Activada", {
                        icon: "success",
                        allowOutsideClick: false,
                        closeOnClickOutside: false
                    });
                    $(".swal-button").click(function () {
                        dataTable.destroy();
                        initDataTable();
                        activarLinea();
                    });
                }
            }
        });
    })

    initDataTable();
}
function llenaCombos() {

    $.ajax({
        async: false,
        url: "paros.aspx/ProcesoParos",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $('#proceso').append($('<option>', {
                value: 0,
                text: 'Seleccione la Opcion'
            }));
            console.log(response);
            if (response.d != "") {
                $.each(response, function (item, index) {
                    $.each(jQuery.parseJSON(index), function (item, index) {
                        $('#proceso').append($('<option>', {
                            value: index.idProcesoParo,
                            text: index.nombreProceso
                        }));
                    });

                });
            }
        }
    });


    

    $.ajax({
        async: false,
        url: "paros.aspx/linea",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            
            if (response.d != "") {
                $.each(response, function (item, index) {
                    $.each(jQuery.parseJSON(index), function (item, index) {
                        $('#linea').append($('<option>', {
                            value: index.idLinea,
                            text: index.nombreLinea
                        }));

                        $('#lineaActivar').append($('<option>', {
                            value: index.idLinea,
                            text: index.nombreLinea
                        }));
                    });

                });
            }
        }
    });
}
function initDataTable() {
    var datos = null;

    $.ajax({
        type: 'POST',
        url: "paros.aspx/allParoLineas",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            datos = response.d;
            var json
            if (response.d != "") {
                json = $.parseJSON(datos);

                console.log(json);
                dataTable = $('#tablaAprobacionArticulos').DataTable({
                    data: json,
                    orderCellsTop: true,
                    fixedHeader: true,
                    lengthMenu: [[15, 30, 50, 100], [15, 30, 50, 100]],
                    "scrollCollapse": true,
                    "oLanguage": {
                        "sUrl": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Spanish.json"
                    },
                    "autoWidth": true,
                    "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6 hidden-xs'l><'col-sm-6 col-xs-12 hidden-xs'<'toolbar'>>r>",
                    columns: [
                        { data: "fechaHoraInicio" },
                        { data: "fechaHoraFin" },
                        {
                            data: "fechaHoraAtencion",
                            "mRender": function (data, type, full) {
                                return data;
                            }
                        },
                        { data: "motivoParo" },
                        { data: "descripcionDetalleParo" },
                        { data: "personal" },

                        {
                            data: "nombreEstatus",
                            "mRender": function (data, type, row) {

                                if (data == "NON_PROGRAMMED_STOPPAGE_ATTEMPT" || data == "NON_PROGRAMMED_STOPPAGE" || data == "NON_PROGRAMMED_STOPPAGE_IN_ATTENTION" || data == "NON_PROGRAMMED_STOPPAGE_ATTENDED") {
                                    return 'Paro No Programado';
                                } else {
                                    return 'Paro Programado';
                                }
                            }
                        },
                        {
                            data: "fechaHoraAtencion",
                            "mRender": function (data, type, row) {
                                //if (row.nombreEstatus != "NON_PROGRAMMED_STOPPAGE_ATTEMPT") {
                                //    if (row.nombreEstatus != "NON_PROGRAMMED_STOPPAGE") {
                                //        if (row.nombreEstatus != "NON_PROGRAMMED_STOPPAGE_IN_ATTENTION") {
                                //            if (row.nombreEstatus != "NON_PROGRAMMED_STOPPAGE_ATTENDED") {
                                //                if (row.nombreEstatus != "NON_PROGRAMMED_STOPPAGE_ATTENDED") {
                                //                    return '<a class="btn btn-info btn-sm boton2" style="width: 100%; color: #FFFFFF;">' + 'Finalizar' + '</a>';
                                //                }
                                //            }
                                //        }
                                //    }
                                //}
                                
                                //if (row.nombreEstatus == "NON_PROGRAMMED_STOPPAGE_ATTEMPT" && data=="") {
                                //    return '<a class="btn btn-info btn-sm boton" style="width: 100%; color: #FFFFFF;">' + 'Atender' + '</a>';

                                //}
                                //if (row.nombreEstatus == "NON_PROGRAMMED_STOPPAGE" && data == "") {
                                //    return '<a class="btn btn-info btn-sm boton" style="width: 100%; color: #FFFFFF;">' + 'Atender' + '</a>';

                                //}  
                                //if (row.nombreEstatus == "NON_PROGRAMMED_STOPPAGE_IN_ATTENTION" && data == "") {
                                //    return '<a class="btn btn-info btn-sm boton" style="width: 100%; color: #FFFFFF;">' + 'Atender' + '</a>';

                                //}  
                                //if (row.nombreEstatus == "NON_PROGRAMMED_STOPPAGE_ATTENDED" && data == "") {
                                //    return '<a class="btn btn-info btn-sm boton" style="width: 100%; color: #FFFFFF;">' + 'Atender' + '</a>';
                                //}

                                return '<a class="btn btn-info btn-sm boton2" style="width: 100%; color: #FFFFFF;">' + 'Finalizar' + '</a>';

                                
                            }
                        }

                    ]
                });

                $('#tablaAprobacionArticulos').on('click', 'tbody .boton2', function () {
                    var data_row = dataTable.row($(this).closest('tr')).data();

                    editLinea(data_row);
                });
                $('#tablaAprobacionArticulos').on('click', 'tbody .boton', function () {
                    var data_row = dataTable.row($(this).closest('tr')).data();

                    atender(data_row);
                });
            } else {
                console.log("2"+json);

                dataTable = $('#tablaAprobacionArticulos').DataTable({
                    orderCellsTop: true,
                    fixedHeader: true,
                    lengthMenu: [[15, 30, 50, 100], [15, 30, 50, 100]],
                    "scrollCollapse": true,
                    "oLanguage": {
                        "sUrl": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Spanish.json"
                    },
                    "autoWidth": true,
                    "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6 hidden-xs'l><'col-sm-6 col-xs-12 hidden-xs'<'toolbar'>>r>",

                })
            }
               
        },
        failure: function (response) {
            console.log(response);
        }
    });



}
function editLinea(row) {
    $('#tablaParos').hide('fast', function () {
        $('#paroProgramado').show('fast', function () {
            console.log(row);
            $(".categoria").hide();
            $(".linea").hide();
            $(".fechaIni").hide();
            $("#seccionsubCategoria").hide();
            $("#seccionParo").hide();
            $("#textArea").show();

            $("#btnedit").show();
            $("#btnSave").hide();
            //var estatus;

            //if (row.nombreEstatus != "NON_PROGRAMMED_STOPPAGE_ATTEMPT") {
            //    estatus = 8;
            //    if (row.nombreEstatus != "NON_PROGRAMMED_STOPPAGE") {
            //        estatus = 8;
            //        if (row.nombreEstatus != "NON_PROGRAMMED_STOPPAGE_IN_ATTENTION") {
            //            estatus = 8;
            //            if (row.nombreEstatus != "NON_PROGRAMMED_STOPPAGE_ATTENDED") {
            //                estatus = 8;
            //            } else {
            //                estatus = 6;
            //            }
            //        } else {
            //            estatus = 6;
            //        }
            //    } else {
            //        estatus = 6;
            //    }
            //} else {
            //    estatus = 6;
            //}



            $("#btnedit").click(function () {
                

                $.ajax({
                    async: false,
                    url: "paros.aspx/ActualizaEstatusLinea",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({
                        idLinea: row.idLiena,
                        idEstatusLinea: 1
                    }),
                    success: function (response) {
                        var resultado;
                        if (response.d != "") {
                            $.each(response, function (item, index) {
                                resultado = index;
                            });
                        }

                        if (resultado == true) {
                            $.ajax({
                                async: false,
                                url: "paros.aspx/ActualizaDescripcionParoLinea",
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: JSON.stringify({
                                    idParoLinea: row.idParoLinea,
                                    descripcion: $("#observaciones").val()

                                }),
                                success: function (response) {
                                    var resultado;
                                    if (response.d != "") {
                                        $.each(response, function (item, index) {
                                            resultado = index;
                                        });
                                    }

                                    if (resultado == true) {
                                        swal("Petición procesada", {
                                            icon: "success",
                                            allowOutsideClick: false,
                                            closeOnClickOutside: false
                                        });
                                        $(".swal-button").click(function () {
                                            $('#paroProgramado').hide('fast', function () {
                                                $('#tablaParos').show('fast', function () {
                                                    $("#form")[0].reset();

                                                    dataTable.clear().draw();
                                                    dataTable.destroy();

                                                    initDataTable();
                                                    activarLinea();
                                                });
                                            });

                                        });
                                    }


                                }
                            });
                        }
                    }
                });
            })

        });
    });
}
function atender(row) {
    console.log(row);
    $.ajax({
        async: false,
        url: "paros.aspx/ActualizaEstatusLinea",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({
            idLinea: row.idLiena,
            idEstatusLinea: 5
        }),
        success: function (response) {
            var resultado;
            if (response.d != "") {
                $.each(response, function (item, index) {
                    resultado = index;
                });
            }

            if (resultado == true) {
                $.ajax({
                    async: false,
                    url: "paros.aspx/ActualizaEstatusParoLinea",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({
                        idParoLinea: row.idParoLinea,
                       
                    }),
                    success: function (response) {
                        var resultado;
                        if (response.d != "") {
                            $.each(response, function (item, index) {
                                resultado = index;
                            });
                        }

                        if (resultado == true) {

                            swal("Linea Atendida", {
                                icon: "success",
                                allowOutsideClick: false,
                                closeOnClickOutside: false
                            });
                            $(".swal-button").click(function () {
                                dataTable.destroy();
                                initDataTable();
                                activarLinea();
                            });
                        }

                    }
                });

            }
        }
    });
    
}
function activarLinea() {
    $.ajax({
        async: false,
        url: "paros.aspx/linea",
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            var estatusLinea;
            if (response.d != "") {
                $.each(response, function (item, index) {
                    $.each(jQuery.parseJSON(index), function (item, index) {
                        estatusLinea = index.idEstatusLinea;
                    });

                });
                console.log(estatusLinea);
                if (estatusLinea == "2" || estatusLinea == "6" || estatusLinea == "8") {
                    $("#divActivar").show();
                } else {
                    $("#divActivar").hide();
                }
            }


        }
    });
}