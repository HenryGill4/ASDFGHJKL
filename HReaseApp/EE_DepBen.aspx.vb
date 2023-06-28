Imports System.Data.SqlClient

Public Class EE_DepBen
    Inherits System.Web.UI.Page

    Dim DepClass As New Dependent
    Dim booGotDependent As Boolean

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee
    Dim CompanyClass As New Company

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer
    Dim intRelationshipTypeId As Integer

    Dim strScreenName As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change this on each page
        strScreenName = "EERelationship"

        If Session("Admin") = True Then
            intCompanyId = Session("ShadowCompanyId")
            intEmployeeId = Session("ShadowEmployeeId")
            Session("DisplayName") = Session("AdminName")
            
        Else
            Session("DisplayName") = Session("EmployeeName")
            intCompanyId = Session("CompanyId")
            intEmployeeId = Session("EmployeeId")
        End If

        If Page.IsPostBack = False Then
            s.SaveUserUpdate(Session("UserId"), strScreenName, "Browse", intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

            If sc.GetNavigation(Session("UserId"), intEmployeeId, strScreenName, 0) = True Then
                Session("ScreenName") = sc.ScreenName
                Session("ScreenShortDesc") = sc.ScreenShortDesc
                Session("ScreenPath") = sc.ScreenPath
                Session("DataComplete") = sc.DataComplete
                Session("NextScreen") = sc.NextScreen
                Session("TabString") = sc.TabString
                Session("ScreenConfigTitle") = sc.ScreenConfigTitle
                Session("ScreenConfigText") = sc.ScreenConfigText
                Session("DispayName") = sc.AdminFullName

            End If

            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), Session("ScreenPath"))
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            sc.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            lblMainArticleTitle.Text = sc.MainArticleTitle
            lblMainArticleText.Text = IIf(sc.MainArticleText = "", "Click Add to enter a new Dependent, Beneficiary, or Emergency Contact.  To edit an existing relationship, just click on the name.", sc.MainArticleText)
            imgNext.Visible = True

            If lblMainArticleText.Text = "" Then
                DivText.Visible = False
            End If
            If lblMainArticleTitle.Text = "" Then
                DivTitle.Visible = False
            End If

            'Hide Edit Areas
            DivDependentEdit.Visible = False

            'Fill up DepBen Grid
            DepClass.PopulateDepBenList(intCompanyId, intEmployeeId, "ALL", chkActivesOnly.Checked, 0, grdDepBen)

            ec.LoadPrefix(ddlPrefix)
            ec.LoadSuffix(ddlSuffix)
            ec.LoadState(ddlState)
            ec.LoadCountry(ddlCountry)
            ec.LoadGender(ddlGender)
            DepClass.LoadDepBenTypes(0, ddlDependentType) 'this will show all the Dependent Types
            DepClass.LoadRelationshipTypes(5, ddlRelationship)  'this will show all relationship types on initial load

            ddlPrefix.Items.Insert(0, New ListItem(""))
            ddlSuffix.Items.Insert(0, New ListItem(""))
            ddlState.Items.Insert(0, New ListItem(""))
            ddlCountry.Items.Insert(0, New ListItem(""))
            ddlDependentType.Items.Add(New ListItem("", "0"))
            ddlRelationship.Items.Add(New ListItem("", "0"))

        End If

        DivError.Visible = False
        'DivSuccess.Visible = False
        'btnSaveDep.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSaveDep, "") + ";this.src='/img/processing.gif';")
        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateEditFields()
        Session("AddNewDependent") = 0

        '-------------  EDIT MODE  ---------------'
        txtFirstName.Text = DepClass.FirstName
        txtMiddleName.Text = DepClass.MiddleName
        txtLastName.Text = DepClass.LastName
        txtAddress1.Text = DepClass.Address1
        txtAddress2.Text = DepClass.Address2
        txtCity.Text = DepClass.City
        txtZip.Text = DepClass.Zip
        txtZipExt.Text = DepClass.ZipExtension
        txtSSN.Text = IIf(DepClass.SSN <> "", DepClass.SSN, "")
        txtPhone.Text = DepClass.Phone
        txtEmail.Text = DepClass.Email

        txtDoB.Text = DepClass.BirthDate
        If DepClass.BirthDate <> "" Then
            TxtDOBFormatted.Text = DateTime.Parse(DepClass.BirthDate).ToString("yyyy-MM-dd")
        Else
            TxtDOBFormatted.Text = ""
        End If
        ddlGender.SelectedValue = DepClass.Gender
        ddlPrefix.SelectedValue = IIf(DepClass.Prefix <> "", DepClass.Prefix, "")
        ddlSuffix.SelectedValue = IIf(DepClass.Suffix <> "", DepClass.Suffix, "")
        ddlState.SelectedValue = IIf(DepClass.State <> "", DepClass.State, "")
        ddlCountry.SelectedValue = IIf(DepClass.Country <> "", DepClass.Country, "USA")
        ddlDependentType.SelectedValue = DepClass.DepBenTypeId

        chkTobacco.Checked = DepClass.TobaccoUser
        chkDisabled.Checked = DepClass.Disabled
        chkStudent.Checked = DepClass.Student
        chkActive.Checked = DepClass.Active
        chkSameAsEmp.Checked = DepClass.AddressSameAsEmp

        If ec.GetEmployeeInfo(intCompanyId, intEmployeeId) Then
            TextEEAddress1.Text = ec.Address1
            TextEEAddress2.Text = ec.Address2
            TextEECity.Text = ec.City
            TextEEZip.Text = ec.Zip
            TextEEZipExt.Text = ec.ZipExtension
            ddlEEState.SelectedValue = ec.State
            ddlEECountry.SelectedValue = ec.Country

        End If

        If ddlRelationship.SelectedValue > 7 And (ddlDependentType.SelectedValue = 1 Or ddlDependentType.SelectedValue = 3 Or ddlDependentType.SelectedValue = 6 Or ddlDependentType.SelectedValue = 7) Then
            'this will remove current relationship since it Is Not allowed
            ddlRelationship.SelectedValue = IIf(Dependent.MultipleSpouse(intEmployeeId, Session("DepBenId"), Session("AddNewDependent")) = True, 5, 1)
        Else
            ddlRelationship.SelectedValue = DepClass.RelationshipId
        End If

        Session("RelationshipId") = ddlRelationship.SelectedValue

        DepClass.LoadRelationshipTypes(ddlDependentType.SelectedValue, ddlRelationship)  'this will show all relationship types on initial load

        ShowOrHideDepInfo()

    End Sub

    Protected Sub grdDepBen_RowCreated(sender As Object, e As GridViewRowEventArgs) Handles grdDepBen.RowCreated
        If e.Row.RowType = System.Web.UI.WebControls.DataControlRowType.DataRow Then

            e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#EFF3FB'")
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=''")

            e.Row.Attributes.Add("style", "cursor:pointer;")
            e.Row.Attributes("onclick") = Page.ClientScript.GetPostBackClientHyperlink(grdDepBen, "Select$" & e.Row.RowIndex)
            e.Row.ToolTip = "Click to Edit Dependent."

            lblHightlight1.Visible = True
        End If
    End Sub

    Protected Sub OnSelectedIndexChanged(sender As Object, e As EventArgs)
        Dim row As GridViewRow = grdDepBen.SelectedRow

        Session("DepBenId") = grdDepBen.SelectedValue
        s.SaveUserUpdate(Session("UserId"), "EERelationship", "Browse DepBenId:  " & Session("DepBenId"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

        'Go Get Dependent Info
        booGotDependent = DepClass.GetDepBenInfo(intCompanyId, intEmployeeId, Session("DepBenId"))

        If booGotDependent = True Then
            PopulateEditFields()
            
        End If
        DivDependentReview.Visible = False
        DivDependentEdit.Visible = True
        imgNext.Visible = False
        DivMainArticalTitleandText.Visible = False

    End Sub

    Protected Sub btnSaveDep_Click(sender As Object, e As EventArgs) Handles btnSaveDep.Click
        'Check for Duplicate Spouse
        If ddlRelationship.SelectedValue = "1" Or ddlRelationship.SelectedValue = "2" Or ddlRelationship.SelectedValue = "3" Then
            ' Before Saving a new or updating an existing dependent row as a Spouse, check for existing
            If Dependent.MultipleSpouse(intEmployeeId, Session("DepBenId"), Session("AddNewDependent")) = True Then
                lblError.Text = "Error:  There is already an active Spouse, Common Law Spouse or Domestic Partner on record."
                lblError.Visible = True
                DivError.Visible = True
                imgNext.Visible = False
                ResetScrollPosition()
                Exit Sub
            End If

        End If

        If ddlRelationship.SelectedValue = "" Or ddlRelationship.SelectedValue = "0" Or ddlDependentType.SelectedValue = "" Or ddlDependentType.SelectedValue = "0" Then
            lblError.Text = "Please choose a valid Type and Relationship combination"
            DivError.Visible = True
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If

        'Check for Name.
        If Trim(txtFirstName.Text) = "" Or Trim(txtLastName.Text) = "" Then
            lblError.Text = "Please enter a value in the following field(s):"
            If Trim(txtFirstName.Text) = "" Then
                lblError.Text = lblError.Text + "<br>First Name"
            End If
            If Trim(txtLastName.Text) = "" Then
                lblError.Text = lblError.Text + "<br>Last Name"
            End If
            lblError.Visible = True
            DivError.Visible = True
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If

        'The following checks only apply to Dependents
        If Session("Dependent") = True And chkActive.Checked = True Then
            If Trim(txtDoB.Text) = "" Then
                lblError.Text = "Please enter a Birth Date for Dependent"
                lblError.Visible = True
                DivError.Visible = True
                imgNext.Visible = False
                ResetScrollPosition()
                Exit Sub
            End If

            If txtDoB.Text <> "" Then
                'check birthdate
                Dim isValidDate As Boolean = IsDate(txtDoB.Text)
                If isValidDate = False Then

                    ' If Dependent.ValidDOBFormat(txtDoB.Text) = False Then
                    lblError.Text = "The Date of Birth is not in a valid format or is not a valid date"
                    lblError.Visible = True
                    DivError.Visible = True
                    imgNext.Visible = False
                    ResetScrollPosition()
                    Exit Sub
                End If
            End If

            'Make sure SP is over 14
            If Dependent.ValidSpouseAge(txtDoB.Text) = False And (ddlRelationship.SelectedValue = "1" Or ddlRelationship.SelectedValue = "2" Or ddlRelationship.SelectedValue = "3") Then
                lblError.Text = "Spouse, Common Law Spouse or Domestic Partner must be greater than 14 years of age.  Please validate Relationship type and Date of Birth"
                lblError.Visible = True
                DivError.Visible = True
                imgNext.Visible = False
                ResetScrollPosition()
                Exit Sub
            End If

            If ddlGender.SelectedValue = "3" Then
                lblError.Text = "A Gender of Male or Female must be selected for a Dependent"
                lblError.Visible = True
                DivError.Visible = True
                imgNext.Visible = False
                ResetScrollPosition()
                Exit Sub
            End If

            If ddlRelationship.SelectedValue < 8 Then
                'Validate SSN if Dep is over 1 year of age.
                Dim strSSN As String
                strSSN = txtSSN.Text.Replace("-", "")

                Dim Now As DateTime = DateTime.Now
                Dim strAge As Date = txtDoB.Text
                Dim age = Now.Year - strAge.Year

                If (age > 1 And ddlDependentType.SelectedValue <> 2) Or (strSSN <> "") Then   ' added validation if ANY part of SSN is entered
                    If Employee.ValidateSSN(strSSN) = False Then
                        lblError.Text = "The SSN you entered is not valid"
                        lblError.Visible = True
                        DivError.Visible = True
                        imgNext.Visible = False
                        ResetScrollPosition()
                        Exit Sub
                    End If
                End If
            End If

            'Validate Address if Dependent
            If ddlDependentType.SelectedValue = 1 Or ddlDependentType.SelectedValue = 3 Or ddlDependentType.SelectedValue = 6 Or ddlDependentType.SelectedValue = 7 Then 'Dependents
                If Trim(txtAddress1.Text) = "" Or Trim(txtCity.Text) = "" Or Trim(txtZip.Text) = "" Then
                    lblError.Text = "Please enter valid data into the following field(s):"
                    If Trim(txtAddress1.Text) = "" Or Trim(txtAddress1.Text).Length < 5 Then
                        lblError.Text = lblError.Text + "<br>Address Line 1"
                    End If
                    If Trim(txtCity.Text) = "" Or Trim(txtAddress1.Text).Length < 3 Then
                        lblError.Text = lblError.Text + "<br>City"
                    End If
                    If Trim(txtZip.Text) = "" Or Trim(txtZip.Text).Length < 5 Then
                        lblError.Text = lblError.Text + "<br>Zip"
                    End If
                    lblError.Visible = True
                    DivError.Visible = True
                    imgNext.Visible = False
                    ResetScrollPosition()
                    Exit Sub
                End If
            End If
        End If

        If (ddlDependentType.SelectedValue = 5 Or ddlDependentType.SelectedValue = 6 Or ddlDependentType.SelectedValue = 7 Or ddlDependentType.SelectedValue = 8) And txtPhone.Text = "" Then
            lblError.Text = "Emergency Contacts Must have Phone Number Provided"
            lblError.Visible = True
            DivError.Visible = True
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If

        'Save New Contact Info 
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        objParam = New SqlParameter("@CompanyId", intCompanyId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EmployeeId", intEmployeeId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DepBenId", Session("DepBenId"))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@RelationshipId", ddlRelationship.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DepBenTypeId", ddlDependentType.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Prefix", ddlPrefix.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@FirstName", txtFirstName.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@MiddleName", txtMiddleName.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@LastName", txtLastName.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Suffix", ddlSuffix.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@AddressSame", chkSameAsEmp.Checked)
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
        objParam = New SqlParameter("@Phone", txtPhone.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Email", txtEmail.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@SSN", txtSSN.Text.Replace("-", ""))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@DOB", txtDoB.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Gender", ddlGender.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@TobaccoUser", chkTobacco.Checked)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Disabled", chkDisabled.Checked)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Student", chkStudent.Checked)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@NewDepBen", Session("AddNewDependent"))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@UserId", Session("UserId"))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Active", IIf(chkActive.Checked, "True", "False"))
        aryParams.Add(objParam)

        objDataSet = sqlCon.CreateDataSet("usp_DepBen_Edit", aryParams)
        sqlCon.CloseConn()

        s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)
        DivError.Visible = False


        'Fill up DepBen Grid
        DepClass.PopulateDepBenList(intCompanyId, intEmployeeId, "ALL", chkActivesOnly.Checked, 0, grdDepBen)
        'Show Review Panels
        DivDependentEdit.Visible = False
        DivDependentReview.Visible = True
        imgNext.Visible = True

    End Sub

    Protected Sub btnAddDependent_Click(sender As Object, e As EventArgs) Handles btnAddDependent.Click
        lblMainArticleText.Text = "Please enter information below. <br/><b>Note that adding a Dependent or Beneficiary here will not automatically align them with a benefit.  You must Declare an Event then Enroll them in the applicable benefit.</b>"
        'ddlDependentType.SelectedValue = 0
        AddDep()
    End Sub

    Private Sub AddDep()
        Session("AddNewDependent") = 1

        If Dependent.MultipleSpouse(intEmployeeId, Session("DepBenId"), Session("AddNewDependent")) = True Then
            ddlRelationship.Items.Remove("Spouse")
        End If

        DepClass.LoadRelationshipTypes(ddlDependentType.SelectedValue, ddlRelationship)

        '-------------  Clear all fields  ---------------'
        txtFirstName.Text = ""
        txtMiddleName.Text = ""
        txtLastName.Text = ""
        txtPhone.Text = ""
        txtSSN.Text = ""
        txtDoB.Text = ""
        ddlGender.SelectedValue = 3
        ddlPrefix.SelectedValue = ""
        ddlSuffix.SelectedValue = ""
        ddlState.SelectedValue = ""
        ddlCountry.SelectedValue = "USA"
        ddlDependentType.SelectedValue = 1
        ddlRelationship.SelectedValue = IIf(Dependent.MultipleSpouse(intEmployeeId, Session("DepBenId"), Session("AddNewDependent")) = True, 5, 1)
        Session("RelationshipId") = ddlRelationship.SelectedValue
        chkTobacco.Checked = False
        chkDisabled.Checked = False
        chkStudent.Checked = False
        DivDependentReview.Visible = False
        imgNext.Visible = False
        DivDependentEdit.Visible = True
        chkActive.Checked = True

        If ec.GetEmployeeInfo(intCompanyId, intEmployeeId) Then
            chkSameAsEmp.Checked = True
            txtAddress1.Text = ec.Address1
            txtAddress2.Text = ec.Address2
            txtCity.Text = ec.City
            txtZip.Text = ec.Zip
            txtZipExt.Text = ec.ZipExtension
            ddlState.SelectedValue = ec.State
            ddlCountry.SelectedValue = ec.Country
        End If

    End Sub

    Protected Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        DivDependentReview.Visible = True
        DivDependentEdit.Visible = False
        imgNext.Visible = True

    End Sub

    'Protected Sub chkSameAsEmp_CheckedChanged(sender As Object, e As EventArgs) Handles chkSameAsEmp.CheckedChanged

    '    If chkSameAsEmp.Checked = True Then
    '        If ec.GetEmployeeInfo(intCompanyId, intEmployeeId) Then
    '            txtAddress1.Text = ec.Address1
    '            txtAddress2.Text = ec.Address2
    '            txtCity.Text = ec.City
    '            txtZip.Text = ec.Zip
    '            txtZipExt.Text = ec.ZipExtension
    '            ddlState.SelectedValue = ec.State
    '            ddlCountry.SelectedValue = ec.Country
    '        End If
    '    Else
    '        txtAddress1.Text = ""
    '        txtAddress2.Text = ""
    '        txtCity.Text = ""
    '        txtZip.Text = ""
    '        txtZipExt.Text = ""
    '        ddlState.SelectedIndex = -1
    '        ddlCountry.SelectedValue = "USA"
    '    End If
    'End Sub

    Protected Sub chkActivesOnly_CheckedChanged(sender As Object, e As EventArgs) Handles chkActivesOnly.CheckedChanged
        DepClass.PopulateDepBenList(intCompanyId, intEmployeeId, "ALL", chkActivesOnly.Checked, 0, grdDepBen)

    End Sub

    Protected Sub chkActive_CheckedChanged(sender As Object, e As EventArgs) Handles chkActive.CheckedChanged
        If chkActive.Checked = False Then
            DivError.Visible = True
            lblError.Text = "<b>Please Note</b> that inactivating the Dependent will make them ineligble for benefits and you will not be able to designate them as a beneficiary."
        Else
            DivError.Visible = False
            lblError.Text = ""
        End If
    End Sub

    Private Sub ShowOrHideDepInfo()
        If ddlDependentType.SelectedValue = 4 Or ddlDependentType.SelectedValue = 5 Then
            DepRequiredInfo.Visible = False
            Session("Dependent") = False

        Else
            Session("Dependent") = True
            DepRequiredInfo.Visible = True
        End If

    End Sub

    Protected Sub ddlDependentType_SelectedIndexChanged(sender As Object, e As EventArgs)
        DepClass.LoadRelationshipTypes(ddlDependentType.SelectedValue, ddlRelationship)
        ddlRelationship.Items.Add(New ListItem("", "0"))
        If Session("RelationshipId") > 7 And (ddlDependentType.SelectedValue = 1 Or ddlDependentType.SelectedValue = 3 Or ddlDependentType.SelectedValue = 6 Or ddlDependentType.SelectedValue = 7) Then
            'this will remove current relationship since it is not allowed
            ddlRelationship.SelectedValue = "0"
            lblError.Text = "Please choose a Valid Relationship for this Type"
            DivError.Visible = True
        Else
            ddlRelationship.SelectedValue = Session("RelationshipId")
        End If

        ShowOrHideDepInfo()

    End Sub

    Protected Sub ddlRelationship_SelectedIndexChanged(sender As Object, e As EventArgs)
        ShowOrHideDepInfo()

    End Sub

