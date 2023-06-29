<%@ Page Title="Employee Admin EE Select"
    Language="vb"
    AutoEventWireup="false"
    MasterPageFile="~/AppMasterHeader.Master"
    CodeBehind="Admin_EESelect.aspx.vb"
    Inherits="HReaseApp.Admin_EESelect"
    EnableEventValidation="false"
    MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="tabs" runat="Server">
    <div id="tabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>
    </div>
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" runat="Server">
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
    <meta name="viewport" content="initial-scale = 1.0, maximum-scale = 1.0, user-scalable = no, width = device-width"/>
    <style>
         p.search-box {
            border-radius: 6px !important;
            background-color: #ffffff !important;
            min-width: 200px;
            max-width: 667px;
            width: 60%;
            margin: 1% 0 1% 0;
            height: 50px;
        }

            p.search-box i.icon {
                text-align:center;
                min-width: 60px;
                border-radius: 6px;
                height: 100%;
                align-items: center;
                font-size: 20px;
            }

            p.search-box .Searchtxt {
                width: calc(100% - 70px);
                min-width: 140px;
                max-width: 607px;
                height: 100%;
                align-items: center;
                font-size: 20px;
            }
            p.buttonBar{
                height:50px;
                max-width:667px;
                min-width:200px;
                display:flex;
                align-content:center;
                flex-direction: row;
                justify-content: space-between;
            }
            p.buttonBar .Searchbtn,
            p.buttonBar .Filterbtn{
                height: 100%;
                width:30%;
                padding:1%;
                font-size:20px;
                border-radius:6px;
                border-color:#337ab7;
                align-content:center;
                background-color:#337ab7;
                box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 3px 10px 0 rgba(0, 0, 0, 0.19);
                color:#fff;

            }
            .header{
                font-size:25px;
                font-weight:bold;
                line-height:70px;
            }
            div.Filterdiv div{
                margin-top:10px;
            }
            div.Filterdiv div.orderbychkdiv{
                max-width:667px;
                min-width:200px;
                margin:10px auto 20px 60px ;
                align-content:center;
            }
        @media only screen and (max-width: 690px) {
            .well, .HRESlateBlue, .HRERewrap, .form-inline {
                margin: auto !important;
                padding: 2% 1% 2% 2% !important;
                font-size: 18px !important;
            }
            p.search-box{
                width:100% !important;
            }
            p.buttonBar{
                margin-top:10px!important;
            }
            .dropdownbox{
                width:100px !important;
                font-size:15px !important;
            }
            .orderbychkdiv{
                margin:auto!important;
            }
        }

    </style>


    <div class="HREwrapper">
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>Employee Search</b></h4>
            </div>
        </div>

        <div id="divProcessing" runat="server" visible="false">
            <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Width="100%" />
        </div>
        <div id="divTopHeader" runat="server">
            <div id="divCompanyList" runat="server" class="well HRESlateBlue HRERewrap form-inline">
                <span style="padding-left: 10px; padding-right: 10px; width: 10%;">Company:
                </span>
                <span style="min-width: 200px; max-width: 600px; width: 50%;" >
                    <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-control" DataValueField="CompanyId" DataTextField="CombinedCompanyName" AutoPostBack="true" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged" onclick="btnClearSearch_Click" ></asp:DropDownList>
                </span>
                <script>
                    $('#<%=ddlCompany.ClientID%>').chosen();
                </script>
                <p class="search-box">

                    <i style="color: #014679;" class="bx bx-search icon"></i>
                    <asp:TextBox runat="server" Style="color: #014679!important; background-color: #ffffff!important; border-color: #ffffff !important;" ID="Searchtxt" CssClass="Searchtxt" placeholder="Search..." /><br />

                </p>
                <p class="buttonBar">
                    <asp:Button runat="server" ID="searchbtn" CssClass="Searchbtn" Text="Search" OnClick="searchbtn_Click"></asp:Button>
                    <asp:Button runat="server" ID="filterbtn" cssclass="Filterbtn" Onclick="filterbtn_Click" Text="Filter" />

                </p>
                <div class="form-group">
                <div id="CompanyStatusDiv" class="dropdowndiv">
                <span class="dropdownlbl">Company Status:</span>
                <asp:DropDownList runat="server" ID="CompanyStatusDropDown" DataValueField="value" CssClass="dropdownbox">
                    <asp:ListItem Value="Active">
                            Active
                    </asp:ListItem>
                    <asp:ListItem Value="Inactive">
                            Inactive
                    </asp:ListItem>
                    <asp:ListItem Value="All">
                            All
                    </asp:ListItem>
                </asp:DropDownList>
            </div>
            <div id="EmpStatusDiv" class="dropdowndiv">
                <span class="dropdownlbl">Employee Status:</span>
                <asp:DropDownList runat="server" ID="EmployeeDropDown" CssClass="dropdownbox">
                    <asp:ListItem>
                            Active
                    </asp:ListItem>
                    <asp:ListItem>
                            Inactive
                    </asp:ListItem>
                    <asp:ListItem>
                            All
                    </asp:ListItem>
                </asp:DropDownList>

            </div>
                    </div>
            </div>
            
        </div>


        <div id="FiltersDiv" runat="server" class="Filterdiv" >
            <div id="Search_Filters" class="header">
                <span>Search Filters</span>
            </div>
            <div class="well HRESlateBlue HRERewrap form-inline">
            
            <div id="AdminCompanyDiv" class="dropdowndiv">

                <asp:Label ID="lblAdminCompany" runat="server" Visible="false" class="dropdownlbl">Admin Company:</asp:Label>
                <asp:DropDownList ID="ddlAdminCompany" runat="server" Visible="false" TabIndex="1" DataValueField="CompanyId" DataTextField="CombinedCompanyName" AutoPostBack="false" OnSelectedIndexChanged="ddlAdminCompany_SelectedIndexChanged" CssClass="dropdownbox" />
            </div>
            <div id="ParentCompanyDiv" class="dropdowndiv">
                <asp:Label ID="lblParentCompany" runat="server" Text="Parent Company:" Visible="false" class="dropdownlbl">Parent Company:</asp:Label>
                <asp:DropDownList ID="ddlParentCompany" runat="server" Visible="false" TabIndex="1" DataValueField="CompanyId" DataTextField="CombinedCompanyName" AutoPostBack="false" OnSelectedIndexChanged="ddlParentCompany_SelectedIndexChanged" CssClass="dropdownbox" />
            </div>
            
            
            <div class="orderbychkdiv">
                <asp:CheckBox ID="chkOrderByNumber" runat="server" Text="&nbsp;&nbsp;Order by Company Number" CssClass="orderbycompanynumber" Checked="false" OnCheckedChanged="chkOrderByNumber_CheckedChanged" AutoPostBack="false"></asp:CheckBox>
            </div>

            <p class="buttonBar">
                <asp:Button runat="server" ID="btnClearSearch" CssClass="Searchbtn" Text="Clear" OnClick="btnClearSearch_Click" />
                <asp:Button runat="server" ID="SearchFilteredbtn" CssClass="Filterbtn" Text="Search" OnClick="searchbtn_Click" />
            </p>
        </div>
