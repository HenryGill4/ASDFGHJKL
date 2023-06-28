Imports System
Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient

Partial Class Admin_EESelect
    Inherits System.Web.UI.Page
    Dim ec As New Employee
    Dim s As New Security
    Dim c As New Company
    Dim sc As New ScreenConfiguration

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer

    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Dim strAdminCompanyName As String
    Dim strParentCompanyName As String
    Dim strChildCompanyName As String
    Dim intShadowCompanyId As Integer

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Remove Shadow info
        'Session.Remove("ShadowCompanyId")
        Session.Remove("ShadowEmployeeId")
        Session.Remove("ShadowEmployeeName")
        Session.Remove("ShadowEmployee")
        Session.Remove("ShadowCompany")

        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        intCompanyId = Session("ShadowCompanyId")
        intEmployeeId = Session("ShadowEmployeeId")

        'Change these on each page
        strScreenName = "EmployeeSearch"
        strScreenShortDesc = "Employee Admin"

        If Page.IsPostBack = False Then
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_EESelect")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, "Admin_EESelect", Session("Athena"))

            Session("SearchPage") = True

            'Set Defaults
            intShadowCompanyId = Session("ShadowCompanyId")
            strAdminCompanyName = "ALL"
            strParentCompanyName = "ALL"
            strChildCompanyName = "ALL"
            Session("ListType") = "Company"
            Session("ListLevel") = ""
            Session("ActiveCompany") = True
            Session("ActiveEmployee") = True
            Session("OrderByCompanyNumber") = False

            If Not Session("ShadowCompanyId") Is Nothing Then
                intShadowCompanyId = Session("ShadowCompanyId")
            Else
                Session("ShadowCompanyId") = 0
                intShadowCompanyId = 0
            End If

            Searchtxt.Enabled = True
            FiltersDiv.Visible = False


            FillCompanyLists()

            If ddlAdminCompany.Items.Count > 1 Then
                lblAdminCompany.Visible = True
                ddlAdminCompany.Visible = True
                'chkActiveCompany.Visible = True
            End If

            If ddlParentCompany.Items.Count > 1 Then
                lblParentCompany.Visible = True
                ddlParentCompany.Visible = True
                'chkActiveCompany.Visible = True
            End If

            If ddlCompany.Items.Count < 2 Then
                lblParentCompany.Visible = False
                ddlParentCompany.Visible = False
                'chkActiveCompany.Visible = False
            End If

            GetEmployees()

        End If

        'Me.Form.DefaultButton = btnEmplNumSearch.UniqueID


    End Sub

