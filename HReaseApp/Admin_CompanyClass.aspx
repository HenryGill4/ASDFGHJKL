<%@ Page Title="Company Class" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="Admin_CompanyClass.aspx.vb" 
    Inherits="HReaseApp.Admin_CompanyClass" 
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
                <h4><b>Company Benefit Classes</b></h4>
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

        <div id="divCompanyClass" class="well HREWhite" runat="server" >
            <div class="form-group">
                <div class="hidden-sm hidden-xs col-md-1 col-lg-1 "></div>
                <div class="col-xs-12 col-sm-12 col-md-7 col-lg-7 ">
                    <asp:CheckBox ID="chkParentInherite" runat="server" AutoPostBack="true" OnCheckedChanged="chkParentInherite_CheckedChanged" />
                    <asp:Label ID="lblParent" runat="server" Text="Classes Inherited from Parent company blah blah" />
                    <asp:Label ID="lblParentId" runat="server" Visible="false" />
                    <br />
                </div>
            </div>
            <div style="float:right;">
                <asp:CheckBox ID="chkActiveOnly" runat="server" Checked="true" CssClass=" checkbox-inline" Autopostback="true" Text="Active Classes" OnCheckedChanged="chkActiveOnly_CheckedChanged"/>                  
            </div>
             <div class="form-group">
                    <div class="col-sm-11">
                        <div class="table-responsive">
                        <asp:GridView ID="grdParentBenefitClass" runat="server" 
                        DataKeyNames="CompanyId, ClassId,InheritParentClass,InheritClassId,ParentCompany,ParentCompanyId " 
                        AutoGenerateColumns="False"  HorizontalAlign="Center" Width="100%"
                        GridLines="None" BorderColor="#3276B1"
                        CellPadding="4"
                        EmptyDataText="No Benefit Classes are currently assigned." 
                        CssClass = "small"
                     
                        OnRowdatabound="grdParentBenefitClass_RowDataBound"
                        OnRowCommand="grdParentBenefitClass_RowCommand"
                        OnRowEditing="grdParentBenefitClass_RowEditing"
                        OnRowCancelingEdit="grdParentBenefitClass_RowCancelingEdit"
                        OnRowUpdating="grdParentBenefitClass_RowUpdating1"
                        ShowFooter="true"> 
                    
                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                        <Columns>
                            <asp:BoundField HeaderText="ClassId" DataField="ClassId" Visible="false" />
                             <asp:BoundField HeaderText="InheritParentClass" DataField="ClassId" Visible="false" />
                             <asp:BoundField HeaderText="InheritClassId" DataField="ClassId" Visible="false" />
                             <asp:BoundField HeaderText="ParentCompany" DataField="ClassId" Visible="false" />
                               <asp:BoundField HeaderText="ParentCompanyId" DataField="ClassId" Visible="false" />
               
                             <asp:TemplateField HeaderText="Short Desc">
                                <ItemTemplate>
                                    <asp:Label ID="lblShortDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ShortDesc")%>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtShortDesc" runat="server" CssClass="form-control" Width="50%" Text='<%# DataBinder.Eval(Container.DataItem, "ShortDesc")%>' />
                                </EditItemTemplate>
                                 <FooterTemplate>
                                    <asp:TextBox ID="txtNewShortDesc" runat="server" CssClass="form-control" Width="50%"  />
                                </FooterTemplate>
                             </asp:TemplateField>

                             <asp:TemplateField HeaderText="Long Desc">
                                <ItemTemplate>
                                    <asp:Label ID="lblLongDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "LongDesc")%>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtLongDesc" runat="server" CssClass="form-control"  Text='<%# DataBinder.Eval(Container.DataItem, "LongDesc")%>' Width="90%" />
                                </EditItemTemplate>
                                 <FooterTemplate>
                                    <asp:TextBox ID="txtNewLongDesc" runat="server" CssClass="form-control" Width="90%"  />
                                </FooterTemplate>
                             </asp:TemplateField>

                            <asp:TemplateField HeaderText="BeginDate">
                                <ItemTemplate>
                                    <asp:Label ID="lblBeginDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtBeginDate" runat="server" CssClass="form-control" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' />
                                </EditItemTemplate>
                                <FooterTemplate>
                                 <asp:TextBox ID="txtNewBeginDate" runat="server" CssClass="form-control" Width="100px"  />
                                </FooterTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="End Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblEndDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' />
                                </EditItemTemplate>
                                 <FooterTemplate>
                                 <asp:TextBox ID="txtNewEndDate" runat="server" CssClass="form-control" Width="100px" Text="12/31/2999" />
                                </FooterTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit"></asp:LinkButton>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="lnkSave" runat="server" Text="Save" CommandName="Update"></asp:LinkButton>
                                    <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel"></asp:LinkButton>
                                </EditItemTemplate>
                                <FooterTemplate>
                                     <asp:LinkButton ID="lnkAdd" runat="server" CommandName="Add" Text="Add" />
                                 </FooterTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <FooterStyle backcolor="WhiteSmoke" HorizontalAlign="Left"/>
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                    </asp:GridView>
                    </div>
                </div>
            </div>
         </div>

        <div id="divChildCompanies" class="well HRELightBlue" runat="server" >
            <div class="form-group">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 ">
                    <h4>Companies Related to <b> <asp:Label ID="lblCompanyNameB" runat="server" Text= "Company Name"></asp:Label></b> (Child Companies) </h4>
                    <br />
                    <asp:GridView ID="grdChildCompanies" runat="server"
                        DataKeyNames="CompanyId1, CompanyId2" AutoGenerateColumns="False" Width="80%" HorizontalAlign="Center"
                        GridLines="None" BorderColor="#3276B1"
                        CellPadding="4"
                        EmptyDataText="No Children companies are currently assigned to Company." 
                        CssClass = "small"
                        OnRowDataBound="grdChildCompanies_RowDataBound"
                         >
                       
                        <AlternatingRowStyle CssClass="grdNormalrow"></AlternatingRowStyle>
                        <Columns>
                            <asp:BoundField HeaderText="Parent Company Id" DataField="CompanyId1" Visible="false" />
                            <asp:BoundField HeaderText="Child Company Id" DataField="CompanyId2" Visible="false" />
                            
                             <asp:TemplateField HeaderText="Inherit Parent Classes" ItemStyle-Width="20%" ItemStyle-CssClass="center">
                                <ItemTemplate  >                                   
                                    <asp:checkbox ID="chkInherit" runat="server" AutoPostBack="true" checked ='<%# DataBinder.Eval(Container.DataItem, "InheritParentClass")%>'  OnCheckedChanged="chkInherit_CheckedChanged"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            
                              <asp:BoundField HeaderText="Child Company" DataField="ChildCompany" Visible="true" ItemStyle-Width="75%"  ItemStyle-Font-Bold="true"></asp:BoundField>

                           <asp:TemplateField  >
                                    <ItemTemplate   >
                                       
                                       <asp:Panel ID="pnlChildClasses" runat="server" Visible ="true"  >
                                            </tr>
                                          <td   class ="grdNormalaltrow"></td>
                                            <td  colspan="3"  class ="grdNormalalttrow" >
                                               <%-- Benefit Classes--%>
                                                   <br />
                                                 <asp:GridView id="grdChildBenefitClass" runat="server"
                                                     style="border:1px solid grey;"
                                                     DataKeyNames="CompanyId, ClassId, InheritParentClass, ParentCompanyId,InheritClassId" AutoGenerateColumns="False" Width="90%" HorizontalAlign="Center"
                                                     GridLines="none"  BorderColor="#3276B1"
                                                     CellPadding="4"                                                    
                                                     CssClass = "small"
                                                     ShowFooter="true"
                                                     onrowdatabound="grdChildBenefitClass_RowDataBound"
                                                     OnRowEditing="grdChildBenefitClass_RowEditing"
                                                     OnRowCancelingEdit="grdChildBenefitClass_RowCancelingEdit"
                                                     OnRowUpdating="grdChildBenefitClass_RowUpdating"
                                                     OnRowCommand="grdChildBenefitClass_RowCommand"> 
                    
                                                    <AlternatingRowStyle CssClass="grdNormalrow"></AlternatingRowStyle>
                                                    <Columns>
                                                        <asp:BoundField HeaderText="ClassId" DataField="ClassId" Visible="false" />
                                                        <asp:BoundField HeaderText="Parent Company Id" DataField="ParentCompanyId" Visible="false" />
                                                        <asp:BoundField HeaderText="Child Company Id" DataField="CompanyId" Visible="false" />
                                                        <asp:BoundField HeaderText="InheritParentClass" DataField="InheritParentClass" Visible="false" />
                                                        <asp:BoundField HeaderText="InheritClassId" DataField="InheritClassId" Visible="false" />
               
                                                         <asp:TemplateField HeaderText="Short Desc">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblShortDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ShortDesc")%>' />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtShortDesc" runat="server" CssClass="form-control" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "ShortDesc")%>' />
                                                            </EditItemTemplate>
                                                             <FooterTemplate>
                                                                <asp:TextBox ID="txtNewShortDesc" runat="server" CssClass="form-control" Width="100px"  />
                                                            </FooterTemplate>
                                                         </asp:TemplateField>

                                                         <asp:TemplateField HeaderText="Long Desc">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblLongDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "LongDesc")%>' />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtLongDesc" runat="server" CssClass="form-control" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "LongDesc")%>' />
                                                            </EditItemTemplate>
                                                             <FooterTemplate>
                                                                <asp:TextBox ID="txtNewLongDesc" runat="server" CssClass="form-control" Width="100px"  />
                                                            </FooterTemplate>
                                                         </asp:TemplateField>


                                                        <asp:TemplateField HeaderText="BeginDate">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblBeginDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtBeginDate" runat="server" CssClass="form-control" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' />
                                                            </EditItemTemplate>
                                                              <FooterTemplate>
                                                             <asp:TextBox ID="txtNewBeginDate" runat="server" CssClass="form-control" Width="100px"  />
                                                        </FooterTemplate>

                                                        </asp:TemplateField>
                                                         <asp:TemplateField HeaderText="End Date">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblEndDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' />
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' />
                                                            </EditItemTemplate>
                                                              <FooterTemplate>
                                                             <asp:TextBox ID="txtNewEndDate" runat="server" CssClass="form-control" Width="100px" Text="12/31/2999" />
                                                        </FooterTemplate>
                                                        </asp:TemplateField>
                           
                                                         <asp:TemplateField HeaderText="">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit"></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <asp:LinkButton ID="lnkSave" runat="server" Text="Save" CommandName="Update"></asp:LinkButton>
                                                                <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel"></asp:LinkButton>
                                                            </EditItemTemplate>
                                                            <FooterTemplate>
                                                                 <asp:LinkButton ID="lnkAdd" runat="server" CommandName="Add" Text="Add" />
                                                             </FooterTemplate>
                                                        </asp:TemplateField>
                            

                                                    </Columns>
                                                    <FooterStyle backcolor="WhiteSmoke" HorizontalAlign="Left"/>
                                                    <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                                    <RowStyle CssClass="grdNormalAltrow" HorizontalAlign="Left" />
                                                </asp:GridView>
                                                <div class="right small h1Error"><asp:Label ID="lblError" runat="server" Text="* All fields are required" /></div>
                                                </td>
                                         </asp:Panel>
                                    </ItemTemplate>
                                </asp:TemplateField>
                          
                           
                        </Columns>
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                    </asp:GridView>
                </div>
            </div>
           
        </div>

    </div>
     <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }
        @media screen and (max-width: 768px) {
            .col-sm-11{
                padding: 0px !important;
            }
    .table-responsive {
        overflow-x: auto;
        -webkit-overflow-scrolling: touch;
    }
    .table-responsive .small {
        font-size: 1.2rem; /* Adjust as needed */
    }

    .table-responsive .form-control {
        padding: 1rem 1rem 1rem; /* Adjust as needed */
    }
}
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




