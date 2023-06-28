<%@ Page Title="IA State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_IA.aspx.vb" 
    Inherits="HReaseApp.EE_W4_IA" 
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
        function exempt(textbox) {
            if (textbox != '') {
                var a = '';
                var b = '0';
                
                $('input:text[id$=txtAllowance1]').val(a);
                $('input:text[id$=txtAllowance2]').val(a);
                $('input:text[id$=txtAllowance3]').val(a);
                $('input:text[id$=txtAllowance4]').val(a);
                $('input:text[id$=txtAllowance5]').val(a);
                $('input:text[id$=txtTotalExemptions]').val(b);
                $('input:text[id$=txtAdditionalWithholding]').val(b);
                
            }
        }
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

        function makeMoney(source) {
            //Grab the value from the element
            var money = parseFloat(source.value, 10).toFixed(2);

            //Format your value
            source.value = money.toString();
        }
        $(function () {
            var textBox1 = $('input:text[id$=txtAllowance1]').keyup(foo);
            var textBox2 = $('input:text[id$=txtAllowance2]').keyup(foo);
            var textBox3 = $('input:text[id$=txtAllowance3]').keyup(foo);
            var textBox4 = $('input:text[id$=txtAllowance4]').keyup(foo);
            var textBox5 = $('input:text[id$=txtAllowance5]').keyup(foo);

            function foo() {
                var a = textBox1.val();
                var b = textBox2.val();
                var c = textBox3.val();
                var d = textBox4.val();
                var e = textBox5.val();

                var sum = add(a, b, c, d, e);
                $('input:text[id$=txtTotalExemptions]').val(sum);
                $('input:text[id$=txtExempt]').val('');
                $('input:text[id$=txtExemptYear]').val('');
                $('input:checkbox[id$=chkMilitarySpouseRelief]').prop("checked", false);
                $('input:text[id$=txtMilitaryDomicileState]').val('');

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
        function disableinput() {
            return false;
        }
        
    </script>

    <div class="HREwrapper">
        <div id="PageTitle" class="HRERewrap">
            <div style="text-align:center;">
                <br />
                <h4><b>Iowa Form IA W-4</b></h4>
                <br /><br />
            </div>
        </div>
        
        <div id="TopHeader" class="form-group" style=" margin-top:-40px;">                  
            <div id="divError" runat="server" class="HREError center" visible="false">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px"/>
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

        <div id="InstructionTitle" class="well HRESlateBlue HRERewrap" style="text-align:center; padding-bottom:20px;">
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px;" />
            <br />
        </div>

        <div id="Instructions" class="instruction_toggle" style="margin-right:5%; font-size: large; padding:10px 10px 10px 10px;">        
            <div class="col-md-12" style="text-align:center; font-size:large;">
                <b>IA W-4 Instructions – Employee Withholding Allowance Certificate</b>
            </div>
            <div style="text-align:left; font-size:large;">
                <div class="col-md-12" >
                    <br />
                    <b>Exemption from withholding</b>
                    <p>
                        Claim exemption from withholding if you are an Iowa resident and both of the following situations apply:
                        (1) for 2020 you had a right to a refund of all Iowa income tax withheld because you had no tax liability, and, (2) for 2021 you expect
                        a refund of all Iowa income tax withheld because you expect to have no tax liability. Nonresidents may not claim this exemption.
                        You must complete a new W-4 within 10 days from the day you anticipate you will incur an Iowa income tax liability for the calendar
                        year (or your fiscal year). If you anticipate you will incur an Iowa income tax liability for the following year, then you must complete
                        a new W-4 on or before December 31 of the current year. If you want to claim an exemption from withholding next year, you must
                        file a new W-4 with your employer on or before February 15.
                    </p>
                    <b>Taxpayers 64 years of age or younger:</b> See your payroll officer to determine how much you expect to earn in a calendar year.
                    You are exempt if:
                </div>
                <div class="form-group col-md-12">
                    <div class="col-md-1 center">
                        a.
                    </div>
                    <div class="col-md-11">
                        your filing status is single, your net income is less than $5,000, and are claimed as a dependent on another person’s Iowa
                        return; or
                    </div>
                </div>
                <div class="form-group col-md-12">
                    <div class="col-md-1 center">
                        b.
                    </div>
                    <div class="col-md-11">
                        your filing status is single, your net income is less than $9,000, and you are not claimed as a dependent on another person’s
                        Iowa return; or
                    </div>
                </div>
                <div class="form-group col-md-12">
                    <div class="col-md-1 center">
                        c.
                    </div>
                    <div class="col-md-11">
                        <p>your filing status is other than single and your combined net income is $13,500 or less.
                        </p>
                    </div>
                </div>
                <div class="col-md-12">
                    <b>Taxpayers 65 years of age or older:</b> Only one spouse must be 65 or older to qualify for the exemption. Pension exclusion and any
                        reportable Social Security amount must be added to net income for purposes of determining the low-income exemption. You are
                        exempt if:
                </div>
                <div class="form-group col-md-12">
                    <div class="col-md-1 center">
                        a.
                    </div>
                    <div class="col-md-11">
                        you are single and your net income is $24,000 or less; or
                    </div>
                </div>
                <div class="form-group col-md-12">
                    <div class="col-md-1 center">
                        b.
                    </div>
                    <div class="col-md-11">
                        your filing status is other than single and your combined net income is $32,000 or less.
                    </div>
                </div>
                <div class="col-md-12" >
                    Military personnel in active duty status, as defined in Title 10 of the U.S. Code, are exempt from withholding. Under the Military
                    Spouses Residency Relief Act of 2009 and the Veterans Benefits and Transition Act of 2018, you may be exempt from Iowa income
                    tax on your wages if: (1) your spouse is a member of the uniformed services present in Iowa in compliance with military orders; (2)
                    you are present in Iowa solely to be with your spouse; and (3) you maintain your domicile or residence in another state; or (4) you
                    have elected to use your servicemember spouse’s domicile or residence in another state for income tax purposes. If you claim this
                    exemption, check the appropriate box, enter the state other than Iowa you are claiming as your state of domicile or residence, and
                    attach a copy of your spousal military identification card to the IA W-4 provided to your employer.
                    <br /><br />
                </div>
                <div class="col-md-12" >
                    <b>Line 1. Personal allowances:</b> You can claim the following personal allowances:
                </div>
                <div class="form-group col-md-12">
                    <div class="col-md-1 center">
                        (a)
                    </div>
                    <div class="col-md-11">
                        1 allowance for yourself or 2 allowances if you are unmarried and eligible to claim head of household status. Add 1 additional
                        allowance if you are 65 or older, and/or 1 additional allowance if you are blind.
                    </div>
                    <div class="col-md-1 center">
                        (b)
                    </div>
                    <div class="col-md-11">
                        If you are married and your spouse either does not work or is not claiming allowances on a separate W-4, you may claim the
                        following allowances for them: 1 for your spouse, 1 additional allowance if your spouse is 65 or older, and/or 1 additional
                        allowance if your spouse is blind.
                    </div>
                    <div class="col-md-1 center">
                        (c)
                    </div>
                    <div class="col-md-11">
                        If you are single and hold more than one job, you may not claim the same allowances with more than one employer at the
                        same time. If you are married and both you and your spouse are employed, you may not both claim the same allowances with
                        both of your employers at the same time.
                    </div>
                    <div class="col-md-1 center">
                        (d)
                    </div>
                    <div class="col-md-11">
                        To have the highest amount of tax withheld claim "0" allowances on line 1.
                    </div>
                </div>            
                <div class="col-md-12" >
                    <br />
                    <b>Line 3. Allowances for itemized deductions:</b>
                </div>
                <div class="form-group col-md-12" >
                    <div class="col-md-1 center">
                        (a)
                    </div>
                    <div class="col-md-8">
                        Enter total amount of estimated itemized deductions.
                    </div>
                    <div style="float:right; padding-right:20px;">
                        (a) $ <asp:TextBox ID="txtAllowanceA" runat="server" Width="80%" />
                    </div>
                </div>
                <div class="form-group col-md-12">
                    <div class="col-md-1 center" >
                        (b)
                    </div>
                    <div class="col-md-8" >
                        Enter amount of your standard deduction using the following information.
                    </div>
                    <div style="float:right; padding-right:20px;" >
                        (b) $ <asp:TextBox ID="txtAllowanceB" runat="server" Width="80%"/>
                    </div>
                </div>
                <div class="form-group col-md-12" style="margin-top:-10px;">
                    <div class="col-md-1">
                
                    </div>

                    <div class="col-md-11">
                        If single, married filing separately on a combined return, or married filing separate returns, enter $2,130. 
                    </div>
                    <div class="col-md-1">
                
                    </div>
                    <div class="col-md-11">
                        If married filing a joint return, unmarried head of household, or qualifying widow(er), enter $5,240.
                    </div>
                </div>
                <div class="form-group col-md-12">
                    <div class="col-md-1 center" >
                        (c)
                    </div>
                    <div class="col-md-8" >
                        Subtract line (b) from line (a) and enter the difference or zero, whichever is greater.
                    </div>
                    <div style="float:right; padding-right:20px;">
                        (c) $ <asp:TextBox ID="txtAllowanceC" runat="server" Width="80%"/>
                    </div>
                </div>
                <div class="form-group col-md-12">
                    <div class="col-md-1 center" >
                        (d)
                    </div>
                    <div class="col-md-11" >
                        Additional allowance: Divide the amount on line (c) by $600, round to the nearest whole number and enter on line 3.
                    </div>
                </div>
                <div class="col-md-12" >
                    <br />
                    <p>
                        <b>Line 5. Allowances for child and dependent care credit:</b> Persons having child/dependent care expenses qualifying for the federal
                        and Iowa child and dependent care credit may claim additional Iowa withholding allowances based on their net incomes. If you have
                        qualifying child and dependent care expenses and wish to reduce your Iowa withholding on the basis of this credit, you may claim
                        additional withholding allowances for Iowa based on the information below. Taxpayers with net income of $45,000 or more cannot
                        claim withholding allowances for the child and dependent care credit. 
                        <br />
                        Married persons, regardless of their expected Iowa filing status, must calculate their withholding allowances based on their combined
                        net incomes. Total allowances for child and dependent care that you and your spouse may claim cannot exceed the total allowances
                        shown below.
                    </p>
                </div>
                <div class="col-md-1" >
                
                </div>
                <div class="col-md-11" >
                    Iowa net income between $0 - $19,999 Allowances: 5
                </div>
                <div class="col-md-1" >
                
                </div>
                <div class="col-md-11" >
                    Iowa net income between $20,000 - $34,999 Allowances: 4
                </div>
                <div class="col-md-1" >
                
                </div>
                <div class="col-md-11" >
                    Iowa net income between $35,000 - $44,999, Allowances: 3
                </div>
                <div class="col-md-12" >
                    <br />
                    <p>
                        <b>Line 7. Additional amount of withholding deducted:</b> You may need to have additional tax withheld if you have two or more jobs
                            are married and you both work, or have income other than wages. Income other than wages would include: interest and dividends,
                            capital gains, rent, alimony received, gambling winnings, etc. If you are not having enough tax withheld, you may request your
                            employer to withhold more by filling in an additional amount on line 7. Estimate the amount you will be under-withheld, and divide
                            that amount by the number of pay periods per year. If you reside in a school district that imposes school district surtax, consider
                            reducing the amount of allowances shown on lines 1-5, or have additional tax withheld on line 7. 
                    </p>
                    <p style="float:right;">
                        44-019b (10/09/2020)
                    </p>
                </div>
            </div>
            <div style="border-bottom:1px solid black; margin-bottom:10px;">
                &nbsp;
            </div>
            <div class="col-md-12" style="text-align:center; font-size:large;">
                <br />
                <b>Centralized Employee Registry Reporting Form</b>
            </div>
            <div style="text-align:left; font-size:large;">
                <div class="col-md-12 center" >
                    <br />
                    <b>Employer Reporting Requirements</b>
                </div>
                <div class="col-md-12" >
                    <p>
                        Federal and state law (42 U.S. Code § 653a and Iowa Code Chapter 252G) requires that an employer
                        doing business in Iowa who hires or rehires an employee or contractor to report the hire within 15 days
                        of the start date. All items on this form must be completed.
                    </p>
                    <p>
                        Use one of the listed methods to report your new hires. Please include your FEIN. Fax this form (page
                        44-019c) to 800-759-5881 or mail it to Centralized Employee Registry, PO Box 10322, Des Moines IA
                        50306-0322. If you have questions about employer reporting requirements, call the Employers
                        Partnering in Child Support (EPICS) Unit at 877-274-2580.
                    </p>
                    <p>
                        Multistate employers have two reporting options: to report newly hired employees in the states in which
                        they are working, or alternatively, to identify one state where all hires will be reported. If you choose to
                        report to one state, your new hire reports must be submitted electronically or by magnetic media, and
                        you must register to identify the state you will report to. To register, visit ocsp.acf.hhs.gov.
                    </p>
                    <p>
                        <b>Employee Information</b>
                    </p>
                    <div class="col-md-1 center">
                        <b>1.</b>
                    </div>
                    <div class="col-md-11">
                        <b>Federal Employer Identification Number (FEIN).</b> Provide the same 9-digit FEIN used on your
                            quarterly wage reports, plus the 3-digit suffix used when filing Iowa withholding tax. For a business
                            with only one location, the default suffix is 000.
                    </div>
                    <div class="col-md-1 center">
                        <b>2.</b>
                    </div>
                    <div class="col-md-11">
                        <b>Employer name.</b> Provide the trade name or doing business as (DBA) name, if applicable, rather
                            than the legal name of the employer.
                    </div>
                    <div class="col-md-1 center">
                        <b>3.</b>
                    </div>
                    <div class="col-md-11">
                        <b>Employer address.</b> . Include any applicable post office box, unit number, etc.
                    </div>
                    <div class="col-md-1 center">
                        <b>4.</b>
                    </div>
                    <div class="col-md-11">
                        <b>Employer contact and phone number (optional).</b> Include any applicable phone and extension.
                    </div>
                    <div class="col-md-1 center">
                        <b>5.</b>
                    </div>
                    <div class="col-md-11">
                        <b>Income Provider name and address for income withholding orders or garnishment, if
                            different from the employer address above.</b> This may be the legal name of the business or
                            other entity that handles withholding and garnishment. This information is needed for income
                            withholding and garnishment purposes.
                    </div>
                    <p>
                        <b>Employer Information</b>
                    </p>
                    <div class="col-md-1 center">
                        <b>6.</b>
                    </div>
                    <div class="col-md-11">
                        <b>Is dependent health care coverage available?</b> This question does not relate to insurability of
                        employee’s dependents. Mark yes if the employer or union offers coverage.
                    </div>
                    <div class="col-md-1 center">
                        <b>7.</b>
                    </div>
                    <div class="col-md-11">
                        <b>Approximate date this employee qualifies for coverage.</b> Example: Is dependent insurance
                        coverage offered upon hire or after six months of employment? This question does not relate to
                        insurability of employee’s dependents. Enter in month, day, and year format.
                    </div>
                    <div class="col-md-1 center">
                        <b>8.</b>
                    </div>
                    <div class="col-md-11">
                        <b>Employee start date.</b> Indicate the first day for which the employee is owed compensation. For a
                        rehire, list the return date. Enter in month, day, and year format. (Required by 42 U.S. Code §
                        653a)
                    </div>
                    <div class="col-md-1 center">
                        <b>9.</b>
                    </div>
                    <div class="col-md-11">
                        <b>Employee date of birth.</b> Enter in month, day, and year format.
                    </div>
                    <div class="col-md-1 center">
                        <b>10.</b>
                    </div>
                    <div class="col-md-11">
                        <b>Employee Social Security Number (SSN).</b> SSN is required for all individuals, including minors.
                    </div>
                    <div class="col-md-1 center">
                        <b>11.</b>
                    </div>
                    <div class="col-md-11">
                        <b>Employee name.</b> Provide the employee’s full name including middle initial.
                    </div>
                    <div class="col-md-1 center">
                        <b>12.</b>
                    </div>
                    <div class="col-md-11">
                        <b>Employee address.</b> Provide the employee’s current home address.
                    </div>
                </div>
            </div>

            <div class="col-md-12" style="border-bottom:2px solid black; margin-bottom:10px;" >
                <br /><br />
                <p style="float:right;">
                    44-019b (10/09/2020)
                </p>
            </div>
        </div>

        <div id="DivMainFormHeader" class="form-group" style="margin-top:20px; margin-right:5%; margin-bottom:5px;">
            <div class="form-group" style="width:250px;float:left; padding-left:10px;">
                <img src="images/IA_State_Logo.png" />
            </div>
            <div class="form-group" style="width:80%;float:right; text-align:right; font-size:large;">
                <b>2021 IA W-4</b>
                <br /> <br />
                Employee Withholding Allowance Certificate
                <hr  style="margin:0px;border: 2px solid black;"/>
                <p>tax.iowa.gov</p>
            </div>
        </div>
        
        <div id="DivMainForm" style="margin-top:20px; margin-right:5%; font-size:large;">
            <div class="col-md-12">
                <p>
                    Each employee must file this Iowa W-4 with his/her employer. Do not claim more allowances than necessary or you will not have enough tax withheld. You may file a new W-4 at any time if the number of your allowances increases. You must file a new W-4 within 10 days if the number of allowances previously claimed by you decreases.
                </p>
                <p>
                    Penalties apply for willfully supplying false information or for willful failure to supply information, which would reduce the withholding allowances. If you file as exempt from withholding and you incur an income tax liability, you may be subject to a penalty for underpayment of estimated tax.
                </p>
                <p>Marital Status: &nbsp &nbsp &nbsp &nbsp  &nbsp  &nbsp &nbsp  
                        Single (or married but legally separated) 
                            &nbsp;&nbsp;<asp:RadioButton ID="rdoSingle" GroupName="MaritalStatus" runat="server" Autopostback ="true" OnCheckedChanged="rdoSingle_CheckedChanged"/> 
                            &nbsp &nbsp &nbsp &nbsp 
                        Married 
                            &nbsp;&nbsp;<asp:RadioButton ID="rdoMarried" GroupName="MaritalStatus" runat="server" Autopostback ="true" OnCheckedChanged="rdoMarried_CheckedChanged"/>
                </p>
            </div>

            <div class="form-group" >
                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 " >
                    Print your full name:&nbsp;&nbsp;
                    <b><asp:Label ID="lblEmployeeFullName" runat="server" CssClass="HRETan underline" Width="75%"/></b> 
                </div>
                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 right" >
                    Social Security Number:&nbsp;&nbsp; 
                        <b><asp:Label id="lblSSNumber1" runat="server" CssClass="HRETan underline center" Width="70%"/></b>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 right" >
                    Home address:&nbsp;&nbsp;
                    <b><asp:Label ID="lblHomeAddress" runat="server" CssClass="HRETan underline left" Width="90%"/></b> 
                </div>
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 " >
                    City:&nbsp;&nbsp;
                    <b><asp:Label ID="lblEmployeeCity" runat="server" CssClass="HRETan underline" Width="92%"/></b> 
                </div>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 " >
                    State:&nbsp;&nbsp;
                    <b><asp:Label ID="lblEmployeeState" runat="server" CssClass="HRETan underline" Width="50%"/></b> 
                </div>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right" >
                    Zip:&nbsp;&nbsp;
                    <b><asp:Label ID="lblEEZip" runat="server" CssClass="HRETan underline left" Width="85%"/></b> 
                </div>
                <div class="col-md-12" style="margin-top:10px;">
                   <p>
                       <b>Exemption from withholding</b>
                    </p> 
                </div>
                <div class="col-md-12">
                    <p>
                        If you do not expect to owe any Iowa income tax and have a right to a full refund of ALL income tax withheld, 
                        <br />enter “EXEMPT” here 
                        <asp:TextBox ID="txtExempt" CssClass="center" runat="server" onblur="exempt(this)" TabIndex="20"/> 
                        and the year effective here 
                        <asp:TextBox ID="txtExemptYear" CssClass="center" runat="server" onblur="exempt(this)" TabIndex="21"/>.
                    </p>
                </div>
                <div class="col-md-12">
                    <p>
                        Nonresidents may not claim this exemption.
                    </p>
                </div>
                <div class="col-md-12">
                    <p>
                        Check this box if you are claiming an exemption from Iowa income tax as a military spouse based on the 
                        Military Spouses Residency Relief Act of 2009 or the Veterans Benefits and Transition Act of 2018
                        &nbsp;&nbsp;<asp:CheckBox ID="chkMilitarySpouseRelief" runat="server" onclick="exempt(this)" TabIndex="22"/>
                    </p>
                </div>
                <div class="col-md-12">
                    <p>
                        If claiming the military spouse exemption, enter your state of domicile or residence here
                        &nbsp;&nbsp;<asp:TextBox ID="txtMilitaryDomicileState" runat="server" onkeypress="exempt(this)" TabIndex="23"/>
                    </p>
                </div>
            </div>
   
            <table style="font-size:large; padding-right:10px; background-color:white; margin-left:10px; margin-right:5%;">
                <tr>
                    <td colspan="6" style="width:100%; font-size:large;">
                        <p><b>If you are not exempt, complete the following:</b></p>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="width:5%; text-align:center; vertical-align:top;">
                        1.
                    </td>
                    <td colspan="2" style="width:60%; vertical-align:top; min-width:250px;">        
                        Personal allowances
                    </td>
                    <td colspan="1" style="width:5%; text-align:right; padding-right:5px; vertical-align:top;">
                        1.
                    </td>
                    <td colspan="1" style="width:15%; vertical-align:top; max-width:100px;">
                        <asp:TextBox ID="txtAllowance1" runat="server" onkeypress="return onlyNumbers();" CssClass="center" Width="100%" TabIndex="1"/>
                    </td>
                    <td colspan="1" style="width:5%;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="width:5%; text-align:center; vertical-align:top;">
                        2.
                    </td>
                    <td colspan="2" style="width:60%; vertical-align:top; min-width:250px;">          
                        Allowances for dependents. You may claim 1 allowance for each dependent you claim on your Iowa income tax return
                    </td>
                    <td colspan="1" style="width:5%; text-align:right; padding-right:5px; vertical-align:top;">
                        2.
                    </td>
                    <td colspan="1" style="width:15%; vertical-align:top; max-width:100px;">
                        <asp:TextBox ID="txtAllowance2" runat="server" onkeypress="return onlyNumbers();" CssClass="center" Width="100%" TabIndex="2"/>
                    </td>
                    <td colspan="1" style="width:5%;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="width:5%; text-align:center; vertical-align:top;">
                        3.
                    </td>
                    <td colspan="2" style="width:60%; vertical-align:top; min-width:250px;">          
                        Allowances for itemized deductions. See instructions
                    </td>
                    <td colspan="1" style="width:5%; text-align:right; padding-right:5px; vertical-align:top;">
                        3.
                    </td>
                    <td colspan="1" style="width:15%; vertical-align:top; max-width:100px;">
                        <asp:TextBox ID="txtAllowance3" runat="server" onkeypress="return onlyNumbers();" CssClass="center" Width="100%" TabIndex="3"/>
                    </td>
                    <td colspan="1" style="width:5%;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="width:5%; text-align:center; vertical-align:top;">
                        4.
                    </td>
                    <td colspan="2" style="width:60%; vertical-align:top; min-width:250px;">          
                        Allowances for adjustments to income. Estimate allowable adjustments to income for payments such as an IRA, Keogh, or SEP; penalty on early withdrawal of savings; alimony paid; and student loan interest, which are reflected on the IA 1040. Divide this amount by $600, round to the nearest whole number, and enter on line 4
                    </td>
                    <td colspan="1" style="width:5%; text-align:right; padding-right:5px; vertical-align:top;">
                        4.
                    </td>
                    <td colspan="1" style="width:15%; vertical-align:top; max-width:100px;">
                        <asp:TextBox ID="txtAllowance4" runat="server" onkeypress="return onlyNumbers();" CssClass="center" Width="100%" TabIndex="4"/>
                    </td>
                    <td colspan="1" style="width:5%;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="width:5%; text-align:center; vertical-align:top;">
                        5.
                    </td>
                    <td colspan="2" style="width:60%; vertical-align:top; min-width:250px;">          
                        Allowances for child and dependent care credit
                    </td>
                    <td colspan="1" style="width:5%; text-align:right; padding-right:5px; vertical-align:top;">
                        5.
                    </td>
                    <td colspan="1" style="width:15%; vertical-align:top; max-width:100px;">
                        <asp:TextBox ID="txtAllowance5" runat="server" onkeypress="return onlyNumbers();" CssClass="center" Width="100%" TabIndex="5"/>
                    </td>
                    <td colspan="1" style="width:5%;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="width:5%; text-align:center; vertical-align:top;">
                        6.
                    </td>
                    <td colspan="2" style="width:60%; vertical-align:top; min-width:250px;">          
                        <b>Total allowances.</b> Add lines 1 through 5
                    </td>
                    <td colspan="1" style="width:5%; text-align:right; padding-right:5px; vertical-align:top;">
                        6.
                    </td>
                    <td colspan="1" style="width:15%; vertical-align:top; max-width:100px;">
                        <asp:TextBox ID="txtTotalExemptions" runat="server" CssClass="center" Backcolor="#E0E0E0" onkeypress="return disableinput()" Width="100%"/>
                    </td>
                    <td colspan="1" style="width:5%;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="width:5%; text-align:center; vertical-align:top;">
                        7.
                    </td>
                    <td colspan="2" style="width:60%; vertical-align:top; min-width:250px;">          
                        Additional amount, if any, you want deducted each pay period
                    </td>
                    <td colspan="1" style="width:5%; text-align:right; padding-right:5px; vertical-align:top;">
                        7.
                    </td>
                    <td colspan="1" style="width:15%; vertical-align:top; max-width:100px;">
                        <asp:TextBox ID="txtAdditionalWithholding" runat="server" CssClass="center" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Width="100%" TabIndex="6"/>
                    </td>
                    <td colspan="1" style="width:5%;">
                        &nbsp;
                    </td>
                </tr>        
            </table>
         
        </div>    

        <div id="DivSignature" style="margin-top:20px; margin-right:5%; font-size:large;">
            <div class="form-group" >
                <div class="col-md-12" >
                    <p>
                    I, the undersigned, declare under penalties of perjury or false certificate, that I have examined this claim, and, to the best of my knowledge and belief, it is true, correct, and complete.
                    </p>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8 " >
                    Employee signature:&nbsp;&nbsp;
                    <asp:TextBox id="txtSignature" runat="server"  style="Width:70%;" TabIndex="7"/>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4 " >
                    Date:&nbsp;&nbsp;
                    <asp:TextBox ID="SignatureDate" runat="server" CssClass="center" Backcolor="#E0E0E0" onkeypress="return disableinput()" style="Width:60%;"/>
                </div>
            </div>
        </div>
        
        <div id="DivEmployerSection" style="margin-top:20px; margin-right:5%; font-size:large;">
            <div class="form-group" >
                <div class="col-md-12" >
                    <p>
                        <b>Employers:</b>
                        The employer must maintain records of the W-4s. If the employee is claiming more than 22 withholding allowances or is claiming exemption from withholding when wages are expected to exceed $200 per week, complete the information below and within 90 days send a copy to: Compliance Services, Iowa Department of Revenue, PO Box 10456, Des Moines, Iowa 50306-0456.
                    </p>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 right" >
                    Employer name:&nbsp;&nbsp;
                    <b><asp:Label ID="lblEmployerName" runat="server" CssClass="HRETan underline left" Width="90%"/></b> 
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 right" >
                    Federal Employer Identification Number (FEIN):&nbsp;&nbsp;
                    <b><asp:Label ID="lblEmployerFEIN" runat="server" CssClass="HRETan underline left" Width="74%"/></b> 
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 right" >
                    Employer address:&nbsp;&nbsp;
                    <b><asp:Label ID="lblEmployerCombinedAddress" runat="server" CssClass="HRETan underline left" Width="89%"/>
                    </b> 
                </div>
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 " >
                    City:&nbsp;&nbsp;
                    <b><asp:Label ID="lblEmployerCity" runat="server" CssClass="HRETan underline" Width="92%"/></b> 
                </div>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" >
                    State:&nbsp;&nbsp;
                    <b><asp:Label ID="lblEmployerState" runat="server" CssClass="HRETan underline center" Width="50%"/></b> 
                </div>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right" >
                    Zip:&nbsp;&nbsp;
                    <b><asp:Label ID="lblEmployerZip" runat="server" CssClass="HRETan underline center" Width="86%"/></b> 
                </div>
                <div class="col-md-12" style="border-bottom:2px solid black; margin-bottom:20px;">
                    <p>
                        <b>Questions about Iowa taxes:</b>
                        Call Taxpayer Services at 515-281-3114 or 800-367-3388 or email idr@iowa.gov.
                    </p>
                    <p style="float:right; ">
                        44-019b (10/09/2020)
                    </p>
                </div>
            </div>
        </div>
   
        <div id="DivSecondFormHeader" class="form-group" style="margin-top:20px; margin-right:5%; margin-bottom:5px;font-size:large;">
            <div class="form-group" style="width:80%;float:right; text-align:right; ">
                Centralized Employee Registry Reporting Form
                <hr  style="margin:0px;border: 2px solid black;"/>
                <p>
                    To be completed by the employer within 15 days of hire.
                </p>
            </div>
            <div class="col-md-12" style="text-align:center">
                <p>
                    <b>New Hire Reporting</b>
                </p>
            </div>
            <div class="col-md-12">
                <p>
                    An employer doing business in Iowa is required to report newly hired employees, rehires, and contractors to the Centralized Employee Registry. Use one of the following methods to report.
                </p>
            </div>
            <div class="col-md-12">
                <p>
                    Online Reporting- Online reporting saves time and money and is the preferred method of reporting. Enter employee information or upload data at iowachildsupport.gov.
                </p>
            </div>
            <div class="col-md-12">
                <p>
                    <b>Fax and Mail Reporting-</b>
                    To report new hires and rehires, submit the following form or an equivalent form. To report contractors by fax or mail, use the Contractor Reporting form found at iowachildsupport.gov.
                </p>
            </div>
            <div class="col-md-12">
                <p>
                    <b>Magnetic Media-</b>
                    Record layout instructions and media types are available at iowachildsupport.gov.
                </p>
            </div>
            <div class="col-md-12">
                <p>
                    <b>Employer Information</b>
                </p>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 " >
                &nbsp;&nbsp;1.&nbsp;&nbsp;Federal Employer Identification Number
            </div>
            <div class="col-xs-10 col-sm-6 col-md-12 col-lg-12 right" >
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(FEIN):&nbsp;&nbsp;
                <b><asp:Label ID="lblEmployerFEIN1" runat="server" CssClass="HRETan underline left" Width="93%"/></b> 
            </div>
            <div class="col-xs-10 col-sm-6 col-md-12 col-lg-12 right" >
                &nbsp;&nbsp;2.&nbsp;&nbsp;Employer name:&nbsp;&nbsp;
                <b><asp:Label ID="lblEmployerName1" runat="server" CssClass="HRETan underline left" Width="88%"/></b> 
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 right" >
                &nbsp;&nbsp;3.&nbsp;&nbsp;Address:&nbsp;&nbsp;
                <b><asp:Label ID="lblEmployerCombinedAddress1" runat="server" CssClass="HRETan underline left" Width="92%"/>
                </b> 
            </div>
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 " >
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;City:&nbsp;&nbsp;
                <b><asp:Label ID="lblEmployerCity1" runat="server" CssClass="HRETan underline" Width="80%"/></b> 
            </div>
            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 " >
                State:&nbsp;&nbsp;
                <b><asp:Label ID="lblEmployerState1" runat="server" CssClass="HRETan underline center" Width="50%"/></b> 
            </div>
            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right" >
                Zip:&nbsp;&nbsp;
                <b><asp:Label ID="lblEmployerZip1" runat="server" CssClass="HRETan underline center" Width="85%"/></b> 
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 " >
                &nbsp;&nbsp;4.&nbsp;&nbsp;Employer contact and phone number:&nbsp;&nbsp;
                <b><asp:Label ID="lblEmployerPhoneNo" runat="server" CssClass="HRETan underline" Width="70%"/></b> 
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 " >
                &nbsp;&nbsp;5.&nbsp;&nbsp;Income provider name and address where income withholding and garnishment orders should be sent, if different from above
            </div>
            <div class="col-xs-10 col-sm-6 col-md-12 col-lg-12 right" >
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name:&nbsp;&nbsp;
                <asp:TextBox ID="txtNameDiff" runat="server" Width="93%" CssClass="left" />
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 right" >
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Address:&nbsp;&nbsp;
                <asp:TextBox ID="txtAddressDiff" runat="server" Width="92%" CssClass="left" />
            </div>
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 " >
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;City:&nbsp;&nbsp;
                <asp:TextBox ID="txtCityDiff" runat="server" style="Width:80%;" />
            </div>
            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 " >
                State:&nbsp;&nbsp;
                <asp:TextBox ID="txtStateDIFF" runat="server" style="Width:80%;" CssClass="center" />
            </div>
            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right" >
                Zip:&nbsp;&nbsp;
                <asp:TextBox ID="txtZipDIFF" runat="server" style="Width:85%;" CssClass="center" />
            </div>
            <div class="col-md-12">
                <br />
                <p>
                    <b>Employee Information</b>
                </p>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 " >
                &nbsp;&nbsp;6.&nbsp;&nbsp;Is dependent health care coverage available?
                &nbsp;<asp:CheckBox ID="chkYes" runat="server" Text="&nbsp; Yes" /> 
                &nbsp;<asp:CheckBox ID="chkNo" runat="server" Text="&nbsp; No" />
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 " >
                &nbsp;&nbsp;7.&nbsp;&nbsp;Approximate date this employee qualifies for coverage (MM/DD/YYYY):&nbsp;&nbsp;
                <b style="float:right;"><asp:Label ID="lblDate1" runat="server" CssClass="HRETan underline center" Width="200px"/></b> 
            </div>
            <div class="col-xs-10 col-sm-6 col-md-12 col-lg-12 " >
                &nbsp;&nbsp;8.&nbsp;&nbsp;Employee start date (MM/DD/YYYY):&nbsp;&nbsp;
                <b style="float:right;"><asp:Label ID="lblDate2" runat="server" CssClass="HRETan underline center" Width="200px"/></b> 
            </div>
            <div class="col-xs-10 col-sm-6 col-md-12 col-lg-12 " >
                &nbsp;&nbsp;9.&nbsp;&nbsp;Employee date of birth (MM/DD/YYYY):&nbsp;&nbsp;
                <b style="float:right;"><asp:Label ID="lblDOB" runat="server" CssClass="HRETan underline center" Width="200px"/></b> 
            </div>
            <div class="col-xs-10 col-sm-6 col-md-12 col-lg-12 " >
                &nbsp;10.&nbsp;&nbsp;Employee Social Security Number:&nbsp;&nbsp;
                <b style="float:right;"><asp:Label ID="lblSSNumber" runat="server" CssClass="HRETan underline center"  Width="200px"/></b> 
            </div>
            <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4 " >
                &nbsp;11.&nbsp;&nbsp;Last name:&nbsp;&nbsp;
                <b><asp:Label ID="lblEmpLastName" runat="server" CssClass="HRETan underline" Width="70%"/></b> 
            </div>
            <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4 " >
                &nbsp;&nbsp;First name:&nbsp;&nbsp;
                <b><asp:Label ID="lblEmpFirstName" runat="server" CssClass="HRETan underline" Width="70%"/></b> 
            </div>
            <div class="col-xs-12 col-sm-12 col-md-2 col-lg-2 right" >
                &nbsp;&nbsp;Middle initial:&nbsp;&nbsp;
                <b><asp:Label ID="lblEmpMiddleName" runat="server" CssClass="HRETan underline left" Width="60%"/></b> 
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 right" >
                &nbsp;12.&nbsp;&nbsp;Address:&nbsp;&nbsp;
                <b><asp:Label ID="lblEmpAddress" runat="server" CssClass="HRETan underline left" Width="90%"/></b> 
            </div>
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 " >
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;City:&nbsp;&nbsp;
                <b><asp:Label ID="lblEmpCity" runat="server" CssClass="HRETan underline" Width="80%"/></b> 
            </div>
            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 " >
                State:&nbsp;&nbsp;
                <b><asp:Label ID="lblEmpState" runat="server" CssClass="HRETan underline center" Width="50%"/></b> 
            </div>
            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right" >
                Zip:&nbsp;&nbsp;
                <b><asp:Label ID="lblEmpZip" runat="server" CssClass="HRETan underline center" Width="85%"/></b> 
            </div>

            <div class="col-md-12">
                <p>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Mailing and contact information</b>
                </p>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 " >
                <p>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fax to: 800-759-5881 or 515-281-3749 (local)
                </p>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 " >
                <p>
                    Mail to:Centralized Employee Registry
                </p>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 " >
                <p>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Phone: 877-274-2580
                </p>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 " >
                <p>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PO Box 10322
                </p>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 " >
                <p>
                    &nbsp;
                </p>
            </div>
            <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 " >
                <p>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Des Moines, IA 50306-0322
                </p>
            </div>
            <div class="col-md-12" style="border-bottom:2px solid black; margin-bottom:20px;">
                   <p style="float:right; ">
                        44-019b (10/09/2020)
                    </p>
                </div>
        </div>
 
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
            <asp:ImageButton ID="btnSave" runat="server" ImageAlign="Right" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" OnClick="btnSave_Click" />
        </div>
    
    </div>

    <script>
        var toggleIsHide = true;

        $(".instruction_toggle").hide();
        $(".chart_toggle").hide();
        $(".table_toggle").hide();
        $(".table2_toggle").hide();
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
        $(".table2_toggle_btn").click(function () {
            if (toggleIsHide == true) {
                $(this).attr("src", "img/minus.png");
            } else {
                $(this).attr("src", "img/plus.png")
            }
            $(".table2_toggle").toggle();
            toggleIsHide = !toggleIsHide;
        });
    </script>
    <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; margin-bottom:5px; padding-right:10px;}
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }
        p {color:black;}
        .underline {border-bottom: 1px solid !important; width: 100%; display: inline-block; padding-left: 5px;}
        
        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; padding-left:5px; margin-bottom:10px;}
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%;}
        .HREpadR10 {padding-right: 20px; float:right; }
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
    </style>
</asp:Content>
