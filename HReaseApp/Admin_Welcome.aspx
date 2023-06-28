<%@ Page Title="Administrator Welcome Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeaderSplit.Master" 
    CodeBehind="Admin_Welcome.aspx.vb" 
    Inherits="HReaseApp.Admin_Welcome" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
    <p>
        <br />
        <br />
    </p>

    
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainBlock" Runat="Server">   
    <script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" rel="stylesheet" />
    <style>
        .chosen-container{
            min-width: 300px !important;
            max-width:600px !important; 
            width:50% !important;
        }
        .chosen-single span{
            font-size: 14px !important;
        }       
        
    </style>
    


        <div id="divPageTitle">
            <div >
                <br />
                <h4><b>Administrator Dashboard</b></h4>
            </div>
        </div>
        
        <div id="divTopHeader" runat="server">   
            <div id="divCompanyList" runat="server" class="well HRESlateBlue form-inline">
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
        
        <div id="divWelcomeMessage" class="grid-container">
            <div id="divAlert" runat="server" visible="true" class="grid-item">
                
                    <h4>Administrator Messages</h4>
                    <asp:Label ID="lblAlertTitle" runat="server" CssClass="h1Error"></asp:Label>
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
    
        <div id="divChartArea" runat="server" class="grid-container">

    <div class="grid-item">
        <h4>Demographic Breakdown</h4>
                <div id="divLineChart" runat="server" >
                   <asp:Chart ID="Chart1" runat="server" Width="500px" Height="400px" AntiAliasing="All" AlternateText="No Company Information Available" BorderlineWidth="0" CssClass="chart" Pallet="Excel" >
                       <Series>
                           <asp:Series ChartType="StackedBar" Name="TotalEmployees" ChartArea="ChartArea1" Color="#336699">
                           </asp:Series>
                           <asp:Series ChartType="StackedBar" Name="Eligible" ChartArea="ChartArea1" Color="#f5f5f0">
                           </asp:Series>
                           <asp:Series ChartType="StackedBar" Name="NonEligible" ChartArea="ChartArea1" Color="#878f99">
                           </asp:Series>
                           <asp:Series ChartType="StackedBar" Name="Benefits" ChartArea="ChartArea1" Color="#6b5b95" LabelFormat="">
                           </asp:Series>
                           <asp:Series ChartType="StackedBar" Name="NoBenefits" ChartArea="ChartArea1" Color="#EFF3FB">
                           </asp:Series>
                           <asp:Series ChartType="StackedBar" Name="Medical" ChartArea="ChartArea1" Color="#344A74">
                           </asp:Series>
                           <asp:Series ChartType="StackedBar" Name="Other" ChartArea="ChartArea1" Color="#ccd5e4">
                           </asp:Series>
                       </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" BackColor="white" BorderColor="#EFF3FB" ShadowColor="#EFF3FB"   >
                                <Area3DStyle Enable3D="true" PointDepth="20" PointGapDepth="0" WallWidth="0" Inclination="45" Rotation="25" LightStyle="Realistic" />
                                <AxisX Enabled="false" IsMarginVisible="False" IsMarksNextToAxis="False" LineColor="black">
                                    <MajorGrid Enabled="true" />
                                </AxisX>
                                <AxisY Enabled="False">
                                    <MajorGrid Enabled="false" />
                                </AxisY>
                            </asp:ChartArea>
                        </ChartAreas>
                        <BorderSkin BorderColor="Transparent" BorderWidth="0" />
                    </asp:Chart>
                </div>
            </div>
            <div class="grid-item">
        <h4>Election Summary</h4>
                <asp:Chart ID="Chart2" runat="server"  Width="500px" Height="400px" AntiAliasing="All" CssClass="chart" BackColor="white" BorderSkin-SkinStyle="None" PaletteCustomColors="DarkBlue; LightGray; LightSteelBlue; Tan; SlateGray; DarkSlateBlue; CornflowerBlue; WhiteSmoke; Gray; LightBlue; DarkSalmon; Lavender; Navy; PaleTurquoise; CadetBlue; Beige; Silver; Azure; MediumPurple; Honeydew; SteelBlue; AntiqueWhite; RosyBrown; Thistle">
    <Series>
        <asp:Series Name="Series1" ChartType="Doughnut" IsValueShownAsLabel="True" Legend="Legend1" Palette="None"></asp:Series>
    </Series>
    <ChartAreas>
        <asp:ChartArea Name="ChartArea1" BackColor="white" BorderColor="#EFF3FB" ShadowColor="White">
            <Area3DStyle Enable3D="true" PointDepth="50" PointGapDepth="0" WallWidth="0" Inclination="0" Rotation="0" LightStyle="Realistic"/>
            <AxisX Title ="Plan Types" IsMarksNextToAxis="true" LineColor="black" >
                    <MajorGrid Enabled="false" />
            </AxisX>
            <AxisY Title="# of Elections" TextOrientation="Rotated270" LineColor="White"  IsMarksNextToAxis="true" InterlacedColor="Gray" >
                    <MajorGrid Enabled="false" />
            </AxisY>
        </asp:ChartArea>
    </ChartAreas>
    <Legends>
        <asp:Legend Name="Legend1" BackColor="white" BorderColor="#404040">
        </asp:Legend>
    </Legends>
    <BorderSkin BorderColor="Transparent" BorderWidth="0" />
