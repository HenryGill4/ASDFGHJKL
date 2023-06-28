<%@ Page Title="Employee Admin" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="Admin_Employee.aspx.vb" 
    Inherits="HReaseApp.Admin_Employee" %>

<script runat="server">

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)

    End Sub

    Protected Sub imgNext_Click1(sender As Object, e As ImageClickEventArgs)

    End Sub
</script>


<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" Runat="Server">
    <%--Title and Next Button--%>
    <div class="container" runat="server">
        <div class="form-group">
            <div class="col-xs-8 col-sm-8 col-md-6 left">
                <br />
                <h3>Employee Administration</h3>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-11 col-lg-11 center top">
                <ul id="ulddtabs" runat="server" class="pagination-top">
                </ul>
            </div>
            <div class="col-xs-8 col-sm-8 col-md-4 pull-right right">
                <br />
                <asp:ImageButton ID="imgNext" runat="server" ImageUrl="../img/BlueArrowNext.png" OnMouseOver="src='/img/BlueArrowNextOver.png';" OnMouseOut="src='/img/BlueArrowNext.png';" background="#fff" BackColor="White" BorderStyle="None" ImageAlign="AbsMiddle" Visible="true" OnClick="imgNext_Click1"/>

            </div>
        </div>
    </div>
</asp:Content>