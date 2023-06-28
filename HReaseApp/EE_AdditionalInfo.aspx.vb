
Imports System.Data.SqlClient

Public Class EE_AdditionalInfo
    Inherits System.Web.UI.Page

    Dim s As New Security
    Dim sc As New ScreenConfiguration

    Dim intCompanyId As Integer
    Dim intEmployeeId As Integer
    Dim intTransactionId As Integer

    Dim strScreenName As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Timeout") Is Nothing Then
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        'Change this on each page
        strScreenName = "HRDocument"

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
            lblMainArticleText.Text = IIf(sc.MainArticleText = "", "Please complete form", sc.MainArticleText)
            imgNext.Visible = True
            

            PopulateFields()

        End If

        btnAccept.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(btnAccept, "") + ";this.src='/img/processing.gif';")
        imgNext.Attributes.Add("onclick", "this.disabled='true';" + ClientScript.GetPostBackEventReference(imgNext, "") + ";this.src='/img/processing.gif';")

    End Sub

    Private Sub PopulateFields()

        If Not sc.SideMenu1Title Is Nothing Then
            lblSideMenu1Title.Text = sc.SideMenu1Title
            lblSideMenu1text.Text = sc.SideMenu1Text
        End If

        If Not sc.SideMenu2Title Is Nothing Then
            lblSideMenu2Title.Text = sc.SideMenu2Title
            lblSideMenu2text.Text = sc.SideMenu2Text

        End If

        If Not sc.SideMenu3Title Is Nothing Then
            lblSideMenu3Title.Text = sc.SideMenu3Title
            lblSideMenu3text.Text = sc.SideMenu3Text

        End If

        sc.DocumentScreenSetup(Session("ScreenName"), "LeftDocument1", intCompanyId, intEmployeeId, lblLeftDocument1Title.Text, ddlLeftDocument1)
        sc.DocumentScreenSetup(Session("ScreenName"), "LeftDocument2", intCompanyId, intEmployeeId, lblLeftDocument2Title.Text, ddlLeftDocument2)
        sc.DocumentScreenSetup(Session("ScreenName"), "LeftDocument3", intCompanyId, intEmployeeId, lblLeftDocument3Title.Text, ddlLeftDocument3)
        sc.DocumentScreenSetup(Session("ScreenName"), "RightDocument1", intCompanyId, intEmployeeId, lblRightDocument1Title.Text, ddlRightDocument1)
        sc.DocumentScreenSetup(Session("ScreenName"), "RightDocument2", intCompanyId, intEmployeeId, lblRightDocument2Title.Text, ddlRightDocument2)

    End Sub

    Protected Sub imgNext_Click(sender As Object, e As ImageClickEventArgs)

        ResetScrollPosition()
        Response.AddHeader("REFRESH", "0;URL=" + Session("NextScreen"))

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



