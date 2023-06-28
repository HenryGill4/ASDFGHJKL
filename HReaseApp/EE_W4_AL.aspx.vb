Imports System.Data.SqlClient

Public Class EE_W4_AL
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
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

        'Change this on each page
        strScreenName = "EEW4AL"

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

            PopulateFields()

            divError.Visible = False

        End If

        If Session("DataComplete") = "Yes" Then
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
            lblFullName.Text = ec.EmployeeFullName
            lblHomeAddress.Text = ec.AddressCombined
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZipCode.Text = ec.Zip
            lblSSNumber.Text = ec.SSNwithDashes
            txtSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now(), ec.W4_SignatureDate)

            txtTaxFilingStatusLine1.Text = IIf(ec.TaxFilingStatusId = "17", "S",
                                                IIf(ec.TaxFilingStatusId = "14", "MS",
                                                    ""))

            txtTaxFilingStatusLine2.Text = IIf(ec.TaxFilingStatusId = "16", "M",
                                                IIf(ec.TaxFilingStatusId = "15", "H",
                                                    ""))

            txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding

            txtClaimNoExemptions.Text = IIf(ec.TaxFilingStatusId = "13", "0", "")
            txtNumberOfDependents.Text = ec.W4_Box2

            lblEmployerName.Text = ec.CompanyName
            lblEmployerFEIN.Text = ec.CompanyFEIN
            'lblEmployerStateId.Text = ec.CompanyState
            lblEmployerAddress.Text = IIf(ec.CompanyAddress2 = "", ec.CompanyAddress1, ec.CompanyAddress1 + ", " + ec.CompanyAddress2)
            lblEmployerCity.Text = ec.CompanyCity
            lblEmployerState.Text = ec.CompanyState
            lblEmployerZip.Text = ec.CompanyZip

        End If

    End Sub

    Private Sub Save()
        'Check for required fields
        If txtClaimNoExemptions.Text = "" And txtTaxFilingStatusLine1.Text = "" And txtTaxFilingStatusLine2.Text = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "You must complete at least one entry on Line 1-7"
            txtClaimNoExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtTaxFilingStatusLine1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtTaxFilingStatusLine2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
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

        If txtClaimNoExemptions.Text <> "" Or txtTaxFilingStatusLine1.Text <> "" Or txtTaxFilingStatusLine2.Text <> "" Then
            If Trim(txtSignature.Text) <> "" Then

                imgProcessing.Visible = True

                txtClaimNoExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                txtTaxFilingStatusLine1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                txtTaxFilingStatusLine2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

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

                objParam = New SqlParameter("@TaxFilingStatusId", IIf(txtClaimNoExemptions.Text = "0", "13",
                                                                        IIf(txtTaxFilingStatusLine1.Text = "S", "17",
                                                                            IIf(txtTaxFilingStatusLine1.Text = "MS", "14",
                                                                                IIf(txtTaxFilingStatusLine2.Text = "M", "16",
                                                                                    IIf(txtTaxFilingStatusLine2.Text = "H", "15",
                                                                                    ""))))))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box1", txtClaimNoExemptions.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box2", txtTaxFilingStatusLine1.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Box3", txtTaxFilingStatusLine2.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box10", txtNumberOfDependents.Text)
                aryParams.Add(objParam)

                objDataSet = sqlCon.CreateDataSet("usp_Employee_W4", aryParams)
                sqlCon.CloseConn()

                divSuccess.Visible = True
                divError.Visible = False
                imgNext.Visible = True

                s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

                imgProcessing.Visible = False

            End If
        End If

        PopulateFields()
        ResetScrollPosition()

    End Sub
    Protected Sub txtTaxFilingStatusLine1_TextChanged(sender As Object, e As EventArgs)
        If txtTaxFilingStatusLine1.Text <> "" Then
            txtTaxFilingStatusLine2.Text = ""
            txtClaimNoExemptions.Text = ""
        End If
    End Sub
    Protected Sub txtTaxFilingStatusLine2_TextChanged(sender As Object, e As EventArgs)
        If txtTaxFilingStatusLine2.Text <> "" Then
            txtTaxFilingStatusLine1.Text = ""
            txtClaimNoExemptions.Text = ""
        End If
    End Sub

    Protected Sub txtTotalExemptions_TextChanged(sender As Object, e As EventArgs)
        If txtTotalExemptions.Text <> "" Then
        End If
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As ImageClickEventArgs)
        Save()

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Save()

        'Find Next Screen in Navigation
        If divError.Visible = True Then
            Exit Sub
        Else
            imgNext.Visible = False
            
            'lblSuccess.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")
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