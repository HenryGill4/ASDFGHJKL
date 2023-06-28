Imports System.Data
Imports System.Data.SqlClient

Public Class ContactUs
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'this is a little itty bitty test
    End Sub
    Protected Sub contact_submit_Click(sender As Object, e As EventArgs)

        divSuccess.Visible = False
        divError.Visible = False


        'Validation
        If ddlHowdidyouhear.SelectedIndex = -1 Or ddlHowdidyouhear.SelectedIndex = 0 Then
            lblError.Text = "<h4>Please let us know how you heard about us</h4>"
            lblError.Visible = True
            divError.Visible = True
            Exit Sub
        End If

        Dim sMessageBody As String
        'string together message
        sMessageBody = "Demo Request from website <br/> "
        sMessageBody = sMessageBody + "Name:  " + txtFullName.Text + "<br/> "
        sMessageBody = sMessageBody + "Email:  " + txtcontact_Email.Text + "<br/> "
        sMessageBody = sMessageBody + "Phone:  " + txtcontact_phone.Text + "<br/> <br/>"
        sMessageBody = sMessageBody + "How they heard about us:  " + ddlHowdidyouhear.SelectedValue + "<br/> "




        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        objParam = New SqlParameter("@Subject", "Demo Request")
        aryParams.Add(objParam)
        objParam = New SqlParameter("@MailBody", sMessageBody)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@From", txtcontact_Email.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@To", "skgill@hrease.com")
        aryParams.Add(objParam)

        txtCompanyName.Text = ""
        txtcontact_Email.Text = ""
        txtcontact_phone.Text = ""
        txtFullName.Text = ""
        ddlHowdidyouhear.SelectedValue = 0


        objDataSet = sqlCon.CreateDataSet("[usp_Email]", aryParams)
        sqlCon.CloseConn()

        divSuccess.Visible = True
    End Sub
End Class