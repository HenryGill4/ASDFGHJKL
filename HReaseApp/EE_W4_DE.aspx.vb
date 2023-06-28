Imports System.Data.SqlClient

Public Class EE_W4_DE
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
        strScreenName = "EEW4DE"
        strScreenShortDesc = "DE W-4 Form"

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

    Private Function _toFocus() As String
        Throw New NotImplementedException()
    End Function

    Private Sub PopulateFields()
        'Get State W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id
            lblFirstNameMI.Text = ec.FirstName + " " + ec.MiddleInitial
            lblLastName.Text = ec.LastName
            lblSSNumber.Text = ec.SSNwithDashes
            lblAddress.Text = ec.AddressCombined
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZip.Text = ec.Zip
            chkSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            chkMarried.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)

            txtTotalDependents.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding

            txtSignature.Text = ec.W4_Signature
            txtSignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now, ec.W4_SignatureDate)

            lblEmployerName.Text = ec.CompanyName
            lblEmployerFullAddress.Text = ec.CompanyAddress1
            lblEmployerCity.Text = ec.CompanyCity
            lblEmployerState.Text = ec.CompanyState
            lblEmployerZip.Text = ec.CompanyZip

            lblDateOfHire.Text = ec.OriginalHireDate

            lblEmployerFEIN.Text = ec.CompanyFEIN

            txtResBoxA.Text = ec.PW_BoxA
            txtResBoxB.Text = ec.PW_BoxB
            txtResBoxC.Text = ec.PW_BoxC
            txtResBoxD.Text = ec.PW_BoxD
            txtResBoxE.Text = ec.PW_BoxE
            txtResBoxF.Text = ec.PW_BoxF
            txtResBoxG.Text = ec.PW_BoxG
            txtResBoxH1.Text = ec.PW_BoxH
            txtResBoxH2.Text = ec.PW_BoxI
            txtResBoxH3.Text = ec.PW_BoxJ
            txtResBoxH4.Text = ec.PW_BoxK
            txtResBoxH5.Text = ec.PW_BoxL
            txtResBoxH6.Text = ec.PW_BoxM
            txtResBoxH7.Text = ec.PW_BoxN
            txtResBoxH8.Text = ec.PW_BoxO
            txtResBoxH9.Text = ec.PW_BoxP
            txtResBoxH10.Text = ec.PW_BoxQ

            txtNonRes1A.Text = ec.TE_Box1
            txtNonRes1B.Text = ec.TE_Box2
            txtNonRes2A.Text = ec.TE_Box3
            txtNonRes2B.Text = ec.TE_Box4
            txtNonRes3A.Text = ec.TE_Box5
            txtNonRes3B.Text = ec.TE_Box6
            txtNonRes4aA.Text = ec.TE_Box7
            txtNonRes4aB.Text = ec.TE_Box8
            txtNonRes4bA.Text = ec.TE_Box9
            txtNonRes4bB.Text = ec.TE_Box10
            txtNonRes4cA.Text = ec.TE_Box11
            txtNonRes4cB.Text = ec.TE_Box12
            txtNonRes5A.Text = ec.TE_Box13
            txtNonRes5B.Text = ec.TE_Box14
            txtNonRes6.Text = ec.TE_Box15

            txtNonRes7.Text = ec.ID_Box1
            txtNonRes8.Text = ec.ID_Box2
            txtNonRes9.Text = ec.ID_Box3
            txtNonRes10.Text = ec.ID_Box4
            txtNonRes11.Text = ec.ID_Box5
            txtNonRes12.Text = ec.ID_Box6
            txtNonRes13.Text = ec.ID_Box7
            txtNonRes14.Text = ec.ID_Box8
            txtNonRes15.Text = ec.ID_Box9

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
        If chkSingle.Checked = False And chkMarried.Checked = False Then
            divError.Visible = True
            divSuccess.Visible = False
            chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please Complete Marital Status"
            imgNext.Visible = False
            
            ResetScrollPosition()
            Exit Sub
        End If

        If Trim(txtTotalDependents.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            txtTotalDependents.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please Enter Total Dependents"
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

        If (chkSingle.Checked = True Or chkMarried.Checked = True) Then
            If Trim(txtTotalDependents.Text) <> "" Then
                If Trim(txtSignature.Text) <> "" Then

                    chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtTotalDependents.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
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

                    objParam = New SqlParameter("@TaxFilingStatusId", IIf(chkMarried.Checked = True, "2", "1"))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TotalExemptions", txtTotalDependents.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@PW_BoxA", txtResBoxA.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxB", txtResBoxB.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxC", txtResBoxC.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxD", txtResBoxD.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxE", txtResBoxE.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxF", txtResBoxF.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxG", txtResBoxG.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxH", txtResBoxH1.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxI", txtResBoxH2.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxJ", txtResBoxH3.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxK", txtResBoxH4.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxL", txtResBoxH5.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxM", txtResBoxH6.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxN", txtResBoxH7.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxO", txtResBoxH8.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxP", txtResBoxH9.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxQ", txtResBoxH10.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TE_Box1", txtNonRes1A.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box2", txtNonRes1B.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box3", txtNonRes2A.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box4", txtNonRes2B.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box5", txtNonRes3A.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box6", txtNonRes3B.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box7", txtNonRes4aA.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box8", txtNonRes4aB.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box9", txtNonRes4bA.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box10", txtNonRes4bB.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box11", txtNonRes4cA.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box12", txtNonRes4cB.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box13", txtNonRes5A.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box14", txtNonRes5B.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box15", txtNonRes6.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@ID_Box1", txtNonRes7.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box2", txtNonRes8.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box3", txtNonRes9.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box4", txtNonRes10.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box5", txtNonRes11.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box6", txtNonRes12.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box7", txtNonRes13.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box8", txtNonRes14.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box9", txtNonRes15.Text)
                    aryParams.Add(objParam)

                    objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit_Dev", aryParams)
                    sqlCon.CloseConn()

                    divSuccess.Visible = True

                    SecClass.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

                End If
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

    Protected Sub chkSingle_CheckedChanged(sender As Object, e As EventArgs)
        If chkSingle.Checked = True Then
            chkMarried.Checked = False
        End If
    End Sub

    Protected Sub chkMarried_CheckedChanged(sender As Object, e As EventArgs)
        If chkMarried.Checked = True Then
            chkSingle.Checked = False
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