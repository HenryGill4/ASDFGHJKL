Imports System.Data.SqlClient
Imports Newtonsoft.Json
'11/10/2021 - last change was to fix PCP Table to show.  The page was erroring after we tried to hide it unless needed.
'11/23/2021 - Changed to recognize that H.S.A. (as apposed to HSA) is going through regular Ben Modal (which is good as do not need the bank info) - however needed to allow PlanTypeId 9,10, and 19 to save on Next to get any dep ben changes committed.
'12/05/2021 - Changed Waive Question boxes formatting

Public Class EE_Plans
    Inherits System.Web.UI.Page
    Dim sc As New ScreenConfiguration
    Dim SecClass As New Security
    Dim ec As New Employee
    Dim DepClass As New Dependent
    Dim PlanClass As New Plans
    Dim intEventTypeId As Integer
    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intPlanTypeId As Integer
    Dim intNextPlanTypeId As Integer
    Dim intPlanId As Integer
    Dim intUID As Integer
    Dim intTransactionId As Integer
    Dim intModalId As Integer
    Dim bOkaytoSave As Boolean
    Dim booComplete As Boolean
    Dim booCompleteDetails As Boolean
    Dim strDetailError As String
    Dim booIntheMiddleofaSave As Boolean
    Dim booFinalCheckofDeps As Boolean
    Dim bolJustloadingPage As Boolean
    Dim bolShowPlanOptions As Boolean
    Dim bolAlreadyRanOnce As Boolean
    Dim bolSavingDetails As Boolean
    Dim strEmployeeName As String
    Dim strEventType As String

    Dim TblPCP As New DataTable
    Dim Col1 As New DataColumn()
    Dim Col2 As New DataColumn()
    Dim Col3 As New DataColumn()
    Dim Col4 As New DataColumn()
    Dim Col5 As New DataColumn()
    Dim Col6 As New DataColumn()
    Dim EEPCP As String
    Dim CurrentPatient As Boolean
    Dim EEName As String

    Dim booGotEmployee As Boolean
    Dim booGotPlans As Boolean
    Dim booFoundModal As Boolean

    Dim strScreenName As String
    Dim strScreenShortDesc As String


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EEPlans"
        strScreenShortDesc = "Election Pages"

        If Session("Admin") = True Then
            intCompanyId = Session("ShadowCompanyId")
            intEmployeeId = Session("ShadowEmployeeId")
            Session("DisplayName") = Session("AdminName")

        Else
            Session("DisplayName") = Session("EmployeeName")

            intCompanyId = Session("CompanyId")
            intEmployeeId = Session("EmployeeId")
        End If

        '''''''''''''''''''''''''''''''''''''''''''''
        ''  INITIAL LOAD 
        '''''''''''''''''''''''''''''''''''''''''''''
        If Page.IsPostBack = False Then
            If Request.Params("pt") Is Nothing Then
                Session("CurrentPlanTypeId") = 0
                GetNavigationAndTabs()
                intPlanTypeId = Session("CurrentPlanTypeId")

                Dim NextPage As String
                NextPage = "~/ee_plans?pt=" + intPlanTypeId.ToString
                Response.Redirect(NextPage)

                Session("Changes") = "None"

            Else
                intPlanTypeId = Session("CurrentPlanTypeId")
                'intNextPlanTypeId = Request.Params("pt")
                'Are we moving to new Plan page but changes have not been saved yet?
                'If intPlanTypeId <> intNextPlanTypeId And Session("Changes") <> "None" And Session("Changes") <> "Saved" Then
                '    SaveAndNextFunction()
                'Else
                'Change to new PTId
                Session("Changes") = "None"
                    LblWaiveErrorMessage.Text = ""
                    Session("CurrentPlanTypeId") = Request.Params("pt")
                    intPlanTypeId = Session("CurrentPlanTypeId")
                    GetNavigationAndTabs()
                'End If

            End If

            divError.Visible = False

            booIntheMiddleofaSave = False
            bolAlreadyRanOnce = False
            bolSavingDetails = False
            bolJustloadingPage = True


            SecClass.SaveUserUpdate(Session("UserId"), strScreenName, "Browse", intEmployeeId, 0, intPlanTypeId, "01/01/1900", intTransactionId)

            PlanClass.PopulatePendingBenefitSummary(intCompanyId, intEmployeeId, grdSummary)
            SetProgressBar()

            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), Session("ScreenName"))
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")

            intUID = Session("UserId")
            ec.GetEmployeeEventInfo(intEmployeeId, intUID, intPlanTypeId, intCompanyId)
            Session("EventType") = ec.EventLongDesc
            Session("EventTypeId") = ec.EventTypeId
            intEventTypeId = Session("EventTypeId")
            Session("EventDate") = ec.EventDate

            'Clear out Session Variables
            Session.Remove("SelectedPlanId")
            Session.Remove("EECovered")
            Session.Remove("SPCovered")
            Session.Remove("DPCovered")
            Session.Remove("NumOfDeps")
            Session.Remove("dsExistingElection")
            Session.Remove("ChildIds")
            Session.Remove("PCPRequired")
            Session("HasSpouse") = 0
            Session("HasChild") = 0
            Session("SelectedPlanId") = -1
            Session("Hidesome") = True

            'Load up side panel with Employee's information (regardless if Admin or Employee)
            booGotEmployee = ec.GetEmployeeInfo(intCompanyId, intEmployeeId)
            If booGotEmployee = True Then
                lblPayFrequency.Text = "All costs are shown " + ec.DeductionFrequencyDesc
                lblPayFrequency2.Text = "All costs are shown " + ec.DeductionFrequencyDesc
                lblPayFrequency3.Text = "All costs are shown " + ec.DeductionFrequencyDesc
                mlblPayFrequency.Text = "All costs should be entered as " + ec.DeductionFrequencyDesc

                'Covered Dependents Gridview - populate with all Dependents if Benefit Allows for that (probably need flag?)
                Dim strDependentType As String
                strDependentType = "COV"
                DepClass.PopulateDepBenList(intCompanyId, intEmployeeId, strDependentType, 1, intPlanTypeId, grdCoveredDependents)

                'Beneficiaries Gridview - populate with all Beneficiaries if Benefit Allows for that (probably need flag?)
                strDependentType = "BEN"
                DepClass.PopulateDepBenList(intCompanyId, intEmployeeId, strDependentType, 1, intPlanTypeId, grdBeneficiaries)

                If divError.Visible = False Then
                    UpdateScreenBlocks(Session("CurrentPlanTypeId")) 'This includes CheckCompletePlanQuestions'

                    GetExistingElection()

                    GetNewPlanOptions()

                    BuildLearnSection()

                End If

            End If

            imgShowLearn.Visible = False
            imgHideLearn.Visible = False

        Else  'Postback
            'if the postback was from a user changing question details
            If Not Me.Request("__EVENTTARGET") Is Nothing AndAlso Me.Request("__EVENTTARGET") = "SaveQuestionDetail" AndAlso Not Me.Request("__EVENTARGUMENT") Is Nothing Then
                'If Session("Rebuild") = False Then
                'Get parameters from postback
                Dim deserializedParameters As QuestionDetail = JsonConvert.DeserializeObject(Of QuestionDetail)(Request("__EVENTARGUMENT"))

                'Save the question details to the database as the user changes the input to avoid having to save the whole form
                SaveQuestionDetail(deserializedParameters)

                'Else apparently we dont need this now that took out the top row of detail grid
                BuildQuestionDetailsAgain(sender, e)

                GetNavigationAndTabs()

                bolSavingDetails = True
                btnEditResponses.Visible = False
                btnSavePlanQuestions.Visible = True
                lblPlanQuestions.Visible = False
                grdOptions.Enabled = False

            Else
                intEventTypeId = Session("EventTypeId")
                intEmployeeId = intEmployeeId
                'grdOptions.Enabled = False
                'grdCoveredDependents.Enabled = False
            End If

        End If

        lblEventType.Text = "Event Type:  " + IIf(Session("EventType") = "No Event Declared", "<span style='color:red'>No Event Declared</span>", Session("EventType"))
        lblEventDate.Text = "Effective Date:  " + Session("EventDate")



            imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/Processing.gif';")
        ImgBottomNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(ImgBottomNext, "") + ";this.src='/img/Processing.gif';")

        'INTERESTING - The below disabled chkWaiveQ1 and invoked the SAVE via NEXT BUTTON - how to use this method to hide the next buttons instead of invoking them
        'chkWaiveQ1.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(ImgBottomNext, "") + ";this.src='/img/Processing.gif';")

        booFinalCheckofDeps = True
        bolJustloadingPage = False


    End Sub

    Public Sub GetNavigationAndTabs()
        If Session("CurrentPlanTypeId") Is Nothing And Request.Params("pt") Is Nothing Then
            intPlanTypeId = 0  'Initial Page Load nothing loaded
        ElseIf Not Request.Params("pt") Is Nothing Then
            intPlanTypeId = Request.Params("pt")  'Direct click on tab or after clicking Next
            Session("CurrentPlanTypeId") = intPlanTypeId
        ElseIf Not Session("CurrentPlanTypeId") Is Nothing Then
            intPlanTypeId = Session("CurrentPlanTypeId")  'A page refresh on first page
        End If

        If sc.GetNavigation(Session("UserId"), intEmployeeId, strScreenName, intPlanTypeId) = True Then
            Session("ScreenName") = sc.ScreenName
            Session("ScreenPath") = sc.ScreenPath
            Session("TabString") = sc.TabString
            ltrBenTabs.Text = sc.SubTabString
            Session("PlanTypeShortDesc") = sc.PlanTypeShortDesc
            Session("PlanTypeLongDesc") = sc.PlanTypeLongDesc
            Session("PlanTypeCommentTitle") = sc.PlanTypeCommentTitle
            Session("PlanTypeCommentShortDesc") = sc.PlanTypeCommentShortDesc
            Session("PlanTypeCommentLongDesc") = sc.PlanTypeCommentLongDesc
            Session("PlanModalType") = sc.PlanModalType
            Session("PlanModalId") = sc.PlanModalId
            Session("WaivePlanId") = sc.WaivePlanId
            Session("WaiveAllowed") = sc.WaiveAllowed
            Session("WaiveRateId") = sc.WaiveRateId
            Session("WaiveModalType") = sc.WaiveModalType
            Session("WaiveModalId") = sc.WaiveModalId
            Session("LatestEventDesc") = sc.LatestEventDesc
            Session("LatestEventDate") = sc.LatestEventDate
            Session("LatestEventTypeId") = sc.LatestEventTypeId
            Session("ExistingPlanFullDesc") = sc.ExistingPlanFullDesc
            Session("ExistingCoverageDesc") = sc.ExistingCoverageDesc
            Session("TobaccoBased") = sc.TobaccoBased
            Session("TobaccoCoverageId") = sc.TobaccoCoverageId
            Session("PlanQuestions") = sc.PlanQuestions
            Session("WaiveQuestions") = sc.WaiveQuestions
            Session("DisplayDepBenType") = sc.DisplayDepBenType
            Session("OrderById") = sc.OrderById
            Session("PCPRequired") = sc.PCPRequired
            Session("ShowERRates") = sc.ShowERRates

            Session("CurrentPlanTypeId") = sc.PlanTypeId

            Session("NextPlanTypeId") = sc.NextPlanTypeId

        End If

    End Sub

    Public Sub UpdateScreenBlocks(ByVal intPlanTypeId As Integer)
        'Session.Remove("ModalBenefitAmount")

        'If no data is returned hide all and show error message
        If Session("PlanTypeShortDesc") Is Nothing Then
            divError.Visible = True
            lblError.Text = "There are no options available for the effective date of the event And your current benefit class. <br/> Please correct the data entered - Or contact your HR Administrator for further assistance.<br/>"
            divPlanTypeTabs.Visible = False
            divMainForm.Visible = False
            imgNext.Visible = False
            ImgBottomNext.Visible = False

            Exit Sub
        End If

        'If there is data build Top Banner and Learn Section
        If Session("PlanTypeShortDesc") <> "" Then
            'Get Data for Top Banner
            lblPlanType.Text = Session("PlanTypeLongDesc")
            lblEventDate.Text = "Effective Date:   " + Session("LatestEventDate")
            If InStr(Session("ExistingPlanFullDesc"), "Decline") > 0 Then
                lblCurrentElection.Text = "Waived"
            ElseIf Session("ExistingPlanFullDesc") <> "" Then
                lblCurrentElection.Text = Session("ExistingPlanFullDesc") + " - " + Session("ExistingCoverageDesc")
            Else
                lblCurrentElection.Text = "None"
            End If

            'Get Data for Learn Section
            lblCommentTitle.Text = Session("PlanTypeCommentTitle")
            lblCommentShort.Text = Session("PlanTypeCommentShortDesc")
            lblComment.Text = Session("PlanTypeCommentLongDesc")
            lblRateOptions.Text = "<strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Rate Comparison"

        End If

        If Session("EventType") = "No Event Declared" Then
            rdElect.Enabled = False
            rdWaive.Enabled = False
            btnSaveWaiveQuestions.Enabled = False
            grdBeneficiaries.Enabled = False
            grdCoveredDependents.Enabled = False
            grdPlanQuestions.Enabled = False
            grdOptions.Enabled = False
            grdPCP.Enabled = False
            divError.Visible = True
            lblError.Text = "Since No Event is currently active these pages are view only"
            imgNext.Visible = False
            ImgBottomNext.Visible = False
        End If

        'Determine if Elect or Waive Section should show
        If Session("WaiveAllowed") = False Then
            divElectOrDecline.Visible = False
            DivWaiveQuestions.Visible = False
        Else
            divElectOrDecline.Visible = True

            'Determine if there are Modals and which ones
            'Start by setting all Modals to not visible 
            divElectWaiveNoModal.Visible = False
            divWaiveWithInfoModal.Visible = False
            divWaiveWithModal.Visible = False
            divElectWithModal.Visible = False
            divElectWaiveBothWithInfoModal.Visible = False
            divElectWaiveBothWithModal.Visible = False

            'Determine if there is a modal and which one to present
            If Session("PlanModalId") > 0 And Session("PlanModalType") = "InformationOnly" And Session("WaiveModalId") > 0 And Session("WaiveModalType") = "InformationOnly" And Session("WaiveQuestions") = False Then
                divElectWaiveBothWithInfoModal.Visible = True
            ElseIf Session("PlanModalId") > 0 And Session("PlanModalType") <> "None" And Session("WaiveModalId") > 0 And Session("WaiveQuestions") = False Then
                divElectWaiveBothWithModal.Visible = True
            ElseIf Session("PlanModalType") = "BenAmt" Or Session("PlanModalType") = "HSA" Or Session("WaiveQuestions") = True Then
                divElectWaiveNoModal.Visible = True
            ElseIf Session("PlanModalType") = "Acknowledge" Then
                divElectWithModal.Visible = True
                mbtnWaiveInfoAcknowledge.Visible = True
            ElseIf Session("WaiveModalType") = "InformationOnly" Then
                divWaiveWithInfoModal.Visible = True
                mbtnWaiveInfoAcknowledge.Visible = False
                mbtnWaiveInfoCancel.Visible = True
            Else
                divElectWaiveNoModal.Visible = True
            End If

            'Get Waive Modal Content - Waive Questions and any previous responses
            If Session("WaiveModalType") <> "" Then
                PlanClass.GetModalContentByModalId(Session("WaiveModalId"), intCompanyId, intEmployeeId)
                mlblWaiveTitle.Text = PlanClass.ModalTitle
                mlblWaiveText1.Text = PlanClass.ModalText1
                mlblWaiveText2.Text = PlanClass.ModalText2
                mlblWaiveText3.Text = PlanClass.ModalText3

                If Session("WaiveQuestions") = True Then
                    chkWaiveQ1.Checked = IIf(PlanClass.ResponseQ1 = "True", True, False)
                    chkWaiveQ2.Checked = IIf(PlanClass.ResponseQ2 = "True", True, False)
                    chkWaiveQ3.Checked = IIf(PlanClass.ResponseQ3 = "True", True, False)
                    chkWaiveQ4.Checked = IIf(PlanClass.ResponseQ4 = "True", True, False)

                    mlblWaiveQ1.Text = PlanClass.ModalQ1
                    mlblWaiveQ2.Text = PlanClass.ModalQ2
                    mlblWaiveQ3.Text = PlanClass.ModalQ3
                    mlblWaiveQ4.Text = PlanClass.ModalQ4
                    mlblModalQuestionId1.Text = PlanClass.ModalQuestionId1
                    mlblModalQuestionId2.Text = PlanClass.ModalQuestionId2
                    mlblModalQuestionId3.Text = PlanClass.ModalQuestionId3
                    mlblModalQuestionId4.Text = PlanClass.ModalQuestionId4

                    If PlanClass.ModalQuestionId1 <> 0 Then
                        If PlanClass.ModalQDId1a = 0 Then
                            mlblWaiveQD1a.Visible = False
                            txtResponseQD1a.Visible = False
                        ElseIf PlanClass.ModalQDId1a <> 0 Then
                            mlblWaiveQD1a.Text = PlanClass.ModalQD1a
                            txtResponseQD1a.Text = PlanClass.ResponseQD1a
                            mlblModalQDId1a.Text = PlanClass.ModalQDId1a
                        End If

                        If PlanClass.ModalQDId1b = 0 Then
                            mlblWaiveQD1b.Visible = False
                            txtResponseQD1b.Visible = False
                        ElseIf PlanClass.ModalQDId1b <> 0 Then
                            mlblWaiveQD1b.Text = PlanClass.ModalQD1b
                            txtResponseQD1b.Text = PlanClass.ResponseQD1b
                            mlblModalQDId1b.Text = PlanClass.ModalQDId1b
                        End If

                        If PlanClass.ModalQDId1c = 0 Then
                            mlblWaiveQD1c.Visible = False
                            txtResponseQD1c.Visible = False
                        ElseIf PlanClass.ModalQDId1c <> 0 Then
                            mlblWaiveQD1c.Text = PlanClass.ModalQD1c
                            txtResponseQD1c.Text = PlanClass.ResponseQD1c
                            mlblModalQDId1c.Text = PlanClass.ModalQDId1c
                        End If

                        If PlanClass.ModalQDId1d = 0 Then
                            mlblWaiveQD1d.Visible = False
                            txtResponseQD1d.Visible = False
                        ElseIf PlanClass.ModalQDId1d <> 0 Then
                            mlblWaiveQD1d.Text = PlanClass.ModalQD1d
                            txtResponseQD1d.Text = PlanClass.ResponseQD1d
                            mlblModalQDId1d.Text = PlanClass.ModalQDId1d
                        End If
                    End If

                    If PlanClass.ModalQuestionId2 <> 0 Then
                        If PlanClass.ModalQDId2a = 0 Then
                            mlblWaiveQD2a.Visible = False
                            txtResponseQD2a.Visible = False
                        ElseIf PlanClass.ModalQDId2a <> 0 Then
                            mlblWaiveQD2a.Text = PlanClass.ModalQD2a
                            txtResponseQD2a.Text = PlanClass.ResponseQD2a
                            mlblModalQDId2a.Text = PlanClass.ModalQDId2a
                        End If

                        If PlanClass.ModalQDId2b = 0 Then
                            mlblWaiveQD2b.Visible = False
                            txtResponseQD2b.Visible = False
                        ElseIf PlanClass.ModalQDId2b <> 0 Then
                            mlblWaiveQD2b.Text = PlanClass.ModalQD2b
                            txtResponseQD2b.Text = PlanClass.ResponseQD2b
                            mlblModalQDId2b.Text = PlanClass.ModalQDId2b
                        End If

                        If PlanClass.ModalQDId2c = 0 Then
                            mlblWaiveQD2c.Visible = False
                            txtResponseQD2c.Visible = False
                        ElseIf PlanClass.ModalQDId2c <> 0 Then
                            mlblWaiveQD2c.Text = PlanClass.ModalQD2c
                            txtResponseQD2c.Text = PlanClass.ResponseQD2c
                            mlblModalQDId2c.Text = PlanClass.ModalQDId2c
                        End If

                        If PlanClass.ModalQDId2d = 0 Then
                            mlblWaiveQD2d.Visible = False
                            txtResponseQD2d.Visible = False
                        ElseIf PlanClass.ModalQDId2d <> 0 Then
                            mlblWaiveQD2d.Text = PlanClass.ModalQD2d
                            txtResponseQD2d.Text = PlanClass.ResponseQD2d
                            mlblModalQDId2d.Text = PlanClass.ModalQDId2d
                        End If
                    End If

                    If PlanClass.ModalQuestionId3 <> 0 Then
                        If PlanClass.ModalQDId3a = 0 Then
                            mlblWaiveQD3a.Visible = False
                            txtResponseQD3a.Visible = False
                        ElseIf PlanClass.ModalQDId3a <> 0 Then
                            mlblWaiveQD3a.Text = PlanClass.ModalQD3a
                            txtResponseQD3a.Text = PlanClass.ResponseQD3a
                            mlblModalQDId3a.Text = PlanClass.ModalQDId3a
                        End If

                        If PlanClass.ModalQDId3b = 0 Then
                            mlblWaiveQD3b.Visible = False
                            txtResponseQD3b.Visible = False
                        ElseIf PlanClass.ModalQDId3b <> 0 Then
                            mlblWaiveQD3b.Text = PlanClass.ModalQD3b
                            txtResponseQD3b.Text = PlanClass.ResponseQD3b
                            mlblModalQDId3b.Text = PlanClass.ModalQDId3b
                        End If

                        If PlanClass.ModalQDId3c = 0 Then
                            mlblWaiveQD3c.Visible = False
                            txtResponseQD3c.Visible = False
                        ElseIf PlanClass.ModalQDId3c <> 0 Then
                            mlblWaiveQD3c.Text = PlanClass.ModalQD3c
                            txtResponseQD3c.Text = PlanClass.ResponseQD3c
                            mlblModalQDId3c.Text = PlanClass.ModalQDId3c
                        End If

                        If PlanClass.ModalQDId3d = 0 Then
                            mlblWaiveQD3d.Visible = False
                            txtResponseQD3d.Visible = False
                        ElseIf PlanClass.ModalQDId3d <> 0 Then
                            mlblWaiveQD3d.Text = PlanClass.ModalQD3d
                            txtResponseQD3d.Text = PlanClass.ResponseQD3d
                            mlblModalQDId3d.Text = PlanClass.ModalQDId3d
                        End If
                    End If

                    If PlanClass.ModalQuestionId4 <> 0 Then
                        If PlanClass.ModalQDId4a = 0 Then
                            mlblWaiveQD4a.Visible = False
                            txtResponseQD4a.Visible = False
                        ElseIf PlanClass.ModalQDId4a <> 0 Then
                            mlblWaiveQD4a.Text = PlanClass.ModalQD4a
                            txtResponseQD4a.Text = PlanClass.ResponseQD4a
                            mlblModalQDId4a.Text = PlanClass.ModalQDId4a
                        End If

                        If PlanClass.ModalQDId4b = 0 Then
                            mlblWaiveQD4b.Visible = False
                            txtResponseQD4b.Visible = False
                        ElseIf PlanClass.ModalQDId4b <> 0 Then
                            mlblWaiveQD4b.Text = PlanClass.ModalQD4b
                            txtResponseQD4b.Text = PlanClass.ResponseQD4b
                            mlblModalQDId4b.Text = PlanClass.ModalQDId4b
                        End If

                        If PlanClass.ModalQDId4c = 0 Then
                            mlblWaiveQD4c.Visible = False
                            txtResponseQD4c.Visible = False
                        ElseIf PlanClass.ModalQDId4c <> 0 Then
                            mlblWaiveQD4c.Text = PlanClass.ModalQD4c
                            txtResponseQD4c.Text = PlanClass.ResponseQD4c
                            mlblModalQDId4c.Text = PlanClass.ModalQDId4c
                        End If

                        If PlanClass.ModalQDId4d = 0 Then
                            mlblWaiveQD4d.Visible = False
                            txtResponseQD4d.Visible = False
                        ElseIf PlanClass.ModalQDId4d <> 0 Then
                            mlblWaiveQD4d.Text = PlanClass.ModalQD4d
                            txtResponseQD4d.Text = PlanClass.ResponseQD4d
                            mlblModalQDId4d.Text = PlanClass.ModalQDId4d
                        End If
                    End If

                Else
                    'pre populate with any previous responses
                    PlanClass.GetEmployeeQuestionResponses(intEmployeeId, Session("LatestEventDate"))

                    If PlanClass.Response1 = True Then
                        mrbWaiveType.SelectedValue = "Question1"
                    ElseIf PlanClass.Response2 = True Then
                        mrbWaiveType.SelectedValue = "Question2"
                    End If
                    mtxtWaiveQuestion3.Text = PlanClass.Response3
                    mtxtWaiveQuestion4.Text = PlanClass.Response4
                End If
            End If

            'Get ELECT Modal Content And any previous responses

            If Session("Admin") = True Then
                PlanClass.GetModalContentByModalId(Session("PlanModalId"), intCompanyId, intEmployeeId)
                If booFoundModal = True Then
                    mlblInfoTitle.Text = PlanClass.ModalTitle
                    mlblInfoText1.Text = PlanClass.ModalText1
                    mlblInfoText2.Text = PlanClass.ModalText2
                    mlblInfoText3.Text = PlanClass.ModalText3

                End If
            Else
                PlanClass.GetModalContentByModalId(Session("PlanModalId"), Session("CompanyId"), Session("EmployeeId"))
                If booFoundModal = True Then
                    mlblInfoTitle.Text = PlanClass.ModalTitle
                    mlblInfoText1.Text = PlanClass.ModalText1
                    mlblInfoText2.Text = PlanClass.ModalText2
                    mlblInfoText3.Text = PlanClass.ModalText3

                End If

            End If

            'Determine if WaiveQuestions section should show
            If Session("WaiveQuestions") = True And InStr(Session("ExistingPlanFullDesc"), "Decline") > 0 And Session("WaiveAllowed") = True Then
                DivWaiveQuestions.Visible = True
                'Hide Next Buttons till Waive Save is clicked
                If bOkaytoSave = True Then
                    DivNext.Visible = True
                    imgNext.Visible = True
                Else
                    DivNext.Visible = False
                    imgNext.Visible = False
                End If
            Else
                DivWaiveQuestions.Visible = False
                DivNext.Visible = True
                imgNext.Visible = True
            End If

        End If

        'Determine if DepBen and Options should show and Step Descriptions 
        If InStr(Session("ExistingPlanFullDesc"), "Decline") > 0 Then
            divDepBen.Visible = False
            divOptionsSection.Visible = False
        Else
            If Session("DisplayDepBenType") = "N" Or Session("DisplayDepBenType") Is Nothing Then
                divDepBen.Visible = False
                lbldivPlanOptions.Text = "Step 2: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option"
            ElseIf Session("DisplayDepBenType") = "BO" Then
                divDepBen.Visible = True
                divBeneficiary.Visible = True
                divPlanDependents.Visible = False
                If Session("EventType") <> "No Event Declared" Then
                    grdBeneficiaries.Enabled = True
                End If
                If Session("WaiveAllowed") = False Then
                    lbldivBeneficiaries.Text = "Step 2: Choose Beneficiaries"
                    lbldivPlanOptions.Text = "Step 3: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option"
                Else
                    lbldivBeneficiaries.Text = "Step 3: Choose Beneficiaries"
                    lbldivPlanOptions.Text = "Step 4: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option"
                End If
            ElseIf Session("DisplayDepBenType") = "DO" Then
                divDepBen.Visible = True
                divBeneficiary.Visible = False
                divPlanDependents.Visible = True
                If Session("EventType") <> "No Event Declared" Then
                    grdCoveredDependents.Enabled = True
                End If
                If Session("WaiveAllowed") = False Then
                    lbldivDependents.Text = "Step 2: Choose Dependents to cover"
                    lbldivPlanOptions.Text = "Step 3: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option"
                Else
                    lbldivDependents.Text = "Step 3: Choose Dependents to cover"
                    lbldivPlanOptions.Text = "Step 4: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option"
                End If
            ElseIf Session("DisplayDepBenType") = "DB" Then
                divDepBen.Visible = True
                divBeneficiary.Visible = True
                divPlanDependents.Visible = True
                If Session("EventType") <> "No Event Declared" Then
                    grdBeneficiaries.Enabled = True
                    grdCoveredDependents.Enabled = True
                End If
                If Session("WaiveAllowed") = False Then
                    lbldivBeneficiaries.Text = "Step 2: Choose Beneficiaries"
                    lbldivDependents.Text = "Step 3: Choose Dependents to cover"
                    lbldivPlanOptions.Text = "Step 4: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option"
                Else
                    lbldivBeneficiaries.Text = "Step 3: Choose Beneficiaries"
                    lbldivDependents.Text = "Step 4: Choose Dependents to cover"
                    lbldivPlanOptions.Text = "Step 5: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option"
                End If
            Else
                lbldivBeneficiaries.Text = ""
                lbldivDependents.Text = ""
            End If
        End If

        'Tobacco Based Plans - check to see if Dep Tobacco dropdown is required
        If divPlanDependents.Visible = True Then
            For Each GridViewRow In grdCoveredDependents.Rows
                Dim ddl As DropDownList = DirectCast(GridViewRow.FindControl("ddlTobacco"), DropDownList)
                ' Dim lbl As Label = DirectCast(GridViewRow.FindControl("lblTobaccoLabel"), Label)
                If Session("TobaccoBased") = True And Session("TobaccoCoverageId") > 1 Then

                    'Show Tobacco Drop down in Dependent Grid
                    If GridViewRow.Cells(3).text = "Spouse" Or GridViewRow.Cells(3).text = "Common Law" Or GridViewRow.Cells(3).text = "Domestic Partner" Then  'if coverage leve is > 1 then Spouse is Tobacco based
                        ddl.Visible = True
                        ' lbl.Visible = True
                    ElseIf Session("TobaccoCoverageId") = 3 OrElse 5 OrElse 7 Then   ' only Coverage Level 7 cares about the kids
                        ddl.Visible = True
                        ' lbl.Visible = True
                    Else
                        'Hide Tobacco Drop down in Dependent Grid   if child and coverage id is not 7
                        ddl.Visible = False
                        '  lbl.Visible = False
                    End If

                Else
                    'Hide Tobacco Drop down in Dependent Grid
                    GridViewRow.cells(5).visible = False
                    grdCoveredDependents.HeaderRow.Cells(5).Visible = False

                End If

            Next

            If Session("CurrentPlanTypeId") = 55 Or Session("CurrentPlanTypeId") = 56 Then
                lblDependentTobacco.Text = "Tobacco User Question:  Has any Proposed Insured Age 18 and above, within the last 12 months, used tobacco or other nicotine containing products (e.g. cigarettes, pipe, snuff, chewing tobacco or nicotine delivery device such as gum, e-cigarette, or the patch), or smoked more than 24 cigars?"
                lblDependentTobacco.Visible = True
            Else
                lblDependentTobacco.Text = ""
                lblDependentTobacco.Visible = False
            End If

        End If

        'Determine if PlanQuestions section should show and Step Descriptions 
        If Session("PlanQuestions") = 0 Then
            divPlanQuestions.Visible = False
        Else
            divPlanQuestions.Visible = True
            If Session("WaiveAllowed") = True And divBeneficiary.Visible = True And divPlanDependents.Visible = True Then
                lbldivPlanQuestions.Text = "Step 5: Plan Questions"
                lbldivPlanOptions.Text = "Step 6: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option"
            ElseIf Session("WaiveAllowed") = True And divBeneficiary.Visible = True And divPlanDependents.Visible = False Then
                lbldivPlanQuestions.Text = "Step 4: Plan Questions"
                lbldivPlanOptions.Text = "Step 5: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option"
            ElseIf Session("WaiveAllowed") = True And divBeneficiary.Visible = False And divPlanDependents.Visible = True Then
                lbldivPlanQuestions.Text = "Step 4: Plan Questions"
                lbldivPlanOptions.Text = "Step 5: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option"
            ElseIf Session("WaiveAllowed") = True And divBeneficiary.Visible = False And divPlanDependents.Visible = False Then
                lbldivPlanQuestions.Text = "Step 3: Plan Questions"
                lbldivPlanOptions.Text = "Step 4: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option"
            ElseIf Session("WaiveAllowed") = False And divBeneficiary.Visible = False And divPlanDependents.Visible = False Then
                lbldivPlanQuestions.Text = "Step 2: Plan Questions"
                lbldivPlanOptions.Text = "Step 3: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option"
            Else
                lbldivPlanQuestions.Text = ""
                lbldivPlanOptions.Text = "Step 2: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option"
            End If

            PlanClass.GetPlanQuestions(intEmployeeId, Session("CurrentPlanTypeId"), Session("UserId"), grdPlanQuestions)

            CheckCompletePlanQuestions()
            If booComplete = False Then
                btnEditResponses.Visible = False
                btnSavePlanQuestions.Visible = True
                If Session("EventType") <> "No Event Declared" Then
                    grdPlanQuestions.Enabled = True
                    grdOptions.Enabled = False
                End If
            Else
                btnEditResponses.Visible = True
                btnSavePlanQuestions.Visible = False
                grdOptions.Enabled = True

            End If
        End If

    End Sub

    Private Sub BuildPCPRequiredTable()
        'Always build for now as it is needed to avoid error
        strEmployeeName = IIf(Session("ShadowEmployeeName") = "", Session("EmployeeName"), Session("ShadowEmployeeName"))

        If TblPCP.Columns.Count = 0 Then
            Col1.DataType = System.Type.GetType("System.String")
            Col1.ColumnName = "Emplid"
            Col1.Caption = "Emplid"
            Col1.ReadOnly = False
            TblPCP.Columns.Add(Col1)

            Col2.DataType = System.Type.GetType("System.String")
            Col2.ColumnName = "DepBenId"
            Col2.Caption = "DepBenId"
            Col2.ReadOnly = False
            TblPCP.Columns.Add(Col2)

            Col3.DataType = System.Type.GetType("System.String")
            Col3.ColumnName = "Name"
            Col3.Caption = "Name"
            Col3.ReadOnly = False
            TblPCP.Columns.Add(Col3)

            Col4.DataType = System.Type.GetType("System.String")
            Col4.ColumnName = "Relationship"
            Col4.Caption = "Relationship"
            Col4.ReadOnly = False
            TblPCP.Columns.Add(Col4)

            Col5.DataType = System.Type.GetType("System.String")
            Col5.ColumnName = "EEPCPCode"
            Col5.Caption = "EEPCPCode"
            Col5.ReadOnly = False
            TblPCP.Columns.Add(Col5)

            Col6.DataType = System.Type.GetType("System.Boolean")
            Col6.ColumnName = "CurrentPatient"
            Col6.Caption = "CurrentPatient"
            Col6.ReadOnly = False
            TblPCP.Columns.Add(Col6)

            Dim r As DataRow
            r = TblPCP.NewRow()
            r("DepBenId") = 0
            r("Name") = strEmployeeName
            r("Relationship") = "Employee"
            r("EEPCPCode") = EEPCP
            r("CurrentPatient") = CurrentPatient
            TblPCP.Rows.Add(r)
        End If

    End Sub

    Public Sub GetExistingElection()
        'Select appropriate Elect or Waive Radio buttons
        If Session("ExistingPlanFullDesc") = "" And Session("WaiveAllowed") = True Then
            grdBeneficiaries.Enabled = False
            grdCoveredDependents.Enabled = False
            grdPlanQuestions.Enabled = False
            grdOptions.Enabled = False
            rdElect.Checked = False
            rdWaive.Checked = False
            rdElectInfo2.Checked = False
            rdWaiveInfo2.Checked = False
            rdWaiveBoth.Checked = False
            rdElectModal.Checked = False
            rdWaiveModal.Checked = False
            rdElectOther.Checked = False
            rdWaiveOther.Checked = False
            rdElectInfo.Checked = False
            rdWaiveInfo.Checked = False

        ElseIf InStr(Session("ExistingPlanFullDesc"), "Decline") > 0 Then
            Session("SelectedPlanId") = Session("WaivePlanId")
            divDepBen.Visible = False
            divPlanQuestions.Visible = False
            divOptionsSection.Visible = False
            divPCPSection.Visible = False

            If divWaiveWithInfoModal.Visible = True Then
                rdWaiveInfo2.Checked = True
            ElseIf divWaiveWithModal.Visible = True Then
                rdWaiveModal.Checked = True
            ElseIf divElectWithModal.Visible = True Then
                rdWaiveOther.Checked = True
            ElseIf divElectWaiveBothWithInfoModal.Visible = True Then
                rdWaiveInfo.Checked = True
            ElseIf divElectWaiveBothWithModal.Visible = True Then
                rdWaiveBoth.Checked = True
            Else
                rdWaive.Checked = True
            End If

            WaiveQuestionsComplete()

        ElseIf Session("ExistingPlanFullDesc") <> "" Then
            divOptionsSection.Visible = True

            If divWaiveWithInfoModal.Visible = True Then
                rdElectInfo2.Checked = True
            ElseIf divWaiveWithModal.Visible = True Then
                rdElectModal.Checked = True
            ElseIf divElectWithModal.Visible = True Then
                rdElectOther.Checked = True
            ElseIf divElectWaiveBothWithInfoModal.Visible = True Then
                rdElectInfo.Checked = True
            ElseIf divElectWaiveBothWithModal.Visible = True Then
                rdElectBoth.Checked = True
            Else
                rdElect.Checked = True
            End If

        Else
            rdWaive.Checked = False
            rdElect.Checked = False
        End If

        'Select Dep Ben and Option Radio Buttons
        If divOptionsSection.Visible = True Then
            'Set default Options Session Variables
            Session("EECovered") = 1
            Session("SPCovered") = 0
            Session("DPCovered") = 0
            Session("NumOfDeps") = 0
            Session.Remove("ChildIds")
            Session.Remove("SelectedPlanId")
            Session.Remove("MinValue")
            Session.Remove("MaxValue")

            'De-select Covered Deps
            For Each gvr In grdCoveredDependents.Rows
                Dim chkCovered As CheckBox = DirectCast(gvr.FindControl("chkCovered"), CheckBox)
                chkCovered.Checked = False
            Next

            'De-select Beneficiaries
            For Each gvr In grdBeneficiaries.Rows
                Dim rbPrimary As RadioButton = DirectCast(gvr.FindControl("rbPrimary"), RadioButton)
                Dim rbContingent As RadioButton = DirectCast(gvr.FindControl("rbContingent"), RadioButton)
                Dim rbNeither As RadioButton = DirectCast(gvr.FindControl("rbNeither"), RadioButton)
                Dim ddlPercent As DropDownList = DirectCast(gvr.FindControl("ddlPercent"), DropDownList)
                rbPrimary.Checked = False
                rbContingent.Checked = False
                rbNeither.Checked = True
                ddlPercent.SelectedValue = 0
            Next

            Dim booGotExistingElection As Boolean
            Session("dsExistingElection") = New DataSet
            intPlanTypeId = Session("CurrentPlanTypeId")
            booGotExistingElection = PlanClass.GetExisting(intCompanyId, intEmployeeId, intPlanTypeId, Session("dsExistingElection"))
            If booGotExistingElection = True Then

                Dim dr As DataRow
                Dim dt As DataTable
                Dim i As Int32
                'Now go thru and reselect and covered Dependents
                dt = Session("dsExistingElection").tables(0)

                If Not dt.Rows(0)("TotalEECost") Is Nothing Then
                    lblSum.Text = Convert.ToDecimal(dt.Rows(0)("TotalEECost")).ToString("c")
                Else
                    lblSum.Text = "$0.00"
                End If

                If Not dt.Rows(0)("EEPCPCode") Is Nothing Then
                    EEPCP = dt.Rows(0)("EEPCPCode")
                    CurrentPatient = dt.Rows(0)("CurrentPatient")
                Else
                    EEPCP = ""
                    CurrentPatient = 0
                End If

                If dt.Rows(0)("Pending") <> "None" Then

                    Session("SelectedPlanId") = dt.Rows(0)("PlanId")
                    intPlanId = Session("SelectedPlanId")
                    Session("SelectedBenefitAmount") = Convert.ToInt32(dt.Rows(0)("BenefitAmount"))

                    'need to build the table just in case.  upon initial load the grdoptions has not been built yet
                    'so it is unknown if PCP is required yet
                    BuildPCPRequiredTable()

                    '''''''''''''''''''''''''''''''''''''''''''''
                    'Check Covered Dependents if Plan is tiered
                    '''''''''''''''''''''''''''''''''''''''''''''
                    If divPlanDependents.Visible = True Then
                        Dim strloop As String
                        Dim vDepBenIds As String
                        vDepBenIds = ""
                        strloop = "first"
                        For Each dr In dt.Rows
                            Session("SelectedPlanId") = dr("PlanId")
                            intPlanId = Session("SelectedPlanId")
                            If dr("DepBenId") > 0 Then
                                i = 0
                                For Each gvr In grdCoveredDependents.Rows
                                    Dim chkCovered As CheckBox = DirectCast(gvr.FindControl("chkCovered"), CheckBox)
                                    If dr("DepBenId") = grdCoveredDependents.DataKeys(i).Values("DepBenId") And dr("BeneficiaryType") = "" Then  'dr("BeneficiaryType")   THIS SHOWS BENIFICIARY INFO ONLY.  
                                        chkCovered.Checked = True

                                        'If dr("ParentPlanId") = 1 Then
                                        '    chkCovered.Enabled = False
                                        'Else
                                        '    chkCovered.Enabled = True
                                        'End If

                                        If gvr.Cells(3).text = "Spouse" Or gvr.Cells(3).text = "Common Law" Then    'Domestic Partner??
                                            Session("SPCovered") = 1

                                        ElseIf gvr.Cells(3).text = "Domestic Partner" Then
                                            Session("DPCovered") = 1
                                        Else
                                            Session("NumOfDeps") = Session("NumOfDeps") + 1
                                            If i = 0 Or strloop = "first" Then
                                                vDepBenIds = grdCoveredDependents.DataKeys(i).Values("DepBenId").ToString
                                                strloop = "notfirst"
                                            Else
                                                vDepBenIds = vDepBenIds + ", " + grdCoveredDependents.DataKeys(i).Values("DepBenId").ToString

                                            End If
                                        End If

                                        'Add Row to PCP table - ? should we do this even if PCP is not Required as this just gathers the data for when it is needed''''''''''''''
                                        'If Session("PCPRequired") = True Then
                                        'add to pcptable if plan requires it -- not known on initial load of the table
                                        Dim r As DataRow
                                        r = TblPCP.NewRow()
                                        r("Emplid") = dr("EmployeeId")
                                        r("DepBenId") = dr("DepBenId")
                                        r("Name") = dr("DepBenName")
                                        r("Relationship") = gvr.Cells(3).text
                                        r("PCPCode") = dr("EEPCPCode")
                                        r("CurrentPatient") = dr("DepBenCurrentPatient")
                                        TblPCP.Rows.Add(r)
                                        'End If
                                        'End If

                                    End If
                                    i += 1
                                Next

                            End If
                        Next
                        Session("ChildIds") = vDepBenIds                    'inital load
                    End If

                    Session("dtPCP") = TblPCP
                    If Session("PCPRequired") = True Then
                        'bind the grid
                        grdPCP.DataSource = Session("dtPCP")
                        grdPCP.DataBind()
                        divPCPSection.Visible = True

                        If lbldivPlanOptions.Text = "Step 6: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option" Then
                            lbldivPCP.Text = "Step 7: Provide Primary Care Physician's (PCP) Number"
                        ElseIf lbldivPlanOptions.Text = "Step 5: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option" Then
                            lbldivPCP.Text = "Step 6: Provide Primary Care Physician's (PCP) Number"
                        ElseIf lbldivPlanOptions.Text = "Step 4: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option" Then
                            lbldivPCP.Text = "Step 5: Provide Primary Care Physician's (PCP) Number"
                        ElseIf lbldivPlanOptions.Text = "Step 2: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option" Then
                            lbldivPCP.Text = "Step 3: Provide Primary Care Physician's (PCP) Number"
                        End If

                    Else
                        'Session.Remove("dtPCP")
                        divPCPSection.Visible = False
                    End If

                    '''''''''''''''''''''''''''''''''''''''''''''
                    'Check Beneficiaries if Plan has them
                    '''''''''''''''''''''''''''''''''''''''''''''
                    If divBeneficiary.Visible = True Then
                        For Each dr In dt.Rows

                            If dr("BeneficiaryId") > 0 Then
                                i = 0
                                For Each gvr In grdBeneficiaries.Rows
                                    Dim rbPrimary As RadioButton = DirectCast(gvr.FindControl("rbPrimary"), RadioButton)
                                    Dim rbContingent As RadioButton = DirectCast(gvr.FindControl("rbContingent"), RadioButton)
                                    Dim rbNeither As RadioButton = DirectCast(gvr.FindControl("rbNeither"), RadioButton)
                                    Dim ddlPercent As DropDownList = DirectCast(gvr.FindControl("ddlPercent"), DropDownList)

                                    If dr("BeneficiaryId") = grdBeneficiaries.DataKeys(i).Values("DepBenId") Then
                                        If dr("BeneficiaryType") = "P" Then
                                            rbPrimary.Checked = True
                                            rbContingent.Checked = False
                                            rbNeither.Checked = False
                                            ddlPercent.Enabled = True
                                            ddlPercent.SelectedValue = dr("BeneficiaryPercent")
                                        ElseIf dr("BeneficiaryType") = "C" Then
                                            rbPrimary.Checked = False
                                            rbContingent.Checked = True
                                            rbNeither.Checked = False
                                            ddlPercent.Enabled = True
                                            ddlPercent.SelectedValue = dr("BeneficiaryPercent")
                                        Else
                                            rbPrimary.Checked = False
                                            rbContingent.Checked = False
                                            rbNeither.Checked = True
                                            ddlPercent.SelectedValue = 0
                                            ddlPercent.Enabled = False
                                        End If

                                    End If
                                    i += 1
                                Next
                            End If
                        Next
                    End If

                    'need to check  Employee previously answered all the questions
                    If grdPlanQuestions.Visible = True And bolJustloadingPage = False And booIntheMiddleofaSave = False Then
                        CheckCompletePlanQuestions()

                    End If
                End If

            Else  'No election was ever made
                'Disable all blocks except Elect or Decline...but only if waiving is an option darn it!
                If Session("WaiveAllowed") = True Then
                    'BS add this,in case they just have something missing preventing them from acutally SAVING thier election made on the screen.....
                    If rdElectModal.Checked = False And
                            rdElect.Checked = False And
                            rdElectOther.Checked = False Then

                        rdWaiveModal.Checked = False
                        rdWaive.Checked = False
                        rdWaiveOther.Checked = False

                        rdElectModal.Checked = False
                        rdElect.Checked = False
                        rdElectOther.Checked = False

                        'Disable all blocks except Elect or Decline
                        grdBeneficiaries.Enabled = False
                        grdCoveredDependents.Enabled = False
                        grdOptions.Enabled = False
                        grdPlanQuestions.Enabled = False
                    End If

                End If

            End If

        Else ' currently no existing elections....clear out checkboxes in Covered and Beneficiaries gridviews

            'Disable all blocks except Elect or Decline...but only if waiving is an option darn it!
            If Session("WaiveAllowed") = True Then
                grdBeneficiaries.Enabled = False
                grdCoveredDependents.Enabled = False
                grdOptions.Enabled = False
                grdPlanQuestions.Enabled = False
                For Each GridViewRow In grdCoveredDependents.Rows
                    Dim chkCovered As CheckBox = DirectCast(GridViewRow.FindControl("chkCovered"), CheckBox)
                    chkCovered.Checked = False
                Next

            End If

        End If
    End Sub

    Public Sub GetNewPlanOptions()
        intPlanId = Session("SelectedPlanId")
        Dim bOptions As Boolean
        Session("dsNewOptions") = New DataSet
        intPlanTypeId = Session("CurrentPlanTypeId")
        bOptions = PlanClass.GetAllOptions(intCompanyId, intEmployeeId, intPlanTypeId, Session("EECovered"), Session("SPCovered"), Session("DPCovered"), Session("NumOfDeps"), Session("ChildIds"), Session("UserId"), Session("dsNewOptions"))
        If bOptions = True Then
            'Fill up options
            grdOptions.DataSource = Session("dsNewOptions").tables(0)
            grdOptions.DataBind()

            If Session("ShowERRates") = 0 Then
                grdOptions.Columns(7).Visible = False
                grdOptions.HeaderRow.Cells(7).Visible = False
                grdOptions.Columns(8).Visible = False
                grdOptions.HeaderRow.Cells(8).Visible = False
            End If

            If Session("dsNewOptions").tables(1).rows.count > 0 Then
                'Fill up rate grid in Learn section
                grdRateOptions.DataSource = Session("dsNewOptions").tables(1)
                grdRateOptions.DataBind()

                If Session("PlanModalId") > 0 Then
                    LabelModalId.Text = Session("PlanModalId")
                End If

                If Session("ShowERRates") = 0 Then
                    grdRateOptions.Columns(4).Visible = False
                    grdRateOptions.HeaderRow.Cells(4).Visible = False
                    grdRateOptions.Columns(5).Visible = False
                    grdRateOptions.HeaderRow.Cells(5).Visible = False
                End If

                PlanClass.GetModalContentByModalId(Session("PlanModalId"), intCompanyId, intEmployeeId)
                LabelModalTitle.Text = PlanClass.ModalTitle
                LabelModalText1.Text = PlanClass.ModalText1
                LabelModalText2.Text = PlanClass.ModalText2
                LabelModalText3.Text = PlanClass.ModalText3

            Else
                grdRateOptions.DataSource = Nothing
                grdRateOptions.DataBind()

            End If
        Else
            lblError.Text = "No Options were returned for this Plan Type.  Please contact your HR Administrator"
            divError.Visible = True
            lblError.Visible = True
            Exit Sub
        End If

        Dim i As Int32
        'Check current election if applicable
        intPlanId = Session("SelectedPlanId")
        If Session("SelectedPlanId") > 0 Then
            For Each gvr In grdOptions.Rows
                Dim rb As RadioButton

                rb = CType(grdOptions.Rows(i).FindControl("rbOption"), RadioButton)
                rb.Enabled = True

                If Session("PlanModalId") > 0 Then
                    rb.Attributes.Add("data-target", "#ModalInfoOnly")
                End If

                If grdOptions.DataKeys(i).Values("PlanId") = Session("SelectedPlanId") And ((grdOptions.DataKeys(i).Values("IncrementBased") = True And grdOptions.DataKeys(i).Values("BenefitFinal") = Session("SelectedBenefitAmount")) Or grdOptions.DataKeys(i).Values("IncrementBased") = 0) Then
                    intPlanId = Session("SelectedPlanId")
                    rb.Checked = True
                    'check to see if PCP is required
                    Session("PCPRequired") = grdOptions.DataKeys(i).Values("PCPRequired")
                    'Contribution Button
                    Dim btn As Button
                    btn = CType(grdOptions.Rows(i).FindControl("btnBenefitAmount"), Button)
                    If btn.Visible = True Then
                        btn.Enabled = True
                        If Not Session("ModalEECost") Is Nothing Then   'or HFSA or DFSA because the Cost is calculated on back end in Save proc
                            grdOptions.Rows(i).Cells(6).Text = FormatCurrency(Session("ModalEECost"))
                            Session.Remove("ModalBenefitAmount")
                            Session.Remove("ModalEECost")
                        End If
                    End If
                Else
                    intPlanId = Session("SelectedPlanId")
                    rb.Checked = False
                End If
                i += 1
            Next
        ElseIf grdOptions.Enabled = True Then
            'If no previous plan is selected then choose the first one on the list
            If Session("SelectedPlanId") = 0 Or (Session("WaiveAllowed") = True And ((divElectWaiveNoModal.Visible = True And rdWaive.Checked = False And rdElect.Checked = False) Or (divWaiveWithModal.Visible = True And rdWaiveModal.Checked = False And rdElectModal.Checked = False)) Or (divElectWithModal.Visible = True And rdWaiveOther.Checked = False And rdElectOther.Checked = False) Or (divElectWaiveBothWithModal.Visible = True And rdWaiveBoth.Checked = False And rdElectBoth.Checked = False) Or (divElectWaiveBothWithInfoModal.Visible = True And rdElectInfo.Checked = False And rdWaiveInfo.Checked = False) Or (divWaiveWithInfoModal.Visible = True And rdElectInfo2.Checked = False And rdWaiveInfo2.Checked = False)) Then
                Dim rb As RadioButton
                rb = CType(grdOptions.Rows(0).FindControl("rbOption"), RadioButton)
                rb.Enabled = True
                rb.Checked = True
                Dim btn As Button
                btn = CType(grdOptions.Rows(0).FindControl("btnBenefitAmount"), Button)
                If btn.Visible = True Then
                    btn.Enabled = True
                End If
                'then put in session
                Session("SelectedPlanId") = grdOptions.DataKeys(0).Values("PlanId")
                Session("SelectedRateId") = grdOptions.DataKeys(0).Values("RateId")
                Session("MinValue") = grdOptions.DataKeys(0).Values("MinValue")
                Session("MaxValue") = grdOptions.DataKeys(0).Values("MaxValue")
                Session("PlanModalId") = grdOptions.DataKeys(0).Values("PlanModalId")
                Session("ExistingPlanFullDesc") = grdOptions.DataKeys(0).Values("PlanLongDesc")

                If Session("PlanModalId") > 0 Then
                    rb.Attributes.Add("data-target", "#ModalInfoOnly")
                End If

                'check to see if PCP is required
                Session("PCPRequired") = grdOptions.DataKeys(0).Values("PCPRequired")
                If Session("EventType") <> "No Event Declared" Then
                    grdOptions.Enabled = True
                End If
            End If
        End If

        'PCP Required section (have to bind table and show panel
        If Session("PCPRequired") = True Then
            'bind the grid
            grdPCP.DataSource = Session("dtPCP")
            grdPCP.DataBind()
            divPCPSection.Visible = True

            If lbldivPlanOptions.Text = "Step 6: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option" Then
                lbldivPCP.Text = "Step 7: Provide Primary Care Physician's (PCP) Number"
            ElseIf lbldivPlanOptions.Text = "Step 5: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option" Then
                lbldivPCP.Text = "Step 6: Provide Primary Care Physician's (PCP) Number"
            ElseIf lbldivPlanOptions.Text = "Step 4: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option" Then
                lbldivPCP.Text = "Step 3: Provide Primary Care Physician's (PCP) Number"
            ElseIf lbldivPlanOptions.Text = "Step 2: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option" Then
                lbldivPCP.Text = "Step 1: Provide Primary Care Physician's (PCP) Number"
            End If
        Else
            divPCPSection.Visible = False
        End If
    End Sub

    Public Sub chkDepCovered_OnCheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        'grdOptions.Enabled = False
        'imgNext.Visible = False
        'imgProcessing.Visible = True
        'ImgBottomNext.Visible = False
        'ImgBottomProcessing.Visible = True

        'Reset Session Variables
        Session("EECovered") = 1
        Session("SPCovered") = 0
        Session("DPCovered") = 0
        Session("NumOfDeps") = 0
        Session.Remove("ChildIds")

        Dim b As Integer
        Dim vDepBenIds As String
        Dim strloop As String
        vDepBenIds = ""
        strloop = "first"

        For Each GridViewRow In grdCoveredDependents.Rows
            Dim chkCovered As CheckBox = DirectCast(GridViewRow.FindControl("chkCovered"), CheckBox)
            'chkCovered.Attributes.Add("onclick", "MyDisableFunction()")

            If chkCovered.Checked = True Then
                If GridViewRow.cells(3).text = "Spouse" Or GridViewRow.Cells(3).text = "Common Law" Then     'Domestic Partner??
                    Session("SPCovered") = 1
                ElseIf GridViewRow.cells(3).text = "Domestic Partner" Then
                    Session("DPCovered") = 1
                Else
                    Session("NumOfDeps") = Session("NumOfDeps") + 1
                    If b = 0 Or strloop = "first" Then
                        vDepBenIds = grdCoveredDependents.DataKeys(b).Values("DepBenId").ToString
                        strloop = "notfirst"
                    Else
                        vDepBenIds = vDepBenIds + "," + grdCoveredDependents.DataKeys(b).Values("DepBenId").ToString
                    End If

                End If

            End If
            b += 1
        Next
        Session("ChildIds") = vDepBenIds
        Dim ChildIdList As String
        ChildIdList = Session("ChildIds")

        'If the Question Grid is visible don't fill plans 
        'Instead, loop thru dep grid to see who they want to cover then hide/show any questions to non partipants
        'then check to see of all questions are answered and that will fill options grid
        If divPlanQuestions.Visible = True Then
            Dim gvrq As GridViewRow
            Dim q As Integer
            'Dim booComplete As Boolean
            booComplete = True

            For Each gvrq In grdPlanQuestions.Rows
                Dim rbSP As RadioButtonList
                Dim rbCH As RadioButtonList
                Dim ddlSP As DropDownList
                Dim ddlCH As DropDownList

                'SPOUSE
                rbSP = DirectCast(gvrq.FindControl("rbSpouse"), RadioButtonList)
                If rbSP.Visible = True Then
                    If Session("SPCovered") = 1 Then         'no selection
                        rbSP.Enabled = True
                    Else
                        rbSP.Enabled = False
                    End If
                End If
                ddlSP = DirectCast(gvrq.FindControl("ddlSP"), DropDownList)
                If ddlSP.Visible = True Then
                    If Session("SPCovered") = 1 Then         'no selection
                        ddlSP.Enabled = True
                    Else
                        ddlSP.Enabled = False
                    End If
                End If

                'CHILD
                rbCH = DirectCast(gvrq.FindControl("rbChild"), RadioButtonList)
                If rbCH.Visible = True Then
                    If Session("NumOfDeps") > 0 Then         'no selection
                        rbCH.Enabled = True
                    Else
                        rbCH.Enabled = False
                    End If
                End If
                ddlCH = DirectCast(gvrq.FindControl("ddlCH"), DropDownList)
                If ddlCH.Visible = True Then
                    If Session("NumOfDeps") > 0 Then          'no selection
                        ddlCH.Enabled = True
                    Else
                        ddlCH.Enabled = False
                    End If
                End If

                q += 1
            Next

            EditQuestions()

            booIntheMiddleofaSave = True

            CheckCompletePlanQuestions()

            If booComplete = True Then
                If intPlanTypeId <> 9 And intPlanTypeId <> 10 And intPlanTypeId <> 19 Then
                    SaveElection()
                ElseIf intPlanTypeId = 19 Then
                    HSASave()
                End If
            Else
                btnEditResponses.Visible = False
                btnSavePlanQuestions.Visible = True
                grdPlanQuestions.Enabled = True
            End If

        Else

            'refill Options Grid  
            GetNewPlanOptions()
            'and reselect the option 
            Dim gvr As GridViewRow
            Dim i As Int32
            Dim bGotit As Boolean = False

            'deselect all radiobutton in gridview
            For Each gvr In grdOptions.Rows
                If grdOptions.DataKeys(i).Values("PlanId") = Session("SelectedPlanId") And ((grdOptions.DataKeys(i).Values("IncrementBased") = True And grdOptions.DataKeys(i).Values("BenefitFinal") = Session("SelectedBenefitAmount")) Or grdOptions.DataKeys(i).Values("IncrementBased") = 0) Then

                    Dim rb As RadioButton
                    rb = CType(grdOptions.Rows(i).FindControl("rbOption"), RadioButton)
                    rb.Checked = True
                    'why am i capturing this again??
                    Session("SelectedPlanId") = grdOptions.DataKeys(i).Values("PlanId")
                    Session("SelectedBenefitAmount") = Convert.ToInt32(grdOptions.DataKeys(i).Values("BenefitFinal"))

                    Dim btn As Button
                    btn = CType(grdOptions.Rows(i).FindControl("btnBenefitAmount"), Button)
                    If btn.Visible = True Then
                        btn.Enabled = True
                    End If
                    bGotit = True
                    Exit For
                End If
                i += 1
            Next

            '08/11/2016 BS  added bGotit variable because the Session("SelectedPlanId") did no match any selections in the options grid
            If Session("SelectedPlanId") > 0 And bGotit = True Then
                If booFinalCheckofDeps = True Then
                    'Call Save 
                    If intPlanTypeId <> 9 And intPlanTypeId <> 10 And intPlanTypeId <> 19 Then
                        SaveElection()
                    ElseIf intPlanTypeId = 19 Then
                        HSASave()
                    End If
                    'grdOptions.Enabled = True
                    'grdCoveredDependents.Enabled = True
                    'Button2.Attributes.Add("onclick", "MyEnableFunction()")

                End If
            End If
        End If

        'grdOptions.Enabled = True
        'imgNext.Visible = True
        'imgProcessing.Visible = False
        'ImgBottomNext.Visible = True
        'ImgBottomProcessing.Visible = False
    End Sub

    Public Sub rbOption_onCheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        deselect_RB_in_gridview()

        'Check the radiobutton which is selected
        Dim SenderRB As RadioButton = sender
        SenderRB.Checked = True

        'Grab Plan Id selected 
        Dim gvr As GridViewRow
        Dim i As Int32
        'deselect all radiobutton in gridview
        For Each gvr In grdOptions.Rows
            Dim rb As RadioButton
            Dim btn As Button
            rb = CType(grdOptions.Rows(i).FindControl("rbOption"), RadioButton)
            btn = CType(grdOptions.Rows(i).FindControl("btnBenefitAmount"), Button)

            If rb.Checked = True Then
                Session("SelectedPlanId") = grdOptions.DataKeys(i).Values("PlanId")
                intPlanId = Session("SelectedPlanId")
                Session("MinValue") = grdOptions.DataKeys(i).Values("MinValue")
                Session("MaxValue") = grdOptions.DataKeys(i).Values("MaxValue")
                Session("SelectedBenefitAmount") = Convert.ToInt32(grdOptions.DataKeys(i).Values("BenefitFinal"))

                Session("PlanModalId") = Convert.ToInt32(grdOptions.DataKeys(i).Values("PlanModalId"))
                If Session("PlanModalId") > 0 Then
                    rb.Attributes.Add("data-target", "#ModalGeneric")
                    PlanClass.GetModalContentByModalId(Session("PlanModalId"), intCompanyId, intEmployeeId)
                    LabelModalTitle.Text = PlanClass.ModalTitle
                    LabelModalText1.Text = PlanClass.ModalText1
                    LabelModalText2.Text = PlanClass.ModalText2
                    LabelModalText3.Text = PlanClass.ModalText3

                End If

                If btn.Visible = True Then
                    btn.Enabled = True
                End If
                Session("PCPRequired") = grdOptions.DataKeys(i).Values("PCPRequired")
                If Session("PCPRequired") = True Then
                    divPCPSection.Visible = True

                    If lbldivPlanOptions.Text = "Step 6: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option" Then
                        lbldivPCP.Text = "Step 7: Provide Primary Care Physician's (PCP) Number"
                    ElseIf lbldivPlanOptions.Text = "Step 5: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option" Then
                        lbldivPCP.Text = "Step 6: Provide Primary Care Physician's (PCP) Number"
                    ElseIf lbldivPlanOptions.Text = "Step 4: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option" Then
                        lbldivPCP.Text = "Step 3: Provide Primary Care Physician's (PCP) Number"
                    ElseIf lbldivPlanOptions.Text = "Step 2: Choose <strong>" + Session("PlanTypeLongDesc") + "</strong> Plan Option" Then
                        lbldivPCP.Text = "Step 1: Provide Primary Care Physician's (PCP) Number"
                    End If
                Else
                    divPCPSection.Visible = False
                End If

            Else
                If btn.Visible = True Then
                    btn.Enabled = False
                End If

                rb.Checked = False

            End If
            i += 1
        Next

        If divElectWaiveNoModal.Visible = True Then
            rdWaive.Checked = False
            rdElect.Checked = True
        End If

        SaveElection()

        GetNavigationAndTabs()

    End Sub

    Sub deselect_RB_in_gridview()
        Dim gvr As GridViewRow
        Dim i As Int32
        'deselect all radiobutton in gridview
        For Each gvr In grdOptions.Rows
            Dim rb As RadioButton
            rb = CType(grdOptions.Rows(i).FindControl("rbOption"), RadioButton)
            rb.Checked = False
            i += 1
        Next

    End Sub

    Public Sub WaiveQuestionsComplete()
        If Session("WaiveQuestions") = True Then
            'Verify if all Questions are answered
            If chkWaiveQ1.Checked = False And chkWaiveQ2.Checked = False And chkWaiveQ3.Checked = False And chkWaiveQ4.Checked = False Then
                Session("WaiveQuestionsAreComplete") = False
            ElseIf chkWaiveQ1.Checked = True And ((mlblWaiveQD1a.Text <> "" And txtResponseQD1a.Text = "") Or (mlblWaiveQD1b.Text <> "" And txtResponseQD1b.Text = "") Or (mlblWaiveQD1c.Text <> "" And txtResponseQD1c.Text = "") Or (mlblWaiveQD1d.Text <> "" And txtResponseQD1d.Text = "")) Then
                Session("WaiveQuestionsAreComplete") = False
            ElseIf chkWaiveQ2.Checked = True And ((mlblWaiveQD2a.Text <> "" And txtResponseQD2a.Text = "") Or (mlblWaiveQD2b.Text <> "" And txtResponseQD2b.Text = "") Or (mlblWaiveQD2c.Text <> "" And txtResponseQD2c.Text = "") Or (mlblWaiveQD2d.Text <> "" And txtResponseQD2d.Text = "")) Then
                Session("WaiveQuestionsAreComplete") = False
            ElseIf chkWaiveQ3.Checked = True And ((mlblWaiveQD3a.Text <> "" And txtResponseQD3a.Text = "") Or (mlblWaiveQD3b.Text <> "" And txtResponseQD3b.Text = "") Or (mlblWaiveQD3c.Text <> "" And txtResponseQD3c.Text = "") Or (mlblWaiveQD3d.Text <> "" And txtResponseQD3d.Text = "")) Then
                Session("WaiveQuestionsAreComplete") = False
            ElseIf chkWaiveQ4.Checked = True And ((mlblWaiveQD4a.Text <> "" And txtResponseQD4a.Text = "") Or (mlblWaiveQD4b.Text <> "" And txtResponseQD4b.Text = "") Or (mlblWaiveQD4c.Text <> "" And txtResponseQD4c.Text = "") Or (mlblWaiveQD4d.Text <> "" And txtResponseQD4d.Text = "")) Then
                Session("WaiveQuestionsAreComplete") = False
            Else
                Session("WaiveQuestionsAreComplete") = True
            End If

            If Session("WaiveQuestionsAreComplete") = True Then
                DivNext.Visible = True
                imgNext.Visible = True
            End If
        End If

    End Sub

    Public Sub SaveWaiveQuestions()
        If DivWaiveQuestions.Visible = True Then
            If Session("WaiveQuestionsAreComplete") = False Then
                DivWaiveError.Visible = True
                LblWaiveErrorMessage.Text = "Please choose reason for Waiving and provide all required details."
                DivNext.Visible = False
                imgNext.Visible = False
                Exit Sub
            Else
                DivWaiveError.Visible = False
                'All Required questions are answered so Save the answers to Questions  
                If mlblWaiveQ1.Text <> "" Then
                    PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, Session("WaivePlanId"), mlblModalQuestionId1.Text, IIf(chkWaiveQ1.Checked = True, "True", "False"), "", "", Session("LatestEventDate"), Session("Userid"))
                End If
                If mlblWaiveQ2.Text <> "" Then
                    PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, Session("WaivePlanId"), mlblModalQuestionId2.Text, IIf(chkWaiveQ2.Checked = True, "True", "False"), "", "", Session("LatestEventDate"), Session("Userid"))
                End If
                If mlblWaiveQ3.Text <> "" Then
                    PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, Session("WaivePlanId"), mlblModalQuestionId3.Text, IIf(chkWaiveQ3.Checked = True, "True", "False"), "", "", Session("LatestEventDate"), Session("Userid"))
                End If
                If mlblWaiveQ4.Text <> "" Then
                    PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, Session("WaivePlanId"), mlblModalQuestionId4.Text, IIf(chkWaiveQ4.Checked = True, "True", "False"), "", "", Session("LatestEventDate"), Session("Userid"))
                End If

                If mlblWaiveQD1a.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId1.Text, mlblModalQDId1a.Text, "EE", txtResponseQD1a.Text, Session("LatestEventDate"), Session("Userid"))
                End If
                If mlblWaiveQD1b.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId1.Text, mlblModalQDId1b.Text, "EE", txtResponseQD1b.Text, Session("LatestEventDate"), Session("Userid"))
                End If
                If mlblWaiveQD1c.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId1.Text, mlblModalQDId1c.Text, "EE", txtResponseQD1c.Text, Session("LatestEventDate"), Session("Userid"))
                End If
                If mlblWaiveQD1d.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId1.Text, mlblModalQDId1d.Text, "EE", txtResponseQD1d.Text, Session("LatestEventDate"), Session("Userid"))
                End If

                If mlblWaiveQD2a.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId2.Text, mlblModalQDId2a.Text, "EE", txtResponseQD2a.Text, Session("LatestEventDate"), Session("Userid"))
                End If
                If mlblWaiveQD2b.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId2.Text, mlblModalQDId2b.Text, "EE", txtResponseQD2b.Text, Session("LatestEventDate"), Session("Userid"))
                End If
                If mlblWaiveQD2c.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId2.Text, mlblModalQDId2c.Text, "EE", txtResponseQD2c.Text, Session("LatestEventDate"), Session("Userid"))
                End If
                If mlblWaiveQD2d.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId2.Text, mlblModalQDId2d.Text, "EE", txtResponseQD2d.Text, Session("LatestEventDate"), Session("Userid"))
                End If

                If mlblWaiveQD3a.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId3.Text, mlblModalQDId3a.Text, "EE", txtResponseQD3a.Text, Session("LatestEventDate"), Session("Userid"))
                End If
                If mlblWaiveQD3b.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId3.Text, mlblModalQDId3b.Text, "EE", txtResponseQD3b.Text, Session("LatestEventDate"), Session("Userid"))
                End If
                If mlblWaiveQD3c.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId3.Text, mlblModalQDId3c.Text, "EE", txtResponseQD3c.Text, Session("LatestEventDate"), Session("Userid"))
                End If
                If mlblWaiveQD3d.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId3.Text, mlblModalQDId3d.Text, "EE", txtResponseQD3d.Text, Session("LatestEventDate"), Session("Userid"))
                End If

                If mlblWaiveQD4a.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId4.Text, mlblModalQDId4a.Text, "EE", txtResponseQD4a.Text, Session("LatestEventDate"), Session("Userid"))
                End If
                If mlblWaiveQD4b.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId4.Text, mlblModalQDId4b.Text, "EE", txtResponseQD4b.Text, Session("LatestEventDate"), Session("Userid"))
                End If
                If mlblWaiveQD4c.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId4.Text, mlblModalQDId4c.Text, "EE", txtResponseQD4c.Text, Session("LatestEventDate"), Session("Userid"))
                End If
                If mlblWaiveQD4d.Text <> "" Then
                    PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, mlblModalQuestionId4.Text, mlblModalQDId4d.Text, "EE", txtResponseQD4d.Text, Session("LatestEventDate"), Session("Userid"))
                End If

                DivNext.Visible = True
                imgNext.Visible = True

                Session("Changes") = "Saved"
            End If
        End If

    End Sub

    Public Sub SaveElection()

        strEventType = Session("EventType")
        intPlanId = Session("SelectedPlanId")
        Session("Changes") = "NotSaved"

        If Session("SelectedPlanId") < 1 Then
            Exit Sub
        End If

        If strEventType = "No Event Declared" Then
            divError.Visible = True
            lblError.Text = "You must Declare an Event in order to make or change any options on this page."
            ResetScrollPosition()
            Exit Sub
        End If

        ''This is the Selected RateId    Session("SelectedRateId")
        Dim gvr As GridViewRow
        Dim i As Int32
        Dim vRateId As Integer
        Dim vEECost As Decimal
        Dim vERCost As Decimal
        Dim vBenefitAmount As Decimal
        Dim vMonthlyEECost As Decimal
        Dim vMonthlyERCost As Decimal
        Dim vWaived As Boolean
        bOkaytoSave = True
        booIntheMiddleofaSave = True

        vWaived = False
        If Session("WaiveAllowed") = True And ((divElectWaiveNoModal.Visible = True And rdWaive.Checked = False And rdElect.Checked = False) Or (divWaiveWithModal.Visible = True And rdWaiveModal.Checked = False And rdElectModal.Checked = False)) Or (divElectWithModal.Visible = True And rdWaiveOther.Checked = False And rdElectOther.Checked = False) Or (divElectWaiveBothWithModal.Visible = True And rdWaiveBoth.Checked = False And rdElectBoth.Checked = False) Or (divElectWaiveBothWithInfoModal.Visible = True And rdElectInfo.Checked = False And rdWaiveInfo.Checked = False) Or (divWaiveWithInfoModal.Visible = True And rdElectInfo2.Checked = False And rdWaiveInfo2.Checked = False) Then
            'User did NOT make a waive or elect option
            divError.Visible = True
            lblError.Text = "Please either Decline or choose to Elect Coverage before leaving the page."
            bOkaytoSave = False
            ResetScrollPosition()
        ElseIf Session("WaiveAllowed") = True And ((divElectWaiveNoModal.Visible = True And rdWaive.Checked = True) Or (divWaiveWithModal.Visible = True And rdWaiveModal.Checked = True) Or (divElectWithModal.Visible = True And rdWaiveOther.Checked = True) Or (divElectWaiveBothWithModal.Visible = True And rdWaiveBoth.Checked = True) Or (divElectWaiveBothWithInfoModal.Visible = True And rdWaiveInfo.Checked = True) Or (divWaiveWithInfoModal.Visible = True And rdWaiveInfo2.Checked = True)) Then
            'User Elected Waive
            Session("SelectedPlanId") = Session("WaivePlanId")
            vRateId = Session("WaiveRateId")
            vEECost = 0
            vERCost = 0
            vMonthlyEECost = 0
            vMonthlyERCost = 0
            vWaived = True
            'Clear all these out
            mtxtBenAmt.Text = 0
            mtxtEECost.Text = 0
            Session("ModalBenefitAmount") = 0
            bOkaytoSave = True
        Else 'Not a Waive 

            'Make sure all plan questions are answered
            If divPlanQuestions.Visible = True Then
                CheckCompletePlanQuestions()
                If booComplete = False Then
                    divError.Visible = True
                    lblError.Text = "Please either Decline Coverage or Complete the Plan Questions and choose a Benefit Option before leaving the page."
                    bOkaytoSave = False
                    ResetScrollPosition()
                Else
                    If booCompleteDetails = False Then
                        divError.Visible = True
                        lblError.Text = strDetailError
                        bOkaytoSave = False
                        ResetScrollPosition()
                    End If
                End If
            End If

            'If Beneficiaries are required check that at least one is choosen, and that the totals of P and C are 100%
            If divBeneficiary.Visible = True And vWaived = False Then
                Dim b As Integer
                Dim vPrimaryTotal As Integer
                Dim vContingentTotal As Integer
                vPrimaryTotal = 0
                vContingentTotal = 0

                For Each gvr In grdBeneficiaries.Rows
                    Dim rbPrimary As RadioButton
                    Dim rbContingent As RadioButton
                    Dim ddlPercent As DropDownList
                    rbPrimary = CType(grdBeneficiaries.Rows(b).FindControl("rbPrimary"), RadioButton)
                    rbContingent = CType(grdBeneficiaries.Rows(b).FindControl("rbContingent"), RadioButton)
                    ddlPercent = CType(grdBeneficiaries.Rows(b).FindControl("ddlPercent"), DropDownList)
                    If rbPrimary.Checked = True Or rbContingent.Checked = True Then
                        If rbPrimary.Checked Then
                            vPrimaryTotal = vPrimaryTotal + ddlPercent.SelectedValue
                        Else
                            vContingentTotal = vContingentTotal + ddlPercent.SelectedValue
                        End If
                    End If
                    b += 1
                Next
                If vPrimaryTotal = 0 And Session("Admin") = False Then
                    divError.Visible = True
                    lblError.Text = "You must have at least one Primary Beneficiary"
                    bOkaytoSave = False
                    ResetScrollPosition()
                ElseIf vPrimaryTotal > 0 And vPrimaryTotal <> 100 And Session("Admin") = False Then
                    divError.Visible = True
                    lblError.Text = "The total allotment of the Primary Beneficiaries does not equal 100"
                    bOkaytoSave = False
                    ResetScrollPosition()
                ElseIf vPrimaryTotal > 0 And vPrimaryTotal > 100 And Session("Admin") = True Then
                    divError.Visible = True
                    lblError.Text = "The total allotment of the Primary Beneficiaries cannot exceed 100 Percent"
                    bOkaytoSave = False
                    ResetScrollPosition()
                ElseIf vContingentTotal > 0 And vContingentTotal <> 100 And Session("Admin") = False Then
                    divError.Visible = True
                    lblError.Text = "The total allotment of the Contingent Beneficiaries does not equal 100"
                    bOkaytoSave = False
                    ResetScrollPosition()
                ElseIf vContingentTotal > 0 And vContingentTotal > 100 And Session("Admin") = True Then
                    divError.Visible = True
                    lblError.Text = "The total allotment of the Contingent Beneficiaries cannot exceed 100 Percent"
                    bOkaytoSave = False
                    ResetScrollPosition()
                End If
            End If

            If bOkaytoSave = True Then   'not a waive, and ALL plan questions (if applicable) are answered THEEEEEEEEEN check to see if an option is choosen 
                bOkaytoSave = False
                Session("OptionDefaulted") = 0
                Dim vMaxValue As Double
                Dim vMinValue As Double
                Dim EECost As Decimal
                Dim ERCost As Decimal
                Dim MonthlyEECost As Decimal
                Dim MonthlyERCost As Decimal
                Dim This As Double
                'Grab info from Option Grid View
                For Each gvr In grdOptions.Rows
                    Dim rb As RadioButton
                    rb = CType(grdOptions.Rows(i).FindControl("rbOption"), RadioButton)

                    If rb.Checked = True Then
                        Session("SelectedPlanId") = grdOptions.DataKeys(i).Values("PlanId")
                        Session("SelectedBenefitAmount") = Convert.ToInt32(grdOptions.DataKeys(i).Values("BenefitFinal"))
                        vMinValue = grdOptions.DataKeys(i).Values("MinValue")
                        vMaxValue = grdOptions.DataKeys(i).Values("MaxValue")
                        vRateId = grdOptions.DataKeys(i).Values("RateId")
                        vBenefitAmount = grdOptions.DataKeys(i).Values("BenefitFinal")
                        vMonthlyEECost = grdOptions.DataKeys(i).Values("MonthlyEECost")
                        vMonthlyERCost = grdOptions.DataKeys(i).Values("MonthlyERCost")

                        'BS 09/13/2015 Grab the event date from the return of the procedure based on Users selection
                        Session("LatestEventDate") = grdOptions.DataKeys(i).Values("LatestEventDate")

                        If grdOptions.Rows(i).Cells(6).Text <> "" Then
                            vEECost = grdOptions.Rows(i).Cells(6).Text
                            EECost = grdOptions.Rows(i).Cells(6).Text
                            If grdOptions.Rows(i).Cells(20).Text <> "" Then
                                vMonthlyEECost = grdOptions.Rows(i).Cells(20).Text
                                MonthlyEECost = grdOptions.Rows(i).Cells(20).Text
                            ElseIf grdOptions.Rows(i).Cells(20).Text = "" And vMonthlyEECost <> 0 Then
                                MonthlyEECost = vMonthlyEECost
                            Else
                                vMonthlyEECost = 0
                                MonthlyEECost = 0
                            End If
                        Else
                            vEECost = 0
                            EECost = 0
                        End If
                        If grdOptions.Rows(i).Cells(7).Text <> "" Then
                            vERCost = grdOptions.Rows(i).Cells(7).Text
                            ERCost = grdOptions.Rows(i).Cells(7).Text
                            If grdOptions.Rows(i).Cells(21).Text <> "" Then
                                vMonthlyERCost = grdOptions.Rows(i).Cells(21).Text
                                MonthlyERCost = grdOptions.Rows(i).Cells(21).Text
                            ElseIf grdOptions.Rows(i).Cells(21).Text = "" And vMonthlyERCost <> 0 Then
                                MonthlyERCost = vMonthlyERCost
                            Else
                                vMonthlyERCost = 0
                                MonthlyERCost = 0
                            End If
                        Else
                            vERCost = 0
                            ERCost = 0
                        End If
                        bOkaytoSave = True
                    End If
                    EECost = vEECost
                    This = EECost
                    i += 1

                Next

                If bOkaytoSave = False Then
                    divError.Visible = True
                    lblError.Text = "Please Choose a Benefit Option before leaving the page."
                End If
            End If
        End If

        If bOkaytoSave = True Then
            intPlanTypeId = Session("CurrentPlanTypeId")
            SecClass.SaveUserUpdate(Session("UserId"), "EE Plan", "Save Benefit", intEmployeeId, 0, intPlanTypeId, Session("LatestEventDate"), intTransactionId)
            lblError.Text = ""
            divError.Visible = False

            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()

            objParam = New SqlParameter("@CompanyId", intCompanyId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EmployeeId", intEmployeeId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@PlantypeId", intPlanTypeId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@PlanId", Session("SelectedPlanId"))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@RateId", vRateId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@CoverageBeginDate", Session("LatestEventDate"))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EECost", vEECost)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@ERCost", vERCost)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@MonthlyEECost", vMonthlyEECost)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@MonthlyERCost", vMonthlyERCost)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@BenefitAmount", vBenefitAmount)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EventTypeId", Session("EventTypeId"))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@UserId", Session("UserId"))
            aryParams.Add(objParam)

            '''' PCP Number if applicable
            If divPCPSection.Visible = True And grdPCP.Rows.Count > 0 Then
                Dim txtpcp As TextBox
                txtpcp = CType(grdPCP.Rows(0).FindControl("txtPCPNumber"), TextBox)
                objParam = New SqlParameter("@PCPCode", Trim(txtpcp.Text))
                aryParams.Add(objParam)
                Dim chkCP As CheckBox
                chkCP = CType(grdPCP.Rows(0).FindControl("chkCurrentPatient"), CheckBox)
                objParam = New SqlParameter("@CurrentPatient", chkCP.Checked)
                aryParams.Add(objParam)
            End If

            objDataSet = sqlCon.CreateDataSet("usp_Employee_Election_Save", aryParams)
            sqlCon.CloseConn()

            lblError.Text = ""

            'Save Covered Dependents
            If divPlanDependents.Visible = True And vWaived = False Then
                'Check to see if any Dependents are covered
                Dim vDepId As Integer
                Dim d As Integer
                For Each gvr In grdCoveredDependents.Rows
                    Dim chk As CheckBox
                    chk = CType(grdCoveredDependents.Rows(d).FindControl("chkCovered"), CheckBox)
                    If chk.Checked = True Then
                        vDepId = grdCoveredDependents.DataKeys(d).Values("DepBenId")

                        Dim objdParam As SqlParameter
                        Dim objdDataSet As New DataSet
                        Dim arydParams As New ArrayList()
                        Dim sqldCon As New SQLControl
                        sqldCon.OpenConn()

                        objdParam = New SqlParameter("@CompanyId", intCompanyId)
                        arydParams.Add(objdParam)
                        objdParam = New SqlParameter("@EmployeeId", intEmployeeId)
                        arydParams.Add(objdParam)
                        objdParam = New SqlParameter("@PlantypeId", intPlanTypeId)
                        arydParams.Add(objdParam)
                        objdParam = New SqlParameter("@PlanId", Session("SelectedPlanId"))
                        arydParams.Add(objdParam)
                        objdParam = New SqlParameter("@DepBenId", vDepId)
                        arydParams.Add(objdParam)
                        objdParam = New SqlParameter("@UserId", Session("UserId"))
                        arydParams.Add(objdParam)

                        '''' PCP Number if applicable
                        If divPCPSection.Visible = True And grdPCP.Rows.Count > 0 Then
                            Dim p As New Integer
                            For Each gdr In grdPCP.Rows
                                If vDepId = grdPCP.DataKeys(p).Values("DepBenId") Then
                                    Dim txtdeppcp As TextBox
                                    txtdeppcp = CType(grdPCP.Rows(p).FindControl("txtPCPNumber"), TextBox)
                                    Dim chkdepPCP As CheckBox
                                    chkdepPCP = CType(grdPCP.Rows(p).FindControl("chkCurrentPatient"), CheckBox)

                                    objdParam = New SqlParameter("@PCPCode", Trim(txtdeppcp.Text))
                                    arydParams.Add(objdParam)
                                    objdParam = New SqlParameter("@CurrentPatient", chkdepPCP.Checked)
                                    arydParams.Add(objdParam)
                                    Exit For
                                End If
                                p += 1
                            Next
                        End If

                        objdDataSet = sqldCon.CreateDataSet("usp_Dependent_Election_Save", arydParams)
                        sqldCon.CloseConn()
                    End If
                    d += 1
                Next
            End If

            'Save Beneficiary Information
            If divBeneficiary.Visible = True And vWaived = False Then
                'Check to see if any Dependents are covered
                Dim vBenId As Integer
                Dim b As Integer
                Dim vBenType As String

                For Each gvr In grdBeneficiaries.Rows
                    Dim rbPrimary As RadioButton
                    Dim rbContingent As RadioButton
                    Dim ddlPercent As DropDownList
                    rbPrimary = CType(grdBeneficiaries.Rows(b).FindControl("rbPrimary"), RadioButton)
                    rbContingent = CType(grdBeneficiaries.Rows(b).FindControl("rbContingent"), RadioButton)
                    ddlPercent = CType(grdBeneficiaries.Rows(b).FindControl("ddlPercent"), DropDownList)
                    If rbPrimary.Checked = True Or rbContingent.Checked = True Then
                        vBenId = grdBeneficiaries.DataKeys(b).Values("DepBenId")
                        vBenType = IIf(rbPrimary.Checked, "P", "C")

                        Dim objbParam As SqlParameter
                        Dim objbDataSet As New DataSet
                        Dim arybParams As New ArrayList()
                        Dim sqlbCon As New SQLControl
                        sqlbCon.OpenConn()

                        objbParam = New SqlParameter("@CompanyId", intCompanyId)
                        arybParams.Add(objbParam)
                        objbParam = New SqlParameter("@EmployeeId", intEmployeeId)
                        arybParams.Add(objbParam)
                        objbParam = New SqlParameter("@PlantypeId", intPlanTypeId)
                        arybParams.Add(objbParam)
                        objbParam = New SqlParameter("@PlanId", Session("SelectedPlanId"))
                        arybParams.Add(objbParam)
                        objbParam = New SqlParameter("@DepBenId", vBenId)
                        arybParams.Add(objbParam)
                        objbParam = New SqlParameter("@BeneficiaryType", vBenType)
                        arybParams.Add(objbParam)
                        objbParam = New SqlParameter("@Percentage", ddlPercent.SelectedValue)
                        arybParams.Add(objbParam)
                        objParam = New SqlParameter("@UserId", Session("UserId"))
                        aryParams.Add(objParam)

                        objbDataSet = sqlbCon.CreateDataSet("usp_Employee_Election_Beneficiary_Save", arybParams)
                        sqlbCon.CloseConn()
                    End If
                    b += 1
                Next


            End If
            Session("Changes") = "Saved"
            PlanClass.PopulatePendingBenefitSummary(intCompanyId, intEmployeeId, grdSummary)
            SetProgressBar()
            GetExistingElection()
        Else
            ResetScrollPosition()
        End If

        booIntheMiddleofaSave = False
        imgProcessing.Visible = False

    End Sub

