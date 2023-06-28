<%@ Page Title="Admin Dashboard for Employee Onboarding " 
    Language="vb" AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="Admin_EEOnboarding.aspx.vb" 
    Inherits="HReaseApp.Admin_EEOnboarding" 
    MaintainScrollPositionOnPostback="false" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>   
    </div>  
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" runat="server">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" rel="stylesheet" />
    <style>
        .chosen-container{
            min-width: 300px !important;
            max-width:600px !important; 
            width:100% !important;
        }
    </style>
    <meta name="viewport" content="initial-scale = 1.0, maximum-scale = 1.0, user-scalable = no, width = device-width"/>
    <style>
        .ClearSearchbtn {
              color: white;
              background-color: #8CC85A;
              box-shadow: 1px 1px 2px #000000;
              padding: 3px 3px;
              width: 120px;
              height: 40px;
              font-weight:700;
              font-size:medium;
              vertical-align:middle;
              margin:0px 1px 1px 1px;
        }
        @media only screen and (max-width: 780px) {
             .well .form-group{
                 margin:auto !important;
                 width:95% !important;
             }
             .mobile-view{
                 margin:auto !important;
                 padding:0px !important;
             }
            .col-xs-1, .col-sm-1, .col-md-1, .col-lg-1, .col-xs-2, .col-sm-2, .col-md-2, .col-lg-2, .col-xs-3, .col-sm-3, .col-md-3, .col-lg-3, .col-xs-4, .col-sm-4, .col-md-4, .col-lg-4, .col-xs-5, .col-sm-5, .col-md-5, .col-lg-5, .col-xs-6, .col-sm-6, .col-md-6, .col-lg-6, .col-xs-7, .col-sm-7, .col-md-7, .col-lg-7, .col-xs-8, .col-sm-8, .col-md-8, .col-lg-8, .col-xs-9, .col-sm-9, .col-md-9, .col-lg-9, .col-xs-10, .col-sm-10, .col-md-10, .col-lg-10, .col-xs-11, .col-sm-11, .col-md-11, .col-lg-11, .col-xs-12, .col-sm-12, .col-md-12, .col-lg-12{
                margin:auto !important;
                padding:0px !important;
                width:95% !important;
            }
            .HREwrapper{
                width:95% !important;
                margin:auto !important;
            }
        }
    </style>
    
    <div class="HREwrapper">
        <div id="divPageTitle">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 ">
                <br />
                <h4><b>Onboarding Dashboard</b></h4>
            </div>
        </div>

        <div id="divTopHeader" class="form-group" style="margin-left:1%; margin-right:5%;">       
            <div id="divError" runat="server" class="col-md-12 text-center" visible="false" style="background-color: #f2dede; width:100%; padding-top:20px;">
                <h3><b><span style="color: red;">   
                <asp:Image ID="Image1" ImageUrl="../img/RedX.png" runat="server" border="none" Width="50px" />
                    &nbsp;&nbsp;
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
                </span></b></h3>
            </div>
            <div id="divSuccess" runat="server" class="col-md-12 text-center"  visible ="false">
                <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" cssclass=" img" />
                <h3><br /><b><span style="color: green">
                <asp:Label ID="lblSuccess" runat="server" Text="Form Complete.<br/>"></asp:Label>
                </span></b></h3>
            </div>
        </div>

        <%--<div id="divNextButton" style="float:right; padding-right:2%;" >
            <div class="fixed hidden-xs">
                <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageUrl="../img/NextArrowInCircleBlueGreen.png" Width="90%" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click"/>
            </div>
        </div>--%>
                
        <%--<div id="divCompanyName" runat="server" class="well" style="text-align:center; margin-right:5%;">
            <b><asp:Label ID="lblCompanyName" runat="server" Text="CompanyName"></asp:Label></b>
        </div>--%>

        <div class="form-group">
            <div>
                Please choose at least one search option
                <%--<div style="vertical-align:top; float:right; margin-right:6%;">
                    <asp:CheckBox ID="chkActiveCompany" runat="server" TabIndex="15" Checked="true" Text="&nbsp;Uncheck to show Terminated Companies" Visible ="false" CssClass="checkbox-inline" AutoPostBack="true" OnCheckedChanged="ActiveCompany_CheckedChanged"></asp:CheckBox>
                </div>--%>
            </div>
            <div id="divSearch" runat="server" class=" mobile-view well form-group" style="margin-right:5%;">
                
                <div id="divAdminList" runat="server" class="form-group">
                     <asp:Label ID="lblAdminCompany" runat="server" Visible="false" Text="Admin Company:" class="col-xs-4 col-sm-4  col-md-3 col-lg-3 control-label"></asp:Label>
                     <div class="col-xs-7 col-sm-7 col-md-5 col-lg-5">
                        <asp:DropDownList ID="ddlAdminCompany" runat="server" Visible="false" CssClass="form-control" TabIndex="1" DataValueField="CompanyId" DataTextField="CombinedCompanyName" AutoPostBack="true" OnSelectedIndexChanged="ddlAdminCompany_SelectedIndexChanged"></asp:DropDownList>
                    </div>
                    <script>
                        $('#<%=ddlAdminCompany.ClientID%>').chosen();
                    </script>
                </div>

                <div id="divParentList" runat="server" class="form-group">
                     <asp:Label ID="lblParentCompany" runat="server" Text="Parent Company:" Visible="false" cssclass="col-xs-4 col-sm-4  col-md-3 col-lg-3 control-label"></asp:Label>
                     <div class="col-xs-7 col-sm-7 col-md-5 col-lg-5 ">
                        <asp:DropDownList ID="ddlParentCompany" runat="server" Visible="false" CssClass="form-control" TabIndex="1" DataValueField="CompanyId" DataTextField="CombinedCompanyName" AutoPostBack="true" OnSelectedIndexChanged="ddlParentCompany_SelectedIndexChanged"></asp:DropDownList>
                    </div>
                    <script>
                        $('#<%=ddlParentCompany.ClientID%>').chosen();
                    </script>
                </div>

                <div id="divCompanyList" runat="server" class="form-group">
                    <label for="a_ddlCompany" class="col-xs-4 col-sm-4  col-md-3 col-lg-3 control-label">Company:</label>
                    <div class="col-xs-7 col-sm-7 col-md-5 col-lg-5">
                        <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-control" TabIndex="1" DataValueField="CompanyId" DataTextField="CombinedCompanyName" AutoPostBack="true"></asp:DropDownList>
                    </div> 
                    <script>
                        $('#<%=ddlCompany.ClientID%>').chosen();
                    </script>
                        <div class="col-xs-5 col-sm-5 col-md-4 col-lg-4 checkbox ">
                            <asp:checkbox ID="chkOrderByNumber" runat="server" Text="Order by Company Number"  CssClass="checkbox-inline" Checked="false" OnCheckedChanged="chkOrderByNumber_CheckedChanged" AutoPostBack="true"></asp:checkbox>  
                        </div>
                </div>
                 
                <div id="divEmpNameSearch" class="form-group">
                    <label for="a_txtEmpName" class="col-xs-4 col-sm-4  col-md-3 col-lg-3  control-label">Employee Name:</label>
                    <div class="col-xs-7 col-sm-7 col-md-5 col-lg-5 left">
                        <asp:TextBox ID="txtEmpName" runat="server" CssClass="form-control" TabIndex="2" placeholder="Search by Last or First Name"></asp:TextBox>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 left">
                        <asp:LinkButton ID="btnEmpName" runat="server" Text="<i aria-hidden='true' class='glyphicon glyphicon-search'></i>" CssClass="btn btn-primary  btn-sm "></asp:LinkButton>
                    </div>

                </div>
                
                <div id="divSSNSearch" class="form-group">
                    <label for="a_txtEmpSSN" class="col-xs-4 col-sm-4  col-md-3 col-lg-3  control-label">Employee SSN:</label>
                    <div class="col-xs-7 col-sm-7 col-md-5 col-lg-5 left">
                        <asp:TextBox ID="txtEmpSSN" runat="server" CssClass="form-control" TabIndex="3" placeholder="Search by any part of SSN"></asp:TextBox>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-2 col-lg-1 left">
                        <asp:LinkButton ID="btnEmpSSN" runat="server" Text="<i aria-hidden='true' class='glyphicon glyphicon-search'></i>" CssClass="btn btn-primary  btn-sm "></asp:LinkButton>
                    </div>
                </div>
                
                <div id="divEENumSearch" class="form-group">
                    <label for="a_txtEmpId" class="col-xs-4 col-sm-4  col-md-3 col-lg-3  control-label">Employee Number:</label>
                    <div class="col-xs-7 col-sm-7 col-md-5 col-lg-5">
                        <asp:TextBox ID="txtEmpNum" runat="server" CssClass="form-control" TabIndex="4" placeholder="Search by Employee Number"></asp:TextBox>
                    </div>
                    <div class="col-xs-1 col-sm-1 col-md-2 col-lg-1 left">
                        <asp:LinkButton ID="btnEmplNumSearch" runat="server" Text="<i aria-hidden='true' class='glyphicon glyphicon-search'></i>" CssClass="btn btn-primary  btn-sm " TabIndex="6"></asp:LinkButton>
                    </div>
                </div>
               
                <div id="divLastRowOfSearchSec">
                    <%--<div id="divCkActiveEEs" style="float:left; padding-left:27%;">
                        <asp:CheckBox ID="chkActive" runat="server" TabIndex="5" Checked="true" Text="&nbsp;Uncheck to show Terminated Employees" AutoPostBack="true" CssClass="checkbox-inline" OnCheckedChanged="chkActive_CheckedChanged"></asp:CheckBox>
                    </div>--%>
                    <div id="divClearSearch" runat="server" style="float:right; vertical-align:top;">
                        <asp:Button ID="btnClearSearch" runat="server" Enabled="true" EnableViewState="true" Class="ClearSearchbtn" Text="Clear Search" autopostback="true" OnClick="btnClearSearch_Click" />
                    </div> 
                </div>
            </div>
        </div>

            <%------  Review-----%>
        <div id="divOnboardingList" runat="server" class="mobile-view well HRETan HRERewrap">     
            <div class="form-group">
            <div class="col-xs-12 col-sm-12 col-md-12 center ">
                <asp:GridView ID="grdReviewEmployees" runat="server"
                    AllowPaging="true"
                    PageSize="25"
                    DataKeyNames="EmployeeId, DisplayName, CompanyId,CompanyName, RegKey, URL, Finalize, PercentComplete" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                    GridLines="None" BorderColor="#3276B1"
                    CellPadding="4"
                    EmptyDataText="No Pending Employees"
                    AlternatingRowStyle-CssClass="grdNormalAltrow"
                    OnPageIndexChanging="grdReviewEmployees_PageIndexChanging">
                    <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                    <Columns>
                        <asp:BoundField HeaderText="Employee Id" DataField="EmployeeId" Visible="false" />
                        <asp:BoundField HeaderText="Company Id" DataField="CompanyId" Visible="false" />
                        <asp:BoundField HeaderText="Company Name" DataField="CompanyName" Visible="false" />

                        <asp:BoundField HeaderText="Percent Complete" DataField="PercentComplete" Visible="true"  ItemStyle-Font-Bold="true" ItemStyle-CssClass="center"/>
                        <asp:BoundField HeaderText="Company Number" DataField="CompanyNumber" Visible="true" />
                        <asp:BoundField HeaderText="Company Name" DataField="CompanyName" Visible="true"/>
                        <asp:BoundField HeaderText="Employee Number" DataField="EENumber" Visible="true" />
                        <asp:BoundField HeaderText="Employee Name" DataField="EmployeeName" Visible="true" />
                        <asp:BoundField HeaderText="Benefit Class" DataField="Class" Visible="true" />
                        <asp:BoundField HeaderText="Email Employee" DataField="RegistrationEmail" HtmlEncode="false" ReadOnly="false" ItemStyle-HorizontalAlign="Center"/>
                        <asp:BoundField HeaderText="Display" DataField="DisplayName" Visible="false" />
                        <asp:BoundField HeaderText="key" DataField="RegKey" Visible="false" />
                        <asp:BoundField HeaderText="url" DataField="URL" Visible="false" />
                        <asp:BoundField HeaderText="Finalize" DataField="Finalize" Visible="false" />
                                    
                        <asp:TemplateField HeaderText="Progress Review">
                            <ItemTemplate>
                                <asp:Button ID="btnReview" Text="Status" class="button btn-success" runat="server" Visible="true" Autopostback="true" OnClick="btnReview_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Verify">
                            <ItemTemplate>
                                <asp:Button ID="btnVerify" Text="Verify I9" class="button  btn-danger" runat="server" Visible="true" Autopostback="true" OnClick="btnVerify_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Reset Security" HeaderStyle-CssClass="center" ItemStyle-CssClass ="center">
                            <ItemTemplate>
                                <asp:ImageButton ID="imgRegistration" runat="server" ImageUrl="../img/License-Key.png" BorderStyle="None" Visible="true" Height='40px' data-toggle="modal" Data-target="#ModalReset" ToolTip="Reset Security" OnClientClick="return false"/>
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
                <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
            </div>
        </div>
        </div>     
                    
        <%--  COLUMN 3  --%>        

        <%--End Review--%>
        <div id="divAdminReview" class="well HREWhite HRERewrap" runat="server" visible="false" style="margin-top:20px; border:1px solid grey;">
            <div class="form-group">
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 left">
                    <h4>Reviewing Data for: <asp:Label ID="lblEmployeeName" runat="server"></asp:Label></h4>
                     <h4><asp:Label ID="lblCompanyName" runat="server" style="margin-left:3%;"></asp:Label></h4>
                </div>

                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4  text-info text-center">
                    <span class="text-primary">% Onboarding Process Complete</span>
                    <div class="progress progress-striped active">
                        <div id="divProgressBar" class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="0" aria-valuemin="10" aria-valuemax="100" style="width: 0%" runat="server">
                            <strong>
                                <asp:Label ID="lblProgress" Text="60" runat="server"></asp:Label></strong>
                        </div>
                     </div>
                </div>                          
                <div id="divProgressList" runat="server" class="form-group">
                    <div class="form-group ">
                       <div class="col-xs-12 col-sm-12 col-md-12 center ">
                           <asp:GridView ID="grdOnboardingProgress" runat="server"
                               DataKeyNames="EmployeeId, StepOrder, StepType, StepDescription, Who, CreateDate, PercentComplete" AutoGenerateColumns="False" Width="80%" HorizontalAlign="Center"
                               GridLines="None" BorderColor="#3276B1"
                               CellPadding="4"
                               EmptyDataText="No Pending Employees"
                               AlternatingRowStyle-CssClass="grdNormalAltrow">
                               <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                               <Columns>
                                   <asp:BoundField HeaderText="Employee Id" DataField="EmployeeId" Visible="false" />
                                   <asp:BoundField HeaderText="Step Order" DataField="StepOrder" Visible="true" />
                                   <asp:BoundField HeaderText="Step Type" DataField="StepType" Visible="true" />
                                   <asp:BoundField HeaderText="StepDescription" DataField="StepDescription" Visible="true" />
                                   <asp:BoundField HeaderText="Who Processed" DataField="Who" Visible="true" />
                                   <asp:BoundField HeaderText="Updated" DataField="CreateDate" Visible="true" />
                                   <asp:BoundField HeaderText="Percent Complete" DataField="PercentComplete" Visible="false" />
                                   
                               </Columns>
                               
                               <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                               <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                               <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                               <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />

                           </asp:GridView>
                           <asp:LinkButton ID="linkdummy" runat="server"></asp:LinkButton>
                       </div>
                   </div>
               </div>
           
                </div>
        </div>

        <%--end of Tab Content--%>

    </div>         
   <div class="modal fade" id="ModalReset" tabindex="-1" role="dialog" aria-labelledby="myModalReset" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title text-success" id="ModalTitle">
                        <asp:Label ID="mlblResetTitle" runat="server" Text="Reset Security"></asp:Label></h4>
                </div>
                <div class="modal-body ">
                    <div class="well">
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-12 col-md-12">
                                <asp:Label ID="mResetlbl1" runat="server" class="col-md-12  h3" Text="Reset Employee Security"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-12 col-md-12">
                                <asp:Label ID="mResetlbl2" runat="server" class="col-md-12  h4"
                                    Text="<b>Please Note:</b> Pressing <b> SAVE</b> will generate a new Registration Key for this employee.  If the employee has already registered, they will be required to establish a new Username, Password, and Security Questions.  After reset - please click on the email icon to send the new registration key to employee. "></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-12 col-md-12">
                                <asp:Label ID="mResetlbl3" runat="server" class="col-md-12 h4" Text="Press <b>CLOSE</b> to exit without resetting the Employee"></asp:Label>

                            </div>
                        </div>                    
                    </div>
                </div>
                <div class="modal-footer">
                             
                        <asp:ImageButton ID="mbtnResetSave"  ImageUrl="../img/BlueSaveBtnNew.png" runat="server" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ></asp:ImageButton>
                    <asp:ImageButton ID="mbtnResetCancel" data-dismiss="modal" ImageUrl="../img/BlueCloseBtn.png" runat="server" OnMouseOver="src='/img/BlueCloseBtnOver.png';" OnMouseOut="src='/img/BlueCloseBtn.png';" TabIndex="-1"></asp:ImageButton>
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
            margin-right: 10%;
        }

        .HRESlateBlue {
            background-color: #ccd5e4;
        }

        .HREWhite {
            background-color: white;
            border: 1px solid grey;
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
            float:right;
        }
    </style>
</asp:Content>






