<%@ Page Title="Company Documents and Links"
    Language="vb"
    AutoEventWireup="false"
    MasterPageFile="~/AppMasterHeader.Master"
    CodeBehind="Admin_CompanyManageDocument.aspx.vb"
    Inherits="HReaseApp.Admin_CompanyManageDocument"
    MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" runat="Server">
    <div id="tabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>
    </div>
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" runat="Server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" rel="stylesheet" />
    <style>
        .chosen-container {
            min-width: 300px !important;
            max-width: 600px !important;
            width: 50% !important;
        }
    </style>
    <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>Company Documents</b></h4>
            </div>
        </div>

        <div id="divNextButton" runat="server" class="hidden-xs" style="float: right; display: inline; margin-top: -7px;">
            <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
            <asp:Image ID="Image1" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
        </div>

        <div id="divTopHeader" runat="server">
            <div id="divCompanyList" runat="server" class="well HRESlateBlue HRERewrap form-inline">
                <span style="padding-left: 10px; padding-right: 10px; width: 10%;">Company:
                </span>
                <span style="min-width: 300px; max-width: 600px; width: 50%;">
                    <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-control" DataValueField="CompanyId" DataTextField="CombinedCompanyName" AutoPostBack="true" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged"></asp:DropDownList>
                </span>
                <script>
                    $('#<%=ddlCompany.ClientID%>').chosen();
                </script>
                <span style="width: 20%;">&nbsp;&nbsp;<asp:CheckBox ID="chkActive" runat="server" Checked="true" Text="&nbsp;&nbsp;Active Companies &nbsp;&nbsp;" AutoPostBack="true" OnCheckedChanged="chkActive_CheckedChanged" Visible="true"></asp:CheckBox>
                </span>
                <br />
                <br />
            </div>
        </div>

        <div id="divCompanyName" runat="server" class="well" style="text-align: center; margin-right: 5%;">
            <b>
                <asp:Label ID="lblCompanyName" runat="server" Text="CompanyName"></asp:Label></b>
            <br />
            <br />
        </div>

        <div class=" form-group">
            <div class="col-md-12">
                <asp:ValidationSummary HeaderText="<h4>Please enter a value in the following fields:</h4>" DisplayMode="SingleParagraph" EnableClientScript="true" runat="server" CssClass="alert alert-danger text-danger text-center" ValidationGroup="valDocs" />
                <asp:ValidationSummary HeaderText="<h4>Please enter a value in the following fields:</h4>" DisplayMode="SingleParagraph" EnableClientScript="true" runat="server" CssClass="alert alert-danger text-danger text-center" ValidationGroup="valDemographics" />

            </div>
        </div>

        <div id="divReviewDocuments" class="well HRETan" runat="server">
            <div class="col-xs-4">
                <h4>Documents:</h4>
            </div>
            <div class="col-xs-4 center">
                <asp:CheckBox ID="chkActiveOnly" runat="server" CssClass=" checkbox-inline" Checked="true" AutoPostBack="true" Text="Show Active Documents only" OnCheckedChanged="chkActiveOnly_CheckedChanged" />
            </div>
            <div class="col-xs-4 pull-right">
                <asp:ImageButton ID="btnDocAdd" runat="server" ImageUrl="img/BlueAddBtnNew.png" OnMouseOver="src='/img/BlueAddBtnOver2.png';" OnMouseOut="src='/img/BlueAddBtnNew.png';" ImageAlign="right" OnClick="btnDocAdd_Click" />
            </div>
            <br />
            <br />

            <div class="HREpadLR20 HREpadTB20">
                <asp:GridView ID="grdDocument" runat="server"
                    DataKeyNames="DocumentId,CompanyId, DocLongDesc,DocTypeDesc, IsAParentDocument, ParentName "
                    AutoGenerateColumns="False" Width="90%"
                    HorizontalAlign="Center"
                    GridLines="None" BorderColor="#3276B1"
                    CellPadding="4"
                    EmptyDataText="No Documents are currently uploaded for company."
                    OnRowCommand="grdDocument_RowCommand"
                    OnRowEditing="grdDocument_RowEditing1"
                    OnRowCancelingEdit="grdDocument_RowCancelingEdit"
                    OnRowUpdating="grdDocument_RowUpdating">

                    <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                    <Columns>
                        <asp:BoundField HeaderText="Document Id" DataField="DocumentId" Visible="false" />
                        <asp:BoundField HeaderText="IsAParentDocument" DataField="IsAParentDocument" Visible="false" />
                        <asp:BoundField HeaderText="ParentName" DataField="ParentName" Visible="false" />
                        <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="left">
                            <ItemTemplate>
                                <asp:Image ID="imgArrow" ImageUrl="~/img/arrow_right.png" Width="20px" runat="server" />
                                <asp:Label ID="lblParent" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ParentName")%>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:ButtonField runat="server" Text="Assign" CommandName="Permissions" HeaderText="Assign" ItemStyle-HorizontalAlign="Center"></asp:ButtonField>

                        <asp:TemplateField HeaderText="Category">
                            <ItemTemplate>
                                <asp:Label ID="lblDocCategoryGrid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocCategoryDesc")%>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlDocCategoryGrid" runat="server" CssClass="form-control" DataValueField="DocumentCategoryId" DataTextField="ShortDesc" AutoPostBack="false" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Type">
                            <ItemTemplate>
                                <asp:Label ID="lblDocTypeGrid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocTypeDesc")%>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlDocTypeGrid" runat="server" CssClass="form-control" DataValueField="DocumentTypeId" DataTextField="ShortDesc" AutoPostBack="false" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Document Name">
                            <ItemTemplate>
                                <asp:Label ID="lblDocNameGrid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocLongDesc")%>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDocName" runat="server" CssClass="form-control" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "DocLongDesc")%>' />
                            </EditItemTemplate>

                        </asp:TemplateField>

                        <asp:BoundField HeaderText="Preview" DataField="Preview" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>

                        <asp:TemplateField HeaderText="Doc Begin">
                            <ItemTemplate>
                                <asp:Label ID="lblDocBeginGrid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDocBeginGrid" runat="server" CssClass="form-control" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' />
                                <asp:RequiredFieldValidator ID="valDocBeginDate" runat="server" ErrorMessage="<h4>Document Begin Date</h4>" ControlToValidate="txtDocBeginGrid" ValidationGroup="valDocs" Display="None"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cmvalDocBeginDate" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtDocBeginGrid" ErrorMessage="<h4>Document Begin Date is not formatted correctly (mm/dd/yyyy)</h4>" Display="None" ValidationGroup="valDocs"></asp:CompareValidator>
                            </EditItemTemplate>

                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Doc End">
                            <ItemTemplate>
                                <asp:Label ID="lblDocEndGrid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDocEndGrid" runat="server" CssClass="form-control" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' />
                                <asp:RequiredFieldValidator ID="valDocEndDate" runat="server" ErrorMessage="<h4>Document Begin Date</h4>" ControlToValidate="txtDocEndGrid" ValidationGroup="valDocs" Display="None"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cmvalDocEndDate" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtDocEndGrid" ErrorMessage="<h4>Document End Date is not formatted correctly (mm/dd/yyyy)</h4>" Display="None" ValidationGroup="valDocs"></asp:CompareValidator>

                            </EditItemTemplate>

                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Update">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkEdit" runat="server" Text="Update" CommandName="Edit"></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="lnkSave" runat="server" Text="Save" CommandName="Update"></asp:LinkButton>
                                <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel"></asp:LinkButton>
                            </EditItemTemplate>

                        </asp:TemplateField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Panel ID="divReviewPermissions" runat="server" Visible="false">
                                    </tr>
                                    <tr class="HRELightBlue">
                                        <td></td>
                                        <td colspan="8">
                                            <h4>Assignments for 
                                                <asp:Label ID="lblDocumentName" runat="server" />
                                            </h4>
                                            <asp:GridView ID="grdDocumentPermission" runat="server"
                                                Style="border: 1px solid grey;"
                                                DataKeyNames="CompanyId, DocumentId, DocumentPermissionId, PlanTypeId" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                                                GridLines="None" BorderColor="#3276B1"
                                                CellPadding="4"
                                                ShowFooter="true"
                                                OnRowDataBound="grdDocumentPermission_RowDataBound"
                                                OnRowEditing="grdDocumentPermission_RowEditing"
                                                OnRowCancelingEdit="grdDocumentPermission_RowCancelingEdit"
                                                OnRowUpdating="grdDocumentPermission_RowUpdating"
                                                OnRowCommand="grdDocumentPermission_RowCommand">

                                                <%--  OnSelectedIndexChanged="OnSelectedIndexChanged">  EmptyDataText="No permissions currently exist for this document."--%>
                                                <AlternatingRowStyle CssClass=" grdNormalAltrow"></AlternatingRowStyle>
                                                <Columns>
                                                    <asp:BoundField HeaderText="Company Id Id" DataField="CompanyId" Visible="false" />
                                                    <asp:BoundField HeaderText="Document Id" DataField="DocumentId" Visible="false" />
                                                    <asp:BoundField HeaderText="Permission Id" DataField="DocumentPermissionId" Visible="false" />

                                                    <%--<asp:BoundField HeaderText="Plan Type" DataField="PlanTypeCode" />--%>
                                                    <asp:TemplateField HeaderText="Plan Type">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPlanTypeGrid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PlanTypeCode")%>' />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:DropDownList ID="ddlPlanTypeGrid" runat="server" CssClass="form-control" DataValueField="PlanTypeId" DataTextField="LongDesc" Width="100px" AutoPostBack="true" OnSelectedIndexChanged="ddlPlanTypeGrid_SelectedIndexChanged" />
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:DropDownList ID="ddlNewPlanTypeGrid" runat="server" CssClass="form-control" DataValueField="PlanTypeId" DataTextField="LongDesc" Width="100px" AutoPostBack="true" OnSelectedIndexChanged="ddlNewPlanTypeGrid_SelectedIndexChanged" />
                                                        </FooterTemplate>
                                                    </asp:TemplateField>

                                                    <%--<asp:BoundField HeaderText="Plan" DataField="PlanDesc" />--%>
                                                    <asp:TemplateField HeaderText="Plan">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPlanGrid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PlanDesc")%>' />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:DropDownList ID="ddlPlanGrid" runat="server" CssClass="form-control" DataValueField="PlanId" DataTextField="PlanLongDesc" AutoPostBack="false" />
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:DropDownList ID="ddlNewPlanGrid" runat="server" CssClass="form-control" DataValueField="PlanId" DataTextField="PlanLongDesc" AutoPostBack="false" />
                                                        </FooterTemplate>
                                                    </asp:TemplateField>

                                                    <%--<asp:BoundField HeaderText="Class" DataField="ClassDesc" />--%>
                                                    <asp:TemplateField HeaderText="Class">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblClassGrid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ClassDesc")%>' />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:DropDownList ID="ddlClassGrid" runat="server" CssClass="form-control" DataValueField="ClassId" DataTextField="ShortDesc" AutoPostBack="false" />
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:DropDownList ID="ddlNewClassGrid" runat="server" CssClass="form-control" DataValueField="ClassId" DataTextField="ShortDesc" AutoPostBack="false" />
                                                        </FooterTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Assign Begin">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPerBeginGrid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtPerBeginGrid" runat="server" CssClass="form-control" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' />
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtNewPerBeginGrid" runat="server" CssClass="form-control" Width="100px" />
                                                        </FooterTemplate>

                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Assign End">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPerEndGrid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' />
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox ID="txtPerEndGrid" runat="server" CssClass="form-control" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' />
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:TextBox ID="txtNewPerEndGrid" runat="server" CssClass="form-control" Width="100px" Text="12/31/2999" />
                                                        </FooterTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Update">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit"></asp:LinkButton>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:LinkButton ID="lnkSave" runat="server" Text="Save" CommandName="Update"></asp:LinkButton>
                                                            <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel"></asp:LinkButton>
                                                        </EditItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:LinkButton ID="lnkAdd" runat="server" CommandName="Add" Text="Save New" />
                                                        </FooterTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <FooterStyle BackColor="WhiteSmoke" HorizontalAlign="Left" />
                                                <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                                <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                                            </asp:GridView>
                                            <br />
                                        </td>
                                        <td colspan="2"></td>
                                    </tr>
                                </asp:Panel>


                                <asp:Panel ID="pnlChildCompanies" runat="server" Visible="false">
                                    <tr class="HRELightBlue">
                                        <td></td>
                                        <td colspan="6">
                                            <h4>Child Companies</h4>
                                            <div style="overflow-y: scroll; overflow-x: hidden; height: 200px; width: 600px;">
                                                <asp:GridView ID="grdChildCompanies" runat="server"
                                                    Style="border: 1px solid grey;"
                                                    DataKeyNames="CompanyId1, CompanyId2, DocumentId" AutoGenerateColumns="False" Width="80%" HorizontalAlign="center"
                                                    GridLines="None" BorderColor="#3276B1"
                                                    CellPadding="4"
                                                    CssClass="small">
                                                    <%--  OnRowDataBound="grdChildCompanies_RowDataBound" --%>
                                                    <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                                    <Columns>
                                                        <asp:BoundField HeaderText="Parent Company Id" DataField="CompanyId1" Visible="false" />
                                                        <asp:BoundField HeaderText="Child Company Id" DataField="CompanyId2" Visible="false" />
                                                        <asp:BoundField HeaderText="DocumentId" DataField="DocumentId" Visible="false" />

                                                        <asp:TemplateField HeaderText="Inherit Document" ItemStyle-Width="20%" ItemStyle-CssClass="center">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkInherit" runat="server" AutoPostBack="true" Checked='<%# DataBinder.Eval(Container.DataItem, "InheritDocument")%>' OnCheckedChanged="chkInherit_CheckedChanged" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:BoundField HeaderText="Child Company" DataField="ChildCompany" Visible="true" ItemStyle-Width="75%"></asp:BoundField>

                                                    </Columns>
                                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                    <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                                    <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                                                </asp:GridView>
                                            </div>

                                            <br />
                                        </td>
                                        <td colspan="3">
                                            <asp:CheckBox ID="chkInheritAll" runat="server" AutoPostBack="true" Checked='false' OnCheckedChanged="chkInheritAll_CheckedChanged" Text="Select all" TextAlign="Right" CssClass=" checkbox" />
                                        </td>
                                    </tr>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <FooterStyle BackColor="yellow" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                    <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                </asp:GridView>
                <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
                <br />
                <br />
            </div>

        </div>

        <div id="divAdd" class="well HREWhite" runat="server">
            <div class="form-group">
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 ">
                    <h4>Add New Document:</h4>
                </div>
                <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                    <p class="form-control-static text-success ">* Required fields</p>
                </div>
            </div>

            <div class="form-group has-success">
                <label for="ddlCategory" class="col-xs-4 col-sm-4 col-md-2 col-lg-2 control-label">Category:</label>
                <div class="col-xs-5 col-sm-5 col-md-4 col-lg-4">
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" TabIndex="11" DataValueField="DocumentCategoryId" DataTextField="ShortDesc"></asp:DropDownList>
                </div>
            </div>

            <div class="form-group has-success">
                <label for="ddlType" class="col-xs-4 col-sm-4 col-md-2 col-lg-2 control-label">Type:</label>
                <div class="col-xs-5 col-sm-5 col-md-4 col-lg-4">
                    <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control" TabIndex="12" DataValueField="DocumentTypeId" DataTextField="ShortDesc" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                </div>
            </div>

            <div id="divFileUpload" runat="server" class="form-group has-success">
                <label for="fuLoad1" class="col-xs-4 col-sm-4 col-md-2 col-lg-2 control-label">File to Upload:</label>

                <div class="col-xs-5 col-sm-5 col-md-6 ">
                    <asp:FileUpload ID="fuLoad1" runat="server" Width="100%" CssClass="text-success" ViewStateMode="Enabled" TabIndex="16" /><br />

                </div>
            </div>

            <div id="divWebLink" runat="server" class="form-group has-success">
                <label for="fuLoad1" class="col-xs-4 col-sm-4 col-md-2 col-lg-2 control-label">URL:</label>

                <div class="col-xs-5 col-sm-5 col-md-6 ">
                    <asp:TextBox ID="txtURL" runat="server" CssClass="form-control" TabIndex="16" placeholder="http://www.example.com"></asp:TextBox>

                </div>
            </div>

            <div class="form-group">
                <label for="txtShortDesc" class="col-xs-4 col-sm-4 col-md-2 control-label">Document Name:</label>
                <div class="col-xs-5 col-sm-5 col-md-6 col-lg-6">
                    <asp:TextBox ID="txtShortDesc" runat="server" CssClass="form-control" TabIndex="17" placeholder="File name or URL will be used if left blank"></asp:TextBox>
                    <%--<asp:RequiredFieldValidator ControlToValidate="txtShortDesc" ErrorMessage="<h4>Short Description</h4>" Text="" runat="server" Display="None" ValidationGroup="valSave" />--%>
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-4 col-sm-4 col-md-2 col-lg-2 ">
                </div>
                <div class="col-xs-8 col-sm-4 col-md-6 col-lg-6 ">
                    <asp:Label ID="lblFileUpload" runat="server" Text="" class=" text-danger" Visible="false"></asp:Label>
                </div>
                <div class="col-xs-6 col-sm-4 col-md-2 col-lg-2  pull-right">
                    <asp:ImageButton ID="btnCancelNew" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" ImageAlign="AbsMiddle" TabIndex="23" OnClick="btnCancelNew_Click" />
                </div>
                <div class="col-xs-6 col-sm-4 col-md-2 col-lg-2  pull-right">
                    <asp:ImageButton ID="btnSaveNew" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valSave" OnClick="btnUpload_click" />
                </div>
            </div>
        </div>

    </div>
    <style>
        input[type=text], textarea {
            outline: none;
            min-height: 25px;
            background-color: #f0f4fa;
            border: 1px solid #e0eaf7 !important;
        }

        input[type="checkbox"] {
            width: 16px;
            height: 16px;
            cursor: pointer;
            background: #f0f4fa;
        }

        .HREwrapper {
            margin-left: 5%;
            margin-right: 5%;
        }

        .HRESlateBlue {
            background-color: #ccd5e4;
        }

        .HREWhite {
            background-color: white;
            border: 1px solid grey;
            padding: 10px 10px 10px 10px;
        }

        .HREOffWhite {
            background-color: #F9F9F9;
        }

        .HRETan {
            background-color: #f5f5f0;
        }

        .HRELightBlue {
            background-color: #EFF3FB;
        }

        .HRERewrap {
            margin-right: 5%;
        }

        .HREpadR10 {
            padding-right: 20px;
            float: right;
        }

        .HRENext {
            padding: 5px 5px 5px 5px;
            float: right;
            width: 50%;
        }

        .img {
            display: inline-block;
            width: auto;
            height: auto;
        }
    </style>
</asp:Content>


