Imports System.Data.SqlClient

Public Class EE_W4_CT
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim SecClass As New Security
    Dim ScreenConfig As New ScreenConfiguration
    Dim ec As New Employee

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
        strScreenName = "EEW4CT"
        strScreenShortDesc = "CT W-4 Form"

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
            SecClass.SaveUserUpdate(Session("UserId"), strScreenName, "Browse", intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

            If ScreenConfig.GetNavigation(Session("UserId"), intEmployeeId, strScreenName, 0) = True Then
                Session("ScreenName") = ScreenConfig.ScreenName
                Session("ScreenShortDesc") = ScreenConfig.ScreenShortDesc
                Session("ScreenPath") = ScreenConfig.ScreenPath
                Session("DataComplete") = ScreenConfig.DataComplete
                Session("NextScreen") = ScreenConfig.NextScreen
                Session("TabString") = ScreenConfig.TabString
                Session("ScreenConfigTitle") = ScreenConfig.ScreenConfigTitle
                Session("ScreenConfigText") = ScreenConfig.ScreenConfigText

            End If

            LiteralTopMenu.Text = ScreenConfig.BuildMenu(Session("Admin"), Session("ScreenPath"))
            LiteralTab.Text = ScreenConfig.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            ScreenConfig.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            'lblMainArticleTitle.Text = ScreenConfig.MainArticleTitle
            'lblMainArticleText.Text = IIf(ScreenConfig.MainArticleText = "", "Please complete form", ScreenConfig.MainArticleText)
            imgNext.Visible = False
            

            PopulateFields()

        End If

        divError.Visible = False
        divSuccess.Visible = False
        btnSave.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSave, "") + ";this.src='/img/processing.gif';")
        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateFields()
        'Get State W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id

            lblFName.Text = ec.FirstName
            lblLName.Text = ec.LastName
            lblMI.Text = ec.MiddleInitial
            lblFullAddress.Text = ec.AddressCombined
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZipCode.Text = ec.Zip
            lblSSNumber.Text = ec.SSNwithDashes

            txtAdditionalWithholding.Text = ec.AdditionalWithholding
            chkMilitarySpouseRelief.Checked = IIf(ec.MilitarySpouseRelief = "1", True, False)

            txtSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now(), ec.W4_SignatureDate)

            txtWithholdingCode.Text = ec.W4_Box1
            txtReducedAmount.Text = ec.W4_Box2

            chkNo.Checked = IIf(ec.ID_Box1 = "0", True, False)
            chkYes.Checked = IIf(ec.ID_Box1 = "1", True, False)
            lblHiredDate.Text = IIf(ec.LatestRehireDate <> "", ec.LatestRehireDate,
                                    IIf(ec.OriginalHireDate <> "", ec.OriginalHireDate,
                                        ""))

            lblEmployerFullName.Text = ec.CompanyName
            lblEmployerFEIN.Text = ec.CompanyFEIN
            lblEmployerFullAddress.Text = ec.CompanyAddress1
            lblEmployerCity.Text = ec.CompanyCity
            lblEmployerState.Text = ec.CompanyState
            lblEmployerZipCode.Text = ec.CompanyZip
            lblEmployerContactPerson.Text = ""
            lblEmployerTelNo.Text = ""

        End If

        If ScreenConfig.GetNavigation(Session("UserId"), intEmployeeId, Session("ScreenName"), 0) = True Then
            Session("DataComplete") = ScreenConfig.DataComplete
        End If

        If Session("DataComplete") = "Yes" Then
            imgNext.Visible = True
            
        Else
            imgNext.Visible = False
            
        End If

    End Sub

    Private Sub Save()
        If (txtWithholdingCode.Text = "" And txtAdditionalWithholding.Text = "" And chkMilitarySpouseRelief.Checked = False) Then
            divError.Visible = True
            divSuccess.Visible = False
            txtWithholdingCode.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtAdditionalWithholding.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMilitarySpouseRelief.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please enter into either Line 1 or Line 2 below or check that you are exempt due to MSRRA"
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

        If (txtWithholdingCode.Text <> "" Or txtAdditionalWithholding.Text <> "" Or chkMilitarySpouseRelief.Checked = True) Then
            If Trim(txtSignature.Text) <> "" Then

                txtWithholdingCode.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                txtAdditionalWithholding.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                chkMilitarySpouseRelief.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
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

                objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@MilitarySpouseRelief", IIf(chkMilitarySpouseRelief.Checked = True, 1, 0))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Box1", txtWithholdingCode.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box2", txtReducedAmount.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@ID_Box1", IIf(chkNo.Checked = True, "0",
                                                            IIf(chkYes.Checked = True, "1",
                                                                "")))
                aryParams.Add(objParam)

                objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit_Dev", aryParams)
                sqlCon.CloseConn()

                divSuccess.Visible = True

                SecClass.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

            End If
        End If

        PopulateFields()
        ResetScrollPosition()

    End Sub

    Protected Sub btnSave_Click(sender As Object, e As ImageClickEventArgs)
        Save()

        'If no errors go to Next Screen in Navigation
        If divError.Visible = True Then
            Exit Sub
        Else
            imgNext.Visible = False
            
            ResetScrollPosition()
            Response.AddHeader("REFRESH", "0;URL=" + Session("NextScreen"))
        End If

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Save()

        'Find Next Screen in Navigation
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
End Class