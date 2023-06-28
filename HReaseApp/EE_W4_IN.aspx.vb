Imports System.Data.SqlClient

Public Class EE_W4_IN
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer

    Dim strScreenName As String
    Dim strDisplayName As String
    Dim strAdminName As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EEW4IN"

        If Session("Admin") = True Then
            intCompanyId = Session("ShadowCompanyId")
            intEmployeeId = Session("ShadowEmployeeId")
            strDisplayName = Session("AdminName")
            Session("DisplayName") = Session("AdminName")

        Else
            strDisplayName = Session("EmployeeName")
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

        strDisplayName = Session("DisplayName")

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")
        'btnPrint.Attributes.Add("Onclick", "divPrint();")


    End Sub

    Private Sub PopulateFields()
        'Get State W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id

            LabelFullName.Text = ec.EmployeeFullName
            LabelSSNumber.Text = ec.SSNwithDashes
            LabelHomeAddress.Text = ec.AddressCombined
            LabelCity.Text = ec.City
            LabelState.Text = ec.State
            LabelZip.Text = ec.Zip

            TextCountyOfResidence.Text = ec.ID_Box1
            TextCountyOfEmployment.Text = ec.ID_Box2

            TextBox1.Text = ec.W4_Box1
            TextBox2.Text = ec.W4_Box2
            TextBox3.Text = ec.W4_Box3
            TextBox4.Text = ec.W4_Box4

            CheckboxOver65.Checked = IIf(ec.ID_Box3 = "1", True, False)
            CheckboxBlind.Checked = IIf(ec.ID_Box4 = "1", True, False)
            CheckboxSpouse65.Checked = IIf(ec.ID_Box5 = "1", True, False)
            CheckboxSpouseBlind.Checked = IIf(ec.ID_Box6 = "1", True, False)

            TextBox5.Text = ec.TotalExemptions
            TextBox6.Text = ec.W4_Box6
            TextBox7.Text = ec.AdditionalWithholding
            TextBox8.Text = ec.W4_Box8

            TextSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now(), ec.W4_SignatureDate)

        End If

    End Sub

    Private Sub Save()
        If Trim(TextBox5.Text) = "" Then
            DivError.Visible = True
            DivSuccess.Visible = False
            TextBox5.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            LabelError.Text = "Please enter a number on Line 5"
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(TextSignature.Text) = "" Then
            DivError.Visible = True
            DivSuccess.Visible = False
            LabelError.Text = "This form is not valid unless signed"
            TextSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If Trim(TextBox5.Text) <> "" Then
            If Trim(TextSignature.Text) <> "" Then

                DivError.Visible = False

                TextBox5.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
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

                objParam = New SqlParameter("@ID_Box1", TextCountyOfResidence.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box2", TextCountyOfEmployment.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Box1", TextBox1.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box2", TextBox2.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box3", TextBox3.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box4", TextBox4.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@TotalExemptions", TextBox5.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box6", TextBox6.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@AdditionalWithholding", TextBox7.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_Box8", TextBox8.Text)
                aryParams.Add(objParam)

                objParam = New SqlParameter("@ID_Box3", IIf(CheckboxOver65.Checked = True, "1", "0"))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box4", IIf(CheckboxBlind.Checked = True, "1", "0"))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box5", IIf(CheckboxSpouse65.Checked = True, "1", "0"))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ID_Box6", IIf(CheckboxSpouseBlind.Checked = True, "1", "0"))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@W4_Signature", TextSignature.Text)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                aryParams.Add(objParam)


                objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit", aryParams)
                sqlCon.CloseConn()

                DivSuccess.Visible = True

                s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

            End If
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