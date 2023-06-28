Imports System.Data.SqlClient

Public Class EE_I9
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer
    Dim intUserId As Integer

    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Dim bError As Boolean

    Dim strDateTimeStamp As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EEI9"
        strScreenShortDesc = "I-9 Form"

        intUserId = Session("UserId")

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
            s.SaveUserUpdate(intUserId, strScreenName, "Browse", intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

            If sc.GetNavigation(intUserId, intEmployeeId, strScreenName, 0) = True Then
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
            sc.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            lblMainArticleTitle.Text = sc.MainArticleTitle
            lblMainArticleText.Text = sc.MainArticleText
            imgNext.Visible = False

            If lblMainArticleTitle.Text = "" And lblMainArticleText.Text = "" Then
                divMainArticalTitleandText.Visible = False
            End If
            If lblMainArticleTitle.Text = "" Then
                divTitle.Visible = False
            End If
            If lblMainArticleText.Text = "" Then
                divText.Visible = False
            End If

            ec.LoadState(ddlPRState)

            ec.LoadCountry(ddlCountryofIssuance)
            ddlCountryofIssuance.Items.Insert(0, New ListItem(""))
            ddlPermResidentType.Items.Insert(0, New ListItem(""))
            ddlPermResidentType2.Items.Insert(0, New ListItem(""))
            ddlPRState.Items.Insert(0, New ListItem(""))

            'hide all info and error sections
            divError.Visible = False
            divSuccess.Visible = False
            divEEDemoError.Visible = False
            divEECheckboxError.Visible = False
            divPermResError.Visible = False
            divEEAlienError.Visible = False
            divEESignatureError.Visible = False
            divEEPreparerError.Visible = False
            divERSection2ErrorTop.Visible = False
            divERSection2ErrorBottom.Visible = False
            divERSection3Error.Visible = False

            If Session("Admin") = False Then
                divSection2.Visible = False
                divSection3.Visible = False
            End If

            PopulateFields()

        End If

        CheckRequiredEmployeeInfo()

        If Session("DataComplete") = "Yes" Then
            divSuccess.Visible = True
            imgNext.Visible = True
        Else
            divSuccess.Visible = False
            imgNext.Visible = False

        End If

        btnSave_Section1.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSave_Section1, "") + ";this.src='/img/processing.gif';")
        btnSave_Section2.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSave_Section2, "") + ";this.src='/img/processing.gif';")
        btnSave_Section3.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSave_Section3, "") + ";this.src='/img/processing.gif';")
        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateFields()
        'Get Employee Existing I9 Info
        If ec.GetEmployeeI9Info(intEmployeeId, intUserId) = True Then
            If ec.Address1 = "" Or ec.SSN = "" Or ec.BirthDate = "" Or ec.BirthDate = "01/01/1900" Then
                lblError.Text = "Please enter required data on Profile page before completing this form."
                divError.Visible = True
                divSuccess.Visible = False
                imgNext.Visible = False
                ResetScrollPosition()
                Exit Sub
            Else
                strDateTimeStamp = ec.DateTimeStamp
                Session("DateTimeStamp") = strDateTimeStamp

                Session("EmployeeI9Id") = ec.EmployeeI9Id
                'Section 1
                lblFirstName.Text = ec.FirstName
                lblLastName.Text = ec.LastName
                lblMiddleInit.Text = IIf(ec.MiddleName = "", "N/A", ec.MiddleName)
                lblAddress1.Text = ec.Address1
                lblAddress2.Text = IIf(ec.Address2 = "", "N/A", ec.Address2)
                lblCity.Text = ec.City
                lblState.Text = ec.State
                lblZip.Text = ec.Zip
                lblDOB.Text = ec.BirthDate
                lblSSN.Text = ec.SSN
                lblEmail.Text = IIf(ec.Email1 = "", "N/A", ec.Email1)
                lblPhone.Text = IIf(ec.HomePhone = "", "N/A", IIf(ec.MobilePhone = "", "N/A", ec.MobilePhone))

                chkCitizen.Checked = ec.S1_Citizen
                chkNonCitizen.Checked = ec.S1_NonCitizenNational
                chkPermResident.Checked = ec.S1_PermanentResident
                txtPermResidentNumber.Text = IIf(ec.S1_PermanentResident = True, ec.S1_PermanentResidentNumber, "")
                ddlPermResidentType.SelectedValue = IIf(ec.S1_PermanentResident = True And ec.S1_PermResidentType <> "", ec.S1_PermResidentType, "N/A")
                ddlPermResidentType2.SelectedValue = IIf(ec.S1_Alien = True And ec.S1_PermResidentType <> "", ec.S1_PermResidentType, "N/A")
                chkTempVisa.Checked = ec.S1_Alien
                txtTempVisaDate.Text = IIf(ec.S1_Alien = True And ec.S1_AlienExpDate <> "01/01/1900", ec.S1_AlienExpDate, "")
                txtAlienNumber.Text = IIf(ec.S1_Alien = True, ec.S1_AlienNumber, "")
                txtAdmissionNumber.Text = IIf(ec.S1_Alien = True, ec.S1_Form94Number, "")
                txtPassportNumber.Text = IIf(ec.S1_Alien = True, ec.S1_ForiegnPassportNumber, "")

                ddlCountryofIssuance.SelectedValue = IIf(ec.S1_Alien = True, ec.S1_CountryofIssuance, "")

                txtEmployeeSignature.Text = ec.S1_EESignature
                txtEmployeeSignatureDate.Text = IIf(ec.S1_EESignatureDate = "", ec.DateTimeStamp, ec.S1_EESignatureDate)

                chkNoPreparer.Checked = IIf(ec.S1_UsedPreparer = True, False, True)
                chkUsedPreparer.Checked = ec.S1_UsedPreparer

                txtPRSignature.Text = ec.S1_PRSignature
                txtPRSignatureDate.Text = IIf(chkUsedPreparer.Checked = True And ec.S1_PRSignatureDate = "", ec.DateTimeStamp,
                                              IIf(chkUsedPreparer.Checked = True And ec.S1_PRSignatureDate <> "", ec.S1_PRSignatureDate,
                                                  ""))
                txtPRLastName.Text = ec.S1_PRLastName
                txtPRFirstName.Text = ec.S1_PRFirstName
                txtPRAddress.Text = ec.S1_PRAddress
                txtPRCity.Text = ec.S1_PRCity
                ddlPRState.SelectedValue = ec.S1_PRState
                txtPRZip.Text = ec.S1_PRZipCode

                'Section 2
                If Session("Admin") = True Then
                    PopulateDocumentDropDowns()

                    lblEEFirstName.Text = lblFirstName.Text
                    lblEELastName.Text = lblLastName.Text
                    lblEEMI.Text = lblMiddleInit.Text
                    lblCitizenship.Text = IIf(chkCitizen.Checked = True, "US", IIf(chkNonCitizen.Checked = True, "Non Citizen National",
                                                                                   IIf(chkPermResident.Checked = True, "Permanent Resident",
                                                                                       IIf(chkTempVisa.Checked = True, "Alien Authorized to Work",
                                                                                           ""))))
                    ' txtListADocument1.Text = ec.S2_A1DocumentTitle
                    If ddlListADocument.Items.FindByText(ec.S2_A1DocumentTitle) Is Nothing Then
                        ' do what the Exception is supposed to do '
                        ddlListADocument.SelectedIndex = 0
                    Else
                        ddlListADocument.SelectedIndex = ddlListADocument.Items.IndexOf(ddlListADocument.Items.FindByText(ec.S2_A1DocumentTitle))
                    End If
                    txtListAAuthority.Text = ec.S2_A1IssuedBy
                    txtListADocNum1.Text = ec.S2_A1DocumentNumber
                    txtListAExpDate1.Text = ec.S2_A1ExpirationDate

                    txtListADocument2.Text = ec.S2_A2DocumentTitle
                    txtListAAuthority2.Text = ec.S2_A2IssuedBy
                    txtListADocNum2.Text = ec.S2_A2DocumentNumber
                    txtListAExpDate2.Text = ec.S2_A2ExpirationDate

                    txtListADocument3.Text = ec.S2_A3DocumentTitle
                    txtListAAuthority3.Text = ec.S2_A3IssuedBy
                    txtListADocNum3.Text = ec.S2_A3DocumentNumber
                    txtListAExpDate3.Text = ec.S2_A3ExpirationDate

                    ' txtListBDocument.Text = ec.S2_B1DocumentTitle
                    If ddlListBDocument.Items.FindByText(ec.S2_B1DocumentTitle) Is Nothing Then
                        ' do what the Exception is supposed to do '
                        ddlListBDocument.SelectedIndex = 0
                    Else
                        ddlListBDocument.SelectedIndex = ddlListBDocument.Items.IndexOf(ddlListBDocument.Items.FindByText(ec.S2_B1DocumentTitle))
                    End If
                    txtListBAuthority.Text = ec.S2_B1IssuedBy
                    txtListBDocNum.Text = ec.S2_B1DocumentNumber
                    txtListBExpDate.Text = ec.S2_B1_ExpirationDate

                    ' txtListCDocument.Text = ec.S2_C1DocumentTitle
                    If ddlListCDocument.Items.FindByText(ec.S2_C1DocumentTitle) Is Nothing Then
                        ' do what the Exception is supposed to do '
                        ddlListCDocument.SelectedIndex = 0
                    Else
                        ddlListCDocument.SelectedIndex = ddlListCDocument.Items.IndexOf(ddlListCDocument.Items.FindByText(ec.S2_C1DocumentTitle))
                    End If
                    txtListCAuthority.Text = ec.S2_C1IssuedBy
                    txtListCDocNum.Text = ec.S2_C1DocumentNumber
                    txtListCExpDate.Text = ec.S2_C1ExpirationDate

                    txtHireDate.Text = ec.S2_EEDateofHire
                    txtEmployerSignature.Text = ec.S2_ERSignature
                    txtEmployerSignatureDate.Text = IIf(ec.S2_ERSignatureDate = "", ec.DateTimeStamp, ec.S2_ERSignatureDate)
                    txtEmployerTitle.Text = ec.S2_ERTitle
                    txtAdminFirstName.Text = IIf(ec.S2_ERFirstName <> "", ec.S2_ERFirstName, ec.I9AdminFirstName)
                    txtAdminLastName.Text = IIf(ec.S2_ERLastName <> "", ec.S2_ERLastName, ec.I9AdminLastName)
                    lblCompanyName.Text = IIf(ec.S2_BusinessName <> "", ec.S2_BusinessName, ec.I9CompanyName)
                    lblCompanyAddress.Text = IIf(ec.S2_ERAddress <> "", ec.S2_ERAddress, ec.I9CompanyAddress)
                    lblCompanyCity.Text = IIf(ec.S2_ERCity <> "", ec.S2_ERCity, ec.I9CompanyCity)
                    lblCompanyState.Text = IIf(ec.S2_ERState <> "", ec.S2_ERState, ec.I9CompanyState)
                    lblCompanyZip.Text = IIf(ec.S2_ERZip <> "", ec.S2_ERZip, ec.I9CompanyZip)

                    'Section 3
                    txtRHLastName.Text = ec.S3_EELastName
                    txtRHFirstName.Text = ec.S3_FirstName
                    txtRHiddleInit.Text = ec.S3_MiddleInit
                    txtDateofRehire.Text = ec.S3_RehireDate
                    txtS3DocTitle.Text = ec.S3_DocumentTitle
                    txtS3DocNumber.Text = ec.S3_DocumentNumber
                    txtS3DocExpDate.Text = ec.S3_ExpirationDate
                    txtS3Signature.Text = ec.S3_ERSignature
                    txtS3SignatureDate.Text = IIf(ec.S3_ERSignatureDate = "", ec.DateTimeStamp, ec.S3_ERSignatureDate)
                    txtS3Title.Text = ec.S3_ERTitle
                End If

            End If

        End If

    End Sub

    Private Sub CheckRequiredEmployeeInfo()
        Dim sErrorText As String
        bError = False
        lblEEDemoErrorTitle.Text = "Employee Demographic Information is missing and must be complete before preparing the I-9 form."
        sErrorText = "Please return to the Profile page and complete the required fields:<br/><ul>"

        If Trim(lblFirstName.Text) = "" Then
            sErrorText = sErrorText + "<li style = 'color:black;'>First Name</li>"
            bError = True
        End If

        If Trim(lblLastName.Text) = "" Then
            sErrorText = sErrorText + "<li style = 'color:black;'>Last Name</li>"
            bError = True
        End If

        If Trim(lblAddress1.Text) = "" Then
            sErrorText = sErrorText + "<li style = 'color:black;'>Address (Street Number and Name)</li>"
            bError = True
        End If

        If Trim(lblCity.Text) = "" Then
            sErrorText = sErrorText + "<li style = 'color:black;'>City</li>"
            bError = True
        End If

        If Trim(lblState.Text) = "" Then
            sErrorText = sErrorText + "<li style = 'color:black;'>State</li>"
            bError = True
        End If

        If Trim(lblZip.Text) = "" Then
            sErrorText = sErrorText + "<li style = 'color:black;'>ZIP Code</li>"
            bError = True
        End If


        If Trim(lblDOB.Text) = "01/01/1900" Then
            sErrorText = sErrorText + "<li style = 'color:black;'>Date of Birth</li>"
            bError = True
        End If

        If Trim(lblSSN.Text) = "--" Then
            sErrorText = sErrorText + "<li style = 'color:black;'>SSN</li>"
            bError = True
        End If

        If bError Then
            sErrorText = sErrorText + "</ul>"
            lblEEDemoErrorText.Text = sErrorText
            divEEDemoError.Visible = True
            imgNext.Visible = False
            divSuccess.Visible = False
            ResetScrollPosition()
        End If

    End Sub

