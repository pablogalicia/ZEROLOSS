using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using referenceWS;

public partial class Index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static String ProcesoParos() {
        DataTable dtTitulo = new DataTable();
        WSLinProClass instancia = new WSLinProClass();
        dtTitulo = ConvertToDataTable(instancia.ProcesoParos());
        return DataTableToJSONWithStringBuilder(dtTitulo);
    }

    [WebMethod]
    public static String catagorias() {
        DataTable dtTitulo = new DataTable();
        WSLinProClass instancia = new WSLinProClass();
        dtTitulo = ConvertToDataTable(instancia.catalogos());
        return DataTableToJSONWithStringBuilder(dtTitulo);
    }

    [WebMethod]
    public static String subCatagorias(int idProceso) {
        DataTable dtTitulo = new DataTable();
        WSLinProClass instancia = new WSLinProClass();
        dtTitulo = ConvertToDataTable(instancia.subCategorias(idProceso));
        return DataTableToJSONWithStringBuilder(dtTitulo);
    }

    [WebMethod]
    public static String motivoParo(int idMotivo) {
        DataTable dtTitulo = new DataTable();
        WSLinProClass instancia = new WSLinProClass();
        dtTitulo = ConvertToDataTable(instancia.motivoParo(idMotivo));
        return DataTableToJSONWithStringBuilder(dtTitulo);
    }

    [WebMethod]
    public static String linea() {
        DataTable dtTitulo = new DataTable();
        WSLinProClass instancia = new WSLinProClass();
        dtTitulo = ConvertToDataTable(instancia.linea());
        return DataTableToJSONWithStringBuilder(dtTitulo);
    }

    [WebMethod]
    public static String allParoLineas() {
        DataTable dtTitulo = new DataTable();
        WSLinProClass instancia = new WSLinProClass();
        dtTitulo = ConvertToDataTable(instancia.allParoLineas());
        return DataTableToJSONWithStringBuilder(dtTitulo);
    }

    [WebMethod]
    public static bool insertarParoLinea(int idLinea, String fechaHoraInicio, int idMotivoParo, int idPersonal) {
        WSLinProClass instancia = new WSLinProClass();
        return instancia.insertarParoLinea(idLinea, fechaHoraInicio, idMotivoParo , idPersonal );
    }

    [WebMethod]
    public static bool ActualizaEstatusLinea(int idLinea, int idEstatusLinea) {
        WSLinProClass instancia = new WSLinProClass();
        return instancia.ActualizaEstatusLinea( idLinea,  idEstatusLinea);
    }

    [WebMethod]
    public static bool ActualizaEstatusParoLinea(int idParoLinea) {
        WSLinProClass instancia = new WSLinProClass();
        return instancia.ActualizaEstatusParoLinea(idParoLinea);
    }

    [WebMethod]
    public static bool ActualizaDescripcionParoLinea(int idParoLinea,String descripcion) {
        WSLinProClass instancia = new WSLinProClass();
        return instancia.ActualizaDescripcionParoLinea(idParoLinea, descripcion);
    }


    public static DataTable ConvertToDataTable<T>(IList<T> data) {
        PropertyDescriptorCollection properties =
           TypeDescriptor.GetProperties(typeof(T));
        DataTable table = new DataTable();
        foreach (PropertyDescriptor prop in properties)
            table.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
        foreach (T item in data) {
            DataRow row = table.NewRow();
            foreach (PropertyDescriptor prop in properties)
                row[prop.Name] = prop.GetValue(item) ?? DBNull.Value;
            table.Rows.Add(row);
        }
        return table;

    }

    //public static string DataSetToJSON(DataTable dt) {
    //    return JsonConvert.SerializeObject(dt.AsEnumerable().Select(r => r.ItemArray));
    //}

    public static string DataTableToJSONWithStringBuilder(DataTable table) {
        var JSONString = new StringBuilder();
        if (table.Rows.Count > 0) {
            JSONString.Append("[");
            for (int i = 0; i < table.Rows.Count; i++) {
                JSONString.Append("{");
                for (int j = 0; j < table.Columns.Count; j++) {
                    if (j < table.Columns.Count - 1) {
                        JSONString.Append("\"" + table.Columns[j].ColumnName.ToString() + "\":" + "\"" + table.Rows[i][j].ToString() + "\",");
                    } else if (j == table.Columns.Count - 1) {
                        JSONString.Append("\"" + table.Columns[j].ColumnName.ToString() + "\":" + "\"" + table.Rows[i][j].ToString() + "\"");
                    }
                }
                if (i == table.Rows.Count - 1) {
                    JSONString.Append("}");
                } else {
                    JSONString.Append("},");
                }
            }
            JSONString.Append("]");
        }
        return JSONString.ToString();
    }
}