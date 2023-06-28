Imports System.Data.SqlClient

Partial Class Admin_CompanyBusinessRules
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
        strScreenName = "BusinessRules"
        strScreenShortDesc = "Company Business Rules"

        If Page.IsPostBack = False Then
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_CompanyBusinessRules")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), 0, "Admin_CompanyBusinessRules", Session("Athena"))

            'Hide Edit Areas
            divEdit.Visible = False

            PopulateCompanyInfo()
            PopulateBusinessRules()

            s.SaveUserBrowse(Session("UserId"), strScreenName, "Browsed on " + strScreenShortDesc + " for CompanyId " + intCompanyId.ToString)

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

    Private Sub PopulateBusinessRules()

        If Session("Athena") = True Then
            divInvoicing.Visible = True
        Else
            divInvoicing.Visible = False
        End If

        'Fill Period drop downs
        c.Load_Period_List(ddlInitialWait)
        c.Load_Period_List(ddlRehireWait)
        c.LoadPayFrequency(ddlDefaultPayFrequency)
        c.LoadPayFrequency(ddlDefaultDeductionFrequency)

        ddlInitialWait.Items.Insert(0, New ListItem(""))
        ddlRehireWait.Items.Insert(0, New ListItem(""))
        ddlDefaultPayFrequency.Items.Insert(0, New ListItem(""))
        ddlDefaultDeductionFrequency.Items.Insert(0, New ListItem(""))

        If c.GetCompanyInfo(intCompanyId, Session("UserId")) = True Then
            lblInitialWait.Text = c.InitialWaitPeriod
            lblRehireWait.Text = c.RehireWaitPeriod
            lblDefaultPayFrequency.Text = c.DefaultPayFrequency
            lblDefaultDeductionFrequency.Text = c.DefaultDeductionFrequency
            lblIEDaysPre.Text = c.IEDaysPre
            lblIEDaysPost.Text = c.IEDaysPost
            lblOEBegin.Text = c.OEBegin
            lblOEEnd.Text = c.OEEnd
            lblOEEffectiveDate.Text = c.OEEffective
            lblPreTax.Text = IIf(c.SubjectToPretaxRule = True, "Yes", "No")
            lblResourceInfo.Text = c.ResourceInfoForDisplay
            lblBilledCompany.Text = c.BilledCompany
            lblEmailForInvoicing.Text = c.EmailForInvoicing
            lblNotes.Text = c.Notes
            txtIEDaysPre.Text = c.IEDaysPre
            txtIEDaysPost.Text = c.IEDaysPost
            txtOEBegin.Text = c.OEBegin
            txtOEEnd.Text = c.OEEnd
            txtOEEffectiveDate.Text = c.OEEffective
            rbPreTax.SelectedValue = c.SubjectToPretaxRule
            txtResourceInfo.Text = c.ResourceInfoForDisplay
            txtEmailforInvoice.Text = c.EmailForInvoicing
            ddlInitialWait.SelectedValue = c.InitialWaitPeriodId
            ddlRehireWait.SelectedValue = c.RehireWaitPeriodId
            ddlDefaultPayFrequency.SelectedValue = c.DefaultPayFrequencyId
            ddlDefaultDeductionFrequency.SelectedValue = c.DefaultDeductionFrequencyId
            LblShowEmployerRates.Text = IIf(c.ShowERRates = False, "No", "Yes")
            ChkShowERRates.Checked = c.ShowERRates

            If Session("Athena") = True Then
                ddlBilledCompany.SelectedValue = c.BilledCompanyId
                lblBilledCompany.Text = c.BilledCompany
            End If

            txtNotes.Text = c.Notes

            'if Company has inherited Parent Details, then show lable
            If c.InheritParentDetail = True Then
                lblInherit.Text = "<span class='glyphicon glyphicon-ok text-sucess' aria-hidden='True'></span>&nbsp; Details are inherited from Parent Company <strong>" + c.ParentCompany + ".</strong><br/>Any changes to the information will automatically disinherit the detail information from the parent company."
            Else
                lblInherit.Text = ""
            End If

            'Populate Child Companies if applicable
            Dim NumChildren As Integer
            c.LoadChildCompanyDetail(intCompanyId, Session("UserId"), grdChildCompanies, NumChildren)
            If NumChildren > 0 Then
                lblCompanyNameB.Text = c.LongDesc
                divChild.Visible = True
                Session("HasChildren") = True
            Else
                divChild.Visible = False
                Session("HasChildren") = False
            End If

            'first clear both grids
            grdOEExceptions.DataSource = Nothing
            grdOEExceptions.DataBind()

            grdOEExceptionEdit.DataSource = Nothing
            grdOEExceptionEdit.DataBind()

            'Fill up DataList and Data Grid with OEExceptions
            Session("ds") = New DataSet
            c.LoadCompanyOE(intCompanyId, Session("ds"))
            If Session("ds").Tables(0).Rows.Count > 0 Then
                grdOEExceptions.DataSource = Session("ds").tables(0)
                grdOEExceptions.DataBind()
                pnlOEExceptions.Visible = True
                'edit panel
                grdOEExceptionEdit.DataSource = Session("ds").tables(0)
                grdOEExceptionEdit.DataBind()
            Else
                pnlOEExceptions.Visible = False
                pnlOEExceptionEdit.Visible = False
            End If

        Else
            ClearFields()
        End If
    End Sub

    Private Sub ClearFields()
        lblInitialWait.Text = ""
        lblRehireWait.Text = ""
        lblIEDaysPre.Text = ""
        lblIEDaysPost.Text = ""
        lblOEBegin.Text = ""
        lblOEEnd.Text = ""
        lblPreTax.Text = ""
        'lblACARules.Text = ""
        'lblContractDate.Text = ""
        lblResourceInfo.Text = ""
        lblBilledCompany.Text = ""
        lblEmailForInvoicing.Text = ""
        lblBilledCompany.Text = ""
        lblNotes.Text = ""
        lblEmailForInvoicing.Text = ""
        lblInherit.Text = ""

    End Sub

    Protected Sub btnEditRules_Click(sender As Object, e As EventArgs) Handles btnEditRules.Click
        divNextButton.Visible = False
        divTopHeader.Visible = False
        divBusinessRules.Visible = False
        divEdit.Visible = True
        divChild.Visible = False
    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        PopulateCompanyInfo()

        divNextButton.Visible = True
        divTopHeader.Visible = True
        divBusinessRules.Visible = True
        divEdit.Visible = False
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        intCompanyId = ddlCompany.SelectedValue

        'Save Business Rule Info 
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        objParam = New SqlParameter("@CompanyId", ddlCompany.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@InitialWaitPeriodId", ddlInitialWait.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@RehireWaitPeriodId", ddlRehireWait.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DefaultPayFrequencyId", ddlDefaultPayFrequency.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DefaultDeductionFrequencyId", ddlDefaultDeductionFrequency.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@IEDaysPre", txtIEDaysPre.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@IEDaysPost", txtIEDaysPost.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@OEBegin", txtOEBegin.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@OEEnd", txtOEEnd.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@OEEffectiveDate", txtOEEffectiveDate.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@SubjectToPretaxRule", rbPreTax.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@ResourceInfoForDisplay", txtResourceInfo.Text)
        aryParams.Add(objParam)

        objParam = New SqlParameter("@EmailForInvoicing", txtEmailforInvoice.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@InheritParentDetail", 0)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@ShowERRates", IIf(ChkShowERRates.Checked = False, 0, 1))
        aryParams.Add(objParam)

        If Session("Athena") = True Then
            objParam = New SqlParameter("@BilledCompanyId", ddlBilledCompany.SelectedValue)
            aryParams.Add(objParam)
        End If

        objParam = New SqlParameter("@Notes", txtNotes.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@UserId", Session("UserId"))
        aryParams.Add(objParam)

        objDataSet = sqlCon.CreateDataSet("[usp_Company_Detail_Edit]", aryParams)
        sqlCon.CloseConn()

        'Save to Transaction Table
        s.SaveUserUpdate(Session("UserId"), strScreenShortDesc, "Saved on " + strScreenShortDesc + " for CompanyId " + intCompanyId.ToString, 0, 0, 0, "01/01/1900", 0)

        'If there are child companies that inherit the rules then those must be updated as well
        If Session("HasChildren") = True Then
            Dim gvr As GridViewRow

            For Each gvr In grdChildCompanies.Rows
                Dim cb As CheckBox
                Dim x As Integer
                cb = CType(grdChildCompanies.Rows(x).FindControl("chkInherit"), CheckBox)

                If cb.Checked = True Then
                    Dim ParentCompanyId As Object = grdChildCompanies.DataKeys(x).Values("ParentCompanyId")
                    Dim ChildCompanyId As Object = grdChildCompanies.DataKeys(x).Values("ChildCompanyId")
                    c.UpdateCompanyInheritDetail(ChildCompanyId, ParentCompanyId, cb.Checked, Session("UserId"))
                End If
                x += 1
            Next

        End If

        PopulateCompanyInfo()
        PopulateBusinessRules()

        divNextButton.Visible = True
        divTopHeader.Visible = True
        divBusinessRules.Visible = True
        divEdit.Visible = False
    End Sub

    Protected Sub chkInherit_CheckedChanged(sender As Object, e As EventArgs)
        Dim cb As CheckBox = DirectCast(sender, CheckBox)
        Dim gr As GridViewRow = CType(cb.NamingContainer, GridViewRow)

        Dim gv As GridView = gr.NamingContainer

        Dim keys As DataKey = gv.DataKeys(gr.DataItemIndex)
        Dim ParentCompanyId As Object = keys("ParentCompanyId")
        Dim ChildCompanyId As Object = keys("ChildCompanyId")

        c.UpdateCompanyInheritDetail(ChildCompanyId, ParentCompanyId, cb.Checked, Session("UserId"))
    End Sub

    Protected Sub chkInheritAll_CheckedChanged(sender As Object, e As EventArgs)
        Dim cb As CheckBox = DirectCast(sender, CheckBox)

        'find the gridview, thenloop thru and do your stuff
        Dim gvr As GridViewRow

        For Each gvr In grdChildCompanies.Rows
            Dim cb1 As CheckBox
            Dim x As Integer
            cb1 = CType(grdChildCompanies.Rows(x).FindControl("chkInherit"), CheckBox)

            If cb1.Checked = False Then
                cb1.Checked = True
                Dim ParentCompanyId As Object = grdChildCompanies.DataKeys(x).Values("ParentCompanyId")
                Dim ChildCompanyId As Object = grdChildCompanies.DataKeys(x).Values("ChildCompanyId")
                c.UpdateCompanyInheritDetail(ChildCompanyId, ParentCompanyId, cb.Checked, Session("UserId"))
            End If
            x += 1
        Next
    End Sub

#Region "OEExceptions"
    Protected Sub grdOEExceptionEdit_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)
        Dim lnkEdit As LinkButton = DirectCast(e.Row.FindControl("lnkEdit"), LinkButton)
        Dim rowcolor = Drawing.ColorTranslator.FromHtml("#EFF3FB")

        If e.Row.RowType = DataControlRowType.DataRow Then
            'EDIT MODE
            '  ddlCompany.Enabled = False
            If (e.Row.RowState And DataControlRowState.Edit) > 0 Then
                e.Row.BackColor = rowcolor
                'Load Plan Type List
                Dim ddlPT As DropDownList = DirectCast(e.Row.FindControl("ddlPlanTypeGrid"), DropDownList)
                If Not ddlPT Is Nothing Then
                    c.Load_CompanyPlanTypeList(ddlCompany.SelectedValue, ddlPT)
                    ddlPT.Items.FindByValue(DataBinder.Eval(e.Row.DataItem, "Plantypeid")).Selected = True
                Else
                    pnlOEExceptionEdit.Visible = False
                End If

                'Load Month List
                Dim ddlM As DropDownList = DirectCast(e.Row.FindControl("ddlMonth"), DropDownList)
                If Not ddlM Is Nothing Then
                    ddlM.Items.Insert(0, New System.Web.UI.WebControls.ListItem("Jan", 1))
                    ddlM.Items.Insert(1, New System.Web.UI.WebControls.ListItem("Feb", 2))
                    ddlM.Items.Insert(2, New System.Web.UI.WebControls.ListItem("Mar", 3))
                    ddlM.Items.Insert(3, New System.Web.UI.WebControls.ListItem("Apr", 4))
                    ddlM.Items.Insert(4, New System.Web.UI.WebControls.ListItem("May", 5))
                    ddlM.Items.Insert(5, New System.Web.UI.WebControls.ListItem("Jun", 6))
                    ddlM.Items.Insert(6, New System.Web.UI.WebControls.ListItem("Jul", 7))
                    ddlM.Items.Insert(7, New System.Web.UI.WebControls.ListItem("Aug", 8))
                    ddlM.Items.Insert(8, New System.Web.UI.WebControls.ListItem("Sep", 9))
                    ddlM.Items.Insert(9, New System.Web.UI.WebControls.ListItem("Oct", 10))
                    ddlM.Items.Insert(10, New System.Web.UI.WebControls.ListItem("Nov", 11))
                    ddlM.Items.Insert(11, New System.Web.UI.WebControls.ListItem("Dec", 12))

                    ddlM.Items.FindByValue(DataBinder.Eval(e.Row.DataItem, "EffectiveMonth")).Selected = True
                End If

                'Load Allow 
                Dim ddlA As DropDownList = DirectCast(e.Row.FindControl("ddlAllow"), DropDownList)
                If Not ddlA Is Nothing Then
                    ddlA.Items.Insert(0, New System.Web.UI.WebControls.ListItem("True", 1))
                    ddlA.Items.Insert(1, New System.Web.UI.WebControls.ListItem("False", 0))
                    ddlA.Items.FindByText(DataBinder.Eval(e.Row.DataItem, "AllowOEPeriods")).Selected = True
                End If
            Else

                If DataBinder.Eval(e.Row.DataItem, "PlanType") = "Company currently does not have OE Exceptions" Then
                    lnkEdit.Visible = False
                End If

            End If

            e.Row.Attributes.Add("style", "cursor:pointer;")

        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            'Load Footer Plan Type List
            Dim ddlFPT As DropDownList = DirectCast(e.Row.FindControl("ddlNewPlanTypeGrid"), DropDownList)
            If Not ddlFPT Is Nothing Then
                c.Load_CompanyPlanTypeList(ddlCompany.SelectedValue, ddlFPT)
                ' ddlFPT.Items.Insert(0, New System.Web.UI.WebControls.ListItem("N/A", 0))
            End If

            'Load Footer Plan List
            Dim ddlFM As DropDownList = DirectCast(e.Row.FindControl("ddlNewMonth"), DropDownList)
            If Not ddlFM Is Nothing Then
                ddlFM.Items.Insert(0, New System.Web.UI.WebControls.ListItem("Jan", 1))
                ddlFM.Items.Insert(1, New System.Web.UI.WebControls.ListItem("Feb", 2))
                ddlFM.Items.Insert(2, New System.Web.UI.WebControls.ListItem("Mar", 3))
                ddlFM.Items.Insert(3, New System.Web.UI.WebControls.ListItem("Apr", 4))
                ddlFM.Items.Insert(4, New System.Web.UI.WebControls.ListItem("May", 5))
                ddlFM.Items.Insert(5, New System.Web.UI.WebControls.ListItem("Jun", 6))
                ddlFM.Items.Insert(6, New System.Web.UI.WebControls.ListItem("Jul", 7))
                ddlFM.Items.Insert(7, New System.Web.UI.WebControls.ListItem("Aug", 8))
                ddlFM.Items.Insert(8, New System.Web.UI.WebControls.ListItem("Sep", 9))
                ddlFM.Items.Insert(9, New System.Web.UI.WebControls.ListItem("Oct", 10))
                ddlFM.Items.Insert(10, New System.Web.UI.WebControls.ListItem("Nov", 11))
                ddlFM.Items.Insert(11, New System.Web.UI.WebControls.ListItem("Dec", 12))
                ' ddlFM.Items(0).Selected = True
            End If

            Dim ddlFA As DropDownList = DirectCast(e.Row.FindControl("ddlNewAllow"), DropDownList)
            If Not ddlFA Is Nothing Then
                ddlFA.Items.Insert(0, New System.Web.UI.WebControls.ListItem("True", 1))
                ddlFA.Items.Insert(1, New System.Web.UI.WebControls.ListItem("False", 0))
                ' ddlFA.Items(0).Selected = True
            End If


        End If
    End Sub

    Protected Sub grdOEExceptionEdit_RowEditing(sender As Object, e As GridViewEditEventArgs)
        grdOEExceptionEdit.EditIndex = e.NewEditIndex
        Session("ds") = New DataSet
        c.LoadCompanyOE(ddlCompany.SelectedValue, Session("ds"))
        grdOEExceptionEdit.DataSource = Session("ds").tables(0)
        grdOEExceptionEdit.DataBind()
    End Sub

    Protected Sub grdOEExceptionEdit_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs)
        grdOEExceptionEdit.EditIndex = -1
        Session("ds") = New DataSet
        c.LoadCompanyOE(ddlCompany.SelectedValue, Session("ds"))
        grdOEExceptionEdit.DataSource = Session("ds").tables(0)
        grdOEExceptionEdit.DataBind()
    End Sub

    Protected Sub grdOEExceptionEdit_RowUpdating(sender As Object, e As GridViewUpdateEventArgs)
        Dim intCompanyId = ddlCompany.SelectedValue
        Dim intSelectedOEId = grdOEExceptionEdit.DataKeys(e.RowIndex).Values("OEExceptionsId")


        Dim ddlPT As DropDownList = DirectCast(grdOEExceptionEdit.Rows(e.RowIndex).FindControl("ddlPlanTypeGrid"), DropDownList)
        Dim ddlMonth As DropDownList = DirectCast(grdOEExceptionEdit.Rows(e.RowIndex).FindControl("ddlMonth"), DropDownList)
        Dim ddlAllow As DropDownList = DirectCast(grdOEExceptionEdit.Rows(e.RowIndex).FindControl("ddlAllow"), DropDownList)


        'Save procedure here
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()
        Try

            objParam = New SqlParameter("@CompanyId", intCompanyId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@OEExceptionsId", intSelectedOEId)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@PlanTypeId", ddlPT.SelectedValue)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EffectiveMonth", ddlMonth.SelectedValue)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@Allow", ddlAllow.SelectedValue)
            aryParams.Add(objParam)


            sqlCon.ExecuteNonQuery("usp_Company_OEExceptions_Edit", aryParams)
            sqlCon.CloseConn()

            ' bresult = Comp.getAllDocumentsByCompany(ddlCompany.SelectedValue, grdDocument)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        'reLoad Exceptions
        grdOEExceptionEdit.EditIndex = -1
        Session("ds") = New DataSet
        c.LoadCompanyOE(ddlCompany.SelectedValue, Session("ds"))
        grdOEExceptionEdit.DataSource = Session("ds").tables(0)
        grdOEExceptionEdit.DataBind()
    End Sub

    Protected Sub grdOEExceptionEdit_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "Add" Then
            Dim intCompanyId = ddlCompany.SelectedValue



            Dim ddlPT As DropDownList = DirectCast(grdOEExceptionEdit.FooterRow.FindControl("ddlNewPlanTypeGrid"), DropDownList)
            Dim ddlMonth As DropDownList = DirectCast(grdOEExceptionEdit.FooterRow.FindControl("ddlNewMonth"), DropDownList)
            Dim ddlAllow As DropDownList = DirectCast(grdOEExceptionEdit.FooterRow.FindControl("ddlNewAllow"), DropDownList)


            'Save procedure here
            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()
            Try

                objParam = New SqlParameter("@CompanyId", intCompanyId)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@OEExceptionsId", 0)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@PlanTypeId", ddlPT.SelectedValue)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@EffectiveMonth", ddlMonth.SelectedValue)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@Allow", ddlAllow.SelectedValue)
                aryParams.Add(objParam)


                sqlCon.ExecuteNonQuery("usp_Company_OEExceptions_Edit", aryParams)
                sqlCon.CloseConn()

                ' bresult = Comp.getAllDocumentsByCompany(ddlCompany.SelectedValue, grdDocument)
            Catch ex As Exception
                Throw New Exception(ex.Message)
            End Try

            'reLoad Exceptions
            grdOEExceptionEdit.EditIndex = -1
            Session("ds") = New DataSet
            c.LoadCompanyOE(ddlCompany.SelectedValue, Session("ds"))
            grdOEExceptionEdit.DataSource = Session("ds").tables(0)
            grdOEExceptionEdit.DataBind()
        End If
    End Sub

#End Region

    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ShadowCompanyId") = ddlCompany.SelectedValue
        intCompanyId = Session("ShadowCompanyId")

        PopulateCompanyInfo()
        PopulateBusinessRules()

    End Sub

    Protected Sub chkActive_CheckedChanged(sender As Object, e As EventArgs)
        Session("ActiveCompany") = IIf(chkActive.Checked = True, 1, 0)

        Session("ShadowCompanyId") = 0
        intCompanyId = 0

        PopulateCompanyInfo()
        PopulateBusinessRules()

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Session.Remove("AddNew")
        Session.Remove("HasChildren")
        Response.Redirect("~/Admin_CompanyClass.aspx")
    End Sub

    Protected Sub ChkShowERRates_CheckedChanged(sender As Object, e As EventArgs)

    End Sub
End Class
