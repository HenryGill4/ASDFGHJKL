Imports System.Data.SqlClient

Public Class EE_W4
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee
    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Dim intCompanyId As Integer
    Dim intUserId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EEW4"
        strScreenShortDesc = "W4"

        intUserId = Session("UserId")

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

            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), Session("ScreenPath"))
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            sc.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            'lblMainArticleTitle.Text = ScreenConfig.MainArticleTitle
            'lblMainArticleText.Text = IIf(ScreenConfig.MainArticleText = "", "Please complete form", ScreenConfig.MainArticleText)

            PopulateFields()

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
        'Go Get Employee W4 Info
        'LblTaxYear.Text = Date.Now.Year
        'LblTaxYear1.Text = Date.Now.Year

        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year, Session("ScreenName")) = True Then

            If ec.Address1 = "" Or ec.SSN = "" Or ec.BirthDate = "" Or ec.BirthDate = "01/01/1900" Then
                lblError.Text = "Please enter required data on Profile page before completing this form."
                divError.Visible = True
                divSuccess.Visible = False
                imgNext.Visible = False
                ResetScrollPosition()
                Exit Sub
            Else
                Session("EmployeeW4Id") = ec.EmployeeW4Id
                lblFirstName.Text = ec.FirstNameMiddleInitial
                lblLastName.Text = ec.LastName
                lblAddress.Text = ec.AddressCombined
                lblCityStateZip.Text = ec.CityStateZip
                lblSSN.Text = ec.SSNwithDashes

                chkSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
                chkMarried.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)
                chkHOH.Checked = IIf(ec.TaxFilingStatusId = "4", True, False)

                chkMultipleJobsOrSpouseWorks.Checked = IIf(ec.W4_Box1 = "1", True, False)
                txtW4_Box2.Text = ec.W4_Box2
                txtW4_Box3.Text = ec.W4_Box3
                txtW4_Box4.Text = ec.W4_Box4
                txtW4_Box5.Text = ec.W4_Box5
                txtW4_Box6.Text = ec.W4_Box6

                txtAdditionalWithholding.Text = ec.AdditionalWithholding

                txtSignature.Text = ec.W4_Signature
                txtSignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now, ec.W4_SignatureDate)

                txtPW_BoxA.Text = ec.PW_BoxA
                txtPW_BoxB.Text = ec.PW_BoxB
                txtPW_BoxC.Text = ec.PW_BoxC
                txtPW_BoxD.Text = ec.PW_BoxD
                txtPW_BoxE.Text = ec.PW_BoxE
                txtPW_BoxF.Text = ec.PW_BoxF

                txtID_Box1.Text = ec.ID_Box1
                txtID_Box2.Text = ec.ID_Box2
                txtID_Box3.Text = ec.ID_Box3
                txtID_Box4.Text = ec.ID_Box4
                txtID_Box5.Text = ec.ID_Box5

                lblEmployerName.Text = ec.CompanyName
                lblEmployerAddress.Text = ec.CompanyAddress1 + " " + IIf(Len(ec.CompanyAddress2) > 0, ec.CompanyAddress2, "")
                lblEmployerCityStateZip.Text = ec.CompanyCity + ", " + ec.CompanyState + " " + ec.CompanyZip
                lblLatestHireDate.Text = IIf(ec.LatestRehireDate = "1/1/1900",
                                             ec.OriginalHireDate,
                                             IIf(ec.LatestRehireDate = "",
                                                ec.OriginalHireDate,
                                                    ec.LatestRehireDate))
                lblEmployerFEIN.Text = ec.CompanyFEIN

            End If
        End If

    End Sub

    Private Sub Save()

        'Check for required fields
        If chkHOH.Checked = False And chkMarried.Checked = False And chkSingle.Checked = False Then
            divError.Visible = True
            divSuccess.Visible = False
            imgNext.Visible = False
            lblError.Text = "Please choose a marital status in Step 1 box (c)"
            chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkHOH.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtSignature.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            imgNext.Visible = False
            lblError.Text = "This form is not valid unless signed"
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ResetScrollPosition()
            Exit Sub
        End If

        If Trim(txtSignature.Text) <> "" Then
            If chkHOH.Checked = True Or chkMarried.Checked = True Or chkSingle.Checked = True Then

                chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                chkHOH.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
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

                objParam = New SqlParameter("@TaxFilingStatusId", IIf(chkSingle.Checked = True, "1",
                                                                    IIf(chkMarried.Checked = True, "2",
                                                                        IIf(chkHOH.Checked = True, "4", "0"))))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Box1", IIf(chkMultipleJobsOrSpouseWorks.Checked = True, "1", "0"))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box2", txtW4_Box2.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box3", txtW4_Box3.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box4", txtW4_Box4.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box5", txtW4_Box5.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box6", txtW4_Box6.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@PW_BoxA", txtPW_BoxA.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxB", txtPW_BoxB.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxC", txtPW_BoxC.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxD", txtPW_BoxD.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxE", txtPW_BoxE.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@PW_BoxF", txtPW_BoxF.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@ID_Box1", txtID_Box1.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box2", txtID_Box2.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box3", txtID_Box3.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box4", txtID_Box4.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box5", txtID_Box5.Text)
                aryParams.Add(objParam)

                objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit", aryParams)
                sqlCon.CloseConn()

                divSuccess.Visible = True
                imgNext.Visible = True
                divError.Visible = False

                s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

            End If
        End If

        btnSave.Visible = True

        PopulateFields()
        ResetScrollPosition()

    End Sub

    Protected Sub chkSingle_CheckedChanged(sender As Object, e As EventArgs)
        If chkSingle.Checked = True Then
            chkMarried.Checked = False
            chkHOH.Checked = False
        End If
    End Sub

    Protected Sub chkMarried_CheckedChanged(sender As Object, e As EventArgs)
        If chkMarried.Checked = True Then
            chkSingle.Checked = False
            chkHOH.Checked = False
        End If
    End Sub

    Protected Sub chkHOH_CheckedChanged(sender As Object, e As EventArgs)
        If chkHOH.Checked = True Then
            chkMarried.Checked = False
            chkSingle.Checked = False
        End If
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As ImageClickEventArgs)
        Save()

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs) Handles imgNext.Click
        Save()

        'Find Next sreen in Navigation
        If divError.Visible = True Then
            Exit Sub
        Else
            imgNext.Visible = False
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

    Protected Sub txtW4_Box6_TextChanged(sender As Object, e As EventArgs) Handles txtW4_Box6.TextChanged

    End Sub

    Protected Sub txtPW_BoxF_TextChanged(sender As Object, e As EventArgs) Handles txtPW_BoxF.TextChanged

    End Sub

    Protected Sub txtPW_BoxA_TextChanged(sender As Object, e As EventArgs) Handles txtPW_BoxA.TextChanged

    End Sub
End Class
