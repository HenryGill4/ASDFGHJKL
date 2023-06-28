<%@ Page Title="OR State Withholding Page"
    Language="vb"
    AutoEventWireup="false"
    MasterPageFile="~/AppMasterHeader.Master"
    CodeBehind="EE_W4_OR.aspx.vb"
    Inherits="HReaseApp.EE_W4_OR"
     MaintainScrollPositionOnPostback="true"%>

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

            if (charCode > 31 && (charCode < 46 || charCode > 57))
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

        $(function () {
            var BoxA1 = $('input:text[id$=txtA1]').keyup(foo);
            var BoxA2 = $('input:text[id$=txtA2]').keyup(foo);
            var BoxA3 = $('input:text[id$=txtA3]').keyup(foo);

            $('input:text[id$=hdnPW]').val(document.getElementById('divResPW').childNodes[1].innerHTML);

            function foo() {
                var a1 = BoxA1.val();
                var a2 = BoxA2.val();
                var a3 = BoxA3.val();

                var sum = add(a1, a2, a3);
                $('input:text[id$=txtA4]').val(sum);

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
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>Oregon Form OR-W-4</b></h4>
                <br /><br />
            </div>
        </div>

        <div id="divTopHeader" class="form-group" style=" margin-top:-40px;">
            <div id="divError" runat="server" visible="false" class="HREError">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
            </div>
            <div class="form-group" style="display:inline;">
                <div id="divSuccess" runat="server" visible="false" class="HRESuccess">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" ImageAlign="Left" />
                    <asp:Label ID="lblSuccess" runat="server" Text="Form Complete" Width="50%"></asp:Label>
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
                </div>
            </div>
        </div>

        <div id="divInstructionTitle" class="well HRESlateBlue HRERewrap" style="text-align:center; padding-bottom:20px;">
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px;" />

        </div>

        <div id="divInstructions" class="instruction_toggle" style="margin-right:5%;">
            <table style="background-color:white; width:100%; font-size: x-large; text-align:center;padding-top:10px; padding-bottom:10px; padding-left:2px; padding-right:2px; border-bottom:1px solid black; ">
                <tr>
                    <td style="width:20%;"></td>
                    <td style="width:60%;"></td>
                    <td style="width:20%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="float:left;">
                        <img src="images/OR_State_Logo.png" />
                    </td>
                    <td colspan="1" style="text-align:center; font-size: x-large; font-weight:bold;">
                        <b>
                            Oregon Withholding Instructions
                            <br />  <br />
                            Form OR-W-4
                        </b>
                    </td>
                    <td colspan="1" style="float:right; font-size: x-large; font-weight:bold; vertical-align:bottom;">
                        2021
                    </td>
                </tr>
            </table>
            <table style="background-color:white; width:100%; font-size:medium; border-bottom:1px solid black; margin-top:10px;">
                <tr>
                    <td style="width:47%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:47%;"></td>
                </tr>
                <tr>
                    <td colspan="1">
                        <p style="background-color:black; color:white; font-size:large; padding:5px;">
                            Important Information
                        </p>
                        <p style="font-weight:bold; color:black;">
                            Complete Form OR-W-4 if:
                        </p>
                        <ul>
                            <li style="color:black;">
                                You filed a federal Form W-4 with your employer after
                                December 31, 2017 and you didn’t file Form OR-W-4 or
                                specify a different number of allowances for Oregon.
                            </li>
                            <li style="color:black;">
                                You weren’t satisfied with your prior year Oregon tax-to-pay or refund amount.
                            </li>
                            <li style="color:black;">
                                You’ve had a recent personal or financial change that may
                                affect your tax situation, such as a change in your income,
                                filing status, or number of dependents.
                            </li>
                        </ul>
                        <p style="color:black;">
                            <b>Specific information to consider:</b>
                        </p>
                        <ul>
                            <li style="color:black;">
                                Do you (including your spouse) <b> have more than one job?</b>
                            </li>
                            <li style="color:black;">
                                Do you expect your wages or adjusted gross income
                                (AGI) on your 2021 return to be <b>
                                    more than $100,000 (or
                                    $200,000
                                </b> if filing using the married filing jointly or qualified widow(er) filing status)?
                            </li>
                            <li style="color:black;">
                                Are you making <b>mid-year changes</b> to your withholding?
                            </li>
                            <li style="color:black;">
                                Do you receive <b>pension or annuity payments?</b>
                            </li>
                            <li style="color:black;">
                                Are you a <b>part-year resident, nonresident, or nonresident alien?</b>
                            </li>
                        </ul>
                        <p style="color:black;">
                            <img src="images/OR_Stop_Image.png" /> If you answered <b>yes</b> to <b>any</b> of these questions, read
                            the “Specific information” section in the instructions
                            before filling out the corresponding worksheets or
                            Form OR-W-4. The online <b>Oregon Withholding Calculator</b>
                            at www.oregon.gov/dor may provide more accurate results.
                            If you use the online calculator, you don’t need to complete
                            the corresponding worksheets.
                        </p>
                        <p style="color:black;">
                            Otherwise, read the instructions and complete all applicable
                            worksheets <b>before</b> filling out the Form OR-W-4 and giving
                            it to your employer.
                        </p>
                        <p style="background-color:black; color:white; font-size:large; padding:5px;">
                            General information
                        </p>
                        <p style="font-weight:bold; color:black;">
                            What is Oregon income tax withholding?
                        </p>
                        <p style="color:black;">
                            Oregon income tax withholding refers to the amount of
                            Oregon personal income taxes that are withheld from your
                            paychecks to cover your anticipated Oregon tax liability for
                            the year. By law, your employer must withhold a portion of
                            your wages based on your allowances and send the funds
                            to the Department of Revenue.
                        </p>
                        <p style="font-weight:bold; color:black;">
                            How is the amount of Oregon income tax
                            withholding determined?
                        </p>
                        <p style="color:black;">
                            You report your marital status, withholding allowances, and
                            any additional amount you want withheld to your employer
                            by completing Form OR-W-4. This information, along with
                            Publication 150-206-436, Oregon Withholding Tax Formulas,
                            which estimates the tax due on your wages, is used by your
                            employer to withhold a specific amount per pay period.
                        </p>
                        <p style="color:black;">
                            If you have too much tax withheld, you may have a refund
                            when you file your tax return. If you have too little tax
                            withheld, you may owe tax when you file your tax return,
                        </p>
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        <p style="color:black;">
                            including penalty and interest. See Publication OR-17 for
                            penalty and interest information.
                        </p>
                        <p style="font-weight:bold; color:black;">
                            Why has Oregon created Form OR-W-4?
                        </p>
                        <p style="color:black;">
                            In prior years, Oregon employees were able to use the federal Form W-4 to determine and claim Oregon withholding.
                            However, due to federal tax law and form changes, <b>
                                the
                                federal form no longer calculates Oregon withholding
                                correctly.
                            </b> Form(s) W-4 that are submitted to your employer
                            after January 1, 2020 can’t be used to calculate Oregon withholding. Instead, use Form OR-W-4 to help you calculate
                            allowances for Oregon income tax withholding.
                        </p>
                        <p style="color:black;">
                            Form OR-W-4 is designed to estimate the amount of tax
                            you’ll need to have withheld for Oregon. Your 2021 tax
                            return may still result in a tax due or refund. For a more
                            accurate calculation, use the Oregon Withholding Calculator at www.oregon.gov/dor to calculate your allowances
                            for Oregon.
                        </p>
                        <p style="font-weight:bold; color:black;">
                            How often do I need to complete Form OR-W-4?
                        </p>
                        <p style="color:black;">
                            Complete a new Form OR-W-4 when you start a new job
                            and whenever you have a change in your personal or financial situation that affects your tax situation. This includes
                            changes in your income, marital status, and number of
                            dependents.
                        </p>
                        <p style="font-weight:bold; color:black;">
                            What will happen if I don’t complete Form OR-W-4?
                        </p>
                        <p style="color:black;">
                            Your employer will refer to the most recently submitted version of Form OR-W-4 or Form W-4 when determining withholding. If you don’t complete Form OR-W-4, your employer
                            will withhold for Oregon based upon the following order:
                        </p>
                        <ul>
                            <li style="color:black;">
                                An Oregon-only version of the federal Form W-4 for a year
                                prior to 2020.
                            </li>
                            <li style="color:black;">
                                Federal Form W-4 for a year prior to 2020.
                            </li>
                            <li style="color:black;">
                                Eight percent of your wages or other income requiring
                                withholding.
                            </li>
                        </ul>
                        <p style="background-color:black; color:white; font-size:large; padding:5px;">
                            Specific information
                        </p>
                        <p style="color:black;">
                            <b>Two-earners or multiple jobs.</b> If you and your spouse work
                            or if you have more than one job, complete the following
                            steps on the Form OR-W-4 for the <b>highest paying job</b> only:
                        </p>
                        <ul>
                            <li style="color:black;">
                                Enter the allowances from Worksheet C, line C5 on Form
                                OR-W-4, line 2.
                            </li>
                            <li style="color:black;">
                                Enter the additional per-period amount to withhold, if any,
                                from <b>Worksheet C</b>, line C8 on Form OR-W-4, line 3.
                            </li>
                        </ul>
                        <p style="color:black;">
                            For all other (lower-paying) jobs, skip the worksheets and
                            claim -0- allowances on Form OR-W-4 line 2, <b>and -0- additional amount to be withheld</b> on line 3.
                        </p>
                        <p style="color:black;">
                            If you (including your spouse) have <b>more than two jobs</b>, use
                            the online calculator for more accurate results.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="float:left;">
                        150-101-402-1 (Rev. 10-08-20)
                    </td>
                    <td colspan="1" style="text-align:center;">
                        1 of 7
                    </td>
                    <td colspan="1">
                    </td>
                </tr>
            </table>
            <table style="background-color:white; width:100%; font-size: x-large; text-align:center;padding-top:10px; padding-bottom:10px; padding-left:2px; padding-right:2px; border-bottom:1px solid black; margin-top:30px;">
                <tr>
                    <td style="width:20%;"></td>
                    <td style="width:60%;"></td>
                    <td style="width:20%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="float:left;">
                        <img src="images/OR_State_Logo.png" />
                    </td>
                    <td colspan="1" style="text-align:center; font-size: x-large; font-weight:bold;">
                        <b>
                            Oregon Withholding Instructions
                            <br />  <br />
                            Form OR-W-4
                        </b>
                    </td>
                    <td colspan="1" style="float:right; font-size: x-large; font-weight:bold; vertical-align:bottom;">
                        2021
                    </td>
                </tr>
            </table>
            <table style="background-color:white; width:100%; font-size:medium; border-bottom:1px solid black; margin-top:10px;">
                <tr>
                    <td style="width:47%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:47%;"></td>
                </tr>
                <tr>
                    <td colspan="1">
                        <p style="color:black;">
                            <b>
                                Wages or adjusted gross income (AGI) that exceed the
                                threshold.
                            </b> Do you expect to have wages or AGI on your 2021
                            return that are <b>more than $100,000</b> (or <b>$200,000</b> if using the
                            married filing jointly or the qualifying widow(er) filing status)? Consider using the online calculator to determine the
                            correct amounts to claim on your Form OR-W-4. Otherwise,
                            skip the worksheets. Check the appropriate box on line 1
                            for your marital status and enter -0- on line 2. You may owe
                            additional tax when you file your return.
                        </p>
                        <p style="color:black;">
                            <b>Helpful tip: AGI.</b> Your AGI is your total income minus federal
                            adjustments to income. This amount on your 2020 federal
                            Form 1040 may help you estimate your 2021 AGI.
                        </p>
                        <p style="color:black;">
                            <b>Mid-year changes.</b> If you’re changing your allowances partway through the year and you claimed too many allowances
                            for the first part of the year, use the online calculator to
                            determine the additional amount you need withheld to make
                            up for the shortage you had during the first part of the year.
                            Otherwise, you may owe tax, penalties, and interest when
                            you file your return. See Publication OR-17 for penalty and
                            interest information.
                        </p>
                        <p style="color:black;">
                            <b>Pension or annuity payments.</b> Form OR-W-4 can be used to
                            designate the amount of withholding on your pension or
                            annuity payments. Generally, whenever Form OR-W-4 or
                            the instructions refer to jobs or wages, substitute these terms
                            with “pension or annuity” or “pension or annuity payment.”
                        </p>
                        <p style="color:black;">
                            >
                            If you’ve opted out of federal withholding, you’re automatically opted out from Oregon withholding also. See Publication OR-ESTIMATE to determine the amount of estimated
                            tax payments you need to make.
                        </p>
                        <p style="color:black;">
                            If you elect to have Oregon withholding and your pension
                            or annuity payment is required to be withheld at a certain
                            percentage, you aren’t able to claim allowances on Form
                            OR-W-4, line 2. However, you’re able to claim additional
                            withholding on Form OR-W-4, line 3 in addition to the percentage. If your withholding isn’t required to be withheld at
                            a certain percentage, you’re able to claim amounts on Form
                            OR-W-4, lines 2 and 3.
                        </p>
                        <p style="color:black;">
                            <b>Exemption from withholding.</b> If you’re exempt from withholding, skip the worksheets. Complete line 4 and sign Form
                            OR-W-4. <b>
                                For wages, the exemption ends on February 15th
                                of the year following the election.
                            </b> For commercial annuities, employer deferred compensation plans, and individual
                            retirement plans the exemption ends once revoked. See
                            additional instructions for line 4 on page 2.
                        </p>
                        <p style="color:black;">
                            <b>Part-year and nonresidents.</b> If you’re a part-year or nonresident of Oregon, complete the applicable worksheets based
                            on amounts that will be included in the Oregon column of
                            your Oregon return.
                        </p>
                        <p style="color:black;">
                            <b>Nonresident alien.</b> If all or a portion of your wages are exempt
                            from federal withholding, these wages are also completely or
                        </p>
                    </td>
                    <td colspan="1" style="color:black;">
                    </td>
                    <td colspan="1" style="color:black;">
                        <p style="color:black;">
                            partially exempt from Oregon withholding. Submit federal
                            Form 8233, <i>
                                Exemption from Withholding on Compensation for
                                Independent Personal Services of a Nonresident Alien Individual,
                            </i>
                            to your employer to exempt all or part of your wages.
                        </p>
                        <p style="color:black;">
                            If any portion of your wages are not exempt, submit Form
                            OR-W-4 to your employer. As a nonresident alien, you don’t
                            qualify to claim certain items on your Oregon return. Follow
                            the instructions below when completing Form OR-W-4:
                        </p>
                        <ul>
                            <li style="color:black;">
                                <b>Line 1.</b> Check the “single” box regardless of your marital status.
                            </li>
                            <li style="color:black;">
                                <b>Line 2.</b> Usually, you should claim -0- withholding allowances. However, if you complete the worksheets, follow
                                the instructions below.
                                <br />
                                — Complete Worksheet B using amounts that will be
                                listed on your Oregon return.
                                <br />
                                — Once you have completed all applicable worksheets,
                                subtract 1 allowance from the amount listed on lines
                                A4, B15, or C5.
                            </li>
                            <li style="color:black;">
                                <b>Line 4.</b> Don’t claim exempt for having no tax liability or
                                for the portion of your wages exempted under federal
                                Form 8233.
                            </li>
                        </ul>
                        <p style="background-color:black; color:white; font-size:large; padding:5px;">
                            Form OR-W-4 line instructions
                        </p>
                        <p style="color:black;">
                            Type or clearly print your name, Social Security number
                            (SSN), and mailing address.
                        </p>
                        <p style="color:black;">
                            <b>Note.</b> You must enter a SSN. You can’t use an individual
                            taxpayer identification number (ITIN).
                        </p>
                        <p style="color:black;">
                            <b>Redetermination check box.</b> If the department issued a
                            determination letter to your employer specifying the amount
                            your employer needs to withhold from your wages and you
                            want to lower your withholding, you must have a personal
                            or financial change affecting your tax situation. If you do,
                            mark the “Redetermination” check box. Provide a copy to
                            your employer and send a copy with all of the applicable
                            worksheets filled out to the department at:
                        </p>
                        <p style="color:black;">
                            ADP OR-W-4 Project<br />
                            Oregon Department of Revenue<br />
                            PO Box 14560<br />
                            Salem, OR 97309
                        </p>
                        <p style="color:black;">
                            <b>Line 1.</b> If you anticipate using the single, married filing
                            separately, or head of household filing status when you file
                            your 2021 return, mark “Single.”
                        </p>
                        <p style="color:black;">
                            If you anticipate using the married filing jointly, or qualifying
                            widow(er) filing status when you file your 2021 return, mark
                            “Married.” If you meet the married filing jointly qualifications, but want to withhold at the higher “single” rate, mark
                            “Married, but withholding at the higher single rate.”
                        </p>
                        <p style="color:black;">
                            For the qualifications of each filing status, see federal Publication <i>501, Exemptions, Standard Deduction, and Filing Information.</i>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="float:left;">
                        150-101-402-1 (Rev. 10-08-20)
                    </td>
                    <td colspan="1" style="text-align:center;">
                        2 of 7
                    </td>
                    <td colspan="1">
                    </td>
                </tr>
            </table>
            <table style="background-color:white; width:100%; font-size: x-large; text-align:center;padding-top:10px; padding-bottom:10px; padding-left:2px; padding-right:2px; border-bottom:1px solid black; margin-top:30px;">
                <tr>
                    <td style="width:20%;"></td>
                    <td style="width:60%;"></td>
                    <td style="width:20%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="float:left;">
                        <img src="images/OR_State_Logo.png" />
                    </td>
                    <td colspan="1" style="text-align:center; font-size: x-large; font-weight:bold;">
                        <b>
                            Oregon Withholding Instructions
                            <br />  <br />
                            Form OR-W-4
                        </b>
                    </td>
                    <td colspan="1" style="float:right; font-size: x-large; font-weight:bold; vertical-align:bottom;">
                        2021
                    </td>
                </tr>
            </table>
            <table style="background-color:white; width:100%; font-size:medium; border-bottom:1px solid black; margin-top:10px;">
                <tr>
                    <td style="width:47%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:47%;"></td>
                </tr>
                <tr>
                    <td colspan="1">
                        <p style="color:black;">
                            <b>Line 2.</b> Complete all applicable worksheets. Use the allowances from Worksheet A, line A4, Worksheet B, line B15, or
                            Worksheet C, line C5.
                        </p>
                        <p style="color:black;">
                            <b>Line 3.</b> If you choose to have an additional amount withheld
                            from your pay, enter the amount that you want withheld
                            from each paycheck. If you completed Worksheet C, line C8
                            may direct you to claim an additional amount per paycheck.
                        </p>
                        <p style="color:black;">
                            <b>Line 4.</b> If you’re claiming <b>exemption from withholding</b>, you
                            must meet one of the below requirements:
                        </p>
                        <ul>
                            <li style="color:black;">
                                Your wages must be exempt from Oregon taxation, or
                            </li>
                            <li style="color:black;">
                                You must meet the qualification for having no tax liability.
                            </li>
                        </ul>
                        <p style="color:black;">
                            To claim exemption due to <b>no tax liability</b>, you must meet
                            <b>both</b> of the following conditions:
                        </p>
                        <ul>
                            <li style="color:black;">
                                Last year you had the right to a refund of all Oregon tax
                                withheld because you had <b>no</b> tax liability, and
                            </li>
                            <li style="color:black;">
                                This year you expect a refund of <b>all</b> Oregon income tax
                                withheld because you expect to have <b>no</b> tax liability.
                            </li>
                        </ul>
                        <p style="color:black;">
                            To claim exempt, enter the corresponding code from the following <b>Exemption chart</b> on line 4a. Only enter one exemption code. Also write “Exempt” on line 4b.
                        </p>
                        <p style="color:black;">
                            <b>
                                Note: For wages, exemptions end February 15th of the year
                                following the election. A new OR-W-4 must be completed
                                each year.
                            </b>
                        </p>
                        <p style="color:black; text-align:center">
                            <b>Exemption chart</b>
                        </p>
                        <p style="color:black; text-align:center">
                            <b>Exemption</b>
                            <span style="float:right;">Code</span>
                        </p>
                        <table style="background-color:white; border:1px solid black;">
                            <tr>
                                <td style="width:95%"></td>
                                <td style="width:5%"></td>
                            </tr>
                            <tr style="border:1px solid black;">
                                <td colspan="1" style="border:1px solid black;">
                                    <b>Air carrier employee</b>
                                </td>
                                <td colspan="1" style="text-align:center; font-weight:bold;">
                                    A
                                </td>
                            </tr>
                            <tr style="border:1px solid black;">
                                <td colspan="1" style="border:1px solid black;">
                                    <b>American Indian</b> enrolled tribal member living and
                                    working in Indian country in Oregon.
                                </td>
                                <td colspan="1" style="text-align:center; font-weight:bold;">
                                    B
                                </td>
                            </tr>
                            <tr style="border:1px solid black;">
                                <td colspan="1" style="border:1px solid black;">
                                    <b>Amtrak Act worker</b>
                                </td>
                                <td colspan="1" style="text-align:center; font-weight:bold;">
                                    C
                                </td>
                            </tr>
                            <tr style="border:1px solid black;">
                                <td colspan="1" style="border:1px solid black;">
                                    <b>Casual laborer</b>
                                </td>
                                <td colspan="1" style="text-align:center; font-weight:bold;">
                                    D
                                </td>
                            </tr>
                            <tr style="border:1px solid black;">
                                <td colspan="1" style="border:1px solid black;">
                                    <b>Domestic service worker</b>
                                </td>
                                <td colspan="1" style="text-align:center; font-weight:bold;">
                                    E
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1" style="border:1px solid black;">
                                    <b>Hydroelectric dam worker</b> at the Bonneville, John Day,
                                    McNary, or The Dalles dams.
                                </td>
                                <td colspan="1" style="text-align:center; font-weight:bold;">
                                    F
                                </td>
                            </tr>
                            <tr style="border:1px solid black;">
                                <td colspan="1" style="border:1px solid black;">
                                    <b>Military</b> pay for nonresidents stationed in Oregon and
                                    their spouses, residents stationed outside Oregon,
                                    and service members whose Defense Finance and
                                    Accounting Services (DFAS) address is outside Oregon.
                                </td>
                                <td colspan="1" style="text-align:center; font-weight:bold;">
                                    G
                                </td>
                            </tr>
                            <tr style="border:1px solid black;">
                                <td colspan="1" style="border:1px solid black;">
                                    <b>Minister</b> who is duly ordained, commissioned, or licensed
                                    and performing duties in their ministry or a member of a
                                    religious order performing duties required by their order.
                                </td>
                                <td colspan="1" style="text-align:center; font-weight:bold;">
                                    H
                                </td>
                            </tr>
                            <tr style="border:1px solid black;">
                                <td colspan="1" style="border:1px solid black;">
                                    <b>Real estate salesperson</b> under a written contract not
                                    to be treated as an employee.
                                </td>
                                <td colspan="1" style="text-align:center; font-weight:bold;">
                                    J
                                </td>
                            </tr>
                            <tr style="border:1px solid black;">
                                <td colspan="1" style="border:1px solid black;">
                                    <b>Waterway worker</b>
                                </td>
                                <td colspan="1" style="text-align:center; font-weight:bold;">
                                    K
                                </td>
                            </tr>
                            <tr style="border:1px solid black;">
                                <td colspan="1" style="border:1px solid black;">
                                    <b>No tax liability</b>. See above for definition.
                                </td>
                                <td colspan="1" style="text-align:center; font-weight:bold;">
                                    L
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1" style="border:1px solid black;">
                                    <b>Nonresident</b> who expects a refund of all Oregon income
                                    tax withheld because their wages won’t be subject to
                                    Oregon tax.
                                </td>
                                <td colspan="1" style="text-align:center; font-weight:bold;">
                                    M
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td colspan="1" style="color:black;">
                    </td>
                    <td colspan="1" style="color:black;">
                        <p style="color:black;">
                            <b>Sign and date Form OR-W-4.</b> Submit Form OR-W-4 (page
                            1) to your employer. <b>Don’t</b> complete the employer’s name,
                            FEIN, and address boxes. Your employer will complete these.
                            Keep the worksheets (pages 2–4) with your tax records.
                        </p>
                        <p style="color:black;">
                            <b>Note:</b> You may be assessed a penalty of $500 if you file an
                            erroneous withholding statement where there was no reasonable basis for the instruction to the employer.
                        </p>
                        <p style="background-color:black; color:white; font-size:large; padding:5px;">
                            Worksheet instructions
                        </p>
                        <p style="color:black; font-size:large; ">
                            <b>Worksheet A—Personal allowances</b>
                        </p>
                        <p style="color:black;">
                            <b>Line A3. Dependents.</b> List the total of all qualifying children
                            and qualifying relatives you are able to claim as a dependent
                            on your Oregon return. See the “Exemption credit” section
                            of Publication OR-17 for qualifications.
                        </p>
                        <p style="color:black; font-size:large; ">
                            <b>
                                Worksheet B—Deductions, adjustments, credits,
                                and nonwage income
                            </b>
                        </p>
                        <p style="color:black;">
                            <b>Line B1.</b> If you have large amounts of <b>nonwage income</b>,
                            such as interest, dividends, or self-employment income,
                            consider making estimated tax payments using Publication
                            OR-ESTIMATE. Otherwise, you may owe additional tax.
                        </p>
                        <p style="color:black;">
                            <b>Line B2. Additions</b> are items the federal government doesn’t
                            tax but Oregon does. See Publication OR-17 for a list of additions and instructions.
                        </p>
                        <p style="color:black;">
                            <b>Line B4.</b> Enter your anticipated 2021 Oregon <b>deductions.</b> If
                            you don’t know your anticipated 2021 deductions, enter the
                            standard deduction for your anticipated filing status.
                        </p>
                        <p style="color:black;">
                            The 2021 <b>standard deduction</b> for each filing status is:
                        </p>
                        <ul>
                            <li style="color:black;">
                                $2,350 for single or married filing separately.
                            </li>
                            <li style="color:black;">
                                $3,780 for head of household.
                            </li>
                            <li style="color:black;">
                                $4,700 for married filing jointly or qualifying widow(er).
                            </li>
                        </ul>
                        <p style="color:black;">
                            If you qualify for an <b>additional standard deduction amount</b>
                            because you or your spouse are age 65 or older or blind, and
                            you don’t plan to itemize your deductions, enter your total
                            estimated standard deduction amount for 2021.
                        </p>
                        <p style="color:black;">
                            <b>Itemized deductions</b> include items such as medical expenses
                            in excess of 10% of your adjusted gross income, state and local
                            taxes (limited to $10,000, and excluding Oregon income taxes),
                            qualifying home mortgage interest, charitable contributions,
                            and certain miscellaneous deductions. If you plan to itemize your deductions,
                            enter your estimated <b>
                                Oregon itemized
                                deductions.
                            </b> See Schedule OR-A for additional information.
                        </p>
                        <p style="color:black;">
                            <b>Line B7. Adjustments to income</b> are claimed on your federal
                            return and reduce your federal taxable income. See federal
                            Form 1040 instructions for details on claiming adjustments
                            to income on your federal return and see Publication OR-17
                            for details on claiming these items on your Oregon return.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="float:left;">
                        150-101-402-1 (Rev. 10-08-20)
                    </td>
                    <td colspan="1" style="text-align:center;">
                        3 of 7
                    </td>
                    <td colspan="1">
                    </td>
                </tr>
            </table>
            <table style="background-color:white; width:100%; font-size: x-large; text-align:center;padding-top:10px; padding-bottom:10px; padding-left:2px; padding-right:2px; border-bottom:1px solid black; margin-top:30px;">
                <tr>
                    <td style="width:20%;"></td>
                    <td style="width:60%;"></td>
                    <td style="width:20%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="float:left;">
                        <img src="images/OR_State_Logo.png" />
                    </td>
                    <td colspan="1" style="text-align:center; font-size: x-large; font-weight:bold;">
                        <b>
                            Oregon Withholding Instructions
                            <br />  <br />
                            Form OR-W-4
                        </b>
                    </td>
                    <td colspan="1" style="float:right; font-size: x-large; font-weight:bold; vertical-align:bottom;">
                        2021
                    </td>
                </tr>
            </table>
            <table style="background-color:white; width:100%; font-size:medium; border-bottom:1px solid black; margin-top:10px;">
                <tr>
                    <td style="width:47%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:47%;"></td>
                </tr>
                <tr>
                    <td colspan="1">
                        <p style="color:black;">
                            <b>Subtractions</b> are items the federal government taxes but Oregon doesn’t. See Publication OR-17 for a list of subtractions
                            and instructions. Don’t include your federal tax subtraction.
                        </p>
                        <p style="color:black;">
                            <b>Line B10.</b> Divide line B9 by $2,800. Round to one decimal
                            place. For example, round 4.84 to 4.8 and 4.85 to 4.9. This
                            calculation converts the amount from line B9 into allowances.
                        </p>
                        <p style="color:black;">
                            <b>Line B11. Credits</b> reduce the amount of tax you must pay.
                            Standard and carryfoward credits can reduce your tax down
                            to zero but can’t be refunded to you. However, refundable
                            credits can reduce your tax down to zero and also result in
                            a refund of any remaining amount. See Publication OR-17
                            for a list of credits and instructions.
                        </p>
                        <p style="color:black;">
                            Enter an estimate of the credits you will claim on your 2021
                            Oregon return. <b>Don’t</b> include your exemption credits.
                        </p>
                        <p style="color:black;">
                            <b>Line B12.</b> Divide line B11 by $213. Round using one decimal
                            place. For example, round 4.84 to 4.8 and 4.85 to 4.9. This
                            calculation converts the amount from B11 into allowances.
                        </p>
                        <p style="color:black;">
                            <b>Line B13.</b> Add lines B10 and B12. Round to the nearest whole
                            number closest to zero by eliminating the decimal value. For
                            example, round 4.3 or 4.8 to 4 and round -3.3 or -3.7 to -3.
                        </p>
                        <p style="color:black;">
                            <b>Example 1.</b> Roger entered -3.1 on line B10. He entered 2.4 on
                            line B12. He will enter -0- on line B13 (-3.1 + 2.4 = -0.7, which
                            is rounded to -0-).
                        </p>
                        <p style="color:black;">
                            <b>Line B15.</b> If the result on line B15 is less than zero, consider
                            making quarterly estimated tax payments to avoid a tax
                            liability and penalties and interest when you file your return.
                            See Publication OR-ESTIMATE for information on how to
                            make quarterly estimated payments.
                        </p>
                        <p style="color:black; font-size:large; ">
                            <b>Worksheet C—Two earners / multiple jobs</b>
                        </p>
                        <p style="color:black;">
                            <b>Line C5.</b> For your highest paying job, enter the result of
                            <b>Worksheet C</b>, line C5 on Form OR-W-4, line 2. For all of your
                            lower paying jobs, claim zero allowances.
                        </p>
                        <p style="color:black;">
                            <b>Line C8.</b> For your highest paying job, enter the result of
                            <b> Worksheet C</b>, line C8 on Form OR-W-4, line 3. Round to the
                        </p>
                    </td>
                    <td colspan="1" style="color:black;">
                    </td>
                    <td colspan="1" style="color:black;">
                        <p style="color:black;">
                            nearest whole dollar. For all of your lower paying jobs, claim
                            zero as the additional amount to have withheld.
                        </p>
                        <p style="color:black;">
                            <b>Example 2.</b> Todd is completing this form in January and has
                            entered $824 on line C7. For his highest paying job, he is paid
                            every two weeks and has 25 paychecks left for the year. Todd
                            will enter $33 on line C8 and Form OR-W-4, line 3 ($824 ÷ 25
                            = $32.96, which is rounded up to the nearest whole dollar).
                        </p>
                        <p style="background-color:black; color:white; font-size:large; padding:5px;">
                            Employer instructions
                        </p>
                        <p style="color:black;">
                            Enter the business name, federal employer identification number (FEIN), and address. Keep this form with your records.
                        </p>
                        <p style="color:black;">
                            For additional information and instructions regarding Form
                            OR-W-4, see Publication 150-211-602, <i>
                                W-4 Information for
                                Employers.
                            </i>
                        </p>
                        <p style="background-color:black; color:white; font-size:large; padding:5px;">
                            Additional resources
                        </p>
                        <p style="color:black;">
                            For additional information, refer to the following publications:
                        </p>
                        <ul>
                            <li style="color:black;">
                                Publication 150-206-436, <i>Oregon Withholding Tax Formulas.</i>
                            </li>
                            <li style="color:black;">
                                Publication OR-17, <i>Oregon Individual Income Tax Guide.</i>
                            </li>
                            <li style="color:black;">
                                Publication OR-ESTIMATE, <i>Instructions for Estimated Income Tax.</i>
                            </li>
                            <li style="color:black;">
                                Publication 150-211-602, <i>W-4 Information for Employers.</i>
                            </li>
                            <li style="color:black;">
                                Federal Pub. 501, <i>Exemptions, Standard Deduction, and Filing Information.</i>
                            </li>
                            <li style="color:black;">
                                Federal Form 2833, <i>
                                    Exemption From Withholding on Compensation for Independent (and Certain Dependent) Personal Services
                                    of a Nonresident Alien Individual.
                                </i>
                            </li>
                            <li style="color:black;">
                                Federal Form 1040 Instructions.
                            </li>
                        </ul>
                        <p style="background-color:black; color:white; font-size:large; padding:5px;">
                            Do you have questions or need help?
                        </p>
                        <p style="color:black;">
                            www.oregon.gov/dor<br />
                            503-378-4988 or 800-356-4222<br />
                            questions.dor@oregon.gov
                        </p>
                        <p style="color:black;">
                            Contact us for ADA accommodations or assistance in other
                            languages.
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="float:left;">
                        150-101-402-1 (Rev. 10-08-20)
                    </td>
                    <td colspan="1" style="text-align:center;">
                        4 of 7
                    </td>
                    <td colspan="1">
                    </td>
                </tr>
            </table>

            <table style="background-color:white; width:100%; font-size: x-large; text-align:center;padding-top:10px; padding-bottom:10px; padding-left:2px; padding-right:2px; border-bottom:1px solid black; margin-top:30px;">
                <tr>
                    <td style="width:20%;"></td>
                    <td style="width:60%;"></td>
                    <td style="width:20%;"></td>
                </tr>
                <tr style="margin-bottom:10px;">
                    <td colspan="1" style="float:left;">
                        <img src="images/OR_State_Logo.png" />
                    </td>
                    <td colspan="1" style="text-align:center; font-size: x-large; font-weight:bold;">
                        <b>
                            Oregon Withholding Instructions
                            <br />  <br />
                            Form OR-W-4
                        </b>
                    </td>
                    <td colspan="1" style="float:right; font-size: x-large; font-weight:bold; vertical-align:bottom;">
                        2021
                    </td>
                </tr>
            </table>
            <table style="background-color:white; width:100%; font-size:medium; margin-top:10px; margin-bottom:20px;">
                <tr>
                    <td style="width:2%;"></td>
                    <td style="width:2%;"></td>
                    <td style="width:2%;"></td>
                    <td style="width:2%;"></td>
                    <td style="width:75%;"></td>
                    <td style="width:2%;"></td>
                    <td style="width:1%;"></td>
                    <td style="width:14%;"></td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="font-size:16pt; font-weight:bold; text-align:center; ">
                        Worksheet A—Personal allowances
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        A1.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="3">
                        Enter “1” for <b>yourself</b> if no one else can claim you as a dependent. Otherwise, enter 0.
                    </td>
                    <td colspan="1">
                        A1.
                    </td>
                    <td colspan="1">
                        `
                    </td>
                    <td colspan="1" style="text-align:center;">
                        <asp:TextBox ID="txtA1" runat="server" Placeholder="1 OR 0" CssClass="input_color center border-gray" onkeypress="return onlyNumbers();"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="valretxtA1" runat="server" CSSClass="red" ControlToValidate="txtA1" ValidationExpression="\b(1|0)\b" ErrorMessage="<b>Only 1 or 0 are Valid</b>" Display="Dynamic" />
                    </td>

                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        A2.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="3">
                        Enter “1” for your <b>spouse</b> if your spouse <b>doesn’t work</b>. Otherwise, enter 0
                    </td>
                    <td colspan="1">
                        A2.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="text-align:center;">
                        <asp:TextBox ID="txtA2" runat="server" Placeholder="1 OR 0" CssClass="input_color center border-gray" onkeypress="return onlyNumbers();"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="valretxtA2" runat="server" CSSClass="red" ControlToValidate="txtA2" ValidationExpression="\b(1|0)\b" ErrorMessage="<b>Only 1 or 0 are Valid</b>" Display="Dynamic" />
                    </td>

                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        A3.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="3">
                        Enter the number of <b>dependents</b> you will claim on your Oregon tax return
                    </td>
                    <td colspan="1">
                        A3.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="text-align:center;">
                        <asp:TextBox ID="txtA3" runat="server" CssClass="input_color center border-gray" onkeypress="return onlyNumbers();"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        A4.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="3">
                        Add lines A1 through A3. Enter the result here and follow the instructions below
                    </td>
                    <td colspan="1">
                        A4.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="text-align:center;">
                        <asp:TextBox ID="txtA4" runat="server" CssClass="input_color center border-gray" onkeypress="return onlyNumbers();"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2" rowspan="2" style="vertical-align:top;">
                        <img src="images/OR_Stop_Image.png" />
                    </td>
                    <td colspan="6">
                        <b>Complete all worksheets that apply.</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <ul>
                            <li style="color:black;">
                                <b>Worksheet B—</b>Use this worksheet if you plan to do <b>any</b> of the following on your 2021 Oregon return:
                                <ul>
                                    <li style="color:black;">
                                        Itemize your Oregon deductions or claim additional standard deduction amounts.
                                    </li>
                                    <li style="color:black;">
                                        Claim federal adjustments to income or Oregon additions, subtractions, or credits (other than personal exemption credits).
                                    </li>
                                    <li style="color:black;">
                                        Report nonwage income (such as dividends, interest, or self-employment income).
                                    </li>
                                </ul>
                            </li>
                        </ul>
                        <ul>
                            <li style="color:black;">
                                <b>Worksheet C—</b>Use this worksheet if you (including your spouse) have more than one job <b>and</b> the combined earnings from
                                <b>all</b> jobs exceed $20,000.
                            </li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                    <td colspan="6">
                        <b>If neither of the above worksheets apply,</b> stop here and enter the number from line A4 on Form OR-W-4, line 2.
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
            </table>
            <table style="background-color:white; font-size:medium; border-bottom:1px solid black; margin-bottom:20px;">
                <tr>
                    <td style="width:30%;"></td>
                    <td style="width:30%;"></td>
                    <td style="width:30%;"></td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align:center; font-weight:bold;">
                        – Keep this worksheet for your records –
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        150-101-402-1 (Rev. 10-08-20)
                    </td>
                    <td colspan="1" style="text-align:center;">
                        5 of 7
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
            </table>

            <table style="background-color:white; width:100%; font-size: x-large; text-align:center;padding-top:10px; padding-bottom:10px; padding-left:2px; padding-right:2px; border-bottom:1px solid black; margin-top:30px;">
                <tr>
                    <td style="width:20%;"></td>
                    <td style="width:60%;"></td>
                    <td style="width:20%;"></td>
                </tr>
                <tr style="margin-bottom:10px;">
                    <td colspan="1" style="float:left;">
                        <img src="images/OR_State_Logo.png" />
                    </td>
                    <td colspan="1" style="text-align:center; font-size: x-large; font-weight:bold;">
                        <b>
                            Oregon Withholding Instructions
                            <br />  <br />
                            Form OR-W-4
                        </b>
                    </td>
                    <td colspan="1" style="float:right; font-size: x-large; font-weight:bold; vertical-align:bottom;">
                        2021
                    </td>
                </tr>
            </table>
            <table style="background-color:white; width:100%; font-size:medium; margin-top:10px; margin-bottom:20px;">
                <tr>
                    <td style="width:2%;"></td>
                    <td style="width:2%;"></td>
                    <td style="width:73%;"></td>
                    <td style="width:1%;"></td>
                    <td style="width:1%;"></td>
                    <td style="width:7%;"></td>
                    <td style="width:7%;"></td>
                    <td style="width:7%;"></td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="font-size:16pt; font-weight:bold; text-align:center; ">
                        Worksheet B—Deductions, adjustments, credits, and nonwage income
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2" rowspan="2" style="vertical-align:top;">
                        <img src="images/OR_Stop_Image.png" />
                    </td>
                    <td colspan="6">
                        Use this worksheet if you plan to do <b>any</b> of the following on your 2021 Oregon return:
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        <ul>
                            <li style="color:black;">
                                Itemize your Oregon deductions or claim additional standard deduction amounts.
                            </li>
                            <li style="color:black;">
                                Claim federal adjustments to income or Oregon additions, subtractions, or credits (other than personal exemption credits).
                            </li>
                            <li style="color:black;">
                                Report nonwage income (such as dividends, interest, or self-employment income).
                            </li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        Having your prior year’s Oregon tax return on hand may help you when completing this worksheet
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        <b>Don’t list numbers as negative unless instructed.</b> For example, write a $1,000 Oregon subtraction as “$1,000”, not “($1,000)”.
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        B1.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Enter your estimated 2021 <b>nonwage income</b> (such as dividends or interest)
                    </td>
                    <td colspan="1">
                        B1.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtB1" runat="server" CssClass="input_color center border-gray right" onkeypress="return isDecimal(evt)" onblur="makeMoney(this)" Width="90%"></asp:TextBox>
                    </td>
                    <td colspan="1">
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        B2.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Enter your estimated 2021 Oregon <b>additions</b>
                    </td>
                    <td colspan="1">
                        B2.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtB2" runat="server" CssClass="input_color center border-gray right" onkeypress="return isDecimal(evt)" onblur="makeMoney(this)" Width="90%"></asp:TextBox>
                    </td>
                    <td colspan="1">
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        B3.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Add lines B1 and B2
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        B3.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtB3" runat="server" CssClass="input_color center border-gray right" onkeypress="return isDecimal(evt)" onblur="makeMoney(this)" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        B4.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Enter your estimated 2021 Oregon <b>deductions</b>. (See instructions)
                    </td>
                    <td colspan="1">
                        B4.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtB4" runat="server" CssClass="input_color center border-gray right" onkeypress="return isDecimal(evt)" onblur="makeMoney(this)" Width="90%"></asp:TextBox>
                    </td>
                    <td colspan="1">
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        B5.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Enter the <b>standard deduction</b> based on your anticipated 2021 filing status:
                    </td>
                    <td colspan="1">
                        B5.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtB5" runat="server" CssClass="input_color center border-gray right" onkeypress="return isDecimal(evt)" onblur="makeMoney(this)" Width="90%"></asp:TextBox>
                    </td>
                    <td colspan="1">
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="7">
                        <ul>
                            <li style="color:black;">
                                <b>Single or Married Filing Separately:</b> $2,350.
                            </li>
                            <li style="color:black;">
                                <b>Head of Household:</b> $3,780.
                            </li>
                            <li style="color:black;">
                                <b>Married Filing Jointly or Qualifying Widow(er):</b> $4,700.
                            </li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        B6.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Line B4 minus line B5. If the result is zero or less, enter 0
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        B6.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtB6" runat="server" CssClass="input_color center border-gray right" onkeypress="return isDecimal(evt)" onblur="makeMoney(this)" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        B7.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Enter your estimated 2021 federal <b>adjustments to income</b> and Oregon <b>subtractions</b>
                        (<b>exception</b>—don’t include the federal tax subtraction)
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        B7.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtB7" runat="server" CssClass="input_color center border-gray right" onkeypress="return isDecimal(evt)" onblur="makeMoney(this)" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        B8.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Add lines B6 and B7
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        B8.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtB8" runat="server" CssClass="input_color center border-gray right" onkeypress="return isDecimal(evt)" onblur="makeMoney(this)" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        B9.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Line B8 minus line B3. If less than zero, enter as a negative amount
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        B9.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtB9" runat="server" CssClass="input_color center border-gray right" onkeypress="return isDecimal(evt)" onblur="makeMoney(this)" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        B10.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Line B9 divided by $2,800. Round to one decimal place. If less than zero,
                        enter as a negative amount.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        B10.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtB10" runat="server" CssClass="input_color center border-gray right" onkeypress="return isDecimal(evt)" onblur="makeMoney(this)" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        B11.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Enter your estimated 2021 Oregon standard, carryforward, or refundable
                        <b>credits (exception</b>—don’t include personal exemption credits)
                    </td>
                    <td colspan="1">
                        B11.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtB11" runat="server" CssClass="input_color center border-gray right" onkeypress="return isDecimal(evt)" onblur="makeMoney(this)" Width="90%"></asp:TextBox>
                    </td>
                    <td colspan="1">
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        B12.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Divide line B11 by $213. Round to one decimal place.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        B12.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtB12" runat="server" CssClass="input_color center border-gray right" onkeypress="return isDecimal(evt)" onblur="makeMoney(this)" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        B13.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Add lines B10 and B12. If less than zero, enter as a negative amount. Round to
                        the whole number closest to zero by eliminating the decimal value.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        B13.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtB13" runat="server" CssClass="input_color center border-gray right" onkeypress="return onlyNumbers();" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        B14.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Enter the number from <b>Worksheet A</b>, line A4.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        B14.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtB14" runat="server" CssClass="input_color center border-gray right" onkeypress="return onlyNumbers();" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        B15.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Add lines B13 and B14. If zero or less, enter 0. (See instructions).
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        B15.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtB15" runat="server" CssClass="input_color center border-gray right" onkeypress="return onlyNumbers();" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                    <td colspan="2">
                        If you plan to use <b>Worksheet C</b>, also enter the result from line B15 on <b>Worksheet C</b>, line C1
                        <br />
                        Otherwise, <b>stop here</b> and enter the result from line B15 on Form OR-W-4, line 2.
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>

            </table>
            <table style="background-color:white; font-size:medium; border-bottom:1px solid black; margin-bottom:20px;">
                <tr>
                    <td style="width:30%;"></td>
                    <td style="width:30%;"></td>
                    <td style="width:30%;"></td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align:center; font-weight:bold;">
                        – Keep this worksheet for your records –
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        150-101-402-1 (Rev. 10-08-20)
                    </td>
                    <td colspan="1" style="text-align:center;">
                        6 of 7
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
            </table>
            <table style="background-color:white; width:100%; font-size: x-large; text-align:center;padding-top:10px; padding-bottom:10px; padding-left:2px; padding-right:2px; border-bottom:1px solid black; margin-top:30px;">
                <tr>
                    <td style="width:20%;"></td>
                    <td style="width:60%;"></td>
                    <td style="width:20%;"></td>
                </tr>
                <tr style="margin-bottom:10px;">
                    <td colspan="1" style="float:left;">
                        <img src="images/OR_State_Logo.png" />
                    </td>
                    <td colspan="1" style="text-align:center; font-size: x-large; font-weight:bold;">
                        <b>
                            Oregon Withholding Instructions
                            <br />  <br />
                            Form OR-W-4
                        </b>
                    </td>
                    <td colspan="1" style="float:right; font-size: x-large; font-weight:bold; vertical-align:bottom;">
                        2021
                    </td>
                </tr>
            </table>
            <table style="background-color:white; width:100%; font-size:medium; margin-top:10px; margin-bottom:20px;">
                <tr>
                    <td style="width:2%;"></td>
                    <td style="width:2%;"></td>
                    <td style="width:73%;"></td>
                    <td style="width:1%;"></td>
                    <td style="width:1%;"></td>
                    <td style="width:7%;"></td>
                    <td style="width:7%;"></td>
                    <td style="width:7%;"></td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="font-size:16pt; font-weight:bold; text-align:center; ">
                        Worksheet C—Two-earners / multiple jobs
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2" rowspan="2" style="vertical-align:top;">
                        <img src="images/OR_Stop_Image.png" />
                    </td>
                    <td colspan="6">
                        If you (including your spouse) have three or more jobs, consider using the <b>Oregon Withholding Calculator</b> at www.oregon.gov/dor
                        for a more accurate calculation of allowances.
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        If you don’t use the online calculator, use this worksheet to estimate the number of allowances to claim on your <b>highest paying job</b>.
                        Allowances should only be claimed for your highest paying job. Claim zero allowances on Form OR-W-4, line 2 for all of your (or your
                        spouse’s) other jobs to prevent underwithholding.
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        Only complete this worksheet if you (including your spouse) have more than one job <b>and</b> the combined earnings from <b>all</b> jobs exceed $20,000.
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        C1.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Enter the number from <b>Worksheet B</b>, line B15, if used. Otherwise, enter the
                        number from <b>Worksheet A</b>, line A4
                    </td>
                    <td colspan="2">
                    </td>
                    <td colspan="1">
                        C1.
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtC1" runat="server" CssClass="input_color center border-gray right" onkeypress="return onlyNumbers();" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        C2.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Enter the number below based on your 2021 anticipated filing status
                    </td>
                    <td colspan="1">
                        C2.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtC2" runat="server" CssClass="input_color center border-gray right" onkeypress="return onlyNumbers();" Width="90%"></asp:TextBox>
                    </td>
                    <td colspan="1">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                    <td colspan="1">
                        <ul>
                            <li style="color:black;">
                                <b>Single, Head of Household, or Married Filing Separately:</b>: Enter “2”;
                                <b>however</b>, if two of your jobs individually exceed $40,000, enter “4”.
                            </li>
                            <li style="color:black;">
                                <b>Married Filing Jointly or Qualifying Widow(er):</b> Enter “3”; <b>however,</b>
                                if two of your jobs individually exceed $50,000, enter “6”.
                            </li>
                        </ul>
                    </td>
                    <td colspan="5">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        C3.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        If you (including your spouse) will have three or more jobs at any point
                        during the year, enter the number below based on your 2021 anticipated
                        filing status. Otherwise, enter 0
                    </td>
                    <td colspan="1">
                        C3.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtC3" runat="server" CssClass="input_color center border-gray right" onkeypress="return onlyNumbers();" Width="90%"></asp:TextBox>
                    </td>
                    <td colspan="1">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                    <td colspan="1">
                        <ul>
                            <li style="color:black;">
                                <b>Single, Head of Household, or Married Filing Separately:</b>: Enter “2”;
                            </li>
                            <li style="color:black;">
                                <b>Married Filing Jointly or Qualifying Widow(er):</b> Enter “3”.
                            </li>
                        </ul>
                    </td>
                    <td colspan="5">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        C4.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Add lines C2 and C3
                    </td>
                    <td colspan="2">
                    </td>
                    <td colspan="1">
                        C4.
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtC4" runat="server" CssClass="input_color center border-gray right" onkeypress="return onlyNumbers();" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        C5.
                    </td>
                    <td colspan="6">
                        Is line C1 less than line C4?
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                    </td>
                    <td colspan="1">
                        <ul>
                            <li style="color:black;">
                                <b>Yes.</b> Enter 0 on line C5 and on Form OR-W-4, line 2. Complete lines C6 through C8 below
                                to figure the additional withholding amount necessary to avoid a year-end tax bill.
                            </li>
                            <li style="color:black;">
                                <b>No.</b> Line C1 minus line C4. Enter the result on line C5 (if zero, enter 0) and on Form OR-W-4,
                                line 2. <b>Don’t</b> complete the rest of this worksheet.
                            </li>
                        </ul>
                    </td>
                    <td colspan="2">
                        &nbsp;
                    </td>
                    <td colspan="1">
                        C5.
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtC5" runat="server" CssClass="input_color center border-gray right" onkeypress="return onlyNumbers();" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        C6.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Line C4 minus line C1
                    </td>
                    <td colspan="2">
                    </td>
                    <td colspan="1">
                        C6.
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtC6" runat="server" CssClass="input_color center border-gray right" onkeypress="return onlyNumbers();" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        C7.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Line C6 multiplied by $213
                    </td>
                    <td colspan="2">
                    </td>
                    <td colspan="1">
                        C7.
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtC7" runat="server" CssClass="input_color center border-gray right" onkeypress="return onlyNumbers();" Width="90%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        C8.
                    </td>
                    <td colspan="1">
                    </td>
                    <td colspan="1">
                        Line C7 divided by the number of <b>paychecks remaining in 2021</b> for the highest paying job and
                        rounded to the nearest dollar. Enter the result here and on Form OR-W-4, line 3. This is the
                        additional amount to be withheld from each paycheck
                    </td>
                    <td colspan="2">
                    </td>
                    <td colspan="1">
                        C8.
                    </td>
                    <td colspan="2" style="text-align:center;">
                        <asp:TextBox ID="txtC8" runat="server" CssClass="input_color center border-gray right" onkeypress="return onlyNumbers();" Width="90%"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <table style="background-color:white; font-size:medium; border-bottom:3px solid black; margin-bottom:20px;">
                <tr>
                    <td style="width:30%;"></td>
                    <td style="width:30%;"></td>
                    <td style="width:30%;"></td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align:center; font-weight:bold;">
                        – Keep this worksheet for your records –
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        150-101-402-1 (Rev. 10-08-20)
                    </td>
                    <td colspan="1" style="text-align:center;">
                        7 of 7
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="8">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </div>

        <div id="divMainForm" style="margin-left:1%; margin-right:5%;">
            <div id="divMainFormHeader">
                <table style="width:100%; background-color:white;">
                    <tr>
                        <td style="width:25%"></td>
                        <td style="width:25%"></td>
                        <td style="width:25%"></td>
                        <td style="width:25%"></td>
                    </tr>
                    <tr>
                        <td colspan="1" style="font-size: 35px; font-weight: bold;">
                            2021 Form OR-W-4
                            <br />
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1">
                            <img src="images/OR_BarCode.png" style="width:80%" />
                        </td>
                        <td style="border:2px solid black; text-align:center; color:black;">
                            Office use only
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            <b>Page 1 of 1, 150-101-402</b>
                        </td>
                        <td colspan="1">
                            <b>Oregon Department of Revenue</b>
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="border-left:2px solid black; border-right:2px solid black;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            <b>(Rev. 08-14-20, ver. 01)</b>
                        </td>
                        <td colspan="2">
                            &nbsp;
                        </td>
                        <td colspan="1" style="border-left:2px solid black; border-right:2px solid black;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="font-size: 28px; font-weight: bold;">
                            Oregon Employee’s Withholding Statement and Exemption Certificate
                        </td>
                        <td colspan="1" style="border-left:2px solid black; border-right:2px solid black;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            &nbsp;
                        </td>
                        <td colspan="1" style="border-left:2px solid black; border-right:2px solid black;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            &nbsp;
                        </td>
                        <td colspan="1" style="border-left:2px solid black; border-right:2px solid black;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="border-bottom:2px solid grey;">
                            &nbsp;
                        </td>
                        <td colspan="1" style="border-left:2px solid black; border-right:2px solid black; border-bottom:2px solid black;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </div>

            <div id="divMainFormNameAndAddress">
                <table style="width: 100%; background-color:white; font-size:large; border-bottom:2px solid black;">
                    <tr>
                        <td style="width:20%;"></td>
                        <td style="width:5%;"></td>
                        <td style="width:25%;"></td>
                        <td style="width:20%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:5%;"></td>
                        <td style="width:15%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border: 2px solid grey; border-left:hidden;">
                            First name
                            <br />
                            <b><asp:Label ID="lblFirstName" Style="padding-left:4%; color:dimgrey" runat="server" Width="100%" CssClass="HRETan" /></b>
                        </td>
                        <td colspan="1" style="border: 2px solid grey;">
                            Initial
                            <br />
                            <asp:Label ID="lblMiddleInitial" runat="server" Style="padding-left:5%;" Width="100%" CssClass="HRETan" />
                        </td>
                        <td colspan="1" style="border: 2px solid grey;">
                            Last name
                            <br />
                            <asp:Label ID="lblLastName" runat="server" Style="padding-left:5%;" Width="100%" CssClass="HRETan" />
                        </td>
                        <td colspan="1" style="border: 2px solid grey;">
                            Social Security number (SSN)
                            <br />
                            <asp:Label ID="lblSSN" runat="server" Style="padding-left:5%;" Width="100%" CssClass="HRETan" />
                        </td>
                        <td colspan="3">
                            Redetermination
                            <br />
                            <asp:Checkbox ID="chkRedetermination" runat="server" Style="padding-left:5%;" Width="100%" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="border: 2px solid grey; border-left:hidden;">
                            Address
                            <br />
                            <b><asp:Label ID="lblCombinedAddress" Style="padding-left:4%; color:dimgrey" runat="server" Width="100%" CssClass="HRETan" /></b>
                        </td>
                        <td colspan="2" style="border: 2px solid grey;">
                            City
                            <br />
                            <asp:Label ID="lblCity" runat="server" Style="padding-left:5%;" Width="100%" CssClass="HRETan" />
                        </td>
                        <td colspan="1" style="border: 2px solid grey;">
                            State
                            <br />
                            <asp:Label ID="lblState" runat="server" Style="padding-left:5%;" Width="100%" CssClass="HRETan" />
                        </td>
                        <td colspan="1" style="border: 2px solid grey; border-right:hidden;">
                            ZIP code
                            <br />
                            <asp:Label ID="lblZip" runat="server" Style="padding-left:5%;" Width="100%" CssClass="HRETan" />
                        </td>
                    </tr>
                </table>
            </div>

            <div id="divMainFormCenter">
                <table style="width: 100%; background-color:white; font-size:large;">
                    <tr>
                        <td style="width:2%;"></td>
                        <td style="width:80%;"></td>
                        <td style="width:3%;"></td>
                        <td style="width:15%;"></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <b>Note:</b> Your eligibility to claim a certain number of allowances or an exemption from withholding may be subject to review by the
                            Oregon Department of Revenue. Your employer may be required to send a copy of this form to the department for review.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="vertical-align:top;">
                            1.
                        </td>
                        <td colspan="3" style="vertical-align:top;">
                            <b>Select one:</b>&nbsp;&nbsp;
                            <asp:CheckBox ID="chkSingle" runat="server" AutoPostBack="true" OnCheckedChanged="chkSingle_CheckedChanged" /> Single &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:CheckBox ID="chkMarried" runat="server" AutoPostBack="true" OnCheckedChanged="chkMarried_CheckedChanged" /> Married &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:CheckBox ID="chkMarriedWHHigher" runat="server" AutoPostBack="true" OnCheckedChanged="chkMarriedWH_CheckedChanged" /> Married, but withholding at the higher single rate
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="vertical-align:top;">
                            &nbsp;
                        </td>
                        <td colspan="3" style="vertical-align:top;">
                            <b>Note:</b>
                            Check the “Single” box if you’re married and you’re legally separated or if your spouse is a nonresident alien.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="vertical-align:top;">
                            2.
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>Allowances.</b> Total number of allowances you’re claiming on line <b>A4, B15, or C5.</b> If you meet a
                            qualification to skip the worksheets and you aren’t exempt,<b> enter 0</b>
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right; padding-right:1%;">
                            2.
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:center; border:1px solid grey;">
                            <asp:TextBox ID="txtTotalExemptions" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" Class="center" Width="95%" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="vertical-align:top;">
                            3.
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>Additional amount.</b>  if any, you want withheld from each paycheck
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right; padding-right:1%;">
                            3.
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:center; border:1px solid grey;">
                            $<asp:TextBox ID="txtAdditionalWithholding" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="95%" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="vertical-align:top;">
                            4.
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            <b>Exemption from withholding.</b> I certify that my wages are exempt from withholding and I meet
                            the conditions for exemption as stated on page 2 of the instructions. Complete <b>both</b> lines below:
                        </td>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            <ul>
                                <li style="color:black;">
                                    Enter the corresponding exemption code. (See instructions)
                                </li>
                            </ul>
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right; padding-right:1%;">
                            4a.
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:center; border:1px solid grey;">
                            <asp:TextBox ID="txt4a" runat="server" Class="center" Width="95%" AutoPostBack="true" Onblur="txt4a_TextChanged" />
                            <%--<asp:RegularExpressionValidator ID="valretxt4a" runat="server" CSSClass="red" ControlToValidate="txt4a" ValidationExpression="\b(A|B|C|D|E|F|G|H|J|K|L|M|a|b|c|d|e|f|g|h|j|k|l|m)\b" ErrorMessage="<b>Only letters A, B, C, D, E, F, G, H, J, K, L, and M are Valid</b>" Display="Dynamic" />--%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" style="vertical-align:top;">
                            <ul>
                                <li style="color:black;">
                                    Write “Exempt”
                                </li>
                            </ul>
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:right; padding-right:1%;">
                            4b.
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:center; border-bottom:1px solid grey;">
                            <asp:TextBox ID="txt4b" runat="server" Class="center HREUnderLine" Width="95%" AutopostPack="true" OnBlur="txt4b_TextChanged" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;
                        </td>
                    </tr>
                    <tr style="border-bottom:2px solid grey;">
                        <td colspan="4">
                            <b>Sign here.</b> Under penalty of false swearing, I declare that the information provided is true, correct, and complete.
                        </td>
                    </tr>
                    <tr style="border-bottom:2px solid grey;">
                        <td colspan="2" style="border-right:1px solid black;">
                            Employee’s signature (This form isn’t valid unless signed).
                            <br />
                            <asp:TextBox ID="txtSignature" runat="server" Style="padding-left:2%;" Width="99%" />
                        </td>
                        <td colspan="2">
                            Date
                            <br />
                            <asp:TextBox ID="txtSignatureDate" runat="server" Width="99%" />
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <div>
                <table style="width: 100%; background-color:white; font-size:large;">
                    <tr>
                        <td style="width:60%;"></td>
                        <td style="width:25%;"></td>
                        <td style="width:7%;"></td>
                        <td style="width:8%;"></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <b>Employer use only.</b>
                        </td>
                    </tr>
                    <tr style="border-top:2px solid grey;">
                        <td colspan="1" style="border-right:2px solid grey;">
                            Employer’s Name
                            <br />
                            <b><asp:Label ID="lblEmployerName" runat="server" Style="padding-left: 10px;" CssClass="HRETan" Width="100%" /></b>
                        </td>
                        <td colspan="3">
                            Federal employer identification number (FEIN)
                            <br />
                            <b><asp:Label ID="lblEmployerFEIN" runat="server" Style="padding-left: 10px;" CssClass="HRETan" Width="100%" /></b>
                        </td>
                    </tr>
                    <tr style="border-top:2px solid grey; border-bottom:2px solid grey;">
                        <td colspan="1" style="border-right:2px solid grey;">
                            Employer’s address
                            <br />
                            <b><asp:Label ID="lblEmployerAddress" runat="server" Style="padding-left: 10px;" CssClass="HRETan" Width="100%" /></b>
                        </td>
                        <td colspan="1" style="border-right:2px solid grey;">
                            City or Town
                            <br />
                            <b><asp:Label ID="lblEmployerCity" runat="server" Style="padding-left: 10px;" CssClass="HRETan" Width="100%" /></b>
                        </td>
                        <td colspan="1" style="border-right:2px solid grey;">
                            State
                            <br />
                            <b><asp:Label ID="lblEmployerState" runat="server" Style="padding-left: 10px;" CssClass="HRETan" Width="100%" /></b>
                        </td>
                        <td colspan="1">
                            ZIP Code
                            <br />
                            <b><asp:Label ID="lblEmployerZip" runat="server" Style="padding-left: 10px;" CssClass="HRETan" Width="100%" /></b>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div id="divFormFooter" class="row HRERewrap">
            <br />
            <div style="float:right;">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valw4" OnClick="btnSave_Click" />
            </div>
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
            background: #f0f4fa;
            content: "X";
            color: black;
        }

        ol {
            list-style-type: lower-roman;
        }

        .HREwrapper {
            margin-left: 5%;
            margin-right: 5%;
        }

        .HRESlateBlue {
            background-color: #ccd5e4;
        }

        .HREWhite {
            background-color: white;
            border: 1px solid grey;
            padding: 10px;
            color: black;
        }

        .HREOffWhite {
            background-color: #F9F9F9;
        }

        .HRETan {
            background-color: #f5f5f0;
        }

        .HRELightBlue {
            background-color: #EFF3FB;
        }

        .HRERewrap {
            margin-right: 5%;
        }

        .HREpadR10 {
            padding-right: 20px;
            float: right;
        }

        .HREUnderLine {
            border-bottom: 1px solid black;
        }

        .HREError {
            color: red;
            font-weight: bold;
            background-color: #f2dede;
            padding: 10px 10px 10px 10px;
            margin-right: 5%;
            text-align: center;
        }

        .HRESuccess {
            color: green;
            font-weight: bold;
            font-size: x-large;
            background-color: #fff;
            padding: 10px 10px 10px 10px;
            text-align: center;
        }

        .HRELabel {
            background-color: #f5f5f0;
            font-size: large;
            vertical-align: bottom;
        }

        .HREBlack {
            color: black;
        }
    </style>

</asp:Content>

