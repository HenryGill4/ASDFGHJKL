Partial Class Admin_Benefit
    Inherits System.Web.UI.Page
    Dim ec As New Employee
    Dim SecClass As New Security
    Dim sc As New ScreenConfiguration

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Page.IsPostBack = False Then
            SecClass.SaveUserBrowse(Session("UserId"), "Benefit Admin", "Browse")
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_Benefit")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), 0, "Admin_Benefit", Session("Athena"))

            'Remove Shadow info
            'Session.Remove("ShadowCompanyId")
            Session.Remove("ShadowEmployeeId")
            Session.Remove("ShadowEmployeeName")
            Session.Remove("ShadowEmployee")
            Session.Remove("ShadowCompany")
            Session.RemoveAll()
        End If

    End Sub
End Class