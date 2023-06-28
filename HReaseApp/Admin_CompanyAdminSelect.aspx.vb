Imports System.Data.SqlClient

Public Class Admin_CompanyAdminSelect
    Inherits System.Web.UI.Page
    Dim s As New Security
    Dim c As New Company
    Dim sc As New ScreenConfiguration
    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Dim intCompanyId As Integer
    Dim intUserId As Integer
    Dim bAdminAllowedEdit As Boolean

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
        strScreenName = "Administrator"
        strScreenShortDesc = "Company Administrator"

        If Page.IsPostBack = False Then
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_Welcome")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), 0, "Admin_CompanyAdminSelect", Session("Athena"))

            c.LoadState(ddlState)
            c.LoadCountry(ddlCountry)

            ddlState.Items.Insert(0, New ListItem(""))
            ddlCountry.Items.Insert(0, New ListItem(""))

            PopulateCompanyInfo()
            GetAdminRights()
            FillAdminLists()

            s.SaveUserBrowse(Session("UserId"), strScreenName, "Browsed on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString)

        End If

        btnSave.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSave, "") + ";this.src='/img/processing.gif';")
        btnCancel.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnCancel, "") + ";this.src='/img/processing.gif';")
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

    Private Sub GetAdminRights()
        c.GetAdminInfo(Session("AdminId"), Session("UserId"))
        Dim intAdminId As Integer
        intAdminId = Session("AdminId")

        If c.AdminRoleTypeId = 1 Or c.AdminRoleTypeId = 2 Or c.AdminRoleTypeId = 5 Then
            btnAddAdmin.Visible = True
            bAdminAllowedEdit = True
            btnEditAdmin.Visible = True
            divEmailandEdit.Visible = True
            divEditButtons.Visible = True
            Session("AllowedToEdit") = True
        Else
            btnAddAdmin.Visible = False
            btnEditAdmin.Visible = False
            divEmailandEdit.Visible = False
            divEditButtons.Visible = False
            Session("AllowedToEdit") = False
        End If
    End Sub

    Private Sub FillAdminLists()
        c.getAdminList(Session("UserId"), Session("ShadowCompanyId"), grdAdmin)

    End Sub

#Region "Admin Select datagrid"
    Protected Sub grdAdmin_RowCreated(sender As Object, e As GridViewRowEventArgs) Handles grdAdmin.RowCreated
        If Session("AllowedToEdit") = True Then
            If e.Row.RowType = System.Web.UI.WebControls.DataControlRowType.DataRow Then
                e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#EFF3FB'")  'old color   8bced
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=''")

                e.Row.Attributes.Add("style", "cursor:pointer;")
                e.Row.Attributes("onclick") = Page.ClientScript.GetPostBackClientHyperlink(grdAdmin, "Select$" & e.Row.RowIndex)
                e.Row.ToolTip = "Click to select this Administrator."

                lblHightlight1.Visible = True
            End If
        End If
    End Sub

    'user select row in grid
    Protected Sub OnSelectedIndexChanged(sender As Object, e As EventArgs)
        Dim row As GridViewRow = grdAdmin.SelectedRow
        Dim i As Integer
        i = grdAdmin.SelectedIndex
        Session("ShadowAdminId") = grdAdmin.DataKeys(i).Values("AdminId")

        'Probably just want to hide everything and show Edit blocks....not there yet
        PopulateAdminInfo()
        divNextButton.Visible = False
        divTopHeader.Visible = False
        divAdminList.Visible = False
        divAdminReview.Visible = True
        divAdminEdit.Visible = False

        btnCancelCompanyAdmin.Visible = False
        btnSaveCompanyAdmin.Visible = False

        GetAdminRights()
    End Sub

    Sub grdAdmin_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs)
        grdAdmin.DataSource = Session("Admins")
        ' a_grdEmployee.DataBind()

        grdAdmin.PageIndex = e.NewPageIndex
        grdAdmin.DataBind()
    End Sub
#End Region

