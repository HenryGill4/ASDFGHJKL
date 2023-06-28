Imports System.Data.SqlClient

Partial Class EE_Accept
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee
    Dim p As New Plans
    Dim c As New Company

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer

    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "BenAccept"
        strScreenShortDesc = "Benefit Acceptance"

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

            End If

            sc.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), Session("ScreenPath"))
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            lblMainArticleTitle.Text = sc.MainArticleTitle
            lblMainArticleText.Text = sc.MainArticleText

            If lblMainArticleText.Text = "" Then
                divText.Visible = False
            End If
            If lblMainArticleTitle.Text = "" Then
                divTitle.Visible = False
            End If

            SetProgressBar()
            PopulateFields()
            RequiredFieldsCheck()

        End If

        If Session("DataComplete") = "Yes" Then
            If txtSignature.Text <> "" And txtSignatureDate.Text <> "" Then
                divError.Visible = False
                divSuccess.Visible = True
                divMainArticalTitleandText.Visible = True
                divSignatureAndDate.Visible = True
            Else
                divError.Visible = False
                divMainArticalTitleandText.Visible = True
                divSignatureAndDate.Visible = True
                divProgressBarSection.Visible = True
            End If
        ElseIf lblError.Text <> "" Then
            divError.Visible = True
            divSuccess.Visible = False
            divTitle.Visible = False
            divMainArticalTitleandText.Visible = False
            divSignatureAndDate.Visible = False
        End If

        ''''''''''''''''''''''''''''''''''''''''''''   
        ''  Side Menu Info-  Fill Benefit Summary
        ''''''''''''''''''''''''''''''''''''''''''''
        p.PopulatePendingBenefitSummary(intCompanyId, intEmployeeId, grdSummary)
            Dim booGotExistingElection As Boolean
            Session("dsExistingElection") = New DataSet
            booGotExistingElection = p.GetExisting(intCompanyId, intEmployeeId, Session("CurrentPlanTypeId"), Session("dsExistingElection"))
            If booGotExistingElection = True Then
                Dim dt As DataTable
                'Now go thru and reselect and covered Dependents
                dt = Session("dsExistingElection").tables(0)

                If Not dt.Rows(0)("TotalEECost") Is Nothing Then
                    lblSum.Text = Convert.ToDecimal(dt.Rows(0)("TotalEECost")).ToString("c")
                Else
                    lblSum.Text = "$0.00"
                End If
            End If

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub RequiredFieldsCheck()
        ''''''''''''''''''''''''''''''''
        '  Check for completed elections
        '''''''''''''''''''''''''''''''''
        Dim bCompleted As Boolean
        Dim ds As New DataSet
        Dim dt As New DataTable
        Dim strError As String
        Dim i As Integer
        i = 1
        bCompleted = p.CheckForElections(intCompanyId, intEmployeeId, Session("UserId"), ds)
        If bCompleted = False Then
            strError = "<b>Error</b> - You must elect or decline coverage for the following missing plan types: <ul>"
            dt = ds.Tables(0)
            For Each row As DataRow In dt.Rows
                If i = 1 Then
                    strError = strError + "<li>" + row.Item("PlanTypeDesc")
                Else
                    strError = strError + "<li>" + row.Item("PlanTypeDesc") + "</li>"
                End If
                i = i + 1
            Next
            strError = strError + "</ul>Please return to the <strong>Enroll</strong> tab and fix any issues identified."
            lblError.Text = strError
            Session("DataComplete") = "No"
            Exit Sub
        Else
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'Check that elections meet plan rules - Add EOI  Warning Here
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'Check for any Clients specific rules
            '''''''''''''''''''''''''''''''''''''''''''''''
            'Check for missing Demographic Required data
            '''''''''''''''''''''''''''''''''''''''''''''''
            Dim bMissing As Boolean
            i = 1
            bMissing = p.CheckForRequiredFields(intEmployeeId, Session("UserId"), ds)
            If bMissing = False Then
                strError = "Some required information is not complete.  Please return to the <b>Employee Profile </b> tab and provide the following: "
                dt = ds.Tables(0)
                For Each row As DataRow In dt.Rows
                    If i = 1 Then
                        strError = strError + row.Item("MIA")
                    Else
                        strError = strError + ", " + row.Item("MIA")
                    End If
                    i = i + 1
                Next
                lblError.Text = strError
                Session("DataComplete") = "No"
                Exit Sub
            Else
                Session("DataComplete") = "Yes"

            End If
        End If
    End Sub

    Private Sub PopulateFields()
        If ec.GetEmployeeFormResponses(intCompanyId, intEmployeeId, Session("ScreenName")) = True Then
            txtSignature.Text = ec.FormSignature
            txtSignatureDate.Text = IIf(ec.SignatureDate = "1/1/1900", Date.Now(), ec.SignatureDate)
        End If

    End Sub

    Private Sub Save()

        btnAccept.Visible = False
        imgProcessing.Visible = True

        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        objParam = New SqlParameter("@CompanyId", intCompanyId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EmployeeId", intEmployeeId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@UserId", Session("UserId"))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@ScreenName", Session("ScreenName"))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@FormSignature", txtSignature.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@SignatureDate", txtSignatureDate.Text)
        aryParams.Add(objParam)

        objDataSet = sqlCon.CreateDataSet("usp_Employee_Form_Response_Edit", aryParams)
        sqlCon.CloseConn()

        divSuccess.Visible = True

        s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

        PopulateFields()
        ResetScrollPosition()

        imgProcessing.Visible = False
        btnAccept.Visible = True

        Response.AddHeader("REFRESH", "3;URL=EE_Welcome.aspx")

    End Sub

    Protected Sub btnAccept_Click(sender As Object, e As ImageClickEventArgs) Handles btnAccept.Click
        RequiredFieldsCheck()

        If divError.Visible = False Then
            Save()

            'If c.GetCompanyEmployeePaymentProcessing(Session("CompanyId"), 18) = True Then
            '    Server.Transfer("EE_Payments_S1.aspx")

            'End If
        End If
    End Sub

    Protected Sub SetProgressBar()
        ''  Populate progress bar
        Dim PercentageComplete As Integer
        Dim widthset As String

        PercentageComplete = p.GetPercentage(intCompanyId, intEmployeeId, Session("UserId"))
        widthset = PercentageComplete.ToString + "%"
        divProgressBar.Attributes.Add("aria-valuenow", PercentageComplete.ToString)
        divProgressBar.Style.Add("width", widthset)
        lblProgress.Text = PercentageComplete.ToString + "%"

    End Sub

    Private Sub ResetScrollPosition()
        If Not ClientScript.IsClientScriptBlockRegistered(Me.GetType(), "CreateResetScrollPosition") Then
            'Create the ResetScrollPosition() function
            ClientScript.RegisterClientScriptBlock(Me.GetType(), "CreateResetScrollPosition",
                             "Function ResetScrollPosition() {" & vbCrLf &
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

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Save()

        Response.Redirect(Session("NextScreen"))

    End Sub
End Class