#Region "Save buttons"
    Private Sub SaveSection1()

        bError = False
        CheckRequiredEmployeeInfo()
        If bError = True Then
            Exit Sub
        ElseIf chkCitizen.Checked = False And chkNonCitizen.Checked = False And chkPermResident.Checked = False And chkTempVisa.Checked = False Then
            lblEECheckboxTitle.Text = "You must select one of the following checkboxes to complete Section 1:"
            lblEECheckboxText.Text = "<ul>
                                <li style='color:black;'>A Citizen of the United States or</li>
                                <li style='color:black;'>A noncitizen national of the United States or</li>
                                <li style='color:black;'>A lawful permanent resident or  </li>
                                <li style='color:black;'>An alien authorized to work.  </li>
                                </ul>"
            divEECheckboxError.Visible = True
            chkCitizen.Focus()
            MaintainScrollPositionOnPostBack = False
            divSuccess.Visible = False
            divError.Visible = True
            imgNext.Visible = False

            Exit Sub
        ElseIf chkPermResident.Checked = True And Trim(txtPermResidentNumber.Text) = "" Then
            lblPermResErrorText.Text = "<br/><br/>The Alien Registration Number or a USCIS number must be provided for a Lawful Permanent Resident."
            divPermResError.Visible = True
            txtPermResidentNumber.Focus()
            MaintainScrollPositionOnPostBack = False
            divSuccess.Visible = False
            divError.Visible = True
            imgNext.Visible = False

            Exit Sub
        ElseIf chkPermResident.Checked = True And Trim(txtPermResidentNumber.Text) <> "" And (ddlPermResidentType.SelectedItem.Text = "N/A" Or ddlPermResidentType.SelectedItem.Text = "") Then
            lblPermResErrorText.Text = "<br/><br/>Please indicate Registration Number or a USCIS number by making the a selection in the drop-down."
            divPermResError.Visible = True
            ddlPermResidentType.Focus()
            MaintainScrollPositionOnPostBack = False
            divSuccess.Visible = False
            divError.Visible = True
            imgNext.Visible = False

            Exit Sub
        ElseIf chkTempVisa.Checked = True And Trim(txtAlienNumber.Text) = "" And Trim(txtAdmissionNumber.Text) = "" And Trim(txtPassportNumber.Text) = "" Then
            lblEEAlienErrorTitle.Text = "Aliens authorized to work must provide one of the following document Numbers to complete Form I-9:"
            lblEEAlienErrorText.Text = "<ul>
                                <li style='color:black;'>Alien Registration Number/USCIS Number or</li>
                                <li style='color:black;'>Form i-94 Admission Number or</li>
                                <li style='color:black;'>Foreign Passport Number and the Country of Issuance.  </li>
                                </ul>"
            divEEAlienError.Visible = True
            chkTempVisa.Focus()
            MaintainScrollPositionOnPostBack = False
            divSuccess.Visible = False
            divError.Visible = True
            imgNext.Visible = False

            Exit Sub
        ElseIf chkTempVisa.Checked = True And Trim(txtTempVisaDate.Text) = "" Then
            lblEEAlienErrorTitle.Text = "Please enter expiration date or N/A if not applicable"
            lblEEAlienErrorText.Text = ""
            divEEAlienError.Visible = True
            txtTempVisaDate.Focus()
            MaintainScrollPositionOnPostBack = False
            divSuccess.Visible = False
            divError.Visible = True
            imgNext.Visible = False

            Exit Sub
        ElseIf chkTempVisa.Checked = True And Trim(txtPermResidentNumber.Text) <> "" And (ddlPermResidentType2.SelectedItem.Text = "N/A" Or ddlPermResidentType2.SelectedItem.Text = "") Then
            lblEEAlienErrorText.Text = "<br/><br/>Please indicate if data entered into 4.1 is an Alien Registration Number or a USCIS number by making the a selection in the drop-down."
            divEEAlienError.Visible = True
            ddlPermResidentType2.Focus()
            MaintainScrollPositionOnPostBack = False
            divSuccess.Visible = False
            divError.Visible = True
            imgNext.Visible = False

            Exit Sub
        ElseIf Trim(txtEmployeeSignature.Text) = "" Then
            lblEESignatureErrorTitle.Text = "<br/><br/>Signature of Employee is required before saving."
            divEESignatureError.Visible = True
            txtEmployeeSignature.Focus()
            MaintainScrollPositionOnPostBack = False
            divSuccess.Visible = False
            divError.Visible = True
            imgNext.Visible = False

            Exit Sub
        ElseIf chkNoPreparer.Checked = False And chkUsedPreparer.Checked = False Then
            lblEEPreparerErrorTitle.Text = "Preparer And/Or Translator Certification must be indicated by selecting On Of the following checkboxes:"
            lblEEPreparerErrorText.Text = "
                                <ul >
                                <li style='color:black;'>I did not use a preparer or translator or</li>
                                <li style='color:black;'>A preparer and/or translator assisted the employee in completeing Section 1.</li>                          
                                </ul>"

            divEEPreparerError.Visible = True
            chkNoPreparer.Focus()
            MaintainScrollPositionOnPostBack = False
            divSuccess.Visible = False
            imgNext.Visible = False

            Exit Sub
        ElseIf chkUsedPreparer.Checked = True And (txtPRLastName.Text = "" Or txtPRFirstName.Text = "" Or txtPRAddress.Text = "" Or txtPRCity.Text = "" Or ddlPRState.SelectedValue = "" Or txtPRZip.Text = "") Then
            Dim strPRError As String
            lblEEPreparerErrorTitle.Text = "If a preparer and/or translator assisted the employee in completeing Section 1, the following information must be provided:"
            strPRError = "<ul >"
            strPRError = strPRError + IIf(txtPRSignature.Text = "", " <li style='color:black;'>Signature of Preparer or Translator</li>", "")
            strPRError = strPRError + IIf(txtPRSignatureDate.Text = "", " <li style='color:black;'>Current Date <i>(mm/dd/yyyy)</i></li>", "")
            strPRError = strPRError + IIf(txtPRLastName.Text = "", " <li style='color:black;'>Last Name of Preparer or Translator</li>", "")
            strPRError = strPRError + IIf(txtPRFirstName.Text = "", " <li style='color:black;'>First Name of Preparer or Translator</li>", "")
            strPRError = strPRError + IIf(txtPRAddress.Text = "", " <li style='color:black;'>Address of Preparer or Translator</li>", "")
            strPRError = strPRError + IIf(txtPRCity.Text = "", " <li style='color:black;'>City of Preparer or Translator</li>", "")
            strPRError = strPRError + IIf(ddlPRState.SelectedValue = "", " <li style='color:black;'>State of Preparer or Translator</li>", "")
            strPRError = strPRError + IIf(txtPRZip.Text = "", " <li style='color:black;'>Zip of Preparer or Translator</li>", "")
            strPRError = strPRError + "</ul>"
            lblEEPreparerErrorText.Text = strPRError
            divEEPreparerError.Visible = True
            txtPRSignature.Focus()
            MaintainScrollPositionOnPostBack = False
            divSuccess.Visible = False
            divError.Visible = True
            imgNext.Visible = False

            Exit Sub
        Else

            imgProcessing.Visible = True

            divEECheckboxError.Visible = False
            divPermResError.Visible = False
            divEEAlienError.Visible = False
            divEESignatureError.Visible = False
            divEEPreparerError.Visible = False

            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()
            objParam = New SqlParameter("@EmployeeI9Id", Session("EmployeeI9Id"))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EmployeeId", intEmployeeId)
            aryParams.Add(objParam)

            'Section 1
            objParam = New SqlParameter("@S1_OtherName", txtOtherName.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_Citizen", chkCitizen.Checked)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_NonCitizenNational", chkNonCitizen.Checked)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_PermanentResident", chkPermResident.Checked)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_PermanentResidentNumber", IIf(chkPermResident.Checked = True, txtPermResidentNumber.Text, ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_PermanentResidentType", IIf(chkPermResident.Checked = True And (ddlPermResidentType.SelectedValue = "N/A" Or ddlPermResidentType.SelectedValue = ""), "",
                                                                         IIf(chkTempVisa.Checked = True And (ddlPermResidentType2.SelectedValue = "N/A" Or ddlPermResidentType2.SelectedValue = ""), "",
                                                                             IIf(chkPermResident.Checked = True And ddlPermResidentType.SelectedValue <> "N/A" And ddlPermResidentType.SelectedValue <> "", ddlPermResidentType.SelectedValue,
                                                                                IIf(chkTempVisa.Checked = True And ddlPermResidentType2.SelectedValue <> "N/A" And ddlPermResidentType2.SelectedValue <> "", ddlPermResidentType2.SelectedValue,
                                                                                        "")))))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_Alien", chkTempVisa.Checked)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_AlienExpDate", IIf(chkTempVisa.Checked = True And txtTempVisaDate.Text <> "", txtTempVisaDate.Text, ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_AlienNumber", IIf(chkTempVisa.Checked = True, txtAlienNumber.Text, ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_Form94Number", IIf(chkTempVisa.Checked = True, txtAdmissionNumber.Text, ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_ForiegnPassportNumber", IIf(chkTempVisa.Checked = True, txtPassportNumber.Text, ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_CountryofIssuance", IIf(chkTempVisa.Checked = True, ddlCountryofIssuance.SelectedItem.Text, ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_EESignature", txtEmployeeSignature.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_EESignatureDate", Session("DateTimeStamp"))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_UsedPreparer", chkUsedPreparer.Checked)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_PRSignature", txtPRSignature.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_PRSignatureDate", IIf(RTrim(txtPRSignature.Text) <> "", Session("DateTimeStamp"), ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_PRLastName", IIf(txtPRLastName.Text <> "&nbsp;", txtPRLastName.Text, ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_PRFirstName", IIf(txtPRFirstName.Text <> "", txtPRFirstName.Text, ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_PRAddress", IIf(txtPRAddress.Text <> "&nbsp;", txtPRAddress.Text, ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_PRCity", IIf(txtPRCity.Text <> "", txtPRCity.Text, ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_PRState", IIf(ddlPRState.SelectedValue <> "", ddlPRState.SelectedValue, ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S1_PRZipCode", IIf(txtPRZip.Text <> "", txtPRZip.Text, ""))
            aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("usp_Employee_I9_Edit_Section1", aryParams)
            sqlCon.CloseConn()

            imgProcessing.Visible = False

        End If

    End Sub

    Protected Sub btnSave_Section1_Click(sender As Object, e As EventArgs)
        SaveSection1()

        If Session("Admin") = False And divEECheckboxError.Visible = False And divPermResError.Visible = False And divEEAlienError.Visible = False And divEESignatureError.Visible = False And divEEPreparerError.Visible = False Then
            divError.Visible = False
            divSuccess.Visible = True
            lblSuccess.Text = "I-9 Form Complete"
            divMainArticalTitleandText.Visible = False
            imgNext.Visible = True
            ResetScrollPosition()

        ElseIf Session("Admin") = True And divEECheckboxError.Visible = False And divPermResError.Visible = False And divEEAlienError.Visible = False And divEESignatureError.Visible = False And divEEPreparerError.Visible = False And divERSection2ErrorTop.Visible = False And divERSection2ErrorBottom.Visible = False And divERSection3Error.Visible = False Then
            divError.Visible = False
            'divSuccess.Visible = True - Do not show sucess as Section 2 might not have been started yet - just show NEXT button - if that is clicked it will check Section 2 and 3
            imgNext.Visible = True

            divMainArticalTitleandText.Visible = False

        End If

        s.SaveUserUpdate(intUserId, strScreenName, "Saved Section 1 of " + strScreenShortDesc, intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

        PopulateFields()

    End Sub

    Private Sub SaveSection2()
        If ddlListADocument.SelectedItem.Text = "N/A" And ddlListBDocument.SelectedItem.Text = "N/A" And ddlListCDocument.SelectedItem.Text = "N/A" Then
            divERSection2ErrorTop.Visible = True
            divSuccess.Visible = False
            divError.Visible = True
            imgNext.Visible = False

            lblSection2ErrorTop.Text = "Please choose Document Type A - or B and C"
            ddlListADocument.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ddlListBDocument.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ddlListCDocument.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ddlListADocument.Focus()
            Exit Sub

        ElseIf ddlListADocument.SelectedItem.Text = "N/A" And (ddlListBDocument.SelectedItem.Text = "N/A" Or ddlListCDocument.SelectedItem.Text = "N/A") Then
            divERSection2ErrorTop.Visible = True
            divSuccess.Visible = False
            divError.Visible = True
            imgNext.Visible = False

            lblSection2ErrorTop.Text = "Please choose Document for both B and C"
            ddlListBDocument.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ddlListCDocument.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            ddlListBDocument.Focus()
            Exit Sub
        ElseIf txtEmployerSignature.Text = "" Then
            divERSection2ErrorBottom.Visible = True
            divSuccess.Visible = False
            divError.Visible = True
            imgNext.Visible = False

            lblSection2ErrorBottom.Text = "Signature of Employer or Authorized Representative is Required"
            txtEmployerSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
            txtEmployerSignature.Focus()
            Exit Sub
        Else

            imgProcessing.Visible = True

            imgNext.Visible = True

            divERSection2ErrorTop.Visible = False
            lblSection2ErrorTop.Text = ""
            divERSection2ErrorBottom.Visible = False
            lblSection2ErrorBottom.Text = ""

            txtEmployerSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            ddlListADocument.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            ddlListBDocument.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            ddlListCDocument.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")

            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()

            objParam = New SqlParameter("@EmployeeI9Id", Session("EmployeeI9Id"))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EmployeeId", intEmployeeId)
            aryParams.Add(objParam)

            'Section 2
            objParam = New SqlParameter("@S2_A1DocumentTitle", ddlListADocument.SelectedItem.Text)
            aryParams.Add(objParam)
            If ddlListAAuthority.Visible Then
                objParam = New SqlParameter("@S2_A1IssuedBy", ddlListAAuthority.SelectedItem.Text)
            Else
                objParam = New SqlParameter("@S2_A1IssuedBy", txtListAAuthority.Text)
            End If
            aryParams.Add(objParam)

            objParam = New SqlParameter("@S2_A1DocumentNumber", txtListADocNum1.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_A1ExpirationDate", txtListAExpDate1.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@S2_A2DocumentTitle", txtListADocument2.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_A2IssuedBy", txtListAAuthority2.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_A2DocumentNumber", txtListADocNum2.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_A2ExpirationDate", txtListAExpDate2.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@S2_A3DocumentTitle", txtListADocument3.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_A3IssuedBy", txtListAAuthority3.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_A3DocumentNumber", txtListADocNum3.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_A3ExpirationDate", txtListAExpDate3.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@S2_B1DocumentTitle", ddlListBDocument.SelectedItem.Text)
            aryParams.Add(objParam)

            If ddlListBAuthority.Visible Then
                objParam = New SqlParameter("@S2_B1IssuedBy", ddlListBAuthority.SelectedItem.Text)
            Else
                objParam = New SqlParameter("@S2_B1IssuedBy", txtListBAuthority.Text)
            End If
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_B1DocumentNumber", txtListBDocNum.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_B1_ExpirationDate", txtListBExpDate.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@S2_C1DocumentTitle", ddlListCDocument.SelectedItem.Text)
            aryParams.Add(objParam)

            If ddlListCAuthority.Visible Then
                objParam = New SqlParameter("@S2_C1IssuedBy", ddlListCAuthority.SelectedItem.Text)
            Else
                objParam = New SqlParameter("@S2_C1IssuedBy", txtListCAuthority.Text)
            End If
            aryParams.Add(objParam)

            objParam = New SqlParameter("@S2_C1DocumentNumber", txtListCDocNum.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_C1ExpirationDate", txtListCExpDate.Text)
            aryParams.Add(objParam)

            objParam = New SqlParameter("@S2_EEDateofHire", txtHireDate.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_ERSignature", txtEmployerSignature.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_ERSignatureDate", Session("DateTimeStamp"))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_ERLastName", txtAdminLastName.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_ERFirstName", txtAdminFirstName.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_ERTitle", txtEmployerTitle.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_BusinessName", lblCompanyName.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_ERAddress", lblCompanyAddress.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_ERCity", lblCompanyCity.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_ERState", lblCompanyState.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S2_ERZip", lblCompanyZip.Text)
            aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("usp_Employee_I9_Edit_Section2", aryParams)
            sqlCon.CloseConn()
            aryParams = Nothing
            sqlCon = Nothing

            imgProcessing.Visible = False

            divERSection2ErrorTop.Visible = False
            divERSection2ErrorBottom.Visible = False

        End If
    End Sub

    Protected Sub btnSave_Section2_Click(sender As Object, e As EventArgs)
        SaveSection2()

        If divEECheckboxError.Visible = False And divPermResError.Visible = False And divEEAlienError.Visible = False And divEESignatureError.Visible = False And divEEPreparerError.Visible = False And divERSection2ErrorTop.Visible = False And divERSection2ErrorBottom.Visible = False And divERSection3Error.Visible = False Then
            divError.Visible = False
            divSuccess.Visible = True
            lblSuccess.Text = "I-9 Form Complete"
            divMainArticalTitleandText.Visible = False
            imgNext.Visible = True

            s.SaveUserUpdate(intUserId, strScreenName, "Saved Section 2 of " + strScreenShortDesc, intEmployeeId, 0, 0, "01/01/1900", intTransactionId)
        End If

        PopulateFields()

    End Sub

    Private Sub SaveSection3()
        If txtRHLastName.Text <> "" Or txtRHFirstName.Text <> "" Or txtDateofRehire.Text <> "" Or txtS3DocTitle.Text <> "" Or txtS3DocNumber.Text <> "" Or txtS3Signature.Text <> "" Or txtS3Title.Text <> "" Then
            If txtRHLastName.Text = "" Or txtRHFirstName.Text = "" Or txtDateofRehire.Text = "" Or txtS3DocTitle.Text = "" Or txtS3DocNumber.Text = "" Or txtS3Signature.Text = "" Or txtS3Title.Text = "" Then

                Dim strERError As String
                strERError = "Please make sure all required fields are completed:<ul >"
                strERError = strERError + IIf(txtRHLastName.Text = "", " <li style = 'color:black;'>Last Name </li>", "")
                strERError = strERError + IIf(txtRHFirstName.Text = "", " <li style = 'color:black;'>First Name </li>", "")
                strERError = strERError + IIf(txtDateofRehire.Text = "", " <li style = 'color:black;'>Date of Rehire </li>", "")
                strERError = strERError + IIf(txtS3DocTitle.Text = "", " <li style = 'color:black;'>Document Title</li>", "")
                strERError = strERError + IIf(txtS3DocNumber.Text = "", " <li style = 'color:black;'>Document Number</li>", "")
                strERError = strERError + IIf(txtS3Signature.Text = "", " <li style = 'color:black;'>Signature</li>", "")
                strERError = strERError + IIf(txtS3SignatureDate.Text = "", " <li style = 'color:black;'>Signature Date </li>", "")
                strERError = strERError + IIf(txtS3Title.Text = "", " <li style = 'color:black;'>Administrator Title</li>", "")
                strERError = strERError + "</ul>"

                lblSection3Error.Text = strERError
                txtRHLastName.Focus()
                MaintainScrollPositionOnPostBack = False

                IIf(txtRHLastName.Text = "", txtRHLastName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede"), txtRHLastName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa"))
                IIf(txtRHFirstName.Text = "", txtRHFirstName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede"), txtRHFirstName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa"))
                IIf(txtDateofRehire.Text = "", txtDateofRehire.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede"), txtDateofRehire.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa"))
                IIf(txtS3DocTitle.Text = "", txtS3DocTitle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede"), txtS3DocTitle.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa"))
                IIf(txtS3DocNumber.Text = "", txtS3DocNumber.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede"), txtS3DocNumber.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa"))
                IIf(txtS3Signature.Text = "", txtS3Signature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede"), txtS3Signature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa"))
                IIf(txtS3SignatureDate.Text = "", txtS3SignatureDate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede"), txtS3SignatureDate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa"))
                IIf(txtS3Title.Text = "", txtS3Title.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede"), txtS3Title.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa"))

                divERSection3Error.Visible = True
                divError.Visible = True
                divSuccess.Visible = False
                lblSection3Error.Visible = True
                imgNext.Visible = False

                Exit Sub

            End If

        Else

            imgProcessing.Visible = True

            divERSection3Error.Visible = False
            lblSection3Error.Visible = False

            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()
            objParam = New SqlParameter("@EmployeeI9Id", Session("EmployeeI9Id"))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EmployeeId", intEmployeeId)
            aryParams.Add(objParam)

            'Section 3
            objParam = New SqlParameter("@S3_EELastName", txtRHLastName.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S3_FirstName", txtRHFirstName.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S3_MiddleInit", txtRHiddleInit.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S3_RehireDate", txtDateofRehire.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S3_DocumentTitle", txtS3DocTitle.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S3_DocumentNumber", txtS3DocNumber.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S3_ExpirationDate", txtS3DocExpDate.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S3_ERSignature", txtS3Signature.Text)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S3_ERSignatureDate", IIf(txtS3Signature.Text <> "", Session("DateTimeStamp"), ""))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@S3_ERTitle", txtS3Title.Text)
            aryParams.Add(objParam)

            objDataSet = sqlCon.CreateDataSet("usp_Employee_I9_Edit_Section3", aryParams)
            sqlCon.CloseConn()

            imgProcessing.Visible = False

        End If

    End Sub

    Protected Sub btnSave_Section3_Click(sender As Object, e As EventArgs)

        SaveSection3()

        If divEECheckboxError.Visible = False And divPermResError.Visible = False And divEEAlienError.Visible = False And divEESignatureError.Visible = False And divEEPreparerError.Visible = False And divERSection2ErrorTop.Visible = False And divERSection2ErrorBottom.Visible = False And divERSection3Error.Visible = False Then
            divError.Visible = False
            divSuccess.Visible = True
            lblSuccess.Text = "I-9 Form Complete"
            divMainArticalTitleandText.Visible = False
            imgNext.Visible = True

        End If

        s.SaveUserUpdate(intUserId, strScreenName, "Saved Section 3 of " + strScreenShortDesc, intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

        PopulateFields()

    End Sub

#End Region

#Region "Section 1: Status Check box changes"
    Protected Sub chkCitizen_CheckedChanged(sender As Object, e As EventArgs)
        If chkCitizen.Checked = True Then
            chkNonCitizen.Checked = False

            chkPermResident.Checked = False
            ddlPermResidentType.SelectedItem.Value = "N/A"
            ddlPermResidentType.Visible = False
            txtPermResidentNumber.Visible = False
            txtPermResidentNumber.Text = ""

            chkTempVisa.Checked = False
            txtTempVisaDate.Visible = False
            txtTempVisaDate.Text = ""

            lblAlien1.Visible = False
            txtAlienNumber.Visible = False
            txtAlienNumber.Text = ""

            ddlPermResidentType2.SelectedItem.Value = "N/A"
            ddlPermResidentType2.Visible = False

            txtAdmissionNumber.Visible = False
            txtAdmissionNumber.Text = ""

            txtPassportNumber.Visible = False
            txtPassportNumber.Text = ""

            ddlCountryofIssuance.Visible = False
            ddlCountryofIssuance.SelectedIndex = 0

            divPermResError.Visible = False
            divEEAlienError.Visible = False
            divEECheckboxError.Visible = False
            divEEDemoError.Visible = False

            txtEmployeeSignatureDate.Text = Session("DateTimeStamp")
        End If
        PopulateDocumentDropDowns()
    End Sub

    Protected Sub chkNonCitizen_CheckedChanged(sender As Object, e As EventArgs)
        If chkNonCitizen.Checked = True Then
            chkCitizen.Checked = False

            chkPermResident.Checked = False
            ddlPermResidentType.SelectedItem.Value = "N/A"
            ddlPermResidentType.Visible = False
            txtPermResidentNumber.Visible = False
            txtPermResidentNumber.Text = ""

            chkTempVisa.Checked = False
            txtTempVisaDate.Visible = False
            txtTempVisaDate.Text = ""

            lblAlien1.Visible = False
            txtAlienNumber.Visible = False
            txtAlienNumber.Text = ""

            ddlPermResidentType2.SelectedItem.Value = "N/A"
            ddlPermResidentType2.Visible = False

            txtAdmissionNumber.Visible = False
            txtAdmissionNumber.Text = ""

            txtPassportNumber.Visible = False
            txtPassportNumber.Text = ""

            ddlCountryofIssuance.Visible = False
            ddlCountryofIssuance.SelectedIndex = 0

            divPermResError.Visible = False
            divEEAlienError.Visible = False
            divEECheckboxError.Visible = False
            divEEDemoError.Visible = False

            txtEmployeeSignatureDate.Text = Session("DateTimeStamp")
        End If
        PopulateDocumentDropDowns()
    End Sub

    Protected Sub chkPermResident_CheckedChanged(sender As Object, e As EventArgs)
        If chkPermResident.Checked = True Then
            ddlPermResidentType.Visible = True
            txtPermResidentNumber.Visible = True
            ddlPermResidentType.SelectedValue = IIf(ec.S1_PermResidentType <> "", ec.S1_PermResidentType, "N/A")
            txtPermResidentNumber.Text = ec.S1_PermanentResidentNumber

            chkCitizen.Checked = False

            chkNonCitizen.Checked = False

            chkTempVisa.Checked = False
            txtTempVisaDate.Visible = False
            txtTempVisaDate.Text = ""

            lblAlien1.Visible = False
            txtAlienNumber.Visible = False
            txtAlienNumber.Text = ""

            ddlPermResidentType2.SelectedItem.Value = "N/A"
            ddlPermResidentType2.Visible = False

            txtAdmissionNumber.Visible = False
            txtAdmissionNumber.Text = ""

            txtPassportNumber.Visible = False
            txtPassportNumber.Text = ""

            ddlCountryofIssuance.Visible = False
            ddlCountryofIssuance.SelectedIndex = 0

            divPermResError.Visible = False
            divEEAlienError.Visible = False
            divEECheckboxError.Visible = False
            divEEDemoError.Visible = False

            txtEmployeeSignatureDate.Text = Session("DateTimeStamp")
        End If
        PopulateDocumentDropDowns()
    End Sub

    Protected Sub chkTempVisa_CheckedChanged(sender As Object, e As EventArgs)
        If chkTempVisa.Checked = True Then

            txtTempVisaDate.Visible = True
            txtTempVisaDate.Text = IIf(ec.S1_Alien = True And ec.S1_AlienExpDate <> "01/01/1900", ec.S1_AlienExpDate, "")

            lblAlien1.Visible = True
            txtAlienNumber.Visible = True
            txtAlienNumber.Text = IIf(ec.S1_Alien = True, ec.S1_AlienNumber, "")

            ddlPermResidentType2.SelectedItem.Value = IIf(ec.S1_PermResidentType = "", "N/A", ec.S1_PermResidentType)
            ddlPermResidentType2.Visible = True

            txtAdmissionNumber.Visible = True
            txtAdmissionNumber.Text = IIf(ec.S1_Alien = True, ec.S1_Form94Number, "")

            txtPassportNumber.Visible = True
            txtPassportNumber.Text = IIf(ec.S1_Alien = True, ec.S1_ForiegnPassportNumber, "")

            ddlCountryofIssuance.Visible = True
            ddlCountryofIssuance.Text = IIf(ec.S1_Alien = True, ec.S1_CountryofIssuance, "")

            chkCitizen.Checked = False
            chkNonCitizen.Checked = False

            chkPermResident.Checked = False
            ddlPermResidentType.SelectedItem.Value = "N/A"
            ddlPermResidentType.Visible = False
            txtPermResidentNumber.Visible = False
            txtPermResidentNumber.Text = ""

            divPermResError.Visible = False
            divEEAlienError.Visible = False
            divEECheckboxError.Visible = False
            divEEDemoError.Visible = False

            txtEmployeeSignatureDate.Text = Session("DateTimeStamp")
        End If
        PopulateDocumentDropDowns()
    End Sub
#End Region

#Region "Section 1 Help"
    Protected Sub btnCitizen_Click(sender As Object, e As EventArgs)
        divHelp.Visible = True
        lblHelpTitle.Text = "<strong>A Citizen Of the United States</strong>"
        lblHelpText.Text = "Select this status If it applies To you.  If you Select this box, the rest Of the fields In the area wil contain N/A."

    End Sub

    Protected Sub btnNonCitizenHelp_Click(sender As Object, e As EventArgs)
        divHelp.Visible = True
        lblHelpTitle.Text = "<strong>A NonCitizen National Of the United States</strong>"
        lblHelpText.Text = "Select this status If it applies To you.  If you Select this box, the rest Of the fields In the area will contain N/A.
                            <br/><br/>
                            A noncitizen national of the United States is an individual born in American Samoa, certain former citizens of the former Trust Territory of the Pacific Islands, and certain children of noncitizen nationals born abroad."
    End Sub

    Protected Sub btnPermResidentHelp_Click(sender As Object, e As EventArgs)
        divHelp.Visible = True
        lblHelpTitle.Text = "<strong>A Lawful Permanent Resident</strong>"
        lblHelpText.Text = "Select this status if it applies to you.  If you select this box, the fields associated with the alien authorized to work status will contain N/A
                            <br/><br/>
                            A lawful permanent resident is an individual who is not a U.S. citizen and who resides in the United Status under legally recognized and lawfully recorded permanent residence as an immigrant.  This term includes conditional residents.
                            <br/><br/>
                            If you select this box, you must enter either your <strong>Alien Registration Number or USCIS Number </strong> in the field provided. At this time, the USCIS Number is the same as the A-number without the 'A' prefix.
                            <br/><br/>
                            Asylees and refugees should not select this status, but should instead select 'An alien authorized to work.'"

    End Sub

    Protected Sub btnPermResidentHelp2_Click(sender As Object, e As EventArgs)
        divHelp.Visible = True
        lblHelpTitle.Text = "<strong>Alien Registration Number/USCIS Number</strong>"
        lblHelpText.Text = "Lawful permanent residents must enter their 7 to 9 digit Alien Registration Number or USCIS Number here.  At this time, the USCIS Number is the same as the A-number without the 'A' prefix.  To do so, enter the number in the space provide, then select either Alien Registration Number or USCIS Number from the drop-down.  If you select Alien Registration Number from the drop-down, an 'A' will appear before the number you entered."

    End Sub

    Protected Sub btnTempVisaHelp_Click(sender As Object, e As EventArgs)
        divHelp.Visible = True
        lblHelpTitle.Text = "<strong>An Alien Authorized to Work</strong>"
        lblHelpText.Text = "Select this status if it applies to you.  If you select his box, the fields associated with the lawful permanent resident status will contain N/A. <br/><br/>
                            An alien authorized to work is an individual who is not a citizen or national of the United States, or a lawful permanent resident, but is authorized to work in the United States. <br/><br/>
                            If you select this box, you must enter the expiration date of your employment authorization, if any, and either the Alien Registration Number/USCIS Number or the Form I-94 Admission Number in the fields below."

    End Sub

    Protected Sub btnTempVisaHelp2_Click(sender As Object, e As EventArgs)
        divHelp.Visible = True
        lblHelpTitle.Text = "<strong>Expiration Date of Employment Authorization</strong>"
        lblHelpText.Text = "Enter the date your employment authorization expires, if any, in this field.<br/><br/>
                            If you select this box, enter the date that your employment authorization expires, if any, in this field.  In most cases, your employment authorization expiration date is found on the document(s) evidencing your employment authorization.  Refugees, asylees and certain citizens of the Federated States of Micronesia, the Republic of the Marshall Islands, or Palau, and other aliens whose employment authorization does not have an expiration date should enter N/A in this field.  In some cases, such as if you have temporary protected status, your employment authorization document may have been automatically extended; in these cases, you should enter the expiration date of the automatic extension in this field."

    End Sub

    Protected Sub btnAlienHelpClose_Click(sender As Object, e As EventArgs)
        divHelp.Visible = False
        divAlienHelp.Visible = False
        divEmpSignature.Visible = False
        divPreparerHelp.Visible = False
        divPreparerHelp2.Visible = False
        divHelpSection2.Visible = False

    End Sub

    Protected Sub btnANumberHelp_Click(sender As Object, e As EventArgs)
        divAlienHelp.Visible = True
        lblAlienHelpTitle.Text = "<strong>Alien Registration Number/USCIS Number</strong>"
        lblAlienHelpText.Text = "Enter your 7- to 9-digit Alien Registration Number (A-Number)/USCIS Number, if any, in this field.  To do so, enter the number in the space provided, then select either Alien Registration Number or USCIS Number from the drop-down. If you select Alien Registration Number from the drop-down, an ‘A’ will appear before the number you entered. Currently, the USCIS number is the same as the Alien number without the ‘A’ prefix. If you do not provide an Alien Registration Number/USCIS Number, enter either a Form I-94 Admission Number or Foreign Passport Number in the fields provided.  This field will then be populated with N/A.<br/><br/>
                                Aliens authorized to work must enter one of the following to complete Section1:<br/>
                                <ol >
                                <li style = 'color:#014679;'>Alien Registration Number (A-Number)/USCIS Number or</li>
                                <li style = 'color:#014679;'>Form i-94 Admission Number or</li>
                                <li style ='color:#014679;'>Foreign Passport Number and the Country of Issuance.  </li>
                                </ol>"
    End Sub

    Protected Sub btnHelpClose_Click(sender As Object, e As EventArgs)
        divHelp.Visible = False
        divAlienHelp.Visible = False
        divEmpSignature.Visible = False
        divPreparerHelp.Visible = False
        divPreparerHelp2.Visible = False
        divHelpSection2.Visible = False
        divHelpSection3Top.Visible = False
        divHelpSection3Bottom.Visible = False

    End Sub

    Protected Sub btnI94Help_Click(sender As Object, e As EventArgs)

        divAlienHelp.Visible = True
        lblAlienHelpTitle.Text = "<strong>Form I-94 Admission Number</strong>"
        lblAlienHelpText.Text = "Enter your 11-digit I-94 admission number in this field. If you do not provide an I-94 admission number, enter either an Alien Registration Number/USCIS Number or a Foreign Passport Number in the fields provided.  This field will then be populated with N/A.<br/><br/>
                                Aliens authorized to work must enter one of the following to complete Section1:<br/>
                                <ol >
                                <li style = 'color:#014679;'>Alien Registration Number (A-Number)/USCIS Number or</li>
                                <li style = 'color:#014679;'>Form i-94 Admission Number or</li>
                                <li style ='color:#014679;'>Foreign Passport Number and the Country of Issuance.  </li>
                                </ol>"
    End Sub

    Protected Sub btnPassportHelp_Click(sender As Object, e As EventArgs)
        divAlienHelp.Visible = True
        lblAlienHelpTitle.Text = "<strong>Foreign Passport Number</strong>"
        lblAlienHelpText.Text = "Enter your foreign passport number in this field. If you do not provide a foreign passport number, enter either your Alien Number/USCIS Number or your I-94 Admission Number in the fields provided.  This field will then be populated with N/A.<br/><br/>
                                Aliens authorized to work must enter one of the following to complete Section1:<br/>
                                <ol >
                                <li style = 'color:#014679;'>Alien Registration Number (A-Number)/USCIS Number or</li>
                                <li style = 'color:#014679;'>Form i-94 Admission Number or</li>
                                <li style ='color:#014679;'>Foreign Passport Number and the Country of Issuance.  </li>
                                </ol>"
    End Sub

    Protected Sub btnCountryIssuanceHelp_Click(sender As Object, e As EventArgs)
        divAlienHelp.Visible = True
        lblAlienHelpTitle.Text = "<strong>Country of Issuance</strong>"
        lblAlienHelpText.Text = "If you entered your foreign passport number in the Foreign Passport Number field, select the country of issuance of the foreign passport you used to enter the United States from the drop-down list provided. You mayu also type the first letter of the country and use the down arrow to select your country of issuance.<br/><br/>
                                 If you entered an Alien Registration Number/USCIS Number or I-94 admission number, or you entered N/A in the Foreign Passport Number field, this field will contain N/A."
    End Sub

    Protected Sub btnNameHelpClose_Click(sender As Object, e As EventArgs)
        divNameHelp.Visible = False
    End Sub

    Protected Sub btnOtherNameHelp_Click(sender As Object, e As EventArgs)
        divNameHelp.Visible = True
        lblNameHelpTitle.Text = "<strong>Other Last Name Used <i>(if any)</i></strong>"
        lblNameHelpText.Text = "Provide all other last names used, if any (such as maiden name).  Enter N/A if you have not used other last names.  <br/><br/>
                               For example, if you legally changed your last name from Smith to Jones, you should enter the name Smith in this field."
    End Sub

    Protected Sub btnEmpSignHelpClose_Click(sender As Object, e As EventArgs)
        divEmpSignature.Visible = False
    End Sub

    Protected Sub btnEmpSignHelp_Click(sender As Object, e As EventArgs)
        divEmpSignature.Visible = True
        lblEmpSignHelpTitle.Text = "<strong>Signature of Employee</strong>"
        lblEmpSignHelpText.Text = "After completing Section 1, type your name in this field. <br/><br/>
                                    By signing this form, you attest under penalty of perjury (28 U.S.C. 1746) that the information you provided; the citizenship or immigration status you selected; and all information and documentation you provide to your employer, is complete, true and correct, and you are aware that you may face severe penalties provided by law and may be subject to criminal prosecution for knowingly or willfully making false statements or using false documentation when completing this form.
                                    <br/><br/>
                                    If anyone other than the employee completes Section 1, both the employee and the preparer or translator should complete their respective areas of Section1, then sign Section 1. If the employee is a minor (individual under age 18) or a person with a disability (who is placed in employment by a nonprofit organization, association or as part of a rehabilitation program) who cannot present an identity document, refer to the section of the Form I-9 instruction titled ‘Signature of the Employee’ for more information. Employees who use a preparer or translator to complete the form must still sign or make a mark in this field."
    End Sub

    Protected Sub btnPreparerHelp_Click(sender As Object, e As EventArgs)
        divPreparerHelp.Visible = True
        lblPreparerHelpTitle.Text = "<strong>Preparer and/or Translator Certification</strong>"
        lblPreparerHelpText.Text = "Select the number of preparers and/or translators you used to complete the form.<br/><br/>
                                    If you are the employee and you did not use a preparer or translator, you must select the first box marked ‘I Did Not Use a Preparer or Translator.’ <br/><br/>
                                    If one or more preparers or translators assist the employee in completing Section1, the preparer or translator must select the second box marked ‘A preparer(s) and/or translator(s) assisted the employee in completing Section 1’ and complete the rest of the fields below. <br/><br/>
                                    The preparer and/or translator must also select the Certification areas needed from the dropdown provided.  These additional Certification areas may result in additional pages. <br/><br/>
                                    The first preparer and/or translator must complete the Certification on the same page the employee has signed.  There is no limit to the number of preparers and/or translators that can be used, however each additional preparer and/or translator must complete and signa separate Certification area.  The Supplement for Section1 Preparer and/or Translator provide an extra page of Certification areas, if necessary. <br/><br/>
                                    Ensure the employee’s last name, first name and middle initial are entered at the top of any additional pages. Your employer will ensure that these additional pages are retained with your completed form. <br/><br/>
                                    Parents or legal guardians attesting to the identity of minors (individuals under 18) and individuals attesting to the identity of certain employees with disabilities must complete this section. <br/><br/>
                                    "
    End Sub

    Protected Sub btnPreparerHelpClose_Click(sender As Object, e As EventArgs)
        divPreparerHelp.Visible = False
        divPreparerHelp2.Visible = False
    End Sub

    Protected Sub btnSignaturePrepare_Click(sender As Object, e As EventArgs)
        divPreparerHelp2.Visible = True
        lblPreparerHelpTitle2.Text = "<strong>Signature of Preparer or Translator</strong>"
        lblPreparerHelpText2.Text = "Any person who helped to prepare or translate Section 1 of Form I-9 must sign his or her name in this field. <br/><br/> 
                                    The Preparer and/or Translator Certification must also be completed if ‘Individual under Age 18’ or ‘Special Placement’ is entered in lieu of the employee’s signature in Section 1."
    End Sub

    Protected Sub btnPRLastNameHelp_Click(sender As Object, e As EventArgs)
        divPreparerHelp2.Visible = True
        lblPreparerHelpTitle2.Text = "<strong>Last Name <i>(Family Name)</i></strong>"
        lblPreparerHelpText2.Text = "Enter the full legal last name of the person who helped the employee in preparing or translating Section  1 in this field.<br/><br/>
                                    The last name is also the family name or surname. If the preparer or translator has two last names or a hyphenated last name, include both names in this field."

    End Sub

    Protected Sub btnPRFirstNameHelp_Click(sender As Object, e As EventArgs)
        divPreparerHelp2.Visible = True
        lblPreparerHelpTitle2.Text = "<strong>First Name <i>(Given Name)</i></strong>"
        lblPreparerHelpText2.Text = "Enter the full legal first name of the person who helped the employee in preparing or translating Section 1 in this field. .<br/><br/>
                                     The first name is also the given name."

    End Sub

    Protected Sub btnPRCityHelp_Click(sender As Object, e As EventArgs)
        divPreparerHelp2.Visible = True
        lblPreparerHelpTitle2.Text = "<strong>City or Town</strong>"
        lblPreparerHelpText2.Text = "Enter the city, town or village of the address of the person who helped the employee in preparing or translating Section 1 in this field .<br/><br/>
                                    If the address is not located in a city or town, enter the name of the village, county, township, reservation, etc., in this field. If the address is in Canada, enter the city and province in this field. If the address is in Mexico, enter the city and stat in this field."
    End Sub

    Protected Sub btnPRAddressHelp_Click(sender As Object, e As EventArgs)
        divPreparerHelp2.Visible = True
        lblPreparerHelpTitle2.Text = "<strong>Address <i>(Street Number and Name)</i></strong>"
        lblPreparerHelpText2.Text = "Enter the street name and number of the current address of the person who helped the employee in preparing or translating Section 1 in this field.<br/><br/>
                                    Addresses in Canada or Mexico may be entered in this field.  If the address is an apartment, include the apartment number in this field.<br/><br/>
                                    If the person does not have a physical address, enter a description of the person’s location, such as ‘3 miles southwest of Anytown post office near water tower’."
    End Sub

    Protected Sub btnPRStateHelp_Click(sender As Object, e As EventArgs)
        divPreparerHelp2.Visible = True
        lblPreparerHelpTitle2.Text = "<strong>State</strong>"
        lblPreparerHelpText2.Text = "Enter the state, territory or country of the preparer or translator’s address. If the prepare or translator entered an address from Canada or Mexico enter the country abbreviation."
    End Sub

    Protected Sub btnPRZipHelp_Click(sender As Object, e As EventArgs)
        divPreparerHelp2.Visible = True
        lblPreparerHelpTitle2.Text = "<strong>ZIP Code</strong>"
        lblPreparerHelpText2.Text = "Enter the 5-digit ZIP code of the person who helped the employee in preparing or translating Section 1 in this field. <br/><br/>
                                    If the address of the preparer or translator entered is in Canada or Mexico, enter the 5- or 6-digit postal code in this field."
    End Sub

#End Region

#Region "Preparer/Translator Section"
    Protected Sub chkNoPreparer_CheckedChanged(sender As Object, e As EventArgs)
        If chkNoPreparer.Checked = True Then
            chkUsedPreparer.Checked = False
            txtPRSignature.Text = ""
            txtPRSignatureDate.Text = ""
            txtPRLastName.Text = ""
            txtPRFirstName.Text = ""
            txtPRAddress.Text = ""
            txtPRCity.Text = ""
            ddlPRState.SelectedValue = ""
            txtPRZip.Text = ""

            txtPRSignature.Enabled = False
            txtPRSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
            txtPRSignatureDate.Enabled = False
            txtPRSignatureDate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
            txtPRLastName.Enabled = False
            txtPRLastName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
            txtPRFirstName.Enabled = False
            txtPRFirstName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
            txtPRAddress.Enabled = False
            txtPRAddress.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
            txtPRCity.Enabled = False
            txtPRCity.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
            ddlPRState.Enabled = False
            ddlPRState.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
            txtPRZip.Enabled = False
            txtPRZip.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
        Else
            chkUsedPreparer.Checked = True
            txtPRSignature.Enabled = True
            txtPRSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtPRSignatureDate.Enabled = True
            txtPRSignatureDate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtPRLastName.Enabled = True
            txtPRLastName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtPRFirstName.Enabled = True
            txtPRFirstName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtPRAddress.Enabled = True
            txtPRAddress.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtPRCity.Enabled = True
            txtPRCity.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            ddlPRState.Enabled = True
            ddlPRState.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtPRZip.Enabled = True
            txtPRZip.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
        End If
    End Sub

    Protected Sub chkUsedPreparer_CheckedChanged(sender As Object, e As EventArgs)
        If chkUsedPreparer.Checked = True Then
            chkNoPreparer.Checked = False
            txtPRSignature.Enabled = True
            txtPRSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtPRSignatureDate.Enabled = True
            txtPRSignatureDate.Text = ec.DateTimeStamp
            txtPRSignatureDate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtPRLastName.Enabled = True
            txtPRLastName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtPRFirstName.Enabled = True
            txtPRFirstName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtPRAddress.Enabled = True
            txtPRAddress.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtPRCity.Enabled = True
            txtPRCity.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            ddlPRState.Enabled = True
            ddlPRState.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            txtPRZip.Enabled = True
            txtPRZip.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
        Else
            chkNoPreparer.Checked = True
            txtPRSignature.Text = ""
            txtPRSignatureDate.Text = ""
            txtPRLastName.Text = ""
            txtPRFirstName.Text = ""
            txtPRAddress.Text = ""
            txtPRCity.Text = ""
            ddlPRState.SelectedValue = ""
            txtPRZip.Text = ""

            txtPRSignature.Enabled = False
            txtPRSignature.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
            txtPRSignatureDate.Enabled = False
            txtPRSignatureDate.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
            txtPRLastName.Enabled = False
            txtPRLastName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
            txtPRFirstName.Enabled = False
            txtPRFirstName.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
            txtPRAddress.Enabled = False
            txtPRAddress.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
            txtPRCity.Enabled = False
            txtPRCity.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
            ddlPRState.Enabled = False
            ddlPRState.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
            txtPRZip.Enabled = False
            txtPRZip.BackColor = System.Drawing.ColorTranslator.FromHtml("#f5f5f5")
        End If
    End Sub
#End Region

#Region "Load Section 2 Drop downs"
    Private Sub PopulateDocumentDropDowns()
        Session("ds") = New DataSet
        If chkCitizen.Checked Or chkNonCitizen.Checked Or chkPermResident.Checked Or chkTempVisa.Checked Then
            ec.GetEmployeeI9Documents(chkCitizen.Checked, chkNonCitizen.Checked, chkPermResident.Checked, chkTempVisa.Checked, Session("ds"))
            ddlListADocument.DataSource = Session("ds").tables(0)
            ddlListADocument.DataBind()
            ddlListBDocument.DataSource = Session("ds").tables(1)
            ddlListBDocument.DataBind()
            ddlListCDocument.DataSource = Session("ds").tables(2)
            ddlListCDocument.DataBind()

            txtListAAuthority.Text = ""
            txtListAAuthority2.Text = ""
            txtListAAuthority3.Text = ""
            txtListADocNum1.Text = ""
            txtListADocNum2.Text = ""
            txtListADocNum3.Text = ""
            txtListAExpDate1.Text = ""
            txtListAExpDate2.Text = ""
            txtListAExpDate3.Text = ""

            txtListBAuthority.Text = ""
            txtListBDocNum.Text = ""
            txtListBExpDate.Text = ""

            txtListCAuthority.Text = ""
            txtListCDocNum.Text = ""
            txtListCExpDate.Text = ""

            txtListAAuthority.Visible = True
            ddlListAAuthority.Visible = False
            txtListBAuthority.Visible = True
            ddlListBAuthority.Visible = False
            txtListCAuthority.Visible = True
            ddlListCAuthority.Visible = False
        End If
    End Sub

    Protected Sub ddlListADocument_SelectedIndexChanged(sender As Object, e As EventArgs)
        If ec.GetEmployeeI9DocumentAuthority(ddlListADocument.SelectedValue, ddlListAAuthority) Then
            txtListAAuthority.Visible = False
            ddlListAAuthority.Visible = True
        Else
            txtListAAuthority.Visible = True
            ddlListAAuthority.Visible = False
        End If

        txtListADocument2.Text = "N/A"
        txtListADocument3.Text = "N/A"

        txtListAAuthority2.Text = "N/A"
        txtListAAuthority3.Text = "N/A"

        txtListADocNum2.Text = "N/A"
        txtListADocNum3.Text = "N/A"

        txtListAExpDate2.Text = "N/A"
        txtListAExpDate3.Text = "N/A"

        ddlListBDocument.SelectedIndex = 0
        txtListBAuthority.Visible = True
        ddlListBAuthority.Visible = False
        txtListBAuthority.Text = "N/A"
        txtListBDocNum.Text = "N/A"
        txtListBExpDate.Text = "N/A"

        ddlListCDocument.SelectedIndex = 0
        txtListCAuthority.Visible = True
        ddlListCAuthority.Visible = False
        txtListCAuthority.Text = "N/A"
        txtListCDocNum.Text = "N/A"
        txtListCExpDate.Text = "N/A"
    End Sub

    Protected Sub ddlListBDocument_SelectedIndexChanged(sender As Object, e As EventArgs)
        If ec.GetEmployeeI9DocumentAuthority(ddlListBDocument.SelectedValue, ddlListBAuthority) Then
            txtListBAuthority.Visible = False
            ddlListBAuthority.Visible = True
        Else
            txtListBAuthority.Visible = True
            txtListBAuthority.Text = ""

            ddlListBAuthority.Visible = False
        End If

        ddlListADocument.SelectedIndex = 0
        txtListAAuthority.Visible = True
        ddlListAAuthority.Visible = False
        txtListAAuthority.Text = "N/A"
        txtListAAuthority2.Text = "N/A"
        txtListAAuthority3.Text = "N/A"
        txtListADocNum1.Text = "N/A"
        txtListADocNum2.Text = "N/A"
        txtListADocNum3.Text = "N/A"
        txtListAExpDate1.Text = "N/A"
        txtListAExpDate2.Text = "N/A"
        txtListAExpDate3.Text = "N/A"
    End Sub

    Protected Sub ddlListCDocument_SelectedIndexChanged(sender As Object, e As EventArgs)
        If ec.GetEmployeeI9DocumentAuthority(ddlListCDocument.SelectedValue, ddlListCAuthority) Then
            txtListCAuthority.Visible = False
            ddlListCAuthority.Visible = True
        Else
            txtListCAuthority.Visible = True
            txtListCAuthority.Text = ""
            ddlListCAuthority.Visible = False
        End If

        ddlListADocument.SelectedIndex = 0
        txtListAAuthority.Visible = True
        ddlListAAuthority.Visible = False
        txtListAAuthority.Text = "N/A"
        txtListAAuthority2.Text = "N/A"
        txtListAAuthority3.Text = "N/A"
        txtListADocNum1.Text = "N/A"
        txtListADocNum2.Text = "N/A"
        txtListADocNum3.Text = "N/A"
        txtListAExpDate1.Text = "N/A"
        txtListAExpDate2.Text = "N/A"
        txtListAExpDate3.Text = "N/A"
    End Sub

#End Region

#Region "Load Section 2 and 3 Helpbuttons"
    Protected Sub bntListADocumentHelp_Click(sender As Object, e As EventArgs)
        divHelpSection2.Visible = True
        lblSection2Title.Text = "<strong>Document Title #1 List A</strong>"
        lblSection2Text.Text = "If the employee presented documentation from List A, select the document or receipt
                                presented from the drop-down list provided. If the employee presented a List A document that
                                consists of a combination of documents, select the first document from the drop-down list
                                provided. The other documents in the combination should be entered in the separate areas
                                provided.<br/><br/>

                                All documents must be unexpired. Ensure that each document is an unexpired, original (no
                                photocopies, except for certified copies of birth certificates) document. Certain employees
                                may present an expired employment authorization document, which may be considered
                                unexpired, if the employee’s employment authorization has been extended by regulation or a
                                Federal Register Notice. Refer to the instructions for more information. .<br/><br/>

                                The documents below the dotted line in the drop-down are unacceptable for the citizenship or
                                immigration status the employee selected in Section 1. If you receive an error message after
                                selecting one of these documents, ensure that you selected the correct number in the
                                Citizenship/Immigration Status field that correlates to the citizenship or immigration status box
                                the employee checked in Section 1. If this area was automatically populated, have the
                                employee review the information he or she entered on the printed and signed copy of Section
                                1, make any required corrections in Section 1, then initial and date those corrections. You may
                                then correct the number in the Employee Info field, which should provide the correct list of
                                acceptable documents.
                                .<br/><br/>
                                If the employee did not present a List A combination document, the second and third
                                Document Title fields will contain N/A.
                                .<br/><br/>
                                An entry in this column allows all fields in the List B and C columns to contain N/A. If you did
                                this in error, select a document from the drop-down list provided in List B. All fields in the List
                                A column will then contain N/A, and you will then be able to complete the List B and List C
                                columns."

    End Sub

    Protected Sub bntListBDocumentHelp_Click(sender As Object, e As EventArgs)
        divHelpSection2.Visible = True
        lblSection2Title.Text = "<strong>Document Title List B</strong>"
        lblSection2Text.Text = "If the employee presented an acceptable document Or an acceptable receipt for a
                                List B document, select the document Or receipt presented from the drop-down list
                                provided.All documents must be unexpired. If you make an entry In this column, you
                                must also make an entry in the List C column. .<br/><br/>


                                If an Then employer participates In E-Verify And the employee presents a List B document,
                                the List B document must include a photograph. .<br/><br/>

                                If a Then parent Or legal guardian attested either To the identity Of an employee who Is a
                                minor(individual under age 18) who cannot present an identity document Or To the
                                identity of certain employees with disabilities in Section 1, select either ""minor under
                                age 18"" (for a minor) Or ""special placement"" (for an employee with disabilities) from
                                the drop - down provided. Refer to the instructions And the Handbook for Employers
                                Guidance for Completing Form I-9 (M-274) for more guidance on minors And certain
                                person with disabilities. .<br/><br/>

                                The documents below the dotted line in the drop-down are unacceptable for the
                                citizenship Or immigration status the employee selected in Section 1. If you receive an
                                Error message after selecting one Of these documents, ensure that you selected the
                                correct Number in the Citizenship/Immigration Status area that correlates to the
                                citizenship Or immigration status box the employee selected in Section 1. If this area
                                was automatically populated, have the employee review the information he Or she
                                entered on the printed And signed copy of Section 1, make any required corrections in
                                Section 1, then initial And date those corrections. You may then correct the number in
                                the Employee Info field, which should provide the correct list of acceptable
                                documents. .<br/><br/>

                                An entry in this column allows all fields in the List A column to contain N/A. If you did
                                this in error, select a document in the List A drop-down. This field column And the List
                                C column will then contain N/A. You may then complete the List A column."

    End Sub

    Protected Sub bntListCDocumentHelp_Click(sender As Object, e As EventArgs)
        divHelpSection2.Visible = True
        lblSection2Title.Text = "<strong>Document Title List C</strong>"
        lblSection2Text.Text = "If the Then employee presented an acceptable document from List C Or an acceptable receipt For a
                                List C document, select the document Or receipt presented from the drop-down list provided.
                                All documents must be unexpired. An unexpired document includes a document where the
                                expiration Date shown On the face Of a document has been extended, such as conditional
                                residents who show an extended conditional resident card with a Form I-797 as a List C
                                document.
                                If you chose DHS-issued employment authorization Or Receipt DHS-issued employment
                                authorization From the drop-down list provided in the Document Title field, this field will contain
                                the words ""List C #7,"" after which you should enter the title of the document. Abbreviations are
                                acceptable.
                                If you make an entry In this column, you must also make an entry In the List B column, If you
                                have Not already done so.
                                An entry in this column allows all fields in the List A column to contain N/A. If you did this in
                                Error, select N/A from the drop-down list provided. You will then be able to select a document in
                                a different column field.
                                The documents below the dotted line in the drop-down do Not match the citizenship Or
                                immigration status the employee selected in Section 1. If you receive an error message after
                                selecting one Of these documents, ensure that you selected the correct number in the
                                Citizenship/ Immigration Status field that correlates to the citizenship Or immigration status box
                                the Employee selected in Section 1 as noted on the employee's printed and signed copy of
                                            Section 1.If this area was automatically populated, have the employee review the information
                                he Or she entered On the printed And signed copy Of Section 1, make any required corrections in
                                Section 1, then initial And date those corrections. You may then correct the number in the
                                Employee Info field, which should provide the correct list of acceptable documents.
                                An entry in this column allows all fields in the List A column to contain N/A. If you did this in
                                Error, select a document in the List A drop-down. This column And the List B column will then
                                contain N / A.You may then complete the List A column."


    End Sub

    Protected Sub btnListAIssuingHelp_Click(sender As Object, e As EventArgs)
        divHelpSection2.Visible = True
        lblSection2Title.Text = "<strong>Issuing Authority #1 List A</strong>"
        lblSection2Text.Text = "Select from the drop-down list the issuing authority of the List A document or receipt you entered in the first Document Title field.The issuing authority is the entity that issued the document. .<br/><br/>

                                        If the employee presented a List A document that consists of a combination of documents, use the second and third Issuing Authority fields as necessary. .<br/><br/>

                                        If the issuing authority provide in the drop-down list does not match the issuing authority shown on the document presented, ensure that you made the correct selection in the Document Title Field."

    End Sub

    Protected Sub btnListBIssuingHelp_Click(sender As Object, e As EventArgs)
        divHelpSection2.Visible = True
        lblSection2Title.Text = "<strong>Issuing Authority List B</strong>"
        lblSection2Text.Text = "Select from the drop-down list the issuing authority of the List A document or receipt you entered in the first Document Title field. The issuing authority is the entity that issued the document or receipt. .<br/><br/>

                                If you selected a document or receipt issued by a state in the Document Title field, select the state or territory that issued the document or receipt from the drop-down list provided. .<br/><br/>

                                If no drop-down is provided for a particular selection, enter the issuing authority exactly as it appears on the document or receipt. .<br/><br/>

                                If the issuing authority provide in the drop-down list does not match the issuing authority shown on the document presented, ensure that you made the correct selection in the Document Title Field."

    End Sub

    Protected Sub btnListCIssuingHelp_Click(sender As Object, e As EventArgs)
        divHelpSection2.Visible = True
        lblSection2Title.Text = "<strong>Issuing Authority List C </strong>"
        lblSection2Text.Text = "Select from the drop-down list the issuing authority of the List A document or receipt you entered in the first Document Title field. The issuing authority is the entity that issued the document or receipt. .<br/><br/>

                                If an issuing authority drop-down is not provided, enter the issuing authority exactly as it appears on the document or receipt you entered in the Document Title field in this column. .<br/><br/>

                                If the issuing authority provide in the drop-down list does not match the issuing authority shown on the document or receipt presented, ensure that you made the correct selection in the Document Title Field in this column."
    End Sub

    Protected Sub btnListADocNumberHelp_Click(sender As Object, e As EventArgs)
        divHelpSection2.Visible = True
        lblSection2Title.Text = "<strong>Document Number #1 List A </strong>"
        lblSection2Text.Text = "Enter the document number, if any, exactly as it appears on the document you entered in the first Document Title field. <br/><br/>
                                If you chose a receipt in the Document Title field, you should enter the receipt number, if any, exactly as it appears on the receipt. <br/><br/>
                                If the document does not contain a number, enter N/A. <br/><br/>
                                If the employee presented a combination of document, use the second and third Document Number fields as necessary."
    End Sub

    Protected Sub btnListBDocNumberHelp_Click(sender As Object, e As EventArgs)
        divHelpSection2.Visible = True
        lblSection2Title.Text = " < strong >Document Number List B </strong>"
        lblSection2Text.Text = "Enter the document number, if any, exactly as it appears on the document you entered in the Document Title field. If the document does not contain a number, enter N/A. <br/><br/>
                                If you chose a receipt in the Document Title field, you should enter the receipt number, if any, exactly as it appears on the receipt. <br/><br/>"
    End Sub

    Protected Sub btnListCDocNumberHelp_Click(sender As Object, e As EventArgs)
        divHelpSection2.Visible = True
        lblSection2Title.Text = "<strong>Document Number List C </strong>"
        lblSection2Text.Text = "Enter the document number, if any, exactly as it appears on the document you entered in the Document Title field. If the document does not contain a number, enter N/A. <br/><br/>
                                If you chose a receipt in the Document Title field, you should enter the receipt number, if any, exactly as it appears on the receipt. <br/><br/>"

    End Sub

    Protected Sub btnListAExpirationDate_Click(sender As Object, e As EventArgs)
        divHelpSection2.Visible = True
        lblSection2Title.Text = "<strong>Expiration Date #1 List A</strong>"
        lblSection2Text.Text = "Enter the expiration date, if any, of the document or receipt you entered in the first Document Title field. A document is not acceptable if it has already expired. An unexpired document includes a document where the expiration date shown on the face of a document has been atomically extended, such as for individuals with Temporary Protected Status. <br/> <br/>
                                If the document uses text rather than a date to indicate when it expires, enter the text shown on the documents, such as ""D/S"" which means, ""duration Of status""). If the document does not contain an expiration date, enter N/A. If the employee presented a combination of documents, used the second and third Expiration Date fields as necessary.  For a receipt, enter the expiration date of the receipt validity period.
                                <ol>
                                <li style = 'color:#014679;'>For a receipt showing that the employee has applied to replace a document that was lost, stolen or damaged, enter the date that is 90 days from the first day of work for pay.
                                </li>
                                <li style = 'color:#014679;'>For a receipt that is the arrival portion of Form I-94/I-94A containing a temporary I-551 stamp and a photograph of the individual, enter the expiration date of the stamp or, if there is no expiration date, within one year from the date of admission.
                                </li>
                                <li style = 'color:#014679;'>For a receipt that is the departure portion of Form I-94/I-94A with a refugee admission stamp, enter a date that is 90 days from the first day of work for pay.
                                </li>
                                </ol>"
    End Sub

    Protected Sub btnListBExpirationDate_Click(sender As Object, e As EventArgs)
        divHelpSection2.Visible = True
        lblSection2Title.Text = "<strong>Expiration Date List B</strong>"
        lblSection2Text.Text = "Enter the expiration date, if any, of the document or receipt you entered above.  The document is not acceptable if it is already expired.  If the document or receipt has no expiration date, enter N/A.<br/><br/>
                                However, for a receipt showing that the employee has applied to replace a document that was lost stolen or damaged, enter the expiration date of the receipt validity period which is 90 days from the first day of work for pay."
    End Sub

    Protected Sub btnListCExpirationDate_Click(sender As Object, e As EventArgs)
        divHelpSection2.Visible = True
        lblSection2Title.Text = "<strong>Expiration Date List C</strong>"
        lblSection2Text.Text = "Enter the expiration date, if any, of the document or receipt you entered above.  If the document or receipt has no expiration date, enter N/A. The document is not acceptable if it has already expired, unless USCIS has extended the expiration date on the document. <br/>  <br/>  
                                For instance, if a conditional resident presents an expired Form I-551 in combination with a Form i-797 extending his or her conditional resident status with the employee’s expired Form I-551, enter the future expiration date as indicated on the Form I-797. <br/>  <br/>  
                                For a receipt, enter the expiration date of the receipt validity period.
                                <ol>
                                <li style = 'color:#014679;'>For a receipt showing that the employee has applied to replace a document that was lost, stolen or damaged, enter the date that is 90 days from the first day of work for pay.
                                </li>
                                <li style = 'color:#014679;'>For a receipt that is the arrival portion of Form I-94/I-94A containing a temporary I-551 stamp and a photograph of the individual, enter the expiration date of the stamp or, if there is no expiration date, within one year from the date of admission.
                                </li>
                                <li style = 'color:#014679;'>For a receipt that is the departure portion of Form I-94/I-94A with a refugee admission stamp, enter a date that is 90 days from the first day of work for pay.
                                </li>
                                </ol>"
    End Sub



    'SECTION 3
    Protected Sub btnNewNameHelp_Click(sender As Object, e As EventArgs)
        divHelpSection3Top.Visible = True
        lblHelpSection3TopTitle.Text = "<strong>New Name <i>(if applicable)</i></strong>"
        lblHelpSection3TopText.Text = "Complete Block A if:
                                        <br/><br/>
                                        <ol>
                                        <li style = 'color:#014679;'>You are reverifying employment authorization and the employee’s name has changed since the previous verification.
                                         </li>
                                        <li style = 'color:#014679;'>You are rehiring an employee whose name has changed since last completing Form I-9.
                                        </li>
                                        </ol>"
    End Sub

    Protected Sub btnRehireDateHelp_Click(sender As Object, e As EventArgs)
        divHelpSection3Top.Visible = True
        lblHelpSection3TopTitle.Text = "<strong>Date of Rehire <i>(if applicable)</i></strong>"
        lblHelpSection3TopText.Text = "Complete this block if you are rehiring an employee within 3 years of the date Form I-9 was orginally completed. <br/><br/>
                                        Enter the date of rehire in this field. <br/><br/>
                                        Enter N/A in this field if the employee is not being rehired. If the employee is being rehired, but it has been more than 3 years from the date Form I-9 was originally completed, a new Form I-9 must be completed."

    End Sub

    Protected Sub btnRVDocTitleHelp_Click(sender As Object, e As EventArgs)
        divHelpSection3Bottom.Visible = True
        lblHelpSection3BottomTitle.Text = "<strong>Document Title</strong>"
        lblHelpSection3BottomText.Text = "Complete this block if you are reverifying expiring or expired employment authorization from Section 1 or employment authorization documentation that is subject to reverification of a current or rehired employee. Enter the information from the List A or List C documents(s) (or receipt) that the employee presented to reverify his or her employment authorization. All documents must be unexpired. An unexpired document includes a document where the expiration date shown on the face of a document has been extended, such as for individuals with Temporary Protected Status.
                                        <br/><br/>
                                        Reverification in Section 3 must be completed prior to the earlier of:
                                        <ul>
                                        <li style = 'color:#014679;'>The expiration date, if any, of the employment authorization stated in Section 1, or </li>
                                        <li style = 'color:#014679;'>The expiration date, if any, of the List A or List C employment authorization document recorded in Section 2 (with some exceptions listed below.)</li>
                                        </ul>
                                        Some employees may have entered N/A in the expiration date field in Section 1 if they are aliens whose employment authorization does no expire, e.g., asylees, refugees, certain citizens of the Federated States of Micronesia, the Republic of the Marshall Islands, or Palau. Reverification applies to such employees if they chose to present evidence of employment authorization in Section 2 that contains an expiration date, such as Form I-766, Employment Authorization Document.
                                        <br/><br/>
                                        You should not reverify U.S. citizens and noncitizen nationals, or lawful permanent residents (including conditional residents) who presented a Permanent Resident Card (Form I-551). <br/><br/>
                                        Select the List A or C document (or receipt) the employee presented to show current employment authorization from the drop-down list provided. <br/><br/>
                                        If you are completing this field for an employee who is continuing in his or her employment or being rehired within 3 years, and that employee remains authorized to work on the previously executed Form I-9 and the originally executed Form I-9 is the current version, enter N/A in this field.  The other fields in Block C will then contain N/A as well. If you have done this in error, select a different document from the drop-down list."
    End Sub

    Protected Sub btnRVDocNumHelp_Click(sender As Object, e As EventArgs)
        divHelpSection3Bottom.Visible = True
        lblHelpSection3BottomTitle.Text = "<strong>Document Number</strong>"
        lblHelpSection3BottomText.Text = "Enter the document number, if any, of the document or receipt you entered in the Document Title field.  Enter N/A if the document or receipt does not have a number.  If the document is a receipt, enter the word ""receipt"" in this field."
    End Sub

    Protected Sub btnRVDocExpDateHelp_Click(sender As Object, e As EventArgs)
        divHelpSection3Bottom.Visible = True
        lblHelpSection3BottomTitle.Text = "<strong>Document Expiration Date <i>(if any)(mm/dd/yyyy)</i></strong>"
        lblHelpSection3BottomText.Text = "Enter the expiration date, if any, of the document or receipt you entered in Document Title field of this block.
                                        <br/><br/>
                                          For a receipt, enter the expiration date of the receipt validity period.
                                                                        <ol>
                                                                        <li style = 'color:#014679;'>For a receipt showing that the employee has applied to replace a document that was lost, stolen or damaged, enter the date that is 90 days from the first day of work for pay.
                                                                        </li>
                                                                        <li style = 'color:#014679;'>For a receipt that is the arrival portion of Form I-94/I-94A containing a temporary I-551 stamp and a photograph of the individual, enter the expiration date of the stamp or, if there is no expiration date, within one year from the date of admission.
                                                                        </li>
                                                                        <li style = 'color:#014679;'>For a receipt that is the departure portion of Form I-94/I-94A with a refugee admission stamp, enter a date that is 90 days from the first day of work for pay.
                                                                        </li>
                                                                        </ol>
                                        If the document does not contain an expiration date, enter N/A."
    End Sub

