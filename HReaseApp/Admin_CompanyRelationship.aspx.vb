Imports System.Data.SqlClient

Public Class Admin_CompanyRelationship
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
        strScreenName = "CompanyRelationship"

        If Page.IsPostBack = False Then
            s.SaveUserBrowse(Session("UserId"), strScreenName, "Browsed on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString)
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_CompanyRelationship")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), 0, "Admin_CompanyRelationship", Session("Athena"))

            PopulateCompanyInfo()
            FillRelationshipLists()
            PopulateRelationships()

            's.SaveUserBrowse(Session("UserId"), strScreenName, "Browsed on " + strScreenShortDesc + " for CompanyId " + intCompanyId.ToString)

            'Only want to show Add and Edit buttons to Admins allowed to alter infomration
            If c.ShowCompanyRelationshipScreen(Session("Userid"), Session("Athena")) = False Then
                btnAddCompanyChild.Visible = False
                btnAddCompanyParent.Visible = False
                btnEditCompanyChild.Visible = False
                btnEditCompanyParent.Visible = False
            End If

            btnCancelCompanyParent.Visible = False
            btnSaveCompanyParent.Visible = False
            btnCancelCompanyChild.Visible = False
            btnSaveCompanyChild.Visible = False
        End If

        btnSaveCompanyChild.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSaveCompanyChild, "") + ";this.src='/img/processing.gif';")
        btnSaveCompanyParent.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSaveCompanyParent, "") + ";this.src='/img/processing.gif';")
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

    Private Sub FillRelationshipLists()
        'fill up RElationship list in modals
        Dim ds1 As New DataSet
        c.LoadCompanyList(Session("UserId"), Session("ShadowCompanyId"), "Consolidated", "", Session("ActiveCompany"), 0, 0, Session("ds1"))

        ddlAddParent.DataSource = Session("ds1").tables(0)
        ddlAddParent.DataBind()

        ddlAddChild.DataSource = Session("ds1").tables(0)
        ddlAddChild.DataBind()

        c.LoadCompanyRelationshipTypes(4, ds1)
        ddlAddChildRelationshiptype.DataSource = ds1.Tables(0)
        ddlAddChildRelationshiptype.DataBind()

        ddlAddParentRelationshiptype.DataSource = ds1.Tables(0)
        ddlAddParentRelationshiptype.DataBind()

        lblCompanyNameA.Text = ddlCompany.SelectedItem.Text
        lblCompanyNameB.Text = ddlCompany.SelectedItem.Text
    End Sub

    Private Sub PopulateRelationships()
        'Fill Child Datagrid (select Company as the Child)
        c.LoadChildCompany(intCompanyId, Session("UserId"), Session("Athena"), grdChildCompanies)

        'Fill Parent datagrid (Selected Company as Parent)
        Dim iRowCount As Integer
        c.LoadParentCompany(intCompanyId, Session("UserId"), Session("Athena"), grdParentCompanies, iRowCount)

    End Sub

