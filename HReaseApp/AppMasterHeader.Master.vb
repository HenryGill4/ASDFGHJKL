Public Class AppMasterHeader
    Inherits System.Web.UI.MasterPage

    Dim sql As New SQLControl
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee
    Dim DepClass As New Dependent
    Dim intCompanyId As Integer
    Dim intEmpId As Integer


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Or Session("DisplayName") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        If Page.IsPostBack = False Then
            If InStr(Request.Url.ToString, "local") = 0 And InStr(Request.Url.ToString, "hrease-dev") = 0 Then
                If Not Request.IsSecureConnection Then
                    Dim url As String
                    url = Request.Url.ToString.Replace("http:", "https:")
                    Response.Redirect(url)
                End If
            End If

            If Session("Admin") = False Then
                intCompanyId = Session("CompanyId")
                intEmpId = Session("EmployeeId")

                divIcons.Visible = False
                divShadowEEandCo.Visible = False
            Else        ' ADMIN

                intCompanyId = Session("ShadowCompanyId")
                intEmpId = Session("ShadowEmployeeId")

            End If

            If lblDisplayName IsNot Nothing Then
                lblDisplayName.Text = Session("DisplayName")
                lblID.Text = "CompId: " + Session("CompanyId").ToString + " EmpId: " + Session("EmployeeId").ToString
            Else
                lblID.Text = "CompId: " + Session("CompanyId").ToString
            End If

            If lblShadowName IsNot Nothing And Session("ShadowEmployee") IsNot Nothing Then
                lblShadowName.Text = Session("ShadowEmployee")
                lblShadowCompany.Text = Session("ShadowCompany")
                lblID.Text = "SHADOW CompId: " + Session("ShadowCompanyId").ToString + " EmpId: " + Session("ShadowEmployeeId").ToString

                'Employee Notes grid - MODAL
                'ec.FillEmployeeNotes(Session("ShadowEmployeeId"), grdEmployeeNotes)
                'mlblInfoTitle.Text = "Employee Notes for " + Session("ShadowEmployeeName")

            End If

            If Session("Logo") IsNot Nothing Then
                imgCompanyImage.ImageUrl = Session("Logo")
            Else
                imgCompanyImage.ImageUrl = "../images/hrease-01.png"
            End If

            lblID.Attributes.Add("onmouseover", "LabelHover();")
            lblID.Attributes.Add("OnMouseOut", "LabelLeave();")

        End If

    End Sub
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    '''''           UNTIL I CAN FIGURE OUT HOW TO SET A DEFAULT BUTTON ON THE CONTENT PAGE WITH THE STUPID SCRIPT MANAGER 
    '''''           ON THE MASTER PAGE, I NEED TO REMOVE THE EMPLOYEE NOTES MODAL OFF OF HERE AND ON TO THE FOLLOWING CONTENT PAGES:
    '''''                             EMPLOYEE PROFILE, RELATIONSHIPS, CURRENT AND FUTURE SUMMARY PAGES
    '''''                                                   I AM NOT HAPPY!!!!!
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''



    'Protected Sub a_grdEmployee_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdEmployeeNotes.RowDataBound
    '    If e.Row.RowType = System.Web.UI.WebControls.DataControlRowType.DataRow Then
    '        e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#EFF3FB'")  'old color   8bcced
    '        e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=''")
    '        e.Row.Attributes.Add("style", "cursor:pointer;")
    '        'e.Row.Attributes("onclick") = Page.ClientScript.GetPostBackClientHyperlink(grdEmployeeNotes, "Select$" & e.Row.RowIndex)
    '        e.Row.ToolTip = "Click to edit this Note."
    '    End If
    'End Sub

    'Protected Sub mbtnSave_Click(sender As Object, e As ImageClickEventArgs) Handles mbtnSave.Click
    '    ec.UpdateEmployeeNotes(mlblHiddenNoteId.Text, Session("ShadowEmployeeId"), mtxtNewComment.Text, Session("UserId"), True)
    '    ec.FillEmployeeNotes(Session("ShadowEmployeeId"), grdEmployeeNotes)
    '    mtxtNewComment.Text = ""
    '    mtxtNewComment.Visible = False
    '    mlblAddNew.Visible = False
    '    mbtnSave.Visible = False
    '    mbtnAdd.Visible = True
    'End Sub

    'Protected Sub mbtnAdd_Click(sender As Object, e As ImageClickEventArgs) Handles mbtnAdd.Click
    '    mtxtNewComment.Text = ""
    '    mlblHiddenNoteId.Text = 0
    '    mtxtNewComment.Visible = True
    '    mlblAddNew.Visible = True
    '    mbtnSave.Visible = True
    '    mbtnAdd.Visible = False
    'End Sub

    'Protected Sub ButtonEdit_Click(sender As Object, e As EventArgs)
    '    Dim btnEdit As Button = sender
    '    Dim gr As GridViewRow = btnEdit.Parent.Parent
    '    Dim grd As GridView = btnEdit.Parent.Parent.Parent.Parent
    '    Dim EmployeeNoteId As Object = grdEmployeeNotes.DataKeys(gr.RowIndex).Values("EmployeeNoteId")

    '    Dim strCurrentNote As String
    '    strCurrentNote = grd.Rows(gr.RowIndex).Cells(2).Text
    '    'Dim row As GridViewRow = grdEmployeeNotes.SelectedRow
    '    'Dim i As Integer
    '    'i = grdEmployeeNotes.SelectedIndex
    '    'Dim lblNote As Label = DirectCast(grdEmployeeNotes.Rows(i).FindControl("lblNote"), Label)
    '    'Session("EmployeeNoteId") = grdEmployeeNotes.DataKeys(i).Values("EmployeeNoteId")
    '    mlblHiddenNoteId.Text = EmployeeNoteId
    '    mtxtNewComment.Text = strCurrentNote
    '    mtxtNewComment.Visible = True
    '    mbtnAdd.Visible = False
    '    mbtnSave.Visible = True
    'End Sub

End Class