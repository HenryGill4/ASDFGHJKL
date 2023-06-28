Public Class EE_SecurityRegistration
    Inherits System.Web.UI.Page
    Dim sql As New SQLControl
    Dim sc As New ScreenConfiguration
    Dim strPurpose As String
    Dim secClass As New Security
    Dim c As New Company

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            ' MsgBox("Your Session has Timed out.  You will be redirected to the Login page to reenter your credentials", MsgBoxStyle.Exclamation, "Application Timeout")
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        strPurpose = Request("prp")
        sc.ScreenSetup(1, "Security", Session("UserId"))

        If InStr(Request.Url.ToString, "local") = 0 AndAlso InStr(Request.Url.ToString, "hrease-dev") = 0 Then
            txtCompany.Text = sc.AliasInURL(Server.HtmlEncode(Request.ServerVariables("SERVER_NAME")), ".")
        Else
            txtCompany.Text = "abelhr"
        End If

        If Page.IsPostBack = False Then
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            ''                    SLIDER
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'If Not sc.Slider1Image Is Nothing Then
            '    imgSliderImage1.ImageUrl = sc.Slider1Image
            '    imgSliderImage1.NavigateUrl = sc.Slider1Link
            '    lblSlider1Title.Text = sc.Slider1Title
            '    lblSlider1text.Text = sc.Slider1Text
            '    'lnkSlider1.NavigateUrl = sc.Slider1Link                   
            'End If


            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            ''              Main Articule
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

            'Fill these regardless
            'Load Drop Down Lists
            Dim SecurityClass As New Security
            SecurityClass.LoadSecurityQuestions(lstSecurity1, lstSecurity2, lstSecurity3)
            lstSecurity1.Items.Insert(0, New ListItem("<< Please Select a Question >>"))
            lstSecurity2.Items.Insert(0, New ListItem("<< Please Select a Question >>"))
            lstSecurity3.Items.Insert(0, New ListItem("<< Please Select a Question >>"))


            If strPurpose = "New" Then
                lblMainArticleTitle.Text = "New User Registration"
                lblMainArticleText.Text = "<h4>Please indicate your Login Type</h4>"
            Else          'strPurpose = "Forgot"
                lblMainArticleTitle.Text = "Reset Username/Password"
                lblMainArticleText.Text = "Please indicate your Login Type"
            End If

            divLoginType.Visible = True
            divForgot.Visible = False
            divAskQuestions.Visible = False
            divUserName.Visible = False
            divQuestions.Visible = False
            'default focus and primary button
            Page.Form.DefaultButton = btnLoginTypeNext.UniqueID
        End If
    End Sub

    Protected Sub btnLoginTypeNext_Click(sender As Object, e As ImageClickEventArgs) Handles btnLoginTypeNext.Click
        If rdEmployee.Checked Then
            divLoginTypeAdmin.Visible = False
            txtEmail.Text = "Employee"
            If c.GetCompanyOnboarding(Session("LoginCompanyId")) Then
                divRegistrationType.Visible = True
                divOnboarding.Visible = False
                divManualSearch.Visible = False
            Else    'not Onboarding client
                divRegistrationType.Visible = True
                divOnboarding.Visible = False
                divManualSearch.Visible = False
            End If

        Else ' Admin
            divRegistrationType.Visible = False
            divOnboarding.Visible = False
            divLoginTypeEmployee.Visible = False
            'filling these so that the validator doesn't show these as empty
            txtSSN.Text = "9999"
            txtDOB.Text = "01/01/1900"
        End If

        lblMainArticleText.Text = "Please fill in the required information in order to locate your user record. <font color='red'>Note that the Company Code will be provided by your HR Administrator. </font>"
        divLoginType.Visible = False
        divForgot.Visible = True
        divAskQuestions.Visible = False
        divUserName.Visible = False
        divQuestions.Visible = False
    End Sub

