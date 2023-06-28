Imports System.Data.SqlClient

Public Class EE_W4_IL
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
        strScreenName = "EEW4IL"
        strScreenShortDesc = "IL W-4 Form"

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
        'Get State W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id

            lblSSNDigit1.Text = Mid(ec.SSN, 1, 1)
            lblSSNDigit2.Text = Mid(ec.SSN, 2, 1)
            lblSSNDigit3.Text = Mid(ec.SSN, 3, 1)
            lblSSNDigit4.Text = Mid(ec.SSN, 4, 1)
            lblSSNDigit5.Text = Mid(ec.SSN, 5, 1)
            lblSSNDigit6.Text = Mid(ec.SSN, 6, 1)
            lblSSNDigit7.Text = Mid(ec.SSN, 7, 1)
            lblSSNDigit8.Text = Mid(ec.SSN, 8, 1)
            lblSSNDigit9.Text = Mid(ec.SSN, 9, 1)
            txtTotalAllowance1.Text = ec.W4_Box1
            txtTotalAllowance2.Text = ec.W4_Box2
            txtAdditionalWithholding.Text = ec.AdditionalWithholding

            lblFullName.Text = ec.EmployeeFullName
            lblFullAddress.Text = ec.AddressCombined
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZip.Text = ec.Zip

            chkExempt.Checked = IIf(ec.Exempt = "1", True, False)

            txtSignature.Text = ec.W4_Signature
            txtSignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now, ec.W4_SignatureDate)

            chkNoOne.Checked = IIf(ec.PW_BoxA = "1", True, False)
            chkClaimSpouse.Checked = IIf(ec.PW_BoxB = "1", True, False)
            chk65.Checked = IIf(ec.PW_BoxC = "1", True, False)
            chkBlind.Checked = IIf(ec.PW_BoxD = "1", True, False)
            chkSP65.Checked = IIf(ec.PW_BoxE = "1", True, False)
            chkSPBlind.Checked = IIf(ec.PW_BoxF = "1", True, False)

            txtOne.Text = ec.ID_Box1
            txtTwo.Text = ec.ID_Box2
            txtThree.Text = ec.ID_Box3
            txtFour.Text = ec.ID_Box4
            txtFive.Text = ec.ID_Box5
            txtSix.Text = ec.ID_Box6
            txtSeven.Text = ec.ID_Box7
            txtEight.Text = ec.ID_Box8
            txtNine.Text = ec.ID_Box9

        End If

    End Sub

    Private Sub Save()
        If (txtTotalAllowance1.Text = "" And txtTotalAllowance2.Text = "" And chkExempt.Checked = False) Then
            divError.Visible = True
            divSuccess.Visible = False
            txtTotalAllowance1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtTotalAllowance2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkExempt.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            LabelError.Text = "Please enter into either Line 1 or Line 2 below or check that you are exempt"
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtSignature.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            LabelError.Text = "This form is not valid unless signed"
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If (txtTotalAllowance1.Text <> "" Or txtTotalAllowance2.Text <> "" Or chkExempt.Checked = True) Then
            If Trim(txtSignature.Text) <> "" Then

                txtTotalAllowance1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                txtTotalAllowance2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                chkExempt.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

                btnSave.Visible = False
                imgProcessing.Visible = True

                Dim intTotalAllowance1 As Integer
                Dim intTotalAllowance2 As Integer
                Dim intTotalAllowances As Integer
                intTotalAllowance1 = txtTotalAllowance1.Text
                intTotalAllowance2 = txtTotalAllowance2.Text
                intTotalAllowances = intTotalAllowance1 + intTotalAllowance2

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

                objParam = New SqlParameter("@TotalExemptions", IIf(txtTotalAllowance1.Text <> "" And txtTotalAllowance2.Text <> "", intTotalAllowances,
                                                                        IIf(txtTotalAllowance1.Text <> "", intTotalAllowance1,
                                                                            IIf(txtTotalAllowance2.Text <> "", intTotalAllowance2,
                                                                                ""))))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@Exempt", IIf(chkExempt.Checked = True, 1, 0))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Box1", txtTotalAllowance1.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box2", txtTotalAllowance2.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@PW_BoxA", IIf(chkNoOne.Checked = True, "1", "0"))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxB", IIf(chkClaimSpouse.Checked = True, "1", "0"))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxC", IIf(chk65.Checked = True, "1", "0"))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxD", IIf(chkBlind.Checked = True, "1", "0"))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxE", IIf(chkSP65.Checked = True, "1", "0"))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxF", IIf(chkSPBlind.Checked = True, "1", "0"))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@ID_Box1", txtOne.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box2", txtTwo.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box3", txtThree.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box4", txtFour.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box5", txtFive.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box6", txtSix.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box7", txtSeven.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box8", txtEight.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box9", txtNine.Text)
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

    Protected Sub chkExempt_CheckedChanged(sender As Object, e As EventArgs)
        If chkExempt.Checked = True Then
            txtTotalAllowance1.Text = ""
            txtTotalAllowance2.Text = ""
            txtAdditionalWithholding.Text = "0.00"
        End If
    End Sub
End Class