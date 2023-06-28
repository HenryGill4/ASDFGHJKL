Imports System.Data.SqlClient

Public Class EE_Profile
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim c As New Company
    Dim ec As New Employee
    Dim p As New Plans

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer

    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Dim booGotEmployee As Boolean

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EEProfile"
        strScreenShortDesc = "Employee Profile"

        If Session("Admin") = True Then
            intCompanyId = Session("ShadowCompanyId")
            intEmployeeId = Session("ShadowEmployeeId")
            Session("DisplayName") = Session("AdminName")
            
        Else
            Session("DisplayName") = Session("EmployeeName")
            
            intCompanyId = Session("CompanyId")
            intEmployeeId = Session("EmployeeId")
        End If

        If Page.IsPostBack = False Then
            s.SaveUserUpdate(Session("UserId"), strScreenName, "Browse", intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

            GetNavigationAndTabs()

            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), Session("ScreenPath"))
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            sc.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            lblMainArticleTitle.Text = sc.MainArticleTitle
            lblMainArticleText.Text = sc.MainArticleText
            imgNext.Visible = False

            divUpdatePic.Visible = False

            LoadPageInfo()
            PopulateEmpFields()

            If lblFullName.Text = "" Or lblAddress.Text = "" Or lblCity.Text = "" Or lblState.Text = "" Or lblCountry.Text = "" Or lblEmail1.Text = "" Then
                If Session("Admin") = False Then
                    divContactEdit.Visible = True
                    divContactReview.Visible = False
                    divDemographicReview.Visible = False
                    divDemographicEdit.Visible = False
                    divAdminEdit.Visible = False
                    divAdminReview.Visible = False
                End If

            End If

            If lblMainArticleText.Text = "" Then
                divText.Visible = False
            End If
            If lblMainArticleTitle.Text = "" Then
                divTitle.Visible = False
            End If

            divError.Visible = False

        End If

        If Session("DataComplete") = "Yes" And divError.Visible = False Then
            divSuccess.Visible = True
            imgNext.Visible = True
        Else
            divSuccess.Visible = False
            imgNext.Visible = False

        End If

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub LoadPageInfo()
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Dim objParam As SqlParameter
        Dim objDataSet As DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()
        objParam = New SqlParameter("@EmployeeID", intEmployeeId)
        aryParams.Add(objParam)
        objDataSet = sqlCon.CreateDataSet("[usp_EEGoingThruOnboarding]", aryParams)

        If objDataSet.Tables(0).Rows.Count > 0 Then
            Session("bOnboarding") = objDataSet.Tables(0).Rows(0).Item("Onboarding")
        Else
            Session("bOnboarding") = 0
        End If

        If Session("Admin") = True And Request.QueryString("edit") Is Nothing Then
            divContactReview.Visible = True
            divDemographicReview.Visible = True
            divAdminReview.Visible = True
            divContactEdit.Visible = False
            divDemographicEdit.Visible = False
            divAdminEdit.Visible = False
            imgNext.Visible = True
        ElseIf Session("Admin") = True And Request.QueryString("edit") = "contact" Then
            divContactReview.Visible = False
            divDemographicReview.Visible = False
            divAdminReview.Visible = False
            divContactEdit.Visible = True
            divDemographicEdit.Visible = False
            divAdminEdit.Visible = False
            imgNext.Visible = False
        ElseIf Session("Admin") = True And Request.QueryString("edit") = "demo" Then
            divContactReview.Visible = False
            divDemographicReview.Visible = False
            divAdminReview.Visible = False
            divContactEdit.Visible = False
            divDemographicEdit.Visible = True
            divAdminEdit.Visible = False
            imgNext.Visible = False
        ElseIf Session("Admin") = True And Request.QueryString("edit") IsNot Nothing Then
            divContactReview.Visible = False
            divDemographicReview.Visible = False
            divAdminReview.Visible = False
            divContactEdit.Visible = False
            divDemographicEdit.Visible = False
            divAdminEdit.Visible = True
            imgNext.Visible = False
        ElseIf Request.QueryString("edit") = "contact" Then
            divContactReview.Visible = False
            divDemographicReview.Visible = False
            divAdminReview.Visible = False
            divContactEdit.Visible = True
            divDemographicEdit.Visible = False
            divAdminEdit.Visible = False
            imgNext.Visible = False
        ElseIf Request.QueryString("edit") = "demo" Then
            divContactReview.Visible = False
            divDemographicReview.Visible = False
            divAdminReview.Visible = False
            divContactEdit.Visible = False
            divDemographicEdit.Visible = True
            divAdminEdit.Visible = False
            imgNext.Visible = False
        ElseIf Request.QueryString("edit") Is Nothing Then
            divContactReview.Visible = True
            divDemographicReview.Visible = True
            divAdminReview.Visible = False
            divContactEdit.Visible = False
            divDemographicEdit.Visible = False
            divAdminEdit.Visible = False
            imgNext.Visible = True
        Else
            divContactReview.Visible = True
            divDemographicReview.Visible = True
            divAdminReview.Visible = True
            divContactEdit.Visible = False
            divDemographicEdit.Visible = False
            divAdminEdit.Visible = False
            imgNext.Visible = True
        End If
        If Session("Admin") = True Then
            ec.FillEmployeeNotes(Session("ShadowEmployeeId"), grdEmployeeNotes)
            mlblInfoTitle.Text = "Employee Notes for " + Session("ShadowEmployeeName")
        End If

        'Load up Drop Down Lists
        ec.LoadPrefix(ddlPrefix)
        ec.LoadSuffix(ddlSuffix)
        ec.LoadState(ddlState)
        ec.LoadCountry(ddlCountry)
        ec.LoadEthnicity(ddlEthnicity)
        ec.LoadMaritalStatus(ddlMaritalStatus)
        ec.LoadMilitaryStatus(ddlMilitaryStatus)
        ec.LoadEducationLevel(ddlEducationLevel)
        ec.LoadLanguage(ddlLanguage)
        ec.LoadGender(ddlGender)
        ec.LoadPayType(ddlPaytype)
        ec.LoadEmploymentStatus(ddlStatus)
        ec.LoadPayFrequency(ddlPayFrequency)
        ec.LoadPayFrequency(ddlDeductionFrequency)
        ec.LoadSalaryType(ddlPayPer)
        ec.LoadTerminationReason(ddlTerminationReason)
        ec.LoadCobraLength(ddlCobraLength)

        c.Load_Company_Class_List(intCompanyId, ddlBenefitClass)
        c.Load_Company_Category_List(intCompanyId, ddlCategory)
        c.Load_Company_Department_List(intCompanyId, ddlDepartment)
        c.Load_Company_Division_List(intCompanyId, ddlDivision)

        ddlPrefix.Items.Insert(0, New ListItem(""))
        ddlSuffix.Items.Insert(0, New ListItem(""))
        ddlState.Items.Insert(0, New ListItem(""))
        ddlCountry.Items.Insert(0, New ListItem(""))

        ddlEthnicity.Items.Add(New ListItem("", "0"))
        ddlMaritalStatus.Items.Add(New ListItem("", "0"))
        ddlMilitaryStatus.Items.Add(New ListItem("", "0"))
        ddlEducationLevel.Items.Add(New ListItem("", "0"))
        ddlLanguage.Items.Add(New ListItem("", "0"))
        ddlPaytype.Items.Add(New ListItem("", "0"))
        ddlPayFrequency.Items.Add(New ListItem("", "0"))
        ddlDeductionFrequency.Items.Add(New ListItem("", "0"))
        ddlStatus.Items.Add(New ListItem("", "0"))

        ddlPayPer.Items.Add(New ListItem("", "0"))
        ddlDepartment.Items.Add(New ListItem("", "0"))
        ddlDivision.Items.Add(New ListItem("", "0"))
        ddlBenefitClass.Items.Add(New ListItem("", "0"))

        btnSaveContact.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSaveContact, "") + ";this.src='/img/processing.gif';")
        btnSaveDemo.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSaveDemo, "") + ";this.src='/img/processing.gif';")
        btnAdminEdit.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnAdminEdit, "") + ";this.src='/img/processing.gif';")
        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub
    Public Sub GetNavigationAndTabs()
        If sc.GetNavigation(Session("UserId"), intEmployeeId, strScreenName, 0) = True Then
            Session("ScreenName") = sc.ScreenName
            Session("ScreenShortDesc") = sc.ScreenShortDesc
            Session("ScreenPath") = sc.ScreenPath
            Session("DataComplete") = sc.DataComplete
            Session("NextScreen") = sc.NextScreen
            Session("TabString") = sc.TabString
            Session("ScreenConfigTitle") = sc.ScreenConfigTitle
            Session("ScreenConfigText") = sc.ScreenConfigText

        End If
    End Sub
    Private Sub PopulateEmpFields()
        If ec.GetEmployeeInfo(intCompanyId, intEmployeeId) = True Then

            '---------------- CONTACT INFO  LABELS  ------------------'
            'lblEmployeeName.Text = ec.FullName
            lblFullName.Text = ec.FullName
            lblAddress.Text = ec.Address1
            lblAddress2.Text = ec.Address2
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblCountry.Text = ec.Country
            If Not ec.ZipExtension Is Nothing And Len(ec.ZipExtension) > 1 Then
                lblZip.Text = ec.Zip & "-" & ec.ZipExtension
            Else
                lblZip.Text = ec.Zip
            End If

            If ec.PrimaryPhone = "Home" Then
                lblHomePhone.Text = "<b>Home:  " & ec.HomePhone & "</b>"
                lblHomePhone.CssClass = "text-success"
            Else
                lblHomePhone.Text = "<b>Home:</b>  " & ec.HomePhone
                lblHomePhone.CssClass = "control-label"
            End If

            If ec.PrimaryPhone = "Work" Then
                lblWorkPhone.Text = "<b>Work:  " & ec.WorkPhone & "</b>"
                lblWorkPhone.CssClass = "text-success"
            Else
                lblWorkPhone.Text = "<b>Work: </b> " & ec.WorkPhone
                lblWorkPhone.CssClass = "control-label"
            End If

            If ec.PrimaryPhone = "Mobile" Then
                lblMobilePhone.Text = "<b>Mobile:  " & ec.MobilePhone & "</b> "
                lblMobilePhone.CssClass = "text-success"
            Else
                lblMobilePhone.Text = "<b>Mobile:</b>  " & ec.MobilePhone
                lblMobilePhone.CssClass = "control-label"
            End If

            If ec.PrimaryEmail = "Email1" Then
                lblEmail1.Text = "<b>" + ec.Email1 + "</b>"
                lblEmail1.CssClass = "text-success"
            Else
                lblEmail1.Text = ec.Email1
                lblEmail1.CssClass = "control-label"
            End If
            If ec.PrimaryEmail = "Email2" Then
                lblEmail2.Text = "<b>" + ec.Email2 + "</b>"
                lblEmail2.CssClass = "text-success"
            Else
                lblEmail2.Text = ec.Email2
                lblEmail2.CssClass = "control-label"
            End If

            imgEmployee.ImageUrl = ec.ProfilePic

            '-------------  CONTACT INFO EDIT MODE  ---------------'
            txtFirstName.Text = ec.FirstName
            txtMiddleName.Text = ec.MiddleName
            txtLastName.Text = ec.LastName
            txtAddress1.Text = ec.Address1
            txtAddress2.Text = ec.Address2
            txtCity.Text = ec.City
            txtZip.Text = ec.Zip
            txtZipExt.Text = ec.ZipExtension

            txtHomePhone.Text = ec.HomePhone
            txtWorkPhone.Text = ec.WorkPhone
            txtCellPhone.Text = ec.MobilePhone

            txtEmail1.Text = ec.Email1
            txtEmail2.Text = ec.Email2

            rbtnHomePhone.Checked = IIf(ec.PrimaryPhone = "Home", True, False)
            rbtnWorkPhone.Checked = IIf(ec.PrimaryPhone = "Work", True, False)
            rbtnCellPhone.Checked = IIf(ec.PrimaryPhone = "Mobile", True, False)
            rbtnEmail1.Checked = IIf(ec.PrimaryEmail = "Email1", True, False)
            rbtnEmail2.Checked = IIf(ec.PrimaryEmail = "Email2", True, False)

            ddlPrefix.SelectedValue = IIf(ec.Prefix <> "", ec.Prefix, "")
            ddlSuffix.SelectedValue = IIf(ec.Suffix <> "", ec.Suffix, "")
            ddlState.SelectedValue = IIf(ec.State <> "", ec.State, "")
            ddlCountry.SelectedValue = IIf(ec.Country <> "", ec.Country, "USA")

            '----Demographic Review Fields
            lblSSN.Text = ec.SSN
            lblDateofBirth.Text = ec.BirthDate
            lblEmployeeNumber.Text = ec.EENumber
            lblTobacco.Text = ec.TobaccoUser
            lblMaritalStatus.Text = ec.MaritalStatusDesc
            lblGender.Text = ec.GenderDesc
            lblLanguage.Text = ec.LanguageDesc
            lblMilitary.Text = ec.MilitaryStatusDesc
            lblEducationLevel.Text = ec.EducationLevel
            lblEthnicGroup.Text = ec.EthnicGroupDesc

            '----Demographic Edit Fields
            txtSSN.Text = ec.SSN
            txtDoB.Text = ec.BirthDate
            txtEENumber.Text = ec.EENumber
            ddlGender.SelectedValue = ec.Gender
            ddlLanguage.SelectedValue = ec.Language
            ddlMaritalStatus.SelectedValue = ec.MaritalStatus
            ddlEthnicity.SelectedValue = ec.EthnicGroup
            ddlMilitaryStatus.SelectedValue = ec.MilitaryStatus
            'ddlEducationLevel.SelectedValue = ec.EducationLevel
            chkTobacco.Checked = ec.TobaccoUser
            chkOwner.Checked = ec.Owner

            '------Admin Review Fields
            lblHireDate.Text = IIf(ec.OriginalHireDate <> "", ec.OriginalHireDate, "<b>REQUIRED</b>")
            lblRehireDate.Text = ec.LatestRehireDate
            lblPaytype.Text = ec.PayTypeDesc
            lblStatus.Text = ec.StatusDesc
            lblEligibilityDate.Text = IIf(ec.OriginalEligibilityDate <> "", ec.OriginalEligibilityDate, "<b>REQUIRED</b>")
            lblReEligDate.Text = ec.LatestEligibilityDate
            lblSalary.Text = FormatCurrency(ec.SalaryAmount)
            lblBenefitSalary.Text = IIf(ec.BenefitSalary <> "", FormatCurrency(ec.BenefitSalary), "<b>REQUIRED</b>")
            lblCategory.Text = ec.CategoryDesc
            lblManager.Text = ec.Manager
            lblOccupation.Text = ec.Occupation
            lblStandardHours.Text = ec.StandardHours
            lblPayFrequency.Text = ec.PayFrequencyDesc
            lblDeductionFrequency.Text = ec.DeductionFrequencyDesc
            lblBenefitClassEffDate.Text = ec.BenefitClassEffDate
            lblBenefitClass.Text = ec.ClassDesc
            lblTerminationDate.Text = ec.TerminationDate
            lblTerminationReason.Text = IIf(ec.TerminationDate <> "", ec.TerminationReasonDesc, "")
            lblCobra.Text = IIf(ec.CobraLength <> "0", ec.CobraLength, "")
            lblTestPerson.Visible = IIf(ec.TestPerson = True, True, False)
            lblOwner.Text = IIf(ec.Owner = True, "True", "False")
            lblInOnboarding.Text = IIf(ec.InOnboarding = True, "True", "False")
            lblDivision.Text = ec.DivisionDesc
            lblDepartment.Text = ec.DepartmentDesc
            lblSalaryTypeDesc.Text = ec.SalaryTypeDesc
            lblOther.Text = ec.Other

            '----Admin Edit
            txtHireDate.Text = IIf(ec.OriginalHireDate <> "", ec.OriginalHireDate, "")
            txtRehire.Text = IIf(ec.LatestRehireDate <> "", ec.LatestRehireDate, "")
            txtEligDate.Text = IIf(ec.OriginalEligibilityDate <> "", ec.OriginalEligibilityDate, "")
            txtReHireElig.Text = IIf(ec.LatestEligibilityDate <> "", ec.LatestEligibilityDate, "")
            txtBenefitClassEffDate.Text = IIf(ec.BenefitClassEffDate <> "", ec.BenefitClassEffDate, "")
            ddlPaytype.SelectedValue = IIf(ec.PayType <> "", ec.PayType, "")
            ddlPayFrequency.SelectedValue = IIf(ec.PayFrequency <> "", ec.PayFrequency, "")
            ddlDeductionFrequency.SelectedValue = IIf(ec.DeductionFrequency <> "", ec.DeductionFrequency, "")
            ddlStatus.SelectedValue = IIf(ec.Status <> "", ec.Status, "")
            txtSalary.Text = ec.SalaryAmount
            txtBenefitSalary.Text = ec.BenefitSalary
            txtStandardHours.Text = ec.StandardHours
            txtOther.Text = ec.Other
            If ec.BirthDate <> "" Then
                TxtDOBFormatted.Text = DateTime.Parse(ec.BirthDate).ToString("yyyy-MM-dd")
            Else
                TxtDOBFormatted.Text = ""
            End If
            If ec.OriginalHireDate <> "" Then
                TxtHireDateFormatted.Text = DateTime.Parse(ec.OriginalHireDate).ToString("yyyy-MM-dd")
            Else
                TxtHireDateFormatted.Text = ""
            End If
            If ec.LatestRehireDate <> "" Then
                TxtReHireDateFormatted.Text = DateTime.Parse(ec.LatestRehireDate).ToString("yyyy-MM-dd")
            Else
                TxtReHireDateFormatted.Text = ""
            End If
            If ec.OriginalEligibilityDate <> "" Then
                TxtEligDateFormatted.Text = DateTime.Parse(ec.OriginalEligibilityDate).ToString("yyyy-MM-dd")
            Else
                TxtEligDateFormatted.Text = ""
            End If
            If ec.LatestEligibilityDate <> "" Then
                TxtRehireEligDateFormatted.Text = DateTime.Parse(ec.LatestEligibilityDate).ToString("yyyy-MM-dd")
            Else
                TxtRehireEligDateFormatted.Text = ""
            End If
            If ec.BenefitClassEffDate <> "" Then
                TxtBenefitClassEffDateFormatted.Text = DateTime.Parse(ec.BenefitClassEffDate).ToString("yyyy-MM-dd")
            Else
                TxtBenefitClassEffDateFormatted.Text = ""
            End If
            If ec.TerminationDate <> "" Then
                TxtTermDateFormatted.Text = DateTime.Parse(ec.TerminationDate).ToString("yyyy-MM-dd")
            Else
                TxtTermDateFormatted.Text = ""
            End If


            'To catch non existant Benefit Classes
            If ddlBenefitClass.Items.FindByValue(ec.ClassId) Is Nothing Then
                ddlBenefitClass.SelectedValue = 0
            Else
                ddlBenefitClass.SelectedValue = ec.ClassId
            End If

            ddlDivision.SelectedValue = ec.DivisionId
            ddlDepartment.SelectedValue = ec.DepartmentId
            ddlCategory.SelectedValue = ec.CategoryId
            ddlPayPer.SelectedValue = ec.SalaryTypeId

            txtManager.Text = ec.Manager
            txtOccupation.Text = ec.Occupation

            txtTerminationDate.Text = ec.TerminationDate
            ddlTerminationReason.SelectedValue = IIf(ec.TerminationDate <> "", ec.TerminationReason, 0)
            ddlCobraLength.SelectedValue = IIf(ec.TerminationDate <> "", ec.CobraLength, 0)

            chkTest.Checked = ec.TestPerson
            chkOwner.Checked = ec.Owner
            chkOnboarding.Checked = ec.InOnboarding

        End If

    End Sub

    Protected Sub btnEditContact_Click(sender As Object, e As EventArgs) Handles btnEditContact.Click
        divContactReview.Visible = False
        divContactEdit.Visible = True
        divDemographicReview.Visible = False
        divDemographicEdit.Visible = False
        divAdminReview.Visible = False
        divAdminEdit.Visible = False
        imgNext.Visible = False
    End Sub

    Protected Sub btnEditDemo_Click(sender As Object, e As EventArgs) Handles btnEditDemo.Click
        divContactReview.Visible = False
        divContactEdit.Visible = False
        divDemographicReview.Visible = False
        divDemographicEdit.Visible = True
        divAdminReview.Visible = False
        divAdminEdit.Visible = False
        imgNext.Visible = False

        'Go Get Employee Info
        booGotEmployee = ec.GetEmployeeInfo(intCompanyId, intEmployeeId)
        If booGotEmployee = True Then

            If Session("Admin") = True Or ec.SSN = "" Or Session("bOnboarding") = 1 Then
                txtSSN.Enabled = True
            Else
                txtSSN.Enabled = False
            End If

            If Session("Admin") = True Or ec.BirthDate = "" Or Session("bOnboarding") = 1 Then
                txtDoB.Enabled = True
            Else
                txtDoB.Enabled = False
            End If

            If Session("Admin") = True Then
                txtEENumber.Enabled = True
            Else
                txtEENumber.Enabled = False
            End If
        End If

    End Sub

    Protected Sub btnAdminEdit_Click(sender As Object, e As EventArgs) Handles btnAdminEdit.Click
        'Show Review Panels
        divContactReview.Visible = False
        divContactEdit.Visible = False
        divDemographicReview.Visible = False
        divDemographicEdit.Visible = False
        divAdminReview.Visible = False
        divAdminEdit.Visible = True
        imgNext.Visible = False
    End Sub

    Protected Sub btnSaveContact_Click(sender As Object, e As EventArgs) Handles btnSaveContact.Click

        Dim strPrimaryPhone As String
        Dim strPrimaryEmail As String
        'Dim strHomePhone As String

        'strHomePhone = txtHomePhone1.Text + txtHomePhone2.Text + txtHomePhone3.Text

        If rbtnHomePhone.Checked Then
            strPrimaryPhone = "Home"
        ElseIf rbtnWorkPhone.Checked Then
            strPrimaryPhone = "Work"
        ElseIf rbtnCellPhone.Checked Then
            strPrimaryPhone = "Mobile"
        Else
            strPrimaryPhone = ""                'make this mandatory
        End If

        If rbtnEmail1.Checked Then
            strPrimaryEmail = "Email1"
        ElseIf rbtnEmail2.Checked Then
            strPrimaryEmail = "Email2"
        Else
            strPrimaryEmail = ""                'make this mandatory
        End If

        If txtCellPhone.Text.Length > 0 And txtCellPhone.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", "").Length <> 10 Then
            lblError.Text = "Please check that cell phone has 10 digits and contains numbers only"
            divError.Visible = True
            divSuccess.Visible = False
            ResetScrollPosition()
            Exit Sub
        ElseIf txtCellPhone.Text.Length > 0 Then
            txtCellPhone.Text = txtCellPhone.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", "")
            txtCellPhone.Text = txtCellPhone.Text.Substring(0, 3) + "-" + txtCellPhone.Text.Substring(3, 3) + "-" + txtCellPhone.Text.Substring(6, 4)
        End If

        If txtHomePhone.Text.Length > 0 And txtHomePhone.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", "").Length <> 10 Then
            lblError.Text = "Please check that cell phone has 10 digits and contains numbers only"
            divError.Visible = True
            divSuccess.Visible = False
            ResetScrollPosition()
            Exit Sub
        ElseIf txtHomePhone.Text.Length > 0 Then
            txtHomePhone.Text = txtHomePhone.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", "")
            txtHomePhone.Text = txtHomePhone.Text.Substring(0, 3) + "-" + txtHomePhone.Text.Substring(3, 3) + "-" + txtHomePhone.Text.Substring(6, 4)
        End If

        If txtWorkPhone.Text.Length > 0 And txtWorkPhone.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", "").Length <> 10 Then
            lblError.Text = "Please check that cell phone has 10 digits and contains numbers only"
            divError.Visible = True
            divSuccess.Visible = False
            ResetScrollPosition()
            Exit Sub
        ElseIf txtWorkPhone.Text.Length > 0 Then
            txtWorkPhone.Text = txtWorkPhone.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", "")
            txtWorkPhone.Text = txtWorkPhone.Text.Substring(0, 3) + "-" + txtWorkPhone.Text.Substring(3, 3) + "-" + txtWorkPhone.Text.Substring(6, 4)
        End If

        If txtAddress1.Text = "" Or txtCity.Text = "" Or ddlState.SelectedValue = "" Or txtZip.Text = "" Or (txtEmail1.Text = "" And txtEmail2.Text = "") Then
            If Session("Admin") = False Then
                lblError.Text = "Please complete Name, Address Line 1, City, State, Zip, and Email to complete this form"
                divError.Visible = True
                divSuccess.Visible = False
                ResetScrollPosition()
                Exit Sub

            End If
        End If

        If txtZip.Text.Length < 5 Or (txtZipExt.Text.Length > 0 And txtZipExt.Text.Length < 4) Then
            If Session("Admin") = False Then
                lblError.Text = "Please correct ZIP Code"
                divError.Visible = True
                divSuccess.Visible = False
                ResetScrollPosition()
                Exit Sub
            End If
        End If

        divError.Visible = False

        'Save New Contact Info 
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        objParam = New SqlParameter("@CompanyId", intCompanyId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EmployeeId", intEmployeeId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Prefix", ddlPrefix.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@FirstName", txtFirstName.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@MiddleName", txtMiddleName.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@LastName", txtLastName.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Suffix", ddlSuffix.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Address1", txtAddress1.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Address2", txtAddress2.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@City", txtCity.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@State", ddlState.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Country", ddlCountry.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Zip", txtZip.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@ZipExtension", txtZipExt.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@HomePhone", txtHomePhone.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", ""))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@WorkPhone", txtWorkPhone.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", ""))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@MobilePhone", txtCellPhone.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", ""))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@PrimaryPhone", strPrimaryPhone)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Email1", txtEmail1.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Email2", txtEmail2.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@PrimaryEmail", strPrimaryEmail)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@UserId", Session("UserId"))
        aryParams.Add(objParam)

        objDataSet = sqlCon.CreateDataSet("usp_Employee_Profile_Contact_Edit", aryParams)
        sqlCon.CloseConn()

        s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on contact section of " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

        divError.Visible = False
        ResetScrollPosition()

        'Update Screen
        'Go Get Employee Info
        booGotEmployee = ec.GetEmployeeInfo(intCompanyId, intEmployeeId)

        If booGotEmployee = True Then
            PopulateEmpFields()
        End If

        If Session("Admin") = True Then
            divContactReview.Visible = True
            divContactEdit.Visible = False
            divDemographicReview.Visible = True
            divDemographicEdit.Visible = False
            divAdminReview.Visible = True
            divAdminEdit.Visible = False
            imgNext.Visible = True
        ElseIf Session("bOnboarding") = 1 And (ec.SSN = "" Or ec.BirthDate = "" Or ec.MaritalStatus = "" Or ec.Status = "" Or ec.Gender = "") Then
            divContactReview.Visible = False
            divContactEdit.Visible = False
            divDemographicReview.Visible = False
            divDemographicEdit.Visible = True
            divAdminReview.Visible = False
            divAdminEdit.Visible = False
            imgNext.Visible = False
        Else
            divContactReview.Visible = True
            divContactEdit.Visible = False
            divDemographicReview.Visible = True
            divDemographicEdit.Visible = False
            divAdminReview.Visible = False
            divAdminEdit.Visible = False
            imgNext.Visible = True
        End If

    End Sub

    Protected Sub btnSaveDemo_Click(sender As Object, e As EventArgs) Handles btnSaveDemo.Click

        Dim strSSN As String
        strSSN = txtSSN.Text.Replace("-", "")

        If strSSN = "" And Session("Admin") = False Then
            lblError.Text = "SSN is missing"
            lblError.Visible = True
            divError.Visible = True
            divSuccess.Visible = False
            Exit Sub
        End If

        If strSSN <> "" And Employee.ValidateSSN(strSSN) = False Then
            lblError.Text = "The SSN you entered is not valid"
            lblError.Visible = True
            divError.Visible = True
            divSuccess.Visible = False
            Exit Sub
        Else
            strSSN = txtSSN.Text
        End If

        If txtDoB.Text = "" And Session("Admin") = False Then
            lblError.Text = "Invalid Birth Date"
            lblError.Visible = True
            divError.Visible = True
            divSuccess.Visible = False
            Exit Sub
        End If

        If txtDoB.Text <> "" Then
            If Len(txtDoB.Text) > 10 Then
                lblError.Text = "Invalid Birth Date."
                lblError.Visible = True
                divError.Visible = True
                divSuccess.Visible = False
                Exit Sub
            End If
            If Convert.ToDateTime(Me.txtDoB.Text) > DateTime.Now.Date.AddYears(-10) Then
                lblError.Text = "Invalid Birth Date"
                lblError.Visible = True
                divError.Visible = True
                divSuccess.Visible = False
                Exit Sub
            Else
                If Convert.ToDateTime(Me.txtDoB.Text) < DateTime.Now.Date.AddYears(-100) Then
                    lblError.Text = "Invalid Birth Date"
                    lblError.Visible = True
                    divError.Visible = True
                    divSuccess.Visible = False
                    Exit Sub
                End If
            End If
        End If

        imgProcessing.Visible = True

        'Save New Demo Info 
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        objParam = New SqlParameter("@CompanyId", intCompanyId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EmployeeId", intEmployeeId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EENumber", txtEENumber.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@SSN", strSSN)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DOB", txtDoB.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@GenderId", ddlGender.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@LanguageId", ddlLanguage.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@MaritalStatusId", ddlMaritalStatus.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EthnicGroupId", ddlEthnicity.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@MilitaryStatusId", ddlMilitaryStatus.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EducationLevelId", ddlEducationLevel.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@TobaccoUser", chkTobacco.Checked)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@UserId", Session("UserId"))
        aryParams.Add(objParam)

        objDataSet = sqlCon.CreateDataSet("usp_Employee_Profile_Demo_Edit", aryParams)
        sqlCon.CloseConn()

        'Update Screen
        'Go Get Employee Info
        booGotEmployee = ec.GetEmployeeInfo(intCompanyId, intEmployeeId)

        If booGotEmployee = True Then
            PopulateEmpFields()
        End If

        s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on Demo Section of " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

        divContactReview.Visible = True
        divContactEdit.Visible = False
        divDemographicReview.Visible = True
        divDemographicEdit.Visible = False
        'divAdminReview.Visible = False
        divAdminEdit.Visible = False
        imgNext.Visible = True
        If Session("Admin") = True Then
            divAdminReview.Visible = True
        End If

        imgProcessing.Visible = False

    End Sub

    Protected Sub btnAdminSave_Click(sender As Object, e As EventArgs) Handles btnAdminSave.Click
        If txtHireDate.Text <> "" Then
            If Len(txtHireDate.Text) > 10 Or Convert.ToDateTime(Me.txtHireDate.Text) > DateTime.Now.Date.AddYears(1) Or Convert.ToDateTime(Me.txtHireDate.Text) < DateTime.Now.Date.AddYears(-50) Then
                lblError.Text = "Invalid Hire Date"
                lblError.Visible = True
                divError.Visible = True
                divSuccess.Visible = False
                Exit Sub
            End If
        End If

        If txtRehire.Text <> "" Then
            If Len(txtRehire.Text) > 10 Or Convert.ToDateTime(Me.txtRehire.Text) > DateTime.Now.Date.AddYears(1) Or Convert.ToDateTime(Me.txtRehire.Text) < DateTime.Now.Date.AddYears(-50) Then
                lblError.Text = "Invalid Rehire Date"
                lblError.Visible = True
                divError.Visible = True
                divSuccess.Visible = False
                Exit Sub
            End If
        End If

        If txtEligDate.Text <> "" Then
            If Len(txtEligDate.Text) > 10 Or Convert.ToDateTime(Me.txtEligDate.Text) > DateTime.Now.Date.AddYears(1) Or Convert.ToDateTime(Me.txtEligDate.Text) < DateTime.Now.Date.AddYears(-50) Then
                lblError.Text = "Invalid Eligibility Date"
                lblError.Visible = True
                divError.Visible = True
                divSuccess.Visible = False
                Exit Sub
            End If
        End If

        If txtReHireElig.Text <> "" Then
            If Len(txtReHireElig.Text) > 10 Or Convert.ToDateTime(Me.txtReHireElig.Text) > DateTime.Now.Date.AddYears(1) Or Convert.ToDateTime(Me.txtReHireElig.Text) < DateTime.Now.Date.AddYears(-50) Then
                lblError.Text = "Invalid Latest Eligibility Date"
                lblError.Visible = True
                divError.Visible = True
                divSuccess.Visible = False
                Exit Sub
            End If
        End If

        If txtBenefitClassEffDate.Text <> "" Then
            If Len(txtBenefitClassEffDate.Text) > 10 Or Convert.ToDateTime(Me.txtBenefitClassEffDate.Text) > DateTime.Now.Date.AddYears(1) Or Convert.ToDateTime(Me.txtBenefitClassEffDate.Text) < DateTime.Now.Date.AddYears(-50) Then
                lblError.Text = "Invalid Benefit Class Date"
                lblError.Visible = True
                divError.Visible = True
                divSuccess.Visible = False
                Exit Sub
            End If
        End If

        If txtTerminationDate.Text <> "" Then
            If Len(txtTerminationDate.Text) > 10 Or Convert.ToDateTime(Me.txtTerminationDate.Text) > DateTime.Now.Date.AddYears(1) Or Convert.ToDateTime(Me.txtTerminationDate.Text) < DateTime.Now.Date.AddYears(-50) Then
                lblError.Text = "Invalid Benefit Class Date"
                lblError.Visible = True
                divError.Visible = True
                divSuccess.Visible = False
                Exit Sub
            End If
        End If

        If txtTerminationDate.Text.Trim <> "" And ddlTerminationReason.SelectedItem.Text = "" Then
            lblError.Text = "The Termination Reason chosen is not valid."
            divError.Visible = True
            divSuccess.Visible = False
        End If

        If ddlBenefitClass.SelectedValue = "0" Then
            lblError.Text = "The Benefit Class selected is not valid"
            divError.Visible = True
            divSuccess.Visible = False
        End If

        If chkOnboarding.Checked = True Then
            Session("RegistrationKey") = ec.GetUniqueKey 'System.Web.Security.Membership.GeneratePassword(12, 1)
        End If

        'Save New Admin Demo Info 
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        objParam = New SqlParameter("@CompanyId", intCompanyId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EmployeeId", intEmployeeId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@HireDate", txtHireDate.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@RehireDate", txtRehire.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@OrigEligDate", txtEligDate.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EligDate", txtReHireElig.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@BenefitClassDate", txtBenefitClassEffDate.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@PaytypeId", ddlPaytype.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@PayFrequencyId", ddlPayFrequency.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DeductionFrequencyId", ddlDeductionFrequency.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@StatusId", ddlStatus.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Salary", txtSalary.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@PayPer", ddlPayPer.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@BenefitSalary", txtBenefitSalary.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Class", ddlBenefitClass.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Manager", txtManager.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Occupation", txtOccupation.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Department", ddlDepartment.SelectedValue)
        aryParams.Add(objParam)

        If Not ddlCategory.SelectedIndex = -1 Then
            If Not ddlCategory.SelectedValue = "0" Then
                objParam = New SqlParameter("@Category", ddlCategory.SelectedValue)
                aryParams.Add(objParam)
            End If
        End If

        objParam = New SqlParameter("@Division", ddlDivision.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@StandardHours", txtStandardHours.Text)
        aryParams.Add(objParam)
        If txtTerminationDate.Text.Trim <> "" Then
            objParam = New SqlParameter("@TerminationDate", txtTerminationDate.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@TerminationReason", ddlTerminationReason.SelectedValue)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@CobraLength", ddlCobraLength.SelectedValue)
            aryParams.Add(objParam)
        End If

        objParam = New SqlParameter("@Other", txtOther.Text)
        aryParams.Add(objParam)


        objParam = New SqlParameter("@TestPerson", chkTest.Checked)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Owner", chkOwner.Checked)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@InOnboarding", chkOnboarding.Checked)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@UserId", Session("UserId"))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@RegistrationKey", Session("RegistrationKey"))
        aryParams.Add(objParam)

        objDataSet = sqlCon.CreateDataSet("usp_Employee_Profile_AdminDemo_Edit", aryParams)

        sqlCon.CloseConn()

        'Update Screen
        'Go Get Employee Info
        booGotEmployee = ec.GetEmployeeInfo(intCompanyId, intEmployeeId)
        If booGotEmployee = True Then
            PopulateEmpFields()
        End If

        s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on Admin Section of " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

        If sc.GetNavigation(Session("UserId"), intEmployeeId, strScreenName, 0) = True Then
            Session("TabString") = sc.TabString

            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")

        End If

        divError.Visible = False
        divSuccess.Visible = True
        divContactReview.Visible = True
        divContactEdit.Visible = False
        divDemographicReview.Visible = True
        divDemographicEdit.Visible = False
        divAdminReview.Visible = True
        divAdminEdit.Visible = False
        imgNext.Visible = True
        ResetScrollPosition()

    End Sub

    Protected Sub btnCancel_Click()
        divError.Visible = False
        'Update Screen
        'Go Get Employee Info
        booGotEmployee = ec.GetEmployeeInfo(intCompanyId, intEmployeeId)
        If booGotEmployee = True Then
            PopulateEmpFields()
        End If

        divContactReview.Visible = True
        divContactEdit.Visible = False
        divDemographicReview.Visible = True
        divDemographicEdit.Visible = False
        divAdminEdit.Visible = False
        imgNext.Visible = True
        If Session("Admin") = True Then
            divAdminReview.Visible = True
        End If
    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs) Handles imgNext.Click
        '''''''''''''''''''''''''''''''''''''''''''''''
        'Check for missing Demographic Required data
        '''''''''''''''''''''''''''''''''''''''''''''''
        Dim ds As New DataSet
        Dim dt As New DataTable
        Dim strError As String
        Dim i As Integer
        Dim bMissing As Boolean
        i = 1
        bMissing = p.CheckForRequiredFields(intEmployeeId, Session("UserId"), ds)
        If bMissing = False Then
            strError = "Some required information Is Not complete.  Please provide the following:  "
            dt = ds.Tables(0)
            For Each row As DataRow In dt.Rows
                If i = 1 Then
                    strError = strError + row.Item("MIA")
                Else
                    strError = strError + ", " + row.Item("MIA")
                End If
                i = i + 1
            Next
            divError.Visible = True
            lblError.Text = strError
        Else
            'Find Next Screen in Navigation
            If divError.Visible = True Then
                Exit Sub
            Else
                imgNext.Visible = False

                ResetScrollPosition()
                Response.AddHeader("REFRESH", "0;URL=" + Session("NextScreen"))
            End If

        End If

    End Sub

