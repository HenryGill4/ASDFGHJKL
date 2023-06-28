Imports System.Data.SqlClient

Public Class EE_W4_VT
    Inherits System.Web.UI.Page


    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer

    Dim strScreenName As String


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EEW4VT"


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
            imgNext.Visible = False

            PopulateFields()

            divError.Visible = False

        End If

        If Session("DataComplete") = "Yes" Then
            divError.Visible = False
            divSuccess.Visible = True
            imgNext.Visible = True
        Else
            divSuccess.Visible = False
            imgNext.Visible = False
        End If

        btnSave.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSave, "") + ";this.src='/img/processing.gif';")
        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateFields()
        'Get State W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id


            lblFName.Text = ec.FirstName
            lblMiddleInitial.Text = ec.MiddleInitial
            lblLName.Text = ec.LastName
            lblSSNumber.Text = ec.SSNwithDashes

            txtPW_BoxA.Text = ec.PW_BoxA
            txtPW_BoxB.Text = ec.PW_BoxB
            txtPW_BoxC.Text = ec.PW_BoxC
            txtPW_BoxD.Text = ec.PW_BoxD

            txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding

            txtSignature.Text = ec.W4_Signature
            txtSignatureDate.Text = Date.Now()

            chkSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            chkMarried.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)
            chkMarriedWithholdHigher.Checked = IIf(ec.TaxFilingStatusId = "4", True, False)
            MarriedFilingSep.Checked = IIf(ec.TaxFilingStatusId = "3", True, False)
            'chkCivilUnionHigher.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)

        End If

        If sc.GetNavigation(Session("UserId"), intEmployeeId, Session("ScreenName"), 0) = True Then
            Session("DataComplete") = sc.DataComplete
        End If

        If Session("DataComplete") = "Yes" Then
            imgNext.Visible = True

        Else
            imgNext.Visible = False

        End If

    End Sub

    Private Sub Save()
        'Check for required fields
        If Trim(txtTotalExemptions.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please Enter Total Exemptions - enter 0 if none, if using Additional Withholding, or if you are Exempt"
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtSignature.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "This form is not valid unless signed"
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If chkSingle.Checked = False And chkMarried.Checked = False And chkMarriedWithholdHigher.Checked = False And MarriedFilingSep.Checked = False Then
            divError.Visible = True
            chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarriedWithholdHigher.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            MarriedFilingSep.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            lblError.Text = "Please complete Marital Status"
            Exit Sub
        End If


        If (chkSingle.Checked = True Or chkMarried.Checked = True Or chkMarriedWithholdHigher.Checked = True Or MarriedFilingSep.Checked = True) Then
            If Trim(txtTotalExemptions.Text) <> "" Then
                If Trim(txtSignature.Text) <> "" Then

                    txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarriedWithholdHigher.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    MarriedFilingSep.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

                    Dim objParam As SqlParameter
                    Dim objDataSet As New DataSet
                    Dim aryParams As New ArrayList()
                    Dim sqlCon As New SQLControl
                    sqlCon.OpenConn()

                    objParam = New SqlParameter("@EmployeeW4Id", Session("EmployeeW4Id"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@EmployeeId", intEmployeeId)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TaxYear", Now.Year())
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ScreenName", Session("ScreenName"))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@PW_BoxA", txtPW_BoxA.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxB", txtPW_BoxB.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxC", txtPW_BoxC.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxD", txtPW_BoxD.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TaxFilingStatusId", IIf(chkSingle.Checked = True, "1",
                                                                        IIf(chkMarried.Checked = True, "2",
                                                                            IIf(MarriedFilingSep.Checked = True, "3",
                                                                                    IIf(chkMarriedWithholdHigher.Checked = True, "4", "")))))
                    aryParams.Add(objParam)


                    objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit_Dev", aryParams)
                    sqlCon.CloseConn()

                    divSuccess.Visible = True

                    s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

                End If
            End If
        End If

        PopulateFields()
        ResetScrollPosition()
        btnSave.Visible = True
        imgProcessing.Visible = False

    End Sub

    Protected Sub chkSingle_CheckedChanged(sender As Object, e As EventArgs)
        If chkSingle.Checked = True Then
            chkMarried.Checked = False
            chkMarriedWithholdHigher.Checked = False
            MarriedFilingSep.Checked = False
        End If
    End Sub

    Protected Sub chkMarried_CheckedChanged(sender As Object, e As EventArgs)
        If chkMarried.Checked = True Then
            chkSingle.Checked = False
            chkMarriedWithholdHigher.Checked = False
            MarriedFilingSep.Checked = False
        End If
    End Sub

    Protected Sub chkMarriedWithholdHigher_CheckedChanged(sender As Object, e As EventArgs)
        If chkMarriedWithholdHigher.Checked = True Then
            chkMarried.Checked = False
            chkSingle.Checked = False
            MarriedFilingSep.Checked = False
        End If
    End Sub
    Protected Sub MarriedFilingSep_CheckedChanged(sender As Object, e As EventArgs)
        If MarriedFilingSep.Checked = True Then
            chkMarried.Checked = False
            chkMarriedWithholdHigher.Checked = False
            chkSingle.Checked = False
        End If
    End Sub


    Protected Sub btnSave_Click(sender As Object, e As ImageClickEventArgs)
        Save()

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Save()

        Response.Redirect(Session("NextScreen"))
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