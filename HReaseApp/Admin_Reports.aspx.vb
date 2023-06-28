Imports System
Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Text
Imports System.IO
Imports System.Text.RegularExpressions
Imports iTextSharp.text
Imports iTextSharp.text.pdf
Imports iTextSharp.text.html
Imports iTextSharp.text.html.simpleparser
Imports ClosedXML.Excel

Partial Class Admin_Reports
    Inherits System.Web.UI.Page
    Dim EmpClass As New Employee
    Dim DepClass As New Dependent
    Dim SecClass As New Security
    Dim ReportClass As New Reports
    Dim c As New Company
    Dim PlanClass As New Plans
    Dim sc As New ScreenConfiguration
    Dim strPurpose As String

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        'divNoResults.Visible = False

        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        If Page.IsPostBack = False Then
            SecClass.SaveUserBrowse(Session("UserId"), "Reporting", "Browse")
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_Reports")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), 0, "Admin_Reports", Session("Athena"))

            'Remove Shadow info
            'Session.Remove("ShadowCompanyId")
            Session.Remove("ShadowEmployeeId")
            Session.Remove("ShadowEmployeeName")
            Session.Remove("ShadowEmployee")
            Session.Remove("ShadowCompany")
            Session.Remove("ViewName")

            'Fill Favorite and Standard Report Lists and put list in Session
            Session("dsFavs") = New DataSet
            ReportClass.Load_ReportList(Session("UserId"), Session("Athena"), "Favorite", lstFavorite, Session("dsFavs"))
            Session("dsReports") = New DataSet
            ReportClass.Load_ReportList(Session("UserId"), Session("Athena"), "Standard", lstReports, Session("dsReports"))

            'Fill up DataGrid (in case user wants to edit list)
            ReportClass.Load_ReportEditGrid(Session("UserId"), Session("Athena"), "All", grdReports)

            'Page.Form.DefaultButton = btnExcel.UniqueID
        End If

    End Sub


