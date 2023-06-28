<%@ Page Title="CA State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_CA.aspx.vb" 
    Inherits="HReaseApp.EE_W4_CA" 
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
                 $('input:checkbox[id$=CheckboxMarried]').prop("checked", false);
                 $('input:checkbox[id$=CheckboxHoH]').prop("checked", false);
             }
         }
         function married(checkbox) {
             if (checkbox.checked) {
                 $('input:checkbox[id$=CheckboxSingle]').prop("checked", false);
                 $('input:checkbox[id$=CheckboxHoH]').prop("checked", false);
             }
         }
         function hoh(checkbox) {
             if (checkbox.checked) {
                 $('input:checkbox[id$=CheckboxSingle]').prop("checked", false);
                 $('input:checkbox[id$=CheckboxMarried]').prop("checked", false);
             }
         }

         function exempt(checkbox) {
             if (checkbox.checked) {
                 //alert('Checkbox has been ticked!');
                 var a = '';
                 var b = '0';
                 $('input:text[id$=TextAllowancesWorksheetA]').val(b);
                 $('input:text[id$=TextAllowancesWorksheetB]').val(b);
                 $('input:text[id$=TextTotalExemptions]').val(b);
                 $('input:text[id$=TextAdditionalWithholding]').val(b);

             }
         }

         function notexempt(textbox) {
             if (textbox != '') {
                 //alert('Textbox is not empty');
                 $('input:checkbox[id$=CheckboxExempt1]').prop("checked", false);
                 $('input:checkbox[id$=CheckboxExempt2]').prop("checked", false);
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

         function onlyNumbersorDecimal(evt) {
             var e = event || evt; // for trans-browser compatibility
             var charCode = e.which || e.keyCode;

             if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
                 return false;
             return true;
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

         function makeMoney(source) {
             //Grab the value from the element
             var money = parseFloat(source.value, 10).toFixed(2);

             //Format your value
             source.value = money.toString();
         }
         // This function will allow users to insert only numbers 0 or 1 in the textboxes.
         function onlyZeroOrOne(evt) {
             var e = event || evt; // for trans-browser compatibility
             var charCode = e.which || e.keyCode;

             if (charCode == 48 || charCode == 49)
                 return true;
             return false;

         }
         //This function Summarizes Total Exemptions 1c on Main Form
         $(function () {
             var Boxa = $('input:text[id$=TextAllowancesWorksheetA]').keyup(foo);
             var Boxb = $('input:text[id$=TextAllowancesWorksheetB]').keyup(foo);

             function foo() {
                 var a = Boxa.val();
                 var b = Boxb.val();

                 var sumc = 0
                 sumc = add(a, b);
                 $('input:text[id$=TextTotalExemptions]').val(sumc);

             }
             function add() {
                 var sumc = 0;
                 for (var i = 0, j = arguments.length; i < j; i++) {
                     if (IsNumeric(arguments[i])) {
                         sumc += parseFloat(arguments[i]);
                     }
                 }
                 return sumc;
             }
             function IsNumeric(input) {
                 return (input - 0) == input && input.length > 0;
             }
         });
         //This function Summarizes Total for WorksheetA
         $(function () {
             var Boxa = $('input:text[id$=TextAllowance1A]').keyup(foo);
             var Boxb = $('input:text[id$=TextAllowance1B]').keyup(foo);
             var Boxc = $('input:text[id$=TextAllowance1C]').keyup(foo);
             var Boxd = $('input:text[id$=TextAllowance1D]').keyup(foo);
             var Boxe = $('input:text[id$=TextAllowance1E]').keyup(foo);

             function foo() {
                 var a = Boxa.val();
                 var b = Boxb.val();
                 var c = Boxc.val();
                 var d = Boxd.val();
                 var e = Boxe.val();

                 var sumf = 0
                 sumf = add(a, b, c, d, e);
                 $('input:text[id$=TextAllowance1F]').val(sumf);

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

         //This function Calculates WorksheetB Line 3
         //$(function () {
         //    Box1 = $('input:text[id$=txtDeduction1]').keyup(foo);
         //    Box2 = $('input:text[id$=txtDeduction2]').keyup(foo);
             
         //    function foo() {
         //        var box1 = Box1.val();
         //        var box2 = Box2.val();
         //        var sum3 = 0
         //        sum3 = subtract(box1, box2);
         //        if (sum3 < 0)
         //            sum3 = 0
         //        $('input:text[id$=txtDeduction3]').val(sum3);

         //    }
         //    function subtract() {
         //        var sum3 = 0;
         //        for (var i = 0, j = arguments.length; i < j; i--) {
         //            if (IsNumeric(arguments[i])) {
         //                sum3 += parseFloat(arguments[i]);
         //            }
         //        }
         //        return sum3;
         //    }
         //    function IsNumeric(input) {
         //        return (input - 0) == input && input.length > 0;
         //    }
         //});
         ////This function Calculates WorksheetB Line 5
         //$(function () {
         //    var Box3 = $('input:text[id$=txtDeduction3]').keyup(foo);
         //    var Box4 = $('input:text[id$=txtDeduction4]').keyup(foo);

         //    function foo() {
         //        var box3 = Box3.val();
         //        var box4 = Box4.val();

         //        var sum5 = 0
         //        sum5 = add(box3, box4);
         //        $('input:text[id$=txtDeduction5]').val(sum5);

         //    }
         //    function add() {
         //        var sum5 = 0;
         //        for (var i = 0, j = arguments.length; i < j; i++) {
         //            if (IsNumeric(arguments[i])) {
         //                sum5 += parseFloat(arguments[i]);
         //            }
         //        }
         //        return sum5;
         //    }
         //    function IsNumeric(input) {
         //        return (input - 0) == input && input.length > 0;
         //    }
         //});

     </script>

    <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>California Form DE 4 </b></h4>
                <br /><br />
            </div>
        </div>
        
        <div id="DivTopHeader" class="form-group" >                  
            <div id="DivError" runat="server" visible="false" class="HREError" style="height:auto;">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="LabelError" runat="server" Text="There was an error."></asp:Label>
            </div>
            <div class="form-group" style="display:inline;">
                <div id="DivSuccess" runat="server" visible ="false" class="HRESuccess">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" ImageAlign="Left" />
                    <asp:Label ID="LabelSuccess" runat="server"  Text="Form Complete" Width="50%"></asp:Label>
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

        <div id="DivInstructions" class="instruction_toggle" style="text-align:center; margin-right:5%; font-size: medium; padding:5px 5px 5px 5px;">
            <table id="TableInstructionsPage1">
                <tr>
                    <td style="width:48%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:49%;"></td>
                </tr>
                <tr>
                    <td colspan="1">
                        <p><b>PURPOSE:</b> This certificate, DE 4, is for <b>California Personal
                            Income Tax (PIT) withholding </b>  purposes only. The DE 4 is used to
                            compute the amount of taxes to be withheld from your wages,
                            by your employer, to accurately reflect your state tax withholding
                            obligation.

                        </p>
                        <p>
                            Beginning January 1, 2020, Employee’s Withholding Allowance
                            Certificate (Form W-4) from the Internal Revenue Service (IRS) will
                            be used for federal income tax withholding only. You must file the
                            state form Employee’s Withholding Allowance Certificate (DE 4)
                            to determine the appropriate California Personal Income Tax (PIT)
                            withholding. 
                        </p>
                        <p>If you do not provide your employer with a withholding certificate,
                            the employer must use Single with Zero withholding allowance.</p>
                        <p><b>CHECK YOUR WITHHOLDING: </b> After your DE 4 takes effect,
                            compare the state income tax withheld with your estimated total
                            annual tax. For state withholding, use the worksheets on this form.
                        </p>
                        <p><b>EXEMPTION FROM WITHHOLDING: </b> If you wish to claim
                            exempt, complete the federal Form W-4 and the state DE 4. You
                            may claim exempt from withholding California income tax if you
                            meet both of the following conditions for exemption:
                        </p>
                    </td>
                    <td colspan="1"></td>
                    <td colspan="1" style="padding-right: 3px; vertical-align:top;">
                        <ol>
                            <li style="padding-bottom:10px;">
                                You did not owe any federal/state income tax last year, and</li>
                            <li>
                                You do not expect to owe any federal/state income tax this
                                year. The exemption is good for one year</li>
                        </ol>
                        <p>If you continue to qualify for the exempt filing status, a new DE 4
                            designating EXEMPT must be submitted by February 15 each year
                            to continue your exemption. If you are not having federal/state
                            income tax withheld this year but expect to have a tax liability
                            next year, you are required to give your employer a new DE 4 by
                            December 1.
                        </p>
                        <p><b>Member Service Civil Relief Act: </b> Under this act, as provided by the
                            Military Spouses Residency Relief Act and the Veterans Benefits and
                            Transition Act of 2018, you may be exempt from California income
                            tax on your wages if
                        </p>
                        <ol type="i">
                            <li style="padding-bottom:10px;"> 
                                your spouse is a member of the armed forces present in
                                California in compliance with military orders;
                            </li>
                            <li style="padding-bottom:10px;"> 
                                you are present in California solely to be with your spouse; and
                            </li>
                            <li style="padding-bottom:10px;"> 
                                you maintain your domicile in another state.
                            </li>
                        </ol>
                        <p>If you claim exemption under <b>this</b> act, <b>check the box on Line 4.</b>
                            You may be required to provide proof of exemption upon request.</p>
                    </td>
                </tr>
                
            </table>
            <table id="TableFooterPage1" style="border-bottom: 1px solid darkgrey;">
                <tr>
                    <td style="width:40%;"> </td>
                    <td style="width:45%;"> </td>
                    <td style="width:5%;"> </td>
                </tr>
                <tr>
                    <td colspan="1" style="float:left;">
                        DE 4 Rev. 50 (1-21) <b>(INTERNET) </b>
                    </td>
                    <td colspan="1" style="text-align: left;">
                        Page 1 of 4
                    </td>
                    <td colspan="1" style="text-align:right;">
                        CU
                    </td>
                </tr>                
            </table>
            <table id="TableInstructionsPage2" style="margin-top:10px;">
                <tr>
                    <td style="width:48%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:49%;"></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <p>
                            The California Employer’s Guide (DE 44) (PDF, 2.4 MB) <a href="http://edd.ca.gov/pdf_pub_ctr/de44.pdf" target="_blank">(edd.ca.gov/pdf_pub_ctr/de44.pdf)</a> provides the income tax
                            withholding tables. This publication may be found by visiting Forms and Publications <a href="http://edd.ca.gov/Payroll_Taxes/Forms_and_Publications.htm" target="_blank">(edd.ca.gov/Payroll_Taxes/Forms_and_Publications.htm).</a> 
                            To assist you in calculating your tax liability, please visit the Franchise Tax Board (FTB) <a href="http://ftb.ca.gov" target="_blank">(ftb.ca.gov)</a>.
                        </p>
                        <p>
                            If you need information on your last California Resident Income Tax Return (FTB Form 540), visit the Franchise Tax Board
                            (FTB) <a href="http://ftb.ca.gov" target="_blank">(ftb.ca.gov)</a>.
                        </p>
                    </td>
                </tr>   
                <tr>
                    <td colspan="1">
                        <b>NOTIFICATION: </b>The burden of proof rests with the
                        employee to show the correct California income tax
                        withholding. Pursuant to section 4340-1(e) of Title 22,
                        California Code of Regulations (CCR), the FTB or the EDD
                        may, by special direction in writing, require an employer to
                        submit a Form W-4 or DE 4 when such forms are necessary
                        for the administration of the withholding tax programs.
                    </td>
                    <td colspan="1"></td>
                    <td colspan="1">
                        <b>PENALTY: </b>You may be fined $500 if you file, with no
                        reasonable basis, a DE 4 that results in less tax being
                        withheld than is properly allowable. In addition, criminal
                        penalties apply for willfully supplying false or fraudulent
                        information or failing to supply information requiring an
                        increase in withholding. This is provided by section 13101
                        of the California Unemployment Insurance Code and
                        section 19176 of the Revenue and Taxation Code.
                    </td>
                </tr>
            </table>
            <table id="FooterPage2" style="border-bottom: 1px solid darkgrey; margin-bottom:20px;">
                <tr>
                    <td style="width:40%;"> </td>
                    <td style="width:45%;"> </td>
                    <td style="width:5%;"> </td>
                </tr>
                <tr>
                    <td colspan="1" style="float:left;">
                        DE 4 Rev. 50 (1-21) <b>(INTERNET) </b>
                    </td>
                    <td colspan="1" style="text-align: left;">
                        Page 2 of 4
                    </td>
                    <td colspan="1"></td>
                </tr>                
            </table>
       </div>
       
        <div id="PersonalAllowancesHeaderBar" class="well HRESlateBlue HRERewrap" style="text-align:center; max-height:100px;">
	        <span><b>PERSONAL ALLOWANCES WORKSHEET</b></span>
	        <img src="img/plus.png" class="instruction_toggle_btn1" style="float: right; width: 30px; max-height:100px; padding-bottom:10px;" />
        </div>

        <div id="PersonalAllowancesWorksheet" class="form-group instruction_toggle1" style="margin-right:5%;">    
            <table id="TableWorksheetInstructions" style="width: 100%;">
                <tr>
                    <td style="width:48%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:49%;"></td>
                </tr>
                <tr>
                    <td colspan="3" style="font-size:x-large; width:100%; border-bottom:2px solid black; text-align:center; font-weight:500; padding-bottom:10px;">
                        WORKSHEETS
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style=" font-weight:bold; text-align:left;">
                        INSTRUCTIONS — 1 — ALLOWANCES*
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        <p>
                            When determining your withholding allowances, you must consider
				            your personal situation:<br/>
                            — Do you claim allowances for dependents or blindness?<br/>
                            — Will you itemize your deductions?<br/>
                            — Do you have more than one income coming into the household?
                        </p>
                        <p>
                            <b>TWO-EARNERS/MULTIPLE INCOMES: </b>: When earnings are derived
                            from more than one source, under-withholding may occur. If you have a
                            working spouse or more than one job, it is best to check the box “SINGLE
                            or MARRIED (with two or more incomes).” Figure the total number of
                            allowances you are entitled to claim on all jobs using only one DE 4 form.
                            Claim allowances with <b>one</b> employer.
                        </p>
                        <p>
                            Do <b>not</b> claim the same allowances with more than one employer. Your
                            withholding will usually be most accurate when all allowances are claimed
                            on the DE 4 filed for the highest paying job and zero allowances are
                            claimed for the others.
                        </p>
                    </td>
                    <td colspan="1"></td> 
                    <td colspan="1">
                        <b>MARRIED BUT NOT LIVING WITH YOUR SPOUSE:</b> You may
					        check the “Head of Household” marital status box if you meet all
					        of the following tests:
                        <ol style="list-style-type: decimal; padding-left: 16px;">
                            <li>Your spouse will not live with you <b>at any time</b> during the year; </li>
                            <li>You will furnish over half of the cost of maintaining a home
						        for the entire year for yourself and your child or stepchild who
					        qualifies as your dependent; <b>and</b> </li>
                            <li>You will file a separate return for the year </li>
                        </ol>

                        <p>
                            <b>HEAD OF HOUSEHOLD: </b>To qualify, you must be unmarried or
					        legally separated from your spouse and pay more than 50% of the
					        costs of maintaining a home for the <b>entire</b> year for yourself and your
					        dependent(s) or other qualifying individuals. Cost of maintaining the
					        home includes such items as rent, property insurance, property taxes,
					        mortgage interest, repairs, utilities, and cost of food. It does not include
					        the individual’s personal expenses or any amount which represents value
				            of services performed by a member of the household of the taxpayer.
                        </p>
                    </td> 
                </tr>
            </table>
            <table id="TableWorksheetAHeader" style="width: 100%; border: 0; border-top: 2px solid black; font-size:large; font-weight:bold;">
                <tr>
                    <td style="width:40%; vertical-align:top;"></td>
                    <td style="width:60%; vertical-align:top;"></td>
                </tr>
                <tr>
                    <td colspan="1">
                        WORKSHEET A
                    </td>
                    <td colspan="1">
                        REGULAR WITHHOLDING ALLOWANCES
                    </td>
                </tr>
            </table>
            <table id="TableWorksheetA" style="width: 100%; border: 0; border-top: 2px solid black;">
                <tr>
                    <td style="width:3%;"></td>
                    <td style="width:87%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:7%;"></td>
                </tr> 
                <tr>
                    <td colspan="1">
                        (A) 
                    </td>
                    <td colspan="1">
                        Allowance for yourself — enter 1. 
                    </td>
                    <td colspan="1">
                        (A)
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextAllowance1A" runat="server" maxlength = "1" Width="100px" CssClass="center" onkeypress="return onlyZeroOrOne()"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        (B) 
                    </td>
                    <td colspan="1">
                        Allowance for your spouse (if not separately claimed by your spouse) — enter 1. 
                    </td>
                    <td colspan="1">
                        (B)
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextAllowance1B" runat="server" Width="100px" CssClass="center" onkeypress="return onlyZeroOrOne()"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        (C) 
                    </td>
                    <td colspan="1">
                        Allowance for blindness — yourself — enter 1. 
                    </td>
                    <td colspan="1">
                        (C)
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextAllowance1C" runat="server" maxlength = "1" Width="100px" CssClass="center" onkeypress="return onlyZeroOrOne()"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        (D) 
                    </td>
                    <td colspan="1">
                        Allowance for blindness — your spouse (if not separately claimed by your spouse) — enter 1.
                    </td>
                    <td colspan="1">
                        (D)
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextAllowance1D" runat="server" maxlength = "1" Width="100px" CssClass="center" onkeypress="return onlyZeroOrOne()"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        (E) 
                    </td>
                    <td colspan="1">
                        Allowance(s) for dependent(s) — do not include yourself or your spouse.
                    </td>
                    <td colspan="1">
                        (E)
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextAllowance1E" runat="server" maxlength = "2" Width="100px" CssClass="center" onkeypress="return onlyNumbers()"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        (F) 
                    </td>
                    <td colspan="1">
                        Total — add lines (A) through (E) above. 
                    </td>
                    <td colspan="1">
                        (F)
                    </td>
                    <td colspan="1" style="padding-bottom:10px;">
                        <asp:TextBox ID="TextAllowance1F" runat="server" maxlength = "1" Width="100px" CssClass="center" onkeypress="return onlyNumbers()"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <table id="TableWorksheetInstructions2" style="width: 100%; border: 0; border-top: 2px solid black;">
                <tr>
                    <td style="font-size:large; font-weight:bold; margin-bottom:5px;">
                       INSTRUCTIONS — 2 — (OPTIONAL) ADDITIONAL WITHHOLDING ALLOWANCES
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>
                        If you expect to itemize deductions on your California income tax return, you can claim additional withholding allowances. Use Worksheet B to determine 
                        whether your expected estimated deductions may entitle you to claim <b>one or more additional</b> withholding allowances. Use last year’s FTB Form 540 as a 
                        model to calculate this year’s withholding amounts.
                    </p>
                    <p>
                        Do not include deferred compensation, qualified pension payments, or flexible benefits, etc., that are deducted from your gross pay but are not taxed on this 
                        worksheet.
                    </p>
                    <p>
                        You may reduce the amount of tax withheld from your wages by claiming one additional withholding allowance for each $1,000, or fraction of $1,000, by 
                        which you expect your estimated deductions for the year to exceed your allowable standard deduction.
                    </p> 
                    </td>
                </tr>
            </table>
            <table id="TableWorksheetBHeader" style="width: 100%; border: 0; border-top: 2px solid black; font-size:large; font-weight:bold;">
                <tr>
                    <td style="width:45%; vertical-align:top;"></td>
                    <td style="width:55%; vertical-align:top;"></td>
                </tr>
                <tr>
                    <td colspan="1">
                        WORKSHEET B
                    </td>
                    <td colspan="1">
                       ESTIMATED DEDUCTIONS
                    </td>
                </tr>
               <tr>
                   <td colspan="2" style="font-weight:normal;">
                        Use this worksheet <b>only</b> if you plan to itemize deductions, claim certain adjustments to income, or have a large amount of nonwage income not subject to 
                        withholding.
                   </td>
               </tr>
            </table>
            <table id="TableWorksheetB" >
                <tr>
                    <td style="width:3%;"></td>
                    <td style="width:84%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:10%;"></td>
                </tr> 
                <tr>
                    <td colspan="1">
                        1. 
                    </td>
                    <td colspan="1">
                        Enter an estimate of your itemized deductions for California taxes for this tax year as listed in the schedules in the FTB Form 540 
                    </td>
                    <td colspan="1">
                        1.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextDeduction1" runat="server" Width="150px" CssClass="right" onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        2. 
                    </td>
                    <td colspan="1">
                        Enter $9,202 if married filing joint with two or more allowances, unmarried head of household, or qualifying widow(er) 
                        with dependent(s) or $4,601 if single or married filing separately, dual income married, or married with multiple employers 
                    </td>
                    <td colspan="1">
                        2.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextDeduction2" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        3. 
                    </td>
                    <td colspan="1">
                        Subtract line 2 from line 1, enter difference 
                    </td>
                    <td colspan="1">
                        3.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextDeduction3" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        4. 
                    </td>
                    <td colspan="1">
                        Enter an estimate of your adjustments to income (alimony payments, IRA deposits)
                    </td>
                    <td colspan="1">
                        4.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextDeduction4" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        5. 
                    </td>
                    <td colspan="1">
                        Add line 4 to line 3, enter sum
                    </td>
                    <td colspan="1">
                        5.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextDeduction5" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       6. 
                    </td>
                    <td colspan="1">
                        Enter an estimate of your nonwage income (dividends, interest income, alimony receipts)
                    </td>
                    <td colspan="1">
                        6.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextDeduction6" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       7. 
                    </td>
                    <td colspan="1">
                        If line 5 is greater than line 6 (if less, see below [go to line 9]);<br />
						Subtract line 6 from line 5, enter difference
                    </td>
                    <td colspan="1">
                        7.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextDeduction7" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       8. 
                    </td>
                    <td colspan="1">
                        Divide the amount on line 7 by $1,000, round any fraction to the nearest whole number<br />
                        Add this number to Line F of Worksheet A and enter it on line 1 of the DE 4. Complete Worksheet C, if needed, otherwise <b>stop here.</b>
                    </td>
                    <td colspan="1">
                        8.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextDeduction8" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       9. 
                    </td>
                    <td colspan="1">
                        If line 6 is greater than line 5;<br />
						Enter amount from line 6 (nonwage income).
                    </td>
                    <td colspan="1">
                        9.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextDeduction9" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       10. 
                    </td>
                    <td colspan="1">
                        Enter amount from line 5 (deductions)
                    </td>
                    <td colspan="1">
                        10.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextDeduction10" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       11. 
                    </td>
                    <td colspan="1">
                        Subtract line 10 from line 9, enter difference.  Then, complete Worksheet C
                    </td>
                    <td colspan="1">
                        11.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextDeduction11" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td colspan="4">
                        <p>
                            *Wages paid to registered domestic partners will be treated the same for state income tax purposes as wages paid to spouses for California PIT withholding
                            and PIT wages. This law does not impact federal income tax law. A registered domestic partner means an individual partner in a domestic partner
                            relationship within the meaning of section 297 of the Family Code. For more information, please call our Taxpayer Assistance Center at 1-888-745-3886.
                        </p>

                    </td>
                </tr>
            </table>
            <table id="FooterPage3" style="margin-bottom:20px;">
                <tr>
                    <td style="width:40%;"> </td>
                    <td style="width:45%;"> </td>
                    <td style="width:5%;"> </td>
                </tr>
                <tr>
                    <td colspan="1" style="float:left;">
                        DE 4 Rev. 50 (1-21) <b>(INTERNET) </b>
                    </td>
                    <td colspan="1" style="text-align: left;">
                        Page 3 of 4
                    </td>
                    <td colspan="1"></td>
                </tr>                
            </table>
            <table id="TableWorksheetCHeader" style="width: 100%; border: 0; border-top: 2px solid black; font-size:large; font-weight:bold;">
                <tr>
                    <td style="width:45%; vertical-align:top;"></td>
                    <td style="width:55%; vertical-align:top;"></td>
                </tr>
                <tr>
                    <td colspan="1">
                        WORKSHEET C
                    </td>
                    <td colspan="1">
                       ADDITIONAL TAX WITHHOLDING AND ESTIMATED TAX
                    </td>
                </tr>
            </table>
            <table id="TableWorksheetC" style="border-bottom:2px solid black;">
                <tr>
                    <td style="width:3%;"></td>
                    <td style="width:84%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:10%;"></td>
                </tr> 
                <tr>
                    <td colspan="1">
                        1. 
                    </td>
                    <td colspan="1">
                        Enter estimate of total wages for tax year 2021. 
                    </td>
                    <td colspan="1">
                        1.
                    </td>
                    <td colspan="1" style="float:right; padding-right:10px;">
                        <asp:TextBox ID="TextEstimatedTax1" runat="server" Width="150px"  CssClass="right" onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        2. 
                    </td>
                    <td colspan="1">
                        Enter estimate of nonwage income (line 6 of Worksheet B).
                    </td>
                    <td colspan="1">
                        2.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextEstimatedTax2" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        3. 
                    </td>
                    <td colspan="1">
                        Add line 1 and line 2. Enter sum.
                    </td>
                    <td colspan="1">
                        3.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextEstimatedTax3" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        4. 
                    </td>
                    <td colspan="1">
                        Enter itemized deductions or standard deduction (line 1 or 2 of Worksheet B, whichever is largest). 
                    </td>
                    <td colspan="1">
                        4.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextEstimatedTax4" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        5. 
                    </td>
                    <td colspan="1">
                        Enter adjustments to income (line 4 of Worksheet B). 
                    </td>
                    <td colspan="1">
                        5.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextEstimatedTax5" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       6. 
                    </td>
                    <td colspan="1">
                        Add line 4 and line 5. Enter sum.
                    </td>
                    <td colspan="1">
                        6.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextEstimatedTax6" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       7. 
                    </td>
                    <td colspan="1">
                        Subtract line 6 from line 3. Enter difference.
                    </td>
                    <td colspan="1">
                        7.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextEstimatedTax7" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       8. 
                    </td>
                    <td colspan="1">
                        Figure your tax liability for the amount on line 7 by using the 2021 tax rate schedules below.
                    </td>
                    <td colspan="1">
                        8.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextEstimatedTax8" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       9. 
                    </td>
                    <td colspan="1">
                        Enter personal exemptions (line F of Worksheet A x $136.40). 
                    </td>
                    <td colspan="1">
                        9.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextEstimatedTax9" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       10. 
                    </td>
                    <td colspan="1">
                        Subtract line 9 from line 8. Enter difference.
                    </td>
                    <td colspan="1">
                        10.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextEstimatedTax10" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       11. 
                    </td>
                    <td colspan="1">
                        Enter any tax credits. (See FTB Form 540).
                    </td>
                    <td colspan="1">
                        11.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextEstimatedTax11" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       12. 
                    </td>
                    <td colspan="1">
                        Subtract line 11 from line 10. Enter difference. This is your total tax liability.
                    </td>
                    <td colspan="1">
                        12.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextEstimatedTax12" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       13. 
                    </td>
                    <td colspan="1">
                        Calculate the tax withheld and estimated to be withheld during 2021. Contact your employer to request 
                        the amount that will be withheld on your wages based on the marital status and number of withholding 
                        allowances you will claim for 2021. Multiply the estimated amount to be withheld by the number of pay 
                        periods left in the year. Add the total to the amount already withheld for 2021.
                    </td>
                    <td colspan="1">
                        13.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextEstimatedTax13" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       14. 
                    </td>
                    <td colspan="1">
                        Subtract line 13 from line 12. Enter difference. If this is less than zero, you do not need to have additional 
                        taxes withheld. 
                    </td>
                    <td colspan="1">
                        14.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextEstimatedTax14" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                       15. 
                    </td>
                    <td colspan="1">
                        Divide line 14 by the number of pay periods remaining in the year. Enter this figure on line 2 of the DE 4. 
                    </td>
                    <td colspan="1">
                        15.
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextEstimatedTax15" runat="server" Width="150px" CssClass="right"  onkeypress="return onlyNumbersorDecimal()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <p>
                            <b>NOTE: </b> Your employer is not required to withhold the additional amount requested on line 2 of your DE 4. If your employer does not agree to withhold the
                            additional amount, you may increase your withholdings as much as possible by using the “single” status with “zero” allowances. If the amount withheld still
                            results in an underpayment of state income taxes, you may need to file quarterly estimates on Form 540-ES with the FTB to avoid a penalty
                        </p>
                    </td>
                </tr>
            </table>
            <div id="divLinktoRateTable" >
                <p style="text-align: center; height: 20px;">
                    <i>THESE TABLES ARE FOR CALCULATING WORKSHEET C AND FOR 2021 ONLY</i>
                </p>
                <p style="text-align:center;">
                    <b><a href="/Documents/Shared/W4CA_RateTables_0121.pdf" target="_blank">Rate Tables</a></b>
                </p>
            </div>
            <table id="FooterPage4" style="border-bottom: 2px solid black;">
                <tr>
                    <td style="width:40%;"> </td>
                    <td style="width:45%;"> </td>
                    <td style="width:5%;"> </td>
                </tr>
                <tr>
                    <td colspan="1" style="float:left;">
                        DE 4 Rev. 50 (1-21) <b>(INTERNET) </b>
                    </td>
                    <td colspan="1" style="text-align: left;">
                        Page 4 of 4
                    </td>
                    <td colspan="1"></td>
                </tr>   
                <tr><td>&nbsp;</td></tr>
            </table>
        </div>

        <div id="divMainForm" class="row" style="font-size:large; margin-left:1%; margin-right:6%;">
            <table id="TableHeader">
                <tr>
                    <td style="width:20%;"></td>
                    <td style="width:80%;"></td>
                </tr>
                <tr>
                    <td colspan="1">
                        <img src="images/S-California-loo.png"/>
                    </td>
                    <td colspan="1" style="font-size: 30px; font-weight:300; font-weight:bold; vertical-align:bottom;">
                        EMPLOYEE’S WITHHOLDING ALLOWANCE CERTIFICATE
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td colspan="2">
                        Complete this form so that your employer can withhold the correct California state income tax from your paycheck.
                    </td>
                </tr>
            </table>
            <table id="TablePersonalInfo" style = "width:100%; margin-top: 20px; border-top: 1px solid black; border-bottom: 1px solid black;">
                <tr>
                    <td style="width:50%;"> </td>
                    <td style="width:50%;"> </td>
                </tr>
                <tr>
                    <td colspan="2" style="border-bottom:1px solid black; height:35px; vertical-align:middle;">
                        <b>Enter Personal Information</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="border-right:1px solid black; border-bottom: 1px solid black;">
                        First, Middle, Last Name<br />
                        <b><asp:label ID="LabelFullName" runat="server" CssClass="HRETan" Width="100%"/></b>
                    </td>
                    <td colspan="1" style="border-bottom: 1px solid black;">
                        Social Security Number<br />
                        <b><asp:label ID="LabelSSNumber" runat="server" CssClass="HRETan" Width="100%" /></b>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="border-right:1px solid black; border-bottom:1px solid black;">
                        Address<br />
                        <b><asp:label ID="LabelFullAddress" runat="server" CssClass="HRETan" Width="100%" /></b>
                    </td>
                    <td colspan="1" rowspan="2" style="padding-left:10px; padding-top:5px;">
                        <div>Filing Status</div>
                        <div style="padding-top:5px;">
                            <asp:CheckBox ID="CheckboxSingle" runat="server" style="float:left;" onclick="single(this)"/>
                                &nbsp;&nbsp;SINGLE or MARRIED (with two or more incomes)
                            
                        </div>
                        <div style="padding-top:5px;">
                            <span><asp:CheckBox ID="CheckboxMarried" runat="server" style="float:left;" onclick="married(this)"/>
                                &nbsp;&nbsp;MARRIED (one income)
                            </span>
                        </div>
                        <div style="padding-top:5px;">
                            <span><asp:CheckBox ID="CheckboxHOH" runat="server" style="float:left;" onclick="hoh(this)"/>
                                &nbsp;&nbsp;HEAD OF HOUSEHOLD
                            </span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td  colspan="1" style="border-right:1px solid black; ">
                        City, State, and ZIP Code<br/>
                        <b><asp:label ID="LabelCityStateZipCode" runat="server" CssClass="HRETan" Width="100%" /></b>
                    </td>
                </tr>
            </table>
            <table id="TableQuestions" style = "width: 100%; background-color: white; border: 0; margin-top: 20px; table-layout: fixed; vertical-align:top; font-size:medium; ">
                <tr>
                    <td style="width:5%;"> </td>
                    <td style="width:5%;"> </td>
                    <td style="width:70%;"> </td>
                    <td style="width:16%;"> </td>
                    <td style="width:4%;"> </td>
                </tr>
                <tr >
                    <td colspan="1" style="vertical-align:top;">
                        &nbsp;1.&nbsp;
                    </td>
                    <td colspan="5" style="width:90%;">
                        Use Worksheet A for Regular Withholding allowances. Use other worksheets on the following pages as applicable.
                    </td>
                </tr>
                <tr>
                    <td colspan="1">&nbsp;</td>
                    <td colspan="1">
                        1a.
                    </td>
                    <td colspan="1">
                        Number of Regular Withholding Allowances (Worksheet A)
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-bottom:1px solid black;">
                        <asp:TextBox ID="TextAllowancesWorksheetA" runat="server" CssClass="center" Width="100%" onkeypress="return onlyNumbers()" onblur="exempt(this)"></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="1">&nbsp;</td>
                    <td colspan="1">
                        1b.
                    </td>
                    <td colspan="1">
                        Number of allowances from the Estimated Deductions (Worksheet B, if applicable.)
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom;">
                        <asp:TextBox ID="TextAllowancesWorksheetB" runat="server" CssClass="center" Width="100%" onkeypress="return onlyNumbers()" onblur="exempt(this)"></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="1">&nbsp;</td>
                    <td colspan="1">
                        1c.
                    </td>
                    <td colspan="1">
                        Total Number of Allowances you are claiming
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom;">
                        <asp:TextBox ID="TextTotalExemptions" runat="server" CssClass="center" Width="100%" onkeypress="return onlyNumbers()" onblur="exempt(this)"></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr >
                    <td colspan="1" style="vertical-align:top;">
                        &nbsp;2.&nbsp;
                    </td>
                    <td colspan="2">
                        Additional amount of state income tax to be withheld each pay period (if employer agrees), <b>Worksheet C</b>
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="TextAdditionalWithholding" runat="server" CssClass="center" Width="100%" onblur="exempt(this)"></asp:TextBox>
                    </td>                        
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr >
                    <td colspan="1">
                        &nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                    <td colspan="1" style="text-align: left;">OR
                    </td>
                    <td colspan="3">&nbsp;
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td colspan="5">
                        <b>Exemption from Withholding</b>
                    </td>
                </tr>
                <tr >
                    <td colspan="1" style="vertical-align:top;">
                        &nbsp;3.&nbsp;
                    </td>
                    <td colspan="2">
                        &nbsp;I claim exemption from withholding for 2021, and I certify I meet both of the conditions for exemption.
                    </td>
                    <td colspan="1" style="text-align:left; vertical-align:bottom;" >
                        <asp:CheckBox ID="CheckboxExempt1" runat="server" CssClass="center" Width="100%" Text="(Check box here)&nbsp;" TextAlign="Left" onblur="exempt(this)"></asp:CheckBox>
                    </td>
                    <td colspan="1"></td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                    <tr >
                    <td colspan="1" style="vertical-align:top;">
                        &nbsp;4.&nbsp;
                    </td>
                    <td colspan="2">
                        I certify under penalty of perjury that I am not subject to California withholding. I meet the conditions set forth under
						the Service Member Civil Relief Act, as amended by the Military Spouses Residency Relief Act. 
                    </td>
                    <td colspan="1"  style="vertical-align:bottom;">
                        <asp:CheckBox ID="CheckboxExempt2" runat="server" CssClass="center" Width="100%" Text="(Check box here)&nbsp;" onblur="exempt(this)"/>
                    </td>
                        <td colspan="1"></td>
                </tr>
                <tr><td colspan="5" style="border-bottom: 1px solid black;">&nbsp;</td></tr>
            </table>
            <table id="TableSignature">
                <tr>
                    <td style="width:75%;"></td>
                    <td style="width:25%;"></td>
                </tr>
                <tr >
                    <td colspan="2">
                        Under the penalties of perjury, I certify that the number of withholding allowances claimed on this certificate does not exceed the number 
                        to which I am entitled or, if claiming exemption from withholding, that I am entitled to claim the exempt status.                                
                    </td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="1">
                        Employee’s Signature
                        <span class="underline">
                            <asp:TextBox ID="TextSignature" runat="server" Style="display: inline; width: 99%;" placeholder="Enter your Full Name" ></asp:TextBox>
                        </span>
                    </td>
                    <td colspan="1">
                        Date
                        <span class="underline center" >
                            <asp:TextBox ID="SignatureDate" runat="server" Style="display: inline; width: 100%;" CssClass="center"></asp:TextBox>
                        </span>
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
            </table>
            <table id="TableEmployerInfo" style="border:1px solid black;">
                <tr>
                    <td style="width:50%;"></td>
                    <td style="width:50%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="border-right: 1px solid;">
                        <b>Employer’s Section: </b>Employer’s Name and Address
                    </td>
                    <td colspan="1">
                        California Employer Payroll Tax Account Number
                    </td>
                </tr>
                <tr>
                    <td colspan="1" class="HRETan" style="border-right: 1px solid;">
                        &nbsp;<b><asp:Label ID="LabelCompanyName" TextMode="MultiLine" runat="server" Style="display: inline; width: 95%;" ></asp:Label></b><br />
                        &nbsp;<b><asp:Label ID="LabelCompanyAddress" TextMode="MultiLine" runat="server" Style="display: inline; width: 95%;" ></asp:Label></b><br />
                        &nbsp;<b><asp:Label ID="LabelCompanyCityStateZip" TextMode="MultiLine" runat="server" Style="display: inline; width: 95%;" ></asp:Label></b>
                    </td>
                    <td colspan="1" class="HRETan">
                        &nbsp;<b><asp:Label ID="LabelEmployerPTANo" runat="server" Style="display: inline; width: 95%;" ></asp:Label></b>
                    </td>
                </tr>
            </table>
        </div>

        <div id="divFormFooter" class="row HRERewrap">
            <br />
            <div style="float:right;">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valw4" OnClick="btnSave_Click"/>
            </div>
        </div>

    </div>

    <script>
        var toggleIsHide = true;
        var toggleIsHide1 = true;
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

        $(".instruction_toggle1").hide();
        $(".instruction_toggle_btn1").click(function () {
            if (toggleIsHide1 == true) {
                $(this).attr("src", "img/minus.png");
            } else {
                $(this).attr("src", "img/plus.png")
            }
            $(".instruction_toggle1").toggle();
            toggleIsHide1 = !toggleIsHide1;
        });
    </script>

    <style>
        input[type=text], textarea {outline: none; min-height: 25px; min-width: 75px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important;}
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; display:inline; float: right; vertical-align:bottom;}
        table {background-color:white; min-height: 25px; color:black; border:none; border-collapse:separate; border-spacing: 0px 0px; vertical-align:top; font-size:large;}
        table tr td {vertical-align:top;}
        p {color:black;}
        div ul li {color:black;}
        div ol li {color:black;}
        div {color:black; }
        .underline {border-bottom: 1px solid !important; width: 100%; display: inline-block;}
        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; padding-top:5px; padding-left:5px; height:40px; } 
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}

    </style>


</asp:Content>