#Region "Child Company - top portion of the screen"
    Protected Sub grdChildCompanies_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdChildCompanies.RowDataBound

        'hide Text boxes until in edit mode
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim keys As DataKey = grdChildCompanies.DataKeys(e.Row.RowIndex)

            'Dim txtDescription As TextBox = DirectCast(e.Row.FindControl("txtDescription"), TextBox)
            'Dim lblDescription As Label = DirectCast(e.Row.FindControl("lblDescription"), Label)

            Dim ddlChildRelationshiptype As DropDownList = DirectCast(e.Row.FindControl("ddlChildRelationshiptype"), DropDownList)
            Dim lblRelationship As Label = DirectCast(e.Row.FindControl("lblRelationship"), Label)

            Dim txtBegin As TextBox = DirectCast(e.Row.FindControl("txtBeginDate"), TextBox)
            Dim lblBegin As Label = DirectCast(e.Row.FindControl("lblBeginDate"), Label)

            Dim txtEnd As TextBox = DirectCast(e.Row.FindControl("txtEndDate"), TextBox)
            Dim lblEnd As Label = DirectCast(e.Row.FindControl("lblEndDate"), Label)

            'Hide editable stuff
            'txtDescription.Visible = False
            ddlChildRelationshiptype.Visible = False
            txtBegin.Visible = False
            txtEnd.Visible = False

            'show labels
            lblBegin.Visible = True
            If lblEnd.Text <> "12/31/2999" Then
                lblEnd.Visible = True
            Else
                lblEnd.Visible = False
            End If

        End If

    End Sub

    Protected Sub btnEditCompanyChild_Click() Handles btnEditCompanyChild.Click
        'call LoadCompanyRelationshipTypes to fill datatable, then use to fill every row in Gridview
        Dim ds As New DataSet

        c.LoadCompanyRelationshipTypes(4, ds)

        Dim i As Int32

        For Each gvr In grdChildCompanies.Rows
            'Dim txtDescription As TextBox = DirectCast(gvr.FindControl("txtDescription"), TextBox)
            'Dim lblDescription As Label = DirectCast(gvr.FindControl("lblDescription"), Label)

            Dim ddlChildRelationshiptype As DropDownList = DirectCast(gvr.FindControl("ddlChildRelationshiptype"), DropDownList)
            Dim lblRelationship As Label = DirectCast(gvr.FindControl("lblRelationship"), Label)

            Dim txtBegin As TextBox = DirectCast(gvr.FindControl("txtBeginDate"), TextBox)
            Dim lblBegin As Label = DirectCast(gvr.FindControl("lblBeginDate"), Label)

            Dim txtEnd As TextBox = DirectCast(gvr.FindControl("txtEndDate"), TextBox)
            Dim lblEnd As Label = DirectCast(gvr.FindControl("lblEndDate"), Label)

            'fill relationshiptype ddl with values
            Dim intRelationshipId As Integer
            intRelationshipId = grdChildCompanies.DataKeys(i).Values("RelationshipTypeId")
            ddlChildRelationshiptype.DataSource = ds.Tables(0)
            ddlChildRelationshiptype.DataBind()
            ddlChildRelationshiptype.SelectedValue = intRelationshipId

            'show editable stuff
            'txtDescription.Visible = True
            ddlChildRelationshiptype.Visible = True
            txtBegin.Visible = True
            txtEnd.Visible = True

            'lblDescription.Visible = False
            lblRelationship.Visible = False
            lblBegin.Visible = False
            lblEnd.Visible = False
            i += 1
        Next

        btnCancelCompanyChild.Visible = True
        btnSaveCompanyChild.Visible = True
        btnAddCompanyChild.Visible = False
        btnEditCompanyChild.Visible = False

    End Sub

    Protected Sub btnCancelCompanyChild_Click() Handles btnCancelCompanyChild.Click
        c.LoadChildCompany(ddlCompany.SelectedValue, Session("UserId"), Session("Athena"), grdChildCompanies)
        btnCancelCompanyChild.Visible = False
        btnSaveCompanyChild.Visible = False
        btnAddCompanyChild.Visible = True
        btnEditCompanyChild.Visible = True

    End Sub

    Protected Sub btnSaveCompanyChild_Click() Handles btnSaveCompanyChild.Click
        'THIS IS THE EDIT
        'Cycle thru Datagrid and check for any changes by comparing text boxes and drop downs to label values

        Dim i As Int32
        For Each gvr In grdChildCompanies.Rows
            'Dim txtDescription As TextBox = DirectCast(gvr.FindControl("txtDescription"), TextBox)
            'Dim lblDescription As Label = DirectCast(gvr.FindControl("lblDescription"), Label)

            Dim ddlChildRelationshiptype As DropDownList = DirectCast(gvr.FindControl("ddlChildRelationshiptype"), DropDownList)
            Dim lblRelationship As Label = DirectCast(gvr.FindControl("lblRelationship"), Label)

            Dim txtBegin As TextBox = DirectCast(gvr.FindControl("txtBeginDate"), TextBox)
            Dim lblBegin As Label = DirectCast(gvr.FindControl("lblBeginDate"), Label)

            Dim txtEnd As TextBox = DirectCast(gvr.FindControl("txtEndDate"), TextBox)
            Dim lblEnd As Label = DirectCast(gvr.FindControl("lblEndDate"), Label)

            'grab key values
            Dim intCompanyRelationshipId As Integer
            Dim intCompanyId1 As Integer
            Dim intCompanyId2 As Integer
            Dim intRelationshipId As Integer
            intCompanyRelationshipId = grdChildCompanies.DataKeys(i).Values("CompanyRelationshipId")
            intCompanyId1 = grdChildCompanies.DataKeys(i).Values("CompanyId1")
            intCompanyId2 = grdChildCompanies.DataKeys(i).Values("CompanyId2")
            intRelationshipId = grdChildCompanies.DataKeys(i).Values("RelationshipTypeId")

            'Compare values to find out which ones have changed if any
            If txtBegin.Text <> lblBegin.Text Or
                txtEnd.Text <> IIf(lblEnd.Text = "", "12/31/2999", lblEnd.Text) Or
                ddlChildRelationshiptype.SelectedValue <> intRelationshipId Then

                'Something has changed, call save procedure
                SaveRecord(intCompanyRelationshipId, intCompanyId1, intCompanyId2, "", ddlChildRelationshiptype.SelectedValue, txtBegin.Text, txtEnd.Text)
            End If
            i += 1
        Next

        c.LoadChildCompany(ddlCompany.SelectedValue, Session("UserId"), Session("Athena"), grdChildCompanies)
        btnCancelCompanyChild.Visible = False
        btnSaveCompanyChild.Visible = False
        btnAddCompanyChild.Visible = True
        btnEditCompanyChild.Visible = True

    End Sub


    Protected Sub btnParentAddSave_Click(sender As Object, e As ImageClickEventArgs) Handles btnParentAddSave.Click
        SaveRecord(0, ddlAddParent.SelectedValue, ddlCompany.SelectedValue, "", ddlAddParentRelationshiptype.SelectedValue, txtParentBeginDate.Text, "12/31/2999")

        c.LoadChildCompany(ddlCompany.SelectedValue, Session("UserId"), Session("Athena"), grdChildCompanies)
        btnCancelCompanyParent.Visible = False
        btnSaveCompanyParent.Visible = False
        btnAddCompanyParent.Visible = True
        btnEditCompanyParent.Visible = True

    End Sub

