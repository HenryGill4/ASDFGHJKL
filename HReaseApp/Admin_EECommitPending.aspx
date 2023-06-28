<%@ Page Title="Commit Pending Elections Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master"  
    CodeBehind="Admin_EECommitPending.aspx.vb" 
    Inherits="HReaseApp.Admin_EECommitPending" 
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" runat="Server"  >
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
    <style>
          .buttonReview {
              color: white;
              background-color: #639ED5;
              box-shadow: 0px 0px 0px 0px;
              padding: 3px 3px;
              width: 80px;
              height: 30px;
              font-weight:500;
              font-size:small;
              vertical-align:middle;
              margin:1px 1px 1px 0px;
              float:left;
        }
        .buttonSave {
              color: darkolivegreen;
              background-color: #8CC85A;
              box-shadow: 0px 0px 0px 0px;
              padding: 3px 3px;
              width: 80px;
              height: 30px;
              font-weight:500;
              font-size:small;
              vertical-align:middle;
              margin:1px 1px 1px 0px;
              float:right;
        }
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
    </style>

    <div class="HREwrapper">
        <div id="divPageTitle">
            <div >
                <br />
                <h4><b>Commit Pending Elections</b></h4>
            </div>
        </div>

        <div id="divNextButton" runat="server" class="hidden-xs" style="float:right; display:inline; width:10%; margin-top:-10px;">
            <asp:ImageButton ID="imgNext" runat="server" class="HRENext" ToolTip="NEXT" ImageUrl="../img/NextArrowInCircleBlueGreenTP.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreenTP.png';" OnClick="imgNext_Click" />
        </div>

        <div id="divProcessing" runat="server" visible="false">
            <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Width="100%" />
        </div>

        <div id="divTopHeader" class="form-group ">
            <div>
                Please choose at least one search option
            </div>
            <div id="divSearch" runat="server" class="well form-group" style="margin-right:5%;">
                
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
                        <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-control" TabIndex="1" DataValueField="CompanyId" DataTextField="CombinedCompanyName" AutoPostBack="true" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged"></asp:DropDownList>
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
                    <div id="divClearSearch" runat="server" style="float:right; vertical-align:top;">
                        <asp:Button ID="btnClearSearch" runat="server" Enabled="true" EnableViewState="true" Class="ClearSearchbtn" Text="Clear Search" autopostback="true" OnClick="btnClearSearch_Click" />
                    </div> 
                </div>
            </div>
        </div>
                               
        <div id="divResults" class="HRETan"  runat="server" Visible ="false" style="margin-right:5%;">
            <div>
                <div class=" checkbox pull-right ">
                    <asp:CheckBox ID="chkApproveAll" runat="server" TabIndex="5" Checked="false" Text="&nbsp;Click to Approve All" AutoPostBack="true" OnCheckedChanged="chkApproveAll_CheckedChanged" TextAlign="Right"></asp:CheckBox>
                    <asp:CheckBox ID="chkDisapproveAll" runat="server" TabIndex="6" Visible="false" Text="&nbsp;Click to Disapprove All" AutoPostBack ="true" OnCheckedChanged="chkDisapproveAll_CheckedChanged" TextAlign="Right"></asp:CheckBox>                           
                </div>
                   
                <div class=" center ">
                    <asp:GridView ID="grdCommit" runat="server"
                        DataKeyNames="EmployeeElectionPendingId, EmployeeId, CompanyId, EmployeeDisplayName, CompanyName, RowNumber" AutoGenerateColumns="False" width="100%" HorizontalAlign="Center"
                        GridLines="None" 
                        BorderColor="#3276B1"
                        CellPadding="4"
                        EmptyDataText="No Pending Elections were found."
                        AlternatingRowStyle-CssClass="grdNormalAltrow"
                        OnSelectedIndexChanged="grdCommit_SelectedIndexChanged"
                            >
                               
                        <AlternatingRowStyle CssClass="grdNormalAltrow" ></AlternatingRowStyle>
                            <Columns>
                                <asp:BoundField HeaderText="EmployeeElectionPendingId" DataField="EmployeeElectionPendingId"  Visible="false" />
                                <asp:TemplateField HeaderText="" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-VerticalAlign="Middle">
                                    <ItemTemplate>
                                        <asp:Button ID="btnReview" Text="Review" runat="server" Enabled="true" EnableViewState="true" Class="buttonReview" autopostback="true" OnClick="btnReview_Click" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Company" DataField="CompanyName">
                                    <ItemStyle Width="20%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Employee" DataField="EmployeeDisplayName" >
                                    <ItemStyle Width="15%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Event" DataField="EventType">
                                    <ItemStyle Width="10%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Effective Date" DataField="CoverageBegin" > 
                                    <ItemStyle Width="10%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Enroller" DataField="Enroller" >
                                    <ItemStyle Width="10%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Pended For" DataField="ReasonPended" >
                                    <ItemStyle Width="10%"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Plan Description" DataField="PlanDesc">
                                    <ItemStyle Width="25%"></ItemStyle>
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Approve" >
									<ItemTemplate >
										<asp:CheckBox ID="chkApprove" Runat="server" Class =" center" Width="20px" Enabled="true" EnableViewState="true" AutoPostBack ="true"  OnCheckedChanged="chkApprove_CheckedChanged"></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Disapprove">
									<ItemTemplate>
										<asp:CheckBox ID="chkDisapprove" Runat="server" Enabled="true" EnableViewState="true" AutoPostBack="true" OnCheckedChanged="chkDisapprove_CheckedChanged"></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateField>
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <asp:Button ID="btnSaveOne" Text="Save" runat="server" Class="buttonSave" autopostback="true" OnClick="btnSaveOne_Click" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="EmployeeId" DataField="EmployeeId"  Visible="false" />
                                <asp:BoundField HeaderText="CompanyId" DataField="CompanyId"  Visible="false" />
                                <asp:BoundField HeaderText="EmployeeDisplayName" DataField="EmployeeDisplayName"  Visible="false" />
                                <asp:BoundField HeaderText="CompanyName" DataField="CompanyName"  Visible="false" />
                                <asp:BoundField HeaderText="RowNumber" DataField="RowNumber"  Visible="false" />
                            </Columns>      
                       
                        <FooterStyle BackColor="#D3D3D3" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle HorizontalAlign="Center" Font-Size="Small" BackColor="#ccd5e4" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left"/>                               
                                     
                    </asp:GridView>
                           
                </div>

            </div>
            <div class="form-group">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12  right ">
                    <br />
                    <asp:Button ID="btnSaveAll" Text="Save All" runat="server" ControlStyle-CssClass="btn-primary  btn-lg" autopostback="true" OnClick="btnSaveAll_Click" />
                </div>
            </div>
        </div>

    </div>
    <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; margin-left:20px; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px 10px 10px 10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HRENext {padding:5px 5px 5px 5px; float:right; min-width:50px; max-width:90px; }
        .img {display: inline-block; width: auto; height: auto;}
    </style>
</asp:Content>
