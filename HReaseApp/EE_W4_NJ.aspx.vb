Imports System.Data.SqlClient

Public Class EE_W4_NJ
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee

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
        strScreenName = "EEW4NJ"
        strScreenShortDesc = "NJ W-4 Form"

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

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateFields()
        'Go Get Employee W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year, Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id
            lblSSNwithDashes.Text = ec.SSNwithDashes
            lblEmployeeFullName.Text = ec.EmployeeFullName
            lblHomeAddress.Text = ec.AddressCombined
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZip.Text = ec.Zip

            chkSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            chkMarriedJoint.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)
            chkMarriedSeparate.Checked = IIf(ec.TaxFilingStatusId = "3", True, False)
            chkHeadHousehold.Checked = IIf(ec.TaxFilingStatusId = "4", True, False)
            chkWidow.Checked = IIf(ec.TaxFilingStatusId = "5", True, False)

            txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding
            txtExempt.Text = IIf(ec.Exempt = "1", "EXEMPT", "")

            txt1.Text = ec.W4_Box1

            txtSignature.Text = ec.W4_Signature
            txtSignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now, ec.W4_SignatureDate)

            lblCompanyName.Text = ec.CompanyName
            lblCompanyFEIN.Text = ec.CompanyFEIN
            lblCompanyAddress.Text = ec.CompanyAddress1 + " " + IIf(Len(ec.CompanyAddress2) > 0, ec.CompanyAddress2, "")
            lblCompanyCityStateZip.Text = ec.CompanyCity + ", " + ec.CompanyState + " " + ec.CompanyZip

        End If

    End Sub

    Private Sub Save()
        If txtExempt.Text <> "" And txtExempt.Text <> "EXEMPT" Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "Only the word EXEMPT may be entered into Box 6."
            txtExempt.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ResetScrollPosition()
            Exit Sub
        Else
            txtExempt.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
        End If

        If txtExempt.Text = "" Then
            'Check for required fields
            If chkSingle.Checked = False And chkMarriedJoint.Checked = False And chkMarriedSeparate.Checked = False And chkHeadHousehold.Checked = False And chkWidow.Checked = False Then
                divError.Visible = True
                divSuccess.Visible = False
                chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                chkMarriedJoint.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                chkMarriedSeparate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                chkHeadHousehold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                chkWidow.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                lblError.Text = "Please choose a Filing status in Box 2"
                ResetScrollPosition()
                Exit Sub
            Else
                chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                chkMarriedJoint.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                chkMarriedSeparate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                chkHeadHousehold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                chkWidow.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If
            If Trim(txtTotalExemptions.Text) = "" Then
                divError.Visible = True
                divSuccess.Visible = False
                lblError.Text = "Please enter Total Allowances on Line 4.  Enter a 0 if none."
                txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                ResetScrollPosition()
                Exit Sub
            Else
                txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If
            If Trim(txtSignature.Text) = "" Then
                divError.Visible = True
                lblError.Text = "This form is not valid unless signed"
                txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                ResetScrollPosition()
                Exit Sub
            Else
                txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If
        End If

        btnSave.Visible = False
        imgProcessing.Visible = True

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

        objParam = New SqlParameter("@TaxFilingStatusId", IIf(chkSingle.Checked = True, "1",
                                                                IIf(chkMarriedJoint.Checked = True, "2",
                                                                IIf(chkMarriedSeparate.Checked = True, "3",
                                                                    IIf(chkHeadHousehold.Checked = True, "4",
                                                                        IIf(chkWidow.Checked = True, "5",
                                                                        ""))))))
        aryParams.Add(objParam)

        objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Exempt", IIf(txtExempt.Text = "EXEMPT", "1", "0"))
        aryParams.Add(objParam)

        objParam = New SqlParameter("@W4_Box1", txt1.Text)
        aryParams.Add(objParam)

        objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
        aryParams.Add(objParam)

        objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit", aryParams)
        sqlCon.CloseConn()

        divSuccess.Visible = True

        s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

        PopulateFields()
        ResetScrollPosition()

        btnSave.Visible = True
        imgProcessing.Visible = False

    End Sub

    Protected Sub chkSingle_CheckedChanged(sender As Object, e As EventArgs) Handles chkSingle.CheckedChanged
        If chkSingle.Checked = True Then
            chkMarriedJoint.Checked = False
            chkMarriedSeparate.Checked = False
            chkHeadHousehold.Checked = False
            chkWidow.Checked = False
        End If
    End Sub

    Protected Sub chkMarriedJoint_CheckedChanged(sender As Object, e As EventArgs) Handles chkMarriedJoint.CheckedChanged
        If chkMarriedJoint.Checked = True Then
            chkSingle.Checked = False
            chkMarriedSeparate.Checked = False
            chkHeadHousehold.Checked = False
            chkWidow.Checked = False
        End If
    End Sub

    Protected Sub chkMarriedSeparate_CheckedChanged(sender As Object, e As EventArgs)
        If chkMarriedSeparate.Checked = True Then
            chkSingle.Checked = False
            chkMarriedJoint.Checked = False
            chkHeadHousehold.Checked = False
            chkWidow.Checked = False
        End If
    End Sub

    Protected Sub chkHeadHousehold_CheckedChanged(sender As Object, e As EventArgs)
        If chkHeadHousehold.Checked = True Then
            chkSingle.Checked = False
            chkMarriedJoint.Checked = False
            chkMarriedSeparate.Checked = False
            chkWidow.Checked = False
        End If
    End Sub

    Protected Sub chkWidow_CheckedChanged(sender As Object, e As EventArgs)
        If chkWidow.Checked = True Then
            chkSingle.Checked = False
            chkMarriedJoint.Checked = False
            chkMarriedSeparate.Checked = False
            chkHeadHousehold.Checked = False
        End If
    End Sub

    Protected Sub txtExempt_TextChanged(sender As Object, e As EventArgs)
        If txtExempt.Text = "EXEMPT" Then
            chkSingle.Checked = False
            chkMarriedJoint.Checked = False
            chkMarriedSeparate.Checked = False
            chkHeadHousehold.Checked = False
            chkWidow.Checked = False
            txtTotalExemptions.Text = ""
            txtAdditionalWithholding.Text = ""
            txt1.Text = ""
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