#Region "Confirm User"
    Protected Sub btnSearchClick()
        Dim bCompletedSVP As Boolean
        Dim bFoundUserRecord As Boolean
        divError.Visible = False
        bFoundUserRecord = secClass.GetUserRecord(txtCompany.Text, txtLastName.Text, txtDOB.Text, txtSSN.Text, txtEmail.Text, "Empty", bCompletedSVP)

        If bFoundUserRecord = True And bCompletedSVP = True Then
            divAskQuestions.Visible = True
            divForgot.Visible = False
            lblMainArticleText.Text = "Your User record has been located.  Please answer at least 2 of your Security Questions below to confirm your identity."
            Session("CompanyId") = secClass.CompanyID
            Session("Userid") = secClass.UserID
            Session("Username") = secClass.UserName
            Session("EmployeeId") = secClass.EmployeeID
            Session("EmployeeName") = secClass.EmployeeName
            Session("Group") = secClass.GroupName
            Session("Admin") = secClass.Enroller
            Session("AdminId") = secClass.AdminId
            Session("AdminName") = secClass.AdminName
            Session("Athena") = secClass.Athena
            Session("Onboarding") = secClass.Onboarding
            Session("Logo") = secClass.Logo

            If secClass.EmployeeName <> "" Then
                Session("DisplayName") = secClass.EmployeeName
            Else
                Session("DisplayName") = secClass.AdminName
            End If
            secClass.GetUserQuestions(Session("UserId"), lblForgotQuestion1.Text, Session("Answer1"), lblForgotQuestion2.Text, Session("Answer2"), lblForgotQuestion3.Text, Session("Answer3"))


        ElseIf bFoundUserRecord = True Then
            'And bCompletedSVP = False Then

            divAskQuestions.Visible = False
            divForgot.Visible = False
            divUserName.Visible = True
            divQuestions.Visible = True
            lblMainArticleText.Text = "Your record has been located.  Please complete the New User Registration Process."
            Session("CompanyId") = secClass.CompanyID
            Session("Userid") = secClass.UserID
            Session("Username") = secClass.UserName
            Session("EmployeeId") = secClass.EmployeeID
            Session("EmployeeName") = secClass.EmployeeName
            Session("Group") = secClass.GroupName
            Session("Admin") = secClass.Enroller
            Session("AdminId") = secClass.AdminId
            Session("AdminName") = secClass.AdminName
            Session("Athena") = secClass.Athena
            Session("Onboarding") = secClass.Onboarding
            Session("Logo") = secClass.Logo

            If secClass.EmployeeName <> "" Then
                Session("DisplayName") = secClass.EmployeeName
            Else
                Session("DisplayName") = secClass.AdminName
            End If
        Else
            divError.Visible = True
            lblError.Text = "Your user record was not located with information provided below.<br>Please ensure that you've entered your information correctly and contact your HR Adminstrator if you need further assistance."
        End If
    End Sub

    Protected Sub imgSearchRegEmp_Click(sender As Object, e As ImageClickEventArgs)
        Dim bCompletedSVP As Boolean
        Dim bFoundUserRecord As Boolean
        divError.Visible = False
        bFoundUserRecord = secClass.GetUserRecord(txtCompany.Text, txtLastName.Text, txtDOB.Text, txtSSN.Text, txtEmail.Text, txtRegistrationKey.Text, bCompletedSVP)

        If bFoundUserRecord = True And bCompletedSVP = False Then
            divAskQuestions.Visible = False
            divForgot.Visible = False
            divUserName.Visible = True
            divQuestions.Visible = True
            lblMainArticleText.Text = "Your record has been located.  Please complete the New User Registration Process."
            Session("CompanyId") = secClass.CompanyID
            Session("Userid") = secClass.UserID
            Session("Username") = secClass.UserName
            Session("EmployeeId") = secClass.EmployeeID
            Session("EmployeeName") = secClass.EmployeeName
            Session("Group") = secClass.GroupName
            Session("Admin") = secClass.Enroller
            Session("AdminId") = secClass.AdminId
            Session("AdminName") = secClass.AdminName
            Session("Athena") = secClass.Athena
            Session("Logo") = secClass.Logo
            Session("Onboarding") = secClass.Onboarding

            If secClass.EmployeeName <> "" Then
                Session("DisplayName") = secClass.EmployeeName
            Else
                Session("DisplayName") = secClass.AdminName
            End If
        Else
            divError.Visible = True
            lblError.Text = "Your user record was not located with the Registration Key provided below.<br>Please ensure that you've entered your Key correctly and contact your HR Adminstrator if you need further assistance."
        End If
    End Sub