</div>

       
<div id="divEEGrid" class="form-group employee-grid">

    <asp:Label ID="lblHightlight1" CssClass="text-success small_text" Text="** Click Employee row to Shadow **" runat="server" Visible="true"></asp:Label>
    <asp:GridView ID="a_grdEmployee" runat="server" CssClass="employee-grid"
        AllowPaging="true"
        PageSize="15"
        DataKeyNames="EmployeeId, DisplayName,CompanyId,CompanyName, HiddenS" AutoGenerateColumns="False" Width="100%" HorizontalAlign="center"
        GridLines="None" BorderStyle="None"
        CellPadding="4"
        EmptyDataText="No Employees found with that Search criteria."
        OnSelectedIndexChanged="OnSelectedIndexChanged"
        OnPageIndexChanging="a_grdEmployee_PageIndexChanging">

                    <Columns>
                        <asp:BoundField HeaderText="Employee Id" DataField="EmployeeId" Visible="false" />
                        <asp:BoundField HeaderText="Company Id" DataField="CompanyId" Visible="false" />
                        <asp:BoundField HeaderText="" DataField="HiddenS" Visible="false" />
                        <asp:BoundField HeaderText="Number" DataField="CompanyNumber" Visible="true"></asp:BoundField>
                        <asp:BoundField HeaderText="Company Name" DataField="CompanyName" Visible="true" />

                        <asp:BoundField HeaderText="EE Number" DataField="EENumber"></asp:BoundField>
                        <%--ItemStyle-Width="200px"--%>
                        <asp:BoundField HeaderText="Employee Name" DataField="EmployeeName" ItemStyle-Width="30%"></asp:BoundField>
                        <asp:BoundField HeaderText="SSN" DataField="SSN" SortExpression="SSN">
                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField HeaderText="Class" DataField="Class"></asp:BoundField>
                        <asp:BoundField HeaderText="Display" DataField="DisplayName" Visible="false" />
                        <asp:BoundField HeaderText="SearchName" DataField="DisplayName" Visible="false" />
                    </Columns>

                    <PagerStyle CssClass="grdPager" HorizontalAlign="Center" />
        <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" FirstPageText="First" LastPageText="Last" NextPageText="Next" PreviousPageText="Prev" />

        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />

    </asp:GridView>

    <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>

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

