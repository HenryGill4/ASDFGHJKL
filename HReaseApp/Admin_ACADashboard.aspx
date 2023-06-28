<%@ Page Title="Admin ACA Dashboard"
    Language="vb"
    AutoEventWireup="false"
    MasterPageFile="~/AppMasterHeader.Master"
    CodeBehind="Admin_ACADashboard.aspx.vb"
    Inherits="HReaseApp.Admin_ACADashboard"
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
    <div class="HREWrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>ACA Dashboard</b></h4>
            </div>
        </div>
        <div id="divTopHeader" runat="server">
            <div id="div1" runat="server">
                <div id="divCompanyList" runat="server" class="well HRESlateBlue form-inline">

                    <span style="padding-left: 10px; padding-right: 10px; width: 10%;">Company:
                    </span>
                    <span style="min-width: 300px!important; max-width: 600px!important; width: 50%!important;">
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
        </div>
        <div id="divCompanyName" runat="server" class="well" style="text-align: center; margin-right: 5%;">
            <b>
                <asp:Label ID="lblCompanyName" runat="server" Text="CompanyName"></asp:Label></b>
            <br />
            <br />
        </div>

        <div id="divWelcomeMessage" class="grid-container">
            <div id="divAlert" runat="server" visible="true" class="grid-item">

                <h4>Administrator Messages</h4>
                <asp:Label ID="lblAlertTitle" runat="server" CssClass="h1Error"></asp:Label>
                <br />
                <br />
                <asp:Label ID="lblAlertMessage" runat="server" CssClass="h1Error"></asp:Label>
            </div>
            <div class="grid-item">
                <h4>Dashboard Reports</h4>
                <asp:LinkButton ID="lnkEdit" runat="server" PostBackUrl="~/Admin_Reports.aspx" CssClass="text-success"> 
                <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
             Add and Organize your reports
                <br />
                </asp:LinkButton>
                <asp:DataList ID="lstReports" runat="server" Width="100%" RepeatColumns="1" CellPadding="3">
                    <ItemStyle BackColor="White" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkReports" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ShortDesc")%>' CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ReportId")%>'>    <%--data-toggle="modal" data-target="#ModalParameters"--%>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:DataList>
            </div>
        </div>

        <div class="grid-container">
            <div id="divACACounts" runat="server" class="grid-item">
                <div class="form-group">
                    <table class="table table-bordered table-condensed" style="border: 1px solid grey;">
                        <tr>
                            <td colspan="12" class="text-center" style="color: navy;">
                                <strong>ALE Trend Monthly Average
                                    <br />
                                    <span class="text-success">(# of Months)</span></strong></td>
                        </tr>
                        <tr>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>1 </strong></td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>2 </strong></td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>3 </strong></td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>4 </strong></td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>5 </strong></td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>6 </strong></td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>7 </strong></td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>8 </strong></td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>9 </strong></td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>10 </strong></td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>11 </strong></td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>12 </strong></td>
                        </tr>
                        <tr>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                                <asp:Label ID="lblALETrend1MonthAve" runat="server" class="control-label text-center"></asp:Label>
                            </td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                                <asp:Label ID="lblALETrend2MonthAve" runat="server" class="control-label"></asp:Label>
                            </td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                                <asp:Label ID="lblALETrend3MonthAve" runat="server" class="control-label"></asp:Label>
                            </td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                                <asp:Label ID="lblALETrend4MonthAve" runat="server" class="control-label"></asp:Label>
                            </td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                                <asp:Label ID="lblALETrend5MonthAve" runat="server" class="control-label"></asp:Label>
                            </td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                                <asp:Label ID="lblALETrend6MonthAve" runat="server" class="control-label"></asp:Label>
                            </td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                                <asp:Label ID="lblALETrend7MonthAve" runat="server" class="control-label"></asp:Label>
                            </td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                                <asp:Label ID="lblALETrend8MonthAve" runat="server" class="control-label"></asp:Label>
                            </td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                                <asp:Label ID="lblALETrend9MonthAve" runat="server" class="control-label"></asp:Label>
                            </td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                                <asp:Label ID="lblALETrend10MonthAve" runat="server" class="control-label"></asp:Label>
                            </td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                                <asp:Label ID="lblALETrend11MonthAve" runat="server" class="text-center"></asp:Label>
                            </td>
                            <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                                <asp:Label ID="lblALETrend12MonthAve" runat="server" class="control-label"></asp:Label>
                            </td>
                        </tr>

                    </table>
                </div>

                <div id="divEdit" class="well HRERewrap pt-5 pb-5" runat="server">
                    <div class="form-group">
                        <label for="ddlMeasurementMethod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Measurement Method:</label>
                        <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3">
                            <asp:DropDownList ID="ddlMeasurementMethod" runat="server" CssClass="form-control" DataValueField="ACAMethodTypeId" DataTextField="ShortDesc" TabIndex="1"></asp:DropDownList>
                        </div>

                        <label for="ddlIntialPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Initial Period:</label>
                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                            <asp:DropDownList ID="ddlIntialPeriod" runat="server" CssClass="form-control" DataValueField="PeriodId" DataTextField="LongDesc" TabIndex="2"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="ddlMeasurementPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Measurement Period:</label>
                        <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3">
                            <asp:DropDownList ID="ddlMeasurementPeriod" runat="server" CssClass="form-control" DataValueField="PeriodId" DataTextField="LongDesc" TabIndex="3"></asp:DropDownList>
                        </div>

                        <label for="ddlStabilityPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Stability Period:</label>
                        <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3">
                            <asp:DropDownList ID="ddlStabilityPeriod" runat="server" CssClass="form-control" DataValueField="PeriodId" DataTextField="LongDesc" TabIndex="4"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="form-group ">
                        <label for="txtPeriodBegin" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Measurement Period Begin:</label>
                        <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3 ">
                            <asp:TextBox ID="txtPeriodBegin" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" TabIndex="5"></asp:TextBox>
                        </div>

                        <label for="ddlAdminPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Administrative Period:</label>
                        <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3">
                            <asp:DropDownList ID="ddlAdminPeriod" runat="server" CssClass="form-control" DataValueField="PeriodId" DataTextField="LongDesc" TabIndex="6"></asp:DropDownList>
                        </div>
                    </div>

                    <div class="form-group ">
                        <label for="txtPeriodEnd" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Measurement Period End:</label>
                        <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3 ">
                            <asp:TextBox ID="txtPeriodEnd" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" TabIndex="7"></asp:TextBox>
                        </div>

                        <label for="txtFirstPayroll" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">First Payroll Date:</label>
                        <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3 ">
                            <asp:TextBox ID="txtFirstPayroll" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" TabIndex="8"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group ">
                        <label for="txtLastIRSReport" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Last IRS Report Date:</label>
                        <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3 ">
                            <asp:TextBox ID="txtLastIRSReport" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" TabIndex="9"></asp:TextBox>
                        </div>

                        <label for="txtMostRecentPayroll" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Most Recent Payroll Date:</label>
                        <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3 ">
                            <asp:TextBox ID="txtMostRecentPayroll" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" TabIndex="10"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group ">
                        <label for="txtNextIRSReport" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Next IRS Report Date:</label>
                        <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3 ">
                            <asp:TextBox ID="txtNextIRSReport" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" TabIndex="11"></asp:TextBox>
                        </div>

                        <label for="txtALECountBegin" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">ALE Count Begin Date:</label>
                        <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3 ">
                            <asp:TextBox ID="txtALECountBegin" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" TabIndex="12"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group ">
                        <label for="txtACAPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label ">Last ALE Count: </label>
                        <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3 ">
                            <asp:TextBox ID="txtLastACACount" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" TabIndex="13"></asp:TextBox>
                        </div>

                        <label for="txtALECountEnd" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">ALE Count End Date:</label>
                        <div class="col-xs-5 col-sm-5 col-md-3 col-lg-3 ">
                            <asp:TextBox ID="txtALECountEnd" runat="server" CssClass="form-control" TabIndex="14"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="d-flex justify-content-end">
                            <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2" style="float: right !important;">
                                <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" ImageAlign="AbsMiddle" TabIndex="23" CssClass="btn-cancel" />
                            </div>

                            <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2" style="float: right !important;">
                                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valRules" OnClick="btnSave_Click" CssClass="btn-save" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="grid-item">
                <div>
                    <div>
                        <h3 class="header-title">Employee List</h3>
                    </div>
                    <div class="search-box">
                        <i class="bx bx-search icon"></i>
                        <asp:TextBox runat="server" ID="Searchtxt" CssClass="search-input" placeholder="Search..." />
                        <asp:Button runat="server" ID="searchbtn" CssClass="search-btn" Text="Search" OnClick="searchbtn_Click"></asp:Button>
                    </div>
                </div>
                <div id="divEEGrid" class="form-group employee-grid">

                    <asp:Label ID="lblHightlight1" CssClass="text-success small_text" Text="** Click Employee row to Shadow **" runat="server" Visible="true"></asp:Label>
                    <asp:GridView ID="a_grdEmployee" runat="server" CssClass="employee-grid"
                        AllowPaging="true"
                        PageSize="20"
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
                            <asp:BoundField HeaderText="Number" DataField="CompanyNumber" Visible="false"></asp:BoundField>
                            <asp:BoundField HeaderText="Company Name" DataField="CompanyName" Visible="false" />

                            <asp:BoundField HeaderText="EE Number" DataField="EENumber"></asp:BoundField>
                            <asp:BoundField HeaderText="Employee Name" DataField="EmployeeName" ItemStyle-Width="30%"></asp:BoundField>
                            <asp:BoundField HeaderText="SSN" DataField="SSN" SortExpression="SSN" Visible="false">
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

        </div>
        <div class="grid-container">



            <div class="grid-item">
                <div class="form-container">
                    <h1>ACA Affordability Calculator</h1>
                    <p>Use this calculator to determine the affordability of your health plan under the Affordable Care Act (ACA).</p>
                    <div class="form-row">
                        <div class="form-group1">
                            <asp:Label ID="PayTypeLabel" runat="server" Text="Payment Type" />
                            <asp:RadioButtonList ID="PayType" runat="server" ToolTip="Select whether you are paid hourly or salaried.">
                                <asp:ListItem Text="Hourly" Value="Hourly"></asp:ListItem>
                                <asp:ListItem Text="Salaried" Value="Salaried"></asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                        <div class="form-group1">
                            <asp:Label ID="PayLabel" runat="server" Text="Hourly Rate / Annual Salary" />
                            <asp:TextBox ID="PayInput" runat="server" ToolTip="Enter your hourly rate or annual salary."></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group1">
                            <asp:Label ID="ContributionLabel" runat="server" Text="Monthly Health Plan Contribution" />
                            <asp:TextBox ID="ContributionInput" runat="server" ToolTip="Enter your monthly health plan contribution."></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row">
                        <asp:Button ID="CalculateButton" runat="server" Text="Calculate" OnClick="CalculateButton_Click" CssClass="btn btn-primary" />
                        <asp:Button ID="ResetButton" runat="server" Text="Reset" OnClick="ResetButton_Click" CssClass="btn btn-secondary" />
                    </div>
                </div>

                <div class="hidden" id="resultsdiv" runat="server">
                    <asp:Label ID="ResultLabel" runat="server" ForeColor="Red" />
                    <div class="Affordable-ResultBox" id="resultBox">
                        <h4 class="text-center">Your Result</h4>
                        <div class="table-responsive mTop10">
                            <table class="table table-bordered mTop0">
                                <tr>
                                    <td class="emptybor"></td>
                                    <td colspan="2" class="taC td-bg cur-contri-bg">Current Contribution
                                    </td>
                                    <td colspan="2" class="taC td-bg aff-contri-bg">Affordable Contribution
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fstyle">Employee's monthly income
                                    </td>
                                    <td>Employee's monthly contribution
                                    </td>
                                    <td>Percentage of income the employee has contributed
                                    </td>
                                    <td>Affordable employee contribution<span id="AffordPer"></span></td>
                                    <td>Percentage of income the employee can contribute
                                    </td>
                                </tr>
                                <tr class="trResultRateOfPay blu1">
                                    <th colspan="5">Rate of Pay Safe Harbor
                                    </th>
                                </tr>
                                <tr class="trResultRateOfPay">
                                    <td>
                                        <asp:Label ID="RateofPayIncome" runat="server" /></td>
                                    <td>
                                        <asp:Label ID="EmployeeCont" runat="server" /></td>
                                    <td>
                                        <asp:Label ID="RateofPayPer" runat="server" />
                                        <br />
                                        <asp:Label ID="RateofPayPertxt" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="RateofPayMin" runat="server" /></td>
                                    <td>
                                        <asp:Label ID="AffortablePerc" runat="server" /></td>
                                </tr>
                                <%--                    <tr class="trw2 blu1">
                        <th colspan="5">
                            W-2 Safe Harbor
                        </th>
                    </tr>
                    <tr class="trw2">
                        <td><asp:Label ID="W2Income" runat="server"/></td>
                        <td><asp:Label ID="EmployeeContW2" runat="server"/></td>
                        <td>
                            <asp:Label ID="W2Per" runat="server"/>
                            <br />
                            <asp:Label ID="W2Pertxt" runat="server"/>
                        </td>
                        <td><asp:Label ID="W2Min" runat="server"/></td>
                        <td><asp:Label ID="AffortablePercW2" runat="server"/></td>
                    </tr>--%>
                                <tr class="blu1">
                                    <th colspan="5">Federal Poverty Line Safe Harbor
                                    </th>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="FPLIncome" runat="server" /></td>
                                    <td>
                                        <asp:Label ID="EmployeeContFPL" runat="server" /></td>
                                    <td>
                                        <asp:Label ID="FPLPer" runat="server" />
                                        <br />
                                        <asp:Label ID="FPLPertxt" runat="server" />
                                    </td>
                                    <td>
                                        <asp:Label ID="FPLMin" runat="server" /></td>
                                    <td>
                                        <asp:Label ID="AffortablePercFPL" runat="server" /></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="grid-item">
                <div style="width: 100%;">
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

                        <div>
                            <asp:GridView ID="grdDocument" runat="server"
                                DataKeyNames="DocumentId,CompanyId, DocLongDesc,DocTypeDesc, IsAParentDocument, ParentName "
                                AutoGenerateColumns="False" Width="100%"
                                CssClass="myGrid"
                                HorizontalAlign="Center"
                                GridLines="None" BorderColor="#3276B1"
                                CellPadding="10"
                                AllowPaging="true"
                                PageSize="10"
                                EmptyDataText="No Documents are currently uploaded for company."
                                OnRowCommand="grdDocument_RowCommand"
                                OnRowEditing="grdDocument_RowEditing1"
                                OnRowCancelingEdit="grdDocument_RowCancelingEdit"
                                OnRowUpdating="grdDocument_RowUpdating">
                                <HeaderStyle CssClass="headerStyle" />
                                <RowStyle CssClass="rowStyle" />
                                <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                <Columns>
                                    <asp:BoundField HeaderText="Document Id" DataField="DocumentId" Visible="false" />
                                    <asp:BoundField HeaderText="IsAParentDocument" DataField="IsAParentDocument" Visible="false" />
                                    <asp:BoundField HeaderText="ParentName" DataField="ParentName" Visible="false" />
                                    <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="left" Visible="false">
                                        <ItemTemplate>
                                            <asp:Image ID="imgArrow" ImageUrl="~/img/arrow_right.png" Width="20px" runat="server" />
                                            <asp:Label ID="lblParent" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ParentName")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:ButtonField runat="server" Text="Assign" CommandName="Permissions" HeaderText="Assign" ItemStyle-HorizontalAlign="Center" Visible="false"></asp:ButtonField>

                                    <asp:TemplateField HeaderText="Category" ItemStyle-Width="20%">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDocCategoryGrid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocCategoryDesc")%>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlDocCategoryGrid" runat="server" CssClass="form-control" DataValueField="DocumentCategoryId" DataTextField="ShortDesc" AutoPostBack="false" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Type" Visible="false">
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

                                    <asp:TemplateField HeaderText="Doc Begin" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDocBeginGrid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtDocBeginGrid" runat="server" CssClass="form-control" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' />
                                            <asp:RequiredFieldValidator ID="valDocBeginDate" runat="server" ErrorMessage="<h4>Document Begin Date</h4>" ControlToValidate="txtDocBeginGrid" ValidationGroup="valDocs" Display="None"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="cmvalDocBeginDate" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtDocBeginGrid" ErrorMessage="<h4>Document Begin Date is not formatted correctly (mm/dd/yyyy)</h4>" Display="None" ValidationGroup="valDocs"></asp:CompareValidator>
                                        </EditItemTemplate>

                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Doc End" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDocEndGrid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtDocEndGrid" runat="server" CssClass="form-control" Width="100px" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' />
                                            <asp:RequiredFieldValidator ID="valDocEndDate" runat="server" ErrorMessage="<h4>Document Begin Date</h4>" ControlToValidate="txtDocEndGrid" ValidationGroup="valDocs" Display="None"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="cmvalDocEndDate" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtDocEndGrid" ErrorMessage="<h4>Document End Date is not formatted correctly (mm/dd/yyyy)</h4>" Display="None" ValidationGroup="valDocs"></asp:CompareValidator>

                                        </EditItemTemplate>

                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Update" Visible="false">
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
                                                PageSize="20"
                                                CellPadding="6"
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
                                                            <asp:LinkButton ID="lnkEdit" runat="server" Text="Update" CommandName="Edit"></asp:LinkButton>
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
                                                                PageSize="5"
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
                                <PagerStyle CssClass="grdPager" HorizontalAlign="Center" />
                                <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" FirstPageText="First" LastPageText="Last" NextPageText="Next" PreviousPageText="Prev" />

                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                            </asp:GridView>
                            <asp:LinkButton ID="LinkButton1" runat="server"></asp:LinkButton>
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
            </div>
        </div>
        <div class=" grid-container">
            <div class="grid-item">
                <div id="divReviewACARules" class="well HRETan hidden" runat="server">
                    <div class="form-group ">
                        <label for="lblMeasurementMethod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right ">Measurement Method: </label>
                        <div class="col-xs-3 col-sm-3 col-md-1 col-lg-2 ">
                            <asp:Label ID="lblMeasurementMethod" runat="server" class="control-label"></asp:Label>
                        </div>

                        <label for="lblIntialPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right ">Initial Period: </label>
                        <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                            <asp:Label ID="lblIntialPeriod" runat="server" class="control-label"></asp:Label>
                        </div>
                    </div>

                    <div class="form-group ">
                        <label for="lblMeasurementPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right ">Measurement Period: </label>
                        <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                            <asp:Label ID="lblMeasurementPeriod" runat="server" class="control-label"></asp:Label>
                        </div>

                        <label for="lblStabilityPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">Stability Period:</label>
                        <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                            <asp:Label ID="lblStabilityPeriod" runat="server" class="control-label"></asp:Label>
                        </div>
                    </div>

                    <div class="form-group ">
                        <label for="lblPeriodBegin" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right ">Measurement Period Begin: </label>
                        <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                            <asp:Label ID="lblPeriodBegin" runat="server" class="control-label"></asp:Label>
                        </div>

                        <label for="lblAdmistrativePeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">Admistrative Period:</label>
                        <div class="col-xs-3 col-sm-3 col-md-4 col-lg-4 ">
                            <asp:Label ID="lblAdmistrativePeriod" runat="server" class="control-label"></asp:Label>
                        </div>
                    </div>

                    <div class="form-group ">
                        <label for="lblPeriodEnd" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right ">Measurement Period End: </label>
                        <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                            <asp:Label ID="lblPeriodEnd" runat="server" class="control-label"></asp:Label>
                        </div>

                        <label for="lblFirstPayrollAvailable" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">First Payroll Available:</label>
                        <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                            <asp:Label ID="lblFirstPayrollAvailable" runat="server" class="control-label"></asp:Label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="lblLastIRSReportDate" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">Last IRS Report:</label>
                        <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                            <asp:Label ID="lblLastIRSReportDate" runat="server" class="control-label"></asp:Label>
                        </div>

                        <label for="lblMostRecentPayroll" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">Most Recent Payroll Available:</label>
                        <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                            <asp:Label ID="lblMostRecentPayroll" runat="server" class="control-label"></asp:Label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="lblNextIRSReport" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">Next IRS Report:</label>
                        <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                            <asp:Label ID="lblNextIRSReport" runat="server" class="control-label"></asp:Label>
                        </div>

                        <label for="lblLastALECountBegin" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right ">ALE Count Begin Date: </label>
                        <div class="col-xs-3 col-sm-3 col-md-1 col-lg-1 ">
                            <asp:Label ID="lblLastALECountBegin" runat="server" class="control-label"></asp:Label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="lblLastALECount" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">Last ALE Count:</label>
                        <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                            <asp:Label ID="lblLastALECount" runat="server" class="control-label"></asp:Label>
                        </div>

                        <label for="lblLastALECountEnd" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right ">ALE Count End Date: </label>
                        <div class="col-xs-3 col-sm-3 col-md-1 col-lg-1 ">
                            <asp:Label ID="lblLastALECountEnd" runat="server" class="control-label"></asp:Label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class=" col-lg-2  pull-right">
                            <asp:ImageButton ID="btnEditRules" runat="server" ImageUrl="img/GreenEditBtnNew.png" OnMouseOver="src='/img/GreenEditBtnOverNew.png';" OnMouseOut="src='/img/GreenEditBtnNew.png';" ImageAlign="AbsMiddle" OnClick="btnEditRules_Click" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="grid-item">
                
            </div>

        </div>
    </div>


    <style>
        .myGrid {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 0px 10px 20px 0px rgba(0,0,0,0.15);
            margin-bottom: 20px;
        }

            .myGrid .headerStyle {
                background: #007BFF;
                color: white;
                font-size: 14px;
                text-transform: uppercase;
            }

            .myGrid .rowStyle {
                background: #f2f2f2;
                color: #333;
                font-size: 14px;
            }

                .myGrid .rowStyle:hover {
                    background: #e2e2e2;
                }

        .HREWrapper {
            margin-left: 5%;
            margin-right: 5%;
        }

        .HRESlateBlue {
            background-color: #ccd5e4;
        }

        .HRERewrap {
            padding: 0px;
        }

            .HRERewrap .form-group {
                padding: 5px !important;
            }

        .Searchtxt {
            /*            display: none !important;*/
        }

        .form-group {
            margin: 10px 0px 5px 0px !important;
        }

        :root {
            --primary-color: #f9feff;
            --secondary-color: #a6b1e1;
            --text-color: #333;
        }

        .grid-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            padding: 0px 0px 20px 0px;
            background-color: var(--primary-color);
        }

        .grid-item {
            background: white;
            color: var(--text-color);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 10px 15px -3px rgba(0, 0, 0, 0.1), 0px 4px 6px -2px rgba(0, 0, 0, 0.05);
            transition: all 0.2s ease-in-out;
        }

            .grid-item:hover {
                transform: scale(1.02);
                box-shadow: 0px 20px 25px -5px rgba(0, 0, 0, 0.1), 0px 10px 10px -5px rgba(0, 0, 0, 0.04);
            }

        .header-title {
            color: #014679;
            margin-bottom: 15px;
        }

        .search-box {
            display: flex;
            align-items: center;
            color: #014679;
        }

            .search-box .icon {
                font-size: 20px;
                margin-right: 5px;
            }

        .search-input {
            color: #014679;
            background-color: #ffffff;
            border: 2px solid #e0e0e0;
            border-radius: 4px;
            padding: 5px 10px;
            flex-grow: 1;
            margin-right: 5px;
        }

        .search-btn {
            background-color: #014679;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            padding: 5px 10px;
            cursor: pointer;
        }

            .search-btn:hover {
                background-color: #01335a;
            }


        .employee-grid {
            border: 1px solid #e0e0e0;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .grdPager {
            color: #014679;
            font-size: 0.9em;
            padding: 10px 0;
        }

        .grdHeaderrow {
            background-color: #014679;
            color: #ffffff;
            text-transform: uppercase;
            padding: 10px 0;
        }

        .grdNormalrow, .grdNormalAltrow {
            padding: 10px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .grdNormalAltrow {
            background-color: #f7f7f7;
        }

        .employee-grid .form-group {
            border-radius: 4px;
            overflow: hidden;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .control-label {
            font-size: 1.1rem;
            margin-bottom: 5px;
            display: inline-block;
        }

        .form-container {
            display: flex;
            flex-direction: column;
            gap: 1em;
            max-width: 600px;
            margin: auto;
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 1em;
            align-items: center;
        }

        .form-group1 {
            flex: 1 1 200px;
            display: flex;
            flex-direction: column;
        }

            .form-group1 label {
                margin-bottom: 0.5em;
            }

            .form-group1 input[type="text"],
            .form-group1 select {
                padding: 0.5em;
                font-size: 1em;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

        .btn-save, .btn-cancel {
            max-width: 100%;
            height: auto;
        }

        .error {
            border: 1px solid red;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        /* ...your existing css... */

        #resultsdiv {
            background-color: var(--primary-color);
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0px 5px 15px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

            #resultsdiv h1 {
                text-align: center;
                color: #014679;
            }

        #ResultLabel {
            color: red;
            font-weight: bold;
            margin-bottom: 10px;
            text-align: center;
        }

        .Affordable-ResultBox {
            padding: 15px;
            border-radius: 10px;
            background-color: white;
            box-shadow: 0px 10px 15px -3px rgba(0, 0, 0, 0.1), 0px 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        .table-responsive {
            margin-top: 20px;
        }

        .table {
            border-radius: 10px;
            overflow: hidden; /* This allows the rounded corners on the table */
        }

            .table thead th {
                background-color: #014679;
                color: #fff;
                border: none;
            }

            .table tbody tr {
                transition: background-color 0.3s ease;
            }

                .table tbody tr:hover {
                    background-color: #f0f0f0;
                }

            .table td, .table th {
                border: none;
            }

        .blu1 th {
            color: white;
            background-color: #014679;
        }

        .td-bg {
            background-color: #f8f9fa;
        }

        .cur-contri-bg {
            background-color: rgb(255, 248, 178);
            color: black;
            padding: 10px;
            line-height: 2em !important;
        }

        .aff-contri-bg {
            background-color: #d6ffd6;
            color: black;
            padding: 10px;
            line-height: 2em !important;
        }

        .greenTxt {
            color: #28a745;
        }

        .blu1 {
            background-color: #014679;
            color: #ffffff;
        }
    </style>
</asp:Content>
