Imports System.Data.SqlClient

Public Class EE_W4_SC
    Inherits System.Web.UI.Page

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
        strScreenName = "EEW4SC"

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

            FirstName.Text = ec.FirstName
            MiddleInitial.Text = ec.MiddleInitial
            LastName.Text = ec.LastName
            SSNumber.Text = ec.SSNwithDashes
            AddressCombined.Text = ec.AddressCombined
            City.Text = ec.City
            State.Text = ec.State
            ZipCode.Text = ec.Zip

            SingleCheckbox.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            MarriedCheckbox.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)
            MarriedWithholdCheckbox.Checked = IIf(ec.TaxFilingStatusId = "3", True, False)

            TotalExemptions.Text = ec.TotalExemptions
            AdditionalWithholding.Text = ec.AdditionalWithholding

            Signature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now, ec.W4_SignatureDate)

            SSNNameDiffCheckbox.Checked = IIf(ec.W4_Box1 = "1", True, False)
            ExemptCheckbox.Checked = IIf(ec.Exempt = 1, True, False)
            MilitarySpouseCheckBox.Checked = IIf(ec.MilitarySpouseRelief = 1, True, False)
            MilitaryState.Text = ec.W4_Box2
            Exempt.Text = IIf(ec.Exempt = 1, "Exempt", "")

            PWBoxA.Text = ec.PW_BoxA
            PWBoxB.Text = ec.PW_BoxB
            PWBoxC.Text = ec.PW_BoxC
            PWBoxD.Text = ec.PW_BoxD
            PWBoxE.Text = ec.PW_BoxE
            PWBoxF.Text = ec.PW_BoxF
            PWBoxG.Text = ec.PW_BoxG

            TEBox1.Text = ec.TE_Box1
            TEBox2.Text = ec.TE_Box2
            TEBox3.Text = ec.TE_Box3
            TEBox4.Text = ec.TE_Box4
            TEBox5.Text = ec.TE_Box5
            TEBox6.Text = ec.TE_Box6
            TEBox7.Text = ec.TE_Box7
            TEBox8.Text = ec.TE_Box8
            TEBox9.Text = ec.TE_Box9
            TEBox10.Text = ec.TE_Box10

            EmployerName.Text = ec.CompanyName
            EmployerAddress.Text = ec.CompanyAddress1 + " " + IIf(Len(ec.CompanyAddress2) > 0, ec.CompanyAddress2, "") + " " + ec.CompanyCity + ", " + ec.CompanyState + " " + ec.CompanyZip
            HireDate.Text = IIf(ec.LatestRehireDate <> "", ec.LatestRehireDate, ec.OriginalHireDate)
            EmployerFEIN.Text = ec.CompanyFEIN

        End If

    End Sub

    Private Sub Save()
        If SingleCheckbox.Checked = False And MarriedCheckbox.Checked = False And MarriedWithholdCheckbox.Checked = False And ExemptCheckbox.Checked = False Then
            divError.Visible = True
            SingleCheckbox.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            MarriedCheckbox.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            MarriedWithholdCheckbox.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please Enter a Filing Status"
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(TotalExemptions.Text) = "" And ExemptCheckbox.Checked = False Then
            divError.Visible = True
            lblError.Text = "Please Enter amount to Line 4. 0 if exempt or claiming 0"
            TotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(Signature.Text) = "" Then
            divError.Visible = True
            lblError.Text = "This form is not valid unless signed"
            Signature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If

        If (SingleCheckbox.Checked = True Or MarriedCheckbox.Checked = True Or MarriedWithholdCheckbox.Checked = True Or ExemptCheckbox.Checked = True) Then
            If Trim(TotalExemptions.Text) <> "" Then
                If Trim(Signature.Text) <> "" Then

                    SingleCheckbox.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    MarriedCheckbox.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    MarriedWithholdCheckbox.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    TotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    Signature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

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

                    objParam = New SqlParameter("@TaxFilingStatusId", IIf(SingleCheckbox.Checked = True, "1",
                                                                          IIf(MarriedCheckbox.Checked = True, "2",
                                                                              IIf(MarriedWithholdCheckbox.Checked = True, "3", ""))))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TotalExemptions", TotalExemptions.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@AdditionalWithholding", AdditionalWithholding.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@Exempt", IIf(ExemptCheckbox.Checked = True, 1, 0))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@MilitarySpouseRelief", IIf(MilitarySpouseCheckBox.Checked = True, 1, 0))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", Signature.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Box1", IIf(SSNNameDiffCheckbox.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box2", MilitaryState.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@PW_BoxA", PWBoxA.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxB", PWBoxB.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxC", PWBoxC.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxD", PWBoxD.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxE", PWBoxE.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxF", PWBoxF.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxG", PWBoxG.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TE_Box1", TEBox1.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box2", TEBox2.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box3", TEBox1.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box4", TEBox4.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box5", TEBox5.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box6", TEBox6.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box7", TEBox7.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box8", TEBox8.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box9", TEBox9.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box10", TEBox10.Text)
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

    Protected Sub Exempt_TextChanged(sender As Object, e As EventArgs)

    End Sub

    Protected Sub SingleCheckbox_CheckedChanged(sender As Object, e As EventArgs)
        If SingleCheckbox.Checked = True Then
            MarriedCheckbox.Checked = False
            MarriedWithholdCheckbox.Checked = False
        End If
    End Sub

    Protected Sub MarriedCheckbox_CheckedChanged(sender As Object, e As EventArgs)
        If MarriedCheckbox.Checked = True Then
            MarriedWithholdCheckbox.Checked = False
            SingleCheckbox.Checked = False
        End If
    End Sub

    Protected Sub MarriedWithholdCheckbox_CheckedChanged(sender As Object, e As EventArgs)
        If MarriedWithholdCheckbox.Checked = True Then
            MarriedCheckbox.Checked = False
            SingleCheckbox.Checked = False
        End If
    End Sub

    Protected Sub ExemptCheckbox_CheckedChanged(sender As Object, e As EventArgs)
        If ExemptCheckbox.Checked = True Then
            TotalExemptions.Text = "0"
            AdditionalWithholding.Text = "0"
            Exempt.Text = "EXEMPT"
        ElseIf ExemptCheckbox.Checked = False Then
            Exempt.Text = ""
        End If
    End Sub

    Protected Sub MilitarySpouseCheckBox_CheckedChanged(sender As Object, e As EventArgs)
        If MilitarySpouseCheckBox.Checked = True Then
            TotalExemptions.Text = "0"
            AdditionalWithholding.Text = "0"
            Exempt.Text = "EXEMPT"
            ExemptCheckbox.Checked = True
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
