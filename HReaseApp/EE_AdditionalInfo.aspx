<%@ Page Title="Additional Info" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_AdditionalInfo.aspx.vb" 
    Inherits="HReaseApp.EE_AdditionalInfo" %>

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
        <div id="PageTitle" class="center" style="padding-top:20px; padding-bottom:20px;">
            <div>
                <h4><b>Additional Information</b></h4>
            </div>
        </div>

        <div id="DivTopHeader" class="form-group" >                  
            <div class="form-group" style="display:inline;">
                <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
            </div>
        </div> 

        <div id="divMainArticalTitleandText" runat="server" class="HRESlateBlue HRERewrap" style="margin-top:-90px;">
            <div id ="DivMainArticleTitle">
                <b><asp:Label ID="lblMainArticleTitle" runat="server" /></b>
            </div>
            <div id="DivMainArticleText" runat="server" class="HREWhite" >
                <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div>
  
        <div id="DivCol1" class="col-xs-12 col-sm-12 col-md-4 col-lg-4 center">
            <div id="LeftDocument1" runat="server">
                <h3>
                    <asp:Label ID="lblLeftDocument1Title" runat="server"></asp:Label></h3>
                    <asp:Repeater ID="ddlLeftDocument1" runat="server">
                        <HeaderTemplate > 
                            <table >
                        </HeaderTemplate>
                        <ItemTemplate >
                            <tr >
                                <td>
                                    <%# Container.DataItem("DocumentName")%>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate >
                            </table>
                        </FooterTemplate>
            </asp:Repeater> 
            </div>

            <div id="LeftDocument2" runat="server">
                <h3>
                <asp:Label ID="lblLeftDocument2Title" runat="server"></asp:Label></h3>
                <asp:Repeater ID="ddlLeftDocument2" runat="server">
                    <HeaderTemplate > <table ></HeaderTemplate>
                    <ItemTemplate >
                        <tr >
                            <td>
                            <%# Container.DataItem("DocumentName")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate ></table></FooterTemplate>
                </asp:Repeater>
            </div>

            <div id="LeftDocument3" runat="server">
                <h3>
                <asp:Label ID="lblLeftDocument3Title" runat="server"></asp:Label></h3>
                    <asp:Repeater ID="ddlLeftDocument3" runat="server">
                    <HeaderTemplate > <table ></HeaderTemplate>
                    <ItemTemplate >
                        <tr>
                            <td>
                            <%# Container.DataItem("DocumentName")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate ></table></FooterTemplate>
                    </asp:Repeater>
            </div>
        </div>

        <div id="DivCol2" class="col-xs-12 col-sm-12 col-md-4 col-lg-4" style="padding-left:70px;">
            <div id="MiddleColumnDoc1" runat="server">
                <h3>
                <asp:Label ID="lblRightDocument1Title" runat="server"></asp:Label></h3>
                <asp:Repeater ID="ddlRightDocument1" runat="server">
                    <HeaderTemplate > <table ></HeaderTemplate>
                    <ItemTemplate >
                        <tr ><td>
                            <%# Container.DataItem("DocumentName")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate ></table></FooterTemplate>
                </asp:Repeater>
            </div>

            <div id="MiddleColumnDoc2" runat="server">
                <h3> <asp:Label ID="lblRightDocument2Title" runat="server"></asp:Label></h3>
                <asp:Repeater ID="ddlRightDocument2" runat="server">
                    <HeaderTemplate > <table></HeaderTemplate>
                    <ItemTemplate >
                        <tr >
                            <td>
                            <%# Container.DataItem("DocumentName")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate ></table></FooterTemplate>
                </asp:Repeater>
            </div>
            
            <div id="MiddleColumnDoc3" runat="server">
                <h3> <asp:Label ID="lblRightDocument3Title" runat="server"></asp:Label></h3>
                <asp:Repeater ID="ddlRightDocument3" runat="server">
                    <HeaderTemplate > <table ></HeaderTemplate>
                    <ItemTemplate >
                        <tr >
                            <td>
                            <%# Container.DataItem("DocumentName")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate ></table></FooterTemplate>
                </asp:Repeater>
            </div>
        </div>

        <div id="DivCol3" class="col-xs-12 col-sm-12 col-md-4 col-lg-4 center">
            <div id="RightColumnDoc1" runat="server">
                <h3><asp:Label ID="lblSideMenu1Title" runat="server"></asp:Label></h3>
                <br />
                <asp:Label ID="lblSideMenu1text" runat="server"></asp:Label>                
            </div>
            <div id="RightColumnDoc2" runat="server">
                <h3><asp:Label ID="lblSideMenu2Title" runat="server"></asp:Label></h3>
                <br />
                <asp:Label ID="lblSideMenu2text" runat="server"></asp:Label>                
            </div>
            <div id="RightColumnDoc3" runat="server">
                <h3><asp:Label ID="lblSideMenu3Title" runat="server"></asp:Label></h3>
                <br />
                <asp:Label ID="lblSideMenu3text" runat="server"></asp:Label>                
            </div>
        </div>         
        
        <div id="DivAcceptButton" class="col-md-12">
            <asp:ImageButton ID="btnAccept" ImageUrl="../img/BlueMoreBtn.png" runat="server" ImageAlign="Right" Visible="false" OnMouseOver="src='/img/BlueMoreBtnOver.png';" OnMouseOut="src='/img/BlueMoreBtn.png';" data-toggle="modal" data-target="#News3" onclientclick="return false" ></asp:ImageButton>
        </div>
    </div>

    <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }
        table {background-color:white;}
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

                <%--End of Menu Block--%>