#Region "Fill up Company Lists"
    Private Sub FillCompanyLists()
        Session("ds") = New DataSet

        c.LoadCompanyList(Session("UserId"), intShadowCompanyId, Session("ListType"), Session("Listlevel"), Session("ActiveCompany"), Session("ActiveEmployee"), Session("OrderByCompanyNumber"), Session("ds"))

        'Get Admin Drop Down
        ddlAdminCompany.DataSource = Session("ds").tables(0)
        ddlAdminCompany.DataBind()

        If ddlAdminCompany.Items.Count > 1 Then
            ddlAdminCompany.Items.Insert(0, New ListItem("ALL"))
        End If

        If Session("ListLevel") = "Admin" Then

            'if the Company session variable is found in the drop down then select it, if not, select ALL
            If Not ddlAdminCompany.Items.FindByValue(Session("ShadowCompanyId")) Is Nothing And Not Session("ShadowCompanyId") Is Nothing Then
                ddlAdminCompany.SelectedValue = Session("ShadowCompanyId")
                strAdminCompanyName = ddlAdminCompany.SelectedItem.Text
                If ddlAdminCompany.SelectedValue = "ALL" Then
                    intShadowCompanyId = 0
                    Session("ShadowCompanyId") = 0
                Else
                    intShadowCompanyId = ddlAdminCompany.SelectedValue

                End If

            Else
                ddlAdminCompany.Items(0).Selected = True

            End If
        End If

        'Get Parent Drop Down List
        ddlParentCompany.DataSource = Session("ds").tables(1)
        ddlParentCompany.DataBind()

        If ddlParentCompany.Items.Count > 1 Then
            ddlParentCompany.Items.Insert(0, New ListItem("ALL"))
        End If

        If Session("ListLevel") = "Parent" Then

            'if the Company session variable is found in the drop down then select it, if not, select ALL
            If Not ddlParentCompany.Items.FindByValue(Session("ShadowCompanyId")) Is Nothing And Not Session("ShadowCompanyId") Is Nothing Then
                ddlParentCompany.SelectedValue = Session("ShadowCompanyId")
                strParentCompanyName = ddlParentCompany.SelectedItem.Text
                If ddlParentCompany.SelectedValue = "ALL" Then
                    intShadowCompanyId = 0
                    Session("ShadowCompanyId") = 0
                Else
                    intShadowCompanyId = ddlParentCompany.SelectedValue

                End If

            ElseIf lblParentCompany.Visible = True Then
                ddlParentCompany.Items(0).Selected = True

                If ddlParentCompany.SelectedValue = "ALL" And Session("ShadowCompanyId") Is Nothing Then
                    intShadowCompanyId = 0
                    Session("ShadowCompanyId") = 0
                Else
                    intShadowCompanyId = ddlParentCompany.SelectedValue

                End If

            End If

        End If

        'Get Child Drop Down List
        ddlCompany.DataSource = Session("ds").tables(2)
        ddlCompany.DataBind()

        If ddlCompany.Items.Count > 1 Then
            ddlCompany.Items.Insert(0, New ListItem("ALL"))
        End If

        If Session("ListLevel") = "Child" Or Session("ListLevel") = "" Then
            'if the Company session variable is found in the drop down then select it, if not, select ALL
            If Not ddlCompany.Items.FindByValue(Session("ShadowCompanyId")) Is Nothing And Not Session("ShadowCompanyId") Is Nothing Then
                ddlCompany.SelectedValue = Session("ShadowCompanyId")
                strChildCompanyName = ddlCompany.SelectedItem.Text
                If ddlCompany.SelectedValue = "ALL" Then
                    intShadowCompanyId = 0
                    Session("ShadowCompanyId") = 0
                ElseIf ddlCompany.SelectedValue Is Nothing Then
                    intShadowCompanyId = 0
                Else
                    intShadowCompanyId = ddlCompany.SelectedValue

                End If

            Else
                ddlCompany.Items(0).Selected = True
                Session("ShadowCompanyId") = ddlCompany.SelectedValue
                strChildCompanyName = ddlCompany.SelectedItem.Text
                If ddlCompany.SelectedValue = "ALL" Then
                    intShadowCompanyId = 0
                    Session("ShadowCompanyId") = 0
                Else
                    intShadowCompanyId = ddlCompany.SelectedValue

                End If

            End If
        End If

        If Session("ShadowCompanyId") Is Nothing Then
            intShadowCompanyId = 0
            Session("ShadowCompanyId") = 0
        End If

    End Sub

