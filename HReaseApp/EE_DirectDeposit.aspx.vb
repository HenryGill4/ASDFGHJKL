Imports System.Data.SqlClient

Public Class EE_DirectDeposit
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

    Dim booGotEmployee As Boolean

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "DirectDeposit"
        strScreenShortDesc = "Direct Deposit"

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
            lblMainArticleTitle.Text = sc.MainArticleTitle
            lblMainArticleText.Text = sc.MainArticleText

            If lblMainArticleText.Text = "" Then
                divText.Visible = False
            End If

            ddlAccountType.Items.Insert(0, New ListItem(""))
            ddlAccountType2.Items.Insert(0, New ListItem(""))
            ddlAccountType3.Items.Insert(0, New ListItem(""))
            ddlAccountType4.Items.Insert(0, New ListItem(""))
            ddlAmountType.Items.Insert(0, New ListItem(""))
            ddlAmountType2.Items.Insert(0, New ListItem(""))
            ddlAmountType3.Items.Insert(0, New ListItem(""))
            ddlAmountType4.Items.Insert(0, New ListItem(""))
            ddlPriority.Items.Insert(0, New ListItem(""))
            ddlPriority2.Items.Insert(0, New ListItem(""))
            ddlPriority3.Items.Insert(0, New ListItem(""))
            ddlPriority4.Items.Insert(0, New ListItem(""))

            PopulateFields()

            divError.Visible = False

        End If

        If Session("DataComplete") = "Yes" Then
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
        'Go Get Employee Direct Deposit Info
        booGotEmployee = ec.GetEmployeeDirectDepositInfo(intEmployeeId)

        If booGotEmployee = True Then

            chkYes.Checked = IIf(ec.DDYesNo = "1", True, False)
            chkNo.Checked = IIf(ec.DDYesNo = "0", True, False)

            txtBankName.Text = ec.BankName
            txtRoutingNumber.Text = ec.RoutingNumber
            txtRoutingNumberVerify.Text = ec.RoutingNumberVerify
            txtAccountNumber.Text = ec.AccountNumber
            txtAccountNumberVerify.Text = ec.AccountNumberVerify
            ddlAccountType.SelectedValue = ec.DDAccountType
            ddlAmountType.SelectedValue = ec.DDAmountType
            txtAmount.Text = ec.DDAmount
            ddlPriority.SelectedValue = ec.DDPriority

            txtBankName2.Text = ec.BankName2
            txtRoutingNumber2.Text = ec.RoutingNumber2
            txtRoutingNumberVerify2.Text = ec.RoutingNumberVerify2
            txtAccountNumber2.Text = ec.AccountNumber2
            txtAccountNumberVerify2.Text = ec.AccountNumberVerify2
            ddlAccountType2.SelectedValue = ec.DDAccountType2
            ddlAmountType2.SelectedValue = ec.DDAmountType2
            txtAmount2.Text = ec.DDAmount2
            ddlPriority2.SelectedValue = ec.DDPriority2

            txtBankName3.Text = ec.BankName3
            txtRoutingNumber3.Text = ec.RoutingNumber3
            txtRoutingNumberVerify3.Text = ec.RoutingNumberVerify3
            txtAccountNumber3.Text = ec.AccountNumber3
            txtAccountNumberVerify3.Text = ec.AccountNumberVerify3
            ddlAccountType3.SelectedValue = ec.DDAccountType3
            ddlAmountType3.SelectedValue = ec.DDAmountType3
            txtAmount3.Text = ec.DDAmount3
            ddlPriority3.SelectedValue = ec.DDPriority3

            txtBankName4.Text = ec.BankName4
            txtRoutingNumber4.Text = ec.RoutingNumber4
            txtRoutingNumberVerify4.Text = ec.RoutingNumberVerify4
            txtAccountNumber4.Text = ec.AccountNumber4
            txtAccountNumberVerify4.Text = ec.AccountNumberVerify4
            ddlAccountType4.SelectedValue = ec.DDAccountType4
            ddlAmountType4.SelectedValue = ec.DDAmountType4
            txtAmount4.Text = ec.DDAmount4
            ddlPriority4.SelectedValue = ec.DDPriority4

        Else
            txtBankName.Text = ""
            txtRoutingNumber.Text = ""
            txtAccountNumber.Text = ""

        End If

        If txtBankName2.Text = "" Then
            divBank2.Attributes.Add("class", "well HREWhite HRERewrap instruction_toggle")
        Else
            divBank2.Attributes.Add("class", "well HREWhite HRERewrap")
        End If

        If txtBankName3.Text = "" Then
            divBank3.Attributes.Add("class", "well HREWhite HRERewrap instruction_toggle")
        Else
            divBank3.Attributes.Add("class", "well HREWhite HRERewrap")
        End If

        If txtBankName4.Text = "" Then
            divBank4.Attributes.Add("class", "well HREWhite HRERewrap instruction_toggle")
        Else
            divBank4.Attributes.Add("class", "well HREWhite HRERewrap")
        End If

    End Sub

    Private Sub Save()

        If chkYes.Checked = False And chkNo.Checked = False Then
            lblError.Text = "Please indicate with a check if you choose to elect direct deposit or not."
            chkYes.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkNo.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            divError.Visible = True
            divSuccess.Visible = False
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If

        If chkNo.Checked = False Then

            If txtBankName.Text = "" Or txtAccountNumber.Text = "" Or ddlAccountType.SelectedItem.Text = "" Or ddlAmountType.SelectedItem.Text = "" Or txtAmount.Text = "" Or ddlPriority.SelectedItem.Text = "" Then
                lblError.Text = "Please complete the required information highlighted below."
                divError.Visible = True
                divSuccess.Visible = False
                If txtBankName.Text = "" Then
                    txtBankName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                Else
                    txtBankName.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                End If

                If txtRoutingNumber.Text = "" Then
                    txtRoutingNumber.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                Else
                    txtRoutingNumber.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                End If

                If txtRoutingNumberVerify.Text = "" Then
                    txtRoutingNumberVerify.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                Else
                    txtRoutingNumberVerify.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                End If

                If txtAccountNumber.Text = "" Then
                    txtAccountNumber.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                Else
                    txtAccountNumber.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                End If

                If txtAccountNumberVerify.Text = "" Then
                    txtAccountNumberVerify.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                Else
                    txtAccountNumberVerify.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                End If

                If ddlAccountType.SelectedIndex = -1 Or ddlAccountType.SelectedItem.Text = "" Or ddlAccountType Is Nothing Then
                    ddlAccountType.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                Else
                    ddlAccountType.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                End If

                If ddlAmountType.SelectedIndex = -1 Or ddlAmountType.SelectedItem.Text = "" Or ddlAmountType Is Nothing Then
                    ddlAmountType.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                Else
                    ddlAmountType.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                End If

                If txtAmount.Text = "" Then
                    txtAmount.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                Else
                    txtAmount.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                End If

                If ddlPriority.SelectedIndex = -1 Or ddlPriority.SelectedItem.Text = "" Or ddlPriority Is Nothing Then
                    ddlPriority.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                Else
                    ddlPriority.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                End If
                imgNext.Visible = False

                ResetScrollPosition()
                Exit Sub
            End If

            If txtRoutingNumber.Text.Length <> 9 Or (txtBankName2.Text <> "" And txtRoutingNumber2.Text.Length <> 9) Or (txtBankName3.Text <> "" And txtRoutingNumber3.Text.Length <> 9) Or (txtBankName4.Text <> "" And txtRoutingNumber4.Text.Length <> 9) Then
                lblError.Text = "Routing Numbers must be 9 digits in length.  Please verify your Routing Number"
                divError.Visible = True
                imgNext.Visible = False
                divSuccess.Visible = False
                ResetScrollPosition()
                Exit Sub
            End If

            If txtRoutingNumber.Text <> txtRoutingNumberVerify.Text Then
                divError.Visible = True
                lblError.Text = "Routing Number of Bank 1 does not match verify"
                txtRoutingNumber.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                txtRoutingNumberVerify.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                imgNext.Visible = False
                divSuccess.Visible = False
                ResetScrollPosition()
                Exit Sub
            Else
                txtRoutingNumber.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                txtRoutingNumberVerify.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
            End If

            If txtAccountNumber.Text <> txtAccountNumberVerify.Text Then
                divError.Visible = True
                lblError.Text = "Routing Number of Bank 1 does not match verify"
                txtAccountNumber.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                txtAccountNumberVerify.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                imgNext.Visible = False
                divSuccess.Visible = False
                ResetScrollPosition()
                Exit Sub
            Else
                txtAccountNumber.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                txtAccountNumberVerify.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
            End If

            If txtBankName2.Text <> "" Then
                If (txtAccountNumber2.Text = "" Or ddlAccountType2.SelectedItem.Text = "" Or ddlAmountType2.SelectedItem.Text = "" Or txtAmount2.Text = "" Or ddlPriority2.SelectedItem.Text = "") Then
                    lblError.Text = "Please Complete all sections for Bank #2"
                    divError.Visible = True
                    imgNext.Visible = False
                    divSuccess.Visible = False
                    ResetScrollPosition()
                    Exit Sub
                End If

                If txtBankName2.Text <> "" And txtRoutingNumber2.Text <> txtRoutingNumberVerify2.Text Then
                    lblError.Text = "Routing Number of Bank 2 does not match verification"
                    txtRoutingNumber2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    txtRoutingNumberVerify2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    imgNext.Visible = False
                    divSuccess.Visible = False
                    ResetScrollPosition()
                    Exit Sub
                Else
                    txtRoutingNumber2.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                    txtRoutingNumberVerify2.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                End If

                If txtBankName2.Text <> "" And txtAccountNumber2.Text <> txtAccountNumberVerify2.Text Then
                    lblError.Text = "Account Number of Bank 2 does not match verification"
                    txtAccountNumber2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    txtAccountNumberVerify2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    imgNext.Visible = False
                    divSuccess.Visible = False
                    ResetScrollPosition()
                    Exit Sub
                Else
                    txtAccountNumber2.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                    txtAccountNumberVerify2.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                End If
            End If

            If txtBankName3.Text <> "" Then
                If (txtAccountNumber3.Text = "" Or ddlAccountType3.SelectedItem.Text = "" Or ddlAmountType3.SelectedItem.Text = "" Or txtAmount3.Text = "" Or ddlPriority3.SelectedItem.Text = "") Then
                    lblError.Text = "Please Complete all sections for Bank #3"
                    divError.Visible = True
                    imgNext.Visible = False
                    divSuccess.Visible = False
                    ResetScrollPosition()
                    Exit Sub
                End If

                If txtBankName3.Text <> "" And txtRoutingNumber3.Text <> txtRoutingNumberVerify3.Text Then
                    lblError.Text = "Routing Number of Bank 3 does not match verification"
                    txtRoutingNumber3.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    txtRoutingNumberVerify3.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    imgNext.Visible = False
                    divSuccess.Visible = False
                    ResetScrollPosition()
                    Exit Sub
                Else
                    txtRoutingNumber3.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                    txtRoutingNumberVerify3.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                End If

                If txtBankName3.Text <> "" And txtAccountNumber3.Text <> txtAccountNumberVerify3.Text Then
                    lblError.Text = "Account Number of Bank 3 does not match verification"
                    txtAccountNumber3.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    txtAccountNumberVerify3.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    imgNext.Visible = False
                    divSuccess.Visible = False
                    ResetScrollPosition()
                    Exit Sub
                Else
                    txtAccountNumber3.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                    txtAccountNumberVerify3.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                End If
            End If

            If txtBankName4.Text <> "" Then
                If (txtAccountNumber4.Text = "" Or ddlAccountType4.SelectedItem.Text = "" Or ddlAmountType4.SelectedItem.Text = "" Or txtAmount4.Text = "" Or ddlPriority4.SelectedItem.Text = "") Then
                    lblError.Text = "Please Complete all sections for Bank #4"
                    divError.Visible = True
                    imgNext.Visible = False
                    divSuccess.Visible = False
                    ResetScrollPosition()
                    Exit Sub
                End If

                If txtBankName4.Text <> "" And txtRoutingNumber4.Text <> txtRoutingNumberVerify4.Text Then
                    lblError.Text = "Routing Number of Bank 4 does not match verification"
                    txtRoutingNumber4.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    txtRoutingNumberVerify4.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    imgNext.Visible = False
                    divSuccess.Visible = False
                    ResetScrollPosition()
                    Exit Sub
                Else
                    txtRoutingNumber4.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                    txtRoutingNumberVerify4.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                End If

                If txtBankName4.Text <> "" And txtAccountNumber4.Text <> txtAccountNumberVerify4.Text Then
                    lblError.Text = "Account Number of Bank 4 does not match verification"
                    txtAccountNumber4.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    txtAccountNumberVerify4.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    imgNext.Visible = False
                    divSuccess.Visible = False
                    ResetScrollPosition()
                    Exit Sub
                Else
                    txtAccountNumber4.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                    txtAccountNumberVerify4.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                End If
            End If

            If (ddlAmountType.SelectedItem.Text = "%" Or ddlAmountType2.SelectedItem.Text = "%" Or ddlAmountType3.SelectedItem.Text = "%" Or ddlAmountType4.SelectedItem.Text = "%") Then
                Dim vSum As Integer
                vSum = 0

                vSum = 0
                If ddlAmountType.SelectedItem.Text = "%" And txtAmount.Text <> "" Then
                    vSum = vSum + txtAmount.Text
                End If
                If ddlAmountType2.SelectedItem.Text = "%" And txtAmount2.Text <> "" Then
                    vSum = vSum + txtAmount2.Text
                End If
                If ddlAmountType3.SelectedItem.Text = "%" And txtAmount3.Text <> "" Then
                    vSum = vSum + txtAmount3.Text
                End If
                If ddlAmountType4.SelectedItem.Text = "%" And txtAmount.Text <> "" Then
                    vSum = vSum + txtAmount4.Text
                End If
                If vSum > 100 Then
                    lblError.Text = "Your % allocations cannot exceed 100 percent"
                    divError.Visible = True
                    imgNext.Visible = False
                    divSuccess.Visible = False
                    ResetScrollPosition()
                    Exit Sub
                End If

            End If

            If (ddlPriority.SelectedItem.Text = ddlPriority2.SelectedItem.Text And txtBankName2.Text <> "") Or (ddlPriority.SelectedItem.Text = ddlPriority3.SelectedItem.Text And txtBankName3.Text <> "") Or (ddlPriority.SelectedItem.Text = ddlPriority4.SelectedItem.Text And txtBankName4.Text <> "") Or (ddlPriority2.SelectedItem.Text = ddlPriority3.SelectedItem.Text And txtBankName2.Text <> "" And txtBankName3.Text <> "") Or (ddlPriority2.SelectedItem.Text = ddlPriority4.SelectedItem.Text And txtBankName2.Text <> "" And txtBankName4.Text <> "") Or (ddlPriority3.SelectedItem.Text = ddlPriority4.SelectedItem.Text And txtBankName3.Text <> "" And txtBankName4.Text <> "") Then
                lblError.Text = "Your prioritizations must be unique.  Please modify."
                divError.Visible = True
                imgNext.Visible = False
                divSuccess.Visible = False
                ResetScrollPosition()
                Exit Sub
            End If
        End If

        If chkYes.Checked = True Or chkNo.Checked = True Then
            chkYes.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
            chkNo.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
        End If

        imgProcessing.Visible = True

        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        objParam = New SqlParameter("@EmployeeId", intEmployeeId)
        aryParams.Add(objParam)

        objParam = New SqlParameter("@UserId", Session("UserId"))
        aryParams.Add(objParam)

        objParam = New SqlParameter("@DDYesNo", IIf(chkNo.Checked = True, 0,
                                                    IIf(chkYes.Checked = True, 1,
                                                        1)))
        aryParams.Add(objParam)

        objParam = New SqlParameter("@BankName", txtBankName.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@RoutingNumber", txtRoutingNumber.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@RoutingNumberVerify", txtRoutingNumberVerify.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@AccountNumber", txtAccountNumber.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@AccountNumberVerify", txtAccountNumberVerify.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDAccountType", IIf(txtBankName.Text = "", "", ddlAccountType.SelectedValue))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDAmountType", ddlAmountType.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDAmount", IIf(txtAmount.Text = "", 0, txtAmount.Text))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDPriority", ddlPriority.SelectedValue)
        aryParams.Add(objParam)

        objParam = New SqlParameter("@BankName2", txtBankName2.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@RoutingNumber2", txtRoutingNumber2.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@RoutingNumberVerify2", txtRoutingNumberVerify2.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@AccountNumber2", txtAccountNumber2.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@AccountNumberVerify2", txtAccountNumberVerify2.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDAccountType2", IIf(txtBankName2.Text = "", "", ddlAccountType2.SelectedValue))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDAmountType2", ddlAmountType2.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDAmount2", IIf(txtAmount2.Text = "", 0, txtAmount2.Text))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDPriority2", ddlPriority2.SelectedValue)
        aryParams.Add(objParam)

        objParam = New SqlParameter("@BankName3", txtBankName3.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@RoutingNumber3", txtRoutingNumber3.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@RoutingNumberVerify3", txtRoutingNumberVerify3.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@AccountNumber3", txtAccountNumber3.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@AccountNumberVerify3", txtAccountNumberVerify3.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDAccountType3", IIf(txtBankName3.Text = "", "", ddlAccountType3.SelectedValue))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDAmountType3", ddlAmountType3.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDAmount3", IIf(txtAmount3.Text = "", 0, txtAmount3.Text))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDPriority3", ddlPriority3.SelectedValue)
        aryParams.Add(objParam)

        objParam = New SqlParameter("@BankName4", txtBankName4.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@RoutingNumber4", txtRoutingNumber4.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@RoutingNumberVerify4", txtRoutingNumberVerify4.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@AccountNumber4", txtAccountNumber4.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@AccountNumberVerify4", txtAccountNumberVerify4.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDAccountType4", IIf(txtBankName4.Text = "", "", ddlAccountType4.SelectedValue))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDAmountType4", ddlAmountType4.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDAmount4", IIf(txtAmount4.Text = "", 0, txtAmount4.Text))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DDPriority4", ddlPriority4.SelectedValue)
        aryParams.Add(objParam)

        objDataSet = sqlCon.CreateDataSet("usp_Employee_DirectDeposit_Edit", aryParams)
        sqlCon.CloseConn()

        divSuccess.Visible = True
        divError.Visible = False
        imgNext.Visible = True

        s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

        imgProcessing.Visible = False

        PopulateFields()
        ResetScrollPosition()

    End Sub

    Protected Sub chkYes_CheckedChanged(sender As Object, e As EventArgs)
        If chkYes.Checked = True Then
            chkNo.Checked = False
        End If
    End Sub

    Protected Sub chkNo_CheckedChanged(sender As Object, e As EventArgs)
        If chkNo.Checked = True Then
            chkYes.Checked = False

            txtBankName.Text = ""
            txtRoutingNumber.Text = ""
            txtRoutingNumberVerify.Text = ""
            txtAccountNumber.Text = ""
            txtAccountNumberVerify.Text = ""
            ddlAccountType.SelectedValue = ""
            ddlAmountType.SelectedValue = ""
            txtAmount.Text = ""
            ddlPriority.SelectedValue = ""
            txtBankName2.Text = ""
            txtRoutingNumber2.Text = ""
            txtRoutingNumberVerify2.Text = ""
            txtAccountNumber2.Text = ""
            txtAccountNumberVerify2.Text = ""
            ddlAccountType2.SelectedValue = ""
            ddlAmountType2.SelectedValue = ""
            txtAmount2.Text = ""
            ddlPriority2.SelectedValue = ""
            txtBankName3.Text = ""
            txtRoutingNumber3.Text = ""
            txtRoutingNumberVerify3.Text = ""
            txtAccountNumber3.Text = ""
            txtAccountNumberVerify3.Text = ""
            ddlAccountType3.SelectedValue = ""
            ddlAmountType3.SelectedValue = ""
            txtAmount3.Text = ""
            ddlPriority3.SelectedValue = ""
            txtBankName4.Text = ""
            txtRoutingNumber4.Text = ""
            txtRoutingNumberVerify4.Text = ""
            txtAccountNumber4.Text = ""
            txtAccountNumberVerify4.Text = ""
            ddlAccountType4.SelectedValue = ""
            ddlAmountType4.SelectedValue = ""
            txtAmount4.Text = ""
            ddlPriority4.SelectedValue = ""

            txtBankName.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
            txtRoutingNumber.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
            txtRoutingNumberVerify.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
            txtAccountNumber.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
            txtAccountNumberVerify.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
            ddlAccountType.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
            ddlAmountType.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
            txtAmount.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
            ddlPriority.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")

            imgNext.Visible = True
            divSuccess.Visible = True
            divError.Visible = False
            ResetScrollPosition()

        End If
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As ImageClickEventArgs)
        Save()
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

    Protected Sub btnClear_Click(sender As Object, e As ImageClickEventArgs)
        txtBankName.Text = ""
        txtRoutingNumber.Text = ""
        txtRoutingNumberVerify.Text = ""
        txtAccountNumber.Text = ""
        txtAccountNumberVerify.Text = ""
        ddlAccountType.SelectedValue = ""
        ddlAmountType.SelectedValue = ""
        txtAmount.Text = ""
        ddlPriority.SelectedValue = ""
    End Sub

    Protected Sub btnClear2_Click(sender As Object, e As ImageClickEventArgs)
        txtBankName2.Text = ""
        txtRoutingNumber2.Text = ""
        txtRoutingNumberVerify2.Text = ""
        txtAccountNumber2.Text = ""
        txtAccountNumberVerify2.Text = ""
        ddlAccountType2.SelectedValue = ""
        ddlAmountType2.SelectedValue = ""
        txtAmount2.Text = ""
        ddlPriority2.SelectedValue = ""
    End Sub

    Protected Sub btnClear3_Click(sender As Object, e As ImageClickEventArgs)
        txtBankName3.Text = ""
        txtRoutingNumber3.Text = ""
        txtRoutingNumberVerify3.Text = ""
        txtAccountNumber3.Text = ""
        txtAccountNumberVerify3.Text = ""
        ddlAccountType3.SelectedValue = ""
        ddlAmountType3.SelectedValue = ""
        txtAmount3.Text = ""
        ddlPriority3.SelectedValue = ""
    End Sub

    Protected Sub btnClear4_Click(sender As Object, e As ImageClickEventArgs)
        txtBankName4.Text = ""
        txtRoutingNumber4.Text = ""
        txtRoutingNumberVerify4.Text = ""
        txtAccountNumber4.Text = ""
        txtAccountNumberVerify4.Text = ""
        ddlAccountType4.SelectedValue = ""
        ddlAmountType4.SelectedValue = ""
        txtAmount4.Text = ""
        ddlPriority4.SelectedValue = ""
    End Sub
End Class