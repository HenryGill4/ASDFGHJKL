Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

'<response>
'<result>1</result>
'  <result-text>SUCCESS</result-text>
'  <transaction-id>4261992238</transaction-id>
'  <result-code>100</result-code>
'  <authorization-code>123456</authorization-code>
'  <avs-result>N</avs-result>
'  <cvv-result>M</cvv-result>
'  <Action-type>sale</action-type>
'  <amount>3.33</amount>
'  <amount-authorized>3.33</amount-authorized>
'  <tip-amount>0.00</tip-amount>
'  <surcharge-amount>0.00</surcharge-amount>
'  <ip-address>:1</ip-address>
'  <industry> ecommerce</industry>
'  <processor-id>ccprocessora</processor-id>
'  <Currency> USD</currency>
'  <order-description>Small Order</order-description>
'  <merchant-defined-field-1>Red</merchant-defined-field-1>
'  <merchant-defined-field-2>Medium</merchant-defined-field-2>
'  <order-id>1234</order-id>
'  <tax-amount>0.00</tax-amount>
'  <shipping-amount>0.00</shipping-amount>
'  <billing>
'<first-name> John</first-name>
'    <last-name>Smith</last-name>
'    <address1>1234 Main St.</address1>
'    <city> Beverly Hills</city>
'    <state> CA</state>
'    <postal>90210</postal>
'    <country> US</country>
'    <phone>555-555-5555</phone>
'    <Company> Acme, Inc.</company>
'    <address2>1234 Main St.</address2>
'    <cc-number>411111******1111</cc-number>
'    <cc-exp>1025</cc-exp>
'  </billing>
'</response>

Public Class EE_Payments_S3
    Inherits System.Web.UI.Page

    Dim PlanClass As New Plans

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        Dim srXmlData As New System.IO.StringReader(Session("data"))
        Dim ds As New DataSet
        ds.ReadXml(srXmlData)

        'Uncomment to view the XML Response
        'LabelResponse.Text = Server.HtmlEncode(Session("data").ToString())

        If Not IsNothing(ds.Tables("response")) Then
            If ds.Tables("response").Rows.Count > 0 Then
                With ds.Tables("response").Rows(0)
                    Select Case .Item("Result")

                        Case "1"
                            Dim TransactionId As String = Nothing
                            Dim TransactionAmount As String = Nothing
                            Dim BillingName As String = Nothing
                            Dim CCNumber As String = Nothing

                            PlanClass.AcceptCoverages(Session("EmployeeId"), Session("UserId"))

                            divFail.Visible = False

                            'Response.AddHeader("REFRESH", "3;URL=EE_Welcome.aspx")


                            lblMainArticleText.Text = "Transaction was Approved."

                            TransactionId = .Item("transaction-id") & Environment.NewLine
                            TransactionAmount = Convert.ToDecimal(.Item("amount")).ToString("c")

                            If Not IsNothing(ds.Tables("billing")) Then
                                If ds.Tables("billing").Rows.Count > 0 Then
                                    BillingName = ds.Tables("billing").Rows(0).Item("first-name") & Space(1) & ds.Tables("billing").Rows(0).Item("last-name")
                                    CCNumber = "************" & Right(ds.Tables("billing").Rows(0).Item("cc-number").ToString.Trim, 4)
                                End If
                            End If

                            PlanClass.SaveEmployeePaymentProcess(Session("EmployeeId"), BillingName, TransactionId, TransactionAmount, CCNumber, Session("EventDate"), Session("UserId"))

                            LabelResponseText.Text = "Billing Name:  " & BillingName & Environment.NewLine
                            LabelResponseText.Text &= "Transaction Id:  " & TransactionId & Environment.NewLine
                            LabelResponseText.Text &= "Credit Card Number:  " & CCNumber & Environment.NewLine
                            LabelResponseText.Text &= "Billed Amount:  " & TransactionAmount & Environment.NewLine

                        Case Else
                            lblMainArticleText.Text = "Transaction caused an Error" & Environment.NewLine & Environment.NewLine &
                                   "Error returned was:  " & .Item("result-text")
                    End Select
                End With
            End If
        End If





        'If Not Session("result").Equals("1") Then
        '    LabelResponseText.Text = CStr(Session("result-text"))
        'Else
        '    LabelResponseText.Text = ""
        'End If

        If Not IsNothing(ds) Then
            ds.Dispose()

            ds = Nothing
        End If
    End Sub

    Private Sub btnReturn_Click(sender As Object, e As EventArgs) Handles btnReturn.Click
        Server.Transfer("EE_Welcome.aspx")
    End Sub
End Class