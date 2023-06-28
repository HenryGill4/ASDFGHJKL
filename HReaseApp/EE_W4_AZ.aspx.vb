Imports System.Data.SqlClient

Public Class EE_W4_AZ
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer

    Dim strScreenName As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EEW4AZ"

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
                Session("ScreenConfigTitle") = sc.ScreenConfigTitle
                Session("ScreenConfigText") = sc.ScreenConfigText

            End If

            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), Session("ScreenPath"))
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            sc.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            'lblMainArticleTitle.Text = sc.MainArticleTitle
            'lblMainArticleText.Text = IIf(sc.MainArticleText = "", "Please complete form", sc.MainArticleText)

            PopulateFields()

        End If

        If Session("DataComplete") = "Yes" Then
            divError.Visible = False
            divSuccess.Visible = True
        Else
            divSuccess.Visible = False
        End If

        btnSave.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSave, "") + ";this.src='/img/processing.gif';")
        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateFields()
        'Go Get AL Employee W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then

            Session("EmployeeW4Id") = ec.EmployeeW4Id

            lblFullName.Text = ec.EmployeeFullName
            lblSSNumber.Text = ec.SSNwithDashes
            lblAddressCombined.Text = ec.AddressCombined
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZipCode.Text = ec.Zip
            lblTaxYear.Text = Date.Now.Year

            txtAdditionalWithholding.Text = ec.AdditionalWithholding
            chkExempt.Checked = IIf(ec.Exempt = "1", True, False)

            chkPercent.Checked = IIf(ec.W4_Box1 = "1", True, False)
            chkToWithholdFlatAmt.Checked = IIf(ec.W4_Box2 = "1", True, False)

            rbTWPercentage1.Checked = IIf(ec.ID_Box1 <> "", True, False)
            rbTWPercentage2.Checked = IIf(ec.ID_Box2 <> "", True, False)
            rbTWPercentage3.Checked = IIf(ec.ID_Box3 <> "", True, False)
            rbTWPercentage4.Checked = IIf(ec.ID_Box4 <> "", True, False)
            rbTWPercentage5.Checked = IIf(ec.ID_Box5 <> "", True, False)
            rbTWPercentage6.Checked = IIf(ec.ID_Box6 <> "", True, False)
            rbTWPercentage7.Checked = IIf(ec.ID_Box7 <> "", True, False)

            txtSignature.Text = ec.W4_Signature
            txtSignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now, ec.W4_SignatureDate)

        End If

    End Sub

    Private Sub Save()
        'Check for required fields
        If rbTWPercentage1.Checked = False And rbTWPercentage2.Checked = False And rbTWPercentage3.Checked = False And rbTWPercentage4.Checked = False And rbTWPercentage5.Checked = False And rbTWPercentage6.Checked = False And rbTWPercentage7.Checked = False And chkExempt.Checked = False Then
            divError.Visible = True
            divSuccess.Visible = False
            rbTWPercentage1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            rbTWPercentage2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            rbTWPercentage3.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            rbTWPercentage4.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            rbTWPercentage5.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            rbTWPercentage6.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            rbTWPercentage7.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkExempt.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please Chose from either box 1 or box 2 below (check only one)"
            ResetScrollPosition()
            Exit Sub
        End If

        If Trim(txtSignature.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "This form is not valid unless signed"
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ResetScrollPosition()
            Exit Sub
        End If

        If (rbTWPercentage1.Checked = True Or rbTWPercentage2.Checked = True Or rbTWPercentage3.Checked = True Or rbTWPercentage4.Checked = True Or rbTWPercentage5.Checked = True Or rbTWPercentage6.Checked = True Or rbTWPercentage7.Checked = True) And Trim(txtSignature.Text) <> "" Then
            chkPercent.Checked = True
            chkExempt.Checked = False
            rbTWPercentage1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            rbTWPercentage2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            rbTWPercentage3.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            rbTWPercentage4.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            rbTWPercentage5.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            rbTWPercentage6.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            rbTWPercentage7.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            chkExempt.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            divError.Visible = False
        ElseIf chkExempt.Checked = True And Trim(txtSignature.Text) <> "" Then
            chkPercent.Checked = False
            chkExempt.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            divError.Visible = False
        End If

        If divError.Visible = False Then

            imgProcessing.Visible = True
            btnSave.Visible = False

            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()
            objParam = New SqlParameter("@EmployeeW4Id", Session("EmployeeW4Id"))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EmployeeId", intEmployeeId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@TaxYear", Now.Year())
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ScreenName", Session("ScreenName"))
            aryParams.Add(objParam)

            objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@Exempt", IIf(chkExempt.Checked = True, 1, 0))
            aryParams.Add(objParam)

            objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@W4_Box1", IIf(chkPercent.Checked = True, "1", "0"))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_Box2", IIf(chkToWithholdFlatAmt.Checked = True, "1", "0"))
            aryParams.Add(objParam)

            objParam = New SqlParameter("@ID_Box1", If(rbTWPercentage1.Checked = True, ".5", ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ID_Box2", If(rbTWPercentage2.Checked = True, "1.0", ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ID_Box3", If(rbTWPercentage3.Checked = True, "1.5", ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ID_Box4", If(rbTWPercentage4.Checked = True, "2.0", ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ID_Box5", If(rbTWPercentage5.Checked = True, "2.5", ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ID_Box6", If(rbTWPercentage6.Checked = True, "3.0", ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ID_Box7", If(rbTWPercentage7.Checked = True, "3.5", ""))
            aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit", aryParams)
            sqlCon.CloseConn()

            s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

            divError.Visible = False
            lblError.Text = ""
            divSuccess.Visible = True

        End If

        PopulateFields()
        ResetScrollPosition()

        imgProcessing.Visible = False
        btnSave.Visible = True

    End Sub

    Protected Sub chkPercent_CheckedChanged(sender As Object, e As EventArgs) Handles chkPercent.CheckedChanged
        If chkPercent.Checked = True Then
            chkExempt.Checked = False
        End If

    End Sub

    Protected Sub chkToWithholdFlatAmt_CheckedChanged(sender As Object, e As EventArgs)
        If chkToWithholdFlatAmt.Checked = True Then
            chkExempt.Checked = False
        End If
    End Sub

    Protected Sub chkExempt_CheckedChanged(sender As Object, e As EventArgs)
        If chkExempt.Checked = True Then
            chkPercent.Checked = False
            chkToWithholdFlatAmt.Checked = False
            rbTWPercentage1.Checked = False
            rbTWPercentage2.Checked = False
            rbTWPercentage3.Checked = False
            rbTWPercentage4.Checked = False
            rbTWPercentage5.Checked = False
            rbTWPercentage6.Checked = False
            rbTWPercentage7.Checked = False
        End If
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As ImageClickEventArgs)
        Save()

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Save()

        Response.Redirect(Session("NextScreen"))

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