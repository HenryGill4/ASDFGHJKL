Imports System.Web.UI.DataVisualization.Charting
Imports System.Data.SqlClient
Imports System.IO
Imports Newtonsoft.Json

Partial Class Admin_Welcome
    Inherits System.Web.UI.Page
    Dim s As New Security
    Dim r As New Reports
    Dim sc As New ScreenConfiguration
    Dim c As New Company
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
        strScreenName = "AdminWelcome"
        strScreenShortDesc = "Admin Welcome"

        If Page.IsPostBack = False Then
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_Welcome")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), 0, "Admin_Welcome", Session("Athena"))

            PopulateCompanyInfo()
            PopulateDetailCompanyInfo()
            CompanySummaryChart()
            ElectionSummaryChart()
            GetScreenConfig()
            PrepareElectionChartData()

            intCompanyId = Session("ShadowCompanyId")

            s.SaveUserBrowse(Session("UserId"), strScreenName, "Browsed on " + strScreenShortDesc + " for CompanyId " + intCompanyId.ToString)

            'Populate Dashboard Reports
            Session("dsReports") = New DataSet
            r.Load_ReportList(Session("UserId"), Session("Athena"), "Dashboard", lstReports, Session("dsReports"))

        End If

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
                ddlCompany.Items.Insert(0, New ListItem("SELECT"))
                ddlCompany.Items(0).Selected = True
            End If

        End If

    End Sub

    Private Sub GetScreenConfig()
        sc.ScreenSetup(intCompanyId, "AdminWelcome", Session("UserId"))

        lblAlertTitle.Text = sc.AdminNoticeTitle
        lblAlertMessage.Text = sc.AdminNoticeText

        If intCompanyId = 0 Or Session("ActiveCompany") = 0 Then
            divChartArea.Visible = False
        Else
            divChartArea.Visible = True
        End If

    End Sub

    Private Sub PopulateDetailCompanyInfo()

        If c.GetCompanyInfo(intCompanyId, Session("UserId")) = True Then
            lblAddress.Text = c.Address1
            lblAddress2.Text = c.Address2
            lblZip.Text = c.Zip
            lblState.Text = c.State
            lblCity.Text = c.City

            lblContactName.Text = c.ContactName
            lblContactPhone.Text = c.ContactPhone
            lblContactEmail.Text = c.ContactEmail

            lblIEPre.Text = c.IEDaysPre
            lblIEPost.Text = c.IEDaysPost

            lblOEBegin.Text = c.OEBegin
            lblOEEnd.Text = c.OEEnd
            lblOEEffective.Text = c.OEEffective

            If Session("Group") = "Full Admin" Or Session("Group") = "BR Admin" Then
                btnEditAddress.Visible = True
                btnEditContact.Visible = True
                btnEditIE.Visible = True
                btnEditOE.Visible = True
            End If

        End If

    End Sub
    Public Function PrepareChartData(c As Company) As String
        ' Prepare the data for the chart
        Dim labels As New List(Of String) From {"Eligible", "NonEligible", "Benefits", "NoBenefits", "Medical", "Other"}
        Dim data As New List(Of Double) From {c.EligibleEmployees, c.NonEligibleEmployees, c.EmpsWithBenefits, c.EmpsWithoutBenefits, c.EmpsMedical, c.EmpsOther}

        ' Convert the data into JSON format
        Return "{ ""labels"": " & JsonConvert.SerializeObject(labels) & ", ""data"": " & JsonConvert.SerializeObject(data) & " }"
    End Function

    Public ReadOnly Property ChartData(c As Company) As String
        Get
            Return PrepareChartData(c)
        End Get
    End Property

    Public Function PrepareElectionChartData() As String
        ' Prepare the data for the chart
        Dim dsElections As New DataSet()
        c.GetElectionChartSummary(intCompanyId, Session("UserId"), dsElections)

        Dim dtElections As DataTable = dsElections.Tables(0)
        Dim labels As New List(Of String)
        Dim data As New List(Of Double)

        For Each row As DataRow In dtElections.Rows
            labels.Add(row("Legend").ToString())
            data.Add(Double.Parse(row("Elections").ToString()))
        Next

        ' Convert the data into JSON format
        Return "{ ""labels"": " & JsonConvert.SerializeObject(labels) & ", ""data"": " & JsonConvert.SerializeObject(data) & " }"
    End Function

    Public ReadOnly Property ElectionChartData As String
        Get
            Return PrepareElectionChartData()
        End Get
    End Property
    Private Sub CompanySummaryChart()
        c.GetCompanyChartSummary(intCompanyId, Session("UserId"))

        Dim intEligible As Integer
        Dim intIneligible As Integer
        Dim intBenefits As Integer
        Dim intNoBenefits As Integer
        Dim intMedical As Integer
        Dim intOther As Integer


        If c.TotalEmployees > 0 Then
            If c.EligibleEmployees > 0 Then
                intEligible = c.EligibleEmployees * 100 / c.TotalEmployees
            Else
                intEligible = 0
            End If

            intIneligible = 100 - intEligible
            If c.EmpsWithBenefits > 0 And c.EligibleEmployees > 0 Then
                intBenefits = c.EmpsWithBenefits * 100 / c.EligibleEmployees
            Else
                intBenefits = 0
            End If
            intNoBenefits = 100 - intBenefits

            If c.EmpsMedical > 0 Then
                intMedical = c.EmpsMedical * 100 / c.EmpsWithBenefits
            Else
                intMedical = 0
            End If

            intOther = 100 - intMedical

            Dim lblTotal As String = "TotalEmployees: " + c.TotalEmployees.ToString
            Dim lblEligible As String = "Eligible: " + c.EligibleEmployees.ToString + " (" + intEligible.ToString + "%)"
            Dim lblInEligible As String = "Ineligible: " + c.NonEligibleEmployees.ToString + " (" + intIneligible.ToString + "%)"
            Dim lblBenefits As String = "Benefits: " + c.EmpsWithBenefits.ToString + " (" + intBenefits.ToString + "%)"
            Dim lblNoBenefits As String = "No Benefits: " + c.EmpsWithoutBenefits.ToString + " (" + intNoBenefits.ToString + "%)"
            Dim lblMedical As String = "Medical: " + c.EmpsMedical.ToString + " (" + intMedical.ToString + "%)"
            Dim lblOther As String = "Other Benefits: " + c.EmpsOther.ToString + " (" + intOther.ToString + "%)"

            'Chart.Style = "margin:0 auto; width: 100%; height:100%;"

            Chart1.Series("TotalEmployees").YValuesPerPoint = 4
            Me.Chart1.Series("TotalEmployees").Points.AddY(0)
            Me.Chart1.Series("TotalEmployees").Points.AddY(0)
            Me.Chart1.Series("TotalEmployees").Points.AddY(0)
            Me.Chart1.Series("TotalEmployees").Points.AddY(c.TotalEmployees)
            Me.Chart1.Series("TotalEmployees").Label = lblTotal

            Chart1.Series("Eligible").YValuesPerPoint = 4
            Me.Chart1.Series("Eligible").Points.AddY(0)
            Me.Chart1.Series("Eligible").Points.AddY(0)
            Me.Chart1.Series("Eligible").Points.AddY(c.EligibleEmployees)
            Me.Chart1.Series("Eligible").Points.AddY(0)
            Me.Chart1.Series("Eligible").Label = lblEligible

            Chart1.Series("NonEligible").YValuesPerPoint = 4
            Me.Chart1.Series("NonEligible").Points.AddY(0)
            Me.Chart1.Series("NonEligible").Points.AddY(0)
            Me.Chart1.Series("NonEligible").Points.AddY(c.NonEligibleEmployees)
            Me.Chart1.Series("NonEligible").Points.AddY(0)
            Me.Chart1.Series("NonEligible").Label = lblInEligible

            Chart1.Series("Benefits").YValuesPerPoint = 4
            Me.Chart1.Series("Benefits").Points.AddY(0)
            Me.Chart1.Series("Benefits").Points.AddY(c.EmpsWithBenefits)
            Me.Chart1.Series("Benefits").Points.AddY(0)
            Me.Chart1.Series("Benefits").Points.AddY(0)
            Me.Chart1.Series("Benefits").Label = lblBenefits

            Chart1.Series("NoBenefits").YValuesPerPoint = 4
            Me.Chart1.Series("NoBenefits").Points.AddY(0)
            Me.Chart1.Series("NoBenefits").Points.AddY(c.EmpsWithoutBenefits)
            Me.Chart1.Series("NoBenefits").Points.AddY(0)
            Me.Chart1.Series("NoBenefits").Points.AddY(0)
            Me.Chart1.Series("NoBenefits").Label = lblNoBenefits

            Chart1.Series("Medical").YValuesPerPoint = 4
            Me.Chart1.Series("Medical").Points.AddY(c.EmpsMedical)
            Me.Chart1.Series("Medical").Points.AddY(0)
            Me.Chart1.Series("Medical").Points.AddY(0)
            Me.Chart1.Series("Medical").Points.AddY(0)
            Me.Chart1.Series("Medical").Label = lblMedical

            Chart1.Series("Other").YValuesPerPoint = 4
            Me.Chart1.Series("Other").Points.AddY(c.EmpsOther)
            Me.Chart1.Series("Other").Points.AddY(0)
            Me.Chart1.Series("Other").Points.AddY(0)
            Me.Chart1.Series("Other").Points.AddY(0)
            Me.Chart1.Series("Other").Label = lblOther

            Dim s As Series

            For Each s In Chart1.Series
                For Each p As DataPoint In s.Points
                    If p.YValues.Length > 0 Then
                        ' For x = 0 To 3
                        If p.YValues.GetValue(0) = 0 Then
                            p.Label = ""
                        Else
                            If s.Name = "Medical" Or s.Name = "TotalEmployees" Or s.Name = "Benefits" Or s.Name = "NonEligible" Then
                                p.LabelForeColor = Drawing.Color.White
                            Else
                                p.LabelForeColor = Drawing.Color.Black
                            End If
                        End If
                        ' Next
                    End If
                Next
            Next
        End If
    End Sub

    Private Sub ElectionSummaryChart()
        Dim dsElections As New DataSet()
        Dim dtElections As New DataTable()

        c.GetElectionChartSummary(intCompanyId, Session("UserId"), dsElections)

        dtElections = dsElections.Tables(0)

        Chart2.DataSource = dtElections
        Chart2.Series("Series1").XValueMember = "Legend"
        Chart2.Series("Series1").YValueMembers = "Elections"

        ' Position the chart area to take up 70% of the chart's width and 100% of its height
        Chart2.ChartAreas("ChartArea1").Position = New System.Web.UI.DataVisualization.Charting.ElementPosition(0, 0, 60, 100)
        ' Position the legend to take up the remaining 30% of the chart's width and 100% of its height
        Chart2.Legends("Legend1").Position = New System.Web.UI.DataVisualization.Charting.ElementPosition(60, 0, 40, 100)

        Chart2.DataBind()

        Dim Random As New Random()
        Dim colors As String() = {"DarkBlue", "LightGray", "LightSteelBlue", "Tan", "SlateGrey", "DarkSlateBlue", "CornflowerBlue", "WhiteSmoke", "Gray", "LightBlue", "DarkSalmon", "Lavender", "Navy", "PaleTurquoise", "CadetBlue", "Beige", "Silver", "Azure", "MediumPurple", "Honeydew", "SteelBlue", "AntiqueWhite", "RosyBrown", "Thistle"}
        Dim x As Integer
        x = 0
        For Each v In Chart2.Series("Series1").Points
            v.Color = Drawing.Color.FromName(colors(x))
            x = x + 1
        Next
    End Sub


    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlCompany.SelectedIndexChanged
        Session("ShadowCompanyId") = ddlCompany.SelectedValue
        intCompanyId = Session("ShadowCompanyId")

        PopulateCompanyInfo()
        PopulateDetailCompanyInfo()
        CompanySummaryChart()
        ElectionSummaryChart()
        GetScreenConfig()

    End Sub

    Protected Sub chkActive_CheckedChanged(sender As Object, e As EventArgs)
        Session("ActiveCompany") = IIf(chkActive.Checked = True, 1, 0)

        Session("ShadowCompanyId") = 0
        intCompanyId = 0

        PopulateCompanyInfo()
        GetScreenConfig()
        PopulateDetailCompanyInfo()
        CompanySummaryChart()
        ElectionSummaryChart()

    End Sub

