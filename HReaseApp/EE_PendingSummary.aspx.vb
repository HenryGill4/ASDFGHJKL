Public Class EE_PendingSummary
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee
    Dim p As New Plans

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
        strScreenName = "BenefitSummaryPending"
        strScreenShortDesc = "Benefit Summary"

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

            If lblMainArticleText.Text = "" Then
                divText.Visible = False
            End If
            If lblMainArticleTitle.Text = "" Then
                divTitle.Visible = False
            End If

            Dim booGotEmployee As Boolean
            booGotEmployee = ec.GetEmployeeInfo(intCompanyId, intEmployeeId)
            If booGotEmployee = True Then
                lblFullEmployeeName.Text = ec.FullName
                lblAddress.Text = ec.Address1 + IIf(Len(ec.Address2) > 0, "<br>" + ec.Address2, "")
                lblCity.Text = ec.City + ", "
                lblState.Text = ec.State
                lblZip.Text = ec.Zip
            End If

            If Session("Admin") = True Then
                'Employee Notes grid - MODAL
                ec.FillEmployeeNotes(Session("ShadowEmployeeId"), grdEmployeeNotes)
                mlblInfoTitle.Text = "Employee Notes for " + Session("ShadowEmployeeName")

            End If

        End If

        PopulateSummaryTable()

        btnPrint.Attributes.Add("Onclick", "divPrint();")
        'btnPrint.Attributes.Add("Onclick", "PrintWindow('divSummary');")
        btnPrintHistory.Attributes.Add("Onclick", "PrintWindow('ModalBenefitSummary');")

        PopulateHistoryTable()

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub
    Private Sub PopulateSummaryTable()
        tblSummary.Rows.Clear()

        Dim TotalEECost As Decimal
        Dim TotalERCost As Decimal
        Dim booGotExistingElection As Boolean

        Session("dsExistingElection") = New DataSet
        If txtSearchDate.Text = "" Then
            booGotExistingElection = p.GetExistingPending(intCompanyId, intEmployeeId, "", Session("dsExistingElection"))
        Else
            booGotExistingElection = p.GetExistingPending(intCompanyId, intEmployeeId, txtSearchDate.Text, Session("dsExistingElection"))
        End If

        If booGotExistingElection = True Then

            Dim dt As DataTable
            Dim dr As DataRow
            Dim dv As DataView
            Dim tc As New TableCell()
            Dim tr As New TableRow()
            Dim t As New Table()
            Dim x As Int32
            Dim PlanTypeDesc As String
            Dim WroteBeneficiary As Boolean

            dt = Session("dsExistingElection").tables(0)
            dv = New DataView(dt)

            'Check to see if Employee has coverages
            If dv.Count = 0 Then  'none
                tc = New TableCell
                tr = New TableRow()

                tr.CssClass = "grdNormalrow"
                tc.Width = Unit.Percentage(100%)
                tc.HorizontalAlign = HorizontalAlign.Center
                tc.Text = "<br /><br />Employee has not selected any benefits<br /><br />"
                tr.Cells.Add(tc)
                tblSummary.Rows.Add(tr)

            Else  'Employee has Existing plans

                lblPayFrequency.Text = Session("dsExistingElection").Tables(0).Rows(0)("PayFrequencyText")
                tblSummary.CellPadding = 3
                'tblSummary.BorderColor = Drawing.Color.Navy

                'Header Row
                tr = New TableRow
                tr.CssClass = "grdHeaderrow"

                tc = New TableCell
                tc.ColumnSpan = "3"
                tc.Text = "<strong>Plan Description</strong>"
                tr.Cells.Add(tc)

                tc = New TableCell
                tc.ColumnSpan = "1"
                tc.Text = "<strong>Details</strong>"
                tr.Cells.Add(tc)

                tc = New TableCell
                tc.ColumnSpan = "1"
                tc.CssClass = "text-center"
                tc.Text = "<strong>Coverage</strong>"
                tr.Cells.Add(tc)

                tc = New TableCell
                tc.ColumnSpan = "1"
                tc.Text = "<strong>Begin Date</strong>"
                tr.Cells.Add(tc)

                tc = New TableCell
                tc.ColumnSpan = "1"
                tc.Text = "<strong>End Date</strong>"
                tr.Cells.Add(tc)

                tc = New TableCell
                tc.ColumnSpan = "1"
                tc.CssClass = "text-right"
                tc.Text = "<strong>Employee</strong>"
                tr.Cells.Add(tc)

                If Session("ShowERRates") = True Then
                    tc = New TableCell
                    tc.ColumnSpan = "1"
                    tc.CssClass = "text-right"
                    tc.Text = "<strong>Employer</strong>"
                    tr.Cells.Add(tc)

                    tc = New TableCell
                    tc.ColumnSpan = "1"
                    tc.CssClass = "text-right HRERightBorder"
                    tc.Text = "<strong>Total&nbsp;&nbsp;</strong>"
                    tr.Cells.Add(tc)
                Else
                    tc = New TableCell
                    tc.ColumnSpan = "2"
                    tc.CssClass = "HRERightBorder"
                    tc.Text = ""
                    tr.Cells.Add(tc)
                End If

                tblSummary.Rows.Add(tr)
                PlanTypeDesc = "FirstRow"

                For x = 0 To dv.Count - 1
                    dr = dt.Rows(x)

                    If dr("PlanTypeDesc") <> PlanTypeDesc Then
                        If InStr(dr("PlanTypeDesc"), "Prior") = 0 And PlanTypeDesc <> "FirstRow" Then
                            tc = New TableCell
                            tr = New TableRow
                            'tc.Text = "<br />"
                            tc.Width = Unit.Percentage(100%)
                            tc.ColumnSpan = "10"
                            'tc.CssClass = "topborder"
                            tr.Cells.Add(tc)
                            'tr.CssClass = "topborder"
                            tblSummary.Rows.Add(tr)
                        End If

                        'Plan Type Description
                        WroteBeneficiary = False

                        tr = New TableRow
                        tr.CssClass = IIf(dr("Pending") = "True", "HREPending", IIf(dr("Pending") = "Existing", "HREExisting", "HRENone"))

                        'Plan Type Desc
                        tc = New TableCell
                        tc.ColumnSpan = "10"
                        tc.Text = IIf(InStr(dr("PlanTypeDesc"), "Prior") > 0, "", "<strong>" + dr("PlanTypeDesc") + "</strong>")
                        tc.CssClass = IIf(InStr(dr("PlanTypeDesc"), "Prior") > 0, "", " HRETopBorder")
                        tr.Cells.Add(tc)

                        tblSummary.Rows.Add(tr)

                        tr = New TableRow
                        tr.CssClass = IIf(dr("Pending") = "True", "HREPending", IIf(dr("Pending") = "Existing", "HREExisting", "HRENone"))

                        'Plan Description 
                        tc = New TableCell
                        tc.ColumnSpan = "4"
                        tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;" + dr("PlanDesc")
                        tr.Cells.Add(tc)

                        'Coverage Tier
                        tc = New TableCell
                        tc.ColumnSpan = "1"
                        tc.CssClass = "text-center"
                        If Not dr("CoverageDesc") Is Nothing Then
                            tc.Text = dr("CoverageDesc")
                        End If
                        tr.Cells.Add(tc)

                        'Begin Date
                        tc = New TableCell
                        tc.ColumnSpan = "1"
                        tc.HorizontalAlign = HorizontalAlign.Center
                        tc.Text = dr("CoverageBegin")
                        tr.Cells.Add(tc)

                        'End Date
                        tc = New TableCell
                        tc.ColumnSpan = "1"
                        tc.HorizontalAlign = HorizontalAlign.Center
                        tc.Text = IIf(dr("CoverageEnd") = "12/31/2999", "", dr("CoverageEnd"))
                        tr.Cells.Add(tc)

                        'EE Cost
                        tc = New TableCell
                        tc.ColumnSpan = "1"
                        tc.CssClass = "text-right"
                        tc.Text = String.Format("{0:C2}", dr("EECost"))
                        tr.Cells.Add(tc)

                        If Session("ShowERRates") = True Then
                            'ER Cost
                            tc = New TableCell
                            tc.ColumnSpan = "1"
                            tc.CssClass = "text-right"
                            tc.Text = String.Format("{0:C2}", dr("ERCost"))
                            tr.Cells.Add(tc)

                            'Total Cost
                            tc = New TableCell
                            tc.ColumnSpan = "1"
                            tc.CssClass = "text-right"
                            tc.Text = String.Format("{0:C2}", (CType(dr("EECost"), Decimal) + CType(dr("ERCost"), Decimal))) + "&nbsp;"
                            tr.Cells.Add(tc)
                        Else
                            'Empty Column to pad
                            tc = New TableCell
                            tc.ColumnSpan = "2"
                            tc.CssClass = "HRERightBorder"
                            tc.Text = "&nbsp;"
                            tr.Cells.Add(tc)
                        End If

                        'Add Covered Dependents
                        If dr("DepBenId") > 0 And dr("BeneficiaryType") = "" Then
                            tblSummary.Rows.Add(tr)
                            tr = New TableRow
                            tr.CssClass = IIf(dr("Pending") = "True", "HREPending", IIf(dr("Pending") = "Existing", "HREExisting", "HRENone"))
                            tc = New TableCell
                            tc.ColumnSpan = "10"
                            tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Covered Dependents</strong>"
                            tr.Cells.Add(tc)
                            tblSummary.Rows.Add(tr)

                            'Dep row
                            tr = New TableRow
                            tr.CssClass = IIf(dr("Pending") = "True", "HREPending", IIf(dr("Pending") = "Existing", "HREExisting", "HRENone"))
                            tc = New TableCell
                            tc.ColumnSpan = "4"
                            tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & dr("DepBenName")
                            tr.Cells.Add(tc)

                            tc = New TableCell
                            tc.ColumnSpan = "6"
                            tc.Text = dr("DepBenBirthDate")
                            tr.Cells.Add(tc)

                        ElseIf dr("DepBenId") > 0 And dr("BeneficiaryType") <> "" Then
                            WroteBeneficiary = True
                            tblSummary.Rows.Add(tr)
                            tr = New TableRow
                            tr.CssClass = IIf(dr("Pending") = "True", "HREPending", IIf(dr("Pending") = "Existing", "HREExisting", "HRENone"))
                            tc = New TableCell
                            tc.ColumnSpan = "10"
                            tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Beneficiary Information</strong>"
                            tr.Cells.Add(tc)
                            tblSummary.Rows.Add(tr)

                            'Beneficary row
                            tr = New TableRow
                            tr.CssClass = IIf(dr("Pending") = "True", "HREPending", IIf(dr("Pending") = "Existing", "HREExisting", "HRENone"))
                            tc = New TableCell
                            tc.ColumnSpan = "4"
                            tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & dr("DepBenName")
                            tr.Cells.Add(tc)

                            tc = New TableCell
                            tc.ColumnSpan = "6"
                            tc.Text = dr("BeneficiaryType")
                            tr.Cells.Add(tc)
                        End If
                        PlanTypeDesc = dr("PlanTypeDesc")

                    Else
                        If dr("DepBenId") > 0 And dr("BeneficiaryType") = "" Then
                            tblSummary.Rows.Add(tr)
                            tr = New TableRow
                            tr.CssClass = IIf(dr("Pending") = "True", "HREPending", IIf(dr("Pending") = "Existing", "HREExisting", "HRENone"))
                            tc = New TableCell
                            tc.ColumnSpan = "4"
                            tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & dr("DepBenName")
                            tr.Cells.Add(tc)
                            tc = New TableCell
                            tc.ColumnSpan = "6"
                            tc.Text = dr("DepBenBirthDate")
                            tr.Cells.Add(tc)

                        ElseIf dr("DepBenId") > 0 And dr("BeneficiaryType") <> "" Then
                            If WroteBeneficiary = False Then
                                tblSummary.Rows.Add(tr)
                                tr = New TableRow
                                tr.CssClass = IIf(dr("Pending") = "True", "HREPending", IIf(dr("Pending") = "Existing", "HREExisting", "HRENone"))
                                tc = New TableCell
                                tc.ColumnSpan = "10"
                                tc.Text = "<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Beneficiary Information</strong>"
                                tr.Cells.Add(tc)

                                WroteBeneficiary = True
                            End If

                            tblSummary.Rows.Add(tr)
                            tr = New TableRow
                            tr.CssClass = IIf(dr("Pending") = "True", "HREPending", IIf(dr("Pending") = "Existing", "HREExisting", "HRENone"))
                            tc = New TableCell
                            tc.ColumnSpan = "4"
                            tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & dr("DepBenName")
                            tr.Cells.Add(tc)

                            tc = New TableCell
                            tc.ColumnSpan = "6"
                            tc.Text = dr("BeneficiaryType")
                            tr.Cells.Add(tc)
                        End If

                    End If
                    tblSummary.Rows.Add(tr)
                    TotalEECost = dr("TotalEECost")
                    TotalERCost = dr("TotalERCost")
                Next

                'Footer row
                tc = New TableCell
                tr = New TableRow
                tr.CssClass = "grdHeaderrow"
                tc.ColumnSpan = "7"
                tc.CssClass = "text-right"
                tc.Text = "<strong>Total</strong>"
                tr.Cells.Add(tc)

                'Total EE Cost
                tc = New TableCell
                tc.ColumnSpan = "1"
                tc.CssClass = "text-right"
                tc.Text = "<strong>" + String.Format("{0:C2}", TotalEECost) + "</strong>"
                tr.Cells.Add(tc)

                If Session("ShowERRates") = True Then
                    'Total ER Cost
                    tc = New TableCell
                    tc.ColumnSpan = "1"
                    tc.CssClass = "text-right"
                    tc.Text = "<strong>" + String.Format("{0:C2}", TotalERCost) + "</strong>"
                    tr.Cells.Add(tc)

                    'Total Cost
                    tc = New TableCell
                    tc.ColumnSpan = "1"
                    tc.CssClass = "text-right"
                    tc.Text = "<strong>" + String.Format("{0:C2}", TotalEECost + TotalERCost) + "</strong>" + "&nbsp;"
                    tr.Cells.Add(tc)
                Else
                    'Empty column
                    tc = New TableCell
                    tc.ColumnSpan = "2"
                    tc.Text = "&nbsp;"
                    tr.Cells.Add(tc)
                End If

                tblSummary.Rows.Add(tr)
            End If
        End If

    End Sub

    'Protected Sub btnSearch_Click(sender As Object, e As ImageClickEventArgs) Handles btnSearch.Click
    '    Session.Remove("dsExistingElection")
    '    PopulateSummaryTable()

    'End Sub

