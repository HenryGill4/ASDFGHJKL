<%@ Page Title="" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="Admin_Benefit.aspx.vb" 
    Inherits="HReaseApp.Admin_Benefit" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="tabs" runat="Server">
    <div id="tabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>       
    </div>
</asp:Content>

<asp:Content ID="Content5" ContentPlaceHolderID="MainArticle" Runat="Server">
    <div class="container">
    <div class=" form-group  " >
            <div class=" hidden-sm hidden-xs col-md-4 col-lg-4 center" >
                <br />
                <br />
                <asp:Image ID="Image1" ImageUrl="../img/Coming-soon2.gif" Width="100%" runat="server" CssClass="img" border="none" />
                <%--<img src="../img/Coming-soon2.gif" class=" img-rounded" ld Testing this stuff!!!!!!!/>--%>
            </div>

            <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8 ">
                <br />
                <asp:Image ID="imgBenefit" ImageUrl="../img/IconBenefit.png" Width="100px" runat="server" border="none" CssClass=" img" OnMouseOver="src='/img/IconBenefitOver.png';" OnMouseOut="src='/img/IconBenefit.png';" />
                <br />
                <br />
                <h2>Benefit Administration</h2>

                <div class="h4">You will soon be able to manage the following:</div>
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;<span style="color:red; font-size:3px;" class = "glyphicon glyphicon-check"></span>
               &nbsp;&nbsp;&nbsp;&nbsp; <b style="color:darkgreen; font-size:3px;">Benefit Classes</b>
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;<span style="color:red; font-size:3px;" class = "glyphicon glyphicon-check"></span>
            &nbsp;&nbsp;&nbsp;&nbsp;<b style="color:purple; font-size:3px;">Plan Information and Rules</b>
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;<span style="color:red; font-size:3px;" class = "glyphicon glyphicon-check"></span>
            &nbsp;&nbsp;&nbsp;&nbsp;<b style="color:royalblue; font-size:3px;">Plan Rates and Options</b>
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;<span style="color:red; font-size:3px;" class = "glyphicon glyphicon-check"></span>
            &nbsp;&nbsp;&nbsp;&nbsp;         <b>Assign Rates to Classes</b>
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;<span style="color:red; font-size:3px;" class = "glyphicon glyphicon-check"></span>
            &nbsp;&nbsp;&nbsp;&nbsp;  <b style="color:limegreen; font-size:3px;">Screen Configuration</b>
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;<span style="color:red; font-size:3px;" class = "glyphicon glyphicon-check"></span>
            &nbsp;&nbsp;&nbsp;&nbsp;    <b style="color:Orange; font-size:3px;">Plan Questions</b>
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;<span style="color:red; font-size:3px;" class = "glyphicon glyphicon-check"></span>
            &nbsp;&nbsp;&nbsp;&nbsp;    <b  style="color:darkblue; font-size:3px;">Loading and Managing Plan Documents</b>
                <br />
                <br />

                <h4>
                    Announcements will be made on your main <a href="../Admin_Welcome.aspx">Home</a> User Dashboard as new functionality is rolled out. 
                <br /><br />Thank you for being our valued customer!<br />

                </h4>
                </div>
            </div>
        </div>
</asp:Content>

