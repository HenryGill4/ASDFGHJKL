Imports System.Data.SqlClient

Public Class Admin_CompanyScreenConfig
    Inherits System.Web.UI.Page
    Dim s As New Security
    Dim c As New Company
    Dim sc As New ScreenConfiguration
    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Dim intCompanyId As Integer
    Dim intUserId As Integer
    Dim bresult As Boolean
    Dim intScreenConfigCoId As Integer

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
        strScreenName = "ScreenConfig"
        strScreenShortDesc = "Company Screen Config"

        If Page.IsPostBack = False Then
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_CompanyScreenConfig")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), 0, "Admin_CompanyScreenConfig", Session("Athena"))

            PopulateCompanyInfo()
            FillScreenConfig()

            s.SaveUserBrowse(Session("UserId"), strScreenName, "Browsed on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString)

        End If

        intCompanyId = Session("ShadowCompanyId")

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

    Private Sub FillScreenConfig()
        bresult = c.getCompanyScreenConfig(Session("ShadowCompanyId"), Session("UserId"), grdScreenConfig)

    End Sub

#Region "GridView stuff"
    Protected Sub grdScreenConfig_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdScreenConfig.RowDataBound

        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)
        Dim imgArrow As Image = DirectCast(e.Row.FindControl("imgArrow"), Image)
        Dim lnkEdit As LinkButton = DirectCast(e.Row.FindControl("lnkEdit"), LinkButton)
        Dim lblParent As Label = DirectCast(e.Row.FindControl("lblParent"), Label)

        Dim rowcolor = Drawing.ColorTranslator.FromHtml("#EFF3FB")

        If e.Row.RowType = DataControlRowType.DataRow Then
            ' Dim btnView As LinkButton = e.Row.Cells(4).Controls(0)
            Dim btnShow As ImageButton = DirectCast(e.Row.Cells(8).Controls(0), ImageButton)
            Dim btnHide As ImageButton = DirectCast(e.Row.Cells(9).Controls(0), ImageButton)

            Dim pnlReviewContent As Panel = DirectCast(e.Row.FindControl("pnlReviewContent"), Panel)
            Dim pnlEditContent As Panel = DirectCast(e.Row.FindControl("pnlEditContent"), Panel)

            Dim intScreenId = drview("ScreenId")
            Dim intScreenContentid = drview("ScreenConfigBlockId")
            Dim intScreenConfigCoId = drview("CompanyId")
            Dim intBlockId = drview("BlockId")

            'EDIT MODE
            If (e.Row.RowState And DataControlRowState.Edit) > 0 Then
                e.Row.BackColor = rowcolor
                btnShow.Visible = False
                btnHide.Visible = False
                pnlEditContent.Visible = True
                pnlReviewContent.Visible = False
                Session("BlockId") = intBlockId
                Session("ScreenId") = intScreenId

            Else
                If Session("ScreenId") = intScreenId And Session("BlockId") = intBlockId Then
                        e.Row.BackColor = rowcolor
                        btnShow.Visible = False
                        btnHide.Visible = True
                        pnlEditContent.Visible = False
                        pnlReviewContent.Visible = True

                    Else
                        btnShow.Visible = True
                        btnHide.Visible = False
                        pnlEditContent.Visible = False
                        pnlReviewContent.Visible = False

                    End If


            End If

            End If
    End Sub

    Protected Sub grdScreenConfig_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        Dim rowcolor = Drawing.ColorTranslator.FromHtml("#EFF3FB")
        Dim Normalcolor = Drawing.ColorTranslator.FromHtml("#FFFFFF")
        Dim Altcolor = Drawing.ColorTranslator.FromHtml("#eeeeee")

        If e.CommandName = "View" Then
            Dim i As Int32 = Convert.ToInt32(e.CommandArgument)
            Dim gvRow As GridViewRow = grdScreenConfig.Rows(i)
            Dim gvr As GridViewRow = grdScreenConfig.SelectedRow
            Dim X As Integer
            Dim intScreenConfigBlockId As Integer

            If i <> -1 Then
                Dim intScreenConfigCoId = grdScreenConfig.DataKeys(i).Values("CompanyId")
                Dim intSelectedScreenConfigBlockId = grdScreenConfig.DataKeys(i).Values("ScreenConfigBlockId")
                Dim bIsaParent = grdScreenConfig.DataKeys(i).Values("IsAParentDocument")


                'Then loop thru grid and hide image except for the row selected and fill up Permissions Grid
                For Each gvr In grdScreenConfig.Rows
                    ' Dim imgArrow As Image = DirectCast(gvr.FindControl("imgArrow"), Image)
                    Dim pnlReviewContent As Panel = DirectCast(gvr.FindControl("pnlReviewContent"), Panel)
                    Dim pnlEditContent As Panel = DirectCast(gvr.FindControl("pnlEditContent"), Panel)
                    Dim lblContent As Label = DirectCast(gvr.FindControl("lblContent"), Label)
                    Dim btnShow As ImageButton = DirectCast(gvr.Cells(8).Controls(0), ImageButton)
                    Dim btnHide As ImageButton = DirectCast(gvr.Cells(9).Controls(0), ImageButton)

                    intScreenConfigBlockId = grdScreenConfig.DataKeys(X).Values("ScreenConfigBlockId")
                    If intSelectedScreenConfigBlockId = intScreenConfigBlockId Then
                        Session("ScreenConfigBlockId") = intScreenConfigBlockId
                        grdScreenConfig.Rows(X).BackColor = rowcolor
                        'editor and more button should be hidden
                        pnlEditContent.Visible = False
                        pnlReviewContent.Visible = True
                        btnShow.Visible = False
                        btnHide.Visible = True

                    Else
                        pnlReviewContent.Visible = False
                        pnlEditContent.Visible = False
                        btnShow.Visible = True
                        btnHide.Visible = False

                        If grdScreenConfig.Rows(X).RowState = DataControlRowState.Normal Then
                            grdScreenConfig.Rows(X).BackColor = Normalcolor
                        Else
                            grdScreenConfig.Rows(X).BackColor = Altcolor
                        End If
                    End If
                    X += 1
                Next

            End If

        ElseIf e.CommandName = "Hide" Then
            Dim i As Int32 = Convert.ToInt32(e.CommandArgument)
            Dim gvRow As GridViewRow = grdScreenConfig.Rows(i)
            Dim gvr As GridViewRow = grdScreenConfig.SelectedRow
            Dim X As Integer
            Dim intScreenConfigBlockId As Integer
            If i <> -1 Then
                Dim intScreenConfigCoId = grdScreenConfig.DataKeys(i).Values("CompanyId")
                Dim intSelectedScreenConfigBlockId = grdScreenConfig.DataKeys(i).Values("ScreenConfigBlockId")
                Dim bIsaParent = grdScreenConfig.DataKeys(i).Values("IsAParentDocument")

                'Then loop thru grid and hide image except for the row selected and fill up Permissions Grid
                For Each gvr In grdScreenConfig.Rows
                    Dim pnlReviewContent As Panel = DirectCast(gvr.FindControl("pnlReviewContent"), Panel)
                    Dim pnlEditContent As Panel = DirectCast(gvr.FindControl("pnlEditContent"), Panel)
                    Dim lblContent As Label = DirectCast(gvr.FindControl("lblContent"), Label)
                    Dim btnShow As ImageButton = DirectCast(gvr.Cells(8).Controls(0), ImageButton)
                    Dim btnHide As ImageButton = DirectCast(gvr.Cells(9).Controls(0), ImageButton)

                    intScreenConfigBlockId = grdScreenConfig.DataKeys(X).Values("ScreenConfigBlockId")
                    If intSelectedScreenConfigBlockId = intScreenConfigBlockId Then
                        grdScreenConfig.Rows(X).BackColor = rowcolor
                        pnlEditContent.Visible = False
                        pnlReviewContent.Visible = False
                        btnShow.Visible = True
                        btnHide.Visible = False

                    Else

                        pnlReviewContent.Visible = False
                        pnlEditContent.Visible = False
                        btnShow.Visible = True
                        btnHide.Visible = False

                        If grdScreenConfig.Rows(X).RowState = DataControlRowState.Normal Then
                            grdScreenConfig.Rows(X).BackColor = Normalcolor
                        Else
                            grdScreenConfig.Rows(X).BackColor = Altcolor
                        End If
                    End If

                    X += 1
                Next

            End If

        End If
    End Sub

    Protected Sub grdScreenConfig_RowEditing(sender As Object, e As GridViewEditEventArgs)
        grdScreenConfig.EditIndex = e.NewEditIndex
        FillScreenConfig()
    End Sub

    Protected Sub grdScreenConfig_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        grdScreenConfig.EditIndex = -1
        FillScreenConfig()
    End Sub

    Protected Sub grdScreenConfig_RowUpdating(sender As Object, e As GridViewUpdateEventArgs)
        'write the save/update procedure here
        Dim intScreenConfigCoId = ddlCompany.SelectedValue
        Dim intSelectedContentId = grdScreenConfig.DataKeys(e.RowIndex).Values("BlockId")
        Dim intSelectedScreenId = grdScreenConfig.DataKeys(e.RowIndex).Values("ScreenId")
        Dim txtBD As TextBox = DirectCast(grdScreenConfig.Rows(e.RowIndex).FindControl("txtBeginGrid"), TextBox)
        Dim txtED As TextBox = DirectCast(grdScreenConfig.Rows(e.RowIndex).FindControl("txtEndGrid"), TextBox)
        Dim txtTitle As TextBox = DirectCast(grdScreenConfig.Rows(e.RowIndex).FindControl("txtBlockTitle"), TextBox)
        Dim txtContent As TextBox = DirectCast(grdScreenConfig.Rows(e.RowIndex).FindControl("txtContent"), TextBox)

        Session("BlockId") = intSelectedContentId
        Session("ScreenId") = intSelectedScreenId

        intCompanyId = Session("ShadowCompanyId")

        'Save procedure here
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()
        Try
            objParam = New SqlParameter("@CompanyId", intCompanyId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ScreenId", intSelectedScreenId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ScreenContentId", intSelectedContentId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Title", txtTitle.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Content", txtContent.Text)
            aryParams.Add(objParam)
            If txtBD.Text <> "" Then
                objParam = New SqlParameter("@BeginDate", txtBD.Text)
                aryParams.Add(objParam)
            End If

            If txtED.Text <> "" Then
                objParam = New SqlParameter("@EndDate", txtED.Text)
                aryParams.Add(objParam)
            End If

            sqlCon.ExecuteNonQuery("[usp_ScreenConfig_Edit]", aryParams)
            sqlCon.CloseConn()

            'Save to Transaction Table
            s.SaveUserUpdate(Session("UserId"), strScreenShortDesc, "Saved on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString, 0, 0, 0, "01/01/1900", 0)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try
        grdScreenConfig.EditIndex = -1
        FillScreenConfig()
    End Sub

    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ShadowCompanyId") = ddlCompany.SelectedValue
        intCompanyId = Session("ShadowCompanyId")

        PopulateCompanyInfo()
        FillScreenConfig()

    End Sub

    Protected Sub chkActive_CheckedChanged(sender As Object, e As EventArgs)
        Session("ActiveCompany") = IIf(chkActive.Checked = True, 1, 0)

        Session("ShadowCompanyId") = 0
        intCompanyId = 0

        PopulateCompanyInfo()
        FillScreenConfig()

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Response.Redirect("~/Admin_CompanyWebConfig.aspx")
    End Sub

#End Region

End Class