</asp:Chart>
                    <%--<asp:Chart ID="pieChart" runat="server" BackColor="#EFF3FB" BorderSkin-SkinStyle="None" Palette="BrightPastel" >--%>
                            <%--<Series>
                                <asp:Series Name="Series1" ChartType="Doughnut" ChartArea="MainArea" IsValueShownAsLabel="false" Label="COUNT" Legend="Legend1">
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

                        </asp:Chart>--%>
            </div>
        </div>
          
</asp:Content>

<asp:Content ID="SideMenu1" ContentPlaceHolderID="SideMenu1" runat="Server">
    <div class="HREwrapper">
        <div id="divNextButton" runat="server" class="hidden-xs" >
            <asp:ImageButton ID="imgNext" runat="server" class="HRENext" ToolTip="NEXT" ImageUrl="../img/NextArrowInCircleBlueGreenTP.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreenTP.png';" OnClick="imgNext_Click" />
        </div>

        <div id="divProcessing" runat="server" visible="false">
            <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Width="100%" />
        </div>

        <div id="divCompanyInfo" style="margin-top:40px; margin-left: 10px;">
             <h4> Company Address:</h4>  
            <div style="margin-left:40px;padding-bottom:10px;">
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
                <div class="col-md-10 text-center">
                    <asp:ImageButton ID="btnEditAddress" runat="server"  width="75px" ImageUrl="img/BlueEditBtn.png" OnMouseOver="src='/img/BlueEditBtnOver.png';" OnMouseOut="src='/img/BlueEditBtn.png';" ImageAlign="AbsMiddle" PostBackUrl="~/Admin_CompanyContact.aspx" Visible="false" />
                </div>
            </div>   

            <h4>Company Contact:</h4>
            <div style="margin-left:40px;padding-bottom:10px;">
                <div class="row">
                    <asp:Label ID="lblContactName" runat="server" class=" control-label" Text="Contact Name"></asp:Label>
                </div>
                <div class="row">
                    <asp:Label ID="lblContactPhone" runat="server" class=" control-label" Text="Contact Phone"></asp:Label>
                </div>
                <div class="row">
                    <asp:Label ID="lblContactEmail" runat="server" class=" control-label" Text="Contact Email"></asp:Label>                       
                </div>                    
            </div>
            <div class="row">
                <div class="col-md-10 text-center">
                    <asp:ImageButton ID="btnEditContact" runat="server" width="75px"  ImageUrl="img/BlueEditBtn.png" OnMouseOver="src='/img/BlueEditBtnOver.png';" OnMouseOut="src='/img/BlueEditBtn.png';" ImageAlign="AbsMiddle" PostBackUrl="~/admin_companyadminselect.aspx" Visible="false" />
                </div>
            </div>

            <h4 style="display: inline-block;">Initial Enrollment Rules:</h4>
            <div style="margin-left:35px;padding-bottom:10px;">
                <div class="row">
                    Days Before:  &nbsp; <asp:Label ID="lblIEPre" runat="server" class=" control-label text-info"></asp:Label>
                </div>
                <div class="row">
                    Days After: &nbsp; &nbsp;&nbsp;&nbsp; <asp:Label ID="lblIEPost" runat="server" class=" control-label text-info"></asp:Label>
                </div>
                   
            </div>
            <div class="row">
                <div class="col-md-10 text-center">
                    <asp:ImageButton ID="btnEditIE" runat="server" width="75px"  ImageUrl="img/BlueEditBtn.png" OnMouseOver="src='/img/BlueEditBtnOver.png';" OnMouseOut="src='/img/BlueEditBtn.png';" ImageAlign="AbsMiddle" PostBackUrl="~/Admin_CompanyBusinessRules.aspx" Visible="false"  />
                </div>
            </div>
    
            <h4 style="display: inline-block;">Open Enrollment Rules:</h4>
            <div style="margin-left:35px;padding-bottom:10px;">
                <div class="row">
                    OE Period Begin:  &nbsp; 
                    <asp:Label ID="lblOEBegin" runat="server" class=" control-label text-info"></asp:Label>
                </div>
                <div class="row">
                    OE Period End: &nbsp; &nbsp;&nbsp;&nbsp;<asp:Label ID="lblOEEnd" runat="server" class=" control-label text-info"></asp:Label>
                </div>
                <div class="row">
                    OE Effective Date:&nbsp;&nbsp;<asp:Label ID="lblOEEffective" runat="server" class=" control-label text-info"></asp:Label>
                </div>

            </div>
            <div class="row">
                <div class="col-md-10 text-center">
                    <asp:ImageButton ID="btnEditOE" runat="server" Width="75px" ImageUrl="img/BlueEditBtn.png" OnMouseOver="src='/img/BlueEditBtnOver.png';" OnMouseOut="src='/img/BlueEditBtn.png';" ImageAlign="AbsMiddle" PostBackUrl="~/Admin_CompanyBusinessRules.aspx" Visible="false" />
                </div>
            </div>
        </div>
    </div>
    <style>
        @media screen and (max-width: 500px) {
    .chart {
        width: 100% !important; 
        height: auto !important;
    }
}
        @media screen and (min-width: 500px) {
    .chart {
        width: 100% !important; 
        height: auto !important;
    }
}
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; display:inline-block;}
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px 10px 10px 10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HRENext {padding:5px 5px 5px 5px; min-width:50px; max-width:90px; position:relative; top:55px; margin-bottom:50px;}
        .img {display: inline-block; width: auto; height: auto;}
        .MainArticle{
            display: inline-block;
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
    box-shadow: 0px 10px 15px -3px rgba(0, 0, 0, 0.1), 
                0px 4px 6px -2px rgba(0, 0, 0, 0.05);
    transition: all 0.2s ease-in-out;
}

.grid-item:hover {
    transform: scale(1.02);
    box-shadow: 0px 20px 25px -5px rgba(0, 0, 0, 0.1), 
                0px 10px 10px -5px rgba(0, 0, 0, 0.04);
}

    </style>
</asp:Content>

<asp:Content ID="Benefit" ContentPlaceHolderID="Benefit" runat="Server">
    </asp:Content>

<asp:Content ID="Client" ContentPlaceHolderID="Client" runat="Server">
    </asp:Content>



