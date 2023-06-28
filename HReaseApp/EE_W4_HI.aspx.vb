Imports System.Data.SqlClient

Public Class EE_W4_HI
    Inherits System.Web.UI.Page

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
        strScreenName = "EEW4HI"


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
            imgNext.Visible = True
        Else
            divSuccess.Visible = False
            imgNext.Visible = False
        End If

        btnSave.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSave, "") + ";this.src='/img/processing.gif';")
        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateFields()
        'Get State W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id

            lblFullName.Text = ec.FirstNameMiddleInitial + " " + ec.LastName
            lblSSNumber.Text = ec.SSNwithDashes
            lblAddressCombined.Text = ec.AddressCombined
            lblCityStateZipCode.Text = ec.CityStateZip

            chkSingle.Checked = IIf(ec.TaxFilingStatusId = 1, True, False)
            chkMarried.Checked = IIf(ec.TaxFilingStatusId = 2, True, False)
            chkMarriedWHSR.Checked = IIf(ec.TaxFilingStatusId = 3, True, False)

            txttotalexemptions.Text = ec.TotalExemptions
            txtAdditionalAmt.Text = ec.AdditionalWithholding
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now(), ec.W4_SignatureDate)
            txtSigned.Text = ec.W4_Signature

            txtWFWABoxA.Text = ec.PW_BoxA
            txtWFWABoxB.Text = ec.PW_BoxB
            txtWFWABoxC.Text = ec.PW_BoxC
            txtWFWABoxD.Text = ec.PW_BoxD
            txtWFWABoxE.Text = ec.PW_BoxE
            txtWFWABoxF.Text = ec.PW_BoxF
            txtWFWABoxG.Text = ec.PW_BoxG
            txtWFWABoxH.Text = ec.PW_BoxH
            txtWFWABoxI.Text = ec.TE_Box9
            txtDAWBox1.Text = ec.TE_Box1
            txtDAWBox2.Text = ec.TE_Box2
            txtDAWBox3.Text = ec.TE_Box3
            txtDAWBox4.Text = ec.TE_Box4
            txtDAWBox5.Text = ec.TE_Box5
            txtDAWBox6.Text = ec.TE_Box6
            txtDAWBox7.Text = ec.TE_Box7
            txtDAWBox8.Text = ec.TE_Box8

            lblEmployerFullName.Text = ec.CompanyName
            lblEmployerHawaiiTaxID.Text = ""
            lblEmployerCombinedAddress.Text = ec.CompanyAddress1 + IIf(ec.CompanyAddress2 <> "", " " + ec.CompanyAddress2, "")
            lblEmployerCityStateZipCode.Text = ec.CompanyCity + ", " + ec.CompanyState + " " + ec.CompanyZip

        End If

    End Sub

    Private Sub Save()
        'Check for required fields
        If chkSingle.Checked = False And chkMarried.Checked = False And chkMarriedWHSR.Checked = False And chkCertifiedDisabledPerson.Checked = False And chkNRMilitarySpouse.Checked = False Then
            divError.Visible = True
            lblError.Text = "Please Select Marital Status"
            chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarriedWHSR.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkCertifiedDisabledPerson.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkNRMilitarySpouse.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If Trim(txttotalexemptions.Text) = "" Then
            divError.Visible = True
            lblError.Text = "Please enter an amount to Line 4.  Enter 0 if none."
            txttotalexemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If Trim(txtSigned.Text) = "" Then
            divError.Visible = True
            lblError.Text = "This form is not valid unless signed"
            txtSigned.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If (chkSingle.Checked = True Or chkMarried.Checked = True Or chkMarriedWHSR.Checked = True Or chkCertifiedDisabledPerson.Checked = True Or chkNRMilitarySpouse.Checked = True) Then
            If Trim(txttotalexemptions.Text) <> "" Then
                If Trim(txtSigned.Text) <> "" Then

                    chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarriedWHSR.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkCertifiedDisabledPerson.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkNRMilitarySpouse.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txttotalexemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtSigned.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

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
                                                                        IIf(chkMarried.Checked = True, "3",
                                                                            IIf(chkMarriedWHSR.Checked = True, "3", ""))))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TotalExemptions", txttotalexemptions.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalAmt.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", txtSigned.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@PW_BoxA", txtWFWABoxA.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxB", txtWFWABoxB.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxC", txtWFWABoxC.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxD", txtWFWABoxD.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxE", txtWFWABoxE.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxF", txtWFWABoxF.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxG", txtWFWABoxG.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxH", txtWFWABoxH.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box9", txtWFWABoxI.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box1", txtDAWBox1.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box2", txtDAWBox2.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box3", txtDAWBox3.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box4", txtDAWBox4.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box5", txtDAWBox5.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box6", txtDAWBox6.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box7", txtDAWBox7.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box8", txtDAWBox8.Text)
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