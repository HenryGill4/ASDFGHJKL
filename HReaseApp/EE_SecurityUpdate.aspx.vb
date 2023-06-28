Public Class EE_SecurityUpdate
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim sc As New ScreenConfiguration
    Dim strPurpose As String
    Dim secClass As New Security

#Region "Page Events"


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        If sql.HasConnection = True Then
            strPurpose = Request("prp")
            'sc.ScreenSetup(1, "Security")
            If Page.IsPostBack = False Then
                ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                ''              Main Articule
                ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                'It's an update
                lblMainArticleTitle.Text = "Update Security Information"
                lblMainArticleText.Text = "For your security, please confirm your existing password"
                divUpdate.Visible = True
                divUpdateOptions.Visible = False
                divUserName.Visible = False
                divQuestions.Visible = False
            End If
        End If
    End Sub
#End Region

    Protected Sub btnRegister_Click(sender As Object, e As EventArgs) Handles btnRegister.Click

        'Check Username - if it was updated from original then make sure it conforms to standard
        If Not secClass.ValidUserName(txtUsername.Text) And divUserName.Visible = True Then
            lblError.Text = "Please enter a valid Username"
            lblUsernameInfo.CssClass = "text-danger"
            divError.Visible = True

        ElseIf Not secClass.CheckForDuplicateUsernames(Session("CompanyId"), Session("userid"), txtUsername.Text) And divUserName.Visible = True Then
            'check for duplicate usernames in system
            lblError.Text = "Sorry the username <b>" & txtUsername.Text & "</b> is already in user.  Please choose another <i>(i.e. " & txtUsername.Text & "123)</i>"
            Page.SetFocus(txtUsername)
            divError.Visible = True

        ElseIf txtUsername.Text = txtPassword.Text And divUserName.Visible = True Then
            'make sure Username and Password are NOT the same
            lblError.Text = "Sorry your Username and Password cannot match"
            txtPassword.Text = ""
            txtConfirmPassword.Text = ""
            Page.SetFocus(txtPassword)
            divError.Visible = True

        ElseIf txtPassword.Text <> txtConfirmPassword.Text And divUserName.Visible = True Then
            'Make sure passwords match
            txtPassword.Text = ""
            txtConfirmPassword.Text = ""
            lblError.Text = "Sorry your Paswwords do NOT match.  Please try again"
            Page.SetFocus(txtPassword)
            divError.Visible = True

        ElseIf Not secClass.ValidPassword(txtPassword.Text) And divUserName.Visible = True Then
            'Check to see if Password is in proper format
            lblError.Text = "Please enter a Valid Password"
            lblPasswordInfo.CssClass = "text-danger"
            Page.SetFocus(txtPassword)
            divError.Visible = True

        Else
            If divUserName.Visible = True Then
                'Update table info and move on
                secClass.SaveUserSecurityInfo(Session("UserId"), txtUsername.Text, txtPassword.Text, lstSecurity1.SelectedValue, txtAnswer1.Text, lstSecurity2.SelectedValue, txtAnswer2.Text, lstSecurity3.SelectedValue, txtAnswer3.Text)
            Else
                secClass.SaveUserSecurityInfo(Session("UserId"), "BLANK", "BLANK", lstSecurity1.SelectedValue, txtAnswer1.Text, lstSecurity2.SelectedValue, txtAnswer2.Text, lstSecurity3.SelectedValue, txtAnswer3.Text)
            End If

            divSuccess.Visible = True
            divError.Visible = False
            If Session("Admin") = False Then  'EMPLOYEE
                Response.AddHeader("REFRESH", "2;URL=EE_Welcome.aspx")
            Else
                Response.AddHeader("REFRESH", "2;URL=Admin_Welcome.aspx")
            End If

        End If



    End Sub

    'Protected Sub btnSearch_Click(sender As Object, e As ImageClickEventArgs) Handles btnSearch.Click
    '    Dim bCompletedSVP As Boolean
    '    Dim bFoundUserRecord As Boolean

    '    bFoundUserRecord = secClass.FindUserRecord(txtCompany.Text, txtLastName.Text, txtDOB.Text, txtSSN.Text, bCompletedSVP)

    '    If bFoundUserRecord = True And bCompletedSVP = True Then
    '        divAskQuestions.Visible = True
    '        divForgot.Visible = False
    '        lblMainArticleText.Text = "Your User record has been located.  Please answer at least 2 of your Security Questions below to confirm your identity."
    '        Session("UserName") = secClass.UserName
    '        Session("UserId") = secClass.UserID
    '        secClass.GetUserQuestions(Session("UserId"), lblForgotQuestion1.Text, Session("Answer1"), lblForgotQuestion2.Text, Session("Answer2"), lblForgotQuestion3.Text, Session("Answer3"))
    '    ElseIf bFoundUserRecord = True And bCompletedSVP = False Then
    '        divAskQuestions.Visible = False
    '        divForgot.Visible = False
    '        lblMainArticleText.Text = "Your User record has been located, however you never went through the initial New User Registration process.  Please return to the Login page and complete the New User Registration Process."
    '    Else
    '        divAskQuestions.Visible = False
    '        divForgot.Visible = False
    '        lblMainArticleText.Text = "Your user record was not located with information provided below.  Please contact your HR Adminstrator for assistance."
    '    End If
    'End Sub

    'Protected Sub btnCheckAnswers_Click(sender As Object, e As ImageClickEventArgs) Handles btnCheckAnswers.Click
    '    Dim vCorrectAnswers As Integer
    '    lblError.Text = ""
    '    divError.Visible = False
    '    'first check that at least 2 answers have been provided
    '    If (Trim(txtForgotAnswer1.Text) = "" And Trim(txtForgotAnswer2.Text) = "") Or (Trim(txtForgotAnswer1.Text) = "" And Trim(txtForgotAnswer3.Text) = "") Or (Trim(txtForgotAnswer2.Text) = "" And Trim(txtForgotAnswer3.Text) = "") Then
    '        divError.Visible = True
    '        lblError.Text = "Please provide answers to at least two of your security questions."
    '    Else
    '        If Trim(txtForgotAnswer1.Text) <> "" And txtForgotAnswer1.Text = Session("Answer1") Then
    '            vCorrectAnswers = vCorrectAnswers + 1
    '        End If
    '        If Trim(txtForgotAnswer2.Text) <> "" And txtForgotAnswer2.Text = Session("Answer2") Then
    '            vCorrectAnswers = vCorrectAnswers + 1
    '        End If
    '        If Trim(txtForgotAnswer3.Text) <> "" And txtForgotAnswer3.Text = Session("Answer3") Then
    '            vCorrectAnswers = vCorrectAnswers + 1
    '        End If
    '        If vCorrectAnswers > 1 Then
    '            lblMainArticleText.Text = "Please update your Username and Password.  You will be automatically redirected to the Login page in order to enter the system with your new login information."
    '            txtUsername.Text = Session("UserName")
    '            divUserName.Visible = True
    '            btnSaveUserName.Visible = True
    '            divAskQuestions.Visible = False
    '        Else
    '            divError.Visible = True
    '            lblError.Text = "One or more of your answers to the security questions is incorrect.  Please correct and try again."
    '        End If
    '    End If
    'End Sub

    Protected Sub btnSaveUserName_Click(sender As Object, e As ImageClickEventArgs) Handles btnSaveUserName.Click
        lblUsernameInfo.CssClass = "text"
        lblPasswordInfo.CssClass = "text"
        'Check Username - if it was updated from original then make sure it conforms to standard
        If Not secClass.ValidUserName(txtUsername.Text) Then
            lblError.Text = "Please enter a valid Username"
            lblUsernameInfo.CssClass = "text-danger"
            divError.Visible = True

        ElseIf Not secClass.CheckForDuplicateUsernames(Session("CompanyId"), Session("userid"), txtUsername.Text) Then
            'check for duplicate usernames in system
            lblError.Text = "Sorry the username <b>" & txtUsername.Text & "</b> is already in user.  Please choose another <i>(i.e. " & txtUsername.Text & "123)</i>"
            Page.SetFocus(txtUsername)
            divError.Visible = True

        ElseIf txtUsername.Text = txtPassword.Text Then
            'make sure Username and Password are NOT the same
            lblError.Text = "Sorry your Username and Password cannot match"
            txtPassword.Text = ""
            txtConfirmPassword.Text = ""
            Page.SetFocus(txtPassword)
            divError.Visible = True

        ElseIf txtPassword.Text <> txtConfirmPassword.Text And txtPassword.Text <> "" And txtConfirmPassword.Text <> "" Then
            'Make sure passwords match
            txtPassword.Text = ""
            txtConfirmPassword.Text = ""
            lblError.Text = "Sorry your Paswwords do NOT match.  Please try again"
            Page.SetFocus(txtPassword)
            divError.Visible = True

        ElseIf Not secClass.ValidPassword(txtPassword.Text) Then
            'Check to see if Password is in proper format
            lblError.Text = "Please enter a Valid Password"
            lblPasswordInfo.CssClass = "text-danger"
            Page.SetFocus(txtPassword)
            divError.Visible = True

        Else
            'saves new Username and Password only then redirect BACK to Home Page.
            secClass.SaveUserNamePasswordInfo(Session("UserId"), txtUsername.Text, txtPassword.Text)
            divSuccess.Visible = True
            divError.Visible = False
            If Session("Admin") = False Then  'EMPLOYEE
                Response.AddHeader("REFRESH", "2;URL=EE_Welcome.aspx")
            Else
                Response.AddHeader("REFRESH", "2;URL=Admin_Welcome.aspx")
            End If
        End If
    End Sub

    Protected Sub btnConfirmPassword_Click(sender As Object, e As EventArgs) Handles btnConfirmPassword.Click
        If secClass.ConfirmUserPassword(Session("UserId"), txtConfirmUser.Text) Then
            lblMainArticleText.Text = "You may update your Username/Password or update your Security Questions."
            divUpdate.Visible = False
            divUpdateOptions.Visible = True
            divUserName.Visible = False
            divQuestions.Visible = False
            divError.Visible = False
            btnSaveUserName.Visible = True
            secClass.LoadSecurityQuestions(lstSecurity1, lstSecurity2, lstSecurity3)
            lstSecurity1.Items.Insert(0, New ListItem("<< Please Select a Question >>"))
            lstSecurity2.Items.Insert(0, New ListItem("<< Please Select a Question >>"))
            lstSecurity3.Items.Insert(0, New ListItem("<< Please Select a Question >>"))

            'Default Username to existing Default Value
            txtUsername.Text = Session("Username")

        Else
            divError.Visible = True
            lblError.Text = "Sorry the Password you entered does not match our records."
        End If
    End Sub

    Protected Sub rdUpdateUser_CheckedChanged(sender As Object, e As EventArgs) Handles rdUpdateUser.CheckedChanged
        divUpdateOptions.Visible = False
        divUserName.Visible = True
        lblMainArticleText.Text = "Enter a new Username and Password"
    End Sub

    Protected Sub rdUpdateQuestions_CheckedChanged(sender As Object, e As EventArgs) Handles rdUpdateQuestions.CheckedChanged
        divUpdateOptions.Visible = False
        divQuestions.Visible = True
        lblMainArticleText.Text = "Please select 3 Security Questions and populate the Answers."
    End Sub
End Class


