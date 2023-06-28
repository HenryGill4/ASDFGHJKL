Imports System.Data.SqlClient

Public Class EE_W4_OR
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
        strScreenName = "EEW4OR"
        strScreenShortDesc = "OR W-4 Form"

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

            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), Session("ScreenPath"))
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

            txtA1.Text = ec.PW_BoxA
            txtA2.Text = ec.PW_BoxB
            txtA3.Text = ec.PW_BoxC
            txtA4.Text = ec.PW_BoxD

            txtB1.Text = ec.TE_Box1
            txtB2.Text = ec.TE_Box2
            txtB3.Text = ec.TE_Box3
            txtB4.Text = ec.TE_Box4
            txtB5.Text = ec.TE_Box5
            txtB6.Text = ec.TE_Box6
            txtB7.Text = ec.TE_Box7
            txtB8.Text = ec.TE_Box8
            txtB9.Text = ec.TE_Box9
            txtB10.Text = ec.TE_Box10
            txtB11.Text = ec.TE_Box11
            txtB12.Text = ec.TE_Box12
            txtB13.Text = ec.TE_Box13
            txtB14.Text = ec.TE_Box14
            txtB15.Text = ec.TE_Box15

            txtC1.Text = ec.ID_Box1
            txtC2.Text = ec.ID_Box2
            txtC3.Text = ec.ID_Box3
            txtC4.Text = ec.ID_Box4
            txtC5.Text = ec.ID_Box5
            txtC6.Text = ec.ID_Box6
            txtC7.Text = ec.ID_Box7
            txtC8.Text = ec.ID_Box8

            lblSSN.Text = ec.SSNwithDashes
            lblFirstName.Text = ec.FirstName
            lblMiddleInitial.Text = ec.MiddleInitial
            lblLastName.Text = ec.LastName
            lblCombinedAddress.Text = ec.AddressCombined
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZip.Text = ec.Zip

            chkRedetermination.Checked = IIf(ec.W4_Box1 = "1", True, False)

            chkSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            chkMarried.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)
            chkMarriedWHHigher.Checked = IIf(ec.TaxFilingStatusId = "3", True, False)

            txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding

            txt4a.Text = ec.W4_Box2
            txt4b.Text = IIf(ec.Exempt = "1", "EXEMPT", "")

            txtSignature.Text = ec.W4_Signature
            txtSignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now, ec.W4_SignatureDate)

            lblEmployerName.Text = ec.CompanyName
            lblEmployerFEIN.Text = ec.CompanyFEIN
            lblEmployerAddress.Text = ec.CompanyAddress1 + " " + IIf(Len(ec.CompanyAddress2) > 0, ec.CompanyAddress2, "")
            lblEmployerCity.Text = ec.CompanyCity
            lblEmployerState.Text = ec.CompanyState
            lblEmployerZip.Text = ec.CompanyZip

        End If

    End Sub

    Private Sub Save()
        'Check for required fields
        If chkSingle.Checked = False And chkMarried.Checked = False And chkMarriedWHHigher.Checked = False And txt4a.Text = "" And txt4b.Text = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarriedWHHigher.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please Enter Filing Status"
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtTotalExemptions.Text) = "" And txt4a.Text = "" And txt4b.Text = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "Please Enter amount to Line 2, or complete 4a and 4b if exempt. "
            txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
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
        If (txt4a.Text <> "" Or txt4b.Text <> "") Then
            txtAdditionalWithholding.Text = "0"
            txtTotalExemptions.Text = "0"
        End If

        If Trim(txtTotalExemptions.Text) <> "" Or (txt4a.Text <> "" And txt4b.Text <> "") Then
            If Trim(txtSignature.Text) <> "" Then

                txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
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
                                                                IIf(chkMarriedWHHigher.Checked = True, "3",
                                                                     ""))))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Exempt", IIf(txt4a.Text <> "" Or txt4b.Text <> "", 1, 0))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Box1", IIf(chkRedetermination.Checked = True, "1", "0"))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Box2", txt4a.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@PW_BoxA", txtA1.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxB", txtA2.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxC", txtA3.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxD", txtA4.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@TE_Box1", txtB1.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@TE_Box2", txtB2.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@TE_Box3", txtB3.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@TE_Box4", txtB4.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@TE_Box5", txtB5.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@TE_Box6", txtB6.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@TE_Box7", txtB7.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@TE_Box8", txtB8.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@TE_Box9", txtB9.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@TE_Box10", txtB10.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@TE_Box11", txtB11.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@TE_Box12", txtB12.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@TE_Box13", txtB13.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@TE_Box14", txtB14.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@TE_Box15", txtB15.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@ID_Box1", txtC1.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box2", txtC2.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box3", txtC3.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box4", txtC4.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box5", txtC5.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box6", txtC6.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box7", txtC7.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box8", txtC8.Text)
                aryParams.Add(objParam)

                objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit", aryParams)
                sqlCon.CloseConn()

                divSuccess.Visible = True

                s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

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
            chkMarriedWHHigher.Checked = False
        End If
    End Sub

    Protected Sub chkMarried_CheckedChanged(sender As Object, e As EventArgs)
        If chkMarried.Checked = True Then
            chkMarriedWHHigher.Checked = False
            chkSingle.Checked = False
        End If
    End Sub

    Protected Sub chkMarriedWH_CheckedChanged(sender As Object, e As EventArgs)
        If chkMarriedWHHigher.Checked = True Then
            chkMarried.Checked = False
            chkSingle.Checked = False
        End If
    End Sub

    Protected Sub txt4a_TextChanged(sender As Object, e As EventArgs)
        If txt4a.Text <> "" Then
            chkSingle.Checked = False
            chkMarried.Checked = False
            chkMarriedWHHigher.Checked = False
            txtTotalExemptions.Text = "0"
            txtAdditionalWithholding.Text = "0"
            txt4b.Text = "EXEMPT"
        End If
    End Sub

    Protected Sub txt4b_TextChanged(sender As Object, e As EventArgs)
        If txt4b.Text <> "" Then
            chkSingle.Checked = False
            chkMarried.Checked = False
            chkMarriedWHHigher.Checked = False
            txtTotalExemptions.Text = "0"
            txtAdditionalWithholding.Text = "0"
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
