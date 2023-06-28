<%@ Page Title="SC State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_SC.aspx.vb" 
    Inherits="HReaseApp.EE_W4_SC"
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" runat="Server">
    <div id="tabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>
    </div>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainArticle" Runat="Server">
    <script type="text/javascript">
        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

        $(function () {
            var textBox1 = $('input:text[id$=txtPW_BoxA]').keyup(foo);
            var textBox2 = $('input:text[id$=txtPW_BoxB]').keyup(foo);
            var textBox3 = $('input:text[id$=txtPW_BoxC]').keyup(foo);
            var textBox4 = $('input:text[id$=txtPW_BoxD]').keyup(foo);
            var textBox5 = $('input:text[id$=txtPW_BoxE]').keyup(foo);
            var textBox6 = $('input:text[id$=txtPW_BoxF]').keyup(foo);
            var textBox7 = $('input:text[id$=txtPW_BoxG]').keyup(foo);

   
            $('input:text[id$=hdnPW]').val(document.getElementById('divPWPrint').childNodes[1].innerHTML);


            function foo() {
                var a = textBox1.val();
                var b = textBox2.val();
                var c = textBox3.val();
                var d = textBox4.val();
                var e = textBox5.val();
                var f = textBox6.val();
                var g = textBox7.val();
                var sum = add(a, b, c, d, e, f, g);
                $('input:text[id$=txtPW_BoxH]').val(sum);
                $('input:text[id$=txtW4_Box5]').val(sum);
                
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
        <div id="PageTitle">
            <div>
                <br />
                <h4><b>South Carolina Form SC W-4</b></h4>
                <br /><br />
            </div>
        </div>

        <div id="divTopHeader" class="form-group" style=" margin-top:-40px;">                  
            <div id="divError" runat="server" visible="false" class="HREError">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
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

        <div id="InstructionHeaderBar" class="well HRESlateBlue HRERewrap" style="text-align:center;">
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px; padding-bottom:10px;" />

        </div>

        <div id="Instructions" class="form-group instruction_toggle HREWhite" style="margin-right:5%;">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <p>
                    <b>Employee instructions</b>
                    <br />
                    Complete the SC W-4 so your employer can withhold the correct South Carolina Income Tax from your pay. If you have 
                    too much tax withheld, you will receive a refund when you file your tax return. If you have too little tax withheld, you will 
                    owe tax when you file your tax return, and you might owe a penalty. 
                </p>
                <p>
                    Determine the number of withholding allowances you should claim for withholding for 2022 and any additional amount of 
                    tax to have withheld. For regular wages, withholding must be based on allowances you claimed and may not be a flat 
                    amount or percentage of wages.
                </p>
                <p>
                    Consider completing a new SC W-4 each year and when your personal or financial situation changes. This keeps your 
                    withholding accurate and helps you avoid surprises when you file your South Carolina Individual Income Tax return. 
                </p>
                <p>
                    For the latest information about South Carolina Withholding Tax and the SC W-4, visit <a href="http://dor.sc.gov/withholding" target="_blank">dor.sc.gov/withholding</a>.
                </p>
                <p>
                    <b>Exemptions: </b>You may claim exemption from South Carolina withholding for 2022 for one of the following reasons: 
                </p>
                <ul>
                    <li style="color:black;">
                        For tax year 2020, you had a right to a refund of <b>all</b> South Carolina Income Tax withheld because you had no tax 
                        liability, <b>and</b> for tax year 2022 you expect a refund of <b>all</b> South Carolina Income Tax withheld because you expect 
                        to have <b>no</b> tax liability
                    </li>
                    <li style="color:black;">
                        Under the Servicemembers Civil Relief Act, you are claiming the same state of residence for tax purposes as your 
                        military servicemember spouse. You are only in South Carolina, or a bordering state, to be with your military 
                        spouse who is serving in the state in compliance with military orders. Provide your employer with a copy of your 
                        current military ID card and a copy of your spouse's latest Leave and Earnings Statement (LES). Your military ID 
                        card must have been issued within the last four years. The assignment location on the LES must be in South 
                        Carolina or a bordering state. Enter your spouse's state of domicile on the line provided.
                    </li>
                </ul>
                <p>
                    If you are exempt, complete <b>only</b> line 1 through line 4 and line 7. Check the box for the reason you are claiming an 
                    exemption and write <b>Exempt</b> on line 7. Your exemption for 2022 expires February 15, 2023. If you are a military spouse 
                    and you no longer qualify for the exemption, you have 10 days to update your SC W-4 with your employer.
                </p>
                <p>
                    <b>Filers with multiple jobs or working spouses:</b> You will need to file an SC W-4 for each employer. If you have more 
                    than one job, or if you are married filing jointly and your spouse is also working, you may want to consider only claiming 
                    allowances on the SC W-4 for the highest earning job and/or adding additional withholding on line 6 to ensure you are 
                    having enough withheld.
                </p>
                <p>
                    <b>Nonwage income:</b> If you have a large amount of nonwage income not subject to withholding, such as interest or
                    dividends, consider making Estimated Tax payments using the SC1040ES, Individual Declaration of Estimated Tax, or 
                    adding additional withholding from this job's wages on line 6. Otherwise, you may owe additional tax. Find the SC1040ES 
                    with instructions at <a href="http://dor.sc.gov/forms" target="_blank">dor.sc.gov/forms</a>. 
                </p>
                <p>
                    <b>Employer instructions</b>
                    <br />
                       Complete box 8 through box 10, as necessary. Employees do not complete this section. 
                </p>
                <ul>
                    <li style="color:black;">
                        <b>New hire reporting:</b> You must report newly-hired employees within 20 days after the employee's first day of 
                        work. For more information, see SC Code Section 43-5-598 and 42 USC Section 653a or visit <a href="http://newhire.sc.gov" target="_blank">newhire.sc.gov</a>.  
                    </li>
                    <li style="color:black;">
                        <b>Box 8:</b> Enter your name and address. If you are sending a copy of this form to the State Directory of New Hires, 
                        enter the address where child support agencies should send income withholding orders.
                    </li>
                    <li style="color:black;">
                        <b>Box 9:</b> If you are sending a copy of this form to the State Directory of New Hires, enter the employee’s first date 
                        of employment, which is the date services for payment were first performed by the employee. If you rehired the 
                        employee after they had been separated from your service for at least 60 days, enter the rehire date. 
                    </li>
                    <li style="color:black;">
                        <b>Box 10:</b> Enter your Employer Identification Number (EIN). 
                    </li>
                </ul>
                <p>
                    All employers reporting South Carolina wages or withholdings must submit the W-2s directly to the SCDOR. Submitting 
                    the W-2s to the Social Security Administration does not meet this requirement. The fastest, easiest way to submit W-2s is 
                    using our free, online tax portal, MyDORWAY, at <a href="http://MyDORWAY.dor.sc.gov" target="_blank">MyDORWAY.dor.sc.gov</a>. Sign into your existing account or create an 
                    account to get started. Select <b>W2 Upload</b>, listed under the <b>I Want To</b> column.
                </p>
                <p>
                    Find the Withholding Tax Tables and the Withholding Tax Formula at <a href="http://dor.sc.gov/withholding" target="_blank">dor.sc.gov/withholding</a>.
                </p>
            </div>    
        </div>
    
        <div id="PersonalAllowancesHeaderBar" class="well HRESlateBlue HRERewrap" style="text-align:center; max-height:100px;">
	        <span><b>PERSONAL ALLOWANCES WORKSHEET</b></span>
	        <img src="img/plus.png" class="instruction_toggle_btn1" style="float: right; width: 30px; max-height:100px; padding-bottom:10px;" />
        </div>

        <div id="PersonalAllowancesWorksheet" class="form-group instruction_toggle1 HREWhite" style="margin-right:5%;">
            <div id="WorksheetInstructions" class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="border-bottom: 2px solid black; width: 95%;">
                <p>
                    <b>Worksheet instructions</b>
                    <br />
                    <b>Personal Allowances Worksheet:</b> Complete the worksheet on page 3 to determine the number of withholding 
                    allowances to claim.                    
                </p>
                <ul>
                    <li style="color:black;">
                        <b>Line C: Head of household -</b> Generally, you may claim the head of household filing status on your tax return 
                        only if you are unmarried and pay more than 50% of the costs of keeping up a home for yourself and a qualifying 
                        individual. For more information on filing status, refer to IRS Pub. 501 at <a href="http://irs.gov" target="_blank">irs.gov</a>.
                    </li>
                    <li style="color:black;">
                        <b>Line E: Dependents -</b> The total number of dependents claimed on your South Carolina return must equal the 
                        number of dependents claimed on your federal return. This includes qualifying children and qualifying relatives. 
                        Enter the total number of eligible dependents.
                    </li>
                    <li style="color:black;">
                        <b>Line F: Dependents under the age of 6 -</b> Enter the number of dependents from line E who have <b>not</b> reached 
                        the age of six by December 31, 2022. 
                    </li>
                </ul>
                <p>
                    Enter the total from line G of this worksheet on line 5 of the SC W-4. 
                </p>
                <p>
                    <b>Deductions, Adjustments, and Additional Income Worksheet:</b> Complete this <b>optional</b> worksheet if you plan to itemize 
                    or claim adjustments to income and want to reduce your withholding, or if you have a large amount of nonwage income 
                    not subject to withholding and want to increase your withholding.
                </p>
                <ul>
                    <li style="color:black;">
                        <b>Reduce withholding: </b>Complete this worksheet to determine if you are able to reduce the tax withheld from your 
                        paycheck to account for your itemized deductions and other adjustments to income, such as IRA contributions. If 
                        you reduce your withholding, your refund at the end of the year will be smaller, but your paycheck will be larger. 
                    </li>
                    <li style="color:black;">
                        <b>Increase withholding:</b> You can also use this worksheet to determine how much to increase the tax withheld from 
                        your paycheck if you have a large amount of nonwage income not subject to withholding, such as interest or 
                        dividends. 
                    </li>
                </ul>                
                <p>
                    Enter the total from line 10 of this worksheet on line 5 of the SC W-4. 
                </p>
            </div>
            <div id="Worksheet" class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="width: 95%;">
                <div style="text-align:center; font:x-large; margin-top:20px;">
                    <p>
                        <b>SC W-4 Worksheets</b>
                        <br />
                        KEEP FOR YOUR RECORDS
                    </p>
                </div>     
                <table style="background-color:#fefcf9; color:black; border:2px solid black; border-collapse:separate; border-spacing: 0 10px;">
                    <tr>
                        <td style="width:5%;"></td>
                        <td style="width:5%;"></td>
                        <td style="width:70%;"></td>
                        <td style="width:5%;"></td>
                        <td style="width:4%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:1%;"></td>
                    </tr>
                    <tr >
                        <td colspan="7" style="text-align: center; border-bottom:2px solid black; padding:5px 5px 5px 5px;">
                            <b>Personal Allowances Worksheet</b>
                        </td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>A</b>
                        </td>
                        <td colspan="3" style="vertical-align:top; width: 100%;">
                            Enter “1” for yourself.
                            
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>A</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">  
                            <asp:TextBox ID="PWBoxA" runat="server" CssClass="HRELightBlue center" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>B</b>
                        </td>
                        <td colspan="3" style="vertical-align:top; width: 100%;">
                            Enter 1 if you will file as married filing jointly.
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>B</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">  
                            <asp:TextBox ID="PWBoxB" runat="server" CssClass="HRELightBlue center" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>C</b>
                        </td>
                        <td colspan="3" style="vertical-align:top; width: 100%;">
                            Enter 1 if you will file as head of household.
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>C</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">  
                            <asp:TextBox ID="PWBoxC" runat="server" CssClass="HRELightBlue center" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>D</b>
                        </td>
                        <td colspan="3" style="vertical-align:top; width: 100%;">
                            Enter 1 if:
                            <ul>
                                <li style="color:black;">
                                    You are single, or married filing separately, and have only one job; <b>or</b>
                                </li>
                                <li style="color:black;">
                                    You are married filing jointly, have only one job, and your spouse doesn’t work; <b>or</b> 
                                </li>
                                <li style="color:black;">
                                    Your wages from a second job or your spouse’s wages (or the total of both) are $1,500 or less.
                                </li>
                            </ul>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>D</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">  
                            <asp:TextBox ID="PWBoxD" runat="server" CssClass="HRELightBlue center" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>E</b>
                        </td>
                        <td colspan="3" style="vertical-align:top; width: 100%;">
                            <b>Dependents:</b> Enter the number of dependents you will claim on your 2022 federal return.
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>E</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">  
                            <asp:TextBox ID="PWBoxE" runat="server" CssClass="HRELightBlue center" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>F</b>
                        </td>
                        <td colspan="3" style="vertical-align:top; width: 100%;">
                            <b>Dependents under the age of 6:</b> Enter the number of dependents from line <b>E</b> who are under the age 
                            of 6 as of December 31, 2022.
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>F</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">  
                            <asp:TextBox ID="PWBoxF" runat="server" CssClass="HRELightBlue center" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>G</b>
                        </td>
                        <td colspan="3" style="vertical-align:top; width: 100%;">
                            Add line A through line F.
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>G</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">  
                            <asp:TextBox ID="PWBoxG" runat="server" CssClass="HRELightBlue center" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="4">
                            For accuracy, <b>complete all worksheets that apply.</b>
                            <ul>
                                <li style="color:black;">
                                    <b>If you plan to itemize</b> or <b>claim adjustments to income</b> and want to reduce your withholding, or if 
                                    you have a large amount of nonwage income not subject to withholding and want to increase your 
                                    withholding, see the <b>Deductions, Adjustments, and Additional Income Worksheet</b> below. 
                                </li>
                                <li style="color:black;">
                                    If the above situation does not apply, stop here and enter the number from line G on line 5 of the 
                                    SC W-4 on page 1. 
                                </li>
                            </ul>
                        </td>
                        <td colspan="2"></td>
                    </tr>
                    <tr >
                        <td colspan="7" style="text-align: center; border-top:2px solid black; border-bottom:2px solid black; padding:5px 5px 5px 5px;">
                            <b>Deductions, Adjustments, and Additional Income Worksheet</b>
                        </td>
                    </tr>
                    <tr style="margin-top:10px;">
                        <td colspan="1" style="float:right; vertical-align:top;">
                            <b>Note:</b>
                        </td>
                        <td colspan="5" style="vertical-align:top;">
                            Use this worksheet only if you plan to itemize deductions, claim certain adjustments to income, or have a large 
                            amount of nonwage income not subject to withholding.
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>1</b>
                        </td>
                        <td colspan="2" style="vertical-align:top; width: 100%;">
                            Enter an estimate of your 2022 itemized deductions. These include qualifying home 
                            mortgage interest, charitable contributions, state and local taxes (up to $10,000), and 
                            medical expenses in excess of 10% of your income. For more information, see IRS Pub. 505 
                            at irs.gov.
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>1</b>
                        </td>
                        <td colspan="2" style="text-align:center; vertical-align:top;"> 
                            <span style="float:left; height:25px; vertical-align:bottom;">$</span>
                            <span style="vertical-align:middle; float:right; width:90%;" class="underline">
                                <asp:TextBox ID="TEBox1" runat="server" CssClass="HRELightBlue right" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                            </span>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>2</b>
                        </td>
                        <td colspan="2" style="vertical-align:top; width: 100%;">
                            Enter the 2022 federal standard deduction amount based on your filing status.
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>2</b>
                        </td>
                        <td colspan="2" style="text-align:center; vertical-align:top;"> 
                            <span style="float:left; height:25px; vertical-align:bottom;">$</span>
                            <span style="vertical-align:middle; float:right; width:90%;" class="underline">
                                <asp:TextBox ID="TEBox2" runat="server" CssClass="HRELightBlue right" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                            </span>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>3</b>
                        </td>
                        <td colspan="2" style="vertical-align:top; width: 100%;">
                            Subtract line 2 from line 1. If zero or less, enter 0.
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>3</b>
                        </td>
                        <td colspan="2" style="text-align:center; vertical-align:top;"> 
                            <span style="float:left; height:25px; vertical-align:bottom;">$</span>
                            <span style="vertical-align:middle; float:right; width:90%;" class="underline">
                                <asp:TextBox ID="TEBox3" runat="server" CssClass="HRELightBlue right" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                            </span>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>4</b>
                        </td>
                        <td colspan="2" style="vertical-align:top; width: 100%;">
                            Enter an estimate of your 2022 adjustments to income and any additional standard 
                            deduction for age or blindness. For more information, see IRS Pub. 505 at <b>irs.gov.</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>4</b>
                        </td>
                        <td colspan="2" style="text-align:center; vertical-align:top;"> 
                            <span style="float:left; height:25px; vertical-align:bottom;">$</span>
                            <span style="vertical-align:middle; float:right; width:90%;" class="underline">
                                <asp:TextBox ID="TEBox4" runat="server" CssClass="HRELightBlue right" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                            </span>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>5</b>
                        </td>
                        <td colspan="2" style="vertical-align:top; width: 100%;">
                            Add line 3 and line 4.
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>5</b>
                        </td>
                        <td colspan="2" style="text-align:center; vertical-align:top;"> 
                            <span style="float:left; height:25px; vertical-align:bottom;">$</span>
                            <span style="vertical-align:middle; float:right; width:90%;" class="underline">
                                <asp:TextBox ID="TEBox5" runat="server" CssClass="HRELightBlue right" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                            </span>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>6</b>
                        </td>
                        <td colspan="2" style="vertical-align:top; width: 100%;">
                            Enter an estimate of your 2022 nonwage income not subject to withholding (such as 
                            dividends or interest). 
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>6</b>
                        </td>
                        <td colspan="2" style="text-align:center; vertical-align:top;"> 
                            <span style="float:left; height:25px; vertical-align:bottom;">$</span>
                            <span style="vertical-align:middle; float:right; width:90%;" class="underline">
                                <asp:TextBox ID="TEBox6" runat="server" CssClass="HRELightBlue right" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                            </span>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>7</b>
                        </td>
                        <td colspan="2" style="vertical-align:top; width: 100%;">
                            Subtract line 6 from line 5. If zero, enter 0. Enter a negative amount in <b>brackets</b>.
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>7</b>
                        </td>
                        <td colspan="2" style="text-align:center; vertical-align:top;"> 
                            <span style="float:left; height:25px; vertical-align:bottom;">$</span>
                            <span style="vertical-align:middle; float:right; width:90%;" class="underline">
                                <asp:TextBox ID="TEBox7" runat="server" CssClass="HRELightBlue right" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                            </span>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>8</b>
                        </td>
                        <td colspan="2" style="vertical-align:top; width: 100%;">
                            Divide line 7 by $4,300. Enter a negative amount in <b>brackets</b>. Round decimals <b>down</b>.
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>8</b>
                        </td>
                        <td colspan="2" style="text-align:center; vertical-align:top;"> 
                            <span style="float:left; height:25px; vertical-align:bottom;">$</span>
                            <span style="vertical-align:middle; float:right; width:90%;" class="underline">
                                <asp:TextBox ID="TEBox8" runat="server" CssClass="HRELightBlue right" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                            </span>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>9</b>
                        </td>
                        <td colspan="2" style="vertical-align:top; width: 100%;">
                            Enter the number from the <b>Personal Allowances Worksheet,</b> line G. 
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>9</b>
                        </td>
                        <td colspan="2" style="text-align:center; vertical-align:top;"> 
                            <span style="float:left; height:25px; vertical-align:bottom;">$</span>
                            <span style="vertical-align:middle; float:right; width:90%;" class="underline">
                                <asp:TextBox ID="TEBox9" runat="server" CssClass="HRELightBlue right" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                            </span>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="margin-top:20px;">
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>10</b>
                        </td>
                        <td colspan="2" style="vertical-align:top; width: 100%;">
                            Add line 8 and line 9. If zero or less, enter 0.
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>10</b>
                        </td>
                        <td colspan="2" style="text-align:center; vertical-align:top;"> 
                            <span style="float:left; height:25px; vertical-align:bottom;">$</span>
                            <span style="vertical-align:middle; float:right; width:90%;" class="underline">
                                <asp:TextBox ID="TEBox10" runat="server" CssClass="HRELightBlue right" Width="70px" Height="25px" onkeypress="return onlyNumbers();"   ></asp:TextBox>
                            </span>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="4">
                            Enter the total from line 10 on line 5 of the SC W-4 on page 1.
                        </td>
                        <td colspan="2"></td>
                    </tr>
                </table>
                <p>&nbsp;<br /></p>
                <p>
                    <b>The Family Privacy Protection Act</b>
                    <br />
                    Under the Family Privacy Protection Act, the collection of personal information from citizens by the SCDOR is limited to the information 
                    necessary for the SCDOR to fulfill its statutory duties. In most instances, once this information is collected by the SCDOR, it is protected 
                    by law from public disclosure. In those situations where public disclosure is not prohibited, the Family Privacy Protection Act prevents 
                    such information from being used by third parties for commercial solicitation purposes.
                </p>
                <p>
                    <b>Social Security Privacy Act Disclosure</b>
                    <br />
                    It is mandatory that you provide your Social Security Number on this tax form if you are an individual taxpayer. 42 U.S.C. 405(c)(2)(C)(i) 
                    permits a state to use an individual's Social Security Number as means of identification in administration of any tax. SC Regulation 
                    117-201 mandates that any person required to make a return to the SCDOR must provide identifying numbers, as prescribed, for 
                    securing proper identification. Your Social Security Number is used for identification purposes.
                </p>
            </div>
        </div>

        <div id="MainForm" style="margin-right:5%;">
            <div id="MainFormHeader">
                <table style="width:95%; color:black; border:none;">
                    <tr>
                        <td style="width:15%;"></td>
                        <td style="width:15%;"></td>
                        <td style="width:50%;"></td>
                        <td style="width:20%;"></td>
                    </tr>
                    <tr>
                        <td class="center" colspan="1" style="border-right:1px solid black; border-bottom:1px solid black; vertical-align:bottom;">
                            <h2 style="vertical-align:top;">
                                <b>1350</b>
                            </h2>
                            <br /><br /><br />
                            <h2 style="vertical-align:bottom;">
                                <b>dor.sc.gov</b>
                            </h2>
                        </td>
                        <td class="center" colspan="1" style="border-bottom:1px solid black; vertical-align:middle;">
                            <img src="images/SC_State_Logo.png" style="Width: 80%"/>
                        </td>
                        <td class="center" colspan="1" style="border-right:1px solid black; border-bottom:1px solid black; vertical-align:bottom;">
                            <h3>
                                <b>STATE OF SOUTH CAROLINA</b>
                                <br />
                                <b>DEPARTMENT OF REVENUE</b>
                            </h3>
                            <h2>
                                <b>SOUTH CAROLINA EMPLOYEE&#39;S</b>
                                <br />
                                <b>WITHHOLDING ALLOWANCE CERTIFICATE</b>
                            </h2>
                        </td>
                        <td colspan="1" class="nowrap center" style="border-bottom:1px solid black; vertical-align:bottom;">
                            <h2>
                                <b>SC W-4</b>
                                <br />
                            </h2>
                            <h3>
                               <b>(Rev. 10/25/21)
                                <br />
                                3527</b>
                            </h3>
                            <h1>
                                <b>2022</b>
                            </h1>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="border-bottom:1px solid black;">
                            <h4>
                                <b>Give this form to your employer. Keep the worksheets for your records. The SCDOR may review any allowances and 
                                exemptions claimed. Your employer may be required to send a copy of this form to the SCDOR. </b>
                            </h4>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="border-bottom:1px solid black; vertical-align:middle;">
                            <h4>
                                <b>Part I: Employee Information</b>
                            </h4>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="MainDemographicsandStatus">
                <table style="width: 100%; background-color:white; font-size:large;border:none; border-bottom:1px solid black;">
                    <tr >
                        <td style="width: 3%;"></td>
                        <td style="width:27%;"></td>
                        <td style="width: 5%;"></td>
                        <td style="width: 5%;"></td>
                        <td style="width:30%;"></td>
                        <td style="width: 3%;"></td>
                        <td style="width:27%;"></td>
                    </tr>
                    <tr class="HRETan" style="vertical-align:top; height:40px;">
                        <td colspan="1">
                            <b>1</b>
                        </td>
                        <td colspan="2" style="vertical-align:top;">
                            First name and middle initial<br />
                            <br />
                            <b style="padding-left:5px;">
                                <asp:Label ID="FirstName" runat="server"/>
                                &nbsp;&nbsp;
                                <asp:Label ID="MiddleInitial" runat="server"/>
                            </b>
                        </td>
                        <td colspan="2" style="border-right:1px solid black;">
                            Last name
                            <br />
                            <br />
                            <b style="background-color:#f5f5f0; padding-left:5px;">
                                <asp:Label ID="LastName" runat="server" Width="98%"/>
                            </b>
                        </td>
                        <td colspan="2">
                            <b>1</b>&nbsp;&nbsp; Social security number
                            <br />
                            <br />
                            <b style="background-color:#f5f5f0; padding-left:30px;">
                                <asp:Label ID="SSNumber" runat="server" /></b>
                        </td>
                    </tr>                
                </table>
                <table style="width: 100%; background-color:white; font-size:large; border:none;">
                    <tr >
                        <td style="width: 3%;"></td>
                        <td style="width:30%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width: 7%;"></td>
                        <td style="width:40%;"></td>
                    </tr>
                    <tr >
                        <td colspan="1" class="HRETan" style="border-bottom:1px solid black;">
                            &nbsp;
                        </td>
                        <td colspan="3" class="HRETan" style="border-bottom:1px solid black;border-right:1px solid black;">
                            Address
                            <div>
                                <br />
                                <b style="padding-left:5px;">
                                    <asp:Label ID="AddressCombined" runat="server" Width="98%"/>
                                </b>
                            </div>
                        </td>
                        <td colspan="2" style="border-bottom:1px solid black;">
                            <div style="padding-left: 2px;">
                                3.&nbsp;&nbsp;
                                <asp:CheckBox ID="SingleCheckbox" runat="server" Autopostback="true" OnCheckedChanged="SingleCheckbox_CheckedChanged"/>
                                &nbsp;&nbsp;Single&nbsp;&nbsp;
                                <asp:CheckBox ID="MarriedCheckbox" runat="server" Autopostback="true" OnCheckedChanged="MarriedCheckbox_CheckedChanged"/> 
                                &nbsp;&nbsp;Married
                                <asp:CheckBox ID="MarriedWithholdCheckbox" runat="server" Autopostback="true" OnCheckedChanged="MarriedWithholdCheckbox_CheckedChanged"/>
                                &nbsp;&nbsp;Married, but withhold at higher Single rate
                                <br />
                                If Married filing separately, check <b>Married, but withhold at higher Single rate.</b>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="HRETan" style="border-bottom:1px solid black;">
                            &nbsp;
                        </td>
                        <td colspan="1" class="HRETan" style="border-bottom:1px solid black;">
                            City
                            <div>
                                <br />
                                <b style="padding-left:5px;">
                                    <asp:Label ID="City" runat="server" Width="98%"/></b>
                            </div>
                        </td>
                        <td colspan="1" class="HRETan" style="border-bottom:1px solid black;">
                            State
                            <div>
                                <br />
                                <b style="padding-left:5px;">
                                    <asp:Label ID="State" runat="server" Width="98%"/></b>
                            </div>
                        </td>
                        <td colspan="1" class="HRETan" style="border-bottom:1px solid black;border-right:1px solid black;">
                            Zip
                            <div>
                                <br />
                                <b style="padding-left:5px;">
                                    <asp:Label ID="ZipCode" runat="server" Width="98%"/></b>
                            </div>
                        </td>
                         <td colspan="2" style="border-bottom:1px solid black;">
                            4.&nbsp;&nbsp;Check if <b>your last name is different</b> on your Social Security card. 
                            <asp:CheckBox ID="SSNNameDiffCheckbox" runat="server" Autopostback="true" /> 
                             <br />
                             For a replacement card, contact the Social Security Admin at 1-800-772-1213 .
                        </td>
                    </tr>
            </table>
            </div>
            <div id="MainFormQuestions">
                <table style="width: 100%; background-color:white; font-size:large; border:none;">
                    <tr>
                        <td style="width: 3%;"></td>
                        <td style="width:75%;"></td>
                        <td style="width: 3%;"></td>
                        <td style="width:20%"></td>
                    </tr>
                    <tr style="height:40px; border-bottom:1px solid black;">
                        <td colspan="1">
                            <b>5</b>
                        </td>
                        <td colspan="1">
                            Total number of allowances (from the applicable worksheet on page 3).
                        </td>
                        <td colspan="1" style="text-align:center; border:1px solid black;">
                            <b>5</b>&nbsp;
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:1px solid black;">
                            &nbsp;&nbsp;&nbsp;<asp:TextBox ID="TotalExemptions" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" Class="center" Width="90%" AutoPostBack="true"/>
                        </td>
                    </tr>
                    <tr style="height:40px; border-bottom:1px solid black;">
                        <td colspan="1">
                            <b>6</b>
                        </td>
                        <td colspan="1">
                            Additional amount, if any, you want withheld from your paycheck
                        </td>
                        <td colspan="1" style="text-align:center; border:1px solid black;">
                            <b>6</b>&nbsp;
                        </td>
                        <td colspan="1">
                            &nbsp;$&nbsp;<asp:TextBox ID="AdditionalWithholding" runat="server" BackColor="#EFF3FB" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="height:40px; border-bottom:1px solid black;">
                        <td colspan="1">
                            <b>7</b>
                        </td>
                        <td colspan="1">
                            I claim exemption from withholding for 2022. Check the box for the exemption reason and write Exempt on line 7.
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="border-left:1px solid black;">
                            &nbsp
                        </td>
                    </tr>
                    <tr style="height:40px; border-bottom:1px solid black;">
                        <td colspan="1">
                        </td>
                        <td colspan="1">
                            <asp:CheckBox ID="ExemptCheckbox" runat="server" Autopostback="true" OnCheckedChanged="ExemptCheckbox_CheckedChanged"/>
                            For tax year 2020, I had a right to a refund of all South Carolina Income Tax withheld because I had no tax 
                            liability, and for tax year 2022 I expect a refund of all South Carolina Income Tax withheld because I expect 
                            to have no tax liability.
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="border-left:1px solid black;">
                            &nbsp
                        </td>
                    </tr>
                    <tr style="height:40px; border-bottom:1px solid black;">
                        <td colspan="1">
                        </td>
                        <td colspan="1">
                            <asp:CheckBox ID="MilitarySpouseCheckBox" runat="server" Autopostback="true" OnCheckedChanged="MilitarySpouseCheckBox_CheckedChanged"/>
                            I elect to use the same state of residence for tax purposes as my military servicemember spouse. I have 
                            provided my employer with a copy of my current military ID card and a copy of my spouse's latest Leave and 
                            Earning Statement (LES). State of domicile:
                            <asp:TextBox ID="MilitaryState" runat="server" BackColor="#EFF3FB" Class="center underline" Width="150px"></asp:TextBox>
                        </td>
                        <td colspan="1" style="border:1px solid black;">
                            <b>7</b>&nbsp;
                        </td>
                        <td colspan="1" style="border-left:1px solid black;">
                            &nbsp;&nbsp;&nbsp;<asp:TextBox ID="Exempt" runat="server" BackColor="#EFF3FB" Class="center underline" Width="90%" Autopostback="true" OnTextChanged="Exempt_TextChanged"></asp:TextBox>
                        </td>
                    </tr>
                </table>            
            </div>
            <div id="EmployeeSignature">
                <table style="width: 100%; background-color:white; font-size:large; border:none;">
                    <tr>
                        <td style="width:80%"></td>
                        <td style="width:20%"></td>
                    </tr>
                    <tr>
                        <td colspan="2" style="border-top:1px solid black; border-bottom:1px solid black;">
                            Under penalty of law, I certify that this information is correct, true, and complete to the best of my knowledge. 
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" >
                            <b>Employee’s signature (required)</b>
                            &nbsp&nbsp<asp:TextBox ID="Signature" runat="server" BackColor="#EFF3FB" Class="left underline" Width="75%"></asp:TextBox>
                        </td>
                        <td colspan="1">
                            <b>Date</b>
                            <asp:TextBox ID="SignatureDate" runat="server" BackColor="#EFF3FB" Class="center underline" Width="75%"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="EmployerSection">
                <table style="width: 100%; background-color:white; font-size:large; border:none;">
                    <tr>
                        <td style="width:50%"></td>
                        <td style="width:20%"></td>
                        <td style="width:30%"></td>
                    </tr>
                    <tr>
                        <td colspan="3" style="border-top:1px solid black; border-bottom:1px solid black;">
                            <b>Part II: Employer Information</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="border-top:1px solid black; border-bottom:1px solid black;">
                            Complete box 8 and box 10 if sending to the SCDOR. Complete box 8, box 9, and box 10 if sending to the State Directory of New Hires.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" class="HRETan" style="border-top:1px solid black; border-bottom:1px solid black;border-right:1px solid black;">
                            <b>8</b> Employer’s name and address
                            <br />
                            <b style="padding-left:10px;"><asp:Label ID="EmployerName" runat="server" Style="width: 50%; padding-left:10px;" ></asp:Label></b>
                            <br />
                            <b style="padding-left:10px;"><asp:Label ID="EmployerAddress" runat="server" Style="width: 40%; padding-left:10px;"></asp:Label></b>
                        </td>
                        <td colspan="1" class="HRETan" style="border-top:1px solid black; border-bottom:1px solid black;border-right:1px solid black;">
                            <b>9</b> First date of employment
                            <br /><br />
                            <b style="padding-left:10px;"><asp:Label ID="HireDate" runat="server" Style="width: 50%; padding-left:10px;" ></asp:Label></b>
                        </td>
                        <td colspan="1" class="HRETan" style="border-top:1px solid black; border-bottom:1px solid black;border-right:1px solid black;">
                            <b>10</b> Employer identification number (EIN)
                            <br /><br />
                            <b style="padding-left:10px;"><asp:Label ID="EmployerFEIN" runat="server" Style="width: 50%; padding-left:10px;" ></asp:Label></b>
                        </td>
                    </tr>
                </table>
                <div id="divFormFooter" class="row HRERewrap">
                    <br />
                    <div style="float:right;">
                        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valw4" OnClick="btnSave_Click"/>
                    </div>
                </div> 
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
        input[type=text], textarea {outline: none; min-height: 20px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 20px; height: 20px; cursor: pointer; background: #f0f4fa; display: inline-block; padding-left:3px; padding-right: 3px; color: black;}
        input[type="label"] {background-color: #f5f5f0;}
        table {background-color:white; color:black; border:2px solid black; border-collapse:separate; border-spacing: 0px 5px;}
        p {color:black;}
        li {color:black;}
        div {color:black; }
        
        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; padding-left:5px;}
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .underline {border-bottom: 1px solid !important; width: 100%; display: inline-block; }
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
    </style>
</asp:Content>
