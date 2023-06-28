<%@ Page Title="Administrator List"
    Language="vb"
    AutoEventWireup="false"
    MasterPageFile="~/AppMasterHeader.Master"
    CodeBehind="Admin_CompanyAdminSelect.aspx.vb"
    Inherits="HReaseApp.Admin_CompanyAdminSelect"
    EnableEventValidation="false"
    MaintainScrollPositionOnPostback="false" %>

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
                <h4><b>Company Administrators</b></h4>
            </div>
        </div>

        <div id="divNextButton" runat="server" class="hidden-xs" style="float: right; display: inline; margin-top: -7px;">
            <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
            <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
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

        <div id="divAdminList" runat="server" class="well HRETan">
            <div id="divAddButton" style="float: right; padding: 10px; vertical-align: top;">
                <asp:ImageButton ID="btnAddAdmin" runat="server" ImageUrl="img/BlueAddBtnNew.png" OnMouseOver="src='/img/BlueAddBtnOver2.png';" OnMouseOut="src='/img/BlueAddBtnNew.png';" ImageAlign="middle" />
            </div>

            <div id="divAdminGrid" class="HREpadLR20">
                <br />
                <asp:Label ID="lblHightlight1" CssClass="text-success small_text" Text="** Click Admin row to View and Edit Detail **" runat="server" Visible="true"></asp:Label>
                <asp:GridView ID="grdAdmin" runat="server"
                    DataKeyNames="ShadowCompanyId, ShadowCompanyName, AdminCompanyId, AdminCompanyName, AdminId, AdminName, AdminRoleTypeId, AdminRoleTypeDesc, UserAllowedToEdit" AutoGenerateColumns="False" Width="100%" HorizontalAlign="center"
                    GridLines="None" BorderColor="#3276B1"
                    CellPadding="4"
                    EmptyDataText="No Administrators found with that Search criteria."
                    OnSelectedIndexChanged="OnSelectedIndexChanged">
                    <Columns>
                        <asp:BoundField HeaderText="ShadowCompanyId" DataField="ShadowCompanyId" Visible="false" />
                        <asp:BoundField HeaderText="Company Name" DataField="ShadowCompanyName" Visible="true" />
                        <asp:BoundField HeaderText="AdminCompanyId" DataField="AdminCompanyId" Visible="false"></asp:BoundField>
                        <asp:BoundField HeaderText="Admin Company Name" DataField="AdminCompanyName" Visible="true"></asp:BoundField>
                        <asp:BoundField HeaderText="AdminId" DataField="AdminId" Visible="false" />
                        <asp:BoundField HeaderText="Admin Name" DataField="AdminName" Visible="true"></asp:BoundField>
                        <asp:BoundField HeaderText="AdminRoleTypeId" DataField="AdminRoleTypeId" Visible="false"></asp:BoundField>
                        <asp:BoundField HeaderText="Role Description" DataField="AdminRoleTypeDesc" Visible="true"></asp:BoundField>
                        <asp:BoundField HeaderText="Allowed To Edit" DataField="UserAllowedToEdit" Visible="true"></asp:BoundField>
                    </Columns>

                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                    <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                    <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />

                </asp:GridView>
                <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>

            </div>
        </div>

        <div id="divAdminReview" class="HRETan" runat="server" visible="false">
            <div id="divReturnToList" class="form-group">
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 pull-right  ">
                    <asp:Button ID="btnBack2" runat="server" Text="Return to Admin Search" CssClass="btn-primary" />
                </div>
            </div>
            <div id="divAdminData" class="form-group">
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
                    <h5><b>Name and Address</b></h5>
                    <asp:Label ID="lblAdminName" runat="server" class="control-label"></asp:Label><br />
                    <asp:Label ID="lblAddress" runat="server" class="control-label"></asp:Label>
                    <asp:Label ID="lblAddress2" runat="server" class=" control-label"></asp:Label><br />
                    <asp:Label ID="lblCity" runat="server" class=" control-label"></asp:Label>&nbsp<asp:Label ID="lblState" runat="server" class=" control-label"></asp:Label>
                    <asp:Label ID="lblZip" runat="server" class=" control-label"></asp:Label>
                    &nbsp
                        <asp:Label ID="lblZipExtension" runat="server" class=" control-label"></asp:Label><br />
                    <asp:Label ID="lblCountry" runat="server" class=" control-label"></asp:Label><br />
                    <br />
                </div>
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
                    <h5><b>Phone & Email</b></h5>
                    <b>Office:</b>
                    <asp:Label ID="lblWorkPhone" runat="server"></asp:Label>&nbsp;&nbsp <b>Ext:</b>&nbsp; 
                        <asp:Label ID="lblExtension" runat="server"></asp:Label><br />

                    <b>Mobile:</b><asp:Label ID="lblMobile" runat="server"></asp:Label><br />
                    <b>Fax:</b>
                    <asp:Label ID="lblFax" runat="server"></asp:Label><br />
                    <b>Email:</b>
                    <asp:Label ID="lblEmail" runat="server"></asp:Label>
                </div>
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
                    <h5><b>Other</b></h5>
                    <b>Role Type:</b>
                    <asp:Label ID="lblRoleType" runat="server"></asp:Label><br />
                    <b>Begin Date:</b>
                    <asp:Label ID="lblAdminBeginDate" runat="server"></asp:Label><br />
                    <b>End Date:</b>
                    <asp:Label ID="lblAdminEndDate" runat="server"></asp:Label><br />
                </div>
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
                    <b>Last Login:</b>
                    <asp:Label ID="lblLastLogin" runat="server"></asp:Label>
                </div>
            </div>
            <div id="divEmailandEdit" runat="server" class="form-group">
                <div id="divEmail" class="col-xs-3 col-sm-3 col-md-2 col-lg-2  pull-left">
                    <asp:LinkButton ID="lnkButton1" runat="server" Text="Email Admin" Style="border: 1px solid grey; padding: 10px; background-color: #639ed5; color: white; font-weight: 700;" Visible="true" data-toggle="modal" Data-target="#ModalEmail"></asp:LinkButton>
                </div>
                <div id="divEditButton" class="col-xs-3 col-sm-3 col-md-2 col-lg-2  pull-right">
                    <asp:ImageButton ID="btnEditAdmin" runat="server" ImageUrl="img/GreenEditBtnNew.png" OnMouseOver="src='/img/GreenEditBtnOverNew.png';" OnMouseOut="src='/img/GreenEditBtnNew.png';" ImageAlign="AbsMiddle" />
                </div>
            </div>

        </div>

        <div id="divAdminEdit" class="well HREWhite HRERewrap" runat="server" visible="false">
            <div id="divError" runat="server" class="col-md-12 text-center" visible="false" style="background-color: #f2dede; width: 100%; padding-top: 20px;">
                <h3><b><span style="color: red;">
                    <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" border="none" Width="50px" />
                    &nbsp;&nbsp;
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
                </span></b></h3>
            </div>
            <div id="divSuccess" runat="server" class="col-md-12 text-center" visible="false">
                <asp:Image ID="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" CssClass=" img" />
                <h3>
                    <br />
                    <b><span style="color: green">
                        <asp:Label ID="lblSuccess" runat="server" Text="Form Complete.<br/>"></asp:Label>
                    </span></b></h3>
            </div>
            <div class="form-group">
                <label for="lblAdminId" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 control-label">
                    Admin Id:</label>
                <div class="col-xs-2 col-sm-2 col-md-2  ">
                    <p class="form-control-static">
                        <asp:Label ID="lblAdminId" runat="server" class="control-label"></asp:Label></p>
                </div>
                <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2 center">
                    <a style="color: red">*</a> Required fields  
                </div>
                <div style="float: right; padding-right: 20px; padding-top: 10px;">
                    <%--<asp:Button ID="btnResetSecurity" Text="Reset Security" runat="server" Enabled="true" EnableViewState="true" Class="buttonReview"/>--%>
                    <asp:LinkButton ID="btnLinkReset" runat="server" Text="Reset Security" Style="border: 1px solid grey; padding: 10px; background-color: #639ed5; color: white; font-weight: 700;" Visible="true" data-toggle="modal" Data-target="#ModalReset" />
                </div>
            </div>

            <div class="form-group  has-success">
                <label for="txtFirstName" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 control-label">
                    <a style="color: red">*</a> Name:</label>
                <div class="col-xs-4 col-sm-4 col-md-3 right ">
                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" TabIndex="10" placeholder="First" ToolTip="First Name"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtFirstName" ErrorMessage="<h4>First Name</h4>" Text="" runat="server" Display="None" ValidationGroup="valAdmin" />
                </div>
                <div class="col-xs-4 col-sm-4 col-md-3 right ">
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" TabIndex="11" placeholder="Last" ToolTip="Last Name" /><%--<span class=" text-muted" ><i>* Required</i></span>--%>
                    <asp:RequiredFieldValidator ControlToValidate="txtLastName" ErrorMessage="<h4>Last Name</h4>" Text="" runat="server" Display="None" ValidationGroup="valAdmin" />
                </div>
            </div>

            <div class="form-group">
                <label for="ddlRoleType" class="col-xs-3 col-sm-3 col-md-2 control-label">
                    <a style="color: red">*</a> Role Type:</label>
                <div class="col-xs-8 col-sm-8 col-md-5 ">
                    <asp:DropDownList ID="ddlRoleType" runat="server" CssClass="form-control" TabIndex="13" DataValueField="RoleTypeId" DataTextField="LongDesc">
                    </asp:DropDownList>
                </div>
            </div>

            <div class="row">
                <div class="col-md-2">
                    <br />
                </div>
            </div>

            <div class="form-group">
                <label for="txtAddress1" class="col-xs-3 col-sm-3 col-md-2 control-label">
                    Address:</label>
                <div class="col-xs-8 col-sm-8 col-md-5 ">
                    <asp:TextBox ID="txtAddress1" runat="server" CssClass="form-control" TabIndex="15" placeholder="Line 1"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <div class="col-xs-3 col-sm-3 col-md-2 ">
                </div>
                <div class="col-xs-8 col-sm-8 col-md-5 ">
                    <asp:TextBox ID="txtAddress2" runat="server" CssClass="form-control" TabIndex="16" placeholder="Line 2"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label for="txtCity" class="col-xs-3 col-sm-3 col-md-2 control-label">
                    City:</label>
                <div class="col-xs-8  col-sm-8 col-md-5 ">
                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" TabIndex="17" placeholder="City"></asp:TextBox>
                </div>
            </div>
            <div class="form-group">
                <label for="ddlState" class="col-xs-3 col-sm-3 col-md-2 control-label">
                    State:</label>
                <div class="col-xs-2 col-sm-2  col-md-1 ">
                    <asp:DropDownList ID="ddlState" runat="server" CssClass="selectpicker" TabIndex="18" DataValueField="ShortDesc" DataTextField="ShortDesc" Width="80px"></asp:DropDownList>
                </div>

                <label for="ddlCountry" class="col-xs-2 col-sm-2 col-md-2  control-label ">
                    Country:</label>
                <div class="col-xs-2 col-sm-2 col-md-1 ">
                    <asp:DropDownList ID="ddlCountry" runat="server" CssClass="selectpicker" TabIndex="19" DataValueField="ShortDesc" DataTextField="ShortDesc" Width="80px"></asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <label for="txtZip" class="col-xs-3 col-sm-3 col-md-2 control-label">
                    Zip:</label>
                <div class="col-xs-2 col-sm-2 col-md-1">
                    <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" TabIndex="20" placeholder="Zip" Width="80px" MaxLength="5"></asp:TextBox>
                </div>
                <div class="col-xs-2 col-sm-2 col-md-1 pull-left ">
                    <asp:TextBox ID="txtZipExt" runat="server" CssClass="form-control" TabIndex="21" placeholder="Plus 4" Width="80px" MaxLength="4"></asp:TextBox>
                </div>
                <asp:RegularExpressionValidator ID="valrZip" runat="server" ControlToValidate="txtZip" ValidationExpression="\d{5}" ErrorMessage="<h4> Zip Code is not formatted correctly <i>(12345) </i></h4>" ValidationGroup="valAdmin" Display="None" />
                <asp:RegularExpressionValidator ID="valZipext" runat="server" ControlToValidate="txtZipExt" ValidationExpression="\d{4}" ErrorMessage="<h4> Zip Code Ext is not formatted correctly <i>(1234) </i></h4>" ValidationGroup="valAdmin" Display="None" />
            </div>
            <div class="row">
                <div class="col-md-2">
                    <br />
                </div>
            </div>
            <div class="form-group">
                <label for="txtOffice" class="col-xs-3 col-sm-3 col-md-2 control-label">
                    Work Phone:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2">
                    <asp:TextBox ID="txtOffice" runat="server" CssClass="form-control" TabIndex="22" placeholder="555-555-5555" AutoPostBack="true" OnTextChanged="txtOffice_TextChanged"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="regWorkPhone" runat="server" ControlToValidate="txtOffice" ValidationExpression="^(\(?\s*\d{3}\s*[\)\-\.]?\s*)?[2-9]\d{2}\s*[\-\.]\s*\d{4}$" ErrorMessage="<h4>Work phone number is not formatted correctly <i>(999-999-9999 or (999)999-9999) </i></h4>" ValidationGroup="valAdmin" Display="None" />
                </div>
                <label for="txtExtension" class="col-xs-3 col-sm-3 col-md-2 control-label">
                    Extension:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:TextBox ID="txtExtension" runat="server" CssClass="form-control" TabIndex="23" placeholder="9999"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <label for="txtMobile" class="col-xs-3 col-sm-3 col-md-2 control-label">
                    Mobile Phone:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2">
                    <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" TabIndex="24" placeholder="555-555-5555" AutoPostBack="true" OnTextChanged="txtMobile_TextChanged"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="regMobilePhone" runat="server" ControlToValidate="txtMobile" ValidationExpression="^(\(?\s*\d{3}\s*[\)\-\.]?\s*)?[2-9]\d{2}\s*[\-\.]\s*\d{4}$" ErrorMessage="<h4>Mobile phone number is not formatted correctly <i>(999-999-9999 or (999)999-9999) </i></h4>" ValidationGroup="valAdmin" Display="None" />
                </div>
                <label for="txtExtension" class="col-xs-3 col-sm-3 col-md-2 control-label">
                    Fax:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:TextBox ID="txtFax" runat="server" CssClass="form-control" TabIndex="25" placeholder="555-555-5555" AutoPostBack="true" OnTextChanged="txtFax_TextChanged"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="regFaxPhone" runat="server" ControlToValidate="txtFax" ValidationExpression="^(\(?\s*\d{3}\s*[\)\-\.]?\s*)?[2-9]\d{2}\s*[\-\.]\s*\d{4}$" ErrorMessage="<h4>Fax number is not formatted correctly <i>(999-999-9999 or (999)999-9999) </i></h4>" ValidationGroup="valAdmin" Display="None" />

                </div>
            </div>

            <div class="form-group  has-success   ">
                <label for="txtEmail" class="col-xs-3 col-sm-3 col-md-2 control-label">
                    <a style="color: red">*</a> Email Address:</label>
                <div class="col-xs-8 col-sm-8 col-md-4">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TabIndex="26" placeholder="abc@company.com" aria-describedby="inputSuccess2Status"> </asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtEmail" ErrorMessage="<h4>Email Address</h4>" Text="" runat="server" Display="None" ValidationGroup="valAdmin" />
                    <asp:RegularExpressionValidator ID="valrEmail1" runat="server" ControlToValidate="txtEmail" ValidationExpression="^(.+)@([^\.].*)\.([a-z]{2,})$" ErrorMessage="<h4>Email is not formatted correctly<i>(email@provider.com) </i></h4>" ValidationGroup="valAdmin" Display="None" />
                </div>

            </div>

            <div class="form-group  has-success">
                <label for="txtAdminBeginDate" class="col-xs-3 col-sm-3 col-md-2 control-label">
                    <a style="color: red">*</a> Begin Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 ">
                    <asp:TextBox ID="txtAdminBeginDate" runat="server" CssClass="form-control" TabIndex="27" placeholder="mm/dd/yyyy" ToolTip="Begin Date of Admin"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtAdminBeginDate" ErrorMessage="<h4>Begin Date</h4>" Text="" runat="server" Display="None" ValidationGroup="valAdmin" />
                    <asp:CompareValidator ID="cmvalBeginDate" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtAdminBeginDate" ErrorMessage="<h4>Begin Date is not formatted correctly (mm/dd/yyyy)</h4>" Display="None" ValidationGroup="valAdmin"></asp:CompareValidator>

                </div>
            </div>

            <div class="form-group">
                <label for="txtAdminEndDate" class="col-xs-3 col-sm-3 col-md-2 control-label">
                    End Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 ">
                    <asp:TextBox ID="txtAdminEndDate" runat="server" CssClass="form-control" TabIndex="28" placeholder="mm/dd/yyyy" ToolTip="End Date of Admin" AutoPostBack="true" OnTextChanged="UpdateEndDate"></asp:TextBox>
                    <asp:CompareValidator ID="cmvalEndDate" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtAdminEndDate" ErrorMessage="<h4>End Date is not formatted correctly (mm/dd/yyyy)</h4>" Display="None" ValidationGroup="valAdmin"></asp:CompareValidator>
                </div>
                <div class="col-xs-4 col-sm-4 col-md-6 pull-right">
                    <asp:CheckBox ID="chkActiveAdmin" runat="server" CssClass="checkbox" Checked="true" TabIndex="29" Text="Active" TextAlign="Right"></asp:CheckBox>
                </div>

            </div>

            <div class="form-group">
                <div class="col-xs-3 col-sm-3 col-md-2 ">
                </div>
                <div class="col-xs-3 col-sm-3 col-md-6 ">
                    <asp:Label ID="lblErrorActive" runat="server" CssClass="text-danger text-center" Text="Opps!  There was an error." Visible="false"></asp:Label>
                </div>

                <div style="float: right; padding-right: 20px;">
                    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" ImageAlign="AbsMiddle" TabIndex="35" />
                </div>

                <div style="float: right; padding-right: 20px;">
                    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="36" />
                </div>
            </div>

        </div>

        <div id="divAdminCompanies" class="well HRELightBlue" runat="server" visible="false">
            <div class="form-group">
                <div class="col-xs-10 col-sm-10 col-md-8 col-lg-8 ">
                    <h4>Assigned Companies:</h4>
                    <br />
                    <asp:GridView ID="grdCurrentCompanies" runat="server"
                        Style="border: 1px solid grey;"
                        DataKeyNames="CompanyAdminId, CompanyId" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                        GridLines="None" BorderColor="#3276B1"
                        CellPadding="4"
                        EmptyDataText="Not currently assigned.">
                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                        <Columns>
                            <asp:BoundField HeaderText="Company Id" DataField="CompanyId" Visible="false" />
                            <asp:BoundField HeaderText="Company Admin Id" DataField="CompanyAdminId" Visible="false" />
                            <asp:BoundField HeaderText="Company Name" DataField="CompanyName" Visible="true" HtmlEncode="false"></asp:BoundField>
                            <asp:TemplateField HeaderText="Begin Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblBeginDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' />
                                    <asp:TextBox ID="txtBeginDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' Width="110px" CssClass="form-control" />
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="End Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblEndDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' />
                                    <asp:TextBox ID="txtEndDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' Width="110px" CssClass="form-control" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                    </asp:GridView>
                </div>
            </div>

            <div id="divEditButtons" runat="server" class="form-group">
                <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">

                    <asp:ImageButton ID="btnEditCompanyAdmin" runat="server" ImageUrl="img/GreenEditBtnNew.png" OnMouseOver="src='/img/GreenEditBtnOverNew.png';" OnMouseOut="src='/img/GreenEditBtnNew.png';" ImageAlign="AbsBottom" />
                    <asp:ImageButton ID="btnCancelCompanyAdmin" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" ImageAlign="AbsMiddle" TabIndex="40" />
                </div>
                <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                    <asp:ImageButton ID="btnAddCompanyAdmin" runat="server" ImageUrl="img/BlueAddBtnNew.png" OnMouseOver="src='/img/BlueAddBtnOver2.png';" OnMouseOut="src='/img/BlueAddBtnNew.png';" ImageAlign="Right" data-toggle="modal" data-target="#ModalAssignCompany" OnClientClick="return false" />
                    <asp:ImageButton ID="btnSaveCompanyAdmin" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="41" ValidationGroup="valAdmin" />
                </div>
            </div>
        </div>

        <%--  Add Companies Modal--%>
        <div id="ModalAssignCompany" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalEnroller" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title text-success" id="myModalInfoLabel">
                            <asp:Label ID="mlblInfoTitle" runat="server" Text="Assign Company"></asp:Label></h4>
                    </div>
                    <div class="modal-body ">
                        <div class="well HRELightBlue">
                            <div class="form-group">
                                <asp:Label ID="mlblInfoText1" runat="server" class="col-md-12 " Text="Assign Administrator to Company"></asp:Label>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="mlblInfoText2" runat="server" class="col-md-12 "></asp:Label>
                            </div>
                            <div class="form-group">
                                <div class=" col-xs-1 col-sm-1 col-md-1"></div>
                                <div class=" col-xs-10 col-sm-10 col-md-10" style="max-height: 350px; overflow-y: scroll;">
                                    <asp:GridView ID="grdAssignNewCompany" runat="server"
                                        DataKeyNames="CompanyId, CompanyAdminId, Assign" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                                        GridLines="None" BorderColor="#3276B1"
                                        CellPadding="4"
                                        EmptyDataText="No Companies found."
                                        AlternatingRowStyle-CssClass="grdNormalAltrow">
                                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                        <Columns>
                                            <asp:BoundField HeaderText="Company Id" DataField="CompanyId" Visible="false" />
                                            <asp:BoundField HeaderText="Company Admin Id" DataField="CompanyAdminId" Visible="false" />
                                            <asp:TemplateField HeaderText="Assign">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkAssign" runat="server" Checked='<%# IIf(DataBinder.Eval(Container.DataItem, "Assign").ToString().Equals("True"), "True", "False")%>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Company Name" DataField="CompanyName" Visible="true" HtmlEncode="false"></asp:BoundField>
                                        </Columns>
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                                    </asp:GridView>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-2 pull-right">
                                    <asp:ImageButton ID="mbtnSave" ImageUrl="../img/BlueSaveBtnNew.png" runat="server" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="AbsMiddle"></asp:ImageButton>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <%-- <div id ="ModalEnroller" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalEnroller" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title text-success" id="myModalInfoLabel">
                            <asp:Label ID="mlblInfoTitle" runat="server" Text="Assign Company"></asp:Label></h4>
                    </div>
                    <div class="modal-body ">
                        <div class="well HREWhite HRERewrap">
                            <div class="form-group">
                                <asp:Label ID="mlblInfoText1" runat="server" class="col-md-12 " Text="Assign Administrator to Company"></asp:Label>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="mlblInfoText2" runat="server" class="col-md-12 "></asp:Label>
                            </div>
                            <div class="form-group">
                                 <div class=" col-xs-1 col-sm-1 col-md-1"></div>
                               <div class=" col-xs-10 col-sm-10 col-md-10" >
                                    <asp:GridView ID="grdAssignNewCompany" runat="server"
                                                DataKeyNames="CompanyId, CompanyAdminId, Assign" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                                                GridLines="None" BorderColor="#3276B1"
                                                CellPadding="4"
                                                EmptyDataText="No Companies found."
                                                AlternatingRowStyle-CssClass="grdNormalAltrow">
                                               <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                                <Columns>
                                                    <asp:BoundField HeaderText="Company Id" DataField="CompanyId" Visible="false" />
                                                    <asp:BoundField HeaderText="Company Admin Id" DataField="CompanyAdminId" Visible="false" />
                                                    <asp:TemplateField HeaderText="Assign">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkAssign" runat="server" Checked='<%# IIf(DataBinder.Eval(Container.DataItem, "Assign").ToString().Equals("True"), "True", "False")%>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField HeaderText="Company Name" DataField="CompanyName" Visible="true" HtmlEncode="false"></asp:BoundField>
                                                </Columns>
                                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                                <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                                            </asp:GridView>
                                   </div>
                            </div>

                            <div class="form-group">
                                <div class="col-md-2 pull-right">
                                 <asp:ImageButton ID="mbtnSave" ImageUrl="../img/BlueSaveBtnNew.png" runat="server" OnMouseOver="src='/img/GreenSaveBtnOver.png';" OnMouseOut="src='/img/GreenSaveBtn.png';" ImageAlign="AbsMiddle"></asp:ImageButton>
                                    </div>
                            </div>
                        </div>
                    </div>
                
                </div>
            </div>
        </div>
        --%>
    </div>

    <div class="modal fade" id="ModalReset" tabindex="-1" role="dialog" aria-labelledby="myModalReset" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title text-success" id="ModalTitle">
                        <asp:Label ID="mlblResetTitle" runat="server" Text="Reset Security"></asp:Label></h4>
                </div>
                <div class="modal-body ">
                    <div class="form-group">
                        <div class="col-xs-12 col-sm-12 col-md-12">
                            <asp:Label ID="mResetlbl2" runat="server" class="col-md-12  h4"
                                Text="<b>Please Note:</b>  Pressing <b> Save</b> will reset the Administrators username to their current email address.  It will also provide a temporary password and reset all previously entered Security Questions and Answers."></asp:Label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-12 col-sm-12 col-md-12">
                            <asp:Label ID="mResetlbl3" runat="server" class="col-md-12 h4" Text="Press <b>Cancel</b> to exit without resetting the Employee"></asp:Label>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:ImageButton ID="mbtnResetSave" ImageUrl="../img/BlueSaveBtnNew.png" runat="server" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';"></asp:ImageButton>
                    <asp:ImageButton ID="mbtnResetCancel" data-dismiss="modal" ImageUrl="../img/GreenCancelBtnNew.png" runat="server" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" TabIndex="-1"></asp:ImageButton>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="ModalEmail" tabindex="-1" role="dialog" aria-labelledby="myModalEmail" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title text-success" id="ModalEmailTitle">
                        <asp:Label ID="Label1" runat="server" Text="Welcome Email"></asp:Label></h4>
                </div>
                <div class="modal-body ">
                    <div id="divSend" class="form-group" style="float: right;">
                        <asp:Button ID="btnSend" Text="Send" runat="server" Style="border: 1px solid grey; background-color: aliceblue; padding: 10px; color: black; width: 60px; height: 40px;" Autopostback="true" OnClick="btnSend_Click"></asp:Button>
                    </div>
                    <div id="divTo" class="form-group">
                        <div class="col-sm-3 col-md-9">
                            <label for="txtAdminEmailTo" class="col-sm-3 control-label">To:</label>
                            <div class="col-md-9">
                                <asp:TextBox ID="txtAdminEmailTo" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div id="divFrom" class="form-group">
                        <div class="col-sm-3 col-md-9">
                            <label for="txtAdminFromEmail" class="col-sm-3 control-label">From:</label>
                            <div class="col-md-9">
                                <asp:TextBox ID="txtAdminFromEmail" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div id="divCC" class="form-group">
                        <div class="col-sm-3 col-md-9">
                            <label for="txtAdminCC" class="col-sm-3 control-label">CC:</label>
                            <div class="col-md-9">
                                <asp:TextBox ID="txtAdminCC" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div id="divBCC" class="form-group">
                        <div class="col-sm-3 col-md-9">
                            <label for="txtAdminBCC" class="col-sm-3 control-label">BCC:</label>
                            <div class="col-md-9">
                                <asp:TextBox ID="txtAdminBCC" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div id="divSubject" class="form-group">
                        <div class="col-sm-3 col-md-9">
                            <label for="txtAdminEmailSubject" class="col-sm-3 control-label">Subject:</label>
                            <div class="col-md-9">
                                <asp:TextBox ID="txtAdminEmailSubject" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div id="divBody" class="form-group">
                        <div class="col-sm-3 col-md-9">
                            <label for="txtAdminEmailBody" class="col-sm-3 control-label">Email:</label>
                            <div class="col-md-9" style="vertical-align: top;">
                                <asp:TextBox ID="txtAdminEmailBody" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="15" ToolTip=""></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:ImageButton ID="imgLogo" runat="server"></asp:ImageButton>
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
            min-width: 50px;
            max-width: 90px;
        }

        .img {
            display: inline-block;
            width: auto;
            height: auto;
        }
    </style>
</asp:Content>

