Imports System
Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Text
Imports System.Text.RegularExpressions
Partial Class Admin_EEOnboarding
    Inherits System.Web.UI.Page

    Dim ec As New Employee
    Dim CompanyClass As New Company
    Dim sc As New ScreenConfiguration
    Dim PlanClass As New Plans
    Dim SecClass As New Security

    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Dim intCompanyId As Integer
    Dim intUserId As Integer

    Dim booGotEmployee As Boolean
    Dim intEmpId As Integer
    Dim strEmployeeName As String
    Dim intTransactionId As Integer

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
        strScreenName = "OnboardingDashboard"
        strScreenShortDesc = "Admin Onboarding Dashboard"

        If Page.IsPostBack = False Then
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_EEOnboarding")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmpId, "Admin_EEOnboarding", Session("Athena"))

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
            'txtEmpSSN.Enabled = True
            txtEmpNum.Enabled = True
            btnEmpName.Enabled = True
            'btnEmpSSN.Enabled = True
            btnEmplNumSearch.Enabled = True

            FillCompanyLists()

            If ddlAdminCompany.Items.Count > 1 Then
                lblAdminCompany.Visible = True
                ddlAdminCompany.Visible = True
            End If

            If ddlParentCompany.Items.Count > 1 Then
                lblParentCompany.Visible = True
                ddlParentCompany.Visible = True
            End If

            GetEmployees()

            'Hide Edit Areas    
            divOnboardingList.Visible = True
            divAdminReview.Visible = False
            divProgressList.Visible = False

            Session("RegistrationKey") = ec.GetUniqueKey 'System.Web.Security.Membership.GeneratePassword(12, 1)

            SecClass.SaveUserBrowse(Session("UserId"), strScreenName, "Browsed on " + strScreenShortDesc)

        End If

        divError.Visible = False

    End Sub

#Region "Fill up Company Lists"
    Private Sub FillCompanyLists()
        Session("ds") = New DataSet

        CompanyClass.LoadCompanyList(Session("UserId"), intShadowCompanyId, Session("ListType"), Session("Listlevel"), Session("ActiveCompany"), Session("ActiveEmployee"), Session("OrderByCompanyNumber"), Session("ds"))

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

    Private Sub GetEmployees()
        'Dim SearchSSN As String
        Dim SearchEmployeeName As String
        Dim SearchEENumber As String
        intShadowCompanyId = Session("ShadowCompanyId")

        'SearchSSN = txtEmpSSN.Text.Replace("-", "")
        SearchEmployeeName = txtEmpName.Text.Replace(" ", "")
        SearchEmployeeName = SearchEmployeeName.Replace(",", "")
        SearchEmployeeName = SearchEmployeeName.Replace(".", "")
        SearchEmployeeName = SearchEmployeeName.Replace("-", "")
        SearchEENumber = txtEmpNum.Text

        ec.GetEmployeeList(Session("UserId"), intShadowCompanyId, Session("ListType"), Session("ListLevel"), Session("ActiveCompany"), Session("ActiveEmployee"), SearchEmployeeName, "", SearchEENumber, 24, grdReviewEmployees)

    End Sub