#Region "Change to Elect or Waive"
    Protected Sub rdElect_CheckedChanged(sender As Object, e As EventArgs) Handles rdElect.CheckedChanged
        If rdElect.Checked = True Then
            rdWaive.Checked = False
            DivWaiveQuestions.Visible = False
            grdOptions.Enabled = True
            'If Previous entry was decline - need to get first option on list and save
            If InStr(Session("ExistingPlanFullDesc"), "Decline") > 0 Then
                Session("ExistingPlanFullDesc") = ""
                Session("SelectedPlanId") = 0
                'Get New Options and select first option
                GetNewPlanOptions()
            ElseIf InStr(Session("ExistingPlanFullDesc"), "Decline") = 0 And Session("ExistingPlanFullDesc") <> "" Then
                'It is not a Decline and has an existing election - so get existing data and save
                GetExistingElection()
            Else
                'Else no previous election or selected plan so just get first option and save
                GetNewPlanOptions()
            End If
            'should not need an else here as this only triggers when rdElect is checked true - radio buttons in a group are not checked false
            intPlanId = Session("SelectedPlanId")

            If divPlanQuestions.Visible = False Then
                bOkaytoSave = True
            Else
                CheckCompletePlanQuestions()
                'if questions are complete - i.e. true then bOkaytoSave is also true - and vice versa
                bOkaytoSave = booComplete
            End If

            If bOkaytoSave = True Then
                SaveElection()
            End If

            GetNavigationAndTabs()
            UpdateScreenBlocks(Session("PlanTypeId"))

        End If

    End Sub

    Protected Sub rdWaive_CheckedChanged(sender As Object, e As EventArgs) Handles rdWaive.CheckedChanged
        If rdWaive.Checked = True Then
            rdElect.Checked = False
            Session("SelectedPlanId") = Session("WaivePlanId")
            'Remove previous description and add waive description so screen block set properly to show modal or Qs
            Session("ExistingPlanFullDesc") = "I Decline Coverage for " + Session("PlanTypeLongDesc")
            UpdateScreenBlocks(Session("PlanTypeId"))
            If Session("WaiveQuestions") = True And Session("WaiveQuestionsAreComplete") = False Then
                'Just exit at this stage so that the questions can be entered
                Exit Sub
            ElseIf Session("WaiveQuestions") = True And Session("WaiveQuestionsAreComplete") = True Then
                SaveWaiveQuestions()
                SaveElection()
            Else
                'then save it
                SaveElection()
            End If

        End If
        'should not need an else here as this only triggers when rdElect is checked true - radio buttons in a group are not checked false
    End Sub

    Protected Sub rdElectInfo2_CheckedChanged(sender As Object, e As EventArgs) Handles rdElectInfo2.CheckedChanged
        If rdElectInfo2.Checked = True Then
            rdWaiveInfo2.Checked = False
            DivWaiveQuestions.Visible = False
            grdOptions.Enabled = True
            'If Previous entry was decline - need to get first option on list and save
            If InStr(Session("ExistingPlanFullDesc"), "Decline") > 0 Then
                Session("ExistingPlanFullDesc") = ""
                Session("SelectedPlanId") = 0
                'Get New Options and select first option
                GetNewPlanOptions()
            ElseIf InStr(Session("ExistingPlanFullDesc"), "Decline") = 0 And Session("ExistingPlanFullDesc") <> "" Then
                'It is not a Decline and has an existing election - so get existing data and save
                GetExistingElection()
            Else
                'Else no previous election or selected plan so just get first option and save
                GetNewPlanOptions()
            End If
            'should not need an else here as this only triggers when rdElect is checked true - radio buttons in a group are not checked false
            intPlanId = Session("SelectedPlanId")
            bOkaytoSave = True
            SaveElection()
            GetNavigationAndTabs()
            UpdateScreenBlocks(Session("PlanTypeId"))
        End If

    End Sub

    Protected Sub rdWaiveInfo2_CheckedChanged(sender As Object, e As EventArgs) Handles rdWaiveInfo2.CheckedChanged
        If rdWaiveInfo2.Checked = True Then
            rdElectInfo2.Checked = False
            Session("SelectedPlanId") = Session("WaivePlanId")
            'Remove previous description and add waive description so screen block set properly to show modal or Qs
            Session("ExistingPlanFullDesc") = "I Decline Coverage for " + Session("PlanTypeLongDesc")
            UpdateScreenBlocks(Session("PlanTypeId"))
            If Session("WaiveQuestions") = False Then
                'then save it
                SaveElection()
            End If
        End If
    End Sub

    Protected Sub rdElectModal_CheckedChanged(sender As Object, e As EventArgs) Handles rdElectModal.CheckedChanged
        If rdElectModal.Checked = True Then
            rdWaiveModal.Checked = False
            DivWaiveQuestions.Visible = False
            grdOptions.Enabled = True
            'If Previous entry was decline - need to get first option on list and save
            If InStr(Session("ExistingPlanFullDesc"), "Decline") > 0 Then
                Session("ExistingPlanFullDesc") = ""
                Session("SelectedPlanId") = 0
                'Get New Options and select first option
                GetNewPlanOptions()
            ElseIf InStr(Session("ExistingPlanFullDesc"), "Decline") = 0 And Session("ExistingPlanFullDesc") <> "" Then
                'It is not a Decline and has an existing election - so get existing data and save
                GetExistingElection()
            Else
                'Else no previous election or selected plan so just get first option and save
                GetNewPlanOptions()
            End If
            'should not need an else here as this only triggers when rdElect is checked true - radio buttons in a group are not checked false
            intPlanId = Session("SelectedPlanId")
            bOkaytoSave = True
            SaveElection()
            GetNavigationAndTabs()
            UpdateScreenBlocks(Session("PlanTypeId"))
        End If

    End Sub

    Protected Sub rdWaiveModal_CheckedChanged(sender As Object, e As EventArgs) Handles rdWaiveModal.CheckedChanged
        If rdWaiveModal.Checked = True Then
            rdElectModal.Checked = False
            Session("SelectedPlanId") = Session("WaivePlanId")
            'Remove previous description and add waive description so screen block set properly to show modal or Qs
            Session("ExistingPlanFullDesc") = "I Decline Coverage for " + Session("PlanTypeLongDesc")
            UpdateScreenBlocks(Session("PlanTypeId"))
            If Session("WaiveQuestions") = False Then
                'then save it
                SaveElection()
            End If
        End If
    End Sub

    Protected Sub rdElectOther_CheckedChanged(sender As Object, e As EventArgs) Handles rdElectOther.CheckedChanged
        If rdElectOther.Checked = True Then
            rdWaiveOther.Checked = False
            DivWaiveQuestions.Visible = False
            grdOptions.Enabled = True
            'If Previous entry was decline - need to get first option on list and save
            If InStr(Session("ExistingPlanFullDesc"), "Decline") > 0 Then
                Session("ExistingPlanFullDesc") = ""
                Session("SelectedPlanId") = 0
                'Get New Options and select first option
                GetNewPlanOptions()
            ElseIf InStr(Session("ExistingPlanFullDesc"), "Decline") = 0 And Session("ExistingPlanFullDesc") <> "" Then
                'It is not a Decline and has an existing election - so get existing data and save
                GetExistingElection()
            Else
                'Else no previous election or selected plan so just get first option and save
                GetNewPlanOptions()
            End If
            'should not need an else here as this only triggers when rdElect is checked true - radio buttons in a group are not checked false
            intPlanId = Session("SelectedPlanId")

            If grdPlanQuestions.Visible = True Then
                CheckCompletePlanQuestions()
                If booComplete = True Then
                    bOkaytoSave = True
                    grdPlanQuestions.Enabled = False
                    btnEditResponses.Visible = True
                    btnSavePlanQuestions.Visible = False
                    grdOptions.Enabled = True
                    SaveElection()
                ElseIf booComplete = False Then
                    bOkaytoSave = False
                    grdPlanQuestions.Enabled = True
                    btnEditResponses.Visible = False
                    btnSavePlanQuestions.Visible = True
                    grdOptions.Enabled = False
                End If
            Else
                bOkaytoSave = True
                SaveElection()
            End If

            GetNavigationAndTabs()
            UpdateScreenBlocks(Session("PlanTypeId"))
        End If

    End Sub

    Protected Sub rdWaiveOther_CheckedChanged(sender As Object, e As EventArgs) Handles rdWaiveOther.CheckedChanged
        If rdWaiveOther.Checked = True Then
            rdElectOther.Checked = False
            Session("SelectedPlanId") = Session("WaivePlanId")
            'Remove previous description and add waive description so screen block set properly to show modal or Qs
            Session("ExistingPlanFullDesc") = "I Decline Coverage for " + Session("PlanTypeLongDesc")
            UpdateScreenBlocks(Session("PlanTypeId"))
            If Session("WaiveQuestions") = False Then
                'then save it
                SaveElection()
            End If
        End If
    End Sub

    Protected Sub rdElectInfo_CheckedChanged(sender As Object, e As EventArgs) Handles rdElectInfo.CheckedChanged
        If rdElectInfo.Checked = True Then
            rdWaiveInfo.Checked = False
            DivWaiveQuestions.Visible = False
            grdOptions.Enabled = True
            'If Previous entry was decline - need to get first option on list and save
            If InStr(Session("ExistingPlanFullDesc"), "Decline") > 0 Then
                Session("ExistingPlanFullDesc") = ""
                Session("SelectedPlanId") = 0
                'Get New Options and select first option
                GetNewPlanOptions()
            ElseIf InStr(Session("ExistingPlanFullDesc"), "Decline") = 0 And Session("ExistingPlanFullDesc") <> "" Then
                'It is not a Decline and has an existing election - so get existing data and save
                GetExistingElection()
            Else
                'Else no previous election or selected plan so just get first option and save
                GetNewPlanOptions()
            End If
            'should not need an else here as this only triggers when rdElect is checked true - radio buttons in a group are not checked false
            intPlanId = Session("SelectedPlanId")

            If grdPlanQuestions.Visible = True Then
                CheckCompletePlanQuestions()
                If booComplete = True Then
                    bOkaytoSave = True
                    grdPlanQuestions.Enabled = False
                    btnEditResponses.Visible = True
                    btnSavePlanQuestions.Visible = False
                    grdOptions.Enabled = True
                    SaveElection()
                ElseIf booComplete = False Then
                    bOkaytoSave = False
                    grdPlanQuestions.Enabled = True
                    btnEditResponses.Visible = False
                    btnSavePlanQuestions.Visible = True
                    grdOptions.Enabled = False
                End If
            Else
                bOkaytoSave = True
                SaveElection()
            End If

            GetNavigationAndTabs()
            UpdateScreenBlocks(Session("PlanTypeId"))
        End If

    End Sub

    Protected Sub rdWaiveInfo_CheckedChanged(sender As Object, e As EventArgs) Handles rdWaiveInfo.CheckedChanged
        If rdWaiveInfo.Checked = True Then
            rdElectInfo.Checked = False
            Session("SelectedPlanId") = Session("WaivePlanId")
            'Remove previous description and add waive description so screen block set properly to show modal or Qs
            Session("ExistingPlanFullDesc") = "I Decline Coverage for " + Session("PlanTypeLongDesc")
            UpdateScreenBlocks(Session("PlanTypeId"))
            If Session("WaiveQuestions") = False Then
                'then save it
                If grdPlanQuestions.Visible = True Then
                    CheckCompletePlanQuestions()
                    If booComplete = True Then
                        bOkaytoSave = True
                        grdPlanQuestions.Enabled = False
                        btnEditResponses.Visible = True
                        btnSavePlanQuestions.Visible = False
                        grdOptions.Enabled = True
                        SaveElection()
                    ElseIf booComplete = False Then
                        bOkaytoSave = False
                        grdPlanQuestions.Enabled = True
                        btnEditResponses.Visible = False
                        btnSavePlanQuestions.Visible = True
                        grdOptions.Enabled = False
                    End If
                Else
                    bOkaytoSave = True
                    SaveElection()
                End If
            End If
        End If
    End Sub

    Protected Sub rdElectBoth_CheckedChanged(sender As Object, e As EventArgs) Handles rdElectBoth.CheckedChanged
        If rdElectBoth.Checked = True Then
            rdWaiveBoth.Checked = False
            DivWaiveQuestions.Visible = False
            grdOptions.Enabled = True
            'If Previous entry was decline - need to get first option on list and save
            If InStr(Session("ExistingPlanFullDesc"), "Decline") > 0 Then
                Session("ExistingPlanFullDesc") = ""
                Session("SelectedPlanId") = 0
                'Get New Options and select first option
                GetNewPlanOptions()
            ElseIf InStr(Session("ExistingPlanFullDesc"), "Decline") = 0 And Session("ExistingPlanFullDesc") <> "" Then
                'It is not a Decline and has an existing election - so get existing data and save
                GetExistingElection()
            Else
                'Else no previous election or selected plan so just get first option and save
                GetNewPlanOptions()
            End If
            'should not need an else here as this only triggers when rdElect is checked true - radio buttons in a group are not checked false
            intPlanId = Session("SelectedPlanId")

            If grdPlanQuestions.Visible = True Then
                CheckCompletePlanQuestions()
                If booComplete = True Then
                    bOkaytoSave = True
                    grdPlanQuestions.Enabled = False
                    btnEditResponses.Visible = True
                    btnSavePlanQuestions.Visible = False
                    grdOptions.Enabled = True
                    SaveElection()
                ElseIf booComplete = False Then
                    bOkaytoSave = False
                    grdPlanQuestions.Enabled = True
                    btnEditResponses.Visible = False
                    btnSavePlanQuestions.Visible = True
                    grdOptions.Enabled = False
                End If
            Else
                bOkaytoSave = True
                SaveElection()
            End If

            GetNavigationAndTabs()
            UpdateScreenBlocks(Session("PlanTypeId"))
        End If

    End Sub

    Protected Sub rdWaiveBoth_CheckedChanged(sender As Object, e As EventArgs) Handles rdWaiveBoth.CheckedChanged
        If rdWaiveBoth.Checked = True Then
            rdElectBoth.Checked = False
            Session("SelectedPlanId") = Session("WaivePlanId")
            'Remove previous description and add waive description so screen block set properly to show modal or Qs
            Session("ExistingPlanFullDesc") = "I Decline Coverage for " + Session("PlanTypeLongDesc")
            UpdateScreenBlocks(Session("PlanTypeId"))
            If Session("WaiveQuestions") = False Then
                'then save it
                If grdPlanQuestions.Visible = True Then
                    CheckCompletePlanQuestions()
                    If booComplete = True Then
                        bOkaytoSave = True
                        grdPlanQuestions.Enabled = False
                        btnEditResponses.Visible = True
                        btnSavePlanQuestions.Visible = False
                        grdOptions.Enabled = True
                        SaveElection()
                    ElseIf booComplete = False Then
                        bOkaytoSave = False
                        grdPlanQuestions.Enabled = True
                        btnEditResponses.Visible = False
                        btnSavePlanQuestions.Visible = True
                        grdOptions.Enabled = False
                    End If
                Else
                    bOkaytoSave = True
                    SaveElection()
                End If
            End If
        End If
    End Sub

    Protected Sub mimgWaiveCancel_Click(sender As Object, e As ImageClickEventArgs) Handles mimgWaiveCancel.Click
        grdBeneficiaries.Enabled = True
        grdCoveredDependents.Enabled = True
        grdOptions.Enabled = True
        grdPlanQuestions.Enabled = True
        rdElectModal.Checked = True
        rdWaiveModal.Checked = False
    End Sub

    Protected Sub mimgWaiveSave_Click(sender As Object, e As ImageClickEventArgs) Handles mimgWaiveSave.Click

        'Update radio buttons on main screen
        grdBeneficiaries.Enabled = False
        grdCoveredDependents.Enabled = False
        grdOptions.Enabled = False
        grdPlanQuestions.Enabled = True

        rdElectModal.Checked = False
        rdWaiveModal.Checked = True

        rdElectBoth.Checked = False
        rdWaiveBoth.Checked = True
        'uncheck all deps
        For Each gvr In grdCoveredDependents.Rows
            Dim chkCovered As CheckBox = DirectCast(gvr.FindControl("chkCovered"), CheckBox)
            chkCovered.Checked = False
        Next

        'uncheck all options
        For Each rw In grdOptions.Rows
            Dim chkOption As RadioButton = DirectCast(rw.findControl("rbOption"), RadioButton)
            chkOption.Checked = False
            Dim btn As Button = DirectCast(rw.findControl("btnBenefitAmount"), Button)
            If btn.Visible = True Then
                btn.Enabled = True
            End If

        Next

        'Hide PCP Block if visible
        divPCPSection.Visible = False

        SaveElection()
        GetNavigationAndTabs()
        UpdateScreenBlocks(intPlanTypeId)
        GetExistingElection()

    End Sub
