<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DualFactorAuthenticationPage.aspx.vb" Inherits="HReaseApp.DualFactorAuthenticationPage"
    MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title runat="server" id="pagetitle"></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script>
        function addnewemployee() {
            document.getElementById("VTselect").style.display = "block";
            document.getElementById("typeselct").style.display = "none";
        }
        function forgotpasswordbtn() {
            document.getElementById("forgotVD").style.display = "block";
            document.getElementById("typeselct").style.display = "none";
        }
        function SMStab() {
            document.getElementById("SMSVerify").style.display = "block";
            document.getElementById("VTselect").style.display = "none";
        }
        function verifyemail() {

            document.getElementById("emailverify").style.display = "block";
            document.getElementById("VTselect").style.display = "none";

        }
        function subshow() {
            document.getElementById("submitbtn").style.display = "block";
            document.getElementById("margindelete").style.margin = "auto auto 10% auto";
            document.getElementById("ResendEmail").style.display = "none"
        }
        function smsshow() {
            document.getElementById("submitbtn1").style.display = "block";
            document.getElementById("margindelete1").style.margin = "auto auto 10% auto";
            document.getElementById("ResendSMS").style.display = "none"
        }
        function emailsub() {
            document.getElementById("validationthank").style.display = "block"
            document.getElementById("emailverify").style.display = "none"
            var time = 2;

            setInterval(function () {
                var seconds = time % 60;
                var minutes = (time - seconds) / 60;
                if (seconds.toString().length == 1) {
                    seconds = "0" + seconds;
                }
                if (minutes.toString().length == 1) {
                    minutes = "0" + minutes;
                }
                document.getElementById("time").innerHTML = minutes + ":" + seconds;
                time--;
                if (time == 0) {

                    document.getElementById("newusersignup").style.display = "block";
                    document.getElementById("validationthank").style.display = "none";
                }
            }, 1000);
        }
        function smssub() {
            document.getElementById("validationthank").style.display = "block"
            document.getElementById("SMSVerify").style.display = "none"
            var time = 2;

            setInterval(function () {
                var seconds = time % 60;
                var minutes = (time - seconds) / 60;
                if (seconds.toString().length == 1) {
                    seconds = "0" + seconds;
                }
                if (minutes.toString().length == 1) {
                    minutes = "0" + minutes;
                }
                document.getElementById("time").innerHTML = minutes + ":" + seconds;
                time--;
                if (time == 0) {

                    document.getElementById("newusersignup").style.display = "block";
                    document.getElementById("validationthank").style.display = "none";
                }
            }, 1000);
        }
        function signin() {
            document.getElementById("newusersuccess").style.display = "block";
            document.getElementById("newusersignup").style.display = "none";
        }

        function passwordvalidation() {
            var pass1 = document.getElementById("passwordtxt").value
            var pass2 = document.getElementById("passwordverifytxt").value
            if (pass1 === pass2) {
                document.getElementById("passworderror").style.display = "none"
            } else {
                document.getElementById("passworderror").style.display = "block"
                document.getElementById("passwordverifytxt").style.color = "red"
            }
        }

        /*PASSWORD RESET SECTION*/

        function Emailinput() {
            document.getElementById("Emailforgotbtn").style.display = "none"
            document.getElementById("emailimput").style.display = "block"
            document.getElementById("SMSforgotbtn").style.display = "none"
            document.getElementById("tab1").style.display = "none"
            document.getElementById("tab3").style.display = "block"
        }
        function SMSinput() {
            document.getElementById("SMSforgotbtn").style.display = "none"
            document.getElementById("SMSinput").style.display = "block"
            document.getElementById("Emailforgotbtn").style.display = "none"
            document.getElementById("tab1").style.display = "none"
            document.getElementById("tab2").style.display = "block"
        }
        function emailenter() {
            document.getElementById("whitespace").style.display = "none"
            document.getElementById("Emailsubmit").style.display = "block"
        }
        function SMSenter() {
            document.getElementById("whitespace").style.display = "none"
            document.getElementById("SMSsubmit").style.display = "block"
        }
        function RSsubmit1() {
            document.getElementById("forgotVD").style.display = "none"
            document.getElementById("RSemail").style.display = "block"
        }
        function RSsubmit2() {
            document.getElementById("forgotVD").style.display = "none"
            document.getElementById("RSphone").style.display = "block"
        }
        function RSsubshow() {
            document.getElementById("RSsubmitbtn").style.display = "block";
            document.getElementById("RSmargindelete").style.margin = "auto auto 10% auto";
            document.getElementById("RSResendEmail").style.display = "none"
        }
        function RSsmsshow() {
            document.getElementById("RSsubmitbtn1").style.display = "block";
            document.getElementById("RSmargindelete1").style.margin = "auto auto 10% auto";
            document.getElementById("RSResendSMS").style.display = "none"
        }
        function RSsub1() {
            document.getElementById("RSvalidationthank").style.display = "block"
            document.getElementById("RSemail").style.display = "none"
            var time = 2;

            setInterval(function () {
                var seconds = time % 60;
                var minutes = (time - seconds) / 60;
                if (seconds.toString().length == 1) {
                    seconds = "0" + seconds;
                }
                if (minutes.toString().length == 1) {
                    minutes = "0" + minutes;
                }
                document.getElementById("RStime").innerHTML = minutes + ":" + seconds;
                time--;
                if (time == 0) {

                    document.getElementById("passwordreset").style.display = "block";
                    document.getElementById("RSvalidationthank").style.display = "none";
                }
            }, 1000);
        }
        function RSsmssub() {
            document.getElementById("RSvalidationthank").style.display = "block"
            document.getElementById("RSphone").style.display = "none"
            var time = 2;

            setInterval(function () {
                var seconds = time % 60;
                var minutes = (time - seconds) / 60;
                if (seconds.toString().length == 1) {
                    seconds = "0" + seconds;
                }
                if (minutes.toString().length == 1) {
                    minutes = "0" + minutes;
                }
                document.getElementById("RStime").innerHTML = minutes + ":" + seconds;
                time--;
                if (time == 0) {

                    document.getElementById("passwordreset").style.display = "block";
                    document.getElementById("RSvalidationthank").style.display = "none";
                }
            }, 1000);
        }
        function RSpasswordvalidation() {
            var pass1 = document.getElementById("newpasswordtxt").value
            var pass2 = document.getElementById("newpasswordverifytxt").value
            if (pass1 === pass2) {
                document.getElementById("RSpassworderror").style.display = "none"
            } else {
                document.getElementById("RSpassworderror").style.display = "block"
                document.getElementById("newpasswordverifytxt").style.color = "red"
            }
        }
        function Resetcomplete() {
            document.getElementById("resetsuccess").style.display = "block";
            document.getElementById("passwordreset").style.display = "none";
        }
    </script>

