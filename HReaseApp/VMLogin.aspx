﻿<%@ Page Title="VMLogin" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMaster.master" 
    CodeBehind="VMLogin.aspx.vb" 
    Inherits="HReaseApp.VMLogin"
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <%--<asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>--%>   
</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainBlock" runat="Server">
    <div class="HREwrapper" >
        <div id="divPageTitle">
            <div >
                <br />
                <%--<h4><b>Login Page</b></h4>--NOTE THAT WE DO NOT NEED THIS TEXT ON THE LOGIN PAGE BUT DO NEED THE SPACING SO THAT IT DOES NOT PUSH UNDER THE TITLE BAR --%>
                <br />
                <br />
                <br />
            </div>
        </div>
        <section id="LoginSection" class="container">
            <div id="Column1" class="col-xs-12 col-md-8 col-lg-8" >
                <div class="center" style="padding: 5px 5px 5px 5px;">
                    <asp:Image ID="CompanyLogoImage" runat="server" CssClass="center" ImageUrl="/images/hrease-01.png"/>
                </div>
                <div class="center">
                    <h2><asp:Label ID="MainArticleTitleLabel" runat="server" CssClass="center"></asp:Label> </h2>
                </div>
                <div class="hidden-xs">
                    <p><asp:Label ID="MainArticleTextLabel" runat="server" CssClass="center "> </asp:Label><br /> <br /></p>
                </div>
            </div>

            <div id="Column2" class="container" >
                <div class="col-xs-12 col-md-4 white-row" >
                    <div class="row" style ="padding-left:10px;">
                        <h4>New Users</h4>
                    </div>
                    <div class="text-center">
                        <asp:ImageButton ID="RegisterButton" runat="server" ImageUrl="img/BlueRegisterBtn1.png" ImageAlign="AbsMiddle" OnMouseOver="src='/img/BlueRegisterBtnOver1.png';" OnMouseOut="src='/img/BlueRegisterBtn1.png';" CausesValidation="false" PostBackUrl="~/EE_SecurityRegistration.aspx?prp=New" />
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
               
                        <asp:TextBox ID="CompanyCodeText" TabIndex="1" CssClass="form-control" runat="server"> </asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CompanyCodeText" ErrorMessage="<h4>Company Code</h4>" Display="None"></asp:RequiredFieldValidator>

                    </div>

                    <div class="form-group">
                        Username
                 
                         <asp:TextBox ID="UsernameText" TabIndex="3" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="ValidUsername" runat="server" ControlToValidate="UsernameText" ErrorMessage="<h4>Username</h4>" Display="None"></asp:RequiredFieldValidator>

                    </div>

                    <div class="form-group">           
                        Password                       
                        <asp:TextBox ID="PasswordText" TabIndex="5" CssClass="form-control" runat="server" MaxLength="50"></asp:TextBox>  
                        TextMode="Password" 
                        <asp:RequiredFieldValidator ID="ValidPassword" runat="server" ControlToValidate="PasswordText" ErrorMessage="<h4>Password</h4>" Display="None"></asp:RequiredFieldValidator>
                    </div>

                    <div class="col-md-12 text-center">
                        <asp:ImageButton ID="LoginButton" runat="server" ImageUrl="img/BlueLogInBtn2.png" ImageAlign="AbsMiddle" OnMouseOver="src='/img/BlueLoginBtnOver2.png';" OnMouseOut="src='/img/BlueLogInBtn2.png';" />
                    </div>

                    <div class="row"> 
                    <div id="TimeoutMessage" runat="server" visible="false" class="col-md-12 ">
                        <div class="col-md-12 center" style="color:red;">
                            <br /><br />
                            <b>For security reasons your previous session has timed out.
                                <br />
                                Please log in again.</b>
                        </div>
                    </div>

                    <div id="SuccessMessage" runat="server" class="col-md-12" visible="false">
                        <div class="col-md-12 center" > 
                            <h4 style="color:green; padding-top:10px;">Sucessful login.</h4>
                            <br />
                        </div>
                    </div>

                    <div id="ErrorMessage" runat="server" visible="false" class="col-md-12 ">
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
            Company In Session: Alias:<asp:Label ID="AliasLabel" runat="server"></asp:Label> ;  CompanyId:<asp:Label ID="CompanyIdLabel" runat="server"></asp:Label>
        </div>
    </div>
    <style>
        .HREwrapper {margin-left: 5%; margin-right: 5%; }
    </style>
</asp:Content>