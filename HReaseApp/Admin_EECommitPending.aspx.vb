Imports System.Data.SqlClient

Public Class Admin_EECommitPending
    Inherits System.Web.UI.Page
    Dim s As New Security
    Dim c As New Company
    Dim ec As New Employee
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

        'Change these on each page
        strScreenName = "CommitPending"
        strScreenShortDesc = "Commit Pending Elections"

        If Page.IsPostBack = False Then
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_EECommitPending")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, "Admin_EECommitPending", Session("Athena"))

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

            txtEmpName.Enabled = True
            txtEmpSSN.Enabled = True
            txtEmpNum.Enabled = True
            btnEmpName.Enabled = True
            btnEmpSSN.Enabled = True
            btnEmplNumSearch.Enabled = True

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

        Me.Form.DefaultButton = btnEmplNumSearch.UniqueID

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

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

        SearchSSN = txtEmpSSN.Text.Replace("-", "")
        SearchEmployeeName = txtEmpName.Text.Replace(" ", "")
        SearchEmployeeName = SearchEmployeeName.Replace(",", "")
        SearchEmployeeName = SearchEmployeeName.Replace(".", "")
        SearchEmployeeName = SearchEmployeeName.Replace("-", "")
        SearchEENumber = txtEmpNum.Text

        ec.GetEmployeeList(Session("UserId"), intShadowCompanyId, Session("ListType"), Session("ListLevel"), Session("ActiveCompany"), Session("ActiveEmployee"), SearchEmployeeName, SearchSSN, SearchEENumber, 22, grdCommit)

    End Sub

    Protected Sub ddlAdminCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ListLevel") = "Admin"

        If ddlAdminCompany.SelectedItem.Text <> "ALL" Then
            Session("ShadowCompanyId") = ddlAdminCompany.SelectedValue
            intShadowCompanyId = ddlAdminCompany.SelectedValue
            strAdminCompanyName = ddlAdminCompany.SelectedItem.Text
            ddlParentCompany.SelectedItem.Text = "ALL"
            ddlCompany.SelectedItem.Text = "ALL"

        End If

        FillCompanyLists()
        GetEmployees()

        txtEmpName.Enabled = True
        txtEmpSSN.Enabled = True
        txtEmpNum.Enabled = True
        btnEmpName.Enabled = True
        btnEmpSSN.Enabled = True
        btnEmplNumSearch.Enabled = True
    End Sub

    Protected Sub ddlParentCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ListLevel") = "Parent"

        If ddlParentCompany.SelectedItem.Text <> "ALL" Then
            Session("ShadowCompanyId") = ddlParentCompany.SelectedValue
            intShadowCompanyId = ddlParentCompany.SelectedValue
            strAdminCompanyName = ddlAdminCompany.SelectedItem.Text
            strParentCompanyName = ddlParentCompany.SelectedItem.Text
            strChildCompanyName = "ALL"
            ddlCompany.SelectedItem.Text = "ALL"
        End If

        FillCompanyLists()
        GetEmployees()

        txtEmpName.Enabled = True
        txtEmpSSN.Enabled = True
        txtEmpNum.Enabled = True
        btnEmpName.Enabled = True
        btnEmpSSN.Enabled = True
        btnEmplNumSearch.Enabled = True
    End Sub

    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlCompany.SelectedIndexChanged
        Session("ListLevel") = "Child"

        'If ddlAdminCompany.Visible = True And ddlParentCompany.Visible = True Then

        If ddlCompany.SelectedItem.Text <> "ALL" Then
            Session("ShadowCompanyId") = ddlCompany.SelectedValue
            intShadowCompanyId = ddlCompany.SelectedValue
            strChildCompanyName = ddlCompany.SelectedItem.Text
        End If

        FillCompanyLists()
        GetEmployees()

        txtEmpName.Enabled = True
        txtEmpSSN.Enabled = True
        txtEmpNum.Enabled = True
        btnEmpName.Enabled = True
        btnEmpSSN.Enabled = True
        btnEmplNumSearch.Enabled = True

    End Sub

    Protected Sub btnEmpName_Click(sender As Object, e As EventArgs) Handles btnEmpName.Click
        GetEmployees()
    End Sub

    Protected Sub btnEmpSSN_Click(sender As Object, e As EventArgs) Handles btnEmpSSN.Click
        GetEmployees()
    End Sub

    Protected Sub btnEmplNumSearch_Click(sender As Object, e As EventArgs) Handles btnEmplNumSearch.Click
        GetEmployees()
    End Sub

