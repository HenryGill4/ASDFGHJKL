Imports System.Data.SqlClient

Public Class EE_Compliance_NY2
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee
    Dim c As New Company

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer

    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EEComplianceNY2"
        strScreenShortDesc = "NY Notice for Exempt Employees"

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

            If sc.GetNavigation(Session("UserId"), intEmployeeId, strScreenName, 0) = True Then
                Session("ScreenName") = sc.ScreenName
                Session("ScreenShortDesc") = sc.ScreenShortDesc
                Session("ScreenPath") = sc.ScreenPath
                Session("DataComplete") = sc.DataComplete
                Session("NextScreen") = sc.NextScreen
                Session("TabString") = sc.TabString
                Session("scTitle") = sc.ScreenConfigTitle
                Session("scText") = sc.ScreenConfigText

            End If

            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), Session("ScreenPath"))
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            sc.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            lblMainArticleTitle.Text = sc.MainArticleTitle
            lblMainArticleText.Text = sc.MainArticleText
            imgNext.Visible = False

            If lblMainArticleText.Text = "" Then
                divText.Visible = False
            End If

            PopulateFields()

            divError.Visible = False

        End If

        If Session("DataComplete") = "Yes" Then
            If Trim(txtSignature.Text) <> "" Then
                divSuccess.Visible = True
                imgNext.Visible = True
            ElseIf Session("Admin") = True Then
                divSuccess.Visible = False
                imgNext.Visible = True
            Else
                divSuccess.Visible = False
                imgNext.Visible = False
            End If
        Else
            divSuccess.Visible = False
            imgNext.Visible = False

        End If

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateFields()
        'Go Get Employee Compliance New York 1
        If c.GetCompanyInfo(intCompanyId, Session("UserId")) = True Then
            lblCompanyName.Text = c.LongDesc
            lblDBA.Text = ""
            lblFEIN.Text = c.FEIN
            lblCompanyAddress1.Text = c.Address1 + IIf(Len(c.Address2) > 0, ", " + c.Address2, "")
            lblCompanyCityStateZip.Text = c.City + ", " + c.State + " " + c.Zip
            lblMailingAdd.Text = ""
            lblPhoneNumber.Text = c.ContactPhone
        End If
        If ec.GetEmployeeInfo(intCompanyId, intEmployeeId) = True Then
            lblEmployeePayRate.Text = ec.BenefitSalary
            lblEEName.Text = ec.FirstName + " " + ec.LastName
            chkWeekly.Checked = IIf(ec.PayFrequency = 1, True, False)
            chkBiweekly.Checked = IIf(ec.PayFrequency = 2, True, False)
            chkOther2.Checked = IIf(ec.PayFrequency <> 1 And ec.PayFrequency <> 2, True, False)

        End If
        If ec.GetEmployeeFormResponses(intCompanyId, intEmployeeId, Session("ScreenName")) = True Then
            txtSignature.Text = ec.FormSignature
            txtSignatureDate.Text = IIf(ec.SignatureDate = "1/1/1900", Date.Now(), ec.SignatureDate)
            chkNone.Checked = IIf(ec.Box1 = "1", True, False)
            chkTips.Checked = IIf(ec.Box2 = "1", True, False)
            chkMeals.Checked = IIf(ec.Box3 = "1", True, False)
            chkLodging.Checked = IIf(ec.Box4 = "1", True, False)
            chkOther.Checked = IIf(ec.Box5 = "1", True, False)
            chkEnglish.Checked = IIf(ec.Box6 = "1", True, False)
            chkNotEnglish.Checked = IIf(ec.Box7 = "1", True, False)
            txtLanguage.Text = ec.Box8
            txtPreparer.Text = ec.Box9
            txtTipsPerHour.Text = ec.Box10
            txtMealsPerMeal.Text = ec.Box11
            txtLodging.Text = ec.Box12
            txtOther.Text = ec.Box13
            txtOvertime.Text = ec.Box14
            txtPayday.Text = ec.Box15
        End If

        chkProvidedAtHire.Checked = True
        chkProvidedAtChange.Checked = False

    End Sub

    Private Sub Save()
        'Check for required fields
        If chkNone.Checked = False And chkTips.Checked = False And chkMeals.Checked = False And chkLodging.Checked = False And chkOther.Checked = False Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "You must check one of the boxes under 4. Allowances taken"
            chkNone.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkTips.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMeals.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkLodging.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkOther.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If

        If txtPayday.Text = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "You must enter a day on Line 5. Regular payday"
            txtPayday.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If

        If Session("Admin") = "False" Then
            If chkEnglish.Checked = False And chkNotEnglish.Checked = False Then
                divError.Visible = True
                divSuccess.Visible = False
                lblError.Text = "You must check one of the boxes under 8. Employee Acknowledgement"
                chkEnglish.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                chkNotEnglish.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                imgNext.Visible = False
                ResetScrollPosition()
                Exit Sub
            End If

            If Trim(txtSignature.Text) = "" Then
                divError.Visible = True
                divSuccess.Visible = False
                lblError.Text = "Please enter employee name for Signature"
                txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                imgNext.Visible = False
                ResetScrollPosition()
                Exit Sub
            End If
        End If

        imgProcessing.Visible = True

        chkNone.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
        chkTips.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
        chkMeals.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
        chkLodging.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
        chkOther.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
        txtPayday.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
        chkEnglish.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
        chkNotEnglish.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
        txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        objParam = New SqlParameter("@CompanyId", intCompanyId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EmployeeId", intEmployeeId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@ScreenName", Session("ScreenName"))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@FormSignature", txtSignature.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@SignatureDate", txtSignatureDate.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Box1", IIf(chkNone.Checked = True, "1", ""))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Box2", IIf(chkTips.Checked = True, "1", ""))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Box3", IIf(chkMeals.Checked = True, "1", ""))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Box4", IIf(chkLodging.Checked = True, "1", ""))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Box5", IIf(chkOther.Checked = True, "1", ""))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Box6", IIf(chkEnglish.Checked = True, "1", "0"))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Box7", IIf(chkNotEnglish.Checked = True, "1", "0"))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Box8", txtLanguage.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Box9", txtPreparer.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Box10", txtTipsPerHour.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Box11", txtMealsPerMeal.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Box12", txtLodging.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Box13", txtOther.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Box14", txtOvertime.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Box15", txtPayday.Text)
        aryParams.Add(objParam)

        objDataSet = sqlCon.CreateDataSet("usp_Employee_Form_Response_Edit", aryParams)
        sqlCon.CloseConn()

        divError.Visible = False
        If Trim(txtSignature.Text) <> "" Then
            divSuccess.Visible = True
        End If
        imgNext.Visible = True

        s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

        PopulateFields()
        ResetScrollPosition()

        imgProcessing.Visible = False


    End Sub

    Protected Sub chkEnglish_CheckedChanged(sender As Object, e As EventArgs)
        If chkEnglish.Checked = True Then
            chkNotEnglish.Checked = False
        End If
    End Sub

    Protected Sub chkNotEnglish_CheckedChanged(sender As Object, e As EventArgs)
        If chkNotEnglish.Checked = True Then
            chkEnglish.Checked = False
        End If
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As ImageClickEventArgs)
        Save()

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Save()

        'Find Next Screen in Navigation
        If divError.Visible = True Then
            Exit Sub
        Else
            imgNext.Visible = False
            
            ResetScrollPosition()
            Response.AddHeader("REFRESH", "0;URL=" + Session("NextScreen"))
        End If
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

