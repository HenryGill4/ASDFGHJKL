Imports System.Data.SqlClient

Public Class EE_W4_WV
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
        strScreenName = "EEW4WV"
        strScreenShortDesc = "WV W-4 Form"

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

            lblEmployeeName1.Text = ec.EmployeeFullName
            lblSSNwithDashes.Text = ec.SSNwithDashes
            lblAddress.Text = ec.AddressCombined
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZipCode.Text = ec.Zip

            txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding

            txtSignature.Text = ec.W4_Signature
            txtSignatureDate.Text = Date.Now()

            txtIfSingle.Text = ec.W4_Box1
            txtIfMarriedABC.Text = ec.W4_Box2
            txtNumberOfDependents.Text = ec.W4_Box10
            chkWithheldLower.Text = IIf(ec.W4_Box3 = "1", True, False)

        End If

        If sc.GetNavigation(Session("UserId"), intEmployeeId, Session("ScreenName"), 0) = True Then
            Session("DataComplete") = sc.DataComplete
        End If

        If Session("DataComplete") = "Yes" Then
            imgNext.Visible = True

        Else
            imgNext.Visible = False

        End If

    End Sub

    Private Sub Save()
        'Check for required fields
        If Trim(txtSignature.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "This form is not valid unless signed"
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If txtIfSingle.Text = "" And txtIfMarriedABC.Text = "" And chkWithheldLower.Checked = False Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "Please complete Line 1, 2, or 5 - enter 0 if applicable"
            txtIfSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtIfMarriedABC.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkWithheldLower.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If txtTotalExemptions.Text = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "Please compete Line 4 - enter 0 if applicable"
            txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If divError.Visible = False Then

            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtIfSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtIfMarriedABC.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            chkWithheldLower.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

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

            objParam = New SqlParameter("@TaxFilingStatusId", IIf(txtIfSingle.Text <> "", "1",
                                                                IIf(txtIfMarriedABC.Text <> "", "2",
                                                                    IIf(chkWithheldLower.Checked = True, "7", ""))))
            aryParams.Add(objParam)

            objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@W4_Box1", txtIfSingle.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_Box2", txtIfMarriedABC.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_Box3", IIf(chkWithheldLower.Checked = True, "1", "0"))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_Box10", txtNumberOfDependents.Text)
            aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit", aryParams)
            sqlCon.CloseConn()

            divSuccess.Visible = True

            s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

        End If

        PopulateFields()
        ResetScrollPosition()

    End Sub

    Protected Sub txtIfSingle_TextChanged(sender As Object, e As EventArgs)
        If txtIfSingle.Text <> "" Then
            txtIfMarriedABC.Text = ""
        End If
    End Sub

    Protected Sub txtIfMarriedABC_TextChanged(sender As Object, e As EventArgs)
        If txtIfMarriedABC.Text <> "" Then
            txtIfSingle.Text = ""
        End If
    End Sub

    'Protected Sub txtExempt_TextChanged(sender As Object, e As EventArgs)
    '    If txtExempt.Text <> "" Then
    '        txtIfSingle.Text = ""
    '        txtIfMarriedABC.Text = ""
    '        txtNumberOfDependents.Text = ""
    '        txtTotalExemptions.Text = ""
    '        chkWithheldLower.Checked = False
    '        txtAdditionalWithholding.Text = ""
    '    End If
    'End Sub



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