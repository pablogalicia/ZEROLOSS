<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="PitChart.aspx.cs" Inherits="Reportes_PitChart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
    <link rel="stylesheet" type="text/css" href="styles/services.css">
    
     <link href="AmCharts/Css/style.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server"><style>
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
  
  <div class="home_container">
     <form id="form1" runat="server"> 
           <div class="home_title">PIT CHART</div>        
           <div id="chartdiv" style="width: 100%; height: 500px" ></div>         
     </form>
    </div>  
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