#Region "Employee Notes Module"
    Protected Sub a_grdEmployee_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdEmployeeNotes.RowDataBound
        If e.Row.RowType = System.Web.UI.WebControls.DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#EFF3FB'")  'old color   8bcced
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=''")
            e.Row.Attributes.Add("style", "cursor:pointer;")
            'e.Row.Attributes("onclick") = Page.ClientScript.GetPostBackClientHyperlink(grdEmployeeNotes, "Select$" & e.Row.RowIndex)
            e.Row.ToolTip = "Click to edit this Note."
        End If
    End Sub

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

#End Region

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)

        'Find Next Screen in Navigation
        If DivError.Visible = True Then
            Exit Sub
        Else
            imgNext.Visible = False

            ResetScrollPosition()
            Response.AddHeader("REFRESH", "0;URL=" + Session("NextScreen"))
        End If

    End Sub

    Private Sub ResetScrollPosition()
        If Not ClientScript.IsClientScriptBlockRegistered(Me.GetType(), "CreateResetScrollPosition") Then
            'Create the ResetScrollPosition() function
            ClientScript.RegisterClientScriptBlock(Me.GetType(), "CreateResetScrollPosition",
                             "function ResetScrollPosition() {" & vbCrLf &
                             " var scrollX = document.getElementById('__SCROLLPOSITIONX');" & vbCrLf &
                             " var scrollY = document.getElementById('__SCROLLPOSITIONY');" & vbCrLf &
                             " if (scrollX && scrollY) {" & vbCrLf &
                             "    scrollX.value = 0;" & vbCrLf &
                             "    scrollY.value = 0;" & vbCrLf &
                             " }" & vbCrLf &
                             "}", True)

            'Add the call to the ResetScrollPosition() function
            ClientScript.RegisterStartupScript(Me.GetType(), "CallResetScrollPosition", "ResetScrollPosition();", True)
        End If

    End Sub
End Class


