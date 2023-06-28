Imports System.Data.SqlClient

Public Class EE_W4_CA
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
        strScreenName = "EEW4CA"

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
            'LabelMainArticleTitle.Text = sc.MainArticleTitle
            'LabelMainArticleText.Text = IIf(sc.MainArticleText = "", "Please complete form", sc.MainArticleText)

            PopulateFields()

        End If

        If Session("DataComplete") = "Yes" Then
            DivError.Visible = False
            DivSuccess.Visible = True
        Else
            DivSuccess.Visible = False
        End If

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateFields()
        'Get State W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id

            LabelFullName.Text = ec.EmployeeFullName
            LabelFullAddress.Text = ec.AddressCombined
            LabelCityStateZipCode.Text = ec.CityStateZip
            LabelSSNumber.Text = ec.SSNwithDashes

            CheckboxSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            CheckboxMarried.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)
            CheckboxHOH.Checked = IIf(ec.TaxFilingStatusId = "4", True, False)

            TextTotalExemptions.Text = ec.TotalExemptions
            TextAdditionalWithholding.Text = ec.AdditionalWithholding

            TextSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate <> "", ec.W4_SignatureDate, Date.Now())

            TextAllowancesWorksheetA.Text = ec.W4_Box1
            TextAllowancesWorksheetB.Text = ec.W4_Box2
            CheckboxExempt1.Checked = IIf(ec.W4_Box3 = "1", True, False)
            CheckboxExempt2.Checked = IIf(ec.W4_Box4 = "1", True, False)

            TextAllowance1A.Text = ec.PW_BoxA
            TextAllowance1B.Text = ec.PW_BoxB
            TextAllowance1C.Text = ec.PW_BoxC
            TextAllowance1D.Text = ec.PW_BoxD
            TextAllowance1E.Text = ec.PW_BoxE
            TextAllowance1F.Text = ec.PW_BoxF

            TextDeduction1.Text = ec.ID_Box1
            TextDeduction2.Text = ec.ID_Box2
            TextDeduction3.Text = ec.ID_Box3
            TextDeduction4.Text = ec.ID_Box4
            TextDeduction5.Text = ec.ID_Box5
            TextDeduction6.Text = ec.ID_Box6
            TextDeduction7.Text = ec.ID_Box7
            TextDeduction8.Text = ec.ID_Box8
            TextDeduction9.Text = ec.ID_Box9
            TextDeduction10.Text = ec.ID_Box10
            TextDeduction11.Text = ec.W4_Box10

            TextEstimatedTax1.Text = ec.TE_Box1
            TextEstimatedTax2.Text = ec.TE_Box2
            TextEstimatedTax3.Text = ec.TE_Box3
            TextEstimatedTax4.Text = ec.TE_Box4
            TextEstimatedTax5.Text = ec.TE_Box5
            TextEstimatedTax6.Text = ec.TE_Box6
            TextEstimatedTax7.Text = ec.TE_Box7
            TextEstimatedTax8.Text = ec.TE_Box8
            TextEstimatedTax9.Text = ec.TE_Box9
            TextEstimatedTax10.Text = ec.TE_Box10
            TextEstimatedTax11.Text = ec.TE_Box11
            TextEstimatedTax12.Text = ec.TE_Box12
            TextEstimatedTax13.Text = ec.TE_Box13
            TextEstimatedTax14.Text = ec.TE_Box14
            TextEstimatedTax15.Text = ec.TE_Box15

            LabelCompanyName.Text = ec.CompanyName
            LabelCompanyAddress.Text = ec.CompanyAddress1 + " " + IIf(Len(ec.CompanyAddress2) > 0, ec.CompanyAddress2, "")
            LabelCompanyCityStateZip.Text = ec.CompanyCity + ", " + ec.CompanyState + " " + ec.CompanyZip
            LabelEmployerPTANo.Text = ec.CompanyFEIN

        End If

    End Sub

    Private Sub Save()
        If CheckboxSingle.Checked = False And CheckboxMarried.Checked = False And CheckboxHOH.Checked = False Then
            DivError.Visible = True
            DivSuccess.Visible = False
            CheckboxSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            CheckboxMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            CheckboxHOH.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            LabelError.Text = "Please Complete Status"
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(TextTotalExemptions.Text) = "" Then
            DivError.Visible = True
            DivSuccess.Visible = False
            TextTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            LabelError.Text = "Please Enter Total Exemptions - enter 0 if none or if using Additional Withholding or if you are Exempt"
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(TextSignature.Text) = "" Then
            DivError.Visible = True
            DivSuccess.Visible = False
            LabelError.Text = "This form is not valid unless signed"
            TextSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ResetScrollPosition()
            Exit Sub
        End If

        If (CheckboxSingle.Checked = True Or CheckboxMarried.Checked = True Or CheckboxHOH.Checked = True) Then
            If Trim(TextTotalExemptions.Text) <> "" Then
                If Trim(TextSignature.Text) <> "" Then

                    DivError.Visible = False

                    CheckboxSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    CheckboxMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    CheckboxHOH.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    TextTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    TextSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

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

                    objParam = New SqlParameter("@TaxFilingStatusId", IIf(CheckboxSingle.Checked = True, "1",
                                                                        IIf(CheckboxMarried.Checked = True, "2",
                                                                            IIf(CheckboxHOH.Checked = True, "4", ""))))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TotalExemptions", TextTotalExemptions.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@AdditionalWithholding", TextAdditionalWithholding.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@Exempt", IIf(CheckboxExempt1.Checked = True, 1, IIf(CheckboxExempt1.Checked = True, 1, 0)))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", TextSignature.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Box1", TextAllowancesWorksheetA.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box2", TextAllowancesWorksheetB.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box3", IIf(CheckboxExempt1.Checked = True, "1", ""))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box4", IIf(CheckboxExempt2.Checked = True, "1", ""))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@PW_BoxA", TextAllowance1A.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxB", TextAllowance1B.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxC", TextAllowance1C.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxD", TextAllowance1D.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxE", TextAllowance1E.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxF", TextAllowance1F.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@ID_Box1", TextDeduction1.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box2", TextDeduction2.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box3", TextDeduction3.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box4", TextDeduction4.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box5", TextDeduction5.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box6", TextDeduction6.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box7", TextDeduction7.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box8", TextDeduction8.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box9", TextDeduction9.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box10", TextDeduction10.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box10", TextDeduction11.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TE_Box1", TextEstimatedTax1.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box2", TextEstimatedTax2.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box3", TextEstimatedTax3.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box4", TextEstimatedTax4.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box5", TextEstimatedTax5.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box6", TextEstimatedTax6.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box7", TextEstimatedTax7.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box8", TextEstimatedTax8.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box9", TextEstimatedTax9.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box10", TextEstimatedTax10.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box11", TextEstimatedTax11.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box12", TextEstimatedTax12.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box13", TextEstimatedTax13.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box14", TextEstimatedTax14.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box15", TextEstimatedTax15.Text)
                    aryParams.Add(objParam)

                    objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit", aryParams)
                    sqlCon.CloseConn()

                    DivSuccess.Visible = True
                End If
            End If
        End If

        PopulateFields()
        ResetScrollPosition()

        imgProcessing.Visible = False

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