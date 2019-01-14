<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="home_container">
        <br /><br />
        <div class="container"  id="paroProgramado">
            <br /><br />
            <form id="form">
                <center>
                        <div class="col-lg-10 col-md-10 col-xl-10 col-sm-10" >
                            <fieldset>
                                    <fieldset class="paros_title">
                                        <h1>
                                            Paros
                                        </h1>
                                    </fieldset><br />
                                    <div class="row">
                                                <section class="col-md-3 categoria">
                                                    <label class="control-label">
                                                        Parte del Proceso
                                                    </label>
                                                    <select class="form-control" id="proceso" name="categoria">
                                                    </select>
                                                </section>
                                                <section class="col-md-3 categoria">
                                                    <label class="control-label">
                                                        Categoria
                                                    </label>
                                                    <select class="form-control" id="categoria" name="categoria">
                                                    
                                                    </select>
                                                </section>
                                                <section class="col-md-3" id="seccionsubCategoria">
                                                    <label class="control-label">
                                                        Sub Categoria
                                                    </label>
                                                    <select class="form-control" id="subCategoria" name="subCategoria" >
                                                    
                                                    </select>
                                                </section>
                                                <section class="col-md-3" id="seccionParo">
                                                    <label class="control-label">
                                                        Tipo de Paro
                                                    </label>
                                                    <select class="form-control" id="paro" name="paro" >
                                                   
                                                    </select>
                                                </section>
                                    </div><br />     
                                    <div class="row">
                                                <section class="col-md-4 linea">
                                                    <label class="control-label">
                                                        Linea
                                                    </label>
                                                    <select class="form-control" id="linea">

                                                    </select>
                                                </section>
                                                <section class="col-md-4 fechaIni">
                                                    <label class="control-label">
                                                        Fecha de Inicio
                                                    </label>
                                                    <input type="text" class="form-control" id="fechaIni" data-format="MM/dd/yyyy HH:mm:ss PP"/>
                                                </section>
                                                <%--<section class="col-md-4">
                                                    <label class="control-label">
                                                        Fecha de Fin
                                                    </label>
                                                    <input type="text" class="form-control" id="fechaFin" data-format="MM/dd/yyyy HH:mm:ss PP"/>
                                                </section>--%>
                                    </div><br />
                                    <div class="row">
                                                <section class="col-md-12" id="textArea">
                                                    <label class="control-label">
                                                        Observaciones de Paro
                                                    </label>
                                                    <textarea id="observaciones" class="form-control" rows="5"></textarea>
                                                </section>
                                 
                                    </div><br />
                            </fieldset>
                                

                            <div class="widget-body-toolbar fa-pull-right">
					            <div class="form-actions">
						            <button id="btnCancelar"  type="button" class="btn btn-danger btn-sm btnCancelar">
							            Cancelar
						            </button>
						            <button class="btn btn-primary btn-sm" id="btnSave" type="button">
							            Guardar
						            </button>
                                    <button class="btn btn-primary btn-sm" id="btnedit" type="button">
							            Guardar
						            </button>
					            </div>
				            </div>
                        </div>
                </center>

            </form>
        </div>
         <div class="col-lg-12 col-md-12 col-xl-12 col-sm-12" id="tablaParos">
           <%--<div class="widget-body-toolbar">
               <div class="row col-lg-12" id="divActivar">
                   <section class="col-md-2">
                         <select class="form-control" id="lineaActivar" ></select>
                    </section>  
                   <section class="col-md-2">
                        <button id="btnActivar" type="button" class="form-control btn btn-primary btn-sm">Activar Linea</button>
                   </section> 
               </div>

            </div><br /><br /><br />--%>
            <div class="widget-body-toolbar">
                <button id="btnPlus" type="button" class="btn btn-primary btn-sm btnPlus">
                   Programar Paro
                </button>
               <%-- <button id="btnEdit" type="button" class="btn btn-warning btn-sm">
                    <i class="fa fa-pencil"></i> Editar
                </button>--%>
            </div>
            <br />
            <div class="widget-body">
                <table id="tablaAprobacionArticulos" class="table table-striped table-bordered table-hover DTTT_selectable" cellspacing="0" width="100%">
			        <thead>
				        <tr>
					        <th>Fecha Inical</th>
					        <th>Fecha Fin</th> 
					        <th>Fecha Atencion</th>
					        <th>Motivo Paro</th> 
					        <th>Descripcion</th>
					        <th>Personal</th> 
                            <th>Tipo de Paro</th>
                            <th>Detalle</th>
							        
				        </tr>
			        </thead>
					
		        </table>
            </div>
            
        </div>
    </div>
    
  
    <script type="text/javascript" src="js/paros.js"></script>



</asp:Content>