#Region "Dashboard Reports"
    Protected Sub lstReports_ItemCommand(ByVal sender As Object, e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles lstReports.ItemCommand

        If TypeOf (e.CommandSource) Is System.Web.UI.WebControls.LinkButton Then
            Dim lnkbtn As LinkButton = CType(e.CommandSource, LinkButton)
            Dim ReportId As Int64 = lnkbtn.CommandArgument
            Dim ViewName As String
            Dim QryString As String
            Dim CompanyId As String = Session("ShadowCompanyId")
            Dim ReportName As String

            Dim dvReports As New DataView(Session("dsReports").Tables(0), "", "ReportId", DataViewRowState.CurrentRows)
            Dim rowindex As Integer = dvReports.Find(New Object() {ReportId})
            If rowindex <> -1 Then
                'Capture ViewName 
                ViewName = dvReports(rowindex)("ViewName").ToString()
                ReportName = dvReports(rowindex)("ShortDesc").ToString()

                'Build Query
                QryString = "Select *"
                QryString = QryString & " From " & ViewName
                If r.ReportRequiredCompany(ReportId) Then
                    'Add Company Id to Where clause
                    QryString = QryString & " Where CompanyId = " & CompanyId
                End If

                'run report to excel
                Dim sqlCon As New SQLControl
                Dim cmd As New SqlCommand(QryString & " Where CompanyId = " & CompanyId)
                Dim dt As DataTable = sqlCon.GetData(QryString & " Where CompanyId = " & CompanyId)

                'Create a dummy GridView 
                Dim GridView1 As New GridView()
                GridView1.AllowPaging = False
                GridView1.DataSource = dt
                GridView1.DataBind()

                If GridView1.Rows.Count > 0 Then
                    Dim strFileName As String
                    strFileName = ReportName & ".xls"
                    Response.Clear()
                    Response.Buffer = True
                    Response.AddHeader("content-disposition", "attachment;filename=" & strFileName)
                    Response.Charset = ""
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
                    Dim sw As New StringWriter()
                    Dim hw As New HtmlTextWriter(sw)

                    For i As Integer = 0 To GridView1.Rows.Count - 1
                        'Apply text style to each Row 
                        GridView1.Rows(i).Attributes.Add("class", "textmode")
                    Next
                    GridView1.RenderControl(hw)
                    'style to format numbers to string 
                    Dim style As String = "<style> .textmode{mso-number-format:     \@;}</style>"
                    Response.Write(style)
                    Response.Output.Write(sw.ToString())
                    Response.Flush()
                    Response.End()

                Else
                    'no records returned - show alert (damn error div idea did not work well!)
                    ScriptManager.RegisterClientScriptBlock(Me, GetType(Page), UniqueID, "javascript:alert('The report you requested does not return any data.\n\nCheck your criteria and try again');", True)
                End If

            End If

        End If

    End Sub

#End Region

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Response.Redirect("~/Admin_CompanyContact.aspx")

    End Sub

End Class
