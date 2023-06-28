Imports System.Data.SqlClient

Public Class EE_Event
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer
    Dim intEventTypeId As Integer
    Dim strEventType As String
    Dim strEventDate As String
    Dim strOEEffectiveDate As String

    Dim strScreenName As String

    Dim booGotEvent As Boolean

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EmployeeEvent"

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
                Session("CurrentPlanTypeId") = sc.PlanTypeId
                Session("LatestEventDesc") = sc.LatestEventDesc
                Session("LatestEventDate") = sc.LatestEventDate
                Session("LatestEventTypeId") = sc.LatestEventTypeId

            End If

            sc.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), Session("ScreenPath"))
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            lblMainArticleTitle.Text = sc.MainArticleTitle
            lblMainArticleText.Text = sc.MainArticleText

            PopulateFields()

            If lblMainArticleText.Text = "" Then
                divText.Visible = False
            End If

            DivError.Visible = False

        End If

        'divSuccess.Visible = False

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Public Sub PopulateFields()

        'Now go get Event
        ec.GetEmployeeEventInfo(intEmployeeId, Session("UserId"), 0, intCompanyId)

        TxtLatestEventDate.Text = ec.EventDate
        TxtIEDate.Text = ec.IEEffectiveDate
        TxtOEDate.Text = ec.OEEffectiveDate
        txtEventDate1.Text = txtEventDate.Text

        If ec.EventShortDesc = "No Event Declared" Then
            txtEventDate.Enabled = False
            txtEventDate.Text = ""
            TxtLatestEventDate.Text = ""
        Else
            txtEventDate.Text = DateTime.Parse(Session("LatestEventDate")).ToString("yyyy-MM-dd")

        End If

        Session("EventType") = ec.EventShortDesc
        strEventType = ec.EventShortDesc

        Session("EventTypeId") = ec.EventTypeId
        intEventTypeId = ec.EventTypeId

        Session("IEEffectiveDate") = ec.IEEffectiveDate

        Session("OEEffectiveDate") = ec.OEEffectiveDate
        strOEEffectiveDate = ec.OEEffectiveDate

        Session("EventDate") = ec.EventDate
        strEventDate = ec.EventDate

        If ec.EventDate <> "" Then
            TxtDateFormatted.Text = DateTime.Parse(ec.EventDate).ToString("yyyy-MM-dd")
        Else
            TxtDateFormatted.Text = ""
        End If

        Dim strIEEffectiveDate As String
        strIEEffectiveDate = ec.IEEffectiveDate
        Dim MyIEEffDateString As String = strIEEffectiveDate
        Dim MyIEEffDateTime As DateTime = DateTime.Parse(MyIEEffDateString)
        Console.WriteLine(MyIEEffDateTime)

        TxtDateFormatted.Text = MyIEEffDateTime.ToString("yyyy-MM-dd")
        If ec.EventShortDesc = "IE" Then
            sc.ScreenSetup(intCompanyId, "EmployeeEvent", Session("UserId"))
            lblMainArticleTitle.Text = sc.IETitle
            lblMainArticleText.Text = sc.IEText
            txtEventDate.Enabled = False
            TxtDateFormatted.Text = DateTime.Parse(Session("IEEffectiveDate")).ToString("yyyy-MM-dd")
        ElseIf ec.EventShortDesc = "OE" Then
            sc.ScreenSetup(intCompanyId, "EmployeeEvent", Session("UserId"))
            lblMainArticleTitle.Text = sc.OETitle
            lblMainArticleText.Text = sc.OEText
            txtEventDate.Enabled = False
            TxtDateFormatted.Text = DateTime.Parse(Session("OEEffectiveDate")).ToString("yyyy-MM-dd")
        ElseIf ec.InIE = False And MyIEEffDateTime > Now And ec.IsEligible = True Then
            imgNext.Visible = False
            lblMainArticleTitle.Visible = False
            divCol1.Visible = False
            If Session("Admin") = False Then
                lblMainArticleText.Text = "<center>You are eligible for benefits effective <b>" & ec.IEEffectiveDate &
                                          "</b> However, your enrollment window is from <span style=color:red;><b>" & ec.IEBeginDate & "</b></span> to <span style=color:red;><b>" & ec.IEEndDate & "</b></span>.  
                                            <br/> <br/>
                                            If you need to make changes outside of this period, you will need to contact your administrator for assistance.</center>
                                            <br/> <br/>"
                divCol2.Visible = False
            Else
                lblMainArticleText.Text = "<center>ADMINISTRATOR:  This employee is eligible for benefits effective <b>" & ec.IEEffectiveDate &
                                           "</b> However, their enrollment window is from <span style=color:red;><b>" & ec.IEBeginDate & "</b></span> to <span style=color:red;><b>" & ec.IEEndDate & "</b></span>.  
                                            <br/> <br/>
                                            Administrators may process events but the employee will not have access to any functionality on this page.</center>
                                            <br/> <br/>"
            End If

        ElseIf ec.IsEligible = False Then
            imgNext.Visible = False
            lblMainArticleTitle.Visible = False
            divCol1.Visible = False
            divCol2.Visible = False
            If Session("Admin") = False Then
                lblMainArticleText.Text = "<center><color='red'>You are not showing as eligible for benefits.</color> 
                                        <br/> <br/> 
                                        Please contact your HR Administrator if you have any questions or concerns about this information.<center>
                                        <br/> <br/> "
            Else
                lblMainArticleText.Text = "<center><color='red'>This employee is not eligible for benefits.  Please verify that they are in an eligible class on their Profile page.</color> 
                                        <br/> <br/>"
            End If

        Else
            sc.ScreenSetup(intCompanyId, "EmployeeEvent", Session("UserId"))
            lblMainArticleTitle.Text = sc.OtherTitle
            lblMainArticleText.Text = sc.OtherText


        End If

        'Load up Event List
        If Session("Admin") = True Then
            ec.LoadEventTypes(True, Session("UserId"), ddlOtherEventTypes)
        Else
            ec.LoadEventTypes(False, Session("UserId"), ddlOtherEventTypes)
        End If

        ddlOtherEventTypes.Items.Insert(0, New ListItem("-- Select Event --"))
        ddlOtherEventTypes.Attributes.Add("style", "Color:grey")

        If ec.EventTypeId <> "0" Then
            ddlOtherEventTypes.SelectedValue = ec.EventTypeId

        Else
            ddlOtherEventTypes.SelectedValue = "-- Select Event --"
            txtEventDate.Text = ""
            TxtDateFormatted.Text = ""
        End If

        sc.ScreenSetup(intCompanyId, "Event", Session("UserId"))
        'Fill in Text
        If Not sc.TopDocument1Text Is Nothing Then
            lblMainArticleText.Text = sc.TopDocument1Text
            divText.Visible = True
        End If
        If Not sc.BottomDocument1Text Is Nothing Then
            lblBottomDocument.Text = sc.BottomDocument1Text
            divBottomComment.Visible = True
        End If

        If sc.SideMenu1Title <> "" And sc.SideMenu1Text <> "" Then
            lblSideMenu1Title.Text = sc.SideMenu1Title
            If Len(sc.SideMenu1Text) > 1000 Then
                lblSideMenu1text.Text = sc.SideMenu1Text.Substring(0, InStr(1000, sc.SideMenu1Text, " ") - 1) & "..."
                lblModalTitle1.Text = sc.SideMenu1Title
                lblModalText1.Text = sc.SideMenu1Text
                btnMenu1.Visible = True
            Else
                lblSideMenu1text.Text = sc.SideMenu1Text
                btnMenu1.Visible = False
            End If
        End If

        If sc.SideMenu2Title <> "" And sc.SideMenu2Text <> "" Then
            lblSideMenu2Title.Text = sc.SideMenu2Title
            If Len(sc.SideMenu2Text) > 1000 Then
                lblSideMenu2text.Text = sc.SideMenu2Text.Substring(0, 1000) & "..."
                lblModalTitle2.Text = sc.SideMenu2Title
                lblModalText2.Text = sc.SideMenu2Text
                btnMenu2.Visible = True
            Else
                lblSideMenu2text.Text = sc.SideMenu2Text
                btnMenu2.Visible = False
            End If

        End If

        If sc.SideMenu3Title <> "" And sc.SideMenu3Text <> "" Then
            lblSideMenu3Title.Text = sc.SideMenu3Title
            lblModalTitle3.Text = sc.SideMenu3Title
            lblModalText3.Text = sc.SideMenu3Text
            If Len(sc.SideMenu3Text) > 1000 Then
                lblSideMenu3text.Text = sc.SideMenu3Text.Substring(0, 1000) & "..."
                btnMenu3.Visible = True
            Else
                lblSideMenu3text.Text = sc.SideMenu3Text
                btnMenu3.Visible = False
            End If
        End If

    End Sub

    Protected Sub ddlOtherEventTypes_SelectedIndexChanged(sender As Object, e As EventArgs)
        DivError.Visible = False

        imgNext.Visible = True
        If ddlOtherEventTypes.SelectedItem.Text = "Initial Enrollment" Then
            TxtDateFormatted.Text = DateTime.Parse(Session("IEEffectiveDate")).ToString("yyyy-MM-dd")
            txtEventDate.Text = Session("IEEffectiveDate")
            txtEventDate.Enabled = False
        ElseIf ddlOtherEventTypes.SelectedItem.Text = "Open Enrollment" Then
            txtEventDate.Text = Session("OEEffectiveDate")
            TxtDateFormatted.Text = DateTime.Parse(Session("OEEffectiveDate")).ToString("yyyy-MM-dd")
            txtEventDate.Enabled = False
        ElseIf ddlOtherEventTypes.SelectedItem.Text = "-- Select Event --" Then
            TxtDateFormatted.Text = ""
            txtEventDate.Text = ""
            txtEventDate.Enabled = False
            imgNext.Visible = False
        Else
            txtEventDate.Enabled = True
        End If

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs) Handles imgNext.Click
        TxtDateFormatted.Text = DateTime.Parse(txtEventDate.Text).ToString("yyyy-MM-dd")
        Dim MyEffDateString As String = txtEventDate.Text
        Dim MyEffDateTime As DateTime = DateTime.Parse(MyEffDateString)
        Console.WriteLine(MyEffDateTime)

        If DateDiff("d", MyEffDateTime, Now) > 30 And Session("Admin") = False Then
            lblEventDateError.Text = "Date must be within the past 30-days " '+ DateDiff("d", MyEffDateTime, Now, ).ToString
            lblEventDateError.Visible = True
            DivError.Visible = True
            Exit Sub
        End If

        'Do some Validation on the Event Date if OTHER Status
        If ddlOtherEventTypes.SelectedItem.Text = "-- Select Event --" And txtEventDate.Text = "" Then
            lblError.Text = "Please select an Event Type and Date"
            DivError.Visible = True
            imgNext.Visible = False
            Exit Sub
        ElseIf ddlOtherEventTypes.SelectedValue = "-- Select Event --" Then
            strEventType = Session("EventType")
            lblError.Text = "Please select an Event Type"
            DivError.Visible = True
            imgNext.Visible = False
            Exit Sub
        ElseIf txtEventDate.Text = "" Then
            lblError.Text = "Please select an Event Date"
            DivError.Visible = True
            imgNext.Visible = False
            Exit Sub
        Else
            intEventTypeId = ddlOtherEventTypes.SelectedValue
            Session("EventTypeId") = intEventTypeId
            strEventType = ddlOtherEventTypes.SelectedItem.Text
            Session("EventType") = strEventType
            strEventDate = txtEventDate.Text
            Session("EventDate") = TxtDateFormatted.Text
            imgNext.Visible = True
        End If

        If Session("EventType") = "IE" Or Session("EventType") = "OE" Then
            intEventTypeId = Session("EventTypeId")
            strEventType = Session("EventType")
            strEventDate = TxtDateFormatted.Text
        Else
            intEventTypeId = ddlOtherEventTypes.SelectedValue
            Session("EventTypeId") = intEventTypeId
            strEventType = ddlOtherEventTypes.SelectedItem.Text
            Session("EventType") = strEventType
            strEventDate = txtEventDate.Text
            Session("EventDate") = TxtDateFormatted.Text
        End If

        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        objParam = New SqlParameter("@EmployeeId", intEmployeeId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EventTypeId", intEventTypeId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EventDate", strEventDate)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@UserId", Session("UserId"))
        aryParams.Add(objParam)
        objDataSet = sqlCon.CreateDataSet("usp_Employee_EventType_Save", aryParams)
        sqlCon.CloseConn()

        s.SaveUserUpdate(Session("UserId"), "EmployeeEvent", "Save Event", intEmployeeId, 0, 0, Session("EventDate"), intTransactionId)

        Session("CurrentPlanTypeId") = 0

        'Redirect to benefits page
        Response.Redirect("~/EE_Plans.aspx")

    End Sub

    Protected Sub txtEventDate_TextChanged(sender As Object, e As EventArgs)
        If DivError.Visible = False Then
            imgNext.Visible = True
        End If
    End Sub
End Class
