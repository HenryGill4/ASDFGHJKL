﻿Imports System.Data.SqlClient

Public Class EE_Onboarding_Accept
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee
    Dim p As New Plans

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer

    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Dim intUserId As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EEOnboardingAccept"
        strScreenShortDesc = "Onboarding Acceptance"

        intUserId = Session("UserId")

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

            SetProgressBar()
            PopulateFields()

        End If

        If Session("DataComplete") = "Yes" Then
            If txtSignature.Text <> "" And txtSignatureDate.Text <> "" Then
                divError.Visible = False
                divSuccess.Visible = True
                divMainArticalTitleandText.Visible = True
                divSignatureAndDate.Visible = True
                divCol2.Visible = False
            Else
                divError.Visible = False
                divMainArticalTitleandText.Visible = True
                divSignatureAndDate.Visible = True
                divProgressBarSection.Visible = True
                divCol2.Visible = False
            End If
        Else
            divSuccess.Visible = False
            divTitle.Visible = False
            divSignatureAndDate.Visible = False
            divCol2.Visible = True

        End If

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub SetProgressBar()
        If ec.GetEmployeeEventInfo(intEmployeeId, Session("UserId"), 0, intCompanyId) = True Then

            'progress bar
            Dim PercentageComplete As Integer
            Dim widthset As String

            PercentageComplete = ec.EEPercentComplete
            widthset = PercentageComplete.ToString + "%"
            divProgressBar.Attributes.Add("aria-valuenow", PercentageComplete.ToString)
            divProgressBar.Style.Add("width", widthset)
            lblProgress.Text = PercentageComplete.ToString + "%"

            ec.getEmployeeOnboardingProgress(intEmployeeId, "EEWelcome", grdOnboardingProgress)

        End If

        Dim gettinghere As String
        gettinghere = ""

    End Sub

    Protected Sub grdSummary_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdOnboardingProgress.RowDataBound
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim keys As DataKey = grdOnboardingProgress.DataKeys(e.Row.RowIndex)
            Dim StepComplete As Object = keys("StepComplete")
            Dim StepDescription As Object = keys("StepDescription")

            If StepComplete = "0" And InStr(StepDescription, "Registration") = 0 And InStr(StepDescription, "Accept") = 0 And InStr(StepDescription, "Document") = 0 Then
                e.Row.ForeColor = System.Drawing.Color.Red
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
                Session("DataComplete") = "No"
            ElseIf StepComplete = "1" Then
                e.Row.ForeColor = System.Drawing.Color.Navy
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f0")
            Else
                e.Row.ForeColor = System.Drawing.Color.Silver
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFF")
            End If
        End If

        If Session("DataComplete") = "No" Then
            divError.Visible = True
            lblError.Text = "Please address any missing forms or information which are highlighted in red below"
            divMainArticalTitleandText.Visible = False
            divSignatureAndDate.Visible = False
            divCol1 = divCol2
        End If

    End Sub

    Private Sub PopulateFields()
        If ec.GetEmployeeFormResponses(intCompanyId, intEmployeeId, Session("ScreenName")) = True Then
            txtSignature.Text = ec.FormSignature
            txtSignatureDate.Text = IIf(ec.SignatureDate = "1/1/1900", Date.Now(), ec.SignatureDate)
        End If

    End Sub

    Private Sub Save()

        'Check for required fields
        If txtSignature.Text = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "You must enter a Signature to complete this form"
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If

        If Trim(txtSignatureDate.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "You must enter the Date to complete this form"
            txtSignatureDate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If

        If txtSignature.Text <> "" And Trim(txtSignatureDate.Text) <> "" Then
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtSignatureDate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

            imgProcessing.Visible = True

            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()

            objParam = New SqlParameter("@CompanyId", intCompanyId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EmployeeId", intEmployeeId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ScreenName", Session("ScreenName"))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@FormSignature", txtSignature.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@SignatureDate", txtSignatureDate.Text)
            aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("usp_Employee_Form_Response_Edit", aryParams)
            sqlCon.CloseConn()

            divSuccess.Visible = True

            divSuccess.Visible = True
            divError.Visible = False
            imgNext.Visible = True

            s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

        End If

        PopulateFields()
        ResetScrollPosition()

        imgProcessing.Visible = False

    End Sub

    Protected Sub btnAccept_Click(sender As Object, e As ImageClickEventArgs) Handles btnAccept.Click
        btnAccept.Visible = False
        Save()
        btnAccept.Visible = True
    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Save()

        Response.Redirect(Session("NextScreen"))
    End Sub

    Private Sub ResetScrollPosition()
        If Not ClientScript.IsClientScriptBlockRegistered(Me.GetType(), "CreateResetScrollPosition") Then
            'Create the ResetScrollPosition() function
            ClientScript.RegisterClientScriptBlock(Me.GetType(), "CreateResetScrollPosition",
                             "Function ResetScrollPosition() {" & vbCrLf &
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