<%@ Page Title="Corporate Login" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMaster.master" 
    CodeBehind="CorporateLogin.aspx.vb" 
    Inherits="HReaseApp.CorporateLogin"
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainBlock" runat="Server">
     
    <div class="HREwrapper" >
        <script type="text/javascript">
            function clearSessionMemory() {
                sessionStorage.clear()
            }
        </script>
        <div id="divPageTitle"  >
            <div >
                <br />
                <%--<h4><b>Login Page</b></h4>--NOTE THAT WE DO NOT NEED THIS TEXT ON THE LOGIN PAGE BUT DO NEED THE SPACING SO THAT IT DOES NOT PUSH UNDER THE TITLE BAR --%>
                <br />
                <br />
                <%--<span style="color:red;">The HRease website is currently unavailable due to routine maintenance.  Please log back in after 6:00am EST.  Thank you for your patience while we work to improve your experience.</span>--%>
                <br />
            </div>
        </div>
        <section id="login" class="container" >
            <div class="col-xs-12 col-md-8 ">
                <div class="col-xs-12 col-md-12">
                    <div class="center" style="padding: 5px 5px 5px 5px;">
                        <asp:Image ID="imgCompanyLogo" runat="server" CssClass="center" ImageUrl="/images/hrease-01.png"/>
                    </div>
                    <h2><asp:Label ID="lblMainArticleTitle" runat="server" CssClass="center"></asp:Label> </h2>
                    <p><asp:Label ID="lblMainArticleText" runat="server" CssClass="center "> </asp:Label><br /> <br /></p>
                </div>
            </div>

            <div id="divcol2" class="container" >
                <div class="col-xs-12 col-md-4 white-row" >
                    <div class="row" style ="padding-left:10px;">
                        <h4>New Users</h4>
                    </div>
                    <div class="text-center">
                        <asp:ImageButton ID="btnRegister" runat="server" ImageUrl="img/BlueRegisterBtn1.png" ImageAlign="AbsMiddle" OnMouseOver="src='/img/BlueRegisterBtnOver1.png';" OnMouseOut="src='/img/BlueRegisterBtn1.png';" CausesValidation="false" PostBackUrl="~/EE_SecurityRegistration.aspx?prp=New" />
                    </div>
                    <div class="row text-center">
                        <p> New users must complete initial registration.</p>
                    </div>
                    <div class="row">
                        <br />
                    </div>
                    <div class="row" style ="padding-left:10px;">
                        <h4>Login</h4>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12 text-center">
              
                            <a href="/EE_SecurityRegistration.aspx?prp=Forgot">Forgot Username or Password</a>
                        </div>
                    </div>

                    <div class="form-group">
                        Company Code
               
                        <asp:TextBox ID="txtCompanyCode" TabIndex="1" CssClass="form-control" runat="server" placeholder="Company"> </asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCompanyCode" ErrorMessage="<h4>Company Number</h4>" Display="None"></asp:RequiredFieldValidator>

                    </div>

                    <div class="form-group">
                        Username
                 
                         <asp:TextBox ID="txtUsername" TabIndex="3" CssClass="form-control" runat="server" placeholder="Username"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="valUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="<h4>Username</h4>" Display="None"></asp:RequiredFieldValidator>

                    </div>

                    <div class="form-group">           
                        Password                       
                        <asp:TextBox ID="txtPassword" TabIndex="5" CssClass="form-control" runat="server" TextMode="Password" placeholder="Password" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="valPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="<h4>Password</h4>" Display="None"></asp:RequiredFieldValidator>
                    </div>

                    <div class="col-md-12 text-center" onclick="clearSessionMemory(this)">
                        <asp:ImageButton ID="btnLogin" runat="server" ImageUrl="img/BlueLogInBtn2.png" ImageAlign="AbsMiddle" OnMouseOver="src='/img/BlueLoginBtnOver2.png';" OnMouseOut="src='/img/BlueLogInBtn2.png';" />
                    </div>

                    <div class="row"> 
                    <div id="divTimeout" runat="server" visible="false" class="col-md-12 ">
                        <div class="col-md-12 center" style="color:red;">
                            <br /><br />
                            <b>For security reasons your previous session has timed out.
                                <br />
                                Please log in again.</b>
                        </div>
                    </div>

                    <div id="divSuccess" runat="server" class="col-md-12" visible="false">
                        <div class="col-md-12 center" > 
                            <h4 style="color:green; padding-top:10px;">Sucessful login.</h4>
                            <br />
                        </div>
                    </div>

                    <div id="divError" runat="server" visible="false" class="col-md-12 ">
                        <div class="col-md-12 center" >                       
                            <h5 style="color:red; padding-top:10px;">We are unable to locate your record with the information provided. </h5>
                        </div>
                    </div>
                   
                    <asp:ValidationSummary HeaderText="<h4>Please enter a value in the following fields:</h4>" DisplayMode="SingleParagraph" EnableClientScript="true" runat="server"  CssClass="alert alert-danger text-danger text-center"  />

                </div>
            </div>
            </div>

                
        </section>
    
        <div class="hidden">
            Company In Session: Alias:<asp:Label ID="lblAlias" runat="server"></asp:Label> ;  CompanyId:<asp:Label ID="lblCompanyId" runat="server"></asp:Label>
        </div>
    </div>
  
    <style>
        .HREwrapper {margin-left: 5%; margin-right: 5%; }
    </style>
</asp:Content>