#Region "Employee Notes Module"
    Protected Sub a_grdEmployee_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdEmployeeNotes.RowDataBound
        If e.Row.RowType = System.Web.UI.WebControls.DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#EFF3FB'")  'old color   8bcced
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=''")
            e.Row.Attributes.Add("style", "cursor:pointer;")
            'e.Row.Attributes("onclick") = Page.ClientScript.GetPostBackClientHyperlink(grdEmployeeNotes, "Select$" & e.Row.RowIndex)
            e.Row.ToolTip = "Click to edit this Note."
        End If
    End Sub

    Protected Sub mbtnSave_Click(sender As Object, e As ImageClickEventArgs) Handles mbtnSave.Click
        ec.UpdateEmployeeNotes(mlblHiddenNoteId.Text, Session("ShadowEmployeeId"), mtxtNewComment.Text, Session("UserId"), True)
        ec.FillEmployeeNotes(Session("ShadowEmployeeId"), grdEmployeeNotes)
        mtxtNewComment.Text = ""
        mtxtNewComment.Visible = False
        mlblAddNew.Visible = False
        mbtnSave.Visible = False
        mbtnAdd.Visible = True
    End Sub

    Protected Sub mbtnAdd_Click(sender As Object, e As ImageClickEventArgs) Handles mbtnAdd.Click
        mtxtNewComment.Text = ""
        mlblHiddenNoteId.Text = 0
        mtxtNewComment.Visible = True
        mlblAddNew.Visible = True
        mbtnSave.Visible = True
        mbtnAdd.Visible = False
    End Sub

    Protected Sub ButtonEdit_Click(sender As Object, e As EventArgs)
        Dim btnEdit As Button = sender
        Dim gr As GridViewRow = btnEdit.Parent.Parent
        Dim grd As GridView = btnEdit.Parent.Parent.Parent.Parent
        Dim EmployeeNoteId As Object = grdEmployeeNotes.DataKeys(gr.RowIndex).Values("EmployeeNoteId")

        Dim strCurrentNote As String
        strCurrentNote = grd.Rows(gr.RowIndex).Cells(2).Text
        'Dim row As GridViewRow = grdEmployeeNotes.SelectedRow
        'Dim i As Integer
        'i = grdEmployeeNotes.SelectedIndex
        'Dim lblNote As Label = DirectCast(grdEmployeeNotes.Rows(i).FindControl("lblNote"), Label)
        'Session("EmployeeNoteId") = grdEmployeeNotes.DataKeys(i).Values("EmployeeNoteId")
        mlblHiddenNoteId.Text = EmployeeNoteId
        mtxtNewComment.Text = strCurrentNote
        mlblAddNew.Visible = True
        mtxtNewComment.Visible = True
        mbtnAdd.Visible = False
        mbtnSave.Visible = True
    End Sub

