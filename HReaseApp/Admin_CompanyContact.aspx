<%@ Page Title="Company Information Page"
    Language="vb"
    AutoEventWireup="false"
    MasterPageFile="~/AppMasterHeader.Master"
    CodeBehind="Admin_CompanyContact.aspx.vb"
    Inherits="HReaseApp.Admin_CompanyContact"
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
            <div>
                <br />
                <h4><b>Company Contact Information</b></h4>
            </div>
        </div>

        <div id="divNextButton" runat="server" class="hidden-xs" style="float: right; display: inline; margin-top: -7px;">
            <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
            <asp:Image ID="Image1" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
        </div>

        <div id="divTopHeader" runat="server">
            <div id="divCompanyList" runat="server" class="mobile-company-select well HRESlateBlue HRERewrap form-inline">
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
                <p style="width: 20%; float: right;">
                    <asp:ImageButton ID="btnAddContact" runat="server" ImageUrl="img/BlueAddBtnNew.png" CssClass="mobile-btn-rescale" OnMouseOver="src='/img/BlueAddBtnOver2.png';" OnMouseOut="src='/img/BlueAddBtnNew.png';" ImageAlign="AbsMiddle" OnClick="btnAddContact_Click" Visible="true" />
                </p>
                <br />
                <br />
            </div>
        </div>

        <div id="divCompanyName" runat="server" class="well " style="text-align: center; margin-right: 5%;">
            <b>
                <asp:Label ID="lblCompanyName" runat="server" Text="CompanyName"></asp:Label></b>
            <br />
            <br />
        </div>

        <div id="divContactReview" class="well HRETan mobile-table-scale" runat="server">
            <div class="form-group">
                <label for="lblLevel" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">Company Level:</label>
                <div class="col-xs-3 col-sm-3 col-md-4  col-lg-4 ">
                    <asp:Label ID="lblLevel" runat="server" class="control-label"></asp:Label>
                </div>

                <label for="lblAlias" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">Alias:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblAlias" runat="server" class="control-label" ToolTip="xxx.benefitreflection.com"></asp:Label>
                </div>
            </div>

            <div class="form-group ">
                <label for="lblCompanyNumber" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right ">Company Number: </label>
                <div class="col-xs-3 col-sm-3 col-md-4 col-lg-4 ">
                    <asp:Label ID="lblCompanyNumber" runat="server"></asp:Label>
                </div>

                <label for="lblBeginDate" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">Begin Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblBeginDate" runat="server" class="control-label"></asp:Label>
                </div>
            </div>

            <div class="form-group">
                <label for="lblShortDesc" class="col-xs-3 col-sm-3 col-md-2 right">Short Desc:</label>
                <div class="col-xs-3 col-sm-3 col-md-4 col-lg-4 ">
                    <asp:Label ID="lblShortDesc" runat="server" class="control-label"></asp:Label>
                </div>

                <label for="lblEndDate" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">End Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblEndDate" runat="server" class="control-label"></asp:Label>
                </div>
            </div>

            <div class="form-group">
                <label for="lblCompanyLongDesc" class="col-xs-3 col-sm-3 col-md-2 right">Long Desc:</label>
                <div class="col-xs-3 col-sm-3 col-md-4 col-lg-4 ">
                    <asp:Label ID="lblCompanyLongDesc" runat="server" class="control-label"></asp:Label>
                </div>

                <label for="lblFEIN" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">FEIN:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblFEIN" runat="server" class="control-label" ToolTip="XX-XXXXXXX"></asp:Label>
                </div>
            </div>

            <div class="form-group">
                <label for="lblAddress" class="col-xs-3 col-sm-3 col-md-2 right">Address:</label>
                <div class="col-xs-3 col-sm-3 col-md-4 col-lg-4 ">
                    <asp:Label ID="lblAddress" runat="server" class="control-label"></asp:Label><br />
                    <asp:Label ID="lblAddress2" runat="server" class=" control-label"></asp:Label>
                    <br />
                    <asp:Label ID="lblCity" runat="server" class=" control-label"></asp:Label>
                    ,&nbsp;
                    <asp:Label ID="lblState" runat="server" class=" control-label"></asp:Label>
                    <br />
                    <asp:Label ID="lblZip" runat="server" class=" control-label"></asp:Label>
                    &nbsp;-&nbsp;
                    <asp:Label ID="lblZipExtension" runat="server" class=" control-label"></asp:Label>
                    <br />
                    <asp:Label ID="lblCountry" runat="server" class=" control-label"></asp:Label><br />
                </div>
                <%--<label for="imgLogo" class="col-xs-3 col-sm-3 col-md-5 col-lg-4 left">Logo:</label>--%>
                <div class="logo-div col-xs-3 col-sm-3 col-md-5 col-lg-4 left ">
                    <label for="imgLogo" >Logo:</label><br />
                    <asp:Image CssClass="mobile-img" ID="imgLogo" runat="server"></asp:Image><br />
                </div>
            </div>

            <div class="form-group">
                <label for="lblRegion" class="col-xs-3 col-sm-3 col-md-2 right">
                    Region:</label>
                <div class="col-xs-3 col-sm-3 col-md-4 col-lg-4 ">
                    <asp:Label ID="lblRegion" runat="server" class=" control-label"></asp:Label><br />
                </div>
                <label for="lblCompanyId" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">
                    CompanyId:
                </label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblCompanyId" runat="server" class=" control-label"></asp:Label><br />
                </div>
                <div class="HREpadR10">
                    <asp:ImageButton ID="btnEditContact" runat="server" ImageUrl="img/GreenEditBtnNew.png" OnMouseOver="src='/img/GreenEditBtnOverNew.png';" OnMouseOut="src='/img/GreenEditBtnNew.png';" ImageAlign="AbsMiddle" OnClick="btnEditContact_Click" />
                </div>
            </div>

        </div>

        <div id="divContactEdit" class="well HREWhite HRERewrap" runat="server">
            <div class="form-group">
                <label for="ddlLevel" class="col-xs-4 col-sm-4 col-md-2 col-lg-2 control-label">Company Level:</label>
                <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2">
                    <asp:DropDownList ID="ddlLevel" runat="server" CssClass="form-control" DataValueField="LevelId" DataTextField="Level" Visible="false" TabIndex="1">
                        <asp:ListItem Value="0">Level 0</asp:ListItem>
                        <asp:ListItem Value="1">Level 1</asp:ListItem>
                        <asp:ListItem Value="2">Level 2</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Label ID="lblLevel2" runat="server" class="control-label" Text="test"></asp:Label>
                </div>
            </div>

            <div class="form-group">
                <label for="txtCompanyNumber" class="col-xs-4 col-sm-4 col-md-2 control-label">Company Number:</label>
                <div class="col-xs-5 col-sm-5 col-md-2 ">
                    <asp:TextBox ID="txtCompanyNumber" runat="server" CssClass="form-control" placeholder="Number" ToolTip="alphanumeric" TabIndex="2"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtCompanyNumber" ErrorMessage="<h4>Company Number</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                </div>
            </div>

            <div class="form-group">
                <label for="txtCompanyShort" class="col-xs-4 col-sm-4 col-md-2 control-label">Company Short:</label>
                <div class="col-xs-8 col-sm-8 col-md-5 ">
                    <asp:TextBox ID="txtCompanyShort" runat="server" CssClass="form-control" placeholder="short description or acronym" TabIndex="3"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtCompanyShort" ErrorMessage="<h4>Short Desc</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                </div>

            </div>

            <div class="form-group">
                <label for="txtCompanyName" class="col-xs-4 col-sm-4 col-md-2 control-label">Company Name:</label>
                <div class="col-xs-8 col-sm-8 col-md-5 ">
                    <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" placeholder="Company Name" ToolTip="full legal name" TabIndex="4"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtCompanyName" ErrorMessage="<h4>Company Name</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                </div>
            </div>

            <div class="form-group">
                <label for="txtAlias" class="col-xs-4 col-sm-4 col-md-2 control-label">Alias:</label>
                <div class="col-xs-8 col-sm-8 col-md-5 ">
                    <asp:TextBox ID="txtAlias" runat="server" CssClass="form-control" placeholder="URL Alias" TabIndex="5"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtAlias" ErrorMessage="<h4>Company Alias</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                </div>
            </div>

            <div class="form-group">
                <label for="txtLogo" class="col-xs-4 col-sm-4 col-md-2 control-label">Logo:</label>
                <div class="col-xs-8 col-sm-8 col-md-5 ">
                    <asp:TextBox ID="txtLogo" runat="server" CssClass="form-control" placeholder="Link to Document folder for logo" TabIndex="6"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <label for="txtAddress1" class="col-xs-4 col-sm-4 col-md-2 control-label">Address:</label>
                <div class="col-xs-8 col-sm-8 col-md-5 ">
                    <asp:TextBox ID="txtAddress1" runat="server" CssClass="form-control" placeholder="Line 1" TabIndex="7"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtAddress1" ErrorMessage="<h4>Address Line 1</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-4 col-sm-4 col-md-2 ">
                </div>
                <div class="col-xs-8 col-sm-8 col-md-5 ">
                    <asp:TextBox ID="txtAddress2" runat="server" CssClass="form-control" placeholder="Line 2" TabIndex="8"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <label for="txtCity" class="col-xs-4 col-sm-4 col-md-2 control-label">City:</label>
                <div class="col-xs-8  col-sm-8 col-md-5 ">
                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="City" TabIndex="9"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtCity" ErrorMessage="<h4>City</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                </div>
            </div>

            <div class="form-group">
                <label for="ddlState" class="col-xs-4 col-sm-4 col-md-2 control-label">State:</label>
                <div class="col-xs-2 col-sm-2 col-md-1 ">
                    <asp:DropDownList ID="ddlState" runat="server" CssClass="selectpicker" DataValueField="ShortDesc" DataTextField="ShortDesc" Width="80px" TabIndex="10"></asp:DropDownList>
                </div>

                <label for="ddlCountry" class="col-xs-3 col-sm-3 col-md-2  control-label ">Country:</label>
                <div class="col-xs-2 col-sm-2 col-md-1 ">
                    <asp:DropDownList ID="ddlCountry" runat="server" CssClass="selectpicker" DataValueField="ShortDesc" DataTextField="ShortDesc" Width="80px" TabIndex="11"></asp:DropDownList>
                </div>
            </div>

            <div class="form-group">
                <label for="txtZip" class="col-xs-4 col-sm-4 col-md-2 control-label">Zip:</label>
                <div class="col-xs-2 col-sm-2 col-md-1">
                    <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" placeholder="Zip" Width="80px" MaxLength="5" TabIndex="12"></asp:TextBox>
                </div>
                <div class="col-xs-2 col-sm-2 col-md-1 pull-left ">
                    <asp:TextBox ID="txtZipExt" runat="server" CssClass="form-control" placeholder="Plus 4" Width="80px" MaxLength="4" TabIndex="13"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ControlToValidate="txtZip" ErrorMessage="<h4>Zip</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                <asp:RegularExpressionValidator ID="valrZip" runat="server" ControlToValidate="txtZip" ValidationExpression="\d{5}" ErrorMessage="<h4> Zip Code is not formatted correctly <i>(12345) </i></h4>" ValidationGroup="valContact" Display="None" />
                <asp:RegularExpressionValidator ID="valZipext" runat="server" ControlToValidate="txtZipExt" ValidationExpression="\d{4}" ErrorMessage="<h4> Zip Code Ext is not formatted correctly <i>(1234) </i></h4>" ValidationGroup="valContact" Display="None" />
            </div>

            <div class="form-group">
                <label for="txtRegion" class="col-xs-4 col-sm-4 col-md-2 control-label">Region:</label>
                <div class="col-xs-8 col-sm-8 col-md-5 ">
                    <asp:TextBox ID="txtRegion" runat="server" CssClass="form-control" TabIndex="14" placeholder="Region"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <label for="txtBeginDate" class="col-xs-4 col-sm-4 col-md-2 control-label">Begin Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 ">
                    <asp:TextBox ID="txtBeginDate" runat="server" CssClass="form-control" TabIndex="15" placeholder="mm/dd/yyyy" ToolTip="Begin Date of Company"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtBeginDate" ErrorMessage="<h4>Begin Date</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                    <asp:CompareValidator ID="cmvalBeginDate" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtBeginDate" ErrorMessage="<h4>Begin Date is not formatted correctly (mm/dd/yyyy)</h4>" Display="None" ValidationGroup="valContact"></asp:CompareValidator>

                </div>
            </div>

            <div class="form-group">
                <label for="txtEndDate" class="col-xs-4 col-sm-4 col-md-2 control-label">End Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 ">
                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TabIndex="16" placeholder="mm/dd/yyyy" ToolTip="End Date of Company"></asp:TextBox>
                    <asp:CompareValidator ID="cmvalEndDate" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtEndDate" ErrorMessage="<h4>End Date is not formatted correctly (mm/dd/yyyy)</h4>" Display="None" ValidationGroup="valContact"></asp:CompareValidator>

                </div>
                <div class="col-md-4 text-muted">Leave blank if Company is active</div>
            </div>

            <div class="form-group">
                <label for="txtFEIN" class="col-xs-4 col-sm-4 col-md-2 control-label">FEIN:</label>
                <div class="col-xs-5 col-sm-5 col-md-2 ">
                    <asp:TextBox ID="txtFEIN" runat="server" CssClass="form-control" TabIndex="17" placeholder="XX-XXXXXXX"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <div class="HREpadR10">
                    <asp:ImageButton ID="btnCancelContact" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" ImageAlign="AbsMiddle" TabIndex="23" OnClick="btnCancel_Click" />
                </div>

                <div class="HREpadR10">
                    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valContact" OnClick="btnSave_Click" />
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
        .logo-div{
            padding-left:10%;
        }
        @media only screen and (max-width: 479px) {
            .mobile-btn-rescale{
                width:65px !important;
                height:30px !important;
                float:right !important;
                margin-right:5px !important;
                vertical-align:bottom !important;
                margin-top:22px !important;
            }
            .mobile-company-select{
                padding:2% !important;
                margin:auto !important;
                text-align:center !important;
            }
            .mobile-hide{
                display:none !important;
            }
            #chkActive{
                float:left !important;
                padding-left:10px !important;
            }
            .mobile-table-scale{
                
                text-align:left !important;
                padding:2% 1% 2% 1% !important;
            }
            .col-xs-1, .col-sm-1, .col-md-1, .col-lg-1, .col-xs-2, .col-sm-2, .col-md-2, .col-lg-2, .col-xs-3, .col-sm-3, .col-md-3, .col-lg-3, .col-xs-4, .col-sm-4, .col-md-4, .col-lg-4, .col-xs-5, .col-sm-5, .col-md-5, .col-lg-5, .col-xs-6, .col-sm-6, .col-md-6, .col-lg-6, .col-xs-7, .col-sm-7, .col-md-7, .col-lg-7, .col-xs-8, .col-sm-8, .col-md-8, .col-lg-8, .col-xs-9, .col-sm-9, .col-md-9, .col-lg-9, .col-xs-10, .col-sm-10, .col-md-10, .col-lg-10, .col-xs-11, .col-sm-11, .col-md-11, .col-lg-11, .col-xs-12, .col-sm-12, .col-md-12, .col-lg-12 {
                position: relative;
                min-height: 1px;
                padding-right: 8px;
                padding-left: 8px;
            }
        }
    </style>
</asp:Content>
