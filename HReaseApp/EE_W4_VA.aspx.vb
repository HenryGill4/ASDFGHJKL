﻿Imports System.Data.SqlClient

Public Class EE_W4_VA
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim SecClass As New Security
    Dim ScreenConfig As New ScreenConfiguration
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
        strScreenName = "EEW4VA"
        strScreenShortDesc = "VA W-4 Form"

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
            SecClass.SaveUserUpdate(Session("UserId"), strScreenName, "Browse", intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

            If ScreenConfig.GetNavigation(Session("UserId"), intEmployeeId, strScreenName, 0) = True Then
                Session("ScreenName") = ScreenConfig.ScreenName
                Session("ScreenShortDesc") = ScreenConfig.ScreenShortDesc
                Session("ScreenPath") = ScreenConfig.ScreenPath
                Session("DataComplete") = ScreenConfig.DataComplete
                Session("NextScreen") = ScreenConfig.NextScreen
                Session("TabString") = ScreenConfig.TabString
                Session("ScreenConfigTitle") = ScreenConfig.ScreenConfigTitle
                Session("ScreenConfigText") = ScreenConfig.ScreenConfigText

            End If



            LiteralTopMenu.Text = ScreenConfig.BuildMenu(Session("Admin"), Session("ScreenPath"))
            LiteralTab.Text = ScreenConfig.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            ScreenConfig.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            'lblMainArticleTitle.Text = ScreenConfig.MainArticleTitle
            'lblMainArticleText.Text = IIf(ScreenConfig.MainArticleText = "", "Please complete form", ScreenConfig.MainArticleText)
            imgNext.Visible = False


            PopulateFields()

        End If

        divError.Visible = False
        divSuccess.Visible = False
        btnSave.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSave, "") + ";this.src='/img/processing.gif';")
        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateFields()
        'Get State W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id
            lblFullName.Text = ec.EmployeeFullName
            lblAddress.Text = ec.AddressCombined
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZipCode.Text = ec.Zip
            lblSSNumber.Text = ec.SSNwithDashes

            txtClaim.Text = ec.PW_BoxA
            txtStatus.Text = ec.PW_BoxB
            txtDependents.Text = ec.PW_BoxC
            txtPersonalExemptions.Text = ec.PW_BoxD
            txtExemptionsForAge.Text = ec.PW_BoxE
            txtExemptionsForAge2.Text = ec.PW_BoxF
            txtExemptionsBlindness.Text = ec.PW_BoxG
            txtExemptionsBlindness2.Text = ec.PW_BoxH
            txtSubTotalExemptions.Text = ec.PW_BoxI
            txtTotalWSExemptions.Text = ec.PW_BoxJ

            txtApplicationLineA.Text = ec.W4_Box1
            txtApplicationLineB.Text = ec.W4_Box2

            txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding

            txtSignature.Text = ec.W4_Signature
            txtSignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now, ec.W4_SignatureDate)

            chkExempt.Checked = IIf(ec.Exempt = "1", True, False)
            chkMilitarySpouse.Checked = IIf(ec.MilitarySpouseRelief = "1", True, False)

        End If

        If ScreenConfig.GetNavigation(Session("UserId"), intEmployeeId, Session("ScreenName"), 0) = True Then
            Session("DataComplete") = ScreenConfig.DataComplete
        End If

        If Session("DataComplete") = "Yes" Then
            imgNext.Visible = True

        Else
            imgNext.Visible = False

        End If

    End Sub

    Private Sub Save()
        'Check for required fields
        If Trim(txtApplicationLineA.Text) = "" And txtApplicationLineB.Text = "" And txtAdditionalWithholding.Text = "" And chkExempt.Checked = False And chkMilitarySpouse.Checked = False Then
            divError.Visible = True
            divSuccess.Visible = False
            txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please Enter Exemptions - enter 0 if none, if using Additional Withholding, or if you are Exempt"
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

        If Trim(txtApplicationLineA.Text) <> "" Or txtApplicationLineB.Text <> "" Or txtAdditionalWithholding.Text <> "" Or chkExempt.Checked = True Or chkMilitarySpouse.Checked = True Then
            If Trim(txtSignature.Text) <> "" Then

                txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
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

                objParam = New SqlParameter("@PW_BoxA", txtClaim.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxB", txtStatus.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxC", txtDependents.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxD", txtPersonalExemptions.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxE", txtExemptionsForAge.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxF", txtExemptionsForAge2.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxG", txtExemptionsBlindness.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxH", txtExemptionsBlindness2.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxI", txtSubTotalExemptions.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxJ", txtTotalWSExemptions.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Box1", txtApplicationLineA.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box2", txtApplicationLineB.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Exempt", IIf(chkExempt.Checked = True, 1, 0))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@MilitarySpouseRelief", IIf(chkMilitarySpouse.Checked = True, 1, 0))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                aryParams.Add(objParam)

                objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit_Dev", aryParams)
                sqlCon.CloseConn()

                divSuccess.Visible = True

                SecClass.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

            End If
        End If

        PopulateFields()
        ResetScrollPosition()

    End Sub

    Protected Sub btnSave_Click(sender As Object, e As ImageClickEventArgs)
        Save()

        'If no errors go to Next Screen in Navigation
        If divError.Visible = True Then
            Exit Sub
        ElseIf imgNext.Visible = True Then
            ResetScrollPosition()
        Else
            Save()
            imgNext.Visible = False

            ResetScrollPosition()
            Response.AddHeader("REFRESH", "0;URL=" + Session("NextScreen"))
        End If

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

    Protected Sub chkExempt_CheckedChanged(sender As Object, e As EventArgs)
        If chkExempt.Checked = True Then
            txtClaim.Text = ""
            txtStatus.Text = ""
            txtDependents.Text = ""
            txtPersonalExemptions.Text = ""
            txtExemptionsForAge.Text = ""
            txtExemptionsForAge2.Text = ""
            txtExemptionsBlindness.Text = ""
            txtExemptionsBlindness2.Text = ""
            txtSubTotalExemptions.Text = ""
            txtTotalWSExemptions.Text = ""
            txtApplicationLineA.Text = ""
            txtApplicationLineB.Text = ""
            txtTotalExemptions.Text = ""
            txtAdditionalWithholding.Text = ""
        End If
    End Sub

    Protected Sub chkMilitarySpouse_CheckedChanged(sender As Object, e As EventArgs)
        If chkMilitarySpouse.Checked = True Then
            txtClaim.Text = ""
            txtStatus.Text = ""
            txtDependents.Text = ""
            txtPersonalExemptions.Text = ""
            txtExemptionsForAge.Text = ""
            txtExemptionsForAge2.Text = ""
            txtExemptionsBlindness.Text = ""
            txtExemptionsBlindness2.Text = ""
            txtSubTotalExemptions.Text = ""
            txtTotalWSExemptions.Text = ""
            txtApplicationLineA.Text = ""
            txtApplicationLineB.Text = ""
            txtTotalExemptions.Text = ""
            txtAdditionalWithholding.Text = ""
            chkExempt.Checked = True
        End If
    End Sub

    Protected Sub txtExemptionsBlindness_TextChanged(sender As Object, e As EventArgs) Handles txtExemptionsBlindness.TextChanged

    End Sub
End Class