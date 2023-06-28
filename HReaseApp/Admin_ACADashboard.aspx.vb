Imports System.Data.SqlClient

Public Class Admin_ACADashboard
    Inherits System.Web.UI.Page
    Private Const AffordabilityPercentage As Decimal = 9.12D / 100
    Private Const FPL As Decimal = 12760

    ' Approximate FPL for a single individual in 2023
    Private Const HoursPerMonth As Decimal = 130

    Dim bActives As Boolean
    Dim bresult As Boolean
    Dim c As New Company
    Dim ec As New Employee
    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intShadowCompanyId As Integer
    Dim intUserId As Integer
    Dim r As New Reports
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim strAdminCompanyName As String
    Dim strChildCompanyName As String
    Dim strParentCompanyName As String
    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Sub a_grdEmployee_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        a_grdEmployee.DataSource = Session("Employees")
        a_grdEmployee.PageIndex = e.NewPageIndex
        a_grdEmployee.DataBind()

        intShadowCompanyId = Session("ShadowCompanyId")

        'FillCompanyLists() --Do not need to refill company list as we are already at the EE level
        GetEmployees()
    End Sub

    Protected Sub a_grdEmployee_RowCreated(sender As Object, e As GridViewRowEventArgs) Handles a_grdEmployee.RowCreated
        If e.Row.RowType = System.Web.UI.WebControls.DataControlRowType.DataRow Then

            e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#EFF3FB'")  'old color   8bcced
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=''")

            e.Row.Attributes.Add("style", "cursor:pointer;")
            e.Row.Attributes("onclick") = Page.ClientScript.GetPostBackClientHyperlink(a_grdEmployee, "Select$" & e.Row.RowIndex)
            e.Row.ToolTip = "Click to select this employee."

        End If
    End Sub

    Protected Sub btnEditRules_Click(sender As Object, e As EventArgs) Handles btnEditRules.Click
        ' Code to handle the btnEditRules click event
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        ' Code to handle the btnSave click event and save the ACADashboard rules
    End Sub

    Protected Sub CalculateButton_Click(sender As Object, e As EventArgs)
        Dim payType1 As String = PayType.SelectedValue
        Dim pay As Decimal
        If Not Decimal.TryParse(PayInput.Text, pay) Then
            ResultLabel.Text = "Invalid pay input."
            PayInput.CssClass = "error"
            Return
        End If
        Dim contribution As Decimal
        If Not Decimal.TryParse(ContributionInput.Text, contribution) Then
            ResultLabel.Text = "Invalid contribution input."
            ContributionInput.CssClass = "error"
            Return
        End If

        Dim affordableContribution As Decimal
        Dim monthlyIncome As Decimal
        If payType1 = "Hourly" Then
            monthlyIncome = pay * HoursPerMonth
            affordableContribution = monthlyIncome * AffordabilityPercentage
        ElseIf payType1 = "Salaried" Then
            monthlyIncome = pay / 12
            affordableContribution = monthlyIncome * AffordabilityPercentage
        Else
            ResultLabel.Text = "Invalid pay type. Please select either 'Hourly' or 'Salaried'."
            Return
        End If
        resultsdiv.Style("display") = "block !important"
        Dim isAffordable = contribution <= affordableContribution

        ' FPL Safe Harbor
        Dim fplSafeHarbor = contribution <= (FPL * AffordabilityPercentage / 12)

        ' W-2 Safe Harbor
        Dim w2SafeHarbor = contribution <= (pay * AffordabilityPercentage)

        ' Update labels
        RateofPayIncome.Text = monthlyIncome.ToString("C2")
        EmployeeCont.Text = contribution.ToString("C2")
        RateofPayPer.Text = ((contribution / monthlyIncome) * 100).ToString("F2") & "%"
        RateofPayPertxt.Text = If(isAffordable, "Affordable", "Not Affordable")
        RateofPayPertxt.ForeColor = If(isAffordable, Drawing.Color.Green, Drawing.Color.Red)
        RateofPayPer.ForeColor = If(isAffordable, Drawing.Color.Green, Drawing.Color.Red)
        RateofPayMin.Text = affordableContribution.ToString("C2") & " / month"
        AffortablePerc.Text = (AffordabilityPercentage * 100).ToString("F2") & "%"

        '' For W-2 Safe Harbor
        'W2Income.Text = monthlyIncome.ToString("C2")
        'EmployeeContW2.Text = contribution.ToString("C2")
        'W2Per.Text = ((contribution / monthlyIncome) * 100).ToString("F2") & "%"
        'W2Pertxt.Text = If(w2SafeHarbor, "Affordable", "Not Affordable")
        'W2Pertxt.ForeColor = If(w2SafeHarbor, Drawing.Color.Green, Drawing.Color.Red)
        'W2Per.ForeColor = If(w2SafeHarbor, Drawing.Color.Green, Drawing.Color.Red)
        'W2Min.Text = (monthlyIncome * AffordabilityPercentage).ToString("C2") & " / month"
        'AffortablePercW2.Text = (AffordabilityPercentage * 100).ToString("F2") & "%"

        FPLIncome.Text = (FPL / 12).ToString("C2")
        EmployeeContFPL.Text = contribution.ToString("C2")
        FPLPer.Text = ((contribution / (FPL / 12)) * 100).ToString("F2") & "%"
        FPLPertxt.Text = If(fplSafeHarbor, "Affordable", "Not Affordable")
        FPLPertxt.ForeColor = If(fplSafeHarbor, Drawing.Color.Green, Drawing.Color.Red)
        FPLPer.ForeColor = If(fplSafeHarbor, Drawing.Color.Green, Drawing.Color.Red)
        FPLMin.Text = (FPL * AffordabilityPercentage / 12).ToString("C2") & " / month"
        AffortablePercFPL.Text = (AffordabilityPercentage * 100).ToString("F2") & "%"
    End Sub

    Protected Sub chkActive_CheckedChanged(sender As Object, e As EventArgs)
        Session("ActiveCompany") = If(chkActive.Checked, 1, 0)
        Session("ShadowCompanyId") = 0

        GetEmployees()
        PopulateCompanyInfo()
        PopulateDashboard()
    End Sub

    Protected Sub chkActiveOnly_CheckedChanged(sender As Object, e As EventArgs)
        intCompanyId = Session("ShadowCompanyId")
        bresult = c.getAllDocumentsByCompany(intCompanyId, Session("UserId"), chkActiveOnly.Checked, grdDocument)

    End Sub

    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ShadowCompanyId") = ddlCompany.SelectedValue

        GetEmployees()
        PopulateCompanyInfo()
        PopulateDashboard()
        PopulateDocumentLists()
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

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
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
        strScreenName = "ACADashboard"
        strScreenShortDesc = "Admin ACA Dashboard"

        If Page.IsPostBack = False Then

            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_ACADashboard")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), 0, "Admin_ACADashboard", Session("Athena"))

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

            c.DocumentCategoryList(ddlCategory)
            c.GetDocumentTypeList(1, ddlType)
            divAdd.Visible = False

            PopulateDocumentLists()

            GetScreenConfig()

            PopulateCompanyInfo()
            PopulateDashboard()

            Session("dsReports") = New DataSet
            r.Load_ReportList(Session("UserId"), Session("Athena"), "Dashboard", lstReports, Session("dsReports"))
            s.SaveUserBrowse(Session("UserId"), strScreenName, "Browsed on " + strScreenShortDesc + " for CompanyId " + intCompanyId.ToString)

            GetEmployees()

        End If

        lblFileUpload.Visible = False

    End Sub

    Protected Sub PopulateDocumentLists()
        Session("FirstTime") = True
        btnDocAdd.Visible = True

        'Load Documents
        Session.Remove("DocumentId")
        grdDocument.EditIndex = -1

        'then fill up Document
        bresult = c.getAllDocumentsByCompany(intCompanyId, Session("UserId"), chkActiveOnly.Checked, grdDocument)

    End Sub

    ' Hours for full-time employee per month
    Protected Sub ResetButton_Click(sender As Object, e As EventArgs)
        PayType.ClearSelection()
        PayInput.Text = String.Empty
        ContributionInput.Text = String.Empty
        ResultLabel.Text = String.Empty
        PayInput.CssClass = String.Empty
        ContributionInput.CssClass = String.Empty
        RateofPayIncome.Text = String.Empty
        EmployeeCont.Text = String.Empty
        RateofPayPer.Text = String.Empty
        RateofPayPertxt.Text = String.Empty
        RateofPayMin.Text = String.Empty
        AffortablePerc.Text = String.Empty
        'W2Income.Text = String.Empty
        'EmployeeContW2.Text = String.Empty
        'W2Per.Text = String.Empty
        'W2Pertxt.Text = String.Empty
        'W2Min.Text = String.Empty
        'AffortablePercW2.Text = String.Empty
        FPLIncome.Text = String.Empty
        EmployeeContFPL.Text = String.Empty
        FPLPer.Text = String.Empty
        FPLPertxt.Text = String.Empty
        FPLMin.Text = String.Empty
        AffortablePercFPL.Text = String.Empty
        resultsdiv.Style("display") = "none"
    End Sub

    Protected Sub searchbtn_Click(sender As Object, e As EventArgs) Handles searchbtn.Click
        GetEmployees()
    End Sub

    'Private Function GetALETrendData() As List(Of Double)
    '    Dim aleTrendData As New List(Of Double)()

    '    If c.GetALECompanyRules(intCompanyId) = True Then
    '        aleTrendData.Add(Convert.ToDouble(c.ALETrend1MonthAve))
    '        aleTrendData.Add(Convert.ToDouble(c.ALETrend2MonthAve))
    '        aleTrendData.Add(Convert.ToDouble(c.ALETrend3MonthAve))
    '        aleTrendData.Add(Convert.ToDouble(c.ALETrend4MonthAve))
    '        aleTrendData.Add(Convert.ToDouble(c.ALETrend5MonthAve))
    '        aleTrendData.Add(Convert.ToDouble(c.ALETrend6MonthAve))
    '        aleTrendData.Add(Convert.ToDouble(c.ALETrend7MonthAve))
    '        aleTrendData.Add(Convert.ToDouble(c.ALETrend8MonthAve))
    '        aleTrendData.Add(Convert.ToDouble(c.ALETrend9MonthAve))
    '        aleTrendData.Add(Convert.ToDouble(c.ALETrend10MonthAve))
    '        aleTrendData.Add(Convert.ToDouble(c.ALETrend11MonthAve))
    '        aleTrendData.Add(Convert.ToDouble(c.ALETrend12MonthAve))
    '    End If

    '    Return aleTrendData
    'End Function

    Private Function GetCompanyId() As Integer
        Dim companyId As Integer = 0

        If ddlCompany.Items.Count = 1 Then
            If Integer.TryParse(ddlCompany.Items(0).Value, companyId) Then
                Return companyId
            End If
        Else
            If Integer.TryParse(ddlCompany.SelectedValue, companyId) Then
                Return companyId
            End If
        End If

        Return 0 ' Default value if the conversion fails
    End Function

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

    Private Sub GetScreenConfig()
        sc.ScreenSetup(intCompanyId, "AdminWelcome", Session("UserId"))

        lblAlertTitle.Text = sc.AdminNoticeTitle
        lblAlertMessage.Text = sc.AdminNoticeText

    End Sub

    Private Function GetTotalALEs(companyId As Integer) As Integer
        ' Code to retrieve the total number of ALEs based on the companyId ...
        Return 5 ' Placeholder value
    End Function

    Private Function GetTotalCompanies(companyId As Integer) As Integer
        ' Code to retrieve the total number of companies based on the companyId ...
        Return 10 ' Placeholder value
    End Function

    Private Function GetTotalEmployees(companyId As Integer) As Integer
        ' Code to retrieve the total number of employees based on the companyId ...
        Return 100 ' Placeholder value
    End Function

    Private Function GetTotalFullTimeEmployees(companyId As Integer) As Integer
        ' Code to retrieve the total number of full-time employees based on the companyId ...
        Return 70 ' Placeholder value
    End Function

    Private Function GetTotalNonALEs(companyId As Integer) As Integer
        ' Code to retrieve the total number of Non-ALEs based on the companyId ...
        Return 15 ' Placeholder value
    End Function

    Private Function GetTotalPartTimeEmployees(companyId As Integer) As Integer
        ' Code to retrieve the total number of part-time employees based on the companyId ...
        Return 30 ' Placeholder value
    End Function

    Private Sub PopulateCompanyInfo()

        Session("ActiveCompany") = If(chkActive.Checked = True, 1, 0)

        'Fill up Company list based on UserId
        c.LoadCompanyList(Session("UserId"), Session("ShadowCompanyId"), "Consolidated", "", Session("ActiveCompany"), 0, 0, Session("ds"))

        ddlCompany.DataSource = Session("ds").Tables(0)
        ddlCompany.DataBind()

        If ddlCompany.Items.Count < 2 Then
            lblCompanyName.Text = ddlCompany.Items(0).Text
            lblCompanyName.Text = lblCompanyName.Text.Replace(" - [Single]", "")
            lblCompanyName.Text = lblCompanyName.Text.Replace(" - [Parent]", "")
            lblCompanyName.Text = lblCompanyName.Text.Replace(" - [Child]", "")
            Session("ShadowCompanyId") = ddlCompany.SelectedValue
            intCompanyId = Session("ShadowCompanyId")
            ddlCompany.Text = ddlCompany.SelectedItem.Text
            If Session("ActiveCompany") = 1 Then
                divCompanyList.Visible = False
            End If
        Else
            divCompanyName.Visible = False
            If Session("ShadowCompanyId") Is Nothing Or Session("ShadowCompanyId") = 0 Then
                ddlCompany.Items.Insert(0, New ListItem("SELECT"))
                ddlCompany.Items(0).Selected = True
                Session("ShadowCompanyId") = 0
                intCompanyId = 0
            ElseIf Session("ShadowCompanyId") <> 0 Then
                ddlCompany.SelectedValue = Session("ShadowCompanyId")
                intCompanyId = Session("ShadowCompanyId")
            Else
                ddlCompany.Items(0).Selected = True
            End If

        End If

    End Sub

