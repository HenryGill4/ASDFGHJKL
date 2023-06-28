<%@ Page Title="VM Complete4" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="VMComplete.aspx.vb" 
    Inherits="HReaseApp.VMComplete"
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<%--<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>--%>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" Runat="Server">
    <div class="HREwrapper">
        
        <%--<div id="divPageTitle" class="HRERewrap" >
            <div class =" center">
                <br />
                <h4><b>Vaccine Policy</b></h4>
            </div>
        </div>--%>

        <div id="divTopHeader" class="form-group HRERewrap"> 
            <%--Note that the error section is below for this form--%>
            <div id="SuccessSectionDiv" runat="server" visible ="false" style="vertical-align:middle; display:inline; ">
                <div style="float:left; padding-top:10px;">
                    <asp:Image id="SuccessImage" ImageUrl="../img/GreenCheck.png" runat="server" Width="30px" />
                </div>
                <div id="SuccessDiv" style="text-align:center; color:green; font-size:large;padding-top:10px;">
                    <b><asp:Label ID="SuccessLabel" runat="server" Text="Complete"></asp:Label></b>
                </div>
                <%--<div id="NextButtonDiv" style="float:right;" >
                    <asp:ImageButton ID="NextImage" runat="server" Visible="false" ToolTip="NEXT" Width="50%" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="NextImage_Click" />
                </div>--%>
            </div>
            <%--<div id="ProcessingDiv" runat="server" visible="false">
                <div class="fixed">
                    <asp:Image ID="ProcessingImage" runat="server" src='/img/processing.gif' Width="100%" />
                </div>
            </div>--%>
        </div>           
      
        <div id="MainArticalTitleandTextDiv" class="well HRERewrap">
            <div id="TitleDiv" runat="server" class="form-group HRESlateBlue">
                    <h4><asp:Label ID="MainArticleTitleLabel" runat="server" Text=""></asp:Label></h4>           
            </div>
            <div id="TextDiv" runat="server" class="form-group HREWhite" style="margin-left:-25px; max-height: 320px; overflow-y: scroll;">
                    <asp:Label ID="MainArticleTextLabel" runat="server"></asp:Label>
            </div>
        </div>

        <%--<div id="SignatureAndDateDiv" class="form-group HREWhite HRERewrap">
            <div style="color:red; font-size:small; padding-left:20px;">
                Please enter full name and date below as acknowledgment that you have read and understand the above:
            </div>
            <div id="SignatureLineDiv" style="padding-top:20px; font-size:medium;">
                <asp:Label ID="SignatureLabel" runat="server" Visible="true" Text="Employee Signature:" for="SignatureText" class="col-sm-2 text-right"></asp:Label>
                <div class="col-sm-3" >
                    <asp:TextBox ID="SignatureText" runat="server" Visible="true" CssClass="form-control" ></asp:TextBox>
                </div>
                <asp:Label ID="SignatureDateDiv" runat="server"  Visible="true" Text="Date:" for="SignatureDate" class="col-sm-1 text-right control-label"></asp:Label>
                <div class="col-sm-3" style="padding-bottom:5px;">
                    <asp:TextBox ID="SignatureDateText" runat="server"  Visible="true" CssClass="form-control"></asp:TextBox>
                </div>   
                <div class="form-group HREpadR10" >
                    <asp:ImageButton ID="AcceptButton" runat="server" ImageUrl="../img/GreenAcceptBtnNew.png" OnMouseOver="src='/img/GreenAcceptBtnOverNew.png';" OnMouseOut="src='/img/GreenAcceptBtnNew.png';"  BorderStyle="None"  OnClick="AcceptButton_Click" />
                </div>
            </div>
        </div> --%>
        
        <div id="ErrorDiv" runat="server" visible ="false" style="vertical-align:middle; display:inline;">
            <b><span style="color: red;">   
                    <asp:Image ID="ErrorImage" ImageUrl="../img/RedX.png" runat="server" border="none" Width="50px" />
                    &nbsp;&nbsp;
                    <asp:Label ID="ErrorLabel" runat="server" Text="There was an error."></asp:Label>
                </span></b>
        </div>
            

    </div>    
    <style>
        input[type=text], textarea {outline: none; font-size:medium; vertical-align:middle; min-height: 40px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
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