#End Region

#Region "Next Click"
    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        If Session("Admin") = False And divError.Visible = False Then
            SaveSection1()
            ResetScrollPosition()
            divSuccess.Visible = True
            divMainArticalTitleandText.Visible = False
            lblSuccess.Text = Session("ScreenShortDesc") + " Form Complete"
            Response.AddHeader("REFRESH", "0;URL=" + Session("NextScreen"))
            imgNext.Visible = False

            s.SaveUserUpdate(intUserId, Session("ScreenName"), "Clicked Next on " + strScreenShortDesc, intEmployeeId, 0, 0, "01/01/1900", intTransactionId)
        ElseIf Session("Admin") = True Then
            SaveSection1()
            If divEECheckboxError.Visible = False And divPermResError.Visible = False And divEEAlienError.Visible = False And divEESignatureError.Visible = False And divEEPreparerError.Visible = False Then
                SaveSection2()
                If divERSection2ErrorTop.Visible = False And divERSection2ErrorBottom.Visible = False Then
                    SaveSection3()
                    If divERSection3Error.Visible = False Then
                        ResetScrollPosition()
                        divSuccess.Visible = True
                        divMainArticalTitleandText.Visible = False
                        lblSuccess.Text = Session("ScreenShortDesc") + " Form Complete"
                        Response.AddHeader("REFRESH", "0;URL=" + Session("NextScreen"))
                        imgNext.Visible = False

                        s.SaveUserUpdate(intUserId, Session("ScreenName"), "Clicked Next on " + strScreenShortDesc, intEmployeeId, 0, 0, "01/01/1900", intTransactionId)
                    End If
                End If
            End If

        Else
            ResetScrollPosition()
            divSuccess.Visible = True
            divMainArticalTitleandText.Visible = False
            lblSuccess.Text = Session("ScreenShortDesc") + " Form Complete"
            s.SaveUserUpdate(intUserId, Session("ScreenName"), "Clicked Next on " + strScreenShortDesc, intEmployeeId, 0, 0, "01/01/1900", intTransactionId)
            Response.AddHeader("REFRESH", "0;URL=" + Session("NextScreen"))
            imgNext.Visible = False
            
        End If

    End Sub

#End Region

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
