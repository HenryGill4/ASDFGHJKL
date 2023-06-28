Imports System.Data.SqlClient

Public Class EE_W4_PA
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
        strScreenName = "EEW4PA"
        strScreenShortDesc = "PA W-4 Form"

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

            

            ScreenConfig.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            LiteralTopMenu.Text = ScreenConfig.BuildMenu(Session("Admin"), "EE_DirectDeposit")
            LiteralTab.Text = ScreenConfig.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
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

            lblLastFirstMiddle.Text = ec.LastName + ", " + ec.FirstName + IIf(ec.MiddleInitial = "", "", ", " + ec.MiddleInitial)
            lblSSNumber.Text = ec.SSNwithDashes
            lblAddress1.Text = ec.Address1
            lblAddress2.Text = ec.Address2
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZipCode.Text = ec.Zip
            lblMobilePhoneNo.Text = ec.MobilePhone

            txtMuncipality.Text = ec.W4_Box1
            txtCounty.Text = ec.W4_Box2
            txtResidentPSDCode.Text = ec.W4_Box3
            txtResidentEITRate.Text = ec.W4_Box4

            lblEmployerName.Text = ec.CompanyName
            lblEmployerFEIN.Text = ec.CompanyFEIN
            txtEmployerAddress1.Text = IIf(ec.W4_Box5 <> "", ec.W4_Box5, ec.CompanyAddress1)
            txtEmployerAddress2.Text = IIf(ec.W4_Box6 <> "", ec.W4_Box6, ec.CompanyAddress2)
            txtEmployerCity.Text = IIf(ec.W4_Box7 <> "", ec.W4_Box7, ec.CompanyCity)
            txtEmployerState.Text = IIf(ec.W4_Box8 <> "", ec.W4_Box8, ec.CompanyState)
            txtEmployerZipCode.Text = IIf(ec.W4_Box9 <> "", ec.W4_Box9, ec.CompanyZip)
            txtEmployerPhone.Text = ec.W4_Box10

            txtEmployerMuncipal.Text = ec.ID_Box1
            txtERCounty.Text = ec.ID_Box2

            txtEmployerLocationPSDCode.Text = ec.ID_Box3
            txtEmployerWLNonResEITRate.Text = ec.ID_Box4

            txtSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now(), ec.W4_SignatureDate)

            txtEEPhone.Text = IIf(ec.ID_Box5 <> "", ec.ID_Box5, ec.MobilePhone)
            txtEmail.Text = IIf(ec.ID_Box6 <> "", ec.ID_Box6, ec.Email1)
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
        If Trim(txtSignature.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "This form is not valid unless signed"
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ResetScrollPosition()
            Exit Sub
        End If

        If Trim(txtSignature.Text) <> "" Then

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

            objParam = New SqlParameter("@W4_Box1", txtMuncipality.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_Box2", txtCounty.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_Box3", txtResidentPSDCode.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_Box4", txtResidentEITRate.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_Box5", txtEmployerAddress1.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_Box6", txtEmployerAddress2.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_Box7", txtEmployerCity.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_Box8", txtEmployerState.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_Box9", txtEmployerZipCode.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_Box10", txtEmployerPhone.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@ID_Box1", txtEmployerMuncipal.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ID_Box2", txtERCounty.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ID_Box3", txtEmployerLocationPSDCode.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ID_Box4", txtEmployerWLNonResEITRate.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ID_Box5", txtEEPhone.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ID_Box6", txtEmail.Text)
            aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit_Dev", aryParams)
            sqlCon.CloseConn()

            divSuccess.Visible = True

            SecClass.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

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
