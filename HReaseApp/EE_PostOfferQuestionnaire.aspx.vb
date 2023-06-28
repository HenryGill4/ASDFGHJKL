Imports System.Data.SqlClient

Public Class EE_PostOfferQuestionnaire
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim c As New Company
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
        strScreenName = "EEPostOfferQuestionnaire"
        strScreenShortDesc = "Post Offer Questionnaire"

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
            lblMainArticleTitle.Text = sc.MainArticleTitle
            lblMainArticleText.Text = sc.MainArticleText
            imgNext.Visible = False

            If lblMainArticleText.Text = "" Then
                divText.Visible = False
            End If

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
        'Go Get Employee Compliance New York 1
        If ec.GetEmployeeInfo(intCompanyId, intEmployeeId) = True Then
            lblFirstName.Text = ec.FirstName
            lblLastName.Text = ec.LastName
        End If
        If c.GetCompanyInfo(intCompanyId, Session("UserId")) = True Then
            lblCompanyName.Text = c.LongDesc
            lblCompanyFullAddress.Text = c.Address1 + IIf(Len(c.Address2) > 0, ", " + c.Address2, "") + ", " + c.City + ", " + c.State + " " + c.Zip
        End If

        If ec.GetEmployeeFormResponses(intCompanyId, intEmployeeId, "EEPostOfferQuestionnaire") = True Then
            txtSignature.Text = ec.FormSignature
            txtSignatureDate.Text = IIf(ec.SignatureDate = "1/1/1900", Date.Now(), ec.SignatureDate)

            chkYes1.Checked = IIf(ec.Box1 = "1", True, False)
            chkNo1.Checked = IIf(ec.Box1 = "0", True, False)
            chkNotSerious1.Checked = IIf(ec.Box32 = "1", True, False)
            chkSerious1.Checked = IIf(ec.Box32 = "2", True, False)
            chkHadSurgery1.Checked = IIf(ec.Box32 = "3", True, False)

            chkYes2.Checked = IIf(ec.Box2 = "1", True, False)
            chkNo2.Checked = IIf(ec.Box2 = "0", True, False)
            chkNotSerious2.Checked = IIf(ec.Box33 = "1", True, False)
            chkSerious2.Checked = IIf(ec.Box33 = "2", True, False)
            chkHadSurgery2.Checked = IIf(ec.Box33 = "3", True, False)

            chkYes3.Checked = IIf(ec.Box3 = "1", True, False)
            chkNo3.Checked = IIf(ec.Box3 = "0", True, False)
            chkNotSerious3.Checked = IIf(ec.Box34 = "1", True, False)
            chkSerious3.Checked = IIf(ec.Box34 = "2", True, False)
            chkHadSurgery3.Checked = IIf(ec.Box34 = "3", True, False)

            chkYes4.Checked = IIf(ec.Box4 = "1", True, False)
            chkNo4.Checked = IIf(ec.Box4 = "0", True, False)
            Explain4.Text = ec.Box43

            chkYes5.Checked = IIf(ec.Box5 = "1", True, False)
            chkNo5.Checked = IIf(ec.Box5 = "0", True, False)
            Explain5.Text = ec.Box44

            chkYes6.Checked = IIf(ec.Box6 = "1", True, False)
            chkNo6.Checked = IIf(ec.Box6 = "0", True, False)
            Explain6.Text = ec.Box45

            chkYes7.Checked = IIf(ec.Box7 = "1", True, False)
            chkNo7.Checked = IIf(ec.Box7 = "0", True, False)
            chkSometimes7.Checked = IIf(ec.Box35 = "1", True, False)
            chkOften7.Checked = IIf(ec.Box35 = "2", True, False)

            chkYes8.Checked = IIf(ec.Box8 = "1", True, False)
            chkNo8.Checked = IIf(ec.Box8 = "0", True, False)
            chkSometimes8.Checked = IIf(ec.Box36 = "1", True, False)
            chkOften8.Checked = IIf(ec.Box36 = "2", True, False)
            chkMaybe8.Checked = IIf(ec.Box36 = "3", True, False)

            chkYes9.Checked = IIf(ec.Box9 = "1", True, False)
            chkNo9.Checked = IIf(ec.Box9 = "0", True, False)
            chkSometimes9.Checked = IIf(ec.Box37 = "1", True, False)
            chkOften9.Checked = IIf(ec.Box37 = "2", True, False)

            chkYes10.Checked = IIf(ec.Box10 = "1", True, False)
            chkNo10.Checked = IIf(ec.Box10 = "0", True, False)
            chkSometimes10.Checked = IIf(ec.Box38 = "1", True, False)
            chkOften10.Checked = IIf(ec.Box38 = "2", True, False)
            chkMaybe10.Checked = IIf(ec.Box38 = "3", True, False)

            chkYes11.Checked = IIf(ec.Box11 = "1", True, False)
            chkNo11.Checked = IIf(ec.Box11 = "0", True, False)
            chkSometimes11.Checked = IIf(ec.Box39 = "1", True, False)
            chkOften11.Checked = IIf(ec.Box39 = "2", True, False)

            chkYes12.Checked = IIf(ec.Box12 = "1", True, False)
            chkNo12.Checked = IIf(ec.Box12 = "0", True, False)
            chkSometimes12.Checked = IIf(ec.Box40 = "1", True, False)
            chkOften12.Checked = IIf(ec.Box40 = "2", True, False)
            chkMaybe12.Checked = IIf(ec.Box40 = "3", True, False)

            chkYes13.Checked = IIf(ec.Box13 = "1", True, False)
            chkNo13.Checked = IIf(ec.Box13 = "0", True, False)
            chkSometimes13.Checked = IIf(ec.Box41 = "1", True, False)
            chkOften13.Checked = IIf(ec.Box41 = "2", True, False)

            chkYes14.Checked = IIf(ec.Box14 = "1", True, False)
            chkNo14.Checked = IIf(ec.Box14 = "0", True, False)
            chkSometimes14.Checked = IIf(ec.Box42 = "1", True, False)
            chkOften14.Checked = IIf(ec.Box42 = "2", True, False)
            chkMaybe14.Checked = IIf(ec.Box42 = "3", True, False)

            txtDate15.Text = ec.Box15
            txtDate16.Text = ec.Box16
            txtDate17.Text = ec.Box17
            txtDate18.Text = ec.Box18
            txtDate19.Text = ec.Box19
            txtDate20.Text = ec.Box20
            txtDate21.Text = ec.Box21
            txtDate22.Text = ec.Box22
            txtDate23.Text = ec.Box23
            txtDate24.Text = ec.Box24
            txtDate25.Text = ec.Box25
            txtDate26.Text = ec.Box26
            txtDate27.Text = ec.Box27

            txtNumber28.Text = ec.Box28
            txtNumber29.Text = ec.Box29
            txtNumber30.Text = ec.Box30
            txtNumber31.Text = ec.Box31

            txtDetail47.Text = ec.Box47
            txtDetail48.Text = ec.Box48
            txtDetail49.Text = ec.Box49
            txtDetail50.Text = ec.Box50

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
        'Check for required fields
        If txtSignature.Text = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "You must enter a name for Signature to complete this form"
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If Trim(txtSignatureDate.Text) = "" Then
            divError.Visible = True
            divSuccess.Visible = False
            lblError.Text = "You must enter the date to complete this form"
            txtSignatureDate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False

            ResetScrollPosition()
            Exit Sub
        End If

        If txtSignature.Text <> "" And Trim(txtSignature.Text) <> "" Then
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

            imgProcessing.Visible = True

            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()

            objParam = New SqlParameter("@CompanyId", intCompanyId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EmployeeId", intEmployeeId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ScreenName", "EEPostOfferQuestionnaire")
            aryParams.Add(objParam)
            objParam = New SqlParameter("@FormSignature", txtSignature.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@SignatureDate", txtSignatureDate.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box1", IIf(chkYes1.Checked = True, "1", IIf(chkNo1.Checked = True, "0", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box2", IIf(chkYes2.Checked = True, "1", IIf(chkNo2.Checked = True, "0", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box3", IIf(chkYes3.Checked = True, "1", IIf(chkNo3.Checked = True, "0", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box4", IIf(chkYes4.Checked = True, "1", IIf(chkNo4.Checked = True, "0", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box5", IIf(chkYes5.Checked = True, "1", IIf(chkNo5.Checked = True, "0", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box6", IIf(chkYes6.Checked = True, "1", IIf(chkNo6.Checked = True, "0", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box7", IIf(chkYes7.Checked = True, "1", IIf(chkNo7.Checked = True, "0", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box8", IIf(chkYes8.Checked = True, "1", IIf(chkNo8.Checked = True, "0", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box9", IIf(chkYes9.Checked = True, "1", IIf(chkNo9.Checked = True, "0", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box10", IIf(chkYes10.Checked = True, "1", IIf(chkNo10.Checked = True, "0", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box11", IIf(chkYes11.Checked = True, "1", IIf(chkNo11.Checked = True, "0", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box12", IIf(chkYes12.Checked = True, "1", IIf(chkNo12.Checked = True, "0", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box13", IIf(chkYes13.Checked = True, "1", IIf(chkNo13.Checked = True, "0", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box14", IIf(chkYes14.Checked = True, "1", IIf(chkNo14.Checked = True, "0", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box15", txtDate15.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box16", txtDate16.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box17", txtDate17.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box18", txtDate18.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box19", txtDate19.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box20", txtDate20.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box21", txtDate21.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box22", txtDate22.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box23", txtDate23.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box24", txtDate24.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box25", txtDate25.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box26", txtDate26.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box27", txtDate27.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box28", txtNumber28.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box29", txtNumber29.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box30", txtNumber30.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box31", txtNumber31.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box32", IIf(chkNotSerious1.Checked = True, "1", IIf(chkSerious1.Checked = True, "2", IIf(chkHadSurgery1.Checked = True, "3", ""))))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box33", IIf(chkNotSerious2.Checked = True, "1", IIf(chkSerious2.Checked = True, "2", IIf(chkHadSurgery2.Checked = True, "3", ""))))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box34", IIf(chkNotSerious3.Checked = True, "1", IIf(chkSerious3.Checked = True, "2", IIf(chkHadSurgery3.Checked = True, "3", ""))))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box35", IIf(chkSometimes7.Checked = True, "1", IIf(chkOften7.Checked = True, "2", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box36", IIf(chkSometimes8.Checked = True, "1", IIf(chkOften8.Checked = True, "2", IIf(chkMaybe8.Checked = True, "3", ""))))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box37", IIf(chkSometimes9.Checked = True, "1", IIf(chkOften9.Checked = True, "2", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box38", IIf(chkSometimes10.Checked = True, "1", IIf(chkOften10.Checked = True, "2", IIf(chkMaybe10.Checked = True, "3", ""))))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box39", IIf(chkSometimes11.Checked = True, "1", IIf(chkOften11.Checked = True, "2", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box40", IIf(chkSometimes12.Checked = True, "1", IIf(chkOften12.Checked = True, "2", IIf(chkMaybe12.Checked = True, "3", ""))))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box41", IIf(chkSometimes13.Checked = True, "1", IIf(chkOften13.Checked = True, "2", "")))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box42", IIf(chkSometimes14.Checked = True, "1", IIf(chkOften14.Checked = True, "2", IIf(chkMaybe14.Checked = True, "3", ""))))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box43", Explain4.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box44", Explain5.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box45", Explain6.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box47", txtDetail47.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box48", txtDetail48.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box49", txtDetail49.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Box50", txtDetail47.Text)
            aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("usp_Employee_Form_Response_Edit", aryParams)
            sqlCon.CloseConn()

            divSuccess.Visible = True
            divError.Visible = False
            imgNext.Visible = True

            s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

            imgProcessing.Visible = False

        End If

        PopulateFields()
        ResetScrollPosition()

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

    Protected Sub chkYes1_CheckedChanged(sender As Object, e As EventArgs)
        If chkYes1.Checked = True Then
            chkNo1.Checked = False
        End If
    End Sub

    Protected Sub chkNo1_CheckedChanged(sender As Object, e As EventArgs)
        If chkNo1.Checked = True Then
            chkYes1.Checked = False
        End If
    End Sub

    Protected Sub chkNotSerious1_CheckedChanged(sender As Object, e As EventArgs)
        If chkNotSerious1.Checked = True Then
            chkSerious1.Checked = False
            chkHadSurgery1.Checked = False
        End If
    End Sub

    Protected Sub chkHadSurgery1_CheckedChanged(sender As Object, e As EventArgs)
        If chkHadSurgery1.Checked = True Then
            chkSerious1.Checked = False
            chkNotSerious1.Checked = False
        End If
    End Sub

    Protected Sub chkYes2_CheckedChanged(sender As Object, e As EventArgs)
        If chkYes2.Checked = True Then
            chkNo2.Checked = False
        End If
    End Sub

    Protected Sub chkNo2_CheckedChanged(sender As Object, e As EventArgs)
        If chkNo2.Checked = True Then
            chkYes2.Checked = False
        End If
    End Sub

    Protected Sub chkNotSerious2_CheckedChanged(sender As Object, e As EventArgs)
        If chkNotSerious2.Checked = True Then
            chkSerious2.Checked = False
            chkHadSurgery2.Checked = False
        End If
    End Sub

    Protected Sub chkSerious2_CheckedChanged(sender As Object, e As EventArgs)
        If chkSerious2.Checked = True Then
            chkNotSerious2.Checked = False
            chkHadSurgery2.Checked = False
        End If
    End Sub

    Protected Sub chkHadSurgery2_CheckedChanged(sender As Object, e As EventArgs)
        If chkHadSurgery2.Checked = True Then
            chkSerious2.Checked = False
            chkNotSerious2.Checked = False
        End If
    End Sub

    Protected Sub chkYes3_CheckedChanged(sender As Object, e As EventArgs)
        If chkYes3.Checked = True Then
            chkNo3.Checked = False
        End If
    End Sub

    Protected Sub chkNo3_CheckedChanged(sender As Object, e As EventArgs)
        If chkNo3.Checked = True Then
            chkYes3.Checked = False
        End If
    End Sub

    Protected Sub chkNotSerious3_CheckedChanged(sender As Object, e As EventArgs)
        If chkSerious3.Checked = True Then
            chkHadSurgery3.Checked = False
            chkNotSerious3.Checked = False
        End If
    End Sub

    Protected Sub chkSerious3_CheckedChanged(sender As Object, e As EventArgs)
        If chkSerious3.Checked = True Then
            chkNotSerious3.Checked = False
            chkHadSurgery3.Checked = False
        End If
    End Sub

    Protected Sub chkHadSurgery3_CheckedChanged(sender As Object, e As EventArgs)
        If chkHadSurgery3.Checked = True Then
            chkSerious3.Checked = False
            chkNotSerious3.Checked = False
        End If
    End Sub

    Protected Sub chkYes4_CheckedChanged(sender As Object, e As EventArgs)
        If chkYes4.Checked = True Then
            chkNo4.Checked = False
        End If
    End Sub

    Protected Sub chkNo4_CheckedChanged(sender As Object, e As EventArgs)
        If chkNo4.Checked = True Then
            chkYes4.Checked = False
        End If
    End Sub

    Protected Sub chkYes5_CheckedChanged(sender As Object, e As EventArgs)
        If chkYes5.Checked = True Then
            chkNo5.Checked = False
        End If
    End Sub

    Protected Sub chkNo5_CheckedChanged(sender As Object, e As EventArgs)
        If chkNo5.Checked = True Then
            chkYes5.Checked = False
        End If
    End Sub

    Protected Sub chkYes6_CheckedChanged(sender As Object, e As EventArgs)
        If chkYes6.Checked = True Then
            chkNo6.Checked = False
        End If
    End Sub

    Protected Sub chkNo6_CheckedChanged(sender As Object, e As EventArgs)
        If chkNo6.Checked = True Then
            chkYes6.Checked = False
        End If
    End Sub

    Protected Sub chkYes7_CheckedChanged(sender As Object, e As EventArgs)
        If chkYes7.Checked = True Then
            chkNo7.Checked = False
        End If
    End Sub

    Protected Sub chkSometimes7_CheckedChanged(sender As Object, e As EventArgs)
        If chkSometimes7.Checked = True Then
            chkOften7.Checked = False
        End If
    End Sub

    Protected Sub chkOften7_CheckedChanged(sender As Object, e As EventArgs)
        If chkOften7.Checked = True Then
            chkSometimes7.Checked = False
        End If
    End Sub

    Protected Sub chkYes8_CheckedChanged(sender As Object, e As EventArgs)
        If chkYes8.Checked = True Then
            chkNo8.Checked = False
        End If
    End Sub

    Protected Sub chkNo8_CheckedChanged(sender As Object, e As EventArgs)
        If chkNo8.Checked = True Then
            chkYes8.Checked = False
        End If
    End Sub

    Protected Sub chkSometimes8_CheckedChanged(sender As Object, e As EventArgs)
        If chkSometimes8.Checked = True Then
            chkOften8.Checked = False
            chkMaybe8.Checked = False
        End If
    End Sub

    Protected Sub chkOften8_CheckedChanged(sender As Object, e As EventArgs)
        If chkOften8.Checked = True Then
            chkSometimes8.Checked = False
            chkMaybe8.Checked = False
        End If
    End Sub

    Protected Sub chkMaybe8_CheckedChanged(sender As Object, e As EventArgs)
        If chkMaybe8.Checked = True Then
            chkOften8.Checked = False
            chkSometimes8.Checked = False
        End If
    End Sub

    Protected Sub chkYes9_CheckedChanged(sender As Object, e As EventArgs)
        If chkYes9.Checked = True Then
            chkNo9.Checked = False
        End If
    End Sub

    Protected Sub chkNo9_CheckedChanged(sender As Object, e As EventArgs)
        If chkNo9.Checked = True Then
            chkYes9.Checked = False
        End If
    End Sub

    Protected Sub chkSometimes9_CheckedChanged(sender As Object, e As EventArgs)
        If chkSometimes9.Checked = True Then
            chkOften9.Checked = False
        End If
    End Sub

    Protected Sub chkOften9_CheckedChanged(sender As Object, e As EventArgs)
        If chkOften9.Checked = True Then
            chkSometimes9.Checked = False
        End If
    End Sub

    Protected Sub chkYes10_CheckedChanged(sender As Object, e As EventArgs)
        If chkYes10.Checked = True Then
            chkNo10.Checked = False
        End If

    End Sub

    Protected Sub chkNo10_CheckedChanged(sender As Object, e As EventArgs)
        If chkNo10.Checked = True Then
            chkYes10.Checked = False
        End If
    End Sub

    Protected Sub chkSometimes10_CheckedChanged(sender As Object, e As EventArgs)
        If chkSometimes10.Checked = True Then
            chkOften10.Checked = False
            chkMaybe10.Checked = False
        End If
    End Sub

    Protected Sub chkOften10_CheckedChanged(sender As Object, e As EventArgs)
        If chkOften10.Checked = True Then
            chkSometimes10.Checked = False
            chkMaybe10.Checked = False
        End If
    End Sub

    Protected Sub chkMaybe10_CheckedChanged(sender As Object, e As EventArgs)
        If chkMaybe10.Checked = True Then
            chkOften10.Checked = False
            chkSometimes10.Checked = False
        End If
    End Sub

    Protected Sub chkYes11_CheckedChanged(sender As Object, e As EventArgs)
        If chkYes11.Checked = True Then
            chkNo11.Checked = False
        End If
    End Sub

    Protected Sub chkNo11_CheckedChanged(sender As Object, e As EventArgs)
        If chkNo11.Checked = True Then
            chkYes11.Checked = False
        End If
    End Sub

    Protected Sub chkSometimes11_CheckedChanged(sender As Object, e As EventArgs)
        If chkSometimes11.Checked = True Then
            chkOften11.Checked = False
        End If
    End Sub

    Protected Sub chkOften11_CheckedChanged(sender As Object, e As EventArgs)
        If chkOften11.Checked = True Then
            chkSometimes11.Checked = False
        End If
    End Sub

    Protected Sub chkYes12_CheckedChanged(sender As Object, e As EventArgs)
        If chkYes12.Checked = True Then
            chkNo12.Checked = False
        End If
    End Sub

    Protected Sub chkNo12_CheckedChanged(sender As Object, e As EventArgs)
        If chkNo12.Checked = True Then
            chkYes12.Checked = False
        End If
    End Sub

    Protected Sub chkSometimes12_CheckedChanged(sender As Object, e As EventArgs)
        If chkSometimes12.Checked = True Then
            chkOften12.Checked = False
            chkMaybe12.Checked = False
        End If
    End Sub

    Protected Sub chkOften12_CheckedChanged(sender As Object, e As EventArgs)
        If chkOften12.Checked = True Then
            chkMaybe12.Checked = False
            chkSometimes12.Checked = False
        End If
    End Sub

    Protected Sub chkMaybe12_CheckedChanged(sender As Object, e As EventArgs)
        If chkMaybe12.Checked = True Then
            chkOften12.Checked = False
            chkSometimes12.Checked = False
        End If
    End Sub

    Protected Sub chkYes13_CheckedChanged(sender As Object, e As EventArgs)
        If chkYes13.Checked = True Then
            chkNo13.Checked = False
        End If
    End Sub

    Protected Sub chkNo13_CheckedChanged(sender As Object, e As EventArgs)
        If chkNo13.Checked = True Then
            chkYes13.Checked = False
        End If
    End Sub

    Protected Sub chkSometimes13_CheckedChanged(sender As Object, e As EventArgs)
        If chkSometimes13.Checked = True Then
            chkOften13.Checked = False
        End If
    End Sub

    Protected Sub chkOften13_CheckedChanged(sender As Object, e As EventArgs)
        If chkOften13.Checked = True Then
            chkSometimes13.Checked = False
        End If
    End Sub

    Protected Sub chkYes14_CheckedChanged(sender As Object, e As EventArgs)
        If chkYes14.Checked = True Then
            chkNo14.Checked = False
        End If
    End Sub

    Protected Sub chkNo14_CheckedChanged(sender As Object, e As EventArgs)
        If chkNo14.Checked = True Then
            chkYes14.Checked = False
        End If
    End Sub

    Protected Sub chkSometimes14_CheckedChanged(sender As Object, e As EventArgs)
        If chkSometimes14.Checked = True Then
            chkOften14.Checked = False
        End If
    End Sub

    Protected Sub chkOften14_CheckedChanged(sender As Object, e As EventArgs)
        If chkOften14.Checked = True Then
            chkSometimes14.Checked = False
            chkMaybe14.Checked = False
        End If
    End Sub

    Protected Sub chkMaybe14_CheckedChanged(sender As Object, e As EventArgs)
        If chkMaybe14.Checked = True Then
            chkSometimes14.Checked = False
            chkOften14.Checked = False
        End If
    End Sub

End Class
