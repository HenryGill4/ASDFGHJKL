Imports System.Data.SqlClient

Public Class EE_Documents
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim ec As New Employee
    Dim c As New Company

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer
    Dim intEmployeeDocumentId As Integer
    Dim intDocumentTypeId As Integer
    Dim DocumentTypeShortDesc As String
    Dim intDocumentSubTypeId As Integer

    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "EEDocuments"
        strScreenShortDesc = "Employee Documents"

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

            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), Session("ScreenPath"))
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), intEmployeeId, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            sc.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            lblMainArticleTitle.Text = sc.MainArticleTitle
            lblMainArticleText.Text = sc.MainArticleText

            If lblMainArticleText.Text = "" Then
                divText.Visible = False
            End If

            GetEmployeeDocuments()
            GetDropDownLists()

        Else
            'If first time page is submitted and we have file in FileUpload control but not in session 
            ' Store the values to Session Object 
            If Session("FileUpload") Is Nothing And fuUploadDoc.HasFile Then
                Session("FileUpload") = fuUploadDoc
                lblFileUpload.Text = fuUploadDoc.FileName

                'Next time submit and Session has values but FileUpload is Blank 
                ' Return the values from session to FileUpload 
            ElseIf Not Session("FileUpload") Is Nothing And Not fuUploadDoc.HasFile Then
                fuUploadDoc = Session("FileUpload")
                lblFileUpload.Text = fuUploadDoc.FileName

                'Now there could be another situation when Session has File but user want to change the file 
                'In this case we have to change the file in session object 
            ElseIf (fuUploadDoc.HasFile) Then
                Session("FileUpload") = fuUploadDoc
                lblFileUpload.Text = fuUploadDoc.FileName
            End If

        End If

        If Session("DataComplete") = "Yes" Then
            divSuccess.Visible = True
            imgNext.Visible = True
        Else
            divSuccess.Visible = False
            imgNext.Visible = False

        End If

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub GetEmployeeDocuments()

        ec.GetEmployeeDocuments(intCompanyId, intEmployeeId, grdEEDocs)

        ec.EmployeeDocumentsNeeded(intCompanyId, intEmployeeId, grdEEDocsNeeded)

    End Sub

    Private Sub GetDropDownLists()

        c.GetDocumentTypeList(6, ddlDocumentTypeList)
        ddlDocumentTypeList.Items.Insert(0, New ListItem("Select Support For", "-1"))

        If ddlDocumentTypeList.SelectedValue <> "-1" Then
            intDocumentTypeId = ddlDocumentTypeList.SelectedValue
            Session("DocumentType") = ddlDocumentTypeList.SelectedItem.Text
        Else
            intDocumentTypeId = 0
            ddlDocumentTypeList.SelectedItem.Text = "Select Support For"

        End If

        ec.GetDocumentSubTypeList(intDocumentTypeId, ddlDocumentSubTypeList)
        ddlDocumentSubTypeList.Items.Insert(0, New ListItem("Select Document Type", "-1"))

        If ddlDocumentSubTypeList.SelectedValue <> "-1" Then
            intDocumentSubTypeId = ddlDocumentSubTypeList.SelectedValue
        Else
            intDocumentSubTypeId = 0
            ddlDocumentSubTypeList.SelectedItem.Text = "Select Document Type"

        End If

        If (fuUploadDoc.HasFile) Then
            lblFileUpload.Text = fuUploadDoc.FileName
        Else
            lblFileUpload.Text = ""
        End If

    End Sub

    Protected Sub btnUpload_Click(sender As Object, e As EventArgs) Handles btnSaveNew.Click
        If fuUploadDoc.HasFile Then
            Try
                'Get Filename
                Dim NewFileName = Server.HtmlEncode(fuUploadDoc.FileName)
                'Get File Extension
                Dim Extension As String = System.IO.Path.GetExtension(NewFileName)
                'Get CompanyId 
                Dim strCompanyId As String = intCompanyId.ToString
                'Get EmployeeId 
                Dim strEmployeeId As String = intEmployeeId.ToString
                'Get root path
                Dim Rootpath As String = Server.MapPath(".\\")
                'Get Date
                Dim strDate As String = Date.Now().ToString("yyyy.MM.dd_HHmmss")

                'Only allow files with proper extensions to load - Replaced characters that are not allowed
                Extension = Extension.ToLower()
                If LCase(Extension) = ".doc" Or LCase(Extension) = ".docx" Or LCase(Extension) = ".pdf" Or LCase(Extension) = ".tiff" Or LCase(Extension) = ".gif" Or LCase(Extension) = ".png" Or LCase(Extension) = ".jpg" Or LCase(Extension) = ".jpeg" Then
                    NewFileName = Replace(Replace(Replace(Replace(Replace(Replace(Replace(NewFileName, " ", "_"), "&amp;", ""), "&39;", ""), "&", ""), "#", ""), ";", ""), "+", "")
                    Dim FilePath As String
                    Dim FullFilePath As String = ""
                    Dim SaveFilePath As String = ""

                    FilePath = Rootpath & NewFileName

                    If ddlDocumentTypeList.SelectedValue = 6 Then
                        FullFilePath = Rootpath & "img\EmployeeDocuments\Dependents\" & strDate & "_" & strCompanyId & "_" & strEmployeeId & "_" & NewFileName
                    ElseIf ddlDocumentTypeList.SelectedValue = 7 Then
                        FullFilePath = Rootpath & "img\EmployeeDocuments\DirectDeposit\" & strDate & "_" & strCompanyId & "_" & strEmployeeId & "_" & NewFileName
                    ElseIf ddlDocumentTypeList.SelectedValue = 8 Then
                        FullFilePath = Rootpath & "img\EmployeeDocuments\I9\" & strDate & "_" & strCompanyId & "_" & strEmployeeId & "_" & NewFileName
                    ElseIf ddlDocumentTypeList.SelectedValue = 9 Then
                        FullFilePath = Rootpath & "img\EmployeeDocuments\Benefits\" & strDate & "_" & strCompanyId & "_" & strEmployeeId & "_" & NewFileName
                    ElseIf ddlDocumentTypeList.SelectedValue = 10 Then
                        FullFilePath = Rootpath & "img\EmployeeDocuments\Other\" & strDate & "_" & Session("DocumentType") & "_" & strCompanyId & "_" & strEmployeeId & "_" & NewFileName
                    ElseIf ddlDocumentTypeList.SelectedValue = 13 Or ddlDocumentTypeList.SelectedValue = 14 Then
                        FullFilePath = Rootpath & "img\EmployeeDocuments\VaccineMandate\" & strDate & "_" & strCompanyId & "_" & strEmployeeId & "_" & NewFileName
                    ElseIf ddlDocumentTypeList.SelectedValue = 15 Then
                        FullFilePath = Rootpath & "img\EmployeeDocuments\401k\" & strDate & "_" & strCompanyId & "_" & strEmployeeId & "_" & NewFileName
                    Else
                        lblError.Visible = True
                        lblError.Text = "Please select a Support Type"
                    End If

                    fuUploadDoc.SaveAs(FullFilePath)

                    lblFileUpload.Text = FilePath

                    If ddlDocumentTypeList.SelectedValue = 6 Then
                        SaveFilePath = "/img/EmployeeDocuments/Dependents/" & strDate & "_" & strCompanyId & "_" & strEmployeeId & "_" & NewFileName
                    ElseIf ddlDocumentTypeList.SelectedValue = 7 Then
                        SaveFilePath = "/img/EmployeeDocuments/DirectDeposit/" & strDate & "_" & strCompanyId & "_" & strEmployeeId & "_" & NewFileName
                    ElseIf ddlDocumentTypeList.SelectedValue = 8 Then
                        SaveFilePath = "/img/EmployeeDocuments/I9/" & strDate & "_" & strCompanyId & "_" & strEmployeeId & "_" & NewFileName
                    ElseIf ddlDocumentTypeList.SelectedValue = 9 Then
                        SaveFilePath = "/img/EmployeeDocuments/Benefits/" & strDate & "_" & strCompanyId & "_" & strEmployeeId & "_" & NewFileName
                    ElseIf ddlDocumentTypeList.SelectedValue = 10 Then
                        SaveFilePath = "/img/EmployeeDocuments/Other/" & strDate & "_" & Session("DocumentType") & "_" & strCompanyId & "_" & strEmployeeId & "_" & NewFileName
                    ElseIf ddlDocumentTypeList.SelectedValue = 13 Or ddlDocumentTypeList.SelectedValue = 14 Then
                        SaveFilePath = "/img/EmployeeDocuments/VaccineMandate/" & strDate & "_" & strCompanyId & "_" & strEmployeeId & "_" & NewFileName
                    ElseIf ddlDocumentTypeList.SelectedValue = 15 Then
                        SaveFilePath = "/img/EmployeeDocuments/401k/" & strDate & "_" & strCompanyId & "_" & strEmployeeId & "_" & NewFileName

                    End If

                    If SaveFilePath <> "" Then

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
                            objParam = New SqlParameter("@DocumentTypeId", ddlDocumentTypeList.SelectedValue)
                            aryParams.Add(objParam)
                            objParam = New SqlParameter("@DocumentSubTypeId", ddlDocumentSubTypeList.SelectedValue)
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

                    End If

                    GetEmployeeDocuments()

                    GetDropDownLists()

                Else
                    lblFileUpload.Text = "Error:  The file must be a valid format (.doc, .docx, .pdf, .tiff, .gif, .png, .jpg, .jpeg)"

                End If
            Catch ex As Exception
                lblFileUpload.Text = "ERROR: " & ex.Message.ToString()
            End Try
        End If

    End Sub

    Protected Sub btnSaveDelete_Click(sender As Object, ByVal e As System.EventArgs)
        Dim bt As Button = DirectCast(sender, Button)
        Dim gr As GridViewRow = CType(bt.NamingContainer, GridViewRow)

        Dim gv As GridView = gr.NamingContainer

        Dim keys As DataKey = gv.DataKeys(gr.DataItemIndex)
        Dim intEmployeeDocumentId As Object = keys("EmployeeDocumentId")

        'Save procedure here
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()
        Try
            objParam = New SqlParameter("@EmployeeDocumentId", intEmployeeDocumentId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@CompanyId", intCompanyId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@EmployeeId", intEmployeeId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@DocumentTypeId", 0)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@DocumentSubTypeId", 0)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@DocumentLink", "")
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Delete", 1)
            aryParams.Add(objParam)
            sqlCon.ExecuteNonQuery("[usp_Employee_Document_Edit]", aryParams)
            sqlCon.CloseConn()

            aryParams = Nothing
            sqlCon = Nothing

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        GetEmployeeDocuments()

        GetDropDownLists()

    End Sub

    Protected Sub ddlDocumentTypeList_SelectedIndexChanged(sender As Object, x As EventArgs)
        intDocumentTypeId = ddlDocumentTypeList.SelectedValue

        ec.GetDocumentSubTypeList(intDocumentTypeId, ddlDocumentSubTypeList)
        ddlDocumentSubTypeList.Items.Insert(0, New ListItem("Select Document Type", "-1"))

        If ddlDocumentSubTypeList.SelectedValue <> "-1" Then
            intDocumentSubTypeId = ddlDocumentSubTypeList.SelectedValue
        Else
            intDocumentSubTypeId = 0
            ddlDocumentSubTypeList.SelectedItem.Text = "Select Document Type"

        End If

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)

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
