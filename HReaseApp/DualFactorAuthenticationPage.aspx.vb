Imports System.Data.SqlClient
Public Class DualFactorAuthenticationPage
    Inherits System.Web.UI.Page
    Dim sql As New SQLControl
    Dim sc As New ScreenConfiguration
    Dim strPurpose As String
    Dim ec As Employee
    Dim secClass As New Security
    Dim c As New Company
    Dim intEmployeeId As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''If Session("Timeout") Is Nothing Then
        ''    ' MsgBox("Your Session has Timed out.  You will be redirected to the Login page to reenter your credentials", MsgBoxStyle.Exclamation, "Application Timeout")
        ''    Session("Timeout") = True
        ''    Response.Redirect("CorporateLogin.aspx")
        ''End If

        strPurpose = Request("prp")
        sc.ScreenSetup(1, "Security", Session("UserId"))

        'If InStr(Request.Url.ToString, "local") = 0 AndAlso InStr(Request.Url.ToString, "hrease-dev") = 0 Then
        '    txtCompany.Text = sc.AliasInURL(Server.HtmlEncode(Request.ServerVariables("SERVER_NAME")), ".")
        'Else
        '    txtCompany.Text = "abelhr"
        'End If

        If Page.IsPostBack = False Then
            If strPurpose = "Forgot" Then
                pagetitle.Text = "Forgot Password"
                forgotVD.Visible = True
                VTselect.Visible = False
                RSvalidationthank.Visible = False
                RSemail.Visible = False
                RSphone.Visible = False
                SMSVerify.Visible = False
                emailverify.Visible = False
                passwordreset.Visible = False
                resetsuccess.Visible = False
                newusersignup.Visible = False
                newusersuccess.Visible = False
                validationthank.Visible = False

            ElseIf strPurpose = "" Then
                forgotVD.Visible = False
                VTselect.Visible = False
                RSvalidationthank.Visible = False
                RSemail.Visible = False
                RSphone.Visible = False
                SMSVerify.Visible = False
                emailverify.Visible = False
                passwordreset.Visible = False
                resetsuccess.Visible = False
                newusersignup.Visible = False
                newusersuccess.Visible = False
                validationthank.Visible = False
            End If
            If strPurpose = "New" Then
                Emailbtn.Text = "Henry********@gmail.com"
                SMSbtn.Text = "(813)***-****"
                VTselect.Visible = True
                forgotVD.Visible = False
                RSvalidationthank.Visible = False
                RSemail.Visible = False
                RSphone.Visible = False
                SMSVerify.Visible = False
                emailverify.Visible = False
                passwordreset.Visible = False
                resetsuccess.Visible = False
                newusersignup.Visible = False
                newusersuccess.Visible = False
                validationthank.Visible = False
            ElseIf strPurpose = "" Then
                forgotVD.Visible = False
                VTselect.Visible = False
                RSvalidationthank.Visible = False
                RSemail.Visible = False
                RSphone.Visible = False
                SMSVerify.Visible = False
                emailverify.Visible = False
                passwordreset.Visible = False
                resetsuccess.Visible = False
                newusersignup.Visible = False
                newusersuccess.Visible = False
                validationthank.Visible = False
            End If

        End If
    End Sub
    Protected Sub Emailbtn_Click(sender As Object, e As EventArgs) Handles Emailbtn.Click
        VTselect.Visible = False
        emailverify.Visible = True
    End Sub
    Protected Sub SMSbtn_click(sender As Object, e As EventArgs) Handles SMSbtn.Click
        VTselect.Visible = False
        SMSVerify.Visible = True
    End Sub
    Protected Sub emailsubmit_Click(sender As Object, e As EventArgs) Handles emailsubmit.Click
        newusersignup.Visible = True
        emailverify.Visible = False

    End Sub
    Protected Sub smsSubmit_Click(sender As Object, e As EventArgs) Handles smsSubmit.Click
        newusersignup.Visible = True
        SMSVerify.Visible = False

    End Sub
    Protected Sub registernew_Click(sender As Object, e As EventArgs) Handles reset.Click
        newusersignup.Visible = False
        newusersuccess.Visible = True
        resetsuccess.Visible = False
        If Not secClass.ValidUserName(txtUsername.Text) Then
            'lblError.Text = "Please enter a valid Username"
            lblUsernameInfo.CssClass = "text-danger"
            'divError.Visible = True

        ElseIf Not secClass.CheckForDuplicateUsernames(Session("CompanyId"), Session("userid"), txtUsername.Text) Then
            'check for duplicate usernames in system
            'lblError.Text = "Sorry the username <b>" & txtUsername.Text & "</b> is already in user.  Please choose another <i>(i.e. " & txtUsername.Text & "123)</i>"
            Page.SetFocus(txtUsername)
            'divError.Visible = True

        ElseIf txtUsername.Text = txtPassword.Text Then
            'make sure Username and Password are NOT the same
            'lblError.Text = "Sorry your Username and Password cannot match"
            txtPassword.Text = ""
            txtConfirmPassword.Text = ""
            Page.SetFocus(txtPassword)
            'divError.Visible = True

        ElseIf txtPassword.Text <> txtConfirmPassword.Text And txtPassword.Text <> "" And txtConfirmPassword.Text <> "" Then
            'Make sure passwords match
            txtPassword.Text = ""
            txtConfirmPassword.Text = ""
            'lblError.Text = "Sorry your Paswwords do NOT match.  Please try again"
            Page.SetFocus(txtPassword)
            'divError.Visible = True

        ElseIf Not secClass.ValidPassword(txtPassword.Text) Then
            'Check to see if Password is in proper format
            'lblError.Text = "Please enter a Valid Password"
            lblPasswordInfo.CssClass = "text-danger"
            Page.SetFocus(txtPassword)
            'divError.Visible = True

        Else
            'saves new Username and Password only then redirect BACK to Login Page.
            secClass.SaveUserNamePasswordInfo(Session("UserId"), txtUsername.Text, txtPassword.Text)
            'divSuccessForgotPassword.Visible = True
            'divError.Visible = False



            If Session("Admin") = 0 Then
                If Session("Onboarding") = False Then
                    Response.AddHeader("REFRESH", "2;URL=EE_Welcome.aspx")
                Else
                    Response.AddHeader("REFRESH", "2;URL=EE_UserAgreement.aspx")
                End If
            Else
                Response.AddHeader("REFRESH", "2;URL=Admin_Welcome.aspx")
            End If

        End If
    End Sub
    Protected Sub RSSMSsubmit_Click(sender As Object, e As EventArgs) Handles RSSMSsubmit.Click
        RSphone.Visible = True
        forgotVD.Visible = False

        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()
        objParam = New SqlParameter("@SMSinput", SMSinputtxt.Text)
        aryParams.Add(objParam)

        objDataSet = sqlCon.CreateDataSet("usp_DFA_Validate", aryParams)
        sqlCon.CloseConn()


    End Sub
    Protected Sub RSEmailsubmit_click(sender As Object, e As EventArgs) Handles RSEmailsubmit.Click


        RSemail.Visible = True
        forgotVD.Visible = False


        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()
        objParam = New SqlParameter("@EmailInput", Emailinputtxt.Text)
        aryParams.Add(objParam)

        objDataSet = sqlCon.CreateDataSet("usp_DFA_Validate", aryParams)
        sqlCon.CloseConn()


    End Sub
    Protected Sub RSemailsub_click(sender As Object, e As EventArgs) Handles RSemailsub.Click
        passwordreset.Visible = True
        RSemail.Visible = False

    End Sub
    Protected Sub RSsmssub_click(sender As Object, e As EventArgs) Handles RSsmsSub.Click
        passwordreset.Visible = True
        RSphone.Visible = False

    End Sub
    Protected Sub reset_Click(sender As Object, e As EventArgs) Handles reset.Click
        passwordreset.Visible = False
        resetsuccess.Visible = True
        newusersuccess.Visible = False
    End Sub
End Class