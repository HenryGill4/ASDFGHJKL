<%@ Page Title="Company Relationship Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="Admin_CompanyRelationship.aspx.vb" 
    Inherits="HReaseApp.Admin_CompanyRelationship" 
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
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
            min-width: 300px !important;
            max-width:600px !important; 
            width:50% !important;
        }
    </style>
    <div class="HREwrapper">
        <div id="divPageTitle">
            <div >
                <br />
                <h4><b>Company Relationships</b></h4>
            </div>
        </div>

       <div id="divNextButton" runat="server" class="hidden-xs" style="float:right; display:inline; margin-top:-7px;">
            <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
            <asp:Image ID="Image1" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
        </div>

        <div id="divTopHeader" runat="server">   
            <div id="divCompanyList" runat="server" class="well HRESlateBlue HRERewrap form-inline">
                <span style="padding-left:10px; padding-right:10px; width:10%;">
                    Company:
                </span>
                <span style="min-width:300px; max-width:600px; width:50%;"> 
                    <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-control" DataValueField="CompanyId" DataTextField="CombinedCompanyName" AutoPostBack="true" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged"></asp:DropDownList>
                </span>
                <script>
                    $('#<%=ddlCompany.ClientID%>').chosen();
                </script>
                <span style="width:20%;">
                    &nbsp;&nbsp;<asp:CheckBox ID="chkActive" runat="server" Checked="true" Text="&nbsp;&nbsp;Active Companies &nbsp;&nbsp;" AutoPostBack="true" OnCheckedChanged="chkActive_CheckedChanged" Visible="true"></asp:CheckBox>
                </span>
                <br /><br />
            </div>   
        </div>

        <div id="divCompanyName" runat="server" class="well" style="text-align:center; margin-right:5%;">
            <b><asp:Label ID="lblCompanyName" runat="server" Text="CompanyName"></asp:Label></b>
            <br /><br />
        </div>   

        <div id="divChildof" class="well HREWhite" runat="server">            
            <div class="form-group">
                <div class="col-sm-12">
                    <h4>Companies that can administer <b><asp:Label ID="lblCompanyNameA" runat="server" Text= "Company Name"></asp:Label> </b> (Parent Companies) </h4>
                    <asp:GridView ID="grdChildCompanies" runat="server" 
                        DataKeyNames="CompanyRelationshipId, CompanyId1, CompanyId2,RelationshipTypeId" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                        GridLines="None" BorderColor="#3276B1"
                        CellPadding="4"
                        EmptyDataText="No Parent companies are currently assigned to this company." 
                        CssClass = "small" >
                        <%--  OnSelectedIndexChanged="OnSelectedIndexChanged"> --%>
                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                        <Columns>
                            <asp:BoundField HeaderText="CompanyRelationshipId" DataField="CompanyRelationshipId" Visible="false" />
                            <asp:BoundField HeaderText="Parent Company Id" DataField="CompanyId1" Visible="false" />
                            <asp:BoundField HeaderText="Child Company Id" DataField="CompanyId2" Visible="false" />
                            <asp:BoundField HeaderText="Relationship Id" DataField="RelationshipTypeId" Visible="false" />
