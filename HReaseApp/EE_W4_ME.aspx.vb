Imports System.Data.SqlClient

Public Class EE_W4_ME
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
        strScreenName = "EEW4ME"
        strScreenShortDesc = "ME W-4 Form"

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
            imgNext.Visible = False

            PopulateFields()

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

            lblFirstName.Text = ec.FirstName
            'lblMiddleInit.Text = ec.MiddleInitial
            lblLastName.Text = ec.LastName
            lblSSNumber.Text = ec.SSNwithDashes
            lblAddressCombined.Text = ec.AddressCombined
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZipCode.Text = ec.Zip

            chkSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            chkMarried.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)
            chkMarriedWithhold.Checked = IIf(ec.TaxFilingStatusId = "3", True, False)

            txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding

            txtSignature.Text = ec.W4_Signature
            txtSignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now, ec.W4_SignatureDate)

            chk6a.Checked = IIf(ec.W4_Box1 = "1", True, False)
            chk6b.Checked = IIf(ec.W4_Box2 = "1", True, False)
            chk6c.Checked = IIf(ec.W4_Box3 = "1", True, False)
            chk6d.Checked = IIf(ec.W4_Box4 = "1", True, False)

            txtWorksheetA.Text = ec.PW_BoxA
            txtWorksheetB.Text = ec.PW_BoxB
            txtWorksheetC.Text = ec.PW_BoxC
            txtWorksheetD.Text = ec.PW_BoxD
            txtWorksheetE.Text = ec.PW_BoxE

            lblEmployerFullName.Text = ec.CompanyName
            lblEmployerFullAddress.Text = ec.CompanyAddress1 + " " + IIf(Len(ec.CompanyAddress2) > 0, ec.CompanyAddress2, "") + " " + ec.CompanyCity + ", " + ec.CompanyState + " " + ec.CompanyZip
            lblIdentificationNo.Text = ec.CompanyFEIN
            lblContact.Text = ""

        End If


    End Sub

    Private Sub Save()
        If chkSingle.Checked = False And chkMarried.Checked = False And chkMarriedWithhold.Checked = False Then
            divError.Visible = True
            chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarriedWithhold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please Enter a Filing Status"
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtTotalExemptions.Text) = "" And chk6a.Checked = False And chk6b.Checked = False And chk6c.Checked = False And chk6d.Checked = False And chkMilitarySpouseRelief.Checked = False Then
            divError.Visible = True
            lblError.Text = "Please Enter amount to Line 4. 0 if exempt or claiming 0"
            txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtSignature.Text) = "" Then
            divError.Visible = True
            lblError.Text = "This form is not valid unless signed"
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If

        If (chkSingle.Checked = True Or chkMarried.Checked = True Or chkMarriedWithhold.Checked = True) Then
            If Trim(txtTotalExemptions.Text) <> "" Or chk6a.Checked = True Or chk6b.Checked = True Or chk6c.Checked = True Or chk6d.Checked = True Or chkMilitarySpouseRelief.Checked = True Then
                If Trim(txtSignature.Text) <> "" Then

                    chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarriedWithhold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

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
                                                                          IIf(chkMarried.Checked = True, "2",
                                                                              IIf(chkMarriedWithhold.Checked = True, "3", ""))))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@Exempt", IIf(chk6a.Checked = True Or chk6b.Checked = True Or chk6c.Checked = True Or chk6d.Checked = True, 1, 0))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@MilitarySpouseRelief", IIf(chkMilitarySpouseRelief.Checked = True, 1, 0))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Box1", IIf(chk6a.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box2", IIf(chk6b.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box3", IIf(chk6c.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box4", IIf(chk6d.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box5", IIf(chkMilitarySpouseRelief.Checked = True, "1", "0"))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@PW_BoxA", txtWorksheetA.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxB", txtWorksheetB.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxC", txtWorksheetC.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxD", txtWorksheetD.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxE", txtWorksheetE.Text)
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
            chkMarried.Checked = False
            chkMarriedWithhold.Checked = False
        End If
    End Sub

    Protected Sub chkMarried_CheckedChanged(sender As Object, e As EventArgs)
        If chkMarried.Checked = True Then
            chkMarriedWithhold.Checked = False
            chkSingle.Checked = False
        End If
    End Sub

    Protected Sub chkMarriedWithhold_CheckedChanged(sender As Object, e As EventArgs)
        If chkMarriedWithhold.Checked = True Then
            chkMarried.Checked = False
            chkSingle.Checked = False
        End If
    End Sub

    Protected Sub chk6a_CheckedChanged(sender As Object, e As EventArgs)
        If chk6a.Checked = True Then
            txtTotalExemptions.Text = "0"
            txtAdditionalWithholding.Text = "0"
        End If
    End Sub

    Protected Sub chk6b_CheckedChanged(sender As Object, e As EventArgs)
        If chk6b.Checked = True Then
            txtTotalExemptions.Text = "0"
            txtAdditionalWithholding.Text = "0"
        End If
    End Sub

    Protected Sub chk6c_CheckedChanged(sender As Object, e As EventArgs)
        If chk6c.Checked = True Then
            txtTotalExemptions.Text = "0"
            txtAdditionalWithholding.Text = "0"
        End If
    End Sub

    Protected Sub chk6d_CheckedChanged(sender As Object, e As EventArgs)
        If chk6d.Checked = True Then
            txtTotalExemptions.Text = "0"
            txtAdditionalWithholding.Text = "0"
        End If
    End Sub

    Protected Sub chkMilitarySpouseRelief_CheckedChanged(sender As Object, e As EventArgs)
        If chkMilitarySpouseRelief.Checked = True Then
            txtTotalExemptions.Text = "0"
            txtAdditionalWithholding.Text = "0"
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