#Region "Fill or Empty Review and Edit areas"
    Private Sub ClearAdminInfo()
        lblAdminId.Text = "0"
        lblAdminName.Text = ""
        ' lblAdminType.Text = ""
        lblRoleType.Text = ""
        lblWorkPhone.Text = ""
        lblExtension.Text = ""
        lblMobile.Text = ""
        lblEmail.Text = ""
        lblAddress.Text = ""
        lblAddress2.Text = ""
        lblZip.Text = ""
        lblZipExtension.Text = ""
        lblState.Text = ""
        lblCity.Text = ""
        lblCountry.Text = ""
        lblAdminBeginDate.Text = ""
        lblAdminEndDate.Text = ""

        lblAdminId.Text = 0
        lblAdminId.Visible = False
        txtFirstName.Text = ""
        txtLastName.Text = ""
        ' lblEAdminType.Text = ddlAdminType.SelectedItem.Text
        txtOffice.Text = ""
        txtExtension.Text = ""
        txtMobile.Text = ""
        txtFax.Text = ""
        txtEmail.Text = ""
        txtAddress1.Text = ""
        txtAddress2.Text = ""
        txtCity.Text = ""
        txtZip.Text = ""
        txtZipExt.Text = ""
        txtAdminBeginDate.Text = ""
        txtAdminEndDate.Text = ""
        chkActiveAdmin.Checked = True
        ddlState.SelectedValue = ""
        ddlCountry.SelectedValue = "USA"
        ddlRoleType.Items.Add(New ListItem("", "0"))
        ddlRoleType.SelectedValue = 0

        'Clear Company section

        grdAssignNewCompany.DataSource = Nothing
        grdAssignNewCompany.DataBind()

        grdCurrentCompanies.DataSource = Nothing
        grdCurrentCompanies.DataBind()

    End Sub

    Private Sub PopulateAdminInfo()
        divAdminCompanies.Visible = True
        divAdminReview.Visible = True
        btnEditAdmin.Visible = True
        btnAddAdmin.Visible = True
        lblErrorActive.Visible = False

        c.Load_RoleType_List(Session("UserId"), ddlRoleType)

        c.GetAdminInfo(Session("ShadowAdminId"), Session("UserId"))

        Dim dsCompany As New DataSet
        c.Load_AdminEnrollerCompany_List(Session("ShadowAdminId"), Session("UserId"), Session("Athena"), dsCompany)

        grdCurrentCompanies.DataSource = dsCompany.Tables(0)
        grdCurrentCompanies.DataBind()

        grdAssignNewCompany.DataSource = dsCompany.Tables(1)
        grdAssignNewCompany.DataBind()

        If dsCompany.Tables(1).Rows.Count > 1 Then  'unassigned companies that the current user can see
            'Make the add Compnay admin button visible
            btnAddCompanyAdmin.Visible = True
        Else
            btnAddCompanyAdmin.Visible = False
        End If

        lblAdminName.Text = c.AdminFullName
        lblRoleType.Text = c.AdminRoleTypeDesc
        lblWorkPhone.Text = c.AdminWorkPhone
        lblExtension.Text = c.AdminExtension
        lblMobile.Text = c.AdminMobilePhone
        lblEmail.Text = c.AdminPrimaryEmail
        lblAddress.Text = c.AdminAddress1
        lblAddress2.Text = c.AdminAddress2
        lblZip.Text = c.AdminZip
        lblZipExtension.Text = c.AdminZipExtension
        lblState.Text = c.AdminState
        lblCity.Text = c.AdminCity
        lblCountry.Text = c.AdminCountry
        lblAdminBeginDate.Text = c.AdminBeginDate
        lblAdminEndDate.Text = IIf(c.AdminEndDate = "12/31/2999", "", c.AdminEndDate)
        lblLastLogin.Text = c.AdminLastLogin

        lblAdminId.Text = Session("ShadowAdminId")
        lblAdminId.Visible = True
        txtFirstName.Text = c.AdminFirstName
        txtLastName.Text = c.AdminLastName
        txtOffice.Text = c.AdminWorkPhone
        txtExtension.Text = c.AdminExtension
        txtMobile.Text = c.AdminMobilePhone
        txtFax.Text = c.AdminFax
        txtEmail.Text = c.AdminPrimaryEmail
        txtAddress1.Text = c.AdminAddress1
        txtAddress2.Text = c.AdminAddress2
        txtCity.Text = c.AdminCity
        txtZip.Text = c.AdminZip
        txtZipExt.Text = c.AdminZipExtension
        txtAdminBeginDate.Text = c.AdminBeginDate
        txtAdminEndDate.Text = IIf(c.AdminEndDate = "12/31/2999", "", c.AdminEndDate)
        ddlState.SelectedValue = IIf(c.AdminState <> "", c.AdminState, "")
        ddlCountry.SelectedValue = IIf(c.AdminCountry <> "", c.AdminCountry, "USA")
        ddlRoleType.SelectedValue = c.AdminRoleTypeId

        txtAdminEmailTo.Text = c.AdminPrimaryEmail
        txtAdminFromEmail.Text = c.AdminFromEmail
        txtAdminEmailSubject.Text = c.AdminEmailSubject
        txtAdminEmailBody.Text = c.AdminEmailBody
        imgLogo.ImageUrl = "<img src=https://hrease.com" & c.AdminLogo & " />"
        imgLogo.AlternateText = "<img src=https://hrease.com" & c.AdminLogo & " />"
    End Sub

    Protected Sub btnAddAdmin_Click(sender As Object, e As EventArgs) Handles btnAddAdmin.Click
        ClearAdminInfo()

        divNextButton.Visible = False
        divTopHeader.Visible = False
        divAdminReview.Visible = False
        divAdminEdit.Visible = True
        divAdminList.Visible = False

        Session("ShadowAdminId") = 0

        c.GetCompanyInfo(intCompanyId, Session("UserId"))

        c.Load_RoleType_List(Session("UserId"), ddlRoleType)
        ddlRoleType.Items.Add(New ListItem("", "0"))
        ddlRoleType.SelectedValue = 0

        txtAddress1.Text = c.Address1
        txtAddress2.Text = c.Address2
        txtCity.Text = c.City
        ddlState.SelectedValue = c.State
        txtZip.Text = c.Zip
        txtZipExt.Text = c.ZipExtension

    End Sub

    Protected Sub btnEditAdmin_Click(sender As Object, e As EventArgs) Handles btnEditAdmin.Click
        divNextButton.Visible = False
        divTopHeader.Visible = False
        divAdminList.Visible = False
        divAdminReview.Visible = False
        divAdminEdit.Visible = True
        divAdminCompanies.Visible = False
        btnAddAdmin.Visible = False

        btnCancelCompanyAdmin.Visible = False
        btnSaveCompanyAdmin.Visible = False
        GetAdminRights()
        FillAdminLists()

    End Sub

    Protected Sub btnBack2_Click(sender As Object, e As EventArgs) Handles btnBack2.Click
        divNextButton.Visible = True
        divTopHeader.Visible = True
        divAdminList.Visible = True
        divAdminReview.Visible = False
        divAdminEdit.Visible = False
        divAdminCompanies.Visible = False
        GetAdminRights()
    End Sub
