Imports System.Data.SqlClient

Public Class EE_W4_CO
    Inherits System.Web.UI.Page

    ReadOnly s As New Security
    ReadOnly sc As New ScreenConfiguration
    ReadOnly ec As New Employee

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
        strScreenName = "EEW4CO"

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

            DivError.Visible = False

        End If

        If Session("DataComplete") = "Yes" Then
            DivError.Visible = False
            DivSuccess.Visible = True
            imgNext.Visible = True
        Else
            DivSuccess.Visible = False
            imgNext.Visible = False
        End If

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")
        'btnPrint.Attributes.Add("Onclick", "divPrint();")

    End Sub

    Private Sub PopulateFields()
        'Get State W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id

            LabelLastName.Text = ec.LastName
            LabelFirstName.Text = ec.FirstName
            LabelMiddleInitial.Text = ec.MiddleInitial
            LabelMailingAddress.Text = ec.AddressCombined
            LabelSSN.Text = ec.SSNwithDashes
            LabelCity.Text = ec.City
            LabelState.Text = ec.State
            LabelZip.Text = ec.Zip

            TextAdditionalWithholding.Text = ec.AdditionalWithholding
            TextWithholdingAllowance.Text = ec.W4_Box1

            TextSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate <> "", ec.W4_SignatureDate, Date.Now())

            TextWorksheet1Q1.Text = ec.PW_BoxA
            TextWorksheet1Q2.Text = ec.PW_BoxB
            TextWorksheet1Q3.Text = ec.PW_BoxC
            TextWorksheet1Q4.Text = ec.PW_BoxD
            TextWorksheet1Q5.Text = ec.PW_BoxE
            TextWorksheet1Q6.Text = ec.PW_BoxF
            TextWorksheet1Q7.Text = ec.PW_BoxG

            TextWorksheet2Q1.Text = ec.PW_BoxH
            TextWorksheet2Q2.Text = ec.PW_BoxI
            TextWorksheet2Q3.Text = ec.PW_BoxJ
            TextWorksheet2Q4.Text = ec.PW_BoxK
            TextWorksheet2Q5.Text = ec.PW_BoxL
            TextWorksheet2Q6.Text = ec.PW_BoxM


        End If

    End Sub

    Private Sub Save()
        'Check for required fields
        If Trim(TextSignature.Text) = "" Then
            DivError.Visible = True
            LabelError.Text = "This form is not valid unless signed"
            TextSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If

        If Trim(TextSignature.Text) <> "" Then

            DivError.Visible = False

            TextSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")


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

            objParam = New SqlParameter("@AdditionalWithholding", TextAdditionalWithholding.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@W4_Signature", TextSignature.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@W4_Box1", TextWithholdingAllowance.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@PW_BoxA", TextWorksheet1Q1.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@PW_BoxB", TextWorksheet1Q2.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@PW_BoxC", TextWorksheet1Q3.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@PW_BoxD", TextWorksheet1Q4.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@PW_BoxE", TextWorksheet1Q5.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@PW_BoxF", TextWorksheet1Q6.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@PW_BoxG", TextWorksheet1Q7.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@PW_BoxH", TextWorksheet2Q1.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@PW_BoxI", TextWorksheet2Q2.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@PW_BoxJ", TextWorksheet2Q3.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@PW_BoxK", TextWorksheet2Q4.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@PW_BoxL", TextWorksheet2Q5.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@PW_BoxM", TextWorksheet2Q6.Text)
            aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit", aryParams)
            sqlCon.CloseConn()

            DivSuccess.Visible = True

            s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

        End If

        PopulateFields()
        ResetScrollPosition()

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