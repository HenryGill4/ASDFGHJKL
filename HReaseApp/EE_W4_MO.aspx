<%@ Page Title="MO State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_MO.aspx.vb" 
    Inherits="HReaseApp.EE_W4_MO" 
    MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" runat="Server">
    <div id="tabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>
    </div>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainArticle" runat="Server">
    <script type="text/javascript">
        function onlyNumbers(evt) {
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
        function disableinput() {
            return false;
        }
    </script>

    <div class="HREwrapper">
        <div id="PageTitle">
            <div>
                <br />
                <h4><b>Missouri Form MO W-4</b></h4>
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

        <div id="Instructions" class="form-group instruction_toggle HREWhite" style="margin-right:5%;border-top: 2px solid; border-bottom: 2px solid black;">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <p style="margin-top: 10px; margin-bottom: 10px;">
                    <b>Notice To Employer: </b>
                    <br />
                    Within 20 days of hiring a new employee, a copy of the Employee’s Withholding Certificate (Form MO W-4) must be submitted by one of the following methods: 
                    
                </p>
                <ul>
                    <li>
                        <b>Email: </b>withholding@dor.mo.gov
                        
                    </li>
                    <li>
                        <b>Fax: </b>(573) 526-8079 
                    </li>
                    <li>
                        <b>Mail to: </b>Missouri Department of Revenue
                        <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P.O.BOX 3340
                        <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Jefferson City, MO 65105-3340
                    </li>
                </ul>
                <p>
                    Please visit <a href="http://dss.mo.gov/child-support/employers/new-hire-reporting.htm" style="font-weight: bold;">http://dss.mo.gov/child-support/employers/new-hire-reporting.htm</a> for additional information regarding new hire reporting.
                </p>
                <p style="margin-top: 10px; margin-bottom: 10px;">
                    <b>Notice To Employee: </b>
                    <br />
                    Return completed form to your Employer. Consider completing a new Form MO W-4 each year and when your personal or financial situation changes. Visit our online 
                    withholding calculator <a href="https://mytax.mo.gov/rptp/portal/home/withholding-calculator" style="font-weight: bold;">https://mytax.mo.gov/rptp/portal/home/withholding-calculator</a> 
                    
                </p>
                <p style="margin-top: 10px;">
                    <b>Items to Remember: </b>
                </p>
                <ul>
                    <li>
                        Employees must complete a new form if their filing status changes or to adjust the amount of withholding. 
                    </li>
                    <li>
                        If you are claiming an “Exempt” status due to the Military Spouses Residency Relief Act you must provide one of the following to your employer: Leave 
                        and Earnings Statement of the non-resident military servicemember, Form W-2 issued to the nonresident military servicemember, a military
                        identification card, or specific military orders received by the servicemember. You must also provide verification of residency such as a copy of
                        your state income tax return filed in your state of residence, a property tax receipt from the state of residence, a current drivers license, vehicle 
                        registration or voter ID card. For additional assistance in regard to Military, visit the department’s website
                        <a href="https://dor.mo.gov/military/" style="font-weight: bold;">https://dor.mo.gov/military/</a>.
                    </li>
                    <li>
                        Additional information can be found at <a href="https://dor.mo.gov/business/withhold/" style="font-weight: bold;">https://dor.mo.gov/business/withhold/</a>.
                    </li>
                </ul>
                <table style="padding-bottom:10px; margin-bottom:10px; border-top: 1px solid black; border-left:none; border-right:none;">
                    <tr>
                        <td style="width:5%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:20%;"></td>
                        <td style="width:30%;"></td>
                        <td style="width:35%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1"></td>
                        <td colspan="1">
                            <b>Mail to:</b>
                        </td>
                        <td colspan="1">
                            Taxation Division
                        </td>
                        <td colspan="1">
                            <b>Phone: </b>(573) 522-0967
                        </td>
                        <td colspan="1" style="text-align:right; font-size:small; vertical-align:top;">
                            Form MO W-4 (Revised 05-2021)
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"></td>
                        <td colspan="1">
                            P.O. Box 3340
                        </td>
                        <td colspan="2">
                            <b>Fax: </b> (573) 526-8079
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"></td>
                        <td colspan="1">
                            Jefferson City, MO 65105-3340
                        </td>
                        <td colspan="2"></td>
                    </tr>
                </table>
           </div>

        </div>

        <div id="MainForm" style="margin-right:5%;" >
            <div id="MainFormHeader">
                <table style="color:black; border:none; border-collapse:separate; border-spacing: 10px 10px;">
                    <tr>
                        <td style="width:10%;"></td>
                        <td style="width:90%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1" rowspan="3" style="vertical-align:bottom;">
                            <img src="images/MO_State_Logo.png" />
                        </td>
                        <td colspan="1">
                            <img src="images/MO_DeptofRevenue_Logo.png" /> 
                            <br />
                        </td>                        
                    </tr>
                    <tr style="padding:5px 10px 5px 10px;">
                        <td colspan="1">
                            <span class=" underline" style="font-size:x-large;">
                                <b>Employee’s Withholding Certificate</b>
                            </span>
                        </td>
                    </tr>
                    <tr style="padding:5px;">
                        <td colspan="1">
                            <span style="font-size:small;">
                                This certificate is for income tax withholding and child support enforcement purposes only. Type or print
                            </span>  
                        </td>
                    </tr>
                    
                </table>
            </div>
  
            <div id="EmployeeMainBlock" class="HREWhite" style="width:100%; border:none;">
                <table style="width: 100%; font-size:medium; height:100px; border:none;">
                    <tbody>
                        <tr>
                            <td style="width:2.5%;"></td>
                            <td style="width:.5%;"></td>
                            <td style="width:97%;"></td>
                        </tr>
                        <tr>
                            <td colspan="1" style="background: black;">
                                <div>
                                    <p style="text-align: center; height:20%; writing-mode: vertical-rl; color: white; -webkit-transform: rotate(180deg); font-weight: 700;">
                                        Employee
                                    </p>
                                </div>
                            </td>
                            <td colspan="1">
                                &nbsp;
                            </td>
                            <td colspan="1" style="vertical-align:top"> 
                                <table style="width: 100%; font-size:medium; border:1px solid black;" class="HRETan">
                                    <tr>
                                        <td style="width:40%"></td>
                                        <td style="width:30%"></td>
                                        <td style="width:10%"></td>
                                        <td style="width:20%"></td>
                                    </tr>
                                    <tr style="font-size: medium;">
                                        <td colspan="2" style="vertical-align:top;border-right:1px solid black;">
                                            Full Name 
                                        </td>
                                        <td colspan="2" style="vertical-align:top;">
                                            Social Security Number 
                                        </td>
                                    </tr>
                                    <tr style="font-size: medium;">
                                        <td colspan="2" style="vertical-align:top; border-right:1px solid black; border-bottom:1px solid black;">
                                            <b><asp:Label ID="lblFullName" runat="server"></asp:Label></b>
                                        </td>
                                        <td colspan="2" style="vertical-align:top;  border-bottom:1px solid black;">
                                            <b><asp:Label  ID="lblSSNumber" runat="server"></asp:Label></b>
                                        </td>
                                    </tr>
                                    <tr style="font-size: medium;">
                                        <td colspan="1" style="vertical-align:top; border-right:1px solid black;">
                                            Home Address (Number and Street or Rural Route)
                                        </td>
                                        <td colspan="1" style="vertical-align:top; border-right:1px solid black;">
                                            City or Town 
                                        </td>
                                        <td colspan="1" style="vertical-align:top; border-right:1px solid black;">
                                            State
                                        </td>
                                        <td colspan="1" style="vertical-align:top;">
                                            ZIP Code
                                        </td>
                                    </tr>
                                    <tr style="font-size: medium;">
                                        <td colspan="1" style="vertical-align:top; border-right:1px solid black;">
                                            <b><asp:Label  ID="lblFullAddress" runat="server" ></asp:Label></b>
                                        </td>
                                        <td colspan="1" style="vertical-align:top; border-right:1px solid black;">
                                            <b><asp:Label  ID="lblCity" runat="server" ></asp:Label></b>
                                        </td>
                                        <td colspan="1" style="vertical-align:top; border-right:1px solid black;">
                                            <b><asp:Label  ID="lblState" runat="server"></asp:Label></b>
                                        </td>
                                        <td colspan="1" style="vertical-align:top;">
                                            <b><asp:Label  ID="lblZipCode" runat="server"></asp:Label></b>
                                        </td>
                                    </tr>
                                </table>

                                <table style="width: 100%; margin-top: 20px; border: 1px solid black;">
                                    <tbody>
                                        <tr>
                                            <td style="width:2%"></td>
                                            <td style="width:2%"></td>
                                            <td style="width:79%"></td>
                                            <td style="width:2%"></td>
                                            <td style="width:15%"></td>
                                        </tr>
                                        <tr style="vertical-align:top;">
                                             <td colspan="1">
                                                 <b> 1.</b>
                                             </td>
                                            <td colspan="2">
                                                Filing Status: Check the appropriate filling status below.
                                            </td>
                                            <td colspan="1" style="border-left:1px solid black; border-right:1px solid black;">
                                                &nbsp;
                                            </td>
                                            <td colspan="1">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="1"></td>
                                            <td colspan="1" style="text-align:right;">
                                                <asp:CheckBox ID="chkSingle" runat="server" AutoPostBack="true" OnCheckedChanged="chkSingle_CheckedChanged"/>
                                            </td>
                                            <td colspan="1">
                                                Single or Married Spouse Works or Married Filing Separate  &nbsp;
                                                <asp:CheckBox ID="chkMarried" runat="server" Style="background-color: #EFF3FB; font-weight: normal;" AutoPostBack="true" OnCheckedChanged="chkMarried_CheckedChanged"/>
                                                     &nbsp;Married (Spouse does not work) &nbsp;
                                            </td>
                                            <td colspan="1" style="border-left:1px solid black; border-right:1px solid black;">
                                                &nbsp;
                                            </td>
                                            <td colspan="1">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="1"></td>
                                            <td colspan="1" style="text-align:right;">
                                                <asp:CheckBox ID="chkHOH" runat="server" Style="background-color: #EFF3FB; font-weight: normal;" AutoPostBack="true" OnCheckedChanged="chkHOH_CheckedChanged"/>
                                            </td>
                                            <td colspan="1">Head of Household </td>
                                            <td colspan="1" style="border-left:1px solid black; border-right:1px solid black;">
                                                &nbsp;
                                            </td>
                                            <td colspan="1">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                            <td colspan="1" style="border-left:1px solid black; border-right:1px solid black;"></td>
                                            <td colspan="1"></td>
                                        </tr>
                                        <tr style="vertical-align:top;">
                                             <td colspan="1">
                                                 <b> 2.</b>
                                             </td>
                                            <td colspan="2" style="text-align:left;">
                                                Additional withholding: If you expect to have a balance due (as a result of interest income, dividends, income from a
                                                part-time job, etc.) on your tax return, you may request your employer to withhold an additional amount of tax from each
                                                pay period. To calculate the amount needed, divide the amount of the expected tax by the number of pay periods in a 
                                                year. Enter the additional amount to be withheld each pay period on line 2.
                                            </td>
                                            <td colspan="1" style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black; vertical-align:bottom;">
                                                &nbsp;<b>2.</b>&nbsp;
                                            </td>
                                            <td colspan="1" style="padding-bottom:5px; border-bottom:1px solid black; vertical-align:bottom;">
                                                <asp:TextBox ID="txtAdditionalWithholding" runat="server" Style="display: inline;" placeholder="" Class="center" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                            <td colspan="1" style="border-left:1px solid black; border-right:1px solid black;"></td>
                                            <td colspan="1"></td>
                                        </tr>
                                        <tr style="vertical-align:top;">
                                             <td colspan="1">
                                                 <b> 3.</b>
                                             </td>
                                            <td colspan="2" style="text-align:left;">
                                                Reduced withholding: If you expect to receive a refund (as a result of itemized deductions, modifications or tax credits) 
                                                on your tax return, you may direct your employer to only withhold the amount indicated on line 3. Your employer
                                                will not use the standard calculations for withholding. If you designate an amount that is too low, it could result in you 
                                                being under withheld. To calculate the amount needed, divide the amount of your expected tax by the number of pay 
                                                periods in a year. Enter the amount to be withheld instead of the standard calculation. If no amount is indicated on
                                                line 3, the standard calculations will be used.
                                            </td>
                                            <td colspan="1" style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black; vertical-align:bottom;">
                                                &nbsp;<b>3.</b>&nbsp;
                                            </td>
                                            <td colspan="1" style="padding-bottom:5px; border-bottom:1px solid black; vertical-align:bottom;">
                                                <asp:TextBox ID="txtReducedWithholding" runat="server" Style="display: inline;" placeholder="" cssclass="center" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                            <td colspan="1" style="border-left:1px solid black; border-right:1px solid black;"></td>
                                            <td colspan="1"></td>
                                        </tr>
                                        <tr style="vertical-align:top;">
                                             <td colspan="1">
                                                 <b> 4.</b>
                                             </td>
                                        <td colspan="2" style="text-align:left;">
                                                Exempt Status: Select the appropriate reason you are claiming an exemption from withholding below and indicate 
                                                EXEMPT on line 4.
                                            </td>
                                            <td colspan="1" style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black; vertical-align:bottom;">
                                                &nbsp;<b>4.</b>&nbsp;
                                            </td>
                                            <td colspan="1" style="padding-bottom:5px; border-bottom:1px solid black; vertical-align:bottom;">
                                                <asp:TextBox ID="txtExempt" runat="server" Style="display: inline;" placeholder="" cssclass="center" AutoPostBack="true" OnTextChanged="txtExempt_TextChanged"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="valretxtExempt" runat="server" CSSClass="red" ControlToValidate="txtExempt" ValidationExpression="\b(EXEMPT|exempt|Exempt)\b" ErrorMessage="<b>Only the word EXEMPT is valid</b>" Display="Dynamic" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="1"></td>
                                            <td colspan="1" style="text-align:right; vertical-align:top;">
                                                <asp:CheckBox ID="chkExemptNoLiability" runat="server" Style="display: inline;" placeholder="" Text="" AutoPostBack="true" OnCheckedChanged="chkExemptNoLiability_CheckedChanged"></asp:CheckBox>
                                            </td>
                                            <td colspan="1">
                                                I am exempt because I had a right to a refund of all Missouri income tax withheld last year and expect to have no tax liability 
                                                this year. A new MO W-4 must be completed annually if you wish to continue the exemption.
                                            </td>
                                            <td colspan="1" style="border-left:1px solid black; border-right:1px solid black;">
                                               &nbsp;
                                            </td>
                                            <td colspan="1"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="1"></td>
                                            <td colspan="1" style="text-align:right; vertical-align:top;">
                                                <asp:CheckBox ID="chkSpouseRelief" runat="server" Style="display: inline;" placeholder="" AutoPostBack="true" OnCheckedChanged="chkSpouseRelief_CheckedChanged"></asp:CheckBox>
                                            </td>
                                            <td colspan="1">
                                                I am exempt because I meet the conditions set forth under the Servicemember Civil Relief Act, as amended by the 
                                                Military Spouses Residency Relief Act and have no Missouri tax liability.
                                            </td>
                                            <td colspan="1" style="border-left:1px solid black; border-right:1px solid black;">
                                               &nbsp;
                                            </td>
                                            <td colspan="1"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="1"></td>
                                            <td colspan="1" style="text-align:right; vertical-align:top;">
                                                <asp:CheckBox ID="chkActiveDutyMilitary" runat="server" Style="display: inline;" placeholder="" AutoPostBack="true" OnCheckedChanged="chkActiveDutyMilitary_CheckedChanged"></asp:CheckBox>
                                                
                                            </td>
                                            <td colspan="1">
                                                I am exempt because my income is earned as a member of any active duty component of the Armed Forces of the 
                                                United States and I am eligible for the military income deduction.
                                            </td>
                                            <td colspan="1" style="border-left:1px solid black; border-right:1px solid black;">
                                               &nbsp;
                                            </td>
                                            <td colspan="1"></td>
                                        </tr>
                                        
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div id="SignatureBlock" class="HREWhite" style="width:100%; border:none;">
                <table style="width: 100%; font-size:medium; height:100px; border:none;">
                    <tbody>
                        <tr>
                            <td style="width:2.5%;"></td>
                            <td style="width:.5%;"></td>
                            <td style="width:97%;"></td>
                        </tr>
                        <tr>
                            <td colspan="1" style="background: black;">
                                <div>
                                    <p style="text-align: center; height:10%; writing-mode: vertical-rl; color: white; -webkit-transform: rotate(180deg); font-weight: 700;">
                                        Signature
                                    </p>
                                </div>
                            </td>
                            <td colspan="1">&nbsp;
                            </td>
                            <td colspan="1" style="vertical-align:top"> 
                                <table style="width: 100%; margin-top: 10px; border:none;">
                                    <tbody>
                                        <tr>
                                            <td style="width:70%"></td>
                                            <td style="width:30%"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" style="vertical-align:top;">
                                                <p>
                                                    Under penalties of perjury, I certify that I am entitled to the number of withholding allowances claimed on this certificate, or I am entitled to claim exempt status. 
                                                </p>
                                            </td>
                                        </tr>
                                        <tr >
                                            <td colspan="1" style="border:1px solid black;">
                                                Employee’s Signature (Form is not valid unless you sign it)
                                                <asp:TextBox ID="txtSignature" runat="server" Style="display: inline; width: 100%;"></asp:TextBox>
                                            </td>
                                            <td colspan="1" style="border:1px solid black;">
                                                Date 
                                                <asp:TextBox ID="SignatureDate" runat="server" Style="width: 100%;"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div id="EmployerInfo" class="HRETan" style="width:100%; border:none;">
                <table style="width: 100%; font-size:medium; height:100px; border:none;">
                    <tbody>
                        <tr>
                            <td style="width:2.5%;"></td>
                            <td style="width:.5%;"></td>
                            <td style="width:97%;"></td>
                        </tr>
                        <tr>
                            <td style="background: black;">
                                <div>
                                    <p style="text-align: center; height:10%; writing-mode: vertical-rl; color: white; -webkit-transform: rotate(180deg); font-weight: 700;">
                                        Employer
                                 </p>
                                </div>
                             </td>
                             <td>
                             </td>
                             <td colspan="1" style="vertical-align:top"> 
                                <table class="HRETan" style="width: 100%; margin-top: 10px; border:1px solid black;">
                                    <tbody>
                                        <tr>
                                            <td style="width:40%"></td>
                                            <td style="width:10%"></td>
                                            <td style="width:20%"></td>
                                            <td style="width:5%"></td>
                                            <td style="width:25%"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="1" style="vertical-align:top; border-right:1px solid black;">
                                                Employer’s Name
                                            </td>
                                            <td colspan="4" style="vertical-align:top;">
                                                Employer’s Address
                                            </td>
                                        </tr>
                                        <tr style="font-size: medium;">
                                            <td colspan="1" style="vertical-align:top; border-right:1px solid black; border-bottom:1px solid black;">
                                                <b><asp:Label  ID="lblEmployerName" runat="server" Style="display: inline; width: 100%;"> </asp:Label></b>
                                            </td>
                                            <td colspan="4" style="vertical-align:top;  border-bottom:1px solid black;">
                                                <b><asp:Label  ID="lblEmployerFullAddress" runat="server" Style="display: inline; width: 100%;" placeholder="" CssClass=""></asp:Label></b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="1" style="vertical-align:top; border-right:1px solid black;">
                                                City
                                            </td>
                                            <td colspan="2" style="vertical-align:top; border-right:1px solid black;">
                                                State
                                            </td>
                                            <td colspan="2">
                                                Zip Code
                                            </td>
                                        </tr>
                                        <tr style="font-size: medium;">
                                            <td colspan="1" style="vertical-align:top; border-right:1px solid black; border-bottom:1px solid black;">
                                                <b><asp:Label  ID="lblEmployerCity" runat="server" Style="display: inline; width: 100%;" placeholder="" CssClass=""></asp:Label></b>
                                            </td>
                                            <td colspan="2" style="vertical-align:top; border-right:1px solid black; border-bottom:1px solid black;">
                                                <b><asp:Label  ID="lblEmployerState" runat="server" Style="display: inline; width: 100%;" placeholder="" CssClass=""></asp:Label></b>
                                            </td>
                                            <td colspan="2" style="vertical-align:top;  border-bottom:1px solid black;">
                                                <b><asp:Label  ID="lblEmployerZipCode" runat="server" Style="display: inline; width: 100%;" placeholder="" CssClass=""></asp:Label></b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"  style="vertical-align:top; border-right:1px solid black;">
                                                Date Services for Pay First Performed by Employee (MM/DD/YYYY)
                                            </td>
                                            <td colspan="2"  style="vertical-align:top; border-right:1px solid black;">
                                                Federal Employer I.D. Number
                                            </td>
                                            <td colspan="1">
                                                Missouri Tax Identification Number
                                            </td>
                                        </tr>
                                        <tr style="font-size: medium;">
                                            <td colspan="2" style="vertical-align:top; border-right:1px solid black; border-bottom:1px solid black;">
                                                <b><asp:Label  ID="lblEmployerDate" runat="server" Style="display: inline; width: 100%;" placeholder="" CssClass=""></asp:Label></b>
                                            </td>
                                            <td colspan="2" style="vertical-align:top; border-right:1px solid black; border-bottom:1px solid black;">
                                                <b><asp:Label  ID="lblEmployerIDNumber" runat="server" Style="display: inline; width: 100%;" placeholder="" CssClass=""></asp:Label></b>
                                            </td>
                                            <td colspan="1" style="vertical-align:top;  border-bottom:1px solid black;">
                                                <b><asp:Label  ID="lblEmployerTaxNumber" runat="server" Style="display: inline; width: 100%;" placeholder="" CssClass=""></asp:Label></b>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
    
        <div id="divFormFooter" class="row">
            <br />
            <div style="float:right; padding-right:10px;">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valw4" OnClick="btnSave_Click"/>
                <br /><br /><br /><br />
            </div>
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
        input[type=text], textarea {outline: none; min-height: 20px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 20px; height: 20px; cursor: pointer; background: #f0f4fa; display: inline-block; padding-left:3px; padding-right: 3px; color: black;}
        input[type="label"] {background-color: #f5f5f0;}
        table {background-color:white; color:black; border:2px solid black; border-collapse:separate; border-spacing: 0px 0px;}
        p {color:black;}
        ul li {color:black;}
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