#Region "Benefit Summary Modal"
    Private Sub PopulateHistoryTable()
        tblHistory.Rows.Clear()

        Dim booGotSummary As Boolean

        Session("dsElectionSummary") = New DataSet
        booGotSummary = p.GetBenefitSummary(intCompanyId, intEmployeeId, Now.Date, Session("dsElectionSummary"))

        If booGotSummary = True Then

            Dim dt As DataTable
            Dim dr As DataRow
            Dim dv As DataView
            Dim tc As New TableCell()
            Dim tr As New TableRow()
            Dim t As New Table()
            Dim x As Int32
            Dim PlanTypeDesc As String
            Dim PlanDesc As String
            Dim EmployeeElectionId As Integer
            Dim WroteBeneficiary As Boolean

            dt = Session("dsElectionSummary").tables(0)
            dv = New DataView(dt)

            If dv.Count = 0 Then
                'Display a message stating that Employee does not have any benefits on record
                tc = New TableCell()
                tr = New TableRow()

                tr.CssClass = "grdLightBluerow"
                tc.Width = Unit.Percentage(100%)
                tc.HorizontalAlign = HorizontalAlign.Center
                tc.Text = "<br /><br />Benefit History is not available<br /><br />"
                tr.Cells.Add(tc)
                tblHistory.Rows.Add(tr)

            Else  'Employee has Benefit History
                lblPayFrequencyModal.Text = Session("dsElectionSummary").Tables(0).Rows(0)("PayFrequencyText")
                'Header Row
                tc = New TableCell
                tr = New TableRow
                tr.CssClass = "grdHeaderrow"

                tc.ColumnSpan = "2"
                tc.Text = "<strong>Plan Description</strong>"
                tr.Cells.Add(tc)

                tc = New TableCell
                tc.Text = "<strong>Coverage</strong>"
                tr.Cells.Add(tc)

                tc = New TableCell
                tc.Text = "<strong>Begin Date</strong>"
                tr.Cells.Add(tc)

                tr.Cells.Add(tc)
                tc = New TableCell
                tc.Text = "<strong>End Date</strong>"
                tr.Cells.Add(tc)

                tc = New TableCell
                tc.Text = "<strong>EE Cost </strong>"
                tr.Cells.Add(tc)

                If Session("ShowERRates") = True Then
                    tc = New TableCell
                    tc.Text = "<strong>ER Cost</strong>"
                    tr.Cells.Add(tc)
                Else
                    tc = New TableCell
                    tc.Text = ""
                    tr.Cells.Add(tc)
                End If

                tc = New TableCell
                tc.Text = "<strong>Event</strong>"
                tr.Cells.Add(tc)

                tc = New TableCell
                tc.Text = "<strong>Created by</strong>"
                tr.Cells.Add(tc)

                tc = New TableCell
                tc.Text = "<strong>Create Date</strong>"
                tr.Cells.Add(tc)

                tc = New TableCell
                tc.Text = "<strong>Changed by</strong>"
                tr.Cells.Add(tc)

                tc = New TableCell
                tc.Text = "<strong>Change Date</strong>"
                tr.Cells.Add(tc)

                tblHistory.Rows.Add(tr)
                PlanTypeDesc = "HeaderRow"
                PlanDesc = "HeaderRow"
                EmployeeElectionId = 0

                For x = 0 To dv.Count - 1
                    dr = dt.Rows(x)

                    If dr("PlanTypeDesc") <> PlanTypeDesc Then
                        If PlanTypeDesc <> "HeaderRow" Then
                            tc = New TableCell
                            tr = New TableRow
                            tc.Text = "<br />"
                            tc.ColumnSpan = "12"
                            tr.Cells.Add(tc)
                            tblHistory.Rows.Add(tr)
                            PlanDesc = "HeaderRow"
                        End If

                        'Plan Type Description
                        tc = New TableCell
                        tr = New TableRow
                        tr.CssClass = "grdLightBluerow"
                        tc.ColumnSpan = "12"
                        tc.Text = "<strong>" + dr("PlanTypeDesc") + "</strong>"
                        tr.Cells.Add(tc)
                        tblHistory.Rows.Add(tr)

                    End If  'same plan type

                    ' Benefit Plan Description 
                    tr = New TableRow
                    tc = New TableCell
                    tr.CssClass = "grdLightBluerow"

                    If EmployeeElectionId <> dr("EmployeeElectionId") Then
                        If PlanDesc <> "HeaderRow" Then
                            tc = New TableCell
                            tr = New TableRow
                            tc.Text = "<br />"
                            tc.ColumnSpan = "12"
                            tr.CssClass = "grdLightBluerow"
                            tr.Cells.Add(tc)
                            tblHistory.Rows.Add(tr)
                        End If

                        WroteBeneficiary = False

                        tc = New TableCell
                        tr = New TableRow
                        tr.CssClass = "grdLightBluerow"
                        tc.Text = dr("PlanDesc")
                        tr.Cells.Add(tc)

                        'Blank Column
                        tc = New TableCell
                        tc.Text = "&nbsp;"
                        tr.Cells.Add(tc)

                        'Coverage Tier
                        tc = New TableCell
                        tc.HorizontalAlign = HorizontalAlign.Center
                        tc.Text = dr("CoverageDesc")
                        tr.Cells.Add(tc)

                        'Effective Date
                        tc = New TableCell
                        tc.HorizontalAlign = HorizontalAlign.Center
                        tc.Text = dr("CoverageBegin")
                        tr.Cells.Add(tc)

                        'End Date
                        tc = New TableCell
                        tc.HorizontalAlign = HorizontalAlign.Center
                        tc.Text = IIf(dr("CoverageEnd") = "12/31/2999", "", dr("CoverageEnd"))
                        tr.Cells.Add(tc)

                        'EECost
                        tc = New TableCell
                        tc.HorizontalAlign = HorizontalAlign.Center
                        tc.Text = dr("EECost")
                        tr.Cells.Add(tc)

                        If Session("ShowERRates") = True Then
                            'ERCost
                            tc = New TableCell
                            tc.HorizontalAlign = HorizontalAlign.Center
                            tc.Text = dr("ERCost")
                            tr.Cells.Add(tc)
                        Else
                            'ERCost
                            tc = New TableCell
                            tc.Text = ""
                            tr.Cells.Add(tc)
                        End If

                        'Event
                        tc = New TableCell
                        tc.HorizontalAlign = HorizontalAlign.Right
                        tc.Text = dr("EventType")
                        tr.Cells.Add(tc)

                        'Enroller
                        tc = New TableCell
                        tc.HorizontalAlign = HorizontalAlign.Center
                        tc.Text = dr("EnrollerName")
                        tr.Cells.Add(tc)

                        'Create Date
                        tc = New TableCell
                        tc.HorizontalAlign = HorizontalAlign.Center
                        tc.Text = dr("ElectDate")
                        tr.Cells.Add(tc)

                        'Changer
                        tc = New TableCell
                        tc.HorizontalAlign = HorizontalAlign.Center
                        tc.Text = dr("ChangerName")
                        tr.Cells.Add(tc)

                        'Change Date
                        tc = New TableCell
                        tc.HorizontalAlign = HorizontalAlign.Center
                        tc.Text = dr("ChangeDate")
                        tr.Cells.Add(tc)

                        'Add Deps
                        If dr("DepBenId") > 0 And dr("BeneficiaryType") = "Z" Then
                            tblHistory.Rows.Add(tr)
                            tr = New TableRow
                            tr.CssClass = "grdLightBluerow"
                            tc = New TableCell
                            tc.ColumnSpan = "12"
                            tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Covered Dependents</strong>"
                            tr.Cells.Add(tc)
                            tblHistory.Rows.Add(tr)

                            tr = New TableRow
                            tr.CssClass = "grdLightBluerow"
                            tc = New TableCell
                            tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & dr("DepBenName")
                            tr.Cells.Add(tc)

                            tc = New TableCell
                            tc.ColumnSpan = "11"
                            tc.Text = dr("DepBenBirthDate")
                            tr.Cells.Add(tc)

                        ElseIf dr("DepBenId") > 0 And dr("BeneficiaryType") <> "Z" Then
                            WroteBeneficiary = True
                            tblHistory.Rows.Add(tr)
                            tr = New TableRow
                            tr.CssClass = "grdLightBluerow"
                            tc = New TableCell
                            tc.ColumnSpan = "12"
                            tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Beneficiary Information</strong>"
                            tr.Cells.Add(tc)
                            tblHistory.Rows.Add(tr)

                            'Beneficary row
                            tr = New TableRow
                            tr.CssClass = "grdLightBluerow"
                            tc = New TableCell
                            tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & dr("DepBenName")

                            tr.Cells.Add(tc)
                            tc = New TableCell
                            tc.ColumnSpan = "11"

                            tc.Text = dr("BeneficiaryType")
                            tr.Cells.Add(tc)
                        End If

                        PlanTypeDesc = dr("PlanTypeDesc")
                        PlanDesc = dr("PlanDesc")


                    Else  'add additional deps
                            If dr("DepBenId") > 0 And dr("BeneficiaryType") = "Z" Then
                                tblHistory.Rows.Add(tr)
                                tr = New TableRow
                                tr.CssClass = "grdLightBluerow"
                                tc = New TableCell
                                tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & dr("DepBenName")
                                tr.Cells.Add(tc)

                                tc = New TableCell
                                tc.ColumnSpan = "11"
                                tc.Text = dr("DepBenBirthDate")
                                tr.Cells.Add(tc)

                            ElseIf dr("DepBenId") > 0 And dr("BeneficiaryType") <> "Z" Then
                                If WroteBeneficiary = False Then
                                    tblHistory.Rows.Add(tr)
                                    tr = New TableRow
                                    tr.CssClass = "grdLightBluerow"
                                    tc = New TableCell
                                    tc.ColumnSpan = "12"
                                    tc.Text = "<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Beneficiary Information</strong>"
                                    tr.Cells.Add(tc)

                                    WroteBeneficiary = True
                                End If
                                tblHistory.Rows.Add(tr)
                                tr = New TableRow
                                tr.CssClass = "grdLightBluerow"
                                tc = New TableCell
                                tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & dr("DepBenName")
                                tr.Cells.Add(tc)
                                tc = New TableCell
                                tc.ColumnSpan = "11"
                                tc.Text = dr("BeneficiaryType")
                                tr.Cells.Add(tc)
                            End If

                        End If
                        tblHistory.Rows.Add(tr)
                        EmployeeElectionId = dr("EmployeeElectionId")
                    Next

                    'Footer
                    tc = New TableCell
                    tr = New TableRow
                    tr.CssClass = "grdHeaderrow"
                    tc.Text = "&nbsp;"
                    tc.ColumnSpan = "12"
                    tr.Cells.Add(tc)

                    tblHistory.Rows.Add(tr)
                End If
            End If

    End Sub
#End Region

#Region "Employee Notes Module"
    Protected Sub a_grdEmployee_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdEmployeeNotes.RowDataBound
        If e.Row.RowType = System.Web.UI.WebControls.DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#EFF3FB'")  'old color   8bcced
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=''")
            e.Row.Attributes.Add("style", "cursor:pointer;")
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
        mlblHiddenNoteId.Text = EmployeeNoteId
        mtxtNewComment.Text = strCurrentNote
        mtxtNewComment.Visible = True
        mbtnAdd.Visible = False
        mbtnSave.Visible = True
    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)

        Response.Redirect(Session("NextScreen"))

    End Sub

    Protected Sub txtSearchDate_TextChanged(sender As Object, e As EventArgs)
        Session.Remove("dsExistingElection")
        PopulateSummaryTable()
    End Sub

#End Region
End Class