#End Region

#Region "Saving on HSA Module"
    Sub HSASave()
        strEventType = Session("EventType")

        If strEventType = "No Event Declared" Then
            divError.Visible = True
            lblError.Text = "You must Declare an Event in order to make or change any options on this page."
            ResetScrollPosition()
            Exit Sub
        End If

        'Go get HSA Plan and Rate Id
        intPlanTypeId = Session("CurrentPlanTypeId")
        PlanClass.GetHSAPlanInfo(intCompanyId, intEmployeeId, intPlanTypeId, Session("EECovered"), Session("SPCovered"), Session("DPCovered"), Session("NumOfDeps"), Session("ChildIds"))

        Dim HSAMax As Double
        HSAMax = PlanClass.HSAMax

        'CHECK FOR MIN/MAX VALUE FIRST
        If mtxtHSAAnnualElection.Text < Session("HSAMinValue") Or mtxtHSAAnnualElection.Text > HSAMax Then
            divError.Visible = True
            lblError.Text = "The HSA Contribution entered exceeds the maximum amount allowed of $" + HSAMax.ToString + ".  Please correct and try again."
            ResetScrollPosition()
            Exit Sub
        End If

        'Save the answers to Questions 
        PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, PlanClass.HSAPlanId, 5, mtxtHSAQuestion1.Text, "", "", Session("LatestEventDate"), Session("Userid"))
        PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, PlanClass.HSAPlanId, 6, mtxtHSAQuestion2.Text, "", "", Session("LatestEventDate"), Session("Userid"))
        PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, PlanClass.HSAPlanId, 7, mtxtHSAQuestion3.Text, "", "", Session("LatestEventDate"), Session("Userid"))
        PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, PlanClass.HSAPlanId, 32, mchkUMBAccount.Checked, "", "", Session("LatestEventDate"), Session("Userid"))

        'Have to save HSA Election separately
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        lblError.Text = ""
        divError.Visible = False

        objParam = New SqlParameter("@CompanyId", intCompanyId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EmployeeId", intEmployeeId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@PlantypeId", 19)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@PlanId", PlanClass.HSAPlanId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@RateId", PlanClass.HSARateId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@CoverageBeginDate", Session("LatestEventDate"))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EECost", "0")
        aryParams.Add(objParam)
        objParam = New SqlParameter("@ERCost", "0")
        aryParams.Add(objParam)
        objParam = New SqlParameter("@MonthlyEECost", "0")
        aryParams.Add(objParam)
        objParam = New SqlParameter("@MonthlyERCost", "0")
        aryParams.Add(objParam)
        objParam = New SqlParameter("@BenefitAmount", mtxtHSAAnnualElection.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EventTypeId", Session("EventTypeId"))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@UserId", Session("UserId"))
        aryParams.Add(objParam)
        objDataSet = sqlCon.CreateDataSet("usp_Employee_Election_Save", aryParams)
        sqlCon.CloseConn()

        'Save Covered Dependents
        If divPlanDependents.Visible = True Then
            'Check to see if any Dependents are covered
            Dim vDepId As Integer
            Dim d As Integer
            For Each gvr In grdCoveredDependents.Rows
                Dim chk As CheckBox
                chk = CType(grdCoveredDependents.Rows(d).FindControl("chkCovered"), CheckBox)
                If chk.Checked = True Then
                    vDepId = grdCoveredDependents.DataKeys(d).Values("DepBenId")

                    Dim objdParam As SqlParameter
                    Dim objdDataSet As New DataSet
                    Dim arydParams As New ArrayList()
                    Dim sqldCon As New SQLControl
                    sqldCon.OpenConn()

                    objdParam = New SqlParameter("@CompanyId", intCompanyId)
                    arydParams.Add(objdParam)
                    objdParam = New SqlParameter("@EmployeeId", intEmployeeId)
                    arydParams.Add(objdParam)
                    objdParam = New SqlParameter("@PlantypeId", 19)
                    arydParams.Add(objdParam)
                    objdParam = New SqlParameter("@PlanId", Session("SelectedPlanId"))
                    arydParams.Add(objdParam)
                    objdParam = New SqlParameter("@DepBenId", vDepId)
                    arydParams.Add(objdParam)
                    objdParam = New SqlParameter("@UserId", Session("UserId"))
                    arydParams.Add(objdParam)

                    objdDataSet = sqldCon.CreateDataSet("usp_Dependent_Election_Save", arydParams)
                    sqldCon.CloseConn()
                End If
                d += 1
            Next
        End If

        'Save Beneficiary Information
        If divBeneficiary.Visible = True Then
            'Check to see if any Dependents are covered
            Dim vBenId As Integer
            Dim b As Integer
            Dim vBenType As String

            For Each gvr In grdBeneficiaries.Rows
                Dim rbPrimary As RadioButton
                Dim rbContingent As RadioButton
                Dim ddlPercent As DropDownList
                rbPrimary = CType(grdBeneficiaries.Rows(b).FindControl("rbPrimary"), RadioButton)
                rbContingent = CType(grdBeneficiaries.Rows(b).FindControl("rbContingent"), RadioButton)
                ddlPercent = CType(grdBeneficiaries.Rows(b).FindControl("ddlPercent"), DropDownList)
                If rbPrimary.Checked = True Or rbContingent.Checked = True Then
                    vBenId = grdBeneficiaries.DataKeys(b).Values("DepBenId")
                    vBenType = IIf(rbPrimary.Checked, "P", "C")

                    Dim objbParam As SqlParameter
                    Dim objbDataSet As New DataSet
                    Dim arybParams As New ArrayList()
                    Dim sqlbCon As New SQLControl
                    sqlbCon.OpenConn()

                    objbParam = New SqlParameter("@CompanyId", intCompanyId)
                    arybParams.Add(objbParam)
                    objbParam = New SqlParameter("@EmployeeId", intEmployeeId)
                    arybParams.Add(objbParam)
                    objbParam = New SqlParameter("@PlantypeId", 19)
                    arybParams.Add(objbParam)
                    objbParam = New SqlParameter("@PlanId", PlanClass.HSAPlanId)
                    arybParams.Add(objbParam)
                    objbParam = New SqlParameter("@DepBenId", vBenId)
                    arybParams.Add(objbParam)
                    objbParam = New SqlParameter("@BeneficiaryType", vBenType)
                    arybParams.Add(objbParam)
                    objbParam = New SqlParameter("@Percentage", ddlPercent.SelectedValue)
                    arybParams.Add(objbParam)
                    objParam = New SqlParameter("@UserId", Session("UserId"))
                    aryParams.Add(objParam)

                    objbDataSet = sqlbCon.CreateDataSet("usp_Employee_Election_Beneficiary_Save", arybParams)
                    sqlbCon.CloseConn()
                End If
                b += 1
            Next

        End If
        Session("Changes") = "Saved"
        GetNewPlanOptions()
        GetExistingElection()
        PlanClass.PopulatePendingBenefitSummary(intCompanyId, intEmployeeId, grdSummary)
        SetProgressBar()

    End Sub