#Region "Click on Favorite or Standard Report List"
    Protected Sub lstFavs_ItemCommand(ByVal sender As Object, e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles lstFavorite.ItemCommand
        divCriteria.Visible = True

        If TypeOf (e.CommandSource) Is System.Web.UI.WebControls.LinkButton Then
            Dim lnkbtn As LinkButton = CType(e.CommandSource, LinkButton)
            Dim ReportId As Int64 = lnkbtn.CommandArgument

            Dim dvReports As New DataView(Session("dsFavs").Tables(0), "", "ReportId", DataViewRowState.CurrentRows)
            Dim rowindex As Integer = dvReports.Find(New Object() {ReportId})
            If rowindex <> -1 Then
                'Fillup Parameter gridview
                ReportClass.Load_ReportParameters(ReportId, grdCriteria)
                Session("OrderId") = 1
                'Capture ViewName and put in session
                Session("ViewName") = dvReports(rowindex)("ViewName").ToString()
                'Title
                lblReportName.Text = dvReports(rowindex)("ShortDesc").ToString()
            End If

            If grdCriteria.Rows.Count > 0 Then
                Session("Parameter") = True
                lblCriteriaText.Visible = True
            Else
                lblCriteriaText.Visible = False
                Session("Parameter") = False
                'and just run the report...
            End If
            Session("OrderBy") = ""
        End If

    End Sub

    Protected Sub lstReports_ItemCommand(ByVal sender As Object, e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles lstReports.ItemCommand
        ' divNoResults.Visible = False
        divCriteria.Visible = True
        If TypeOf (e.CommandSource) Is System.Web.UI.WebControls.LinkButton Then
            Dim lnkbtn As LinkButton = CType(e.CommandSource, LinkButton)
            Dim ReportId As Int64 = lnkbtn.CommandArgument

            Dim dvReports As New DataView(Session("dsReports").Tables(0), "", "ReportId", DataViewRowState.CurrentRows)
            Dim rowindex As Integer = dvReports.Find(New Object() {ReportId})
            If rowindex <> -1 Then
                'Fillup Parameter gridview
                ReportClass.Load_ReportParameters(ReportId, grdCriteria)
                Session("OrderId") = 1
                'Capture ViewName and put in session
                Session("ViewName") = dvReports(rowindex)("ViewName").ToString()
                'Title
                lblReportName.Text = dvReports(rowindex)("ShortDesc").ToString()
            End If

            If grdCriteria.Rows.Count > 0 Then
                Session("Parameter") = True
                lblCriteriaText.Visible = True
            Else
                lblCriteriaText.Visible = False
                Session("Parameter") = False
                'and just run the report...
            End If
            Session("OrderBy") = ""
        End If

    End Sub
#End Region

#Region "Load Criteria Gridview"
    Protected Sub grdCriteria_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdCriteria.RowDataBound
        'Adding in Contribution Button to Options Grid
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim keys As DataKey = grdCriteria.DataKeys(e.Row.RowIndex)
            Dim ReportParameterId As Object = keys("ReportParameterId")
            Dim ViewName As Object = keys("ViewName")
            Dim ColumnName As Object = keys("ColumnName")
            Dim DataType As Object = keys("DataType")

            Dim ddlOperator As DropDownList = DirectCast(e.Row.FindControl("ddlOperator"), DropDownList)
            Dim ddlCompany As DropDownList = DirectCast(e.Row.FindControl("ddlCompany"), DropDownList)  'Company ddl
            Dim ddlPlanType As DropDownList = DirectCast(e.Row.FindControl("ddlPlanType"), DropDownList)  'Plantypes ddl
            Dim ddlAscDesc As DropDownList = DirectCast(e.Row.FindControl("ddlAscDesc"), DropDownList)  'Asc vs Desc
            Dim txtValue As TextBox = DirectCast(e.Row.FindControl("txtValue"), TextBox)
            Dim chkSort As CheckBox = DirectCast(e.Row.FindControl("chkOrder"), CheckBox)
            Dim lblOrder As Label = DirectCast(e.Row.FindControl("lblOrder"), Label)

            'clean up
            lblOrder.Text = "0"
            lblOrder.Visible = False
            chkSort.Checked = False
            ddlAscDesc.Visible = False

            If ColumnName = "CompanyId" Then
                'Hide operator ddl, txtValue, and Orderby ddl
                ddlOperator.Visible = False
                ddlCompany.Visible = True
                ddlPlanType.Visible = False
                txtValue.Visible = False

                'Fill up Company list based on UserId
                Dim intUserId = Session("UserId")
                Dim intCompanyId = Session("ShadowCompanyId")

                c.LoadCompanyList(Session("UserId"), Session("ShadowCompanyId"), "Consolidated", "", 1, 1, 0, Session("ds"))

                ddlCompany.DataSource = Session("ds").tables(0)
                ddlCompany.DataBind()

                If Not Session("ShadowCompanyId") Is Nothing Then
                    ddlCompany.SelectedValue = Session("ShadowCompanyId")
                Else
                    ddlCompany.Items(0).Selected = True
                End If

                If ddlCompany.Items.Count > 1 Then
                    'Loop thru list and capture all Company Id's and put in session (used later for querying views)
                    Dim strAllCompanies As String
                    strAllCompanies = "0"
                    For Each item As System.Web.UI.WebControls.ListItem In ddlCompany.Items
                        strAllCompanies = strAllCompanies & "," & item.Value
                    Next
                    Session("AllCompanies") = "(" & strAllCompanies & ")"

                    ddlCompany.Items.Insert(0, New System.Web.UI.WebControls.ListItem("<< ALL >>"))
                End If

            ElseIf ColumnName = "PlanTypeId" Then
                'Hide operator ddl, txtValue, and Orderby ddl
                ddlOperator.Visible = False
                ddlCompany.Visible = False
                ddlPlanType.Visible = True
                txtValue.Visible = False

                'Plan Type Drop Down
                PlanClass.PlanTypeList(ddlPlanType)
                If ddlPlanType.Items.Count > 1 Then
                    ddlPlanType.Items.Insert(0, New System.Web.UI.WebControls.ListItem("<< ALL >>"))
                End If
                ddlPlanType.Items(0).Selected = True
            Else
                ddlOperator.Visible = True
                ddlPlanType.Visible = False
                ddlCompany.Visible = False
                txtValue.Visible = True
                If DataType = "String" Then
                    ddlOperator.Items.Insert(0, New System.Web.UI.WebControls.ListItem("  ="))
                    ddlOperator.Items.Insert(1, New System.Web.UI.WebControls.ListItem("Like"))
                ElseIf DataType = "Date" Then
                    ddlOperator.Items.Insert(0, New System.Web.UI.WebControls.ListItem(" ="))
                    ddlOperator.Items.Insert(1, New System.Web.UI.WebControls.ListItem("<="))
                    ddlOperator.Items.Insert(2, New System.Web.UI.WebControls.ListItem(">="))
                    ddlOperator.Items.Insert(3, New System.Web.UI.WebControls.ListItem("IS NULL"))
                Else
                    ddlOperator.Items.Insert(0, New System.Web.UI.WebControls.ListItem(" ="))
                    ddlOperator.Items.Insert(1, New System.Web.UI.WebControls.ListItem("<="))
                    ddlOperator.Items.Insert(2, New System.Web.UI.WebControls.ListItem(">="))
                End If
            End If


        End If
    End Sub
#End Region

#Region "Build Query and Export Report"
    Private Function BuildQueryString() As String

        'Build our Query
        Dim QryString As String
        Dim bFirst As Boolean

        bFirst = True


        If Session("ViewName") Like "*usp*" Then
            QryString = "EXEC " & Session("ViewName") & " "

            Dim gvr As GridViewRow
            Dim i As Integer

            For Each gvr In grdCriteria.Rows
                Dim vReportParameterId As Object = grdCriteria.DataKeys(i).Values("ReportParameterId")
                Dim vColumnName As Object = grdCriteria.DataKeys(i).Values("ColumnName")
                Dim vDataType As Object = grdCriteria.DataKeys(i).Values("DataType")

                Dim ddlOperator As DropDownList = DirectCast(gvr.FindControl("ddlOperator"), DropDownList)
                Dim ddlCompany As DropDownList = DirectCast(gvr.FindControl("ddlCompany"), DropDownList)  'Company ddl
                Dim ddlPlanType As DropDownList = DirectCast(gvr.FindControl("ddlPlanType"), DropDownList)  'Plantypes ddl
                Dim ddlAscDesc As DropDownList = DirectCast(gvr.FindControl("ddlAscDesc"), DropDownList)  'Asc vs Desc
                Dim txtValue As TextBox = DirectCast(gvr.FindControl("txtValue"), TextBox)
                Dim chkSort As CheckBox = DirectCast(gvr.FindControl("chkOrder"), CheckBox)
                Dim lblOrder As Label = DirectCast(gvr.FindControl("lblOrder"), Label)

                If ddlCompany.SelectedIndex <> -1 Then
                    If ddlCompany.Visible = True And ddlCompany.SelectedValue <> "<< ALL >>" Then
                        QryString &= "@CompanyId = " & ddlCompany.SelectedValue.ToString() & ", "
                    ElseIf ddlCompany.SelectedValue = "<< ALL >>" Then
                        QryString &= "@CompanyId = '" & Replace(Replace(Session("AllCompanies"), "(", ""), ")", "") & "', "
                    End If
                End If

                If ddlPlanType.SelectedIndex <> -1 Then
                    If ddlPlanType.Visible = True And ddlPlanType.SelectedValue <> "<< ALL >>" Then
                        QryString &= "@PlanTypeId = " & ddlPlanType.SelectedValue.ToString() & ", "
                    Else
                        QryString &= "@PlanTypeId = NULL, "
                    End If
                End If

                Select Case vColumnName
                    Case "RelationshipName", "Division", "EENumber", "SSN", "FirstName", "LastName", "Provider"
                        If txtValue.Visible = True And Trim(txtValue.Text) <> "" Then
                            'Do some datavalidation here based on Data type
                            If vDataType = "Date" Then
                                If Dependent.ValidDOBFormat(txtValue.Text) = False Then
                                    txtValue.BackColor = Drawing.Color.LightPink
                                    QryString = "ErrorDate"
                                    Return QryString
                                    Exit Function
                                End If
                            ElseIf vDataType = "Numeric" Then
                                If Employee.ValidNumericFormat(txtValue.Text) = False Then
                                    txtValue.BackColor = Drawing.Color.LightPink
                                    QryString = "ErrorNumeric"
                                    Return QryString
                                    Exit Function
                                End If
                            End If
                        End If

                        'remove background
                        txtValue.BackColor = Drawing.Color.Empty

                        If Trim(txtValue.Text) = "" Then
                            QryString &= "@" & vColumnName & " = NULL, "
                        Else
                            QryString &= "@" & vColumnName & " = '" & txtValue.Text.Trim & "', "
                        End If
                End Select

                i += 1

            Next

            QryString = Mid(QryString.Trim, 1, Len(QryString.Trim) - 1)
        Else
            QryString = "Select *"
            QryString = QryString & " From " & Session("ViewName")
            If Session("Parameter") = True Then
                Dim gvr As GridViewRow
                Dim i As Integer
                For Each gvr In grdCriteria.Rows
                    Dim vReportParameterId As Object = grdCriteria.DataKeys(i).Values("ReportParameterId")
                    Dim vColumnName As Object = grdCriteria.DataKeys(i).Values("ColumnName")
                    Dim vDataType As Object = grdCriteria.DataKeys(i).Values("DataType")

                    Dim ddlOperator As DropDownList = DirectCast(gvr.FindControl("ddlOperator"), DropDownList)
                    Dim ddlCompany As DropDownList = DirectCast(gvr.FindControl("ddlCompany"), DropDownList)  'Company ddl
                    Dim ddlPlanType As DropDownList = DirectCast(gvr.FindControl("ddlPlanType"), DropDownList)  'Plantypes ddl
                    Dim ddlAscDesc As DropDownList = DirectCast(gvr.FindControl("ddlAscDesc"), DropDownList)  'Asc vs Desc
                    Dim txtValue As TextBox = DirectCast(gvr.FindControl("txtValue"), TextBox)
                    Dim chkSort As CheckBox = DirectCast(gvr.FindControl("chkOrder"), CheckBox)
                    Dim lblOrder As Label = DirectCast(gvr.FindControl("lblOrder"), Label)

                    If ddlCompany.Visible = True And ddlCompany.SelectedValue <> "<< ALL >>" Then
                        QryString = QryString & IIf(bFirst = True, " Where ", " And ") & "CompanyId = " & ddlCompany.SelectedValue.ToString()
                        bFirst = False
                    ElseIf ddlCompany.SelectedValue = "<< ALL >>" Then
                        QryString = QryString & IIf(bFirst = True, " Where ", " And ") & "CompanyId IN " & Session("AllCompanies")
                        bFirst = False
                    End If

                    If ddlPlanType.Visible = True And ddlPlanType.SelectedValue <> "<< ALL >>" Then
                        QryString = QryString & IIf(bFirst = True, " Where ", " And ") & "PlanTypeId = " & ddlPlanType.SelectedValue.ToString()
                        bFirst = False
                    End If

                    If txtValue.Visible = True And Trim(txtValue.Text) <> "" Then
                        'Do some datavalidation here based on Data type
                        'If vDataType = "Date" Then
                        '    If Dependent.ValidDOBFormat(txtValue.Text) = False Then
                        '        txtValue.BackColor = Drawing.Color.LightPink
                        '        QryString = "ErrorDate"
                        '        Return QryString
                        '        Exit Function
                        '    End If
                        'Else
                        If vDataType = "Numeric" Then
                                If Employee.ValidNumericFormat(txtValue.Text) = False Then
                                    txtValue.BackColor = Drawing.Color.LightPink
                                    QryString = "ErrorNumeric"
                                    Return QryString
                                    Exit Function
                                End If
                            End If

                            'remove background
                            txtValue.BackColor = Drawing.Color.Empty


                        If ddlOperator.SelectedValue = "Like" Then
                            QryString = QryString & IIf(bFirst = True, " Where ", " And ") & vColumnName & " " & ddlOperator.SelectedValue & "'%" & txtValue.Text & "%'"
                            bFirst = False
                        Else
                            If vDataType = "Date" Then
                                vColumnName = "CAST(" & vColumnName & " as Datetime)"
                            End If

                            QryString = QryString & IIf(bFirst = True, " Where ", " And ") & vColumnName & " " & ddlOperator.SelectedValue & "'" & txtValue.Text & "'"
                            bFirst = False
                        End If
                    End If

                    i += 1
                Next
            End If

            'Add the sort if any
            If Session("OrderBy") <> "" Then
                QryString = QryString & " Order By " & Session("OrderBy")
            End If
        End If


        Return QryString

    End Function

    Protected Sub btnExcel_Click(sender As Object, e As ImageClickEventArgs)
        ' Protected Sub Button1_Click(sender As Object, e As EventArgs)
        ' divImage.visible = True



        Dim QryString As String
        QryString = BuildQueryString()

        'Catch Formatting Errors here..
        If QryString = "ErrorDate" Then
            ScriptManager.RegisterClientScriptBlock(Me, GetType(Page), UniqueID, "javascript:alert('The highlighted Date field is not in the correct format.\n\nPlease correct (mm/dd/yyyy) and try again.');", True)
            Exit Sub
        End If
        If QryString = "ErrorNumeric" Then
            ScriptManager.RegisterClientScriptBlock(Me, GetType(Page), UniqueID, "javascript:alert('The highlighted field can only contain a Numeric amount.\n\nPlease correct (999.99) and try again.');", True)
            Exit Sub
        End If

        Dim sqlCon As New SQLControl
        Dim cmd As New SqlCommand(QryString)
        Dim dt As DataTable = sqlCon.GetData(QryString)

        'Create a dummy GridView 
        Dim GridView1 As New GridView()
        GridView1.AllowPaging = False
        GridView1.DataSource = dt
        GridView1.DataBind()

        divCriteria.Visible = False

        If GridView1.Rows.Count > 0 Then
            Dim strFileName As String
            strFileName = lblReportName.Text & ".xlsx"

            Using wb As New XLWorkbook()
                wb.Worksheets.Add(dt)
                Response.Clear()
                Response.Buffer = True
                Response.Charset = ""
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                Response.AddHeader("content-disposition", "attachment;filename=" & strFileName)
                Using MyMemoryStream As New MemoryStream()
                    wb.SaveAs(MyMemoryStream)
                    MyMemoryStream.WriteTo(Response.OutputStream)
                    Response.Flush()
                    Response.End()
                End Using
            End Using

        Else
            'no records returned - show alert (damn error div idea did not work well!)
            ScriptManager.RegisterClientScriptBlock(Me, GetType(Page), UniqueID, "javascript:alert('The report you requested does not return any data.\n\nCheck your criteria and try again');", True)
        End If


    End Sub

    Protected Sub btnWord_Click(sender As Object, e As ImageClickEventArgs) Handles btnWord.Click
        Dim QryString As String
        QryString = BuildQueryString()
        Dim sqlCon As New SQLControl
        Dim cmd As New SqlCommand(QryString)
        Dim dt As DataTable = sqlCon.GetData(QryString)

        'Create a dummy GridView 
        Dim GridView1 As New GridView()
        GridView1.AllowPaging = False
        GridView1.DataSource = dt
        GridView1.DataBind()
        If GridView1.Rows.Count > 0 Then
            Dim strFileName As String
            strFileName = lblReportName.Text & ".doc"
            Response.Clear()
            Response.Buffer = True
            Response.AddHeader("content-disposition", "attachment;filename=" & strFileName)
            Response.Charset = ""
            Response.ContentType = "application/vnd.ms-word "
            Dim sw As New StringWriter()
            Dim hw As New HtmlTextWriter(sw)
            GridView1.AllowPaging = False
            GridView1.DataBind()
            GridView1.RenderControl(hw)
            Response.Output.Write(sw.ToString())
            Response.Flush()
            Response.End()
        Else
            'no records returned - show alert (damn error div idea did not work well!)
            ScriptManager.RegisterClientScriptBlock(Me, GetType(Page), UniqueID, "javascript:alert('The report you requested does not return any data.\n\nCheck your criteria and try again');", True)
        End If
    End Sub

    Protected Sub btnPDF_Click(sender As Object, e As ImageClickEventArgs) Handles btnPDF.Click
        Dim QryString As String
        QryString = BuildQueryString()

        Dim sqlCon As New SQLControl
        Dim cmd As New SqlCommand(QryString)
        Dim dt As DataTable = sqlCon.GetData(QryString)

        'Create a dummy GridView 
        Dim GridView1 As New GridView()
        GridView1.AllowPaging = False
        GridView1.DataSource = dt
        GridView1.DataBind()
        If GridView1.Rows.Count > 0 Then
            Dim strFileName As String
            strFileName = lblReportName.Text & ".pdf"
            Response.ContentType = "application/pdf"
            Response.AddHeader("content-disposition", "attachment;filename=" & strFileName)
            Response.Cache.SetCacheability(HttpCacheability.NoCache)
            Dim sw As New StringWriter()
            Dim hw As New HtmlTextWriter(sw)
            GridView1.RenderControl(hw)
            Dim sr As New StringReader(sw.ToString())
            Dim pdfDoc As New Document(PageSize.A4, 10.0F, 10.0F, 10.0F, 0.0F)
            Dim htmlparser As New HTMLWorker(pdfDoc)
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream)
            pdfDoc.Open()
            htmlparser.Parse(sr)
            pdfDoc.Close()
            Response.Write(pdfDoc)
            Response.End()
        Else
            'no records returned - show alert (damn error div idea did not work well!)
            ScriptManager.RegisterClientScriptBlock(Me, GetType(Page), UniqueID, "javascript:alert('The report you requested does not return any data.\n\nCheck your criteria and try again');", True)
        End If
    End Sub
#End Region

#Region "Updating Sorting order"

    Public Sub UpdateOrderBy()
        Dim gvr As GridViewRow
        For Each gvr In grdCriteria.Rows
            Dim ddlAscDesc As DropDownList = DirectCast(gvr.FindControl("ddlAscDesc"), DropDownList)  'Asc vs Desc
            Dim chkSort As CheckBox = DirectCast(gvr.FindControl("chkOrder"), CheckBox)
            Dim lblOrder As Label = DirectCast(gvr.FindControl("lblOrder"), Label)

            If chkSort.Checked = True Then
                ddlAscDesc.Visible = True
                lblOrder.Visible = True
                If lblOrder.Text = "0" Then
                    lblOrder.Text = Session("OrderId")
                    Session("OrderId") = Session("OrderId") + 1
                End If
            Else
                ddlAscDesc.Visible = False
                lblOrder.Visible = False
                lblOrder.Text = "0"
            End If
        Next

        UpdateSortOrder()
    End Sub

    Protected Sub ddlAscDesc_SelectedIndexChanged(sender As Object, e As EventArgs)
        UpdateSortOrder()
    End Sub

    Protected Sub UpdateSortOrder()
        'Create and fill datatable
        Dim dt As New DataTable
        dt.Columns.Add("ReportParamId")
        dt.Columns.Add("SortOrder")
        dt.Columns.Add("ColumnName")

        Dim gvr2 As GridViewRow
        Dim i As Integer
        For Each gvr2 In grdCriteria.Rows
            Dim chk As CheckBox = DirectCast(gvr2.FindControl("chkOrder"), CheckBox)
            Dim lbl As Label = DirectCast(gvr2.FindControl("lblOrder"), Label)
            Dim ddl As DropDownList = DirectCast(gvr2.FindControl("ddlAscDesc"), DropDownList)
            If chk.Checked = True Then
                Dim ReportParameterId As Object = grdCriteria.DataKeys(i).Values("ReportParameterId")
                Dim ColumnName As Object = grdCriteria.DataKeys(i).Values("ColumnName")
                If ddl.SelectedValue = "Asc" Then
                    dt.Rows.Add(ReportParameterId, lbl.Text, ColumnName)
                Else
                    dt.Rows.Add(ReportParameterId, lbl.Text, ColumnName & " " & ddl.SelectedValue)
                End If

            End If
            i += 1
        Next

        'Now, query sorted datatable and update sort labels in Grid....is it really worth all this?
        ' Create DataView 
        Dim vw As New DataView(dt)
        ' Sort by SortOrder 
        vw.Sort = "SortOrder ASC"
        Dim r As Integer
        Dim x As Integer
        r = 1
        Session("OrderBy") = ""
        For Each row As DataRowView In vw
            x = 0
            For Each gvr2 In grdCriteria.Rows
                Dim ReportParameterId As Object = grdCriteria.DataKeys(x).Values("ReportParameterId")
                Dim lbl As Label = DirectCast(gvr2.FindControl("lblOrder"), Label)
                If ReportParameterId = row("ReportParamId") Then
                    lbl.Text = r
                    Session("OrderBy") = Session("OrderBy") & IIf(Session("OrderBy") = "", "", ", ") & row("ColumnName")
                End If
                x += 1
            Next
            r = r + 1
        Next
    End Sub
#End Region

#Region "Organizing Reports"
    Protected Sub lnkClose_Click(sender As Object, e As EventArgs)
        divCriteria.Visible = False
    End Sub

    Protected Sub chkDashboard_CheckedChanged(sender As Object, e As EventArgs)
        Dim chkDashboard As CheckBox = sender
        Dim gr As GridViewRow = chkDashboard.Parent.Parent
        Dim ReportPermissionId As Object = grdReports.DataKeys(gr.RowIndex).Values("ReportPermissionId")
        Dim chkFavorite As CheckBox = DirectCast(gr.FindControl("chkFavorite"), CheckBox)
        Dim chkStandard As CheckBox = DirectCast(gr.FindControl("chkStandard"), CheckBox)
        Dim chkHide As CheckBox = DirectCast(gr.FindControl("chkHide"), CheckBox)

        If chkDashboard.Checked = True And chkHide.Checked = True Then
            chkFavorite.Checked = False
            chkStandard.Checked = True
            chkHide.Checked = False
        End If

        'Save Preferences
        ReportClass.SaveAdminPreferences(ReportPermissionId, chkDashboard.Checked, chkFavorite.Checked, chkHide.Checked)

    End Sub

    Protected Sub chkFavorite_CheckedChanged(sender As Object, e As EventArgs)
        Dim chkFavorite As CheckBox = sender
        Dim gr As GridViewRow = chkFavorite.Parent.Parent
        Dim ReportPermissionId As Object = grdReports.DataKeys(gr.RowIndex).Values("ReportPermissionId")
        Dim chkStandard As CheckBox = DirectCast(gr.FindControl("chkStandard"), CheckBox)
        Dim chkHide As CheckBox = DirectCast(gr.FindControl("chkHide"), CheckBox)
        Dim chkDashboard As CheckBox = DirectCast(gr.FindControl("chkDashboard"), CheckBox)

        If chkFavorite.Checked = True Then
            chkStandard.Checked = False
            chkHide.Checked = False
        Else
            chkStandard.Checked = True
        End If

        'Save Preferences
        ReportClass.SaveAdminPreferences(ReportPermissionId, chkDashboard.Checked, chkFavorite.Checked, chkHide.Checked)



    End Sub

    Protected Sub chkStandard_CheckedChanged(sender As Object, e As EventArgs)
        Dim chkStandard As CheckBox = sender
        Dim gr As GridViewRow = chkStandard.Parent.Parent
        Dim ReportPermissionId As Object = grdReports.DataKeys(gr.RowIndex).Values("ReportPermissionId")
        Dim chkFavorite As CheckBox = DirectCast(gr.FindControl("chkFavorite"), CheckBox)
        Dim chkHide As CheckBox = DirectCast(gr.FindControl("chkHide"), CheckBox)
        Dim chkDashboard As CheckBox = DirectCast(gr.FindControl("chkDashboard"), CheckBox)

        If chkStandard.Checked = True Then
            chkFavorite.Checked = False
            chkHide.Checked = False
        Else
            chkFavorite.Checked = True
        End If

        'Save Preferences
        ReportClass.SaveAdminPreferences(ReportPermissionId, chkDashboard.Checked, chkFavorite.Checked, chkHide.Checked)


    End Sub

    Protected Sub chkHide_CheckedChanged(sender As Object, e As EventArgs)
        Dim chkHide As CheckBox = sender
        Dim gr As GridViewRow = chkHide.Parent.Parent
        Dim ReportPermissionId As Object = grdReports.DataKeys(gr.RowIndex).Values("ReportPermissionId")
        Dim chkFavorite As CheckBox = DirectCast(gr.FindControl("chkFavorite"), CheckBox)
        Dim chkStandard As CheckBox = DirectCast(gr.FindControl("chkStandard"), CheckBox)
        Dim chkDashboard As CheckBox = DirectCast(gr.FindControl("chkDashboard"), CheckBox)

        If chkHide.Checked = True Then
            chkFavorite.Checked = False
            chkStandard.Checked = False
            chkDashboard.Checked = False
        Else
            chkFavorite.Checked = False
            chkStandard.Checked = True
        End If

        'Save Preferences
        ReportClass.SaveAdminPreferences(ReportPermissionId, chkDashboard.Checked, chkFavorite.Checked, chkHide.Checked)

    End Sub

    Protected Sub mbtnSave_Click(sender As Object, e As ImageClickEventArgs)
        'Fill Favorite and Standard Report Lists and put list in Session
        Session("dsFavs") = New DataSet
        ReportClass.Load_ReportList(Session("UserId"), Session("Athena"), "Favorite", lstFavorite, Session("dsFavs"))
        Session("dsReports") = New DataSet
        ReportClass.Load_ReportList(Session("UserId"), Session("Athena"), "Standard", lstReports, Session("dsReports"))

        'hide the stupid Criteria section
        'Page.ClientScript.RegisterStartupScript(Me.GetType(), "script", "HideCriteria();", True)

    End Sub
#End Region

End Class
