Imports System.Data.SqlClient

Public Class Admin_CompanyWebConfig
    Inherits System.Web.UI.Page
    Dim s As New Security
    Dim c As New Company
    Dim sc As New ScreenConfiguration
    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Dim intCompanyId As Integer
    Dim intUserId As Integer
    Dim bresult As Boolean

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Remove Shadow info
        'Session.Remove("ShadowCompanyId")
        Session.Remove("ShadowEmployeeId")
        Session.Remove("ShadowEmployeeName")
        Session.Remove("ShadowEmployee")
        Session.Remove("ShadowCompany")

        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "WebConfig"
        strScreenShortDesc = "Company Web Config"

        If Page.IsPostBack = False Then
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_CompanyWebConfig")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), 0, "Admin_CompanyWebConfig", Session("Athena"))

            PopulateCompanyInfo()
            PopulateWebConfigInfo()

            s.SaveUserBrowse(Session("UserId"), strScreenName, "Browsed on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString)

        End If

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateCompanyInfo()

        Session("ActiveCompany") = IIf(chkActive.Checked = True, 1, 0)

        'Fill up Company list based on UserId
        c.LoadCompanyList(Session("UserId"), Session("ShadowCompanyId"), "Consolidated", "", Session("ActiveCompany"), 0, 0, Session("ds"))

        ddlCompany.DataSource = Session("ds").tables(0)
        ddlCompany.DataBind()

        If ddlCompany.Items.Count < 2 Then
            lblCompanyName.Text = ddlCompany.Items(0).Text
            lblCompanyName.Text = lblCompanyName.Text.Replace(" - [Single]", "")
            lblCompanyName.Text = lblCompanyName.Text.Replace(" - [Parent]", "")
            lblCompanyName.Text = lblCompanyName.Text.Replace(" - [Child]", "")
            Session("ShadowCompanyId") = ddlCompany.SelectedValue
            intCompanyId = Session("ShadowCompanyId")
            ddlCompany.Text = ddlCompany.SelectedItem.Text
            If Session("ActiveCompany") = 1 Then
                divCompanyList.Visible = False
            End If
        Else
            divCompanyName.Visible = False
            If Session("ShadowCompanyId") Is Nothing Or Session("ShadowCompanyId") = 0 Then
                ddlCompany.Items.Insert(0, New ListItem("SELECT"))
                ddlCompany.Items(0).Selected = True
                Session("ShadowCompanyId") = 0
                intCompanyId = 0
            ElseIf Session("ShadowCompanyId") <> 0 Then
                ddlCompany.SelectedValue = Session("ShadowCompanyId")
                intCompanyId = Session("ShadowCompanyId")
            Else
                ddlCompany.Items(0).Selected = True
            End If

        End If

    End Sub

    Private Sub PopulateWebConfigInfo()
        c.getCompanyWebConfig(intCompanyId, Session("UserId"), grdWebConfig)

    End Sub

    Protected Sub chkAssigned_CheckedChanged(sender As Object, ByVal e As System.EventArgs)

        Try
            Dim cb As CheckBox = DirectCast(sender, CheckBox)
            Dim gr As GridViewRow = CType(cb.NamingContainer, GridViewRow)

            Dim gv As GridView = gr.NamingContainer

            Dim keys As DataKey = gv.DataKeys(gr.DataItemIndex)
            Dim CompanyId As Object = keys("CompanyId")
            Dim ScreenId As Object = keys("ScreenId")
            Dim CompanyWebConfigId As Object = keys("CompanyWebConfigId")

            intCompanyId = ddlCompany.SelectedValue

            'Save New WebConfig Info 
            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()

            objParam = New SqlParameter("@CompanyId", intCompanyId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ScreenId", ScreenId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@IsAssigned", cb.Checked)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@UserId", Session("UserId"))
            aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("usp_Company_WebConfig_Edit", aryParams)
            ''''''''''''''''''''''''''''''
            sqlCon.CloseConn()
            aryParams = Nothing
            sqlCon = Nothing

            'Save to Transaction Table
            s.SaveUserUpdate(Session("UserId"), strScreenShortDesc, "Saved on " + strScreenShortDesc + " for CompanyId " + intCompanyId.ToString + " Modified ScreenId " + ScreenId.ToString + " to " + cb.Checked.ToString, 0, 0, 0, "01/01/1900", 0)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

    End Sub

    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ShadowCompanyId") = ddlCompany.SelectedValue
        intCompanyId = Session("ShadowCompanyId")

        PopulateCompanyInfo()
        PopulateWebConfigInfo()

    End Sub

    Protected Sub chkActive_CheckedChanged(sender As Object, e As EventArgs)
        Session("ActiveCompany") = IIf(chkActive.Checked = True, 1, 0)

        Session("ShadowCompanyId") = 0
        intCompanyId = 0

        PopulateCompanyInfo()
        PopulateWebConfigInfo()

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Response.Redirect("~/Admin_EEAdd.aspx")
    End Sub

End Class