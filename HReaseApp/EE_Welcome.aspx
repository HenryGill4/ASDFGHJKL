<%@ Page Title="EE Welcome and Home Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeaderSplit.Master" 
    CodeBehind="EE_Welcome.aspx.vb" 
    Inherits="HReaseApp.EE_Welcome" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainBlock" runat="Server">
    <br />
    <div class = "HREWrapper" style="margin-left:5%;">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>Employee Welcome</b></h4>
            </div>
        </div>

        <div id="divTopHeader" class="form-group">                  
            <div id="divError" runat="server" visible ="false" style="vertical-align:middle; display:inline;">
                <h3><b><span style="color: red;">   
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" border="none" Width="50px" />
                    &nbsp;&nbsp;
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
                </span></b></h3>
            </div>
            <div id="divSuccess" runat="server" style="vertical-align:middle; display:inline;">
                <div style="float:left;  visibility:hidden;" >
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" />
                </div>
                <div id="divSuccessLabel" style="text-align:center; color:green; font-size:x-large; visibility:hidden;">
                    <b><asp:Label ID="lblSuccess" runat="server" Text="Form Complete"></asp:Label></b>
                </div>
            </div>
        </div>    
        
        <div id="divMainArticalTitleandText" runat="server" class="well HRERewrap">
            <div class="form-group HRESlateBlue">
                    <h4><asp:Label ID="lblMainArticleTitle" runat="server" Text=""></asp:Label></h4>           
            </div>
            <div class="form-group HREWhite" >
                    <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div>   
  
        <div id="divBenefitButtons" runat="server">
           <div class="form-group ">
               <div class="col-xs-4 col-sm-4 col-md-4 center" style="left: 0px; top: 0px; width: 40%">
                   <div id="divLearn" runat="server" class="text-center">  
                       <p>Click here for benefit information</p>
                       <asp:ImageButton ID="btnLearn" runat="server" ImageUrl="img/YellowLearnMoreBtnNew.png" OnMouseOver="src='/img/YellowLearnMoreBtnOverNew.png';" OnMouseOut="src='/img/YellowLearnMoreBtnNew.png';" ImageAlign="AbsMiddle" PostBackUrl="~/EE_LearnBenefit.aspx" width="150px"/>
                   </div>
                </div>

                <div class="col-xs-6 col-sm-6 col-md-6 center" style="left: 0px; top: 0px; width: 40%">
                   <div id="divEnroll" runat="server" class ="text-center">
                       <p>Click here to begin your enrollment</p>
                       <asp:ImageButton ID="btnEnroll" runat="server" ImageUrl="img/GreenEnrollNowBtnNew.png" OnMouseOver="src='/img/GreenEnrollNowBtnOverNew.png';" OnMouseOut="src='/img/GreenEnrollNowBtnNew.png';"  ImageAlign="AbsMiddle" BorderStyle="none" width="150px" />
                   </div>
                </div>
            </div>
            <br />
            <br />
        </div>

        <div id="divMainForm" class="well SlateBlue" >
            <div id ="divOnboardingInfo" runat="server" class="form-group HREWhite">
                <div id="divCompletePercent">
                    <b>Onboarding Process</b>
                    <div class="progress progress-striped active">
                        <div id="divProgressBar" class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="0" aria-valuemin="10" aria-valuemax="100" style="width: 0%" runat="server">
                            <strong>
                                <asp:Label ID="lblProgress" Text="00" runat="server"></asp:Label></strong>
                        </div>
                     </div>
                </div>                          
                <div id="divProgressList" runat="server">
                       <asp:GridView ID="grdOnboardingProgress" runat="server"
                               DataKeyNames="EmployeeId, StepOrder, StepType, StepDescription, Who, CreateDate, PercentComplete, EEPercentComplete" AutoGenerateColumns="False" Width="98%" HorizontalAlign="Center"
                               GridLines="none" 
                               BorderColor="white"
                               CellPadding="4"
                               EmptyDataText="No Progress">
                               <Columns>
                                   <asp:BoundField HeaderText="Employee Id" DataField="EmployeeId" Visible="false" />
                                   <asp:BoundField HeaderText="Step Order" DataField="StepOrder" Visible="true" ItemStyle-Width="10%"  ItemStyle-VerticalAlign="top"/>
                                   <asp:BoundField HeaderText="Step Type" DataField="StepType" Visible="false" />
                                   <asp:BoundField HeaderText="StepDescription" DataField="StepDescription" Visible="true" ItemStyle-Width="50%" ItemStyle-Wrap="true" />
                                   <asp:BoundField HeaderText="Who Processed" DataField="Who" Visible="true" ItemStyle-Width="20%" ItemStyle-Wrap="true"/>
                                   <asp:BoundField HeaderText="Updated" DataField="CreateDate" Visible="true" ItemStyle-Width="20%" ItemStyle-Wrap="true"/>
                                   <asp:BoundField HeaderText="Percent Complete" DataField="PercentComplete" Visible="false" />
                                   <asp:BoundField HeaderText="EE Percent Complete" DataField="EEPercentComplete" Visible="false" />
                                   
                               </Columns>
                               <alternatingrowstyle backcolor="whitesmoke" forecolor="DarkBlue" />
                               <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                               <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                               <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />

                           </asp:GridView>
                   </div>           
            </div>

            <div id="divBenefitSummary" runat="server" class="well HREWhite" style="display:flex;">
                <div class="row" id="uselessrow">
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-3 small" >
                        <table id="tblLegend" class="tablelegend">
                            <tr>
                                <td style="width: 33.3%; background-color:#F9F9F9; color:navy; border: 1px solid grey" class=" text-center">Current</td>
                                <td style="width: 33.3%; background-color:#FFF; color:red; border: 1px solid grey" class="text-center">Pending</td>
                                <td style="width: 33.3%; background-color:#FFF; color:grey; border: 1px solid grey" class="text-center">None</td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="row " >
                    <div id="divBenefitSummaryGrid" class="col-xs-12 col-sm-12 col-md-12 col-lg-7  center ">
                        <asp:GridView ID="grdSummary" runat="server" AutoGenerateColumns="false" 
                            HeaderStyle-CssClass="text-success" 
                            BorderStyle="None" 
                            GridLines="Horizontal" 
                            DataKeyNames="Pending">
                            <%--<AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>--%>
                            <Columns>
                                <asp:BoundField HeaderText="Plan Type" DataField="PlanTypeShortDesc"></asp:BoundField>
                                <asp:BoundField HeaderText="EE Cost" DataField="EECost" DataFormatString="{0:c}" HtmlEncode="False" ItemStyle-CssClass="Right" HeaderStyle-CssClass="left"></asp:BoundField>
                                <asp:BoundField HeaderText="ER Cost" DataField="ERCost" DataFormatString="{0:c}" HtmlEncode="False" ItemStyle-CssClass="Right" HeaderStyle-CssClass="left"></asp:BoundField>
                                <asp:BoundField HeaderText="Total Cost" DataField="TotalCost" DataFormatString="{0:c}" HtmlEncode="False" ItemStyle-CssClass="Right" HeaderStyle-CssClass="left"></asp:BoundField>
                                <asp:BoundField HeaderText="Pending" DataField="Pending" Visible="false" />
                            </Columns>
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                            <%--<RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />--%>
                            <EmptyDataTemplate>
                                No Benefit Elections on record.
                            </EmptyDataTemplate>
                        </asp:GridView>                     
                    </div>
                    <div id="divChart" runat="server" class ="col-md-12 col-lg-5  text-center  hidden-sm hidden-xs">
                        <br /><b>Employee Cost Allocation</b><br />
                        <asp:Chart ID="pieChart" runat="server" BackColor="#EFF3FB" BorderSkin-SkinStyle="None" Palette="BrightPastel" >
                            <Series>
                                <asp:Series Name="chartSeries" ChartType="Pie" ChartArea="MainArea" IsValueShownAsLabel="false" Label="#PERCENT" Legend="Legend1">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="MainArea" BackColor=" #EFF3FB" Area3DStyle-Enable3D="true" Area3DStyle-Inclination="40" Area3DStyle-IsClustered="false" >
                                    <Area3DStyle Enable3D="True" Inclination="40"></Area3DStyle>
                                </asp:ChartArea>
                            </ChartAreas>
                            <Legends>
                                <asp:Legend Name="Legend1" BackColor=" #EFF3FB">
                                </asp:Legend>
                            </Legends>

                        </asp:Chart>
                        <div class="text-muted center">
                            <i>Move cursor over chart to see plans</i>
                        </div>
                    </div>
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
        .HRENext {padding:5px 5px 5px 5px; float:right; min-width:50px; max-width:90px; }
        .img {display: inline-block; width: auto; height: auto;}
    </style>

