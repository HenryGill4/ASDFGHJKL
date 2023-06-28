Imports System.Data.SqlClient

Public Class EE_W4_MD
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
        strScreenName = "EEW4MD"

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

            lblFullName.Text = ec.EmployeeFullName
            lblFullAddress.Text = ec.FullAddress
            lblSSNumber.Text = ec.SSNwithDashes

            chkSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            chkMarried.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)
            chkMarriedSingle.Checked = IIf(ec.TaxFilingStatusId = "3", True, False)

            TextTotalExemptions.Text = ec.TotalExemptions
            TextAdditionalWithholding.Text = ec.AdditionalWithholding
            TextExempt.Text = IIf(ec.Exempt = "1", "EXEMPT", "")

            TextSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now(), ec.W4_SignatureDate)
            ChkA.Checked = IIf(ec.W4_Box1 = "1", True, False)
            ChkB.Checked = IIf(ec.W4_Box2 = "1", True, False)
            TextYear.Text = ec.W4_Box3

            chkFourOne.Checked = IIf(ec.W4_Box4 = "1", True, False)
            chkFourTwo.Checked = IIf(ec.W4_Box5 = "1", True, False)
            chkFourThree.Checked = IIf(ec.W4_Box6 = "1", True, False)

            TextECFourFirst.Text = ec.W4_Box7
            TextECFiveFirst.Text = ec.W4_Box8
            TextECSixFirst.Text = ec.W4_Box9
            TextECSevenFirst.Text = ec.ID_Box1
            TextECEightFirst.Text = ec.ID_Box2
            TextECEightSecond.Text = ec.ID_Box3

            TextEWOneFirst.Text = ec.TE_Box1
            TextEWTwoFirst.Text = ec.TE_Box2
            TextEWThreeFirst.Text = ec.TE_Box3
            TextEWFourFirst.Text = ec.TE_Box4
            TextEWFiveFirst.Text = ec.TE_Box5

            TextCounty.Text = ec.PW_BoxA

            lblEmployerName.Text = ec.CompanyName
            lblEmployerFullAddress.Text = ec.CompanyAddress1 + " " + IIf(Len(ec.CompanyAddress2) > 0, ec.CompanyAddress2, "") + ec.CompanyCity + ", " + ec.CompanyState + " " + ec.CompanyZip
            lblEmployerFEIN.Text = ec.CompanyFEIN

        End If

    End Sub

    Private Sub Save()
        'Check for required fields
        If chkSingle.Checked = False And chkMarried.Checked = False And chkMarriedSingle.Checked = False Then
            DivError.Visible = True
            chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarriedSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            LabelError.Text = "Please Enter Filing Status."
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(TextTotalExemptions.Text) = "" Then
            DivError.Visible = True
            DivSuccess.Visible = False
            TextTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            LabelError.Text = "Please Enter Total Exemptions - enter 0 if none or if using Additional Withholding or if you are Exempt"
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(TextSignature.Text) = "" Then
            DivError.Visible = True
            LabelError.Text = "This form is not valid unless signed"
            TextSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If (chkSingle.Checked = True Or chkMarried.Checked = True Or chkMarriedSingle.Checked = True) Then
            If Trim(TextTotalExemptions.Text) <> "" Then
                If Trim(TextSignature.Text) <> "" Then

                    DivError.Visible = False

                    chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarriedSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    TextTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    TextSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")


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
                                                                            IIf(chkMarriedSingle.Checked = True, "3", ""))))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TotalExemptions", TextTotalExemptions.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@AdditionalWithholding", TextAdditionalWithholding.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@Exempt", IIf(TextExempt.Text = "EXEMPT", 1, 0))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", TextSignature.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                    aryParams.Add(objParam)


                    objParam = New SqlParameter("@W4_Box1", IIf(ChkA.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box2", IIf(ChkB.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box3", TextYear.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box4", IIf(chkFourOne.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box5", IIf(chkFourTwo.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box6", IIf(chkFourThree.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box7", TextECFourFirst.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box8", TextECFiveFirst.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box9", TextECSixFirst.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box1", TextECSevenFirst.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box2", TextECEightFirst.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box3", TextECEightSecond.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TE_Box1", TextEWOneFirst.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box2", TextEWTwoFirst.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box3", TextEWThreeFirst.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box4", TextEWFourFirst.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box5", TextEWFiveFirst.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@PW_BoxA", TextCounty.Text)
                    aryParams.Add(objParam)

                    objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit", aryParams)
                    sqlCon.CloseConn()

                    DivSuccess.Visible = True

                    s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

                End If
            End If
        End If

        PopulateFields()
        ResetScrollPosition()

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