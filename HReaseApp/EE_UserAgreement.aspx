<%@ Page Title="User Agreement on Login" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_UserAgreement.aspx.vb" 
    Inherits="HReaseApp.EE_UserAgreement"
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" Runat="Server">
    <div class="HREwrapper">
        
        <div id="divPageTitle" >
            <div>
                <br />
                <h4><b>User Agreement</b></h4>
            </div>
        </div>

        <div id="divTopHeader" class="form-group "> 
            <%--Note that the error section is below for this form--%>
            <div id="divSuccess" runat="server" visible ="false" style="vertical-align:middle; display:inline;">
                <div style="float:left;">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" />
                </div>
                <div id="divSuccessLabel" style="text-align:center; color:green; font-size:x-large;">
                    <b><asp:Label ID="lblSuccess" runat="server" Text="Form Complete"></asp:Label></b>
                </div>
                <div id="divNextButton" style="float:right; margin-top:-3%;" >
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" Width="50%" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                </div>
            </div>
            <div id="divProcessing" runat="server" visible="false">
                <div class="fixed">
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Width="100%" />
                </div>
            </div>
        </div>           
      
        <div id="divMainArticalTitleandText" class="well ">
            <div id="divTitle" runat="server" class="form-group HRESlateBlue">
                    <h4><asp:Label ID="lblMainArticleTitle" runat="server" Text=""></asp:Label></h4>           
            </div>
            <div id="divText" runat="server" class="form-group HREWhite" >
                    <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div>

        <div id="divSignatureAndDate" class="well HREWhite HRERewrap">
            <div id="divSignatureLine" class="form-group" style="padding-top:10px;">
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
        
        <div id="divError" runat="server" visible ="false" style="vertical-align:middle; display:inline;">
            <b><span style="color: red;">   
                    <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" border="none" Width="50px" />
                    &nbsp;&nbsp;
                    <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
                </span></b>
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
        .HRENext {padding:5px 5px 5px 15px; float:right; min-width:50px; max-width:90px; }
        .img {display: inline-block; width: auto; height: auto;}
    </style>
</asp:Content>


