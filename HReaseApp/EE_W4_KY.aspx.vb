Imports System.Data.SqlClient

Public Class EE_W4_KY
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
            'Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EEW4KY"


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
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "EE_DirectDeposit")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            'lblMainArticleTitle.Text = sc.MainArticleTitle
            'lblMainArticleText.Text = IIf(sc.MainArticleText = "", "Please complete form", sc.MainArticleText)
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

            lblFullName.Text = ec.EmployeeFullName
            lblHomeAddress.Text = ec.Address1
            lblSSNumber.Text = ec.SSNwithDashes
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZip.Text = ec.Zip

            'txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding
            ChkExmpt1.Checked = If(ec.W4_Box1 = "1", True, False)
            ChkExmpt2.Checked = If(ec.W4_Box2 = "1", True, False)
            ChkExmpt3.Checked = If(ec.W4_Box3 = "1", True, False)
            ChkExmpt4.Checked = If(ec.W4_Box4 = "1", True, False)

            'txtBox1.Text = ec.W4_Box1
            'txtBox2.Text = ec.W4_Box3
            'txtBox3.Text = ec.W4_Box3
            'txtBox4.Text = ec.W4_Box4
            'txtBox5.Text = ec.W4_Box5
            'txtBox6.Text = ec.W4_Box6

            'txtPayrollNo.Text = ec.W4_Box7
            'txtNumberOfDependents.Text = ec.W4_Box10

            txtSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now(), ec.W4_SignatureDate)

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
        'If Trim(txtTotalExemptions.Text) = "" Then
        '    divError.Visible = True
        '    divSuccess.Visible = False
        '    txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
        '    lblError.Text = "Please Enter Total Exemptions - enter 0 if none or if using Additional Withholding or if you are Exempt"
        '    imgNext.Visible = False

        '    ResetScrollPosition()
        '    Exit Sub
        'End If
        If Trim(txtSignature.Text) = "" Then
            divError.Visible = True
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "This form is not valid unless signed"
            imgNext.Visible = False
            
            ResetScrollPosition()
            Exit Sub
        End If

        'If Trim(txtTotalExemptions.Text) <> "" Then
        If Trim(txtSignature.Text) <> "" Then

            'txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
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

            'objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
            'aryParams.Add(objParam)

            objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
            aryParams.Add(objParam)

            'objParam = New SqlParameter("@W4_Box1", txtBox1.Text)
            'aryParams.Add(objParam)
            'objParam = New SqlParameter("@W4_Box2", txtBox2.Text)
            'aryParams.Add(objParam)
            'objParam = New SqlParameter("@W4_Box3", txtBox3.Text)
            'aryParams.Add(objParam)
            'objParam = New SqlParameter("@W4_Box4", txtBox4.Text)
            'aryParams.Add(objParam)
            'objParam = New SqlParameter("@W4_Box5", txtBox5.Text)
            'aryParams.Add(objParam)
            'objParam = New SqlParameter("@W4_Box6", txtBox6.Text)
            'aryParams.Add(objParam)
            'objParam = New SqlParameter("@W4_Box7", txtPayrollNo.Text)
            'aryParams.Add(objParam)
            'objParam = New SqlParameter("@W4_Box10", txtNumberOfDependents.Text)
            'aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit_Dev", aryParams)
                sqlCon.CloseConn()

                divSuccess.Visible = True

                s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

            End If
        'End If

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