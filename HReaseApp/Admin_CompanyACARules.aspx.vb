Imports System.Data.SqlClient

Public Class Admin_CompanyACARules
    Inherits System.Web.UI.Page
    Dim s As New Security
    Dim c As New Company
    Dim sc As New ScreenConfiguration
    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Dim intCompanyId As Integer
    Dim intUserId As Integer

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
        strScreenName = "ACARules"
        strScreenShortDesc = "Company ACA Rules"

        If Page.IsPostBack = False Then

            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_CompanyACARules")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), 0, "Admin_CompanyACARules", Session("Athena"))

            'Hide Edit Areas
            divEdit.Visible = False

            'Fill Period drop downs
            c.Load_Period_List(ddlAdminPeriod)
            c.Load_Period_List(ddlIntialPeriod)
            c.Load_Period_List(ddlMeasurementPeriod)
            c.Load_Period_List(ddlStabilityPeriod)

            'Fill MeasurementMethod
            c.Load_Method_List(ddlMeasurementMethod)

            PopulateCompanyInfo()
            PopulateACAInfo()

            s.SaveUserBrowse(Session("UserId"), strScreenName, "Browsed on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString)

        End If

        btnSave.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSave, "") + ";this.src='/img/processing.gif';")
        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateCompanyInfo()

        Session("ActiveCompany") = IIf(chkActive.Checked = True, 1, 0)

        'Fill up Company list based on UserId
        c.LoadCompanyList(Session("UserId"), Session("ShadowCompanyId"), "Consolidated", "", Session("ActiveCompany"), 0, 0, Session("ds"))

        ddlCompany.DataSource = Session("ds").tables(0)
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

    Private Sub PopulateACAInfo()
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

    Protected Sub btnEditRules_Click(sender As Object, e As EventArgs) Handles btnEditRules.Click
        divNextButton.Visible = False
        divTopHeader.Visible = False
        divReviewACARules.Visible = False
        divACACounts.Visible = False
        divEdit.Visible = True
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        PopulateCompanyInfo()

        divNextButton.Visible = True
        divTopHeader.Visible = True
        divReviewACARules.Visible = True
        divEdit.Visible = False
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As ImageClickEventArgs)

        intCompanyId = Session("ShadowCompanyId")

        'Save ACA Rule Info 
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        objParam = New SqlParameter("@CompanyId", intCompanyId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@StdMeasurementMethod", ddlMeasurementMethod.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@StdMeasurementPeriodId", ddlMeasurementPeriod.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@StdMeasurementPeriodBegin", txtPeriodBegin.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@StdMeasurementPeriodEnd", txtPeriodEnd.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@InitialMeasurementPeriodId", ddlIntialPeriod.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@StabilityMeasurementPeriodId", ddlStabilityPeriod.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@AdministrativeMeasurementPeriod", ddlAdminPeriod.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@LastALECount", txtLastACACount.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@LastALECountBeginDate", txtALECountBegin.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@LastALECountEndDate", txtALECountEnd.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@LastIRSReportDate", txtLastIRSReport.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@NextIRSReportDate", txtNextIRSReport.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@FirstPayrollAvailable", txtFirstPayroll.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@MostRecentPayrollAvailable", txtMostRecentPayroll.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@UserId", Session("UserId"))
        aryParams.Add(objParam)

        objDataSet = sqlCon.CreateDataSet("[usp_Company_ACARules_Edit]", aryParams)
        sqlCon.CloseConn()

        'Save to Transaction Table
        s.SaveUserUpdate(Session("UserId"), strScreenShortDesc, "Saved on " + strScreenShortDesc + " for CompanyId " + intCompanyId.ToString, 0, 0, 0, "01/01/1900", 0)

        PopulateCompanyInfo()
        PopulateACAInfo()

        divNextButton.Visible = True
        divTopHeader.Visible = True
        divReviewACARules.Visible = True
        divEdit.Visible = False
    End Sub

    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ShadowCompanyId") = ddlCompany.SelectedValue
        intCompanyId = Session("ShadowCompanyId")

        PopulateCompanyInfo()
        PopulateACAInfo()

    End Sub

    Protected Sub chkActive_CheckedChanged(sender As Object, e As EventArgs)
        Session("ActiveCompany") = IIf(chkActive.Checked = True, 1, 0)

        Session("ShadowCompanyId") = 0
        intCompanyId = 0

        PopulateCompanyInfo()
        PopulateACAInfo()

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Session.Remove("AddNew")
        Response.Redirect("~/Admin_CompanyAdminSelect.aspx")
    End Sub
End Class
