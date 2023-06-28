
Partial Class CorporateHome
    Inherits System.Web.UI.Page

    'Dim sc As New ScreenConfiguration


    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    '    Session("ScreenName") = "Corporate Home"


    '    Dim CompanyAlias As String

    '    If InStr(Request.Url.ToString, "local") = 0 Then
    '        CompanyAlias = sc.AliasInURL(Server.HtmlEncode(Request.ServerVariables("SERVER_NAME")), ".")
    '        ltrmainmenu.Text = sc.BuildCorporateSiteMenu(CompanyAlias, Session("ScreenName"))
    '        'ltrmainmenu.Text = sc.BuildCorporateSiteMenu(CompanyAlias, Session("ScreenName"))
    '        '    LiteralTopMenu.Text = sc.BuildCorporateSiteMenu(CompanyAlias, Session("ScreenName"))
    '        'Else
    '        '    LiteralTopMenu.Text = sc.BuildMenu(True, Session("ScreenName"))
    '    End If
    'End Sub


End Class
