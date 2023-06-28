Imports System.Data.SqlClient

Public Class EE_W4_WI
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
        strScreenName = "EEW4WI"
        strScreenShortDesc = "WI W-4 Form"

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



            sc.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "EE_DirectDeposit")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            'lblMainArticleTitle.Text = sc.MainArticleTitle
            'lblMainArticleText.Text = IIf(sc.MainArticleText = "", "Please complete form", sc.MainArticleText)
            imgNext.Visible = False


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
        'Get State W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id

            lblFullName.Text = ec.EmployeeFullName
            lblSSN.Text = ec.SSNwithDashes
            lblAddressCombined.Text = ec.AddressCombined
            lblDOB.Text = ec.BirthDate
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZipCode.Text = ec.Zip
            lblDateOfHire.Text = ec.OriginalHireDate

            chkSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            chkMarried.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)
            chkMarriedWithhold.Checked = IIf(ec.TaxFilingStatusId = "3", True, False)

            txtTotalExemptions.Text = ec.TotalExemptions

            txtAdditionalWithholding.Text = ec.AdditionalWithholding

            txtExempt.Text = ec.Exempt

            txtSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now(), ec.W4_SignatureDate)

            txtLine1A.Text = ec.W4_Box1
            txtLine1B.Text = ec.W4_Box2
            txtLine1C.Text = ec.W4_Box3

            lblemployerfullname.Text = ec.CompanyName
            lblEmployerFEIN.Text = ec.CompanyFEIN
            lblemployerfulladdress.Text = ec.CompanyAddress1 + " " + IIf(Len(ec.CompanyAddress2) > 0, ec.CompanyAddress2, "")
            lblEmployerCity.Text = ec.CompanyCity
            lblEmployerState.Text = ec.CompanyState
            lblEmployerZipCode.Text = ec.CompanyZip

            lblEmployerCompletedBy.Text = ""
            lblEmployerTitle.Text = ""
            lblEmployerPhoneNo.Text = ""
            lblEmployerEmailID.Text = ""
        End If

    End Sub

    Private Sub Save()

        If txtExempt.Text = "" And chkSingle.Checked = False And chkMarried.Checked = False And chkMarriedWithhold.Checked = False Then
            divError.Visible = True
            divSuccess.Visible = False
            chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarriedWithhold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please Complete Marital Status"
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If txtExempt.Text = "" And Trim(txtTotalExemptions.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please Enter Total Exemptions"
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If Trim(txtSignature.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "This form is not valid unless signed"
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If (chkSingle.Checked = True Or chkMarried.Checked = True Or chkMarriedWithhold.Checked = True Or txtExempt.Text = "Exempt") Then
            If (Trim(txtTotalExemptions.Text) <> "" Or txtExempt.Text = "Exempt") Then
                If Trim(txtSignature.Text) <> "" Then

                    chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarriedWithhold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

                    btnSave.Visible = False
                    imgProcessing.Visible = True
                    divError.Visible = False

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
                                                                                IIf(chkMarried.Checked = True, "2",
                                                                                    IIf(chkMarriedWithhold.Checked = True, "3", ""))))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@Exempt", txtExempt.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Box1", txtLine1A.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box2", txtLine1B.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box3", txtLine1C.Text)
                    aryParams.Add(objParam)

                    objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit", aryParams)
                    sqlCon.CloseConn()

                    divSuccess.Visible = True

                    s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

                End If
            End If
        End If

        PopulateFields()
        ResetScrollPosition()
        btnSave.Visible = True
        imgProcessing.Visible = False

    End Sub

    Protected Sub chkSingle_CheckedChanged(sender As Object, e As EventArgs) Handles chkSingle.CheckedChanged
        If chkSingle.Checked = True Then
            chkMarried.Checked = False
            chkMarriedWithhold.Checked = False
        End If
    End Sub

    Protected Sub chkMarried_CheckedChanged(sender As Object, e As EventArgs) Handles chkMarried.CheckedChanged
        If chkMarried.Checked = True Then
            chkSingle.Checked = False
            chkMarriedWithhold.Checked = False
        End If
    End Sub

    Protected Sub chkMarriedwithhold_CheckedChanged(sender As Object, e As EventArgs) Handles chkMarriedWithhold.CheckedChanged
        If chkMarriedWithhold.Checked = True Then
            chkMarried.Checked = False
            chkSingle.Checked = False
        End If
    End Sub

    Protected Sub txtExempt_TextChanged(sender As Object, e As EventArgs)
        If txtExempt.Text = "EXEMPT" Then
            txtLine1A.Text = ""
            txtLine1B.Text = ""
            txtLine1C.Text = ""
            txtTotalExemptions.Text = ""
            txtAdditionalWithholding.Text = ""
            chkSingle.Checked = False
            chkMarried.Checked = False
            chkMarriedWithhold.Checked = False
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