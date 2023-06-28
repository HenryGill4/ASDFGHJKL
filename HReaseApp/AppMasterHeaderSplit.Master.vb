
Partial Class AppMasterHeaderSplit
    Inherits System.Web.UI.MasterPage

    Dim sql As New SQLControl
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee
    Dim DepClass As New Dependent
    Dim intCompanyId As Integer
    Dim intEmpId As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            'Response.Redirect("CorporateLogin.aspx")
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
                If Not ImageNext Is Nothing Then
                    ImageNext.Visible = False
                End If
                divIcons.Visible = False
                divShadowEEandCo.Visible = False
            Else        ' ADMIN

                intCompanyId = Session("ShadowCompanyId")
                intEmpId = Session("ShadowEmployeeId")
                If Not ImageNext Is Nothing Then
                    'show next button
                    ImageNext.Visible = True
                End If
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
                ec.FillEmployeeNotes(Session("ShadowEmployeeId"), grdEmployeeNotes)
                mlblInfoTitle.Text = "Employee Notes for " + Session("ShadowEmployeeName")

            End If

            If Session("Logo") IsNot Nothing Then
                imgCompanyImage.ImageUrl = Session("Logo")
            Else
                imgCompanyImage.ImageUrl = "../images/hrease-01.png"
            End If

            lblID.Attributes.Add("onmouseover", "LabelHover();")
            lblID.Attributes.Add("OnMouseOut", "LabelLeave();")

            If btnEditProfile IsNot Nothing Then   'on plan pages this section should not be shown, so a simple test of the first button should let us know
                If Page.IsPostBack = False Then
                    Dim booGotEmployee As Boolean
                    '  If Session("Admin") = False Then
                    booGotEmployee = ec.GetEmployeeInfo(intCompanyId, intEmpId)
                    If booGotEmployee = True Then
                        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                        ''              Right Side menu
                        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                        'Employee Demographic info
                        imgProfilePic.Src = ec.ProfilePic
                        lblEmployeeName.Text = ec.FullName
                        lblAddress.Text = ec.Address1
                        lblAddress2.Text = ec.Address2
                        lblCity.Text = ec.City + ", "
                        lblState.Text = ec.State
                        lblZip.Text = ec.Zip
                        lblPhone.Text = IIf(ec.PrimaryPhone = "Home", ec.HomePhone,
                                            (IIf(ec.PrimaryPhone = "Work", ec.WorkPhone,
                                                 (IIf(ec.PrimaryPhone = "Mobile", ec.MobilePhone, "")))))

                        lblEmail.Text = IIf(ec.PrimaryEmail = "Email1", ec.Email1,
                                            (IIf(ec.PrimaryEmail = "Email2", ec.Email2, "")))

                        'Dependents
                        grdDependents.DataSource = DepClass.GetDependentList(intCompanyId, intEmpId, 1)
                        grdDependents.DataBind()
                    End If
                End If
            End If
        End If

    End Sub

    Protected Sub a_grdEmployee_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdEmployeeNotes.RowDataBound
        If e.Row.RowType = System.Web.UI.WebControls.DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#EFF3FB'")  'old color   8bcced
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=''")
            e.Row.Attributes.Add("style", "cursor:pointer;")
            'e.Row.Attributes("onclick") = Page.ClientScript.GetPostBackClientHyperlink(grdEmployeeNotes, "Select$" & e.Row.RowIndex)
            e.Row.ToolTip = "Click to edit this Note."


        End If
    End Sub

    'Protected Sub OnSelectedIndexChanged(sender As Object, e As EventArgs)
    '    Dim row As GridViewRow = grdEmployeeNotes.SelectedRow
    '    Dim i As Integer
    '    i = grdEmployeeNotes.SelectedIndex
    '    Dim lblNote As Label = DirectCast(grdEmployeeNotes.Rows(i).FindControl("lblNote"), Label)
    '    Session("EmployeeNoteId") = grdEmployeeNotes.DataKeys(i).Values("EmployeeNoteId")
    '    mtxtNewComment.Text = lblNote.Text
    '    mtxtNewComment.Visible = True
    '    mbtnAdd.Visible = False
    '    mbtnSave.Visible = True
    'End Sub


    Protected Sub mbtnSave_Click(sender As Object, e As ImageClickEventArgs) Handles mbtnSave.Click
        ec.UpdateEmployeeNotes(mlblHiddenNoteId.Text, Session("ShadowEmployeeId"), mtxtNewComment.Text, Session("UserId"), True)
        ec.FillEmployeeNotes(Session("ShadowEmployeeId"), grdEmployeeNotes)
        mtxtNewComment.Text = ""
        mtxtNewComment.Visible = False
        mlblAddNew.Visible = False
        mbtnSave.Visible = False
        mbtnAdd.Visible = True
    End Sub

    Protected Sub mbtnAdd_Click(sender As Object, e As ImageClickEventArgs) Handles mbtnAdd.Click
        mtxtNewComment.Text = ""
        mlblHiddenNoteId.Text = 0
        mtxtNewComment.Visible = True
        mlblAddNew.Visible = True
        mbtnSave.Visible = True
        mbtnAdd.Visible = False
    End Sub

    Protected Sub ButtonEdit_Click(sender As Object, e As EventArgs)
        Dim btnEdit As Button = sender
        Dim gr As GridViewRow = btnEdit.Parent.Parent
        Dim grd As GridView = btnEdit.Parent.Parent.Parent.Parent
        Dim EmployeeNoteId As Object = grdEmployeeNotes.DataKeys(gr.RowIndex).Values("EmployeeNoteId")

        Dim strCurrentNote As String
        strCurrentNote = grd.Rows(gr.RowIndex).Cells(2).Text
        'Dim row As GridViewRow = grdEmployeeNotes.SelectedRow
        'Dim i As Integer
        'i = grdEmployeeNotes.SelectedIndex
        'Dim lblNote As Label = DirectCast(grdEmployeeNotes.Rows(i).FindControl("lblNote"), Label)
        'Session("EmployeeNoteId") = grdEmployeeNotes.DataKeys(i).Values("EmployeeNoteId")
        mlblHiddenNoteId.Text = EmployeeNoteId
        mtxtNewComment.Text = strCurrentNote
        mlblAddNew.Visible = True
        mtxtNewComment.Visible = True
        mbtnAdd.Visible = False
        mbtnSave.Visible = True
    End Sub

End Class

