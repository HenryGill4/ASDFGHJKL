<%@ Page Title="Employee State WH Form GA" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_GA.aspx.vb" 
    Inherits="HReaseApp.EE_W4_GA" 
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

      function makeMoney(source){
          //Grab the value from the element
          var money = parseFloat(source.value,10).toFixed(2);
      
          //Format your value
          source.value = money.toString();
        }

        $(function () {
            var textBox3A = $('input:text[id$=txtSingle]').keyup(foo);
            var textBox3B = $('input:text[id$=txtMFJointBoth]').keyup(foo);
            var textBox3C = $('input:text[id$=txtMFJointOne]').keyup(foo);
            var textBox3D = $('input:text[id$=txtMFSeparate]').keyup(foo);
            var textBox3E = $('input:text[id$=txtHOHousehold]').keyup(foo);
            var textBox4 = $('input:text[id$=txtDependentAllowances]').keyup(foo);
            var textBox5 = $('input:text[id$=txtAdditionalAllowances]').keyup(foo);

            function foo() {
                var box1 = textBox3A.val();
                var box2 = textBox3B.val();
                var box3 = textBox3C.val();
                var box4 = textBox3D.val();
                var box5 = textBox3E.val();
                var box6 = textBox4.val();
                var box7 = textBox5.val();

                var sum = add(box1, box2, box3, box4, box5, box6, box7);
                $('input:text[id$=txtTotalExemptions]').val(sum);
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

        $(function () {
            var textBox3A = $('input:text[id$=txtSingle]').keyup(foo);            
            var textBox3B = $('input:text[id$=txtMFJointBoth]').keyup(foo);
            var textBox3C = $('input:text[id$=txtMFJointOne]').keyup(foo);
            var textBox3D = $('input:text[id$=txtMFSeparate]').keyup(foo);
            var textBox3E = $('input:text[id$=txtHOHousehold]').keyup(foo);

            function foo() {
                var box1 = textBox3A.val();
                var box2 = textBox3B.val();
                var box3 = textBox3C.val();
                var box4 = textBox3D.val();
                var box5 = textBox3E.val();

                if (box1 > 0) {
                    var a = 0;
                    var b = "A";
                    $('input:text[id$=txtMFJointBoth]').val(a);
                    $('input:text[id$=txtMFJointOne]').val(a);
                    $('input:text[id$=txtMFSeparate]').val(a);
                    $('input:text[id$=txtHOHousehold]').val(a);
                    $('input:text[id$=txtMaritalStatus]').val(b);
                }
                else if(box2 > 0 ) {
                    var a = 0;
                    var b = "B";
                    $('input:text[id$=txtSingle]').val(a);
                    $('input:text[id$=txtMFJointOne]').val(a);
                    $('input:text[id$=txtMFSeparate]').val(a);
                    $('input:text[id$=txtHOHousehold]').val(a);
                    $('input:text[id$=txtMaritalStatus]').val(b);
                }
                 else if(box3 > 0 ) {
                    var a = 0;
                    var b = "C";
                    $('input:text[id$=txtSingle]').val(a);
                    $('input:text[id$=txtMFJointBoth]').val(a);
                    $('input:text[id$=txtMFSeparate]').val(a);
                    $('input:text[id$=txtHOHousehold]').val(a);
                    $('input:text[id$=txtMaritalStatus]').val(b);
                }
                else if(box4 > 0 ) {
                    var a = 0;
                    var b = "D";
                    $('input:text[id$=txtSingle]').val(a);
                    $('input:text[id$=txtMFJointOne]').val(a);
                    $('input:text[id$=txtMFJointBoth]').val(a);
                    $('input:text[id$=txtHOHousehold]').val(a);
                    $('input:text[id$=txtMaritalStatus]').val(b);
                }
                else if(box5 > 0 ) {
                    var a = 0;
                    var b = "E";
                    $('input:text[id$=txtSingle]').val(a);
                    $('input:text[id$=txtMFJointOne]').val(a);
                    $('input:text[id$=txtMFJointBoth]').val(a);
                    $('input:text[id$=txtMFSeparate]').val(a);
                    $('input:text[id$=txtMaritalStatus]').val(b);
                }

            }
        });


 
    </script>
    <style>
        input[type=text], textarea {
            outline: none;
            min-height: 25px;
            background-color: #f0f4fa;
            border: 1px solid #e0eaf7 !important;
        }

        input[type="checkbox"] {
            width: 16px;
            height: 16px;
            cursor: pointer;
        }
        td.dots-after:after {
            clip: rect(0px, 500px, 20px, 0px);
            content: " ....................................................................................................... ";
            position: absolute;
            z-index: -1;
        }
        p{color:black}

        .underline {
            border-bottom: 1px solid !important;
            width: 100%;
            display: inline-block;
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
                <asp:Label ID="lblSuccess" runat="server" Text="Georgia State Tax Form Complete.<br/>"></asp:Label>
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
            <span><b>INSTRUCTIONS </b></span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px" />
        </div>

        <%-- next arrow mobile screen --%>
        <div class="col-xs-3 col-sm-3 hidden-lg hidden-md pull-right right" style="padding-right:30%;">
            <asp:ImageButton ID="imgNextMobile" runat="server" ImageUrl="../img/NextArrowInCircleBlueGreen.png" Width="150px" Height="150px" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
        </div>

        <div id="divInstructions" class="row well instruction_toggle" style="margin-bottom:20px;">
            <table>
                <tr>
                    <td style="width:6%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:5%;"></td>
                    <td style="width:80%;"></td>
                </tr>
                <tr>
                    <td colspan="5">
                        <b>INSTRUCTIONS FOR COMPLETING FORM G-4 </b>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        Enter your full name, address and social security number in boxes 1a through 2b.
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        Line 3: 
                    </td>
                    <td colspan="4">
                        Write the number of allowances you are claiming in the brackets beside your marital status. 
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="vertical-align:top;">
                        A: 
                    </td>
                    <td colspan="3">
                        Single – enter 1 if your are claiming yourself
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="vertical-align:top;">
                        B: 
                    </td>
                    <td colspan="3">
                        Married Filing Joint, both spouses working – enter 1 if you claim yourself 
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="vertical-align:top;">
                        C: 
                    </td>
                    <td colspan="3">
                        Married Filing Joint, one spouse working – enter 1 if your claim yourself or 2 if you claim yourself and your spouse
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="vertical-align:top;">
                        D: 
                    </td>
                    <td colspan="3">
                        Married Filing Separate – enter 1 if you claim yourself 
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="vertical-align:top;">
                        E: 
                    </td>
                    <td colspan="3">
                        Head of Household – enter 1 if you claim yourself 
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        Line 4: 
                    </td>
                    <td colspan="4">
                        Enter the number of dependent allowances you are entitled to claim.
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        Line 5: 
                    </td>
                    <td colspan="4">
                        Complete the worksheet on Form G-4 if you claim additional allowances. Enter the number on Line H here.
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                    </td>
                    <td colspan="4">
                        <b>Failure to complete and submit the worksheet will result in automatic denial on your claim.</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        Line 6: 
                    </td>
                    <td colspan="4">
                        Enter a specific dollar amount that you authorize your employer to withhold in addition to the tax withheld based on your marital status and number of allowances.
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        Line 7: 
                    </td>
                    <td colspan="4">
                        Enter the letter of your marital status from Line 3. Enter total of the numbers on Lines 3-5.
                    </td>
                </tr>
                <tr>
                    <td colspan="5" style="vertical-align:top;">
                        Line 8: 
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:right; vertical-align:top;">
                        a) 
                    </td>
                    <td colspan="2">
                        Check the first box if you qualify to claim exempt from withholding. You can claim exempt if you filed a Georgia income tax return last year and the amount of Line 4 of Form 500EZ or Line 16 of Form 500 was zero, and you expect to file a Georgia tax return this year and will not have a tax liability. You can not claim exempt if you did not file a Georgia income tax return for the previous tax year. <b>Receiving a refund in the previous tax year does not qualify you to claim exempt.</b>
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td colspan="3">
                    </td>
                    <td colspan="2">
                        <b>EXAMPLES:</b> Your employer withheld $500 of Georgia income tax from your wages. The amount on Line 4 of Form 500EZ (or Line 16 of Form 500) was $100. Your tax liability is the amount on Line 4 (or Line 16); therefore, you <b>do not qualify</b> to claim exempt.
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td colspan="3">
                    </td>
                    <td colspan="2">
                        Your employer withheld $500 of Georgia income tax from your wages. The amount on Line 4 of Form 500EZ (or Line 16 of Form 500) was $0 (zero). Your tax liability is the amount on Line 4 (or Line 16) and you filed a prior year income tax return; therefore you <b>qualify</b> to claim exempt.
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:right; vertical-align:top;">
                        b) 
                    </td>
                    <td colspan="2">
                        Check the second box if you are not subject to Georgia withholding and meet the conditions set forth under the Servicemembers Civil Relief Act, as amended by the Military Spouses Residency Relief Act. Under the Act, a spouse of a servicemember may be exempt from Georgia income tax on income from services performed in Georgia if:
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                    </td>
                    <td colspan="1" style="text-align:right;">
                        1.
                    </td>
                    <td colspan="1">
                        The servicemember is present in Georgia in compliance with military orders;
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                    </td>
                    <td colspan="1" style="text-align:right;">
                        2.
                    </td>
                    <td colspan="1">
                        The spouse is in Georgia solely to be with the servicemember;
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                    </td>
                    <td colspan="1" style="text-align:right;">
                        3.
                    </td>
                    <td colspan="1">
                        The spouse maintains domicile in another state; and
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                    </td>
                    <td colspan="1" style="text-align:right;">
                        4.
                    </td>
                    <td colspan="1">
                        The domicile of the spouse is the same as the domicile of the servicemember.
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td colspan="3">
                    </td>
                    <td colspan="2">
                        Additional information for employers regarding the Military Spouses Residency Relief Act:
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                    </td>
                    <td colspan="1" style="text-align:right;">
                        1.
                    </td>
                    <td colspan="3">
                        On the W-2 for 2010 and any year thereafter, the employer should not report any of the wages as Georgia wages on the W-2.
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                    </td>
                    <td colspan="1" style="text-align:right;">
                        2.
                    </td>
                    <td colspan="1">
                        If the spouse of a servicemember is entitled to the protection of the Military Spouses Residency Relief Act in another state and files a withholding exemption form in such other state, the spouse is required to submit a Georgia Form G-4 so that withholding will occur as is required by Georgia Law when a Georgia domiciliary works in another state and withholding is not required by such other state. If the spouse does not fill out the form, the employer shall withhold Georgia income tax as if the spouse is single with zero allowances.
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td colspan="5">
                        <b>Worksheet for calculating additional allowances.</b> Enter the information as requested by each line. For Line 2D, enter items such as Retirement Income Exclusion, U.S. Obligations, and other allowable deductions per Georgia Law, see the IT-511 booklet for more information.
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td colspan="5">
                        <b>Do not complete Lines 3-7 if claiming exempt.</b>
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td colspan="5">
                        <b>O.C.G.A. § 48-7-102</b> requires you to complete and submit Form G-4 to your employer in order to have tax withheld from your wages. By correctly completing this form, you can adjust the amount of tax withheld to meet your tax liability. Failure to submit a properly completed Form G-4 will result in your employer withholding tax as though you are single with zero allowances.
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td colspan="5">
                        Employers are required to mail any Form G-4 claiming more than 14 allowances or exempt from withholding to the Georgia Department of Revenue for approval. Employers will honor the properly completed form as submitted pending notification from the Withholding Tax Unit. Upon approval, such forms remain in effect until changed or until February 15 of the following year. Employers who know that a G-4 is erroneous should not honor the form and should withhold as if the employee is single claiming zero allowances until a corrected form has been received.
                    </td>
                </tr>
            </table>
    </div>

        <div id="divGAFormHeader" class="row ">
            <table style="background-color:transparent;">
                <tr>
                    <td style="width:25%;"></td>
                    <td style="width:50%;"></td>
                    <td style="width:25%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="text-align:center;">
                        <b>Form G-4</b> (Rev. 02/15/19)
                    </td>
                    <td colspan="1" style="text-align:center;">
                        <img src="images/GA_BarCode.png" />
                    </td>
                    <td colspan="3">
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align:center;">
                        <b>STATE OF GEORGIA EMPLOYEE’S WITHHOLDING ALLOWANCE CERTIFICATE</b>
                    </td>
                </tr>
            </table>
        </div>
        
        <div id="divNameAndAddress" class="row ">
            <table style="width:98%; background-color:transparent; border:1px solid black; margin-left:10px; ">
                <tr>
                    <td style="width:3%;"></td>
                    <td style="width:40%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:40%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="text-align:right;">
                        1a.
                    </td>
                    <td colspan="1" style="border-right:1px solid black;">
                        YOUR FULL NAME
                    </td>
                    <td colspan="1" style="text-align:right;">
                        1b.
                    </td>
                    <td colspan="1">
                        YOUR SOLCIAL SECURITY NUMBER
                    </td>
                </tr>
                <tr style="background-color: #f0f4fa;">
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="border-right:1px solid black;">
                        <b><asp:Label ID="lblFullName" runat="server"/></b>
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="border-right:1px solid black;">
                        <b><asp:Label ID="lblSSNumber" runat="server"/></b>
                    </td>
                </tr>
                 <tr>
                    <td colspan="1" style="text-align:right;">
                        2a.
                    </td>
                    <td colspan="1" style="border-right:1px solid black;">
                        HOME ADDRESS (Number, Street, or Rural Route)
                    </td>
                    <td colspan="1" style="text-align:right;">
                        2b.
                    </td>
                    <td colspan="1">
                        CITY, STATE AND ZIP CODE
                    </td>
                </tr>
                <tr style="background-color: #f0f4fa;">
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="border-right:1px solid black;">
                        <b><asp:Label ID="lblFullAddress" runat="server"/></b>
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="border-right:1px solid black;">
                        <b><asp:Label ID="lblCityStateZip" runat="server"/></b>
                    </td>
                </tr>

            </table>
        </div>

        <div id="divMaritalStatus" class="row ">
            <table style="background-color:transparent; margin-left:10px; width:98%;" >
                <tr>
                    <td style="width:3%;"></td>
                    <td style="width:37%;"></td>
                    <td style="width:10%;"></td>
                    <td style="width:10%;"></td>
                    <td style="width:30%;"></td>
                    <td style="width:10%;"></td>
                </tr>
                <tr>
                    <td colspan="6" style="text-align:center;">
                        <b>PLEASE READ INSTRUCTIONS ON REVERSE SIDE BEFORE COMPLETING LINES 3 – 8</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        <b>3.</b>
                    </td>
                    <td colspan="5">
                        <b>MARITAL STATUS</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        (If you do not wish to claim an allowance, enter “0” in the brackets beside your marital status.)
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        A.
                    </td>
                    <td colspan="1" class="dots-after">
                        Single: Enter 0 or 1
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="txtSingle" runat="server" TabIndex="1" style="Width:70%; text-align:center;" onkeypress="return onlyNumbers();"/> 
                    </td>
                    <td colspan="1" style="text-align:right;">
                        <b>4.</b>
                    </td>
                    <td colspan="1">
                        <b>DEPENDENT ALLOWANCES</b>
                    </td>
                    <td colspan ="1">
                        <asp:TextBox ID="txtDependentAllowances" runat="server" TabIndex="6" style="Width:70%;text-align: center;" onkeypress="return onlyNumbers();" />
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       B.
                    </td>
                    <td colspan="5" >
                        Married Filling Joint, both spouses working: 
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                    </td>
                    <td colspan="1" class="dots-after">
                        Enter 0 or 1
                    </td>
                    <td colspan="1" style="text-align:left;">
                        <asp:TextBox ID="txtMFJointBoth" runat="server" TabIndex="2" style="Width:70%; text-align:center;" onkeypress="return onlyNumbers();" /> 
                    </td>
                    <td colspan="3" >
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       C.
                    </td>
                    <td colspan="2" >
                        Married Filing Joint, one spouse working:
                    </td>
                    <td colspan="1" style="text-align:right;">
                        <b>5.</b>
                    </td>
                    <td colspan="1">
                        <b>ADDITIONAL ALLOWANCES</b>
                    </td>
                    <td colspan ="1">
                        <asp:TextBox ID="txtAdditionalAllowances" runat="server" TabIndex="7" style="Width:70%;text-align: center;" onkeypress="return onlyNumbers();" />
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                    </td>
                    <td colspan="1" class="dots-after">
                        Enter 0 or 1 or 2
                    </td>
                    <td colspan="1" style="text-align:left;">
                        <asp:TextBox ID="txtMFJointOne" runat="server" TabIndex="3" style="Width:70%; text-align:center;" onkeypress="return onlyNumbers();"/> 
                    </td>
                    <td colspan="1" >
                    </td>
                    <td colspan="2" >
                        (worksheet below must be completed)
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       D.
                    </td>
                    <td colspan="5" >
                        Married Filing Separate: 
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                    </td>
                    <td colspan="1" class="dots-after">
                        Enter 0 or 1
                    </td>
                    <td colspan="1" style="text-align:left;">
                        <asp:TextBox ID="txtMFSeparate" runat="server" TabIndex="4" style="Width:70%; text-align:center;" onkeypress="return onlyNumbers();" /> 
                    </td>
                    <td colspan="3">
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       E.
                    </td>
                    <td colspan="2" >
                        Head of Household: 
                    </td>
                    <td colspan="1" style="text-align:right;">
                        <b>6.</b>
                    </td>
                    <td colspan="1">
                        <b>ADDITIONAL WITHHOLDING</b>
                    </td>
                    <td colspan ="1" class="underline" style="width:90%;">
                        $<asp:TextBox ID="txtAdditionalWithholding" runat="server" TabIndex="7" style="width:90%; text-align:right; padding-right:20px;" onkeypress="return isNumberKey(event)" onblur="makeMoney(this)" />
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                    </td>
                    <td colspan="1" class="dots-after">
                        Enter 0 OR 1
                    </td>
                    <td colspan="1" style="text-align:left;">
                        <asp:TextBox ID="txtHOHousehold" runat="server" TabIndex="5" style="Width:70%; text-align:center;" onkeypress="return onlyNumbers();" /> 
                    </td>
                    <td colspan="3">
                    </td>
                </tr>
            </table>
        </div>


            <div class="row" style="color:black; margin-top: 20px; margin-left:10px; margin-right:10px; margin-bottom: 20px; border: 1px solid #000">

                <div style="Text-align: center; padding: 5px 0px; letter-spacing: 0.5px;">
                    <b>WORKSHEET FOR CALCULATING ADDITIONAL ALLOWANCES
                        <br/>
                    </b>
                </div>
                <div style="Text-align: center; padding-bottom: 10px; letter-spacing: -1px;">
                    <b>(Must be completed in order to enter an amount on step 5)</b>
                </div>

                <div class="col-md-12"> 
                    <p >1. COMPLETE THIS LINE ONLY IF USING STANDARD DEDUCTION:</p>
                    <p style="padding-left: 25px;">
                        Yourself:
				        &nbsp;<asp:CheckBox ID="chkOver65" runat="server" TabIndex="8" Text="&nbsp; Age 65 or Over" />
                        &nbsp;<asp:CheckBox ID="chkBlind" runat="server" TabIndex="9" Text="&nbsp; Blind" />
                    </p>
                    <p style="padding-left: 25px;">
                        Spouse:
				        &nbsp;<asp:CheckBox ID="chkSpouse65" runat="server" TabIndex="10" Text="&nbsp; Age 65 or Over" />
                        &nbsp;<asp:CheckBox ID="chkSpouseBlind" runat="server" TabIndex="11" Text="&nbsp; Blind" />
                        &nbsp  &nbsp  &nbsp  &nbsp   Number of Boxes checked  &nbsp
                        &nbsp;<asp:TextBox ID="txtNumberOfBoxesChecked" runat="server" TabIndex="12" MaxLength="1" style="text-align:center;" />
                        &nbsp; x1300 ...............  &nbsp; $<asp:TextBox ID="txtAddAllowLine1" runat="server" TabIndex="13"/>
                    </p>
                    <p>2. ADDITIONAL ALLOWANCES FOR DEDUCTIONS:</p>
                   
                    <p>A. Federal Estimated Itemized Deductions (If Itemizing Deductions).
                        $<asp:TextBox ID="txtAddAllowA" runat="server" TabIndex="14"/></p>


                    <p>
                        B. Georgia Standard Deduction (enter one):  <span style="margin-right: 100px; margin-left: 100px;">Single/Head of Household</span><span>$4600</span>
                    </p>
                    <p>
                        <span style="margin-left: 50px; margin-right: 306px;">Each spouse </span><span style="margin-right: 135px;">$3,000</span>
                        $<asp:TextBox ID="txtAddAllowB" runat="server" TabIndex="15" style="text-align:center;"></asp:TextBox>
                    </p>
                    <table style="width: 100%; background-color: transparent;">
                        <tr>
                            <td colspan ="10" style="width:70%">
                                C. Subtract Line B from Line A (If zero or less, enter zero)
                            </td>
                            <td colspan="2">
                                $<asp:TextBox ID="txtAddAllowC" runat="server" TabIndex="16" style="width:50%;text-align:center;"/>
                                <br /><br />
                            </td>
                            
                        </tr>
                        <tr>
                            <td colspan ="10" style="width:70%;">    
                                D. Allowable Deductions to Federal Adjusted Gross Income 
                            </td>
                            <td colspan ="2">
                                $<asp:TextBox ID="txtAddAllowD" runat="server" TabIndex="17" style="width:50%;text-align:center;"/>
                                <br /><br />
                            </td>
                        </tr>
                        <tr>
                            <td colspan ="10" style="width:70%;"> 
                                E. Add the Amounts on Lines 1, 2C, and 2D 
                            </td>
                            <td colspan ="2">
                                $<asp:TextBox ID="txtAddAllowE" runat="server" TabIndex="18" style="width:50%;text-align:center;" />
                                <br /><br />
                            </td>
                        </tr>
                        <tr>
                            <td colspan ="10" style="width:70%;"> 
                                F. Estimate of Taxable Income not Subject to Withholding 
                            </td>
                            <td colspan ="2">
                                $<asp:TextBox ID="txtAddAllowF" runat="server" TabIndex="19" style="width:50%;text-align:center;"/>
                                <br /><br />
                            </td>
                        </tr>
                        <tr>
                            <td colspan ="10" style="width:70%;"> 
                                G. Subtract Line F from Line E (if zero or less, stop here) 
                            </td>
                            <td colspan ="2">
                                $<asp:TextBox ID="txtAddAllowG" runat="server" TabIndex="20" style="width:50%;text-align:center;"/>
                                <br /><br />
                            </td>
                        </tr>
                        <tr>
                            <td colspan ="10" style="width:70%;"> 
                                H. Divide the Amount on Line G by $3,000. Enter total here and on Line 5 above 
                            </td>
                            <td colspan ="2">                               
                            </td>
                        </tr>
                        <tr>
                            <td colspan ="10" style="width:70%;"> 
                                (This is the maximum number of additional allowances you can claim. If the remainder is over $1,500 round up)
                            </td>
                            <td colspan ="2">
                                $<asp:TextBox ID="txtAddAllowH" runat="server" TabIndex="21" style="width:50%;text-align:center;"/>  
                                <br /><br />
                            </td>
                        </tr>
                        
                    </table>
                        
                    
                        
                </div>
            </div>
            <div class="row">
                <div class="col-md-12" style="border-bottom: 4px solid #000; padding:10px; margin-left:20px;">
                    <div class="col-md-6" style="padding: 0">
                        <p>
                            <b>7. LETTER USED </b>(Marital Status A, B, C, D, or E)
					<asp:TextBox ID="txtMaritalStatus" runat="server" Width="30%" TabIndex="22" Style="padding-left:20px"/>
                        </p>
                    </div>
                    <div class="col-md-6" style="padding: 0">
                        <p>
                            <b>TOTAL ALLOWANCES (Total of Lines 3 - 5) </b>
                            <asp:TextBox ID="txtTotalExemptions" runat="server" TabIndex="23" Width="36%" Style="padding-left:20px" />
                        </p>
                    </div>
                    <div class="col-md-12" style="padding: 0">
                        <p style="font-size: 15px;">(Employer: The letter indicates the tax tables in Em ployer’s Tax Guide)</p>
                    </div>
                </div>
                <div class="col-md-12" style="margin-top: 10px; border-bottom: 4px solid #000;">
                    <p>
                        <b>EXEMPT : </b>(Do not complete Lines 3 - 7 if claiming exempt) 
				<b style="font-size: 15px;">Read the Line 8 instructions on page 2 before completing this section.</b>
                    </p>
                    <p>
                        a) I claim exemption from withholding because I incurred no Georgia income tax liability last year and I do not expect to have a Georgia income tax liability this year. 
				<b>Check Here &nbsp;
                    <asp:CheckBox ID="chkExempt" runat="server" Text=""/>
                </b>
                    </p>
                    <p>
                        b) I certify that I am not subject to Georgia withholding because I meet the conditions set forth under the Servicemembers Civil Relief Act as amended by the Military Spouses Residency Relief Act as provided on page 2. My state of residence is
				<asp:TextBox ID="txtNotSubTOGeorgiaWithholdings" runat="server" />
                        My spouse’s (servicemember) state of residence is
				<asp:TextBox ID="txtSpousesStateOFRecidence" runat="server" />
                        The states of residence must be the same to be exempt.
				<b>Check Here</b> &nbsp;
                        <asp:CheckBox ID="chkMilitarySpouseRelief" runat="server" Text="" />
                    </p>
                </div>
                <div class="col-md-12" style="margin-top: 10px; border-bottom: 4px solid #000;">
                    <p>I certify under penalty of perjury that I am entitled to the number of withholding allowances or the exemption from withholding status claimed on this Form G-4. Also, I authorize my employer to deduct per pay period the additional amount listed above.</p>
                    <div class="col-md-6">
                        <p>
                            Employee's Signature
					<asp:TextBox ID="txtSignature" runat="server" TabIndex="24" Width="65%" Style="padding-left:20px"/>
                        </p>
                    </div>
                    <div class="col-md-6">
                        <p>
                            Date
					<asp:TextBox ID="SignatureDate" runat="server" TabIndex="25" Width="90%" Style="padding-left:20px"/>
                        </p>
                    </div>
                </div>
                <div class="col-md-12" style="margin-top: 10px;">
                    <p><b>Employer: Complete Line 9 and mail entire form only if the employee claims over 14 allowances or exempt from withholding. </b></p>
                    <p>If necessary, mail form to: Georgia Department of Revenue, Withholding Tax Unit, P.O. Box 49432, Atlanta , G A 30359</p>
                    <div class="col-md-6">
                        <p><b>9. EMPLOYER’S NAME AND ADDRESS</b></p>
                        <b><asp:Label ID="lblEmployerName" runat="server" Width="100%" /></b>
                        <b><asp:Label ID="lblEmployerFullAddress" runat="server" Width="100%" /></b>
                        <span><b><asp:Label ID="lblEmployerCity" runat="server" Width="10%" />, 
                                <asp:Label ID="lblEmployerState" runat="server" Width="5%" />
                                <asp:Label ID="lblEmployerZip" runat="server" Width="8%" /></b>
                        </span>
                    </div>
                    <div class="col-md-6">
                        <p><b>EMPLOYER’S FEIN:</b>
                            <b><asp:Label ID="lblEmployerFEIN" runat="server" Width="68%" /></b></p>
                        <p><b>EMPLOYER’S WH#:</b>
                            <asp:Label ID="lblEmployerWH" runat="server" Width="68%" /></p>
                    </div>
                    
                </div>
               
            </div>
            <div class="row" style="margin:10px;">
                <p>Do not accept forms claiming additional allowances unless the worksheet has been completed. Do not accept forms claiming exempt if numbers are written on Lines 3 - 7.</p>
           
                <p style="font-size: 14px;">G-4 (Rev. 02/15/19)</p>
            </div>

            <div class="row">
                <div class="clearfix">&nbsp;</div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 Text-center">
                    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valw4" OnClick="btnSave_Click" />
                </div>
                <div class="clearfix">&nbsp;</div>
            </div>
        </div>

        <script>
            var toggleIsHide = true;

            $(".instruction_toggle").hide();
            $(".instruction_toggle_btn").click(function () {
                if (toggleIsHide == true) {
                    $(this).attr("src", "img/minus.png");
                } else {
                    $(this).attr("src", "img/plus.png")
                }
                $(".instruction_toggle").toggle();
                toggleIsHide = !toggleIsHide;
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
