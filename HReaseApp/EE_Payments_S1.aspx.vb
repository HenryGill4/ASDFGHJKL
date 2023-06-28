
Imports System
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Text.RegularExpressions
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Xml
Imports System.Web.UI.WebControls
Imports System.IO
Imports System.Net
Imports System.Text
Imports System.Security.Cryptography.X509Certificates
Imports HReaseApp
Imports System.Net.Security


Public Class EE_Payments_S1
    Inherits System.Web.UI.Page

    Dim sql As New SQLControl
    Dim ec As New Employee
    Dim DepClass As New Dependent
    Dim PlanClass As New Plans
    Dim SecClass As New Security
    Dim intTransactionId As Integer
    Dim ScreenClass As New ScreenConfiguration
    Dim intCompanyId As Integer
    Dim intEmpId As Integer
    Dim EECost As Decimal

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Request("token-id") IsNot Nothing Then
            Dim xmlRequest As XmlDocument = New XmlDocument()
            Dim xmlDecl As XmlDeclaration = xmlRequest.CreateXmlDeclaration("1.0", "UTF-8", "yes")
            Dim root As XmlElement = xmlRequest.DocumentElement
            xmlRequest.InsertBefore(xmlDecl, root)

            Dim xmlCompleteTransaction As XmlElement = xmlRequest.CreateElement("complete-action")
            Dim xmlApiKey As XmlElement = xmlRequest.CreateElement("api-key")
            xmlApiKey.InnerText = "eVg799r7xVMF5S44H7wPFW4fSw79RUA7"
            xmlCompleteTransaction.AppendChild(xmlApiKey)

            Dim xmlTokenId As XmlElement = xmlRequest.CreateElement("token-id")
            xmlTokenId.InnerText = Request("token-id")
            xmlCompleteTransaction.AppendChild(xmlTokenId)
            xmlRequest.AppendChild(xmlCompleteTransaction)

            Dim responseFromServer As String = Me.SendXMLRequest(xmlRequest)
            Dim responseReader As XmlReader = XmlReader.Create(New StringReader(responseFromServer))
            Dim xDoc As XmlDocument = New XmlDocument()
            xDoc.Load(responseReader)

            Dim response As XmlNodeList = xDoc.GetElementsByTagName("result")
            Dim responseText As XmlNodeList = xDoc.GetElementsByTagName("result-text")
            Session("data") = responseFromServer
            Session("result") = response(0).InnerText
            Session("result-text") = responseText(0).InnerText
            responseReader.Close()



            Server.Transfer("EE_Payments_S3.aspx")

        End If



        If Session("Timeout") Is Nothing Then
            ' MsgBox("Your Session has Timed out.  You will be redirected to the Login page to reenter your credentials", MsgBoxStyle.Exclamation, "Application Timeout")
            Session("Timeout") = True
            Response.Redirect("CorporateLogin.aspx")
        End If

        If Session("Admin") = False Then  'EMPLOYEE
            intCompanyId = Session("CompanyId")
            intEmpId = Session("EmployeeId")

            'btnAcceptCommit.Visible = False

        Else        ' ADMIN
            intCompanyId = Session("ShadowCompanyId")
            intEmpId = Session("ShadowEmployeeId")
            'btnAcceptCommit.Visible = False
        End If


        '''''''''''''''''''''''''''''''''''''''''''''
        ''  INITIAL LOAD AND BENEFIT TABS
        '''''''''''''''''''''''''''''''''''''''''''''
        If Page.IsPostBack = False Then
            'SecClass.SaveUserUpdate(Session("UserId"), "EE Accept", "Browse", intEmpId, 0, 0, "01/01/1900", intTransactionId)

            ScreenClass.ScreenSetup(intCompanyId, "Accept", Session("UserId"))
            LiteralTopMenu.Text = ScreenClass.BuildMenu(Session("Admin"), "EE_Accept")
            LiteralTab.Text = ScreenClass.BuildTabs(Session("Admin"), intEmpId, "EE_Accept", Session("Athena"))

            SetProgressBar()
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            ''              Main Article
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            If Not ScreenClass.MainArticleTitle Is Nothing Then
                lblMainArticleTitle.Text = ScreenClass.MainArticleTitle
            End If
            If Not ScreenClass.MainArticleText Is Nothing Then
                lblMainArticleText.Text = ScreenClass.MainArticleText
            End If
            ''''''''''''''''''''''''''''''''''''''''''''   
            ''  Side Menu Info-  Fill Benefit Summary
            ''''''''''''''''''''''''''''''''''''''''''''
            PlanClass.PopulatePendingBenefitSummary(intCompanyId, intEmpId, grdSummary)
            Dim booGotExistingElection As Boolean
            Session("dsExistingElection") = New DataSet
            booGotExistingElection = PlanClass.GetExisting(intCompanyId, intEmpId, Session("CurrentPlanTypeId"), Session("dsExistingElection"))
            If booGotExistingElection = True Then
                Dim dt As DataTable
                'Now go thru and reselect and covered Dependents
                dt = Session("dsExistingElection").tables(0)

                If Not dt.Rows(0)("TotalEECost") Is Nothing Then
                    lblSum.Text = Convert.ToDecimal(dt.Rows(0)("TotalEECost")).ToString("c")
                Else
                    lblSum.Text = "$0.00"
                End If
            End If
        End If

        ec.LoadState(ddlState)
        ec.LoadCountry(ddlCountry)

        SetEmployeePaymentData()

    End Sub

    Protected Sub SetProgressBar()
        ''  Populate progress bar
        Dim PercentageComplete As Integer
        Dim widthset As String

        PercentageComplete = PlanClass.GetPercentage(intCompanyId, intEmpId, Session("UserId"))
        widthset = PercentageComplete.ToString + "%"
        divProgressBar.Attributes.Add("aria-valuenow", PercentageComplete.ToString)
        divProgressBar.Style.Add("width", widthset)
        lblProgress.Text = PercentageComplete.ToString + "%"

    End Sub

    Protected Function SendXMLRequest(ByVal XMLRequest As XmlDocument) As String

        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12

        ServicePointManager.ServerCertificateValidationCallback = New RemoteCertificateValidationCallback(AddressOf CertValidation)

        Dim uri As String = "https://secure.retrievermedgateway.com/api/v2/three-step"
        Dim req As WebRequest = WebRequest.Create(uri)

        req.Method = "POST"

        req.ContentType = "text/xml"

        Dim writer As StreamWriter = New StreamWriter(req.GetRequestStream())

        XMLRequest.Save(writer)

        writer.Close()

        Dim rsp As WebResponse = req.GetResponse()
        Dim dataStream As Stream = rsp.GetResponseStream()
        Dim reader As StreamReader = New StreamReader(dataStream)
        Dim responseFromServer As String = reader.ReadToEnd()

        reader.Close()

        dataStream.Close()

        rsp.Close()

        Return responseFromServer
    End Function

    Private Function CertValidation(ByVal sender As Object, ByVal certificate As X509Certificate, ByVal chain As X509Chain, ByVal sslpolicyErrors As SslPolicyErrors) As Boolean
        Dim result As Boolean = False
        If (chain IsNot Nothing) AndAlso (chain.ChainStatus.Length = 1) AndAlso (chain.ChainStatus(0).Status = X509ChainStatusFlags.UntrustedRoot) Then result = True
        Return If(result, result, sslpolicyErrors = SslPolicyErrors.None)
    End Function

    Public Sub SetEmployeePaymentData()
        Dim ds As New DataSet

        ds = ec.GetEmployeePaymentData(Session("EmployeeId"))

        If Not IsNothing(ds.Tables(0)) Then
            If ds.Tables(0).Rows.Count > 0 Then
                With ds.Tables(0).Rows(0)
                    If Not IsNothing(.Item("FirstName")) Then
                        If Trim(.Item("FirstName")) <> "" Then
                            Me.txtFirstName.Text = Trim(.Item("FirstName"))
                        End If
                    End If

                    If Not IsNothing(.Item("LastName")) Then
                        If Trim(.Item("LastName")) <> "" Then
                            Me.txtLastName.Text = Trim(.Item("LastName"))
                        End If
                    End If

                    If Not IsNothing(.Item("Address1")) Then
                        If Trim(.Item("Address1")) <> "" Then
                            Me.txtAddress1.Text = Trim(.Item("Address1"))
                        End If
                    End If

                    If Not IsNothing(.Item("Address2")) Then
                        If Trim(.Item("Address2")) <> "" Then
                            Me.txtAddress2.Text = Trim(.Item("Address2"))
                        End If
                    End If

                    If Not IsNothing(.Item("City")) Then
                        If Trim(.Item("City")) <> "" Then
                            Me.txtCity.Text = Trim(.Item("City"))
                        End If
                    End If

                    If Not IsNothing(.Item("State")) Then
                        If Trim(.Item("State")) <> "" Then
                            Me.ddlState.SelectedValue = Trim(.Item("State"))
                        End If
                    End If

                    If Not IsNothing(.Item("Zip")) Then
                        If Trim(.Item("Zip")) <> "" Then
                            Me.txtZip.Text = Trim(.Item("Zip"))
                        End If
                    End If

                    If Not IsNothing(.Item("Email")) Then
                        If Trim(.Item("Email")) <> "" Then
                            Me.txtEmail.Text = Trim(.Item("Email"))
                        End If
                    End If

                    If Not IsNothing(.Item("Phone")) Then
                        If Trim(.Item("Phone")) <> "" Then
                            Dim strPhone As String = Trim(.Item("Phone"))

                            Me.txtPhone.Text = Mid(strPhone, 1, 3) & "-" & Mid(strPhone, 4, 3) & Mid(strPhone, 7, 4)
                        End If
                    End If

                    If Not IsNothing(.Item("Country")) Then
                        If Trim(.Item("Country")) <> "" Then
                            Me.ddlCountry.SelectedValue = .Item("Country")
                        End If
                    End If

                    If Not IsNothing(.Item("EECost")) Then
                        If Trim(.Item("EECost")) <> "" Then
                            EECost = Trim(.Item("EECost"))
                        End If
                    End If
                End With
            End If
        End If

        If Not IsNothing(ds) Then
            ds.Dispose()

            ds = Nothing
        End If
    End Sub

    Private Sub btnAccept_Click(sender As Object, e As ImageClickEventArgs) Handles btnAccept.Click
        Dim xmlRequest As XmlDocument = New XmlDocument()
        Dim xmlDecl As XmlDeclaration = xmlRequest.CreateXmlDeclaration("1.0", "UTF-8", "yes")
        Dim root As XmlElement = xmlRequest.DocumentElement

        xmlRequest.InsertBefore(xmlDecl, root)

        Dim xmlSale As XmlElement = xmlRequest.CreateElement("sale")
        Dim xmlApiKey As XmlElement = xmlRequest.CreateElement("api-key")

        xmlApiKey.InnerText = "eVg799r7xVMF5S44H7wPFW4fSw79RUA7"
        xmlSale.AppendChild(xmlApiKey)

        Dim xmlRedirectUrl As XmlElement = xmlRequest.CreateElement("redirect-url")
        xmlRedirectUrl.InnerText = Request.ServerVariables("HTTP_REFERER")
        xmlSale.AppendChild(xmlRedirectUrl)

        Dim xmlAmount As XmlElement = xmlRequest.CreateElement("amount")
        xmlAmount.InnerText = EECost  'txtTotalAmount.Text
        xmlSale.AppendChild(xmlAmount)

        Dim xmlRemoteAddr As XmlElement = xmlRequest.CreateElement("ip-address")
        xmlRemoteAddr.InnerText = Request.ServerVariables("REMOTE_ADDR")
        xmlSale.AppendChild(xmlRemoteAddr)

        Dim xmlCurrency As XmlElement = xmlRequest.CreateElement("currency")
        xmlCurrency.InnerText = "USD"
        xmlSale.AppendChild(xmlCurrency)

        Dim xmlOrderId As XmlElement = xmlRequest.CreateElement("order-id")
        xmlOrderId.InnerText = "1234"
        xmlSale.AppendChild(xmlOrderId)

        Dim xmlOrderDescription As XmlElement = xmlRequest.CreateElement("order-description")
        xmlOrderDescription.InnerText = "Small Order"
        xmlSale.AppendChild(xmlOrderDescription)

        Dim xmlMDF1 As XmlElement = xmlRequest.CreateElement("merchant-defined-field-1")
        xmlMDF1.InnerText = "Red"
        xmlSale.AppendChild(xmlMDF1)

        Dim xmlMDF2 As XmlElement = xmlRequest.CreateElement("merchant-defined-field-2")
        xmlMDF2.InnerText = "Medium"
        xmlSale.AppendChild(xmlMDF2)

        Dim xmlTax As XmlElement = xmlRequest.CreateElement("tax-amount")
        xmlTax.InnerText = "0.00"
        xmlSale.AppendChild(xmlTax)

        Dim xmlShipping As XmlElement = xmlRequest.CreateElement("shipping-amount")
        xmlShipping.InnerText = "0.00"
        xmlSale.AppendChild(xmlShipping)

        'If Not (txtCustomerVaultId.Text.Equals("") OrElse txtCustomerVaultId.Text.Equals("0"c)) Then
        '    Dim xmlCustomerVaultId As XmlElement = xmlRequest.CreateElement("customer-vault-id")
        '    xmlCustomerVaultId.InnerText = txtCustomerVaultId.Text
        '    xmlSale.AppendChild(xmlCustomerVaultId)
        'End If

        Dim xmlBillingAddress As XmlElement = xmlRequest.CreateElement("billing")
        Dim xmlFirstName As XmlElement = xmlRequest.CreateElement("first-name")
        xmlFirstName.InnerText = Me.txtFirstName.Text
        xmlBillingAddress.AppendChild(xmlFirstName)

        Dim xmlLastName As XmlElement = xmlRequest.CreateElement("last-name")
        xmlLastName.InnerText = Me.txtLastName.Text
        xmlBillingAddress.AppendChild(xmlLastName)

        Dim xmlAddress1 As XmlElement = xmlRequest.CreateElement("address1")
        xmlAddress1.InnerText = Me.txtAddress1.Text
        xmlBillingAddress.AppendChild(xmlAddress1)

        Dim xmlCity As XmlElement = xmlRequest.CreateElement("city")
        xmlCity.InnerText = Me.txtCity.Text
        xmlBillingAddress.AppendChild(xmlCity)

        Dim xmlState As XmlElement = xmlRequest.CreateElement("state")
        xmlState.InnerText = Me.ddlState.SelectedValue
        xmlBillingAddress.AppendChild(xmlState)

        Dim xmlZip As XmlElement = xmlRequest.CreateElement("postal")
        xmlZip.InnerText = Me.txtZip.Text
        xmlBillingAddress.AppendChild(xmlZip)

        Dim xmlCountry As XmlElement = xmlRequest.CreateElement("country")
        xmlCountry.InnerText = Me.ddlCountry.SelectedValue
        xmlBillingAddress.AppendChild(xmlCountry)

        Dim xmlPhone As XmlElement = xmlRequest.CreateElement("phone")
        xmlPhone.InnerText = Me.txtPhone.Text
        xmlBillingAddress.AppendChild(xmlPhone)

        Dim xmlCompany As XmlElement = xmlRequest.CreateElement("company")
        xmlCompany.InnerText = Session("CompanyName")
        xmlBillingAddress.AppendChild(xmlCompany)

        'Dim xmlAddress2 As XmlElement = xmlRequest.CreateElement("address2")
        'xmlAddress2.InnerText = txtBillingAddressAddress1.Text
        'xmlBillingAddress.AppendChild(xmlAddress2)

        Dim xmlFax As XmlElement = xmlRequest.CreateElement("fax")
        xmlFax.InnerText = ""
        xmlBillingAddress.AppendChild(xmlFax)
        xmlSale.AppendChild(xmlBillingAddress)

        Dim xmlShippingAddress As XmlElement = xmlRequest.CreateElement("shipping")

        'Dim xmlSFirstName As XmlElement = xmlRequest.CreateElement("first-name")
        'xmlSFirstName.InnerText = txtShippingAddressFirstName.Text
        'xmlShippingAddress.AppendChild(xmlSFirstName)

        'Dim xmlSLastName As XmlElement = xmlRequest.CreateElement("last-name")
        'xmlSLastName.InnerText = txtShippingAddressLastName.Text
        'xmlShippingAddress.AppendChild(xmlSLastName)

        'Dim xmlSAddress1 As XmlElement = xmlRequest.CreateElement("address1")
        'xmlSAddress1.InnerText = txtShippingAddressAddress1.Text
        'xmlShippingAddress.AppendChild(xmlSAddress1)

        'Dim xmlSCity As XmlElement = xmlRequest.CreateElement("city")
        'xmlSCity.InnerText = txtShippingAddressCity.Text
        'xmlShippingAddress.AppendChild(xmlSCity)

        'Dim xmlSState As XmlElement = xmlRequest.CreateElement("state")
        'xmlSState.InnerText = txtShippingAddressState.Text
        'xmlShippingAddress.AppendChild(xmlSState)

        'Dim xmlSZip As XmlElement = xmlRequest.CreateElement("postal")
        'xmlSZip.InnerText = txtShippingAddressZip.Text
        'xmlShippingAddress.AppendChild(xmlSZip)

        'Dim xmlSCountry As XmlElement = xmlRequest.CreateElement("country")
        'xmlSCountry.InnerText = txtShippingAddressCountry.Text
        'xmlShippingAddress.AppendChild(xmlSCountry)

        'Dim xmlSPhone As XmlElement = xmlRequest.CreateElement("phone")
        'xmlSPhone.InnerText = txtShippingAddressPhone.Text
        'xmlShippingAddress.AppendChild(xmlSPhone)

        'Dim xmlSCompany As XmlElement = xmlRequest.CreateElement("company")
        'xmlSCompany.InnerText = ""
        'xmlShippingAddress.AppendChild(xmlSCompany)

        'Dim xmlSAddress2 As XmlElement = xmlRequest.CreateElement("address2")
        'xmlSAddress2.InnerText = txtShippingAddressAddress1.Text
        'xmlShippingAddress.AppendChild(xmlSAddress2)

        'Dim xmlSFax As XmlElement = xmlRequest.CreateElement("fax")
        'xmlFax.InnerText = ""
        'xmlShippingAddress.AppendChild(xmlSFax)
        'xmlSale.AppendChild(xmlShippingAddress)

        'Dim xmlProduct As XmlElement = xmlRequest.CreateElement("product")
        'Dim xmlSku As XmlElement = xmlRequest.CreateElement("product-code")
        'xmlSku.InnerText = "SKU-123456"
        'xmlProduct.AppendChild(xmlSku)

        'Dim xmlDescription As XmlElement = xmlRequest.CreateElement("description")
        'xmlDescription.InnerText = "Books"
        'xmlProduct.AppendChild(xmlDescription)

        'Dim xmlQuantity As XmlElement = xmlRequest.CreateElement("quantity")
        'xmlQuantity.InnerText = "1"
        'xmlProduct.AppendChild(xmlQuantity)

        'Dim xmlUnit As XmlElement = xmlRequest.CreateElement("unit-of-measure")
        'xmlUnit.InnerText = "1"
        'xmlProduct.AppendChild(xmlUnit)

        'Dim xmlUnitAmount As XmlElement = xmlRequest.CreateElement("total-amount")
        'xmlUnitAmount.InnerText = "1"
        'xmlProduct.AppendChild(xmlUnitAmount)

        'Dim xmlUnitDiscount As XmlElement = xmlRequest.CreateElement("discount-amount")
        'xmlUnitDiscount.InnerText = "0.00"
        'xmlProduct.AppendChild(xmlUnitDiscount)

        'Dim xmlUnitTax As XmlElement = xmlRequest.CreateElement("tax-amount")
        'xmlUnitTax.InnerText = "0.00"
        'xmlProduct.AppendChild(xmlUnitTax)

        'Dim xmlTaxRate As XmlElement = xmlRequest.CreateElement("tax-rate")
        'xmlTaxRate.InnerText = "0.01"
        'xmlProduct.AppendChild(xmlTaxRate)
        'xmlSale.AppendChild(xmlProduct)

        'Dim xmlProduct2 As XmlElement = xmlRequest.CreateElement("product")
        'Dim xmlSku2 As XmlElement = xmlRequest.CreateElement("product-code")
        'xmlSku2.InnerText = "SKU-654321"
        'xmlProduct2.AppendChild(xmlSku2)

        'Dim xmlDescription2 As XmlElement = xmlRequest.CreateElement("description")
        'xmlDescription2.InnerText = "Videos"
        'xmlProduct2.AppendChild(xmlDescription2)

        'Dim xmlQuantity2 As XmlElement = xmlRequest.CreateElement("quantity")
        'xmlQuantity2.InnerText = "1"
        'xmlProduct2.AppendChild(xmlQuantity2)

        'Dim xmlUnit2 As XmlElement = xmlRequest.CreateElement("unit-of-measure")
        'xmlUnit2.InnerText = ""
        'xmlProduct2.AppendChild(xmlUnit2)

        'Dim xmlUnitAmount2 As XmlElement = xmlRequest.CreateElement("total-amount")
        'xmlUnitAmount2.InnerText = "2"
        'xmlProduct2.AppendChild(xmlUnitAmount2)

        'Dim xmlUnitDiscount2 As XmlElement = xmlRequest.CreateElement("discount-amount")
        'xmlUnitDiscount2.InnerText = "0.00"
        'xmlProduct2.AppendChild(xmlUnitDiscount2)

        'Dim xmlUnitTax2 As XmlElement = xmlRequest.CreateElement("tax-amount")
        'xmlUnitTax2.InnerText = "0.00"
        'xmlProduct2.AppendChild(xmlUnitTax2)

        'Dim xmlTaxRate2 As XmlElement = xmlRequest.CreateElement("tax-rate")
        'xmlTaxRate2.InnerText = "0.01"
        'xmlProduct2.AppendChild(xmlTaxRate2)
        'xmlSale.AppendChild(xmlProduct2)

        xmlRequest.AppendChild(xmlSale)

        Dim responseFromServer As String = Me.SendXMLRequest(xmlRequest)
        Dim responseReader As XmlReader = XmlReader.Create(New StringReader(responseFromServer))
        Dim xDoc As XmlDocument = New XmlDocument()
        xDoc.Load(responseReader)

        Dim response As XmlNodeList = xDoc.GetElementsByTagName("result")

        If response(0).InnerText.Equals("1") Then
            Dim formUrl As XmlNodeList = xDoc.GetElementsByTagName("form-url")
            Session("formURL") = ""
            Session("formURL") = formUrl(0).InnerText
            responseReader.Close()
            Server.Transfer("EE_Payments_S2.aspx")
        End If
    End Sub

End Class