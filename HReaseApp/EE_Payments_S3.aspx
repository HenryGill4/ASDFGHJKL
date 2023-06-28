<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AppMasterHeaderSplit.Master"   CodeBehind="EE_Payments_S3.aspx.vb" Inherits="HReaseApp.EE_Payments_S3" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainBlock" runat="Server">
     
    <div id="divAccept" runat="server" class="container-fluid" >
        <div class="form-group">
            <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">
                <br />
                <h3>
                    <asp:Label ID="lblMainArticleTitle" runat="server"></asp:Label>
                </h3>

            </div>
           <%-- <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 pull-right right">
                <asp:ImageButton ID="imgNext" runat="server" ImageUrl="../img/BlueArrowNext.png" OnMouseOver="src='/img/BlueArrowNextOver.png';" OnMouseOut="src='/img/BlueArrowNext.png';" background="#fff" BackColor="White" BorderStyle="None" Visible="true" PostBackUrl="~/EE_Welcome.aspx" />
            </div>--%>
        </div>
                
       <div class=" form-group">
            <div class="col-md-12">
                <asp:ValidationSummary HeaderText="<h4>Please enter a value in the following fields:</h4>" DisplayMode="SingleParagraph" EnableClientScript="true" runat="server" CssClass="alert alert-danger text-danger text-center" ValidationGroup="valAccept"/>
                <div id="divError" class='alert alert-danger text-center text-danger' runat="server" visible="false">
                    <h4>
                        <asp:Label ID="lblError" runat="server" Text=""></asp:Label></h4>
                </div>
            </div>
        </div>
         
<%--         <div class="form-group">
                 <div id="divSuccess" runat="server" class="col-md-12 text-center"  visible ="false">
                     <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="175px" cssclass=" img" />
                     <h1><br />Congratulations, you have completed the enrollment process</h1>
                 </div>
            </div>--%>

             <div class="form-group"  id="divFail" runat="server" visible ="false" >
                 <div  class="col-xs-4 col-sm-4 col-md-3 col-lg-3 center " >
                     <asp:Image id="imgFail" ImageUrl="../img/RedX.png" runat="server" Width="175px" cssclass=" img" border="none"/>
                     <%--<asp:ImageButton id="btnFail" ImageUrl="../img/RedX.png" runat="server" Width="175px" cssclass=" img" />--%>
                   </div>
                   <div class=" h2Error text-center col-xs-8 col-sm-8 col-md-9 col-lg-9 " ><br />
                       <asp:label id="lblErrorMessage" runat="server" text = "Opps!  There was an error.<br/>"></asp:label>  
                   </div>                        
                 </div>
        

        <div class="well-success">

            
             <div class="form-group">
                  <div class="col-md-12">
                 <asp:Label ID="lblMainArticleText" runat="server" Font-Size="Larger" ></asp:Label>
                    </div>
            </div>

            <%-- Capture Initials Area--%>
        

            <div class="form-group">


                        <div class="form-group ">
                            <div class="col-xs-10 col-sm-10 col-md-3">
                                 <div class="input-group ">
                                    <asp:Label ID="LabelResponse" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group ">
                            <div class="col-xs-10 col-sm-12 col-md-5">
                                 <div class="input-group ">
                                    <asp:Label ID="LabelResponseText" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>

            <div class="form-group">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 right">
                    <asp:Button   runat="server"    Text="Return to Welcome Page" ID="btnReturn" ></asp:Button>
                </div>
            </div>

            </div>
             <div class="form-group">
                 <br />
            </div>



           



        </div>

    </div>
         
</asp:Content>




 <asp:Content ID="Client" ContentPlaceHolderID="Client" runat="Server">
  </asp:Content>
