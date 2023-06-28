Imports System.Data.SqlClient
Imports System.IO

Public Class Admin_CompanyFiles
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim s As New Security
    Dim sc As New ScreenConfiguration
    Dim c As New Company

    Dim intCompanyId As Integer
    Dim intCompanyFileId As Integer
    Dim intFileCategoryId As Integer
    Dim intFileTypeId As Integer
    Dim intFileSubTypeId As Integer
    Dim FileTypeShortDesc As String

    Dim strScreenName As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Remove Shadow info
        'Session.Remove("ShadowCompanyId")
        Session.Remove("ShadowEmployeeId")
        Session.Remove("ShadowEmployeeName")
        Session.Remove("ShadowEmployee")
        Session.Remove("ShadowCompany")

        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change these on each page
        strScreenName = "CompanyFiles"

        If Page.IsPostBack = False Then
            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), Session("ScreenPath"))
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), 0, Session("ScreenPath"), Session("Athena")) + Session("TabString")
            sc.ScreenSetup(intCompanyId, strScreenName, Session("UserId"))
            lblMainArticleTitle.Text = sc.MainArticleTitle
            lblMainArticleText.Text = sc.MainArticleText

            If lblMainArticleText.Text = "" Then
                divText.Visible = False
            End If

            PopulateCompanyInfo()
            GetFiles()
            GetDropDownLists()

            s.SaveUserBrowse(Session("UserId"), strScreenName, "Browsed on " + strScreenName + " for CompanyId: " + intCompanyId.ToString)

        Else
            'If first time page is submitted and we have file in FileUpload control but not in session 
            ' Store the values to Session Object 
            If Session("FileUpload") Is Nothing And FileUpload1.HasFile Then
                Session("FileUpload") = FileUpload1
                LabelFileUpload1.Text = FileUpload1.FileName

                'Next time submit and Session has values but FileUpload is Blank 
                ' Return the values from session to FileUpload 
            ElseIf Not Session("FileUpload") Is Nothing And Not FileUpload1.HasFile Then
                FileUpload1 = Session("FileUpload")
                LabelFileUpload1.Text = FileUpload1.FileName

                'Now there could be another situation when Session has File but user want to change the file 
                'In this case we have to change the file in session object 
            ElseIf (FileUpload1.HasFile) Then
                Session("FileUpload") = FileUpload1
                LabelFileUpload1.Text = FileUpload1.FileName
            End If
        End If

        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub
    Private Sub PopulateCompanyInfo()

        Session("ActiveCompany") = IIf(chkActive.Checked = True, 1, 0)

        'Fill up Company list based on UserId
        c.LoadCompanyList(Session("UserId"), Session("ShadowCompanyId"), "Consolidated", "", Session("ActiveCompany"), 0, 0, Session("ds"))

        ddlCompany.DataSource = Session("ds").tables(0)
        ddlCompany.DataBind()

        If ddlCompany.Items.Count < 2 Then
            lblCompanyName.Text = ddlCompany.Items(0).Text
            lblCompanyName.Text = lblCompanyName.Text.Replace(" - [Single]", "")
            lblCompanyName.Text = lblCompanyName.Text.Replace(" - [Parent]", "")
            lblCompanyName.Text = lblCompanyName.Text.Replace(" - [Child]", "")
            Session("ShadowCompanyId") = ddlCompany.SelectedValue
            intCompanyId = Session("ShadowCompanyId")
            ddlCompany.Text = ddlCompany.SelectedItem.Text
            If Session("ActiveCompany") = 1 Then
                divCompanyList.Visible = False
            End If
        Else
            divCompanyName.Visible = False
            If Session("ShadowCompanyId") Is Nothing Or Session("ShadowCompanyId") = 0 Then
                ddlCompany.Items.Insert(0, New ListItem("SELECT"))
                ddlCompany.Items(0).Selected = True
                Session("ShadowCompanyId") = 0
                intCompanyId = 0
            ElseIf Session("ShadowCompanyId") <> 0 Then
                ddlCompany.SelectedValue = Session("ShadowCompanyId")
                intCompanyId = Session("ShadowCompanyId")
            Else
                ddlCompany.Items(0).Selected = True
            End If

        End If

    End Sub
    Private Sub GetFiles()
        c.GetCompanyFiles(intCompanyId, 1, grdImportFiles)

        c.GetCompanyFiles(intCompanyId, 2, grdExportFiles)


    End Sub

    Private Sub GetDropDownLists()

        c.GetFileTypeList(1, ddlFileTypeList)
        ddlFileTypeList.Items.Insert(0, New ListItem("Select File Type", "-1"))

        If ddlFileTypeList.SelectedValue <> "-1" Then
            intFileTypeId = ddlFileTypeList.SelectedValue
            Session("FileType") = ddlFileTypeList.SelectedItem.Text
        Else
            intFileTypeId = 0
            ddlFileTypeList.SelectedItem.Text = "Select File Type"

        End If

        'c.getCompanyFileSubTypeList(intCompanyId, intFileTypeId, ddlFileSubTypeList)
        'ddlFileSubTypeList.Items.Insert(0, New ListItem("Select File Type", "-1"))

        'If ddlFileSubTypeList.SelectedValue <> "-1" Then
        '    intFileSubTypeId = ddlFileSubTypeList.SelectedValue
        'Else
        '    intFileSubTypeId = 0
        '    ddlFileSubTypeList.SelectedItem.Text = "Select File Type"

        'End If

        If (FileUpload1.HasFile) Then
            Session("FileUpload") = FileUpload1
            LabelFileUpload1.Text = FileUpload1.FileName
        Else
            LabelFileUpload1.Text = ""
        End If

    End Sub

    Protected Sub btnUpload_Click(sender As Object, e As EventArgs)
        If FileUpload1.HasFile Then
            Try
                'Get Filename
                Dim NewFileName = Server.HtmlEncode(FileUpload1.FileName)
                'Get File Extension
                Dim Extension As String = System.IO.Path.GetExtension(NewFileName)
                'Get CompanyId 
                Dim strCompanyId As String = intCompanyId.ToString
                'Get root path
                Dim Rootpath As String = Server.MapPath("~/Uploads/")
                'Get Date
                Dim strDate As String = Date.Now().ToString("yyyy.MM.dd_HHmmss")

                'Only allow files with proper extensions to load - Replaced characters that are not allowed
                Extension = Extension.ToLower()
                If LCase(Extension) = ".xls" Or LCase(Extension) = ".xlsx" Or LCase(Extension) = ".csv" Or LCase(Extension) = ".txt" Then
                    NewFileName = Replace(Replace(Replace(Replace(Replace(Replace(Replace(NewFileName, " ", "_"), "&amp;", ""), "&39;", ""), "&", ""), "#", ""), ";", ""), "+", "")
                    Dim FilePath As String
                    Dim FullFilePath As String = ""
                    Dim SaveFilePath As String = ""

                    FilePath = Rootpath & NewFileName

                    If ddlFileTypeList.SelectedValue = 1 Then
                        FullFilePath = Rootpath & strDate & "_" & strCompanyId & "_" & NewFileName
                    Else
                        lblError.Visible = True
                        lblError.Text = "Please select a File Type"
                    End If

                    FileUpload1.SaveAs(FullFilePath)

                    LabelFileUpload1.Text = FilePath

                    If ddlFileTypeList.SelectedValue = 1 Then
                        SaveFilePath = "/Uploads/" & strDate & "_" & strCompanyId & "_" & NewFileName
                    ElseIf ddlFileTypeList.SelectedValue = 2 Then
                        SaveFilePath = "/Uploads/" & strDate & "_" & strCompanyId & "_" & NewFileName

                    End If

                    If SaveFilePath <> "" Then

                        'Save procedure here
                        Dim objParam As SqlParameter
                        Dim objDataSet As New DataSet
                        Dim aryParams As New ArrayList()
                        Dim sqlCon As New SQLControl
                        sqlCon.OpenConn()
                        Try
                            objParam = New SqlParameter("@CompanyFileId", 0)
                            aryParams.Add(objParam)
                            objParam = New SqlParameter("@CompanyId", intCompanyId)
                            aryParams.Add(objParam)
                            objParam = New SqlParameter("@FileCategoryId", intFileCategoryId)
                            aryParams.Add(objParam)
                            objParam = New SqlParameter("@FileTypeId", ddlFileTypeList.SelectedValue)
                            aryParams.Add(objParam)
                            objParam = New SqlParameter("@TextFileDescr", TextFileDescription.Text)
                            aryParams.Add(objParam)
                            objParam = New SqlParameter("@FileLink", SaveFilePath)
                            aryParams.Add(objParam)
                            objParam = New SqlParameter("@Delete", 0)
                            aryParams.Add(objParam)
                            sqlCon.ExecuteNonQuery("[usp_Company_File_Edit]", aryParams)
                            sqlCon.CloseConn()

                            aryParams = Nothing
                            sqlCon = Nothing

                        Catch ex As Exception
                            Throw New Exception(ex.Message)
                        End Try

                    End If

                    GetFiles()

                    GetDropDownLists()

                Else
                    lblError.Text = "Error:  The file must be a valid format (.xlx, .xlsx, .csv, or .txt)"

                End If
            Catch ex As Exception
                LabelFileUpload1.Text = "ERROR: " & ex.Message.ToString()
            End Try
        End If

    End Sub

    Protected Sub btnSaveDelete_Click(sender As Object, ByVal e As System.EventArgs)
        Dim bt As Button = DirectCast(sender, Button)
        Dim gr As GridViewRow = CType(bt.NamingContainer, GridViewRow)

        Dim gv As GridView = gr.NamingContainer

        Dim keys As DataKey = gv.DataKeys(gr.DataItemIndex)
        Dim intCompanyFileId As Object = keys("CompanyFileId")

        'Save procedure here
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()
        Try
            objParam = New SqlParameter("@CompanyFileId", intCompanyFileId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@CompanyId", intCompanyId)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@FileCateogryId", 0)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@FileTypeId", 0)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@FileSubTypeId", 0)
            aryParams.Add(objParam)
            objParam = New SqlParameter("@FileLink", "")
            aryParams.Add(objParam)
            objParam = New SqlParameter("@Delete", 1)
            aryParams.Add(objParam)
            sqlCon.ExecuteNonQuery("[usp_Company_File_Edit]", aryParams)
            sqlCon.CloseConn()

            aryParams = Nothing
            sqlCon = Nothing

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        GetFiles()

        GetDropDownLists()

    End Sub

    Protected Sub ddlFileTypeList_SelectedIndexChanged(sender As Object, x As EventArgs)
        intFileTypeId = ddlFileTypeList.SelectedValue

        c.GetFileTypeList(intFileCategoryId, ddlFileTypeList)
        ddlFileTypeList.Items.Insert(0, New ListItem("Select File Type", "-1"))

        If ddlFileTypeList.SelectedValue <> "-1" Then
            intFileSubTypeId = ddlFileTypeList.SelectedValue
        Else
            intFileSubTypeId = 0
            ddlFileTypeList.SelectedItem.Text = "Select File Type"

        End If

    End Sub

    Protected Sub chkActiveOnly_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        GetFiles()

    End Sub

    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ShadowCompanyId") = ddlCompany.SelectedValue
        intCompanyId = Session("ShadowCompanyId")

        PopulateCompanyInfo()

        grdImportFiles.EditIndex = -1
        grdExportFiles.EditIndex = -1

        GetFiles()
        GetDropDownLists()


    End Sub

    Protected Sub chkActive_CheckedChanged(sender As Object, e As EventArgs)
        Session("ActiveCompany") = IIf(chkActive.Checked = True, 1, 0)

        Session("ShadowCompanyId") = 0
        intCompanyId = 0

        GetFiles()

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
