<%@ Page Title="MN State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_MN.aspx.vb" 
    Inherits="HReaseApp.EE_W4_MN" 
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

        function single(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarried]').prop("checked", false);
                $('input:checkbox[id$=chkMarriedWithhold]').prop("checked", false);
            }
        }
        function married(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingle]').prop("checked", false);
                $('input:checkbox[id$=chkMarriedWithhold]').prop("checked", false);
            }
        }
        function marriedwh(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarried]').prop("checked", false);
                $('input:checkbox[id$=chkSingle]').prop("checked", false);
            }
        }

        // This function will allow users to insert only numbers in the textboxes.
        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
  
        // This function will allow users to insert only numbers 0 or 1 in the textboxes.
        function onlyZeroOrOne(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;
            
            if (charCode == 48 || charCode == 49) 
                return true;
            return false;

            }

        function isDecimal(evt) {
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

        function exempt(checkbox) {
                if (checkbox.checked) {
                    //alert('Checkbox has been ticked!');
                    var a = '';
                    var b = '0';
                    $('input:checkbox[id$=chkHeaderSection2]').prop("checked", true);
                    $('input:checkbox[id$=chkHeaderSection1]').prop("checked", false);
                    $('input:text[id$=txtA]').val(a);
                    $('input:text[id$=txtB]').val(a);
                    $('input:text[id$=txtC]').val(a);
                    $('input:text[id$=txtE]').val(a);
                    $('input:text[id$=txtNumberOfDependents]').val(a);
                    $('input:text[id$=txtF]').val(b);
                    $('input:text[id$=txtTotalExemptions]').val(b);
                    $('input:text[id$=txtAdditionalWithholding]').val(b);                   
                    
                }
        }

        function notexempt(textbox) {
                if (textbox !='') {
                    //alert('Textbox is not empty');
                    $('input:checkbox[id$=chkHeaderSection1]').prop("checked", true);
                    $('input:checkbox[id$=chkHeaderSection2]').prop("checked", false);
                    $('input:checkbox[id$=chkExemptA]').prop("checked", false);
                    $('input:checkbox[id$=chkExemptB]').prop("checked", false);
                    $('input:checkbox[id$=chkExemptC]').prop("checked", false);
                    $('input:checkbox[id$=chkExemptD]').prop("checked", false);
                    $('input:checkbox[id$=chkExemptE]').prop("checked", false);
                    $('input:checkbox[id$=chkExemptF]').prop("checked", false);
                }
        }

        $(function () {
            var Boxa = $('input:text[id$=txtA]').keyup(foo);
            var Boxb = $('input:text[id$=txtB]').keyup(foo);
            var Boxc = $('input:text[id$=txtC]').keyup(foo);
            var Boxd = $('input:text[id$=txtNumberOfDependents]').keyup(foo);
            var Boxe = $('input:text[id$=txtE]').keyup(foo);
            var Box8 = $('input:text[id$=txtIDBox8]').keyup(foo);

            function foo() {
                var a = Boxa.val();
                var b = Boxb.val();
                var c = Boxc.val();
                var d = Boxd.val();
                var e = Boxe.val();
                var b8 = Box8.val();

                var sumf = 0
                sumf = add(a, b, c, d, e);
                var sum10 = (sumf + parseFloat(b8))
                $('input:text[id$=txtF]').val(sumf);
                $('input:text[id$=txtIDBox9]').val(sumf);               
                $('input:text[id$=txtIDBox10]').val(sum10);
                $('input:text[id$=txtTotalExemptions]').val(sum10);

            }
            function add() {
                var sumf = 0;
                for (var i = 0, j = arguments.length; i < j; i++) {
                    if (IsNumeric(arguments[i])) {
                        sumf += parseFloat(arguments[i]);
                    }
                }
                return sumf;
            }
            function IsNumeric(input) {
                return (input - 0) == input && input.length > 0;
            }
        });
        
        $(function () {
            var Box1 = $('input:text[id$=txtIDBox1]').keyup(foo);
            var Box2 = $('input:text[id$=txtIDBox2]').keyup(foo);
            var Box4 = $('input:text[id$=txtIDBox4]').keyup(foo);
            var Box6 = $('input:text[id$=txtIDBox6]').keyup(foo);
            var Box9 = $('input:text[id$=txtF]').keyup(foo);

            function foo() {
                var box1 = Box1.val();
                var box2 = Box2.val();
                var box4 = Box4.val();
                var box6 = Box6.val();
                var box9 = Box9.val();

                $('input:text[id$=txtIDBox9]').val(box9);

                var sum3 = 0
                var sum5 = 0
                var sum7 = 0
                var sum8 = 0
                var sum10 = 0

                sum3 = (box1 - box2);
                sum5 = (sum3 + parseFloat(box4))
                sum7 = (sum5 - parseFloat(box6))
                sum8 = parseFloat((sum7 / 4350).toFixed(0))
                sum10 = (sum8 + parseFloat(box9))
                $('input:text[id$=txtIDBox3]').val(sum3);
                $('input:text[id$=txtIDBox5]').val(sum5);
                $('input:text[id$=txtIDBox7]').val(sum7);
                $('input:text[id$=txtIDBox8]').val(sum8);
                $('input:text[id$=txtIDBox10]').val(sum10);
                $('input:text[id$=txtTotalExemptions]').val(sum10);

                if (sum3 < 0)
                    //alert('Getting here');
                    sum3 = 0
                sum5 = (sum3 + parseFloat(c4))
                sum7 = (sum5 - parseFloat(d6))
                sum8 = parseFloat((sum7 / 4350).toFixed(0))
                sum10 = (sum8 + parseFloat(box9))
                $('input:text[id$=txtIDBox3]').val(sum3);
                $('input:text[id$=txtIDBox5]').val(sum5);
                $('input:text[id$=txtIDBox7]').val(sum7);
                $('input:text[id$=txtIDBox8]').val(sum8);
                $('input:text[id$=txtIDBox10]').val(sum10);
                $('input:text[id$=txtTotalExemptions]').val(sum10);
            }
        });
        function disableinput() {
            return false;
        }
        //$(document).ready(function () {
        //    $("h4").click(function () {
        //        var single = $('input:checkbox[id$=chkSingle]');
        //        var married = $('input:checkbox[id$=chkMarried]');
        //        var marriedwh = $('input:checkbox[id$=chkMarriedWithhold]');
        //        var errormsg = "Please enter Marital Status";

        //        if (!single.is(":checked") && !married.is(":checked") && !marriedwh.is(":checked")) {
        //            $(".HREError").show();
        //            $('[id$=lblError]').text(errormsg);
        //            $('[id$=lblError]').text(errormsg);
        //        } else {
        //            $(".HREError").hide();
        //        }
        //    })
        //});
    </script>

    <div class="HREwrapper">
        <%--<h4><asp:Button ID="btnReview" Text="Review" runat="server" Enabled="true" EnableViewState="true" OnClientClick="testrequireddata()" AutoPostBack ="false" /></h4>--%>

        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>Minnesota Form W-4MN</b></h4>
                <br /><br />
            </div>
        </div>
        
        <div id="divTopHeader" class="form-group" style=" margin-top:-40px;">                  
            <div id="divError" runat="server" class="HREError" visible="false">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </div>
            <div class="form-group" style="display:inline;">
                <div id="divSuccess" runat="server" visible ="false" class="HRESuccess">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" ImageAlign="Left" />
                    <asp:Label ID="lblSuccess" runat="server"  Text="Form Complete" Width="50%"></asp:Label>
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
                </div>
            </div>
        </div>   

        <div id="divInstructionTitle" class="well HRESlateBlue HRERewrap" style="text-align:center; padding-bottom:20px;">
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px;" />
            <br />
        </div>

        <div id="divInstructions" class="instruction_toggle" style="margin-right:5%; font-size: large;"> 
            <div id="divPage1Instructions">
                <p style="color:black;">
                    <img src="../images/MinnDeptOfRevLogo.png" width="300" />
                </p>
                <p style="color:black; margin-top: 10px; font-size: 30px; font-weight:300;">
                    <b>Form W-4MN Employee Instructions</b>
                </p>
                <p style="color:black; padding: 5px 0px;">
                    <i>Complete this form for your employer to calculate the amount of Minnesota income tax to be withheld from your pay.</i>
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large">When should I complete Form W-4MN?</b> 
                    <br/>
                    Complete Form W-4MN if any of the following apply:

                    <ul list-style-type: disc;>
                        <li style="color:black;">You begin employment</li>
                        <li style="color:black;">You change your filing status</li>
                        <li style="color:black;">You reasonably expect to change your filing status in the next calendar year</li>
                        <li style="color:black;">Your personal or financial situation changes</li>
                        <li style="color:black;">You claim exempt from Minnesota withholding (see Section 2 instructions for qualifications)</li>
                    </ul>

                    If you have not had sufficient Minnesota income tax withheld from your wages, we may assess penalty and interest when you file your state 
                    income tax return.
                </p>
                <p style="color:black;">
                    <b>Note:</b> Your employer may be required to submit a copy of your Form W-4MN to the Minnesota Department of Revenue. You may be subject to a 
                    $500 penalty if you provide a false Form W-4MN.
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large">What if I have completed federal Form W-4?</b> 
                    <br/>
                    If you completed a 2021 Form W-4, you must complete Form W-4MN to determine your Minnesota withholding allowances. 
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large">What if I am exempt from Minnesota withholding?</b>
                </p>
                <p style="color:black;">
                    If you claim exempt from Minnesota withholding, complete only Section 2 of Form W-4MN and sign the form to validate it. If you complete 
                    Section 2, you must complete a new Form W-4MN by February 15 in each following year. 
                </p>
                <p style="color:black;">
                    You cannot claim exempt from withholding if all of these apply:
                </p>
                <ul>
                    <li style="color:black;">Another person can claim you as a dependent on their federal tax return</li>
                    <li style="color:black;">Your annual income exceeds $1,100</li>
                    <li style="color:black;">Your annual income includes more than $350 of unearned income</li>
                </ul>
                <p style="color:black;">
                    <b style="font-size:x-large">What if I am a nonresident alien for U.S. income taxes?</b>
                    <br />
                    If you are a nonresident alien, you are not allowed to claim exempt from withholding. You will check the single box for marital status 
                    regardless of your actual marital status and may enter one personal allowance on Step A. Enter zero on steps B, C, and E.
                </p>
                <p style="color:black;">
                    If you are resident of Canada, Mexico, South Korea, or India, and are allowed to claim dependents, you may enter the number of dependents on 
                    Step D.
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large">Section 1 — Minnesota Allowances Worksheet</b>
                    <br />
                    Complete Section 1 to find your allowances for Minnesota withholding tax. For regular wages, withholding must be based on allowances you 
                    claimed and may not be a flat amount or percentage of wages.
                </p>
                <p style="color:black;">
                    If you expect to owe more income tax for the year than will be withheld, you can claim fewer allowances or request additional Minnesota 
                    withholding from your wages. Enter the amount of additional Minnesota income tax you want withheld on line 2 of Section 1.
                </p>
                <p style="color:black;">
                    <b>Nonwage Income</b>
                    <br />
                    Consider making estimated payments if you have a large amount of “nonwage income.” Nonwage income (other than tax-exempt income) 
                    includes interest, dividends, net rental income, unemployment compensation, gambling winnings, prizes and awards, hobby income, capital 
                    gains, royalties, and partnership income. 
                </p>
                <p style="color:black;">
                    <b>Two Earners or Multiple Jobs</b>
                    <br />
                    If your spouse works or you have more than one job, figure the total number of allowances you are entitled to claim on all jobs using 
                    worksheets from only one Form W-4MN. Usually, your withholding will be more accurate when all allowances are claimed on the Form 
                    W-4MN for the highest paying job and zero allowances are claimed on the others.
                </p>
                <p style="color:black;">
                    <b>Head of Household Filing Status</b>
                    <br />
                    You may claim Head of Household as your filing status if you are unmarried and pay more than 50% of the costs of keeping up a home for 
                    yourself, your dependents, and other qualifying individuals. Enter “1” on Step E if you may claim Head of Household as your filing status on 
                    your tax return.
                </p>
                <p style="color:black;">
                    <b>What if I itemize deductions on my Minnesota return or have other nonwage income?</b>
                    <br />
                    Use the Itemized Deductions and Additional Income Worksheet to find your Minnesota withholding allowances. Complete Section 1 on page 1, 
                    then follow the steps in the worksheet on the next page to find additional allowances.
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large">Section 2 — Minnesota Exemption</b>
                    <br />
                    Your employer will not withhold Minnesota taxes from your pay if you are exempt from Minnesota withholding. You cannot claim exempt 
                    from withholding if all of these apply:
                </p>
                <ul>
                    <li style="color:black;">Another person can claim you as a dependent on their federal tax return</li>
                    <li style="color:black;">Your annual income exceeds $1,100</li>
                    <li style="color:black;">Your annual income includes more than $350 of unearned income</li>
                </ul>


            </div>
            <div id="divPage2Instructions" style="border-bottom: 2px solid black; margin-bottom:20px;">
                <div> 
                    <table style="background-color: white; font-size:large; color:black; border:2px solid black; padding: 5px 5px 5px 5px;">
                        <tr>
                            <td style="width:3%;"></td>
                            <td style="width:2%;"></td>
                            <td style="width:80%;"></td>
                            <td style="width:14%;"></td>
                            <td style="width:1%;"></td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <b>Itemized Deductions and Additional Income Worksheet </b>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="vertical-align:top;">
                                1
                            </td>
                            <td colspan="2">
                                Enter an estimate of your 2021 Minnesota itemized deductions. For 2021, you may have to reduce your itemized deductions 
                                if your income is over $199,850 ($99,925 for Married Filing Separately). 
                            </td>
                            <td colspan="1" style="vertical-align:bottom; border-bottom:1px solid black;">
                                <asp:TextBox ID="txtIDBox1" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="95%" />
                            </td>
                            <td colspan="1">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                &nbsp;
                            </td>
                        </tr>
                        <tr >
                            <td colspan="1" style="vertical-align:top;">
                                2
                            </td>
                            <td colspan="2">
                                Enter one of the following based on your filing status:  
                            </td>
                            <td colspan="1" style="vertical-align:top; border-bottom:1px solid black;">
                                <asp:TextBox ID="txtIDBox2" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="95%" />
                            </td>
                            <td colspan="1">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="vertical-align:top; text-align:right;">
                                a.
                            </td>
                            <td colspan="2">
                                $25,050 if Married Filing Jointly
                            </td>
                            <td colspan="1">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="vertical-align:top; text-align:right;">
                                b.
                            </td>
                            <td colspan="2">
                                $18,800 if Head of Household
                            </td>
                            <td colspan="1">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="vertical-align:top; text-align:right;">
                                c.
                            </td>
                            <td colspan="2">
                                $12,525 if Single or Married Filing Separately
                            </td>
                            <td colspan="1">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="vertical-align:top;">
                                3
                            </td>
                            <td colspan="2">
                                Subtract step 2 from step 1. If zero or less, enter 0. 
                            </td>
                            <td colspan="1" style="vertical-align:bottom; border-bottom:1px solid black;">
                                <asp:TextBox ID="txtIDBox3" runat="server" onblur="makeMoney(this)" Class="center" Width="95%" Backcolor="#E0E0E0" onkeypress="return disableinput()"/>
                            </td>
                            <td colspan="1">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="vertical-align:top;">
                                4
                            </td>
                            <td colspan="2">
                                Enter an estimate of your 2021 additional standard deduction (from page 11 of the Form M1 instructions). 
                            </td>
                            <td colspan="1" style="vertical-align:bottom; border-bottom:1px solid black;">
                                <asp:TextBox ID="txtIDBox4" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="95%" />
                            </td>
                            <td colspan="1">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="vertical-align:top;">
                                5
                            </td>
                            <td colspan="2">
                                Add steps 3 and 4. 
                            </td>
                            <td colspan="1" style="vertical-align:bottom; border-bottom:1px solid black;">
                                <asp:TextBox ID="txtIDBox5" runat="server" onpageload="zero(this)" Class="center" Width="95%" Backcolor="#E0E0E0" onkeypress="return disableinput()"/>
                            </td>
                            <td colspan="1">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="vertical-align:top;">
                                6
                            </td>
                            <td colspan="2">
                                Enter an estimate of your 2021 taxable nonwage income. 
                            </td>
                            <td colspan="1" style="vertical-align:bottom; border-bottom:1px solid black;">
                                <asp:TextBox ID="txtIDBox6" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="95%" />
                            </td>
                            <td colspan="1">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="vertical-align:top;">
                                7
                            </td>
                            <td colspan="2">
                                Subtract step 6 from step 5. If zero, enter 0. If less than zero, enter the amount in parentheses. 
                            </td>
                            <td colspan="1" style="vertical-align:bottom; border-bottom:1px solid black;">
                                <asp:TextBox ID="txtIDBox7" runat="server" onblur="makeMoney(this)" Class="center" Width="95%" Backcolor="#E0E0E0" onkeypress="return disableinput()"/>
                            </td>
                            <td colspan="1">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="vertical-align:top;">
                                8
                            </td>
                            <td colspan="2">
                                Divide the amount on step 7 by $4,350. If a negative amount, enter in parentheses. Do not include fractions. 
                            </td>
                            <td colspan="1" style="vertical-align:bottom; border-bottom:1px solid black;">
                                <asp:TextBox ID="txtIDBox8" runat="server" Class="center" Width="95%" Backcolor="#E0E0E0" onkeypress="{this.type='readonly'}"/>
                            </td>
                            <td colspan="1">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="vertical-align:top;">
                                9
                            </td>
                            <td colspan="2">
                                Enter the number on step F of Section 1 on page 1. 
                            </td>
                            <td colspan="1" style="vertical-align:bottom; border-bottom:1px solid black;">
                                <asp:TextBox ID="txtIDBox9" runat="server" Class="center" Width="95%" Backcolor="#E0E0E0" onkeypress="return disableinput()"/>
                            </td>
                            <td colspan="1">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="vertical-align:top;">
                                10
                            </td>
                            <td colspan="2">
                                Add step 8 and 9 and enter the total here. If zero or less, enter 0. Enter this amount on line 1 of page 1. 
                            </td>
                            <td colspan="1" style="vertical-align:bottom; border-bottom:1px solid black;">
                                <asp:TextBox ID="txtIDBox10" runat="server" Class="center" Width="95%" Backcolor="#E0E0E0" onkeypress="return disableinput()"/>
                            </td>
                            <td colspan="1">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </div>
                <div>
                    <br />
                    <b>Box A</b>
                    <br />
                    Check box A of Section 2 to claim exempt if all of these apply:
                </div>
                <ul>
                    <li style="color:black;">You meet the requirements to be exempt from federal withholding</li>
                    <li style="color:black;">You had no Minnesota income tax liability in the prior year and received a full refund of Minnesota tax withheld</li>
                    <li style="color:black;">You expect to have no Minnesota income tax liability for the current year</li>
                </ul>
                <div>
                    <b>Box B</b>
                    <br />
                    Check box B of Section 2 if you are not claiming exempt from federal withholding, but meet the second and third requirements for box A.
                </div>
                <div>
                    <br />
                    <b>Box C</b>
                    <br />
                    Check box C in Section 2 to claim exempt if all of these apply:
                </div>
                <ul>
                    <li style="color:black;">You are the spouse of a military member assigned to duty in Minnesota</li>
                    <li style="color:black;">You and your spouse are domiciled in another state</li>
                    <li style="color:black;">You are in Minnesota solely to be with your active duty military spouse member</li>
                </ul>
                <div>
                    <b>Boxes D-F</b>
                    <br />
                    If you receive income from the following sources, it is exempt from Minnesota withholding. Your employer will not withhold Minnesota tax 
                    from that income when you check the appropriate box in Section 2
                </div>
                <ul>
                    <li style="color:black;">
                        <b>Box D:</b> You receive wages as a member of an American Indian tribe living and working on the reservation of which you are an enrolled 
                        member. 
                    </li>
                    <li style="color:black;">
                        <b>Box E:</b> You receive wages for Minnesota National Guard (MNG) pay or for active duty U.S. military pay. MNG and active duty U.S. 
                        military members can claim exempt from Minnesota withholding on these wages, even if they are taxable federally. For more information, 
                        see Income Tax Fact Sheet 5, Military Personnel.
                    </li>
                    <li style="color:black;">
                        <b>Box F:</b> You receive a military pension or other military retirement pay calculated under U.S. Code title 10, sections 1401 through 1414, 1447 
                        through 1455, and 12733. You may claim exempt from Minnesota withholding on this income even if it is taxable federally</li>
                </ul>
                <p style="color:black;">
                    <b>Note:</b> You may not want to claim exempt if you (or your spouse if filing a joint return) expect to have other forms of income subject to 
                    Minnesota tax and you want to avoid owing tax at the end of the year.
                </p>
                <p style="color:black;">
                    If you complete Section 2, you must complete a new Form W-4MN by February 15 in each following year.
                </p>
                <p style="color:black;">
                    <b>Nonresident Alien</b>
                    <br />
                    If you are a nonresident alien for federal tax purposes, do not complete Section 2.
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large">Additional Minnesota Withholding</b>
                    <br />
                    If you would like an additional amount of tax to be deducted per payment period, enter the amount on line 2. Do not enter a percentage of the 
                    payment you want to be deducted.
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large">Use of Information</b>
                    <br />
                    All information on Form W-4MN is private by state law. It cannot be given to others without your consent, except to the Internal Revenue Service, 
                    to other states that guarantee the same privacy, and by court order. Your name, address, and Social Security Number are required for identification. 
                    Information about your allowances is required to determine your correct tax. We ask for your phone number so we can call if we have a question.
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large">Questions?</b>                    
                </p>
                <ul>
                    <li style="color:black;">Website: <a href="http://www.revenue.state.mn.us" target="_blank">www.revenue.state.mn.us</a></li>
                    <li style="color:black;">Email: <a href="mailto:mailto=withholding.tax@state.mn.us">withholding.tax@state.mn.us</a></li>
                    <li style="color:black;">Phone: 651-282‑9999 or 1-800-657-3594 (toll-free) </li>
                </ul>
            </div>
            <div id="divPage3Instructions" style="border-bottom: 2px solid black; margin-bottom:20px;">
                <p style="color:black; margin-top: 10px; font-size: 30px; font-weight:300;">
                    <b>Form W-4MN Employer Instructions</b>
                </p>
                <p style="color:black;">
                    <b>Form W-4MN Requirement</b>
                    <br />
                    Federal Form W-4 will not determine withholding allowances used to determine the amount of Minnesota withholding. Employees completing a 
                    2021 Form W-4 will need to complete 2021 Form W-4MN to determine the appropriate amount of Minnesota withholding.
                </p>
                <p style="color:black;">
                    <b>Lock-In Letters</b>
                    <br />
                    Internal Revenue Service (IRS) Letter 2800C tells you when the IRS believes your employee may have filed an incorrect federal Form W-4. If 
                    you receive this letter, you must provide the Minnesota Department of Revenue with a copy of the employee’s Form W-4MN. We will verify 
                    the number of allowances that the employee may claim for Minnesota purposes. Continue using the Form W-4MN you were using at the time 
                    you received Letter 2800C from the IRS, until we notify you to change the amount of allowances on the employee’s Form W-4MN. If the 
                    employee has not completed a Form W-4MN, have them complete the form and use the allowances calculated on that form until notified by the 
                    department.
                </p>
                <p style="color:black;">
                    <b>Form W-4MN Requirement</b>
                    <br />
                    Federal Form W-4 will not determine withholding allowances used to determine the amount of Minnesota withholding. Employees completing a 
                    2021 Form W-4 will need to complete 2021 Form W-4MN to determine the appropriate amount of Minnesota withholding.
                </p>
                <p style="color:black;">
                    <b>Use the amount on line 1 of page 1 for calculating the withholding tax for your employees.</b>
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large;">When does an employee complete Form W-4MN?</b>
                    <br />
                    Employees complete Form W-4MN when they begin employment or when their personal or financial situation changes.
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large;">How should I determine Minnesota withholding for an employee that does not complete Form W-4MN?</b>
                    <br />
                    If an employee does not complete Form W-4MN and they have a federal Form W-4 (from 2019 or prior years) on file, use the allowances on 
                    their federal Form W-4. Otherwise, withhold Minnesota tax as if the employee is single with zero withholding allowances.
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large;">What if my employee claims to be exempt from Minnesota withholding?</b>
                    <br />
                    If your employee claims exempt from Minnesota withholding, they must complete Section 2 of Form W-4MN. They must provide you with a 
                    new Form W-4MN by February 15 of each year. If you are paying an employee for wages that are exempt from withholding, such as Medicaid 
                    Waiver Payments or wages to H-2A visa workers, do not send us Form W-4MN.
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large;">When do I need to submit copies of a Form W-4MN to the department?</b>
                    <br />
                    You must send copies of Form W-4MN to us if any of these apply:
                </p>
                <ul>
                    <li style="color:black;">The employee claims more than 10 Minnesota withholding allowances</li>
                    <li style="color:black;">The employee checked box A or B under Section 2, and you reasonably expect the employee’s wages to exceed $200 per week</li>
                    <li style="color:black;">You believe the employee is not entitled to the number of allowances claimed</li>
                </ul>
                <p style="color:black;">
                    You do not need to submit Form W-4MN to us if the employee is asking to have additional Minnesota withholding deducted from their pay.
                </p>
                <p style="color:black;">
                    We may assess a $50 penalty for each Form W-4MN you do not file with us when required.
                </p>
                <p style="color:black;">
                    Mail Forms W-4MN to: 
                    <br />
                    <span style="padding-left:20px;">
                        Minnesota Department of Revenue 
                        <br />
                        Mail Station 6501 
                        <br />
                        600 N. Robert St.
                        <br />
                        St. Paul, MN 55146-6501
                    </span>
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large;">What if my employee is a resident of a reciprocity state?</b>
                    <br />
                    If your employee is a resident of North Dakota or Michigan and they do not want you to withhold Minnesota tax from their wages, they must 
                    complete Form MWR, Reciprocity Exemption/Affidavit of Residency. They must complete a Form MWR by February 28 of each year, or within 
                    30 days after they begin working or change their permanent residence. See Withholding Fact Sheet 20, Reciprocity - Employee Withholding, for 
                    more information.
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large;">What is an invalid Form W-4MN?</b>
                    <br />
                    A Form W-4MN is considered invalid if any of these apply:
                </p>
                <ul>
                    <li style="color:black;">There is any unauthorized change or addition to the form, including any change to the language certifying the form is correct</li>
                    <li style="color:black;">The employee indicates in any way the form is false by the date they provide you with the form</li>
                    <li style="color:black;">The form is incomplete or lacks the necessary signatures</li>
                    <li style="color:black;">Both Section 1 and Section 2 were completed</li>
                    <li style="color:black;">The employer information is incomplete</li>
                </ul>
                <p style="color:black;">
                    <b style="font-size:x-large;">What if I receive an invalid form?</b>
                    <br />
                    Do not use the invalid form to calculate Minnesota income tax withholding. Have the employee complete and submit a new Form W-4MN. 
                    If the employee does not give you a valid form, and you have an earlier Form W-4MN from them, use the earlier form to calculate their 
                    withholding. 
                </p>
                <p style="color:black;">
                    If a valid Form W-4MN is not completed by the employee, withhold taxes as if the employee is single and claiming zero withholding 
                    allowances.
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large;">What if my employee is a nonresident alien of the United States?</b>
                    <br />
                    If the wages to this employee are subject to income tax withholding, you will use Table 1 and the procedure under <b>Withholding Adjustment 
                    for Nonresident Alien Employees</b> in IRS Publication 15-T to determine the correct Minnesota withholding tax. Do not use this procedure 
                    for nonresident alien students from India and business apprentices from India. See IRS Notice 1392 for special instructions and withholding 
                    exceptions.
                </p>
            </div>
        </div>
 
        <div id="divMainForm" class="row" style="font-size:large; margin-left:1%; margin-right:6%;">
            <div id="divMainFormHeader">
                <p style="color:black;">
                    <img src="../images/MinnDeptOfRevLogo.png" width="300" />
                </p>
                 <p style="color:black; margin-top: 10px; font-size: 30px; font-weight:300;">
                    <b>2021 W-4MN, Minnesota Employee Withholding Allowance/Exemption Certificate</b>
                </p>
                <p style="color:black;">
                    <b style="font-size:x-large">Employees</b> 
                    <br/>
                    Complete Form W-4MN so that your employer can withhold the correct Minnesota income tax from your pay.  Consider completing a new Form W-4MN each year or when your personal or financial situation changes.
                </p>
            </div>
            <div id="divDemoandMaritalStatus">
                <table  style="width:100%; background-color:white;">
                    <tr >
                        <td style="width:30%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width: 2%;"></td>
                        <td style="width:38%;"></td>
                    </tr>
                    <tr style="border-top:1px solid black;">
                        <td colspan="1" >
                            <small>Employee’s First Name and Initial</small>
                        </td>
                        <td colspan="3" style="border-right:1px solid black;">
                            <small>Last Name</small>
                        </td>
                        <td colspan="2" >
                            <small>Employee’s Social Security Number</small>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="padding-left:5px; padding-bottom:1px; vertical-align:bottom;" class="HRETan">
                            <br />
                            <b><asp:Label ID="lblFName" runat="server" Width="98%"/></b>
                        </td>
                        <td colspan="3" style="padding-left:5px; padding-bottom:1px; vertical-align:bottom; border-right:1px solid black;" class="HRETan">
                            <br />
                            <b><asp:Label ID="lblLName" runat="server" Width="98%"/> </b>
                        </td>
                        <td colspan="2" style="padding-left:5px; padding-bottom:1px; vertical-align:bottom;" class="HRETan">
                            <br />
                            <b><asp:Label ID="lblSSNumber" runat="server" Width="98%" CssClass="center"/> </b>
                        </td>
                    </tr>
                    <tr style="border-top:1px solid black;">
                        <td colspan="4" style="border-right:1px solid black;">
                            <small>Permanent Address</small>
                        </td>
                        <td colspan="2">
                            <b>Marital Status <i>(Check one):</i></b>
                        </td>                        
                    </tr>
                    <tr>
                        <td colspan="4" style="padding-left:5px; padding-bottom:1px; border-bottom:1px solid black;" class="HRETan">
                            <br />
                            <b><asp:Label ID="lblAddressCombined" runat="server" Width="98%"/> </b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; vertical-align:top;">
                            <asp:CheckBox ID="chkSingle" runat="server" onclick="single(this)"/>                           
                        </td>
                        <td colspan="1" style="vertical-align:top; padding-bottom:5px;">
                            Single; Married, but legally separated; or Spouse is a nonresident alien
                        </td>
                    </tr>
                    <tr >
                        <td colspan="2">
                            <small>City</small>
                        </td>
                        <td colspan="1">
                            <small> State</small>
                        </td>
                        <td colspan="1">
                            <small> ZIP Code</small>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; vertical-align:top;">
                            <asp:CheckBox ID="chkMarried" runat="server" onclick="married(this)"/>                           
                        </td>
                        <td colspan="1" style="vertical-align:top; padding-bottom:10px;">
                            Married
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-left:5px; padding-bottom:1px;" class="HRETan">
                            <br />
                            <b><asp:Label ID="lblCity" runat="server" Width="98%"/></b>
                        </td>
                        <td colspan="1" style="padding-left:5px; padding-bottom:1px;" class="HRETan">
                            <br />
                            <b><asp:Label ID="lblState" runat="server" Width="98%"/></b>
                        </td>
                        <td style="padding-left:5px; padding-bottom:1px;" class="HRETan">
                            <br />
                            <b><asp:Label ID="lblZipCode" runat="server" Width="98%"/> </b>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; vertical-align:top;">
                            <asp:CheckBox ID="chkMarriedWithhold" runat="server" onclick="marriedwh(this)"/>                           
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Married, but withhold at higher Single rate
                        </td>
                    </tr>
                </table>
            </div>
            
            <div id="divMainFormSection1">
                <table style="width:100%; background-color:white; color:black; margin:0; padding:0;">
                    <tr>
                        <td style="width: 3%;"></td>
                        <td style="width: 3%;"></td>
                        <td style="width:80%;"></td>
                        <td style="width: 5%;"></td>
                        <td style="width:10%;"></td>
                    </tr>
                    <tr>
                        <td colspan="5" style="border-top:1px solid black;">                            
                            <br />
                            <b>Read instructions on back. Complete Section 1 OR Section 2, then sign and give the completed form to your employer. 
                               <br />
                                Do not complete both Section 1 and Section 2. Completing both sections will make the form invalid. </b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <asp:CheckBox ID="chkHeaderSection1" runat="server" onclick="notexempt(this)" />
                            &nbsp;<b>Section 1 — Determining Minnesota Allowances</b>
                        </td>
                    </tr>
                    <tr style="color:black; vertical-align:top;">
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <b>A</b>
                        </td>
                        <td colspan ="1" >
                            Enter “1” for yourself if no one else can claim you as a dependent
                        </td>
                        <td colspan="1" style="text-align:right;">
                            <b>A&nbsp;&nbsp;</b>  
                        </td>
                        <td colspan="1" style="padding-bottom:5px; min-width:70px;">
                            <asp:TextBox ID="txtA" runat="server" Placeholder="0 or 1" MaxLength="1" onkeypress="return onlyZeroOrOne()" onblur="notexempt(this)" Class="center" Width="95%" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="vertical-align:top; text-align:center;">
                            <b>B</b>
                        </td>
                        <td colspan ="1" style="vertical-align:top;">
                            Enter “1” if any of the following apply: 
                        </td>
                        <td colspan="1" style="text-align:right; vertical-align:bottom;">
                            <b>B&nbsp;&nbsp;</b>  
                        </td>
                        <td colspan="1" style="vertical-align:bottom;">
                            <asp:TextBox ID="txtB" runat="server" Placeholder="0 or 1" MaxLength="1" onkeypress="return onlyZeroOrOne()" onblur="notexempt(this)" Class="center" Width="95%" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                        <td colspan="1">
                            <ul >                            
                                <li style="color:black;">You are single and have only one job; or</li>
                                <li style="color:black;">You are married, have only one job, and your spouse does not work</li>
                                <li style="color:black;">Your wages from a second job or your spouse’s wages are $1500 or less</li>
                            </ul>
                        </td>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <b>C</b>
                        </td>
                        <td colspan ="1" >
                            Enter “1” if you are married. You may choose to enter “0” if you are married and have either a
                            working spouse or more than one job. <i>(Entering “0” may help you avoid having too little tax withheld.) </i>
                        </td>
                        <td colspan="1" style="text-align:right;">
                            <b>C&nbsp;&nbsp;</b>  
                        </td>
                        <td colspan="1">
                            <asp:TextBox ID="txtC" runat="server" Placeholder="0 or 1" MaxLength="1" onkeypress="return onlyZeroOrOne()" onblur="notexempt(this)" Class="center" Width="95%" />
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <b>D</b>
                        </td>
                        <td colspan ="1">
                            Enter the number of dependents (other than your spouse or yourself) you will claim on your tax return
                        </td>
                        <td colspan="1" style="text-align:right;">
                            <b>D&nbsp;&nbsp;</b>  
                        </td>
                        <td colspan="1" style="padding-bottom:5px;">
                            <asp:TextBox ID="txtNumberOfDependents" runat="server" Placeholder="" MaxLength="1" onkeypress="return onlyNumbers()" onblur="notexempt(this)" Class="center" Width="95%" />
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <b>E</b>
                        </td>
                        <td colspan ="1" >
                            Enter “1” if you will use the filing status Head of Household <i>(see instructions)</i>
                        </td>
                        <td colspan="1" style="text-align:right;">
                            <b>E&nbsp;&nbsp;</b>  
                        </td>
                        <td colspan="1">
                            <asp:TextBox ID="txtE" runat="server" Placeholder="0 or 1" MaxLength="1" onkeypress="return onlyZeroOrOne()" onblur="notexempt(this)" Class="center" Width="95%" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="vertical-align:top; text-align:center;">
                            <b>F</b>
                        </td>
                        <td colspan ="1" style="vertical-align:top;">
                            <b>Total number of allowances claimed.</b> Add steps A through E. 
                            <br />
                            If you plan to itemize deductions on your 2021 Minnesota income tax return, you may also complete the
                            Itemized Deductions and Additional Income Worksheet.
                        </td>
                        <td colspan="1" style="text-align:right; vertical-align:bottom;">
                            <b>F&nbsp;&nbsp;</b>  
                        </td>
                        <td colspan="1" style="vertical-align:bottom;">
                            <asp:TextBox ID="txtF" runat="server" Class="center" Width="95%" Backcolor="#E0E0E0" onkeypress="return disableinput()"/>
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <div id="divMainFormSection2">
                <table style="width:100%; background-color:white;">
                    <tr>
                        <td style="width: 3%;"></td>
                        <td style="width: 3%;"></td>
                        <td style="width: 2%;"></td>
                        <td style="width:93%;"></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <asp:CheckBox ID="chkHeaderSection2" runat="server" onclick="exempt(this)"/> 
                            <b>Section 2 — Exemption From Minnesota Withholding</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="3" style="padding-bottom:5px;">
                            Complete Section 2 if you claim to be exempt from Minnesota income tax withholding (see Section 2 instructions for qualifications). If applicable,
                            check one box below to indicate why you believe you are exempt:
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkExemptA" runat="server" onclick="exempt(this)"/> 
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <b>A</b>
                        </td>
                        <td colspan="1">
                            I meet the requirements and claim exempt from both federal and Minnesota income tax withholding
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkExemptB" runat="server" onclick="exempt(this)"/> 
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <b>B</b>
                        </td>
                        <td colspan="1">
                            Even though I did not claim exempt from federal withholding, I claim exempt from Minnesota withholding, because:
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            &nbsp;
                        </td>
                        <td colspan="1">
                            • I had no Minnesota income tax liability last year
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            &nbsp;
                        </td>
                        <td colspan="1">
                            • I received a refund of all Minnesota income tax withheld
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            &nbsp;
                        </td>
                        <td colspan="1">
                            • I expect to have no Minnesota income tax liability this year
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkExemptC" runat="server" onclick="exempt(this)"/> 
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <b>C</b>
                        </td>
                        <td colspan="1">
                            All of these apply:
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            &nbsp;
                        </td>
                        <td colspan="1">
                            • My spouse is a military service member assigned to a military location in Minnesota
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            &nbsp;
                        </td>
                        <td colspan="1">
                            • My domicile (legal residence) is in another state
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            &nbsp;
                        </td>
                        <td colspan="1">
                            • I am in Minnesota solely to be with my spouse. My state of domicile is <asp:TextBox ID="txtMilitaryState" runat="server" style="border-bottom:2px solid black; text-align:center;" /> 
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkExemptD" runat="server" onclick="exempt(this)"/> 
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <b>D</b>
                        </td>
                        <td colspan="1">
                            I am an American Indian that resides and works on a reservation
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkExemptE" runat="server" /> 
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <b>E</b>
                        </td>
                        <td colspan="1">
                            I am a member of the Minnesota National Guard or an active duty U.S. military member and claim exempt from Minnesota withholding
	                            on my military pay
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkExemptF" runat="server" onclick="exempt(this)"/> 
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <b>F</b>
                        </td>
                        <td colspan="1">
                            I receive a military pension or other military retirement pay as calculated under U.S. Code, title 10, sections 1401 through 1414, 1447
                                through 1455, and 12733, and I claim exempt from Minnesota withholding on this retirement pay
                        </td>
                    </tr>
                </table>
            </div>

            <div>
                <br />
                <table style="width:100%; background-color:white;">
                    <tr>
                        <td style="width: 2%;"></td>
                        <td style="width: 3%;"></td>
                        <td style="width:75%;"></td>
                        <td style="width: 5%;"></td>
                        <td style="width:15%;"></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <span>
                            <b>Minnesota Allowances and Additional Withholding</b>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            &nbsp;
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1">
                            <b>1</b>
                        </td>
                        <td colspan="1">
                            <b>Minnesota Allowances</b>  Enter Step F from Section 1 above or Step 10 of the Itemized Deductions Worksheet 
                        </td>
                        <td colspan="1" style="text-align:right;">
                            <b>1 &nbsp; &nbsp;</b>  
                        </td>
                        <td colspan="1" style="min-width:70px;">
                            <asp:TextBox ID="txtTotalExemptions" runat="server" Class="center" Width="95%" Backcolor="#E0E0E0" /> 
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1">
                            <b>2</b>
                        </td>
                        <td colspan="1">
                            <b>Additional Minnesota withholding you want deducted each pay period <i>(see instructions)</i> </b>
                        </td>
                        <td colspan="1" style="text-align:right;">
                            <b>2 &nbsp; &nbsp;</b>  
                        </td>
                        <td colspan="1" style="min-width:70px;">
                            <asp:TextBox ID="txtAdditionalWithholding" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" onkeyup="notexempt(this)" Class="center" Width="95%" /> 
                        </td>
                    </tr>
                </table>

                <table id="Signatureblock" style="width:100%; background-color:white;">
                    <tr>
                        <td style="width:40%;">&nbsp;</td>
                        <td style="width:30%;"></td>
                        <td style="width:30%;"></td>
                    </tr>
                    <tr>
                        <td colspan="3"> 
                            <i>I certify that all information provided in Section 1 <b>OR</b> Section 2 is correct. I understand there is a $500 penalty for filing a false withholding allowance/
                                exemption certificate. </i>
                        </td>
                    </tr>
                    <tr style="border-top:1px solid black; font-size:medium;">
                        <td colspan="1" >
                            <small>Employee’s Signature</small>
                                <br />
                                <asp:TextBox ID="txtSignature" runat="server" Width="98%" CssClass="left"/> 
                        </td>
                        <td colspan="1" >
                            <small>Date</small>
                            <br />
                            <asp:TextBox ID="txtSignatureDate" runat="server" Width="98%" CssClass="center"/> 
                        </td>
                        <td colspan="1">
                            <small>Daytime Phone</small>
                            <br />
                            <asp:TextBox ID="txtDayTimePhoneNo" runat="server" Width="98%" CssClass="left" />
                        </td>
                    </tr>
                    <tr style="border-top:1px solid black;">
                        <td colspan="3">
                            Employees: Give the completed form to your employer.
                        </td>
                    </tr>
                </table>

                <table style="width:100%; background-color:white;">
                    <tr>
                        <td style="width:40%;">&nbsp;</td>
                        <td style="width:10%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:30%;"></td>
                    </tr>
                    <tr>
                        <td colspan="5" style="font-size:20px;">
                            <b>Employers</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            See the employer instructions to determine if you must send a copy of this form to the Minnesota Department of Revenue. If required, enter your
                            information below and mail this form to the address in the instructions. (Incomplete forms are considered invalid.) We may assess a $50 penalty for
                            each required Form W-4MN not filed with us. Keep a copy for your records.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="border-top:1px solid black;">
                            <small>Name of Employer</small>
                            <div style="padding-left:5px; padding-bottom:1px;" class="HRETan">
                                <br />
                                <b><asp:Label ID="lblEmployerFullName" runat="server" Width="98%" /> </b>
                            </div>
                        </td>
                        <td colspan="2">
                            <small>Federal Employer ID Number (FEIN)</small>
                            <div style="padding-left:5px; padding-bottom:1px;" class="HRETan">
                                <br />
                                <b><asp:Label ID="lblEmployerFEIN" runat="server" Width="98%" /> </b>
                            </div>
                        </td>
                        <td colspan="1">
                            <small>Minnesota Tax ID Number</small>
                            <div style="padding-left:5px; padding-bottom:1px;" class="HRETan">
                                <br />
                                <b><asp:Label ID="lblEmployerMinnesotaTaxIDNo" runat="server" Width="98%" /> </b>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            <small>Address</small>
                            <div style="padding-left:5px; padding-bottom:1px;" class="HRETan">
                                <br />
                                <b><asp:Label ID="lblEmployerAddress" runat="server" Width="98%" /> </b>
                            </div>
                        </td>
                        <td colspan="2">
                            <small>City</small>
                            <div style="padding-left:5px; padding-bottom:1px;" class="HRETan">
                                <br />
                                <b><asp:Label ID="lblEmployerCity" runat="server" Width="98%"/> </b>
                            </div>
                        </td>
                        <td colspan="1">
                            <small>State</small>
                            <div style="padding-left:5px; padding-bottom:1px;" class="HRETan">
                                <br />
                                <b><asp:Label ID="lblEmployerState" runat="server" Width="98%" /> </b>
                            </div>
                        </td>
                        <td colspan="1">
                            <small>Zip Code</small>
                            <div style="padding-left:5px; padding-bottom:1px;" class="HRETan">
                                <br />
                                <b><asp:Label ID="lblEmployerZipCode" runat="server" Width="98%" /> </b>
                            </div>                    
                        </td>
                    </tr>                 
                </table>
            </div>
        </div>

        <div class="row">
            <div class="clearfix">&nbsp;</div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22"  Onclick="btnSave_Click"/>
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
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; text-align:center; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }
        input[type="label"] {background-color: #f5f5f0;}

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
    </style>

</asp:Content>
