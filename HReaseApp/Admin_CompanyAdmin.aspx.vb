Imports System
Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Text
Imports System.IO
Imports System.Text.RegularExpressions
Partial Class Admin_CompanyAdmin
    Inherits System.Web.UI.Page

    Dim sc As New ScreenConfiguration
    Dim cc As New Company
    Dim EmpClass As New Employee
    Dim SecClass As New Security

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Remove Shadow info
        'Session.Remove("ShadowCompanyId")
        Session.Remove("ShadowEmployeeId")
        Session.Remove("ShadowEmployeeName")
        Session.Remove("ShadowEmployee")
        'Session.Remove("ShadowCompany")

        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        If Page.IsPostBack = False Then
            SecClass.SaveUserBrowse(Session("UserId"), "Administrators", "Browse")

            ltrTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_Welcome")
            ltrTab.Text = sc.BuildTabs(Session("Admin"), 0, "Admin_CompanyAdmin", Session("Athena"))

            'Fill up dropdowns
            cc.Load_AdminType_List(Session("UserId"), ddlAdminType)
            If ddlAdminType.Items.Count < 2 Then
                ddlAdminType.Visible = True
                PopulateCompanyInfo()
            Else
                ddlAdminType.Visible = True

                'pre select
                If Not ddlAdminType.Items.FindByText("SubCustomer") Is Nothing Then
                    ddlAdminType.Items.FindByText("SubCustomer").Selected = True
                    'Fill up Company Drop Down
                    PopulateCompanyInfo()
                    If Not Session("ShadowCompanyId") Is Nothing Then
                        ddlCompany.SelectedValue = Session("ShadowCompanyId")

                    End If
                Else
                    'Fill up Company Drop Down
                    PopulateCompanyInfo()
                    ddlAdminType.Items(0).Selected = True

                End If
                PopulateAdminList()
            End If

            cc.Load_RoleType_List(Session("UserId"), ddlRoleType)
            EmpClass.LoadState(ddlState)
            EmpClass.LoadCountry(ddlCountry)

            ddlState.Items.Insert(0, New ListItem(""))

            'Hide both Review and Edit Areas until first selection is made
            'divCompanies.Visible = False
            ' divReviewContact.Visible = False

            divEdit.Visible = False
            btnCancelCompanyAdmin.Visible = False
            btnSaveCompanyAdmin.Visible = False
        End If

    End Sub

    Private Sub PopulateCompanyInfo()
        'clear out admin list 
        ddlAdmins.Items.Clear()

        'once the AdminType is selected, then go get the appropriate companies for drop down
        cc.Load_AdminCompany_List(ddlAdminType.SelectedValue, Session("UserId"), Session("Athena"), ddlCompany)

        If ddlCompany.Items.Count < 2 Then
            '  ddlCompany.Items(0).Selected = True
            btnAddAdmin.Visible = True
            'then fill up Admin list
            PopulateAdminList()
        Else

            ddlCompany.Items.Insert(0, New ListItem("<< ALL >>", "0"))
            btnAddAdmin.Visible = False
            ' ddlCompany.Items(0).Selected = True
            'then fill up Admin list
            PopulateAdminList()
        End If


    End Sub

    Private Sub PopulateAdminList()
        cc.Load_Admin_List(ddlAdminType.SelectedValue, ddlCompany.SelectedValue, Session("UserId"), Session("Athena"), ddlAdmins)
        If ddlAdmins.Items.Count = 1 Then
            If ddlAdmins.Items(0).Value = 0 Then
                'no admins were found
                btnAddAdmin.Visible = True
                btnEditAdmin.Visible = False
                divReviewContact.Visible = True
                divCompanies.Visible = False
                ClearAdminInfo()
            Else
                PopulateAdminInfo()
                divReviewContact.Visible = True
                divCompanies.Visible = True

            End If
          
        Else
            ' there are multiple admins returned
            divCompanies.Visible = False
            ClearAdminInfo()
        End If
    End Sub

    Protected Sub ddlAdminType_SelectedIndexChanged(sender As Object, e As EventArgs)
        'once the AdminType is selected, then go get the appropriate companies for drop down
        ddlCompany.Items.Clear()
        PopulateCompanyInfo()
        'hide all areas until selections have been made
        If ddlAdmins.Items.Count > 1 Then
            divCompanies.Visible = False
            divReviewContact.Visible = False
        End If

        divEdit.Visible = False

    End Sub

    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        If ddlCompany.SelectedItem.Text = "<< ALL >>" Then
            'Hide ADD button
            btnAddAdmin.Visible = False
            btnEditAdmin.Visible = False
        Else
            btnAddAdmin.Visible = True
            btnEditAdmin.Visible = False
        End If
        divCompanies.Visible = False
        Session("ShadowCompanyId") = ddlCompany.SelectedValue
        PopulateAdminList()
    End Sub

    Protected Sub ddlAdmins_SelectedIndexChanged(sender As Object, e As EventArgs)
        If ddlAdmins.SelectedItem.Text = "<< Select Admin >>" Then
            'show ADD button hide Edit
            btnAddAdmin.Visible = True
            btnEditAdmin.Visible = False
            divCompanies.Visible = False

        ElseIf ddlAdmins.SelectedItem.Text = "<< No Admins Found >>" Then
            'show ADD button hide Edit
            btnAddAdmin.Visible = True
            btnEditAdmin.Visible = False
            divCompanies.Visible = False
        Else
            btnAddAdmin.Visible = True
            btnEditAdmin.Visible = True
            divCompanies.Visible = True
        End If

        PopulateAdminInfo()
    End Sub

    Private Sub PopulateAdminInfo()
        divCompanies.Visible = True
        divReviewContact.Visible = True
        btnAddAdmin.Visible = True
        btnEditAdmin.Visible = True
        lblErrorActive.Visible = False

        'EmpClass.GetAdminInfo(ddlCompany.SelectedValue, ddlAdmins.SelectedValue)

        Dim dsCompany As New DataSet
        ' cc.Load_AdminEnrollerCompany_List(ddlAdminType.SelectedValue, ddlAdmins.SelectedValue, Session("UserId"), Session("Athena"), dsCompany)

        grdCurrentCompanies.DataSource = dsCompany.Tables(0)
        grdCurrentCompanies.DataBind()

        'Also grab the first company from the Current list to default the top Company drop down list -- ONLY IF THE COMPANY DDL IS STILL ON ALL
        If ddlCompany.SelectedValue = 0 Then
            Dim DefaultCompanyId As Integer
            If dsCompany.Tables(0).Rows.Count > 0 Then
                DefaultCompanyId = dsCompany.Tables(0).Rows(0).Item("CompanyId")
                ddlCompany.SelectedValue = DefaultCompanyId
            End If
        End If


        grdAssignNewCompany.DataSource = dsCompany.Tables(1)
        grdAssignNewCompany.DataBind()


        If dsCompany.Tables(1).Rows.Count > 0 Then  'unassigned companies that the current user can see
            'Make the add Compnay admin button visible
            btnAddCompanyAdmin.Visible = True
        Else
            btnAddCompanyAdmin.Visible = False
        End If

        lblAdminName.Text = EmpClass.FullName
        lblAdminType.Text = EmpClass.AdminType
        lblRoleType.Text = EmpClass.RoleType
        lblWorkPhone.Text = EmpClass.WorkPhone
        lblExtension.Text = EmpClass.Extension
        lblMobile.Text = EmpClass.MobilePhone
        lblEmail.Text = EmpClass.PrimaryEmail
        lblRegion.Text = EmpClass.Region
        lblAddress.Text = EmpClass.Address1
        lblAddress2.Text = EmpClass.Address2
        lblZip.Text = EmpClass.Zip
        lblZipExtension.Text = EmpClass.ZipExtension
        lblState.Text = EmpClass.State
        lblCity.Text = EmpClass.City
        lblCountry.Text = EmpClass.Country
        lblActive.Text = IIf(EmpClass.Active = True, "Yes", "No")
        lblAdminBeginDate.Text = EmpClass.BeginDate
        lblAdminEndDate.Text = IIf(EmpClass.EndDate = "12/31/2999", "", EmpClass.EndDate)

        'LastLogin = obj
        'Group = objData
        lblAdminId.Text = ddlAdmins.SelectedValue
        lblAdminId.Visible = True
        txtFirstName.Text = EmpClass.FirstName
        txtLastName.Text = EmpClass.LastName
        lblEAdminType.Text = ddlAdminType.SelectedItem.Text
        txtOffice.Text = EmpClass.WorkPhone
        txtExtension.Text = EmpClass.Extension
        txtMobile.Text = EmpClass.MobilePhone
        txtFax.Text = EmpClass.Fax
        txtEmail.Text = EmpClass.PrimaryEmail
        txtRegion.Text = EmpClass.Region
        txtAddress1.Text = EmpClass.Address1
        txtAddress2.Text = EmpClass.Address2
        txtCity.Text = EmpClass.City
        txtZip.Text = EmpClass.Zip
        txtZipExt.Text = EmpClass.ZipExtension
        txtAdminBeginDate.Text = EmpClass.BeginDate
        txtAdminEndDate.Text = IIf(EmpClass.EndDate = "12/31/2999", "", EmpClass.EndDate)
        chkActive.Checked = EmpClass.Active
        ddlState.SelectedValue = EmpClass.State
        ddlCountry.SelectedValue = IIf(EmpClass.Country <> "", EmpClass.Country, "USA")
        ddlRoleType.SelectedValue = IIf(EmpClass.RoleTypeId <> "", EmpClass.RoleTypeId, "1")

    End Sub

    Private Sub ClearAdminInfo()
        lblAdminId.Text = "0"
        lblAdminName.Text = ""
        lblAdminType.Text = ""
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
        lblActive.Text = ""
        lblAdminBeginDate.Text = ""
        lblAdminEndDate.Text = ""

        lblAdminId.Text = 0
        lblAdminId.Visible = False
        txtFirstName.Text = ""
        txtLastName.Text = ""
        lblEAdminType.Text = ddlAdminType.SelectedItem.Text
        txtOffice.Text = ""
        txtExtension.Text = ""
        txtMobile.Text = ""
        txtFax.Text = ""
        txtEmail.Text = ""
        txtRegion.Text = ""
        txtAddress1.Text = ""
        txtAddress2.Text = ""
        txtCity.Text = ""
        txtZip.Text = ""
        txtZipExt.Text = ""
        txtAdminBeginDate.Text = ""
        txtAdminEndDate.Text = ""
        chkActive.Checked = True
        ddlState.SelectedValue = ""
        ddlCountry.SelectedValue = "USA"
        ddlRoleType.SelectedValue = "1"

        'Clear Company section

        grdAssignNewCompany.DataSource = Nothing
        grdAssignNewCompany.DataBind()

        grdCurrentCompanies.DataSource = Nothing
        grdCurrentCompanies.DataBind()



    End Sub

    Protected Sub btnAddAdmin_Click(sender As Object, e As EventArgs) Handles btnAddAdmin.Click
        ClearAdminInfo()
        divReviewPick.Visible = False
        divReviewContact.Visible = False
        divEdit.Visible = True
        divCompanies.Visible = False

        'should default Address to the company's stuff
        cc.GetCompanyInfo(ddlCompany.SelectedValue, Session("UserId"))
        txtAddress1.Text = cc.Address1
        txtAddress2.Text = cc.Address2
        txtCity.Text = cc.City
        txtZip.Text = cc.Zip
        txtZipExt.Text = cc.ZipExtension
        ddlState.SelectedValue = cc.State
        ddlCountry.SelectedValue = IIf(EmpClass.Country <> "", cc.Country, "USA")

    End Sub

    Protected Sub btnEditAdmin_Click(sender As Object, e As EventArgs) Handles btnEditAdmin.Click
        divReviewPick.Visible = False
        divReviewContact.Visible = False
        divEdit.Visible = True
        divCompanies.Visible = False
        imgNext.Visible = False
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        PopulateAdminInfo()
        divReviewPick.Visible = True
        divReviewContact.Visible = True
        divCompanies.Visible = True
        divEdit.Visible = False
        imgNext.Visible = True
    End Sub

    Protected Sub UpdateEndDate(sender As Object, e As EventArgs)
        If RTrim(txtAdminEndDate.Text) <> "" Then
            If txtAdminEndDate.Text < Now Then
                chkActive.Checked = False
                lblErrorActive.Visible = True
                lblErrorActive.Text = "<strong>Please Note:  </strong>Updating the End Date will prohibit the user from logging into the system."
            Else
                chkActive.Checked = True
                lblErrorActive.Visible = False
            End If

        Else
            chkActive.Checked = True
            lblErrorActive.Visible = False
        End If
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
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

            'Save Admin Info
            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()

            objParam = New SqlParameter("@AdminId", lblAdminId.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@AdminTypeId", ddlAdminType.SelectedValue)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@CompanyId", ddlCompany.SelectedValue)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@RoleTypeId", ddlRoleType.SelectedValue)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@FirstName", txtFirstName.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@LastName", txtLastName.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Region", txtRegion.Text)
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
            objParam = New SqlParameter("@WorkPhone", txtOffice.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@WorkExt", txtExtension.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@MobilePhone", txtMobile.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Fax", txtFax.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Email", txtEmail.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@BeginDate", txtAdminBeginDate.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EndDate", IIf(Trim(txtAdminEndDate.Text) = "", "12/31/2999", txtAdminEndDate.Text))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Active", chkActive.Checked)
            aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("[usp_Admin_Edit]", aryParams)


            If objDataSet.Tables(0).Rows.Count > 0 Then
                Dim LastSavedAdminId As Integer
                LastSavedAdminId = objDataSet.Tables(0).Rows(0).Item("LastSavedAdminId")
                PopulateAdminList()
                Try
                    ddlAdmins.SelectedValue = LastSavedAdminId
                Catch ex As Exception
                    Throw New Exception(ex.Message)

                End Try
            End If
            sqlCon.CloseConn()

        End If

        PopulateAdminInfo()
        divReviewPick.Visible = True
        divReviewContact.Visible = True
        divCompanies.Visible = True
        divEdit.Visible = False
        btnSaveCompanyAdmin.Visible = False
        imgNext.Visible = True
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
        btnCancelCompanyAdmin.Visible = True
        btnSaveCompanyAdmin.Visible = True
        btnAddCompanyAdmin.Visible = False
        btnEditCompanyAdmin.Visible = False
    End Sub


    Protected Sub btnCancelCompanyAdmin_Click() Handles btnCancelCompanyAdmin.Click
        'revert back to original data
        Dim dsCompany As New DataSet
        '  cc.Load_AdminEnrollerCompany_List(ddlAdminType.SelectedValue, ddlAdmins.SelectedValue, Session("UserId"), Session("Athena"), dsCompany)

        grdCurrentCompanies.DataSource = dsCompany.Tables(0)
        grdCurrentCompanies.DataBind()
        grdAssignNewCompany.DataSource = dsCompany.Tables(1)
        grdAssignNewCompany.DataBind()


        btnCancelCompanyAdmin.Visible = False
        btnSaveCompanyAdmin.Visible = False
        btnAddCompanyAdmin.Visible = True
        btnEditCompanyAdmin.Visible = True
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
            cc.SaveCompanyAdmin(intCompanyAdminId, ddlAdmins.SelectedValue, intCompanyId, txtB.Text, txtE.Text)
            i += 1
        Next


        Dim dsCompany As New DataSet
        '  cc.Load_AdminEnrollerCompany_List(ddlAdminType.SelectedValue, ddlAdmins.SelectedValue, Session("UserId"), Session("Athena"), dsCompany)

        grdCurrentCompanies.DataSource = dsCompany.Tables(0)
        grdCurrentCompanies.DataBind()
        grdAssignNewCompany.DataSource = dsCompany.Tables(1)
        grdAssignNewCompany.DataBind()


        btnCancelCompanyAdmin.Visible = False
        btnSaveCompanyAdmin.Visible = False
        btnAddCompanyAdmin.Visible = True
        btnEditCompanyAdmin.Visible = True

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
                cc.SaveCompanyAdmin(0, ddlAdmins.SelectedValue, intNewCompanyId, "01/01/1900", "12/31/2099")
            End If
            i += 1
        Next


        Dim dsCompany As New DataSet
        ' cc.Load_AdminEnrollerCompany_List(ddlAdminType.SelectedValue, ddlAdmins.SelectedValue, Session("UserId"), Session("Athena"), dsCompany)

        grdCurrentCompanies.DataSource = dsCompany.Tables(0)
        grdCurrentCompanies.DataBind()
        grdAssignNewCompany.DataSource = dsCompany.Tables(1)
        grdAssignNewCompany.DataBind()


        btnCancelCompanyAdmin.Visible = False
        btnSaveCompanyAdmin.Visible = False
        btnAddCompanyAdmin.Visible = True
        btnEditCompanyAdmin.Visible = True

    End Sub
    'Protected Sub chkAssign_CheckedChanged(sender As Object, e As EventArgs)
    '    Dim chkAssign As CheckBox = sender
    '    Dim gr As GridViewRow = chkAssign.Parent.Parent
    '    Dim CompanyId As Object = grdAssignNewCompany.DataKeys(gr.RowIndex).Values("CompanyId")

    '    'Dim chkStandard As CheckBox = DirectCast(gr.FindControl("chkStandard"), CheckBox)
    '    'Dim chkHide As CheckBox = DirectCast(gr.FindControl("chkHide"), CheckBox)

    '    'If chkDashboard.Checked = True And chkHide.Checked = True Then
    '    '    chkFavorite.Checked = False
    '    '    chkStandard.Checked = True
    '    '    chkHide.Checked = False
    '    'End If

    '    ''Save Preferences
    '    'ReportClass.SaveAdminPreferences(ReportPermissionId, chkDashboard.Checked, chkFavorite.Checked, chkHide.Checked)

    'End Sub
#End Region

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs) Handles imgNext.Click
        Session.Remove("AddNew")
        Response.Redirect("~/Admin_CompanyManageDocument.aspx")
    End Sub
End Class