</asp:Content>

<asp:Content ID="SideMenu1" ContentPlaceHolderID="SideMenu1" runat="Server">
    <div class="HREwrapper">              
        <div id="divNextButton" runat="server" class="hidden-xs">
            <asp:ImageButton ID="imgNext" runat="server" class="HRENext" ToolTip="NEXT" ImageUrl="../img/NextArrowInCircleBlueGreenTP.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreenTP.png';" OnClick="imgNext_Click" />
        </div>

        <div id="divProcessing" runat="server" visible="false">
            <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Width="100%" />
        </div>

        <div id="divNameandImage" style="padding-top:10%;">
            <h4>
                <asp:Label ID="lblEmployeeName" runat="server" Text=""></asp:Label>
            </h4>
            <div class="col-md-3 col-lg-3">
                <img id="imgProfilePic" runat="server" src="images/default_person.jpg" width="56" alt="" />
            </div>
        </div>
        
        <div id="divAddress" class="col-md-9 col-lg-9 ">
            <div class="row">
                <asp:Label ID="lblAddress" runat="server" class=" control-label"></asp:Label>
            </div>
            <div class="row">
                <asp:Label ID="lblAddress2" runat="server" class=" control-label"></asp:Label>
            </div>
            <div class="row">
                <asp:Label ID="lblCity" runat="server" class=" control-label"></asp:Label>
                <asp:Label ID="lblState" runat="server" class=" control-label"></asp:Label>
                &nbsp
                <asp:Label ID="lblZip" runat="server" class=" control-label"></asp:Label>
                &nbsp
            </div>
            <div class="row">
                <asp:Label ID="lblPhone" runat="server" class=" control-label"></asp:Label>
            </div>
            <div class="row">
                <asp:Label ID="lblEmail" runat="server" class=" control-label"></asp:Label>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-12 col-lg-12 text-center">
                <br />
                <asp:ImageButton ID="btnEditProfile" runat="server" ImageUrl="img/BlueEditBtnNew.png" OnMouseOver="src='/img/BlueEditBtnOverNew.png';" OnMouseOut="src='/img/BlueEditBtnNew.png';" ImageAlign="AbsMiddle" PostBackUrl="~/EE_Profile.aspx" Width="70px"/>
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
        .HRENext {padding:15px 5px 5px 5px; float:right; min-width:50px; max-width:90px; }
        .img {display: inline-block; width: auto; height: auto;}
    </style>