#Region "Loading up Commit grid and Paging"
    Protected Sub grdCommit_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdCommit.RowDataBound
        divResults.Visible = True
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)

        If e.Row.Cells(2).Text = "DontRepeat" Then
            e.Row.Cells(1).Text = ""
            e.Row.Cells(2).Text = ""
            e.Row.BorderColor = Drawing.Color.AliceBlue
        End If

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim keys As DataKey = grdCommit.DataKeys(e.Row.RowIndex)
            Dim EEPID As Object = keys("EmployeeElectionPendingId")
            Dim EEID As Object = keys("EmployeeId")
            Dim EENAME As Object = keys("EmployeeDisplayName")
            Dim COMPID As Object = keys("CompanyId")
            Dim COMPNAME As Object = keys("CompanyName")
            Dim RowNum As Object = keys("RowNumber")

        End If
    End Sub

#End Region

#Region "Approve or Disapprove"
    Protected Sub chkApprove_CheckedChanged(sender As Object, e As EventArgs)

        Dim chkApp As CheckBox = sender
        Dim gr As GridViewRow = chkApp.Parent.Parent
        Dim EEPI As Object = grdCommit.DataKeys(gr.RowIndex).Values("EmployeeElectionPendingId")
        Dim chkDisApp As CheckBox = DirectCast(gr.FindControl("chkDisapprove"), CheckBox)

        If chkApp.Checked = True Then
            chkDisApp.Checked = False
        End If


    End Sub

    Protected Sub chkDisapprove_CheckedChanged(sender As Object, e As EventArgs)
        Dim chkDisApp As CheckBox = sender
        Dim gr As GridViewRow = chkDisApp.Parent.Parent
        Dim EEPI As Object = grdCommit.DataKeys(gr.RowIndex).Values("EmployeeElectionPendingId")
        Dim chkApp As CheckBox = DirectCast(gr.FindControl("chkApprove"), CheckBox)

        If chkDisApp.Checked = True Then
            chkApp.Checked = False
        End If

        'Response.Redirect(HttpContext.Current.Request.Url.ToString(), True)

    End Sub

    Protected Sub chkApproveAll_CheckedChanged(sender As Object, e As EventArgs)
        Dim gvr As GridViewRow
        Dim i As Int32
        If chkApproveAll.Checked = True Then
            For Each gvr In grdCommit.Rows
                Dim chkA As CheckBox
                Dim chkD As CheckBox
                chkA = CType(grdCommit.Rows(i).FindControl("chkApprove"), CheckBox)
                chkD = CType(grdCommit.Rows(i).FindControl("chkDisapprove"), CheckBox)

                If chkA.Enabled = True Then
                    chkA.Checked = True
                End If

                'regardless if Approved or not
                chkD.Checked = False
                i += 1
            Next

            'make sure Disapprove all is unchecked, and make visible
            chkDisapproveAll.Checked = False
            chkDisapproveAll.Visible = True
            chkApproveAll.Visible = False
        End If
    End Sub

    Protected Sub chkDisapproveAll_CheckedChanged(sender As Object, e As EventArgs)
        Dim gvr As GridViewRow
        Dim i As Int32
        If chkDisapproveAll.Checked = True Then
            For Each gvr In grdCommit.Rows
                Dim chkA As CheckBox
                Dim chkD As CheckBox
                chkA = CType(grdCommit.Rows(i).FindControl("chkApprove"), CheckBox)
                chkD = CType(grdCommit.Rows(i).FindControl("chkDisapprove"), CheckBox)
                chkD.Checked = True
                chkA.Checked = False
                i += 1
            Next

            'make sure Approve all is unchecked, and make visible
            chkApproveAll.Checked = False
            chkApproveAll.Visible = True
            chkDisapproveAll.Visible = False
        End If
    End Sub

#End Region