#End Region

    Protected Sub ddlAdminCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ListLevel") = "Admin"

        divAdminReview.Visible = False

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
        'txtEmpSSN.Enabled = True
        txtEmpNum.Enabled = True
        btnEmpName.Enabled = True
        'btnEmpSSN.Enabled = True
        btnEmplNumSearch.Enabled = True
    End Sub

    Protected Sub ddlParentCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ListLevel") = "Parent"

        divAdminReview.Visible = False

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
        'txtEmpSSN.Enabled = True
        txtEmpNum.Enabled = True
        btnEmpName.Enabled = True
        'btnEmpSSN.Enabled = True
        btnEmplNumSearch.Enabled = True
    End Sub

    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlCompany.SelectedIndexChanged
        Session("ListLevel") = "Child"

        divAdminReview.Visible = False

        'If ddlAdminCompany.Visible = True And ddlParentCompany.Visible = True Then

        If ddlCompany.SelectedItem.Text <> "ALL" Then
            Session("ShadowCompanyId") = ddlCompany.SelectedValue
            intShadowCompanyId = ddlCompany.SelectedValue
            strChildCompanyName = ddlCompany.SelectedItem.Text
        End If

        FillCompanyLists()
        GetEmployees()

        txtEmpName.Enabled = True
        'txtEmpSSN.Enabled = True
        txtEmpNum.Enabled = True
        btnEmpName.Enabled = True
        'btnEmpSSN.Enabled = True
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

    Protected Sub grdReviewEmployees_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdReviewEmployees.RowDataBound
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim keys As DataKey = grdReviewEmployees.DataKeys(e.Row.RowIndex)
            Dim bFinalize As Object = keys("Finalize")

            Dim btnVerify As Button = DirectCast(e.Row.FindControl("btnVerify"), Button)
            btnVerify.Visible = True

        End If
    End Sub

    Protected Sub grdReviewEmployees_RowCreated(sender As Object, e As GridViewRowEventArgs) Handles grdReviewEmployees.RowCreated
        If e.Row.RowType = System.Web.UI.WebControls.DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#EFF3FB'")  'old color   8bcced
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=''")
        End If
    End Sub

    Sub grdReviewEmployees_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        grdReviewEmployees.DataSource = Session("Employees")
        grdReviewEmployees.PageIndex = e.NewPageIndex
        grdReviewEmployees.DataBind()
        divAdminReview.Visible = False
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

    Private Sub PopulateEmpFields()

        'progress bar
        Dim PercentageComplete As Integer
        Dim widthset As String

        PercentageComplete = ec.OnboardingPercentComplete
        widthset = PercentageComplete.ToString + "%"
        divProgressBar.Attributes.Add("aria-valuenow", PercentageComplete.ToString)
        divProgressBar.Style.Add("width", widthset)
        lblProgress.Text = PercentageComplete.ToString + "%"

        ec.getEmployeeOnboardingProgress(Session("ShadowEmployeeId"), "OnboardingDashboard", grdOnboardingProgress)

    End Sub

    Protected Sub btnReview_Click(sender As Object, e As EventArgs)
        Dim btnReview As Button = sender
        Dim gr As GridViewRow = btnReview.Parent.Parent
        Dim EmployeeId As Object = grdReviewEmployees.DataKeys(gr.RowIndex).Values("EmployeeId")
        Dim CompanyId As Object = grdReviewEmployees.DataKeys(gr.RowIndex).Values("CompanyId")
        Dim CompanyName As Object = grdReviewEmployees.DataKeys(gr.RowIndex).Values("CompanyName")
        Dim Registration As Object = grdReviewEmployees.DataKeys(gr.RowIndex).Values("RegKey")
        Dim URLPath As Object = grdReviewEmployees.DataKeys(gr.RowIndex).Values("URL")
        Dim RegistrationEmail As Object = grdReviewEmployees.DataKeys(gr.RowIndex).Values("RegistrationEmail")

        Session("ShadowCompanyId") = CompanyId
        Session("ShadowEmployeeId") = EmployeeId
        Session("RegistrationKey") = Registration
        Session("URL") = URLPath

        'Go Get Employee Info
        booGotEmployee = ec.GetEmployeeInfo(Session("ShadowCompanyId"), Session("ShadowEmployeeId"))
        If booGotEmployee = True Then
            lblEmployeeName.Text = ec.FullName

        End If

        divOnboardingList.Visible = True
        divProgressList.Visible = True
        divAdminReview.Visible = True

        PopulateEmpFields()
        divAdminReview.Focus()

        lblCompanyName.Text = CompanyName
        'mlblCompanyName.Text = "<h4>" + CompanyName + "</h4>"

    End Sub

    Protected Sub btnAdminEdit_Click(sender As Object, e As ImageClickEventArgs)
        divOnboardingList.Visible = False
        divProgressList.Visible = True
        'divCompany.Visible = False
        divAdminReview.Visible = False
        Session("NewEmployee") = 0

    End Sub

    Protected Sub btnVerify_Click(sender As Object, e As EventArgs)
        Dim btnReview As Button = sender
        Dim gr As GridViewRow = btnReview.Parent.Parent
        Dim EmployeeId As Object = grdReviewEmployees.DataKeys(gr.RowIndex).Values("EmployeeId")
        Dim CompanyId As Object = grdReviewEmployees.DataKeys(gr.RowIndex).Values("CompanyId")
        Dim CompanyName As Object = grdReviewEmployees.DataKeys(gr.RowIndex).Values("CompanyName")
        Dim DisplayName As Object = grdReviewEmployees.DataKeys(gr.RowIndex).Values("DisplayName")
        Dim EmployeeCompanyId As Object = grdReviewEmployees.DataKeys(gr.RowIndex).Values("CompanyId")

        Session("ShadowCompanyId") = CompanyId
        Session("ShadowEmployeeId") = EmployeeId
        Session("ShadowEmployeeName") = DisplayName

        'These are used for the Header to show admin who they're shadowing
        Session("ShadowEmployee") = "You have selected  " + DisplayName
        Session("ShadowCompany") = "With  " + CompanyName

        Response.Redirect("~/EE_I9.aspx")

    End Sub

    Protected Sub mbtnResetSave_Click(sender As Object, e As ImageClickEventArgs) Handles mbtnResetSave.Click

        'Save procedure here
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()
        Try
            objParam = New SqlParameter("@EmployeeId", intEmpId)
            aryParams.Add(objParam)

            sqlCon.ExecuteNonQuery("[usp_Employee_Security_Reset]", aryParams)
            sqlCon.CloseConn()

            aryParams = Nothing
            sqlCon = Nothing

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

    End Sub

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
        txtEmpName.Text = ""
        txtEmpNum.Text = ""

        FillCompanyLists()
        GetEmployees()
    End Sub

End Class
