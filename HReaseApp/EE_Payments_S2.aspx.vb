Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
'Imports System.Windows.Forms
Imports System.Web.UI
Imports System.Web.UI.WebControls


Public Class EE_Payments_S2
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            form3.Action = CStr(Session("formUrl"))

            'Server.Transfer(form3.Action)
        End If
    End Sub

    'Private Sub submitStepTwo_Click(sender As Object, e As EventArgs) Handles submitStepTwo.Click
    '    Server.Transfer(CStr(Session("formUrl")))
    'End Sub
End Class