#End Region

#Region "Edit Admin"
    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        divNextButton.Visible = False
        divTopHeader.Visible = False
        divAdminList.Visible = False
        divAdminReview.Visible = True
        divAdminEdit.Visible = False
        divAdminCompanies.Visible = True
        divError.Visible = False

        GetAdminRights()
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        intCompanyId = Session("ShadowCompanyId")

        If txtAddress1.Text = "" Or txtCity.Text = "" Or ddlState.SelectedValue = "" Or txtZip.Text = "" Then
            lblError.Text = "All Address Components are Required"
            divError.Visible = True
            txtAddress1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtCity.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ddlState.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtZip.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Exit Sub
        End If

        If txtFirstName.Text = "" Or txtLastName.Text = "" Then
            lblError.Text = "First and Last Name are Required"
            divError.Visible = True
            txtFirstName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtLastName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Exit Sub
        End If

        If txtEmail.Text = "" Then
            lblError.Text = "Email Address is Required"
            divError.Visible = True
            txtEmail.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Exit Sub
        End If

        If ddlRoleType.SelectedValue = "" Then
            lblError.Text = "Please select a Role Type"
            divError.Visible = True
            ddlRoleType.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Exit Sub
        End If

        If divError.Visible = False Then

            txtAddress1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtCity.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            ddlState.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtZip.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtFirstName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtLastName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtEmail.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            ddlRoleType.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            lblError.Text = ""

            imgProcessing.Visible = True

            'Save Admin Info
            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()

            objParam = New SqlParameter("@AdminId", lblAdminId.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@CompanyId", Session("ShadowCompanyId"))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@RoleTypeId", ddlRoleType.SelectedValue)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@FirstName", txtFirstName.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@LastName", txtLastName.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Address1", txtAddress1.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Address2", txtAddress2.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@City", txtCity.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@State", ddlState.SelectedValue)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Country", ddlCountry.SelectedValue)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Zip", txtZip.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ZipExtension", txtZipExt.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@WorkPhone", txtOffice.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@WorkExt", txtExtension.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@MobilePhone", txtMobile.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Fax", txtFax.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Email", txtEmail.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@BeginDate", txtAdminBeginDate.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EndDate", IIf(Trim(txtAdminEndDate.Text) = "", "12/31/2999", txtAdminEndDate.Text))
            aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("[usp_Admin_Profile_Edit]", aryParams)
            sqlCon.CloseConn()

            divSuccess.Visible = True
            divError.Visible = False
            imgNext.Visible = True

            s.SaveUserUpdate(Session("UserId"), strScreenShortDesc, "Saved on " + strScreenShortDesc + " for CompanyId " + intCompanyId.ToString, 0, 0, 0, "01/01/1900", 0)

            imgProcessing.Visible = False

        End If

        PopulateCompanyInfo()
        GetAdminRights()
        FillAdminLists()

        divNextButton.Visible = True
        divTopHeader.Visible = True
        divAdminList.Visible = True
        divAdminReview.Visible = False
        divAdminEdit.Visible = False
        divAdminCompanies.Visible = False
    End Sub