#End Region

#Region "Saving on Benefit Amount Modal"
    Protected Sub mbtnBenAmtSave_Click(sender As Object, e As ImageClickEventArgs) Handles mbtnBenAmtSave.Click
        strEventType = Session("EventType")

        If strEventType = "No Event Declared" Then
            divError.Visible = True
            lblError.Text = "You must Declare an Event in order to make or change any options on this page."
            ResetScrollPosition()
            Exit Sub
        End If

        Dim intRateId As Integer
        'FIRST CHECK FOR MIN/MAX VALUE - happens in Save Election
        Session("ModalBenefitAmount") = mtxtBenAmt.Text
        If mtxtEECost.Visible = True Then
            Session("ModalEECost") = mtxtEECost.Text
        End If

        'apparently i need to transfer cost to options grid before saving 
        Dim i As Int32
        For Each gvr In grdOptions.Rows
            Dim rb As RadioButton
            Dim vPlanId As Integer
            Dim vRateId As Integer
            Dim vMaxValue As Double
            Dim vBenAmt As String

            rb = CType(grdOptions.Rows(i).FindControl("rbOption"), RadioButton)
            If rb.Checked = True Then
                vPlanId = grdOptions.DataKeys(i).Values("PlanId")
                vRateId = grdOptions.DataKeys(i).Values("RateId")
                grdOptions.Rows(i).Cells(8).Text = FormatCurrency(Session("ModalBenefitAmount"))
                grdOptions.Rows(i).Cells(6).Text = FormatCurrency(Session("ModalEECost"))
                vMaxValue = grdOptions.DataKeys(i).Values("MaxValue")
                vBenAmt = grdOptions.DataKeys(i).Values("BenefitFinal")
            End If
            i += 1

            intPlanTypeId = Session("CurrentPlanTypeId")
            intPlanId = vPlanId
            Session("PlanId") = vPlanId
            intRateId = vRateId
            Session("RateId") = vRateId

            If vMaxValue > 0 Then
                If Session("ModalBenefitAmount") > vMaxValue Then
                    mtxtBenAmt.Text = vMaxValue
                    Session("ModalBenefitAmount") = vMaxValue
                End If
            End If

            Session("MaxValue") = vMaxValue

        Next

        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        'Label1.Text = intCompanyId.ToString
        'Label2.Text = intEmployeeId.ToString
        'Label3.Text = Session("CurrentPlanTypeId").ToString
        'Label4.Text = Session("SelectedPlanId").ToString
        'Label13.Text = Session("RateId").ToString
        'Label6.Text = mtxtEECost.Text
        'Label9.Text = mtxtBenAmt.Text
        'Label10.Text = Session("LatestEventDate").ToString
        'Label11.Text = Session("EventTypeId").ToString
        'Label12.Text = Session("UserId").ToString

        intPlanTypeId = Session("CurrentPlanTypeId")
        intPlanId = Session("SelectedPlanId")
        'intRateId = Session("SelectedRateId")

        objParam = New SqlParameter("@CompanyId", intCompanyId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EmployeeId", intEmployeeId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@PlantypeId", intPlanTypeId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@PlanId", intPlanId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@RateId", intRateId)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@CoverageBeginDate", Session("LatestEventDate"))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EECost", mtxtEECost.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@ERCost", "0")
        aryParams.Add(objParam)
        objParam = New SqlParameter("@MonthlyEECost", "0")
        aryParams.Add(objParam)
        objParam = New SqlParameter("@MonthlyERCost", "0")
        aryParams.Add(objParam)
        objParam = New SqlParameter("@BenefitAmount", mtxtBenAmt.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EventTypeId", Session("EventTypeId"))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@UserId", Session("UserId"))
        aryParams.Add(objParam)

        objDataSet = sqlCon.CreateDataSet("usp_Employee_Election_Save", aryParams)
        sqlCon.CloseConn()

        'Save Covered Dependents
        If divPlanDependents.Visible = True Then
            'Check to see if any Dependents are covered
            Dim vDepId As Integer
            Dim d As Integer
            For Each gvr In grdCoveredDependents.Rows
                Dim chk As CheckBox
                chk = CType(grdCoveredDependents.Rows(d).FindControl("chkCovered"), CheckBox)
                If chk.Checked = True Then
                    vDepId = grdCoveredDependents.DataKeys(d).Values("DepBenId")

                    Dim objdParam As SqlParameter
                    Dim objdDataSet As New DataSet
                    Dim arydParams As New ArrayList()
                    Dim sqldCon As New SQLControl
                    sqldCon.OpenConn()

                    objdParam = New SqlParameter("@CompanyId", intCompanyId)
                    arydParams.Add(objdParam)
                    objdParam = New SqlParameter("@EmployeeId", intEmployeeId)
                    arydParams.Add(objdParam)
                    objdParam = New SqlParameter("@PlantypeId", intPlanTypeId)
                    arydParams.Add(objdParam)
                    objdParam = New SqlParameter("@PlanId", Session("SelectedPlanId"))
                    arydParams.Add(objdParam)
                    objdParam = New SqlParameter("@DepBenId", vDepId)
                    arydParams.Add(objdParam)
                    objdParam = New SqlParameter("@UserId", Session("UserId"))
                    arydParams.Add(objdParam)

                    objdDataSet = sqldCon.CreateDataSet("usp_Dependent_Election_Save", arydParams)
                    sqldCon.CloseConn()
                End If
                d += 1
            Next
        End If

        'Save Beneficiary Information
        If divBeneficiary.Visible = True Then
            'Check to see if any Dependents are covered
            Dim vBenId As Integer
            Dim b As Integer
            Dim vBenType As String

            For Each gvr In grdBeneficiaries.Rows
                Dim rbPrimary As RadioButton
                Dim rbContingent As RadioButton
                Dim ddlPercent As DropDownList
                rbPrimary = CType(grdBeneficiaries.Rows(b).FindControl("rbPrimary"), RadioButton)
                rbContingent = CType(grdBeneficiaries.Rows(b).FindControl("rbContingent"), RadioButton)
                ddlPercent = CType(grdBeneficiaries.Rows(b).FindControl("ddlPercent"), DropDownList)
                If rbPrimary.Checked = True Or rbContingent.Checked = True Then
                    vBenId = grdBeneficiaries.DataKeys(b).Values("DepBenId")
                    vBenType = IIf(rbPrimary.Checked, "P", "C")

                    Dim objbParam As SqlParameter
                    Dim objbDataSet As New DataSet
                    Dim arybParams As New ArrayList()
                    Dim sqlbCon As New SQLControl
                    sqlbCon.OpenConn()


                    objbParam = New SqlParameter("@CompanyId", intCompanyId)
                    arybParams.Add(objbParam)
                    objbParam = New SqlParameter("@EmployeeId", intEmployeeId)
                    arybParams.Add(objbParam)
                    objbParam = New SqlParameter("@PlantypeId", intPlanTypeId)
                    arybParams.Add(objbParam)
                    objbParam = New SqlParameter("@PlanId", PlanClass.HSAPlanId)
                    arybParams.Add(objbParam)
                    objbParam = New SqlParameter("@DepBenId", vBenId)
                    arybParams.Add(objbParam)
                    objbParam = New SqlParameter("@BeneficiaryType", vBenType)
                    arybParams.Add(objbParam)
                    objbParam = New SqlParameter("@Percentage", ddlPercent.SelectedValue)
                    arybParams.Add(objbParam)
                    objParam = New SqlParameter("@UserId", Session("UserId"))
                    aryParams.Add(objParam)

                    objbDataSet = sqlbCon.CreateDataSet("usp_Employee_Election_Beneficiary_Save", arybParams)
                    sqlbCon.CloseConn()
                End If
                b += 1
            Next

        End If
        Session("Changes") = "Saved"
        GetNewPlanOptions()
        GetExistingElection()
        PlanClass.PopulatePendingBenefitSummary(intCompanyId, intEmployeeId, grdSummary)
        SetProgressBar()
    End Sub