#End Region

    Private Sub GetEmployees()
        Dim SearchSSN As String
        Dim SearchEmployeeName As String
        Dim SearchEENumber As String

        intShadowCompanyId = Session("ShadowCompanyId")

        'SearchSSN = Searchtxt.Text.Replace("-", "")
        SearchEmployeeName = Searchtxt.Text.Replace(" ", "")
        SearchEmployeeName = SearchEmployeeName.Replace(",", "")
        SearchEmployeeName = SearchEmployeeName.Replace(".", "")
        SearchEmployeeName = SearchEmployeeName.Replace("-", "")
        'SearchEENumber = txtEmpNum.Text

        ec.GetEmployeeList(Session("UserId"), intShadowCompanyId, Session("ListType"), Session("ListLevel"), Session("ActiveCompany"), Session("ActiveEmployee"), SearchEmployeeName, SearchSSN, SearchEENumber, 20, a_grdEmployee)

    End Sub

    Protected Sub ddlAdminCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ListLevel") = "Admin"

        If ddlAdminCompany.SelectedIndex = 0 Then
            ddlAdminCompany.SelectedValue = Nothing
            Session("ShadowCompanyId") = 0
            Session("ListLevel") = ""
        Else
            Session("ShadowCompanyId") = ddlAdminCompany.SelectedValue
            intShadowCompanyId = ddlAdminCompany.SelectedValue
            strAdminCompanyName = ddlAdminCompany.SelectedItem.Text
            ddlParentCompany.SelectedItem.Text = "ALL"
            ddlCompany.SelectedItem.Text = "ALL"

        End If

        FillCompanyLists()
        GetEmployees()

        Searchtxt.Enabled = True

    End Sub

    Protected Sub ddlParentCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ListLevel") = "Parent"
        If ddlParentCompany.SelectedIndex = 0 Then
            ddlParentCompany.SelectedValue = Nothing
            Session("ShadowCompanyId") = 0
            Session("ListLevel") = ""
        Else
            Session("ShadowCompanyId") = ddlParentCompany.SelectedValue
            intShadowCompanyId = ddlParentCompany.SelectedValue
            strAdminCompanyName = ddlAdminCompany.SelectedItem.Text
            strParentCompanyName = ddlParentCompany.SelectedItem.Text
            strChildCompanyName = "ALL"
            ddlCompany.SelectedItem.Text = "ALL"
        End If


        FillCompanyLists()
        GetEmployees()

        Searchtxt.Enabled = True
    End Sub

    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlCompany.SelectedIndexChanged
        Session("ListLevel") = "Child"

        'If ddlAdminCompany.Visible = True And ddlParentCompany.Visible = True Then
        If ddlCompany.SelectedIndex = 0 Then
            ddlCompany.SelectedValue = Nothing
            Session("ShadowCompanyId") = 0
            Session("ListLevel") = ""
        Else
            Session("ShadowCompanyId") = ddlCompany.SelectedValue
            intShadowCompanyId = ddlCompany.SelectedValue
            strChildCompanyName = ddlCompany.SelectedItem.Text
        End If

        FillCompanyLists()
        GetEmployees()

        Searchtxt.Enabled = True

    End Sub



    Protected Sub a_grdEmployee_RowCreated(sender As Object, e As GridViewRowEventArgs) Handles a_grdEmployee.RowCreated
        If e.Row.RowType = System.Web.UI.WebControls.DataControlRowType.DataRow Then

            e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#EFF3FB'")  'old color   8bcced
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=''")

            e.Row.Attributes.Add("style", "cursor:pointer;")
            e.Row.Attributes("onclick") = Page.ClientScript.GetPostBackClientHyperlink(a_grdEmployee, "Select$" & e.Row.RowIndex)
            e.Row.ToolTip = "Click to select this employee."

            lblHightlight1.Visible = True
        End If
    End Sub

    Protected Sub OnSelectedIndexChanged(sender As Object, e As EventArgs)
        Dim row As GridViewRow = a_grdEmployee.SelectedRow
        Dim i As Integer
        i = a_grdEmployee.SelectedIndex
        Session("ShadowCompanyId") = a_grdEmployee.DataKeys(i).Values("CompanyId")
        Session("ShadowEmployeeId") = a_grdEmployee.DataKeys(i).Values("EmployeeId")
        Session("ShadowEmployeeName") = a_grdEmployee.DataKeys(i).Values("DisplayName")
        Session("EmployeeCompanyId") = a_grdEmployee.DataKeys(i).Values("CompanyId")

        'These are used for the Header to show admin who they're shadowing
        Session("ShadowEmployee") = "You have selected  " + a_grdEmployee.DataKeys(i).Values("DisplayName")
        Session("ShadowCompany") = "With  " + a_grdEmployee.DataKeys(i).Values("CompanyName")

        Response.Redirect("~/EE_Welcome.aspx")

    End Sub

    Sub a_grdEmployee_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        a_grdEmployee.DataSource = Session("Employees")
        a_grdEmployee.PageIndex = e.NewPageIndex
        a_grdEmployee.DataBind()

        intShadowCompanyId = Session("ShadowCompanyId")

        'FillCompanyLists() --Do not need to refill company list as we are already at the EE level
        GetEmployees()
    End Sub

    Protected Sub chkOrderByNumber_CheckedChanged(sender As Object, e As EventArgs)
        If chkOrderByNumber.Checked = True Then
            Session("OrderByCompanyNumber") = True
        Else
            Session("OrderByCompanyNumber") = False
        End If

        FillCompanyLists()
        GetEmployees()
    End Sub

    'Protected Sub chkActive_CheckedChanged(sender As Object, e As EventArgs)
    '    If chkActive.Checked = False Then
    '        Session("ActiveEmployee") = False
    '    Else
    '        Session("ActiveEmployee") = True
    '    End If

    '    FillCompanyLists()
    '    GetEmployees()
    'End Sub

    'Protected Sub ActiveCompany_CheckedChanged(sender As Object, e As EventArgs)
    '    If chkActiveCompany.Checked = False Then
    '        Session("ShadowCompanyId") = 0
    '        Session("ListLevel") = ""
    '        Session("ActiveCompany") = False
    '        Session("ActiveEmployee") = False
    '        intShadowCompanyId = 0
    '        ddlAdminCompany.Items.Insert(0, New ListItem("ALL"))
    '        ddlParentCompany.Items.Insert(0, New ListItem("ALL"))
    '        ddlCompany.Items.Insert(0, New ListItem("ALL"))

    '        If Not strAdminCompanyName Is Nothing Then
    '            strAdminCompanyName = "ALL"
    '            ddlAdminCompany.SelectedItem.Text = "ALL"
    '        End If
    '        If Not strParentCompanyName Is Nothing Then
    '            strParentCompanyName = "ALL"
    '            ddlParentCompany.SelectedItem.Text = "ALL"
    '        End If
    '        If Not strChildCompanyName Is Nothing Then
    '            strChildCompanyName = "ALL"
    '            ddlCompany.SelectedItem.Text = "ALL"
    '        End If

    '        txtEmpSSN.Text = ""
    '        txtEmpName.Text = ""
    '        txtEmpNum.Text = ""
    '    Else
    '        Session("ActiveCompany") = True
    '        chkActive.Checked = True
    '    End If

    '    FillCompanyLists()
    '    GetEmployees()
    'End Sub

    Protected Sub btnClearSearch_Click(sender As Object, e As EventArgs)
        Session("ShadowCompanyId") = 0
        Session("ListLevel") = ""

        If Not strAdminCompanyName Is Nothing Then
            strAdminCompanyName = "ALL"
            ddlAdminCompany.SelectedItem.Text = "ALL"
        End If
        If Not strParentCompanyName Is Nothing Then
            strParentCompanyName = "ALL"
            ddlParentCompany.SelectedItem.Text = "ALL"
        End If
        If Not strChildCompanyName Is Nothing Then
            strChildCompanyName = "ALL"
            ddlCompany.SelectedItem.Text = "ALL"
        End If

        'txtEmpSSN.Text = ""
        'txtEmpName.Text = ""
        'txtEmpNum.Text = ""

        FillCompanyLists()
        GetEmployees()

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Response.Redirect("~/Admin_EECommitPending.aspx")
    End Sub

    Protected Sub searchbtn_Click(sender As Object, e As EventArgs) Handles searchbtn.Click
        GetEmployees()
        FiltersDiv.Visible = False
    End Sub

    Protected Sub filterbtn_Click(sender As Object, e As EventArgs) Handles filterbtn.Click
        FiltersDiv.Visible = True
    End Sub
End Class
