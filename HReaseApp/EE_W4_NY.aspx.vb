Imports System.Data.SqlClient

Public Class EE_W4_NY
    Inherits System.Web.UI.Page

    ReadOnly s As New Security
    ReadOnly sc As New ScreenConfiguration
    ReadOnly ec As New Employee

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
        strScreenName = "EEW4NY"

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

            PopulateFields()

        End If

        If Session("DataComplete") = "Yes" Then
            DivError.Visible = False
            DivSuccess.Visible = True
        Else
            DivSuccess.Visible = False
        End If

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")
        'btnPrint.Attributes.Add("Onclick", "divPrint();")
    End Sub

    Private Sub PopulateFields()
        'Get State W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id

            lblFName.Text = ec.FirstNameMiddleInitial
            lblLName.Text = ec.LastName
            lblSSNumber.Text = ec.SSNwithDashes
            lblAddress1.Text = ec.Address1
            lblAddress2.Text = ec.Address2
            lblCityVillage.Text = ec.City
            lblState.Text = ec.State
            lblZipCode.Text = ec.Zip

            chkSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            chkMarried.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)
            chkMarriedWithholdHigher.Checked = IIf(ec.TaxFilingStatusId = "3", True, False)

            chkNYResidentYes.Checked = IIf(ec.W4_Box1 = "1", True, False)
            chkNYResidentNo.Checked = IIf(ec.W4_Box1 = "0", True, False)
            chkYonkersYes.Checked = IIf(ec.W4_Box2 = "1", True, False)
            chkYonkersNo.Checked = IIf(ec.W4_Box2 = "0", True, False)

            txtTotalAllowance1.Text = ec.TotalExemptions
            txtTotalAllowance2.Text = IIf(ec.W4_Box4 = "", 0, ec.W4_Box4)
            txtTotalAllowance3.Text = IIf(ec.W4_Box5 = "", 0, ec.W4_Box5)
            txtTotalAllowance4.Text = IIf(ec.W4_Box6 = "", 0, ec.W4_Box6)
            txtTotalAllowance5.Text = IIf(ec.W4_Box7 = "", 0, ec.W4_Box7)

            txtSignature.Text = ec.W4_Signature
            txtSignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now, ec.W4_SignatureDate)

            chkBoxA.Checked = IIf(ec.PW_BoxA = "1", True, False)
            chkBoxB.Checked = IIf(ec.PW_BoxB = "1", True, False)
            chkDHIBYes.Checked = IIf(ec.PW_BoxC = "1", True, False)
            chkDHIBNo.Checked = IIf(ec.PW_BoxC = "0", True, False)
            txtIFchkIsYes.Text = ec.PW_BoxD

            txtBox6.Text = ec.PW_BoxE
            txtBox7.Text = ec.PW_BoxF
            txtBox8.Text = ec.PW_BoxG
            txtBox9.Text = ec.PW_BoxH
            txtBox10.Text = ec.PW_BoxI

            txtBox11.Text = ec.TE_Box1
            txtBox12.Text = ec.TE_Box2
            txtBox13.Text = ec.TE_Box3
            txtBox14.Text = ec.TE_Box4
            txtBox15.Text = ec.TE_Box5
            txtBox16.Text = ec.TE_Box6
            txtBox16a.Text = ec.TE_Box7
            txtBox17.Text = ec.TE_Box8
            txtBox18.Text = ec.TE_Box9
            txtBox19.Text = ec.TE_Box10
            txtBox20.Text = ec.TE_Box11
            txtBox21.Text = ec.TE_Box12
            txtBox22.Text = ec.TE_Box13
            txtBox23.Text = ec.TE_Box14
            txtBox24.Text = ec.TE_Box15

            txtBox25.Text = ec.ID_Box1
            txtBox26.Text = ec.ID_Box2
            txtBox27.Text = ec.ID_Box3
            txtBox28.Text = ec.ID_Box4
            txtBox29.Text = ec.ID_Box5
            txtBox30.Text = ec.ID_Box6
            txtBox31.Text = ec.ID_Box7

            lblOriginalHireDate.Text = ec.OriginalHireDate
            lblEmployerName.Text = ec.CompanyName
            lblEmployerAddress.Text = ec.CompanyAddress1 + " " + IIf(Len(ec.CompanyAddress2) > 0, ec.CompanyAddress2, "")
            lblEmployerCityStateZip.Text = ec.CompanyCity + ", " + ec.CompanyState + " " + ec.CompanyZip
            lblEmployerIDNo.Text = ec.CompanyFEIN
        End If

    End Sub

    Private Sub Save()
        If chkSingle.Checked = False And chkMarried.Checked = False And chkMarriedWithholdHigher.Checked = False Then
            DivError.Visible = True
            DivSuccess.Visible = False
            chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarriedWithholdHigher.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please enter Marital Status"
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtSignature.Text) = "" Then
            DivError.Visible = True
            DivSuccess.Visible = False
            lblError.Text = "This form is not valid unless signed"
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ResetScrollPosition()
            Exit Sub
        End If
        If chkNYResidentYes.Checked = False And chkNYResidentNo.Checked = False Then
            DivError.Visible = True
            DivSuccess.Visible = False
            chkNYResidentYes.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkNYResidentNo.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please answer residency status for New York City"
            ResetScrollPosition()
            Exit Sub
        End If
        If chkYonkersYes.Checked = False And chkYonkersNo.Checked = False Then
            DivError.Visible = True
            DivSuccess.Visible = False
            chkYonkersYes.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkYonkersNo.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please answer residency status for Yonkers"
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtTotalAllowance1.Text) = "" Then
            DivError.Visible = True
            DivSuccess.Visible = False
            lblError.Text = "Enter Total number of allowances you are claiming for New York State and Yonkers - enter 0 if not applicable"
            txtTotalAllowance1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtTotalAllowance2.Text) = "" Then
            DivError.Visible = True
            DivSuccess.Visible = False
            lblError.Text = "Please Enter Total number of allowances for New York City - enter 0 if none"
            txtTotalAllowance2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ResetScrollPosition()
            Exit Sub
        End If

        If (chkSingle.Checked = True Or chkMarried.Checked = True Or chkMarriedWithholdHigher.Checked = True) Then
            If (chkNYResidentYes.Checked = True Or chkNYResidentNo.Checked = True) Then
                If (chkYonkersYes.Checked = True Or chkYonkersNo.Checked = True) Then
                    If Trim(txtTotalAllowance1.Text) <> "" Then
                        If Trim(txtTotalAllowance2.Text) <> "" Then
                            If Trim(txtSignature.Text) <> "" Then

                                btnSave.Visible = False
                                imgProcessing.Visible = True

                                chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                                chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                                chkMarriedWithholdHigher.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                                chkNYResidentYes.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                                chkNYResidentNo.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                                chkYonkersYes.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                                chkYonkersNo.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                                txtTotalAllowance1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                                txtTotalAllowance2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
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
                                                                                    IIf(chkMarried.Checked = True, "2",
                                                                                        IIf(chkMarriedWithholdHigher.Checked = True, "3",
                                                                                            ""))))
                                aryParams.Add(objParam)

                                objParam = New SqlParameter("@W4_Box1", IIf(chkNYResidentYes.Checked = True, "1",
                                                                            IIf(chkNYResidentNo.Checked = True, "0",
                                                                                "")))
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@W4_Box2", IIf(chkYonkersYes.Checked = True, "1",
                                                                           IIf(chkYonkersNo.Checked = True, "0",
                                                                               "")))
                                aryParams.Add(objParam)


                                objParam = New SqlParameter("@TotalExemptions", txtTotalAllowance1.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@W4_Box4", txtTotalAllowance2.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@W4_Box5", txtTotalAllowance3.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@W4_Box6", txtTotalAllowance4.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@W4_Box7", txtTotalAllowance5.Text)
                                aryParams.Add(objParam)

                                objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                                aryParams.Add(objParam)

                                objParam = New SqlParameter("@PW_BoxA", IIf(chkBoxA.Checked = True, "1", "0"))
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@PW_BoxB", IIf(chkBoxB.Checked = True, "1", "01"))
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@PW_BoxC", IIf(chkDHIBYes.Checked = True, "1",
                                                                            IIf(chkDHIBNo.Checked = True, "0",
                                                                                "")))
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@PW_BoxD", txtIFchkIsYes.Text)
                                aryParams.Add(objParam)

                                objParam = New SqlParameter("@PW_BoxE", txtBox6.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@PW_BoxF", txtBox7.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@PW_BoxG", txtBox8.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@PW_BoxH", txtBox9.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@PW_BoxI", txtBox10.Text)
                                aryParams.Add(objParam)

                                objParam = New SqlParameter("@TE_Box1", txtBox11.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@TE_Box2", txtBox12.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@TE_Box3", txtBox13.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@TE_Box4", txtBox14.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@TE_Box5", txtBox15.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@TE_Box6", txtBox16.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@TE_Box7", txtBox16a.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@TE_Box8", txtBox17.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@TE_Box9", txtBox18.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@TE_Box10", txtBox19.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@TE_Box11", txtBox20.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@TE_Box12", txtBox21.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@TE_Box13", txtBox22.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@TE_Box14", txtBox23.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@TE_Box15", txtBox24.Text)
                                aryParams.Add(objParam)

                                objParam = New SqlParameter("@ID_Box1", txtBox25.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@ID_Box2", txtBox26.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@ID_Box3", txtBox27.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@ID_Box4", txtBox28.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@ID_Box5", txtBox29.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@ID_Box6", txtBox30.Text)
                                aryParams.Add(objParam)
                                objParam = New SqlParameter("@ID_Box7", txtBox31.Text)
                                aryParams.Add(objParam)

                                objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit", aryParams)
                                sqlCon.CloseConn()

                                DivError.Visible = False
                                lblError.Text = ""
                                DivSuccess.Visible = True

                                s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

                            End If
                        End If
                    End If
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