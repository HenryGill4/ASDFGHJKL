Imports System.Data.SqlClient

Public Class VMQandA
    Inherits System.Web.UI.Page

    ReadOnly s As New Security
    ReadOnly sc As New ScreenConfiguration
    ReadOnly ec As New Employee
    ReadOnly c As New Company

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer
    Dim strScreenName As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("VMLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "VMQandA"

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

            Session("DataComplete") = "No"
            Session("DocumentLink") = ""

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
            'LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            sc.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            MainArticleTitleLabel.Text = sc.MainArticleTitle
            MainArticleTextLabel.Text = sc.MainArticleText

            If MainArticleTextLabel.Text = "" Then
                TextDiv.Visible = False
            End If

            PopulateFields()
        Else
            'If first time page is submitted and we have file in FileUpload control but not in session 
            ' Store the values to Session Object 
            If Session("FileUpload") Is Nothing And FileUploadDocument1.HasFile Then
                Session("FileUpload") = FileUploadDocument1
                LabelFileUpload1.Text = FileUploadDocument1.FileName

                'Next time submit and Session has values but FileUpload is Blank 
                ' Return the values from session to FileUpload 
            ElseIf Not Session("FileUpload") Is Nothing And Not FileUploadDocument1.HasFile Then
                FileUploadDocument1 = Session("FileUpload")
                LabelFileUpload1.Text = FileUploadDocument1.FileName

                'Now there could be another situation when Session has File but user want to change the file 
                'In this case we have to change the file in session object 
            ElseIf (FileUploadDocument1.HasFile) Then
                Session("FileUpload") = FileUploadDocument1
                LabelFileUpload1.Text = FileUploadDocument1.FileName
            End If
        End If

        If Session("DataComplete") = "Yes" Then
            DivSuccessSection.Visible = True
        Else
            DivSuccessSection.Visible = False

        End If

    End Sub

    Private Sub PopulateFields()
        If c.GetFormQuestions(intCompanyId, 125) = True Then
            Question1.Text = c.Question1
            Question2.Text = c.Question2
            Question3.Text = c.Question3
            Question4.Text = c.Question4
            Question5.Text = c.Question5
            Question6.Text = c.Question6
            Question7.Text = c.Question7
            Question8.Text = c.Question8
            Question9.Text = c.Question9
            Question10.Text = c.Question10

            QuestionId1.Text = c.QuestionId1
            QuestionId2.Text = c.QuestionId2
            QuestionId3.Text = c.QuestionId3
            QuestionId4.Text = c.QuestionId4
            QuestionId5.Text = c.QuestionId5
            QuestionId6.Text = c.QuestionId6
            QuestionId7.Text = c.QuestionId7
            QuestionId8.Text = c.QuestionId8
            QuestionId9.Text = c.QuestionId9
            QuestionId10.Text = c.QuestionId10

            DetailQuestion1A.Text = c.DetailQuestion1A
            DetailQuestion1B.Text = c.DetailQuestion1B
            DetailQuestion1C.Text = c.DetailQuestion1C
            DetailQuestion1D.Text = c.DetailQuestion1D

            DetailQuestion2A.Text = c.DetailQuestion2A
            DetailQuestion2B.Text = c.DetailQuestion2B
            DetailQuestion2C.Text = c.DetailQuestion2C
            DetailQuestion2D.Text = c.DetailQuestion2D

            DetailQuestion3A.Text = c.DetailQuestion3A
            DetailQuestion3B.Text = c.DetailQuestion3B
            DetailQuestion3C.Text = c.DetailQuestion3C
            DetailQuestion3D.Text = c.DetailQuestion3D

            DetailQuestion4A.Text = c.DetailQuestion4A
            DetailQuestion4B.Text = c.DetailQuestion4B
            DetailQuestion4C.Text = c.DetailQuestion4C
            DetailQuestion4D.Text = c.DetailQuestion4D

            DetailQuestion5A.Text = c.DetailQuestion5A
            DetailQuestion5B.Text = c.DetailQuestion5B
            DetailQuestion5C.Text = c.DetailQuestion5C
            DetailQuestion5D.Text = c.DetailQuestion5D

            DetailQuestion6A.Text = c.DetailQuestion6A
            DetailQuestion6B.Text = c.DetailQuestion6B
            DetailQuestion6C.Text = c.DetailQuestion6C
            DetailQuestion6D.Text = c.DetailQuestion6D

            DetailQuestion7A.Text = c.DetailQuestion7A
            DetailQuestion7B.Text = c.DetailQuestion7B
            DetailQuestion7C.Text = c.DetailQuestion7C
            DetailQuestion7D.Text = c.DetailQuestion7D

            DetailQuestion8A.Text = c.DetailQuestion8A
            DetailQuestion8B.Text = c.DetailQuestion8B
            DetailQuestion8C.Text = c.DetailQuestion8C
            DetailQuestion8D.Text = c.DetailQuestion8D

            DetailQuestion9A.Text = c.DetailQuestion9A
            DetailQuestion9B.Text = c.DetailQuestion9B
            DetailQuestion9C.Text = c.DetailQuestion9C
            DetailQuestion9D.Text = c.DetailQuestion9D

            DetailQuestion10A.Text = c.DetailQuestion10A
            DetailQuestion10B.Text = c.DetailQuestion10B
            DetailQuestion10C.Text = c.DetailQuestion10C
            DetailQuestion10D.Text = c.DetailQuestion10D

            DetailQuestionId1A.Text = c.DetailQuestionId1A
            DetailQuestionId1B.Text = c.DetailQuestionId1B
            DetailQuestionId1C.Text = c.DetailQuestionId1C
            DetailQuestionId1D.Text = c.DetailQuestionId1D

            DetailQuestionId2A.Text = c.DetailQuestionId2A
            DetailQuestionId2B.Text = c.DetailQuestionId2B
            DetailQuestionId2C.Text = c.DetailQuestionId2C
            DetailQuestionId2D.Text = c.DetailQuestionId2D

            DetailQuestionId3A.Text = c.DetailQuestionId3A
            DetailQuestionId3B.Text = c.DetailQuestionId3B
            DetailQuestionId3C.Text = c.DetailQuestionId3C
            DetailQuestionId3D.Text = c.DetailQuestionId3D

            DetailQuestionId4A.Text = c.DetailQuestionId4A
            DetailQuestionId4B.Text = c.DetailQuestionId4B
            DetailQuestionId4C.Text = c.DetailQuestionId4C
            DetailQuestionId4D.Text = c.DetailQuestionId4D

            DetailQuestionId5A.Text = c.DetailQuestionId5A
            DetailQuestionId5B.Text = c.DetailQuestionId5B
            DetailQuestionId5C.Text = c.DetailQuestionId5C
            DetailQuestionId5D.Text = c.DetailQuestionId5D

            DetailQuestionId6A.Text = c.DetailQuestionId6A
            DetailQuestionId6B.Text = c.DetailQuestionId6B
            DetailQuestionId6C.Text = c.DetailQuestionId6C
            DetailQuestionId6D.Text = c.DetailQuestionId6D

            DetailQuestionId7A.Text = c.DetailQuestionId7A
            DetailQuestionId7B.Text = c.DetailQuestionId7B
            DetailQuestionId7C.Text = c.DetailQuestionId7C
            DetailQuestionId7D.Text = c.DetailQuestionId7D

            DetailQuestionId8A.Text = c.DetailQuestionId8A
            DetailQuestionId8B.Text = c.DetailQuestionId8B
            DetailQuestionId8C.Text = c.DetailQuestionId8C
            DetailQuestionId8D.Text = c.DetailQuestionId8D

            DetailQuestionId9A.Text = c.DetailQuestionId9A
            DetailQuestionId9B.Text = c.DetailQuestionId9B
            DetailQuestionId9C.Text = c.DetailQuestionId9C
            DetailQuestionId9D.Text = c.DetailQuestionId9D

            DetailQuestionId10A.Text = c.DetailQuestionId10A
            DetailQuestionId10B.Text = c.DetailQuestionId10B
            DetailQuestionId10C.Text = c.DetailQuestionId10C
            DetailQuestionId10D.Text = c.DetailQuestionId10D

            If Question1.Text = "" Then
                DivQ1.Visible = False
            End If
            If Question2.Text = "" Then
                DivQ2.Visible = False
            End If
            If Question3.Text = "" Then
                DivQ3.Visible = False
            End If
            If Question4.Text = "" Then
                DivQ4.Visible = False
            End If
            If Question5.Text = "" Then
                DivQ5.Visible = False
            End If
            If Question6.Text = "" Then
                DivQ6.Visible = False
            End If
            If Question7.Text = "" Then
                DivQ7.Visible = False
            End If
            If Question8.Text = "" Then
                DivQ8.Visible = False
            End If
            If Question9.Text = "" Then
                DivQ9.Visible = False
            End If
            If Question10.Text = "" Then
                DivQ10.Visible = False
            End If
        End If

        If ec.GetEmployeeFormResponses(intCompanyId, intEmployeeId, Session("ScreenName")) = True Then
            ResponseDetailQ1A.Text = ec.Box11
            ResponseDetailQ1B.Text = ec.Box12
            ResponseDetailQ1C.Text = ec.Box13
            ResponseDetailQ1D.Text = ec.Box14

            ResponseDetailQ2A.Text = ec.Box15
            ResponseDetailQ2B.Text = ec.Box16
            ResponseDetailQ2C.Text = ec.Box17
            ResponseDetailQ2D.Text = ec.Box18

            ResponseDetailQ3A.Text = ec.Box19
            ResponseDetailQ3B.Text = ec.Box20
            ResponseDetailQ3C.Text = ec.Box21
            ResponseDetailQ3D.Text = ec.Box22

            ResponseDetailQ4A.Text = ec.Box23
            ResponseDetailQ4B.Text = ec.Box24
            ResponseDetailQ4C.Text = ec.Box25
            ResponseDetailQ4D.Text = ec.Box26

            ResponseDetailQ5A.Text = ec.Box27
            ResponseDetailQ5B.Text = ec.Box28
            ResponseDetailQ5C.Text = ec.Box29
            ResponseDetailQ5D.Text = ec.Box30

            ResponseDetailQ6A.Text = ec.Box31
            ResponseDetailQ6B.Text = ec.Box32
            ResponseDetailQ6C.Text = ec.Box33
            ResponseDetailQ6D.Text = ec.Box34

            ResponseDetailQ7A.Text = ec.Box35
            ResponseDetailQ7B.Text = ec.Box36
            ResponseDetailQ7C.Text = ec.Box37
            ResponseDetailQ7D.Text = ec.Box38

            ResponseDetailQ8A.Text = ec.Box39
            ResponseDetailQ8B.Text = ec.Box40
            ResponseDetailQ8C.Text = ec.Box41
            ResponseDetailQ8D.Text = ec.Box42

            ResponseDetailQ9A.Text = ec.Box43
            ResponseDetailQ9B.Text = ec.Box44
            ResponseDetailQ9C.Text = ec.Box45
            ResponseDetailQ9D.Text = ec.Box46

            ResponseDetailQ10A.Text = ec.Box47
            ResponseDetailQ10B.Text = ec.Box48
            ResponseDetailQ10C.Text = ec.Box49
            ResponseDetailQ10D.Text = ec.Box50

            If ec.DocumentLink <> "" Then
                LabelUploadedDocument1.Text = ec.DocumentLink
            End If


            If ec.Box1 = "" Then
                DivDetailQ1.Visible = False
            ElseIf ec.Box1 = "1" Then
                ButtonQ1Yes.CssClass = "HREButtonActive"
                ButtonQ1No.CssClass = "HREButtonInActive"
                If c.DetailQuestion1A = "" Then
                    DivDetailQ1A.Visible = False
                End If
                If c.DetailQuestion1B = "" Then
                    DivDetailQ1B.Visible = False
                End If
                If c.DetailQuestion1C = "" Then
                    DivDetailQ1C.Visible = False
                End If
                If c.DetailQuestion1D = "" Then
                    DivDetailQ1D.Visible = False
                End If
                If ec.DocumentLink = "" Then
                    DivExistingDocument.Visible = False
                Else
                    DivExistingDocument.Visible = True
                    DivUpload1.Visible = False
                End If
            ElseIf ec.Box1 = "0" Then
                    ButtonQ1Yes.CssClass = "HREButtonInActive"
                ButtonQ1No.CssClass = "HREButtonActive"
                DivDetailQ1.Visible = False
            End If

            If ec.Box2 = "" Then
                DivDetailQ2.Visible = False
            ElseIf ec.Box2 = "1" Then
                ButtonQ2Yes.CssClass = "HREButtonActive"
                ButtonQ2No.CssClass = "HREButtonInActive"
                If c.DetailQuestion2A = "" Then
                    DivDetailQ2A.Visible = False
                End If
                If c.DetailQuestion2B = "" Then
                    DivDetailQ2B.Visible = False
                End If
                If c.DetailQuestion2C = "" Then
                    DivDetailQ2C.Visible = False
                End If
                If c.DetailQuestion2D = "" Then
                    DivDetailQ2D.Visible = False
                End If
            ElseIf ec.Box2 = "0" Then
                ButtonQ2Yes.CssClass = "HREButtonInActive"
                ButtonQ2No.CssClass = "HREButtonActive"
                DivDetailQ2.Visible = False
            End If

            If ec.Box3 = "" Then
                DivDetailQ3.Visible = False
            ElseIf ec.Box3 = "1" Then
                ButtonQ3Yes.CssClass = "HREButtonActive"
                ButtonQ3No.CssClass = "HREButtonInActive"
                If c.DetailQuestion3A = "" Then
                    DivDetailQ3A.Visible = False
                End If
                If c.DetailQuestion3B = "" Then
                    DivDetailQ3B.Visible = False
                End If
                If c.DetailQuestion3C = "" Then
                    DivDetailQ3C.Visible = False
                End If
                If c.DetailQuestion3D = "" Then
                    DivDetailQ3D.Visible = False
                End If
            ElseIf ec.Box3 = "0" Then
                ButtonQ3Yes.CssClass = "HREButtonInActive"
                ButtonQ3No.CssClass = "HREButtonActive"
                DivDetailQ3.Visible = False
            End If

            If ec.Box4 = "" Then
                DivDetailQ4.Visible = False
            ElseIf ec.Box4 = "1" Then
                ButtonQ4Yes.CssClass = "HREButtonActive"
                ButtonQ4No.CssClass = "HREButtonInActive"
                If c.DetailQuestion4A = "" Then
                    DivDetailQ4A.Visible = False
                End If
                If c.DetailQuestion4B = "" Then
                    DivDetailQ4B.Visible = False
                End If
                If c.DetailQuestion4C = "" Then
                    DivDetailQ4C.Visible = False
                End If
                If c.DetailQuestion4D = "" Then
                    DivDetailQ4D.Visible = False
                End If
            ElseIf ec.Box4 = "0" Then
                ButtonQ4Yes.CssClass = "HREButtonInActive"
                ButtonQ4No.CssClass = "HREButtonActive"
                DivDetailQ4.Visible = False
            End If

            If ec.Box5 = "" Then
                DivDetailQ5.Visible = False
            ElseIf ec.Box5 = "1" Then
                ButtonQ5Yes.CssClass = "HREButtonActive"
                ButtonQ5No.CssClass = "HREButtonInActive"
                If c.DetailQuestion5A = "" Then
                    DivDetailQ5A.Visible = False
                End If
                If c.DetailQuestion5B = "" Then
                    DivDetailQ5B.Visible = False
                End If
                If c.DetailQuestion5C = "" Then
                    DivDetailQ5C.Visible = False
                End If
                If c.DetailQuestion5D = "" Then
                    DivDetailQ5D.Visible = False
                End If
            ElseIf ec.Box5 = "0" Then
                ButtonQ5Yes.CssClass = "HREButtonInActive"
                ButtonQ5No.CssClass = "HREButtonActive"
                DivDetailQ5.Visible = False
            End If

            If ec.Box6 = "" Then
                DivDetailQ6.Visible = False
            ElseIf ec.Box6 = "1" Then
                ButtonQ6Yes.CssClass = "HREButtonActive"
                ButtonQ6No.CssClass = "HREButtonInActive"
                If c.DetailQuestion6A = "" Then
                    DivDetailQ6A.Visible = False
                End If
                If c.DetailQuestion6B = "" Then
                    DivDetailQ6B.Visible = False
                End If
                If c.DetailQuestion6C = "" Then
                    DivDetailQ6C.Visible = False
                End If
                If c.DetailQuestion6D = "" Then
                    DivDetailQ6D.Visible = False
                End If
            ElseIf ec.Box6 = "0" Then
                ButtonQ6Yes.CssClass = "HREButtonInActive"
                ButtonQ6No.CssClass = "HREButtonActive"
                DivDetailQ6.Visible = False
            End If

            If ec.Box7 = "" Then
                DivDetailQ7.Visible = False
            ElseIf ec.Box7 = "1" Then
                ButtonQ7Yes.CssClass = "HREButtonActive"
                ButtonQ7No.CssClass = "HREButtonInActive"
                If c.DetailQuestion7A = "" Then
                    DivDetailQ7A.Visible = False
                End If
                If c.DetailQuestion7B = "" Then
                    DivDetailQ7B.Visible = False
                End If
                If c.DetailQuestion7C = "" Then
                    DivDetailQ7C.Visible = False
                End If
                If c.DetailQuestion7D = "" Then
                    DivDetailQ7D.Visible = False
                End If
            ElseIf ec.Box7 = "0" Then
                ButtonQ7Yes.CssClass = "HREButtonInActive"
                ButtonQ7No.CssClass = "HREButtonActive"
                DivDetailQ7.Visible = False
            End If

            If ec.Box8 = "" Then
                DivDetailQ8.Visible = False
            ElseIf ec.Box8 = "1" Then
                ButtonQ8Yes.CssClass = "HREButtonActive"
                ButtonQ8No.CssClass = "HREButtonInActive"
                If c.DetailQuestion8A = "" Then
                    DivDetailQ8A.Visible = False
                End If
                If c.DetailQuestion8B = "" Then
                    DivDetailQ8B.Visible = False
                End If
                If c.DetailQuestion8C = "" Then
                    DivDetailQ8C.Visible = False
                End If
                If c.DetailQuestion8D = "" Then
                    DivDetailQ8D.Visible = False
                End If
            ElseIf ec.Box8 = "0" Then
                ButtonQ8Yes.CssClass = "HREButtonInActive"
                ButtonQ8No.CssClass = "HREButtonActive"
                DivDetailQ8.Visible = False
            End If

            If ec.Box9 = "" Then
                DivDetailQ9.Visible = False
            ElseIf ec.Box9 = "1" Then
                ButtonQ9Yes.CssClass = "HREButtonActive"
                ButtonQ9No.CssClass = "HREButtonInActive"
                If c.DetailQuestion9A = "" Then
                    DivDetailQ9A.Visible = False
                End If
                If c.DetailQuestion9B = "" Then
                    DivDetailQ9B.Visible = False
                End If
                If c.DetailQuestion9C = "" Then
                    DivDetailQ9C.Visible = False
                End If
                If c.DetailQuestion9D = "" Then
                    DivDetailQ9D.Visible = False
                End If
            ElseIf ec.Box9 = "0" Then
                ButtonQ9Yes.CssClass = "HREButtonInActive"
                ButtonQ9No.CssClass = "HREButtonActive"
                DivDetailQ9.Visible = False
            End If

            If ec.Box10 = "" Then
                DivDetailQ10.Visible = False
            ElseIf ec.Box10 = "1" Then
                ButtonQ10Yes.CssClass = "HREButtonActive"
                ButtonQ10No.CssClass = "HREButtonInActive"
                If c.DetailQuestion10A = "" Then
                    DivDetailQ10A.Visible = False
                End If
                If c.DetailQuestion10B = "" Then
                    DivDetailQ10B.Visible = False
                End If
                If c.DetailQuestion10C = "" Then
                    DivDetailQ10C.Visible = False
                End If
                If c.DetailQuestion10D = "" Then
                    DivDetailQ10D.Visible = False
                End If
            ElseIf ec.Box10 = "0" Then
                ButtonQ10Yes.CssClass = "HREButtonInActive"
                ButtonQ10No.CssClass = "HREButtonActive"
                DivDetailQ10.Visible = False
            End If

        End If

    End Sub

    Private Sub UploadDocument()
        If FileUploadDocument1.HasFile Then
            Try
                'Get Filename
                Dim NewFileName = Server.HtmlEncode(FileUploadDocument1.FileName)
                'Get File Extension
                Dim Extension As String = System.IO.Path.GetExtension(NewFileName)
                'Get CompanyId 
                Dim strCompanyId As String = intCompanyId.ToString
                'Get EmployeeId 
                Dim strEmployeeId As String = intEmployeeId.ToString
                'Get Date
                Dim strDate As String = Date.Now().ToString("yyyyMMdd HH mm ss")
                'Get QuestionId
                Dim strQuestionId = Session("QuestionId").ToString
                'Get root path
                Dim Rootpath As String = Server.MapPath(".\\")

                'Only allow files with proper extensions to load - Replaced characters that are not allowed
                Extension = Extension.ToLower()
                If LCase(Extension) = ".doc" Or LCase(Extension) = ".docx" Or LCase(Extension) = ".pdf" Or LCase(Extension) = ".tiff" Or LCase(Extension) = ".gif" Or LCase(Extension) = ".png" Or LCase(Extension) = ".jpg" Or LCase(Extension) = ".jpeg" Then
                    NewFileName = Replace(Replace(Replace(Replace(Replace(Replace(Replace(NewFileName, " ", "_"), "&amp;", ""), "&39;", ""), "&", ""), "#", ""), ";", ""), "+", "")
                    Dim FilePath As String
                    Dim FullFilePath As String = ""
                    Dim SaveFilePath As String = ""

                    FilePath = Rootpath & NewFileName

                    FullFilePath = Rootpath & "img\EmployeeDocuments\VaccineMandate\" & strDate & "_" & strCompanyId & "_" & strEmployeeId & "_" & strQuestionId & "_" & NewFileName

                    FileUploadDocument1.SaveAs(FullFilePath)

                    LabelFileUpload1.Text = FilePath

                    Session("FileName") = LabelFileUpload1.Text

                    SaveFilePath = "/img/EmployeeDocuments/VaccineMandate/" & strDate & "_" & strCompanyId & "_" & strEmployeeId & "_" & strQuestionId & "_" & NewFileName

                    If SaveFilePath <> "" Then

                        Session("DocumentLink") = SaveFilePath

                        'Save procedure here
                        Dim objParam As SqlParameter
                        Dim objDataSet As New DataSet
                        Dim aryParams As New ArrayList()
                        Dim sqlCon As New SQLControl
                        sqlCon.OpenConn()
                        Try
                            objParam = New SqlParameter("@EmployeeDocumentId", 0)
                            aryParams.Add(objParam)
                            objParam = New SqlParameter("@CompanyId", intCompanyId)
                            aryParams.Add(objParam)
                            objParam = New SqlParameter("@EmployeeId", intEmployeeId)
                            aryParams.Add(objParam)
                            objParam = New SqlParameter("@DocumentTypeId", 13)
                            aryParams.Add(objParam)
                            objParam = New SqlParameter("@DocumentSubTypeId", 27)
                            aryParams.Add(objParam)
                            objParam = New SqlParameter("@DocumentLink", SaveFilePath)
                            aryParams.Add(objParam)
                            objParam = New SqlParameter("@Delete", 0)
                            aryParams.Add(objParam)
                            sqlCon.ExecuteNonQuery("[usp_Employee_Document_Edit]", aryParams)
                            sqlCon.CloseConn()

                            aryParams = Nothing
                            sqlCon = Nothing

                        Catch ex As Exception
                            Throw New Exception(ex.Message)
                        End Try
                    Else
                        LabelError.Text = "Not getting File Path"
                    End If

                    'GetDropDownLists()

                Else
                    LabelFileUpload1.Text = "Error:  The file must be a valid format (.doc, .docx, .pdf, .tiff, .gif, .png, .jpg, .jpeg)"

                End If
            Catch ex As Exception
                LabelFileUpload1.Text = "ERROR: " & ex.Message.ToString()
            End Try
        End If

    End Sub

    Private Sub Save()

        If Session("Question1") = True Then
            If DivDetailQ1.Visible = True Then
                If DivDetailQ1A.Visible = True And ResponseDetailQ1A.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ1A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ1B.Visible = True And ResponseDetailQ1B.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ1B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ1C.Visible = True And ResponseDetailQ1C.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ1C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ1D.Visible = True And ResponseDetailQ1D.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ1D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
            End If
            If DivErrorSection.Visible = False Then
                ResponseDetailQ1A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ1B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ1C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ1D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If
        End If

        If Session("Question2") = True Then
            If DivDetailQ2.Visible = True Then
                If DivDetailQ2A.Visible = True And ResponseDetailQ2A.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ2A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ2B.Visible = True And ResponseDetailQ2B.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ2B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ2C.Visible = True And ResponseDetailQ2C.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ2C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ2D.Visible = True And ResponseDetailQ2D.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ2D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
            End If
            If DivErrorSection.Visible = False Then
                ResponseDetailQ2A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ2B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ2C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ2D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If
        End If

        If Session("Question3") = True Then
            If DivDetailQ3.Visible = True Then
                If DivDetailQ3A.Visible = True And ResponseDetailQ3A.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ3A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ3B.Visible = True And ResponseDetailQ3B.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ3B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ3C.Visible = True And ResponseDetailQ3C.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ3C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ3D.Visible = True And ResponseDetailQ3D.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ3D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
            End If
            If DivErrorSection.Visible = False Then
                ResponseDetailQ3A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ3B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ3C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ3D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If
        End If

        If Session("Question4") = True Then
            If DivDetailQ4.Visible = True Then
                If DivDetailQ4A.Visible = True And ResponseDetailQ4A.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ4A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ4B.Visible = True And ResponseDetailQ4B.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ4B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ4C.Visible = True And ResponseDetailQ4C.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ4C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ4D.Visible = True And ResponseDetailQ4D.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ4D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
            End If
            If DivErrorSection.Visible = False Then
                ResponseDetailQ4A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ4B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ4C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ4D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If
        End If

        If Session("Question5") = True Then
            If DivDetailQ5.Visible = True Then
                If DivDetailQ5A.Visible = True And ResponseDetailQ5A.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ5A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ5B.Visible = True And ResponseDetailQ5B.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ5B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ5C.Visible = True And ResponseDetailQ5C.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ5C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ5D.Visible = True And ResponseDetailQ5D.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ5D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
            End If
            If DivErrorSection.Visible = False Then
                ResponseDetailQ5A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ5B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ5C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ5D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If
        End If

        If Session("Question6") = True Then
            If DivDetailQ6.Visible = True Then
                If DivDetailQ6A.Visible = True And ResponseDetailQ6A.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ6A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ6B.Visible = True And ResponseDetailQ6B.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ6B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ6C.Visible = True And ResponseDetailQ6C.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ6C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ6D.Visible = True And ResponseDetailQ6D.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ6D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
            End If
            If DivErrorSection.Visible = False Then
                ResponseDetailQ6A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ6B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ6C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ6D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If
        End If

        If Session("Question7") = True Then
            If DivDetailQ7.Visible = True Then
                If DivDetailQ7A.Visible = True And ResponseDetailQ7A.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ7A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ7B.Visible = True And ResponseDetailQ7B.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ7B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ7C.Visible = True And ResponseDetailQ7C.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ7C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ7D.Visible = True And ResponseDetailQ7D.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ7D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
            End If
            If DivErrorSection.Visible = False Then
                ResponseDetailQ7A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ7B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ7C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ7D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If
        End If

        If Session("Question8") = True Then
            If DivDetailQ8.Visible = True Then
                If DivDetailQ8A.Visible = True And ResponseDetailQ8A.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ8A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ8B.Visible = True And ResponseDetailQ8B.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ8B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ8C.Visible = True And ResponseDetailQ8C.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ8C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ8D.Visible = True And ResponseDetailQ8D.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ8D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
            End If
            If DivErrorSection.Visible = False Then
                ResponseDetailQ8A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ8B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ8C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ8D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If
        End If

        If Session("Question9") = True Then
            If DivDetailQ9.Visible = True Then
                If DivDetailQ9A.Visible = True And ResponseDetailQ9A.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ9A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ9B.Visible = True And ResponseDetailQ9B.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ9B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ9C.Visible = True And ResponseDetailQ9C.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ9C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ9D.Visible = True And ResponseDetailQ9D.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ9D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
            End If
            If DivErrorSection.Visible = False Then
                ResponseDetailQ9A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ9B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ9C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ9C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If
        End If

        If Session("Question10") = True Then
            If DivDetailQ10.Visible = True Then
                If DivDetailQ10A.Visible = True And ResponseDetailQ10A.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ10A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ10B.Visible = True And ResponseDetailQ10B.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ10B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ10C.Visible = True And ResponseDetailQ10C.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ10C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
                If DivDetailQ10D.Visible = True And ResponseDetailQ10D.Text = "" Then
                    DivErrorSection.Visible = True
                    LabelError.Text = "Please provide required response"
                    ResponseDetailQ10D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f2dede")
                    ResetScrollPosition()
                    Exit Sub
                End If
            End If
            If DivErrorSection.Visible = False Then
                ResponseDetailQ10A.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ10B.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ10C.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
                ResponseDetailQ10D.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0f4fa")
            End If
        End If

        If DivErrorSection.Visible = False Then

            Dim objParam As SqlParameter
            Dim objDataSet As New DataSet
            Dim aryParams As New ArrayList()
            Dim sqlCon As New SQLControl
            sqlCon.OpenConn()

            Try
                objParam = New SqlParameter("@CompanyId", intCompanyId)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@EmployeeId", intEmployeeId)
                aryParams.Add(objParam)
                objParam = New SqlParameter("@UserId", Session("UserId"))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@ScreenName", Session("ScreenName"))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box1", IIf(Session("ButtonQ1Yes") = True, "1", IIf(Session("ButtonQ1No") = True, "0", "")))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box2", IIf(Session("ButtonQ2Yes") = True, "1", IIf(Session("ButtonQ2No") = True, "0", "")))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box3", IIf(Session("ButtonQ3Yes") = True, "1", IIf(Session("ButtonQ3No") = True, "0", "")))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box4", IIf(Session("ButtonQ4Yes") = True, "1", IIf(Session("ButtonQ4No") = True, "0", "")))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box5", IIf(Session("ButtonQ5Yes") = True, "1", IIf(Session("ButtonQ5No") = True, "0", "")))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box6", IIf(Session("ButtonQ6Yes") = True, "1", IIf(Session("ButtonQ6No") = True, "0", "")))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box7", IIf(Session("ButtonQ7Yes") = True, "1", IIf(Session("ButtonQ7No") = True, "0", "")))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box8", IIf(Session("ButtonQ8Yes") = True, "1", IIf(Session("ButtonQ8No") = True, "0", "")))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box9", IIf(Session("ButtonQ9Yes") = True, "1", IIf(Session("ButtonQ9No") = True, "0", "")))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box10", IIf(Session("ButtonQ10Yes") = True, "1", IIf(Session("ButtonQ10No") = True, "0", "")))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box11", IIf(ResponseDetailQ1A.Text <> "", ResponseDetailQ1A.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box12", IIf(ResponseDetailQ1B.Text <> "", ResponseDetailQ1B.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box13", IIf(ResponseDetailQ1C.Text <> "", ResponseDetailQ1C.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box14", IIf(ResponseDetailQ1D.Text <> "", ResponseDetailQ1D.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box15", IIf(ResponseDetailQ2A.Text <> "", ResponseDetailQ2A.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box16", IIf(ResponseDetailQ2B.Text <> "", ResponseDetailQ2B.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box17", IIf(ResponseDetailQ2C.Text <> "", ResponseDetailQ2C.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box18", IIf(ResponseDetailQ2D.Text <> "", ResponseDetailQ2D.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box19", IIf(ResponseDetailQ3A.Text <> "", ResponseDetailQ3A.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box20", IIf(ResponseDetailQ3B.Text <> "", ResponseDetailQ3B.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box21", IIf(ResponseDetailQ3C.Text <> "", ResponseDetailQ3C.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box22", IIf(ResponseDetailQ3D.Text <> "", ResponseDetailQ3D.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box23", IIf(ResponseDetailQ4A.Text <> "", ResponseDetailQ4A.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box24", IIf(ResponseDetailQ4B.Text <> "", ResponseDetailQ4B.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box25", IIf(ResponseDetailQ4C.Text <> "", ResponseDetailQ4C.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box26", IIf(ResponseDetailQ4D.Text <> "", ResponseDetailQ4D.Text, ""))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@Box27", IIf(ResponseDetailQ5A.Text <> "", ResponseDetailQ5A.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box28", IIf(ResponseDetailQ5B.Text <> "", ResponseDetailQ5B.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box29", IIf(ResponseDetailQ5C.Text <> "", ResponseDetailQ5C.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box30", IIf(ResponseDetailQ5D.Text <> "", ResponseDetailQ5D.Text, ""))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@Box31", IIf(ResponseDetailQ6A.Text <> "", ResponseDetailQ6A.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box32", IIf(ResponseDetailQ6B.Text <> "", ResponseDetailQ6B.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box33", IIf(ResponseDetailQ6C.Text <> "", ResponseDetailQ6C.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box34", IIf(ResponseDetailQ6D.Text <> "", ResponseDetailQ6D.Text, ""))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@Box35", IIf(ResponseDetailQ7A.Text <> "", ResponseDetailQ7A.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box36", IIf(ResponseDetailQ7B.Text <> "", ResponseDetailQ7B.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box37", IIf(ResponseDetailQ7C.Text <> "", ResponseDetailQ7C.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box38", IIf(ResponseDetailQ7D.Text <> "", ResponseDetailQ7D.Text, ""))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@Box39", IIf(ResponseDetailQ8A.Text <> "", ResponseDetailQ8A.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box40", IIf(ResponseDetailQ8B.Text <> "", ResponseDetailQ8B.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box41", IIf(ResponseDetailQ8C.Text <> "", ResponseDetailQ8C.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box42", IIf(ResponseDetailQ8D.Text <> "", ResponseDetailQ8D.Text, ""))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@Box43", IIf(ResponseDetailQ9A.Text <> "", ResponseDetailQ9A.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box44", IIf(ResponseDetailQ9B.Text <> "", ResponseDetailQ9B.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box45", IIf(ResponseDetailQ9C.Text <> "", ResponseDetailQ9C.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box46", IIf(ResponseDetailQ9D.Text <> "", ResponseDetailQ9D.Text, ""))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@Box47", IIf(ResponseDetailQ10A.Text <> "", ResponseDetailQ10A.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box48", IIf(ResponseDetailQ10B.Text <> "", ResponseDetailQ10B.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box49", IIf(ResponseDetailQ10C.Text <> "", ResponseDetailQ10C.Text, ""))
                aryParams.Add(objParam)
                objParam = New SqlParameter("@Box50", IIf(ResponseDetailQ10D.Text <> "", ResponseDetailQ10D.Text, ""))
                aryParams.Add(objParam)

                objParam = New SqlParameter("@DocumentLink", IIf(Session("DocumentLink") = "", "", Session("DocumentLink")))
                aryParams.Add(objParam)

                objDataSet = sqlCon.CreateDataSet("usp_Employee_Form_Response_Edit_Dev", aryParams)
                sqlCon.CloseConn()

                s.SaveUserUpdate(Session("UserId"), Session("ScreenName"), "Saved on " + Session("ScreenShortDesc"), intEmployeeId, 0, 0, "01/01/1900", intTransactionId)

                If Session("DocumentLink") = "" Then
                    DivExistingDocument.Visible = True
                    DivUpload1.Visible = False
                    LabelFileUpload1.Text = Session("FileName")
                Else
                    DivExistingDocument.Visible = False
                    DivUpload1.Visible = True
                End If
            Finally
                If objDataSet IsNot Nothing Then
                    objDataSet.Dispose()
                End If
            End Try
        End If
    End Sub

#Region "Buttons Yes and No"
    Protected Sub ButtonQ1Yes_Click(sender As Object, e As EventArgs)
        ButtonQ1Yes.CssClass = "HREButtonActive"
        ButtonQ1No.CssClass = "HREButtonInActive"
        Session("ButtonQ1Yes") = True
        Session("ButtonQ1No") = False

        DivDetailQ1.Visible = True

        If DetailQuestion1A.Text <> "" Then
            DivDetailQ1A.Visible = True
        Else
            DivDetailQ1A.Visible = False
        End If
        If DetailQuestion1B.Text <> "" Then
            DivDetailQ1B.Visible = True
        Else
            DivDetailQ1B.Visible = False
        End If
        If DetailQuestion1C.Text <> "" Then
            DivDetailQ1C.Visible = True
        Else
            DivDetailQ1C.Visible = False
        End If
        If DetailQuestion1D.Text <> "" Then
            DivDetailQ1D.Visible = True
        Else
            DivDetailQ1D.Visible = False
        End If

    End Sub

    Protected Sub ButtonQ1No_Click(sender As Object, e As EventArgs)
        ButtonQ1Yes.CssClass = "HREButtonInActive"
        ButtonQ1No.CssClass = "HREButtonActive"
        Session("ButtonQ1Yes") = False
        Session("ButtonQ1No") = True

        DivDetailQ1.Visible = False
    End Sub

    Protected Sub ButtonQ2Yes_Click(sender As Object, e As EventArgs)
        ButtonQ2Yes.CssClass = "HREButtonActive"
        ButtonQ2No.CssClass = "HREButtonInActive"
        Session("ButtonQ2Yes") = True
        Session("ButtonQ2No") = False

        DivDetailQ2.Visible = True

        If DetailQuestion2A.Text <> "" Then
            DivDetailQ2A.Visible = True
        Else
            DivDetailQ2A.Visible = False
        End If
        If DetailQuestion2B.Text <> "" Then
            DivDetailQ2B.Visible = True
        Else
            DivDetailQ2B.Visible = False
        End If
        If DetailQuestion2C.Text <> "" Then
            DivDetailQ2C.Visible = True
        Else
            DivDetailQ2C.Visible = False
        End If
        If DetailQuestion2D.Text <> "" Then
            DivDetailQ2D.Visible = True
        Else
            DivDetailQ2D.Visible = False
        End If
    End Sub

    Protected Sub ButtonQ2No_Click(sender As Object, e As EventArgs)
        ButtonQ2Yes.CssClass = "HREButtonInActive"
        ButtonQ2No.CssClass = "HREButtonActive"
        Session("ButtonQ2Yes") = False
        Session("ButtonQ2No") = True

        DivDetailQ2.Visible = False
    End Sub

    Protected Sub ButtonQ3Yes_Click(sender As Object, e As EventArgs)
        ButtonQ3Yes.CssClass = "HREButtonActive"
        ButtonQ3No.CssClass = "HREButtonInActive"
        Session("ButtonQ3Yes") = True
        Session("ButtonQ3No") = False

        DivDetailQ3.Visible = True

        If DetailQuestion3A.Text <> "" Then
            DivDetailQ3A.Visible = True
        Else
            DivDetailQ3A.Visible = False
        End If
        If DetailQuestion3B.Text <> "" Then
            DivDetailQ3B.Visible = True
        Else
            DivDetailQ3B.Visible = False
        End If
        If DetailQuestion3C.Text <> "" Then
            DivDetailQ3C.Visible = True
        Else
            DivDetailQ3C.Visible = False
        End If
        If DetailQuestion3D.Text <> "" Then
            DivDetailQ3D.Visible = True
        Else
            DivDetailQ3D.Visible = False
        End If
    End Sub

    Protected Sub ButtonQ3No_Click(sender As Object, e As EventArgs)
        ButtonQ3Yes.CssClass = "HREButtonInActive"
        ButtonQ3No.CssClass = "HREButtonActive"
        Session("ButtonQ3Yes") = False
        Session("ButtonQ3No") = True

        DivDetailQ3.Visible = False
    End Sub

    Protected Sub ButtonQ4Yes_Click(sender As Object, e As EventArgs)
        ButtonQ4Yes.CssClass = "HREButtonActive"
        ButtonQ4No.CssClass = "HREButtonInActive"
        Session("ButtonQ4Yes") = True
        Session("ButtonQ4No") = False

        DivDetailQ4.Visible = True

        If DetailQuestion4A.Text <> "" Then
            DivDetailQ4A.Visible = True
        Else
            DivDetailQ4A.Visible = False
        End If
        If DetailQuestion4B.Text <> "" Then
            DivDetailQ4B.Visible = True
        Else
            DivDetailQ4B.Visible = False
        End If
        If DetailQuestion4C.Text <> "" Then
            DivDetailQ4C.Visible = True
        Else
            DivDetailQ4C.Visible = False
        End If
        If DetailQuestion4D.Text <> "" Then
            DivDetailQ4D.Visible = True
        Else
            DivDetailQ4D.Visible = False
        End If
    End Sub

    Protected Sub ButtonQ4No_Click(sender As Object, e As EventArgs)
        ButtonQ4Yes.CssClass = "HREButtonInActive"
        ButtonQ4No.CssClass = "HREButtonActive"
        Session("ButtonQ4Yes") = False
        Session("ButtonQ4No") = True

        DivDetailQ4.Visible = False
    End Sub

    Protected Sub ButtonQ5Yes_Click(sender As Object, e As EventArgs)
        ButtonQ5Yes.CssClass = "HREButtonActive"
        ButtonQ5No.CssClass = "HREButtonInActive"
        Session("ButtonQ5Yes") = True
        Session("ButtonQ5No") = False

        DivDetailQ5.Visible = True

        If DetailQuestion5A.Text <> "" Then
            DivDetailQ5A.Visible = True
        Else
            DivDetailQ5A.Visible = False
        End If
        If DetailQuestion5B.Text <> "" Then
            DivDetailQ5B.Visible = True
        Else
            DivDetailQ5B.Visible = False
        End If
        If DetailQuestion5C.Text <> "" Then
            DivDetailQ5C.Visible = True
        Else
            DivDetailQ5C.Visible = False
        End If
        If DetailQuestion5D.Text <> "" Then
            DivDetailQ5D.Visible = True
        Else
            DivDetailQ5D.Visible = False
        End If
    End Sub

    Protected Sub ButtonQ5No_Click(sender As Object, e As EventArgs)
        ButtonQ5Yes.CssClass = "HREButtonInActive"
        ButtonQ5No.CssClass = "HREButtonActive"
        Session("ButtonQ5Yes") = False
        Session("ButtonQ5No") = True

        DivDetailQ5.Visible = False
    End Sub

    Protected Sub ButtonQ6Yes_Click(sender As Object, e As EventArgs)
        ButtonQ6Yes.CssClass = "HREButtonActive"
        ButtonQ6No.CssClass = "HREButtonInActive"
        Session("ButtonQ6Yes") = True
        Session("ButtonQ6No") = False

        DivDetailQ6.Visible = True

        If DetailQuestion6A.Text <> "" Then
            DivDetailQ6A.Visible = True
        Else
            DivDetailQ6A.Visible = False
        End If
        If DetailQuestion6B.Text <> "" Then
            DivDetailQ6B.Visible = True
        Else
            DivDetailQ6B.Visible = False
        End If
        If DetailQuestion6C.Text <> "" Then
            DivDetailQ6C.Visible = True
        Else
            DivDetailQ6C.Visible = False
        End If
        If DetailQuestion6D.Text <> "" Then
            DivDetailQ6D.Visible = True
        Else
            DivDetailQ6D.Visible = False
        End If
    End Sub

    Protected Sub ButtonQ6No_Click(sender As Object, e As EventArgs)
        ButtonQ6Yes.CssClass = "HREButtonInActive"
        ButtonQ6No.CssClass = "HREButtonActive"
        Session("ButtonQ6Yes") = False
        Session("ButtonQ6No") = True

        DivDetailQ6.Visible = False
    End Sub

    Protected Sub ButtonQ7Yes_Click(sender As Object, e As EventArgs)
        ButtonQ7Yes.CssClass = "HREButtonActive"
        ButtonQ7No.CssClass = "HREButtonInActive"
        Session("ButtonQ7Yes") = True
        Session("ButtonQ7No") = False

        DivDetailQ7.Visible = True

        If DetailQuestion7A.Text <> "" Then
            DivDetailQ7A.Visible = True
        Else
            DivDetailQ7A.Visible = False
        End If
        If DetailQuestion7B.Text <> "" Then
            DivDetailQ7B.Visible = True
        Else
            DivDetailQ7B.Visible = False
        End If
        If DetailQuestion7C.Text <> "" Then
            DivDetailQ7C.Visible = True
        Else
            DivDetailQ7C.Visible = False
        End If
        If DetailQuestion7D.Text <> "" Then
            DivDetailQ7D.Visible = True
        Else
            DivDetailQ7D.Visible = False
        End If
    End Sub

    Protected Sub ButtonQ7No_Click(sender As Object, e As EventArgs)
        ButtonQ7Yes.CssClass = "HREButtonInActive"
        ButtonQ7No.CssClass = "HREButtonActive"
        Session("ButtonQ7Yes") = False
        Session("ButtonQ7No") = True

        DivDetailQ7.Visible = False
    End Sub

    Protected Sub ButtonQ8Yes_Click(sender As Object, e As EventArgs)
        ButtonQ8Yes.CssClass = "HREButtonActive"
        ButtonQ8No.CssClass = "HREButtonInActive"
        Session("ButtonQ8Yes") = True
        Session("ButtonQ8No") = False

        DivDetailQ8.Visible = True

        If DetailQuestion8A.Text <> "" Then
            DivDetailQ8A.Visible = True
        Else
            DivDetailQ8A.Visible = False
        End If
        If DetailQuestion8B.Text <> "" Then
            DivDetailQ8B.Visible = True
        Else
            DivDetailQ8B.Visible = False
        End If
        If DetailQuestion8C.Text <> "" Then
            DivDetailQ8C.Visible = True
        Else
            DivDetailQ8C.Visible = False
        End If
        If DetailQuestion8D.Text <> "" Then
            DivDetailQ8D.Visible = True
        Else
            DivDetailQ8D.Visible = False
        End If
    End Sub

    Protected Sub ButtonQ8No_Click(sender As Object, e As EventArgs)
        ButtonQ8Yes.CssClass = "HREButtonInActive"
        ButtonQ8No.CssClass = "HREButtonActive"
        Session("ButtonQ8Yes") = False
        Session("ButtonQ8No") = True

        DivDetailQ8.Visible = False
    End Sub

    Protected Sub ButtonQ9Yes_Click(sender As Object, e As EventArgs)
        ButtonQ9Yes.CssClass = "HREButtonActive"
        ButtonQ9No.CssClass = "HREButtonInActive"
        Session("ButtonQ9Yes") = True
        Session("ButtonQ9No") = False

        DivDetailQ9.Visible = True

        If DetailQuestion9A.Text <> "" Then
            DivDetailQ9A.Visible = True
        Else
            DivDetailQ9A.Visible = False
        End If
        If DetailQuestion9B.Text <> "" Then
            DivDetailQ9B.Visible = True
        Else
            DivDetailQ9B.Visible = False
        End If
        If DetailQuestion9C.Text <> "" Then
            DivDetailQ9C.Visible = True
        Else
            DivDetailQ9C.Visible = False
        End If
        If DetailQuestion9D.Text <> "" Then
            DivDetailQ9D.Visible = True
        Else
            DivDetailQ9D.Visible = False
        End If
    End Sub

    Protected Sub ButtonQ9No_Click(sender As Object, e As EventArgs)
        ButtonQ9Yes.CssClass = "HREButtonInActive"
        ButtonQ9No.CssClass = "HREButtonActive"
        Session("ButtonQ9Yes") = False
        Session("ButtonQ9No") = True

        DivDetailQ9.Visible = False
    End Sub

    Protected Sub ButtonQ10Yes_Click(sender As Object, e As EventArgs)
        ButtonQ10Yes.CssClass = "HREButtonActive"
        ButtonQ10No.CssClass = "HREButtonInActive"
        Session("ButtonQ10Yes") = True
        Session("ButtonQ10No") = False

        DivDetailQ10.Visible = True

        If DetailQuestion10A.Text <> "" Then
            DivDetailQ10A.Visible = True
        Else
            DivDetailQ10A.Visible = False
        End If
        If DetailQuestion10B.Text <> "" Then
            DivDetailQ10B.Visible = True
        Else
            DivDetailQ10B.Visible = False
        End If
        If DetailQuestion10C.Text <> "" Then
            DivDetailQ10C.Visible = True
        Else
            DivDetailQ10C.Visible = False
        End If
        If DetailQuestion10D.Text <> "" Then
            DivDetailQ10D.Visible = True
        Else
            DivDetailQ10D.Visible = False
        End If
    End Sub

    Protected Sub ButtonQ10No_Click(sender As Object, e As EventArgs)
        ButtonQ10Yes.CssClass = "HREButtonInActive"
        ButtonQ10No.CssClass = "HREButtonActive"
        Session("ButtonQ10Yes") = False
        Session("ButtonQ10No") = True

        DivDetailQ10.Visible = False
    End Sub
#End Region

#Region "Buttons to Upload and Save"
    Protected Sub ButtonSaveSectionQ1_Click(sender As Object, e As ImageClickEventArgs)
        Session("QuestionId") = QuestionId1.Text
        UploadDocument()
        Save()
    End Sub
    Protected Sub ButtonSaveSectionQ2_Click(sender As Object, e As ImageClickEventArgs)
        Session("QuestionId") = QuestionId2.Text
        UploadDocument()
        Save()
    End Sub
    Protected Sub ButtonSaveSectionQ3_Click(sender As Object, e As ImageClickEventArgs)
        Session("QuestionId") = QuestionId3.Text
        UploadDocument()
        Save()
    End Sub
    Protected Sub ButtonSaveSectionQ4_Click(sender As Object, e As ImageClickEventArgs)
        Session("QuestionId") = QuestionId4.Text
        UploadDocument()
        Save()
    End Sub
    Protected Sub ButtonSaveSectionQ5_Click(sender As Object, e As ImageClickEventArgs)
        Session("QuestionId") = QuestionId5.Text
        UploadDocument()
        Save()
    End Sub
    Protected Sub ButtonSaveSectionQ6_Click(sender As Object, e As ImageClickEventArgs)
        Session("QuestionId") = QuestionId6.Text
        UploadDocument()
        Save()
    End Sub
    Protected Sub ButtonSaveSectionQ7_Click(sender As Object, e As ImageClickEventArgs)
        Session("QuestionId") = QuestionId7.Text
        UploadDocument()
        Save()
    End Sub
    Protected Sub ButtonSaveSectionQ8_Click(sender As Object, e As ImageClickEventArgs)
        Session("QuestionId") = QuestionId8.Text
        UploadDocument()
        Save()
    End Sub
    Protected Sub ButtonSaveSectionQ9_Click(sender As Object, e As ImageClickEventArgs)
        Session("QuestionId") = QuestionId9.Text
        UploadDocument()
        Save()
    End Sub
    Protected Sub ButtonSaveSectionQ10_Click(sender As Object, e As ImageClickEventArgs)
        Session("QuestionId") = QuestionId10.Text
        UploadDocument()
        Save()
    End Sub

#End Region

    Protected Sub ImageNext_Click(sender As Object, e As ImageClickEventArgs)

        Response.AddHeader("REFRESH", "0;URL=" + Session("NextScreen"))

    End Sub

    Private Sub ResetScrollPosition()
        If Not ClientScript.IsClientScriptBlockRegistered(Me.GetType(), "CreateResetScrollPosition") Then
            'Create the ResetScrollPosition() function
            ClientScript.RegisterClientScriptBlock(Me.GetType(), "CreateResetScrollPosition",
                             "Function ResetScrollPosition() {" & vbCrLf &
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

    Protected Sub ButtonChangeDoc_Click(sender As Object, e As EventArgs)
        DivUpload1.Visible = True
        DivExistingDocument.Visible = False
    End Sub
End Class
