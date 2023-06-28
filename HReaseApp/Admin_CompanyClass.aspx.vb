Imports System.Data.SqlClient

Public Class Admin_CompanyClass
    Inherits System.Web.UI.Page
    Dim s As New Security
    Dim c As New Company
    Dim sc As New ScreenConfiguration
    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Dim intCompanyId As Integer
    Dim intUserId As Integer

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
        strScreenName = "Class"
        strScreenShortDesc = "Company Class"

        If Page.IsPostBack = False Then
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_CompanyClass")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), 0, "Admin_CompanyClass", Session("Athena"))

            PopulateCompanyInfo()
            PopulateBenefitClasses()

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

    Private Sub PopulateBenefitClasses()
        'Fill Parent Company Datagrid 
        c.Load_Company_Class_Gridview(intCompanyId, Session("UserId"), chkActiveOnly.Checked, grdParentBenefitClass)
        Dim iRowCount As Integer
        c.LoadParentCompany(intCompanyId, Session("UserId"), Session("Athena"), grdChildCompanies, iRowCount)
        If iRowCount = 0 Then
            divChildCompanies.Visible = False
        Else
            divChildCompanies.Visible = True
        End If

        lblCompanyNameB.Text = ddlCompany.SelectedItem.Text

    End Sub

#Region "Parent Class Grid"
    Protected Sub grdParentBenefitClass_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)
        Dim rowcolor = Drawing.ColorTranslator.FromHtml("#EFF3FB")
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim keys As DataKey = grdParentBenefitClass.DataKeys(e.Row.RowIndex)
            Dim Inherit As Object = keys("InheritParentClass")
            Dim ParentName As Object = keys("ParentCompany")
            Dim ParentId As Object = keys("ParentCompanyId")
            Dim lnkEdit As LinkButton = DirectCast(e.Row.FindControl("lnkEdit"), LinkButton)

            If (e.Row.RowState And DataControlRowState.Edit) > 0 Then
                e.Row.BackColor = rowcolor
            End If

            If ParentName = "" Then
                'no parent to inherit from,hide checkbox and Label
                chkParentInherite.Visible = False
                lblParent.Visible = False
                Session("Inherit") = False

                If DataBinder.Eval(e.Row.DataItem, "LongDesc") = "No classes are currently assigned to this Company" Then
                    lnkEdit.Visible = False
                End If

            Else
                chkParentInherite.Visible = True
                lblParent.Visible = True
                chkParentInherite.Checked = Inherit
                lblParent.Text = "Inherit classes from Parent company <b>" + ParentName + "</b>"
                lblParentId.Text = ParentId

                If Inherit = True Then
                    Session("Inherit") = True
                    lnkEdit.Visible = False

                Else
                    Session("Inherit") = False
                    lnkEdit.Visible = True
                End If

            End If

        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            If Session("Inherit") = True Then
                e.Row.Visible = False
            Else
                e.Row.Visible = True
            End If
        End If

    End Sub

    Protected Sub grdParentBenefitClass_RowEditing(sender As Object, e As GridViewEditEventArgs)
        grdParentBenefitClass.EditIndex = e.NewEditIndex
        c.Load_Company_Class_Gridview(intCompanyId, Session("UserId"), chkActiveOnly.Checked, grdParentBenefitClass)
    End Sub

    Protected Sub grdParentBenefitClass_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        grdParentBenefitClass.EditIndex = -1
        c.Load_Company_Class_Gridview(intCompanyId, Session("UserId"), chkActiveOnly.Checked, grdParentBenefitClass)
    End Sub

    Protected Sub grdParentBenefitClass_RowUpdating1(sender As Object, e As GridViewUpdateEventArgs)
        Dim intCompanyId = grdParentBenefitClass.DataKeys(e.RowIndex).Values("CompanyId")
        Dim intClassId = grdParentBenefitClass.DataKeys(e.RowIndex).Values("ClassId")

        Dim txtShort As TextBox = DirectCast(grdParentBenefitClass.Rows(e.RowIndex).FindControl("txtShortDesc"), TextBox)
        Dim txtLong As TextBox = DirectCast(grdParentBenefitClass.Rows(e.RowIndex).FindControl("txtLongDesc"), TextBox)
        Dim txtBegin As TextBox = DirectCast(grdParentBenefitClass.Rows(e.RowIndex).FindControl("txtBeginDate"), TextBox)
        Dim txtEnd As TextBox = DirectCast(grdParentBenefitClass.Rows(e.RowIndex).FindControl("txtEndDate"), TextBox)

        'Save procedure here
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()
        Try
            objParam = New SqlParameter("@ClassId", intClassId)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@ParentCompanyId", intCompanyId)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@ChildCompanyId", 0)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@ShortDesc", txtShort.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@LongDesc", txtLong.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@BeginDate", txtBegin.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@EndDate", txtEnd.Text)
            aryParams.Add(objParam)

            sqlCon.ExecuteNonQuery("[usp_Company_Class_Edit]", aryParams)
            sqlCon.CloseConn()

            'Save to Transaction Table
            s.SaveUserUpdate(Session("UserId"), strScreenShortDesc, "Saved on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString, 0, 0, 0, "01/01/1900", 0)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try
        grdParentBenefitClass.EditIndex = -1
        PopulateBenefitClasses()

    End Sub

    Protected Sub grdParentBenefitClass_RowCommand(sender As Object, e As GridViewCommandEventArgs)

        intCompanyId = Session("ShadowCompanyId")

        If e.CommandName = "Add" And intCompanyId <> 0 Then
            ' Dim intCompanyId = grdParentBenefitClass.DataKeys(e.RowIndex).Values("CompanyId")
            ' Dim intClassId = grdParentBenefitClass.DataKeys(e.RowIndex).Values("ClassId")

            Dim txtShort As TextBox = CType(grdParentBenefitClass.FooterRow.FindControl("txtNewShortDesc"), TextBox)
            Dim txtLong As TextBox = CType(grdParentBenefitClass.FooterRow.FindControl("txtNewLongDesc"), TextBox)
            Dim txtBegin As TextBox = CType(grdParentBenefitClass.FooterRow.FindControl("txtNewBeginDate"), TextBox)
            Dim txtEnd As TextBox = CType(grdParentBenefitClass.FooterRow.FindControl("txtNewEndDate"), TextBox)

            'Save procedure here
            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()
            Try
                objParam = New SqlParameter("@ClassId", 0)    'it's a new one
                aryParams.Add(objParam)

                objParam = New SqlParameter("@ParentCompanyId", intCompanyId)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@ChildCompanyId", 0)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@ShortDesc", txtShort.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@LongDesc", txtLong.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@BeginDate", txtBegin.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@EndDate", txtEnd.Text)
                aryParams.Add(objParam)

                sqlCon.ExecuteNonQuery("[usp_Company_Class_Edit]", aryParams)
                sqlCon.CloseConn()

                'Save to Transaction Table
                s.SaveUserUpdate(Session("UserId"), strScreenShortDesc, "Saved on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString, 0, 0, 0, "01/01/1900", 0)

            Catch ex As Exception
                Throw New Exception(ex.Message)
            End Try
            grdParentBenefitClass.EditIndex = -1
            PopulateBenefitClasses()
        End If

    End Sub
#End Region

#Region "ChildCompanyGrid"
    Protected Sub grdChildCompanies_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim keys As DataKey = grdChildCompanies.DataKeys(e.Row.RowIndex)
            Dim ChildCompanyId As Object = keys("CompanyId2")
            Dim chkInherit As CheckBox = DirectCast(e.Row.FindControl("chkInherit"), CheckBox)
            If chkInherit.Checked = True Then
                Session("Inherit") = True
            Else
                Session("Inherit") = False
            End If
            Dim grdChildBenefitClass As GridView = DirectCast(e.Row.FindControl("grdChildBenefitClass"), GridView)
            Dim pnlChildClasses As Panel = DirectCast(e.Row.FindControl("pnlChildClasses"), Panel)

            'populate Child Company Benefit class gridview
            c.Load_Company_Class_Gridview(ChildCompanyId, Session("UserId"), chkActiveOnly.Checked, grdChildBenefitClass)
            pnlChildClasses.Visible = True
        End If
    End Sub

    Protected Sub grdChildBenefitClass_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)
        Dim rowcolor = Drawing.ColorTranslator.FromHtml("#EFF3FB")

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lnkEdit As LinkButton = DirectCast(e.Row.FindControl("lnkEdit"), LinkButton)
            If lnkEdit IsNot Nothing Then               'need to test if it exists because if the row is being edited it actually doesn't
                If Session("Inherit") = True Then
                    lnkEdit.Visible = False
                Else
                    lnkEdit.Visible = True
                End If
            End If

            If (e.Row.RowState And DataControlRowState.Edit) > 0 Then
                e.Row.BackColor = rowcolor
            End If

        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            If Session("Inherit") = True Then
                e.Row.Visible = False
            End If
        End If
    End Sub

    Protected Sub grdChildBenefitClass_RowEditing(sender As Object, e As GridViewEditEventArgs)
        Dim gvwChildClasses As GridView = DirectCast(sender, GridView)
        Dim gvRowCompany As GridViewRow = TryCast(DirectCast(sender, GridView).NamingContainer, GridViewRow)

        'Set the edit index.
        gvwChildClasses.EditIndex = e.NewEditIndex
        'Bind data to the GridView control.
        Dim keys As DataKey = grdChildCompanies.DataKeys(gvRowCompany.RowIndex)
        Dim ChildCompanyId As Object = keys("CompanyId2")

        c.Load_Company_Class_Gridview(ChildCompanyId, Session("UserId"), chkActiveOnly.Checked, gvwChildClasses)
    End Sub

    Protected Sub grdChildBenefitClass_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        Dim gvwChildClasses As GridView = DirectCast(sender, GridView)
        Dim gvRowCompany As GridViewRow = TryCast(DirectCast(sender, GridView).NamingContainer, GridViewRow)

        gvwChildClasses.EditIndex = -1

        Dim keys As DataKey = grdChildCompanies.DataKeys(gvRowCompany.RowIndex)
        Dim ChildCompanyId As Object = keys("CompanyId2")

        c.Load_Company_Class_Gridview(ChildCompanyId, Session("UserId"), chkActiveOnly.Checked, gvwChildClasses)
    End Sub

    Protected Sub grdChildBenefitClass_RowUpdating(sender As Object, e As GridViewUpdateEventArgs)
        Dim gvwChildClasses As GridView = DirectCast(sender, GridView)
        Dim gvRowCompany As GridViewRow = TryCast(DirectCast(sender, GridView).NamingContainer, GridViewRow)

        Dim intCompanyId = gvwChildClasses.DataKeys(e.RowIndex).Values("CompanyId")
        Dim intParentCompanyId = gvwChildClasses.DataKeys(e.RowIndex).Values("ParentCompanyId")
        Dim intClassId = gvwChildClasses.DataKeys(e.RowIndex).Values("ClassId")

        Dim txtShort As TextBox = DirectCast(gvwChildClasses.Rows(e.RowIndex).FindControl("txtShortDesc"), TextBox)
        Dim txtLong As TextBox = DirectCast(gvwChildClasses.Rows(e.RowIndex).FindControl("txtLongDesc"), TextBox)
        Dim txtBegin As TextBox = DirectCast(gvwChildClasses.Rows(e.RowIndex).FindControl("txtBeginDate"), TextBox)
        Dim txtEnd As TextBox = DirectCast(gvwChildClasses.Rows(e.RowIndex).FindControl("txtEndDate"), TextBox)

        'Save procedure here
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()
        Try
            objParam = New SqlParameter("@ClassId", intClassId)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@ParentCompanyId", intParentCompanyId)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@ChildCompanyId", intCompanyId)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@ShortDesc", txtShort.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@LongDesc", txtLong.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@BeginDate", txtBegin.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@EndDate", txtEnd.Text)
            aryParams.Add(objParam)

            sqlCon.ExecuteNonQuery("[usp_Company_Class_Edit]", aryParams)
            sqlCon.CloseConn()

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        gvwChildClasses.EditIndex = -1

        Dim keys As DataKey = grdChildCompanies.DataKeys(gvRowCompany.RowIndex)
        Dim ChildCompanyId As Object = keys("CompanyId2")

        c.Load_Company_Class_Gridview(ChildCompanyId, Session("UserId"), chkActiveOnly.Checked, gvwChildClasses)
    End Sub

    Protected Sub grdChildBenefitClass_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "Add" Then
            Dim gvwChildClasses As GridView = DirectCast(sender, GridView)
            Dim gvRowCompany As GridViewRow = TryCast(DirectCast(sender, GridView).NamingContainer, GridViewRow)

            Dim keys As DataKey = grdChildCompanies.DataKeys(gvRowCompany.RowIndex)
            Dim ChildCompanyId As Object = keys("CompanyId2")
            Dim ParentCompanyId As Object = keys("CompanyId1")


            'Dim intCompanyId = gvwChildClasses.FooterRow.Cells(0).Text

            'Dim intParentCompanyId = gvwChildClasses.DataKeys(e.RowIndex).Values("ParentCompanyId")


            Dim txtShort As TextBox = CType(gvwChildClasses.FooterRow.FindControl("txtNewShortDesc"), TextBox)
            Dim txtLong As TextBox = CType(gvwChildClasses.FooterRow.FindControl("txtNewLongDesc"), TextBox)
            Dim txtBegin As TextBox = CType(gvwChildClasses.FooterRow.FindControl("txtNewBeginDate"), TextBox)
            Dim txtEnd As TextBox = CType(gvwChildClasses.FooterRow.FindControl("txtNewEndDate"), TextBox)

            'Save procedure here
            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()
            Try
                objParam = New SqlParameter("@ClassId", 0)    'it's a new one
                aryParams.Add(objParam)

                objParam = New SqlParameter("@ParentCompanyId", ParentCompanyId)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@ChildCompanyId", ChildCompanyId)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@ShortDesc", txtShort.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@LongDesc", txtLong.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@BeginDate", txtBegin.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@EndDate", txtEnd.Text)
                aryParams.Add(objParam)

                sqlCon.ExecuteNonQuery("[usp_Company_Class_Edit]", aryParams)
                sqlCon.CloseConn()

                ' bresult = Comp.getAllDocumentsByCompany(ddlCompany.SelectedValue, grdDocument)
            Catch ex As Exception
                Throw New Exception(ex.Message)
            End Try

            gvwChildClasses.EditIndex = -1


            c.Load_Company_Class_Gridview(ChildCompanyId, Session("UserId"), chkActiveOnly.Checked, gvwChildClasses)
        End If

    End Sub

    Protected Sub chkInherit_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim cb As CheckBox = DirectCast(sender, CheckBox)
        Dim gvRowCompany As GridViewRow = TryCast(cb.NamingContainer, GridViewRow)
        Dim keys As DataKey = grdChildCompanies.DataKeys(gvRowCompany.RowIndex)
        Dim ChildCompanyId As Object = keys("CompanyId2")

        c.UpdateCompanyInheritClass(ChildCompanyId, intCompanyId, cb.Checked, Session("UserId"))

        If cb.Checked Then
            Session("Inherit") = True
        Else
            Session("Inherit") = False
        End If
        'reload this Child Class Gridview
        Dim grdChildBenefitClass As GridView = DirectCast(cb.NamingContainer.FindControl("grdChildBenefitClass"), GridView)
        Dim pnlChildClasses As Panel = DirectCast(cb.NamingContainer.FindControl("pnlChildClasses"), Panel)

        c.Load_Company_Class_Gridview(ChildCompanyId, Session("UserId"), chkActiveOnly.Checked, grdChildBenefitClass)
        pnlChildClasses.Visible = True
    End Sub

