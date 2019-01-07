<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div class="home_container">
		<div class="container">
				<form id="form">
                    <center>
                        <div class="col-lg-10 col-md-10 col-xl-10 col-sm-10">
                        <fieldset class="paros_title">
                            <h1>
                                Paros
                            </h1>
                        </fieldset><br />
                        <div class="row">
                                 <section class="col-md-4">
                                        <label class="control-label">
                                            Categoria
                                        </label>
                                        <select class="form-control">

                                        </select>
                                   </section>
                                   <section class="col-md-4">
                                        <label class="control-label">
                                           Sub Categoria
                                        </label>
                                        <select class="form-control">

                                        </select>
                                   </section>
                                   <section class="col-md-4">
                                        <label class="control-label">
                                           Tipo de Paro
                                        </label>
                                        <select class="form-control">

                                        </select>
                                   </section>
                        </div><br />     
                        <div class="row">
                                 <section class="col-md-4">
                                        <label class="control-label">
                                            Linea
                                        </label>
                                        <select class="form-control">

                                        </select>
                                 </section>
                                 <section class="col-md-4">
                                        <label class="control-label">
                                            Fecha de Inicio
                                        </label>
                                        <input type="text" class="form-control" id="fechaIni" data-format="MM/dd/yyyy HH:mm:ss PP"/>
                                 </section>
                                 <section class="col-md-4">
                                        <label class="control-label">
                                            Fecha de Fin
                                        </label>
                                        <input type="text" class="form-control" id="fechaFin" data-format="MM/dd/yyyy HH:mm:ss PP"/>
                                 </section>
                        </div><br />
                        <div class="row">
                                 <section class="col-md-12">
                                        <label class="control-label">
                                            Descripcion de Paro
                                        </label>
                                        <textarea class="form-control" rows="5"></textarea>
                                 </section>
                                 
                        </div><br />
                        </div>
                    </center>
                    
				</form>
			</div>
	</div>

    <script type="text/javascript" src="js/paros.js"></script>



</asp:Content>