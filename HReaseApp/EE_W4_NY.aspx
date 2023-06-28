<%@ Page Title="NY State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_NY.aspx.vb" 
    Inherits="HReaseApp.EE_W4_NY" 
    MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" runat="Server">
    <div id ="DivTopMenu">
        <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>
    </div>
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" runat="Server">
    <div id="DivTabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>
    </div>
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" runat="Server">
    <script type="text/javascript">
        function single(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarried]').prop("checked", false);
                $('input:checkbox[id$=chkMarriedWithholdHigher]').prop("checked", false);
            }
        }
        function married(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingle]').prop("checked", false);
                $('input:checkbox[id$=chkMarriedWithholdHigher]').prop("checked", false);
            }
        }
        function marriedwithholdhigher(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingle]').prop("checked", false);
                $('input:checkbox[id$=chkMarried]').prop("checked", false);
            }
        }
        function nyresidentyes(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkNYResidentNo]').prop("checked", false);
            }
        }
        function nyresidentno(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkNYResidentYes]').prop("checked", false);
            }
        }
        function yonkersyes(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkYonkersNo]').prop("checked", false);
            }
        }
        function yonkersno(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkYonkersYes]').prop("checked", false);
            }
        }
        function divPrint() {
        // Logic determines which div should be printed.
            $("#TopNav").addClass("hidden");
            $("#DivTopMenu").addClass("hidden");
            $("#DivTabs").addClass("hidden");
            $("#DivPageTitle").addClass("hidden");
            $("#DivTopHeader").addClass("hidden");
            $("#DivInstructionTitle").addClass("hidden");
            $("#DivInstructions").addClass("hidden");
            $("#DivFormFooter").addClass("hidden");
            $("#DivFormHeader").addClass("printable");
            $("#DivFormBody").addClass("printable");
        window.print();
        }   
        
        // This function will allow users to insert only numbers in the textboxes.
        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
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
       function makeMoney(source){
          //Grab the value from the element
          var money = parseFloat(source.value,10).toFixed(2);
      
          //Format your value
          source.value = money.toString();
        }
    </script>

   <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>New York Form 2104</b></h4>
                <br /><br />
            </div>
            <%--<div class="col-md-6" style="float:right; vertical-align:bottom; padding-top:20px;">
                <asp:ImageButton ID='btnPrint' runat='server' ImageUrl='../img/printer.jpg' BorderStyle='None' Height='40px' ToolTip="Print" />
            </div>--%>
            <br /><br />
        </div>
        
        <div id="DivTopHeader" class="form-group" >                  
            <div id="DivError" runat="server" visible="false" class="HREError" style="height:auto;">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
            </div>
            <div class="form-group" style="display:inline;">
                <div id="DivSuccess" runat="server" visible ="false" class="HRESuccess">
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

        <div id="DivInstructions" class="instruction_toggle" style="text-align:center; margin-right:5%; font-size: medium; padding:10px 10px 10px 10px;">
            <table>
                <tr>
                    <td style="width: 45%">
                        <p><b>Important information</b></p>
                        <p>
                            The 2021-2022 New York State budget was signed into law on April 19, 
                            2021. Changes to New York State personal income tax have caused 
                            withholding tax changes for taxpayers with taxable income:
                        </p>
                        <ul>
                            <li>more than $2,155,350, and who are married filing jointly or a qualified
                            widow(er);</li>
                            <li>more than $1,077,550, and who are single or married filing separately;
                                <br />or
                            </li>
                            <li>more than $1,616,450, and who are head of household.
                            </li>
                        </ul>
                        <p>        
                            Accordingly, if you previously filed a Form IT-2104 and earn more than the
                            amounts listed above, you should complete a new 2022 Form IT-2104 and
                            give it to your employer.
                        </p>
                        <p><b>Changes effective for 2022</b></p>
                        <p>
                            Form IT-2104 has been revised for tax year 2022. The worksheet on
                            page 4 and the charts beginning on page 5, used to compute withholding 
                            allowances or to enter an additional dollar amount on line(s) 3, 4, or 5, 
                            have been revised. If you previously filed a Form IT-2104 and used the
                            worksheet or charts, you should complete a new 2022 Form IT-2104 and
                            give it to your employer.
                        </p>
                    </td>
                    <td style="width:3%;"></td>
                    <td style="width: 47%; padding-right: 3px; vertical-align:top;">
                        <p><b>Who should file this form</b></p>
                        <p>
                            This certificate, Form IT-2104, is completed by an employee and given
                            to the employer to instruct the employer how much New York State (and 
                            New York City and Yonkers) tax to withhold from the employee’s pay. The 
                            more allowances claimed, the lower the amount of tax withheld.
                        </p>
                        <p>
                            If the federal Form W-4 you most recently submitted to your employer
                            was for tax year 2019 or earlier, and you did not file Form IT-2104, your
                            employer may use the same number of allowances you claimed on your 
                            federal Form W-4. Due to differences in federal and New York State tax
                            law, this may result in the wrong amount of tax withheld for New York 
                            State, New York City, and Yonkers. 
                        </p>
                        <p>
                           For tax years 2020 or later, withholding allowances are no longer reported 
                            on federal Form W-4. Therefore, if you submit a federal Form W-4 to your
                            employer for tax year 2020 or later, and you do not file Form IT-2104, your
                            employer may use zero as your number of allowances. This may result in 
                            the wrong amount of tax withheld for New York State, New York City, and 
                            Yonkers. 
                        </p>
                        <p>
                            Complete Form IT-2104 each year and file it with your employer if the
                            number of allowances you may claim is different from federal Form W-4 or
                        </p>                            
                    </td>
                </tr>
            </table>
            <p style="padding-top: 20px; text-align:left;"><b>Page 2 </b>of 8 <b>IT-2104</b> (2022)</p>
            <table>
                <tr>
                    <td style="width: 45%; vertical-align:top;">
                       <p>
                           has changed. Common reasons for completing a new Form IT-2104 each
                            year include the following:
                        </p>
                        <ul>
                            <li style="color:black;">You started a new job.</li>
                            <li style="color:black;">You are no longer a dependent.</li>
                            <li style="color:black;">Your individual circumstances may have changed (for example, you were married or have an additional child).</li>
                            <li style="color:black;">You moved into or out of NYC or Yonkers.</li>
                            <li style="color:black;">You itemize your deductions on your personal income tax return.</li>
                            <li style="color:black;">You claim allowances for New York State credits.</li>
                            <li style="color:black;">You owed tax or received a large refund when you filed your personal income tax return for the past year.</li>
                            <li style="color:black;">Your wages have increased and you expect to earn $107,650 or more during the tax year.</li>    
                            <li style="color:black;">The total income of you and your spouse has increased to $107,650 or more for the tax year.</li>
                            <li style="color:black;">You have significantly more or less income from other sources or from another job.</li>
                            <li style="color:black;">You no longer qualify for exemption from withholding.</li>
                            <li style="color:black;">You have been advised by the Internal Revenue Service that you  are entitled to fewer allowances than claimed on your 
                                original federal Form W-4 (submitted to your employer for tax year 2019 or earlier), and the disallowed allowances were 
                                claimed on your original Form IT-2104.</li>
                            <li style="color:black;">You are a covered employee of an employer that has elected to participate in the Employer Compensation Expense Program.</li>
                        </ul>
                        <p><b>Exemption from withholding</b></p>
                        <p>
                            You cannot use Form IT-2104 to claim exemption from withholding.
                            To claim exemption from income tax withholding, you <b>must</b> file
                            Form IT-2104-E, <i>Certificate of Exemption from Withholding</i>, with your 
                            employer. You must file a new certificate each year that you qualify for
                            exemption. This exemption from withholding is allowable only if you had 
                            no New York income tax liability in the prior year, you expect none in the 
                            current year, <b>and</b> you are over 65 years of age, under 18, or a full-time 
                            student under 25. You may also claim exemption from withholding if 
                            you are a military spouse and meet the conditions set forth under the 
                            Servicemembers Civil Relief Act as amended by the Military Spouses
                            Residency Relief Act and the Veterans Benefits and Transition Act. If you
                            are a dependent who is under 18 or a full-time student, you may owe tax 
                            if your income is more than $3,100
                        </p>
                        <p><b>Withholding allowances</b></p>
                        <p>
                            You may not claim a withholding allowance for yourself or, if married, 
                            your spouse. Claim the number of withholding allowances you compute 
                            in Part 1 and Part 4 of the worksheet on page 4. If you want more tax
                            withheld, you may claim fewer allowances. <b>If you claim more than 
                            14 allowances</b>, your employer <b>must send</b> a copy of your <b>Form IT-2104</b>
                            to the New York State Tax Department. You may then be asked to 
                            verify your allowances. If you arrive at negative allowances (less than
                            zero) on lines 1 or 2 and your employer cannot accommodate negative 
                            allowances, <b>enter 0</b> and see <i>Additional dollar amount(s)</i> below.
                        </p>
                        <p>
                            <b>Income from sources other than wages –</b> If you have more than
                            $1,000 of income from sources other than wages (such as interest, 
                            dividends, or alimony received), reduce the number of allowances 
                            claimed on line 1 and line 2 (if applicable) of the IT-2104 certificate
                            by one for each $1,000 of nonwage income. If you arrive at negative
                            allowances (less than zero), see <i>Withholding allowances</i> above. You 
                            may also consider making estimated tax payments, especially if you 
                            have significant amounts of nonwage income. Estimated tax requires
                            that payments be made by the employee directly to the Tax Department 
                            on a quarterly basis. For more information, see the instructions for
                            Form IT‑2105, <i>Estimated Tax Payment Voucher for Individuals</i>, or see 
                            <i>Need help?</i> on page 7.

                        </p>
                        <p>
                            <b>Other credits</b> (Worksheet line 14) – If you will be eligible to claim
                            any credits other than the credits listed in the worksheet, such as an 
                            investment tax credit, you may claim additional allowances.
                        </p>
                        <p>
                            Find your filing status and your New York adjusted gross income (NYAGI)
                            in the chart below, and divide the amount of the expected credit by the 
                            number indicated. Enter the result (rounded to the nearest whole number) 
                            on line 14.
                        </p>
                    </td>
                    <td style="width:3%;"></td>
                    <td style="width: 47%; padding-right: 3px; vertical-align:top;">
                        <table class="table-bordered text-center">
                            <tr>
                                <td>Single and NYAGI is:</td>
                                <td>Head of household and NYAGI is:</td>
                                <td>Married and NYAGI is:</td>
                                <td>Divide amount of expected credit by:</td>
                            </tr>
                            <tr>
                                <td>Less than $215,400</td>
                                <td>Less than $269,300 </td>
                                <td>Less than $323,200</td>
                                <td>63</td>
                            </tr>
                            <tr>
                                <td>Between $215,400 and $1,077,550</td>
                                <td>Between $269,300 and $1,616,450</td>
                                <td>Between $323,200 and $2,155,350</td>
                                <td>68</td>
                            </tr>
                            <tr>
                                <td>Between $1,077,550 and $5,000,000</td>
                                <td>Between $1,616,450 and $5,000,000</td>
                                <td>Between $2,155,350 and $5,000,000</td>
                                <td>96</td>
                            </tr>
                            <tr>
                                <td>Between $5,000,000 and $25,000,000</td>
                                <td>Between $5,000,000 and $25,000,000</td>
                                <td>Between $5,000,000 and $25,000,000</td>
                                <td>100</td>
                            </tr>
                            <tr>
                                <td>Over $25,000,000</td>
                                <td>Over $25,000,000</td>
                                <td>Over $25,000,000</td>
                                <td>110</td>
                            </tr>
                        </table>
                        <p style="padding-top: 10px;">
                            <b>Example:</b> <i>You are married and expect your New York adjusted gross 
                            income to be less than $323,200. In addition, you expect to receive a 
                            flow-through of an investment tax credit from the S corporation of which 
                            you are a shareholder. The investment tax credit will be $160. Divide 
                            the expected credit by 63. 160/63 = 2.5397. The additional withholding 
                            allowance(s) would be 3. Enter 3 on line 14.</i>
                        </p>
                         <p>
                            <b>Married couples with both spouses working – </b> If you and your spouse
                            both work, you should each file a separate IT‑2104 certificate with your
                            respective employers. Your withholding will better match your total tax if 
                            the higher wage-earning spouse claims all of the couple’s allowances and 
                            the lower wage-earning spouse claims zero allowances. <b>Do not</b> claim 
                            more total allowances than you are entitled to. If your combined wages
                            are:
                        </p>
                            <ul>
                                <li style="color:black;">less than $107,650, you should each mark an <b>X</b> in the box <i>Married, 
                                but withhold at higher single rate</i> on the certificate front, and divide the
                                total number of allowances that you compute on line 19 and line 31 (if 
                                applicable) between you and your working spouse.
                                 </li>
                                 <li style="color:black;">$107,650 or more, use the chart(s) in Part 5 and enter the additional 
                                     withholding dollar amount on line 3.
                                </li>
                            </ul>
                        <p>
                            <b>Taxpayers with more than one job – </b>If you have more than one job,
                            file a separate IT-2104 certificate with each of your employers. Be
                            sure to claim only the total number of allowances that you are entitled 
                            to. Your withholding will better match your total tax if you claim all of 
                            your allowances at your higher-paying job and zero allowances at 
                            the lower-paying job. In addition, to make sure that you have enough
                            tax withheld, if you are a single taxpayer or head of household with 
                            two or more jobs, and your combined wages from all jobs are under 
                            $107,650, reduce the number of allowances by seven on line 1 and 
                            line 2 (if applicable) on the certificate you file with your higher‑paying
                            job employer. If you arrive at negative allowances (less than zero), see
                            <i>Withholding allowances</i> above.
                        </p>
                        <p>
                            If you are a single or a head of household taxpayer, and your combined
                            wages from all of your jobs are between $107,650 and $2,263,265, use 
                            the chart(s) in Part 6 and enter the additional withholding dollar amount 
                            from the chart on line 3.
                        </p>
                        <p>
                            If you are a married taxpayer, and your combined wages from all of
                            your jobs are $107,650 or more, use the chart(s) in Part 5 and enter the 
                            additional withholding dollar amount from the chart on line 3 (Substitute 
                            the words Higher-paying job for Higher earner’s wages within the chart).
                        </p>
                        <p>
                            <b>Dependents – </b>If you are a dependent of another taxpayer and expect
                            your income to exceed $3,100, you should reduce your withholding 
                            allowances by one for each $1,000 of income over $2,500. This will 
                            ensure that your employer withholds enough tax.
                        </p>
                        <p>
                            Following the above instructions will help to ensure that you will not owe 
                            additional tax when you file your return
                        </p>
                        <p>
                           <b>Heads of households with only one job –</b> If you will use the
                            head-of-household filing status on your state income tax return, mark
                            the Single or Head of household box on the front of the certificate. If you
                            have only one job, you may also wish to claim two additional withholding 
                            allowances on line 15.
                        </p>                        
                    </td>
                </tr>
            </table>
            <p style="padding-top: 20px; text-align:left;"><b>Page 3 </b>of 8 <b>IT-2104</b> (2022)</p>
            <table style="margin-top: 20px; border-bottom:2px solid black;  margin-bottom: 20px;">
                <tr>
	                <td style="width:15%;"></td>
	                <td style="width:10%;"></td>
	                <td style="width:15%;"></td>
	                <td style="width:10%;"></td>
	                <td style="width:3%;"></td>
	                <td style="width:47%;"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <p>
                            <b>Additional dollar amount(s)</b>
                        </p>
                        <p>
                           You may ask your employer to withhold an additional dollar amount each 
                            pay period by completing lines 3, 4, and
                            5 on Form IT‑2104. In most
                            instances, if you compute a negative number of allowances and your 
                            employer cannot accommodate a negative number, for each negative 
                            allowance claimed you should have an additional $1.85 of tax withheld per 
                            week for New York State withholding on line 3, and an additional $0.80 
                            of tax withheld per week for New York City withholding on line 4. Yonkers 
                            residents should use 16.75% (.1675) of the New York State amount for 
                            additional withholding for Yonkers on line 5.
                        </p>
                        <p>
                           <b>Note:</b> If you are requesting your employer to withhold an additional dollar
                            amount on lines 3, 4, or
                            5 of this allowance certificate, the additional
                            dollar amount, as determined by these instructions or by using the 
                            chart(s) in Part 5 or Part 6, is accurate for a weekly payroll. Therefore, 
                            if you are not paid on a weekly basis, you will need to adjust the dollar 
                            amount(s) that you compute. For example, if you are paid biweekly, you 
                            must double the dollar amount(s) computed.
                        </p>
                        <p>
                            <b>Avoid underwithholding</b>
                        </p>
                        <p>
                            Form IT‑2104, together with your employer’s withholding tables, is
                            designed to ensure that the correct amount of tax is withheld from your pay. 
                            If you fail to have enough tax withheld during the entire year, you may owe a large tax liability when you file your return. The Tax Department must
                            assess interest and may impose penalties in certain situations in addition 
                            to the tax liability. Even if you do not file
                            a return, we may determine
                            that you owe personal income tax, and we may assess interest and 
                            penalties on the amount of tax that you should have paid during the year.
                        </p>
                       <p> <b>Employers</b></p>
                    </td>
                    <td colspan="2">
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <p>
                            <b>Box A</b> – If you are required to submit a copy of an employee’s 
                            Form IT-2104 to the Tax Department because the employee claimed
                            more than 14 allowances, mark an <b><i>X</i></b> in box A and send a copy 
                            of Form IT-2104 to: <b>NYS Tax Department, Income Tax Audit 
                            Administrator, Withholding Certificate Coordinator, W A Harriman 
                            Campus, Albany NY 12227-0865.</b> If the employee is also a new hire or
                            rehire, see Box B instructions. See Publication 55, <i>Designated Private 
                            Delivery Services</i>, if not using U.S. Mail.
                        </p>
                        <p>
                            Due dates for sending certificates received from employees claiming
                            more than 14 allowances are:
                        </p>
                    </td>
                    <td colspan="2">
                    </td>
                </tr> 
                <tr>
                    <td colspan="1">
	                   <b>Quarter</b>
                    </td> 
                    <td colspan="1">
	                    <b>Due date</b>
                    </td> 
                    <td colspan="1">
	                    <b>Quarter</b>
                    </td> 
                    <td colspan="1">
	                    <b>Due date</b>
                    </td> 
		            <td colspan="2">
		            </td>
                </tr>
                <tr>
                    <td colspan="1">
	                    January – March
                    </td> 
                    <td colspan="1">
	                    April 30
                    </td> 
                    <td colspan="1">
	                    July – September
                    </td> 
                    <td colspan="1">
	                    October 31
                    </td> 
                    <td colspan="2">
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        April – June
                    </td> 
                    <td colspan="1">
                        July 31
                    </td> 
                    <td colspan="1">
                        October – December
                    </td> 
                    <td colspan="1">
                        January 31
                    </td> 
                    <td colspan="2">
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
			            <br/>
			        </td>
                </tr>
                <tr>
                    <td colspan = "4">
                        <p>
                            <b>Box B</b> – If you are submitting a copy of this form to comply with New
                            York State’s New Hire Reporting Program, mark an <b><i>X</i></b> in box B. Enter the 
                            first day any services are performed for which the employee will be paid
                            wages, commissions, tips and any other type of compensation. For 
                            services based solely on commissions, this is the first day an employee
                            working for commissions is eligible to earn commissions. Also, mark an <b><i>X</i></b>
                            in the <i>Yes</i> or <i>No</i> box indicating if dependent health insurance benefits are
                            available to this employee. If <i>Yes</i>, enter the date the employee qualifies
                            for coverage. Mail the completed form, within 20 days of hiring, to: <b>NYS 
                            Tax Department, New Hire Notification, PO Box 15119, Albany NY 
                            12212-5119</b>. To report newly-hired or rehired employees online instead of 
                            submitting this form, go to <i>https://www.nynewhire.com</i>.
                        </p>
                        <p style="float:right;">
                            (continued)
                        </p>
                    </td>
                    <td colspan="2">
                         
		    	    </td>

                </tr>
               
            </table>
            <div class="HREWhite">
                <p style="padding-top: 20px; text-align:left;"><b>Page 4 </b>of 8 <b>IT-2104</b> (2022)</p>
                <div id="DivWksPart1" style="text-align:left; font-size:large; background-color:white;">
                    <br />
                    <h3 style="width: 100%; font-weight:bold; text-align:center;">Worksheet</h3>
                    <h4 style="width: 100%; font-weight:bold;margin-top: -20px; text-align:center;">See the instructions before completing this worksheet.</h4>
                    <span style="font-weight:bold;  padding-left: 12px;">
                        Part 1 – Complete this part to compute your withholding allowances for New York State and Yonkers 
                    </span><span>(line 1).</span>
                </div>
                <table id="tblWksPart1" style="margin:15px, 10px; border: 1px solid black; font-size:medium;">
                    <tr>
                        <td style="Width:2%;"></td>
                        <td style="Width:3%;"></td>
                        <td style="Width:80%;"></td>
                        <td style="Width:5%;"></td>
                        <td style="Width:10%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>6</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Enter the number of dependents that you will claim on your state return (do not include yourself or, if married, your spouse) 
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>6</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right;">
                            <asp:TextBox ID="txtBox6" runat="server" Class="underline" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <b>For lines 7, 8, and 9, enter 1 for each credit you expect to claim on your state return.</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>7</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            College tuition credit
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>7</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right;">
                            <asp:TextBox ID="txtBox7" runat="server" Class="underline" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>8</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            New York State household credit
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>8</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right;">
                            <asp:TextBox ID="txtBox8" runat="server" Class="underline" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>9</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Real property tax credit
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>9</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right;">
                            <asp:TextBox ID="txtBox9" runat="server" Class="underline" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <b>For lines 10, 11, and 12, enter 3 for each credit you expect to claim on your state return.</b>
                        </td>
                    </tr> 
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>10</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Child and dependent care credit
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>10</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right;">
                            <asp:TextBox ID="txtBox10" runat="server" Class="underline" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>11</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Earned income credit
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>11</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right;">
                            <asp:TextBox ID="txtBox11" runat="server" Class="underline"  />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>12</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Empire State child credit
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>12</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right;">
                            <asp:TextBox ID="txtBox12" runat="server" Class="underline" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>13</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            New York City school tax credit: If you expect to be a resident of New York City for any part of the tax year, enter <b>2</b> 
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>13</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right;">
                            <asp:TextBox ID="txtBox13" runat="server" Class="underline" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>14</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Other credits <i>(see instructions)</i>
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>14</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right;">
                            <asp:TextBox ID="txtBox14" runat="server" Class="underline" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>15</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Head of household status and only one job <i>(enter <b>2</b> if the situation applies)</i>
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>15</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right;">
                            <asp:TextBox ID="txtBox15" runat="server" Class="underline" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>16</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Enter an estimate of your federal adjustments to income, such as alimony you will pay for the tax year and deductible IRA 
                            contributions you will make for the tax year. Total estimate $ 
                            <asp:TextBox ID="txtBox16a" runat="server" Class="underline" />. 
                            Divide this estimate by $1,000. Drop any fraction and enter the number
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>16</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right;">
                            <asp:TextBox ID="txtBox16" runat="server" Class="underline" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>17</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            If you expect to be a covered employee of an employer who elected to pay the employer compensation expense tax in 2022, 
                            complete Part 3 below and enter the number from line 28.
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>17</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right;">
                            <asp:TextBox ID="txtBox17" runat="server" Class="underline" />
                        </td>
                    </tr>                                 
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>18</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            If you expect to itemize deductions on your state tax return, complete Part 2 below and enter the number from line 23. 
                            All others enter <b>0</b> 
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>18</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right;">
                            <asp:TextBox ID="txtBox18" runat="server" Class="underline" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>19</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Add lines 6 through 18. Enter the result here and on line 1. If you have more than one job, or if you and your spouse both
			                work, see instructions for <i>Taxpayers with more than one job or Married couples with both spouses working</i>  
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>19</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right;">
                            <asp:TextBox ID="txtBox19" runat="server" Class="underline" />
                        </td>
                    </tr> 
                </table>

                <div id="DivWksPart2" style="text-align:left; font-size:large; background-color:white;">
                    <br />
                    <span style="font-weight:bold; padding-left: 12px; text-align:left;">
                        Part 2 – Complete this part only if you expect to itemize deductions on your state return.
                    </span> <span>(line 2).</span>
                </div>
                <div id="tblWksPart2" class="HREWhite">
                    <table style="margin:15px, 10px; font-size:medium;">
                        <tr>
                            <td style="Width:3%;"></td>
                            <td style="Width:2%;"></td>
                            <td style="Width:80%;"></td>
                            <td style="Width:5%;"></td>
                            <td style="Width:10%;"></td>
                        </tr>
                        <tr>
                            <td colspan="1"></td>
                            <td colspan="1" style="vertical-align:top;">
                                <b>20</b> 
                            </td>
                            <td colspan="1">
                                Enter your estimated NY itemized deductions for the tax year <i>(see Form IT-196 and its instructions; enter the amount from line 49)</i>
                            </td>
                            <td colspan="1" style="vertical-align:bottom; text-align:right;">
                                <b>20</b>
                            </td>
                            <td colspan ="1">
                                <asp:TextBox ID="txtBox20" runat="server" Class="underline" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1"></td>
                            <td colspan="1" style="vertical-align:top;">
                                <b>21</b> 
                            </td>
                            <td colspan="1">
                                Based on your federal filing status, enter the applicable amount from the table below 
                            </td>
                            <td colspan="1" style="vertical-align:bottom; text-align:right;">
                                <b>21</b>
                            </td>
                            <td colspan ="1">
                                <asp:TextBox ID="txtBox21" runat="server" Class="underline" />
                            </td>
                        </tr>
                    </table>

                    <table style="width:100%;">
                        <tr>
                            <td style="Width:10%;"></td>
                            <td style="Width:30%;"></td>
                            <td style="Width:10%;"></td>
                            <td style="Width:5%;"></td>
                            <td style="Width:20%;"></td>
                            <td style="Width:10%;"></td>
                            <td style="Width:15%;"></td>
                        </tr>
                        <tr >
                            <td colspan="7" style="text-align:center;">
                                <b>Standard deduction table</b>
                            </td>
                        </tr>
                        <tr >
                            <td colspan="1"></td>
                            <td colspan="1" style="border-left:1px solid black; border-top:1px solid black">Single (cannot be claimed as a dependent)</td>
                            <td colspan="1" style="border-top:1px solid black;">$ 8,000</td>
                            <td colspan="1" style="border-top:1px solid black;"></td>
                            <td colspan="1" style="border-top:1px solid black;">Qualifying widow(er)</td>
                            <td colspan="1" style="border-right:1px solid black; border-top:1px solid black;">$16,050</td> 
                            <td colspan="1"></td>
                        </tr>
                        <tr >
                            <td colspan="1"></td>
                            <td colspan="1" style="border-left:1px solid black;">Single (can be claimed as a dependent)</td>
                            <td colspan="1" >$ 3,100</td>
                            <td colspan="1" ></td>
                            <td colspan="1" >Married filing jointly</td>
                            <td colspan="1" style="border-right:1px solid black;">$16,050</td>
                            <td colspan="1"></td>
                        </tr>
                        <tr >
                            <td colspan="1"></td>
                            <td colspan="1" style="border-left:1px solid black; border-bottom:1px solid black;">Head of household </td>
                            <td colspan="1" style="border-bottom:1px solid black;">$11,200</td>
                            <td colspan="1" style="border-bottom:1px solid black;"></td>
                            <td colspan="1" style="border-bottom:1px solid black;">Married filing separate returns </td>
                            <td colspan="1" style="border-bottom:1px solid black; border-right:1px solid black;">$ 8,000</td>
                            <td colspan="1"></td>
                        </tr>
                    </table>
                    <br />

                    <table style="margin:15px, 10px;">
                        <tr>
                            <td style="Width:3%;"></td>
                            <td style="Width:2%;"></td>
                            <td style="Width:80%;"></td>
                            <td style="Width:5%;"></td>
                            <td style="Width:10%;"></td>
                        </tr>
                        <tr>
                            <td colspan="1"></td>
                            <td colspan="1" style="vertical-align:top;">
                                <b>22</b> 
                            </td>
                            <td colspan="1" style="vertical-align:top;">
                                Subtract line 21 from line 20 <i>(if line 21 is larger than line 20, enter 0 here and on line 18 above) </i>
                            </td>
                            <td colspan="1" style="vertical-align:bottom; text-align:right;">
                                <b>22</b>
                            </td>
                            <td colspan ="1" style="vertical-align:bottom;">
                                <asp:TextBox ID="txtBox22" runat="server" Class="underline" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1"></td>
                            <td colspan="1" style="vertical-align:top;">
                                <b>23</b> 
                            </td>
                            <td colspan="1" style="vertical-align:top;">
                                Divide line 22 by $1,000. Drop any fraction and enter the result here and on line 18 above
                            </td>
                            <td colspan="1" style="vertical-align:bottom; text-align:right;">
                                <b>23</b>
                            </td>
                            <td colspan ="1" style="vertical-align:bottom;">
                                <asp:TextBox ID="txtBox23" runat="server" Class="underline"  />
                            </td>
                        </tr>
                    </table>
                </div>
                
                <div id="DivWksPart3" style="text-align:left; font-size:large; background-color:white;">
                    <br />
                    <span style="font-weight:bold;padding-left: 12px;">
                        Part 3 – Complete this part if you expect to be a covered employee of an employer that has elected to participate in the Employer Compensation Expense Program
                    </span> 
                    <span>(line 17).</span>
                </div>
                <table id="tblWksPart3" style="margin:15px, 10px; border: 1px solid black;">
                    <tr>
                        <td style="Width:3%;"></td>
                        <td style="Width:2%;"></td>
                        <td style="Width:80%;"></td>
                        <td style="Width:5%;"></td>
                        <td style="Width:10%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>24</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Expected annual wages and compensation from electing employer in 2022
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>24</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom;">
                            <asp:TextBox ID="txtBox24" runat="server" Class="underline"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>25</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Line 24 minus $40,000 (if zero or less, <b>stop</b>)
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>25</b>
                        </td>
                        <td colspan ="1">
                            <asp:TextBox ID="txtBox25" runat="server" Class="underline"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>26</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Line 25 multiplied by .05
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>27</b>
                        </td>
                        <td colspan ="1">
                            <asp:TextBox ID="txtBox26" runat="server" Class="underline"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>27</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Line 26 multiplied by .935
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>27</b>
                        </td>
                        <td colspan ="1">
                            <asp:TextBox ID="txtBox27" runat="server" Class="underline"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>28</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Divide line 27 by 65. Drop any fraction and enter the result here and on line 17 above
                        </td>
                        <td colspan="1" style="vertical-align:bottom;text-align:right;">
                            <b>28</b>
                        </td>
                        <td colspan ="1">
                            <asp:TextBox ID="txtBox28" runat="server" Class="underline"/>
                        </td>
                    </tr>
	            </table>

                <div id="DivWksPart4" style="text-align:left; font-size:large; background-color:white;">
                    <br />
                    <span style="font-weight:bold;padding-left: 12px;">
                        Part 4 – Complete this part to compute your withholding allowances for New York City 
                    </span> 
                    <span>(line 2).</span>
                </div>
                <table id="tblWksPart4" style="margin:15px, 10px; border: 1px solid black;">
                    <tr>
                        <td style="Width:3%;"></td>
                        <td style="Width:2%;"></td>
                        <td style="Width:80%;"></td>
                        <td style="Width:5%;"></td>
                        <td style="Width:10%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>29</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Enter the amount from line 6 above
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>29</b>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom;">
                            <asp:TextBox ID="txtBox29" runat="server" Class="underline"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>30</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Add lines 15 through 18 above and enter total here
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>30</b>
                        </td>
                        <td colspan ="1">
                            <asp:TextBox ID="txtBox30" runat="server" Class="underline"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>31</b> 
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            Add lines 29 and 30. Enter the result here and on line 2
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right;">
                            <b>31</b>
                        </td>
                        <td colspan ="1">
                            <asp:TextBox ID="txtBox31" runat="server" Class="underline"/>
                        </td>
                    </tr>
                    
	            </table>

                <div id="DivLinktoRateTable">
                    <br />
                    <a href="/Documents/Shared/W4NY_IT-2104_2022_RateTables.pdf" target="_blank">Part 5 and 6 - Rate Tables</a>
                </div>
            </div>
            <hr />
        </div>

        <div id="DivFormHeader" class="row">
            <div class="col-md-2" style="margin-top: 15px; width:10%; max-height:200px;">
                <img src="images/NY_State_Logo_2022.png"/>             
            </div>
            <div class="col-md-8" style="width:70%; padding-left:10%;">
                <p style="line-height: 0px; margin-top: 18px; font-size:medium; color:black;">
                        Department of Taxation and Finance</p>
                <h2><b>Employee’s Withholding Allowance Certificate</b></h2>
                <h3><b>New York State • New York City • Yonkers</b></h3>
            </div>
            <div class="col-md-2" style="width:20%;float:right; padding-right:5%;">
                <h1><b>IT-2104</b></h1>
            </div>
        </div>
        <br />
        <div id="DivFormBody" style="margin-right:5%;">
            <table>
                <tr>
                    <td colspan="4" style="width:40%; border-left: 2px solid black; border-top: 2px solid black;">
                        <p>First name and middle initial</p>
                        <p style="vertical-align:text-bottom;">
                            <b><asp:label ID="lblFName" runat="server" CssClass="HRETan" Width="100%"/></b>
                        </p>
                    </td>
                    <td colspan="3" style="width:30%; border-top: 2px solid black; border-right: 2px solid black;">
                        <p>Last Name</p>
                        <p style="vertical-align:text-bottom; font-size:large;">
                            <b><asp:label ID="lblLName" runat="server" CssClass="HRETan" Width="100%" /></b>
                        </p>
                    </td>
                    <td colspan="3" style="width:30%; border-top: 1px solid black; border-right: 1px solid black;" >
                        <p>Your social security number</p>
                        <p style="vertical-align:text-bottom; font-size:large;">
                            <b><asp:label ID="lblSSNumber" runat="server" CssClass="HRETan" Width="100%" /></b>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" style="width:40%; border-left: 2px solid black; border-top: 1px solid black;">
                        <p>Permanent home address (number and street or rural route)</p>
                        <p style="vertical-align:text-bottom; font-size:large;">
                            <b><asp:label ID="lblAddress1" runat="server" CssClass="HRETan" Width="100%" /></b>
                        </p>
                    </td>
                    <td colspan="3" style="width:35%; border-top: 1px solid black; border-right: 2px solid black;">
                        <p style="text-align:left; vertical-align:top;">Apartment number</p>
                        <p style="vertical-align:text-bottom; font-size:large;">
                            <b><asp:label ID="lblAddress2" runat="server" CssClass="HRETan" Width="100%" /></b>
                        </p>
                    </td>
                    <td colspan="3" style="width:30%; border-top: 1px solid black; border-right: 1px solid black;  padding-right: 5px; background-color:white;">
                        <asp:CheckBox ID="chkSingle" runat="server" Text="Single or Head of household&nbsp;&nbsp;" TextAlign="Left" onclick="single(this)"/>
                        <asp:CheckBox ID="chkMarried" Text=" Married&nbsp;&nbsp;" TextAlign="Left" Style="float:right;" runat="server" onclick="married(this)"/>
                        <br />
                        <asp:CheckBox ID="chkMarriedWithholdHigher" Text="Married, but withhold at higher single rate&nbsp;&nbsp;&nbsp;&nbsp;" TextAlign="Left" Style="float:right;" runat="server" onclick="marriedwithholdhigher(this)" />
                    </td>
                </tr>
                <tr>
                    <td colspan ="3" style="width:30%; border-left: 2px solid black; border-top: 1px solid black; border-bottom:2px solid black;">
                        <p>City, village, or post-office </p>
                        <p style="vertical-align:text-bottom; font-size:large;">
                            <b><asp:label ID="lblCityVillage" runat="server" CssClass="HRETan" Width="100%" /></b>
                        </p>
                    </td>
                    <td colspan="2" style="width:20%; border-top: 1px solid black; border-bottom: 2px solid black;">
                        <p>State</p>
                        <p style="vertical-align:text-bottom; font-size:large;">
                            <b><asp:label ID="lblState" runat="server" CssClass="HRETan" Width="100%" /></b>
                        </p>
                    </td>
                    <td colspan="2" style="width:20%; border-top: 1px solid black; border-right:2px solid black; border-bottom:2px solid black;">
                        <p>ZIP Code</p>
                        <p style="vertical-align:text-bottom; font-size:large;">
                            <b><asp:label ID="lblZipCode" runat="server" CssClass="HRETan" Width="100%"/></b>
                        </p>
                    </td>
                    <td colspan="3" style="width:30%; border-right: 1px solid black; background-color:white;">
                        <br />
                        <p><b>Note:</b> If married but legally separated, mark an <b>X</b> in the <i>Single or Head of household</i> box</p> 
                    </td>
                </tr>
            </table>
  
            <table style="border: 1px solid black; font-size:large; background-color: white;">
                <tr>
                    <td style="width:3%;"></td>
                    <td style="width:60%;"></td>
                    <td style="width:6%;"></td>
                    <td style="width:6%;"></td>
                    <td style="width:5%;"></td>
                    <td style="width:20%;"></td>

                </tr>
                <tr><td colspan="6" style="border-right:1px solid black;">&nbsp;</td></tr>
                <tr style="padding-top:5px;">
                    <td colspan="2" >
                        Are you a resident of New York City?
                    </td>
                    <td colspan="1">
                            <asp:CheckBox ID="chkNYResidentYes" runat="server" Text="&nbsp;Yes&nbsp;" TextAlign="Left" onclick="nyresidentyes(this)"/>
                    </td>
                    <td colspan="1">
                            <asp:CheckBox ID="chkNYResidentNo" runat="server" Text="&nbsp;No&nbsp;" TextAlign="Left" onclick="nyresidentno(this)"/>              
                    </td>
                    <td colspan="2">

                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        Are you a resident of Yonkers?
                    </td>
                    <td colspan="1">
                            <asp:CheckBox ID="chkYonkersYes" runat="server" Text="&nbsp;Yes&nbsp;" TextAlign="Left" onclick="yonkersyes(this)"/>
                    </td>
                    <td colspan="1">
                            <asp:CheckBox ID="chkYonkersNo" runat="server" Text="&nbsp;No&nbsp;" TextAlign="Left" onclick="yonkersno(this)"/>
                    </td>
                    <td colspan="2">
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <br />
                        <b>Complete the worksheet on page 4 before making any entries.</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        <b>1</b>
                    </td>
                    <td colspan="3">
                        Total number of allowances you are claiming for New York State and Yonkers, if applicable (from line 19)
                    </td>
                    <td colspan="1" style="text-align:right; vertical-align:bottom;">
                        <b style="border: 1px solid black; padding:0px 4px 0px 4px;">1</b>
                    </td>
                    <td colspan="1" style="vertical-align:bottom;">
                            <asp:TextBox ID="txtTotalAllowance1" runat="server" onkeypress="return onlyNumbers()" Style="border: 1px solid black" CssClass="center" />
                    </td>

                </tr>
                <tr>
                    <td colspan="1">
                        <b>2</b>
                    </td>
                    <td colspan="3">
                       Total number of allowances for New York City (from line 31)
                    </td>
                    <td colspan="1" style="text-align:right; vertical-align:bottom;">
                        <b style="border: 1px solid black; padding:0px 4px 0px 4px;">2</b>
                    </td>
                    <td colspan="1"  style="vertical-align:bottom;">
                        <asp:TextBox ID="txtTotalAllowance2" runat="server" onkeypress="return onlyNumbers()" Style="border: 1px solid black" CssClass="center" />
                    </td>
                </tr>
                <tr>
                    <td colspan="6" class="spacebetweenlines">
                        <br />
                        <b>Use lines 3, 4, and 5 below to have additional withholding per pay period under special agreement with your employer.</b>
                        <br />
                    </td>
                </tr>   
                <tr>
                    <td colspan="1">
                        <b>3</b>
                    </td>
                    <td colspan="3">
                         New York State amount
                    </td>
                     <td colspan="1" style="text-align:right; vertical-align:bottom;">
                        <b style="border: 1px solid black; padding:0px 4px 0px 4px;">3</b>
                    </td>
                    <td colspan="1"  style="vertical-align:bottom;">
                            <asp:TextBox ID="txtTotalAllowance3" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Style="border: 1px solid black" CssClass="center" />                    
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        <b>4</b>
                    </td>
                    <td colspan="3">
                       New York City amount
                    </td>
                    <td colspan="1" style="text-align:right; vertical-align:bottom;">
                        <b style="border: 1px solid black; padding:0px 4px 0px 4px;">4</b>
                    </td>
                   <td colspan="1"  style="vertical-align:bottom;">
                            <asp:TextBox ID="txtTotalAllowance4" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Style="border: 1px solid black" CssClass="center" />
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        <b>5</b>
                    </td>
                    <td colspan="3">
                         Yonkers amount
                    </td>
                    <td colspan="1" style="text-align:right; vertical-align:bottom;">
                        <b style="border: 1px solid black; padding:0px 4px 0px 4px;">5</b>
                    </td>
                   <td colspan="1"  style="vertical-align:bottom;">
                        <asp:TextBox ID="txtTotalAllowance5" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Style="border: 1px solid black" CssClass="center" />
                    </td>
                </tr>
            </table>

            <table style="background-color:white;">
                <tr>
                    <td style ="width:100%;">
                        <br />
                        I certify that I am entitled to the number of withholding allowances claimed on this certificate.
                    </td>
                </tr>
            </table>
        
            <table style="border:1px solid black; background-color:white; padding:10px; font-size:large;">
                <tr>
	                <td style="width:70%;"></td>
	                <td style="width:30%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="border-right: 1px solid black;">
                      <p>Employee’s signature</p>
                       <p><asp:TextBox ID="txtSignature" runat="server" Width="90%" MinWidth="150px"/></p>
                    </td>
                    <td colspan="1" >
                       <p> Date</p>
                         <p><asp:TextBox ID="txtSignatureDate" runat="server" Width="90%" MinWidth="100px" CssClass="center" /></p>
                    </td>
                </tr>
            </table>
        
            <table style="background-color:white; font-size:large; border-bottom: 2px solid black;">
                <tr>
                    <td>
                        <b>Penalty</b> – A penalty of $500 may be imposed for any false statement you make that decreases the amount of money you have withheld from your wages. You may also be subject to criminal penalties.
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                        <b style="color:lightgray;">Employee: detach this page and give it to your employer; keep a copy for your records.</b>
                    </td>
                </tr>
            </table>
            <br />

            <table style="background-color:white; font-size:large;">
                <tr>
                    <td>
                        <b>Employer: Keep this certificate with your records.</b>
                    </td>
                </tr>
                <tr>
                    <td>
                        Mark an <b>X</b> in box A and/or box B to indicate why you are sending a copy of this form to New York State (see instructions):
                    </td>
                </tr>
                <tr>
                    <td>
                        A Employee claimed more than 14 exemption allowances for NYS 
                        <span style="margin-left: 25px;"></span>
                        <asp:CheckBox ID="chkBoxA" runat="server" Text="&nbsp; A &nbsp;" TextAlign="Left"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        B Employee is a new hire or a rehire 
                        <span style="margin-left: 25px;"></span>
                        <asp:CheckBox ID="chkBoxB" runat="server" style="margin-left: 10px;" Text="&nbsp; B &nbsp;" TextAlign="Left"/>
                        &nbsp;First date employee performed services for pay (mm-dd-yyyy) (see instr.):
                        <asp:Label ID="lblOriginalHireDate" runat="server" Style="border: 1px solid black; padding: 3px;" />
                    </td>
                </tr>
                <tr>
                    <td style="padding-left: 25px;">
                            Are dependent health insurance benefits available for this employee?
                            <asp:CheckBox ID="chkDHIBYes" runat="server" Text="&nbsp; Yes &nbsp;" TextAlign="Left" style="margin-left: 10px;" />&nbsp;<span style="margin-left: 25px;"></span>
                        &nbsp;<asp:CheckBox ID="chkDHIBNo" runat="server" Text="&nbsp; No &nbsp;" TextAlign="Left" />
                    </td>
                </tr>
                <tr>
                    <td style="padding-left: 45px;">
                            If Yes, enter the date the employee qualifies(mm-dd-yyyy):
                        <asp:TextBox ID="txtIFchkIsYes" runat="server" />
                    </td>
                </tr>
            </table>
            <br />
            <table class="HRETan" style="margin-bottom: 20px; border-left: 1px solid black; border-top: 1px solid black; border-right: 1px solid black; border-bottom: 2px solid black;font-size:large;">
                <tr>
                    <td style="border-right:1px solid black;">
                        <p>Employer’s name and address (Employer: complete this section only if you are sending a copy of this form to the NYS Tax Department.)
                        </p>
                    </td>
                    <td style="border-right:1px solid black;">
                        <p>Employer identification number</p>
                    </td>
                </tr>
                <tr>
                    <td style="padding-left: 20px; border-right:1px solid black;">
                        <b><asp:Label ID="lblEmployerName" runat="server" /></b>
                        <br />
                        <b><asp:Label ID="lblEmployerAddress" runat="server" /></b>
                        <br />
                        <b><asp:label ID="lblEmployerCityStateZip" runat="server" /></b>
                        <br /> <br />
                    </td>
                    <td style="padding-left: 10px; border-right:1px solid black; text-align:center;">
                        <b><asp:Label ID="lblEmployerIDNo" runat="server" Width="100%" /></b>
                    </td>
                </tr>
            </table>
        </div>

        <div id="DivFormFooter" class="row HRERewrap">
            <br />
            <div style="float:right;">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valw4" OnClick="btnSave_Click"/>
            </div>
        </div>   

    </div>

    <script>
        var toggleIsHide = true;

        $(".instruction_toggle").hide();
        $(".chart_toggle").hide();
        $(".table_toggle").hide();
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
            toggleIsHide = !toggleIsHide;
        });
        $(".table_toggle_btn").click(function () {
            if (toggleIsHide == true) {
                $(this).attr("src", "img/minus.png");
            } else {
                $(this).attr("src", "img/plus.png")
            }
            $(".table_toggle").toggle();
            toggleIsHide = !toggleIsHide;
        });       
    </script>
    <style>
       
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }
        table {background-color:white; color:black;}
        p {color:black;}
        div ul li {color:black;}
        div {color:black; }
        .underline {border-bottom: 1px solid !important; width: 100%; display: inline-block; padding-left: 5px;}
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
        .container, .container-fluid {
    width: auto;
    display: block!important;
 }
    </style>
</asp:Content>
