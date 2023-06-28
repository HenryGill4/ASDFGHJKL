Imports System.Data.SqlClient

Public Class EE_W4_MS
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

        'Change this on each page
        strScreenName = "EEW4MS"

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
            imgNext.Visible = True
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
            lblFullAddress.Text = ec.AddressCombined
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZipCode.Text = ec.Zip
            lblSSNumber.Text = ec.SSNwithDashes

            chkSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            chkSpouseNotEmployed.Checked = IIf(ec.TaxFilingStatusId = "7", True, False)
            chkSpouseIsEmployed.Checked = IIf(ec.TaxFilingStatusId = "8", True, False)
            chkHeadOfHousehold.Checked = IIf(ec.TaxFilingStatusId = "4", True, False)

            txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding

            txtSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now, ec.W4_SignatureDate)

            chkHusbandOver65.Checked = IIf(ec.W4_Box1 = "1", True, False)
            chkWifeOver65.Checked = IIf(ec.W4_Box2 = "1", True, False)
            chkSingleOver65.Checked = IIf(ec.W4_Box3 = "1", True, False)
            chkBlindHusband.Checked = IIf(ec.W4_Box4 = "1", True, False)
            chkBlindWife.Checked = IIf(ec.W4_Box5 = "1", True, False)
            chkBlindSingle.Checked = IIf(ec.W4_Box6 = "1", True, False)

            txtCount1.Text = IIf(ec.W4_Box1 = "1", 1, 0)
            txtCount2.Text = IIf(ec.W4_Box2 = "1", 1, 0)
            txtCount3.Text = IIf(ec.W4_Box3 = "1", 1, 0)
            txtCount4.Text = IIf(ec.W4_Box4 = "1", 1, 0)
            txtCount5.Text = IIf(ec.W4_Box5 = "1", 1, 0)
            txtCount6.Text = IIf(ec.W4_Box6 = "1", 1, 0)

            Dim FiveCount As Integer

            FiveCount = IIf(ec.W4_Box1 = "1", 1, 0)
            FiveCount = FiveCount + IIf(ec.W4_Box2 = "1", 1, 0)
            FiveCount = FiveCount + IIf(ec.W4_Box3 = "1", 1, 0)
            FiveCount = FiveCount + IIf(ec.W4_Box4 = "1", 1, 0)
            FiveCount = FiveCount + IIf(ec.W4_Box5 = "1", 1, 0)
            FiveCount = FiveCount + IIf(ec.W4_Box6 = "1", 1, 0)
            txtCountTotal.Text = FiveCount

            txtSingleAmount.Text = ec.ID_Box1
            txtSpouseNotEmployedAmount.Text = ec.ID_Box2
            txtSpouseISEmployedAmount.Text = ec.ID_Box3
            txtHeadOfHouseholdAmount.Text = ec.ID_Box4
            txtNumberOfDependents.Text = IIf(ec.ID_Box5 = "", "0", ec.ID_Box5)
            txtDependentAmount.Text = IIf(ec.ID_Box6 = "", "0", ec.ID_Box6)
            txtBlindTotal.Text = IIf(ec.ID_Box7 = "", "0", ec.ID_Box7)
            ChkMilitarySpouse.Checked = IIf(ec.MilitarySpouseRelief = 1, True, False)

        End If

    End Sub

    Private Sub Save()
        If chkSingle.Checked = False And chkSpouseNotEmployed.Checked = False And chkSpouseIsEmployed.Checked = False And chkHeadOfHousehold.Checked = False And ChkMilitarySpouse.Checked <> True Then
            divError.Visible = True
            divSuccess.Visible = False
            chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkSpouseNotEmployed.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkSpouseIsEmployed.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkHeadOfHousehold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please select a Marital Status on line 1, 2, or 3"
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If Trim(txtTotalExemptions.Text) = "0" Then
            divError.Visible = True
            divSuccess.Visible = False
            txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please Enter an Amount on Line 5 for Total Exemption Claimed"
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

        If (chkSingle.Checked = True Or chkSpouseNotEmployed.Checked = True Or chkSpouseIsEmployed.Checked = True Or chkHeadOfHousehold.Checked = True Or ChkMilitarySpouse.Checked = True) Then
            If Trim(txtTotalExemptions.Text) <> "0" Then
                If Trim(txtSignature.Text) <> "" Then

                    chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkSpouseNotEmployed.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkSpouseIsEmployed.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkHeadOfHousehold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
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

                    objParam = New SqlParameter("@TaxFilingStatusId", IIf(chkSingle.Checked = True, "1",
                                                                        IIf(chkSpouseNotEmployed.Checked = True, "7",
                                                                            IIf(chkSpouseIsEmployed.Checked = True, "8",
                                                                                IIf(chkHeadOfHousehold.Checked = True, "4", "")))))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@MilitarySpouseRelief", IIf(ChkMilitarySpouse.Checked = True, 1, 0))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Box1", IIf(chkHusbandOver65.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box2", IIf(chkWifeOver65.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box3", IIf(chkSingleOver65.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box4", IIf(chkBlindHusband.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box5", IIf(chkBlindWife.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box6", IIf(chkBlindSingle.Checked = True, "1", "0"))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Box8", IIf(ChkMilitarySpouse.Checked = True, "EXEMPT", ""))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@ID_Box1", txtSingleAmount.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box2", txtSpouseNotEmployedAmount.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box3", txtSpouseISEmployedAmount.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box4", txtHeadOfHouseholdAmount.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box5", txtNumberOfDependents.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box6", txtDependentAmount.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box7", txtBlindTotal.Text)
                    aryParams.Add(objParam)
                    'objParam = New SqlParameter("@ID_Box9", txtMilitarySpouseAmount.Text)
                    'aryParams.Add(objParam)

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


    Protected Sub btnSave_Click(sender As Object, e As ImageClickEventArgs)
        Save()

        ResetScrollPosition()
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