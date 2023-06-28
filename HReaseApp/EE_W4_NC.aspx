<%@ Page Title="NC State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_NC.aspx.vb" 
    Inherits="HReaseApp.EE_W4_NC" 
    MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" runat="Server">
    <div id ="DivTopMenu">
        <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>rate
    </div>
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" runat="Server">
    <div id="DivTabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>
    </div>
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" runat="Server">
    <script type="text/javascript">
        function singleyesone(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingleNoOne]').prop("checked", false);
            }
        }
        function singlenoone(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingleYesOne]').prop("checked", false);
            }
        }
        function singleyestwo(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingleNoTwo]').prop("checked", false);
            }
        }
        function singlenotwo(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingleYesTwo]').prop("checked", false);
            }
        }        
        function singleyesthree(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingleNoThree]').prop("checked", false);
            }
        }
        function singlenothree(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingleYesThree]').prop("checked", false);
            }
        }
        function singleyesfour(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingleNoFour]').prop("checked", false);
            }
        }
        function singlenofour(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingleYesFour]').prop("checked", false);
            }
        }

        function mfjyesone(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedJointlyNoOne]').prop("checked", false);
            }
        }
        function mfjnoone(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedJointlyYesOne]').prop("checked", false);
            }
        }
        function mfjyestwo(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedJointlyNoTwo]').prop("checked", false);
            }
        }
        function mfjnotwo(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedJointlyYesTwo]').prop("checked", false);
            }
        }
        function mfjyesthree(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedJointlyNoThree]').prop("checked", false);
            }
        }
        function mfjnothree(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedJointlyYesThree]').prop("checked", false);
            }
        }
        function mfjyesfour(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedJointlyNoFour]').prop("checked", false);
            }
        }
        function mfjnofour(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedJointlyYesFour]').prop("checked", false);
            }
        }
        function mfjyesfive(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedJointlyNoFive]').prop("checked", false);
            }
        }
        function mfjnofive(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedJointlyYesFive]').prop("checked", false);
            }
        }

        function mfsyesone(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedSeparatelyNoOne]').prop("checked", false);
            }
        }
        function mfsnoone(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedSeparatelyYesOne]').prop("checked", false);
            }
        }
        function mfsyestwo(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedSeparatelyNoTwo]').prop("checked", false);
            }
        }
        function mfsnotwo(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedSeparatelyYesTwo]').prop("checked", false);
            }
        }
        function mfsyesthree(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedSeparatelyNoThree]').prop("checked", false);
            }
        }
        function mfsnothree(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedSeparatelyYesThree]').prop("checked", false);
            }
        }
        function mfsyesfour(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedSeparatelyNoFour]').prop("checked", false);
            }
        }
        function mfsnofour(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedSeparatelyYesFour]').prop("checked", false);
            }
        }

        function hohyesone(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkHeadHouseholdNoOne]').prop("checked", false);
            }
        }
        function hohnoone(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkHeadHouseholdYesOne]').prop("checked", false);
            }
        }
        function hohyestwo(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkHeadHouseholdNoTwo]').prop("checked", false);
            }
        }
        function hohnotwo(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkHeadHouseholdYesTwo]').prop("checked", false);
            }
        }
        function hohyesthree(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkHeadHouseholdNoThree]').prop("checked", false);
            }
        }
        function hohnothree(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkHeadHouseholdYesThree]').prop("checked", false);
            }
        }
        function hohyesfour(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkHeadHouseholdNoFour]').prop("checked", false);
            }
        }
        function hohnofour(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkHeadHouseholdYesFour]').prop("checked", false);
            }
        }

        function ssyesone(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSurvivingSpouseNoOne]').prop("checked", false);
            }
        }
        function ssnoone(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSurvivingSpouseYesOne]').prop("checked", false);
            }
        }
        function ssyestwo(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSurvivingSpouseNoTwo]').prop("checked", false);
            }
        }
        function ssnotwo(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSurvivingSpouseYesTwo]').prop("checked", false);
            }
        }
        function ssyesthree(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSurvivingSpouseNoThree]').prop("checked", false);
            }
        }
        function ssnothree(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSurvivingSpouseYesThree]').prop("checked", false);
            }
        }
        function ssyesfour(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSurvivingSpouseNoFour]').prop("checked", false);
            }
        }
        function ssnofour(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSurvivingSpouseYesFour]').prop("checked", false);
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
                var len = document.getElementById("TextChar").value.length;
                var index = document.getElementById("TextChar").value.indexOf('.');

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
    </script>

   <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>North Carolina Form NC-4</b></h4>
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
                    <td style="width: 45%">
                        <p>
                            <b>PURPOSE</b> - Complete <b>Form NC-4</b> so that your employer can withhold the
                             correct amount of State income tax from your pay. <b>If you do not provide
                             an NC-4 to your employer, your employer is required to withhold
                             based on the filing status, “Single” with zero allowances.</b>
                        </p>
                        <p>
                            <b>FORM NC-4 EZ</b> - You may use Form NC4-EZ if you plan to claim either the
                             N.C. Standard Deduction or the N.C. Child Deduction Amount (but no other
                             N.C. deductions), and you do not plan to claim any N.C. tax credits
                        </p>
                        <p>
                            <b>FORM NC-4 NRA</b> - If you are a nonresident alien you must use Form NC-4
                             NRA. In general, a nonresident alien is an alien (not a U.S. citizen) who has not
                             passed the green card test or the substantial presence test. (See Publication
                             519, U.S. Tax Guide for Aliens, for more information on the green card test and
                             the substantial presence test.)
                        </p>
                        <p>
                            <b>FORM NC-4 BASIC INSTRUCTIONS</b> - Complete the NC-4 Allowance
                                Worksheet. The worksheet will help you determine your withholding
                                allowances based on federal and State adjustments to gross income
                                including the N.C. Child Deduction Amount, N.C. itemized deductions,
                                and N.C. tax credits. However, you may claim fewer allowances than
                                you are entitled to if you wish to increase the tax withheld during the tax
                                year. If your withholding allowances decrease, you must file a new NC-4
                                with your employer within 10 days after the change occurs. Exception:
                                When an individual ceases to be “Head of Household” after maintaining
                                the household for the major portion of the year, a new NC-4 is not required
                                until the next year.
                        </p>
                        <p>
                            <b>TWO OR MORE JOBS</b> - If you have more than one job, determine the total
                            number of allowances you are entitled to claim on all jobs using one Form
                            NC-4 Allowance Worksheet. Your withholding will usually be most accurate
                            when all allowances are claimed on the NC-4 filed for the higher paying job
                            and zero allowances are claimed for the other. You should also refer to the
                            “Multiple Jobs Table” to determine the additional amount to be withheld on
                            Line 2 of Form NC-4 (See page 5).
                        </p>
                    </td>
                    <td style="width:3%;"></td>
                    <td style="width: 47%; padding-right: 3px; vertical-align:top;">                        
                        <p>
                            <b>NONWAGE INCOME</b> - If you have a large amount of nonwage income,
                            such as interest or dividends, you should consider making estimated tax
                            payments using Form NC-40 to avoid underpayment of estimated tax
                            interest. Form NC-40 is available on the Department’s website at www.dornc.com.
                        </p>
                        <p>
                            <b>HEAD OF HOUSEHOLD</b> - Generally you may claim “Head of Household”
                            filing status on your tax return only if you are unmarried and pay more than
                            50% of the costs of keeping up a home for yourself and your dependent(s)
                            or other qualifying individuals.
                        </p>
                        <p>
                            <b>SURVIVING SPOUSE</b> - You may claim “Surviving Spouse” filing status only
                            if your spouse died in either of the two preceding tax years and you meet
                            the following requirements:
                        </p>
                        <ol>
                            <li>Your home is maintained as the main household of a child or stepchild
                            for whom you can claim a federal exemption; and</li>
                            <li>You were entitled to file a joint return with your spouse in the year of
                            your spouse’s death.</li>
                        </ol>
                        <p>
                            <b>MARRIED TAXPAYERS</b> - For married taxpayers, both spouses must agree
                            as to whether they will complete the NC-4 Allowance Worksheet based on
                            the filing status, “Married Filing Jointly” or “Married Filing Separately.”
                        </p>
                        <ul>
                            <li>Married taxpayers who complete the worksheet based on the filing
                            status, “Married Filing Jointly” should consider the sum of both
                            spouses’ income, federal and State adjustments to income, and State
                            tax credits to determine the number of allowances.</li>
                           
                            <li>Married taxpayers who complete the worksheet based on the filing
                            status, “Married Filing Separately” should consider only his or her
                            portion of income, federal and State adjustments to income, and State
                            tax credits to determine the number of allowances.</li>
                        </ul>
                        <p>
                            <b>All NC-4 forms are subject to review by the North Carolina Department
                            of Revenue. Your employer may be required to send this form to the
                            North Carolina Department of Revenue.</b>
                        </p>
                    </td>
                </tr>
            </table>

            <div class="row boxOne">
                <div class="col-md-12">
                    <p>
                        <b>CAUTION:</b> If you furnish an employer with an Employee’s Withholding Allowance Certificate that contains information which has no
                        reasonable basis and results in a lesser amount of tax being withheld than would have been withheld had you furnished reasonable
                        information, you are subject to a penalty of 50% of the amount not properly withheld.
                    </p>
                </div>

            </div>
        </div>
       
        <div id="PersonalAllowancesHeaderBar" class="well HRESlateBlue HRERewrap" style="text-align:center; max-height:100px;">
	        <span><b>PERSONAL ALLOWANCES WORKSHEET</b></span>
	        <img src="img/plus.png" class="instruction_toggle_btn1" style="float: right; width: 30px; max-height:100px; padding-bottom:10px;" />
        </div>

        <div id="PersonalAllowancesWorksheet" class="form-group instruction_toggle1" style="margin-right:5%;">
            <table id="PartIHeader" style="border-top:2px solid black; border-bottom: 2px solid black; font-size:x-large;">
                <tr>
                    <td style="width:90%"></td>
                    <td style="width:10%"></td>
                </tr>
                <tr>
                    <td colspan="1" style="text-align:center;">
                        <b>NC-4 Allowance Worksheet</b>
                    </td>
                    <td>
                        <b>Part I</b>
                    </td>
                </tr>
                
            </table>
            <br />
            <div>
                <p style="margin-left:5%">
                    Answer <b>all</b> of the following questions <b>for your filing status.</b>
                </p>
            </div>
            
            <div>
                <table style="width: 90%; margin-left: 5%; border: 2px solid black;">
                    <tr>
                        <td style="width:2%"></td>
                        <td style="width:3%"></td>
                        <td style="width:68%"></td>
                        <td style="width:12%"></td>
                        <td style="width:12%"></td>
                        <td style="width:3%"></td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="5">
                            <b>Single -</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            1.
                        </td>
                        <td colspan="1">
                            Will your N.C. itemized deductions from Page 3, Schedule 1 exceed $15,249?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkSingleYesOne" runat="server" Text="Yes&nbsp;&nbsp;" onclick="singleyesone(this)" />
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkSingleNoOne" runat="server" Text="No&nbsp;&nbsp;" onclick="singlenoone(this)" />
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            2.
                        </td>
                        <td colspan="1">
                            Will your N.C. Child Deduction Amount from Page 3, Schedule 2 exceed $2,499?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkSingleYesTwo" runat="server" Text="Yes&nbsp;&nbsp;" onclick="singleyestwo(this)" />
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkSingleNoTwo" runat="server" Text="No&nbsp;&nbsp;" onclick="singlenotwo(this)" />
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            3.
                        </td>
                        <td colspan="1">
                            Will you have federal adjustments or State deductions from income?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkSingleYesThree" runat="server" Text="Yes&nbsp;&nbsp;" onclick="singleyesthree(this)" />
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkSingleNoThree" runat="server" Text="No&nbsp;&nbsp;" onclick="singlenothree(this)" />
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            4.
                        </td>
                        <td colspan="1">
                            Will you be able to claim any N.C. tax credits or tax credit carryovers?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkSingleYesFour" runat="server" Text="Yes&nbsp;&nbsp;" onclick="singleyesfour(this)" />
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkSingleNoFour" runat="server" Text="No&nbsp;&nbsp;" onclick="singlenofour(this)" />
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>                    
                    <tr>
                        <td colspan="6">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="4">
                            If you answered "No" to all of the above, <b>STOP HERE</b> and enter <b>ZERO (0)</b> as total allowances on Form NC-4, Line 1. 
                            If you answered "Yes" to any of the above, you may choose to go to Page 2, Part II to determine if you qualify for 
                            additional allowances. Otherwise, enter <b>ZERO (0)</b> on Form NC-4, Line 1.
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                </table>
            </div>
            <br />
            <div>
                <table style="width: 90%; margin-left: 5%; border: 2px solid black;">
                    <tr>
                        <td style="width:2%"></td>
                        <td style="width:3%"></td>
                        <td style="width:68%"></td>
                        <td style="width:12%"></td>
                        <td style="width:12%"></td>
                        <td style="width:3%"></td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="5">
                            <b>Married Filing Jointly -</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            1.
                        </td>
                        <td colspan="1">
                            Will your N.C. itemized deductions from Page 3, Schedule 1 exceed $27,999?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedJointlyYesOne" runat="server" Text="Yes&nbsp;&nbsp;" onclick="mfjyesone(this)" />
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedJointlyNoOne" runat="server" Text="No&nbsp;&nbsp;" onclick="mfjnoone(this)"/>
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            2.
                        </td>
                        <td colspan="1">
                            Will your N.C. Child Deduction Amount from Page 3, Schedule 2 exceed $2,499?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedJointlyYesTwo" runat="server" Text="Yes&nbsp;&nbsp;" onclick="mfjyestwo(this)"/>
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedJointlyNoTwo" runat="server" Text="No&nbsp;&nbsp;" onclick="mfjnotwo(this)"/>
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            3.
                        </td>
                        <td colspan="1">
                            Will you have federal adjustments or State deductions from income?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedJointlyYesThree" runat="server" Text="Yes&nbsp;&nbsp;" onclick="mfjyesthree(this)"/>
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedJointlyNoThree" runat="server" Text="No&nbsp;&nbsp;" onclick="mfjnothree(this)" />
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            4.
                        </td>
                        <td colspan="1">
                            Will you be able to claim any N.C. tax credits or tax credit carryovers?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedJointlyYesFour" runat="server" Text="Yes&nbsp;&nbsp;" onclick="mfjyesfour(this)"/>
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedJointlyNoFour" runat="server" Text="No&nbsp;&nbsp;" onclick="mfjnofour(this)"/>
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            5.
                        </td>
                        <td colspan="1">
                            Will your spouse receive combined wages and taxable retirement benefits of
                            less than $10,250 or only retirement benefits not subject to N.C. income tax?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedJointlyYesFive" runat="server" Text="Yes&nbsp;&nbsp;" onclick="mfjyesfive(this)"/>
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedJointlyNoFive" runat="server" Text="No&nbsp;&nbsp;" onclick="mfjnofive(this)"/>
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>   
                    <tr>
                        <td colspan="6">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="4">
                            If you answered "No" to all of the above, <b>STOP HERE</b> and enter <b>ZERO (0)</b> as total allowances on Form NC-4, Line 1. 
                            If you answered "Yes" to any of the above, you may choose to go to Page 2, Part II to determine if you qualify for 
                            additional allowances. Otherwise, enter <b>ZERO (0)</b> on Form NC-4, Line 1.
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                </table>
            </div>
            <br />
            <div>
                <table style="width: 90%; margin-left: 5%; border: 2px solid black;">
                    <tr>
                        <td style="width:2%"></td>
                        <td style="width:3%"></td>
                        <td style="width:68%"></td>
                        <td style="width:12%"></td>
                        <td style="width:12%"></td>
                        <td style="width:3%"></td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="5">
                            <b>Married Filing Separately -</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            1.
                        </td>
                        <td colspan="1">
                            Will your portion of N.C. itemized deductions from Page 3, Schedule 1 exceed $15,249?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedSeparatelyYesOne" runat="server" Text="Yes&nbsp;&nbsp;" onclick="mfsyesone(this)" />
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedSeparatelyNoOne" runat="server" Text="No&nbsp;&nbsp;" onclick="mfsnoone(this)" />
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            2.
                        </td>
                        <td colspan="1">
                            Will your N.C. Child Deduction Amount from Page 3, Schedule 2 exceed $2,499?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedSeparatelyYesTwo" runat="server" Text="Yes&nbsp;&nbsp;" onclick="mfsyestwo(this)"/>
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedSeparatelyNoTwo" runat="server" Text="No&nbsp;&nbsp;" onclick="mfsnotwo(this)" />
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            3.
                        </td>
                        <td colspan="1">
                            Will you have federal adjustments or State deductions from income?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedSeparatelyYesThree" runat="server" Text="Yes&nbsp;&nbsp;" onclick="mfsyesthree(this)"/>
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedSeparatelyNoThree" runat="server" Text="No&nbsp;&nbsp;" onclick="mfsnothree(this)"/>
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            4.
                        </td>
                        <td colspan="1">
                            Will you be able to claim any N.C. tax credits or tax credit carryovers?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedSeparatelyYesFour" runat="server" Text="Yes&nbsp;&nbsp;" onclick="mfsyesfour(this)" />
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMarriedSeparatelyNoFour" runat="server" Text="No&nbsp;&nbsp;" onclick="mfsnofour(this)"/>
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="6">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="4">
                            If you answered "No" to all of the above, <b>STOP HERE</b> and enter <b>ZERO (0)</b> as total allowances on Form NC-4, Line 1. 
                            If you answered "Yes" to any of the above, you may choose to go to Page 2, Part II to determine if you qualify for 
                            additional allowances. Otherwise, enter <b>ZERO (0)</b> on Form NC-4, Line 1.
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                </table>
            </div>
            <br />
            <div>
                <table style="width: 90%; margin-left: 5%; border: 2px solid black;">
                    <tr>
                        <td style="width:2%"></td>
                        <td style="width:3%"></td>
                        <td style="width:68%"></td>
                        <td style="width:12%"></td>
                        <td style="width:12%"></td>
                        <td style="width:3%"></td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="5">
                            <b>Head of Household -</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            1.
                        </td>
                        <td colspan="1">
                            Will your N.C. itemized deductions from Page 3, Schedule 1 exceed $21,624?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkHeadHouseholdYesOne" runat="server" Text="Yes&nbsp;&nbsp;" onclick="hohyesone(this)" />
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkHeadHouseholdNoOne" runat="server" Text="No&nbsp;&nbsp;" onclick="hohnoone(this)" />
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            2.
                        </td>
                        <td colspan="1">
                            Will your N.C. Child Deduction Amount from Page 3, Schedule 2 exceed $2,499?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkHeadHouseholdYesTwo" runat="server" Text="Yes&nbsp;&nbsp;" onclick="hohyestwo(this)" />
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkHeadHouseholdNoTwo" runat="server" Text="No&nbsp;&nbsp;" onclick="hohnotwo(this)" />
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            3.
                        </td>
                        <td colspan="1">
                            Will you have federal adjustments or State deductions from income?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkHeadHouseholdYesThree" runat="server" Text="Yes&nbsp;&nbsp;" onclick="hohyesthree(this)" />
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkHeadHouseholdNoThree" runat="server" Text="No&nbsp;&nbsp;" onclick="hohnothree(this)" />
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            4.
                        </td>
                        <td colspan="1">
                            Will you be able to claim any N.C. tax credits or tax credit carryovers?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkHeadHouseholdYesFour" runat="server" Text="Yes&nbsp;&nbsp;" onclick="hohyesfour(this)" />
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkHeadHouseholdNoFour" runat="server" Text="No&nbsp;&nbsp;" onclick="hohnofour(this)" />
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>                    
                    <tr>
                        <td colspan="6">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="4">
                            If you answered "No" to all of the above, <b>STOP HERE</b> and enter <b>ZERO (0)</b> as total allowances on Form NC-4, Line 1. 
                            If you answered "Yes" to any of the above, you may choose to go to Page 2, Part II to determine if you qualify for 
                            additional allowances. Otherwise, enter <b>ZERO (0)</b> on Form NC-4, Line 1.
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                </table>
            </div>
            <br />
            <div>
                <table style="width: 90%; margin-left: 5%; border: 2px solid black;">
                    <tr>
                        <td style="width:2%"></td>
                        <td style="width:3%"></td>
                        <td style="width:68%"></td>
                        <td style="width:12%"></td>
                        <td style="width:12%"></td>
                        <td style="width:3%"></td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="5">
                            <b>Surviving Spouse -</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            1.
                        </td>
                        <td colspan="1">
                            Will your N.C. itemized deductions from Page 3, Schedule 1 exceed $27,999?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkSurvivingSpouseYesOne" runat="server" Text="Yes&nbsp;&nbsp;" onclick="ssyesone(this)" />
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkSurvivingSpouseNoOne" runat="server" Text="No&nbsp;&nbsp;" onclick="ssnoone(this)"/>
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            2.
                        </td>
                        <td colspan="1">
                            Will your N.C. Child Deduction Amount from Page 3, Schedule 2 exceed $2,499?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkSurvivingSpouseYesTwo" runat="server" Text="Yes&nbsp;&nbsp;" onclick="ssyestwo(this)" />
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkSurvivingSpouseNoTwo" runat="server" Text="No&nbsp;&nbsp;" onclick="ssnotwo(this)"/>
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            3.
                        </td>
                        <td colspan="1">
                            Will you have federal adjustments or State deductions from income?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkSurvivingSpouseYesThree" runat="server" Text="Yes&nbsp;&nbsp;" onclick="ssyesthree(this)"/>
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkSurvivingSpouseNoThree" runat="server" Text="No&nbsp;&nbsp;" onclick="ssnothree(this)"/>
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            4.
                        </td>
                        <td colspan="1">
                            Will you be able to claim any N.C. tax credits or tax credit carryovers?
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:checkbox ID="chkSurvivingSpouseYesFour" runat="server" Text="Yes&nbsp;&nbsp;" onclick="ssyesfour(this)"/>
                        </td>
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkSurvivingSpouseNoFour" runat="server" Text="No&nbsp;&nbsp;" onclick="ssnofour(this)"/>
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>                    
                    <tr>
                        <td colspan="6">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="4">
                            If you answered "No" to all of the above, <b>STOP HERE</b> and enter <b>ZERO (0)</b> as total allowances on Form NC-4, Line 1. 
                            If you answered "Yes" to any of the above, you may choose to go to Page 2, Part II to determine if you qualify for 
                            additional allowances. Otherwise, enter <b>ZERO (0)</b> on Form NC-4, Line 1.
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                </table>
            </div>          
            <hr />
            <table id="PartIIHeader" style="border-top:2px solid black; border-bottom: 2px solid black; font-size:x-large;">
                <tr>
                    <td style="text-align:center; width:100%;">
                        <b>NC-4 Part II</b>
                    </td>
                </tr>
            </table>
            <br />
            <table >
                <tr>
                    <td style="width:3%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:24%;"></td>
                    <td style="width:30%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:16%;"></td>
                    <td style="width:2%;"></td>                    
                    <td style="width:16%;"></td>
                    <td style="width:3%;"></td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        1.
                    </td>
                    <td colspan="5">
                        Enter your total estimated N.C. itemized deductions from Page 3, Schedule 1
                    </td>
                    <td colspan="1">
                        1.
                    </td>
                    <td colspan="1" style="float:right; text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo1" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        2.
                    </td>
                    <td colspan="2">
                        Enter the applicable<br />
                        N.C. standard deduction<br />
                        based on your filing status.
                    </td>
                    <td colspan="3">
                        $12,750 if Single<br />
                        $25,500 if Married Filing Jointly or Surviving Spouse<br />
                        $12,750 if Married Filing Separately<br />
                        $19,125 if Head of Household
                    </td>
                    <td colspan="1">
                        2.
                    </td>
                    <td colspan="1" style="float:right; text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo2" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        3.
                    </td>
                    <td colspan="5">
                        Subtract Line 2 from Line 1. If Line 1 is less than Line 2, enter ZERO (0)
                    </td>
                    <td colspan="1">
                        3.
                    </td>
                    <td colspan="1" style="float:right; text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo3" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        4.
                    </td>
                    <td colspan="5">
                        Enter an estimate of your total N.C. Child Deduction Amount from Page 3, Schedule 2
                    </td>
                    <td colspan="1">
                        4.
                    </td>
                    <td colspan="1" style="float:right; text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo4" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        5.
                    </td>
                    <td colspan="5">
                        Enter an estimate of your total federal adjustments to income and State deductions from 
                        federal adjusted gross income
                    </td>
                    <td colspan="1">
                        5.
                    </td>
                    <td colspan="1" style="float:right; text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo5" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        6.
                    </td>
                    <td colspan="5">
                        Add Lines 3, 4, and 5
                    </td>
                    <td colspan="1">
                        6.
                    </td>
                    <td colspan="1" style="float:right; text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo6" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        7.
                    </td>
                    <td colspan="3">
                        Enter an estimate of your nonwage income (such as dividends or interest)
                    </td>
                    <td colspan="1">
                        7.
                    </td>
                    <td colspan="1" style="float:right; margin-right:20px; text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo7" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        8.
                    </td>
                    <td colspan="3">
                        Enter an estimate of your State additions to federal adjusted gross
                        income
                    </td>
                    <td colspan="1">
                        8.
                    </td>
                    <td colspan="1" style="float:right; margin-right:20px; text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo8" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        9.
                    </td>
                    <td colspan="5">
                        Add Lines 7 and 8
                    </td>
                    <td colspan="1">
                        9.
                    </td>
                    <td colspan="1" style="float:right;text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo9" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        10.
                    </td>
                    <td colspan="5">
                        Subtract Line 9 from Line 6 <i>(Do not enter less than zero)</i>
                    </td>
                    <td colspan="1">
                        10.
                    </td>
                    <td colspan="1" style="float:right; text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo10" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        11.
                    </td>
                    <td colspan="5">
                        Divide the amount on Line 10 by $2,500 . Round down to whole number<br />
                        Ex. $3,900 ÷ $2,500 = 1.56 rounds down to 1
                    </td>
                    <td colspan="1">
                        11.
                    </td>
                    <td colspan="1" style="float:right;text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo11" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        12.
                    </td>
                    <td colspan="3">
                        Enter the amount of your estimated N.C. tax credits
                    </td>
                    <td colspan="1">
                        12.
                    </td>
                    <td colspan="1" style="float:right;text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo12" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="3">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        13.
                    </td>
                    <td colspan="5">
                        Divide the amount on Line 12 by $128. Round down to whole number<br />
                        Ex. $200 ÷ $128 = 1.56 rounds down to 1
                    </td>
                    <td colspan="1">
                        13.
                    </td>
                    <td colspan="1" style="float:right; text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo13" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        14.
                    </td>
                    <td colspan="6">
                        If filing as Single, Head of Household, or Married Filing Separately, enter zero (0) on this line. <br />
                        If filing as Surviving Spouse, enter 5 <br />
                        If filing as Married Filing Jointly, enter the appropriate number from either (a), (b), (c), (d), (e), or (f) below.
                        <br />
                    </td>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1">
                        (a)
                    </td>
                    <td colspan="4">
                        Your spouse expects to have combined wages and taxable retirement benefits of less than or equal to $250 
                        for N.C. purposes, enter 5. (Taxable retirement benefits do not include: Bailey, Certain Military Retirement,
                        Social Security, and Railroad retirement)
                    </td>
                    <td colspan="3">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1">
                        (b)
                    </td>
                    <td colspan="4">
                        Your spouse expects to have combined wages and taxable retirement benefits of more than $250 but less 
                        than or equal to $2,750, enter 4.
                    </td>
                    <td colspan="3">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1">
                        (c)
                    </td>
                    <td colspan="4">
                        Your spouse expects to have combined wages and taxable retirement benefits of more than $2,750 but 
                        less than or equal to $5,250, enter 3.
                    </td>
                    <td colspan="3">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1">
                        (d)
                    </td>
                    <td colspan="4">
                        Your spouse expects to have combined wages and taxable retirement benefits of more than $5,250 but 
                        less than or equal to $7,750, enter 2.
                    </td>
                    <td colspan="3">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1">
                        (e)
                    </td>
                    <td colspan="4">
                        Your spouse expects to have combined wages and taxable retirement benefits of more than $7,750 but 
                        less than or equal to $10,250, enter 1.
                    </td>
                    <td colspan="3">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1">
                        (f)
                    </td>
                    <td colspan="4">
                        Your spouse expects to have combined wages and taxable retirement benefits of more than
                        $10,250, enter 0.
                    </td>
                    <td colspan="1">
                        14.
                    </td>
                    <td colspan="1" style="float:right; text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo14" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        15.
                    </td>
                    <td colspan="5">
                        Add Lines 11, 13, and 14, and enter the total here.
                    </td>
                    <td colspan="1">
                        15.
                    </td>
                    <td colspan="1" style="float:right; text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo15" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        16.
                    </td>
                    <td colspan="5">
                        If you completed this worksheet on the basis of Married Filing Jointly, the total number of allowances determined
                        on Line 15 may be split between you and your spouse, however, you choose. Enter the number of allowances
                        from Line 15 that your spouse plans to claim.
                    </td>
                    <td colspan="1">
                        16.
                    </td>
                    <td colspan="1" style="float:right; text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo16" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                        17.
                    </td>
                    <td colspan="5">
                        Subtract Line 16 from Line 15 and enter the total number of allowances here and on Line 1 of your
                        <b>Form NC-4, Employee’s Withholding Allowance Certificate.</b>
                    </td>
                    <td colspan="1">
                        17.
                    </td>
                    <td colspan="1" style="float:right; text-align:center;" class="underline center">
                        $<asp:TextBox ID="TextPartTwo17" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="1">&nbsp;</td>
                </tr>
            </table>
            <hr />
            <table id="NC4AllowanceWorksheetSchedules" style="border-top:2px solid black; border-bottom: 2px solid black; font-size:x-large;">
                <tr>
                    <td style="text-align:center; width:100%;">
                        <b>NC-4 Allowance Worksheet Schedules</b>
                    </td>
                </tr>
            </table>
            <br />
            <div>
                Important: If you cannot reasonably estimate the amount to enter in the schedules below, you should enter ZERO (0) on Line 1, NC-4.
            </div>    
            <br />
            <div>
                <table style="width: 90%; margin-left: 5%; border: 2px solid black;">
                    <tr>
                        <td style="width:2%"></td>
                        <td style="width:30%"></td>
                        <td style="width:30%"></td>
                        <td style="width:16%"></td>
                        <td style="width:3%"></td>
                        <td style="width:16%"></td>
                        <td style="width:3%"></td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            <b>Schedule 1</b>
                        </td>
                        <td colspan="5">
                            <b>Estimated N.C. Itemized Deductions</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="2">
                            Qualifying mortgage interest
                        </td>
                        <td colspan="1" style="float:right; margin-right:20px; text-align:center;" class="underline center">
                            $<asp:TextBox ID="TextSchedule1One" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                        </td>
                        <td colspan="3">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="2">
                            Real estate property taxes
                        </td>
                        <td colspan="1" style="float:right; margin-right:20px; text-align:center;" class="underline center">
                            $<asp:TextBox ID="TextSchedule1Two" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                        </td>
                        <td colspan="3">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="3">
                            Total qualifying mortgage interest and real estate property taxes*
                        </td>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1" style="float:right; margin-right:20px; text-align:center;" class="underline center">
                            $<asp:TextBox ID="TextSchedule1Three" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="3">
                            Charitable Contributions (Same as allowed for federal purposes)
                        </td>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1" style="float:right; margin-right:20px; text-align:center;" class="underline center">
                            $<asp:TextBox ID="TextSchedule1Four" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="3">
                            Medical and Dental Expenses (Same as allowed for federal purposes)
                        </td>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1" style="float:right; margin-right:20px; text-align:center;" class="underline center">
                            $<asp:TextBox ID="TextSchedule1Five" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="3">
                            Repayment of Claim of Right Income
                        </td>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1" style="float:right; margin-right:20px; text-align:center;" class="underline center">
                            $<asp:TextBox ID="TextSchedule1Six" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="3">
                            Total estimated N.C. itemized deductions. Enter on Page 2, Part II, Line 1
                        </td>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1" style="float:right; margin-right:20px; text-align:center;" class="underline center">
                            $<asp:TextBox ID="TextSchedule1Seven" runat="server" Width="95%" CssClass="underline" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="5" >
                            *The sum of your qualified mortgage interest and real estate property taxes may not exceed $20,000. For married 
                            taxpayers, the $20,000 limitation applies to the combined total of qualified mortgage interest and real estate property 
                            taxes claimed by both spouses, rather than to each spouse separately.
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <div>
                <table style="width: 90%; margin-left: 5%; border: 2px solid black;">
                    <tr>
                        <td style="width:2%"></td>
                        <td style="width:20%"></td>
                        <td style="width:30%"></td>
                        <td style="width:16%"></td>
                        <td style="width:3%"></td>
                        <td style="width:16%"></td>
                        <td style="width:13%"></td>
                    </tr>
                    <tr >
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            <b>Schedule 2</b>
                        </td>
                        <td colspan="5">
                            <b>Estimated N.C. Child Deduction Amount</b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="5">
                            A taxpayer who is allowed a federal child tax credit under section 24 of the Internal Revenue Code is allowed a deduction
                            for each dependent child unless adjusted gross income exceeds the threshold amount shown below.
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="7">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="1">&nbsp;</td>
                        <td colspan="5">
                            The N.C. Child Deduction Amount can be claimed only for a child who is under 17 years of age on the last day of the year.
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="7">&nbsp;</td>
                    </tr>
                    <tr style="text-align: center; vertical-align:top;">
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1" style="font-weight: bold; ">
                            Filing Status<br />
                        </td>
                        <td colspan="1" style="font-weight: bold">
                            Adjusted Gross Income<br />
                        </td>
                        <td colspan="1" style="font-weight: bold">
                            No. of<br />
                            Children
                        </td>
                        <td colspan="1" style="font-weight: bold">
                            Deduction<br />
                            Amount per<br />
                            Qualifying Child<br />
                        </td>
                        <td colspan="1" style="font-weight: bold">
                            Estimated<br />
                            Deduction
                        </td>
                        <td colspan="1">&nbsp;</td>
                    </tr>
                    <tr style="text-align: center; vertical-align:top; min-height: 25px;">
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            Single
                        </td>
                        <td colspan="1">
                            <span>Up to $ 20,000</span><br />
                            <span>Over $ 20,000 Up to $ 30,000</span><br />
                            <span>Over $ 30,000 Up to $ 40,000</span><br />
                            <span>Over $ 40,000 Up to $ 50,000</span><br />
                            <span>Over $ 50,000 Up to $ 60,000</span><br />
                            <span>Over $ 60,000 Up to $ 70,000</span><br />
                            <span>Over $ 70,000</span>
                        </td>
                        <td colspan="1">
                            <span>
                                <asp:TextBox ID="TextSchedule2SingleChildren1" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2SingleChildren2" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2SingleChildren3" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2SingleChildren4" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2SingleChildren5" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2SingleChildren6" runat="server" ></asp:TextBox></span>
                            <span>
                                <asp:TextBox ID="TextSchedule2SingleChildren7" runat="server" ></asp:TextBox></span>
                        </td>
                        <td colspan="1">
                            <span>$ 3,000</span><br />
                            <span>$ 2,500</span><br />
                            <span>$ 2,000</span><br />
                            <span>$ 1,500</span><br />
                            <span>$ 1,000</span><br />
                            <span>$   500</span><br />
                            <span>$ -</span>
                        </td>

                        <td colspan="1">
                            <span>
                                <asp:TextBox ID="TextSchedule2SingleDeduction1" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2SingleDeduction2" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2SingleDeduction3" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2SingleDeduction4" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2SingleDeduction5" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2SingleDeduction6" runat="server" ></asp:TextBox></span>
                            <span>
                                <asp:TextBox ID="TextSchedule2SingleDeduction7" runat="server" ></asp:TextBox></span>
                        </td>
                    </tr>
                    <tr style="text-align: center; vertical-align:top; min-height: 25px;">
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                            MFJ or SS
                        </td>
                        <td>
                            <span>Up to $ 40,000</span><br />
                            <span>Over $ 40,000 Up to $ 60,000</span><br />
                            <span>Over $ 60,000 Up to $ 80,000</span><br />
                            <span>Over $ 80,000 Up to $ 100,000</span><br />
                            <span>Over $ 100,000 Up to $ 120,000</span><br />
                            <span>Over $ 120,000 Up to $ 140,000</span><br />
                            <span>Over $ 140,000</span>
                        </td>
                        <td>
                            <span>
                                <asp:TextBox ID="TextSchedule2MFJorSSChildren1" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFJorSSChildren2" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFJorSSChildren3" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFJorSSChildren4" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFJorSSChildren5" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFJorSSChildren6" runat="server" ></asp:TextBox></span>
                            <span>
                                <asp:TextBox ID="TextSchedule2MFJorSSChildren7" runat="server" ></asp:TextBox></span>
                        </td>
                        <td>
                            <span>$ 3,000</span><br />
                            <span>$ 2,500</span><br />
                            <span>$ 2,000</span><br />
                            <span>$ 1,500</span><br />
                            <span>$ 1,000</span><br />
                            <span>$   500</span><br />
                            <span>$ -</span>
                        </td>

                        <td>
                            <span>
                                <asp:TextBox ID="TextSchedule2MFJorSSDeduction1" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFJorSSDeduction2" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFJorSSDeduction3" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFJorSSDeduction4" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFJorSSDeduction5" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFJorSSDeduction6" runat="server" ></asp:TextBox></span>
                            <span>
                                <asp:TextBox ID="TextSchedule2MFJorSSDeduction7" runat="server" ></asp:TextBox></span>
                        </td>
                    </tr>
                    <tr style="text-align: center;vertical-align:top; min-height: 25px;">
                        <td colspan="1">&nbsp;</td>
                        <td>HOH
                        </td>
                        <td>
                            <span>Up to $ 30,000</span><br />
                            <span>Over $ 30,000 Up to $ 45,000</span><br />
                            <span>Over $ 45,000 Up to $ 60,000</span><br />
                            <span>Over $ 60,000 Up to $ 75,000</span><br />
                            <span>Over $ 75,000 Up to $ 90,000</span><br />
                            <span>Over $ 90,000 Up to $ 105,000</span><br />
                            <span>Over $ 105,000</span>
                        </td>
                        <td>
                            <span>
                                <asp:TextBox ID="TextSchedule2HOHSChildren1" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2HOHSChildren2" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2HOHSChildren3" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2HOHSChildren4" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2HOHSChildren5" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2HOHSChildren6" runat="server" ></asp:TextBox></span>
                            <span>
                                <asp:TextBox ID="TextSchedule2HOHSChildren7" runat="server" ></asp:TextBox></span>
                        </td>
                        <td>
                            <span>$ 3,000</span><br />
                            <span>$ 2,500</span><br />
                            <span>$ 2,000</span><br />
                            <span>$ 1,500</span><br />
                            <span>$ 1,000</span><br />
                            <span>$   500</span><br />
                            <span>$ -</span>
                        </td>

                        <td>
                            <span>
                                <asp:TextBox ID="TextSchedule2HOHDeduction1" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2HOHDeduction2" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2HOHDeduction3" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2HOHDeduction4" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2HOHDeduction5" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2HOHDeduction6" runat="server" ></asp:TextBox></span>
                            <span>
                                <asp:TextBox ID="TextSchedule2HOHDeduction7" runat="server" ></asp:TextBox></span>
                        </td>
                    </tr>
                    <tr style="text-align: center;vertical-align:top; min-height: 25px;">
                        <td colspan="1">&nbsp;</td>
                        <td>MFS
                        </td>
                        <td>
                            <span>Up to $ 20,000</span><br />
                            <span>Over $ 20,000 Up to $ 30,000</span><br />
                            <span>Over $ 30,000 Up to $ 40,000</span><br />
                            <span>Over $ 40,000 Up to $ 50,000</span><br />
                            <span>Over $ 50,000 Up to $ 60,000</span><br />
                            <span>Over $ 60,000 Up to $ 70,000</span><br />
                            <span>Over $ 70,000</span>
                        </td>
                        <td>
                            <span>
                                <asp:TextBox ID="TextSchedule2MFSChildren1" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFSChildren2" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFSChildren3" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFSChildren4" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFSChildren5" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFSChildren6" runat="server" ></asp:TextBox></span>
                            <span>
                                <asp:TextBox ID="TextSchedule2MFSChildren7" runat="server" ></asp:TextBox></span>
                        </td>
                        <td>
                            <span>$ 3,000</span><br />
                            <span>$ 2,500</span><br />
                            <span>$ 2,000</span><br />
                            <span>$ 1,500</span><br />
                            <span>$ 1,000</span><br />
                            <span>$   500</span><br />
                            <span>$ -</span>
                        </td>

                        <td>
                            <span>
                                <asp:TextBox ID="TextSchedule2MFSDeduction1" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFSDeduction2" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFSDeduction3" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFSDeduction4" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFSDeduction5" runat="server" ></asp:TextBox></span><br />
                            <span>
                                <asp:TextBox ID="TextSchedule2MFSDeduction6" runat="server" ></asp:TextBox></span>
                            <span>
                                <asp:TextBox ID="TextSchedule2MFSDeduction7" runat="server" ></asp:TextBox></span>
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <hr />
            <div id="DivLinktoRateTable" style="text-align:center;">
                <br />
                <a href="/Documents/Shared/W4NC_MultipleJobsTable.pdf" target="_blank">Multiple Jobs Table</a>
            </div>
            <hr />
        </div>

        <div id="DivFormHeader">
            <table>
                <tr>
                    <td style="width:30%;"></td>
                    <td style="width:70%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        <img src="images/NC_DOR_Logo.PNG" />  
                    </td>
                    <td colspan="1">
                        <h3><b>NC-4</b></h3> 
                        <h3><b>Employee's Withholding Allowance Certificate</b></h3>
                    </td>
                </tr>
            </table>
        </div>        

        <br />
        <div id="DivFormBody" style="margin-right:5%;">
            <table id="TopTwoQuestions">
                <tr>
                    <td style="width:2%;"></td>
                    <td style="width:90%;"></td>
                    <td style="width:1%;"></td>
                    <td style="width:7%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        <b>1.</b>
                    </td>
                    <td colspan="3">
                        <b>Total number of allowances you are claiming</b>
                    </td>
                </tr>
                <tr>
                    <td colspan ="1">&nbsp;</td>
                    <td colspan ="1">
                        <i>(Enter zero (0), or the number of allowances from Page 2, Line 17 of the NC-4 Allowance Worksheet)</i>
                    </td>
                    <td colspan ="1">&nbsp;</td>
                    <td colspan="1" style="float:right; margin-right:3px; min-width:100px;" class="underline center">
                        <asp:TextBox ID="TextTotalExemptions" runat="server" CssClass="underline center" onkeypress="return onlyNumbers()" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        <b>2.</b>
                    </td>
                    <td colspan="1">
                        <b>Additional amount, if any, withheld from each pay period</b> <i>(Enter whole dollars)</i>
                    </td>
                    <td colspan ="1">&nbsp;</td>
                    <td colspan="1" style="float:right; margin-right:3px; text-align:center; min-width:100px;" class="underline center">
                        <asp:TextBox ID="TextAdditionalWithholding" runat="server" CssClass="center" onkeypress="return onlyNumbers()" ></asp:TextBox>
                    </td>
                </tr>
            </table>
            <br />
            <table id="MainFormTable" style="width:100%; border: 2px solid black; padding: 2px; border-spacing: 0px 0px; padding: 3px 3px 3px 3px;" >
               <tr>
                    <td style="width:30%;"></td>
                    <td style="width:1%;"></td>
                    <td style="width:5%;"></td>
                    <td style="width:5%;"></td>
                    <td style="width:1%;"></td>
                    <td style="width:5%;"></td>
                    <td style="width:1%;"></td>
                    <td style="width:10%;"></td>
                    <td style="width:1%;"></td>
                    <td style="width:5%;"></td>
                    <td style="width:5%;"></td>
                </tr>
                <tr>
                    <td colspan="1">
                        <label>Social Security Number </label>
                    </td>
                    <td colspan="1">&nbsp;</td>
                    <td colspan="9" style="text-align:left; border-left:1px solid black;border-top:1px solid black;border-right:1px solid black; width:90%;">
                        <b><label>&nbsp; &nbsp; Filing Status  </label></b>
                      </td>
                </tr>
                <tr>
                    <td colspan="1" class="underline" style="min-width:100px;">
                        <b><asp:Label ID="LabelSSNumber" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                    <td colspan="1">&nbsp;</td>
                    <td colspan="9" style="text-align:left; border-left:1px solid black;border-bottom:1px solid black;border-right:1px solid black; background-color:white;">
                        &nbsp;<asp:RadioButton ID="chkSingle" runat="server" GroupName="Status" Text="&nbsp; Single or Married Filing Separately &nbsp;" TextWrapping="Wrap" Width="250" onclick="single(this)"/>&nbsp;&nbsp;&nbsp;
                        &nbsp;<asp:RadioButton ID="chkHeadOfHousehold" runat="server" GroupName="Status" Text="&nbsp; Head of Household &nbsp;" TextWrapping="Wrap" Width="170" onclick="hoh(this)"  />
                        &nbsp;<asp:RadioButton ID="chkMarried" runat="server" GroupName="Status" Text="&nbsp; Married Filing Jointly or Surviving Spouse &nbsp;" TextWrapping="Wrap" Width="300" onclick="married(this)" />&nbsp;                         
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="min-width:125px;">
                         <label>First Name <i>(USE CAPITAL LETTERS FOR YOUR NAME AND ADDRESS) </i></label>
                    </td>
                    <td colspan="1">&nbsp;</td>
                    <td colspan="1" style="min-width:50px;">
                        <label>M.I.</label>        
                    </td>
                    <td colspan="1">&nbsp;</td>
                    <td colspan="7" style="min-width:200px;">
                        <label>Last Name</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" class="underline" style="min-width:125px;">
                        <b><asp:Label ID="LabelFirstName" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                    <td colspan="1">&nbsp;</td>
                    <td colspan="1" class="underline" style="min-width:50px;">
                        <b><asp:Label ID="LabelMI" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                    <td colspan="1">&nbsp;</td>
                    <td colspan="7" class="underline" style="min-width:150px;">
                        <b><asp:Label ID="LabelLastName" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <label>Address</label>
                    </td>
                    <td colspan="7" style="text-align:left;">
                        <label>County</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" class="underline">
                        <b><asp:Label ID="LabelAddressCombined" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                    <td colspan="7"></td> 
                </tr>
                <tr>
                    <td colspan="1" >
                        <label>City</label>
                    </td>
                    <td colspan="1">&nbsp;</td>
                    <td colspan="1">
                        <label>State</label>
                    </td>
                    <td colspan="1">&nbsp;</td>
                    <td colspan="1">
                        <label>Zip Code </label>
                    </td>
                    <td colspan="1">&nbsp;</td>
                    <td colspan="3">
                        <label>Country <i>(If not U.S.)</i></label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="underline">
                        <b><asp:Label ID="LabelCity" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                    <td colspan="1">&nbsp;</td>
                    <td colspan="1" class="underline">
                        <b><asp:Label ID="LabelState" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                    <td colspan="1">&nbsp;</td>
                    <td colspan="1" class="underline" style="max-width:75px;">
                        <b><asp:Label ID="LabelZipCode" runat="server" Width="80%" CssClass="HRETan"></asp:Label></b>
                    </td>
                    <td colspan="1">&nbsp;</td>
                    <td colspan="3" class="underline" style="min-width:75px;">
                        <b><asp:Label ID="LabelCountryNotUS" runat="server" Width="50%" CssClass="HRETan"></asp:Label></b>
                    </td>
                </tr>
            </table>
            <br />
        </div>
        <div id="DivSignatureSection" style="margin-right:5%;">
            <table id="SignatureRow" style="width:100%;" class="HREWhite">
                <tr>
                    <td style="width:20%;"></td>
                    <td style="width:50%;"></td>
                    <td style="width:10%;"></td>
                    <td style="width:20%;"></td>
                </tr>
                <tr style="border-bottom: 3px solid black; height: 40px;">
                        <td colspan="2">
                              Employee’s Signature&nbsp;&nbsp;
                                <asp:TextBox ID="TextSignature" runat="server" Width="99%" placeholder="Enter your Full Name"  />
                        </td>
                        <td colspan="2" style="min-width:180px;">
                                Date &nbsp;&nbsp;
                                <asp:TextBox ID="SignatureDate" runat="server" Width="99%" CssClass="center"/>
                        </td>

                </tr>
                <tr>
                    <td colspan="4" style="vertical-align:top;">
                        I certify, under penalties provided by law, that I am entitled to the number of withholding allowances claimed on line 1 above.
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
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; display:inline; float: right;}
        table {background-color:white; color:black; border:none; border-collapse:separate; border-spacing: 0px 5px;}
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
