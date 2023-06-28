Public Class EE_ContactUs

    Inherits System.Web.UI.Page
    Dim sql As New SQLControl
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee
    Dim ScreenClass As New ScreenConfiguration
    Dim intCompanyId As Integer
    Dim intEmpId As Integer



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("Timeout") Is Nothing Then
            ' MsgBox("Your Session has Timed out.  You will be redirected to the Login page to reenter your credentials", MsgBoxStyle.Exclamation, "Application Timeout")
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        If sql.HasConnection = True Then


            If Session("Admin") = False Then  'EMPLOYEE
                intCompanyId = Session("CompanyId")
                intEmpId = Session("EmployeeId")
            Else        ' ADMIN
                intCompanyId = Session("ShadowCompanyId")
                intEmpId = Session("ShadowEmployeeId")
            End If

            sc.ScreenSetup(intCompanyId, "ContactUs", Session("UserId"))
            If Not sc.MainArticleTitle Is Nothing Then
                lblMainArticleTitle.Text = sc.MainArticleTitle
                lblMainArticleText.Text = sc.MainArticleText
            End If

            If Page.IsPostBack = False Then
                LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "EE_Profile")
                '  LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmpId, "EE_Profile", Session("Athena"))


                'ScreenClass.DocumentScreenSetup("ContactUs", "LeftDocument1", intCompanyId, intEmpId, lblLeftDocument1Title.Text, ddlLeftDocument1)
                'ScreenClass.DocumentScreenSetup("ContactUs", "LeftDocument2", intCompanyId, intEmpId, lblLeftDocument2Title.Text, ddlLeftDocument2)
                'ScreenClass.DocumentScreenSetup("ContactUs", "LeftDocument3", intCompanyId, intEmpId, lblLeftDocument3Title.Text, ddlLeftDocument3)
                'ScreenClass.DocumentScreenSetup("ContactUs", "RightDocument1", intCompanyId, intEmpId, lblRightDocument1Title.Text, ddlRightDocument1)
                'ScreenClass.DocumentScreenSetup("ContactUs", "RightDocument2", intCompanyId, intEmpId, lblRightDocument2Title.Text, ddlRightDocument2)

            End If
        End If

    End Sub



End Class