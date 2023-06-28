Imports System.Data.SqlClient

Public Class EE_W4_MO
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim SecClass As New Security
    Dim ScreenConfig As New ScreenConfiguration
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
        strScreenName = "EEW4MO"
        strScreenShortDesc = "MO W-4 Form"

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
            SecClass.SaveUserUpdate(Session("UserId"), strScreenName, "Browse", intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

            If ScreenConfig.GetNavigation(Session("UserId"), intEmployeeId, strScreenName, 0) = True Then
                Session("ScreenName") = ScreenConfig.ScreenName
                Session("ScreenShortDesc") = ScreenConfig.ScreenShortDesc
                Session("ScreenPath") = ScreenConfig.ScreenPath
                Session("DataComplete") = ScreenConfig.DataComplete
                Session("NextScreen") = ScreenConfig.NextScreen
                Session("TabString") = ScreenConfig.TabString
                Session("ScreenConfigTitle") = ScreenConfig.ScreenConfigTitle
                Session("ScreenConfigText") = ScreenConfig.ScreenConfigText

            End If

            ScreenConfig.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            LiteralTopMenu.Text = ScreenConfig.BuildMenu(Session("Admin"), "EE_DirectDeposit")
            LiteralTab.Text = ScreenConfig.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            'lblMainArticleTitle.Text = ScreenConfig.MainArticleTitle
            'lblMainArticleText.Text = IIf(ScreenConfig.MainArticleText = "", "Please complete form", ScreenConfig.MainArticleText)
            imgNext.Visible = False


            PopulateFields()

        End If

        divError.Visible = False
        divSuccess.Visible = False
        btnSave.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSave, "") + ";this.src='/img/processing.gif';")
        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateFields()
        'Get State W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id

            lblFullName.Text = ec.EmployeeFullName
            lblFullAddress.Text = ec.AddressCombined
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZipCode.Text = ec.Zip
            lblSSNumber.Text = ec.SSNwithDashes

            chkSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            chkMarried.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)
            chkHOH.Checked = IIf(ec.TaxFilingStatusId = "4", True, False)

            txtAdditionalWithholding.Text = ec.AdditionalWithholding
            txtExempt.Text = IIf(ec.Exempt = "1", "EXEMPT", "")
            chkSpouseRelief.Checked = IIf(ec.MilitarySpouseRelief = "1", True, False)

            txtSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now(), ec.W4_SignatureDate)

            txtReducedWithholding.Text = ec.W4_Box1
            chkExemptNoLiability.Checked = IIf(ec.W4_Box2 = "1", True, False)
            chkActiveDutyMilitary.Checked = IIf(ec.W4_Box3 = "1", True, False)

            lblEmployerName.Text = ec.CompanyName
            lblEmployerFullAddress.Text = IIf(ec.Address2 <> "", ec.CompanyAddress1 + " " + ec.CompanyAddress2, ec.CompanyAddress1)
            lblEmployerCity.Text = ec.CompanyCity
            lblEmployerState.Text = ec.CompanyState
            lblEmployerZipCode.Text = ec.CompanyZip
            lblEmployerDate.Text = ec.OriginalHireDate
            lblEmployerIDNumber.Text = ec.CompanyFEIN
            lblEmployerTaxNumber.Text = ""

        End If

        If ScreenConfig.GetNavigation(Session("UserId"), intEmployeeId, Session("ScreenName"), 0) = True Then
            Session("DataComplete") = ScreenConfig.DataComplete
        End If

        If Session("DataComplete") = "Yes" Then
            imgNext.Visible = True
            
        Else
            imgNext.Visible = False
            
        End If

    End Sub

    Protected Sub Save()
        If chkSingle.Checked = False And chkMarried.Checked = False And chkHOH.Checked = False Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "Please Select a Filing Status"
            chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkHOH.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
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

        If (chkSingle.Checked = True Or chkMarried.Checked = True Or chkHOH.Checked = True) Then
            If Trim(txtSignature.Text) <> "" Then

                chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                chkHOH.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

                btnSave.Visible = False
                imgProcessing.Visible = True
                lblError.Text = ""
                divError.Visible = False
                imgNext.Visible = True

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
                                                                        IIf(chkHOH.Checked = True, "4", ""))))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Exempt", IIf(txtExempt.Text = "EXEMPT", 1, 0))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@MilitarySpouseRelief", IIf(chkSpouseRelief.Checked = True, 1, 0))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Box1", txtReducedWithholding.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box2", IIf(chkExemptNoLiability.Checked = True, 1, 0))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box3", IIf(chkActiveDutyMilitary.Checked = True, 1, 0))
                aryParams.Add(objParam)


                objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit", aryParams)
                sqlCon.CloseConn()

                divSuccess.Visible = True

                SecClass.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

            End If
        End If

        PopulateFields()
        ResetScrollPosition()
        btnSave.Visible = True
        imgProcessing.Visible = False
    End Sub

    Protected Sub chkSingle_CheckedChanged(sender As Object, e As EventArgs)
        If chkSingle.Checked = True Then
            chkMarried.Checked = False
            chkHOH.Checked = False
        End If
    End Sub

    Protected Sub chkMarried_CheckedChanged(sender As Object, e As EventArgs)
        If chkMarried.Checked = True Then
            chkHOH.Checked = False
            chkSingle.Checked = False
        End If
    End Sub

    Protected Sub chkHOH_CheckedChanged(sender As Object, e As EventArgs)
        If chkHOH.Checked = True Then
            chkMarried.Checked = False
            chkSingle.Checked = False
        End If
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As ImageClickEventArgs)
        Save()

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Save()

        Response.Redirect(Session("NextScreen"))
    End Sub

    Protected Sub txtExempt_TextChanged(sender As Object, e As EventArgs)
        If txtExempt.Text = "Exempt" Then
            txtAdditionalWithholding.Text = "0"
            txtReducedWithholding.Text = "0"
        End If
    End Sub

    Protected Sub chkExemptNoLiability_CheckedChanged(sender As Object, e As EventArgs)
        If chkExemptNoLiability.Checked = True Then
            txtAdditionalWithholding.Text = "0"
            txtReducedWithholding.Text = "0"
            txtExempt.Text = "EXEMPT"
        End If
    End Sub

    Protected Sub chkSpouseRelief_CheckedChanged(sender As Object, e As EventArgs)
        If chkSpouseRelief.Checked = True Then
            txtAdditionalWithholding.Text = "0"
            txtReducedWithholding.Text = "0"
            txtExempt.Text = "EXEMPT"
        End If
    End Sub

    Protected Sub chkActiveDutyMilitary_CheckedChanged(sender As Object, e As EventArgs)
        If chkActiveDutyMilitary.Checked = True Then
            txtAdditionalWithholding.Text = "0"
            txtReducedWithholding.Text = "0"
            txtExempt.Text = "EXEMPT"
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