#End Region

    Protected Sub btnSavePic_Click(sender As Object, e As ImageClickEventArgs)
        If fuLoadPic.HasFile Then
            Try
                'Get Filename
                Dim NewFileName As String = Server.HtmlEncode(fuLoadPic.FileName)
                'Get Extension
                Dim Extension As String = System.IO.Path.GetExtension(NewFileName)
                'Build File path **CHANGING TO COMPANY ID
                'Dim CompanyNumberPos As Integer = ddlCompany.SelectedItem.Text.IndexOf("-") - 1
                'Dim CompanyNumber As String = ddlCompany.SelectedItem.Text.Substring(0, CompanyNumberPos)
                Dim strEmployeeId As String = intEmployeeId.ToString

                'Trying to get full path
                Dim Rootpath As String = Server.MapPath(".\\")

                '  Dim FilePath As String = Rootpath & "Documents\" & strCompanyId & "\"
                Dim FilePath As String = Rootpath & "img\EmployeeProfile\"

                'Only allow files with .doc,docx, xls, xlsx, pdf, txt, png, jpg extensions
                If LCase(Extension) = ".gif" Or LCase(Extension) = ".png" Or LCase(Extension) = ".jpg" Or LCase(Extension) = ".jpeg" Then
                    NewFileName = strEmployeeId & Extension

                    'Double check that file directory exists 
                    If (Not System.IO.Directory.Exists(FilePath)) Then
                        System.IO.Directory.CreateDirectory(FilePath)
                    End If

                    'THEN save the file
                    fuLoadPic.SaveAs(FilePath & NewFileName)   ' & "." & Extension)

                    lblFileUpload.Text = "File name: " &
                        fuLoadPic.PostedFile.FileName & "<br>" &
                        "File Size: " &
                        fuLoadPic.PostedFile.ContentLength & "<br>" &
                        "Content type: " &
                        fuLoadPic.PostedFile.ContentType & "<br>" &
                        "Location Saved: C:\Temp\" &
                        fuLoadPic.FileName

                    'Save procedure here
                    Dim objParam As SqlParameter
                    Dim objDataSet As New DataSet
                    Dim aryParams As New ArrayList()
                    Dim sqlCon As New SQLControl
                    sqlCon.OpenConn()
                    Try
                        objParam = New SqlParameter("@EmployeeId", intEmployeeId)
                        aryParams.Add(objParam)
                        objParam = New SqlParameter("@ProfilePic", NewFileName)
                        aryParams.Add(objParam)
                        sqlCon.ExecuteNonQuery("[usp_Employee_ProfilePicture_Edit]", aryParams)
                        sqlCon.CloseConn()

                        aryParams = Nothing
                        sqlCon = Nothing

                    Catch ex As Exception
                        Throw New Exception(ex.Message)
                    End Try

                    'Update Screen
                    'Go Get Employee Info
                    booGotEmployee = ec.GetEmployeeInfo(intCompanyId, intEmployeeId)
                    If booGotEmployee = True Then
                        PopulateEmpFields()
                    End If
                    divUpdatePic.Visible = False
                    imgEmployee.Visible = True
                Else
                    lblFileUpload.Text = "Error:  The file must be a valid format (.jpg, .gif, .png, .jpeg)"
                    lblFileUpload.Visible = True
                End If
            Catch ex As Exception
                lblFileUpload.Text = "ERROR: " & ex.Message.ToString()
                lblFileUpload.Visible = True
            End Try
        Else
            lblFileUpload.Text = "You have not specified a file."
            lblFileUpload.Visible = True
        End If

    End Sub

    Protected Sub imgEmployee_Click(sender As Object, e As ImageClickEventArgs)
        divEEImage.Visible = False
        imgEmployee.Visible = False
        divError.Visible = False
        divSuccess.Visible = False
    End Sub

    Protected Sub lnkUpdatePic_Click(sender As Object, e As EventArgs)
        divUpdatePic.Visible = True
        divEEImage.Visible = False
    End Sub

    Protected Sub btnCancelPic_Click(sender As Object, e As ImageClickEventArgs)
        divUpdatePic.Visible = False
        divEEImage.Visible = True
    End Sub

    Protected Sub mbtnResetSave_Click(sender As Object, e As ImageClickEventArgs) Handles mbtnResetSave.Click

        'Save procedure here
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()
        Try
            objParam = New SqlParameter("@EmployeeId", intEmployeeId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@UserId", Session("UserId"))
            aryParams.Add(objParam)

            sqlCon.ExecuteNonQuery("[usp_Employee_Security_Reset]", aryParams)
            sqlCon.CloseConn()

            aryParams = Nothing
            sqlCon = Nothing

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        divContactReview.Visible = True
        divContactEdit.Visible = False
        divDemographicReview.Visible = True
        divDemographicEdit.Visible = False
        If Session("Admin") = True Then
            divAdminReview.Visible = True
        End If
        divAdminEdit.Visible = False
        imgNext.Visible = True
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
End Class