#End Region

    Protected Sub chkParentInherite_CheckedChanged(sender As Object, e As EventArgs)
        c.UpdateCompanyInheritClass(intCompanyId, lblParentId.Text, chkParentInherite.Checked, Session("UserId"))
        PopulateBenefitClasses()
    End Sub

    Protected Sub chkActiveOnly_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        PopulateBenefitClasses()
    End Sub

    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ShadowCompanyId") = ddlCompany.SelectedValue
        intCompanyId = Session("ShadowCompanyId")

        PopulateCompanyInfo()
        PopulateBenefitClasses()

        grdParentBenefitClass.EditIndex = -1

        'Fill Parent datagrid (Selected Company as Parent)
        Dim iRowCount As Integer
        c.LoadParentCompany(ddlCompany.SelectedValue, Session("UserId"), Session("Athena"), grdChildCompanies, iRowCount)
        If iRowCount = 0 Then
            divChildCompanies.Visible = False
        Else
            divChildCompanies.Visible = True
            lblCompanyNameB.Text = ddlCompany.SelectedItem.Text
        End If

    End Sub

    Protected Sub chkActive_CheckedChanged(sender As Object, e As EventArgs)
        Session("ActiveCompany") = IIf(chkActive.Checked = True, 1, 0)

        Session("ShadowCompanyId") = 0
        intCompanyId = 0

        PopulateCompanyInfo()
        PopulateBenefitClasses()

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Session.Remove("AddNew")
        Response.Redirect("~/Admin_CompanyACARules.aspx")
    End Sub

End Class
