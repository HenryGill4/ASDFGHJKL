Imports System.Data
Partial Class CorporateLogin

    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim sc As New ScreenConfiguration
    Dim c As New Company

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Test for Timeout BEFORE you remove all existing Session Variables (tee hee)
        If Session("Timeout") = True Then
            'show the alert
            divTimeout.Visible = True
        End If

        'Just in CASE, remove All existing Session Variables
        Session.RemoveAll()
        Session("Timeout") = False
        Session("ScreenName") = "CorporateLogin"


        Dim CompanyAlias As String
        Dim bOkayToUsAlias As Boolean
        CompanyAlias = ""

        If sql.HasConnection = True Then
            ' get CompanyId from alias (if not known then it will default to HRE)
            If InStr(Request.Url.ToString, "local") = 0 And InStr(Request.Url.ToString, "hrease-dev") = 0 Then
                CompanyAlias = sc.AliasInURL(Server.HtmlEncode(Request.ServerVariables("SERVER_NAME")), ".")
                LiteralTopMenu.Text = sc.BuildCorporateSiteMenu(CompanyAlias, Session("ScreenName"))
                If c.GetCompanyIdfromAlias(CompanyAlias, Session("LoginCompanyId")) = False Then
                    Session("LoginCompanyId") = 250
                    bOkayToUsAlias = False
                Else
                    bOkayToUsAlias = True

                End If

            ElseIf InStr(Request.Url.ToString, "hrease-dev") <> 0 Then
                CompanyAlias = "hre"
                LiteralTopMenu.Text = sc.BuildCorporateSiteMenu(CompanyAlias, Session("ScreenName"))
                Session("LoginCompanyId") = 250
                bOkayToUsAlias = True

            ElseIf InStr(Request.Url.ToString, "local") <> 0 Then
                CompanyAlias = "Hrease"
                LiteralTopMenu.Text = sc.BuildCorporateSiteMenu(CompanyAlias, Session("ScreenName"))
                Session("LoginCompanyId") = 250
                bOkayToUsAlias = True

                Else
                LiteralTopMenu.Text = sc.BuildMenu(True, Session("ScreenName"))
                Session("LoginCompanyId") = 250
                bOkayToUsAlias = False
            End If

            sc.ScreenSetup(Session("LoginCompanyId"), Session("ScreenName"), Session("UserId"))
            c.GetCompanyInfo(Session("LoginCompanyId"), 0)

        End If

            If Page.IsPostBack = False Then

            imgCompanyLogo.ImageUrl = c.Logo

            If Not sc.MainArticleTitle Is Nothing Then
                lblMainArticleTitle.Text = sc.MainArticleTitle
                lblMainArticleText.Text = sc.MainArticleText
                End If
                If bOkayToUsAlias = True Then
                    txtCompanyCode.Text = CompanyAlias
                End If
                If txtCompanyCode.Text = "" Then
                    Page.SetFocus(txtCompanyCode)
                Else
                    Page.SetFocus(txtUsername)
                End If

            'lblCompanyInSession.Text = txtCompanyCode.Text
        End If

        Page.Form.DefaultButton = btnLogin.UniqueID

        lblCompanyId.Text = Session("LoginCompanyId")
        lblAlias.Text = CompanyAlias
    End Sub

    Protected Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click
        Dim secClass As New Security
        Dim booLogin As Boolean
        divError.Visible = False
        divSuccess.Visible = False
        divTimeout.Visible = False

        booLogin = secClass.UserLogin(txtCompanyCode.Text, txtUsername.Text, txtPassword.Text, "CorporateLogin")

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

            divError.Visible = False
            divSuccess.Visible = True
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
            divError.Visible = True
            divSuccess.Visible = False
        End If
    End Sub
End Class
