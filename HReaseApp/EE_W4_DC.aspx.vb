Imports System.Data.SqlClient

Public Class EE_W4_DC
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
        strScreenName = "EEW4DC"

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
        'Go Get Employee W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id

            LblTIN.Text = ec.SSN
            LblFirstName.Text = ec.FirstName
            LblMiddleInitial.Text = ec.MiddleInitial
            LblLastName.Text = ec.LastName
            LblFullAddress.Text = ec.AddressCombined
            LblCity.Text = ec.City
            LblState.Text = ec.State
            LblZipCode.Text = ec.Zip
            LblTaxYear.Text = Now.Year()

            chkSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            chkMarriedFilingJoint.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)
            chkMarriedFilingSeparate.Checked = IIf(ec.TaxFilingStatusId = "3", True, False)
            chkHeadOfHousehold.Checked = IIf(ec.TaxFilingStatusId = "4", True, False)
            chkMarriedFillingSeparateOnSameRtn.Checked = IIf(ec.TaxFilingStatusId = "6", True, False)

            txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalwithholding.Text = ec.AdditionalWithholding
            txtExempt.Text = IIf(ec.Exempt = "1", "EXEMPT", "")

            txtSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now(), ec.W4_SignatureDate)

            txtSecALineI.Text = ec.W4_Box1
            txtSecBLineM.Text = ec.W4_Box2

            chkDomicileYes.Checked = IIf(ec.W4_Box3 = "1", True, False)
            chkDomicileNo.Checked = IIf(ec.W4_Box3 = "0", True, False)
            txtDomicileName.Text = ec.W4_Box4
            chkStudentYes.Checked = IIf(ec.W4_Box5 = "1", True, False)
            chkStudentNo.Checked = IIf(ec.W4_Box5 = "0", True, False)

            txtAllowanceA.Text = ec.TE_Box1
            txtAllowanceB.Text = ec.TE_Box2
            txtAllowanceC.Text = ec.TE_Box3
            txtAllowanceD.Text = ec.TE_Box4
            txtAllowanceE.Text = ec.TE_Box5
            txtAllowanceF.Text = ec.TE_Box6
            txtAllowanceG.Text = ec.TE_Box7
            txtAllowanceH.Text = ec.TE_Box8
            txtAllowanceI.Text = ec.TE_Box9
            txtAllowanceJ.Text = ec.TE_Box10
            txtAllowanceK.Text = ec.TE_Box11
            txtAllowanceL.Text = ec.TE_Box12
            txtAllowanceM.Text = ec.TE_Box13
            txtAllowanceN.Text = ec.TE_Box14
        End If

    End Sub

    Private Sub Save()
        'Check for required fields
        If chkSingle.Checked = False And chkMarriedFilingJoint.Checked = False And chkHeadOfHousehold.Checked = False And chkMarriedFilingSeparate.Checked = False And chkMarriedFillingSeparateOnSameRtn.Checked = False And txtExempt.Text = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarriedFilingJoint.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkHeadOfHousehold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarriedFilingSeparate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarriedFillingSeparateOnSameRtn.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            LblError.Text = "Please enter Line 1 Tax filing Status"
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If
        If (txtTotalExemptions.Text = "" And txtExempt.Text = "") Then
            divError.Visible = True
            divSuccess.Visible = False
            txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtExempt.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            LblError.Text = "Please Enter Total Allowances, Line n on Line 2 or enter EXEMPT into the box at Line 4"
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If Trim(txtSignature.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            LblError.Text = "This form is not valid unless signed"
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            
            ResetScrollPosition()
            Exit Sub
        End If

        If (chkSingle.Checked = True Or chkMarriedFilingJoint.Checked = True Or chkHeadOfHousehold.Checked = True Or chkMarriedFilingSeparate.Checked = True Or chkMarriedFillingSeparateOnSameRtn.Checked = True) Then
            If (txtTotalExemptions.Text <> "" Or txtExempt.Text <> "") Then
                If Trim(txtSignature.Text) <> "" Then

                    chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarriedFilingJoint.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkHeadOfHousehold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarriedFilingSeparate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarriedFillingSeparateOnSameRtn.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtExempt.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

                    btnSave.Visible = False
                    imgProcessing.Visible = True
                    LblError.Text = ""
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
                                                                        IIf(chkMarriedFilingJoint.Checked = True, "2",
                                                                            IIf(chkHeadOfHousehold.Checked = True, "4",
                                                                                IIf(chkMarriedFilingSeparate.Checked = True, "3",
                                                                                    IIf(chkMarriedFillingSeparateOnSameRtn.Checked = True, "6",
                                                                                        ""))))))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalwithholding.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@Exempt", IIf(txtExempt.Text = "EXEMPT", 1, 0))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Box1", txtSecALineI.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box2", txtSecBLineM.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box3", IIf(chkDomicileYes.Checked = True, "1",
                                                                 IIf(chkDomicileNo.Checked = True, "0",
                                                                    "")))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Box4", txtDomicileName.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Box5", IIf(chkStudentYes.Checked = True, "1",
                                                                 IIf(chkStudentNo.Checked = True, "0",
                                                                    "")))
                    aryParams.Add(objParam)


                    objParam = New SqlParameter("@TE_Box1", txtAllowanceA.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box2", txtAllowanceB.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box3", txtAllowanceC.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box4", txtAllowanceD.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box5", txtAllowanceE.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box6", txtAllowanceF.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box7", txtAllowanceG.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box8", txtAllowanceH.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box9", txtAllowanceI.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box10", txtAllowanceJ.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box11", txtAllowanceK.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box12", txtAllowanceL.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box13", txtAllowanceM.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box14", txtAllowanceN.Text)
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

    Protected Sub chkSingle_CheckedChanged(sender As Object, e As EventArgs)
        If chkSingle.Checked = True Then
            chkMarriedFilingJoint.Checked = False
            chkHeadOfHousehold.Checked = False
            chkMarriedFilingSeparate.Checked = False
            chkMarriedFillingSeparateOnSameRtn.Checked = False
        End If
    End Sub
    Protected Sub chkMarriedFilingJoint_CheckedChanged(sender As Object, e As EventArgs)
        If chkMarriedFilingJoint.Checked = True Then
            chkSingle.Checked = False
            chkHeadOfHousehold.Checked = False
            chkMarriedFilingSeparate.Checked = False
            chkMarriedFillingSeparateOnSameRtn.Checked = False
        End If
    End Sub
    Protected Sub chkHeadOfHousehold_CheckedChanged(sender As Object, e As EventArgs)
        If chkHeadOfHousehold.Checked = True Then
            chkSingle.Checked = False
            chkMarriedFilingJoint.Checked = False
            chkMarriedFilingSeparate.Checked = False
            chkMarriedFillingSeparateOnSameRtn.Checked = False
        End If
    End Sub
    Protected Sub chkMarriedFilingSeparate_CheckedChanged(sender As Object, e As EventArgs)
        If chkMarriedFilingSeparate.Checked = True Then
            chkSingle.Checked = False
            chkMarriedFilingJoint.Checked = False
            chkHeadOfHousehold.Checked = False
            chkMarriedFillingSeparateOnSameRtn.Checked = False
        End If
    End Sub
    Protected Sub chkMarriedFillingSeparateOnSameRtn_CheckedChanged(sender As Object, e As EventArgs)
        If chkMarriedFillingSeparateOnSameRtn.Checked = True Then
            chkSingle.Checked = False
            chkMarriedFilingJoint.Checked = False
            chkHeadOfHousehold.Checked = False
            chkMarriedFilingSeparate.Checked = False
        End If
    End Sub
    Protected Sub chkDomicileYes_CheckedChanged(sender As Object, e As EventArgs)
        If chkDomicileYes.Checked = True Then
            chkDomicileNo.Checked = False
        End If
    End Sub
    Protected Sub chkDomicileNo_CheckedChanged(sender As Object, e As EventArgs)
        If chkDomicileNo.Checked = True Then
            chkDomicileYes.Checked = False
        End If
    End Sub
    Protected Sub chkStudentYes_CheckedChanged(sender As Object, e As EventArgs)
        If chkStudentYes.Checked = True Then
            chkStudentNo.Checked = False
        End If
    End Sub
    Protected Sub chkStudentNo_CheckedChanged(sender As Object, e As EventArgs)
        If chkStudentNo.Checked = True Then
            chkStudentYes.Checked = False
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