Imports System.Web.UI.DataVisualization.Charting
Imports System.Data.SqlClient

Partial Class EE_Welcome
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee
    Dim d As New Dependent
    Dim p As New Plans
    Dim s As New Security

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer
    Dim strElections As String

    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EEWelcome"
        strScreenShortDesc = "Employee Welcome"

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
                Session("ShowERRates") = sc.ShowERRates
            End If

            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), Session("ScreenPath"))
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            sc.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))

            If sc.MainArticleTitle = "" Then
                lblMainArticleTitle.Visible = False
            End If

            If sc.MainArticleText = "" Then
                lblMainArticleText.Visible = False
            End If

            If sc.MainArticleTitle = "" And sc.MainArticleText = "" Then
                divMainArticalTitleandText.Visible = False
            End If

            lblMainArticleTitle.Text = sc.MainArticleTitle
            lblMainArticleText.Text = sc.MainArticleText

            '''''  Hide Benefits Related Info if EE is not Eligible (yet) '''''''
            If ec.GetEmployeeEventInfo(intEmployeeId, Session("UserId"), 0, intCompanyId) = True Then
                Dim strIEEffectiveDate As String
                strIEEffectiveDate = ec.IEEffectiveDate
                Dim MyIEEffDateString As String = strIEEffectiveDate
                Dim MyIEEffDateTime As DateTime = DateTime.Parse(MyIEEffDateString)
                Console.WriteLine(MyIEEffDateTime)

                If ec.IsEligible = False Then
                    divLearn.Visible = False
                    divEnroll.Visible = False
                    divBenefitSummary.Visible = False
                Else
                    If ec.InIE = False And MyIEEffDateTime > Now Then
                        divEnroll.Visible = False
                        lblMainArticleText.Text = lblMainArticleText.Text &
                                        "<br/> <br/>
                                        <center>You are eligible for benefits effective <b>" & ec.IEEffectiveDate &
                                        "</b> However, your enrollment window does not begin until <span style=color:red;><b>" & ec.IEBeginDate & "</b></span>.  
                                         <br/> <br/>
                                         Please return to the website after that date to complete your benefits enrollment.</center>
                                         <br/> <br/>"
                    Else
                        divBenefitSummary.Visible = True
                        divLearn.Visible = True
                        divEnroll.Visible = True
                    End If

                    strElections = p.HasElections(intCompanyId, intEmployeeId)
                    p.PopulatePendingBenefitSummary(intCompanyId, intEmployeeId, grdSummary)
                    CreatePieChartPending()

                End If

                If ec.InOnboarding = True Then
                    divOnboardingInfo.Visible = True
                    divProgressList.Visible = True
                    GetEmployeeOnboarding()

                Else
                    divOnboardingInfo.Visible = False
                End If

            End If

            If btnEditProfile IsNot Nothing Then   'on plan pages this section should not be shown, so a simple test of the first button should let us know
                If Page.IsPostBack = False Then
                    Dim booGotEmployee As Boolean
                    '  If Session("Admin") = False Then
                    booGotEmployee = ec.GetEmployeeInfo(intCompanyId, intEmployeeId)
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
                        grdDependents.DataSource = d.GetDependentList(intCompanyId, intEmployeeId, 1)
                        grdDependents.DataBind()
                    End If
                End If
            End If
        End If

        If divLearn.Visible = False And divEnroll.Visible = False And divBenefitSummary.Visible = False And divOnboardingInfo.Visible = False Then
            lblMainArticleText.Visible = True
            lblMainArticleText.Text = "There are no outstanding tasks at this time."
        End If

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub GetEmployeeOnboarding()

        'progress bar
        Dim PercentageComplete As Integer
        Dim widthset As String

        PercentageComplete = ec.EEPercentComplete
        widthset = PercentageComplete.ToString + "%"
        divProgressBar.Attributes.Add("aria-valuenow", PercentageComplete.ToString)
        divProgressBar.Style.Add("width", widthset)
        lblProgress.Text = PercentageComplete.ToString + "%"

        ec.getEmployeeOnboardingProgress(intEmployeeId, strScreenName, grdOnboardingProgress)

    End Sub

    Protected Sub CreatePieChartPending()
        ''''''''''''''''''''''  
        'PieChart
        ''''''''''''''''''''''  
        Dim PieData = New DataSet
        p.PopulatePiePendingBenefits(intCompanyId, intEmployeeId, PieData)
        Dim dt As DataTable
        Dim dr As DataRow
        Dim dv As DataView
        Dim i As Int32
        dt = PieData.Tables(0)
        dv = New DataView(dt)

        For i = 0 To dv.Count - 1
            dr = dt.Rows(i)
            Dim dp As New DataPoint(0, dr("PiePercent").ToString())

            dp.ToolTip = dr("PlanTypeDesc")
            dp.Label = dr("PlanTypeCode") + " - " + dr("PiePercent").ToString() + "%"

            pieChart.Series("chartSeries").Points.Add(dp)
        Next

        pieChart.Series("chartSeries")("PointWidth") = "0.1"
        pieChart.Series("chartSeries")("DrawingStyle") = "Cylinder"
        pieChart.Series("chartSeries")("PieLabelStyle") = "Disabled"

    End Sub

    Protected Sub btnEnroll_Click(sender As Object, e As EventArgs) Handles btnEnroll.Click

        Response.Redirect("~/EE_Event.aspx")

    End Sub

    Protected Sub grdSummary_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdSummary.RowDataBound

        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim keys As DataKey = grdSummary.DataKeys(e.Row.RowIndex)
            Dim Pending As Object = keys("Pending")
            If Pending = "True" Then
                e.Row.ForeColor = System.Drawing.Color.Red
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff")
            ElseIf Pending = "None" Then
                e.Row.ForeColor = System.Drawing.Color.Silver
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFF")
            Else
                e.Row.ForeColor = System.Drawing.Color.Navy
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f0")
            End If
            If Session("ShowERRates") = 0 Then
                grdSummary.Columns(2).Visible = False
                grdSummary.HeaderRow.Cells(2).Visible = False
                grdSummary.Columns(3).Visible = False
                grdSummary.HeaderRow.Cells(3).Visible = False
            End If
        End If
    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)

        Response.AddHeader("REFRESH", "0;URL=" + Session("NextScreen"))

    End Sub
End Class

