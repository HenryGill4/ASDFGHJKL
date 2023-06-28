<%@ Page Language="vb" AutoEventWireup="true" CodeBehind="EE_Payments_S2.aspx.vb" Inherits="HReaseApp.EE_Payments_S2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
     <form id="form3"  runat="server" action="EE_Payments_S2.aspx" >
                        <a class="logo hidden-xs hidden-sm" href="Corporate/CorporateHome.aspx">
                            <img src="/images/hrease-01.png" width="270" alt="HR Ease" />
                        </a>
       
            <h2>Please enter your Payment Information then click Submit<br /></h2>

            <h3> Payment Information</h3>
            

              <table>
                  <tr><td>Credit Card Number  </td><td><asp:TextBox ID="cc_number" name="cc_number" runat="server" ></asp:TextBox></td></tr>
                  <tr><td>Expiration Date</td><td><asp:TextBox ID="cc_exp"  name="cc_exp" runat="server"></asp:TextBox> </td></tr>
                  <tr><td>CVV </td><td><asp:TextBox ID="cvv" name="cvv" runat="server"> </asp:TextBox></td></tr>
                  <tr><td colspan="2">&nbsp;</td></tr>
                  <tr><td colspan="2" style="text-align:center;"><asp:Button   runat="server"    Text="Submit"
                           ID="submitStepTwo"></asp:Button> </td></tr>
              </table>
          
        </form>
        
</body>
</html>
