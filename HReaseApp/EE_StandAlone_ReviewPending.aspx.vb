

Public Class EE_StandAlone_ReviewPending
    Inherits System.Web.UI.Page


    Dim sql As New SQLControl
    Dim sc As New ScreenConfiguration
    Dim EmpClass As New Employee
    Dim PlanClass As New Plans
    Dim SecClass As New Security
    Dim intTransactionId As Integer
    Dim intCompanyId As Integer
    Dim intEmpId As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lblEmployeeName.Text = "Review Pending Elections - " & Request.Params("EENAME")
        intCompanyId = Session("ShadowCompanyId")
        intEmpId = Session("ShadowEmployeeId")
        PopulateSummaryTable()
    End Sub


    Private Sub PopulateSummaryTable()
        'Procedure Dynamically builds table for Benefit summary  --I can't think of any other way to accomplish this :-{

        Dim TotalEECost As Decimal
        Dim TotalERCost As Decimal
        Dim booGotExistingElection As Boolean


        Session("dsExistingElection") = New DataSet
        booGotExistingElection = PlanClass.GetExistingPending(Request.Params("COMPID"), Request.Params("EEID"), Session("dsExistingElection"))
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

                tr.CssClass = "grdNormalAltrow"
                tc.Width = Unit.Percentage(100%)
                tc.HorizontalAlign = HorizontalAlign.Center
                tc.Text = "<br /><br />Employee has not selected any benefits<br /><br />"
                tr.Cells.Add(tc)
                tblSummary.Rows.Add(tr)

            Else  'Employee has Existing plans

                lblPayFrequency.Text = Session("dsExistingElection").Tables(0).Rows(0)("PayFrequencyText")
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
                tc.Text = "<strong>Effective Date</strong>"
                tr.Cells.Add(tc)

                tc = New TableCell
                tc.CssClass = "text-right"
                tc.Text = "<strong>Employee</strong>"
                tr.Cells.Add(tc)

                tc = New TableCell
                tc.CssClass = "text-right"
                tc.Text = "<strong>Employer</strong>"
                tr.Cells.Add(tc)

                tc = New TableCell
                tc.CssClass = "text-right"
                tc.Text = "<strong>Total</strong>"
                tr.Cells.Add(tc)


                tblSummary.Rows.Add(tr)
                PlanTypeDesc = "FirstRun"

                For x = 0 To dv.Count - 1
                    dr = dt.Rows(x)

                    If dr("PlanTypeDesc") <> PlanTypeDesc Then
                        If PlanTypeDesc <> "FirstRun" Then
                            tc = New TableCell
                            tr = New TableRow
                            tc.Text = "<br />"
                            tc.Width = Unit.Percentage(100%)
                            tc.ColumnSpan = 7
                            tr.Cells.Add(tc)
                            tblSummary.Rows.Add(tr)
                        End If

                        'Plan Type Description
                        WroteBeneficiary = False

                        tc = New TableCell
                        tr = New TableRow
                        tr.CssClass = IIf(dr("Pending") = "True", "grdPendingrow", IIf(dr("Pending") = "False", "grdNormalAltrow", "grdMissingrow"))
                        tc.ColumnSpan = 7
                        tc.Text = "<h4>" + dr("PlanTypeDesc") + "</h4>"
                        tr.Cells.Add(tc)
                        tblSummary.Rows.Add(tr)

                        ' Plan Description 
                        tr = New TableRow
                        tc = New TableCell
                        tr.CssClass = IIf(dr("Pending") = "True", "grdPendingrow", IIf(dr("Pending") = "False", "grdNormalAltrow", "grdMissingrow"))

                        If dr("Pending") = "None" Then
                            tc.ColumnSpan = 7
                            tc.Text = "A plan must be elected or waived for this plan type before your elections will be approved."
                            tr.Cells.Add(tc)
                        Else
                            tc.Text = dr("PlanDesc")
                            tr.Cells.Add(tc)
                            'Blank Column
                            tc = New TableCell
                            tc.Width = Unit.Percentage(10%)
                            tc.Text = "&nbsp;"
                            tr.Cells.Add(tc)
                            'Coverage Tier
                            tc = New TableCell
                            tc.HorizontalAlign = HorizontalAlign.Center
                            If Not dr("CoverageDesc") Is Nothing Then
                                tc.Text = dr("CoverageDesc")
                            End If
                            tr.Cells.Add(tc)

                            'Effective Date
                            tc = New TableCell
                            tc.HorizontalAlign = HorizontalAlign.Center
                            tc.Text = dr("CoverageBegin")
                            tr.Cells.Add(tc)

                            'EE Cost
                            tc = New TableCell
                            tc.CssClass = "text-right"
                            tc.Text = String.Format("{0:C2}", dr("EECost"))
                            tr.Cells.Add(tc)

                            'ER Rate
                            tc = New TableCell
                            tc.CssClass = "text-right"
                            tc.Text = String.Format("{0:C2}", dr("ERCost"))
                            tr.Cells.Add(tc)

                            'Sum EE ER Costs
                            tc = New TableCell
                            tc.CssClass = "text-right"
                            tc.Text = String.Format("{0:C2}", (CType(dr("EECost"), Decimal) + CType(dr("ERCost"), Decimal)))
                            tr.Cells.Add(tc)

                            'Add Covered Dependents
                            If dr("DepBenId") > 0 And dr("BeneficiaryType") = "Z" Then
                                tblSummary.Rows.Add(tr)
                                tr = New TableRow
                                tr.CssClass = IIf(dr("Pending") = "True", "grdPendingrow", IIf(dr("Pending") = "False", "grdNormalAltrow", "grdMissingrow"))
                                tc = New TableCell
                                tc.ColumnSpan = "7"
                                tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Covered Dependents</strong>"
                                tr.Cells.Add(tc)
                                tblSummary.Rows.Add(tr)

                                'Dep row
                                tr = New TableRow
                                tr.CssClass = IIf(dr("Pending") = "True", "grdPendingrow", IIf(dr("Pending") = "False", "grdNormalAltrow", "grdMissingrow"))
                                tc = New TableCell
                                tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & dr("DepBenName")

                                tr.Cells.Add(tc)
                                tc = New TableCell
                                tc.ColumnSpan = "6"
                                tc.Text = dr("DepBenBirthDate")
                                tr.Cells.Add(tc)

                            ElseIf dr("DepBenId") > 0 And dr("BeneficiaryType") <> "Z" Then
                                WroteBeneficiary = True
                                tblSummary.Rows.Add(tr)
                                tr = New TableRow
                                tr.CssClass = IIf(dr("Pending") = "True", "grdPendingrow", IIf(dr("Pending") = "False", "grdNormalAltrow", "grdMissingrow"))
                                tc = New TableCell
                                tc.ColumnSpan = "7"
                                tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Beneficiary Information</strong>"
                                tr.Cells.Add(tc)
                                tblSummary.Rows.Add(tr)

                                'Beneficary row
                                tr = New TableRow
                                tr.CssClass = IIf(dr("Pending") = "True", "grdPendingrow", IIf(dr("Pending") = "False", "grdNormalAltrow", "grdMissingrow"))
                                tc = New TableCell
                                tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & dr("DepBenName")

                                tr.Cells.Add(tc)
                                tc = New TableCell
                                tc.ColumnSpan = "6"

                                tc.Text = dr("BeneficiaryType")
                                tr.Cells.Add(tc)
                            End If
                        End If
                        PlanTypeDesc = dr("PlanTypeDesc")

                    Else
                        If dr("DepBenId") > 0 And dr("BeneficiaryType") = "Z" Then
                            tblSummary.Rows.Add(tr)
                            tr = New TableRow
                            tr.CssClass = IIf(dr("Pending") = "True", "grdPendingrow", IIf(dr("Pending") = "False", "grdNormalAltrow", "grdMissingrow"))
                            tc = New TableCell
                            tc.Text = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & dr("DepBenName")
                            tr.Cells.Add(tc)
                            tc = New TableCell
                            tc.ColumnSpan = "6"
                            tc.Text = dr("DepBenBirthDate")
                            tr.Cells.Add(tc)

                        ElseIf dr("DepBenId") > 0 And dr("BeneficiaryType") <> "Z" Then
                            If WroteBeneficiary = False Then
                                tblSummary.Rows.Add(tr)
                                tr = New TableRow
                                tr.CssClass = IIf(dr("Pending") = "True", "grdPendingrow", IIf(dr("Pending") = "False", "grdNormalAltrow", "grdMissingrow"))
                                tc = New TableCell
                                tc.ColumnSpan = "7"
                                tc.Text = "<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Beneficiary Information</strong>"
                                tr.Cells.Add(tc)

                                WroteBeneficiary = True
                            End If
                            tblSummary.Rows.Add(tr)
                            tr = New TableRow
                            tr.CssClass = IIf(dr("Pending") = "True", "grdPendingrow", IIf(dr("Pending") = "False", "grdNormalAltrow", "grdMissingrow"))
                            tc = New TableCell
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
                tc.ColumnSpan = "4"
                tc.CssClass = "text-right"
                tc.Text = "<strong>Benefit Coverage Totals</strong>"
                tr.Cells.Add(tc)

                'Total EE Cost
                tc = New TableCell
                tc.CssClass = "text-right"
                tc.Text = "<strong>" + String.Format("{0:C2}", TotalEECost) + "</strong"
                tr.Cells.Add(tc)

                'Total ER Cost
                tc = New TableCell
                tc.CssClass = "text-right"
                tc.Text = "<strong>" + String.Format("{0:C2}", TotalERCost) + "</strong"
                tr.Cells.Add(tc)

                'Total Cost
                tc = New TableCell

                tc.CssClass = "text-right"
                tc.Text = "<strong>" + String.Format("{0:C2}", TotalEECost + TotalERCost) + "</strong"
                tr.Cells.Add(tc)
                tblSummary.Rows.Add(tr)
            End If
        End If

    End Sub

    Protected Sub imgClose_Click(sender As Object, e As ImageClickEventArgs)
        Response.Write("<script language='javascript'> { window.close();}</script>")

    End Sub
End Class