</asp:Content>

<asp:Content ID="Benefit" ContentPlaceHolderID="Benefit" runat="Server">
    <div class="HREwrapper" >
            <div id="divDependents" runat="server">
                <div class="row">
                    <h4>Relationships</h4>
                </div>
                <div class="row">
                    <div class="col-md-3 col-lg-3">
                        <img src="images/default_deps.png" width="60" alt="" />
                    </div>
                    <div class="col-md-9 HREwrapper">
                        <asp:GridView ID="grdDependents" runat="server" DataKeyField="DepBenId" AutoGenerateColumns="false" Width="95%" HeaderStyle-CssClass="grdNormalrow" EmptyDataRowStyle-CssClass="grdNormalrow" GridLines="None" BorderColor="#3276B1">
                            <Columns>
                                <asp:BoundField DataField="DepBenId" Visible="false"></asp:BoundField>
                                <asp:BoundField DataField="DependentName"></asp:BoundField>
                                <asp:BoundField DataField="Relationship"></asp:BoundField>
                            </Columns>
                            <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                            <EmptyDataTemplate>
                                No Dependents, Beneficiaries, or Emergency Contacts on record
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 col-lg-12 text-center">
                        <br />
                        <asp:ImageButton ID="btnEditDeps" runat="server" ImageUrl="img/BlueEditBtnNew.png" OnMouseOver="src='/img/BlueEditBtnOverNew.png';" OnMouseOut="src='/img/BlueEditBtnNew.png';" ImageAlign="AbsMiddle" PostBackUrl="~/EE_DepBen.aspx" Width="70px" />
                    </div>
                </div>
            </div>
          
    </div>
    <style>
        .HREwrapper {margin-left: 5%; margin-right: 5%; }
    </style>
</asp:Content>



