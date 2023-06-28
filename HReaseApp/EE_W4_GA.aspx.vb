Imports System.Data.SqlClient

Public Class EE_W4_GA
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
        strScreenName = "EEW4GA"
        strScreenShortDesc = "GA W-4 Form"

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

    Private Function _toFocus() As String
        Throw New NotImplementedException()
    End Function

    Private Sub PopulateFields()
        'Get State W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id
            lblFullName.Text = ec.EmployeeFullName
            lblFullAddress.Text = ec.AddressCombined
            lblCityStateZip.Text = ec.CityStateZip
            lblSSNumber.Text = ec.SSNwithDashes

            txtSingle.Text = ec.W4_Box1
            txtMFJointBoth.Text = ec.W4_Box2
            txtMFJointOne.Text = ec.W4_Box3
            txtMFSeparate.Text = ec.W4_Box4
            txtHOHousehold.Text = ec.W4_Box5

            txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding
            chkExempt.Checked = IIf(ec.Exempt = "1", True, False)
            chkMilitarySpouseRelief.Checked = IIf(ec.MilitarySpouseRelief = "1", True, False)

            txtMaritalStatus.Text = ec.W4_Box6
            txtSpousesStateOFRecidence.Text = ec.W4_Box7
            txtAdditionalAllowances.Text = ec.W4_Box8
            txtNotSubTOGeorgiaWithholdings.Text = ec.W4_Box9
            txtDependentAllowances.Text = ec.W4_Box10

            txtSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now(), ec.W4_SignatureDate)

            chkOver65.Checked = IIf(ec.ID_Box1 = "1", True, False)
            chkBlind.Checked = IIf(ec.ID_Box2 = "1", True, False)
            chkSpouse65.Checked = IIf(ec.ID_Box3 = "1", True, False)
            chkSpouseBlind.Checked = IIf(ec.ID_Box4 = "1", True, False)
            txtNumberOfBoxesChecked.Text = ec.ID_Box5
            txtAddAllowLine1.Text = ec.ID_Box6

            txtAddAllowA.Text = ec.PW_BoxA
            txtAddAllowB.Text = ec.PW_BoxB
            txtAddAllowC.Text = ec.PW_BoxC
            txtAddAllowD.Text = ec.PW_BoxD
            txtAddAllowE.Text = ec.PW_BoxE
            txtAddAllowF.Text = ec.PW_BoxF
            txtAddAllowG.Text = ec.PW_BoxG
            txtAddAllowH.Text = ec.PW_BoxH

            lblEmployerName.Text = ec.CompanyName
            lblEmployerFEIN.Text = ec.CompanyFEIN
            lblEmployerFullAddress.Text = ec.CompanyAddress1
            lblEmployerCity.Text = ec.CompanyCity
            lblEmployerState.Text = ec.CompanyState
            lblEmployerZip.Text = ec.CompanyZip
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

    Private Sub Save()
        'Check for required fields
        If txtSingle.Text = "" And txtMFJointBoth.Text = "" And txtMFJointOne.Text = "" And txtMFSeparate.Text = "" And txtHOHousehold.Text = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            txtSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtMFJointBoth.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtMFJointOne.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtMFSeparate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtHOHousehold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please enter at least one MARITAL STATUS"
            imgNext.Visible = False
            
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtTotalExemptions.Text) = "" And chkExempt.Checked = False And chkMilitarySpouseRelief.Checked = False Then
            divError.Visible = True
            divSuccess.Visible = False
            txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkExempt.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMilitarySpouseRelief.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please Enter Total Allowances on Line 7 or Claim Exempt on Line 8"
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

        If (txtSingle.Text <> "" Or txtMFJointBoth.Text <> "" Or txtMFJointOne.Text <> "" Or txtMFSeparate.Text <> "" Or txtHOHousehold.Text = "") Then
            If Trim(txtTotalExemptions.Text) <> "" Or chkExempt.Checked = True Or chkMilitarySpouseRelief.Checked = True Then
                If Trim(txtSignature.Text) <> "" Then

                    txtSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtMFJointBoth.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtMFJointOne.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtMFSeparate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtHOHousehold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkExempt.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMilitarySpouseRelief.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

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

                    objParam = New SqlParameter("@TaxFilingStatusId", IIf(txtSingle.Text <> "", "1",
                                                                        IIf(txtMFJointBoth.Text <> "", "2",
                                                                            IIf(txtMFJointOne.Text <> "", "6",
                                                                                IIf(txtMFSeparate.Text <> "", "3",
                                                                                    IIf(txtHOHousehold.Text <> "", "4",
                                                                                        ""))))))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@Exempt", IIf(chkExempt.Checked = True, 1, 0))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@MilitarySpouseRelief", IIf(chkMilitarySpouseRelief.Checked = True, 1, 0))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Box1", txtSingle.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box2", txtMFJointBoth.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box3", txtMFJointOne.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box4", txtMFSeparate.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box5", txtHOHousehold.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box6", txtMaritalStatus.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box7", txtSpousesStateOFRecidence.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box8", txtAdditionalAllowances.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box9", txtNotSubTOGeorgiaWithholdings.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box10", txtDependentAllowances.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@ID_Box1", IIf(chkOver65.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box2", IIf(chkBlind.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box3", IIf(chkSpouse65.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box4", IIf(chkSpouse65.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box5", txtNumberOfBoxesChecked.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box6", txtAddAllowLine1.Text)


                    objParam = New SqlParameter("@PW_BoxA", txtAddAllowA.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxB", txtAddAllowB.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxC", txtAddAllowC.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxD", txtAddAllowD.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxE", txtAddAllowE.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxF", txtAddAllowF.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxG", txtAddAllowG.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxH", txtAddAllowH.Text)
                    aryParams.Add(objParam)

                    objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit_Dev", aryParams)
                    sqlCon.CloseConn()

                    divSuccess.Visible = True

                    SecClass.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

                End If
            End If
        End If

        PopulateFields()
        ResetScrollPosition()

    End Sub

    Protected Sub btnSave_Click(sender As Object, e As ImageClickEventArgs)
        Save()

        'If no errors go to Next Screen in Navigation
        If divError.Visible = True Then
            Exit Sub
        Else
            imgNext.Visible = False
            
            ResetScrollPosition()
            Response.AddHeader("REFRESH", "0;URL=" + Session("NextScreen"))
        End If

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