Imports System.Data.SqlClient

Public Class EE_W4_MN
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
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
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EEW4MN"

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

            txtIDBox1.Text = IIf(ec.ID_Box1 = "", 0, ec.ID_Box1)
            txtIDBox2.Text = IIf(ec.ID_Box2 = "", 0, ec.ID_Box2)
            txtIDBox3.Text = IIf(ec.ID_Box3 = "", 0, ec.ID_Box3)
            txtIDBox4.Text = IIf(ec.ID_Box4 = "", 0, ec.ID_Box4)
            txtIDBox5.Text = IIf(ec.ID_Box5 = "", 0, ec.ID_Box5)
            txtIDBox6.Text = IIf(ec.ID_Box6 = "", 0, ec.ID_Box6)
            txtIDBox7.Text = IIf(ec.ID_Box7 = "", 0, ec.ID_Box7)
            txtIDBox8.Text = IIf(ec.ID_Box8 = "", 0, ec.ID_Box8)
            txtIDBox9.Text = IIf(ec.ID_Box9 = "", 0, ec.ID_Box9)
            txtIDBox10.Text = IIf(ec.ID_Box10 = "", 0, ec.ID_Box10)

            lblFName.Text = ec.FirstName
            lblLName.Text = ec.LastName
            lblSSNumber.Text = ec.SSNwithDashes
            lblAddressCombined.Text = ec.AddressCombined
            lblCity.Text = ec.City
            lblState.Text = ec.State
            lblZipCode.Text = ec.Zip

            chkSingle.Checked = IIf(ec.TaxFilingStatusId = "1", True, False)
            chkMarried.Checked = IIf(ec.TaxFilingStatusId = "2", True, False)
            chkMarriedWithhold.Checked = IIf(ec.TaxFilingStatusId = "10", True, False)

            txtTotalExemptions.Text = ec.TotalExemptions
            txtAdditionalWithholding.Text = ec.AdditionalWithholding

            chkHeaderSection1.Checked = IIf(ec.W4_Box1 = "1", True, False)
            chkHeaderSection2.Checked = IIf(ec.Exempt = "1", True, False)

            txtA.Text = IIf(ec.W4_Box2 = "", 0, ec.W4_Box2)
            txtB.Text = IIf(ec.W4_Box3 = "", 0, ec.W4_Box3)
            txtC.Text = IIf(ec.W4_Box4 = "", 0, ec.W4_Box4)
            txtNumberOfDependents.Text = IIf(ec.W4_Box10 = "", 0, ec.W4_Box10)
            txtE.Text = IIf(ec.W4_Box5 = "", 0, ec.W4_Box5)

            If txtA.Text <> "" Or txtB.Text <> "" Or txtC.Text <> "" Or txtNumberOfDependents.Text <> "" Or txtE.Text <> "" Then
                Dim a As String = IIf(ec.W4_Box2 = "", 0, ec.W4_Box2)
                Dim ai As Integer = Integer.Parse(a)
                Dim b As String = IIf(ec.W4_Box3 = "", 0, ec.W4_Box3)
                Dim bi As Integer = Integer.Parse(b)
                Dim c As String = IIf(ec.W4_Box4 = "", 0, ec.W4_Box4)
                Dim ci As Integer = Integer.Parse(c)
                Dim d As String = IIf(ec.W4_Box10 = "", 0, ec.W4_Box10)
                Dim di As Integer = Integer.Parse(d)
                Dim e As String = IIf(ec.W4_Box5 = "", 0, ec.W4_Box5)
                Dim ei As Integer = Integer.Parse(e)

                txtF.Text = ai + bi + ci + di + ei

            End If

            If txtIDBox9.Text = "" Then
                If txtF.Text <> "" Then
                    Dim f As Integer
                    txtIDBox9.Text = f
                Else
                    Dim b9i As Integer = 0
                    txtIDBox9.Text = b9i

                End If
            End If

            txtMilitaryState.Text = ec.W4_Box7

            txtSignature.Text = ec.W4_Signature
            txtSignatureDate.Text = IIf(ec.W4_SignatureDate = "", Date.Now, ec.W4_SignatureDate)

            chkExemptA.Checked = IIf(ec.PW_BoxA = "1", True, False)
            chkExemptB.Checked = IIf(ec.PW_BoxB = "1", True, False)
            chkExemptC.Checked = IIf(ec.PW_BoxC = "1", True, False)
            chkExemptD.Checked = IIf(ec.PW_BoxD = "1", True, False)
            chkExemptE.Checked = IIf(ec.PW_BoxE = "1", True, False)
            chkExemptF.Checked = IIf(ec.PW_BoxF = "1", True, False)

            lblEmployerFullName.Text = ec.CompanyName
            lblEmployerFEIN.Text = ec.CompanyFEIN
            lblEmployerMinnesotaTaxIDNo.Text = ""
            lblEmployerAddress.Text = ec.CompanyAddress1 + " " + IIf(Len(ec.CompanyAddress2) > 0, ec.CompanyAddress2, "")
            lblEmployerCity.Text = ec.CompanyCity
            lblEmployerState.Text = ec.CompanyState
            lblEmployerZipCode.Text = ec.CompanyZip

        End If

    End Sub

    Private Sub Save()
        'Check for required fields
        If chkSingle.Checked = False And chkMarried.Checked = False And chkMarriedWithhold.Checked = False Then
            divError.Visible = True
            chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkMarriedWithhold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            lblError.Text = "Please enter Marital Status"
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If
        If chkHeaderSection1.Checked = False And chkHeaderSection2.Checked = False Then
            divError.Visible = True
            lblError.Text = "Please enter data in Section 1 or claim Exemption in Section 2."
            chkHeaderSection1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            chkHeaderSection2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If
        If Trim(txtSignature.Text) = "" Then
            divError.Visible = True
            lblError.Text = "This form is not valid unless signed"
            txtSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            imgNext.Visible = False
            ResetScrollPosition()
            Exit Sub
        End If

        If chkSingle.Checked = True Or chkMarried.Checked = True Or chkMarriedWithhold.Checked = True Then
            If chkHeaderSection1.Checked = True Or chkHeaderSection2.Checked = True Then
                If Trim(txtSignature.Text) <> "" Then

                    chkSingle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarried.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkMarriedWithhold.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkHeaderSection1.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                    chkHeaderSection2.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
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

                    objParam = New SqlParameter("@ID_Box1", txtIDBox1.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box2", txtIDBox2.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box3", txtIDBox3.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box4", txtIDBox4.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box5", txtIDBox5.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box6", txtIDBox6.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box7", txtIDBox7.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box8", txtIDBox8.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box9", txtIDBox9.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@ID_Box10", txtIDBox10.Text)
                    aryParams.Add(objParam)

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
                                                                                  IIf(chkMarriedWithhold.Checked = True, "10",
                                                                                      ""))))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@TotalExemptions", txtTotalExemptions.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@AdditionalWithholding", txtAdditionalWithholding.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@Exempt", IIf(chkHeaderSection2.Checked = True, 1, 0))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@MilitarySpouseRelief", IIf(chkExemptC.Checked = True, 1, 0))
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Signature", txtSignature.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_SignatureDate", Date.Now)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@W4_Box1", IIf(chkHeaderSection1.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box2", txtA.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box3", txtB.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box4", txtC.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box5", txtE.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box6", txtF.Text)
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@W4_Box10", txtNumberOfDependents.Text)
                    aryParams.Add(objParam)

                    objParam = New SqlParameter("@PW_BoxA", IIf(chkExemptA.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxB", IIf(chkExemptB.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxC", IIf(chkExemptC.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxD", IIf(chkExemptD.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxE", IIf(chkExemptE.Checked = True, "1", "0"))
                    aryParams.Add(objParam)
                    objParam = New SqlParameter("@PW_BoxF", IIf(chkExemptF.Checked = True, "1", "0"))
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
