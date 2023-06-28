<%@ Page Title="Employee W4 Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4.aspx.vb" 
    Inherits="HReaseApp.EE_W4"  
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" runat="Server">
    <div id="tabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>
    </div>
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" Runat="Server">
    <script type="text/javascript">
        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
        
        $(function () {
            var textBox1 = $('input:text[id$=txtW4_Box2]').keyup(foo);
            var textBox2 = $('input:text[id$=txtW4_Box3]').keyup(foo);

   
            $('input:text[id$=hdnPW]').val(document.getElementById('divPWPrint').childNodes[1].innerHTML);

            function foo() {
                var a = textBox1.val();
                var b = textBox2.val();
                var sum = add(a, b);
                $('input:text[id$=txtW4_Box4]').val(sum);
                
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
  
   <div class="HREwrapper">
       <table style="margin-bottom:10px; background-color: white;" >
            <tr>
                <td style="width:100%;"></td>
            </tr>
        </table>
       
       <div id="PageTitle" class="col-md-12">
            <div style="text-align:center;display:inline;">
                <h4><b>Federal W-4</b></h4>
            </div>
        </div>

       <div id="TopHeader" class="form-group" style="display:inline;">                  
            <div id="divError" runat="server" class="HREError" visible="false">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </div>
            <div class="form-group" style="display:inline;">
                <div id="divSuccess" runat="server" visible ="false" class="HRESuccess">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="60px" ImageAlign="Left" />
                    <asp:Label ID="lblSuccess" runat="server"  Text="Form Complete" Width="200px"></asp:Label>
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="60px" Height="60px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="60px" Height="60px" />
                    <br /><br />
                </div>
            </div>
        </div>   

        <div id="divInstructionTitle" class="well" style="margin-top: 20px; padding:20px; margin-right:5%;">
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px" />

        </div>

        <div id="divInstructions" class="well instruction_toggle" style="text-align:center; margin-right:5%;">
            <div>
                <table style="background-color:white; padding: 20px 10px 5px 5px;"> 
                    <tr>
                        <td style="width:2%;"></td>
                        <td style="width:46%;"></td>
                        <td style="width:2%;"></td>
                        <td style="width:48%;"></td>
                        <td style="width:2%;"></td>
                    </tr>
                    <tr>
                        <td colspan ="5" style="border-bottom: 2px solid black;">
                            Form W-4 (2023)
                        </td>
                    </tr>            
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="padding-top: 5px; padding-left:5px;">
                            <p></p>
                            <p style="font-size:20px"><b>General Instructions</b></p>
		                    <p><b>Future developments.</b> For the latest information about developments related to Form W-4, such as legislation enacted after it was published, go to <a href="http://www.irs.gov/FormW4" target="_blank"> www.irs.gov/FormW4</a>.</p>
                            <p><b>Purpose of Form</b> Complete Form W-4 so that your employer can withhold the correct federal income tax from your pay. If too little is withheld, you will generally owe tax when you file your tax return and may owe a penalty. If too much is withheld, you will generally be due a refund. Complete a new Form W-4 when changes to your personal or financial situation would change the entries on the form. For more information on withholding and when you must furnish a new Form W-4, see Pub. 505, Tax Withholding and Estimated Tax.</p>
                            <p><b>Exemption from withholding.</b> You may claim exemption from withholding for 2023 if you meet both of the following conditions: you had no federal income tax liability in 2022 <b>and</b> you expect to have no federal income tax liability in 2023. You had no federal income tax liability in 2022 if (1) your total tax on line 24 on your 2022 Form 1040 or 1040-SR is zero (or less than the sum of lines 27, 28, and 29), or (2) you were not required to file a return because your income was below the filing threshold for your correct filing status. If you claim exemption, you will have no income tax withheld from your paycheck and may owe taxes and penalties when you file your 2023 tax return. To claim exemption from withholding, certify that you meet both of the conditions above by writing “Exempt” on Form W-4 in the space below Step 4(c). Then, complete Steps 1(a), 1(b), and 5. Do not complete any other steps. You will need to submit a new Form W-4 by February 15, 2024.</p>
                            <p><b>Your privacy.</b>  If you have concerns with Step 2(c), you may choose Step 2(b); if you have concerns with Step 4(a), you may enter an additional amount you want withheld per pay period in Step 4(c).</p>
                            <p><b>Self-employment</b>. Generally, you will owe both income and self-employment taxes on any self-employment income you receive separate from the wages you receive as an employee. If you want to pay income and self-employment taxes through withholding from your wages, you should enter the self-employment income on Step 4(a). Then compute your self-employment tax, divide that tax by the number of pay periods remaining in the year, and include that resulting amount per pay period on Step 4(c). You can also add half of the annual amount of self-employment tax to Step 4(b) as a deduction. To calculate self-employment tax, you generally multiply the self-employment income by 14.13% (this rate is a quick way to figure your self-employment tax and equals the sum of the 12.4% social security tax and the 2.9% Medicare tax multiplied by 0.9235). See Pub. 505 for more information, especially if the sum of self-employment income multiplied by 0.9235 and wages exceeds $160,200 for a given individual.</b></p>
                            <p><b>Nonresident alien.</b>  If you’re a nonresident alien, see Notice 1392, Supplemental Form W-4 Instructions for Nonresident Aliens, before completing this form.</p>
                            
                        </td>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align:top;">
                            <p></p>
                            <p style="font-size:20px"><b>Specific Instructions</b></p>
                            <p><b>Step 1(c):</b>  Check your anticipated filing status. This will determine the standard deduction and tax rates used to compute your withholding.</p>
                            <p><b>Step 2.</b> Use this step if you (1) have more than one job at the same time, or (2) are married filing jointly and you and your spouse both work.</p>
                            <p>&nbsp;&nbsp;&nbsp; If you (and your spouse) have a total of only two jobs, you may check the box in option <b>(c)</b>. The box must also be checked on the Form W-4 for the other job. If the box is checked, the standard deduction and tax brackets will be cut in half for each job to calculate withholding. This option is roughly accurate for jobs with similar pay; otherwise, more tax than necessary may be withheld, and this extra amount will be larger the greater the difference in pay is between the two jobs.</p>
                            <p><img src="img/IRSCaution.png" /><b>Multiple jobs.</b> <i>Complete Steps 3 through 4(b) on only one Form W-4. Withholding will be most accurate if you do this on the Form W-4 for the highest paying job.</i></p>
                            <p><b>Step 3</b>.  This step provides instructions for determining the amount of the child tax credit and the credit for other dependents that you may be able to claim when you file your tax return. To qualify for the child tax credit, the child must be under age 17 as of December 31, must be your dependent who generally lives with you for more than half the year, and must have the required social security number. You may be able to claim a credit for other dependents for whom a child tax credit can’t be claimed, such as an older child or a qualifying relative. For additional eligibility requirements for these credits, see Pub. 501, Dependents, Standard Deduction, and Filing Information. You can also include <b>other tax credits</b> for which you are eligible in this step, such as the foreign tax credit and the education tax credits. To do so, add an estimate of the amount for the year to your credits for dependents and enter the total amount in Step 3. Including these credits will increase your paycheck and reduce the amount of any refund you may receive when you file your tax return.
Step 4 </p>
                            <p><b>Step 4 (optional)</b>. </p>
                            <p><b><i>Step 4(a).</i></b> Enter in this step the total of your other estimated income for the year, if any. You shouldn’t include income from any jobs or self-employment. If you complete Step 4(a), you likely won’t have to make estimated tax payments for that income. If you prefer to pay estimated tax rather than having tax on other income withheld from your paycheck, see Form 1040-ES, Estimated Tax for Individuals.</p>
                            <p><b><i>Step 4(b).</i></b> Enter in this step the amount from the Deductions Worksheet, line 5, if you expect to claim deductions other than the basic standard deduction on your 2023 tax return and want to reduce your withholding to account for these deductions. This includes both itemized deductions and other deductions such as for student loan interest and IRAs.</p>
                            <p><b><i>Step 4(c).</i></b>. Enter in this step any additional tax you want withheld from your pay <b>each pay period</b>, including any amounts from the Multiple Jobs Worksheet, line 4. Entering an amount here will reduce your paycheck and will either increase your refund or reduce any amount of tax that you owe.</p>
                            <p>&nbsp;</p>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                </table>

                <table style="background-color:white; padding: 20px 5px 5px 5px;">                                                                                         
                    <tr>
                        <td style="width:2%;"></td>
                        <td style="width:5%;"></td>
                        <td style="width:5%;"></td>
                        <td style="width:3%;"></td>
                        <td style="width:62%;"></td>
                        <td style="width:5%;"></td>
                        <td style="width:5%;"></td>
                        <td style="width:13%;"></td>
                    </tr>
                    <tr>
                        <td colspan ="8"">
                            Form W-4 (2023)
                        </td>
                    </tr>  
                    <tr style="border-top: 2px solid black; border-bottom: 1px solid black;">
                        <td colspan="7" style="vertical-align: middle; text-align: center;">
                           <strong>Step 2(b)—Multiple Jobs Worksheet (Keep for your records.)</strong>
                        </td>
                        <td colspan="1" style="float:right;">
                            <img src="img/IRSPencil.png" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="8">
                            <p></p>
                            <p>If you choose the option in Step 2(b) on Form W-4, complete this worksheet (which calculates the total extra tax for all jobs) on <b>only ONE</b>
                                Form W-4. Withholding will be most accurate if you complete the worksheet and enter the result on the Form W-4 for the highest paying job.
                                To be accurate, submit a new Form W-4 for all other jobs if you have not updated your withholding since 2019.
                            </p>
                            <p><b>Note:</b> If more than one job has annual wages of more than $120,000 or there are more than three jobs, see Pub. 505 for additional
                                tables.</p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align: top; text-align:center;">
                            <b>1</b>
                        </td>
                        <td colspan ="3">
                            <b>Two jobs</b>. If you have two jobs or you’re married filing jointly and you and your spouse each have one
                            job, find the amount from the appropriate table on page 4. Using the “Higher Paying Job” row and the
                            “Lower Paying Job” column, find the value at the intersection of the two household salaries and enter
                            that value on line 1. Then, <b>skip</b> to line 3
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:center;">
                            <b>1</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right;">
                            <b>$</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black; padding-right:10px;">
                            <asp:TextBox ID="txtPW_BoxA" runat="server" CssClass="form-control" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>                       
                    </tr>
                    <tr><td colspan="8">&nbsp;</td></tr>
                    <tr>
                        <td colspan="1">
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align:center;">
                            <b>2</b>
                        </td>
                        <td colspan ="3">
                            <b>Three jobs</b>. If you and/or your spouse have three jobs at the same time, complete lines 2a, 2b, and
                            2c below. Otherwise, skip to line 3.
                        </td>
                        <td colspan="1">    
                        </td>
                        <td colspan="1">     
                        </td>
                        <td colspan="1">      
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">    
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b>a</b>
                        </td>
                        <td colspan ="2">
                            Find the amount from the appropriate table on page 4 using the annual wages from the highest
                            paying job in the “Higher Paying Job” row and the annual wages for your next highest paying job
                            in the “Lower Paying Job” column. Find the value at the intersection of the two household salaries
                            and enter that value on line 2a
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align: center;">
                            <b>2a</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align: right;">
                            <b>$</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black; padding-right:10px;">
                            <asp:TextBox ID="txtPW_BoxB" runat="server" CssClass="form-control" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align:center;">
                            <br />
                            <b>b</b>
                        </td>
                        <td colspan ="2">
                            <br />
                            Add the annual wages of the two highest paying jobs from line 2a together and use the total as the
                            wages in the “Higher Paying Job” row and use the annual wages for your third job in the “Lower
                            Paying Job” column to find the amount from the appropriate table on page 4 and enter this amount
                            on line 2b
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:center;">
                            <br />
                            <b>2b</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align: right;">
                            <br />
                            <b>$</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black; padding-right:10px;">
                            <br />
                            <asp:TextBox ID="txtPW_BoxC" runat="server" CssClass="form-control" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <br />
                            <b>c</b>
                        </td>
                        <td colspan ="2">
                            <br />
                            Add the amounts from lines 2a and 2b and enter the result on line 2c
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align: center;">
                            <br />
                            <b>2c</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align: right;">
                            <br />
                            <b>$</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black; padding-right:10px;">
                            <br />
                            <asp:TextBox ID="txtPW_BoxD" runat="server" CssClass="form-control" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                    </tr>
                    <tr><td colspan="8">&nbsp;</td></tr>
                    <tr>
                        <td colspan="1">
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b>3</b>
                        </td>
                        <td colspan ="3">
                            Enter the number of pay periods per year for the highest paying job. For example, if that job pays
                            weekly, enter 52; if it pays every other week, enter 26; if it pays monthly, enter 12, etc.
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align: center;">
                            <b>3</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align: right;">
                            <b>$</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black; padding-right:10px;">
                            <asp:TextBox ID="txtPW_BoxE" runat="server" CssClass="form-control" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                        </td>
                    </tr>
                    <tr><td colspan="8">&nbsp;</td></tr>
                    <tr>
                        <td colspan="1">
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b>4</b>
                        </td>
                        <td colspan ="3">
                            <b>Divide</b> the annual amount on line 1 or line 2c by the number of pay periods on line 3. Enter this
                            amount here and in <b>Step 4(c)</b> of Form W-4 for the highest paying job (along with any other additional
                            amount you want withheld)
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align: center;">
                            <b>4</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align: right;">
                            <b>$</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black; padding-right:10px;">
                            <asp:TextBox ID="txtPW_BoxF" runat="server" CssClass="form-control" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                    </tr>
                    <tr><td colspan="8">&nbsp;</td></tr>
                    <tr style="border-top: 2px solid black; border-bottom: 1px solid black;">
                        <td colspan="7" style="vertical-align: middle; text-align: center;">
                            <strong>Step 4(b)—Deductions Worksheet (Keep for your records.)</strong>
                        </td>
                        <td colspan="1" style="float:right;">
                            <img src="img/IRSPencil.png" />
                        </td>
                    </tr>
                    <tr><td colspan="8">&nbsp;</td></tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align: top; text-align:center;">
                            <b>1</b>
                        </td>
                        <td colspan ="3">
                            Enter an estimate of your 2023 itemized deductions (from Schedule A (Form 1040 or 1040-SR)). Such
                            deductions may include qualifying home mortgage interest, charitable contributions, state and local
                            taxes (up to $10,000), and medical expenses in excess of 7.5% of your income
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:center;">
                            <b>1</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right;">
                            <b>$</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black; padding-right:10px;">
                            <asp:TextBox ID="txtID_Box1" runat="server" CssClass="form-control" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                    </tr>
                    <tr><td colspan="8">&nbsp;</td></tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align: middle; text-align:center;">
                            <b>2</b>
                        </td>
                        <td colspan="1" style="text-align: left; vertical-align:middle;" >
                            Enter: 
                        </td>
                        <td colspan="1" style="vertical-align: middle;" >
                           <h1>{</h1>
                        </td>
                        <td colspan ="1" style="vertical-align: middle;">
                            
                            • $27,700 if you’re married filing jointly or qualifying widow(er)<br />
                            • $20,800 if you’re head of household <br />
                            • $13,850 if you’re single or married filing separately
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:center;">
                            <b>2</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right;">
                            <b>$</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black; padding-right:10px;">
                            <asp:TextBox ID="txtID_Box2" runat="server" CssClass="form-control" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                    </tr>
                    <tr><td colspan="8">&nbsp;</td></tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align: top; text-align:center;">
                            <b>3</b>
                        </td>
                        <td colspan ="3">
                            If line 1 is greater than line 2, subtract line 2 from line 1. If line 2 is greater than line 1, enter “-0-”
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:center;">
                            <b>3</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right;">
                            <b>$</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black; padding-right:10px;">
                            <asp:TextBox ID="txtID_Box3" runat="server" CssClass="form-control" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                    </tr>
                    <tr><td colspan="8">&nbsp;</td></tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align: top; text-align:center;">
                            <b>4</b>
                        </td>
                        <td colspan ="3">
                            Enter an estimate of your student loan interest, deductible IRA contributions, and certain other
                            adjustments (from Part II of Schedule 1 (Form 1040 or 1040-SR)). See Pub. 505 for more information
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:center;">
                            <b>4</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right;">
                            <b>$</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black; padding-right:10px;">
                            <asp:TextBox ID="txtID_Box4" runat="server" CssClass="form-control" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                    </tr>
                    <tr><td colspan="8">&nbsp;</td></tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style="vertical-align: top; text-align:center;">
                            <b>5</b>
                        </td>
                        <td colspan ="3">
                            <b>Add</b> lines 3 and 4. Enter the result here and in <b>Step 4(b)</b> of Form W-4
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:center;">
                            <b>5</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right;">
                            <b>$</b>
                        </td>
                        <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black; padding-right:10px;">
                            <asp:TextBox ID="txtID_Box5" runat="server" CssClass="form-control" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                    </tr>
                    <tr><td colspan="8">&nbsp;</td></tr>
                </table>
                
                <table style=" background-color:white; border-top:2px solid black; padding: 20px 5px 5px 5px;">
                    <tr>
                        <td style="width:2%;"></td>
                        <td style="width:45%;"></td>
                        <td style="width:3%;"></td>
                        <td style="width:45%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>                 
                        <td colspan="1">
                            <p></p>
                            <p><b>Privacy Act and Paperwork Reduction Act Notice</b>. We ask for the information
                            on this form to carry out the Internal Revenue laws of the United States. Internal
                            Revenue Code sections 3402(f)(2) and 6109 and their regulations require you to
                            provide this information; your employer uses it to determine your federal income
                            tax withholding. Failure to provide a properly completed form will result in your
                            being treated as a single person with no other entries on the form; providing
                            fraudulent information may subject you to penalties. Routine uses of this
                            information include giving it to the Department of Justice for civil and criminal
                            litigation; to cities, states, the District of Columbia, and U.S. commonwealths and
                            possessions for use in administering their tax laws; and to the Department of
                            Health and Human Services for use in the National Directory of New Hires. We
                            may also disclose this information to other countries under a tax treaty, to federal
                            and state agencies to enforce federal nontax criminal laws, or to federal law
                            enforcement and intelligence agencies to combat terrorism.</p>
                        </td>
                        <td colspan="1"></td>
                        <td colspan="1" style ="vertical-align:top;">
                            <p></p>
                            <p>&nbsp;&nbsp;You are not required to provide the information requested on a form that is
                            subject to the Paperwork Reduction Act unless the form displays a valid OMB
                            control number. Books or records relating to a form or its instructions must be
                            retained as long as their contents may become material in the administration of
                            any Internal Revenue law. Generally, tax returns and return information are
                            confidential, as required by Code section 6103.</p>
                            <p>&nbsp;&nbsp;The average time and expenses required to complete and file this form will vary
                            depending on individual circumstances. For estimated averages, see the
                            instructions for your income tax return.</p>
                            <p>&nbsp;&nbsp;If you have suggestions for making this form simpler, we would be happy to hear
                            from you. See the instructions for your income tax return.</p>
                        </td>
                    </tr>
                </table>

                <table style="background-color:white; padding: 20px 5px 5px 5px;">
                    <tr>
                        <td style="width:1%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:1%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:1%;"></td>
                    </tr>
                    <tr>
                        <td colspan ="17">
                            Form W-4 (2023)
                        </td>
                    </tr>  
                    <tr style="border-top: 3px solid black; border-bottom: 1px solid black;">
                        <td colspan="17" style="vertical-align: middle; text-align: center;">
                            <p></p>
                           <h3><strong>Married Filing Jointly or Qualifying Widow(er)</strong></h3>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="3" rowspan="3" style="border-right: 2px solid black; text-align:center; border-bottom:1px solid black;">
                            <strong>Higher Paying Job<br />Annual Taxable<br />Wage & Salary</strong>
                        </td>
                        <td colspan="12" style ="vertical-align:bottom; text-align: center; border-bottom:1px solid black;">
                            <strong>Lower Paying Job Annual Taxable Wage & Salary</strong>
                        </td>
                        <td colspan="1" style="border-bottom:1px solid black;"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$0 - </td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$10,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$20,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$30,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$40,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$50,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$60,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$70,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$80,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$90,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$100,000 -</td>
                        <td colspan="1" style ="text-align: center;">$110,000 -</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                       <td colspan="1"></td>
                       <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">9,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">19,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">29,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">39,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">49,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">59,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">69,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">79,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">89,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">99,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">109,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black;">120,000</td>
                        <td colspan="1" style="border-bottom:1px solid black;"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$0</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">9,999</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$0</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$0</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$850</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$850</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,000</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">$1,870</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$10,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">19,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">0</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1930</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,850</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,000</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,200</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,220</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,220</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,220</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,220</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,220</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,200</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">4,070</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$20,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">29,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">850</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,850</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,920</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,120</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,320</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,340</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,340</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,340</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,340</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,320</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,320</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">6,190</td>
                        <td colspan="1"></td>
                    </tr>
                  
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$30,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">39,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">850</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,000</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,120</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,320</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,520</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,540</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,540</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,540</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,520</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,520</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,520</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">7,390</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$40,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">49,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,000</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,200</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,320</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,520</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,740</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,740</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">8,590</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$50,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">59,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,220</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,340</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,540</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,740</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,760</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">9,610</td>
                        <td colspan="1"></td>
                    </tr>

                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$60,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">69,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,220</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,340</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,540</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,740</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">10,610</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$70,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">79,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,220</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,340</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,540</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">11,610</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$80,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">99,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,220</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,170</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,370</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,570</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,600</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,600</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,600</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,600</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,600</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">12,600</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">13,460</td>
                        <td colspan="1"></td>
                    </tr>

                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$100,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">149,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,070</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,190</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,390</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,590</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,660</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">12,860</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">14,060</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">15,260</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">16,330</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$150,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">239,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,040</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,440</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,760</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,160</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,660</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">12,860</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">13,180</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">14,380</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">15,580</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">16,780</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">17,850</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$240,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">259,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,040</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,440</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,760</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,160</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,560</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,780</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">13,180</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">14,380</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">15,580</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">16,780</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">17,850</td>
                        <td colspan="1"></td>
                    </tr>

                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$260,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">279,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,040</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,440</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,760</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,160</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,560</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,780</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,980</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">13,180</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">14,380</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">15,580</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">16,780</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">18,140</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$280,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">299,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,040</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,440</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,760</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,160</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,560</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,780</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,980</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">13,180</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">14,380</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">15,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">17,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">19,740</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$300,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">319,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,040</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,440</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,760</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,160</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,560</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,780</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,980</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">13,470</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">15,470</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">17,470</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">19,470</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">21,340</td>
                        <td colspan="1"></td>
                    </tr>

                     <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$320,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">364,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,040</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,440</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,760</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,550</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">12,770</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">14,770</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">16,770</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">18,770</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">20,770</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">22,770</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">24,640</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$365,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">524,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,970</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,470</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,890</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">12,390</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">14,890</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">17,220</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">19,520</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">21,820</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">24,120</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">26,420</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">28,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">30,880</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$525,000</td>
                        <td colspan="2" style= "border-right:2px solid black;">and over</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,140</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,840</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,460</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">13,160</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">15,860</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">18,390</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">20,890</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">23,390</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">25,890</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">28,390</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">30,890</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">33,250</td>
                        <td colspan="1"></td>
                    </tr>
                </table>

                <table style="background-color:white; padding: 20px 5px 5px 5px;">
                    <tr>
                        <td style="width:1%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:1%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:1%;"></td>
                    </tr>
                   
                    <tr style="border-top: 3px solid black; border-bottom: 1px solid black;">
                        <td colspan="17" style="vertical-align: middle; text-align: center;">
                            <p></p>
                           <h3><strong>Single or Married Filing Separately</strong></h3>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="3" rowspan="3" style="border-right: 2px solid black; text-align:center; border-bottom:1px solid black;">
                            <strong>Higher Paying Job<br />Annual Taxable<br />Wage & Salary</strong>
                        </td>
                        <td colspan="12" style ="vertical-align:bottom; text-align: center; border-bottom:1px solid black;">
                            <strong>Lower Paying Job Annual Taxable Wage & Salary</strong>
                        </td>
                        <td colspan="1" style="border-bottom:1px solid black;"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$0 - </td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$10,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$20,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$30,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$40,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$50,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$60,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$70,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$80,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$90,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$100,000 -</td>
                        <td colspan="1" style ="text-align: center;">$110,000 -</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                       <td colspan="1"></td>
                       <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">9,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">19,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">29,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">39,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">49,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">59,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">69,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">79,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">89,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">99,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">109,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black;">120,000</td>
                        <td colspan="1" style="border-bottom:1px solid black;"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$0</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">9,999</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">400</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">930</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,250</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,970</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$2,040</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">$2,040</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$10,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">19,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">310</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">890</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,630</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,600</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,600</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,600</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,600</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,600</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,760</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,960</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">3,970</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$20,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">29,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,880</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,730</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,890</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,090</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,290</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,290</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">5,300</td>
                        <td colspan="1"></td>
                    </tr>
                  
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$30,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">39,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,730</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,890</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,090</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,290</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,490</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">6,500</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$40,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">59,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,710</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,450</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,570</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,570</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,570</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,700</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,910</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,110</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,310</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,510</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,710</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">8,720</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$60,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">79,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,600</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,730</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,860</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,060</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,260</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,460</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,660</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,860</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,060</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,260</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">9,280</td>
                        <td colspan="1"></td>
                    </tr>

                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$80,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">99,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,730</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,060</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,260</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,660</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,860</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,060</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,260</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,260</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,460</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,430</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">11,240</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$100,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">124,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,040</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,970</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,300</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,500</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,700</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,900</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,110</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">12,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">13,430</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$125,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">149,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,040</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,970</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,300</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,500</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,700</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">12,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">13,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">14,900</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">16,020</td>
                        <td colspan="1"></td>
                    </tr>

                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$150,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">174,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,240</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,970</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">12,610</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">13,750</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">15,050</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">16,350</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">17,650</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">18,770</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$175,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">199,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,450</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,580</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,580</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,580</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">13,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">15,180</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">16,480</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">17,780</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">19,080</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">20,280</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">21,490</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$200,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">249,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,900</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,930</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,360</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,660</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">12,960</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">15,260</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">16,570</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">17,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">19,170</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">20,470</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">21,770</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">22,880</td>
                        <td colspan="1"></td>
                    </tr>

                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$250,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">399,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,970</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,010</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,440</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,740</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">13,040</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">15,340</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">16,640</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">17,940</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">19,240</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">20,540</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">21,840</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">22,960</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$400,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">449,999</td>

                        <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$250,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">399,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,970</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,010</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,440</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,740</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">13,040</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">15,340</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">16,640</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">17,940</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">19,240</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">20,540</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">21,840</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">22,960</td>
                        <td colspan="1"></td>
                    </tr>
                    

                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$450,000</td>
                        <td colspan="2" style= "border-right:2px solid black;">and over</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,140</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,380</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,010</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,510</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">14,010</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">16,510</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">18,010</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">19,510</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">21,010</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">22,510</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">24,010</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">25,330</td>
                        <td colspan="1"></td>
                    </tr>
                </table>

                <table style="background-color:white; padding: 20px 5px 5px 5px;">
                    <tr>
                        <td style="width:1%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:1%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:6%;"></td>
                        <td style="width:1%;"></td>
                    </tr>
                   
                    <tr style="border-top: 3px solid black; border-bottom: 1px solid black;">
                        <td colspan="17" style="vertical-align: middle; text-align: center;">
                            <p></p>
                           <h3><strong>Head of Household</strong></h3>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="3" rowspan="3" style="border-right: 2px solid black; text-align:center; border-bottom:1px solid black;">
                            <strong>Higher Paying Job<br />Annual Taxable<br />Wage & Salary</strong>
                        </td>
                        <td colspan="12" style ="vertical-align:bottom; text-align: center; border-bottom:1px solid black;">
                            <strong>Lower Paying Job Annual Taxable Wage & Salary</strong>
                        </td>
                        <td colspan="1" style="border-bottom:1px solid black;"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$0 - </td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$10,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$20,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$30,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$40,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$50,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$60,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$70,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$80,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$90,000 -</td>
                        <td colspan="1" style ="text-align: center; border-right:1px solid black;">$100,000 -</td>
                        <td colspan="1" style ="text-align: center;">$110,000 -</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                       <td colspan="1"></td>
                       <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">9,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">19,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">29,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">39,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">49,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">59,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">69,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">79,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">89,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">99,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black; border-right:1px solid black;">109,999</td>
                        <td colspan="1" style ="text-align: center; border-bottom:1px solid black;">120,000</td>
                        <td colspan="1" style="border-bottom:1px solid black;"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$0</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">9,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$0</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$620</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$860</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,190</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$1,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">$2,040</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">$2,040</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$10,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">19,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">620</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,630</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,060</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,220</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,220</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,220</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,850</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,850</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,070</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,090</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,290</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">4,440</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$20,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">29,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">860</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,060</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,490</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,650</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,650</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,280</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,280</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,280</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,520</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,920</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">6,070</td>
                        <td colspan="1"></td>
                    </tr>
                  
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$30,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">39,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,220</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,650</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,810</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,440</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,440</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,440</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,460</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,880</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,080</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,280</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">7,430</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$40,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">59,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,220</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,130</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,290</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,290</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,290</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,480</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,680</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,100</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,300</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,500</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">9,650</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$60,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">79,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,500</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,700</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,130</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,290</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,480</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,680</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,880</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,080</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,500</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,700</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,900</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">12,050</td>
                        <td colspan="1"></td>
                    </tr>

                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$80,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">99,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">1,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,070</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,690</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,050</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,250</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,450</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">10,650</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,850</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">12,260</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">12,460</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">12,870</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">13,820</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$100,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">124,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,040</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,440</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,070</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,430</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,630</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,830</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,030</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">12,230</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">13,190</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">14,190</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">15,190</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">16,150</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$125,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">149,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,040</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,440</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,070</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,430</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">8,630</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,980</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,980</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">13,980</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">15,190</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">16,190</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">17,270</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">18,530</td>
                        <td colspan="1"></td>
                    </tr>

                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$150,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">174,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,040</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">4,460</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,070</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,980</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,980</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,980</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">13,980</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">15,980</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">17,420</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">18,720</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">20,020</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">21,280</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$175,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">199,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,190</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">5,390</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">7,820</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,980</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,980</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">14,060</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">16,360</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">18,660</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">20,170</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">21,470</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">22,770</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">24,030</td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$200,000</td>
                        <td colspan="1">-</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:2px solid black;">449,999</td>

                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">2,970</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,470</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,100</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">11,660</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">13,960</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">16,260</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">18,560</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">20,860</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">22,380</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">23,680</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">24,980</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">26,230</td>
                        <td colspan="1"></td>
                    </tr>
                                        
                    <tr style="border-bottom:1px solid black;">
                        <td colspan="1"></td>
                        <td colspan="1" style ="text-align: right;">$450,000</td>
                        <td colspan="2" style= "border-right:2px solid black;">and over</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">3,140</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">6,840</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">9,770</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">12,430</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">14,930</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">17,430</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">19,930</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">22,430</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">24,430</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">25,650</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; border-right:1px solid black;">27,150</td>
                        <td colspan="1" style ="text-align: right; padding-right:10px; ">28,600</td>
                        <td colspan="1"></td>
                    </tr>
                </table>
            </div>
        </div>

        <div id="divW4" runat ="server" style="page-break-before: always; font-size:medium; margin-right:5%;">
            <div class="well-sucess">
                <div id="divWMainForm">
                    <table id="tblW4Header" style="background-color:#FFF;"  >
                        <tr>
                            <td style="width: 15%;"></td>
                            <td style="width: 70%;"></td>
                            <td style="width: 15%;"></td>
                        </tr>
                        <tr>
                            <td class="nowrap" style="border-bottom:3px solid black; border-right:3px solid black;">
                                <p style="font-size:medium;">Form</p>
                                <h1><strong>W-4</strong></h1>
                                <br /> 
                                Department of the Treasury
                                <br /> 
                                Internal Revenue Service
                            </td>
                            <td style="text-align: center; border-bottom:3px solid black; border-right:3px solid black;">
                                <h2><strong>Employee’s Withholding Certificate</strong></h2>
                               <strong>▶ Complete Form W-4 so that your employer can withhold the correct federal income tax from your pay.<br />
                                ▶ Give Form W-4 to your employer.<br />
                                ▶ Your withholding is subject to review by the IRS.</strong>
                            </td>
                            <td style="border-bottom:3px solid black;">
                                <p style="border-bottom:1px solid black; text-align:center;">OMB No. 1545-0074</p>
                                <h1 style="text-align:center; vertical-align:bottom;"><b>2023</b></h1>
                               
                            </td>
                        </tr>
                    </table>

                    <table style="background-color:#FFF;">
                        <tr>
                            <td style="width: 10%" ></td> 
                            <td style="width: 2%"></td>
                            <td style="width: 8%"></td>
                            <td style="width: 20%" ></td>
                            <td style="width: 30%"></td>
                            <td style="width: 30%"></td>
                        </tr>
                        <tr>
                            <td colspan="1" rowspan="9" style="vertical-align:top; border-right:1px solid black; border-bottom:1px solid black; font-size:medium;">
                                <strong>Step 1:<br />
                                    Enter<br />
                                    Personal <br />
                                    Information
                                </strong></>
                            </td>
                            <td colspan="1">
                                <b>(a)</b>
                            </td>
                            <td colspan="2" style="border-right:1px solid black;">
                                First name and middle initial
                            </td>
                            <td colspan="1" style="border-right:1px solid black;">
                                Last name
                            </td>
                            <td colspan="1" >
                                <b>(b) Social security number</b>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="border-bottom: 1px solid black;"></td>
                            <td colspan="2" style="border-right:1px solid black; border-bottom: 1px solid black; background-color: #f5f5f5;">
                                <b><asp:Label ID="lblFirstName" runat="server" Text ="Enter on Profile Page"></asp:Label></b>
                            </td>
                            <td colspan="1" style="border-right:1px solid black; border-bottom: 1px solid black; background-color: #f5f5f5;">
                                <b><asp:Label ID="lblLastName" runat="server" Text ="Enter on Profile Page"></asp:Label></b>
                            </td>
                            <td colspan="1" style="border-bottom: 1px solid black; background-color: #f5f5f5;">
                                <b><asp:Label ID="lblSSN" runat="server" Style="padding-left:10%;"></asp:Label></b>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="border-right:1px solid black; padding-left:10px;">
                                Address
                            </td>
                            <td colspan="1" rowspan ="4" style= "border-bottom: 1px solid black;">
                                ▶ Does your name match the name on your social security card? If not, to ensure you get credit for 
                                    your earnings, contact SSA at 800-772-1213 or go to <a href="http://www.ssa.gov" target="_blank">www.ssa.gov</a>.
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="border-bottom: 1px solid black;"></td>
                            <td colspan="3" style="border-right:1px solid black; border-bottom: 1px solid black; background-color: #f5f5f5;">
                                <b><asp:Label ID="lblAddress" runat="server" Text ="Enter on Profile Page"></asp:Label></b>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" style="border-right:1px solid black;">
                                City or town, state and ZIP code
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="border-bottom:1px solid black;"></td>
                            <td colspan="3" style="border-bottom:1px solid black; background-color: #f5f5f5;">
                                <b><asp:Label ID="lblCityStateZip" runat="server" Text ="Enter on Profile Page"></asp:Label></b>
                            </td>
                        </tr>
                        <tr style="border-bottom: 2px solid black;">
                            <td colspan="1" style="vertical-align:top;">
                                <b>(c)</b>
                            </td>
                            <td colspan="4">
                                <b><asp:CheckBox ID="chkSingle" runat="server" autopostback="true" OnCheckedChanged="chkSingle_CheckedChanged" style="background-color: #EFF3FB;"/>
                                <b>Single</b> or <b>Married filing separately</b><br />
                                <asp:CheckBox ID="chkMarried" runat="server" autopostback="true" OnCheckedChanged="chkMarried_CheckedChanged" style="background-color: #EFF3FB;"/>
                                <b>Married filing jointly (or Qualifying widow(er))</b><br />
                                <asp:CheckBox ID="chkHOH" runat="server"  autopostback="true" OnCheckedChanged="chkHOH_CheckedChanged" style="background-color: #EFF3FB;" />
                                <b>Head of household</b> (Check only if you’re unmarried and pay more than half the costs of keeping up a home for yourself and a qualifying individual.)</b>
                            </td> 
                        </tr>
                    </table>

                    <table style="background-color:#FFF; font-size:medium;">
                        <tr>
                            <td style="border-top:2px solid black; border-bottom:2px solid black;">
                                <b>Complete Steps 2–4 ONLY if they apply to you; otherwise, skip to Step 5.</b> 
                                See page 2 for more information on each step, who can claim exemption from withholding, other details, and privacy.
                                
                            </td>
                        </tr>
                     </table>

                    <table style="background-color:#FFF; border-top: 2px solid black; border-bottom: 2px solid black; font-size:medium;">
                        <tr>
                            <td style="width:13%"></td>
                            <td style="width:3%"></td>
                            <td style="width:74%"></td>
                        </tr>
                        <tr>
                            <td colspan="1" rowspan="2" style="vertical-align:top;">
                                <strong>Step 2:<br />
                                Multiple Jobs <br />
                                or Spouse Works
                                    </strong>
                            </td>
                            <td colspan="2">
                               Complete this step if you (1) hold more than one job at a time, or (2) are married filing jointly 
                                and your spouse also works. The correct amount of withholding depends on income earned from all of 
                                these jobs.
                                <br /><br />
                                Do <b>only one </b> of the following.
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="vertical-align:top;">
                               <b>(a)</b>
                            </td>
                            <td colspan="1">
                                Reserved for future use.
                                <b>or</b>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1"></td>
                            <td colspan="1" style="vertical-align:top;">
                               <b>(b)</b>
                            </td>
                            <td colspan="1">
                                Use the Multiple Jobs Worksheet on page 3 and enter the result in Step 4(c) below; <b>or</b>
                                <b>or</b>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1"></td>
                            <td colspan="1" style="vertical-align:top;">
                                <b>(c)</b>
                            </td>
                            <td colspan="1">
                                If there are only two jobs total, you may check this box. Do the same on Form W-4 for the other job. This 
                                option is generally more accurate than (b) if pay at the lower paying job is more than half of the pay at the 
                                higher paying job. Otherwise, (b) is more accurate
                                   <asp:CheckBox ID="chkMultipleJobsOrSpouseWorks" runat="server" Text="" TabIndex="2" Style ="float:right" Width="50px" />
                                    <br />                                
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1"></td>
                            <td colspan="2">
                                <b>TIP:</b> If you have self-employment income, see page 2.
                                 have self-employment income, including as an independent contractor, use the estimator.
                            </td>
                        </tr>
                    </table>

                    <table style="background-color:#FFF; border-bottom: 2px solid black; font-size:medium;">
                        <tr>
                            <td>
                               <b>Complete Steps 3–4(b) on Form W-4 for only ONE of these jobs.</b> Leave those steps blank for 
                                 the other jobs. (Your withholding will be most accurate if you complete Steps 3–4(b) on the 
                                 Form W-4 for the highest paying job.)
                            </td>
                        </tr>
                    </table>

                    <table style="background-color:#FFF; border-top: 2px solid black; border-bottom: 2px solid black;">
                        <tr>
                            <td style="width:13%"></td>
                            <td style="width:47%"></td>
                            <td style="width:2%"></td>
                            <td style="width:2%"></td>
                            <td style="width:15%"></td>
                            <td style="width:6%"></td>
                            <td style="width:2%"></td>
                            <td style="width:13%"></td>
                        </tr>
                        <tr>
                            <td colspan="1" rowspan="4" style="vertical-align:top;">
                                <strong>Step 3:<br />
                                Claim <br />
                                Dependents
                                    </strong>
                            </td>
                            <td colspan="4">
                               If your income will be $200,000 or less ($400,000 or less if married filing jointly):
                                <br />
                                
                            </td>
                            <td colspan="1" style="border-left: 1px solid black; border-right: 1px solid black;"></td>
                            <td colspan="2" ></td>
                        </tr>
                        <tr>
                            <td colspan="1">
                                Multiply the number of qualifying children under age 17 by $2,000 
                            </td>
                            <td colspan="1" style="vertical-align: bottom;">▶</td>
                            <td colspan="1" style="vertical-align: bottom;">$</td>
                            <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black;">
                                <asp:TextBox ID="txtW4_Box2" runat="server" CssClass="form-control" Style="text-align:right; font-weight:inherit; margin-right:35px;" MinWidth="70px" onkeypress="return onlyNumbers();"></asp:TextBox>
                            </td>
                            <td colspan="1" style="border-left: 1px solid black; border-right: 1px solid black;"></td>
                            <td colspan="1"></td>
                        </tr>
                        <tr>
                            <td colspan="1">
                                Multiply the number of other dependents by $500
                            </td>
                            <td colspan="1" style="vertical-align: bottom;">▶</td>
                            <td colspan="1" style="vertical-align: bottom;">$</td>
                            <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black;">
                                <asp:TextBox ID="txtW4_Box3" runat="server" CssClass="form-control" Style="text-align:right; font-weight:inherit; margin-right:35px;" MinWidth="70px" Font="10pt" onkeypress="return onlyNumbers();"></asp:TextBox>
                            </td>
                            <td colspan="1" style="border-left: 1px solid black; border-right: 1px solid black;"></td>
                            <td colspan="1"></td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                Add the amounts above for qualifying children and other dependents. You may add to this the amount of any other credits. Enter the total here
                            </td>
                            <td colspan="1" style="border-left: 1px solid black; border-right: 1px solid black; text-align: center;">
                                <b>3</b>
                            </td>
                            <td colspan="1">$</td>
                            <td colspan="1">
                                <asp:TextBox ID="txtW4_Box4" runat="server" CssClass="form-control" Style="text-align:right;font-weight:inherit; margin-right:35px;" MinWidth="70px" onkeypress="return onlyNumbers();"></asp:TextBox></td>
                        </tr>
                    </table>

                    <table style="background-color:#FFF; border-top: 2px solid black; border-bottom: 2px solid black;">
                        <tr>
                            <td style="width:13%"></td>
                            <td style="width:3%"></td>
                            <td style="width:63%"></td>
                            <td style="width:6%"></td>
                            <td style="width:2%"></td>
                            <td style="width:14%"></td>
                        </tr>
                        <tr>
                            <td colspan="1" rowspan="4" style="vertical-align:top;">
                                <strong>Step 4:<br />
                                (optional): <br />
                                Other Adjustments
                                    </strong>
                            </td>
                            <td colspan="1" style="vertical-align:top;">
                                <b>(a)</b>
                            </td>
                            <td colspan="1">
                               <b>Other income (not from jobs). </b>If you want tax withheld for other income you 
                                expect this year that won’t have withholding, enter the amount of other income here. 
                                This may include interest, dividends, and retirement income
                                <br />
                                
                            </td>
                            <td colspan="1" style="vertical-align: bottom; border-left: 1px solid black; border-right: 1px solid black; text-align: center;">
                                <b>4(a)</b>
                            </td>
                            <td colspan="1" style="vertical-align: bottom;">$</td>
                            <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black;">
                                <asp:TextBox ID="txtW4_Box5" runat="server" CssClass="form-control" Style="text-align:right; font-weight:inherit; margin-right:35px;" MinWidth="70px" onkeypress="return onlyNumbers();"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="vertical-align:top;">
                                <b>(b)</b>
                            </td>
                            <td colspan="1">
                               <b>Deductions.</b> If you expect to claim deductions other than the standard deduction and 
                                want to reduce your withholding, use the Deductions Worksheet on page 3 and enter 
                                the result here 
                                <br />
                                
                            </td>
                            <td colspan="1" style="vertical-align: bottom; border-left: 1px solid black; border-right: 1px solid black; text-align: center;">
                                <b>4(b)</b>
                            </td>
                            <td colspan="1" style="vertical-align: bottom;">$</td>
                            <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black;">
                                <asp:TextBox ID="txtW4_Box6" runat="server" CssClass="form-control" Style = "text-align:right;font-weight:inherit; margin-right:35px;" MinWidth="70px" onkeypress="return onlyNumbers();"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="vertical-align:top;">
                                <b>(c)</b>
                            </td>
                            <td colspan="1">
                               <b>Extra withholding.</b> Enter any additional tax you want withheld each <b>pay period</b>.
                                <br />
                                
                            </td>
                            <td colspan="1" style="vertical-align: bottom; border-left: 1px solid black; border-right: 1px solid black; text-align: center;">
                                <b>4(c)</b>
                            </td>
                            <td colspan="1" style="vertical-align: bottom;">$</td>
                            <td colspan="1" style="vertical-align: bottom; text-align:right; border-bottom: 1px solid black;">
                                <asp:TextBox ID="txtAdditionalWithholding" runat="server" CssClass="form-control" Style = "text-align:right;font-weight:inherit; margin-right:35px;" MinWidth="70px" onkeypress="return onlyNumbers();"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="border-bottom: 1px solid black;">

                            </td>
                        </tr>
                    </table>
                
                    <table style="background-color:#FFF; border-top: 1px solid black; border-bottom: 2px solid black;">
                        <tr>
                            <td style ="width:10%;"></td>
                            <td style ="width:60%;"></td>
                            <td style ="width:10%;"></td>
                            <td style ="width:20%;"></td>
                        </tr>
                        <tr>
                            <td colspan="1" rowspan="3" style="vertical-align:top;">
                                <strong>Step 5:<br />
                                Sign<br />
                                Here
                                    </strong>
                            </td>
                            <td colspan ="3">
                                Under penalties of perjury, I declare that this certificate, to the best of my knowledge and belief, is true, correct, and complete.
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="border-bottom: 1px solid black;">
                                ▶<asp:TextBox ID="txtSignature" runat ="server" Style="width:95%;" placeholder="Full Name" ></asp:TextBox>
                            </td>
                            <td colspan="2" style="border-bottom: 1px solid black;">
                                ▶<asp:TextBox ID ="txtSignatureDate" runat="server" Style="width:95%; padding-left:5px"></asp:TextBox>
                             </td>
                        </tr>
                        <tr>
                            <td colspan="1">
                                <b>Employee’s signature </b> (This form is not valid unless you sign it.)
                            </td>
                            <td colspan="2">
                                <b>Date</b>
                            </td>
                        </tr>
                        <tr style="border-top: 1px solid black; border-bottom: 1px solid black;">
                            <td colspan="1" rowspan="2" style="vertical-align:top;">
                                <strong>Employers<br />
                                Only
                                    </strong>
                            </td>
                            <td colspan ="1">
                                Employer’s name and address
                                <br />
                            </td>
                            <td colspan ="1">
                                First date of employment
                            </td>
                            <td colspan ="1">
                                Employer identification number (EIN)
                            </td>
                        </tr>
                         <tr>
                            <td colspan="1" style="border-right: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;background-color: #f5f5f5;">
                                    &nbsp;<b><asp:Label ID="lblEmployerName" TextMode="MultiLine" runat="server" Style="display: inline; width: 95%;" ></asp:Label></b><br />
                                    &nbsp;<b><asp:Label ID="lblEmployerAddress" TextMode="MultiLine" runat="server" Style="display: inline; width: 95%;" ></asp:Label></b><br />
                                    &nbsp;<b><asp:Label ID="lblEmployerCityStateZip" TextMode="MultiLine" runat="server" Style="display: inline; width: 95%;" ></asp:Label></b>
                            </td>
                            <td colspan="1" style="border-right: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;background-color: #f5f5f5;" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <b><asp:Label ID="lblLatestHireDate" runat="server" > </asp:Label></b></td>
                            <td colspan="1" style="border-bottom: #5f5c5c 1px solid;background-color: #f5f5f5;" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <b><asp:Label ID="lblEmployerFEIN" runat="server" > </asp:Label></b></td>
                        </tr>
                        <tr>
                            <td colspan ="2" style="font-weight:bold">
                                For Privacy Act and Paperwork Reduction Act Notice, see page 3.
                            </td>
                            <td colspan="1">
                                Cat.No. 10220Q
                            </td>
                            <td colspan="1" style="text-align:right;">
                                Form <strong>W-4</strong> (2023)
                            </td>
                        </tr>
                    </table>
                       
                </div>
        
                <div class="form-group">
                     <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                          <br />  <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" OnClick="btnSave_Click"/>
                    </div>
                </div>
            </div>
        </div>

 
        <input id="hdnPW" type="text" runat="server" visible="false" />
        <input id="hdnW4" type="text" runat="server" visible="false"  />
        <input id="hdnAW" type="text" runat="server" visible="false"  />
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
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px 10px 10px 10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HRENext {padding:5px 5px 5px 5px; float:right; min-width:50px; max-width:90px; }
        .img {display: inline-block; width: auto; height: auto;}
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
    </style>
</asp:Content>