#Region "Load Document Grid"

    Protected Sub grdDocument_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdDocument.RowDataBound

        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)
        Dim imgArrow As Image = DirectCast(e.Row.FindControl("imgArrow"), Image)
        Dim lnkEdit As LinkButton = DirectCast(e.Row.FindControl("lnkEdit"), LinkButton)
        Dim lblParent As Label = DirectCast(e.Row.FindControl("lblParent"), Label)

        Dim rowcolor = Drawing.ColorTranslator.FromHtml("#EFF3FB")

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim btnView As LinkButton = e.Row.Cells(4).Controls(0)
            Dim grdDocumentPermission As GridView = DirectCast(e.Row.FindControl("grdDocumentPermission"), GridView)
            Dim pnlReviewPermissions As Panel = DirectCast(e.Row.FindControl("divReviewPermissions"), Panel)

            Dim grdChildCompanies As GridView = DirectCast(e.Row.FindControl("grdChildCompanies"), GridView)
            Dim pnlChildCompanies As Panel = DirectCast(e.Row.FindControl("pnlChildCompanies"), Panel)

            Dim lblDocumentName As Label = DirectCast(e.Row.FindControl("lblDocumentName"), Label)

            Dim intDocid = drview("DocumentId")
            Dim intCompanyId = drview("CompanyId")
            Dim strDocName = drview("DocLongDesc")
            Dim intDocCategory = drview("DocumentCategoryId")
            Dim strDoctype = drview("DoctypeDesc")
            'Dim bRequired = drview("RequireAcknowledgment")
            Dim bIsaParent = drview("IsAParentDocument")
            Dim strParentCompany = drview("ParentName")
            Dim b As Boolean

            'EDIT MODE
            If (e.Row.RowState And DataControlRowState.Edit) > 0 Then

                e.Row.BackColor = rowcolor
                Session("DocumentId") = intDocid

                'Load Document Type List
                Dim ddlDT As DropDownList = DirectCast(e.Row.FindControl("ddlDocTypeGrid"), DropDownList)
                If Not ddlDT Is Nothing Then

                    c.GetDocumentTypeList(1, ddlDT)
                    ddlDT.Items.Insert(0, New System.Web.UI.WebControls.ListItem("", 0))
                    ddlDT.Items.FindByText(DataBinder.Eval(e.Row.DataItem, "DocTypeDesc")).Selected = True
                End If

                'Load Category List
                Dim ddlCat As DropDownList = DirectCast(e.Row.FindControl("ddlDocCategoryGrid"), DropDownList)
                'Dim chkRequireAcknowledgment As CheckBox = DirectCast(e.Row.FindControl("chkRequireAcknowledgment"), CheckBox)
                If Not ddlCat Is Nothing Then
                    c.DocumentCategoryList(ddlCat)
                    ddlCat.Items.Insert(0, New System.Web.UI.WebControls.ListItem("", 0))
                    ddlCat.Items.FindByText(DataBinder.Eval(e.Row.DataItem, "DocCategoryDesc")).Selected = True

                End If

                imgArrow.Visible = True
                'call permissions grid here
                b = c.getAllDocumentPermissions(intCompanyId, intDocid, grdDocumentPermission)
                lblDocumentName.Text = strDocName
                pnlReviewPermissions.Visible = True   'not sure if True or False

                'I am an idiot
                Dim iRowCount As Integer
                c.LoadDocumentCompanyRelationship(ddlCompany.SelectedValue, intDocid, Session("UserId"), Session("Athena"), grdChildCompanies, iRowCount)
                If iRowCount < 1 Then
                    pnlChildCompanies.Visible = False
                Else
                    pnlChildCompanies.Visible = True
                    ' lblCompanyNameB.Text = ddlCompany.SelectedItem.Text
                End If
            Else
                If bIsaParent = False And Session("FirstTime") = True Then
                    imgArrow.Visible = True
                    e.Row.BackColor = rowcolor
                    pnlReviewPermissions.Visible = True
                    'call permissions grid here
                    b = c.getAllDocumentPermissions(intCompanyId, intDocid, grdDocumentPermission)

                    Dim iRowCount As Integer
                    c.LoadDocumentCompanyRelationship(ddlCompany.SelectedValue, intDocid, Session("UserId"), Session("Athena"), grdChildCompanies, iRowCount)
                    If iRowCount < 1 Then
                        pnlChildCompanies.Visible = False
                    Else
                        pnlChildCompanies.Visible = True
                        ' lblCompanyNameB.Text = ddlCompany.SelectedItem.Text
                    End If

                    lblDocumentName.Text = strDocName
                    Session("DocumentId") = intDocid
                    Session.Remove("FirstTime")

                ElseIf intDocid = Session("DocumentId") Then

                    '' after a save or a cancel, re highlight the initial row

                    imgArrow.Visible = True
                    e.Row.BackColor = rowcolor
                Else
                    imgArrow.Visible = False
                    pnlReviewPermissions.Visible = False
                End If

            End If
            If bIsaParent = False Then
                e.Row.Attributes.Add("style", "cursor:pointer;")
                lblParent.Visible = False
            Else
                lnkEdit.Visible = False
                btnView.Visible = False
                lblParent.Visible = True
            End If

        End If
    End Sub

