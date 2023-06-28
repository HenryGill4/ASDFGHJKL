Imports System.Data.SqlClient

Public Class Admin_CompanyContact
    Inherits System.Web.UI.Page
    Dim s As New Security
    Dim c As New Company
    Dim sc As New ScreenConfiguration
    Dim strScreenName As String
    Dim strScreenShortDesc As String

    Dim intCompanyId As Integer
    Dim intUserId As Integer

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
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
        strScreenName = "Company"
        strScreenShortDesc = "Company Contact"

        If Page.IsPostBack = False Then

            LiteralTopMenu.Text = sc.BuildMenu(Session("Admin"), "Admin_CompanyContact")
            LiteralTab.Text = sc.BuildTabs(Session("Admin"), 0, "Admin_CompanyContact", Session("Athena"))

            'fill State and Country DDL
            c.LoadState(ddlState)
            c.LoadCountry(ddlCountry)

            ddlState.Items.Insert(0, New ListItem(""))
            ddlCountry.Items.Insert(0, New ListItem(""))

            'Hide Edit Areas
            divContactEdit.Visible = False

            PopulateCompanyInfo()
            PopulateCompanyContactInfo()

            s.SaveUserBrowse(Session("UserId"), strScreenName, "Browsed on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString)

        End If

        btnSave.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnSave, "") + ";this.src='/img/processing.gif';")
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

        If Session("Athena") = True Then
            ddlLevel.Visible = True
            lblLevel2.Visible = False
            btnAddContact.Visible = True
        End If


    End Sub

    Private Sub PopulateCompanyContactInfo()

        If c.GetCompanyInfo(intCompanyId, Session("UserId")) = True Then
            lblCompanyNumber.Text = c.CompanyNumber
            lblShortDesc.Text = c.ShortDesc
            lblCompanyLongDesc.Text = c.LongDesc
            lblAlias.Text = c.CompanyAlias
            lblFEIN.Text = c.FEIN
            imgLogo.ImageUrl = c.Logo
            lblAddress.Text = c.Address1
            lblAddress2.Text = c.Address2
            lblCity.Text = c.City
            lblState.Text = c.State
            lblZip.Text = c.Zip
            lblZipExtension.Text = c.ZipExtension
            lblCountry.Text = c.Country
            lblRegion.Text = c.Region
            lblBeginDate.Text = c.CompanyBegin
            lblEndDate.Text = c.CompanyEnd
            lblLevel.Text = c.LevelId
            lblLevel2.Text = c.LevelId
            ddlLevel.SelectedValue = c.LevelId
            txtCompanyNumber.Text = c.CompanyNumber
            txtCompanyShort.Text = c.ShortDesc
            txtAlias.Text = c.CompanyAlias
            txtFEIN.Text = c.FEIN
            txtLogo.Text = c.Logo
            txtCompanyName.Text = c.LongDesc
            txtAddress1.Text = c.Address1
            txtAddress2.Text = c.Address2
            txtCity.Text = c.City
            txtZip.Text = c.Zip
            txtZipExt.Text = c.ZipExtension
            txtRegion.Text = c.Region
            ddlState.SelectedValue = IIf(c.State <> "", c.State, "")
            ddlCountry.SelectedValue = IIf(c.Country <> "", c.Country, "USA")
            txtBeginDate.Text = c.CompanyBegin
            txtEndDate.Text = c.CompanyEnd
            lblCompanyId.Text = c.CompanyID
        Else
            ClearFields()
        End If
    End Sub

    Private Sub ClearFields()

        lblCompanyNumber.Text = ""
        lblShortDesc.Text = ""
        lblCompanyLongDesc.Text = ""
        lblAlias.Text = ""
        lblFEIN.Text = ""
        imgLogo.ImageUrl = ""
        lblAddress.Text = ""
        lblAddress2.Text = ""
        lblZip.Text = ""
        lblZipExtension.Text = ""
        lblState.Text = ""
        lblCity.Text = ""
        lblRegion.Text = ""
        lblBeginDate.Text = ""
        lblEndDate.Text = ""
        lblLevel.Text = ""
        lblLevel2.Text = "2"
        ddlLevel.SelectedValue = "2"
        txtCompanyNumber.Text = ""
        txtCompanyShort.Text = ""
        txtCompanyName.Text = ""
        txtAlias.Text = ""
        txtFEIN.Text = ""
        txtLogo.Text = ""
        txtRegion.Text = ""
        txtAddress1.Text = ""
        txtAddress2.Text = ""
        txtCity.Text = ""
        txtZip.Text = ""
        txtZipExt.Text = ""
        ddlState.SelectedValue = ""
        ddlCountry.SelectedValue = "USA"
        txtBeginDate.Text = ""
        txtEndDate.Text = ""

    End Sub

    Protected Sub btnSave_Click()

        intCompanyId = IIf(Session("AddNew") = 0, ddlCompany.SelectedValue, 0)

        'Save New Contact Info 
        Dim objParam As SqlParameter
        Dim objDataSet As New DataSet
        Dim aryParams As New ArrayList()
        Dim sqlCon As New SQLControl
        sqlCon.OpenConn()

        objParam = New SqlParameter("@CompanyId", IIf(Session("AddNew") = 0, ddlCompany.SelectedValue, 0))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@LevelId", ddlLevel.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@CompanyNumber", txtCompanyNumber.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@CompanyAlias", txtAlias.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@ShortDesc", txtCompanyShort.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@LongDesc", txtCompanyName.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Address1", txtAddress1.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Address2", txtAddress2.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@City", txtCity.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@State", ddlState.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Zip", txtZip.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@ZipExtension", txtZipExt.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Country", ddlCountry.SelectedValue)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Region", txtRegion.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@BeginDate", txtBeginDate.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@EndDate", IIf(Trim(txtEndDate.Text) = "", "12/31/2999", txtEndDate.Text))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@FEIN", txtFEIN.Text)
        aryParams.Add(objParam)
        objParam = New SqlParameter("@UserId", Session("UserId"))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@NewCompany", Session("AddNew"))
        aryParams.Add(objParam)
        objParam = New SqlParameter("@Logo", txtLogo.Text)
        aryParams.Add(objParam)

        Try
            objDataSet = sqlCon.CreateDataSet("usp_Company_Edit", aryParams)

            If objDataSet.Tables(0).Rows.Count > 0 Then
                Session("ShadowCompanyId") = objDataSet.Tables(0).Rows(0).Item("CompanyId")
                Session("AddNew") = 0
            Else
                chkActive.Checked = False
                Session("ActiveCompany") = 0
                Session("ShadowCompanyId") = 0
                chkActive.Checked = True
            End If

            intCompanyId = Session("ShadowCompanyId")

            'Save to Transaction Table
            s.SaveUserUpdate(Session("UserId"), strScreenShortDesc, "Saved on " + strScreenShortDesc + " for CompanyId: " + intCompanyId.ToString, 0, 0, 0, "01/01/1900", 0)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        sqlCon.CloseConn()
        aryParams = Nothing
        sqlCon = Nothing

        PopulateCompanyInfo()
        PopulateCompanyContactInfo()

        divNextButton.Visible = True
        divTopHeader.Visible = True
        divContactReview.Visible = True
        divContactEdit.Visible = False
    End Sub

    Protected Sub btnAddContact_Click(sender As Object, e As ImageClickEventArgs)
        ClearFields()
        Session("AddNew") = "1"

        divNextButton.Visible = False
        divTopHeader.Visible = False
        divContactReview.Visible = False
        divContactEdit.Visible = True
    End Sub

    Protected Sub btnEditContact_Click(sender As Object, e As EventArgs) Handles btnEditContact.Click
        Session("AddNew") = "0"

        PopulateCompanyInfo()
        PopulateCompanyContactInfo()

        divNextButton.Visible = False
        divTopHeader.Visible = False
        divContactReview.Visible = False
        divContactEdit.Visible = True
    End Sub

    Protected Sub btnCancel_Click()
        PopulateCompanyInfo()
        PopulateCompanyContactInfo()

        divNextButton.Visible = True
        divTopHeader.Visible = True
        divContactReview.Visible = True
        divContactEdit.Visible = False

    End Sub

    Protected Sub ddlCompany_SelectedIndexChanged(sender As Object, e As EventArgs)
        Session("ShadowCompanyId") = ddlCompany.SelectedValue
        intCompanyId = Session("ShadowCompanyId")

        PopulateCompanyInfo()
        PopulateCompanyContactInfo()

    End Sub

    Protected Sub chkActive_CheckedChanged(sender As Object, e As EventArgs)
        Session("ActiveCompany") = IIf(chkActive.Checked = True, 1, 0)

        Session("ShadowCompanyId") = 0
        intCompanyId = 0

        PopulateCompanyInfo()
        PopulateCompanyContactInfo()

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)
        Session.Remove("AddNew")
        Response.Redirect("~/Admin_CompanyRelationship.aspx")
    End Sub


End Class