#End Region

#Region "Closing Information or Acknowledgement Modal"
    Protected Sub mbtnInfoCancel_Click(sender As Object, e As ImageClickEventArgs) Handles mbtnInfoCancel.Click
        grdBeneficiaries.Enabled = True
        grdCoveredDependents.Enabled = True
        grdOptions.Enabled = True
        grdPlanQuestions.Enabled = True
        rdElectOther.Checked = True
        rdWaiveOther.Checked = False
    End Sub

    Protected Sub mbtnInfoAcknowledge_Click(sender As Object, e As ImageClickEventArgs) Handles mbtnInfoAcknowledge.Click
        'Save the answers to Questions 
        Dim strAnswer As String
        strAnswer = "Employee Id: " + intEmployeeId.ToString + " Has Acknowledged the Benefits Discloser for Plan Type Id:  " + intPlanTypeId.ToString
        PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, Session("SelectedPlanId"), 31, strAnswer, "", "", Session("LatestEventDate"), Session("Userid"))

        grdBeneficiaries.Enabled = True
        grdCoveredDependents.Enabled = True
        grdOptions.Enabled = True
        grdPlanQuestions.Enabled = True
        rdElectOther.Checked = True
        rdWaiveOther.Checked = False
        rdElectBoth.Checked = True
        rdWaiveBoth.Checked = False

        If grdPlanQuestions.Visible = True Then
            CheckCompletePlanQuestions()
        End If

    End Sub

    'Protected Sub mbtnWaiveInfoCancel_Click(sender As Object, e As ImageClickEventArgs) Handles mbtnWaiveInfoCancel.Click
    '    'THIS CANCEL IS ON THE WAIVE    
    '    grdBeneficiaries.Enabled = False
    '    grdCoveredDependents.Enabled = False
    '    grdOptions.Enabled = False
    '    grdPlanQuestions.Enabled = False
    '    If divElectWaiveBothWithInfoModal.Visible = True Then
    '        rdElectInfo.Checked = False
    '        rdWaiveInfo.Checked = True

    '    ElseIf divWaiveWithInfoModal.Visible = True Then
    '        rdElectInfo2.Checked = False
    '        rdWaiveInfo2.Checked = True
    '    End If

    '    'deselect plan options
    '    For Each rw In grdOptions.Rows
    '        Dim chkOption As RadioButton = DirectCast(rw.findControl("rbOption"), RadioButton)
    '        chkOption.Checked = False
    '        Dim btn As Button = DirectCast(rw.findControl("btnBenefitAmount"), Button)
    '        If btn.Visible = True Then
    '            btn.Enabled = True
    '        End If
    '    Next

    'End Sub


    Protected Sub mbtnWaiveInfoAcknowledge_Click(sender As Object, e As ImageClickEventArgs) Handles mbtnWaiveInfoAcknowledge.Click
        'Save the answers to Questions

        'THIS ACKNOWLEDGE IS ON THE WAIVE        
        Dim strAnswer As String
        intPlanTypeId = Session("CurrentPlanTypeId")
        strAnswer = "Employee Id: " + intEmployeeId.ToString + " Has Acknowledged the Benefits Waive Discloser for Plan Type Id:  " + intPlanTypeId.ToString
        PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, Session("SelectedPlanId"), 31, strAnswer, "", "", Session("LatestEventDate"), Session("Userid"))

        grdBeneficiaries.Enabled = False
        grdCoveredDependents.Enabled = False
        grdOptions.Enabled = False
        grdPlanQuestions.Enabled = False

        If divElectWaiveBothWithInfoModal.Visible = True Then
            rdElectInfo.Checked = False
            rdWaiveInfo.Checked = True
        ElseIf divWaiveWithInfoModal.Visible = True Then
            rdElectInfo2.Checked = False
            rdWaiveInfo2.Checked = True
        End If

        'deselect plan options
        For Each rw In grdOptions.Rows
            Dim chkOption As RadioButton = DirectCast(rw.findControl("rbOption"), RadioButton)
            chkOption.Checked = False
            Dim btn As Button = DirectCast(rw.findControl("btnBenefitAmount"), Button)
            If btn.Visible = True Then
                btn.Enabled = True
            End If
        Next
        SaveElection()
        GetNavigationAndTabs()

    End Sub