</head>
<body>

    <div runat="server" class="container">

        <%--<div runat="server" id="typeselct" class="mobile-scale formfield">
                <p class="boxtitle center">
                    Page demo please select the type of form here
                </p>
                <p style="text-align: center;">
                    <input type="button" class="roundbtn" id="newemployee" value="Add New Employee" onclick="addnewemployee()" />
                </p>
                <p style="text-align: center; margin-bottom: 50%;">
                    <input type="button" class="roundbtn" id="forgotpasswordbtn" value="Reset Password" onclick="forgotpasswordbtn()" />
                </p>
            </div>--%>
        <form id="form1" runat="server">

            <div runat="server" id="VTselect" class="mobile-scale formfield">
                <p class="boxtitle center">
                    Please select your preferred verification method
                </p>
                <p style="text-align: center;">
                    <asp:Button runat="server" class="roundbtn" ID="Emailbtn" OnClick="Emailbtn_Click" />
                </p>
                <p style="text-align: center; margin-bottom: 50%;">
                    <asp:Button runat="server" class="roundbtn" ID="SMSbtn" OnClick="SMSbtn_click" />
                </p>
            </div>
            <div runat="server" id="SMSVerify" class=" mobile-scale  formfield">
                <p class="boxtitle" style="text-align: center;">
                    Please enter the verification code which was sent to your phone.
                </p>
                <p class="center">
                    <input type="text" id="SMSCode" name="VCode" class="bkgwhite" placeholder="RK332-92KL" onkeyup="smsshow()" />
                </p>
                <p id="margindelete1" style="text-align: center; margin-bottom: 40%;">
                    <input type="button" class="roundbtn" id="ResendSMS" value="Resend SMS Code" onclick="SMStab()" />
                </p>
                <p id="submitbtn1" style="text-align: center; display: none;">
                    <asp:Button runat="server" class="submitbtn" ID="smsSubmit" Text="SUBMIT" OnClick="smsSubmit_Click" />
                </p>
                <p class="boxtitle" style="font-size: 16px;">
                    If you do not receive an SMS message within the next 30 seconds press the resend code button
                </p>
            </div>

            <div runat="server" id="emailverify" class=" mobile-scale  formfield">
                <p class="boxtitle" style="text-align: center;">
                    Please enter the verification code from your email.
                </p>
                <p class="center">
                    <input type="text" id="EmailCode" name="VCode" class="bkgwhite" placeholder="RK332-92KL" onkeyup="subshow()" />
                </p>
                <p id="margindelete" style="text-align: center;">
                    <input type="button" class="roundbtn" id="ResendEmail" value="Resend Email Code" onclick="Emailtab()" />
                </p>
                <p id="submitbtn" style="text-align: center; display: none;">
                    <asp:Button runat="server" class="submitbtn" ID="emailsubmit" Text="SUBMIT" OnClick="emailsubmit_Click" />
                </p>
                <p class="boxtitle" style="font-size: 16px;">
                    If you do not receive an email within the next 30 seconds press the resend code button
                </p>
            </div>
            <div runat="server" id="validationthank" class="mobile-scale  formfield">
                <p class="boxtitle center" style="padding-bottom: 20%;">
                    Thank you for verifying your account you will now be redirected to enter your new log in information.
                </p>
                <div class="timer" onload="timer(1800)">
                    <div class="time">
                        Time left: <span id="time">Loading...</span>
                    </div>
                </div>
            </div>
            <div runat="server" id="newusersignup" class="mobile-scale formfield">
                <p class="center" style="font-weight: 500; font-size: 50px;">
                    Sign Up
                </p>
                <p class="boxtitle center" style="margin-top: 4% !important;">
                    Please enter a custom username and password
                </p>

                <p class="center">
                    <asp:TextBox ID="txtUsername" TabIndex="2" CssClass="bkgwhite" runat="server" placeholder="New Username" ValidationGroup="vUserPass"></asp:TextBox>                   
                </p>
                <div class="text-muted">
                    <asp:Label ID="lblUsernameInfo" runat="server"
                     Text ="Your Username must have at least 6 characters, cannot contain spaces, must begin with an alpha character, can contain mixed case alpha, digits, and the following special characters: (!@#$%&amp;+?). " Visible="false"></asp:Label>
                 </div>
                <p class="center">
                    <asp:TextBox ID="txtPassword" TabIndex="4" CssClass="bkgwhite" runat="server" TextMode="Password" placeholder="Password" MaxLength="50" ValidationGroup="vUserPass"></asp:TextBox>
                </p>
                <p>
                    <asp:RequiredFieldValidator ID="valPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="<h4>Password</h4>" Display="None" ValidationGroup="vUserPass"></asp:RequiredFieldValidator>
                </p>
                <div class="text-muted">
                    <asp:Label ID="lblPasswordInfo" runat="server"
                      text =" Your Password must have at least 8 characters including one capital, one lowercase, one numeric, and one special character from the following list: (!@#$%&amp;+?)." Visible="false"></asp:Label>
                    </div>
                <p class="center" style="margin-bottom: 10%;">
                                        <asp:TextBox ID="txtConfirmPassword" TabIndex="5" CssClass="bkgwhite" runat="server" TextMode="Password" placeholder="Verify Password" MaxLength="50" ValidationGroup="vUserPass"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="valConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="<h4>Confirm Password</h4>" Display="None" ValidationGroup="vUserPass"></asp:RequiredFieldValidator>
