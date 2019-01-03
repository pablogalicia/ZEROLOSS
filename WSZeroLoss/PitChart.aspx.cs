using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;


public partial class Reportes_PitChart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            ConstruyeGraficaPuntos();
        }
        catch (Exception falla)
        {
            Response.Redirect("http://localhost/MonitoreoITortilla/WBITortilla//inicio.aspx");
        }
    }

    protected void ConstruyeGraficaPuntos()
    {
        try
        {
            StringBuilder ValoresEjeX = new StringBuilder();
            StringBuilder ValoresEjeXEngrafico = new StringBuilder();
            StringBuilder ValoresEjeY = new StringBuilder();
            StringBuilder script = new StringBuilder();
            int i = 0;
            string[] valores = { "9.10", "9.15", "9.17", "9.10", "9.00", "9.01", "8.55", "9.40", "9.05", "9.30" };
            string[] descripcion = { "En tiempo", "Retardo", "Retardo", "En tiempo", "En tiempo", "En tiempo", "En tiempo", "Fuera de tiempo", "En tiempo", "Fuera de tiempo" };
            for (int index = 0; index < 10; index++)
            {
                Random Apertura = new Random();
                double Valor = Apertura.NextDouble();
                Valor = 9 + Valor;
                ValoresEjeXEngrafico.Append("'" + descripcion[index] + "'");
                ValoresEjeX.Append("'" + "Sucursal " + (index + 1).ToString() + "'");

                ValoresEjeY.Append("  case " + index.ToString() + ":" + "\n" + "\r" +
                " visits = " + valores[index] + ";" + "\n" + "\r" +
                " var hits = " + valores[index] + ";" + "\n" + "\r" +
                " var views =" + valores[index] + ";" + "\n" + "\r" +
                " break;");
                i += 1;
                if ((i < 10))
                {
                    ValoresEjeX.Append(",");
                    ValoresEjeY.Append(" " + "\n" + "\r");
                    ValoresEjeXEngrafico.Append(",");

                }
            }

            script.Append(" ");
            script.Append(" " + "\n" + "\r" +
            "        var chartData = generateChartData();" + "\n" + "\r" +
            " var chart = AmCharts.makeChart(\"chartdiv\", {" + "\n" + "\r" +
            "  \"type\": \"serial\", " + "\n" + "\r" +
            " \"theme\": \"light\",  " + "\n" + "\r" +
            " \"legend\": { " + "\n" + "\r" +
            "   \"useGraphSettings\": true" + "\n" + "\r" +
            "}," + "\n" + "\r" +
            "\"dataProvider\": chartData," + "\n" + "\r" +
            "\"valueAxes\": [{" + "\n" + "\r" +
            "\"id\": \"v1\"," + "\n" + "\r" +
            "\"axisColor\": \"#336699\"," + "\n" + "\r" +
            "\"axisThickness\": 2," + "\n" + "\r" +
            "\"gridAlpha\": 0," + "\n" + "\r" +
            "\"axisAlpha\": 1," + "\n" + "\r" +
            "\"position\": \"left\"" + "\n" + "\r" +
               " }]," + "\n" + "\r" +
            "\"graphs\": [{" + "\n" + "\r" +
            "\"valueAxis\": \"v1\"," + "\n" + "\r" +
            "\"balloonText\": \"[[seccionFechas]]<br><b>Valor: [[value]]</b>\"," + "\n" + "\r" +
            "\"lineColor\": \"#EA0000\"," + "\n" + "\r" +
            "\"bullet\": \"round\"," + "\n" + "\r" +
            "\"bulletBorderThickness\": 1," + "\n" + "\r" +
            "\"hideBulletsCount\": 30," + "\n" + "\r" +
            "\"title\": \"Tiempos de apertura (Hora)\"," + "\n" + "\r" +
            "\"valueField\": \"visits\"," + "\n" + "\r" +
            "\"fillAlphas\": 0" + "\n" + "\r" +
            "   }]," + "\n" + "\r" +
            "  //'chartScrollbar': {}," + "\n" + "\r" +
            "\"chartCursor\": {" + "\n" + "\r" +
            "\"cursorPosition\": \"mouse\"" + "\n" + "\r" +
             "   }," + "\n" + "\r" +
            "\"dataDateFormat\": \"DD-MM-YYYY\"," + "\n" + "\r" +
            "\"categoryField\": \"seccion\"," + "\n" + "\r" +
            "\"categoryAxis\": {" + "\n" + "\r" +
            "\"axisColor\": \"#DADADA\"," + "\n" + "\r" +
            "\"minorGridEnabled\": true" + "\n" + "\r" +
            "    }," + "\n" + "\r" +
            "\"export\": {" + "\n" + "\r" +
            "\"enabled\": true," + "\n" + "\r" +
            "\"position\": \"bottom-right\"" + "\n" + "\r" +
            "    }" + "\n" + "\r" +
            "});" + "\n" + "\r" +
            " function generateChartData() {" + "\n" + "\r" +
            "    var chartData = [];" + "\n" + "\r" +
            "    var secciones;" + "\n" + "\r" +
            "    var seccionesFechas;" + "\n" + "\r" +
            "    secciones = [" + ValoresEjeX.ToString() + "];" + "\n" + "\r" +
            "    seccionesFechas = [" + ValoresEjeXEngrafico.ToString() + "];" + "\n" + "\r" +
            "    var firstDate = new Date();" + "\n" + "\r" +
            "    firstDate.setDate(firstDate.getDate());" + "\n" + "\r" +
            "    for (var i = 0; i < 10; i++) {" + "\n" + "\r" +
            "        var newDate = new Date(firstDate);" + "\n" + "\r" +
            "        newDate.setDate(newDate.getDate() + i);" + "\n" + "\r" +
            "        var visits = 0;" + "\n" + "\r" +
            "        var hits = 0;" + "\n" + "\r" +
            "        var views = 0;" + "\n" + "\r" +
            "        switch (i) {" + ValoresEjeY.ToString() + "\n" + "\r" +
            "        }" + "\n" + "\r" +
            "         chartData.push({" + "\n" + "\r" +
            "            seccion: secciones[i]," + "\n" + "\r" +
            "            seccionFechas: seccionesFechas[i]," + "\n" + "\r" +
            "            visits: visits," + "\n" + "\r" +
            "hits : hits," + "\n" + "\r" +
            "views:  views" + "\n" + "\r" +
            "               });" + "\n" + "\r" +
            "          }" + "\n" + "\r" +
            "         return chartData;" + "\n" + "\r" +
            "    } ");
            ScriptManager.RegisterStartupScript(this, typeof(Page), "grafic", script.ToString(), true);
            

        }
        catch (Exception Falla)
        {

        }
    }
}