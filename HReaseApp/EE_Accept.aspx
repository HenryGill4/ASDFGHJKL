<%@ Page Title="Benefits Accept" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeaderSplit.Master" 
    CodeBehind="EE_Accept.aspx.vb" 
    Inherits="HReaseApp.EE_Accept" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainBlock" runat="Server">
     <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>Benefit Elections Acceptance</b></h4>
            </div>
        </div>

        <div id="divTopHeader" class="form-group">                  
            <div id="divError" runat="server" visible ="false" style="vertical-align:middle; display:inline; padding-left:50px;">
                <div style="float:left;">
                    <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="50px" />
                </div>
                <br /><br />
                <div id="divErrorLabel" style="text-align:left; color:red; font-size:large; padding-left:20px;">
                    <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
                </div>
            </div>
            <div id="divSuccess" runat="server" visible ="false" style="vertical-align:middle; display:inline; padding-left:50px;">
                <div style="float:left;">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" />
                </div>
                <div id="divSuccessLabel" style="text-align:center; color:green; font-size:x-large;">
                    <b><asp:Label ID="lblSuccess" runat="server" Text="Your Election Process is Complete"></asp:Label></b>
                </div>
            </div>
        </div> 

        <div id="divMainArticalTitleandText" runat="server" class="well HRESlateBlue">
            <div id="divTitle" runat="server" class="form-group HRESlateBlue">
                    <h4><asp:Label ID="lblMainArticleTitle" runat="server" Text=""></asp:Label></h4>           
            </div>
            <div id="divText" runat="server" class="form-group HREWhite" >
                    <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div>

        <div id="divSignatureAndDate" runat="server" class="well HREWhite">
            <div id="divSignatureLine" class="form-group" style="padding-top:20px;">
                <asp:Label ID="lblSignature" runat="server" Visible="true" Text="Employee Signature:" for="txtSignature" class="col-sm-2 text-right control-label"></asp:Label>
                <div class="col-sm-3">
                    <asp:TextBox ID="txtSignature" runat="server"  Visible="true" CssClass="form-control"></asp:TextBox>
                </div>
                <asp:Label ID="lblSignatureDate" runat="server"  Visible="true" Text="Date:" for="txtSignatureDate" class="col-sm-1 text-right control-label"></asp:Label>
                <div class="col-sm-3">
                    <asp:TextBox ID="txtSignatureDate" runat="server"  Visible="true" CssClass="form-control"></asp:TextBox>
                </div>   
                <div class="form-group HREpadR10">
                    <asp:ImageButton ID="btnAccept" runat="server" ImageUrl="../img/GreenAcceptBtnNew.png" OnMouseOver="src='/img/GreenAcceptBtnOverNew.png';" OnMouseOut="src='/img/GreenAcceptBtnNew.png';"  BorderStyle="None"  Onclick="btnAccept_Click" />
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
        <div id="divNextButton" runat="server" class="hidden-xs" style="margin-top:20px;">
            <asp:ImageButton ID="imgNext" runat="server" class="HRENext" ToolTip="NEXT" ImageUrl="../img/NextArrowInCircleBlueGreenTP.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreenTP.png';" OnClick="imgNext_Click" />
        </div>

        <div id="divProcessing" runat="server" visible="false">
            <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Width="100%" />
        </div>

        <div id="divProgressBarSection" runat="server" class="col-md-12 text-info text-center" style="background-color:white;">
            <span class="text-success">% Complete</span>
            <div class="progress-striped progress-bar-info active">  
                <div id="divProgressBar" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="10" aria-valuemax="100" style="width: 0%" runat="server">
                    <strong><asp:Label ID="lblProgress" Text="" runat="server"></asp:Label></strong>
                </div>
            </div>
        </div>

        <div id="divSummary" runat="server" class="well HREWhite" style="border:none;">
            <h4 style="float:left;">Contribution Summary</h4> 
            <b style="float:right; margin-right:25%;"><asp:Label ID="lblPayFrequency2" runat="server" CssClass="text-muted center small" Text="All Costs shown per pay period"></asp:Label></b>
            <div class="row" >
                <div class="col-md-12">             
                    <asp:GridView ID="grdSummary" runat="server"  AutoGenerateColumns="false" Width="75%" HeaderStyle-CssClass="text-success" BorderStyle="None">
                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                        <Columns>
                            <asp:BoundField HeaderText="Plan Type" DataField="PlanTypeShortDesc"></asp:BoundField>
                            <asp:BoundField HeaderText="EE Cost" DataField="EECost" DataFormatString="{0:c}" HtmlEncode="False" ItemStyle-cssClass="text-right" HeaderStyle-CSSClass="center"></asp:BoundField>
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
        ul li {color:black;}
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

<asp:Content ID="Dependents" ContentPlaceHolderID="Benefit" runat="Server" >
    <div id="divCalculator" runat="server" class="form-group">
        <h4 style="float:left; color:midnightblue">Total Employee Contribution </h4>
        <h4 style="color:midnightblue"><b><asp:Label ID="lblSum" runat="server" Text="" ></asp:Label></b></h4>
    </div>

</asp:Content>

 <asp:Content ID="Client" ContentPlaceHolderID="Client" runat="Server">
  </asp:Content>



