﻿Imports System.Data.SqlClient

Public Class VMMessage
    Inherits System.Web.UI.Page

    ReadOnly s As New Security
    ReadOnly sc As New ScreenConfiguration
    ReadOnly ec As New Employee

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer
    Dim intUserId As Integer

    Dim strScreenName As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("VMLogin.aspx")
        End If

        intUserId = Session("UserId")

        'Change these on each page
        strScreenName = "VMMessage"

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
            'LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            sc.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            MainArticleTitleLabel.Text = sc.MainArticleTitle
            MainArticleTextLabel.Text = sc.MainArticleText

            If MainArticleTextLabel.Text = "" Then
                TextDiv.Visible = False
            End If

            PopulateFields()

        End If

        If Session("DataComplete") = "Yes" Then
            SuccessSectionDiv.Visible = True
        Else
            SuccessSectionDiv.Visible = False

        End If

        AcceptButton.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(AcceptButton, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateFields()
        If ec.GetEmployeeFormResponses(intCompanyId, intEmployeeId, Session("ScreenName")) = True Then
            SignatureText.Text = ec.FormSignature
            SignatureDateText.Text = IIf(ec.SignatureDate = "1/1/1900", Date.Now(), ec.SignatureDate)

        End If

    End Sub

    Private Sub Save()

        If SignatureText.Text = "" Then
            ErrorDiv.Visible = True
            SuccessSectionDiv.Visible = False
            ErrorLabel.Text = "You must enter a Signature to complete this form"
            SignatureText.BackColor = System.Drawing.ColorTranslator.FromHtml("#F9F9F9")
            Session("DataComplete") = "No"
            Exit Sub
        End If

        If Trim(SignatureDateText.Text) = "" Then
            ErrorDiv.Visible = True
            SuccessSectionDiv.Visible = False
            ErrorLabel.Text = "You must enter the Date to complete this form"
            SignatureDateText.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            SignatureDateText.Attributes.Add("class", "HRETextboxError")
            Session("DataComplete") = "No"
            Exit Sub
        End If

        If SignatureText.Text <> "" And Trim(SignatureDateText.Text) <> "" Then
            SignatureText.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            SignatureDateText.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()

            Try

                objParam = New SqlParameter("@CompanyId", intCompanyId)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@EmployeeId", intEmployeeId)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@UserId", intUserId)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ScreenName", Session("ScreenName"))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@FormSignature", SignatureText.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@SignatureDate", SignatureDateText.Text)
                aryParams.Add(objParam)

                objDataSet = sqlCon.CreateDataSet("usp_Employee_Form_Response_Edit", aryParams)
                sqlCon.CloseConn()

                s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

                SuccessSectionDiv.Visible = True
                ErrorDiv.Visible = False
                Session("DataComplete") = "Yes"

                ResetScrollPosition()
            Finally
                If (Not (objDataSet Is Nothing)) Then
                    objDataSet.Dispose()
                End If
            End Try
        End If


    End Sub

    Protected Sub AcceptButton_Click(sender As Object, e As ImageClickEventArgs)
        Save()
        ResetScrollPosition()
        Session("NextScreen") = "VMQandA.aspx"
        Response.AddHeader("REFRESH", "2;URL=" + Session("NextScreen"))
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
