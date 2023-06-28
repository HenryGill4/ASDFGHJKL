<%@ Page Title="Acknowledgement 9" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_Acknowledgement9.aspx.vb" 
    Inherits="HReaseApp.EE_Acknowledgement9" %>

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
        <div id="DivPageTitle" class="col-md-12 center" style="padding-top:20px;">
            <h4>
                    <b><asp:Label ID="lblMainArticleTitle" runat="server" /></b>
                </h4>
        </div>

        <div id="DivTopHeader" class="form-group" >                  
            <div id="DivError" runat="server" visible="false" class="HREError" style="height:auto;">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
            </div>
            <div class="form-group" style="display:inline;">
                <div id="DivSuccess" runat="server" visible ="false" class="HRESuccess">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" ImageAlign="Left" />
                    <asp:Label ID="lblSuccess" runat="server"  Text="Form Complete" Width="50%"></asp:Label>
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
                </div>
            </div>
        </div> 

        <div id="divMainArticalTitleandText" runat="server" class="HRESlateBlue HRERewrap">
            <div id="divText" runat="server" class="HREWhite" >
                <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div>

        <div id="divSignatureAndDate" class="well HREWhite HRERewrap">
            <div id="divSignatureLine" class="form-group" style="padding-top:10px; margin-bottom:-10px;">
                <asp:Label ID="lblSignature" runat="server" Visible="true" Text="Employee Signature:" for="txtSignature" class="col-sm-2 text-right control-label"></asp:Label>
                <div class="col-sm-3">
                    <asp:TextBox ID="txtSignature" runat="server"  Visible="true" CssClass="form-control"></asp:TextBox>
                </div>
                <asp:Label ID="lblSignatureDate" runat="server"  Visible="true" Text="Date:" for="txtSignatureDate" class="col-sm-1 text-right control-label"></asp:Label>
                <div class="col-sm-3">
                    <asp:TextBox ID="txtSignatureDate" runat="server"  Visible="true" CssClass="form-control"></asp:TextBox>
                </div>   
                <div class="form-group HREpadR10" style="padding-top:5px;">
                    <asp:ImageButton ID="btnAccept" runat="server" ImageUrl="../img/GreenAcceptBtnNew.png" OnMouseOver="src='/img/GreenAcceptBtnOverNew.png';" OnMouseOut="src='/img/GreenAcceptBtnNew.png';"  BorderStyle="None"  Onclick="btnAccept_Click" />
                </div>
            </div>
        </div>    
    
    </div> 
    
    <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; padding: 10px 10px 10px 10px;}
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px 10px 10px 10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HRENext {padding:5px 5px 5px 5px; float:right; min-width:50px; max-width:90px; }
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
        .img {display: inline-block; width: auto; height: auto;}
    </style>
</asp:Content>



