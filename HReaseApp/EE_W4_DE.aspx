<%@ Page Title="Employee State WH Form DE" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_DE.aspx.vb" 
    Inherits="HReaseApp.EE_W4_DE" 
    MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" runat="Server">
    <div id="tabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>
    </div>
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" runat="Server">
    <script type="text/javascript">
        // This function will allow users to insert only numbers in the textboxes.
        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
         if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
             return false;
         else {
             var len = document.getElementById("txtChar").value.length;
             var index = document.getElementById("txtChar").value.indexOf('.');
             
             if (index > 0 && charCode == 46) {
                 return false;
             }
             if (index > 0) {
                 var CharAfterdot = (len + 1) - index;
                 if (CharAfterdot > 3) {
                     return false;
                 }
             }

         }
         return true;
        }

        $(function () {
            var BoxA = $('input:text[id$=txtResBoxA]').keyup(foo);
            var BoxB = $('input:text[id$=txtResBoxB]').keyup(foo);
            var BoxC = $('input:text[id$=txtResBoxC]').keyup(foo);
            var BoxD = $('input:text[id$=txtResBoxD]').keyup(foo);
            var BoxE = $('input:text[id$=txtResBoxE]').keyup(foo);
            var BoxF = $('input:text[id$=txtResBoxF]').keyup(foo);
              
            $('input:text[id$=hdnPW]').val(document.getElementById('divResPW').childNodes[1].innerHTML);

            function foo() {
                var a = BoxA.val();
                var b = BoxB.val();
                var c = BoxC.val();
                var d = BoxD.val();
                var e = BoxE.val();
                var f = BoxF.val();
                
                var sum = add(a, b, c, d, e, f);
                $('input:text[id$=txtResBoxG]').val(sum);
                
            }

            function add() {
                var sum = 0;
                for (var i = 0, j = arguments.length; i < j; i++) {
                    if (IsNumeric(arguments[i])) {
                        sum += parseFloat(arguments[i]);
                    }
                }
                return sum;
            }
            function IsNumeric(input) {
                return (input - 0) == input && input.length > 0;
            }
        });

      function makeMoney(source){
          //Grab the value from the element
          var money = parseFloat(source.value,10).toFixed(2);
      
          //Format your value
          source.value = money.toString();
        }

        $(function () {
            var textBoxG = $('input:text[id$=txtResBoxG]').keyup(foo);
            
            function foo() {
                var boxA = txtResBoxA.val();
                var boxB = txtResBoxB.val();
                var boxC = txtResBoxC.val();
                var boxD = txtResBoxD.val();
                var boxE = txtResBoxE.val();
                var boxF = txtResBoxF.val();
               
                var sum = add(boxA, boxB, boxC, boxD, boxE, boxF);
                $('input:text[id$=txtResBoxG]').val(sum);
            }

            function add() {
                var sum = 0;
                for (var i = 0, j = arguments.length; i < j; i++) {
                    if (IsNumeric(arguments[i])) {
                        sum += parseFloat(arguments[i]);
                    }
                }
                return sum;
            }
            function IsNumeric(input) {
                return (input - 0) == input && input.length > 0;
            }
        });
 
    </script>

    <style>
        input[type="checkbox"] {
		width: 20px;
		height: 20px;
        background: #EFF3FB;
		}

        input[type="text"] {		
        background: #EFF3FB;
        border: 0px;
        padding:1px 1px 1px 1px;
        margin: 1px 1px 1px 1px;
        height:30px;
        text-align:center;
		}

        td.dots-after:after {
            clip: rect(0px, 700px, 20px, 20px);
            content: " ................................................................................................................................................................................................................................................................................................................................... ";
            position: absolute;
            float:left;
            z-index: -1;
            flex-shrink: 0;
        }
        p{color:black}

        .underline {
            border-bottom: 1px solid !important;
            width: 100%;
            display: inline-block;
        }

        table {
            background-color:white;
        }
                  
        .wrapper {
	    margin-right:10%;
	    overflow:hidden;
        padding:20px;
        }
    </style>

    <div class="HREwrapper">
        <div class="form-group" style="height:100px;">       
            <div style="float:left;">
            <br />
            <h4><asp:Label ID="lblEmployeeName" runat="server"></asp:Label></h4> 
            </div>
            <div id="divError" class="form-group alert alert-danger text-center text-danger divError" runat="server" visible="false">
                <div style="font-size:large; text-align:center;">
                    <asp:Image ID="Image1" ImageUrl="../img/RedX.png" runat="server" style="width:90px" border="none" /> 
                    <br/>
                    <h4>ERROR:
                    <asp:Label ID="lblError" runat="server" Text="There was an error.<br/>"></asp:Label></h4>
                </div>
            </div>
            <div id="divSuccess" runat="server" class="col-md-12 text-center"  visible ="false">
                <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" cssclass=" img" />
                <h3><br /><b><span style="color: green">
                <asp:Label ID="lblSuccess" runat="server" Text="Delaware State Tax Form Complete.<br/>"></asp:Label>
                </span></b></h3>
            </div>
            <%-- next arrow full screen --%>
            <div style="float:right; padding-right:2%;">
                <div class="fixed hidden-xs">
                    <asp:ImageButton ID="imgNext" runat="server" ImageUrl="../img/NextArrowInCircleBlueGreen.png" Width="50%" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click"/>
                </div>
            </div>
         
        </div>

        <div id="divInstructionTitle" class="row well">
            <span><b>INSTRUCTIONS AND WORKSHEETS - RESIDENTS AND NON-RESIDENTS</b></span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px" />
        </div>

        <%-- next arrow mobile screen --%>
        <div class="col-xs-3 col-sm-3 hidden-lg hidden-md pull-right right" style="padding-right:30%;">
            <asp:ImageButton ID="imgNextMobile" runat="server" ImageUrl="../img/NextArrowInCircleBlueGreen.png" Width="150px" Height="150px" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
        </div>

        <div id="divInstructions" class="row well instruction_toggle" style="margin-bottom:20px;">
            <div id="divResPW">
                <table style="color: black;">
                    <tr>
                        <td style="width:5%;"></td>
                        <td style="width:85%;"></td>
                        <td style="width:5%;"></td>
                        <td style="width:10%;"></td>
                    </tr>
                    <tr>  
                        <td colspan="4" style="text-align:center;">
                            <img src="images/DE_W4_Resident_WH_Image.png" style="width:100%;" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="4" style="text-align:center; font-size:large;">
                            Use the following instructions to determine the correct number of allowances for withholding.
                            <br />
                            Include only those individuals that you would include on your final income tax return.
                            <br /><br />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>A</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Enter “1” for Yourself (2 if 60 years old or older) if no one else claims you as a dependent
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>A</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <asp:TextBox ID="txtResBoxA" runat="server" onkeypress="return onlyNumbers();" CssClass="center"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valretxtResBoxA" runat="server" CSSClass="red" ControlToValidate="txtResBoxA" ValidationExpression="\b(1|2)\b" ErrorMessage="<b>Only 1, or 2 are Valid</b>" Display="Dynamic" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>B</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Enter “1” for your Spouse (2 if 60 years old or older) if no one else claims your spouse as a dependent
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>B</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <asp:TextBox ID="txtResBoxB" runat="server" onkeypress="return onlyNumbers();" CssClass="center"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valretxtResBoxB" runat="server" CSSClass="red" ControlToValidate="txtResBoxB" ValidationExpression="\b(1|2)\b" ErrorMessage="<b>Only 1, or 2 are Valid</b>" Display="Dynamic" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>C</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Enter number of dependents other than your spouse that you will claim
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>C</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <asp:TextBox ID="txtResBoxC" runat="server" onkeypress="return onlyNumbers();" CssClass="center"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>D</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Enter “1” if you qualify to take a child/dependent care credit for one child or dependent and “2” if you qualify to take the credit for two or more
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>D</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <asp:TextBox ID="txtResBoxD" runat="server" onkeypress="return onlyNumbers();" CssClass="center"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valretxtResBoxD" runat="server" CSSClass="red" ControlToValidate="txtResBoxD" ValidationExpression="\b(1|2)\b" ErrorMessage="<b>Only 1, or 2 are Valid</b>" Display="Dynamic" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>E</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Enter “1” for you are 65 or over OR blind. Enter “2” if you are both 65 or over AND blind.
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>E</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <asp:TextBox ID="txtResBoxE" runat="server" onkeypress="return onlyNumbers();" CssClass="center"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valretxtResBoxE" runat="server" CSSClass="red" ControlToValidate="txtResBoxE" ValidationExpression="\b(1|2)\b" ErrorMessage="<b>Only 1, or 2 are Valid</b>" Display="Dynamic" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>F</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Enter “1” if your spouse is 65 or older OR blind. Enter “2” if your spouse is 65 or older AND blind.
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>F</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <asp:TextBox ID="txtResBoxF" runat="server" onkeypress="return onlyNumbers();" CssClass="center"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valretxtResBoxF" runat="server" CSSClass="red" ControlToValidate="txtResBoxF" ValidationExpression="\b(1|2)\b" ErrorMessage="<b>Only 1, or 2 are Valid</b>" Display="Dynamic" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:top;">
                            <b>G</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:left; vertical-align:top;">
                            Add Line A through Line F
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:top;">
                            <b>G</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:bottom;">
                            <asp:TextBox ID="txtResBoxG" runat="server" onkeypress="return onlyNumbers();" CssClass="center"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align:left; padding-right:20px;">
                            <br />
                            If you plan to itemize, or you receive non-wage income, or you can claim other deductions and wish to adjust your withholding, continue with the
                            following Section H. Otherwise, STOP HERE and enter the number from Line G onto the Delaware Form W-4.
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:top;">
                            <b>H</b>
                        </td>
                        <td colspan="3" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:left; vertical-align:top;">
                            DEDUCTIONS AND INCOME ADJUSTMENTS
                        </td>
                    </tr>
                     <tr>
                        <td colspan="4" style="text-align:left; padding-right:20px;">
                            <b>NOTE:</b> Use this section only if you plan to itemize, claim other deductions, or have nonwage income. If computing this section on 
                            <b>Married Filing Separate</b> or <b>Combined Separate</b> status, include only the amount of itemized deductions that may be claimed on your separate return.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>1</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Enter an estimate of your itemized deductions for the current year, i.e. home mortgage interest, real estate and other
                            taxes (excluding state income tax paid) limited to $10,000, charitable contributions, medical expenses in excess of
                            10% of adjusted gross income, and miscellaneous deductions (most miscellaneous deductions are now deductible
                            only in excess of 2% of your adjusted gross income).
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom; padding-bottom:5px;">
                            <b>1</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtResBoxH1" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>2</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Delaware Standard Deduction of $3,250
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom; padding-bottom:5px;">
                            <b>2</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtResBoxH2" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%" Value="3250.00"></asp:TextBox>
                        </td>
                    </tr>
                   <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>3</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Subtract Line 2 from Line 1. If less than zero, enter 0.
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom; padding-bottom:5px;">
                            <b>3</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtResBoxH3" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>4</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Enter an estimate of your adjustments to income for the current year incuding alimony paid, IRA contributions, the pension
                            exclusion and the exclusion for certain persons over 60 years old or disabled
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom; padding-bottom:5px;">
                            <b>4</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtResBoxH4" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>5</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Add Lines 3 and 4
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom; padding-bottom:5px;">
                            <b>5</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtResBoxH5" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>6</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Enter an estimate of your non-wage income for the current year
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom; padding-bottom:5px;">
                            <b>6</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtResBoxH6" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>7</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Subtract Line 6 from Line 5
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom; padding-bottom:5px;">
                            <b>7</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtResBoxH7" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>8</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Divide the amount on Line 7 by $2,000. Round down to nearest whole number.
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom; padding-bottom:5px;">
                            <b>8</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtResBoxH8" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>9</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Enter the number from Line G above
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom; padding-bottom:5px;">
                            <b>9</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtResBoxH9" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:top;">
                            <b>10</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:left; vertical-align:top;">
                            Add Lines 8 and 9. Report this number of allowances to your employer on Delaware Form W-4.
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:bottom; padding-bottom:5px;">
                            <b>10</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtResBoxH10" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr><td colspan="4">&nbsp;<br /><br /></td></tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:top;">
                            <b>H</b>
                        </td>
                        <td colspan="3" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:left; vertical-align:top;">
                            SPECIAL INSTRUCTIONS
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align:left; padding-right:20px;">
                            If the total on Line 10 is less than zero you may need additional withholding as a result of non-wage income to avoid owing tax on your income tax
                            return. You can calculate the amount of additional withholding as follows:
                            <br /><br />
                            (1) Multiply number on Line 10 by $110;<br />
                            (2) Divide the result by the number of pay periods during the year (e.g., if you are paid monthly, divide by 12); The result is the additional amount of
                            withholding required per pay.
                            <br /><br />
                            <b>EXAMPLE:</b> Total on Line 10 is “-2” and you are paid once a month. <br />
                            (1) Line H = 2 x $110 = $220.00 <br />
                            (2) Number of pay periods = $220.00/12 = $18.33 
                            <br /><br />
                            You should notify your employer on a Delaware Form W-4 that your withholding allowance should be “0” and an additional $18.33 per pay should be
                            withheld for the current year.
                            <br /><br />
                        </td>
                    </tr>

                </table>
            </div>
       
            <div id="divNonResPW">
                <table style="color: black; border-top: 5px solid black;">
                    <tr>
                        <td style="width:5%;"></td>
                        <td style="width:85%;"></td>
                        <td style="width:5%;"></td>
                        <td style="width:10%;"></td>
                    </tr>
                    <tr>  
                        <td colspan="4" style="text-align:center;">
                            <img src="images/DE_W4_NonResident_WH_Image.png" style="width:100%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>A</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Enter “1” for Yourself (2 if 60 years old or older) if no one else claims you as a dependent
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>A</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <asp:TextBox ID="txtNonResBoxA" runat="server" onkeypress="return onlyNumbers();" CssClass="center"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valretxtNonResBoxA" runat="server" CSSClass="red" ControlToValidate="txtNonResBoxA" ValidationExpression="\b(1|2)\b" ErrorMessage="<b>Only 1, or 2 are Valid</b>" Display="Dynamic" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>B</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Enter “1” for your Spouse (2 if 60 years old or older) if you claim your spouse as a dependent on the State tax return
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>B</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <asp:TextBox ID="txtNonResBoxB" runat="server" onkeypress="return onlyNumbers();" CssClass="center"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valretxtNonResBoxB" runat="server" CSSClass="red" ControlToValidate="txtNonResBoxB" ValidationExpression="\b(1|2)\b" ErrorMessage="<b>Only 1, or 2 are Valid</b>" Display="Dynamic" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>C</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Enter number of dependents other than your spouse that you will claim
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>C</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <asp:TextBox ID="txtNonResBoxC" runat="server" onkeypress="return onlyNumbers();" CssClass="center"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:top;">
                            <b>D</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:left; vertical-align:top;">
                            Add Lines A through C
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:top;">
                            <b>D</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:bottom;">
                            <asp:TextBox ID="txtNonResBoxD" runat="server" onkeypress="return onlyNumbers();" CssClass="center"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                
                <table style="color: black;">
                    <tr>
                        <td style="width:5%;"></td>
                        <td style="width:70%;"></td>
                        <td style="width:5%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:10%;"></td>
                    </tr>
                    <tr>
                        <td colspan="3">
                        </td>
                        <td colspan="1" style="text-align:center;">
                            Column A
                        </td>
                        <td colspan="1" style="text-align:center;">
                            Column B
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <b>INCOME AND ADJUSTMENTS</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black;  vertical-align:middle; text-align:center;">
                            TOTAL
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; vertical-align:middle; text-align:center;">
                            DELAWARE
                            <br />
                            SOURCE
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>1</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Wages
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>1</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes1A" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes1B" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>2</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Non-wage Income (Net of Losses - See Instructions)
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>2</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes2A" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes2B" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>3</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Total Income (Add Line 1 and Line 2)
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>3</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes3A" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes3B" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>4a</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Federal Adjustments to Income (See Instructions)
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>4a</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes4aA" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes4aB" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>4b</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Delaware Adjustments to Income (See Instructions)
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>4b</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes4bA" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes4bB" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>4c</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Total Adjustments to Income (Add Line 4a and Line 4b)
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>4c</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes4cA" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes4cB" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align: center; vertical-align:top;">
                            <b>5</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:left; vertical-align:top;">
                            Adjusted Gross Income (Subtract Line 4c from Line 3)
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:top;">
                            <b>5</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes5A" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes5B" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:top;">
                            <b>6</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:left; vertical-align:top;">
                            PRORATION DECIMAL (Line 5: Column B ÷ Column A )
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:top;">
                            <b>6</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:bottom;">
                            <asp:TextBox ID="txtNonRes6" runat="server" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-bottom:white;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align:left;">
                            <br /><br />
                            <b>DEDUCTIONS</b>
                        </td>
                        <td colspan="1" style="border-bottom:white;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>7</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Deductions (Higher of Standard or Itemized - See Instructions)
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>7</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes7" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>8</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Estimated Taxable Income (Subtract Line 7 from Line 5, Column A)
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>8</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes8" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-bottom:white;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>9</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Gross Tax Liability (Computed using Line 8 - See Example Below)
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>9</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes9" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-bottom:white;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>10</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Personal Credits (Multiply Line D by $110)
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>10</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes10" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-bottom:white;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>11</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Net Liability before Proration (Subtract Line 10 from Line 9)
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>11</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes11" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-bottom:white;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>12</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Proration Decimal (Enter from Line 6)
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>12</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes12" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-bottom:white;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>13</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Estimated Tax Liability (Multiply Line 11 by Line 12)
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>13</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes13" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-bottom:white;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>14</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:left; vertical-align:top;">
                            Number of Pay Periods (From Employer or See Instructions)
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:top;">
                            <b>14</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes14" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-bottom:white;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:top;">
                            <b>15</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:left; vertical-align:top;">
                            Withholding per Pay Period (Divide Line 13 by Line 14)
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:top;">
                            <b>15</b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; text-align:center; vertical-align:bottom;">
                            <b>$</b><asp:TextBox ID="txtNonRes15" runat="server" onkeypress="return isNumberKey(evt)" onblur="makeMoney(this)" CssClass="right" Width="90%"> </asp:TextBox>
                        </td>
                        <td colspan="1" style="border-bottom:white;">
                            &nbsp;
                        </td>
                    </tr>
                </table>
                
                <table style="color: black;">
                    <tr>
                        <td style="width:9%;"></td>
                        <td style="width:1%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:15%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:45%;"></td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            &nbsp;
                        </td>
                        <td colspan="1" style="border-bottom:white;">
                            &nbsp;
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" style="font-weight:bold; border-left:1px solid black; border-top: 1px solid black; border-right: 1px solid black; text-align:center;">
                            TAX TABLE
                        </td>
                        <td colspan="1" style="border-bottom:white;">
                            &nbsp;
                        </td>
                        <td colspan ="1" style="font-weight:bold; border-left:1px solid black; border-top: 1px solid black; border-right: 1px solid black; text-align:center;">
                            EXAMPLE OF GROSS TAX LIABILITY CALCULATION:
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="border-left: 1px solid black; border-top: 1px solid black; border-right: 1px solid black; text-align:center;">
                            Taxable Income Between
                        </td>
                        <td colspan="1" style="border-left: 1px solid black; border-top: 1px solid black; border-right: 1px solid black; text-align:center;">
                            Pay
                        </td>
                        <td colspan="1" style="border-left: 1px solid black; border-top: 1px solid black; border-right: 1px solid black; text-align:center;">
                            Plus
                        </td>
                        <td colspan="1" style="border-left: 1px solid black; border-top: 1px solid black; border-right: 1px solid black; text-align:center;">
                            On Amounts Over
                        </td>
                        <td colspan="1" style="border-bottom:white;">
                            &nbsp;
                        </td>
                        <td colspan="1" style="border-left: 1px solid black; border-top: 1px solid black; border-right: 1px solid black; text-align:center;">
                            If you Estimated Taxable Income, (Line 8) is $12,000:
                        </td>

                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:right; border-left: 1px solid black; border-top: 1px solid black; border-bottom: 1px solid black; ">
                            $ 0 <br />
                            2,001 <br />
                            5,001 <br />
                            10,001 <br />
                            20,001 <br />
                            25,001 <br />
                            60,001
                        </td>
                        <td colspan="1" style="text-align:right; border-top: 1px solid black; border-bottom: 1px solid black;">
                            - <br />
                            - <br />
                            - <br />
                            - <br />
                            - <br />
                            - <br />
                            &
                        </td>
                        <td colspan="1" style="text-align:right; border-top: 1px solid black; border-right: 1px solid black; border-bottom: 1px solid black;">
                            2,000 <br />
                            5,001 <br />
                            10,001 <br />
                            20,001 <br />
                            25,001 <br />
                            60,001 <br />
                            over
                        </td>
                        <td colspan="1" style="text-align:right; border-left: 1px solid black; border-top: 1px solid black; border-right: 1px solid black; border-bottom: 1px solid black;">
                            $    0.00 <br />
                            $    0.00 <br />
                            $    66.00 <br />
                            $   261.00 <br />
                            $   741.00 <br />
                            $  1,001.00 <br />
                            $  2,943.50
                        </td>
                        <td colspan="1" style="text-align:right; border-left: 1px solid black; border-top: 1px solid black; border-right: 1px solid black; border-bottom: 1px solid black;">
                            0.00 % <br />
                            2.20 % <br />
                            3.90 % <br />
                            4.80 % <br />
                            5.20 % <br />
                            5.55 % <br />
                            6.60 %
                        </td>
                        <td colspan="1" style="text-align:right; border-left: 1px solid black; border-top: 1px solid black; border-right: 1px solid black; border-bottom: 1px solid black;">
                            $       0 <br />
                            $   2,000 <br />
                            $   5,000 <br />
                            $  10.000 <br />
                            $  20,000 <br />
                            $  25,000 <br />
                            $  60,000
                        </td>
                        <td colspan="1" style="border-bottom:white;">
                            &nbsp;
                        </td>
                        <td colspan="1" style="border-left: 1px solid black; border-top: 1px solid black; border-right: 1px solid black; border-bottom: 1px solid black;" >
                            PAY: $261.00 + {(12,000 - 10,000) x 0.048}<br />
                                = $261.00 + (2,000 x 0.048)<br />
                                = $261.00 + 96.00<br />
                                = $357.00
                        </td>
                    </tr>
                   
                </table>
            </div>
        </div>

        <div id="divDEMainForm" class="row ">
            <table style="background-color:transparent;">
                <tr>
                    <td style="width:3%;"></td>
                    <td style="width:30%;"></td>
                    <td style="width:30%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:15%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:1%;"></td>
                    <td style="width:15%;"></td>
                </tr>
                <tr>
                    <td colspan="8" style="text-align:center;">
                        <img src="images/DE_W4_Header.png"  style="width:100%;" />
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                        <b>1</b>
                    </td>
                    <td colspan="1" style="vertical-align:middle; border-top: 1px solid black; border-bottom: 1px solid black; border-right: 1px solid black;">
                        FIRST NAME AND MIDDLE INITIAL
                    </td>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black; border-right: 1px solid black;">
                        LAST NAME
                    </td>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                        <b>2</b>
                    </td>
                    <td colspan="4" style="vertical-align:middle; border-top: 1px solid black; border-bottom: 1px solid black; border-right: 1px solid black;">
                        TAXPAYER ID
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black; height:50px;">
                        &nbsp;
                    </td>
                    <td colspan="1" style="vertical-align:middle; border-top: 1px solid black; border-bottom: 1px solid black; padding-left: 10px;">
                       <b><asp:Label ID="lblFirstNameMI" runat="server"/></b>
                    </td>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black; border-right: 1px solid black; padding-left: 10px;">
                       <b><asp:Label ID="lblLastName" runat="server"/></b>
                    </td>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                         &nbsp;
                    </td>
                    <td colspan="4" style="vertical-align:middle; border-top: 1px solid black; border-bottom: 1px solid black; border-right: 1px solid black; padding-left: 10px;">
                       <b><asp:Label ID="lblSSNumber" runat="server"/></b>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                        &nbsp;
                    </td>
                    <td colspan="2" style="vertical-align:middle; border-top: 1px solid black; border-bottom: 1px solid black; border-right: 1px solid black;">
                        HOME ADDRESS (Number and street or rural route)
                    </td>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                        <b>3</b>
                    </td>
                    <td colspan="4" style="vertical-align:middle; border-top: 1px solid black; border-bottom: 1px solid black; border-right: 1px solid black;">
                        MARITAL STATUS
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black; height:50px;">
                        &nbsp;
                    </td>
                    <td colspan="2" style="vertical-align:middle; border-top: 1px solid black; border-bottom: 1px solid black;">
                       <b><asp:Label ID="lblAddress" runat="server"/></b>
                    </td>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                        &nbsp;
                    </td>
                    <td colspan="2" style="vertical-align:middle; border-top: 1px solid black; border-bottom: 1px solid black;">
                       <asp:CheckBox ID="chkSingle" runat="server" Text="&nbsp;Single"  AutoPostBack="true" OnCheckedChanged="chkSingle_CheckedChanged" />
                    </td>
                    <td colspan="2" style="vertical-align:middle; border-top: 1px solid black; border-bottom: 1px solid black; border-right: 1px solid black;">
					    <asp:CheckBox ID="chkMarried" runat="server" Text="&nbsp;Married" AutoPostBack="true" OnCheckedChanged="chkMarried_CheckedChanged" />
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                        &nbsp;
                    </td>
                    <td colspan="1" style="vertical-align:middle; border-top: 1px solid black; border-bottom: 1px solid black; border-right: 1px solid black;">
                        CITY OR TOWN
                    </td>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                        STATE
                    </td>
                    <td colspan="5" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black; border-right: 1px solid black;">
                        ZIP CODE
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black; height:50px;">
                        &nbsp;
                    </td>
                    <td colspan="1" style="vertical-align:middle; border-top: 1px solid black; border-bottom: 1px solid black;">
                       <b><asp:Label ID="lblCity" runat="server"/></b>
                    </td>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black; border-right: 1px solid black; padding-left:10px;">
                       <b><asp:Label ID="lblState" runat="server"/></b>
                    </td>
                    <td colspan="5" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black; border-right: 1px solid black; padding-left:10px;">
                         <b><asp:Label ID="lblZip" runat="server"/></b>
                    </td>
                </tr>
                <%--<tr><td colspan="8">&nbsp;</td></tr>--%>
                <tr>
                    <td colspan="1" style="vertical-align:middle;">
                        <b>4</b>
                    </td>
                    <td colspan="4" style="vertical-align:middle;" class="dots-after">
                        Total number of dependents you can claim on your return
                    </td>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black; background-color:white; text-align:center;">
                        <b>4</b>
                    </td>
                    <td colspan="2" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black; border-right: 1px solid black; text-align:center; background-color:white;" >
                        <asp:TextBox ID="txtTotalDependents" runat="server" onkeypress="return onlyNumbers();" CssClass="center"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:middle;">
                        <b>5</b>
                    </td>
                    <td colspan="4" style="vertical-align:middle;" class="dots-after">
                        Additional amount, if any, you want withheld from each paycheck
                    </td>
                    <td colspan="1" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black; background-color:white; text-align:center;">
                        <b>5</b>
                    </td>
                    <td colspan="2" style="vertical-align:middle; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black; border-right: 1px solid black; text-align:center; background-color:white;">
                        <asp:TextBox ID="txtAdditionalWithholding" runat="server" onkeypress="return onlyNumbers();" CssClass="center"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                         &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="border-top:1px solid black;">
                        Under penalties of perjury, I declare that I have examined this certificate and, to the best of my knowledge and belief, it is true, correct, and complete.
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        <b>Employee’s signature</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="vertical-align:middle;">
                        (This form is not valid unless signed)
                        <img src="images/Triangle_Right_Black.png" style="width:25px; padding-left:10px;" />
                    </td>
                    <td colspan="2" style="vertical-align:middle; text-align:left;">
                        <asp:TextBox ID="txtSignature" runat="server" placeholder="Type Name to Represent Signature" CssClass="underline" Style=" margin-left:-100px; padding-left:20px; text-align:left;"></asp:TextBox>
                    </td>
                    <td colspan="1" style="vertical-align:bottom; float:right;">
                        Date
                        <img src="images/Triangle_Right_Black.png" style="width:25px; padding-left:10px;" />
                    </td>
                    <td colspan="3" style="vertical-align:middle; width:100%;">
                        <asp:TextBox ID="txtSignatureDate" runat="server" placeholder="MM/DD/YYYY" CssClass="underline" Style="padding-left:20px;" ></asp:TextBox>
                    </td>
                </tr>
                <tr><td colspan="8">&nbsp;</td></tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                        <b>6</b>
                    </td>
                    <td colspan="2" style="vertical-align:top; border-top: 1px solid black; border-bottom: 1px solid black;">
                        Employer’s name and address (Employer: Complete boxes 6 through 8 if sending to the Delaware Division of Revenue and the State Directory of New Hires.)
                        <br />
                        <b><asp:Label ID="lblEmployerName" runat="server" Style="text-align: left; padding-left: 1%; display: inline;" ></asp:Label></b>
                        <br />
                        <b><asp:Label ID="lblEmployerFullAddress" runat="server" Style="text-align: left; padding-left: 1%; display: inline;" ></asp:Label></b>
                        <br />
                        <b><asp:Label ID="lblEmployerCity" runat="server" Style="text-align: left; padding-left: 1%; display: inline;" ></asp:Label></b>,
                        <b><asp:Label ID="lblEmployerState" runat="server" Style="text-align: left; padding-left: 1%; display: inline;" ></asp:Label></b>&nbsp;&nbsp;
                        <b><asp:Label ID="lblEmployerZip" runat="server" Style="text-align: left; padding-left: 1%; display: inline;" ></asp:Label></b>
                    </td>
                    <td colspan="1" style="vertical-align:top; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                        <b>7</b>
                    </td>
                    <td colspan="1" style="vertical-align:top; border-top: 1px solid black; border-bottom: 1px solid black;"> 
                        First date of employment 
                        <br />
                        <br />
                        <b><asp:Label ID="lblDateOfHire" runat="server" Style="text-align: left; padding-left: 1%; display: inline;" ></asp:Label></b>
                    </td>
                    <td colspan="1" style="vertical-align:top; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                        <b>8</b>
                    </td>
                    <td colspan="2" style="vertical-align:top; border-top: 1px solid black; border-bottom: 1px solid black; border-right: 1px solid black;"> 
                        Employer identification number (EIN)
                        <br />
                        <b><asp:Label ID="lblEmployerFEIN" runat="server" Style="text-align: left; padding-left: 1%; display: inline;" ></asp:Label></b>
                    </td>
                </tr>
            </table>
        </div>
      
        <div class="row">
                <div class="clearfix">&nbsp;</div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 Text-center">
                    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" Onclick="btnSave_Click"/>
                </div>
                <div class="clearfix">&nbsp;</div>
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
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
    </style>
</asp:Content>