#End Region

#Region "Row DataBound for GRID VIEWS"
    Protected Sub grdOptions_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdOptions.RowDataBound
        'Adding in Contribution Button to Options Grid
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim keys As DataKey = grdOptions.DataKeys(e.Row.RowIndex)
            Dim PlanId As Object = keys("PlanId")
            Dim BundledPlanId As Object = keys("BundledPlanId")
            Dim AdminBenefit As Object = keys("InputBenefitAmountAdmin")
            Dim EEBenefit As Object = keys("InputBenefitAmountEE")
            Dim EECostInputEE As Object = keys("InputEERateEE")
            Dim EECostInputAdmin As Object = keys("InputEERateAdmin")
            Dim ERCostInput As Object = keys("InputERRateAdmin")
            Dim MinValue As Object = keys("MinValue")
            Dim MaxValue As Object = keys("MaxValue")
            Dim PlanModalId As Object = keys("PlanModalId")
            Dim PlanModalType As Object = keys("PlanModalType")
            'Need this in session for Save Button

            mtxtHSAAnnualElection.Text = 0

            If e.Row.Cells(22).Text.Contains("None") Then
                LabelModalId.Text = e.Row.Cells(22).Text
            End If

            If (Session("Admin") = True And AdminBenefit = True) Or (Session("Admin") = False And EEBenefit = True) Or (EECostInputAdmin = True) Or (ERCostInput = True) Or EECostInputEE = True Then

                If e.Row.Cells(3).Text.Contains("HSA") Then
                    Dim btnAmount As Button = DirectCast(e.Row.FindControl("btnBenefitAmount"), Button)
                    btnAmount.Attributes.Add("data-target", "#ModalHSA")
                    btnAmount.Visible = True
                    btnAmount.Enabled = True
                    Session("HSAPlanId") = BundledPlanId
                    Session("HSAMinValue") = MinValue
                    Session("HSAMaxValue") = MaxValue

                    ''Populate HSA Modal
                    If PlanClass.GetModalContentByPlanId(IIf(BundledPlanId <> 0, BundledPlanId, PlanId), Session("UserId")) Then
                        Dim strPlanYear As String
                        strPlanYear = DatePart(DateInterval.Year, Session("LatestEventDate"))
                        mlblHSATitle.Text = PlanClass.ModalTitle
                        mlblHSAText1.Text = PlanClass.ModalText1
                        mlblHSAText2.Text = PlanClass.ModalText2
                        mlblHSAText3.Text = PlanClass.ModalText3
                        mlblHSAPlanYear.Text = strPlanYear
                        'mlblHSAMaximums.Text = "Maximum annual amount allowed for " + strPlanYear + " is $3,000 for single coverage & $6,550 for family coverage.<br>The annual election amount will be deducted over the total number of remaining checks in " + strPlanYear + "."

                        'pre populate with any previous responses
                        PlanClass.GetEmployeeQuestionResponses(intEmployeeId, Session("LatestEventDate"))
                        mtxtHSAQuestion1.Text = PlanClass.Response5
                        mtxtHSAQuestion2.Text = PlanClass.Response6
                        mtxtHSAQuestion3.Text = PlanClass.Response7
                        mchkUMBAccount.Checked = PlanClass.Response32
                    End If

                Else 'Show buttons based on setup
                    If Session("Admin") = True Or (Session("Admin") = False And EEBenefit = True) Or EECostInputEE = True Then
                        Dim btnAmount As Button = DirectCast(e.Row.FindControl("btnBenefitAmount"), Button)
                        btnAmount.Attributes.Add("data-target", "#ModalBenefitAmount")
                        btnAmount.Visible = True
                        btnAmount.Enabled = True
                        btnAmount.Text = "Enter Amount"
                        'Clear out any previously entered values- WHY?  COMMENTED THIS OUT
                        'mtxtBenAmt.Text = 0
                        'mtxtBenAmt.Visible = False
                        'mtxtEECost.Text = 0
                        'mtxtEECost.Visible = False

                        If EEBenefit = False And AdminBenefit = False Then
                            mlblBenAmt.Visible = False
                            mtxtBenAmt.Visible = False
                            mlblMinMax.Visible = False
                        Else
                            mlblBenAmt.Visible = True
                            mtxtBenAmt.Visible = True
                            mlblMinMax.Visible = True
                            If MinValue = 0 And MaxValue > 0 Then
                                mlblMinMax.Text = "The Maximum Benefit Amount allowed is $" + MaxValue.ToString
                            ElseIf MinValue > 0 And MaxValue > 0 Then
                                mlblMinMax.Text = "The Benefit Amount must be between $" + MinValue.ToString + " and $" + MaxValue.ToString
                            Else
                                mlblMinMax.Text = ""
                            End If

                        End If

                        If Session("Admin") = True And EECostInputAdmin = False Then
                            mlblEECost.Visible = False
                            mtxtEECost.Visible = False
                            mlblPayFrequency.Visible = False
                        ElseIf Session("Admin") = False And EECostInputEE = False Then
                            mlblEECost.Visible = False
                            mtxtEECost.Visible = False
                            mlblPayFrequency.Visible = False
                        Else
                            mlblEECost.Visible = True
                            mtxtEECost.Visible = True
                            mlblPayFrequency.Visible = True
                        End If

                        'Populate  Modal
                        Dim strPlanYear As String
                        strPlanYear = DatePart(DateInterval.Year, Session("LatestEventDate"))
                        intModalId = Session("PlanModalId")
                        If intModalId > 0 Then
                            PlanClass.GetModalContentByModalId(intModalId, intCompanyId, intEmployeeId)
                            If mtxtBenAmt.Visible = True And mtxtEECost.Visible = True And PlanClass.ModalTitle = "" Then
                                mlblBenAmtTitle.Text = "Enter Benefit Amount and Employee Cost"
                            ElseIf mtxtBenAmt.Visible = False And mtxtEECost.Visible = True And PlanClass.ModalTitle = "" Then
                                mlblBenAmtTitle.Text = "Enter Employee Cost"
                            ElseIf mtxtBenAmt.Visible = True And mtxtEECost.Visible = False And PlanClass.ModalTitle = "" Then
                                mlblBenAmtTitle.Text = "Enter Benefit Amount"
                            Else
                                mlblBenAmtTitle.Text = PlanClass.ModalTitle
                            End If

                            mlblBenAmt.Text = "Enter <strong>" & PlanClass.BenefitFrequency & "</strong> Contribution/Benefit Amount"
                            mlblBenAmtText1.Text = PlanClass.ModalText1
                            mlblBenAmtText2.Text = PlanClass.ModalText2
                            mlblBenAmtText3.Text = PlanClass.ModalText3

                        End If

                    End If
                    'Eventually add others for HCRA/DCRA modules or whatever else we come up with...i'm exhausted!!
                End If
            End If
        End If
    End Sub

    Protected Sub grdCoveredDependents_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdCoveredDependents.RowDataBound
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)

        If e.Row.RowType = DataControlRowType.DataRow Then

            'Group Universal life Spouse rider HIDE CHILD ROWS
            If (Session("CurrentPlanTypeId") = 42 Or Session("CurrentPlanTypeId") = 55) And (e.Row.Cells(3).Text <> ("Spouse") And e.Row.Cells(3).Text <> "Domestic Partner" And e.Row.Cells(3).Text <> ("Common Law Spouse")) Then
                e.Row.Visible = False
                'Group Universal life Child rider HIDE SPOUSE ROW
            ElseIf (Session("CurrentPlanTypeId") = 43 Or Session("CurrentPlanTypeId") = 56) And (e.Row.Cells(3).Text = ("Spouse") Or e.Row.Cells(3).Text = "Domestic Partner" Or e.Row.Cells(3).Text = ("Common Law Spouse")) Then
                e.Row.Visible = False
            End If

            Dim ddl As DropDownList = DirectCast(e.Row.FindControl("ddlTobacco"), DropDownList)
            Dim lblTobacco = DirectCast(e.Row.FindControl("lblTobacco"), Label)

            ddl.Items.Add(New ListItem("Yes", "Yes"))
            ddl.Items.Add(New ListItem("No", "No"))

            ddl.Items.FindByValue(lblTobacco.Text).Selected = True

            If e.Row.Cells(3).Text = ("Spouse") Or e.Row.Cells(3).Text = "Domestic Partner" Or e.Row.Cells(3).Text = ("Common Law Spouse") Then
                Session("HasSpouse") = 1
            Else
                Session("HasChild") = 1
            End If
        End If

    End Sub

    Protected Sub grdPlanQuestions_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdPlanQuestions.RowDataBound
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim keys As DataKey = grdPlanQuestions.DataKeys(e.Row.RowIndex)
            Dim QuestionId As Object = keys("QuestionId")
            Dim AskEmployee As Object = keys("Employee")
            Dim AskSpouse As Object = keys("Spouse")
            Dim AskChild As Object = keys("Child")
            Dim EEResponse As Object = keys("EEResponse")
            Dim SPResponse As Object = keys("SPResponse")
            Dim CHResponse As Object = keys("CHResponse")
            Dim AnswerType As Object = keys("AnswerType")
            Dim DetailQuestions As Object = keys("DetailQuestions")
            Dim QuestionDetailInstructions As Object = keys("QuestionDetailInstructions")

            Dim rbEmployee As RadioButtonList = DirectCast(e.Row.FindControl("rbEmployee"), RadioButtonList)
            Dim rbSpouse As RadioButtonList = DirectCast(e.Row.FindControl("rbSpouse"), RadioButtonList)
            Dim rbChild As RadioButtonList = DirectCast(e.Row.FindControl("rbChild"), RadioButtonList)
            Dim ddlEE As DropDownList = DirectCast(e.Row.FindControl("ddlEE"), DropDownList)
            Dim ddlSP As DropDownList = DirectCast(e.Row.FindControl("ddlSP"), DropDownList)
            Dim ddlCH As DropDownList = DirectCast(e.Row.FindControl("ddlCH"), DropDownList)
            Dim lblEE As Label = DirectCast(e.Row.FindControl("lblEE"), Label)
            Dim lblSP As Label = DirectCast(e.Row.FindControl("lblSP"), Label)
            Dim lblCH As Label = DirectCast(e.Row.FindControl("lblCH"), Label)
            Dim chkEE As CheckBoxList = DirectCast(e.Row.FindControl("chkEE"), CheckBoxList)

            Dim lblInstructions As Label = DirectCast(e.Row.FindControl("lblInstructions"), Label)

            Dim grdQuestionDetails As GridView = DirectCast(e.Row.FindControl("grdQuestionDetails"), GridView)
            Dim pnlQuestionDetails As Panel = DirectCast(e.Row.FindControl("pnlQuestionDetails"), Panel)

            rbEmployee.Visible = False
            rbSpouse.Visible = False
            rbChild.Visible = False
            ddlEE.Visible = False
            ddlSP.Visible = False
            ddlCH.Visible = False
            lblEE.Visible = False
            lblSP.Visible = False
            lblCH.Visible = False
            chkEE.Visible = False

            If AnswerType = "YesNo" Then  'Radio Buttons
                If AskEmployee = True Then
                    rbEmployee.Visible = True
                    'populate answer if available
                    If EEResponse = "1" Then
                        rbEmployee.SelectedValue = 1
                        lblEE.Text = "Yes"
                        ' EEDetail = True
                    ElseIf EEResponse = "0" Then
                        rbEmployee.SelectedValue = 0
                        lblEE.Text = "No"
                    End If

                    If DetailQuestions = True Then  'Add PostBack for detail Questions
                        rbEmployee.AutoPostBack = True
                        lblInstructions.Text = QuestionDetailInstructions
                        ' AddHandler rbEmployee.SelectedIndexChanged, AddressOf rbEmployee_SelectedIndexChanged
                        ' rbEmployee.Attributes.Add("OnSelectedIndexChanged", "rbEmployee_SelectedIndexChanged")
                    End If
                End If

                If AskSpouse = True And Session("HasSpouse") = 1 Then
                    rbSpouse.Visible = True
                    'populate answer if available
                    If SPResponse = "1" Then
                        rbSpouse.SelectedValue = 1
                        lblSP.Text = "Yes"
                    ElseIf SPResponse = "0" Then
                        rbSpouse.SelectedValue = 0
                        lblSP.Text = "No"
                    End If
                    'should really check whether or not they're covered eh!
                    If Session("SPCovered") = 1 Then
                        rbSpouse.Enabled = True
                    Else
                        rbSpouse.Enabled = False
                    End If
                    If DetailQuestions = True Then  'Add PostBack for detail Questions
                        rbSpouse.AutoPostBack = True
                    End If
                End If

                If AskChild = True And Session("HasChild") = 1 Then
                    rbChild.Visible = True
                    'populate answer if available
                    If CHResponse = "1" Then
                        rbChild.SelectedValue = 1
                        lblCH.Text = "Yes"
                        ' CHDetail = True                         'ASK DETAIL QUESTIONS
                    ElseIf CHResponse = "0" Then
                        rbChild.SelectedValue = 0
                        lblCH.Text = "No"
                    End If

                    'should really check whether or not they're covered eh!
                    If Session("NumOfDeps") > 0 Then
                        rbChild.Enabled = True
                    Else
                        rbChild.Enabled = False
                    End If
                    If DetailQuestions = True Then  'Add PostBack for detail Questions
                        rbChild.AutoPostBack = True
                    End If

                End If

            ElseIf AnswerType = "DropDown" And (QuestionId <> 18 And QuestionId <> 30) Then 'Not Height/Weight as those are handled below
                Dim dsDetails As New DataSet
                Dim dt As New DataTable
                If PlanClass.GetPlanDetailListItems(intEmployeeId, QuestionId, AskEmployee, AskSpouse, AskChild, dsDetails) Then
                    dt = dsDetails.Tables(0)
                    If AskEmployee Then
                        'Fill Drop Down with List Items
                        ddlEE.Items.Add(New ListItem("<< Please Select >>", "-1"))
                        For Each row As DataRow In dt.Rows
                            ddlEE.Items.Add(New ListItem(row("QuestionDetailText"), row("QuestionDetailCode")))
                            If EEResponse = row("QuestionDetailCode") Then
                                lblEE.Text = row("QuestionDetailText")
                            End If
                        Next
                        ddlEE.SelectedValue = IIf(EEResponse = "Nada", "-1", EEResponse)
                        ddlEE.Visible = True
                    End If
                End If

            ElseIf AnswerType = "CheckGroup" Then 'Not Height/Weight as those are handled below
                Dim dsDetails As New DataSet
                Dim dt As New DataTable
                Dim x As Integer = 0
                If PlanClass.GetPlanDetailListItems(intEmployeeId, QuestionId, AskEmployee, AskSpouse, AskChild, dsDetails) Then
                    dt = dsDetails.Tables(0)
                    If AskEmployee Then
                        For Each row As DataRow In dt.Rows
                            chkEE.Items.Add(New ListItem(row("QuestionDetailText"), row("QuestionDetailId")))

                            If row("EEResponse") = "True" Then
                                chkEE.Items(x).Selected = True
                                lblEE.Text = row("QuestionDetailText") + IIf(Trim(lblEE.Text) = "", "", ", " + lblEE.Text)
                            End If
                            x += 1
                        Next
                        chkEE.Visible = True
                    End If
                End If
            Else

                If AskEmployee = True Then
                    ddlEE.Visible = True
                    If QuestionId = 18 Then  'Height
                        Dim b As String
                        For f As Integer = 0 To 10
                            For i As Integer = 0 To 11
                                b = f.ToString() + "' " + i.ToString() + """"
                                ddlEE.Items.Add(New ListItem(b, b))
                            Next i
                        Next f
                        'default something reasonable
                        ddlEE.SelectedValue = IIf(EEResponse = "Nada", "0' 0""""", EEResponse)
                        lblEE.Text = IIf(EEResponse = "Nada", "0' 0""""", EEResponse)

                    End If

                    If QuestionId = 30 Then 'Weight
                        For l As Integer = 0 To 1000
                            ddlEE.Items.Add(New ListItem(l.ToString(), l.ToString()))
                        Next l
                        ddlEE.SelectedValue = IIf(EEResponse = "Nada", "0", EEResponse)
                        lblEE.Text = IIf(EEResponse = "Nada", "0", EEResponse)
                    End If
                End If
                If AskSpouse = True And Session("HasSpouse") = 1 Then
                    ddlSP.Visible = True
                    If QuestionId = 18 Then  'Height
                        Dim b As String
                        For f As Integer = 0 To 10
                            For i As Integer = 0 To 11
                                b = f.ToString() + "' " + i.ToString() + """"
                                ddlSP.Items.Add(New ListItem(b, b))
                            Next i
                        Next f
                        'default something reasonable
                        ddlSP.SelectedValue = IIf(SPResponse = "Nada", "0' 0""", SPResponse)
                        lblSP.Text = IIf(SPResponse = "Nada", "0' 0""""", SPResponse)
                    End If

                    If QuestionId = 30 Then 'Weight
                        For l As Integer = 1 To 1000
                            ddlSP.Items.Add(New ListItem(l.ToString(), l.ToString()))
                        Next l
                        ddlSP.SelectedValue = IIf(SPResponse = "Nada", "0", SPResponse)
                        lblSP.Text = IIf(SPResponse = "Nada", "0", SPResponse)
                    End If

                    'should really check whether or not they're covered eh!
                    If Session("SPCovered") = 1 Then
                        ddlSP.Enabled = True
                    Else
                        ddlSP.Enabled = False
                    End If
                End If

                If AskChild = True And Session("HasChild") = 1 Then
                    ddlCH.Visible = True
                    If QuestionId = 18 Then  'Height
                        Dim b As String
                        For f As Integer = 0 To 10
                            For i As Integer = 0 To 11
                                b = f.ToString() + "' " + i.ToString() + """"
                                ddlCH.Items.Add(New ListItem(b, b))
                            Next i
                        Next f
                        'default something reasonable
                        ddlCH.SelectedValue = IIf(CHResponse = "Nada", "0' 0""", CHResponse)
                        lblCH.Text = IIf(CHResponse = "Nada", "0' 0""", CHResponse)

                    End If

                    If QuestionId = 30 Then 'Weight
                        For l As Integer = 0 To 1000
                            ddlCH.Items.Add(New ListItem(l.ToString(), l.ToString()))
                        Next l
                        ddlCH.SelectedValue = IIf(CHResponse = "Nada", "0", CHResponse)
                        lblCH.Text = IIf(CHResponse = "Nada", "0", CHResponse)
                    End If
                    'should really check whether or not they're covered eh!
                    If Session("NumOfDeps") > 0 Then
                        ddlCH.Enabled = True
                    Else
                        ddlCH.Enabled = False
                    End If
                End If
            End If
        End If

    End Sub

    Protected Sub grdRateOptions_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdRateOptions.RowDataBound
        Dim drview As DataRowView = TryCast(e.Row.DataItem, DataRowView)
        Dim lblPlan As Label = DirectCast(e.Row.FindControl("lblPlanName"), Label)
        Dim rowcolor = Drawing.ColorTranslator.FromHtml("#eeeeee")
        Dim altrowcolor = Drawing.ColorTranslator.FromHtml("#ffffff")
        Dim oddoreven As Integer


        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim intPlanId = drview("PlanId")
            Dim strPlanDescription = drview("PlanLongDesc")

            If Session("LastPlanId") Is Nothing Then
                Session("LastPlanId") = intPlanId
                Session("LastPlanDescription") = strPlanDescription
                Session("plancount") = 1
            Else

                If Session("LastPlanId") <> intPlanId Then
                    Session("plancount") = Session("plancount") + 1
                    Session("LastPlanId") = intPlanId
                    Session("LastPlanDescription") = strPlanDescription
                Else
                    If Session("LastPlanDescription") = strPlanDescription Then
                        lblPlan.Visible = False
                    End If
                End If
            End If
            oddoreven = Session("plancount") Mod 2
            If oddoreven = 1 Then
                e.Row.BackColor = altrowcolor
            Else
                e.Row.BackColor = rowcolor
            End If


        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            'remove session
            Session.Remove("plancount")
            Session.Remove("LastPlanId")
        End If

    End Sub

    Protected Sub grdBeneficiaries_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdBeneficiaries.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then

            Dim keys As DataKey = grdBeneficiaries.DataKeys(e.Row.RowIndex)
            Dim Relation As Object = keys("RelationshipType")
            Dim ddl As DropDownList

            ddl = e.Row.FindControl("ddlPercent")
            For x As Integer = 0 To 100
                ddl.Items.Add(New ListItem(x.ToString + "%", x))
            Next

        End If
    End Sub

#End Region

#Region "Checking to make sure all plan questions are completed"
    Sub CheckCompletePlanQuestions()
        Dim gvr As GridViewRow
        Dim i As Integer
        Dim d As Integer = 1
        booComplete = True
        booCompleteDetails = True
        strDetailError = "You must provide additional detail for the following field(s):  "

        'If InStr(Session("ExistingPlanFullDesc"), "Decline") = 0 And Session("ExistingPlanFullDesc") <> "" Then
        '    bolAlreadyRanOnce = True
        'End If

        If bolAlreadyRanOnce = False Then
            bolAlreadyRanOnce = True

            For Each gvr In grdPlanQuestions.Rows
                Dim rbEE As RadioButtonList
                Dim rbSP As RadioButtonList
                Dim rbCH As RadioButtonList
                Dim ddlEE As DropDownList
                Dim ddlSP As DropDownList
                Dim ddlCH As DropDownList
                Dim chkEE As CheckBoxList

                'Used for Detail Quesitons
                Dim EEDetail As Boolean
                Dim SPDetail As Boolean
                Dim CHDetail As Boolean
                EEDetail = False
                SPDetail = False
                CHDetail = False

                'EMPLOYEE
                rbEE = DirectCast(gvr.FindControl("rbEmployee"), RadioButtonList)
                ddlEE = DirectCast(gvr.FindControl("ddleE"), DropDownList)
                chkEE = DirectCast(gvr.FindControl("chkEE"), CheckBoxList)
                If rbEE.Visible = True And rbEE.Enabled = True Then
                    If rbEE.SelectedIndex = -1 Then         'no selection
                        booComplete = False
                    Else
                        EEDetail = rbEE.SelectedValue
                    End If
                End If
                If ddlEE.Visible = True And ddlEE.Enabled = True Then
                    If ddlEE.SelectedValue = "-1" Or ddlEE.SelectedValue = "0" Or ddlEE.SelectedValue = "0' 0""" Or ddlEE.SelectedIndex = -1 Then
                        booComplete = False
                    End If
                End If
                If chkEE.Visible = True Then
                    Dim b As Boolean = False
                    Dim NonePlus As Boolean = False
                    For Each li As ListItem In chkEE.Items
                        If li.Selected Then    'Look for at least one answer
                            If LCase(li.Text) = "none of these" And b = True Then
                                NonePlus = True
                                li.Attributes.Add("style", "background-color:#f8bac0;")
                            End If
                            b = True
                        End If
                    Next
                    If b = False Or NonePlus = True Then
                        booComplete = False
                    End If
                End If


                'SPOUSE
                rbSP = DirectCast(gvr.FindControl("rbSpouse"), RadioButtonList)
                ddlSP = DirectCast(gvr.FindControl("ddlSP"), DropDownList)

                If rbSP.Visible = True Then
                    If Session("SPCovered") = 1 Then         'no selection
                        rbSP.Enabled = True
                    Else
                        rbSP.Enabled = False
                    End If
                End If
                If ddlSP.Visible = True Then
                    If Session("SPCovered") = 1 Then         'no selection
                        ddlSP.Enabled = True
                    Else
                        ddlSP.Enabled = False
                    End If
                End If

                If rbSP.Visible = True And (rbSP.Enabled = True Or Session("CurrentPlanTypeId") = 42) Then
                    If rbSP.SelectedIndex = -1 Then         'no selection
                        booComplete = False
                    Else
                        SPDetail = rbSP.SelectedValue
                    End If
                End If
                If ddlSP.Visible = True And ddlSP.Enabled = True Then
                    If ddlSP.SelectedValue = "0" Or ddlSP.SelectedValue = "0' 0""" Or ddlSP.SelectedIndex = -1 Then
                        booComplete = False
                    End If

                End If

                'Child
                rbCH = DirectCast(gvr.FindControl("rbChild"), RadioButtonList)
                ddlCH = DirectCast(gvr.FindControl("ddlCH"), DropDownList)

                'have to make sure they are even enabled correctly first because of the first inital load
                If rbCH.Visible = True Then
                    If Session("NumOfDeps") > 0 Then         'no selection
                        rbCH.Enabled = True
                    Else
                        rbCH.Enabled = False
                    End If
                End If

                If ddlCH.Visible = True Then
                    If Session("NumOfDeps") > 0 Then          'no selection
                        ddlCH.Enabled = True
                    Else
                        ddlCH.Enabled = False
                    End If
                End If

                If rbCH.Visible = True And (rbCH.Enabled = True Or Session("CurrentPlanTypeId") = 43) Then
                    If rbCH.SelectedIndex = -1 Then         'no selection
                        booComplete = False
                    Else
                        CHDetail = rbCH.SelectedValue
                    End If
                End If
                If ddlCH.Visible = True And ddlCH.Enabled = True Then
                    If ddlCH.SelectedValue = "0" Or ddlCH.SelectedValue = "0' 0""" Or ddlCH.SelectedIndex = -1 Then
                        booComplete = False
                    End If
                End If

                '***********************************************************************
                'Rebuild Detail Questions in case something has changed
                '***********************************************************************
                Dim gv As GridView
                Dim pnlQuestionDetails As Panel

                gv = DirectCast(gvr.FindControl("grdQuestionDetails"), GridView)
                pnlQuestionDetails = DirectCast(gvr.FindControl("pnlQuestionDetails"), Panel)

                If grdPlanQuestions.DataKeys(i).Values("DetailQuestions") = True And (EEDetail = True Or SPDetail = True Or CHDetail = True) Then

                    Dim dsDetails As New DataSet
                    If PlanClass.GetPlanDetailQuestions(intEmployeeId, grdPlanQuestions.DataKeys(i).Values("QuestionId"), EEDetail, SPDetail, CHDetail, dsDetails) Then
                        pnlQuestionDetails.Visible = True

                        'now i have to magically loop thru the column of the datatable and create columns in the grid view
                        Dim dt As New DataTable
                        dt = dsDetails.Tables(0)

                        ' Make sure inner grid is empty
                        gv.Columns.Clear()

                        Dim view As New DataView(dt)
                        '**MS We need the question number to use later to save to the database
                        Dim ParentId As String = grdPlanQuestions.DataKeys(i).Values("QuestionId")
                        Dim WhoFor As String = view.ToTable(True, "QuestionNumber").Rows(0).Item(0)

                        For Each column As DataColumn In dt.Columns
                            Dim DetailId As String
                            DetailId = dt.Rows(0)(column.ColumnName)
                            'Dim sColumnName As String
                            'sColumnName = column.ColumnName
                            'Dim WhoFor As String = view.ToTable(True, "QuestionNumber").Rows(0).Item(0)

                            Dim TmpCol As TemplateField = New TemplateField
                            If column.ColumnName <> "QuestionNumber" Then         'hides the header for the first column
                                TmpCol.HeaderTemplate = New GridViewTemplate(ListItemType.Header, column.ColumnName, ParentId, DetailId)
                            End If

                            TmpCol.ItemTemplate = New GridViewTemplate(ListItemType.Item, column.ColumnName, ParentId, DetailId)
                            gv.Columns.Add(TmpCol)
                        Next
                        gv.DataSource = dt
                        gv.DataBind()
                    End If

                    If (bolShowPlanOptions = True Or bolJustloadingPage = True) And booComplete = True Then  'user pressed saved and all answers are provided.
                        pnlQuestionDetails.Enabled = False
                    Else
                        pnlQuestionDetails.Enabled = True
                    End If
                Else
                    pnlQuestionDetails.Visible = False
                End If

                If booIntheMiddleofaSave = True Then  'in the middle of a save and checking to see if required Detail Questions are indeed answered

                    If grdPlanQuestions.DataKeys(i).Values("DetailQuestions") = True And (EEDetail = True Or SPDetail = True Or CHDetail = True) Then

                        Dim dscheck As New DataSet
                        Dim dtCheck As New DataTable
                        '  TAKE THIS BACK OUT      booCompleteDetails = PlanClass.CheckForRequiredDetailQuestions(intEmployeeId, grdPlanQuestions.DataKeys(i).Values("QuestionId"), dscheck)
                        If booCompleteDetails = False Then

                            dtCheck = dscheck.Tables(0)
                            For Each row As DataRow In dtCheck.Rows
                                'If d = 1 Then
                                '    strDetailError = strDetailError + row.Item("MissingInfofor") + " - " + row.Item("QuestionDetailText")
                                'Else
                                strDetailError = strDetailError + "<br/>" + row.Item("MissingInfofor") + " - " + row.Item("QuestionDetailText")
                                '        End If
                                'd = d + 1
                            Next
                        End If
                    End If
                End If
                i += 1
            Next

            If booComplete = True Then
                Session("DisplayOnly") = True

                If booIntheMiddleofaSave = False And bolJustloadingPage = False Then  'and not in the middle of the SAVEELECTIONS or just initial load of the page UGH
                    '  If bolJustloadingPage = False Then
                    'Save the answers
                    Dim s As Integer
                    For Each gvr In grdPlanQuestions.Rows
                        Dim rbEE As RadioButtonList
                        Dim rbSP As RadioButtonList
                        Dim rbCH As RadioButtonList
                        Dim ddlEE As DropDownList
                        Dim ddlSP As DropDownList
                        Dim ddlCH As DropDownList
                        Dim lblEE As Label
                        Dim lblSP As Label
                        Dim lblCH As Label
                        Dim chkEE As CheckBoxList

                        'EMPLOYEE
                        rbEE = DirectCast(gvr.FindControl("rbEmployee"), RadioButtonList)
                        rbSP = DirectCast(gvr.FindControl("rbSpouse"), RadioButtonList)
                        rbCH = DirectCast(gvr.FindControl("rbChild"), RadioButtonList)
                        ddlEE = DirectCast(gvr.FindControl("ddlEE"), DropDownList)
                        ddlSP = DirectCast(gvr.FindControl("ddlSP"), DropDownList)
                        ddlCH = DirectCast(gvr.FindControl("ddlCH"), DropDownList)
                        lblEE = DirectCast(gvr.FindControl("lblEE"), Label)
                        lblSP = DirectCast(gvr.FindControl("lblSP"), Label)
                        lblCH = DirectCast(gvr.FindControl("lblCH"), Label)
                        chkEE = DirectCast(gvr.FindControl("chkEE"), CheckBoxList)

                        'Radio EE, Spouse and Child responses required
                        If rbEE.Visible = True And rbEE.Enabled = True And rbSP.Visible = True And rbSP.Enabled = True And rbCH.Visible = True And rbCH.Enabled = True Then
                            PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, 0, grdPlanQuestions.DataKeys(s).Values("QuestionId"), rbEE.SelectedValue, rbSP.SelectedValue, rbCH.SelectedValue, Session("LatestEventDate"), Session("Userid"))
                            lblEE.Text = IIf(rbEE.SelectedValue = 1, "Yes", "No")
                            lblSP.Text = IIf(rbSP.SelectedValue = 1, "Yes", "No")
                            lblCH.Text = IIf(rbCH.SelectedValue = 1, "Yes", "No")

                            'Radio EE and Spouse only
                        ElseIf rbEE.Visible = True And rbEE.Enabled = True And rbSP.Visible = True And rbSP.Enabled = True Then
                            PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, 0, grdPlanQuestions.DataKeys(s).Values("QuestionId"), rbEE.SelectedValue, rbSP.SelectedValue, "", Session("LatestEventDate"), Session("Userid"))
                            lblEE.Text = IIf(rbEE.SelectedValue = 1, "Yes", "No")
                            lblSP.Text = IIf(rbSP.SelectedValue = 1, "Yes", "No")

                            'RadioEE and Child only
                        ElseIf rbEE.Visible = True And rbEE.Enabled = True And rbCH.Visible = True And rbCH.Enabled = True Then
                            PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, 0, grdPlanQuestions.DataKeys(s).Values("QuestionId"), rbEE.SelectedValue, "", rbCH.SelectedValue, Session("LatestEventDate"), Session("Userid"))
                            lblEE.Text = IIf(rbEE.SelectedValue = 1, "Yes", "No")
                            lblCH.Text = IIf(rbCH.SelectedValue = 1, "Yes", "No")

                            'RadioSpouse only
                        ElseIf rbEE.Visible = False And rbSP.Visible = True And rbSP.Enabled = True Then
                            PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, 0, grdPlanQuestions.DataKeys(s).Values("QuestionId"), rbEE.SelectedValue, rbSP.SelectedValue, "", Session("LatestEventDate"), Session("Userid"))
                            lblSP.Text = IIf(rbSP.SelectedValue = 1, "Yes", "No")

                            'RadioChild only
                        ElseIf rbEE.Visible = False And rbCH.Visible = True And rbCH.Enabled = True Then
                            PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, 0, grdPlanQuestions.DataKeys(s).Values("QuestionId"), rbEE.SelectedValue, "", rbCH.SelectedValue, Session("LatestEventDate"), Session("Userid"))
                            lblCH.Text = IIf(rbCH.SelectedValue = 1, "Yes", "No")

                        ElseIf rbEE.Visible = True And rbEE.Enabled = True Then  'Radio Employee Only
                            PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, 0, grdPlanQuestions.DataKeys(s).Values("QuestionId"), rbEE.SelectedValue, "", "", Session("LatestEventDate"), Session("Userid"))
                            lblEE.Text = IIf(rbEE.SelectedValue = 1, "Yes", "No")

                            'Text EE, Spouse and Child responses required
                        ElseIf ddlEE.Visible = True And ddlEE.Enabled = True And ddlSP.Visible = True And ddlSP.Enabled = True And ddlCH.Visible = True And ddlCH.Enabled = True Then
                            PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, 0, grdPlanQuestions.DataKeys(s).Values("QuestionId"), ddlEE.SelectedValue, ddlSP.SelectedValue, ddlCH.SelectedValue, Session("LatestEventDate"), Session("Userid"))
                            lblEE.Text = ddlEE.SelectedValue
                            lblSP.Text = ddlSP.SelectedValue
                            lblCH.Text = ddlCH.SelectedValue

                            'ddl EE and Spouse  responses only
                        ElseIf ddlEE.Visible = True And ddlEE.Enabled = True And ddlSP.Visible = True And ddlSP.Enabled = True Then
                            PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, 0, grdPlanQuestions.DataKeys(s).Values("QuestionId"), ddlEE.Text, ddlSP.Text, "", Session("LatestEventDate"), Session("Userid"))
                            lblEE.Text = ddlEE.SelectedValue
                            lblSP.Text = ddlSP.SelectedValue

                            'ddl EE and  Child responses only
                        ElseIf ddlEE.Visible = True And ddlEE.Enabled = True And ddlSP.Visible = True And ddlSP.Enabled = True And ddlCH.Visible = True And ddlCH.Enabled = True Then
                            PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, 0, grdPlanQuestions.DataKeys(s).Values("QuestionId"), ddlEE.SelectedValue, "", ddlSP.SelectedValue, Session("LatestEventDate"), Session("Userid"))
                            lblEE.Text = ddlEE.SelectedValue
                            lblCH.Text = ddlCH.SelectedValue

                            'ddl EE only
                        ElseIf ddlEE.Visible = True And ddlEE.Enabled = True Then
                            PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, 0, grdPlanQuestions.DataKeys(s).Values("QuestionId"), ddlEE.SelectedValue, "", "", Session("LatestEventDate"), Session("Userid"))
                            lblEE.Text = ddlEE.SelectedItem.Text

                        ElseIf chkEE.Visible Then
                            lblEE.Text = ""
                            For Each li As ListItem In chkEE.Items
                                'These need to be saved as detail questions
                                PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, grdPlanQuestions.DataKeys(s).Values("QuestionId"), li.Value, "EE", li.Selected, Session("LatestEventDate"), Session("Userid"))
                                If li.Selected Then
                                    lblEE.Text = li.Text + IIf(Trim(lblEE.Text) = "", "", ", " + lblEE.Text)
                                End If
                            Next

                        End If

                        '''''''''''''''''''''  hide radios and ddl and update and show labels ''''''''''''''
                        If bolShowPlanOptions = True Then   'NOT IN EDIT MODE
                            rbEE.Visible = False
                            rbSP.Visible = False
                            rbCH.Visible = False
                            ddlEE.Visible = False
                            ddlSP.Visible = False
                            ddlCH.Visible = False
                            chkEE.Visible = False
                            lblEE.Visible = True
                            lblSP.Visible = True
                            lblCH.Visible = True
                            btnEditResponses.Visible = True
                            btnSavePlanQuestions.Visible = False
                            lblPlanQuestions.Visible = False
                            grdOptions.Enabled = True
                        Else                                 'STILL IN EDIT MODE
                            btnEditResponses.Visible = False
                            btnSavePlanQuestions.Visible = True
                            lblPlanQuestions.Visible = False
                            grdOptions.Enabled = False

                        End If
                        s += 1
                    Next

                Else 'Answers Complete but in the middle of a save or Loading
                    'Hide radiobuttons, show labels and Edit button without saving answers
                    For Each gvr In grdPlanQuestions.Rows
                        Dim rbEE As RadioButtonList
                        Dim rbSP As RadioButtonList
                        Dim rbCH As RadioButtonList
                        Dim ddlEE As DropDownList
                        Dim ddlSP As DropDownList
                        Dim ddlCH As DropDownList
                        Dim lblEE As Label
                        Dim lblSP As Label
                        Dim lblCH As Label
                        Dim chkEE As CheckBoxList

                        'EMPLOYEE
                        rbEE = DirectCast(gvr.FindControl("rbEmployee"), RadioButtonList)
                        rbSP = DirectCast(gvr.FindControl("rbSpouse"), RadioButtonList)
                        rbCH = DirectCast(gvr.FindControl("rbChild"), RadioButtonList)
                        ddlEE = DirectCast(gvr.FindControl("ddlEE"), DropDownList)
                        ddlSP = DirectCast(gvr.FindControl("ddlSP"), DropDownList)
                        ddlCH = DirectCast(gvr.FindControl("ddlCH"), DropDownList)
                        lblEE = DirectCast(gvr.FindControl("lblEE"), Label)
                        lblSP = DirectCast(gvr.FindControl("lblSP"), Label)
                        lblCH = DirectCast(gvr.FindControl("lblCH"), Label)
                        chkEE = DirectCast(gvr.FindControl("chkEE"), CheckBoxList)

                        rbEE.Visible = False
                        rbSP.Visible = False
                        rbCH.Visible = False
                        ddlEE.Visible = False
                        ddlSP.Visible = False
                        ddlCH.Visible = False
                        chkEE.Visible = False
                        lblEE.Visible = True
                        lblSP.Visible = True
                        lblCH.Visible = True
                    Next
                    grdOptions.Enabled = True
                    btnEditResponses.Visible = True
                    btnSavePlanQuestions.Visible = False

                End If

                GetNewPlanOptions()


            Else   'ANSWERS NOT COMPLETE

                ' divOptions.Visible = False
                'Clear out the option table first
                Dim ogvr As GridViewRow
                Dim g As Int32
                For Each ogvr In grdOptions.Rows
                    Dim rb As RadioButton
                    rb = CType(grdOptions.Rows(g).FindControl("rbOption"), RadioButton)
                    rb.Checked = False
                    Dim btn As Button
                    btn = CType(grdOptions.Rows(g).FindControl("btnBenefitAmount"), Button)
                    If btn.Visible = True Then
                        btn.Enabled = False
                    End If
                    g += 1
                Next
                grdOptions.Enabled = False
                lblPlanQuestions.Visible = True
                btnSavePlanQuestions.Visible = True
                btnEditResponses.Visible = False
                grdPlanQuestions.Focus()
            End If

        End If
    End Sub

    Protected Sub btnSavePlanQuestions_Click(sender As Object, e As EventArgs)

        bolShowPlanOptions = True

        CheckCompletePlanQuestions()

        imgNext.Visible = True
        ImgBottomNext.Visible = True


    End Sub

    Protected Sub btnEditResponses_Click(sender As Object, e As EventArgs)
        EditQuestions()

        btnEditResponses.Visible = False
        btnSavePlanQuestions.Visible = True
        lblPlanQuestions.Visible = False
        grdOptions.Enabled = False
        grdPlanQuestions.Enabled = True
        imgNext.Visible = False
        ImgBottomNext.Visible = False

    End Sub

    Sub EditQuestions()
        Dim i As Integer = 0
        Dim gvr As GridViewRow
        For Each gvr In grdPlanQuestions.Rows
            Dim keys As DataKey = grdPlanQuestions.DataKeys(i)
            Dim QuestionId As Object = keys("QuestionId")
            Dim AskEmployee As Object = keys("Employee")
            Dim AskSpouse As Object = keys("Spouse")
            Dim AskChild As Object = keys("Child")
            Dim EEResponse As Object = keys("EEResponse")
            Dim SPResponse As Object = keys("SPResponse")
            Dim CHResponse As Object = keys("CHResponse")
            Dim AnswerType As Object = keys("AnswerType")
            Dim DetailQuestions As Object = keys("DetailQuestions")

            Dim rbEmployee As RadioButtonList = DirectCast(gvr.FindControl("rbEmployee"), RadioButtonList)
            Dim rbSpouse As RadioButtonList = DirectCast(gvr.FindControl("rbSpouse"), RadioButtonList)
            Dim rbChild As RadioButtonList = DirectCast(gvr.FindControl("rbChild"), RadioButtonList)
            Dim ddlEE As DropDownList = DirectCast(gvr.FindControl("ddlEE"), DropDownList)
            Dim ddlSP As DropDownList = DirectCast(gvr.FindControl("ddlSP"), DropDownList)
            Dim ddlCH As DropDownList = DirectCast(gvr.FindControl("ddlCH"), DropDownList)
            Dim lblEE As Label = DirectCast(gvr.FindControl("lblEE"), Label)
            Dim lblSP As Label = DirectCast(gvr.FindControl("lblSP"), Label)
            Dim lblCH As Label = DirectCast(gvr.FindControl("lblCH"), Label)
            Dim chkEE As CheckBoxList = DirectCast(gvr.FindControl("chkEE"), CheckBoxList)

            'Used for Detail Quesitons
            Dim EEDetail As Boolean
            Dim SPDetail As Boolean
            Dim CHDetail As Boolean
            EEDetail = False
            SPDetail = False
            CHDetail = False

            'Dim grdQuestionDetails As GridView = DirectCast(gvr.FindControl("grdQuestionDetails"), GridView)
            'Dim pnlQuestionDetails As Panel = DirectCast(gvr.FindControl("pnlQuestionDetails"), Panel)

            rbEmployee.Visible = False
            rbSpouse.Visible = False
            rbChild.Visible = False
            ddlEE.Visible = False
            ddlSP.Visible = False
            ddlCH.Visible = False
            chkEE.Visible = False
            lblEE.Visible = False
            lblSP.Visible = False
            lblCH.Visible = False

            If AnswerType = "YesNo" Then
                If AskEmployee = True Then
                    rbEmployee.Visible = True
                    If rbEmployee.SelectedIndex = -1 Then         'no selection
                        EEDetail = False
                    Else
                        EEDetail = rbEmployee.SelectedValue
                    End If
                End If

                If AskSpouse = True And Session("HasSpouse") = 1 Then
                    rbSpouse.Visible = True
                    If Session("SPCovered") = 1 Then
                        rbSpouse.Enabled = True
                        If rbSpouse.SelectedIndex = -1 Then         'no selection
                            SPDetail = False
                        Else
                            SPDetail = rbSpouse.SelectedValue
                        End If
                    Else
                        rbSpouse.Enabled = False
                    End If
                End If

                If AskChild = True And Session("HasChild") = 1 Then
                    rbChild.Visible = True
                    ''should really check whether or not they're covered eh!
                    If Session("NumOfDeps") > 0 Then
                        rbChild.Enabled = True
                        If rbChild.SelectedIndex = -1 Then         'no selection
                            CHDetail = False
                        Else
                            CHDetail = rbChild.SelectedValue
                        End If
                    Else
                        rbChild.Enabled = False
                    End If
                End If

            ElseIf AnswerType = "DropDown" And (QuestionId <> 18 And QuestionId <> 30) Then 'Not Height/Weight as those are handled below

                ddlEE.Visible = True
            ElseIf AnswerType = "CheckGroup" Then 'Not Height/Weight as those are handled below

                chkEE.Visible = True
            Else
                If AskEmployee = True Then
                    ddlEE.Visible = True
                End If
                If AskSpouse = True And Session("HasSpouse") = 1 Then
                    ddlSP.Visible = True
                End If

                If AskChild = True And Session("HasChild") = 1 Then
                    ddlCH.Visible = True
                End If
            End If

            '***********************************************************************
            'Rebuild Detail Questions in case something has changed
            '***********************************************************************
            If booIntheMiddleofaSave = False Then
                Dim gv As GridView
                Dim pnlQuestionDetails As Panel

                gv = DirectCast(gvr.FindControl("grdQuestionDetails"), GridView)
                pnlQuestionDetails = DirectCast(gvr.FindControl("pnlQuestionDetails"), Panel)

                gv.Columns.Clear()

                If grdPlanQuestions.DataKeys(i).Values("DetailQuestions") = True And (EEDetail = True Or SPDetail = True Or CHDetail = True) Then

                    Dim dsDetails As New DataSet
                    If PlanClass.GetPlanDetailQuestions(intEmployeeId, grdPlanQuestions.DataKeys(i).Values("QuestionId"), EEDetail, SPDetail, CHDetail, dsDetails) Then
                        pnlQuestionDetails.Visible = True

                        'now i have to magically loop thru the column of the datatable and create columns in the grid view
                        Dim dt As New DataTable
                        dt = dsDetails.Tables(0)
                        'Empty Inner Gridview

                        Dim view As New DataView(dt)
                        '**MS We need the question number to use later to save to the database
                        Dim ParentId As String = grdPlanQuestions.DataKeys(i).Values("QuestionId")
                        Dim WhoFor As String = view.ToTable(True, "QuestionNumber").Rows(0).Item(0)

                        For Each column As DataColumn In dt.Columns
                            Dim DetailId As String
                            DetailId = dt.Rows(0)(column.ColumnName)

                            Dim TmpCol As TemplateField = New TemplateField
                            If column.ColumnName <> "QuestionNumber" Then         'hides the header for the first column
                                TmpCol.HeaderTemplate = New GridViewTemplate(ListItemType.Header, column.ColumnName, ParentId, DetailId)
                            End If

                            TmpCol.ItemTemplate = New GridViewTemplate(ListItemType.Item, column.ColumnName, ParentId, DetailId)
                            gv.Columns.Add(TmpCol)
                        Next
                        gv.DataSource = dt
                        gv.DataBind()
                        pnlQuestionDetails.Enabled = True
                    End If
                Else
                    pnlQuestionDetails.Visible = False
                End If
            End If

            i += 1
        Next

    End Sub
#End Region

#Region "Beneficiary"
    Sub UpdateBenificiaryRB()
        Dim gvr As GridViewRow
        For Each gvr In grdBeneficiaries.Rows
            Dim rbNeither As RadioButton
            Dim ddlPercent As DropDownList

            rbNeither = DirectCast(gvr.FindControl("rbNeither"), RadioButton)
            ddlPercent = DirectCast(gvr.FindControl("ddlPercent"), DropDownList)

            If rbNeither.Checked = True Then
                ddlPercent.SelectedValue = 0
                ddlPercent.Enabled = False
            Else
                ddlPercent.Enabled = True
            End If
        Next
    End Sub

#End Region

#Region "Update Progress Bar"
    Protected Sub SetProgressBar()
        ''  Populate progress bar
        Dim PercentageComplete As Integer
        Dim widthset As String

        PercentageComplete = PlanClass.GetPercentage(intCompanyId, intEmployeeId, Session("UserId"))
        widthset = PercentageComplete.ToString + "%"
        divProgressBar.Attributes.Add("aria-valuenow", PercentageComplete.ToString)
        divProgressBar.Style.Add("width", widthset)
        lblProgress.Text = PercentageComplete.ToString + "%"
    End Sub
#End Region

#Region "Update Tobacco Flag if updated"
    Protected Sub ddlTobacco_OnSelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)

        Dim ddl As DropDownList = DirectCast(sender, DropDownList)
        Dim row As GridViewRow = TryCast(ddl.NamingContainer, GridViewRow)
        Dim vSmoker As String
        Dim vDepBenId As Integer

        If row IsNot Nothing Then
            vSmoker = CType(row.FindControl("ddlTobacco"), DropDownList).SelectedValue
            vDepBenId = CType(row.FindControl("lblDepBenId"), Label).Text

            'Update Depben table
            'Have to save HSA Election separately
            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()

            objParam = New SqlParameter("@CompanyId", intCompanyId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EmployeeId", intEmployeeId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@DepBenId", vDepBenId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@TobaccoUser", IIf(vSmoker = "Yes", 1, 0))
            aryParams.Add(objParam)
            objParam = New SqlParameter("@UserId", Session("UserId"))
            aryParams.Add(objParam)
            objDataSet = sqlCon.CreateDataSet("usp_Dependent_TobaccoFlag_Edit", aryParams)
            sqlCon.CloseConn()

            GetNewPlanOptions()
        End If
    End Sub
#End Region

#Region "Hide or Show Learn section"
    Protected Sub BuildLearnSection()

        'Fill up Plan Type Documents if any.  The Hide variable will determine how many items are displayed in the repeater
        Dim vDocumentType As String
        vDocumentType = ""
        intPlanTypeId = Session("CurrentPlanTypeId")
        sc.BenefitScreenSetup("Learn", intCompanyId, intEmployeeId, intPlanTypeId, vDocumentType, ddlPlanDocuments)
        If vDocumentType <> "" Then
            lblDocumentType.Text = vDocumentType + " Documents"
        Else
            lblDocumentType.Text = ""
        End If

        If Session("HideSome") Is Nothing Or Session("HideSome") = True Then
            If lblComment.Text = "" Then
                ' if there are no plan type comments hide div and test for documents or rates
                divLearnComment.Visible = False

                If ddlPlanDocuments.Items.Count > 0 Then
                    divDocuments.Visible = True

                    If ddlPlanDocuments.Items.Count > 6 Then   ' more than 3 documents, hide rate grid regardless if there are rates
                        divRateComparison.Visible = False
                        btnMoreDocument.Visible = True

                    ElseIf grdRateOptions.Rows.Count > 0 Then   ' less than 3 documents, then test for rates.  If exist then hide rate div, but show more button
                        divRateComparison.Visible = False
                        btnMoreDocument.Visible = True
                    Else                                        'less than 3 documents but no rates, hide rate div and hide more button
                        divRateComparison.Visible = False
                        btnMoreDocument.Visible = False
                    End If

                Else ' there are no plan documents either so just show rate grid with no MORE button
                    divDocuments.Visible = False
                    btnMoreDocument.Visible = False

                    If grdRateOptions.Rows.Count > 0 Then
                        divRateComparison.Visible = True
                    Else
                        divRateComparison.Visible = False
                    End If

                End If

            ElseIf Len(lblComment.Text) > 1000 Then      'Comment Text > 300 characters.  Show more button and hide other divs regardless of counts
                lblComment.Visible = False
                lblCommentShort.Visible = True

                btnMoreDocument.Visible = True
                If ddlPlanDocuments.Items.Count < 8 Then
                    divDocuments.Visible = True
                Else
                    divDocuments.Visible = False
                End If

                divRateComparison.Visible = False

            ElseIf Len(lblComment.Text) < 1000 Then      'Commnet text < 300 characters, then look for documents or rates before showing more button
                lblComment.Visible = True
                lblCommentShort.Visible = False

                If ddlPlanDocuments.Items.Count > 0 Or grdRateOptions.Rows.Count > 0 Then
                    If ddlPlanDocuments.Items.Count < 8 Then
                        divDocuments.Visible = True
                        If grdRateOptions.Rows.Count = 0 Then
                            btnMoreDocument.Visible = False
                        End If
                    Else
                        ''   show more button and hide other divs
                        divDocuments.Visible = False
                        btnMoreDocument.Visible = True
                    End If
                    divRateComparison.Visible = False
                Else
                    'no documents or rates, no need to show more button
                    btnMoreDocument.Visible = False
                    divDocuments.Visible = False
                    divRateComparison.Visible = False
                End If

            End If

        Else ' Show all  HIDESOME = FALSE
            lblComment.Visible = True
            lblCommentShort.Visible = False

            If ddlPlanDocuments.Items.Count > 0 Then
                divDocuments.Visible = True
            Else
                divDocuments.Visible = False
            End If

            If grdRateOptions.Rows.Count > 0 Then
                divRateComparison.Visible = True
            Else
                divRateComparison.Visible = False
            End If

            btnMoreDocument.Visible = False
        End If

    End Sub

    Protected Sub imgHideLearn_Click(sender As Object, e As ImageClickEventArgs)
        Session("HideSome") = True
        imgHideLearn.Visible = False

        BuildLearnSection()
    End Sub

    Protected Sub imgShowLearn_Click(sender As Object, e As ImageClickEventArgs)
        divLearnInfo.Visible = True
        imgShowLearn.Visible = False
        imgHideLearn.Visible = True
    End Sub

    Protected Sub btnMoreDocument_Click(sender As Object, e As EventArgs)
        Session("HideSome") = False
        imgHideLearn.Visible = True
        BuildLearnSection()
    End Sub

    Protected Sub ddlPlanDocuments_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)
        If Session("HideSome") = True Then
            If e.Item.ItemIndex > 6 Then
                e.Item.Visible = False
            End If
        End If

    End Sub
#End Region

#Region "Plan Detail Questions"
    Protected Sub btnSaveDetail_Click(sender As Object, e As EventArgs)
        'HERE I AM
    End Sub

    'put this here for now
    Private Sub SaveQuestion(ByVal parameters As Question)
        Dim QuestionID As Integer = CInt(parameters.QuestionID)
        Dim QuestionAnswer As Boolean = CBool(parameters.QuestionAnswer)

        'make database call here
    End Sub

    Private Sub SaveQuestionDetail(ByVal parameters As QuestionDetail)
        ' Dim QuestionNumber As String = parameters.QuestionNumber
        Dim QuestionAnswer As String = parameters.QuestionAnswer
        ' Dim ColumnName As String = parameters.ColumnName
        Dim ParentId As String = parameters.ParentId
        Dim DetailId As String = parameters.DetailId
        Dim WhoFor As String = parameters.WhoFor

        'make database call here
        ' PlanClass.SaveEmployeeQuestionResponses(intEmployeeId, 0, grdPlanQuestions.DataKeys(s).Values("QuestionId"), EEAnswer, SPAnswer, CHAnswer, Session("LatestEventDate"), Session("Userid"), DetailId)
        PlanClass.SaveEmployeeDetailQuestionResponses(intEmployeeId, ParentId, DetailId, WhoFor, QuestionAnswer, Session("LatestEventDate"), Session("Userid"))
        '  Session("Rebuild") = True
    End Sub

    Protected Sub BuildQuestionDetailsAgain(ByVal sender As Object, ByVal e As EventArgs)
        Dim i As Integer = 0
        For Each gvr In grdPlanQuestions.Rows
            Dim rbEE As RadioButtonList
            Dim rbSP As RadioButtonList
            Dim rbCH As RadioButtonList
            Dim ddlEE As DropDownList
            Dim ddlSP As DropDownList
            Dim ddlCH As DropDownList

            'Used for Detail Quesitons
            Dim EEDetail As Boolean
            Dim SPDetail As Boolean
            Dim CHDetail As Boolean
            EEDetail = False
            SPDetail = False
            CHDetail = False

            'EMPLOYEE
            rbEE = DirectCast(gvr.FindControl("rbEmployee"), RadioButtonList)
            ddlEE = DirectCast(gvr.FindControl("ddleE"), DropDownList)
            If rbEE.Visible = True And rbEE.Enabled = True Then
                If rbEE.SelectedIndex = -1 Then         'no selection
                    booComplete = False
                Else
                    EEDetail = rbEE.SelectedValue
                End If
            End If

            'SPOUSE
            rbSP = DirectCast(gvr.FindControl("rbSpouse"), RadioButtonList)
            ddlSP = DirectCast(gvr.FindControl("ddlSP"), DropDownList)

            'have to make sure they are even enabled correctly first because of the first inital load
            If rbSP.Visible = True Then
                If Session("SPCovered") = 1 Then         'no selection
                    rbSP.Enabled = True
                Else
                    rbSP.Enabled = False
                End If
            End If
            If ddlSP.Visible = True Then
                If Session("SPCovered") = 1 Then         'no selection
                    ddlSP.Enabled = True
                Else
                    ddlSP.Enabled = False
                End If
            End If

            If rbSP.Visible = True And rbSP.Enabled = True Then
                If rbSP.SelectedIndex = -1 Then         'no selection
                    booComplete = False
                Else
                    SPDetail = rbSP.SelectedValue
                End If
            End If
            If ddlSP.Visible = True And ddlSP.Enabled = True Then
                If ddlSP.SelectedValue = "0" Or ddlSP.SelectedValue = "0' 0""" Or ddlSP.SelectedIndex = -1 Then
                    booComplete = False
                End If
            End If

            'Child
            rbCH = DirectCast(gvr.FindControl("rbChild"), RadioButtonList)
            ddlCH = DirectCast(gvr.FindControl("ddlCH"), DropDownList)

            'have to make sure they are even enabled correctly first because of the first inital load
            If rbCH.Visible = True Then
                If Session("NumOfDeps") > 0 Then         'no selection
                    rbCH.Enabled = True
                Else
                    rbCH.Enabled = False
                End If
            End If

            If ddlCH.Visible = True Then
                If Session("NumOfDeps") > 0 Then          'no selection
                    ddlCH.Enabled = True
                Else
                    ddlCH.Enabled = False
                End If
            End If

            If rbCH.Visible = True And rbCH.Enabled = True Then
                If rbCH.SelectedIndex = -1 Then         'no selection
                    booComplete = False
                Else
                    CHDetail = rbCH.SelectedValue
                End If
            End If
            If ddlCH.Visible = True And ddlCH.Enabled = True Then
                If ddlCH.SelectedValue = "0" Or ddlCH.SelectedValue = "0' 0""" Or ddlCH.SelectedIndex = -1 Then
                    booComplete = False
                End If
            End If
            '***********************************************************************
            'Rebuild Detail Questions in case something has changed
            '***********************************************************************
            If booIntheMiddleofaSave = False Then
                Dim gv As GridView
                Dim pnlQuestionDetails As Panel

                gv = DirectCast(gvr.FindControl("grdQuestionDetails"), GridView)
                pnlQuestionDetails = DirectCast(gvr.FindControl("pnlQuestionDetails"), Panel)

                If grdPlanQuestions.DataKeys(i).Values("DetailQuestions") = True And (EEDetail = True Or SPDetail = True Or CHDetail = True) Then

                    Dim dsDetails As New DataSet
                    If PlanClass.GetPlanDetailQuestions(intEmployeeId, grdPlanQuestions.DataKeys(i).Values("QuestionId"), EEDetail, SPDetail, CHDetail, dsDetails) Then
                        pnlQuestionDetails.Visible = True

                        'now i have to magically loop thru the column of the datatable and create columns in the grid view
                        Dim dt As New DataTable
                        dt = dsDetails.Tables(0)

                        'Empty inner gridview
                        'gv.DataSource = dt
                        'gv.DataBind()
                        ' Make sure inner grid is empty
                        gv.Columns.Clear()

                        Dim view As New DataView(dt)
                        '**MS We need the question number to use later to save to the database
                        Dim ParentId As String = grdPlanQuestions.DataKeys(i).Values("QuestionId")
                        Dim WhoFor As String = view.ToTable(True, "QuestionNumber").Rows(0).Item(0)

                        For Each column As DataColumn In dt.Columns
                            Dim DetailId As String
                            DetailId = dt.Rows(0)(column.ColumnName)

                            Dim TmpCol As TemplateField = New TemplateField
                            If column.ColumnName <> "QuestionNumber" Then         'hides the header for the first column
                                TmpCol.HeaderTemplate = New GridViewTemplate(ListItemType.Header, column.ColumnName, ParentId, DetailId)
                            End If

                            TmpCol.ItemTemplate = New GridViewTemplate(ListItemType.Item, column.ColumnName, ParentId, DetailId)
                            gv.Columns.Add(TmpCol)
                        Next
                        gv.DataSource = dt
                        gv.DataBind()
                    End If
                Else
                    pnlQuestionDetails.Visible = False
                End If
            End If
            i += 1
        Next

    End Sub

#End Region

    Protected Sub mbtnHSASave_Click(sender As Object, e As ImageClickEventArgs)
        HSASave()
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

    Protected Sub chkCurrentPatient_CheckedChanged(sender As Object, e As EventArgs)
        For Each GridViewRow In grdPCP.Rows
            Dim chkCP As CheckBox = DirectCast(GridViewRow.FindControl("chkCurrentPatient"), CheckBox)
            If chkCP.Checked = True Then
                CurrentPatient = True
            Else
                CurrentPatient = False
            End If
        Next
    End Sub

    Protected Sub btnSaveWaiveQuestions_Click(sender As Object, e As EventArgs) Handles btnSaveWaiveQuestions.Click
        WaiveQuestionsComplete()
        SaveWaiveQuestions()
        If LblWaiveErrorMessage.Text = "" Then
            SaveElection()
            GetNavigationAndTabs()
            DivNext.Visible = True
        End If
    End Sub

    Public Sub SaveAndNextFunction()
        intPlanTypeId = Session("CurrentPlanTypeId")
        If divError.Visible = True Then
            Page.SetFocus(lblError.Text)
            Exit Sub
        ElseIf DivWaiveError.Visible = True Then
            Page.SetFocus(LblWaiveErrorMessage.Text)
            Exit Sub
        ElseIf DivWaiveQuestions.Visible = True Then
            WaiveQuestionsComplete()
            SaveWaiveQuestions()
            SaveElection()
        Else
            SaveElection()
        End If

        If Session("Changes") = "Saved" Then
            If Session("NextPlanTypeId") = "0" Then
                Dim NextPage As String
                NextPage = "~/EE_PendingSummary.aspx"
                Response.Redirect(NextPage)
            Else
                Session("CurrentPlanTypeId") = Session("NextPlanTypeId")
                intPlanTypeId = Session("CurrentPlanTypeId")

                Dim NextPage As String
                NextPage = "~/ee_plans?pt=" + intPlanTypeId.ToString

                Session("CurrentPlanTypeId") = intPlanTypeId
                Session("NextPlanTypeId") = intNextPlanTypeId

                Session("DocumentListTotal") = 0
                Session("HideSome") = True

                Response.Redirect(NextPage)

            End If
        Else
            divError.Visible = True
            lblError.Text = "Validation Failed please check responses then click on Arrow to proceed to next selection"
            Page.SetFocus(lblError.Text)
            ResetScrollPosition()
        End If


    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs) Handles imgNext.Click
        SaveAndNextFunction()

    End Sub

    Protected Sub imgBottomNext_Click(sender As Object, e As ImageClickEventArgs) Handles ImgBottomNext.Click
        SaveAndNextFunction()

    End Sub

    Protected Sub chkWaiveQ_CheckedChanged(sender As Object, e As EventArgs)
        Session("Changes") = "Pending"
    End Sub

End Class
Public Class Question
    Public Property QuestionID As Integer
    Public Property QuestionAnswer As Boolean
End Class

Public Class QuestionDetail
    Public Property QuestionAnswer As String
    Public Property ParentId As String
    Public Property DetailId As String
    Public Property WhoFor As String

End Class

