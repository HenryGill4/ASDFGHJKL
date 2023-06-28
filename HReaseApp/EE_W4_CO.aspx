<%@ Page Title="CO State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_CO.aspx.vb" 
    Inherits="HReaseApp.EE_W4_CO"
    MaintainScrollPositionOnPostback="false" %>

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
        };

        $(function () {
            var Boxa = $('input:text[id$=TextWorksheet1Q1]').keyup(foo);
            var Boxb = $('input:text[id$=TextWorksheet1Q2]').keyup(foo);
            var Boxc = $('input:text[id$=TextWorksheet1Q3]').keyup(foo);
            var Boxd = $('input:text[id$=TextWorksheet1Q4]').keyup(foo);
            var Boxe = $('input:text[id$=TextWorksheet1Q6]').keyup(foo);

            function foo() {
                var a = Boxa.val();
                var b = Boxb.val();
                var c = Boxc.val();
                var d = Boxd.val();
                var e = Boxe.val();

                var sumf = 0
                sumf = add(a, b, c, d);
                $('input:text[id$=TextWorksheet1Q5]').val(sumf);

                var sumg = 0;
                sumg = sumf / e;
                $('input:text[id$=TextWorksheet1Q7]').val(sumg);
                $('input:text[id$=TextWithholdingAllowance]').val(sumg);

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
            var Boxh = $('input:text[id$=TextWorksheet2Q1]').keyup(foo);
            var Boxi = $('input:text[id$=TextWorksheet2Q2]').keyup(foo);
            var Boxm = $('input:text[id$=TextWorksheet2Q6]').keyup(foo);

            function foo() {
                var h = Boxh.val();
                var i = Boxi.val();
                var m = Boxm.val();

                var sumj = 0
                sumj = add(h, i);
                $('input:text[id$=TextWorksheet2Q3]').val(sumj);

                var sumk = 0;
                sumk = sumj * .0455;
                $('input:text[id$=TextWorksheet2Q4]').val(sumk);

                $('input:text[id$=TextAdditionalWithholding]').val(m);

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

    </script>

    <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>Colorado Form D0004</b></h4>
                <br />
            </div>
            <%--<div class="col-md-6" style="float:right; vertical-align:bottom; padding-top:20px;">
                <asp:ImageButton ID='btnPrint' runat='server' ImageUrl='../img/printer.jpg' BorderStyle='None' Height='40px' ToolTip="Print" />
            </div>--%>
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
                    <td style="width:47%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:50%;"></td>
                </tr>
                <tr>
                    <td colspan="3">
                        DR 0004 (11/05/21)
                        <br />
                        <b>COLORADO DEPARTMENT OF REVENUE</b>
                        <br />
                        <i>Tax.Colorado.gov</i>
                    </td>
                </tr>
                <tr>
                    <td>

                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align:center;">
                        <p style="font-size: 28px; font-weight: 900;">
                            2022 Colorado Employee Withholding Certificate
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan ="1" style="vertical-align:top;">                                  
                        <p style="font-size: 18px;">
                            <b>This Certificate Is Optional for Employees</b>
                            <br />
                            <span style="font-size:medium;">
                                If you do not complete this certificate, then your employer 
                                will calculate your Colorado withholding based on your 
                                IRS Form W-4. That calculation is designed to withhold 
                                the required Colorado income tax due on your wages 
                                throughout the year, and it will generally result in a refund 
                                when you file your Colorado income tax return.
                            </span>
                        </p>
                        <p style="font-size: 20px;">
                            <b>Reasons to Complete This Certificate</b> 
                            <br />
                            <span style="font-size:medium;">
                                Complete this certificate if you want to adjust your Colorado 
                                withholding for one or more of the following reasons:
                            </span>
                        </p>
                        <ol>
                            <li>You earn most of your income from one job,</li>                            
                            <li>You expect to claim federal itemized deductions and/
                                or the Colorado child tax credit, or</li>
                            <li>You expect significant income from other sources.</li>
                           
                        </ol>
                        <p>
                            For most taxpayers, completing this certificate will likely
                            increase your take-home pay, reduce your Colorado 
                            withholding, and reduce your refund when you file your 
                            Colorado income tax return. Consider the amounts you 
                            enter carefully. If too little is withheld, then you will owe 
                            tax when you file your Colorado return, and you may 
                            owe a penalty.
                        </p>
                       
                    </td>
                    <td style="width:3%;"></td>
                    <td style="width: 47%; padding-right: 3px; vertical-align:top;">      
                        <p style="font-size: 18px;">
                            <b>When to Complete a New Certificate</b> 
                            <br />
                            <span style="font-size:medium;">
                                You may adjust your withholding at any time. Consider 
                                completing a new certificate for the following reasons:
                            </span>
                        </p>
                        <ol>
                            <li>You last completed a certificate three or more years ago;</li>                            
                            <li>Your wages or other income changes significantly;</li>
                            <li>Your number of jobs changes;</li>
                            <li>Your expected filing status (single, married filing 
                                jointly, etc.) changes;</li>
                            <li>Your expected federal deductions change significantly;</li>
                            <li>You have a new qualifying child for the child tax credit; or</li>
                            <li>You or your child will no longer qualify for the Colorado 
                                child tax credit, including if your child will turn 6 years 
                                old this year.</li>
                           
                        </ol>
                        <p style="font-size: 18px;">
                            <b>If You Complete This Certificate</b> 
                        </p>
                        <ol>
                            <li>Give it to your employer; then they must calculate your 
                                Colorado withholding based on the amounts you entered.</li>                            
                            <li>If you (and your spouse, if filing jointly) have multiple 
                                jobs, complete a separate certificate for each one.</li>
                            <li>In order to prevent evasion of Colorado income tax, 
                                the Department of Revenue may review and adjust 
                                your withholding.</li>
                           
                        </ol>
                        
                    </td>
                </tr>
            </table>
        </div>

        <div id="PersonalAllowancesHeaderBar" class="well HRESlateBlue HRERewrap" style="text-align:center; max-height:100px;">
	        <span><b>PERSONAL ALLOWANCES WORKSHEET</b></span>
	        <img src="img/plus.png" class="instruction_toggle_btn1" style="float: right; width: 30px; max-height:100px; padding-bottom:10px;" />
        </div>

        <div id="PersonalAllowancesWorksheet" class="form-group instruction_toggle1" style="margin-right:5%;">
            <div id="PageHeader1">
                <p >
                    DR 0004 (11/05/21)
                    <br />
                    <b>COLORADO DEPARTMENT OF REVENUE</b>
                    <br />
                    <i>Tax.Colorado.gov</i>
                </p>
            </div> 
            <div id="Page1Title">
                <br />
                <p style="font-size: 28px; font-weight: 900; text-align:center;" >
                    Worksheet 1: Withholding Allowance
                </p>
            </div>
            <table id="Worksheet1Instructions">
                <tr>
                    <td style="width:47%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:50%;"></td>
                </tr>
                <tr>
                    <td colspan ="1" style="vertical-align:top;">                                  
                        <p>
                            <b>This worksheet is optional.</b>  You may complete the 
                                Colorado Employee Withholding Certificate without 
                                completing this worksheet. Complete this worksheet only 
                                if you want to adjust your Colorado withholding for one or 
                                both of the following reasons:
                        </p>
                        <ol>
                            <li>You expect to claim additional federal deductions and/
                                or the Colorado child tax credit; or</li>                            
                            <li>You (and your spouse, if filing jointly) have multiple jobs 
                                but earn more income from one job.</li>
                            <li>In order to prevent evasion of Colorado income tax, 
                                the Department of Revenue may review and adjust 
                                your withholding.</li>
                           
                        </ol>
                        <p>To use the electronic DR 0004 Withholding Calculator, go 
                            to Tax.Colorado.gov/Withholding-Forms.</p>
                    </td>

                    <td style="width:3%;"></td>
                    <td style="width: 47%; padding-right: 3px; vertical-align:top;">      
                        <p >
                            You (and your spouse, if filing jointly) only need to complete 
                            this worksheet once regardless of your number of jobs. 
                            However, you will need to give a separate Colorado 
                            Employee Withholding Certificate to each of your employers. 
                            <b>Do not give this worksheet to your employers.</b> 
                        </p>
                        <p>
                            For more information about itemized deductions, see IRS 
                            Topic No. 501. For more information about qualifying for the 
                            child tax credit, see IRS Publication 972. Please note that 
                            the Colorado child tax credit is allowed for qualifying children 
                            who do not have a work-eligible social security number.
                        </p>
                        
                    </td>
                </tr>

            </table>            
            <table id="Worksheet1" style="border:2px solid black; padding: 5px 5px 5px 5px;">
                <tr>
                    <td style="width:3%;"></td>
                    <td style="width:2%;"></td>
                    <td style="width:80%;"></td>
                    <td style="width:14%;"></td>
                    <td style="width:1%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; border-bottom:1px solid black;">
                        1.
                    </td>
                    <td colspan="2" style="border-bottom: 1px solid black;" >
                        Enter the amount of income you (and your spouse, if filing jointly) expect to receive this year 
                        from all sources. 
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-left:1px solid black; border-bottom:1px solid black; ">
                        $<asp:TextBox ID="TextWorksheet1Q1" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%" />
                    </td>
                    <td colspan="1" style="border-bottom:1px solid black; " >
                    </td>
                </tr>
                <tr >
                    <td colspan="1" style="vertical-align:top;">
                        2.
                    </td>
                    <td colspan="3">
                        Enter your Standard Allowance, based on your expected filing status from IRS Form W-4 Step 1(c):  
                    </td>
                    <td colspan="1">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="vertical-align:top; text-align:right;">
                        a.
                    </td>
                    <td colspan="2">
                        $10,500 if single or married filing separately;
                    </td>
                    <td colspan="1">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="vertical-align:top; text-align:right;">
                        b.
                    </td>
                    <td colspan="1">
                        $16,500 if head of household; or
                    </td>
                     <td colspan="2" style="border-top:1px solid black; border-left:1px solid black;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="vertical-align:top; text-align:right; border-bottom: 1px solid black;" >
                        c.
                    </td>
                    <td colspan="1" style="border-bottom: 1px solid black;" >
                       $23,000 if married filing jointly or qualifying widow(er)
                    </td>
                    <td colspan="1" style="border-left:1px solid black; border-bottom: 1px solid black;">
                        $<asp:TextBox ID="TextWorksheet1Q2" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%" />
                    </td>
                    <td colspan="1" style="border-bottom: 1px solid black;" >
                         &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; border-bottom:1px solid black;">
                        3.
                    </td>
                    <td colspan="2" style="border-bottom: 1px solid black;" >
                        Enter the amount from IRS Form W-4 Step 4(b), if any, which is your estimated federal 
                        deductions that exceed the standard deduction.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-left:1px solid black; border-bottom:1px solid black;">
                        $<asp:TextBox ID="TextWorksheet1Q3" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%" />
                    </td>
                    <td colspan="1" style="border-bottom: 1px solid black;" >
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; border-bottom:1px solid black;">
                        4.
                    </td>
                    <td colspan="2" style="border-bottom: 1px solid black;" >
                        Enter your Child Tax Credit Allowance from Table 2 below.
                        <br />
                        <b>If you do not want to reduce your withholding for the Colorado child tax credit, you may enter 
                            zero on this line, even if you expect to claim the credit.</b>
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-left:1px solid black; border-bottom:1px solid black;">
                        $<asp:TextBox ID="TextWorksheet1Q4" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%" />
                    </td>
                    <td colspan="1" style="border-bottom: 1px solid black;" >
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        &nbsp;
                    </td>
                    <td colspan="2" style="border-left: 1px solid black;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; border-bottom:1px solid black;">
                        5.
                    </td>
                    <td colspan="2" style="border-bottom: 1px solid black;" >
                        Add Lines 2, 3, and 4. This is your Total Withholding Allowance.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-left:1px solid black; border-bottom:1px solid black;">
                        $<asp:TextBox ID="TextWorksheet1Q5" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%" />
                    </td>
                    <td colspan="1" style="border-bottom: 1px solid black;" >
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        &nbsp;
                    </td>
                    <td colspan="2" style="border-left: 1px solid black;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; border-bottom:1px solid black;">
                        6.
                    </td>
                    <td colspan="2" style="border-bottom: 1px solid black;" >
                       Enter the number of jobs that you (and your spouse, if filing jointly) currently have
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-left:1px solid black; border-bottom:1px solid black;">
                        &nbsp;&nbsp;<asp:TextBox ID="TextWorksheet1Q6" runat="server" onkeypress="return onlyNumbers()" Class="center" Width="90%" />
                    </td>
                    <td colspan="1" style="border-bottom: 1px solid black;" >
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        &nbsp;
                    </td>
                    <td colspan="2" style="border-left: 1px solid black;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        7.
                    </td>
                    <td colspan="2">
                       Divide Line 5 by Line 6. This is your Annual Withholding Allowance for each job.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-left:1px solid black; border-bottom:1px solid black;">
                        $<asp:TextBox ID="TextWorksheet1Q7" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%" />
                    </td>
                    <td colspan="1" style="border-bottom: 1px solid black;" >
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="vertical-align:top; text-align:right;" >
                        <b>a.</b>
                    </td>
                    <td colspan="2">
                       <b>If you (and your spouse, if filing jointly) have multiple jobs but earn most of your income from one job, you may want 
                            to divide the Total Withholding Allowance on Line 5 unevenly between your jobs. For example, if you earn 75% of 
                            your income from one job, you could use 75% of Line 5 for that job and the remaining 25% of Line 5 for your other 
                            job(s). If you choose to divide Line 5 unevenly, you will need to complete a separate Colorado Employee Withholding 
                            Certificate for each job.</b>
                    </td>
                    <td colspan="1">
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="vertical-align:top; text-align:right;" >
                        <b>b.</b>
                    </td>
                    <td colspan="2">
                       <b>If you want a greater amount withheld, you may enter a smaller amount than your calculation.</b>
                    </td>
                    <td colspan="1">
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <b>Enter the amount you choose on Line 2 of your Colorado Employee Withholding Certificate</b>
                    </td>
                </tr>
                
            </table>
            <br />           
            <table id="Table2" style="border:2px solid black; ">
                <tr>
                    <td style="width:20%;"></td>
                    <td style="width:20%;"></td>
                    <td style="width:20%;"></td>
                    <td style="width:20%;"></td>
                    <td style="width:20%;"></td>
                </tr>
                <tr>
                    <td colspan="5" style="font-size:18px;">
                        <b>Table 2: Child Tax Credit Allowance</b>

                    </td>
                </tr>
                <tr>
                    <td colspan="5" style="border-bottom:2px solid black;">
                        Go down the first column to your expected filing status from IRS Form W-4 Step 1(c).
                        Then select the corresponding row in the second column with your expected income from Line 1 of Worksheet 1.
                        Finally, go across that row to the column with your number of qualifying children.

                    </td>
                </tr>
                <tr>
                    <td colspan="1" rowspan="2" style="text-align:center; border-bottom:1px solid black;border-right:1px solid black; font-size:14px;">
                        <p>
                            <b>Filing Status from IRS Form W-4 Step 1(c)</b>

                        </p>
                    </td>
                    <td colspan="1" rowspan="2" style="text-align:center; border-bottom:1px solid black;border-right:1px solid black; font-size:14px;">
                        <p>
                            <b>Income from Line 1 of Worksheet 1</b>

                        </p>
                    </td>
                    <td colspan="3" style="text-align:center; border-bottom:1px solid black; font-size:14px;" >
                        <p>
                           <b>Allowance for Qualifying Children Under Age 6 on December 31 of this year:</b>

                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black; font-size:14px;" >
                        <b>1 Child</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black; font-size:14px;" >
                        <b>2 Children</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black; font-size:14px;" >
                        <b> 3 or More Children</b>
                    </td>

                </tr>                
                <tr>
                    <td colspan="1" rowspan="4" style="text-align:center; border-bottom:2px solid black;" >
                        Single, Married Filing Separately, or Head of Household
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $0 - $25,000
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $9,000
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $13,000
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $11,500
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $25,001 - $50,000
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $7,000
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $13,000
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $17,000
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $50,001 - $75,000
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $2,500
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $5,000
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $7,000
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                        $75,001 or more
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                        $0
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                        $0
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                        $0
                    </td>
                </tr>
                <tr>
                    <td colspan="1" rowspan="4" style="text-align:center; border-bottom:2px solid black;" >
                        Married Filing Jointly or Qualifying Widow(er)
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $0 - $35,000
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $10,000
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $17,500
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $20,000
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $35,001 - $60,000
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $7,000
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $14,000
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $19,000
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $60,001 - $85,000
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $2,500
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $5,000
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:1px solid black; border-left: 1px solid black;" >
                        $7,000
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                        $85,001 or more
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                        $0
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                        $0
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                        $0
                    </td>
                </tr>
            </table>
       
            <div id="PageHeader2">
                <p >
                    DR 0004 (11/05/21)
                    <br />
                    <b>COLORADO DEPARTMENT OF REVENUE</b>
                    <br />
                    <i>Tax.Colorado.gov</i>
                </p>
            </div> 
            <div id="Page2Title">
                <br />
                <p style="font-size: 28px; font-weight: 900; text-align:center;" >
                    Worksheet 2: Additional Withholding
                </p>
            </div>
            <table id="Worksheet2Instructions">
                <tr>
                    <td style="width:47%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:50%;"></td>
                </tr>
                <tr>
                    <td colspan ="1" style="vertical-align:top;">                                  
                        <p>
                            <b>This worksheet is optional.</b> You may complete the Colorado 
                                Employee Withholding Certificate without completing this 
                                worksheet. Complete this worksheet only if you would like 
                                to calculate additional wage withholding to cover other 
                                types of taxable income that you (and your spouse, if filing 
                                jointly) expect to receive this year. This may include interest, 
                                dividends, retirement income, rental income, or income from 
                                self-employment or as an independent contractor.
                        </p>
                        <p>
                            To use the electronic DR 0004 Withholding Calculator, go to 
                            Tax.Colorado.gov/Withholding-Forms
                        </p>
                        <p>Complete a separate copy of this worksheet for each job to 
                            which you would like to add withholding. <b>Do not give this 
                            worksheet to your employer.</b>

                        </p>
                    </td>
                    <td style="width:3%;"></td>
                    <td style="width: 47%; padding-right: 3px; vertical-align:top;">      
                        <p >
                            Alternatively, you may use form DR 0104EP to submit 
                            estimated tax payments for any non-wage income that 
                            you receive. If you do not ensure that you have enough 
                            withholding and estimated tax payments, then you will owe 
                            tax when you file your return, and you may owe a penalty. 
                            For more information about withholding and estimated tax 
                            payments, see parts 6 and 7 of the Colorado Individual 
                            Income Tax Guide.
                        </p>
                        <p>
                            For more information about taxable and nontaxable income, 
                            see IRS Publication 525. For information about the Colorado 
                            pension and annuity subtraction, go to Tax.Colorado.gov/
                            Individual-Income-Tax-Guidance-Publications.
                        </p>
                        
                    </td>
                </tr>

            </table>            
            <table id="Worksheet2" style="border:2px solid black; padding: 5px 5px 5px 5px;">
                <tr>
                    <td style="width:3%;"></td>
                    <td style="width:2%;"></td>
                    <td style="width:80%;"></td>
                    <td style="width:14%;"></td>
                    <td style="width:1%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; border-bottom:1px solid black;">
                        1.
                    </td>
                    <td colspan="2" style="border-bottom: 1px solid black;" >
                        Enter the amount from IRS Form W-4 Step 4(a), which is your estimated non-business 
                        income for this year. 
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-left:1px solid black; border-bottom:1px solid black; ">
                        $<asp:TextBox ID="TextWorksheet2Q1" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%" />
                    </td>
                    <td colspan="1" style="border-bottom:1px solid black; " >
                    </td>
                </tr>
                <tr >
                    <td colspan="1" style="vertical-align:top; border-bottom:1px solid black; ">
                        2.
                    </td>
                    <td colspan="2" style="border-bottom:1px solid black; ">
                        Enter any other non-wage income that you (and your spouse, if filing jointly) expect to 
                        receive this year, but is not included in the amount from IRS Form W-4 Step 4(a). This may 
                        include income from self-employment or as an independent contractor.  
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-left:1px solid black; border-bottom:1px solid black; ">
                        $<asp:TextBox ID="TextWorksheet2Q2" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%" />
                    </td>
                    <td colspan="1" style="border-bottom:1px solid black; ">
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        &nbsp;
                    </td>
                    <td colspan="2" style="border-left: 1px solid black;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; border-bottom:1px solid black;">
                        3.
                    </td>
                    <td colspan="2" style="border-bottom: 1px solid black;" >
                        Add Lines 1 and 2. This is your Total Additional Income.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-left:1px solid black; border-bottom:1px solid black;">
                        $<asp:TextBox ID="TextWorksheet2Q3" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%" />
                    </td>
                    <td colspan="1" style="border-bottom: 1px solid black;" >
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        &nbsp;
                    </td>
                    <td colspan="2" style="border-left: 1px solid black;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; border-bottom:1px solid black;">
                        4.
                    </td>
                    <td colspan="2" style="border-bottom: 1px solid black;" >
                       Multiply Line 3 by 4.55% (0.0455). This is your Total Additional Withholding.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-left:1px solid black; border-bottom:1px solid black;">
                        $<asp:TextBox ID="TextWorksheet2Q4" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%" />
                    </td>
                    <td colspan="1" style="border-bottom: 1px solid black;" >
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; border-bottom:1px solid black;">
                        5.
                    </td>
                    <td colspan="2" style="border-bottom: 1px solid black;" >
                       Divide Line 4 by the number of jobs to which you would like to add withholding. This is your 
                        Additional Withholding Per Job.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-left:1px solid black; border-bottom:1px solid black;">
                        $<asp:TextBox ID="TextWorksheet2Q5" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%" />
                    </td>
                    <td colspan="1" style="border-bottom: 1px solid black;" >
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        6.
                    </td>
                    <td colspan="2" >
                       Divide Line 5 by the number of pay periods during the year for this job (see Table 3 below). 
                        This is your Additional Withholding Per Pay Period.
                    </td>
                    <td colspan="2" style="border-left: 1px solid black;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="border-bottom: 1px solid black;" >
                        <b>Enter this amount on Line 3 of your Colorado Employee Withholding Certificate.</b> 
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-left:1px solid black; border-bottom:1px solid black;">
                        $<asp:TextBox ID="TextWorksheet2Q6" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%" />
                    </td>
                    <td colspan="1" style="border-bottom: 1px solid black;" >
                    </td>
                </tr>
               
            </table>
            <br />           
            <table id="Table3" style="border:2px solid black;">
                <tr>
                    <td style="width:12.5%;"></td>
                    <td style="width:12.5%;"></td>
                    <td style="width:12.5%;"></td>
                    <td style="width:12.5%;"></td>
                    <td style="width:12.5%;"></td>
                    <td style="width:12.5%;"></td>
                    <td style="width:12.5%;"></td>
                    <td style="width:12.5%;"></td>
                </tr>
                <tr>
                    <td colspan="8" style="font-size:28px;">
                        <b>Table 3: Pay Periods During the Year</b>

                    </td>
                </tr>
                <tr>
                    <td colspan="8" style="border-bottom:2px solid black;">
                        Semimonthly means twice a month, usually on the 15th and 30th.
                        <br />
                        Biweekly means every other week, usually on Fridays, regardless of the month.

                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>Annually</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>Semiannually</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>Quarterly</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>Monthly</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>Semimonthly</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>Biweekly</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>Weekly</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>Daily</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>1</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>2</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>4</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>12</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>24</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>26</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>52</b>
                    </td>
                    <td colspan="1" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px; vertical-align:middle;">
                        <b>260</b>
                    </td>
                </tr>
            </table>
            <br /> 
        </div>
       
        <div id="DivFormHeader">
            <div id="PageHeader3">
                <p >
                    DR 0004 (11/05/21)
                    <br />
                    <b>COLORADO DEPARTMENT OF REVENUE</b>
                    <br />
                    <i>Tax.Colorado.gov</i>
                </p>
            </div> 
            <div id="Page3Title">
                <br />
                <p style="font-size: 28px; font-weight: 900; text-align:center;" >
                    2022 Colorado Employee Withholding Certificate
                </p>
            </div>
        </div>

        <div id="DivFormBody" style="margin-right:5%;">
            <table id="MainFormPersonalInfo" style="border:2px solid black;">
                <tr>
                    <td style="width:45%;"></td>
                    <td style="width:20%;"></td>
                    <td style="width:10%;"></td>
                    <td style="width:10%;"></td>
                    <td style="width:15%;"></td>
                </tr>
                <tr>
                    <td colspan="5" style="font-size:18px; border-bottom:2px solid black;">                        
                        <b>1. Personal Information</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="padding-left: 5px; border-bottom:1px solid black;">
                        Last Name
                        <br />
                        <b><asp:Label ID="LabelLastName" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                    <td colspan="3" style="padding-left: 5px; border-bottom:1px solid black; border-left: 1px solid black;">
                        First Name
                        <br />
                        <b><asp:Label ID="LabelFirstName" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                    <td colspan="1" style="padding-left: 5px; border-bottom:1px solid black; border-left: 1px solid black;">
                        Middle Initial
                        <br />
                        <b><asp:Label ID="LabelMiddleInitial" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="padding-left: 5px; border-bottom:1px solid black;">
                        Mailing Address
                        <br />
                        <b><asp:Label ID="LabelMailingAddress" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                    <td colspan="3" style="padding-left: 5px; border-bottom:1px solid black; border-left: 1px solid black;">
                        SSN or ITIN
                        <br />
                        <b><asp:Label ID="LabelSSN" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="padding-left: 5px; border-bottom:1px solid black;">
                        City
                        <br />
                        <b><asp:Label ID="LabelCity" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                    <td colspan="1" style="padding-left: 5px; border-bottom:1px solid black; border-left: 1px solid black;">
                        State
                        <br />
                        <b><asp:Label ID="LabelState" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                    <td colspan="2" style="padding-left: 5px; border-bottom:1px solid black; border-left: 1px solid black;">
                        Zip
                        <br />
                        <b><asp:Label ID="LabelZip" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                </tr>
            </table>
            <table id="MainFormQuestions" style="border:2px solid black; padding: 5px 5px 5px 5px;">
                <tr>
                    <td style="width:3%;"></td>
                    <td style="width:2%;"></td>
                    <td style="width:80%;"></td>
                    <td style="width:14%;"></td>
                    <td style="width:1%;"></td>
                </tr>
                <tr>
                    <td colspan="5" style="vertical-align:top; font-size:18px;">
                        <b>2. Annual Withholding Allowance</b>
                    </td>
                </tr>
                <tr>      
                    <td colspan="1">&nbsp;</td>
                    <td colspan="1" style="vertical-align:top;">
                        a.
                    </td>
                    <td colspan ="3" style="vertical-align:top;">
                        If you want to reduce your Colorado withholding based on the federal standard deduction and your number of jobs, 
                        enter the appropriate amount from Table 1 below. <b>If you have multiple jobs but earn most of your income from one 
                        job, complete Worksheet 1 instead and enter the result here.</b>
                    </td>
                </tr>
                <tr>      
                    <td colspan="1">&nbsp;</td>
                    <td colspan="1" style="vertical-align:top;">
                        b.
                    </td>
                    <td colspan ="3" style="vertical-align:top;">
                        If you also want to reduce your Colorado withholding based on the additional federal deductions and/or Colorado 
                        child tax credit you expect to claim, complete Worksheet 1 and enter the result here.
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="border-bottom:1px solid black; " >
                        &nbsp;

                    </td>
                    <td colspan="2" style="border-bottom:1px solid black; ">
                        <b>If you want a greater amount withheld, you may enter a smaller amount than either calculation.</b>
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-left:1px solid black; border-bottom:1px solid black; border-top: 1px solid black;">
                        $<asp:TextBox ID="TextWithholdingAllowance" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%" />
                    </td>
                    <td colspan="1" style="border-bottom:1px solid black; border-top: 1px solid black;">
                         &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="5" style="vertical-align:top; font-size:18px; ">
                        <b>3. Additional Withholding Per Pay Period</b>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="border-bottom:1px solid black; " >
                        &nbsp;

                    </td>
                    <td colspan="2" style="border-bottom:1px solid black; ">
                        Enter any additional tax you want withheld from each paycheck. <b>If you expect to receive other 
                        income that will not have withholding, you may complete Worksheet 2 and include the result here.</b>
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-left:1px solid black; border-bottom:1px solid black; border-top: 1px solid black; ">
                        $<asp:TextBox ID="TextAdditionalWithholding" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%" />
                    </td>
                    <td colspan="1" style="border-bottom:1px solid black; border-top: 1px solid black; border-top: 1px solid black;">
                         &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="5" style="vertical-align:top; font-size:14px; border-bottom:1px solid black; border-top: 1px solid black;">
                        <b>4. Sign Here.</b>  This form is not valid unless you sign this declaration: I declare that the amounts on this certificate have not 
                            been presented to willfully evade Colorado income tax or obstruct its collection
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="padding-left: 5px; vertical-align:bottom; ">   
                        Employee Signature
                        <br />
                        <asp:TextBox ID="TextSignature" runat="server" Width="95%"/>
                    </td>
                    <td colspan="2" style="padding-left: 5px; vertical-align:bottom; border-left: 1px solid black; ">   
                        Date (MM/DD/YY)
                        <br />
                        <asp:TextBox ID="SignatureDate" runat="server" Width="95%"/>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div id="Table1Div" style="margin-right:5%;">
            <table id="Table1" style="border:2px solid black; padding: 5px 5px 5px 5px;">
                    <tr>
                        <td style="width:40%;"></td>
                        <td style="width:15%;"></td>
                        <td style="width:15%;"></td>
                        <td style="width:15%;"></td>
                        <td style="width:15%;"></td>
                    </tr>
                    <tr>
                        <td colspan="5" style="font-size:18px;">
                            <b>Table 1: Standard Allowance</b>

                        </td>
                    </tr>
                    <tr>
                        <td colspan="5" style="border-bottom:2px solid black;">
                            Go down the first column to your expected filing status from IRS Form W-4 Step 1(c). 
                                Then go across that row to the column with the number of jobs that you (and your spouse, if filing jointly) currently have.

                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" rowspan="2" style="text-align:center; border-bottom:2px solid black;border-right:2px solid black; font-size:14px;">
                            <p>
                                <b>Filing Status from IRS Form W-4 Step 1(c)</b>

                            </p>
                        </td>
                        <td colspan="4" style="text-align:center; border-bottom:1px solid black; font-size:14px;" >
                            <p>
                               <b>Standard Allowance for:</b>

                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; border-bottom:2px solid black; font-size:14px;" >
                            <b>1 Job</b>
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:2px solid black; font-size:14px;" >
                            <b>2 Jobs</b>
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:2px solid black; font-size:14px;" >
                            <b>3 Jobs</b>
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:2px solid black; font-size:14px;" >
                            <b>4 or More Jobs</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; border-bottom:1px solid black;" >
                            Single or Married Filing Separately
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                            $10,500
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                             $5,000
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                            $3,500
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                            $2,500
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; border-bottom:1px solid black;" >
                            Head of Household
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                            $16,500
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                            $8,500
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                            $5,500
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:2px solid black; border-left: 1px solid black;" >
                             $4,000
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center;" >
                            Married Filing Jointly or Qualifying Widow(er) 
                        </td>
                        <td colspan="1" style="text-align:center; border-left: 1px solid black;" >
                            $23,000
                        </td>
                        <td colspan="1" style="text-align:center; border-left: 1px solid black;" >
                             $11,500
                        </td>
                        <td colspan="1" style="text-align:center; border-left: 1px solid black;" >
                             $7,500
                        </td>
                        <td colspan="1" style="text-align:center; border-left: 1px solid black;" >
                             $5,500

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
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; display:inline; float: left;}
        table {background-color:white; min-height: 25px; color:black; border:none; border-collapse:separate; border-spacing: 0px 0px; font-size:large;}
        p {color:black;}
        div ul li {color:black;}
        div ol li {color:black;}
        div {color:black; }
        .underline {border-bottom: 1px solid !important; width: 100%; display: inline-block;}
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
