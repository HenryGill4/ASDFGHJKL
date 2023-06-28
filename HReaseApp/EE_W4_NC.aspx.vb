Imports System.Data.SqlClient

Public Class EE_W4_NC
    Inherits System.Web.UI.Page

    ReadOnly s As New Security
    ReadOnly sc As New ScreenConfiguration
    ReadOnly ec As New Employee

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer

    Dim strScreenName As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EEW4NC"

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
            s.SaveUserUpdate(Session("UserId"), strScreenName, "Browse", intEmployeeId, 0, 0, "01/01/1900", 0)

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
            'LabelMainArticleTitle.Text = sc.MainArticleTitle
            'LabelMainArticleText.Text = IIf(sc.MainArticleText = "", "Please complete form", sc.MainArticleText)
            imgNext.Visible = False

            PopulateFields()

        End If

        If Session("DataComplete") = "Yes" Then
            DivError.Visible = False
            DivSuccess.Visible = True
        Else
            DivSuccess.Visible = False
        End If

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")
        'btnPrint.Attributes.Add("Onclick", "divPrint();")
    End Sub

    Private Sub PopulateFields()
        'Get State W4 Info
        If ec.GetEmployeeW4Info(intEmployeeId, Now.Year(), Session("ScreenName")) = True Then
            Session("EmployeeW4Id") = ec.EmployeeW4Id

            LabelSSNumber.Text = ec.SSNwithDashes
            LabelFirstName.Text = ec.FirstName.ToUpper
            LabelMI.Text = ec.MiddleInitial.ToUpper
            LabelLastName.Text = ec.LastName.ToUpper
            LabelAddressCombined.Text = ec.AddressCombined.ToUpper
            LabelCity.Text = ec.City.ToUpper
            LabelState.Text = ec.State
            LabelZipCode.Text = ec.Zip
            LabelCountryNotUS.Text = IIf(ec.Country = "USA", "", ec.Country)

            chkSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            chkMarried.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)
            chkHeadOfHousehold.Checked = IIf(ec.TaxFilingStatusId = "4", True, False)

            TextTotalExemptions.Text = ec.TotalExemptions
            TextAdditionalWithholding.Text = ec.AdditionalWithholding

            TextSignature.Text = ec.W4_Signature
            SignatureDate.Text = IIf(ec.W4_SignatureDate <> "", ec.W4_SignatureDate, Date.Now())

            chkSingleYesOne.Checked = IIf(ec.PW_BoxA = "1", True, False)
            chkSingleNoOne.Checked = IIf(ec.PW_BoxA = "0", True, False)
            chkSingleYesTwo.Checked = IIf(ec.PW_BoxB = "1", True, False)
            chkSingleNoTwo.Checked = IIf(ec.PW_BoxB = "0", True, False)
            chkSingleYesThree.Checked = IIf(ec.PW_BoxC = "1", True, False)
            chkSingleNoThree.Checked = IIf(ec.PW_BoxC = "0", True, False)
            chkSingleYesFour.Checked = IIf(ec.PW_BoxD = "1", True, False)
            chkSingleNoFour.Checked = IIf(ec.PW_BoxD = "0", True, False)

            chkMarriedJointlyYesOne.Checked = IIf(ec.PW_BoxE = "1", True, False)
            chkMarriedJointlyNoOne.Checked = IIf(ec.PW_BoxE = "0", True, False)
            chkMarriedJointlyYesTwo.Checked = IIf(ec.PW_BoxF = "1", True, False)
            chkMarriedJointlyNoTwo.Checked = IIf(ec.PW_BoxF = "0", True, False)
            chkMarriedJointlyYesThree.Checked = IIf(ec.PW_BoxG = "1", True, False)
            chkMarriedJointlyNoThree.Checked = IIf(ec.PW_BoxG = "0", True, False)
            chkMarriedJointlyYesFour.Checked = IIf(ec.PW_BoxH = "1", True, False)
            chkMarriedJointlyNoFour.Checked = IIf(ec.PW_BoxH = "0", True, False)
            chkMarriedJointlyYesFive.Checked = IIf(ec.PW_BoxI = "1", True, False)
            chkMarriedJointlyNoFive.Checked = IIf(ec.PW_BoxI = "0", True, False)

            chkMarriedSeparatelyYesOne.Checked = IIf(ec.PW_BoxJ = "1", True, False)
            chkMarriedSeparatelyNoOne.Checked = IIf(ec.PW_BoxJ = "0", True, False)
            chkMarriedSeparatelyYesTwo.Checked = IIf(ec.PW_BoxK = "1", True, False)
            chkMarriedSeparatelyNoTwo.Checked = IIf(ec.PW_BoxK = "0", True, False)
            chkMarriedSeparatelyYesThree.Checked = IIf(ec.PW_BoxL = "1", True, False)
            chkMarriedSeparatelyNoThree.Checked = IIf(ec.PW_BoxL = "0", True, False)
            chkMarriedSeparatelyYesFour.Checked = IIf(ec.PW_BoxM = "1", True, False)
            chkMarriedSeparatelyNoFour.Checked = IIf(ec.PW_BoxM = "0", True, False)

            chkHeadHouseholdYesOne.Checked = IIf(ec.PW_BoxN = "1", True, False)
            chkHeadHouseholdNoOne.Checked = IIf(ec.PW_BoxN = "0", True, False)
            chkHeadHouseholdYesTwo.Checked = IIf(ec.PW_BoxO = "1", True, False)
            chkHeadHouseholdNoTwo.Checked = IIf(ec.PW_BoxO = "0", True, False)
            chkHeadHouseholdYesThree.Checked = IIf(ec.PW_BoxP = "1", True, False)
            chkHeadHouseholdNoThree.Checked = IIf(ec.PW_BoxP = "0", True, False)
            chkHeadHouseholdYesFour.Checked = IIf(ec.PW_BoxQ = "1", True, False)
            chkHeadHouseholdNoFour.Checked = IIf(ec.PW_BoxQ = "0", True, False)

            chkSurvivingSpouseYesOne.Checked = IIf(ec.PW_BoxR = "1", True, False)
            chkSurvivingSpouseNoOne.Checked = IIf(ec.PW_BoxR = "0", True, False)
            chkSurvivingSpouseYesTwo.Checked = IIf(ec.PW_BoxS = "1", True, False)
            chkSurvivingSpouseNoTwo.Checked = IIf(ec.PW_BoxS = "0", True, False)
            chkSurvivingSpouseYesThree.Checked = IIf(ec.PW_BoxT = "1", True, False)
            chkSurvivingSpouseNoThree.Checked = IIf(ec.PW_BoxT = "0", True, False)
            chkSurvivingSpouseYesFour.Checked = IIf(ec.PW_BoxU = "1", True, False)
            chkSurvivingSpouseNoFour.Checked = IIf(ec.PW_BoxU = "0", True, False)

            TextPartTwo1.Text = ec.TE_Box1
            TextPartTwo2.Text = ec.TE_Box2
            TextPartTwo3.Text = ec.TE_Box3
            TextPartTwo4.Text = ec.TE_Box4
            TextPartTwo5.Text = ec.TE_Box5
            TextPartTwo6.Text = ec.TE_Box6
            TextPartTwo7.Text = ec.TE_Box7
            TextPartTwo8.Text = ec.TE_Box8
            TextPartTwo9.Text = ec.TE_Box9
            TextPartTwo10.Text = ec.TE_Box10
            TextPartTwo11.Text = ec.TE_Box11
            TextPartTwo12.Text = ec.TE_Box12
            TextPartTwo13.Text = ec.TE_Box13
            TextPartTwo14.Text = ec.TE_Box14
            TextPartTwo15.Text = ec.TE_Box15
            TextPartTwo16.Text = ec.ID_Box1
            TextPartTwo17.Text = ec.ID_Box2

            TextSchedule1One.Text = ec.ID_Box3
            TextSchedule1Two.Text = ec.ID_Box4
            TextSchedule1Three.Text = ec.ID_Box5
            TextSchedule1Four.Text = ec.ID_Box6
            TextSchedule1Five.Text = ec.ID_Box7
            TextSchedule1Six.Text = ec.ID_Box8
            TextSchedule1Seven.Text = ec.ID_Box9

            TextSchedule2SingleChildren1.Text = Session("NoMapping")
            TextSchedule2SingleDeduction1.Text = Session("NoMapping")
            TextSchedule2SingleChildren2.Text = Session("NoMapping")
            TextSchedule2SingleDeduction2.Text = Session("NoMapping")
            TextSchedule2SingleChildren3.Text = Session("NoMapping")
            TextSchedule2SingleDeduction3.Text = Session("NoMapping")
            TextSchedule2SingleChildren4.Text = Session("NoMapping")
            TextSchedule2SingleDeduction4.Text = Session("NoMapping")
            TextSchedule2SingleChildren5.Text = Session("NoMapping")
            TextSchedule2SingleDeduction5.Text = Session("NoMapping")
            TextSchedule2SingleChildren6.Text = Session("NoMapping")
            TextSchedule2SingleDeduction6.Text = Session("NoMapping")
            TextSchedule2SingleChildren7.Text = Session("NoMapping")
            TextSchedule2SingleDeduction7.Text = Session("NoMapping")

            TextSchedule2MFJorSSChildren1.Text = Session("NoMapping")
            TextSchedule2MFJorSSDeduction1.Text = Session("NoMapping")
            TextSchedule2MFJorSSChildren2.Text = Session("NoMapping")
            TextSchedule2MFJorSSDeduction2.Text = Session("NoMapping")
            TextSchedule2MFJorSSChildren3.Text = Session("NoMapping")
            TextSchedule2MFJorSSDeduction3.Text = Session("NoMapping")
            TextSchedule2MFJorSSChildren4.Text = Session("NoMapping")
            TextSchedule2MFJorSSDeduction4.Text = Session("NoMapping")
            TextSchedule2MFJorSSChildren5.Text = Session("NoMapping")
            TextSchedule2MFJorSSDeduction5.Text = Session("NoMapping")
            TextSchedule2MFJorSSChildren6.Text = Session("NoMapping")
            TextSchedule2MFJorSSDeduction6.Text = Session("NoMapping")
            TextSchedule2MFJorSSChildren7.Text = Session("NoMapping")
            TextSchedule2MFJorSSDeduction7.Text = Session("NoMapping")

            TextSchedule2HOHSChildren1.Text = Session("NoMapping")
            TextSchedule2HOHDeduction1.Text = Session("NoMapping")
            TextSchedule2HOHSChildren2.Text = Session("NoMapping")
            TextSchedule2HOHDeduction2.Text = Session("NoMapping")
            TextSchedule2HOHSChildren3.Text = Session("NoMapping")
            TextSchedule2HOHDeduction3.Text = Session("NoMapping")
            TextSchedule2HOHSChildren4.Text = Session("NoMapping")
            TextSchedule2HOHDeduction4.Text = Session("NoMapping")
            TextSchedule2HOHSChildren5.Text = Session("NoMapping")
            TextSchedule2HOHDeduction5.Text = Session("NoMapping")
            TextSchedule2HOHSChildren6.Text = Session("NoMapping")
            TextSchedule2HOHDeduction6.Text = Session("NoMapping")
            TextSchedule2HOHSChildren7.Text = Session("NoMapping")
            TextSchedule2HOHDeduction7.Text = Session("NoMapping")

            TextSchedule2MFSChildren1.Text = Session("NoMapping")
            TextSchedule2MFSDeduction1.Text = Session("NoMapping")
            TextSchedule2MFSChildren2.Text = Session("NoMapping")
            TextSchedule2MFSDeduction2.Text = Session("NoMapping")
            TextSchedule2MFSChildren3.Text = Session("NoMapping")
            TextSchedule2MFSDeduction3.Text = Session("NoMapping")
            TextSchedule2MFSChildren4.Text = Session("NoMapping")
            TextSchedule2MFSDeduction4.Text = Session("NoMapping")
            TextSchedule2MFSChildren5.Text = Session("NoMapping")
            TextSchedule2MFSDeduction5.Text = Session("NoMapping")
            TextSchedule2MFSChildren6.Text = Session("NoMapping")
            TextSchedule2MFSDeduction6.Text = Session("NoMapping")
            TextSchedule2MFSChildren7.Text = Session("NoMapping")
            TextSchedule2MFSDeduction7.Text = Session("NoMapping")


        End If

    End Sub
    Private Sub Save()
        'Check for required fields
        If chkSingle.Checked = False And chkMarried.Checked = False And chkHeadOfHousehold.Checked = False Then
            DivError.Visible = True
            DivSuccess.Visible = False
            chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkHeadOfHousehold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            LabelError.Text = "Please Enter Filing Status"
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(TextTotalExemptions.Text) = "" Then
            DivError.Visible = True
            DivSuccess.Visible = False
            LabelError.Text = "Enter Total number of allowances"
            TextTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(TextSignature.Text) = "" Then
            DivError.Visible = True
            DivSuccess.Visible = False
            LabelError.Text = "This form is not valid unless signed"
            TextSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ResetScrollPosition()
            Exit Sub
        End If

        If (chkSingle.Checked = True Or chkMarried.Checked = True Or chkHeadOfHousehold.Checked = True) Then
            If Trim(TextTotalExemptions.Text) <> "" Then
                If Trim(TextSignature.Text) <> "" Then

                    DivError.Visible = False

                    chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkHeadOfHousehold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    TextTotalExemptions.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
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

                    objParam = New SqlParameter("@TaxFilingStatusId", IIf(chkSingle.Checked = True, "1",
                                                                          IIf(chkMarried.Checked = True, "2",
                                                                              IIf(chkHeadOfHousehold.Checked = True, "4", ""))))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TotalExemptions", TextTotalExemptions.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@AdditionalWithholding", TextAdditionalWithholding.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", TextSignature.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@PW_BoxA", IIf(chkSingleYesOne.Checked = True, "1", IIf(chkSingleNoOne.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxB", IIf(chkSingleYesTwo.Checked = True, "1", IIf(chkSingleNoTwo.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxC", IIf(chkSingleYesThree.Checked = True, "1", IIf(chkSingleNoThree.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxD", IIf(chkSingleYesFour.Checked = True, "1", IIf(chkSingleNoFour.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxE", IIf(chkMarriedJointlyYesOne.Checked = True, "1", IIf(chkMarriedJointlyNoOne.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxF", IIf(chkMarriedJointlyYesTwo.Checked = True, "1", IIf(chkMarriedJointlyNoTwo.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxG", IIf(chkMarriedJointlyYesThree.Checked = True, "1", IIf(chkMarriedJointlyNoThree.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxH", IIf(chkMarriedJointlyYesFour.Checked = True, "1", IIf(chkMarriedJointlyNoFour.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxI", IIf(chkMarriedJointlyYesFive.Checked = True, "1", IIf(chkMarriedJointlyNoFive.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxJ", IIf(chkMarriedSeparatelyYesOne.Checked = True, "1", IIf(chkMarriedSeparatelyNoOne.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxK", IIf(chkMarriedSeparatelyYesTwo.Checked = True, "1", IIf(chkMarriedSeparatelyNoTwo.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxL", IIf(chkMarriedSeparatelyYesThree.Checked = True, "1", IIf(chkMarriedSeparatelyNoThree.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxM", IIf(chkMarriedSeparatelyYesFour.Checked = True, "1", IIf(chkMarriedSeparatelyNoFour.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxN", IIf(chkHeadHouseholdYesOne.Checked = True, "1", IIf(chkHeadHouseholdNoOne.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxO", IIf(chkHeadHouseholdYesTwo.Checked = True, "1", IIf(chkHeadHouseholdNoTwo.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxP", IIf(chkHeadHouseholdYesThree.Checked = True, "1", IIf(chkHeadHouseholdNoThree.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxQ", IIf(chkHeadHouseholdYesFour.Checked = True, "1", IIf(chkHeadHouseholdNoFour.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxR", IIf(chkSurvivingSpouseYesOne.Checked = True, "1", IIf(chkSurvivingSpouseNoOne.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxS", IIf(chkSurvivingSpouseYesTwo.Checked = True, "1", IIf(chkSurvivingSpouseNoTwo.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxT", IIf(chkSurvivingSpouseYesThree.Checked = True, "1", IIf(chkSurvivingSpouseNoThree.Checked = True, "0", "")))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxU", IIf(chkSurvivingSpouseYesFour.Checked = True, "1", IIf(chkSurvivingSpouseNoFour.Checked = True, "0", "")))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TE_Box1", TextPartTwo1.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box2", TextPartTwo2.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box3", TextPartTwo3.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box4", TextPartTwo4.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box5", TextPartTwo5.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box6", TextPartTwo6.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box7", TextPartTwo7.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box8", TextPartTwo8.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box9", TextPartTwo9.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box10", TextPartTwo10.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box11", TextPartTwo11.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box12", TextPartTwo12.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box13", TextPartTwo13.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box14", TextPartTwo14.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@TE_Box15", TextPartTwo15.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box1", TextPartTwo16.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box2", TextPartTwo17.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@ID_Box3", TextSchedule1One.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box4", TextSchedule1Two.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box5", TextSchedule1Three.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box6", TextSchedule1Four.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box7", TextSchedule1Five.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box8", TextSchedule1Six.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box9", TextSchedule1Seven.Text)
                    aryParams.Add(objParam)

                    objDataSet = sqlCon.CreateDataSet("usp_Employee_W4_Edit", aryParams)
                    sqlCon.CloseConn()

                    DivSuccess.Visible = True

                    s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", 0)

                End If
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