#Region "Save one Save All"

    Protected Sub btnSaveOne_Click(sender As Object, e As EventArgs)
        Dim btnSave As Button = sender
        Dim gr As GridViewRow = btnSave.Parent.Parent
        Dim EmployeeElectionPendingId As Object = grdCommit.DataKeys(gr.RowIndex).Values("EmployeeElectionPendingId")
        Dim EmployeeId As Object = grdCommit.DataKeys(gr.RowIndex).Values("EmployeeId")
        Dim chkA As CheckBox = DirectCast(gr.FindControl("chkApprove"), CheckBox)
        Dim chkD As CheckBox = DirectCast(gr.FindControl("chkDisapprove"), CheckBox)

        If chkA.Checked = True Or chkD.Checked = True Then   'only save if either Approved or Disapproved
            ec.CommitPendingElection(EmployeeId, EmployeeElectionPendingId, chkA.Checked, Session("UserId"))

            'refill grid
            GetEmployees()

        End If
    End Sub

    Protected Sub btnSaveAll_Click(sender As Object, e As EventArgs)
        Dim gvr As GridViewRow
        Dim i As Int32
        For Each gvr In grdCommit.Rows
            Dim chkA As CheckBox
            Dim chkD As CheckBox
            Dim EmployeeElectionPendingId As Object = grdCommit.DataKeys(i).Values("EmployeeElectionPendingId")
            Dim EmployeeId As Object = grdCommit.DataKeys(i).Values("EmployeeId")

            chkA = CType(grdCommit.Rows(i).FindControl("chkApprove"), CheckBox)
            chkD = CType(grdCommit.Rows(i).FindControl("chkDisapprove"), CheckBox)

            If chkA.Checked = True Or chkD.Checked = True Then   'only save if either Approved or Disapproved
                ec.CommitPendingElection(EmployeeId, EmployeeElectionPendingId, chkA.Checked, Session("UserId"))
            End If
            i += 1
        Next

        'refill grid
        GetEmployees()

    End Sub

    Protected Sub grdCommit_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim row As GridViewRow = grdCommit.SelectedRow
        Dim i As Integer
        i = grdCommit.SelectedIndex
        Session("ShadowCompanyId") = grdCommit.DataKeys(i).Values("CompanyId")
        Session("ShadowEmployeeId") = grdCommit.DataKeys(i).Values("EmployeeId")
        Session("ShadowEmployeeName") = grdCommit.DataKeys(i).Values("DisplayName")
        Session("EmployeeCompanyId") = grdCommit.DataKeys(i).Values("CompanyId")

    End Sub

    Protected Sub btnReview_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btnReview As Button = sender
        Dim gr As GridViewRow = btnReview.Parent.Parent
        Dim CompanyId As Object = grdCommit.DataKeys(gr.RowIndex).Values("CompanyId")
        Dim EmployeeId As Object = grdCommit.DataKeys(gr.RowIndex).Values("EmployeeId")

        Session("ShadowCompanyId") = CompanyId
        Session("ShadowEmployeeId") = EmployeeId

        Session("ShadowEmployeeName") = grdCommit.DataKeys(gr.RowIndex).Values("EmployeeDisplayName")
        Session("EmployeeCompanyId") = grdCommit.DataKeys(gr.RowIndex).Values("CompanyId")

        'These are used for the Header to show admin who they're shadowing
        Session("ShadowEmployee") = "You have selected  " + grdCommit.DataKeys(gr.RowIndex).Values("EmployeeDisplayName")
        Session("ShadowCompany") = "With  " + grdCommit.DataKeys(gr.RowIndex).Values("CompanyName")

        Response.Redirect("~/EE_PendingSummary.aspx")

        'Session("StandAlone") = "Yes"

        'Dim url As String = "EE_PendingSummary.aspx"
        'Dim sb As New StringBuilder()
        'sb.Append("<script type = 'text/javascript'>")
        'sb.Append("window.open('")
        'sb.Append(url)
        'sb.Append(",');")
        'sb.Append("</script>")
        'ClientScript.RegisterStartupScript(Me.GetType(),
        '      "script", sb.ToString())

        'Response.AddHeader("REFRESH", "0;URL=" + url)

    End Sub

#End Region

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

        txtEmpSSN.Text = ""
        txtEmpName.Text = ""
        txtEmpNum.Text = ""

        FillCompanyLists()
        GetEmployees()
    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Response.Redirect("~/Admin_EEOnboarding.aspx")
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
End Class
