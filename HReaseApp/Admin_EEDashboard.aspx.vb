Imports System.Data.SqlClient

Public Class Admin_EEDashboard
    Inherits System.Web.UI.Page

    Dim SecClass As New Security
    Dim CompanyClass As New Company
    Dim ec As New Employee
    Dim DepClass As New Dependent
    Dim sc As New ScreenConfiguration
    Dim PlanClass As New Plans
    Dim bresult As Boolean
    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        Session("DisplayName") = Session("AdminName")
        'lblEmployeeName.Text = "Employee:  " & Session("ShadowEmployeeName")
        intCompanyId = Session("ShadowCompanyId")
        intEmployeeId = Session("ShadowEmployeeId")

        If Page.IsPostBack = False Then
            SecClass.SaveUserBrowse(Session("UserId"), "AdminEEDashboard", "Browse")
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_EEDashboard")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, "Admin_EEDashboard", Session("Athena"))
        End If
        PopulateEEWebConfigInfo()
        PopulateEmployeeData()
    End Sub

    Private Sub PopulateEEWebConfigInfo()
        ec.getEEWebConfig(intCompanyId, intEmployeeId, Session("UserId"), grdEEWebConfig)

    End Sub
    Private Sub PopulateEmployeeData()
        If ec.GetEmployeeInfo(intCompanyId, intEmployeeId) Then
            lblEmployeeFullName.Text = Session("ShadowEmployeeName")
            lblAddress.Text = ec.Address1
            lblAddress2.Text = ec.Address2
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZip.Text = ec.Zip
            lblPhone.Text = ec.MobilePhone
            lblEmail.Text = ec.Email1

            'grdDependents.DataSource = DepClass.GetDependentList(intCompanyId, intEmployeeId, 1)
            'grdDependents.DataBind()
        End If

        'If PlanClass.GetModalContentByModalCompanyId(19, intCompanyId) Then
        '    mlblRegistrationTitle.Text = PlanClass.ModalTitle
        '    mlblRegistrationText1.Text = PlanClass.ModalText1
        '    mlblRegistrationText2.Text = PlanClass.ModalText2
        '    mlblRegistrationText3.Text = PlanClass.ModalText3
        'End If

        Session("RegistrationKey") = ec.GetUniqueKey 'System.Web.Security.Membership.GeneratePassword(12, 1)      

        'btnPrint.Attributes.Add("Onclick", "PrintWindow('ModalRegistration');")

        'Populate Modal
        'mlblRegistrationTitle.Text = "Registration Information"
        'mlblEmployeeName.Text = "<h4>" + ec.FullName + "</h3>"
        'mlblRegistrationKey.Text = "<b>" + Session("RegistrationKey") + "</b>"
        'mlblClientURL.Text = "<b>" + Session("URL") + "</b>"


    End Sub


    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Response.Redirect("~/EE_Welcome.aspx")
    End Sub

    Protected Sub ButtonEdit_Click(sender As Object, e As EventArgs)
        Try
            Dim box As CheckBox = DirectCast(sender, CheckBox)
            Dim tblcell As TableCell = CType(box.Parent, TableCell)
            Dim dgRow As GridViewRow = CType(tblcell.Parent, GridViewRow)
            Dim dgGrid As GridView = DirectCast(dgRow.DataKeysContainer, GridView)

            Dim CompanyId As String = dgGrid.DataKeys(dgRow.RowIndex).Values("CompanyId")
            Dim EmployeeId As String = dgGrid.DataKeys(dgRow.RowIndex).Values("EmployeeId")
            Dim ScreenId As String = dgGrid.DataKeys(dgRow.RowIndex).Values("ScreenId")
            Dim IsAssigned As String = dgGrid.DataKeys(dgRow.RowIndex).Values("IsAssigned")

            'CompanyClass.SaveCompanyWebConfig(CompanyId, ScreenId, IsAssigned, Session("UserId"))

            'Save New WebConfig Info 
            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()

            objParam = New SqlParameter("@CompanyId", "1161")
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EmployeeId", "206795")
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ScreenId", "62")
            aryParams.Add(objParam)
            objParam = New SqlParameter("@IsAssigned", "1")
            aryParams.Add(objParam)
            objParam = New SqlParameter("@UserId", "1")
            aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("usp_Employee_WebConfig_Edit", aryParams)
            ''''''''''''''''''''''''''''''
            sqlCon.CloseConn()
            aryParams = Nothing
            sqlCon = Nothing

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        'PopulateEEWebConfigInfo()

    End Sub
End Class

