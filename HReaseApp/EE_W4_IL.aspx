<%@ Page Title="IL State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_IL.aspx.vb" 
    Inherits="HReaseApp.EE_W4_IL" 
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

    </script>
    <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>IL Form IL-W-4</b></h4>
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

        <div id="DivInstructions" class="instruction_toggle" style="text-align:center; margin-right:5%; font-size: medium; padding:10px 10px 10px 10px;">
            <table>
                <tr>
                    <td style="width:5%;"> </td>
                    <td style="width:40%;"> </td>
                    <td style="width:55%;"> </td>
                </tr>
                <tr style="border-bottom:3px solid black; color:black;">
                    <td colspan="1">
                        <img src="images/IL_StateImage.png" />
                    </td>
                    <td colspan="1">
                        <b style="font-size:28px;">Illinois Department of Revenue</b>
                        <br />
                        <b style="font-size:38px;">Form IL-W-4</b>

                    </td>
                    <td colspan="1">
                        <br /><br /><br />
                        <b style="font-size:28px; margin-left:-100px;">
                            Employee’s and other Payee’s Illinois Withholding
                        </b>
                        <br />
                        <b style="font-size:28px; margin-left:-100px;">   
                             Allowance Certificate and Instructions
                        </b>
                    </td>
                </tr>
            </table>
            <table style="color: black; padding:5px 5px 5px 5px;">
                <tr>
                    <td style="width:32%;"></td>
                    <td style="width:2%;"></td>
                    <td style="width:32%;"></td>
                    <td style="width:2%;"></td>
                    <td style="width:32%;"></td>
                </tr> 
                <tr>
                    <td colspan="1" style="vertical-align:top; padding-left:10px; padding-top:10px;">
                        <b>Note: </b>These instructions are written for
                        employees to address withholding from
                        wages. However, this form can also be
                        completed and submitted to a payor if an
                        agreement was made to voluntarily withhold
                        Illinois Income tax from other (non-wage)
                        Illinois income
                        <br /><br />
                        <b style="font-size:24px;">Who must complete Form IL-W-4? </b>
                        <br />
                        If you are an employee, you must complete
                        this form so your employer can withhold
                        the correct amount of Illinois Income Tax
                        from your pay. The amount withheld from
                        your pay depends, in part, on the number of
                        allowances you claim on this form.
                        <br />
                        Even if you claimed exemption from
                        withholding on your federal Form W-4,
                        U.S. Employee’s Withholding Allowance
                        Certificate, because you do not expect
                        to owe any federal income tax, you may
                        be required to have Illinois Income Tax
                        withheld from your pay (see Publication
                        130, Who is Required to Withhold Illinois
                        Income Tax). If you are claiming exempt
                        status from Illinois withholding, you must
                        check the exempt status box on Form
                        IL-W-4 and sign and date the certificate. Do
                        not complete Lines 1 through 3. 
                        <br />
                        If you are a resident of a Iowa, Kentucky,
                        Michigan, or Wisconsin, or a military spouse,
                        see Form W-5-NR, Employee’s Statement of
                        Nonresidence in Illinois, to determine if you
                        are exempt. 
                        <br />
                        If you are an Illinois resident who works for
                        an employer in a non-reciprocal state but
                        you work from home or in locations in Illinois
                        for more than 30 working days, you may
                        need to adjust your withholding or begin
                        making estimated payments. For additional
                        information, go to <a href="http://tax.illinois.gov">tax.illinois.gov</a>.
                        <b>Note: </b>If you do not file a completed Form
                        IL-W-4 with your employer, if you fail to
                        sign the form or to include all necessary
                        information, or if you alter the form, your
                        employer must withhold Illinois Income Tax
                        on the entire amount of your compensation,
                        without allowing any exemptions. 
                        <br /><br />
                        <b style="font-size:24px;">When must I submit this form?</b>
                        <br />
                        You should complete this form and give it
                        to your employer on or before the date you
                        start work. You <b>must submit</b> Form IL-W-4
                        when Illinois Income Tax is required to be
                        withheld from compensation that you receive
                        as an employee. You may file a new Form
                        IL-W-4 any time your withholding allowances
                        increase. If the number of your claimed
                        allowances decreases, you must file a new
                        Form IL-W-4 within 10 days. However, the
                        death of a spouse or a dependent does not
                        affect your withholding allowances until the
                        next tax year
                    </td>
                    <td colspan="1"></td>
                    <td colspan="1" style="vertical-align:top; padding-top:10px;">
                        <b style="font-size:24px;">
                            When does my Form IL-W-4 take effect?</b>
                        <br />
                        If you do not already have a Form IL-W-4
                        on file with your employer, this form
                        will be effective for the first payment of
                        compensation made to you after this form
                        is filed. If you already have a Form IL-W-4
                        on file with this employer, your employer
                        may allow any change you file on this form
                        to become effective immediately, but is not
                        required by law to change your withholding
                        until the first payment of compensation is
                        made to you after the first day of the next
                        calendar quarter (that is, January 1, April 1,
                        July 1, or October 1) that falls at least 30
                        days after the date you file the change with
                        your employer.
                        <br />
                        <b>Example: </b>If you have a baby and file a
                        new Form IL-W-4 with your employer to
                        claim an additional allowance for the baby,
                        your employer may immediately change
                        the withholding for all future payments of
                        compensation. However, if you file the new
                        form on September 1, your employer does
                        not have to change your withholding until
                        the first payment of compensation is made
                        to you after October 1. If you file the new
                        form on September 2, your employer does
                        not have to change your withholding until the
                        first payment of compensation made to you
                        after December 31.
                        <br /><br />
                        <b style="font-size:24px;">
                            How long is Form IL-W-4 valid?</b>
                        <br />
                        Your Form IL-W-4 remains valid until a new
                        form you have submitted takes effect or until
                        your employer is required by the Department
                        to disregard it. Your employer is required to
                        disregard your Form IL-W-4 if
                        <ul>
                            <li>you claim total exemption from Illinois
                            Income Tax withholding, but you have
                            not filed a federal Form W-4 claiming
                            total exemption, or</li>
                            <li>the Internal Revenue Service (IRS) has
                            instructed your employer to disregard
                            your federal Form W-4. </li>
                        </ul>
                        <b style="font-size:24px;">
                            What is an “exemption”?</b>
                        <br />
                        An “exemption” is a dollar amount on which
                        you do not have to pay Illinois Income Tax
                        that you may claim on your Illinois Income
                        tax return.
                        <br />
                        <b style="font-size:24px;">
                            What is an “allowance”?</b>
                        <br />
                        The dollar amount that is exempt from
                        Illinois Income Tax is based on the number
                        of allowances you claim on this form. As an
                        employee, you receive one allowance unless
                        you are claimed as a dependent on another
                        person’s tax return (e.g., your parents claim
                        you as a dependent on their tax return). If
                        you are married, you may claim additional
                        allowances for your spouse and any
                        dependents that you are entitled to claim for
                        federal income tax purposes. You also will 
                    </td>
                    <td colspan="1"></td>
                    <td colspan ="1" style="vertical-align:top; padding-top:10px;">
                        receive additional allowances if you or your
                        spouse are age 65 or older, or if you or your
                        spouse are legally blind. 
                        <br />
                        <b>Note: </b>For tax years beginning on or after
                        January 1, 2017, the personal exemption
                        allowance, and additional allowances if you
                        or your spouse are age 65 or older, or if
                        you or your spouse are legally blind, may
                        <b>not</b> be claimed on your Form IL-1040 if
                        your adjusted gross income for the taxable
                        year exceeds $500,000 for returns with a
                        federal filing status of married filing jointly,
                        or $250,000 for all other returns. You may
                        complete a new Form IL-W-4 to update
                        your exemption amounts and increase your
                        Illinois withholding.
                        <br /><br />
                        <b style="font-size:24px;">How do I figure the correct number of allowances?</b>
                        <br />
                        Complete the worksheet on the back of
                        this page to figure the correct number
                        of allowances you are entitled to claim.
                        Give your completed Form IL-W-4 to your
                        employer. Keep the worksheet for your
                        records. 
                        <br />
                        <b>Note: </b>If you have more than one job or your
                        spouse works, your withholding usually will
                        be more accurate if you claim all of your
                        allowances on the Form IL-W-4 for the
                        highest-paying job and claim zero on all of
                        your other IL-W-4 forms.
                        <br /><br />
                        <b style="font-size:24px;">How do I avoid underpaying my tax and owing a penalty?</b>
                        <br />
                        You can avoid underpayment by reducing
                        the number of allowances or requesting that
                        your employer withhold an additional amount
                        from your pay. Even if your withholding
                        covers the tax you owe on your wages, if you
                        have non-wage income that is taxable, such
                        as interest on a bank account or dividends
                        on an investment, you may have additional
                        tax liability. If you owe more than $500
                        tax at the end of the year, you may owe a
                        late-payment penalty or will be required to
                        make estimated tax payments. For additional
                        information on penalties see Publication
                        103, Uniform Penalties and Interest. Visit our
                        website at <a href="http://tax.illinois.gov">tax.illinois.gov</a> to obtain a copy.
                        <br /><br />
                        <b style="font-size:24px;">Where do I get help?</b>
                        <ul>
                            <li>Visit our website at <a href="http://tax.illinois.gov">tax.illinois.gov</a></li>
                            <li>Call our Taxpayer Assistance Division at <b>1 800 732-8866</b> or <b>217 782-3336</b></li>
                            <li>Call our TDD (telecommunications  device for the deaf) at <b>1 800 544-5304</b></li>
                            <li>Write to </li>
                        </ul>
                        <b style="padding-left:40px;">ILLINOIS DEPARTMENT OF REVENUE</b>
                        <br />
                        <b style="padding-left:40px;">PO BOX 19044</b>
                        <br />
                        <b style="padding-left:40px;"> SPRINGFIELD IL 62794-9044</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" style="font-size:small;">
                        IL-W-4 (R-05/20)
                    </td>
                </tr>
            </table>
        </div>               

        <div id="PersonalAllowancesHeaderBar" class="well HRESlateBlue HRERewrap" style="text-align:center; max-height:100px;">
	        <span><b>PERSONAL ALLOWANCES WORKSHEET</b></span>
	        <img src="img/plus.png" class="instruction_toggle_btn1" style="float: right; width: 30px; max-height:100px; padding-bottom:10px;" />
        </div>

        <div id="PersonalAllowancesWorksheet" class="form-group instruction_toggle1" style="margin-right:5%;">
            <div style="border-bottom:3px solid black;">
                <p style="padding-bottom:10px; font-size:36px;">
                        <b>Illinois Withholding Allowance Worksheet</b>
                 </p>
            </div>
            <div id="divGeneralInfo" style="padding-top:5px;">
                <table style="font-size:medium;">
                    <tr>
                        <td style="width:45%;"> </td>
                        <td style="width:5%;"> </td>
                        <td style="width:45%;"> </td>
                    </tr>                
                    <tr>
                        <td colspan="3" style="font-size:28px;">
                            <b>General Information</b>
                        </td>
                    </tr>
                    <tr style="border-bottom:3px solid black;">
                        <td colspan="1">
                            Use this worksheet as a guide to figure your total withholding
                            allowances you may enter on your Form IL-W-4.
                            <br />
                            Complete Step 1.
                            <br />
                            Complete Step 2 if 
                            <ul>
                                <li>you (or your spouse) are age 65 or older or legally blind, or</li>
                                <li>you wrote an amount on Line 4 of the Deductions Worksheet for federal Form W-4.</li>
                            </ul>
                        </td>
                        <td colspan="1"></td>
                        <td colspan="1">
                            If you have more than one job or your spouse works, your withholding
                            usually will be more accurate if you claim all of your allowances on the
                            Form IL-W-4 for the highest-paying job and claim zero on all of your
                            other IL-W-4 forms.
                            <br />
                            You may reduce the number of allowances or request that your
                            employer withhold an additional amount from your pay, which may help
                            avoid having too little tax withheld.
                        </td>
                    </tr>
               
                </table>
            </div>
            <div style="margin-top:20px;">
                <table style="color: black; border-bottom:3px solid black; font-size:medium;">
                    <tr>
                        <td style="width:5%;"></td>
                        <td style="width:2%;"></td>
                        <td style="width:70%;"></td>
                        <td style="width:3%;"></td>
                        <td style="width:15%;"></td>
                        <td style="width:5%;"></td>
                    </tr> 
                    <tr >
                        <td colspan ="6">
                            <b style="font-size:28px;">Step 1: Figure your basic personal allowances </b>
                            <b style="font-size:24px;">(including allowances for dependents)</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan ="6">
                            Check all that apply:
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="5">
                            <asp:CheckBox ID="chkNoOne" runat="server" Class="checkbox" style="border:1px" Text="No one else can claim me as a dependent." TextAlign="Right" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="5">
                            <asp:CheckBox ID="chkClaimSpouse" runat="server" Class="checkbox" style="border:1px" Text="I can claim my spouse as a dependent." TextAlign="Right" />
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>1</b>
                        </td>
                        <td colspan="2" style="vertical-align:top;">
                            Enter the total number of boxes you checked.
                        </td>
                        <td colspan="1" style="text-align:right; vertical-align:bottom;">
                            <b>1</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:bottom; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtOne" runat="server" onkeypress="return onlyNumbers();"/>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>2</b>
                        </td>
                        <td colspan="2" style="vertical-align:top;">
                            Enter the number of dependents (other than you or your spouse) you will claim on your tax return. 
                        </td>
                        <td colspan="1" style="text-align:right; vertical-align:bottom;">
                            <b>2</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:bottom; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtTwo" runat="server" onkeypress="return onlyNumbers();"/>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>3</b>
                        </td>
                        <td colspan="2" style="vertical-align:top;">
                            Add Lines 1 and 2. Enter the result. This is the total number of basic personal allowances to which you are 
                            <b>entitled</b>. You are not required to claim these allowances. The number of basic personal allowances that you
                             choose to claim will determine how much money is withheld from your pay. See Line 4 for more information. 
                        </td>
                        <td colspan="1" style="text-align:right; vertical-align:bottom;">
                            <b>3</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:bottom; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtThree" runat="server" onkeypress="return onlyNumbers();"/>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>4</b>
                        </td>
                        <td colspan="2" style="vertical-align:top;">
                            Enter the total number of basic personal allowances you choose to claim on this line and Line 1 of
                             Form IL-W-4 below. This number may not exceed the amount on Line 3 above, however you can claim as
                             few as zero. Entering lower numbers here will result in more money being withheld(deducted) from your pay.
                        </td>
                        <td colspan="1" style="text-align:right; vertical-align:bottom;">
                            <b>4</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:bottom; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtFour" runat="server" onkeypress="return onlyNumbers();"/>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                </table>
            </div>
            <div style="margin-top:20px;">
                <table style="color: black; border-bottom:1px dashed black; font-size:medium;">
                    <tr>
                        <td style="width:5%;"></td>
                        <td style="width:2%;"></td>
                        <td style="width:34%;"></td>
                        <td style="width:2%;"></td>
                        <td style="width:34%;"></td>
                        <td style="width:3%;"></td>
                        <td style="width:15%;"></td>
                        <td style="width:5%;"></td>
                    </tr> 
                    <tr >
                        <td colspan ="8">
                            <b style="font-size:28px;">
                                Step 2: Figure your additional allowances</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan ="8">
                            Check all that apply:
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="2">
                            <asp:CheckBox ID="chk65" runat="server" Class="checkbox" style="border:1px" Text="I am 65 or older." TextAlign="Right" />
                        </td>
                        <td colspan="5">
                            <asp:CheckBox ID="chkBlind" runat="server" Class="checkbox" style="border:1px" Text="I am legally blind." TextAlign="Right"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="2">
                            <asp:CheckBox ID="chkSP65" runat="server" Class="checkbox" style="border:1px" Text="My spouse is 65 or older." TextAlign="Right"/>
                        </td>
                        <td colspan="5">
                            <asp:CheckBox ID="chkSPBlind" runat="server" Class="checkbox" style="border:1px" Text="My spouse is legally blind." TextAlign="Right"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>5</b>
                        </td>
                        <td colspan="4" style="vertical-align:top;">
                            Enter the total number of boxes you checked. 
                        </td>
                        <td colspan="1" style="text-align:right; vertical-align:bottom;">
                            <b>5</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:bottom; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtFive" runat="server" onkeypress="return onlyNumbers();"/>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>6</b>
                        </td>
                        <td colspan="4" style="vertical-align:top;">
                            Enter any amount that you reported on Line 4 of the Deductions Worksheet
                            for federal Form W-4 plus any additional Illinois subtractions or deductions.
                        </td>
                        <td colspan="1" style="text-align:right; vertical-align:bottom;">
                            <b>6</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:bottom; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtSix" runat="server" onkeypress="return onlyNumbers();"/>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>7</b>
                        </td>
                        <td colspan="4" style="vertical-align:top;">
                            Divide Line 6 by 1,000. Round to the nearest whole number. Enter the result on Line 7.
                        </td>
                        <td colspan="1" style="text-align:right; vertical-align:bottom;">
                            <b>7</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:bottom; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtSeven" runat="server" onkeypress="return onlyNumbers();"/>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>8</b>
                        </td>
                        <td colspan="4" style="vertical-align:top;">
                            Add Lines 5 and 7. Enter the result. This is the total number of additional allowances to which 
                            you are <b>entitled</b>. You are not required to claim these allowances. The number of additional allowances 
                            that you choose to claim will determine how much money is withheld from your pay.
                        </td>
                        <td colspan="1" style="text-align:right; vertical-align:bottom;">
                            <b>8</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:bottom; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtEight" runat="server" onkeypress="return onlyNumbers();"/>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; vertical-align:top;">
                            <b>9</b>
                        </td>
                        <td colspan="4" style="vertical-align:top;">
                           Enter the total number of additional allowances you elect to claim on Line 2 of Form IL-W-4, below. This
                             number may not exceed the amount on Line 8 above, however you can claim as few as zero. Entering lower
                             numbers here will result in more money being withheld(deducted) from your pay.
                        </td>
                        <td colspan="1" style="text-align:right; vertical-align:bottom;">
                            <b>9</b>
                        </td>
                        <td colspan="1" style="text-align:center; vertical-align:bottom; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtNine" runat="server" onkeypress="return onlyNumbers();"/>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan ="7">
                            <b>IMPORTANT: </b> If you want to have additional amounts withheld from your pay, you may enter a dollar amount on Line 3 of Form IL-W-4
                            below. This amount will be deducted from your pay in addition to the amounts that are withheld as a result of the allowances you have
                            claimed.
                             <br /><br />
                        </td>
                        <td colspan="1"></td>
                    </tr>
                   
                </table>
            </div>
        </div>
        
        <div id="divMainForm" class="well HREWhite HRERewrap">
            <div>
                <table>
                    <tr>
                        <td style="width:5%;"> </td>
                        <td style="width:90%;"> </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr style="border-bottom:3px solid black;">
                        <td colspan="1">
                            <img src="images/IL_StateImage.png" />
                        </td>
                        <td colspan="1">
                            <b style="font-size:24px;">Illinois Department of Revenue</b>
                            <br />
                            <b style="font-size:38px;">Form IL-W-4</b>
                            <b style="font-size:24px;">
                                &nbsp;&nbsp;Employee’s Illinois Withholding Allowance Certificate
                            </b>
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <div>
                <table>
                    <tr>
                        <td style="width:2%;"> </td>
                        <td style="width:2%;"> </td>
                        <td style="width:2%;"> </td>
                        <td style="width:1%;"> </td>
                        <td style="width:2%;"> </td>
                        <td style="width:2%;"> </td>
                        <td style="width:1%;"> </td>
                        <td style="width:2%;"> </td>
                        <td style="width:2%;"> </td>
                        <td style="width:2%;"> </td>
                        <td style="width:2%;"> </td>
                        <td style="width:25%;"> </td>
                        <td style="width:2%;"> </td>
                        <td style="width:2%;"> </td>
                        <td style="width:35%;"> </td>
                        <td style="width:2%;"> </td>
                        <td style="width:12%;"> </td>
                        <td style="width:2%;"> </td>
                    </tr>
                    <tr >
                        <td rowspan= "2" class="HRETan" colspan="1" style="text-align:center; vertical-align:bottom;">
                            <b><asp:Label ID="lblSSNDigit1" Class="underline" runat="server" Width="90%"></asp:Label></b>
                        </td>
                        <td rowspan= "2" class="HRETan" colspan="1" style="text-align:center; vertical-align:bottom;">
                            <b><asp:Label ID="lblSSNDigit2" Class="underline" runat="server" Width="90%"></asp:Label></b>
                        </td>
                        <td rowspan= "2" class="HRETan" colspan="1" style="text-align:center; vertical-align:bottom;">
                            <b><asp:Label ID="lblSSNDigit3" Class="underline" runat="server" Width="90%"></asp:Label></b>
                        </td>
                        <td rowspan= "2" class="HRETan" colspan="1" style="text-align:center; vertical-align:bottom;">
                            -
                        </td>
                        <td rowspan= "2" class="HRETan" colspan="1" style="text-align:center; vertical-align:bottom;">
                            <b><asp:Label ID="lblSSNDigit4" Class="underline" runat="server" Width="90%"></asp:Label></b>
                        </td>
                        <td rowspan= "2" class="HRETan" colspan="1" style="text-align:center; vertical-align:bottom;">
                            <b><asp:Label ID="lblSSNDigit5" Class="underline" runat="server" Width="90%"></asp:Label></b>
                        </td>
                        <td rowspan= "2" class="HRETan" colspan="1" style="text-align:center; vertical-align:bottom;">
                            -
                        </td>
                        <td rowspan= "2" class="HRETan" colspan="1" style="text-align:center; vertical-align:bottom;">
                            <b><asp:Label ID="lblSSNDigit6" Class="underline" runat="server" Width="90%"></asp:Label></b>
                        </td>
                        <td rowspan= "2" class="HRETan" colspan="1" style="text-align:center; vertical-align:bottom;">
                            <b><asp:Label ID="lblSSNDigit7" Class="underline" runat="server" Width="90%"></asp:Label></b>
                        </td>
                        <td rowspan= "2" class="HRETan" colspan="1" style="text-align:center; vertical-align:bottom;">
                            <b><asp:Label ID="lblSSNDigit8" Class="underline" runat="server" Width="90%"></asp:Label></b>
                        </td>
                        <td rowspan= "2" class="HRETan" colspan="1" style="text-align:center; vertical-align:bottom;">
                            <b><asp:Label ID="lblSSNDigit9" Class="underline" runat="server" Width="90%"></asp:Label></b>
                        </td>
                        <td rowspan= "2" colspan="1" class="HRETan"></td>
                        <td colspan="1"></td>
                        <td colspan="1" style="text-align:right; vertical-align:top;">
                            <b>1</b>
                        </td>
                        <td rowspan= "2" colspan="1" style="text-align:left; vertical-align:top; font-size:medium;">
                            Enter the total number of basic allowances that you are claiming (Step 1, Line 4, of the worksheet).
                        </td>
                        <td rowspan="2" colspan="1" style="text-align:right; vertical-align:bottom;">
                            <b>1</b>
                        </td>
                        <td rowspan="2" colspan="1" style="text-align:right; vertical-align:bottom;">
                            <asp:TextBox ID="txtTotalAllowance1" runat="server" Class="underline" onkeypress="return onlyNumbers();"/>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td colspan="12" class="HRETan" style="vertical-align:top; font-size:small;">
                            Social Security number
                        </td>
                        <td colspan="6"></td>
                    </tr>
                    <tr>
                        <td colspan="12" class="HRETan">
                            <b><asp:Label ID="lblFullName" runat="server" ></asp:Label></b>
                        </td>
                        <td colspan="1"></td>
                        <td colspan="1" style="text-align:right; vertical-align:top;">
                            <b>2</b>
                        </td>
                        <td rowspan= "2" colspan="1" style="text-align:left; vertical-align:top; font-size:medium;">
                            Enter the total number of additional allowances that you are claiming (Step 2, Line 9, of the worksheet).
                        </td>
                        <td rowspan="2" colspan="1" style="text-align:right; vertical-align:bottom;">
                            <b>2</b>
                        </td>
                        <td rowspan="2" colspan="1" style="text-align:right; vertical-align:bottom;">
                            <asp:TextBox ID="txtTotalAllowance2" runat="server" Class="underline" onkeypress="return onlyNumbers();"/>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="12" class="HRETan" style="border-top:1px solid black;vertical-align:top; font-size:small;">
                            Name
                        </td>
                        <td colspan="6"></td>
                    </tr>
                    <tr>
                        <td colspan="12" class="HRETan">
                            <b><asp:Label ID="lblFullAddress" runat="server" ></asp:Label></b>
                        </td>
                        <td colspan="1"></td>
                        <td colspan="1" style="text-align:right; vertical-align:top;">
                            <b>3</b>
                        </td>
                        <td rowspan= "2" colspan="1" style="text-align:left; vertical-align:top; font-size:medium;">
                            Enter the additional amount you want withheld (deducted) from each pay. 
                        </td>
                        <td rowspan="2" colspan="1" style="text-align:right; vertical-align:bottom;">
                            <b>3</b>
                        </td>
                        <td rowspan="2" colspan="1" style="text-align:right; vertical-align:bottom;">
                            <asp:TextBox ID="txtAdditionalWithholding" runat="server" Class="underline" onkeypress="return onlyNumbers();"/>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="12" class="HRETan" style="border-top:1px solid black;vertical-align:top; font-size:small;">
                            Street address
                        </td>
                        <td colspan="6"></td>
                    </tr>
                    <tr>
                        <td colspan="10" class="HRETan" >
                            <b><asp:Label ID="lblCity" runat="server" ></asp:Label></b>
                        </td>
                        <td colspan="1" class="HRETan">
                            <b><asp:Label ID="lblState" runat="server" ></asp:Label></b>
                        </td>
                        <td colspan="1" class="HRETan" style="padding-left:20px;">
                            <b><asp:Label ID="lblZip" runat="server" ></asp:Label></b>
                        </td>
                        <td colspan="6"></td>
                    </tr>
                    <tr>
                        <td colspan="10" class="HRETan" style="vertical-align:top; border-top:1px solid black; font-size:small;">
                            City
                        </td>
                        <td colspan="1" class="HRETan" style="vertical-align:top; border-top:1px solid black; font-size:small;">
                            State
                        </td>
                        <td colspan="1" class="HRETan" style="vertical-align:top; border-top:1px solid black; font-size:small;padding-left:20px;">
                            ZIP
                        </td>
                        <td colspan="1"></td>
                        <td colspan="4" style="vertical-align:bottom; font-size:medium;"> 
                            I certify that I am entitled to the number of withholding allowances claimed on this certificate.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="12" style="vertical-align:top; font-size:medium;">
                            Check the box if you are exempt from federal and Illinois Income Tax withholding and sign and date the certificate. 
                        </td>
                        <td colspan="1">
                            <asp:CheckBox ID ="chkExempt" runat="server" Class="checkbox" AutoPostBack="true" OnCheckedChanged="chkExempt_CheckedChanged"/>
                        </td>
                        <td colspan="2">
                            <asp:TextBox ID="txtSignature" Class="left" runat="server" placeholder="Enter your name here" Width="98%"></asp:TextBox>
                        </td>
                        <td colspan="2">
                            <asp:TextBox ID="txtSignatureDate" runat="server" Width="100%"></asp:TextBox>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="13"></td>
                        <td colspan="3" style="border-top:1px solid black;">
                            Your Signature
                        </td>
                        <td colspan="1" style="border-top:1px solid black; text-align:center;">
                            Date
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr style="font-size:small;">
                        <td colspan="9">
                            Printed by the authority
                            of the State of Illinois -
                            PO Number: 2200208 - 500 copies
                            IL-W-4 (R-05/20)
                        </td>
                        <td colspan="3" style="border:1px solid black;">
                            This form is authorized under the Illinois Income Tax Act. Disclosure
                            of this information is required. Failure to provide information may
                            result in this form not being processed and may result in a penalty.
                        </td>
                        <td colspan="1"></td>
                        <td colspan="5">
                            <b>Employer: </b>Keep this certificate with your records. If you have referred the employee’s federal
                            certificate to the IRS and the IRS has notified you to disregard it, you may also be required to
                            disregard this certificate. Even if you are not required to refer the employee’s federal certificate to
                            the IRS, you still may be required to refer this certificate to the Illinois Department of Revenue for
                            inspection. See Illinois Income Tax Regulations 86 Ill. Adm. Code 100.7110.
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <br />

        <div class="row HRERewrap">
            <div >
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" Onclick="btnSave_Click"/>
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
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; text-align:center; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

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
    <style>
       
        p{color:black}

        .left {text-align:left;
        }

        .underline {
            border-bottom: 1px solid !important;
            width: 100%;
            display: inline-block;
        }

        table {
            background-color:white;
            padding-top:10px;
        }
    </style>
</asp:Content>