#End Region

    Protected Sub UpdateEndDate(sender As Object, e As EventArgs)
        If RTrim(txtAdminEndDate.Text) <> "" Then
            If txtAdminEndDate.Text < Now Then
                chkActiveAdmin.Checked = False
                lblErrorActive.Visible = True
                lblErrorActive.Text = "<strong>Please Note:  </strong>Updating the End Date will prohibit the user from logging into the system."
            Else
                chkActiveAdmin.Checked = True
                lblErrorActive.Visible = False
            End If

        Else
            chkActiveAdmin.Checked = True
            lblErrorActive.Visible = False
        End If
    End Sub

#Region "Company Admin"

    Protected Sub grdCurrentCompanies_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdCurrentCompanies.RowDataBound

        'hide Text boxes until in edit mode
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim keys As DataKey = grdCurrentCompanies.DataKeys(e.Row.RowIndex)
            Dim txtBegin As TextBox = DirectCast(e.Row.FindControl("txtBeginDate"), TextBox)
            Dim txtEnd As TextBox = DirectCast(e.Row.FindControl("txtEndDate"), TextBox)
            Dim lblBegin As Label = DirectCast(e.Row.FindControl("lblBeginDate"), Label)
            Dim lblEnd As Label = DirectCast(e.Row.FindControl("lblEndDate"), Label)

            txtBegin.Visible = False
            txtEnd.Visible = False
            lblBegin.Visible = True
            lblEnd.Visible = True
        End If

    End Sub

    Protected Sub btnEditCompanyAdmin_Click() Handles btnEditCompanyAdmin.Click
        For Each gvr In grdCurrentCompanies.Rows
            Dim txtBegin As TextBox = DirectCast(gvr.FindControl("txtBeginDate"), TextBox)
            Dim txtEnd As TextBox = DirectCast(gvr.FindControl("txtEndDate"), TextBox)
            Dim lblBegin As Label = DirectCast(gvr.FindControl("lblBeginDate"), Label)
            Dim lblEnd As Label = DirectCast(gvr.FindControl("lblEndDate"), Label)

            txtBegin.Visible = True
            txtEnd.Visible = True
            lblBegin.Visible = False
            lblEnd.Visible = False
        Next
        divNextButton.Visible = False
        divTopHeader.Visible = False
        btnCancelCompanyAdmin.Visible = True
        btnSaveCompanyAdmin.Visible = True
        btnAddCompanyAdmin.Visible = False
        btnEditCompanyAdmin.Visible = False
    End Sub

    Protected Sub btnCancelCompanyAdmin_Click() Handles btnCancelCompanyAdmin.Click
        'revert back to original data
        Dim dsCompany As New DataSet
        c.Load_AdminEnrollerCompany_List(Session("ShadowAdminId"), Session("UserId"), Session("Athena"), dsCompany)

        grdCurrentCompanies.DataSource = dsCompany.Tables(0)
        grdCurrentCompanies.DataBind()
        grdAssignNewCompany.DataSource = dsCompany.Tables(1)
        grdAssignNewCompany.DataBind()

        btnCancelCompanyAdmin.Visible = False
        btnSaveCompanyAdmin.Visible = False
        btnAddCompanyAdmin.Visible = True
        btnEditCompanyAdmin.Visible = True

        PopulateCompanyInfo()
        GetAdminRights()
        FillAdminLists()

        divNextButton.Visible = True
        divTopHeader.Visible = True
    End Sub

    'Current Company Admin Save button
    Protected Sub btnSaveCompanyAdmin_Click() Handles btnSaveCompanyAdmin.Click
        'Loop thru grid and write new records to db
        Dim gvr As GridViewRow
        Dim i As Int32
        'deselect all radiobutton in gridview
        For Each gvr In grdCurrentCompanies.Rows
            Dim txtB As TextBox = DirectCast(gvr.FindControl("txtBeginDate"), TextBox)
            Dim txtE As TextBox = DirectCast(gvr.FindControl("txtEndDate"), TextBox)
            Dim intCompanyId As Integer
            Dim intCompanyAdminId As Integer
            intCompanyAdminId = grdCurrentCompanies.DataKeys(i).Values("CompanyAdminId")
            intCompanyId = grdCurrentCompanies.DataKeys(i).Values("CompanyId")
            c.SaveCompanyAdmin(intCompanyAdminId, Session("ShadowAdminId"), intCompanyId, txtB.Text, txtE.Text)
            i += 1
        Next

        Dim dsCompany As New DataSet
        c.Load_AdminEnrollerCompany_List(Session("ShadowAdminId"), Session("UserId"), Session("Athena"), dsCompany)

        grdCurrentCompanies.DataSource = dsCompany.Tables(0)
        grdCurrentCompanies.DataBind()
        grdAssignNewCompany.DataSource = dsCompany.Tables(1)
        grdAssignNewCompany.DataBind()

        btnCancelCompanyAdmin.Visible = False
        btnSaveCompanyAdmin.Visible = False
        btnAddCompanyAdmin.Visible = True
        btnEditCompanyAdmin.Visible = True
        divAdminList.Visible = True

        PopulateCompanyInfo()
        GetAdminRights()
        FillAdminLists()

    End Sub

    'MODAL SAVE BUTTON
    Protected Sub mbtnSave_Click() Handles mbtnSave.Click
        'Loop thru grid and write new records to db
        Dim gvr As GridViewRow
        Dim i As Int32
        'deselect all radiobutton in gridview
        For Each gvr In grdAssignNewCompany.Rows
            Dim chk As CheckBox = DirectCast(gvr.FindControl("chkAssign"), CheckBox)
            If chk.Checked = True Then
                Dim intNewCompanyId As Integer
                intNewCompanyId = grdAssignNewCompany.DataKeys(i).Values("CompanyId")
                c.SaveCompanyAdmin(0, Session("ShadowAdminId"), intNewCompanyId, "01/01/1900", "12/31/2099")
            End If
            i += 1
        Next


        Dim dsCompany As New DataSet
        c.Load_AdminEnrollerCompany_List(Session("ShadowAdminId"), Session("UserId"), Session("Athena"), dsCompany)

        grdCurrentCompanies.DataSource = dsCompany.Tables(0)
        grdCurrentCompanies.DataBind()
        grdAssignNewCompany.DataSource = dsCompany.Tables(1)
        grdAssignNewCompany.DataBind()


        btnCancelCompanyAdmin.Visible = False
        btnSaveCompanyAdmin.Visible = False
        btnAddCompanyAdmin.Visible = True
        btnEditCompanyAdmin.Visible = True

        PopulateCompanyInfo()
        GetAdminRights()
        FillAdminLists()
    End Sub

