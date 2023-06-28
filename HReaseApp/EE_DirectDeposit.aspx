 <%@Page Title="Direct Deposit Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_DirectDeposit.aspx.vb" 
    Inherits="HReaseApp.EE_DirectDeposit" 
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>   
    </div>     
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" Runat="Server">  
    <style>
        @media only screen and (max-width: 479px) {
            .element {
            display: none;
            }
            #imgSuccess{
                display:none !important;
            }
            #divSuccessLabel{
                display:none !important;
            }
            .well{
                width:99% !important;
                margin-right:auto !important;
                margin-left:auto !important;
            }
            .HREwrapper{
                width:98% !important;
                margin:auto !important;
            }
            #imgNext{
                float:right !important;
                margin:auto !important;
            }
        }
    </style>

    <script type="text/javascript">

        // This function will allow users to insert only numbers in the textboxes.

        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
         }
    </script>

    <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>Direct Deposit Form</b></h4>
            </div>
        </div>
        
        <div id="divTopHeader" class="form-group">                  
            <div id="divError" runat="server" visible ="false" style="vertical-align:middle; display:inline; padding-left:50px;">
                <div style="float:left;">
                    <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="50px" />
                </div>
                <br /><br />
                <div id="divErrorLabel" style="text-align:left; color:red; font-size:large; padding-left:20px;">
                    <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
                </div>
            </div>
            <div id="divSuccess" runat="server" visible ="false" style="vertical-align:middle; display:inline; padding-left:50px;">
                <div style="float:left;">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" />
                </div>
                <div id="divSuccessLabel" style="text-align:center; color:green; font-size:x-large;">
                    <b><asp:Label ID="lblSuccess" runat="server" Text="Form Complete"></asp:Label></b>
                </div>
                <div id="divNextButton" style="float:right; margin-top:-3%;" >
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" Width="50%" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                </div>
            </div>
            <div id="divProcessing" runat="server" visible="false">
                <div class="fixed">
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Width="100%" />
                </div>
            </div>
        </div> 

        <div id="divMainArticalTitleandText" runat="server" class="well HRESlateBlue">
            <div id="divTitle" runat="server" class="form-group HRESlateBlue">
                    <h4><asp:Label ID="lblMainArticleTitle" runat="server" Text=""></asp:Label></h4>           
            </div>
            <div id="divText" runat="server" class="form-group HREWhite" >
                    <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div>
      
        <div id="divElectYN" class="well HRETan" runat="server">
            <div class="form-group" style="text-align:left;">
                <div class="col-xs-8 col-sm-8 col-md-6 left">
                    <label style="font-size:16pt;"><b>I Elect to use Direct Deposit:</b></label>
                </div>
            </div>
            <div class="row" style="text-align:center;">
                <div>
                    <asp:CheckBox ID="chkYes" runat="server" Text="&nbsp; Yes &nbsp;" AutoPostBack="true" OnCheckedChanged="chkYes_CheckedChanged"/>
                    <asp:CheckBox ID="chkNo" runat="server" Text="&nbsp; No" AutoPostBack="true" OnCheckedChanged="chkNo_CheckedChanged"/>
                </div>
            </div>
        </div>
        <div id="divBank1" class="well HREWhite " runat="server" >
            <table style="border:hidden; background-color:white;">
              <tr>
                  <td style="width:20%;"></td>
                  <td style="width:20%;"></td>
                  <td style="width:60%;"></td>
              </tr>
            <tr>
                <td colspan="2">
                    <h4>Direct Deposit Information #1</h4>
                </td>
                <td colspan="1" style="float:right; padding-right:7%;">
                    <asp:ImageButton ID="btnClear" runat="server" ImageUrl="img/GreenClear.png" OnMouseOver="src='/img/GreenClearOver.png';" OnMouseOut="src='/img/GreenClear.png';" OnClick="btnClear_Click" />
                </td>
            
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtBankName" class="control-label" style="float:right; padding:10px;">Bank Name:</label>
                </td>
                <td colspan="1" >
                    <asp:TextBox ID="txtBankName" runat="server" CssClass="form-control" TabIndex="1" Width="170px"></asp:TextBox>
                </td>
                <td colspan ="1" rowspan="4">
                    <asp:Image ID="imgCheck" ImageUrl="../img/Bank_Check.gif" runat="server" CssClass="element" Width="50%" />
                    <br />
                    <br />
                </td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtRoutingNumber" class="control-label" style="float:right; margin:10px;">Routing Number:</label>
                </td>
                <td colspan="1">
                    <asp:TextBox ID="txtRoutingNumber" runat="server" CssClass="form-control" TabIndex="2" Width="170px" oncopy="return false;" Placeholder="Nine Digits"></asp:TextBox>
                    <asp:TextBox ID="txtRoutingNumberVerify" runat="server" CssClass="form-control" TabIndex="3" Width="170px" onpaste="return false;" Placeholder="Re-enter" ToolTip=" Confirm Routing Number " />
                </td>
                <td colspan="1">
                </td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtAccountNumber" class="control-label" style="float:right; margin:10px;">Account Number:</label>
                </td>
                <td colspan="1">
                    <asp:TextBox ID="txtAccountNumber" runat="server" CssClass="form-control" TabIndex="4" Width="170px" oncopy="return false;"></asp:TextBox>
                    <asp:TextBox ID="txtAccountNumberVerify" runat="server" CssClass="form-control" TabIndex="5" Width="170px" onpaste="return false;" Placeholder="Re-enter" Tooltip=" Confirm Account Number " />
                </td>
                <td colspan="1">
                </td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="ddlAccountType" class="control-label" style="float:right; margin:10px;"> Account Type:</label>
                </td>
                <td colspan="1">
                    <asp:DropDownList ID="ddlAccountType" runat="server" style="font-size:10pt; width:auto;" TabIndex="6">
                        <asp:ListItem Text=" Checking Account " Value="1"></asp:ListItem>
                        <asp:ListItem Text=" Savings Account " Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td colspan="1"></td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="ddlAmountType" class="control-label" style="float:right; margin:10px;">Amount Type:</label>
                </td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlAmountType" runat="server" style="font-size:10pt; width:auto;" TabIndex="7">
                        <asp:ListItem Text="$" Value="1"></asp:ListItem> 
                        <asp:ListItem Text="%" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;<b>$:</b> Used for a flat dollar amount, <b>%:</b> Used for a percentage of your pay into this account
                </td>
              
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtAmount" class="control-label" style="float:right; margin:10px;">Amount:</label>
                </td>
                <td colspan="1">
                    <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" TabIndex="8" Width="100px" onkeypress="return onlyNumbers();"></asp:TextBox>
                </td>
                <td colspan="1"></td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="ddlPriority" class="control-label" style="float:right; margin:10px;">Priority:</label>
                </td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlPriority" runat="server" TabIndex="9" style="font-size:10pt; width:auto;">
                        <asp:ListItem Text="#1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="#2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="#3" Value="3"></asp:ListItem>
                        <asp:ListItem Text="#4" Value="4"></asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;&nbsp;<b>#:</b> Used to determine the order in which to allocate funds to each bank account.
                </td>
            </tr>
        </table>
        </div>
       
        <div id="divBank2" class="well HREWhite" runat="server" >
          <table style="border:hidden; background-color:white;">
              <tr>
                  <td style="width:20%;"></td>
                  <td style="width:20%;"></td>
                  <td style="width:60%;"></td>
              </tr>
            <tr>
                <td colspan="2">
                    <h4>Direct Deposit Information #2</h4>
                </td>
                <td colspan="1" style="float:right; padding-right:7%;">
                    <asp:ImageButton ID="btnClear2" runat="server" ImageUrl="img/GreenClear.png" OnMouseOver="src='/img/GreenClearOver.png';" OnMouseOut="src='/img/GreenClear.png';" ImageAlign="Right" OnClick="btnClear2_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtBankName2" class="control-label" style="float:right; margin:10px;">Bank Name:</label>
                </td>
                <td colspan="2" >
                    <asp:TextBox ID="txtBankName2" runat="server" CssClass="form-control" TabIndex="11" Width="170px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtRoutingNumber2" class="control-label" style="float:right; margin:10px;">Routing Number:</label>
                </td>
                <td colspan="1">
                    <asp:TextBox ID="txtRoutingNumber2" runat="server" CssClass="form-control" TabIndex="12" Width="170px" oncopy="return false;" Placeholder="Nine Digits"></asp:TextBox>
                    <asp:TextBox ID="txtRoutingNumberVerify2" runat="server" CssClass="form-control" TabIndex="13" Width="170px" onpaste="return false;" Placeholder="Re-enter" ToolTip=" Confirm Routing Number " />
                </td>
                <td colspan="1">
                </td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtAccountNumber2" class="control-label" style="float:right; margin:10px;">Account Number:</label>
                </td>
                <td colspan="1">
                    <asp:TextBox ID="txtAccountNumber2" runat="server" CssClass="form-control" TabIndex="14" Width="170px" oncopy="return false;"></asp:TextBox>
                    <asp:TextBox ID="txtAccountNumberVerify2" runat="server" CssClass="form-control" TabIndex="15" Width="170px" onpaste="return false;" Placeholder="Re-enter" Tooltip=" Confirm Account Number " />
                </td>
                <td colspan="1">
                </td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="ddlAccountType2" class="control-label" style="float:right; margin:10px;"> Account Type:</label>
                </td>
                <td colspan="1">
                    <asp:DropDownList ID="ddlAccountType2" runat="server" style="font-size:10pt; width:auto;" TabIndex="16">
                        <asp:ListItem Text=" Checking Account " Value="1"></asp:ListItem>
                        <asp:ListItem Text=" Savings Account " Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td colspan="1"></td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="ddlAmountType2" class="control-label" style="float:right; margin:10px;">Amount Type:</label>
                </td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlAmountType2" runat="server" style="font-size:10pt; width:auto;" TabIndex="17">
                        <asp:ListItem Text="$" Value="1"></asp:ListItem> 
                        <asp:ListItem Text="%" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
              
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtAmount2" class="control-label" style="float:right; margin:10px;">Amount:</label>
                </td>
                <td colspan="1">
                    <asp:TextBox ID="txtAmount2" runat="server" CssClass="form-control" TabIndex="18" Width="100px" onkeypress="return onlyNumbers();"></asp:TextBox>
                </td>
                <td colspan="1"></td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="ddlPriority2" class="control-label" style="float:right; margin:10px;">Priority:</label>
                </td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlPriority2" runat="server" TabIndex="19" style="font-size:10pt; width:auto;">
                        <asp:ListItem Text="#1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="#2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="#3" Value="3"></asp:ListItem>
                        <asp:ListItem Text="#4" Value="4"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
        
    </div>
      
        <div id="divBank3" class="well HREWhite" runat="server" >
            <table style="border:hidden; background-color:white;">
              <tr>
                  <td style="width:20%;"></td>
                  <td style="width:20%;"></td>
                  <td style="width:60%;"></td>
              </tr>
            <tr>
                <td colspan="2">
                    <h4>Direct Deposit Information #3</h4>
                </td>
                <td colspan="1" style="float:right; padding-right:7%;">
                    <asp:ImageButton ID="btnClear3" runat="server" ImageUrl="img/GreenClear.png" OnMouseOver="src='/img/GreenClearOver.png';" OnMouseOut="src='/img/GreenClear.png';" ImageAlign="Right" OnClick="btnClear3_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtBankName3" class="control-label" style="float:right; margin:10px;">Bank Name:</label>
                </td>
                <td colspan="2" >
                    <asp:TextBox ID="txtBankName3" runat="server" CssClass="form-control" TabIndex="21" Width="170px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtRoutingNumber3" class="control-label" style="float:right; margin:10px;">Routing Number:</label>
                </td>
                <td colspan="1">
                    <asp:TextBox ID="txtRoutingNumber3" runat="server" CssClass="form-control" TabIndex="22" Width="170px" oncopy="return false;" Placeholder="Nine Digits"></asp:TextBox>
                    <asp:TextBox ID="txtRoutingNumberVerify3" runat="server" CssClass="form-control" TabIndex="23" Width="170px" onpaste="return false;" Placeholder="Re-enter" ToolTip=" Confirm Routing Number " />
                </td>
                <td colspan="1">
                </td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtAccountNumber3" class="control-label" style="float:right; margin:10px;">Account Number:</label>
                </td>
                <td colspan="1">
                    <asp:TextBox ID="txtAccountNumber3" runat="server" CssClass="form-control" TabIndex="24" Width="170px" oncopy="return false;"></asp:TextBox>
                    <asp:TextBox ID="txtAccountNumberVerify3" runat="server" CssClass="form-control" TabIndex="25" Width="170px" onpaste="return false;" Placeholder="Re-enter" Tooltip=" Confirm Account Number " />
                </td>
                <td colspan="1">
                </td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="ddlAccountType3" class="control-label" style="float:right; margin:10px;"> Account Type:</label>
                </td>
                <td colspan="1">
                    <asp:DropDownList ID="ddlAccountType3" runat="server" style="font-size:10pt; width:auto;" TabIndex="26">
                        <asp:ListItem Text=" Checking Account " Value="1"></asp:ListItem>
                        <asp:ListItem Text=" Savings Account " Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td colspan="1"></td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="ddlAmountType3" class="control-label" style="float:right; margin:10px;">Amount Type:</label>
                </td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlAmountType3" runat="server" style="font-size:10pt; width:auto;" TabIndex="27">
                        <asp:ListItem Text="$" Value="1"></asp:ListItem> 
                        <asp:ListItem Text="%" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
              
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtAmount3" class="control-label" style="float:right; margin:10px;">Amount:</label>
                </td>
                <td colspan="1">
                    <asp:TextBox ID="txtAmount3" runat="server" CssClass="form-control" TabIndex="28" Width="100px" onkeypress="return onlyNumbers();"></asp:TextBox>
                </td>
                <td colspan="1"></td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="ddlPriority3" class="control-label" style="float:right; margin:10px;">Priority:</label>
                </td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlPriority3" runat="server" TabIndex="29" style="font-size:10pt; width:auto;">
                        <asp:ListItem Text="#1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="#2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="#3" Value="3"></asp:ListItem>
                        <asp:ListItem Text="#4" Value="4"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
        </div>

      	<div id="divBank4" class="well HREWhite" runat="server">
            <table style="border:hidden; background-color:white;">
              <tr>
                  <td style="width:20%;"></td>
                  <td style="width:20%;"></td>
                  <td style="width:60%;"></td>
              </tr>
            <tr>
                <td colspan="2">
                    <h4>Direct Deposit Information #4</h4>
                </td>
                <td colspan="1" style="float:right; padding-right:7%;">
                    <asp:ImageButton ID="btnClear4" runat="server" ImageUrl="img/GreenClear.png" OnMouseOver="src='/img/GreenClearOver.png';" OnMouseOut="src='/img/GreenClear.png';" ImageAlign="Right" OnClick="btnClear4_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtBankName4" class="control-label" style="float:right; margin:10px;">Bank Name:</label>
                </td>
                <td colspan="2" >
                    <asp:TextBox ID="txtBankName4" runat="server" CssClass="form-control" TabIndex="31" Width="170px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtRoutingNumber4" class="control-label" style="float:right; margin:10px;">Routing Number:</label>
                </td>
                <td colspan="1">
                    <asp:TextBox ID="txtRoutingNumber4" runat="server" CssClass="form-control" TabIndex="32" Width="170px" oncopy="return false;" Placeholder="Nine Digits"></asp:TextBox>
                    <asp:TextBox ID="txtRoutingNumberVerify4" runat="server" CssClass="form-control" TabIndex="33" Width="170px" onpaste="return false;" Placeholder="Re-enter" ToolTip=" Confirm Routing Number " />
                </td>
                <td colspan="1">
                </td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtAccountNumber4" class="control-label" style="float:right; margin:10px;">Account Number:</label>
                </td>
                <td colspan="1">
                    <asp:TextBox ID="txtAccountNumber4" runat="server" CssClass="form-control" TabIndex="34" Width="170px" oncopy="return false;"></asp:TextBox>
                    <asp:TextBox ID="txtAccountNumberVerify4" runat="server" CssClass="form-control" TabIndex="35" Width="170px" onpaste="return false;" Placeholder="Re-enter" Tooltip=" Confirm Account Number " />
                </td>
                <td colspan="1">
                </td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="ddlAccountType4" class="control-label" style="float:right; margin:10px;"> Account Type:</label>
                </td>
                <td colspan="1">
                    <asp:DropDownList ID="ddlAccountType4" runat="server" style="font-size:10pt; width:auto;" TabIndex="36">
                        <asp:ListItem Text=" Checking Account " Value="1"></asp:ListItem>
                        <asp:ListItem Text=" Savings Account " Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td colspan="1"></td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="ddlAmountType4" class="control-label" style="float:right; margin:10px;">Amount Type:</label>
                </td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlAmountType4" runat="server" style="font-size:10pt; width:auto;" TabIndex="37">
                        <asp:ListItem Text="$" Value="1"></asp:ListItem> 
                        <asp:ListItem Text="%" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
              
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="txtAmount4" class="control-label" style="float:right; margin:10px;">Amount:</label>
                </td>
                <td colspan="1">
                    <asp:TextBox ID="txtAmount4" runat="server" CssClass="form-control" TabIndex="38" Width="100px" onkeypress="return onlyNumbers();"></asp:TextBox>
                </td>
                <td colspan="1"></td>
            </tr>
            <tr>
                <td colspan="1" >
                    <label for="ddlPriority4" class="control-label" style="float:right; margin:10px;">Priority:</label>
                </td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlPriority4" runat="server" TabIndex="39" style="font-size:10pt; width:auto;">
                        <asp:ListItem Text="#1" Value="1"></asp:ListItem>
                        <asp:ListItem Text="#2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="#3" Value="3"></asp:ListItem>
                        <asp:ListItem Text="#4" Value="4"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
        </div>

        <div id ="divAdditionalAccounts" class="well HRELightBlue" runat="server" >
            <span>Add Other Accounts</span> 
            <span style="float: right; padding-right:2%;"><img id="instruction_btn" src="img/plus.png" class="instruction_toggle_btn" style="width: 30px;"  />
            </span>
            <br /> <br />
        </div>

        <div style="float:right; margin-right:7%;">
            <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" OnClick="btnSave_Click" />
         </div>
          
    </div>

 <script>

        var toggleIsHide = true;

        $(".instruction_toggle").hide();
        $(".chart_toggle").hide();
        $(".instruction_toggle_btn").click(function () {
            if (toggleIsHide == true) {
                $(this).attr("src", "img/minus.png");
            } else {
                $(this).attr("src", "img/plus.png")
            }
            $(".instruction_toggle").toggle();
            toggleIsHide = !toggleIsHide;
        });

        $(".chart_toggle_btn").click(function () {
            if (toggleIsHide == true) {
                $(this).attr("src", "img/minus.png");
            } else {
                $(this).attr("src", "img/plus.png")
            }
            $(".chart_toggle").toggle();
        });

    </script>
    <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px 10px 10px 10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HRENext {padding:5px 5px 5px 5px; float:right; min-width:50px; max-width:90px; }
        .img {display: inline-block; width: auto; height: auto;}
    </style>
</asp:Content>