#End Region

#Region "Parent Company"
    Protected Sub grdParentCompanies_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdParentCompanies.RowDataBound

        'hide Text boxes until in edit mode
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim keys As DataKey = grdParentCompanies.DataKeys(e.Row.RowIndex)

            'Dim txtDescription As TextBox = DirectCast(e.Row.FindControl("txtDescription"), TextBox)
            'Dim lblDescription As Label = DirectCast(e.Row.FindControl("lblDescription"), Label)

            Dim ddlParentRelationshiptype As DropDownList = DirectCast(e.Row.FindControl("ddlParentRelationshiptype"), DropDownList)
            Dim lblRelationship As Label = DirectCast(e.Row.FindControl("lblRelationship"), Label)

            Dim txtBegin As TextBox = DirectCast(e.Row.FindControl("txtBeginDate"), TextBox)
            Dim lblBegin As Label = DirectCast(e.Row.FindControl("lblBeginDate"), Label)

            Dim txtEnd As TextBox = DirectCast(e.Row.FindControl("txtEndDate"), TextBox)
            Dim lblEnd As Label = DirectCast(e.Row.FindControl("lblEndDate"), Label)

            'Hide editable stuff
            '  txtDescription.Visible = False
            ddlParentRelationshiptype.Visible = False
            txtBegin.Visible = False
            txtEnd.Visible = False

            'show labels
            lblBegin.Visible = True
            If lblEnd.Text <> "12/31/2999" Then
                lblEnd.Visible = True
            Else
                lblEnd.Visible = False
            End If

        End If

    End Sub

    Protected Sub btnEditCompanyParent_Click() Handles btnEditCompanyParent.Click
        'call LoadCompanyRelationshipTypes to fill datatable, then use to fill every row in Gridview
        Dim ds As New DataSet

        c.LoadCompanyRelationshipTypes(4, ds)

        Dim i As Int32

        For Each gvr In grdParentCompanies.Rows
            'Dim txtDescription As TextBox = DirectCast(gvr.FindControl("txtDescription"), TextBox)
            'Dim lblDescription As Label = DirectCast(gvr.FindControl("lblDescription"), Label)

            Dim ddlParentRelationshiptype As DropDownList = DirectCast(gvr.FindControl("ddlParentRelationshiptype"), DropDownList)
            Dim lblRelationship As Label = DirectCast(gvr.FindControl("lblRelationship"), Label)

            Dim txtBegin As TextBox = DirectCast(gvr.FindControl("txtBeginDate"), TextBox)
            Dim lblBegin As Label = DirectCast(gvr.FindControl("lblBeginDate"), Label)

            Dim txtEnd As TextBox = DirectCast(gvr.FindControl("txtEndDate"), TextBox)
            Dim lblEnd As Label = DirectCast(gvr.FindControl("lblEndDate"), Label)

            'fill relationshiptype ddl with values
            Dim intRelationshipId As Integer
            intRelationshipId = grdParentCompanies.DataKeys(i).Values("RelationshipTypeId")
            ddlParentRelationshiptype.DataSource = ds.Tables(0)
            ddlParentRelationshiptype.DataBind()
            ddlParentRelationshiptype.SelectedValue = intRelationshipId

            'show editable stuff
            'txtDescription.Visible = True
            ddlParentRelationshiptype.Visible = True
            txtBegin.Visible = True
            txtEnd.Visible = True

            'lblDescription.Visible = False
            lblRelationship.Visible = False
            lblBegin.Visible = False
            lblEnd.Visible = False
            i += 1
        Next

        btnCancelCompanyParent.Visible = True
        btnSaveCompanyParent.Visible = True
        btnAddCompanyParent.Visible = False
        btnEditCompanyParent.Visible = False

    End Sub

    Protected Sub btnCancelCompanyParent_Click() Handles btnCancelCompanyParent.Click
        Dim iRowCount As Integer
        c.LoadParentCompany(ddlCompany.SelectedValue, Session("UserId"), Session("Athena"), grdParentCompanies, iRowCount)
        btnCancelCompanyParent.Visible = False
        btnSaveCompanyParent.Visible = False
        btnAddCompanyParent.Visible = True
        btnEditCompanyParent.Visible = True
    End Sub

    Protected Sub btnSaveCompanyParent_Click() Handles btnSaveCompanyParent.Click
        'THIS IS THE EDIT
        'Cycle thru Datagrid and check for any changes by comparing text boxes and drop downs to label values
        Dim i As Int32
        For Each gvr In grdParentCompanies.Rows
            'Dim txtDescription As TextBox = DirectCast(gvr.FindControl("txtDescription"), TextBox)
            'Dim lblDescription As Label = DirectCast(gvr.FindControl("lblDescription"), Label)

            Dim ddlParentRelationshiptype As DropDownList = DirectCast(gvr.FindControl("ddlParentRelationshiptype"), DropDownList)
            Dim lblRelationship As Label = DirectCast(gvr.FindControl("lblRelationship"), Label)

            Dim txtBegin As TextBox = DirectCast(gvr.FindControl("txtBeginDate"), TextBox)
            Dim lblBegin As Label = DirectCast(gvr.FindControl("lblBeginDate"), Label)

            Dim txtEnd As TextBox = DirectCast(gvr.FindControl("txtEndDate"), TextBox)
            Dim lblEnd As Label = DirectCast(gvr.FindControl("lblEndDate"), Label)

            'grab key values
            Dim intCompanyRelationshipId As Integer
            Dim intCompanyId1 As Integer
            Dim intCompanyId2 As Integer
            Dim intRelationshipId As Integer
            intCompanyRelationshipId = grdParentCompanies.DataKeys(i).Values("CompanyRelationshipId")
            intCompanyId1 = grdParentCompanies.DataKeys(i).Values("CompanyId1")
            intCompanyId2 = grdParentCompanies.DataKeys(i).Values("CompanyId2")
            intRelationshipId = grdParentCompanies.DataKeys(i).Values("RelationshipTypeId")

            'Compare values to find out which ones have changed if any
            If txtBegin.Text <> lblBegin.Text Or
                txtEnd.Text <> IIf(lblEnd.Text = "", "12/31/2999", lblEnd.Text) Or
                ddlParentRelationshiptype.SelectedValue <> intRelationshipId Then

                'Something has changed, call save procedure
                SaveRecord(intCompanyRelationshipId, intCompanyId1, intCompanyId2, "", ddlParentRelationshiptype.SelectedValue, txtBegin.Text, txtEnd.Text)
            End If
            i += 1
        Next
        Dim iRowCount As Integer
        c.LoadParentCompany(ddlCompany.SelectedValue, Session("UserId"), Session("Athena"), grdParentCompanies, iRowCount)
        btnCancelCompanyParent.Visible = False
        btnSaveCompanyParent.Visible = False
        btnAddCompanyParent.Visible = True
        btnEditCompanyParent.Visible = True

    End Sub

    Protected Sub btnChildAddSave_Click(sender As Object, e As ImageClickEventArgs) Handles btnChildAddSave.Click
        SaveRecord(0, ddlCompany.SelectedValue, ddlAddChild.SelectedValue, "", ddlAddChildRelationshiptype.SelectedValue, txtChildBeginDate.Text, "12/31/2999")
        Dim iRowCount As Integer
        c.LoadParentCompany(ddlCompany.SelectedValue, Session("UserId"), Session("Athena"), grdParentCompanies, iRowCount)
        btnCancelCompanyParent.Visible = False
        btnSaveCompanyParent.Visible = False
        btnAddCompanyParent.Visible = True
        btnEditCompanyParent.Visible = True

    End Sub

