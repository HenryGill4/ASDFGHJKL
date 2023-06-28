<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AppMasterHeader.Master" CodeBehind="EE_ContactUs.aspx.vb" Inherits="HReaseApp.EE_ContactUs" %>


<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>   
    </div> 
</asp:Content>


<asp:Content ID="MainBlock" ContentPlaceHolderID="MainArticle" Runat="Server">    
    <div class="item mainItem">
         <h3><asp:label id="lblMainArticleTitle" runat="server" ></asp:label> </h3>
         <p class="info"> <asp:label id="lblMainArticledate" CssClass ="date" runat="server" ></asp:label> </p>
            <div class="container well-success">
                <asp:label id="lblMainArticleText" runat="server" > </asp:label>
            </div>   
    </div>
     <div class="col1">
         <div class="item itemOdd" id="LeftDocument1" runat="server">
             <h3>
                 <asp:Label ID="lblLeftDocument1Title" runat="server"></asp:Label></h3>
                 <asp:Repeater ID="ddlLeftDocument1" runat="server">
                    <HeaderTemplate > <table ></HeaderTemplate>
                     <ItemTemplate >
                        <tr ><td>
                            <%# Container.DataItem("DocumentName")%>
                       </td></tr>
                     </ItemTemplate>
                     <FooterTemplate ></table></FooterTemplate>
                 </asp:Repeater>
                                        

         </div>

         <div class="item itemEven" id="LeftDocument2" runat="server">
             <h3>
                 <asp:Label ID="lblLeftDocument2Title" runat="server"></asp:Label></h3>
            <asp:Repeater ID="ddlLeftDocument2" runat="server">
                    <HeaderTemplate > <table ></HeaderTemplate>
                     <ItemTemplate >
                        <tr ><td>
                            <%# Container.DataItem("DocumentName")%>
                       </td></tr>
                     </ItemTemplate>
                     <FooterTemplate ></table></FooterTemplate>
                 </asp:Repeater>
         </div>

         <div class="item itemOdd last" id="LeftDocument3" runat="server">
             <h3>
                 <asp:Label ID="lblLeftDocument3Title" runat="server"></asp:Label></h3>
            <asp:Repeater ID="ddlLeftDocument3" runat="server">
                     <HeaderTemplate > <table ></HeaderTemplate>
                     <ItemTemplate >
                        <tr ><td>
                            <%# Container.DataItem("DocumentName")%>
                       </td></tr>
                     </ItemTemplate>
                     <FooterTemplate ></table></FooterTemplate>
                 </asp:Repeater>
         </div>
     </div>
    <div class="col2">
        <div class="item" id="RightDocument1" runat="server">
            <h3>
                <asp:Label ID="lblRightDocument1Title" runat="server"></asp:Label></h3>
              <asp:Repeater ID="ddlRightDocument1" runat="server">
                     <HeaderTemplate > <table ></HeaderTemplate>
                     <ItemTemplate >
                        <tr ><td>
                            <%# Container.DataItem("DocumentName")%>
                       </td></tr>
                     </ItemTemplate>
                     <FooterTemplate ></table></FooterTemplate>
                 </asp:Repeater>
        </div>

        <div id="RightDocument2" class="item" runat="server">
            <h3> <asp:Label ID="lblRightDocument2Title" runat="server"></asp:Label></h3>
              <asp:Repeater ID="ddlRightDocument2" runat="server">
                    <HeaderTemplate > <table ></HeaderTemplate>
                     <ItemTemplate >
                        <tr ><td>
                            <%# Container.DataItem("DocumentName")%>
                       </td></tr>
                     </ItemTemplate>
                     <FooterTemplate ></table></FooterTemplate>
                 </asp:Repeater>
        </div>
    </div>

   <%-- <div id="RightDocument3" class="item" runat="server">
            <h3> <asp:Label ID="lblRightDocument3Title" runat="server"></asp:Label></h3>
              <asp:Repeater ID="ddlRightDocument3" runat="server">
                    <HeaderTemplate > <ul></HeaderTemplate>
                     <ItemTemplate >
                         <li>
                            <%# Container.DataItem("DocumentName")%>
                         </li>
                     </ItemTemplate>
                 </asp:Repeater>
        </div>--%>
    <%--MODAL SECTION--%>
    <div class="modal fade" id="News1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h2 class="modal-title text-success" id="myModalLabel1">
                        <asp:Label ID="lblModalTitle1" runat="server"></asp:Label></h2>
                </div>
                <div class="modal-body ">
                    <%--<div class="container ">--%>
                    <h4>
                        <asp:Label ID="lblModalText1" runat="server"></asp:Label></h4>
                    <%--</div>--%>
                </div>
                <div class="modal-footer">
                    <asp:ImageButton ID="imgModalClose1" ImageUrl="../img/GreenCloseBtn.png" runat="server" OnMouseOver="src='/img/GreenCloseBtnOver.png';" OnMouseOut="src='/img/GreenCloseBtn.png';" data-dismiss="modal"></asp:ImageButton>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="News2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h2 class="modal-title text-success" id="myModalLabel2">
                        <asp:Label ID="lblModalTitle2" runat="server"></asp:Label></h2>
                </div>
                <div class="modal-body ">
                    <%--<div class="container ">--%>
                    <h4>
                        <asp:Label ID="lblModalText2" runat="server"></asp:Label></h4>
                    <%--</div>--%>
                </div>
                <div class="modal-footer">
                    <asp:ImageButton ID="imgModalClose2" ImageUrl="../img/GreenCloseBtn.png" runat="server" OnMouseOver="src='/img/GreenCloseBtnOver.png';" OnMouseOut="src='/img/GreenCloseBtn.png';" data-dismiss="modal"></asp:ImageButton>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="News3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h2 class="modal-title text-success" id="myModalLabel3">
                        <asp:Label ID="lblModalTitle3" runat="server"></asp:Label></h2>
                </div>
                <div class="modal-body ">
                    <%--<div class="container ">--%>
                    <h4>
                        <asp:Label ID="lblModalText3" runat="server"></asp:Label></h4>
                    <%--</div>--%>
                </div>
                <div class="modal-footer">
                    <asp:ImageButton ID="Imagebutton2" ImageUrl="../img/GreenCloseBtn.png" runat="server" OnMouseOver="src='/img/GreenCloseBtnOver.png';" OnMouseOut="src='/img/GreenCloseBtn.png';" data-dismiss="modal"></asp:ImageButton>
                </div>
            </div>
        </div>
    </div>

    <hr class="hidden" />
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
    </style>
</asp:Content>






