<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="reporte1.aspx.cs" Inherits="BandejaTransacciones"  EnableEventValidation = "false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

  <%--<script src="js/amcharts1.js"></script>
  <script src="js/serial.js"></script>--%>
    <style>
        #chartdiv {
            width: 100%;
            height: 500px;
        }
    </style>

    <script src="AmCharts/amcharts.js"></script>
    <script src="AmCharts/funnel.js"></script>
    <script src="AmCharts/gantt.js"></script>
    <script src="AmCharts/gauge.js"></script>
    <script src="AmCharts/pie.js"></script>
    <script src="AmCharts/radar.js"></script>
    <script src="AmCharts/serial.js"></script>
    <script src="AmCharts/xy.js"></script>

    <link href="AmCharts/Css/style.css" rel="stylesheet" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <style>
            .bck { color: #000 !important; }
            .tselect { width: 200px !important; }
            select { width: 150px !important; }
            .tituloDatos{
                text-align:center;
                color:white;
                margin-left:2px;
                margin-right:2px;
                border-radius:2px;
            }
            .produccionDatos{
                margin-left:5px;
            }
            
        </style>
      <form id="form1" runat="server">
            
     <div id="content">
    <div class="row">

		    	<div class="jarviswidget jarviswidget-color-darken" id="" data-widget-editbutton="false" style="width:50%;margin-left:auto;margin-right:auto;">
				<header>
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>Búsqueda</h2>
				</header>

				<!-- widget div-->
				<div>

					<!-- widget edit box -->
					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body">
						<%--<form class="form-horizontal">--%>
							<fieldset>	                        
							
							<div  class="widget-body">

                                <div class="col-sm-10">
										<label>Zona</label>
									</div>
									<div class="col-sm-10">

										<div class="form-group">
											<div class="input-group">
												<select class="form-control"  id="select-1">
                                        <option>Seleccione</option>
			                            <option>Centro</option>
			                            <option>Oriente</option>
			                            <option>Poniente</option>
			                            <option>Sur</option>											
		                            </select>
											</div>
										</div>
									</div>

                                <div class="col-sm-10">
										<label>Por periodo</label>
									</div>
									<div class="col-sm-5">

										<div class="form-group">
											<div class="input-group">
												<input class="form-control datepicker" id="from" type="text" placeholder="Desde">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
											</div>
										</div>
									</div>
                                <div class="col-sm-2">
                                    </div>
                                <div class="col-sm-5">
										<div class="form-group">
											<div class="input-group">
												<input class="form-control datepicker" id="to" type="text" placeholder="Hasta">
												<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
											</div>
										</div>
									</div>
							</div>							
							</fieldset>                            									
							<div class="form-actions">
								<div class="row">
									<div class="col-md-12">										
										<button class="btn btn-primary" type="button" onclick="visualizatabla()" runat="server">
											<i class="fa fa-search"></i>
											Buscar
										</button>
									</div>
								</div>
							</div>

						<%--</form>--%>

					</div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->

			</div>
        <div class="col-sm-6 hidden" id="contenedor1">
            <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-0" data-widget-editbutton="false">				
				<header id="titulo">
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>APERTURA DE SUCURSALES</h2>
				</header>

				<!-- widget div-->
				<div>

					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body">

                       
                         <div id="sinRegistros" runat="server" visible="false" style="text-align:center;"><img src="img/sinRegistros.png" /><br />No se encontraron lecturas</div>
					    <div id="chartdiv" style="width: 100%; height: 200px" ></div>
                       
					</div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->

			</div>
        </div>

        <div class="col-sm-6  hidden" id="contenedor2" >
            <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-0" data-widget-editbutton="false">				
				<header id="titulo">
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>APERTURA SEMANAL</h2>
				</header>

				<!-- widget div-->
				<div>

					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body">

                       
                         <%--<div id="Div1" runat="server" visible="false" style="text-align:center;"><img src="img/sinRegistros.png" /><br />No se encontraron lecturas</div>--%>
					    <div id="grafica" style="width: 100%; height: 200px" ></div>
                       
					</div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->

			</div>
        </div>
        
        <div class="col-sm-12  hidden" id="contenedor3" >
            <div class="jarviswidget jarviswidget-color-blueDark" id="wid-id-0" data-widget-editbutton="false">				
				<header id="titulo">
					<span class="widget-icon"> <i class="fa fa-table"></i> </span>
					<h2>EFECTIVIDAD EN LA APERTURA</h2>
				</header>

				<!-- widget div-->
				<div>

					<div class="jarviswidget-editbox">
						<!-- This area used as dropdown edit box -->

					</div>
					<!-- end widget edit box -->

					<!-- widget content -->
					<div class="widget-body">

                       
                         <%--<div id="Div1" runat="server" visible="false" style="text-align:center;"><img src="img/sinRegistros.png" /><br />No se encontraron lecturas</div>--%>
					    <div id="grafica3" style="width: 100%; height: 300px" ></div>
                       
					</div>
					<!-- end widget content -->

				</div>
				<!-- end widget div -->

			</div>
        </div>

			


			
          </div>

          </div>
      </form>

    <script>

        function visualizatabla() {
            $("#contenedor1").removeClass('hidden')
            $("#contenedor2").removeClass('hidden')
            $("#contenedor3").removeClass('hidden')

            var chart = AmCharts.makeChart("grafica", {
                "type": "serial",
                "theme": "none",
                "legend": {
                    "useGraphSettings": true
                },
                "dataProvider": [{
                    "year": 'Lunes',
                    "italy": 9.25,
                    "germany": 9.12,
                    "uk": 10
                }, {
                    "year": 'Martes',
                    "italy": 9.0,
                    "germany": 9.35,
                    "uk": 9.25
                }, {
                    "year": 'Miércoles',
                    "italy": 9.00,
                    "germany": 9.22,
                    "uk": 9.15
                }, {
                    "year": 'Jueves',
                    "italy": 9.18,
                    "germany": 9.29,
                    "uk": 9.15
                }, {
                    "year": 'Viernes',
                    "italy": 9.45,
                    "germany": 9.11,
                    "uk": 10
                }],
                "valueAxes": [{
                    "integersOnly": true,
                    "maximum": 10,
                    "minimum": 8,
                    //"reversed": true,
                    "axisAlpha": 8,
                    "dashLength": 1,
                    "gridCount": 10,
                    "position": "left",
                    "title": "Hora de entrada"
                }],
                "startDuration": 0.5,
                "graphs": [{
                    "balloonText": "Sucursal 1: [[value]]",
                    "bullet": "round",
                    //"hidden": true,
                    "title": "Sucursal 1",
                    "valueField": "italy",
                    "fillAlphas": 0
                }, {
                    "balloonText": "Sucursal 2: [[value]]",
                    "bullet": "round",
                    "title": "Sucursal 2",
                    "valueField": "germany",
                    "fillAlphas": 0
                }, {
                    "balloonText": "Sucursal 3: [[value]]",
                    "bullet": "round",
                    "title": "Sucursal 3",
                    "valueField": "uk",
                    "fillAlphas": 0
                }],
                "chartCursor": {
                    "cursorAlpha": 0,
                    "zoomable": false
                },
                "categoryField": "year",
                "categoryAxis": {
                    "gridPosition": "start",
                    "axisAlpha": 0,
                    "fillAlpha": 0.05,
                    "fillColor": "#000000",
                    "gridAlpha": 0,
                    "position": "top"
                },
                "export": {
                    "enabled": true,
                    "position": "bottom-right"
                }
            });
            var chart = AmCharts.makeChart("grafica3", {
                "theme": "none",
                "type": "serial",
                "dataProvider": [{
                    "year": 'En Tiempo',
                    "income": 6,
                    "color": "#36bf9f"
                }, {
                    "year": 'Retardo',
                    "income": 2,
                    "color": "#fb6710"
                }, {
                    "year": 'Fuera de Tiempo',
                    "income": 2,
                    "color": "#2680b4"
                }],
                "valueAxes": [{
                    "title": ""
                }],
                "graphs": [{
                    "balloonText": "[[category]]:[[value]]",
                    "fillColorsField": "color",
                    "fillAlphas": 1,
                    "lineAlpha": 0.2,
                    "title": "Income",
                    "type": "column",
                    "valueField": "income"
                }],
                "depth3D": 20,
                "angle": 30,
                "rotate": true,
                "categoryField": "year",
                "categoryAxis": {
                    "gridPosition": "start",
                    "fillAlpha": 0.05,
                    "position": "left"
                },
                "export": {
                    "enabled": true
                }
            });
        }

    </script>

</asp:Content>