#End Region

#Region "Select or Edit Document"

    Protected Sub grdDocument_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        grdDocument.EditIndex = -1
        bresult = c.getAllDocumentsByCompany(ddlCompany.SelectedValue, Session("UserId"), chkActiveOnly.Checked, grdDocument)
        btnDocAdd.Visible = True
        ' ddlCompany.Enabled = True
    End Sub

    Protected Sub grdDocument_Rowcommand(sender As Object, e As GridViewCommandEventArgs)
        Dim rowcolor = Drawing.ColorTranslator.FromHtml("#EFF3FB")
        Dim Normalcolor = Drawing.ColorTranslator.FromHtml("#FFFFFF")
        Dim Altcolor = Drawing.ColorTranslator.FromHtml("#eeeeee")
        If e.CommandName = "Permissions" Then
            Dim i As Int32 = Convert.ToInt32(e.CommandArgument)
            Dim gvRow As GridViewRow = grdDocument.Rows(i)
            Dim gvr As GridViewRow = grdDocument.SelectedRow
            Dim X As Integer
            Dim intDocumentId As Integer

            If i <> -1 Then
                Dim intCompanyId = grdDocument.DataKeys(i).Values("CompanyId")
                Dim intSelectedDocumentId = grdDocument.DataKeys(i).Values("DocumentId")
                Dim strSelectedDocumentName = grdDocument.DataKeys(i).Values("DocLongDesc")
                Dim bIsaParent = grdDocument.DataKeys(i).Values("IsAParentDocument")
                Dim strParentCompany = grdDocument.DataKeys(i).Values("ParentName")

                'Then loop thru grid and hide image except for the row selected and fill up Permissions Grid
                For Each gvr In grdDocument.Rows
                    Dim imgArrow As Image = DirectCast(gvr.FindControl("imgArrow"), Image)
                    Dim grdDocumentPermission As GridView = DirectCast(gvr.FindControl("grdDocumentPermission"), GridView)
                    Dim grdChildCompanies As GridView = DirectCast(gvr.FindControl("grdChildCompanies"), GridView)
                    Dim pnlReviewPermissions As Panel = DirectCast(gvr.FindControl("divReviewPermissions"), Panel)
                    Dim pnlChildCompanies As Panel = DirectCast(gvr.FindControl("pnlChildCompanies"), Panel)
                    Dim lblDocumentName As Label = DirectCast(gvr.FindControl("lblDocumentName"), Label)

                    intDocumentId = grdDocument.DataKeys(X).Values("DocumentId")
                    If intSelectedDocumentId = intDocumentId Then
                        Session("DocumentId") = intDocumentId
                        imgArrow.Visible = True
                        grdDocument.Rows(X).BackColor = rowcolor
                        'call permissions grid here
                        grdDocumentPermission.EditIndex = -1
                        bresult = c.getAllDocumentPermissions(intCompanyId, intSelectedDocumentId, grdDocumentPermission) = True
                        lblDocumentName.Text = strSelectedDocumentName
                        pnlReviewPermissions.Visible = True

                        'also fill up child company
                        'Fill Parent datagrid (Selected Company as Parent)
                        Dim iRowCount As Integer
                        c.LoadDocumentCompanyRelationship(ddlCompany.SelectedValue, intSelectedDocumentId, Session("UserId"), Session("Athena"), grdChildCompanies, iRowCount)
                        If iRowCount < 1 Then
                            pnlChildCompanies.Visible = False
                        Else
                            pnlChildCompanies.Visible = True
                            ' lblCompanyNameB.Text = ddlCompany.SelectedItem.Text
                        End If
                    Else
                        imgArrow.Visible = False
                        pnlReviewPermissions.Visible = False
                        pnlChildCompanies.Visible = False
                        If grdDocument.Rows(X).RowState = DataControlRowState.Normal Then
                            grdDocument.Rows(X).BackColor = Normalcolor
                        Else
                            grdDocument.Rows(X).BackColor = Altcolor
                        End If
                    End If

                    X += 1
                Next

            End If

        End If
    End Sub

    Protected Sub grdDocument_RowEditing1(sender As Object, e As GridViewEditEventArgs)
        grdDocument.EditIndex = e.NewEditIndex
        Session.Remove("DocumentId")
        bresult = c.getAllDocumentsByCompany(ddlCompany.SelectedValue, Session("UserId"), chkActiveOnly.Checked, grdDocument)
        btnDocAdd.Visible = False
        ' ddlCompany.Enabled = False
    End Sub

    Protected Sub grdDocument_RowUpdating(sender As Object, e As GridViewUpdateEventArgs)
        Dim intCompanyId = grdDocument.DataKeys(e.RowIndex).Values("CompanyId")
        Dim intSelectedDocumentId = grdDocument.DataKeys(e.RowIndex).Values("DocumentId")

        Dim ddlCT As DropDownList = DirectCast(grdDocument.Rows(e.RowIndex).FindControl("ddlDocCategoryGrid"), DropDownList)
        Dim ddlDT As DropDownList = DirectCast(grdDocument.Rows(e.RowIndex).FindControl("ddlDocTypeGrid"), DropDownList)
        Dim txtSD As TextBox = DirectCast(grdDocument.Rows(e.RowIndex).FindControl("txtDocName"), TextBox)
        Dim txtBD As TextBox = DirectCast(grdDocument.Rows(e.RowIndex).FindControl("txtDocBeginGrid"), TextBox)
        Dim txtED As TextBox = DirectCast(grdDocument.Rows(e.RowIndex).FindControl("txtDocEndGrid"), TextBox)
        Dim chkRequiredAcknowledgement As CheckBox = DirectCast(grdDocument.Rows(e.RowIndex).FindControl("chkRequireAcknowledgment"), CheckBox)
        'Save procedure here
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()
        Try

            objParam = New SqlParameter("@CompanyId", intCompanyId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@DocumentId", intSelectedDocumentId)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@DocumentCategoryId", ddlCT.SelectedValue)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@DocumentTypeId", ddlDT.SelectedValue)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@ShortDesc", txtSD.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@LongDesc", txtSD.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@Link", "")
            aryParams.Add(objParam)

            'objParam = New SqlParameter("@RequireAcknowledgment", chkRequiredAcknowledgement.Checked)
            'aryParams.Add(objParam)

            objParam = New SqlParameter("@BeginDate", txtBD.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@EndDate", txtED.Text)
            aryParams.Add(objParam)

            sqlCon.ExecuteNonQuery("[usp_Document_Edit]", aryParams)
            sqlCon.CloseConn()

            s.SaveUserUpdate(Session("UserId"), strScreenShortDesc, "Saved on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString, 0, 0, 0, "01/01/1900", 0)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        'reLoad Documents
        grdDocument.EditIndex = -1
        bresult = c.getAllDocumentsByCompany(ddlCompany.SelectedValue, Session("UserId"), chkActiveOnly.Checked, grdDocument)
        btnDocAdd.Visible = True
        ' ddlCompany.Enabled = True

    End Sub

#End Region

#Region "Adding new documents"

    Protected Sub btnCancelNew_Click(sender As Object, e As ImageClickEventArgs)
        divAdd.Visible = False
        divReviewDocuments.Visible = True
        ' divReviewPermissions.Visible = True ddlCompany.Enabled = True
    End Sub

    Protected Sub btnDocAdd_Click(sender As Object, e As ImageClickEventArgs)
        divAdd.Visible = True
        divWebLink.Visible = False
        divFileUpload.Visible = True
        ddlType.SelectedIndex = 0
        divReviewDocuments.Visible = False
        ' divReviewPermissions.Visible = False ddlCompany.Enabled = False
    End Sub

    'Save new file
    Protected Sub btnUpload_Click(sender As Object, e As EventArgs)
        Dim NewFileName As String

        If ddlType.SelectedValue = 3 Then       'WEBLINK
            If Trim(txtURL.Text) = "" Then
                lblFileUpload.Text = "You have not specified a link."
                lblFileUpload.Visible = True
                Exit Sub
            Else
                NewFileName = txtURL.Text
            End If
        Else        'Document or form requiring file upload
            If fuLoad1.HasFile Then
                Try
                    'Get Filename
                    NewFileName = Server.HtmlEncode(fuLoad1.FileName)
                    'Get Extension
                    Dim Extension As String = System.IO.Path.GetExtension(NewFileName)
                    Dim strCompanyId As String = ddlCompany.SelectedValue.ToString

                    'Trying to get full path
                    Dim Rootpath As String = Server.MapPath(".\\")

                    Dim FilePath As String = Rootpath & "Documents\" & strCompanyId & "\"

                    'Only allow files with .doc, docx, pdf, tiff, gif, png, jpg, jpeg extensions --no longer allow xls, xlsx, or txt  - Replaced characters that are not allowed
                    Extension = Extension.ToLower()
                    If LCase(Extension) = ".doc" Or LCase(Extension) = ".docx" Or LCase(Extension) = ".pdf" Or LCase(Extension) = ".tiff" Or LCase(Extension) = ".gif" Or LCase(Extension) = ".png" Or LCase(Extension) = ".jpg" Or LCase(Extension) = ".jpeg" Then
                        NewFileName = Replace(Replace(Replace(Replace(Replace(Replace(Replace(NewFileName, " ", "_"), "&amp;", ""), "&39;", ""), "&", ""), "#", ""), ";", ""), "+", "")

                        'Double check that file directory exists
                        If (Not System.IO.Directory.Exists(FilePath)) Then
                            System.IO.Directory.CreateDirectory(FilePath)
                        End If

                        'THEN save the file
                        fuLoad1.SaveAs(FilePath & NewFileName)   ' & "." & Extension)

                        lblFileUpload.Text = "File name: " &
                            fuLoad1.PostedFile.FileName & "<br>" &
                            "File Size: " &
                            fuLoad1.PostedFile.ContentLength & "<br>" &
                            "Content type: " &
                            fuLoad1.PostedFile.ContentType & "<br>" &
                            "Location Saved: C:\Temp\" &
                            fuLoad1.FileName
                    Else
                        lblFileUpload.Text = "Error:  The file must be a valid format (.doc, .docx, .xls, .xlsx, .pdf, .txt, .png, .jpg)"
                        lblFileUpload.Visible = True
                        Exit Sub
                    End If
                Catch ex As Exception
                    lblFileUpload.Text = "ERROR: " & ex.Message.ToString()
                    lblFileUpload.Visible = True
                    Exit Sub
                End Try
            Else
                lblFileUpload.Text = "You have not specified a file."
                lblFileUpload.Visible = True
                Exit Sub
            End If
        End If

        intCompanyId = ddlCompany.SelectedValue

        'Save procedure here
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()
        Try
            objParam = New SqlParameter("@CompanyId", intCompanyId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@DocumentId", 0)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@DocumentCategoryId", ddlCategory.SelectedValue)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@DocumentTypeId", ddlType.SelectedValue)
            aryParams.Add(objParam)

            If txtShortDesc.Text <> "" Then
                objParam = New SqlParameter("@ShortDesc", txtShortDesc.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@LongDesc", txtShortDesc.Text)
                aryParams.Add(objParam)
            End If
            objParam = New SqlParameter("@Link", NewFileName)
            aryParams.Add(objParam)

            sqlCon.ExecuteNonQuery("[usp_Document_Edit]", aryParams)
            sqlCon.CloseConn()

            aryParams = Nothing
            sqlCon = Nothing

            'Save to Transaction Table
            s.SaveUserUpdate(Session("UserId"), strScreenShortDesc, "Saved on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString, 0, 0, 0, "01/01/1900", 0)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        'Load Documents
        bresult = c.getAllDocumentsByCompany(ddlCompany.SelectedValue, Session("UserId"), chkActiveOnly.Checked, grdDocument)

        'divEditDocuments.Visible = True
        divAdd.Visible = False
        divReviewDocuments.Visible = True
        ' divReviewPermissions.Visible = True
        Session.Remove("FileUpload")
        ' ddlCompany.Enabled = True
    End Sub

    Protected Sub ddlType_SelectedIndexChanged(sender As Object, e As EventArgs)
        If ddlType.SelectedValue = 3 Then
            divWebLink.Visible = True
            txtURL.Text = ""
            divFileUpload.Visible = False
        Else
            divWebLink.Visible = False
            divFileUpload.Visible = True
        End If
    End Sub

#End Region

#Region "Permissions Grid Add New, Edit, Update or Cancel"

    Protected Sub ddlNewPlanTypeGrid_SelectedIndexChanged(sender As Object, e As EventArgs)
        'if the plan type drop down within the permissions Grid is updated, then refill the Plan dropdown?..but how....
        Dim ddlPT As DropDownList = DirectCast(sender, DropDownList)
        Dim gvRowPermission As GridViewRow = TryCast(ddlPT.NamingContainer, GridViewRow)
        Dim ddlP As DropDownList = DirectCast(gvRowPermission.FindControl("ddlNewPlanGrid"), DropDownList)

        If Not ddlP Is Nothing Then
            c.Load_CompanyPlanList(ddlCompany.SelectedValue, ddlPT.SelectedValue, ddlP)
            ddlP.Items.Insert(0, New System.Web.UI.WebControls.ListItem("N/A", 0))
        End If
    End Sub

    Protected Sub ddlPlanTypeGrid_SelectedIndexChanged(sender As Object, e As EventArgs)
        'if the plan type drop down within the permissions Grid is updated, then refill the Plan dropdown?..but how....
        Dim ddlPT As DropDownList = DirectCast(sender, DropDownList)
        Dim gvRowPermission As GridViewRow = TryCast(ddlPT.NamingContainer, GridViewRow)
        Dim ddlP As DropDownList = DirectCast(gvRowPermission.FindControl("ddlNewPlanGrid"), DropDownList)

        If Not ddlP Is Nothing Then
            c.Load_CompanyPlanList(ddlCompany.SelectedValue, ddlPT.SelectedValue, ddlP)
            ddlP.Items.Insert(0, New System.Web.UI.WebControls.ListItem("N/A", 0))
        End If

    End Sub

    Protected Sub grdDocumentPermission_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        Dim gvwDocumentPermission As GridView = DirectCast(sender, GridView)
        gvwDocumentPermission.EditIndex = -1
        bresult = c.getAllDocumentPermissions(ddlCompany.SelectedValue, Session("DocumentId"), gvwDocumentPermission)
        btnDocAdd.Visible = True
        ' ddlCompany.Enabled = False
    End Sub

    Protected Sub grdDocumentPermission_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)
        Dim lnkEdit As LinkButton = DirectCast(e.Row.FindControl("lnkEdit"), LinkButton)
        Dim rowcolor = Drawing.ColorTranslator.FromHtml("#EFF3FB")

        If e.Row.RowType = DataControlRowType.DataRow Then
            'EDIT MODE
            '  ddlCompany.Enabled = False
            If (e.Row.RowState And DataControlRowState.Edit) > 0 Then
                e.Row.BackColor = rowcolor
                'Load Plan Type List
                Dim ddlPT As DropDownList = DirectCast(e.Row.FindControl("ddlPlanTypeGrid"), DropDownList)
                If Not ddlPT Is Nothing Then
                    c.Load_CompanyPlanTypeList(ddlCompany.SelectedValue, ddlPT)
                    ddlPT.Items.Insert(0, New System.Web.UI.WebControls.ListItem("N/A", 0))
                    ddlPT.Items.FindByValue(DataBinder.Eval(e.Row.DataItem, "PlanTypeId")).Selected = True
                End If

                'Load Plan List
                Dim ddlP As DropDownList = DirectCast(e.Row.FindControl("ddlPlanGrid"), DropDownList)
                If Not ddlP Is Nothing Then
                    c.Load_CompanyPlanList(ddlCompany.SelectedValue, ddlPT.SelectedValue, ddlP)
                    ddlP.Items.Insert(0, New System.Web.UI.WebControls.ListItem("N/A", 0))
                    ddlP.Items.FindByText(DataBinder.Eval(e.Row.DataItem, "PlanDesc")).Selected = True
                End If

                'Load Class List
                Dim ddlC As DropDownList = DirectCast(e.Row.FindControl("ddlClassGrid"), DropDownList)
                If Not ddlC Is Nothing Then
                    c.Load_Company_Class_List(ddlCompany.SelectedValue, ddlC)
                    ddlC.Items.Insert(0, New System.Web.UI.WebControls.ListItem("All Classes", 0))
                    ddlC.Items.FindByText(DataBinder.Eval(e.Row.DataItem, "ClassDesc")).Selected = True
                End If
            Else

                If DataBinder.Eval(e.Row.DataItem, "ClassDesc") = "No classes are currently assigned to this Document" Then
                    lnkEdit.Visible = False
                End If

            End If

            'e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#EFF3FB'")  'old color   8bcced
            'e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=''")
            e.Row.Attributes.Add("style", "cursor:pointer;")
            'e.Row.Attributes("onclick") = Page.ClientScript.GetPostBackClientHyperlink(grdDocument, "Select$" & e.Row.RowIndex)
            ' e.Row.ToolTip = "Click to select"

        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            'Load Footer Plan Type List
            Dim ddlFPT As DropDownList = DirectCast(e.Row.FindControl("ddlNewPlanTypeGrid"), DropDownList)
            If Not ddlFPT Is Nothing Then
                c.Load_CompanyPlanTypeList(ddlCompany.SelectedValue, ddlFPT)
                ddlFPT.Items.Insert(0, New System.Web.UI.WebControls.ListItem("N/A", 0))
            End If

            'Load Footer Plan List
            Dim ddlFP As DropDownList = DirectCast(e.Row.FindControl("ddlNewPlanGrid"), DropDownList)
            If Not ddlFP Is Nothing Then
                ' c.Load_CompanyPlanList(ddlCompany.SelectedValue, ddlFPT.SelectedValue, ddlFP) --no
                ' sense trying to fill at this point because Plan type is not selected
                ddlFP.Items.Insert(0, New System.Web.UI.WebControls.ListItem("N/A", 0))
            End If

            'Load FooterClass List
            Dim ddlFC As DropDownList = DirectCast(e.Row.FindControl("ddlNewClassGrid"), DropDownList)
            If Not ddlFC Is Nothing Then
                c.Load_Company_Class_List(ddlCompany.SelectedValue, ddlFC)
                ddlFC.Items.Insert(0, New System.Web.UI.WebControls.ListItem("All Classes", 0))
            End If

            'default begin date
            Dim txtBD As TextBox = DirectCast(e.Row.FindControl("txtNewPerBeginGrid"), TextBox)
            Dim dtNow As Date = Date.Now
            Dim dtFirstOfMonth As DateTime
            dtFirstOfMonth = New DateTime(dtNow.Year, dtNow.Month, 1)
            txtBD.Text = dtFirstOfMonth.ToString("MM/dd/yyyy")

        End If
    End Sub

    Protected Sub grdDocumentPermission_RowEditing(sender As Object, e As GridViewEditEventArgs)
        Dim gvwDocumentPermission As GridView = DirectCast(sender, GridView)
        gvwDocumentPermission.EditIndex = e.NewEditIndex
        bresult = c.getAllDocumentPermissions(ddlCompany.SelectedValue, Session("DocumentId"), gvwDocumentPermission)
        btnDocAdd.Visible = False

    End Sub

    Protected Sub grdDocumentPermission_RowUpdating(sender As Object, e As GridViewUpdateEventArgs)
        Dim gvwDocumentPermission As GridView = DirectCast(sender, GridView)
        Dim gvRowPermission As GridViewRow = TryCast(DirectCast(sender, GridView).NamingContainer, GridViewRow)

        Dim intCompanyId = gvwDocumentPermission.DataKeys(e.RowIndex).Values("CompanyId")
        Dim intDocumentId = gvwDocumentPermission.DataKeys(e.RowIndex).Values("DocumentId")
        Dim intDocumentPermissionId = gvwDocumentPermission.DataKeys(e.RowIndex).Values("DocumentPermissionId")

        Dim ddlPT As DropDownList = DirectCast(gvwDocumentPermission.Rows(e.RowIndex).FindControl("ddlPlanTypeGrid"), DropDownList)
        Dim ddlP As DropDownList = DirectCast(gvwDocumentPermission.Rows(e.RowIndex).FindControl("ddlPlanGrid"), DropDownList)
        Dim ddlBC As DropDownList = DirectCast(gvwDocumentPermission.Rows(e.RowIndex).FindControl("ddlClassGrid"), DropDownList)
        Dim txtBD As TextBox = DirectCast(gvwDocumentPermission.Rows(e.RowIndex).FindControl("txtPerBeginGrid"), TextBox)
        Dim txtED As TextBox = DirectCast(gvwDocumentPermission.Rows(e.RowIndex).FindControl("txtPerEndGrid"), TextBox)

        'Save procedure here
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()
        Try

            objParam = New SqlParameter("@CompanyId", intCompanyId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@DocumentId", intDocumentId)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@DocumentPermissionId", intDocumentPermissionId)
            aryParams.Add(objParam)

            If ddlPT.SelectedValue <> 0 Then
                objParam = New SqlParameter("@PlanTypeId", ddlPT.SelectedValue)
                aryParams.Add(objParam)
            End If
            If ddlP.SelectedValue <> 0 Then
                objParam = New SqlParameter("@PlanId", ddlP.SelectedValue)
                aryParams.Add(objParam)
            End If

            If ddlBC.SelectedValue <> 0 Then
                objParam = New SqlParameter("@ClassId", ddlBC.SelectedValue)
                aryParams.Add(objParam)
            End If

            objParam = New SqlParameter("@BeginDate", txtBD.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@EndDate", txtED.Text)
            aryParams.Add(objParam)

            sqlCon.ExecuteNonQuery("[usp_DocumentPermission_Edit]", aryParams)
            sqlCon.CloseConn()

            'Save to Transaction Table
            s.SaveUserUpdate(Session("UserId"), strScreenShortDesc, "Saved on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString, 0, 0, 0, "01/01/1900", 0)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        'reLoad Permissions
        gvwDocumentPermission.EditIndex = -1
        bresult = c.getAllDocumentPermissions(ddlCompany.SelectedValue, Session("DocumentId"), gvwDocumentPermission)
        btnDocAdd.Visible = True
        ' ddlCompany.Enabled = True
    End Sub

#End Region

#Region "Add New Doc Permission"

    Protected Sub grdDocumentPermission_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        Dim grdDocumentPermission As GridView = DirectCast(sender, GridView)
        If e.CommandName = "Add" Then
            Dim ddlPT As DropDownList = CType(grdDocumentPermission.FooterRow.FindControl("ddlNewPlanTypeGrid"), DropDownList)
            Dim ddlP As DropDownList = CType(grdDocumentPermission.FooterRow.FindControl("ddlNewPlanGrid"), DropDownList)
            Dim ddlBC As DropDownList = CType(grdDocumentPermission.FooterRow.FindControl("ddlNewClassGrid"), DropDownList)
            Dim txtBD As TextBox = CType(grdDocumentPermission.FooterRow.FindControl("txtNewPerBeginGrid"), TextBox)
            Dim txtED As TextBox = CType(grdDocumentPermission.FooterRow.FindControl("txtNewPerEndGrid"), TextBox)

            intCompanyId = ddlCompany.SelectedValue

            'Save procedure here
            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()
            Try

                objParam = New SqlParameter("@CompanyId", intCompanyId)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@DocumentId", Session("DocumentId"))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@DocumentPermissionId", 0)
                aryParams.Add(objParam)

                If ddlPT.SelectedValue <> 0 Then
                    objParam = New SqlParameter("@PlanTypeId", ddlPT.SelectedValue)
                    aryParams.Add(objParam)
                End If
                If ddlP.SelectedValue <> 0 Then
                    objParam = New SqlParameter("@PlanId", ddlP.SelectedValue)
                    aryParams.Add(objParam)
                End If

                If ddlBC.SelectedValue <> 0 Then
                    objParam = New SqlParameter("@ClassId", ddlBC.SelectedValue)
                    aryParams.Add(objParam)
                End If

                objParam = New SqlParameter("@BeginDate", txtBD.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@EndDate", txtED.Text)
                aryParams.Add(objParam)

                sqlCon.ExecuteNonQuery("[usp_DocumentPermission_Edit]", aryParams)
                sqlCon.CloseConn()

                'Save to Transaction Table
                s.SaveUserUpdate(Session("UserId"), strScreenShortDesc, "Saved on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString, 0, 0, 0, "01/01/1900", 0)
            Catch ex As Exception
                Throw New Exception(ex.Message)
            End Try

            'reLoad Permissions
            grdDocumentPermission.EditIndex = -1
            bresult = c.getAllDocumentPermissions(ddlCompany.SelectedValue, Session("DocumentId"), grdDocumentPermission)
            btnDocAdd.Visible = True

        End If
    End Sub

#End Region

#Region "Child company"

    Protected Sub chkInherit_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        'Dim grdChildCompanies As GridView = DirectCast(sender, GridView)
        Dim cb As CheckBox = DirectCast(sender, CheckBox)
        Dim gr As GridViewRow = CType(cb.NamingContainer, GridViewRow)

        Dim gv As GridView = gr.NamingContainer

        Dim keys As DataKey = gv.DataKeys(gr.DataItemIndex)
        Dim ParentCompanyId As Object = keys("CompanyId1")
        Dim ChildCompanyId As Object = keys("CompanyId2")
        Dim DocumentId As Object = keys("DocumentId")

        c.UpdateCompanyInheritDocument(ChildCompanyId, ParentCompanyId, DocumentId, cb.Checked, Session("UserId"))

    End Sub

    Protected Sub chkInheritAll_CheckedChanged(sender As Object, e As EventArgs)
        Dim cb As CheckBox = DirectCast(sender, CheckBox)
        Dim gr As GridViewRow = CType(cb.NamingContainer, GridViewRow)

        Dim grdChildCompanies As GridView = DirectCast(gr.FindControl("grdChildCompanies"), GridView)

        'find the gridview, thenloop thru and do your stuff

        Dim gvr As GridViewRow

        For Each gvr In grdChildCompanies.Rows
            Dim cb1 As CheckBox
            Dim x As Integer
            cb1 = CType(grdChildCompanies.Rows(x).FindControl("chkInherit"), CheckBox)

            If cb1.Checked = False Then
                cb1.Checked = True
                Dim ParentCompanyId As Object = grdChildCompanies.DataKeys(x).Values("CompanyId1")
                Dim ChildCompanyId As Object = grdChildCompanies.DataKeys(x).Values("CompanyId2")
                Dim DocumentId As Object = grdChildCompanies.DataKeys(x).Values("DocumentId")
                c.UpdateCompanyInheritDocument(ChildCompanyId, ParentCompanyId, DocumentId, cb1.Checked, Session("UserId"))
            End If
            x += 1
        Next

    End Sub

#End Region

    Private Sub PopulateDashboard()
        If c.GetALECompanyRules(intCompanyId) = True Then
            lblMeasurementMethod.Text = c.StandardMeasurementMethod
            lblMeasurementPeriod.Text = c.StandardMeasurementPeriod
            lblPeriodBegin.Text = c.StandardMeasurementBegin
            lblPeriodEnd.Text = c.StandardMeasurementEnd
            lblIntialPeriod.Text = c.InitialMeasurementPeriod
            lblStabilityPeriod.Text = c.StabilityMeasurementPeriod
            lblAdmistrativePeriod.Text = c.AdmistrativeMeasurementPeriod

            lblLastIRSReportDate.Text = c.LastIRSReportDate
            lblNextIRSReport.Text = c.NextIRSReportDate

            lblFirstPayrollAvailable.Text = c.FirstPayrollAvailable
            lblMostRecentPayroll.Text = c.MostRecentPayrollAvailable

            lblLastALECount.Text = c.LastALECount
            lblLastALECountBegin.Text = c.LastALECountBegin
            lblLastALECountEnd.Text = c.LastALECountEnd
            lblALETrend1MonthAve.Text = c.ALETrend1MonthAve
            lblALETrend2MonthAve.Text = c.ALETrend2MonthAve
            lblALETrend3MonthAve.Text = c.ALETrend3MonthAve
            lblALETrend4MonthAve.Text = c.ALETrend4MonthAve
            lblALETrend5MonthAve.Text = c.ALETrend5MonthAve
            lblALETrend6MonthAve.Text = c.ALETrend6MonthAve
            lblALETrend7MonthAve.Text = c.ALETrend7MonthAve
            lblALETrend8MonthAve.Text = c.ALETrend8MonthAve
            lblALETrend9MonthAve.Text = c.ALETrend9MonthAve
            lblALETrend10MonthAve.Text = c.ALETrend10MonthAve
            lblALETrend11MonthAve.Text = c.ALETrend11MonthAve
            lblALETrend12MonthAve.Text = c.ALETrend12MonthAve

            ddlMeasurementMethod.SelectedValue = c.StandardMeasurementMethodId
            ddlMeasurementPeriod.SelectedValue = c.StandardMeasurementPeriodId
            ddlIntialPeriod.SelectedValue = c.InitialMeasurementPeriodId
            ddlStabilityPeriod.SelectedValue = c.StabilityMeasurementPeriodId
            ddlAdminPeriod.SelectedValue = c.AdmistrativeMeasurementPeriodId

            txtPeriodBegin.Text = c.StandardMeasurementBegin
            txtPeriodEnd.Text = c.StandardMeasurementEnd
            txtLastIRSReport.Text = c.LastIRSReportDate
            txtNextIRSReport.Text = c.NextIRSReportDate
            txtLastACACount.Text = c.LastALECount
            txtFirstPayroll.Text = c.FirstPayrollAvailable
            txtMostRecentPayroll.Text = c.MostRecentPayrollAvailable
            txtALECountBegin.Text = c.LastALECountBegin
            txtALECountEnd.Text = c.LastALECountEnd
        Else
            'clear fields
            lblMeasurementMethod.Text = ""
            lblMeasurementPeriod.Text = ""
            lblPeriodBegin.Text = ""
            lblPeriodEnd.Text = ""
            lblIntialPeriod.Text = ""
            lblStabilityPeriod.Text = ""
            lblAdmistrativePeriod.Text = ""

            lblLastIRSReportDate.Text = ""
            lblNextIRSReport.Text = ""

            lblFirstPayrollAvailable.Text = ""
            lblMostRecentPayroll.Text = ""

            lblLastALECount.Text = ""
            lblLastALECountBegin.Text = ""
            lblLastALECountEnd.Text = ""
            lblALETrend1MonthAve.Text = ""
            lblALETrend2MonthAve.Text = ""
            lblALETrend3MonthAve.Text = ""
            lblALETrend4MonthAve.Text = ""
            lblALETrend5MonthAve.Text = ""
            lblALETrend6MonthAve.Text = ""
            lblALETrend7MonthAve.Text = ""
            lblALETrend8MonthAve.Text = ""
            lblALETrend9MonthAve.Text = ""
            lblALETrend10MonthAve.Text = ""
            lblALETrend11MonthAve.Text = ""
            lblALETrend12MonthAve.Text = ""

            ddlMeasurementMethod.SelectedIndex = 0
            ddlMeasurementPeriod.SelectedIndex = 0
            ddlIntialPeriod.SelectedIndex = 0
            ddlStabilityPeriod.SelectedIndex = 0
            ddlAdminPeriod.SelectedIndex = 0

            txtPeriodBegin.Text = ""
            txtPeriodEnd.Text = ""
            txtLastIRSReport.Text = ""
            txtNextIRSReport.Text = ""
            txtLastACACount.Text = "0"
            txtFirstPayroll.Text = ""
            txtMostRecentPayroll.Text = ""
            txtALECountBegin.Text = ""
            txtALECountEnd.Text = ""

        End If
    End Sub

End Class