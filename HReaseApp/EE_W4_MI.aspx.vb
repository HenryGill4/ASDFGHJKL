Imports System.Data.SqlClient

Public Class EE_W4_MI
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
        strScreenName = "EEW4MI"
        strScreenShortDesc = "MI W-4 Form"

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

            lblSSNWithDashes.Text = ec.SSNwithDashes
            lblBirthDate.Text = ec.BirthDate
            lblEmployeeFullName.Text = ec.EmployeeFullName
            lblAddressCombined.Text = ec.AddressCombined
            lblEECity.Text = ec.City
            lblEEState.Text = ec.State
            lblZIP.Text = ec.Zip
            lblHireDate.Text = ec.LatestRehireDate

            txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding

            txt8b.Text = ec.W4_Box1
            txt8c.Text = ec.W4_Box2
            txtDriversLicenseNo.Text = ec.W4_Box3

            txtSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now(), ec.W4_SignatureDate)

            lblEmployerName.Text = ec.CompanyName
            lblEmployerFEIN.Text = ec.CompanyFEIN
            lblEmployerAddress.Text = ec.CompanyAddress1 + " " + IIf(Len(ec.CompanyAddress2) > 0, ec.CompanyAddress2, "")
            lblEmployerCity.Text = ec.CompanyCity
            lblEmployerState.Text = ec.CompanyState
            lblEmployerZip.Text = ec.CompanyZip
            lblAdminName.Text = ec.I9AdminFirstName
            lblAdminPhone.Text = ""

            chkNewEmployeeYes.Checked = IIf(ec.ID_Box1 = "1", True, False)
            chkNewEmployeeNo.Checked = IIf(ec.ID_Box1 = "0", True, False)

            chkExemptA.Checked = IIf(ec.PW_BoxA = "1", True, False)
            chkExemptB.Checked = IIf(ec.PW_BoxB = "1", True, False)
            chkExemptC.Checked = IIf(ec.PW_BoxC = "1", True, False)

            If chkNewEmployeeNo.Checked = True Then
                lblHireDate.Visible = False
            End If

        End If

    End Sub

    Private Sub Save()
        'Check for required fields
        If Trim(txtTotalExemptions.Text) = "" And chkExemptA.Checked = False And chkExemptB.Checked = False And chkExemptC.Checked = False Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "Please Enter amount to Line 6. 0 if exempt or claiming 0"
            txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
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

        If Trim(txtTotalExemptions.Text) <> "" Then
            If Trim(txtSignature.Text) <> "" Then

                txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

                btnSave.Visible = False
                imgProcessing.Visible = True

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

                objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Exempt", IIf(chkExemptA.Checked = True Or chkExemptB.Checked = True Or chkExemptC.Checked = True, "1", "0"))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Box1", txt8b.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box2", txt8c.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box3", txtDriversLicenseNo.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box4", IIf(chkNewEmployeeNo.Checked = True, "", lblHireDate.Text))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxA", IIf(chkExemptA.Checked = True, "1", "0"))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxB", IIf(chkExemptB.Checked = True, "1", "0"))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxC", IIf(chkExemptC.Checked = True, "1", "0"))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@ID_Box1", IIf(chkNewEmployeeYes.Checked = True, "1", "0"))
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

    Protected Sub chkNewEmployeeYes_CheckedChanged(sender As Object, e As EventArgs)
        If chkNewEmployeeYes.Checked = True Then
            chkNewEmployeeNo.Checked = False
            lblHireDate.Visible = True
        Else
            lblHireDate.Visible = False
        End If
    End Sub

    Protected Sub chkNewEmployeeNo_CheckedChanged(sender As Object, e As EventArgs)
        If chkNewEmployeeNo.Checked = True Then
            chkNewEmployeeYes.Checked = False
            lblHireDate.Visible = False
        Else
            lblHireDate.Visible = True
        End If
    End Sub
End Class