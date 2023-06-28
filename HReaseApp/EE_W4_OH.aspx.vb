Imports System.Data.SqlClient

Public Class EE_W4_OH
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
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
        strScreenName = "EEW4OH"
        strScreenShortDesc = "OH W-4 Form"

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

        If Session("DataComplete") = "Yes" Then
            divError.Visible = False
            divSuccess.Visible = True
        Else
            divSuccess.Visible = False
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
            lblSSN.Text = ec.SSNwithDashes
            lblFullAddress.Text = ec.FullAddress

            txtPublicSchoolDisttResidence.Text = ec.W4_Box1
            txtSchoolDisttNo.Text = ec.W4_Box2
            txtBox1.Text = ec.W4_Box3
            txtBox2.Text = ec.W4_Box4
            txtNumberOfDependents.Text = ec.W4_Box10

            txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding

            txtSignature.Text = ec.W4_Signature
            txtSignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now, ec.W4_SignatureDate)

            chkExempt1.Checked = IIf(ec.W4_Box5 = "1", True, False)
            chkExempt2.Checked = IIf(ec.W4_Box6 = "1", True, False)
            chkExempt3.Checked = IIf(ec.W4_Box7 = "1", True, False)
            chkExempt4.Checked = IIf(ec.W4_Box8 = "1", True, False)
            chkMilitarySpouse.Checked = IIf(ec.MilitarySpouseRelief = "1", True, False)

        End If

    End Sub
    Private Sub Save()
        'Check for required fields
        If Trim(txtPublicSchoolDisttResidence.Text) = "" Or Trim(txtSchoolDisttNo.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            txtPublicSchoolDisttResidence.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtSchoolDisttNo.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please complete School District information"
            ResetScrollPosition()
            Exit Sub
        End If
        If (Trim(txtTotalExemptions.Text) = "" Or txtBox1.Text = "" Or txtBox2.Text = "") And chkExempt1.Checked = False And chkExempt2.Checked = False And chkExempt3.Checked = False And chkExempt4.Checked = False And chkMilitarySpouse.Checked = False Then
            divError.Visible = True
            divSuccess.Visible = False
            If Trim(txtTotalExemptions.Text) = "" Then
                txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            End If
            If txtBox1.Text = "" Then
                txtBox1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            End If
            If txtBox2.Text = "" Then
                txtBox2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            End If
            lblError.Text = "Please enter valid values into Section II Line 1, 2, or complete Section III. "
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtSignature.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "This form is not valid unless signed"
            ResetScrollPosition()
            Exit Sub
        End If

        If (Trim(txtTotalExemptions.Text) <> "" And txtBox1.Text <> "" And txtBox2.Text <> "") Or (chkExempt1.Checked = True Or chkExempt2.Checked = True Or chkExempt3.Checked = True Or chkExempt4.Checked = True Or chkMilitarySpouse.Checked = True) Then
            If Trim(txtSignature.Text) <> "" Then
                If Trim(txtPublicSchoolDisttResidence.Text) <> "" And Trim(txtSchoolDisttNo.Text) <> "" Then

                    txtPublicSchoolDisttResidence.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtSchoolDisttNo.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtBox1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtBox2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

                    btnSave.Visible = False
                    imgProcessing.Visible = True
                    lblError.Text = ""
                    divError.Visible = False
                    imgNext.Visible = True

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

                    objParam = New SqlParameter("@TaxFilingStatusId", IIf(txtBox2.Text = "1", "2", "1"))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Box1", txtPublicSchoolDisttResidence.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box2", txtSchoolDisttNo.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box3", txtBox1.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box4", txtBox2.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box10", txtNumberOfDependents.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Box5", IIf(chkExempt1.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box6", IIf(chkExempt2.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box7", IIf(chkExempt3.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box8", IIf(chkExempt4.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@MilitarySpouseRelief", IIf(chkMilitarySpouse.Checked = True, 1, 0))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@Exempt", IIf(chkExempt1.Checked = True Or chkExempt2.Checked = True Or chkExempt3.Checked = True Or chkExempt4.Checked = True Or chkMilitarySpouse.Checked = True, "1", "0"))
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