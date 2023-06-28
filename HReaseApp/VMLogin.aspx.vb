Imports System.Data
Partial Class VMLogin

    Inherits System.Web.UI.Page

    ReadOnly sql As New SQLControl
    ReadOnly sc As New ScreenConfiguration
    ReadOnly c As New Company

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Test for Timeout BEFORE you remove all existing Session Variables (tee hee)
        If Session("Timeout") = True Then
            'show the alert
            TimeoutMessage.Visible = True
        End If

        'Just in CASE, remove All existing Session Variables
        Session.RemoveAll()
        Session("Timeout") = False
        Session("ScreenName") = "VMLogin"


        Dim CompanyAlias As String
        Dim bOkayToUsAlias As Boolean
        CompanyAlias = ""

        If sql.HasConnection = True Then
            ' get CompanyId from alias (if not known then it will default to HRE)
            If InStr(Request.Url.ToString, "local") = 0 And InStr(Request.Url.ToString, "hrease-dev") = 0 Then
                CompanyAlias = sc.AliasInURL(Server.HtmlEncode(Request.ServerVariables("SERVER_NAME")), ".")
                'LiteralTopMenu.Text = sc.BuildCorporateSiteMenu(CompanyAlias, Session("ScreenName"))
                If c.GetCompanyIdfromAlias(CompanyAlias, Session("LoginCompanyId")) = False Then
                    Session("LoginCompanyId") = 250
                    bOkayToUsAlias = False
                Else
                    bOkayToUsAlias = True

                End If

            ElseIf InStr(Request.Url.ToString, "hrease-dev") <> 0 Then
                CompanyAlias = "antsul"
                'LiteralTopMenu.Text = sc.BuildCorporateSiteMenu(CompanyAlias, Session("ScreenName"))
                Session("LoginCompanyId") = 758
                bOkayToUsAlias = True

            ElseIf InStr(Request.Url.ToString, "local") <> 0 Then
                CompanyAlias = "antsul"
                'LiteralTopMenu.Text = sc.BuildCorporateSiteMenu(CompanyAlias, Session("ScreenName"))
                Session("LoginCompanyId") = 758
                bOkayToUsAlias = True

                CompanyCodeText.Text = "antsul"
                UsernameText.Text = "charlie2@gmail.com"
                PasswordText.Text = "FXSODAR5"
                Session("VM") = True

            Else
                'LiteralTopMenu.Text = sc.BuildMenu(True, Session("ScreenName"))
                Session("LoginCompanyId") = 250
                bOkayToUsAlias = False
            End If

            sc.ScreenSetup(Session("LoginCompanyId"), Session("ScreenName"), Session("UserId"))
            c.GetCompanyInfo(Session("LoginCompanyId"), 0)

        End If

        If Page.IsPostBack = False Then

            CompanyLogoImage.ImageUrl = c.Logo

            If sc.MainArticleTitle IsNot Nothing Then
                MainArticleTitleLabel.Text = sc.MainArticleTitle
                MainArticleTextLabel.Text = sc.MainArticleText
            End If
            If bOkayToUsAlias = True Then
                CompanyCodeText.Text = CompanyAlias
            End If
            If CompanyCodeText.Text = "" Then
                Page.SetFocus(CompanyCodeText)
            Else
                Page.SetFocus(UsernameText)
            End If

            'lblCompanyInSession.Text = txtCompanyCode.Text
        End If

        Page.Form.DefaultButton = LoginButton.UniqueID

        CompanyIdLabel.Text = Session("LoginCompanyId")
        AliasLabel.Text = CompanyAlias
    End Sub

    Protected Sub LoginButton_Click(sender As Object, e As EventArgs) Handles LoginButton.Click
        Dim secClass As New Security
        Dim booLogin As Boolean
        ErrorMessage.Visible = False
        SuccessMessage.Visible = False
        TimeoutMessage.Visible = False

        booLogin = secClass.UserLogin(CompanyCodeText.Text, UsernameText.Text, PasswordText.Text, "VMLogin")

        If booLogin = True Then

            Session("CompanyId") = secClass.CompanyID
            Session("Userid") = secClass.UserID
            Session("EmployeeId") = secClass.EmployeeID
            Session("EmployeeName") = secClass.EmployeeName
            Session("Group") = secClass.GroupName
            Session("AdminId") = secClass.AdminId
            Session("AdminName") = secClass.AdminName
            Session("Admin") = secClass.Enroller
            Session("Athena") = secClass.Athena
            Session("ShowNotice") = secClass.ShowNotice
            Session("Logo") = secClass.Logo
            Session("Onboarding") = secClass.Onboarding
            Session("LandingPage") = secClass.LandingPage

            ErrorMessage.Visible = False
            SuccessMessage.Visible = True
            If secClass.EmployeeName <> "" Then
                Session("DisplayName") = secClass.EmployeeName
            Else
                Session("DisplayName") = secClass.AdminName
            End If
            If Session("Admin") = 0 Then
                Response.AddHeader("REFRESH", "0;URL=" + Session("LandingPage"))
            Else
                Response.AddHeader("REFRESH", "0;URL=Admin_Welcome.aspx")
            End If

        Else
            ErrorMessage.Visible = True
            SuccessMessage.Visible = False
        End If
    End Sub
End Class
