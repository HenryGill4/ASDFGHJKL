<%@ Page Title="Login"
    Language="vb"
    AutoEventWireup="false"
    MasterPageFile="~/AppMaster.master"
    CodeBehind="Login.aspx.vb"
    Inherits="HReaseApp.Login"
    MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainBlock" runat="Server">
    <div id="body" style="background: url(img/background_login.jpg);">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto&amp;display=swap" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" />
         


    <div class="container-fluid vh-100" style="font-family: Roboto;">
        <div class="row h-100">
            <div class="col my-3">

                <div id="login-background" class="container-fluid shadow-sm rounded-lg" style="margin-top:80px;">
                    <div class="row" style="min-height: 145px; max-height: 330px; padding: 40px 40px 0px 40px;">
                        <div class="col align-self-center d-flex justify-content-center">
                            <img id="mangroveLogo" class="img-fluid" src="img/logo_login.png" />
                        </div>
                    </div>
                    <div class="row" style="padding-left: 40px; padding-right: 40px;">
                        <div class="col">
                            <div class="rounded-lg" style="padding: 10px 40px 10px 40px; background-color: transparent;">
                                <div class="row" style="height: 70px;">
                                    <div class="col my-auto text-center">
                                        <div style="color: white; font-family: Roboto; font-size: 20px;">Secure Login</div>
                                    </div>
                                </div>
                                <div id="EmployeeInputPanel">

                                    <div id="SSOADtr" class="form-group w-100">
                                        <label for="txtEmployee" style="font-size: 13px; margin-bottom: 3px; color: white;">Employee</label>
                                        <asp:TextBox name="txtUserName" runat="server" type="text" ID="txtUserName" CssClass="form-control login-inputs" onfocus="clearStatusMessage();" />
                                    </div>

                                    <div class="form-group w-100">
                                        <label for="txtPwd" style="font-size: 13px; margin-bottom: 3px; color: white;">Password</label>
                                        <asp:TextBox name="txtPassword" runat="server" type="password" MaxLength="55" ID="txtPassword" CssClass="form-control login-inputs" onfocus="clearStatusMessage();" />
                                    </div>
                                    <div class="form-group w-100">
                                        <label for="employeeRole" style="font-size: 13px; margin-bottom: 3px; color: white;">Role</label>
                                        <asp:TextBox ID="txtCompanyCode" TabIndex="1" CssClass="form-control login-inputs" runat="server" placeholder="Company"> </asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCompanyCode" ErrorMessage="<h4>Company Number</h4>" Display="None"></asp:RequiredFieldValidator>

                                    </div>

                                </div>
                               <div class="d-flex justify-content-center w-100" style="margin-top: 35px;">
                                        <input type="submit" name="updateRoles" value="Update Roles" onclick="return updateRoles_click(window.event||event, this);" id="updateRoles" class="loginButtonLinks">
                                        <button id="btnUpdatingRoles" type="button" class="loginButtonLinks" disabled=""><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>&nbsp;&nbsp;Updating Roles</button>
                                    </div>
                               <div id="divAdvanced" class="form-group text-center" style="padding-top: 20px;">
                                        <button id="btnShowSettings" class="loginButtonLinks" type="button" onclick="javascript:ShowSettings();">Show Settings</button>
                                        
                                    </div>

                                <%--<div id="UpdatePanel1">

                                        <div id="advancedSettings">

                                            <div class="form-group w-100">
                                                <label for="txtServiceId" style="font-size: 13px; margin-bottom: 3px; color: white;">Service ID</label>
                                                <asp:TextBox name="txtServiceID" runat="server" type="text" ID="txtServiceID" CssClass="form-control login-inputs hidden-controls" onfocus="clearStatusMessage();" Style="display: none;" />
                                            </div>
                                            <div class="form-group w-100">
                                                <label for="txtClientCode" style="font-size: 13px; margin-bottom: 3px; color: white;">Client</label>
                                                <asp:TextBox name="txtClientCode" runat="server" type="text" ID="txtClientCode" CssClass="form-control login-inputs hidden-controls" onfocus="clearStatusMessage();" Style="display: none;" />
                                            </div>
                                        </div>

                                    </div>--%>
                                <div class="d-flex align-items-center justify-content-center" id="statusMessageContainer" style="height: 0px; opacity: 0;">
                                    <div class="form-group w-100 text-center my-auto">
                                        <span id="statusMessage" style="font-size: 13px; color: red;"></span>
                                    </div>
                                </div>
                                <div class="form-group text-center" style="padding-top: 20px; padding-bottom: 20px;">
                                        <div style=" vertical-align:middle;">
                                            <input id="checkTerms" type="checkbox" name="checkTerms" style="vertical-align:middle;">
                                    
                                        <label id="lblTermsConditionsWords" class="form-check-label" for="checkTerms" style="font-size: 13px; color: white; vertical-align:middle;">I accept this website's </label>
                                        <label id="lblTermsConditionsLink" class="form-check-label" for="lblTermsConditionsWords" data-toggle="modal" data-target="#termsAndConditions" style="vertical-align:middle;">Terms and Conditions</label>
                                        </div>
                                    </div>
                                <div class="form-group w-100">

                                    <asp:Button runat="server" ID="btnLogin1" Class="btn w-100 shadow" OnClick="btnLogin_Click" Text="Login" />
                                </div>
                            </div>
                            <div class="form-group text-center" style="padding-bottom: 15px;">
                                <div id="loginLowerNav" style="display: none;">
                                    <label id="lblChangePwd" class="form-check-label" onclick="javascript:changePassword();">Change Password</label>
                                    <label id="lblDivider" class="form-check-label" style="font-size: 13px; color: whitesmoke;">&nbsp;|&nbsp;</label>
                                    <label id="lblForgotPwd" class="form-check-label" onclick="javascript:forgotPassword();">Forgot Password</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="copyright p-3" style="color: white;">Copyright © 2022 Asure</div>

            </div>
        </div>
        <div id="divSuccess" runat="server" class="col-md-12" visible="false">
            <div class="col-md-12 center">
                <h4 style="color: green; padding-top: 10px;">Sucessful login.</h4>
                <br />
            </div>
        </div>

        <div id="divError" runat="server" visible="false" class="col-md-12 ">
            <div class="col-md-12 center">
                <h5 style="color: red; padding-top: 10px;">We are unable to locate your record with the information provided. </h5>
            </div>
        </div>
    </div>




    <div class="hidden">
        Company In Session: Alias:<asp:Label ID="lblAlias" runat="server"></asp:Label>
        ;  CompanyId:<asp:Label ID="lblCompanyId" runat="server"></asp:Label>
    </div>
    </div>
    <style>
        
        .checkTerms{
            vertical-align:middle !important;
            margin:auto !important;
            padding:0px !important;
        }
        .HREwrapper {
            margin-left: 5%;
            margin-right: 5%;
        }

        .container-fluid {
            width: 100%;
            padding-right: 15px;
            padding-left: 15px;
            margin-right: auto;
            margin-left: auto;
        }

        .btn {
            display: inline-block;
            font-weight: 400;
            color: white !important;
            text-align: center;
            vertical-align: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            background-color: #068FBE !important;
            border: 1px solid transparent;
            padding: 0.375rem 0.75rem !important;
            font-size: 18px !important;
            line-height: 1.5 !important;
            border-radius: 0.25rem;
            transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
        }

        .MainBlock {
            background: url(..//img/background_login.jpg);
            margin: 0;
            font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,"Noto Sans",sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #212529;
            text-align: left;
        }

        *, ::after, ::before {
            box-sizing: border-box;
        }

        :root {
            --blue: #007bff;
            --indigo: #6610f2;
            --purple: #6f42c1;
            --pink: #e83e8c;
            --red: #dc3545;
            --orange: #fd7e14;
            --yellow: #ffc107;
            --green: #28a745;
            --teal: #20c997;
            --cyan: #17a2b8;
            --white: #fff;
            --gray: #6c757d;
            --gray-dark: #343a40;
            --primary: #007bff;
            --secondary: #6c757d;
            --success: #28a745;
            --info: #17a2b8;
            --warning: #ffc107;
            --danger: #dc3545;
            --light: #f8f9fa;
            --dark: #343a40;
            --breakpoint-xs: 0;
            --breakpoint-sm: 576px;
            --breakpoint-md: 768px;
            --breakpoint-lg: 992px;
            --breakpoint-xl: 1200px;
            --font-family-sans-serif: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,"Noto Sans",sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";
            --font-family-monospace: SFMono-Regular,Menlo,Monaco,Consolas,"Liberation Mono","Courier New",monospace;
        }

        *, ::after, ::before {
            box-sizing: border-box;
        }

        .body::-webkit-scrollbar {
            width: 10px;
            border-radius: 10px;
        }

        .body::-webkit-scrollbar-thumb {
            /* background: lightgray; */
            background-color: rgba(0,0,0,.7);
            border-radius: 10px;
        }

        .body::-webkit-scrollbar-track {
            /* background: whitesmoke; */
            background-color: transparent;
            border-radius: 10px;
        }



        /* Login styles */
        /* Copyright © 2007 Mangrove Software Inc. */

        .body {
            margin: 0;
            padding: 0;
            font-family: Arial, Sans-Serif;
            background: url(..//Img/background_login.jpg);
        }


        a {
            color: #2b64cd;
        }

            a:hover {
                color: #d86508;
                text-decoration: none !important;
            }


        .image-container {
            text-align: center;
            margin-top: 15px;
            margin-bottom: 15px;
        }

        .container {
            width: 505px;
            margin: 0px auto;
            text-align: center;
            background-color: #fff;
            padding: 5px;
            font-size: 12px;
        }

        table {
            text-align: left;
            margin: 0px auto;
        }

        .login-title {
            font-size: 1.4em;
            margin-bottom: 25px;
        }

        .directions {
            font-size: 0.9em;
            margin: 0;
            padding: 12px 0;
        }

        .td-left {
            text-align: right;
        }

        .tb {
            border: 1px solid #a5acb2;
            padding: 2px;
        }

        .status {
            color: #cc0000;
            font-weight: bold;
            padding: 10px 0;
            display: block;
        }

        #adv-settings-link {
            font-size: 10px;
            color: #5e7dd6;
        }

            #adv-settings-link:hover {
                font-size: 10px;
                color: #777;
            }

        #change-password-link {
            font-size: 10px;
            color: #5e7dd6;
        }

            #change-password-link:hover {
                font-size: 10px;
                color: #777;
            }



        #terms {
            color: #5e7dd6;
        }

            #terms:hover {
                color: #777;
            }

        .update-button {
            position: relative;
            top: 1px;
            left: 1px;
        }


        fieldset {
            width: 440px;
            margin: 0px auto;
        }

        #adv-settings-link {
            margin-left: 5px;
        }







        .root {
            width: 550px;
            margin: 0px auto;
            border: none;
            background: transparent url(../images/gradient-round-middle.gif) repeat-y;
            background-position: center bottom;
            padding: 0 15px;
            padding-top: 2px;
        }




        .login-header {
            font-size: 16pt;
            text-align: center;
            margin: 8px 0 8px 0;
            color: #0f517b;
        }

        .login-table {
            margin: 0 auto;
            width: 266px;
        }

            .login-table tr td input {
                width: 150px;
            }

            .login-table tr td.fixed {
                width: 162px;
            }

        .button-container {
            text-align: center;
            padding: 10px 0 8px 0;
        }

        .fixed-td {
            width: 94px;
        }

        .user-input {
            font-size: 9pt;
        }



        .status-div {
            color: Red;
            font-size: 9pt;
            text-align: center;
            padding: 5px 0;
        }

        .lower-nav {
            text-align: center;
            font-size: 11px;
            padding: 4px 0;
        }



            .lower-nav a {
                padding: 0 4px;
            }


        .gradient-round-top {
            background: transparent url(../images/gradient-round-top.gif) no-repeat;
            height: 11px;
            overflow: hidden;
            width: 542px;
            margin: 25px auto 0 auto;
        }

        .gradient-round-bottom {
            background: transparent url(../images/gradient-round-bottom.gif) no-repeat;
            height: 11px;
            overflow: hidden;
            width: 542px;
            margin: 0 auto 0 auto;
        }



        .button {
            background: transparent url(../images/btn.gif) repeat-x;
            border: 3px double #ccc;
            cursor: pointer;
            font-weight: bold;
        }


        .page-description {
            margin-top: 0px;
        }

        .page-description-inner {
            text-align: center;
            font-weight: bold;
            font-size: 12pt;
            padding: 0px 0;
            padding-bottom: 4px;
        }

        .page-description-shade {
            height: 1px;
            overflow: hidden;
            background-color: #8ea7d5;
            border-top: 1px solid #777;
            border-bottom: 1px solid #9cb7ea;
            border-bottom: 1px solid #b3c6ea;
        }

        .instructions {
            margin-bottom: 5px;
        }

        .instructions-inner {
        }

        #smDescription {
            text-align: center;
            font-size: 10pt;
            padding: 2px 0;
            padding-top: 4px;
        }



        .label-cell {
            text-align: right;
            padding-right: 5px;
        }


        .form-content {
            padding: 10px;
            padding-bottom: 0;
        }

        .status-message-inner {
            text-align: center;
            padding: 1px 5px;
        }

        .status-message-text {
            font-weight: bold;
            font-size: 9pt;
        }


        .secure-icon {
            vertical-align: middle;
            margin-left: 5px;
        }


        .update-roles-cell {
            text-align: center;
            padding-top: 4px;
        }


        .web-terms {
            padding: 8px 0;
            text-align: center;
            font-size: 9pt;
        }


        .form-shield {
            text-align: center;
            padding-top: 10px;
        }


        #statusMessageContainer {
            height: 70px;
            opacity: 0;
            -webkit-transition: all 0.2s;
            -moz-transition: all 0.2s;
            -o-transition: all 0.2s;
            transition: all 0.2s;
        }


        .get-a-real-browser {
            width: 542px;
            margin: 8px auto;
        }

        .get-a-real-browser-inner {
            padding: 3px 10px;
            font-size: 9pt;
            text-align: center;
        }


        .advanced-settings {
            text-align: center;
            margin: 5px 0;
        }



        .copyright {
            padding-top: 2px;
            font-size: 8pt;
            text-align: center;
        }



        #login-background {
            width: 500px;
            background-color: rgba(0,0,0,.7);
        }


        .login-inputs {
            height: 32px !important;
            font-size: 14px !important;
            background-color: white !important;
            color: #333333 !important;
            border: 1px solid #333333;
        }


        .loginButtonLinks {
            border: none;
            background-color: transparent;
            color: #068FBE;
            font-size: 15px;
        }

        #btnShowSettings:hover {
            color: #47C3D3;
        }

        #btnShowSettings {
            outline: none;
            display: inline-block;
        }

        /*#updateRoles {
    outline: none;
    display: none;
}*/

        #updateRoles:hover {
            color: #47C3D3;
        }

        #btnUpdatingRoles {
            display: none;
            cursor: default;
        }

        #lblTermsConditionsLink {
            font-size: 13px;
            color: #068FBE;
            position: relative;
            background-color: transparent;
        }

            #lblTermsConditionsLink:hover {
                color: #47C3D3;
                cursor: pointer;
            }

        #lblChangePwd, #lblForgotPwd, #login, #loginLink {
            font-size: 13px;
            color: whitesmoke;
        }


            #login:link, #login:visited, #loginLink:visited {
                text-decoration: none !important;
            }


            #lblChangePwd:hover, #lblForgotPwd:hover, #login:hover, #loginLink:hover {
                color: #47C3D3;
                cursor: pointer;
            }

        .btnLogin1 {
            color: white !important;
            background-color: #068FBE !important;
            position: relative !important;
        }

            .btnLogin1:hover, .btnSubmit:hover, .linkToButton:hover {
                color: white !important;
                background-color: #47C3D3 !important;
            }

        #advancedSettings {
            height: 0px;
            opacity: 0;
            -webkit-transition: all 0.3s;
            -moz-transition: all 0.3s;
            -o-transition: all 0.3s;
            transition: all 0.3s;
        }


        .modal-header {
            border-bottom: none !important;
            position: relative;
        }


        #termsAndConditionsContent {
            height: 500px;
            overflow-y: scroll;
            padding: 0px 40px 0px 50px;
            margin-bottom: 20px;
        }

            #termsAndConditionsContent::-webkit-scrollbar {
                width: 10px;
                border-radius: 10px;
            }

            #termsAndConditionsContent::-webkit-scrollbar-track {
                /*background: whitesmoke;*/
                background-color: transparent;
                border-radius: 10px;
            }

            #termsAndConditionsContent::-webkit-scrollbar-thumb {
                /*background: lightgray;*/
                background-color: rgba(0,0,0,.4);
                border-radius: 10px;
            }

            #termsAndConditionsContent p {
                font-size: 14px;
            }

        .body {
            overflow-y: overlay;
            background: image()
        }

            .body::-webkit-scrollbar {
                width: 10px;
                border-radius: 10px;
            }

            .body::-webkit-scrollbar-track {
                /*background: whitesmoke;*/
                background-color: transparent;
                border-radius: 10px;
            }

            .body::-webkit-scrollbar-thumb {
                /*background: lightgray;*/
                background-color: rgba(0,0,0,.7);
                border-radius: 10px;
            }


        .userInputs {
            -webkit-transition: all 0.3s;
            -moz-transition: all 0.3s;
            -o-transition: all 0.3s;
            transition: all 0.3s;
        }

        #loginLowerNav {
            display: none;
        }
        input {
    writing-mode: horizontal-tb !important;

    text-rendering: auto;
    
    letter-spacing: normal;
    word-spacing: normal;
    line-height: normal;
    text-transform: none;
    text-indent: 0px;
    text-shadow: none;
    display: inline-block;
    text-align: start;
    appearance: auto;
    
    cursor: text;
   
    margin: 0em;
    padding: 1px 2px;
    border-width: 2px;
    border-style: inset;
   
    border-image: initial;
}
        input[type="checkbox" i] {
    background-color: initial;
    cursor: default;
    appearance: auto;
    box-sizing: border-box;
    margin: 3px 3px 3px 4px;
    padding: initial;
    border: initial;
    overflow: visible;
}
        div {
    display: block;
}
        html {
    font-family: sans-serif;
    line-height: 1.15;
    -webkit-text-size-adjust: 100%;
    -webkit-tap-highlight-color: transparent;
}
    </style>
</asp:Content>
