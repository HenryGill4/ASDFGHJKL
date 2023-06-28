Partial Class Admin_Employee

    Inherits System.Web.UI.Page
    Dim CompanyClass As New Company
    Dim ec As New Employee
    Dim SecClass As New Security
    Dim sc As New ScreenConfiguration
    Dim bAlreadyFilledMenu As Boolean
    Dim bGotEmployee As Boolean
    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Page.IsPostBack = False Then
            SecClass.SaveUserBrowse(Session("UserId"), "Employee Admin", "Browse")
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_Employee")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), 0, "Admin_Employee", Session("Athena"))

            'Remove Shadow info
            'Session.Remove("ShadowCompanyId")
            Session.Remove("ShadowEmployeeId")
            Session.Remove("ShadowEmployeeName")
            Session.Remove("ShadowEmployee")
            Session.Remove("ShadowCompany")
            Session.RemoveAll()

            If Not Request.Params("screenid") Is Nothing Then
                Session("CurrentScreenId") = Request.Params("screenid")
                '   UpdateScreenBlocks(Session("CurrentPlanTypeId"))
            Else
                Session.Remove("CurrentScreenId")
            End If

            'Go get Screens to load up Navigation
            'Session("dsScreenList") = New DataSet
            'bGotEmployee = Session(intEmployeeId) > 0
            '--Or--
            'IIf(ec.getEEWebConfig(intCompanyId, intEmployeeId, Session("UserId"))

            'If bGotEmployee = False Then

            '    Exit Sub
            'End If
        End If

    End Sub
    'Public Sub FillShadowedEmployeeMenu()
    '    ' Session("Rebuild") = False
    '    If bAlreadyFilledMenu = False Then
    '        bAlreadyFilledMenu = True

    '        Dim dr As DataRow
    '        Dim dt As DataTable
    '        dt = Session("dsTabs").tables(0)
    '        Dim ul1 As HtmlGenericControl = DirectCast(FindControl("ulddtabs"), HtmlGenericControl)
    '        Dim strScreenName As String
    '        Dim strScreenShortDesc As String
    '        Dim strScreenPath As String
    '        Dim strTabName As String
    '        Dim strURLVariable As String

    '        Dim MinResult As Object

    '        MinResult = dt.Compute("MIN(ResultId)", "")


    '        For Each dr In dt.Rows
    '            'GRAB FIRST ScrenId in the table on initial load
    '            If Session("CurrentScreenId") Is Nothing Then
    '                If dr("ResultId") = MinResult Then
    '                    Session("CurrentScreenId") = dr("ScreenId")
    '                    Session("NextScreenId") = dr("NextScreenId")
    '                End If
    '            End If


    '            'Fill up Tabs 
    '            Dim liToAdd As New HtmlGenericControl("li")
    '            Dim anchor As New HtmlGenericControl("a")
    '            strScreenName = dr("ScreenName")
    '            strTabName = "tab" & dr("ScreenId").ToString
    '            strURLVariable = dr("ScreenId")
    '            strScreenShortDesc = dr("ScreenShortDesc")
    '            strScreenPath = dr("ScreenPath")
    '            anchor.Attributes.Add("id", strTabName)
    '            anchor.Attributes.Add("runat", "server")
    '            anchor.Attributes.Add("href", "../Admin_Employee.aspx?screenid=" + strURLVariable)

    '            liToAdd.Controls.Add(anchor)

    '            If dr("ScreenId") = Session("CurrentScreenId") Then
    '                liToAdd.Attributes.Add("class", "active")
    '            End If
    '            ulddtabs.Controls.Add(liToAdd)
    '        Next
    '    End If
    'End Sub
End Class