<%--                            <asp:BoundField HeaderText="Relationship Name" DataField="RelationshipName" Visible="false" />--%>
                            <%--<asp:TemplateField HeaderText="Relationship Name" ItemStyle-Width="10%">
                                <ItemTemplate>
                                    <asp:Label ID="lblRelationName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RelationshipName")%>' />
                                    <asp:TextBox ID="txtRelationName" runat="server" DataValueField="RelationshipName" DataTextField="LongDesc" CssClass="form-control" />
                                </ItemTemplate>
                            </asp:TemplateField>--%>

                            <asp:BoundField HeaderText="Parent Company" DataField="ParentCompany" Visible="true" Itemstyle-Width="20%"></asp:BoundField>
                            
                              <asp:BoundField HeaderText="Child Company" DataField="ChildCompany" Visible="true" ItemStyle-Width="20%"></asp:BoundField>

                            <asp:TemplateField HeaderText="Relationship Type" ItemStyle-Width="20%">
                                <ItemTemplate>
                                    <asp:Label ID="lblRelationship" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RelationshipType")%>' />
                                    <asp:DropDownList ID="ddlChildRelationshiptype" runat="server" CssClass="form-control" DataValueField="RelationshipId" DataTextField="LongDesc" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Begin Date" ItemStyle-Width="10%" >
                                <ItemTemplate>
                                    <asp:Label ID="lblBeginDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>'  />
                                    <asp:TextBox ID="txtBeginDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>'  CssClass="form-control" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="End Date" ItemStyle-Width="10%">
                                <ItemTemplate>
                                    <asp:Label ID="lblEndDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>'  />
                                    <asp:TextBox ID="txtEndDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>'  CssClass="form-control" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                    </asp:GridView>
                </div>
            </div>
            <div class="form-group">
                <div class="HREpadR10">
                    <asp:ImageButton ID="btnEditCompanyChild" runat="server" ImageUrl="img/GreenEditBtnNew.png" OnMouseOver="src='/img/GreenEditBtnOverNew.png';" OnMouseOut="src='/img/GreenEditBtnNew.png';"  CausesValidation="False" />
                    <asp:ImageButton ID="btnCancelCompanyChild" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';"  TabIndex="40" CausesValidation="False"   />
                </div>
                <div class="HREpadR10">
                    <asp:ImageButton ID="btnAddCompanyChild" runat="server" ImageUrl="img/BlueAddBtnNew.png" OnMouseOver="src='/img/BlueAddBtnOver2.png';" OnMouseOut="src='/img/BlueAddBtnNew.png';" ImageAlign="right" data-toggle="modal" data-target="#ModalAddParent" onclientclick="return false" CausesValidation="False" />
                    <asp:ImageButton ID="btnSaveCompanyChild" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="right" TabIndex="41" CausesValidation="False"   />
                </div>
            </div>
        </div>

        <div id="divParent" class="well HREWhite " runat="server">            
            <div class="form-group">
                <div class="col-sm-12">
                    <h4>Companies that <b> <asp:Label ID="lblCompanyNameB" runat="server" Text= "Company Name"></asp:Label></b> can administer (Child Companies) </h4>
                    <asp:GridView ID="grdParentCompanies" runat="server"
                        DataKeyNames="CompanyRelationshipId, CompanyId1, CompanyId2, RelationshipTypeId" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                        GridLines="None" BorderColor="#3276B1"
                        CellPadding="4"
                        EmptyDataText="No Children companies are currently assigned to this company." 
                        CssClass = "small" >
                        <%--  OnSelectedIndexChanged="OnSelectedIndexChanged"> --%>
                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                        <Columns>
                            <asp:BoundField HeaderText="CompanyRelationshipId" DataField="CompanyRelationshipId" Visible="false" />
                            <asp:BoundField HeaderText="Parent Company Id" DataField="CompanyId1" Visible="false" />
                            <asp:BoundField HeaderText="Child Company Id" DataField="CompanyId2" Visible="false" />
                            <asp:BoundField HeaderText="Relationship Id" DataField="RelationshipTypeId" Visible="false" />

                           <%-- <asp:TemplateField HeaderText="Relationship Name" ItemStyle-Width="10%">
                                <ItemTemplate>
                                    <asp:Label ID="lblRelationName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RelationshipName")%>' />
                                    <asp:TextBox ID="txtRelationName" runat="server" Text='Custom Relationship Name'  CssClass="form-control" />
                                </ItemTemplate>
                            </asp:TemplateField>--%>

                            <asp:BoundField HeaderText="Parent Company" DataField="ParentCompany" Visible="true" ItemStyle-Width="20%"></asp:BoundField>
                            
                             
                            
                              <asp:BoundField HeaderText="Child Company" DataField="ChildCompany" Visible="true" ItemStyle-Width="20%"></asp:BoundField>

                            <asp:TemplateField HeaderText="Relationship Type" ItemStyle-Width="20%">
                                <ItemTemplate>
                                    <asp:Label ID="lblRelationship" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RelationshipType")%>' />
                                    <asp:DropDownList ID="ddlParentRelationshiptype" runat="server" CssClass="form-control" DataValueField="RelationshipId" DataTextField="LongDesc" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Begin Date" ItemStyle-Width="10%">
                                <ItemTemplate>
                                    <asp:Label ID="lblBeginDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' />
                                    <asp:TextBox ID="txtBeginDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' CssClass="form-control" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="End Date" ItemStyle-Width="10%">
                                <ItemTemplate>
                                    <asp:Label ID="lblEndDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' />
                                    <asp:TextBox ID="txtEndDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>'  CssClass="form-control" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                    </asp:GridView>
                </div>
            </div>
            <div class="form-group">
                <div class="HREpadR10">
                    <asp:ImageButton ID="btnEditCompanyParent" runat="server" ImageUrl="img/GreenEditBtnNew.png" OnMouseOver="src='/img/GreenEditBtnOverNew.png';" OnMouseOut="src='/img/GreenEditBtnNew.png';"  CausesValidation="False" />
                    <asp:ImageButton ID="btnCancelCompanyParent" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';"  TabIndex="40" CausesValidation="False"   />
                </div>
                <div class="HREpadR10">
                    <asp:ImageButton ID="btnAddCompanyParent" runat="server" ImageUrl="img/BlueAddBtnNew.png" OnMouseOver="src='/img/BlueAddBtnOver2.png';" OnMouseOut="src='/img/BlueAddBtnNew.png';" ImageAlign="right" data-toggle="modal" data-target="#ModalAddChild" onclientclick="return false" CausesValidation="False" />
                    <asp:ImageButton ID="btnSaveCompanyParent" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="right" TabIndex="41" CausesValidation="False"   />
                </div>
            </div>
        </div>
   
    </div>
      
    <%----Selected Company IS THE child and adding a Parent------%>
     <div class="modal fade" id="ModalAddParent" tabindex="-1" role="dialog" aria-labelledby="myModalAddChild" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title text-success" id="myModalParentLabel">
                        <asp:Label ID="Label1" runat="server" Text="Add new Parent Relationship"></asp:Label></h4>
                </div>
                <div class="modal-body HREOffWhite">
                    <div class="HREWhite">
                        <h4></h4>
                        <div class="form-group">
                            <label for="ddlAddParent" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Parent Company:</label>
                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9 ">
                                <asp:DropDownList ID="ddlAddParent" runat="server" CssClass="form-control" TabIndex="10" DataValueField="CompanyId" DataTextField="CompanyName" AutoPostBack="false" Width="400px"></asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="ddlAddParentRelationshiptype" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Relationship:</label>
                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9 ">
                                <asp:DropDownList ID="ddlAddParentRelationshiptype" runat="server" Width="200px" CssClass="form-control" DataValueField="RelationshipId" DataTextField="LongDesc" />
                            </div>
                        </div>
                        <%--<div class="form-group">
                            <label for="txtAddParentRelationshipName" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Relationship:</label>
                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9 ">
                                <asp:TextBox ID="txtAddParentRelationshipName" runat="server" Width="200px" CssClass="form-control" DataValueField="RelationshipName" DataTextField="LongDesc" />
                            </div>
                        </div>--%>

                        <div class="form-group">
                            <label for="txtParentBeginDate" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Begin Date:</label>
                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9 ">
                                <asp:TextBox ID="txtParentBeginDate" runat="server" CssClass="form-control" Width="120" TabIndex="27" placeholder="mm/dd/yyyy"></asp:TextBox>
                                <div class="text-danger text-center">
                                    <asp:RequiredFieldValidator ControlToValidate="txtParentBeginDate" ErrorMessage="** Begin Date is required" Text="" runat="server"  ValidationGroup="valParent"/><br />
                                    <asp:CompareValidator ID="cvalParentBegin" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtParentBeginDate" ErrorMessage="** Begin Date is not formatted correctly (mm/dd/yyyy)" ValidationGroup="valParent"></asp:CompareValidator>
                                </div>
                            </div>
                        </div>
                        <%--<div class="form-group">
                            <label for="txt" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Custome Relationship Name:</label>
                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9 ">
                                <asp:TextBox ID="txtRelationName" runat="server" CssClass="form-control" Width="120" TabIndex="28" placeholder="Custom Name Here"></asp:TextBox>
                            </div>
                        </div>--%>
                    </div>
                </div>
                <div class="modal-footer HREOffWhite">
                    <asp:ImageButton ID="btnParentAddSave" ImageUrl="../img/BlueSaveBtnNew.png" runat="server" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ValidationGroup="valParent"></asp:ImageButton>
                    <asp:ImageButton ID="btnParentAddCancel" ImageUrl="../img/GreenCancelBtnNew.png" runat="server" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" CausesValidation="false"></asp:ImageButton>

                </div>
            </div>
        </div>
    </div>

        <%----Selected Company IS THE PARENT and adding a child------%>
    <div class="modal fade" id="ModalAddChild" tabindex="-1" role="dialog" aria-labelledby="myModalAddChild" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title text-success" id="myModalInfoLabel">
                        <asp:Label ID="mlblInfoTitle" runat="server" Text="Add new Parent Relationship"></asp:Label></h4>
                </div>
                <div class="modal-body HREOffWhite">
                    <div class="well HREWhite">
                        <h4></h4>
                        <div class="form-group">
                            <label for="ddlAddChild" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Child Company:</label>
                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9 ">
                                <asp:DropDownList ID="ddlAddChild" runat="server" CssClass="form-control" TabIndex="10" DataValueField="CompanyId" DataTextField="CompanyName" AutoPostBack="false" Width="400px"></asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="ddlAddChildRelationshiptype" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Relationship:</label>
                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9 ">
                                <asp:DropDownList ID="ddlAddChildRelationshiptype" runat="server" Width="200px" CssClass="form-control" DataValueField="RelationshipId" DataTextField="LongDesc" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="txtChildBeginDate" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Begin Date:</label>
                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9 ">
                                <asp:TextBox ID="txtChildBeginDate" runat="server" CssClass="form-control" Width="120" TabIndex="27" placeholder="mm/dd/yyyy"></asp:TextBox>
                                <div class="text-danger text-center">
                                    <asp:RequiredFieldValidator ControlToValidate="txtChildBeginDate" ErrorMessage="** Begin Date is required" Text="" runat="server" ValidationGroup="valChild" /><br />
                                    <asp:CompareValidator ID="cmvalBeginDate" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtChildBeginDate" ErrorMessage="** Begin Date is not formatted correctly (mm/dd/yyyy)" ValidationGroup="valChild"></asp:CompareValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer HREOffWhite">
                    <asp:ImageButton ID="btnChildAddSave" ImageUrl="../img/BlueSaveBtnNew.png" runat="server" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ValidationGroup="valChild"></asp:ImageButton>
                    <asp:ImageButton ID="btnChildAddCancel" ImageUrl="../img/GreenCancelBtnNew.png" runat="server" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" CausesValidation="false"></asp:ImageButton>

                </div>
            </div>
        </div>
    </div>
     <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px 10px 10px 10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HRENext {padding:5px 5px 5px 5px; float:right; width:50%; }
        .img {display: inline-block; width: auto; height: auto;}
    </style>
</asp:Content>

