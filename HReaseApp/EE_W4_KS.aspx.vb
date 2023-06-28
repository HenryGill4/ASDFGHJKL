Imports System.Data.SqlClient

Public Class EE_W4_KS

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
        strScreenName = "EEW4KS"

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

            txtTotalExemptions.Focus()

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
            lblLName.Text = ec.LastName
            lblMailAddress.Text = ec.AddressCombined
            lblCityStateZip.Text = ec.CityStateZip
            lblSSNumber.Text = ec.SSNwithDashes

            chkSingle1.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            chkJoint1.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)

            txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding
            chkExempt.Checked = IIf(ec.Exempt = 1, True, False)

            txtSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now(), ec.W4_SignatureDate)

            txtBoxB.Text = ec.PW_BoxB
            txtBoxC.Text = ec.PW_BoxC
            txtBoxD.Text = ec.PW_BoxD
            txtBoxE.Text = ec.PW_BoxE
            txtBoxF.Text = ec.PW_BoxF

            lblEmployerName.Text = ec.CompanyName
            lblEmployerAddress.Text = ec.CompanyAddress1 + " " + IIf(Len(ec.CompanyAddress2) > 0, ec.CompanyAddress2, "")
            lblEmployerCityStateZip.Text = ec.CompanyCity + ", " + ec.CompanyState + " " + ec.CompanyZip
            lblEmployerFEIN.Text = ec.CompanyFEIN

        End If

    End Sub

    Private Sub Save()
        'Check for required fields
        If chkSingle1.Checked = False And chkJoint1.Checked = False And chkExempt.Checked <> True Then
            divError.Visible = True
            divSuccess.Visible = False
            chkSingle1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkJoint1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please enter Allowance Rate in Box 3"
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtTotalExemptions.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please enter Allowance Rate in Box 3"
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtSignature.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "This form is not valid unless signed"
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If

        If (chkSingle1.Checked = True Or chkJoint1.Checked = True Or chkExempt.Checked = True) Then
            If Trim(txtTotalExemptions.Text) <> "" Then
                If Trim(txtSignature.Text) <> "" Then

                    chkSingle1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkJoint1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

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

                    objParam = New SqlParameter("@TaxFilingStatusId", IIf(chkSingle1.Checked = True, "1",
                                                                        IIf(chkJoint1.Checked = True, "2",
                                                                            "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@Exempt", IIf(chkExempt.Checked = True, 1, 0))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@PW_BoxB", txtBoxB.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxC", txtBoxC.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxD", txtBoxD.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxE", txtBoxE.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxF", txtBoxF.Text)
                    aryParams.Add(objParam)

                    objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit", aryParams)
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