#End Region

#Region "Save Procedure"
    Private Sub SaveRecord(ByRef CompanyRelationshipId As Integer, ByRef CompanyId1 As Integer, ByRef CompanyId2 As Integer, ByRef Description As String, ByRef RelationshipTypeId As Integer, ByRef BeginDate As String, ByRef EndDate As String)
        'Save Business Rule Info 
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        objParam = New SqlParameter("@CompanyRelationshipId", CompanyRelationshipId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@CompanyId1", CompanyId1)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@CompanyId2", CompanyId2)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@LongDesc", Description)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@RelationshipTypeId", RelationshipTypeId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@BeginDate", BeginDate)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EndDate", EndDate)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@UserId", Session("UserId"))
        aryParams.Add(objParam)

        objDataSet = sqlCon.CreateDataSet("usp_Company_Relationship_Edit", aryParams)
        sqlCon.CloseConn()

        'Save to Transaction Table
        s.SaveUserUpdate(Session("UserId"), strScreenShortDesc, "Saved on " + strScreenShortDesc + " for CompanyId: " + CompanyId1.ToString, 0, 0, 0, "01/01/1900", 0)

    End Sub
#End Region

    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ShadowCompanyId") = ddlCompany.SelectedValue
        intCompanyId = Session("ShadowCompanyId")

        PopulateCompanyInfo()
        FillRelationshipLists()
        PopulateRelationships()

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Session.Remove("AddNew")
        Response.Redirect("~/Admin_CompanyBusinessRules.aspx")

    End Sub

    Protected Sub chkActive_CheckedChanged(sender As Object, e As EventArgs)
        Session("ActiveCompany") = IIf(chkActive.Checked = True, 1, 0)

        Session("ShadowCompanyId") = 0
        intCompanyId = 0

        PopulateCompanyInfo()
        FillRelationshipLists()
        PopulateRelationships()

    End Sub
End Class