#End Region

#Region "Check Answers to Security Questions"
    Protected Sub btnCheckAnswers_Click(sender As Object, e As ImageClickEventArgs) Handles btnCheckAnswers.Click
        Dim vCorrectAnswers As Integer
        lblError.Text = ""
        divError.Visible = False
        'first check that at least 2 answers have been provided
        If (Trim(txtForgotAnswer1.Text) = "" And Trim(txtForgotAnswer2.Text) = "") Or (Trim(txtForgotAnswer1.Text) = "" And Trim(txtForgotAnswer3.Text) = "") Or (Trim(txtForgotAnswer2.Text) = "" And Trim(txtForgotAnswer3.Text) = "") Then
            divError.Visible = True
            lblError.Text = "Please provide answers to at least two of your security questions."
        Else
            If Trim(txtForgotAnswer1.Text) <> "" And txtForgotAnswer1.Text = Session("Answer1") Then
                vCorrectAnswers = vCorrectAnswers + 1
            End If
            If Trim(txtForgotAnswer2.Text) <> "" And txtForgotAnswer2.Text = Session("Answer2") Then
                vCorrectAnswers = vCorrectAnswers + 1
            End If
            If Trim(txtForgotAnswer3.Text) <> "" And txtForgotAnswer3.Text = Session("Answer3") Then
                vCorrectAnswers = vCorrectAnswers + 1
            End If

            If vCorrectAnswers > 1 Then
                lblMainArticleText.Text = "Please update your Username and Password."
                txtUsername.Text = Session("UserName")
                divUserName.Visible = True
                btnSaveUserName.Visible = True
                divAskQuestions.Visible = False
            Else
                divError.Visible = True
                lblError.Text = "One or more of your answers to the security questions is incorrect.  Please correct and try again."
            End If
        End If
    End Sub



#End Region


    Protected Sub btnSaveUserName_Click(sender As Object, e As ImageClickEventArgs) Handles btnSaveUserName.Click
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
            'saves new Username and Password only then redirect BACK to Login Page.
            secClass.SaveUserNamePasswordInfo(Session("UserId"), txtUsername.Text, txtPassword.Text)
            divSuccessForgotPassword.Visible = True
            divError.Visible = False



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

            divSuccessRegistration.Visible = True
            divError.Visible = False


            If Session("Admin") = 0 Then
                If Session("Onboarding") = 0 Then
                    Response.AddHeader("REFRESH", "2;URL=EE_Welcome.aspx")
                Else
                    Response.AddHeader("REFRESH", "2;URL=EE_UserAgreement.aspx")
                End If

            Else
                Response.AddHeader("REFRESH", "2;URL=Admin_Welcome.aspx")
            End If
        End If



    End Sub

    Protected Sub imgNextEmpType_Click(sender As Object, e As ImageClickEventArgs)
        If rdOnboarding.SelectedIndex > -1 Then
            If rdOnboarding.SelectedValue = 1 Then
                divOnboarding.Visible = True
                divManualSearch.Visible = False
                divRegistrationType.Visible = False

            Else
                divOnboarding.Visible = False
                divManualSearch.Visible = True
                divRegistrationType.Visible = False
            End If
        Else
            divError.Visible = True
            lblError.Text = "<br/>Please select <b>Yes</b> or <b>No</b> "
        End If
    End Sub


End Class