#End Region

    Protected Sub txtOffice_TextChanged(sender As Object, e As EventArgs)
        If txtOffice.Text <> "" Then
            txtOffice.Text = txtOffice.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", "")
            txtOffice.Text = txtOffice.Text.Substring(0, 3) + "-" + txtOffice.Text.Substring(3, 3) + "-" + txtOffice.Text.Substring(6, 4)
        End If
    End Sub

    Protected Sub txtMobile_TextChanged(sender As Object, e As EventArgs)
        If txtMobile.Text <> "" Then
            txtMobile.Text = txtMobile.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", "")
            txtMobile.Text = txtMobile.Text.Substring(0, 3) + "-" + txtMobile.Text.Substring(3, 3) + "-" + txtMobile.Text.Substring(6, 4)
        End If
    End Sub

    Protected Sub txtFax_TextChanged(sender As Object, e As EventArgs)
        If txtFax.Text <> "" Then
            txtFax.Text = txtFax.Text.Replace("(", "").Replace(")", "").Replace("-", "").Replace(" ", "").Replace(".", "")
            txtFax.Text = txtFax.Text.Substring(0, 3) + "-" + txtFax.Text.Substring(3, 3) + "-" + txtFax.Text.Substring(6, 4)
        End If
    End Sub

    Protected Sub mbtnResetSave_Click(sender As Object, e As ImageClickEventArgs) Handles mbtnResetSave.Click

        'Save procedure here
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()
        Try
            objParam = New SqlParameter("@AdminId", lblAdminId.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@UserId", Session("UserId"))
            aryParams.Add(objParam)

            sqlCon.ExecuteNonQuery("[usp_Admin_Security_Reset]", aryParams)
            sqlCon.CloseConn()

            aryParams = Nothing
            sqlCon = Nothing

            'Save to Transaction Table
            s.SaveUserUpdate(Session("UserId"), strScreenShortDesc, "Saved on Security Reset" + " for AdminId " + lblAdminId.Text, 0, 0, 0, "01/01/1900", 0)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

    End Sub

    Protected Sub btnSend_Click(sender As Object, e As EventArgs)
        If txtAdminEmailSubject.Text = "" Or txtAdminEmailBody.Text = "" Or txtAdminFromEmail.Text = "" Or txtAdminEmailTo.Text = "" Then
            lblError.Text = "Please complete at least From - To - Subject - and Body"
            divError.Visible = True
            txtAdminEmailSubject.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtAdminEmailBody.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtAdminFromEmail.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtAdminEmailTo.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            Exit Sub
        End If

        If divError.Visible = False Then

            txtAdminEmailSubject.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtAdminEmailBody.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtAdminFromEmail.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtAdminEmailTo.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            lblError.Text = ""

            'Save Email 
            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()
            Try
                objParam = New SqlParameter("@SenderAppCode", "AdminWelcomeEmail")
                aryParams.Add(objParam)
                objParam = New SqlParameter("@AdminId", lblAdminId.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@UserId", Session("UserId"))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Subject", txtAdminEmailSubject.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Body", txtAdminEmailBody.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ReplyTo", txtAdminFromEmail.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ToList", txtAdminEmailTo.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@CCList", txtAdminCC.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@BCCList", txtAdminBCC.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Logo", imgLogo.AlternateText)
                aryParams.Add(objParam)

                sqlCon.ExecuteNonQuery("[usp_Email_Send]", aryParams)
                sqlCon.CloseConn()

                aryParams = Nothing
                sqlCon = Nothing

                'Save to Transaction Table
                s.SaveUserUpdate(Session("UserId"), strScreenShortDesc, "Generated Email to AdminId " + lblAdminId.Text, 0, 0, 0, "01/01/1900", 0)


            Catch ex As Exception
                Throw New Exception(ex.Message)
            End Try
        End If
    End Sub

    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ShadowCompanyId") = ddlCompany.SelectedValue
        intCompanyId = Session("ShadowCompanyId")

        PopulateCompanyInfo()
        GetAdminRights()
        FillAdminLists()

        s.SaveUserBrowse(Session("UserId"), strScreenName, "Browsed on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString)

    End Sub

    Protected Sub chkActive_CheckedChanged(sender As Object, e As EventArgs)
        Session("ActiveCompany") = IIf(chkActive.Checked = True, 1, 0)

        Session("ShadowCompanyId") = 0
        intCompanyId = 0

        PopulateCompanyInfo()
        GetAdminRights()
        FillAdminLists()

        s.SaveUserBrowse(Session("UserId"), strScreenName, "Browsed on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString)

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Session.Remove("AddNew")
        Response.Redirect("~/Admin_CompanyManageDocument.aspx")
    End Sub

End Class