<%--                    <input type="password" id="passwordverifytxt" class="bkgwhite" placeholder="Verify Password" onkeyup="passwordvalidation()" />--%>
                </p>
                <p id="registerbtn" style="text-align: center; padding-bottom: 10%;">
                    <asp:Button runat="server" class="submitbtn" ID="registernew" Text="REGISTER" OnClick="registernew_Click" ValidationGroup="vUserPass" />
                </p>
            </div>
            <div runat="server" id="newusersuccess" class="mobile-scale  formfield">
                <p class="center" style="font-weight: 500; font-size: 50px;">
                    Success!
                </p>
                <p class="boxtitle center" style="padding-bottom: 5%; font-size: 25px;">
                    Your account is now active you can now login with your new login information.               
                </p>
                <p id="signin" style="text-align: center; padding-bottom: 10%;">
                    <input type="button" class="submitbtn" id="signinbtn" value="LOGIN" onclick="login()" />
                </p>

            </div>
            <%--</form>--%>

            <%--RESET PASSWORD SECTION--%>

            <%--First Landing Page--%>
            <%--<form id="forgotpassword" runat="server">--%>
            <div runat="server" id="forgotVD" class="mobile-scale formfield">
                <p class="center" style="font-weight: 500; font-size: 50px;">
                    Forgot Password?
                </p>
                <p id="tab1" class="boxtitle center" style="font-size: 25px; margin-bottom: 10%;">
                    Please select your prefered verification method
                </p>
                <p id="tab2" class="boxtitle center" style="font-size: 25px; margin-bottom: 10%; display: none;">
                    Please enter the phone number associated with your account
                </p>
                <p id="tab3" class="boxtitle center" style="font-size: 25px; margin-bottom: 10%; display: none;">
                    Please enter the email associated with your account
                </p>
                <p style="text-align: center;">
                    <input type="button" class="roundbtn" id="Emailforgotbtn" value="Email" onclick="Emailinput()" />
                </p>
                <p id="emailimput" class="center" style="display: none; font-size: 15px;">
                    <asp:TextBox ID="Emailinputtxt" runat="server" class="bkgwhite" placeholder="Email" onkeyup="emailenter()" />
                </p>
                <p style="text-align: center;">
                    <input type="button" class="roundbtn" id="SMSforgotbtn" value="Phone" onclick="SMSinput()" />
                </p>
                <p id="SMSinput" class="center" style="display: none;">
                    <asp:TextBox ID="SMSinputtxt" runat="server" class="bkgwhite" placeholder="Phone Number" onkeyup="SMSenter()" />
                </p>
                <p id="whitespace">
                    &nbsp;
                </p>
                <p id="Emailsubmit" style="text-align: center; display: none; padding-bottom: 20%;">
                    <asp:Button runat="server" class="submitbtn" ID="RSEmailsubmit" Text="SUBMIT" OnClick="RSEmailsubmit_click" />
                </p>
                <p id="SMSsubmit" style="text-align: center; display: none; padding-bottom: 20%;">
                    <asp:Button runat="server" class="submitbtn" ID="RSSMSsubmit" Text="SUBMIT" OnClick="RSSMSsubmit_Click" />
                </p>
            </div>

            <%--Email verification code entry--%>

            <div runat="server" id="RSemail" class="EmailVerify mobile-scale  formfield">
                <p class="boxtitle" style="text-align: center;">
                    Please enter the verification code from your email.
                </p>
                <p class="center">
                    <input type="text" id="RSEmailCode" name="VCode" class="bkgwhite" placeholder="RK332-92KL" onkeyup="RSsubshow()" />
                </p>
                <p id="RSmargindelete" style="text-align: center;">
                    <input type="button" class="roundbtn" id="RSResendEmail" value="Resend Email Code" onclick="RSEmailtab()" />
                </p>
                <p id="RSsubmitbtn" style="text-align: center; display: none;">
                    <asp:Button runat="server" class="submitbtn" ID="RSemailsub" Text="SUBMIT" OnClick="RSemailsub_click" />
                </p>
                <p class="boxtitle" style="font-size: 16px;">
                    If you do not receive an email within the next 30 seconds press the resend code button
                </p>
            </div>

            <%--SMS verification code entry--%>

            <div runat="server" id="RSphone" class="mobile-scale  formfield">
                <p class="boxtitle" style="text-align: center;">
                    Please enter the verification code which was sent to your phone.
                </p>
                <p class="center">
                    <input type="text" id="RSSMSCode" name="VCode" class="bkgwhite" placeholder="RK332-92KL" onkeyup="RSsmsshow()" />
                </p>
                <p id="RSmargindelete1" style="text-align: center; margin-bottom: 40%;">
                    <input type="button" class="roundbtn" id="RSResendSMS" value="Resend SMS Code" onclick="" />
                </p>
                <p id="RSsubmitbtn1" style="text-align: center; display: none;">
                    <asp:Button runat="server" class="submitbtn" ID="RSsmsSub" Text="SUBMIT" OnClick="RSsmssub_click" />
                </p>
                <p class="boxtitle" style="font-size: 16px;">
                    If you do not receive an SMS message within the next 30 seconds press the resend code button
                </p>
            </div>

            <%--Thank you message --%>

            <div runat="server" id="RSvalidationthank" class="mobile-scale  formfield">
                <p class="boxtitle center" style="padding-bottom: 20%;">
                    Thank you for verifying your account you will now be redirected to enter your new log in information.
                </p>
                <div class="timer" id="timer" onload="timer(1800)">
                    <div class="time">
                        Time left: <span id="RStime">Loading...</span>
                    </div>
                </div>
            </div>

            <%--Password reset section--%>

            <div runat="server" id="passwordreset" class="mobile-scale formfield">
                <p class="center" style="font-weight: 500; font-size: 40px;">
                    Reset Password
                </p>
                <p class="boxtitle center" style="margin-top: 4% !important;">
                    Please enter a new password for your profile
                </p>
                <p class="center">
                    <input type="text" id="usernamelbl" class="bkgwhite" placeholder="Username Label" />
                </p>
                <p class="center">
                    <input type="password" id="newpasswordtxt" class="bkgwhite" placeholder="New Password" />
                </p>
                <p id="RSpassworderror" class="center" style="color: red; font-family: Segoe UI; font-size: 20px; display: none;">
                    * Please make sure your passwords match
                </p>
                <p class="center" style="margin-bottom: 10%;">
                    <input type="password" id="newpasswordverifytxt" class="bkgwhite" placeholder="Verify Password" onkeyup="RSpasswordvalidation()" />
                </p>
                <p id="resetbtn" style="text-align: center; padding-bottom: 10%;">
                    <asp:Button runat="server" class="submitbtn" ID="reset" Text="RESET" OnClick="reset_Click" />
                </p>
            </div>

            <%--Reset success section--%>

            <div runat="server" id="resetsuccess" class="mobile-scale  formfield">
                <p class="center" style="font-weight: 500; font-size: 50px;">
                    Success!
                </p>
                <p class="boxtitle center" style="padding-bottom: 5%; font-size: 25px;">
                    Your password has now been reset you can now click the login button and sign in with your new password               
                </p>
                <p id="signin1" style="text-align: center; padding-bottom: 10%;">
                    <input type="button" class="submitbtn" id="signinbtn1" value="LOGIN" onclick="login()" />
                </p>

            </div>
        </form>
    </div>
    <style>
        @media only screen and (max-width: 1200px) {
            #img1 {
                display: none !important;
            }

            .mobile-scale {
                max-Width: 100% !important;
                margin: auto;
            }

            .formfield {
                min-width: auto;
                border: 1px solid #707070;
                background-image: radial-gradient(white,#F5F5F5);
                border-radius: 10px;
                min-height: 80%;
                width: 90% !important;
                margin: 10% auto !important;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            }

            .boxtitle {
                width: 80% !important;
                font-size: x-large !important;
                font-weight: 300;
                color: #707070;
                margin: 15% auto 12% auto !important;
                font-family: Segoe UI;
            }

            .roundbtn {
                background-image: linear-gradient(#337ab7, #0b68b7, #337ab7);
                border: none;
                color: white;
                padding: 3%;
                width: 80%;
                font-size: 25px;
                margin: auto;
                border-radius: 8px;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            }
        }



        .bkgwhite {
            background-color: aliceblue !important;
            color: dimgray !important;
            padding: 3%;
            text-align: center;
            width: 80%;
            font-size: 20px;
            margin: auto;
            border-radius: 8px;
            border-color: lightgray;
        }



        .form1 {
            margin: auto;
        }

        .roundbtn {
            background-image: linear-gradient(#337ab7, #0b68b7, #337ab7);
            border: none;
            color: white;
            padding: 3%;
            width: 80%;
            font-size: 20px;
            margin: auto;
            border-radius: 8px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        }

            .roundbtn:hover {
                background-image: linear-gradient(#0b68b7, #0a5fa9, #0b68b7) !important;
            }

            .roundbtn:active {
                box-shadow: 0 1px #666;
                transform: translateY(2px);
            }

        body {
            margin: auto;
            max-width: auto;
            background-image: linear-gradient(#f2f2f2, #e6e6e6);
            /*background-image:url(Corporate/assets/images/jim/RiverWalk2.jpg)*/
        }

        .container {
            margin: auto;
            max-width: 100%;
        }

        .formfield {
            min-width: auto;
            border: 1px solid #707070;
            background-image: radial-gradient(white,#F5F5F5);
            border-radius: 10px;
            min-height: 80%;
            width: 20%;
            margin: 10% auto !important;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        }

        .boxtitle {
            width: 80%;
            font-size: xx-large;
            font-weight: 300;
            color: #707070;
            margin: 15% auto 12% auto;
            font-family: Segoe UI;
        }

        .SMSVerify {
            display: none;
        }


        .center {
            text-align: center;
            font-family: Segoe UI;
        }

        #ResendEmail {
            display: block;
        }

        .submitbtn {
            background-image: linear-gradient(#337ab7, #0b68b7, #337ab7);
            border: none;
            color: white;
            padding: 3%;
            width: 80%;
            font-size: 45px;
            margin: auto;
            border-radius: 8px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            cursor: pointer;
            outline: none;
        }

            .submitbtn:hover {
                background-image: linear-gradient(#0b68b7, #0a5fa9, #0b68b7) !important;
            }

            .submitbtn:active {
                background-color: #3e8e41;
                box-shadow: 0 1px #666;
                transform: translateY(2px);
            }

        #submitbtn {
            display: none;
        }

        #margindelete {
            margin: auto auto 40% auto;
        }

        #RSsubmitbtn {
            display: none;
        }

        #RSsubmitbtn1 {
            display: none;
        }

        #RSmargindelete {
            margin: auto auto 40% auto;
        }

        #margindelete1 {
            margin: auto auto 40% auto;
        }

        #RSmargindelete1 {
            margin: auto auto 40% auto;
        }

        #validationthank {
            display: none;
        }

        .timer {
            font-family: Segoe UI;
            font-size: 20px;
            font-weight: 300;
            color: #707070;
            margin: 15% auto 12% auto !important;
            text-align: center;
        }

        #whitespace {
            margin: auto auto 30% auto;
        }

        #validationsubmit {
            margin: 20% auto 20% auto;
        }

        #resetsuccess {
            position: relative;
            animation-name: leftfadein;
            animation-duration: 1s;
            animation-fill-mode: forwards;
        }

        #newusersuccess {
            position: relative;
            animation-name: leftfadein;
            animation-duration: 1s;
            animation-fill-mode: forwards;
        }

        @keyframes leftfadein {
            from {
                right: 400px;
            }

            to {
                right: 0px;
            }
        }
    </style>
</body>

</html>
