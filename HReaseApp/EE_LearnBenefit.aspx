<%@ Page Title="EE Link to Documents from Benefits Learn by PlanType" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_LearnBenefit.aspx.vb" 
    Inherits="HReaseApp.EE_LearnBenefit"
    MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
    <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainArticle" Runat="Server" >
     <div class="HREwrapper">
        <div id="divPageTitle" >
            <div>
                <br />
                <h4><b>Benefit Documents</b></h4>
            </div>
        </div>

        <div id="divTopHeader" class="form-group" style=" margin-top:-40px;">                  
            <div id="divError" runat="server" visible="false" class="HREError">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
            </div>
            <div class="form-group" style="display:inline;">
                <div id="divSuccess" runat="server" visible ="true" class="HRESuccess">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" Visible="false" runat="server" Width="50px" ImageAlign="Left" />
                    <asp:Label ID="lblSuccess" runat="server"  Text="Form Complete" Visible="false" Width="50%"></asp:Label>
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
                </div>
            </div>
        </div>   

        <div id="divMainArticalTitleandText" runat="server" class="well HRESlateBlue HRERewrap">
            <div id="divTitle" runat="server" class="form-group HRESlateBlue">
                    <h4><asp:Label ID="lblMainArticleTitle" runat="server" Text=""></asp:Label></h4>           
            </div>
            <div id="divText" runat="server" class="form-group HREWhite" >
                    <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div>

        <div id="divcol1" class="col1" >
             <div class="item itemOdd" id="LeftDocument1" runat="server" style="float:left; margin-top:-30px;">
                <h4><asp:Label ID="lblLeftDocument1Title" runat="server"></asp:Label></h4>
                <asp:Repeater ID="ddlLeftDocument1" runat="server">
                    <HeaderTemplate>
                        <table class="tablewhite">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <%# Container.DataItem("DocumentName")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate></table></FooterTemplate>
                </asp:Repeater>
            </div>

            <div class="item" id="LeftDocument2" runat="server" style="float:left;">
                <h4><asp:Label ID="lblLeftDocument2Title" runat="server"></asp:Label></h4>
                <asp:Repeater ID="ddlLeftDocument2" runat="server">
                    <HeaderTemplate>
                        <table class="tablewhite">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <%# Container.DataItem("DocumentName")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate></table></FooterTemplate>
                </asp:Repeater>
            </div>
        </div>

        <div id="divcol2" class="col2" style="float:right; width:50%;">
            <div class="item" id="RightDocument1" runat="server">
                <h4><asp:Label ID="lblRightDocument1Title" runat="server"></asp:Label></h4>
                <asp:Repeater ID="ddlRightDocument1" runat="server">
                    <HeaderTemplate>
                        <table class="tablewhite">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <%# Container.DataItem("DocumentName")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <div id="RightDocument2" class="item HRERewrap" runat="server">
                <h4><asp:Label ID="lblRightDocument2Title" runat="server" ></asp:Label></h4>
                <asp:Repeater ID="ddlRightDocument2" runat="server">
                    <HeaderTemplate>
                        <table class="tablewhite">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <%# Container.DataItem("DocumentName")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate></table></FooterTemplate>
                </asp:Repeater>
            </div>
           
        </div> 
    </div>
    <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
    </style>
</asp:Content>


