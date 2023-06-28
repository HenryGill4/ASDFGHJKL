Imports System.Data.SqlClient

Public Class EE_WebConfig
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
        strScreenName = "EEWebConfig"
        strScreenShortDesc = "Employee WebConfig"

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
                Session("ScreenName") = strScreenName
                Session("ScreenShortDesc") = strScreenShortDesc
                Session("ScreenPath") = "../EE_WebConfig.aspx"
                Session("DataComplete") = ScreenConfig.DataComplete
                Session("NextScreen") = "../EE_Profile.aspx"
                Session("TabString") = ScreenConfig.TabString
                Session("ScreenConfigTitle") = ScreenConfig.ScreenConfigTitle
                Session("ScreenConfigText") = ScreenConfig.ScreenConfigText

            End If

            ScreenConfig.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            LiteralTopMenu.Text = ScreenConfig.BuildMenu(Session("Admin"), Session("ScreenPath"))
            LiteralTab.Text = ScreenConfig.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            lblMainArticleTitle.Text = ""
            lblMainArticleText.Text = "Place a checkmark for any web page you want the Employee to access.<br/>  Note that the Company must be assigned to a web page on the Company WebConfig before the employees have that option."

            If lblMainArticleTitle.Text = "" Then
                divTitle.Visible = False
            End If

            PopulateFields()

        End If

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateFields()
        ec.getEEWebConfig(intCompanyId, intEmployeeId, Session("UserId"), grdEEWebConfig)

    End Sub

    Protected Sub chkAssigned_CheckedChanged(sender As Object, e As EventArgs)
        Try
            Dim cb As CheckBox = DirectCast(sender, CheckBox)
            Dim gr As GridViewRow = CType(cb.NamingContainer, GridViewRow)

            Dim gv As GridView = gr.NamingContainer

            Dim keys As DataKey = gv.DataKeys(gr.DataItemIndex)
            Dim CompanyId As Object = keys("CompanyId")
            Dim EmployeeId As Object = keys("EmployeeId")
            Dim ScreenId As Object = keys("ScreenId")
            Dim IsAssigned As Object = keys("IsAssigned")

            'Save New WebConfig Info 
            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()

            objParam = New SqlParameter("@CompanyId", CompanyId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EmployeeId", EmployeeId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ScreenId", ScreenId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@IsAssigned", cb.Checked)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@UserId", Session("UserId"))
            aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("usp_Employee_WebConfig_Edit", aryParams)
            ''''''''''''''''''''''''''''''
            sqlCon.CloseConn()
            aryParams = Nothing
            sqlCon = Nothing

            'divSuccess.Visible = True --Dont want to show a message with every click

            SecClass.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        PopulateFields()
        If ScreenConfig.GetNavigation(Session("UserId"), intEmployeeId, strScreenName, 0) = True Then
            Session("TabString") = ScreenConfig.TabString

            LiteralTab.Text = ScreenConfig.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")

        End If

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Response.AddHeader("REFRESH", "0;URL=" + Session("NextScreen"))
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