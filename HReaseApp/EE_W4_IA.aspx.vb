Imports System.Data.SqlClient

Public Class EE_W4_IA
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
            Session("Timeout") = False
            'Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EEW4IA"

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

            divError.Visible = False

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

            lblEmpLastName.Text = ec.LastName
            lblEmpFirstName.Text = ec.FirstName
            lblEmpMiddleName.Text = ec.MiddleInitial
            lblEmpAddress.Text = ec.AddressCombined
            lblEmpCity.Text = ec.City
            lblEmpState.Text = ec.State
            lblEmpZip.Text = ec.Zip
            lblEmployeeFullName.Text = ec.EmployeeFullName
            lblSSNumber1.Text = ec.SSNwithDashes
            lblHomeAddress.Text = ec.FullAddress
            lblEmployeeCity.Text = ec.City
            lblEmployeeState.Text = ec.State
            lblEEZip.Text = ec.Zip
            lblDOB.Text = ec.BirthDate
            lblSSNumber.Text = ec.SSNwithDashes
            lblDate1.Text = ec.LatestEligibilityDate
            lblDate2.Text = ec.LatestRehireDate

            rdoSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            rdoMarried.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)

            txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding
            txtExempt.Text = IIf(ec.Exempt = "1", "EXEMPT", "")
            chkMilitarySpouseRelief.Checked = IIf(ec.MilitarySpouseRelief = 1, True, False)

            txtExemptYear.Text = ec.W4_Box6
            txtMilitaryDomicileState.Text = ec.W4_Box7

            txtAllowance1.Text = ec.W4_Box1
            txtAllowance2.Text = ec.W4_Box2
            txtAllowance3.Text = ec.W4_Box3
            txtAllowance4.Text = ec.W4_Box4
            txtAllowance5.Text = ec.W4_Box5

            txtAllowanceA.Text = ec.PW_BoxA
            txtAllowanceB.Text = ec.PW_BoxB
            txtAllowanceC.Text = ec.PW_BoxC

            txtSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now(), ec.W4_SignatureDate)
            chkYes.Checked = IIf(ec.ID_Box1 = "1", True, False)
            chkNo.Checked = IIf(ec.ID_Box1 = "0", True, False)

            txtAddressDiff.Text = ec.ID_Box2
            txtCityDiff.Text = ec.ID_Box3
            txtStateDIFF.Text = ec.ID_Box4
            txtZipDIFF.Text = ec.ID_Box5
            txtNameDiff.Text = ec.ID_Box6

            lblEmployerName.Text = ec.CompanyName
            lblEmployerCombinedAddress.Text = ec.CompanyAddress1 + ec.CompanyAddress2
            lblEmployerCity.Text = ec.CompanyCity
            lblEmployerState.Text = ec.CompanyState
            lblEmployerZip.Text = ec.CompanyZip
            lblEmployerFEIN.Text = ec.CompanyFEIN
            lblEmployerName1.Text = ec.CompanyName
            lblEmployerCombinedAddress1.Text = ec.CompanyAddress1 + ec.CompanyAddress2
            lblEmployerCity1.Text = ec.CompanyCity
            lblEmployerState1.Text = ec.CompanyState
            lblEmployerZip1.Text = ec.CompanyZip
            lblEmployerFEIN1.Text = ec.CompanyFEIN
            lblEmployerPhoneNo.Text = ec.CompanyPhone

        End If

        If sc.GetNavigation(Session("UserId"), intEmployeeId, Session("ScreenName"), 0) = True Then
            Session("DataComplete") = sc.DataComplete
        End If

        If Session("DataComplete") = "Yes" Then
            imgNext.Visible = True

        Else
            imgNext.Visible = False

        End If

    End Sub

    Private Sub Save()
        If rdoSingle.Checked = False And rdoMarried.Checked = False And txtExempt.Text.ToUpper <> "EXEMPT" Then
            divError.Visible = True
            divSuccess.Visible = False
            rdoSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            rdoMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please Complete Status"
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtTotalExemptions.Text) = "" And txtExempt.Text.ToUpper <> "EXEMPT" Then
            divError.Visible = True
            divSuccess.Visible = False
            txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtExempt.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            lblError.Text = "Please Enter Allowances or Claim Exempt.  Enter 0 if none."
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtSignature.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "The form is not valid unless signed"
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If
        If (Trim(txtExempt.Text.ToUpper) = "EXEMPT" And Trim(txtExemptYear.Text.Length) <> 4) Or (Trim(txtExempt.Text.ToUpper) <> "EXEMPT" And Trim(txtExemptYear.Text.Length) = 4) Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "If Claiming exemption - please enter EXEMPT and provide applicable year in respective boxes."
            txtExempt.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtExemptYear.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If
        If (chkMilitarySpouseRelief.Checked = True And Trim(txtMilitaryDomicileState.Text.Length) < 2) Or (chkMilitarySpouseRelief.Checked = False And Trim(txtMilitaryDomicileState.Text.Length) > 1) Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "If Claiming Military exemption - please check box and enter applicable state in respective boxes."
            chkMilitarySpouseRelief.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtMilitaryDomicileState.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If

        If (rdoSingle.Checked = True Or rdoMarried.Checked = True Or txtExempt.Text.ToUpper = "EXEMPT") Then
            If Trim(txtTotalExemptions.Text) <> "" Then
                If Trim(txtSignature.Text) <> "" Then

                    rdoSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    rdoMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtExempt.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtExemptYear.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

                    btnSave.Visible = False
                    imgProcessing.Visible = True
                    lblError.Text = ""
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

                    objParam = New SqlParameter("@TaxFilingStatusId", IIf(rdoSingle.Checked = True, "1",
                                                                        IIf(rdoMarried.Checked = True, "2",
                                                                             "")))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@Exempt", IIf(txtExempt.Text.ToUpper = "EXEMPT", 1, 0))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@MilitarySpouseRelief", IIf(chkMilitarySpouseRelief.Checked = True, 1, 0))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now())
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Box1", txtAllowance1.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box2", txtAllowance2.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box3", txtAllowance3.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box4", txtAllowance4.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box5", txtAllowance5.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box6", txtExemptYear.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box7", txtMilitaryDomicileState.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@PW_BoxA", txtAllowanceA.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxB", txtAllowanceB.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxC", txtAllowanceC.Text)
                    aryParams.Add(objParam)


                    objParam = New SqlParameter("@ID_Box1", IIf(chkYes.Checked = True, "1",
                                                                IIf(chkNo.Checked = True, "0",
                                                                     "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box2", txtAddressDiff.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box3", txtCityDiff.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box4", txtStateDIFF.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box5", txtZipDIFF.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box6", txtNameDiff.Text)
                    aryParams.Add(objParam)

                    objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit", aryParams)
                    sqlCon.CloseConn()

                    divSuccess.Visible = True
                    imgNext.Visible = True

                    s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

                End If
            End If
        End If

        PopulateFields()
        ResetScrollPosition()
        btnSave.Visible = True
        imgProcessing.Visible = False
    End Sub

    Protected Sub rdoSingle_CheckedChanged(sender As Object, e As EventArgs)
        If rdoSingle.Checked = True Then
            rdoMarried.Checked = False
        End If
    End Sub
    Protected Sub rdoMarried_CheckedChanged(sender As Object, e As EventArgs)
        If rdoMarried.Checked = True Then
            rdoSingle.Checked = False
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