<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AppMasterHeader.Master" CodeBehind="Admin_Reports.aspx.vb" Inherits="HReaseApp.Admin_Reports" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" runat="Server">
    <div id="tabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>       
    </div>
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" Runat="Server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" rel="stylesheet" />
    <style>
        .chosen-container{
            min-width: 200px !important;
            max-width:560px !important; 
            width:50% !important;
        }
    </style>


     <asp:ScriptManager ID="ScriptManager1" runat="server" />
                    <script type="text/javascript">
                        // Get the instance of PageRequestManager.
                        var prm = Sys.WebForms.PageRequestManager.getInstance();

                        // Add initializeRequest and endRequest
                        prm.add_initializeRequest(prm_InitializeRequest);
                        prm.add_endRequest(prm_EndRequest);

                        // Called when async postback begins
                        function prm_InitializeRequest(sender, args) {

                            // get the divImage and set it to visible
                            var panelProg = $get('divProcessing');
                            panelProg.style.display = '';

                            window.setTimeout(function () {
                                panelProg.style.display = 'none';
                            }, 20000);

                            // Disable button that caused a postback
                            //$get(args._postBackElement.id).disabled = true;
                        }

                        // Called when async postback ends
                        function prm_EndRequest(sender, args) {
                            // get the divImage and hide it again
                            var panelProg = $get('divProcessing');
                            panelProg.style.display = 'none';
                            // Enable button that caused a postback
                            //$get(sender._postBackSettings.sourceElement.id).disabled = false;

                        }

                    </script>


    <div class="container ">
        <br />
        <div class="well">
            <div class="form-group ">
                <div class=" col-xs-12 col-sm-12 col-md-12 col-lg-12 ">
                    <asp:Image ID="imgBenefit" ImageUrl="../img/IconReports.png" Width="100px" runat="server" border="none" CssClass="img" OnMouseOver="src='/img/IconReportsOver.png';" OnMouseOut="src='/img/IconReports.png';" />
                    <br />               
                    <div class="h3">Reporting Module</div>
                    <br />
                </div>
                </div>


             <div class="container form-group ">
                <div class="col-xs-1 col-sm-1 col-md-1"></div>
                 <div id="divCriteria" class="well-success col-xs-10 col-sm-10 col-md-10 center" Visible="false" runat="server">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12  text-right">
                        <asp:LinkButton ID="lnkClose" runat="server" Text="Edit Report Layout" OnClick="lnkClose_Click" CssClass="text-muted">  
                        <span class="glyphicon  glyphicon-remove" aria-hidden="true"></span></asp:LinkButton>
                    </div>
                    <div class=" col-xs-12 col-sm-12 col-md-12 col-lg-12 ">
                        <h4><asp:Label ID="lblReportName" runat="server" Text="Enter Report Criteria"></asp:Label></h4>
                    </div>
                    <div class=" form-group">
                        <div class="col-md-12 text-center ">
                            <asp:ValidationSummary HeaderText="<h4>Please enter a value in the following field(s):</h4>" DisplayMode="SingleParagraph" EnableClientScript="true" runat="server" CssClass="alert alert-danger text-danger text-center" ValidationGroup="valCriteria" />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label ID="lblCriteriaText" runat="server" class="col-md-12 " Text="Please enter report criteria or leave blank to return all data.<br/><br/>"></asp:Label>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-12 col-sm-12 col-md-12">
                            <asp:GridView ID="grdCriteria" runat="server"
                                DataKeyNames="ReportParameterId, ViewName, ColumnName, DataType" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                                GridLines="None" BorderColor="#3276B1"
                                CellPadding="4"
                                EmptyDataText=""
                                AlternatingRowStyle-CssClass="grdNormalAltrow">

                                <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                <Columns>
                                    <asp:BoundField HeaderText="ReportParameterId" DataField="ReportParameterId" Visible="false"></asp:BoundField>
                                    <asp:BoundField HeaderText="ViewName" DataField="ViewName" Visible="false"></asp:BoundField>
                                    <asp:BoundField HeaderText="ColumnName" DataField="ColumnName" Visible="false"></asp:BoundField>
                                    <asp:BoundField HeaderText="DataType" DataField="DataType" Visible="false"></asp:BoundField>
                                    <asp:BoundField HeaderText="Column" DataField="ColumnLabel"></asp:BoundField>
                                    <asp:TemplateField HeaderText="Operator">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlOperator" runat="server" CssClass="form-control" Enabled ="true"></asp:DropDownList>

                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Value" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-control" DataValueField="CompanyId" DataTextField="CompanyName"  ></asp:DropDownList>
                                           
                                            <asp:DropDownList ID="ddlPlanType" runat="server" CssClass="form-control" DataValueField="PlanTypeId" DataTextField="LongDesc" ></asp:DropDownList>
                                            <asp:TextBox ID="txtValue" runat="server" CssClass="form-control" DataValueField="CompanyId" DataTextField="CompanyName" ></asp:TextBox>                   
                                        </ItemTemplate>

                                    </asp:TemplateField>
           
                                    <asp:TemplateField HeaderText="Sort" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkOrder" runat="server" CssClass="check" OnCheckedChanged="UpdateOrderBy" AutoPostBack="true" />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Order" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblOrder" runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlAscDesc" runat="server" CssClass="form-control" Width="85px" OnSelectedIndexChanged="ddlAscDesc_SelectedIndexChanged" AutoPostBack="true">
                                                <asp:ListItem>Asc</asp:ListItem>
                                                <asp:ListItem>Desc</asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Center" />
                                <RowStyle CssClass="grdNormalrow" HorizontalAlign="Center" />
                            </asp:GridView>

                        </div>
                    </div>
             <div class="form-group">
                        <asp:Label ID="lblChooseFormat" runat="server" class="col-md-12 " Text="Select desired format.<br/>"></asp:Label>
                    </div>




                   


                    <div id="divProcessing" style="display: none" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <asp:Image ID="img1" runat="server" ImageUrl="~/img/processing2.gif" Width="80px" />
                      
                    </div>
                    <div class=" col-xs-12 col-sm-12 col-md-12 col-lg-12 ">                      
                        <asp:ImageButton ID="btnExcel" runat="server" Width="75px" ImageUrl="img/ExportXLS.png" OnMouseOver="src='/img/ExportXLSover.png';" OnMouseOut="src='/img/ExportXLS.png';" ImageAlign="AbsMiddle" OnClick="btnExcel_Click" OnClientClick="javascript:prm_InitializeRequest()" />
                        <asp:ImageButton ID="btnWord" runat="server" Width="75px" ImageUrl="img/ExportDOC.png" OnMouseOver="src='/img/ExportDOCover.png';" OnMouseOut="src='/img/ExportDOC.png';" ImageAlign="AbsMiddle" autopostback="true" />
                        <asp:ImageButton ID="btnPDF" runat="server" Width="75px" ImageUrl="img/ExportPDF.png" OnMouseOver="src='/img/ExportPDFover.png';" OnMouseOut="src='/img/ExportPDF.png';" ImageAlign="AbsMiddle" autopostback="true" />
                    </div>

                </div>
            </div>


                <div class="container form-group ">
                    <div class=" col-xs-12 col-sm-12 col-md-12 col-lg-12  text-success">
                        <asp:LinkButton ID="lnkEdit" runat="server" data-toggle="modal" data-target="#ModalReports" CssClass="text-success"> 
                            <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
                         Organize your reports

                        </asp:LinkButton>
                        <br />
                        <br />
                    </div>
                </div>



                <div class="container form-group ">
                    <div class=" col-xs-12 col-sm-12 col-md-12 col-lg-12 ">

                        <h4>Favorites</h4>
                        <asp:DataList ID="lstFavorite" runat="server" Width="100%" RepeatColumns="1" CellSpacing="3" CellPadding="3" BackColor="#EFF3FB">
                            <ItemStyle />
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkFavs" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ShortDesc")%>' CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ReportId")%>'>    <%--data-toggle="modal" data-target="#ModalParameters"--%>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>
                </div>


                <%-- <div class="form-group ">
                <div class=" col-xs-12 col-sm-12 col-md-12 col-lg-12 ">
                    <br />
                    <br />
                    <h3>Standard Reports</h3>
                </div>
            </div>--%>
                <div class="container form-group ">
                    <div class=" col-xs-12 col-sm-12 col-md-12 col-lg-12 ">
                        <br />

                        <h4>Standard Reports</h4>
                        <asp:DataList ID="lstReports" runat="server" Width="100%" RepeatColumns="1"  BackColor="#EFF3FB">
                            <ItemStyle  />
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkReport" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ShortDesc")%>' CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ReportId")%>'>    <%--data-toggle="modal" data-target="#ModalParameters"--%>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>
                </div>
           
        </div>
    </div>



    <%--Report List Edit MODAL SECTION--%>
    <div class="modal fade" id="ModalReports" tabindex="-1" role="dialog" aria-labelledby="myModalReports" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title text-success" id="myModalInfoLabel">
                        <asp:Label ID="mlblInfoTitle" runat="server" Text="Organize your reports"></asp:Label></h4>
                </div>
                <div class="modal-body ">
                    <div class="well ">
                        <div class="form-group">
                            <asp:Label ID="mlblInfoText1" runat="server" class="col-md-12 " Text="Click to choose where you would like each report to be available, or Hide the report from all lists."></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="mlblInfoText2" runat="server" class="col-md-12 "></asp:Label>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-12 col-md-12" style="max-height: 350px; overflow-y: scroll;">
                               <%-- <asp:ScriptManager ID="ScriptManager1" runat="server" />--%>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>

                                        <asp:GridView ID="grdReports" runat="server"
                                            DataKeyNames="ReportPermissionId" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                                            GridLines="None" BorderColor="#3276B1"
                                            CellPadding="4"
                                            EmptyDataText="No Reports found."
                                            AlternatingRowStyle-CssClass="grdNormalAltrow">
                                            <%--  OnSelectedIndexChanged="OnSelectedIndexChanged"> --%>
                                            <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                            <Columns>
                                                <asp:BoundField HeaderText="Report Id" DataField="ReportPermissionId" Visible="false" />
                                                <asp:TemplateField HeaderText="Dashboard">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkDashboard" runat="server" Checked='<%# IIf(DataBinder.Eval(Container.DataItem, "Dashboard").ToString().Equals("True"), "True", "False")%>' AutoPostBack="true" OnCheckedChanged="chkDashboard_CheckedChanged" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="Report Name" DataField="ShortDesc" Visible="true" HtmlEncode="false"></asp:BoundField>
                                                <asp:TemplateField HeaderText="Favorite">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkFavorite" runat="server" Checked='<%# IIf(DataBinder.Eval(Container.DataItem, "Favorite").ToString().Equals("True"), "True", "False")%>'  AutoPostBack="true" OnCheckedChanged="chkFavorite_CheckedChanged"/>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Standard">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkStandard" runat="server" Checked='<%# IIf(DataBinder.Eval(Container.DataItem, "Hide").ToString().Equals("True"), "False", (IIf(DataBinder.Eval(Container.DataItem, "Favorite").ToString().Equals("False"), "True", "False")))%>' AutoPostBack="true" OnCheckedChanged="chkStandard_CheckedChanged" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Hide ">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkHide" runat="server" Checked='<%# IIf(DataBinder.Eval(Container.DataItem, "Hide").ToString().Equals("True"), "True", "False")%>' AutoPostBack="true" OnCheckedChanged="chkHide_CheckedChanged"/>
                                                    </ItemTemplate>
                                                </asp:TemplateField>


                                            </Columns>
                                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                            <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="mlblInfoText3" runat="server" class="col-md-12"></asp:Label>
                        </div>
                    </div>           
            </div>
            <div class="modal-footer">
                <asp:ImageButton ID="mbtnSave" ImageUrl="../img/GreenSaveBtn.png" runat="server" OnMouseOver="src='/img/GreenSaveBtnOver.png';" OnMouseOut="src='/img/GreenSaveBtn.png';" OnClick="mbtnSave_Click"></asp:ImageButton>
            </div>
        </div>
    </div>
    </div>
    <style>
        @media screen and (max-width: 768px) {
    .container{
        display:inline-block !important;
    }
}
    </style>

</asp:Content>



