Imports System.Data.SqlClient

Public Class Admin_EEAdd
    Inherits System.Web.UI.Page
    Dim s As New Security
    Dim c As New Company
    Dim ec As New Employee
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

        'Change this on each page
        strScreenName = "AdminEEAdd"

        If Page.IsPostBack = False Then
            intCompanyId = Session("ShadowCompanyId")
            s.SaveUserBrowse(Session("UserId"), strScreenName, "Browsed on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString)

            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_EEAdd")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), 0, "Admin_EEAdd", Session("Athena"))

            'Load up Drop Down Lists
            ec.LoadPrefix(ddlPrefix)
            ec.LoadSuffix(ddlSuffix)
            ec.LoadPayType(ddlPaytype)
            ec.LoadEmploymentStatus(ddlStatus)
            ec.LoadSalaryType(ddlPayPer)
            ec.LoadPayFrequency(ddlPayFrequency)
            ec.LoadPayFrequency(ddlDeductionFrequency)

            PopulateCompanyInfo()
            PopulateCompanyDetailInfo()

            Session("RegistrationKey") = ec.GetUniqueKey 'System.Web.Security.Membership.GeneratePassword(12, 1)

            Page.SetFocus(txtEENumber)

        End If

        DivError.Visible = False
        DivSuccess.Visible = False

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
                DivCompanyList.Visible = False
            End If
        Else
            DivCompanyName.Visible = False
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

    Private Sub PopulateCompanyDetailInfo()
        If Session("ShadowCompanyId") <> 0 Then
            If c.GetCompanyInfo(Session("ShadowCompanyId"), Session("UserId")) = True Then
                lblInitialWait.Text = c.InitialWaitPeriod
                lblLastEmployeeNumberUsed.Text = c.LastEmployeeNumberUsed
                TextDOHFormatted.Text = DateTime.Parse(c.DefaultHireDate).ToString("yyyy-MM-dd")
                TextEligDateFormated.Text = DateTime.Parse(c.DefaultEligibilityDate).ToString("yyyy-MM-dd")
                txtNewHireDate.Text = DateTime.Parse(c.DefaultHireDate).ToString("MM/dd/yyyy")
                txtEligibilityDate.Text = DateTime.Parse(c.DefaultEligibilityDate).ToString("MM/dd/yyyy")
                lblCompanyName1.Text = c.LongDesc
                DivCoDefaultInfo.Visible = True
                TxtDefaultWaitPeriod.Text = c.InitialWaitPeriodId
                TxtInitialWaitIncrement.Text = c.InitialWaitIncrement
                TxtBeginOfMonthFollowing.Text = c.BeginOfMonthFollowing
            End If

        Else
            DivCoDefaultInfo.Visible = False
        End If

        c.Load_Company_Class_List(intCompanyId, ddlBenefitClass)
        c.Load_Company_Department_List(intCompanyId, ddlDepartment)
        c.Load_Company_Division_List(intCompanyId, ddlDivision)

        ddlPrefix.Items.Insert(0, New ListItem("Prefix"))
        ddlSuffix.Items.Insert(0, New ListItem("Suffix"))
        ddlPaytype.Items.Add(New ListItem("", "0"))
        ddlPayPer.Items.Add(New ListItem("", "0"))
        ddlPayFrequency.Items.Add(New ListItem("", "0"))
        ddlDeductionFrequency.Items.Add(New ListItem("", "0"))
        ddlStatus.Items.Add(New ListItem("", "0"))
        ddlBenefitClass.Items.Add(New ListItem("", "0"))
        ddlDepartment.Items.Add(New ListItem("", "0"))
        ddlDivision.Items.Add(New ListItem("", "0"))

        ddlPaytype.SelectedValue = 0
        ddlStatus.SelectedValue = 0
        ddlPayFrequency.SelectedValue = 0
        ddlDeductionFrequency.SelectedValue = 0
        ddlPayPer.SelectedValue = 0
        ddlBenefitClass.SelectedValue = 0
        ddlDepartment.SelectedValue = 0
        ddlDivision.SelectedValue = 0

    End Sub

    Private Sub ClearData()
        txtEENumber.Text = ""
        ddlPrefix.SelectedValue = "Prefix"
        txtFirstName.Text = ""
        txtMiddleName.Text = ""
        txtLastName.Text = ""
        ddlSuffix.SelectedValue = "Suffix"
        txtEmail.Text = ""
        txtMobilePhone.Text = ""
        txtSalary.Text = ""
        ddlBenefitClass.SelectedValue = 0
        ddlPayPer.SelectedValue = 0
        ddlStatus.SelectedValue = 0
        ddlPaytype.SelectedValue = 0
        txtBenefitSalary.Text = ""
        ddlPayFrequency.SelectedValue = 0
        ddlDeductionFrequency.SelectedValue = 0
        txtOccupation.Text = ""
        txtStandardHours.Text = ""
        ddlDivision.SelectedValue = 0
        ddlDepartment.SelectedValue = 0
        txtManager.Text = ""
        ddlCategory.SelectedValue = 0
        chkOwner.Checked = False
        chkTest.Checked = False
        chkOnboarding.Checked = False

    End Sub

    Public Sub btnAdminSave_Click(sender As Object, e As ImageClickEventArgs)

        intCompanyId = Session("ShadowCompanyId")

        'Validate Data is there for All Required Fields
        If txtEENumber.Text = "" Or txtFirstName.Text = "" Or txtLastName.Text = "" Or txtNewHireDate.Text = "" Or txtEmail.Text = "" Or txtSalary.Text = "" Or txtEligibilityDate.Text = "" Or txtBenefitSalary.Text = "" Or ddlPayPer.SelectedItem.Text = "" Or ddlStatus.SelectedItem.Text = "" Or ddlPaytype.SelectedItem.Text = "" Or ddlPayFrequency.SelectedItem.Text = "" Or ddlDeductionFrequency.SelectedItem.Text = "" Or ddlBenefitClass.SelectedItem.Text = "" Or txtOccupation.Text = "" Then
            lblError.Text = "Please complete all required fields."
            If txtEENumber.Text = "" Or txtEENumber.Text = " " Then
                txtEENumber.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Else
                txtEENumber.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If

            If txtFirstName.Text = "" Then
                txtFirstName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Else
                txtFirstName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If

            If txtLastName.Text = "" Then
                txtLastName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Else
                txtLastName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If

            If (txtNewHireDate.Text = "" Or txtNewHireDate.Text = "01/01/1900") And (TextDOHUpdated.Text = "" Or TextDOHUpdated.Text = "01/01/1900") Then
                txtNewHireDate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Else
                txtNewHireDate.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
            End If

            If txtEmail.Text = "" Then
                txtEmail.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Else
                txtEmail.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If

            If txtSalary.Text = "" Then
                txtSalary.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Else
                txtSalary.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If

            If txtEligibilityDate.Text = "" Then
                txtEligibilityDate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Else
                txtEligibilityDate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If

            If txtBenefitSalary.Text = "" Then
                txtBenefitSalary.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Else
                txtBenefitSalary.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If

            If ddlPayPer.SelectedItem.Text = "" Then
                ddlPayPer.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Else
                ddlPayPer.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If

            If ddlStatus.SelectedItem.Text = "" Then
                ddlStatus.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Else
                ddlStatus.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If

            If ddlPaytype.SelectedItem.Text = "" Then
                ddlPaytype.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Else
                ddlPaytype.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If

            If ddlPayFrequency.SelectedItem.Text = "" Then
                ddlPayFrequency.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Else
                ddlPayFrequency.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If

            If ddlDeductionFrequency.SelectedItem.Text = "" Then
                ddlDeductionFrequency.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Else
                ddlDeductionFrequency.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If

            If ddlBenefitClass.SelectedItem.Text = "" Then
                ddlBenefitClass.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Else
                ddlBenefitClass.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If

            If txtOccupation.Text = "" Then
                txtOccupation.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Else
                txtOccupation.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If

            DivError.Visible = True
            ResetScrollPosition()
            Exit Sub
        End If

        Dim intEmployeeId As Integer
        intEmployeeId = 0

        If ec.IsUniqueEENumber(intCompanyId, intEmployeeId, txtEENumber.Text) = 0 Then
            lblError.Text = "Employee Number must be unique per Company"
            DivError.Visible = True
            ResetScrollPosition()
            Exit Sub
        End If

        If txtBenefitSalary.Text = "NaN" Then
            lblError.Text = "Benefit Salary must be numeric and greater than $0.00"
            DivError.Visible = True
            ResetScrollPosition()
            Exit Sub
        End If

        If TextDOHUpdated.Text <> "" And TextDOHUpdated.Text <> "01/01/1900" Then
            txtNewHireDate.Text = TextDOHUpdated.Text
        End If

        If txtNewHireDate.Text = "" Or txtNewHireDate.Text = "01/01/1900" Then
            txtNewHireDate.Text = Date.Now()
        End If

        imgProcessing.Visible = True

        'Save New Contact Info 
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        objParam = New SqlParameter("@CompanyId", intCompanyId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EENumber", txtEENumber.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Prefix", IIf(ddlPrefix.SelectedValue = "Prefix", "", ddlPrefix.SelectedValue))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@FirstName", txtFirstName.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@MiddleName", txtMiddleName.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@LastName", txtLastName.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Suffix", IIf(ddlSuffix.SelectedValue = "Suffix", "", ddlSuffix.SelectedValue))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@HireDate", txtNewHireDate.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Email1", Me.txtEmail.Text.Trim)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@PayRate", IIf(txtSalary.Text = "", 0, txtSalary.Text))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@MobilePhone", txtMobilePhone.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", ""))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@PayPer", ddlPayPer.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@StatusId", ddlStatus.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@PayTypeId", ddlPaytype.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@PayFrequencyId", ddlPayFrequency.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EligDate", txtEligibilityDate.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DeductionFrequencyId", ddlDeductionFrequency.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@BenefitSalary", IIf(txtBenefitSalary.Text = "", 0, txtBenefitSalary.Text.Replace("$", "").Replace(",", "")))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Division", ddlDivision.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Class", ddlBenefitClass.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Department", ddlDepartment.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@StandardHours", IIf(txtStandardHours.Text = "", 0, txtStandardHours.Text))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Category", ddlCategory.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Occupation", txtOccupation.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Manager", txtManager.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Owner", chkOwner.Checked)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@TestPerson", chkTest.Checked)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@InOnboarding", chkOnboarding.Checked)
        aryParams.Add(objParam)

        objParam = New SqlParameter("@RegistrationKey", Session("RegistrationKey"))
        aryParams.Add(objParam)

        objParam = New SqlParameter("@UserId", Session("UserId"))
        aryParams.Add(objParam)

        Try
            objDataSet = sqlCon.CreateDataSet("usp_Employee_Add", aryParams)

            If objDataSet.Tables(0).Rows.Count > 0 Then
                Session("ShadowEmployeeId") = objDataSet.Tables(0).Rows(0).Item("EmployeeId")
                Session("URL") = objDataSet.Tables(0).Rows(0).Item("URL")
                Session("NewEmployee") = 0
                DivSuccess.Visible = True
                lblSuccess.Text = "You have sucessfully Saved " + txtFirstName.Text + " " + txtLastName.Text
                Session("ShadowEmployeeName") = txtFirstName.Text + " " + txtLastName.Text
            Else
                DivError.Visible = True
                lblError.Text = "Failed to return EmployeeId"
            End If

            'Save to Transaction Table
            s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), Session("ShadowEmployeeId"), 0, 0, "01/01/1900", 0)

            ResetScrollPosition()

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        sqlCon.CloseConn()
        aryParams = Nothing
        sqlCon = Nothing

        Response.AddHeader("REFRESH", "2;URL=../EE_WebConfig.aspx")

        imgProcessing.Visible = False

    End Sub

    Protected Sub txtNewHireDate_TextChanged(sender As Object, e As EventArgs)
        If txtNewHireDate.Text.Length < 10 Then
            txtNewHireDate.Text = txtNewHireDate.Text
            Exit Sub
        Else
            'If Convert.ToDateTime(Me.txtNewHireDate.Text) > DateTime.Now.Date.AddYears(1) Or Convert.ToDateTime(Me.txtNewHireDate.Text) < DateTime.Now.Date.AddYears(-50) Then
            '    lblError.Text = "Please enter valid date"
            '    DivError.Visible = True
            '    Exit Sub
            'End If
            'If Session("ShadowCompanyId") Is Nothing Then
            'Exit Sub
            'Else
            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()

            objParam = New SqlParameter("@CompanyId", Session("ShadowCompanyId"))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@HireDate", DateTime.Parse(txtNewHireDate.Text).ToString("MM/dd/yyyy"))
            aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("usp_Employee_Default_Eligibility_Date_Get", aryParams)

            If objDataSet.Tables(0).Rows.Count > 0 Then
                TextDOHFormatted.Text = DateTime.Parse(txtNewHireDate.Text).ToString("yyyy-MM-dd")
                TextEligDateFormated.Text = DateTime.Parse(objDataSet.Tables(0).Rows(0).Item("EligibilityDate")).ToString("yyyy-MM-dd")
                txtNewHireDate.Text = txtNewHireDate.Text
                txtEligibilityDate.Text = DateTime.Parse(objDataSet.Tables(0).Rows(0).Item("EligibilityDate"))
            End If
            sqlCon.CloseConn()
            aryParams = Nothing
            sqlCon = Nothing

        End If

    End Sub

    Protected Sub txtBenefitSalary_TextChanged(sender As Object, e As EventArgs)
        If txtBenefitSalary.Text Like "*,*" Then
            txtBenefitSalary.Text = txtBenefitSalary.Text.Replace(",", "")
        Else txtBenefitSalary.Text = txtBenefitSalary.Text
        End If
    End Sub

    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ShadowCompanyId") = ddlCompany.SelectedValue
        intCompanyId = Session("ShadowCompanyId")

        PopulateCompanyInfo()
        PopulateCompanyDetailInfo()
        ClearData()
    End Sub

    Protected Sub chkActive_CheckedChanged(sender As Object, e As EventArgs)
        Session("ActiveCompany") = IIf(chkActive.Checked = True, 1, 0)

        Session("ShadowCompanyId") = 0
        intCompanyId = 0

        PopulateCompanyInfo()
        PopulateCompanyDetailInfo()
        ClearData()
    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Response.Redirect("~/Admin_EESelect.aspx")
    End Sub

    Private Sub ResetScrollPosition()
        If Not ClientScript.IsClientScriptBlockRegistered(Me.GetType(), "CreateResetScrollPosition") Then
            'Create the ResetScrollPosition() function
            ClientScript.RegisterClientScriptBlock(Me.GetType(), "CreateResetScrollPosition",
                             "function ResetScrollPosition() {" & vbCrLf &
                             " var scrollX = document.getElementById('__SCROLLPOSITIONX');" & vbCrLf &
                             " var scrollY = document.getElementById('__SCROLLPOSITIONY');" & vbCrLf &
                             " if (scrollX && scrollY) {" & vbCrLf &
                             "    scrollX.value = 0;" & vbCrLf &
                             "    scrollY.value = 0;" & vbCrLf &
                             " }" & vbCrLf &
                             "}", True)

            'Add the call to the ResetScrollPosition() function
            ClientScript.RegisterStartupScript(Me.GetType(), "CallResetScrollPosition", "ResetScrollPosition();", True)
        End If
    End Sub

    Protected Sub btnClearSearch_Click(sender As Object, e As EventArgs)
        ClearData()
        PopulateCompanyDetailInfo()
    End Sub

    'Protected Sub txtEligibilityDate_TextChanged(sender As Object, e As EventArgs)
    '    If txtNewHireDate.Text.Length = 0 Then
    '        Exit Sub
    '    End If
    '    If txtNewHireDate.Text.Length <> 10 Then
    '        lblError.Text = "Please enter valid date"
    '        DivError.Visible = True
    '        Exit Sub
    '    End If
    '    If Convert.ToDateTime(Me.txtNewHireDate.Text) > DateTime.Now.Date.AddYears(1) Or Convert.ToDateTime(Me.txtNewHireDate.Text) < DateTime.Now.Date.AddYears(-50) Then
    '        lblError.Text = "Please enter valid date"
    '        DivError.Visible = True
    '        Exit Sub
    '    End If
    '    If Session("ShadowCompanyId") Is Nothing Then
    '        Exit Sub
    '    Else
    '        txtEligibilityDate.Text = DateTime.Parse(txtEligibilityDate.Text).ToString("MM/dd/yyyy")
    '    End If
    'End Sub
End Class