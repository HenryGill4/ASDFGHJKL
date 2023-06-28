<%@ Page Title="ME State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_ME.aspx.vb" 
    Inherits="HReaseApp.EE_W4_ME" 
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
                <h4><b>Maine Form W-4ME</b></h4>
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

        <div id="divInstructionTitle" class="well HRESlateBlue HRERewrap" style="text-align:center; padding-bottom:20px;">
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px;" />

        </div>

        <div id="divInstructions" class="instruction_toggle" style="margin-right:5%;">
            <table style="background-color:white; width:100%;">
               <tr>
                    <td style="width:47%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:47%;"></td>
                </tr>
               <tr>
                    <td colspan="3" style="font-size:x-large; text-align:center;">
                        <p class="spanundel" style="color:black; text-align: center; margin: 5px; font-size: 18px; font-weight: 700; text-decoration: underline;">
                            Employee/Payee Instructions
                            <br />
                        </p>
                    </td>
                </tr>
               <tr style="vertical-align:top;">
                    <td colspan ="1">
                        <p style="color:black;">
                            <b>Purpose: </b>Complete Form W-4ME so your employer/payer can withhold
                            the correct Maine income tax from your pay. Because your tax situation
                            may change, you may want to recalculate your withholding each year.
                        </p>
                        <p style="color:black;">
                            <b>Line 4. </b>If you qualify for one of the Maine exemptions from withholding,
                            complete lines 1, 2, 3 and 6, and sign the form. Otherwise, complete the
                            Personal Allowances worksheet above. You may claim fewer allowances
                            than you are entitled to, but you must fi le a Personal Withholding Allowance
                            Variance Certifi cate to obtain permission from the State Tax Assessor if you
                            want to claim more allowances than allowed on line E above.
                        </p>
                        <p style="color:black;">
                            <b>Box 3. </b>Select the marital status that applies to you. You must select the
                            same marital status you selected on your federal Form W-4, except that
                            married individuals have the option of withholding at the higher single rate
                            and if you selected married fi ling separately on your federal Form W-4, you
                            should select single. Nonresident aliens are required to check the single
                            box regardless of actual marital status.
                        </p>
                        <p style="color:black;">
                            <b>Line 6. Exemptions from withholding:</b>
                            <br />
                            <br />
                            <%--<span class="tagundel" style="text-decoration: underline;">Line 6a.</span>--%> 
                            <u>Line 6a.</u>You may check this box if you claimed “Exempt” on your federal
                            Form W-4. Do not check this box if you want Maine income taxes withheld
                            even though you are exempt from federal withholding.
                        </p>
                        <p style="color:black;">
                            <u>Line 6b.</u> You may check this box if you completed federal Form W-4P
                            and put a check in the box on line 1. Do not check this box if you want
                            Maine income taxes withheld even though you are exempt from federal
                            withholding.
                        </p>
                    </td>
                    <td colspan="1">

                    </td>
                    <td colspan="1">                            
                        <p style="color:black;">
                            <u>Line 6c. </u> You may elect this exemption if you are a resident employee
                            receiving wages and you meet both of the following conditions:
                            <br/>
                            <span style="padding-left: 15px;">1. You had <b>no</b> Maine income tax liability last year, <b>and</b> </span>
                            <br/>
                            <span style="padding-left: 15px;">2. You reasonably expect to have <b>no</b> Maine income tax liability this year.</span>
                            <br/>
                            This exemption will expire at the end of the year and you must complete a
				            new Form W-4ME for next year or you will be subject to Maine withholding
				            at the maximum rate.
                        </p>
                        <p style="color:black;">
                            <u>Line 6d. </u> You may elect this exemption if you receive periodic retirement
                            payments pursuant to IRC § 3405, you had no Maine income tax liability in
                            the prior year and you reasonably expect you will have no Maine income
                            tax liability this year. This election will remain in eff ect until you complete a
                            new Form W-4ME. 
                        </p>
                        <p style="color:black;">
                            <u>Line 6e. </u> If you are the spouse of a member of the military, you may claim
                                exemption from Maine withholding if you meet the following requirements:
                            <br />
                                <span style="padding-left: 15px;">1. Your spouse is a member of the military located in Maine in compliance with military orders.  </span>
                                <br/>
                                <span style="padding-left: 15px;">2.  You are in Maine solely to be with your spouse.  </span>
                                <br/>
                                <span style="padding-left: 15px;">3. You and your spouse have the same domicile in a state other than Maine.  </span>
                                <br/>
                                <span style="padding-left: 15px;">4. You attach a copy of your spouse’s latest Leave and Earning Statement refl ecting an assignment location in Maine.  </span>
                                <br/>
                                <span style="padding-left: 15px;">5. You present your military ID to your employer. The ID must identify you as a military spouse.  </span>
                                <br/>
                            Your exemption will expire at the end of the calendar year during which
                            you submit Form W-4ME claiming the exemption, at which time you must
                            complete and submit a new Maine Form W-4ME for the new year.    
                        </p>
                    </td>                    
                </tr>
                <tr>
                    <td colspan="3">                        
                        <p style="color:black;">
                            <b>Note: </b> You may be subject to penalty if you do not have sufficient withholding
                            to meet your Maine income tax liability.
                        </p>
                    </td>
                </tr>
            </table>

            <div class="col-md-12" style="padding-top: 5px; padding-bottom: 5px; background: #dcddde; border: 2px solid;">
                <p style="color:black; text-align: center; margin: 5px; font-size: 18px; font-weight: 700;">
                    Notice to Employers and Other Payers
                    <br />
                </p>
                <p style="color:black;">
                    Maine law requires employers and other persons to withhold money from certain payments, most commonly wages, retirement payments and
                    gambling winnings, and remit to Maine Revenue Services for application against the Maine income tax liability of employees and other payees.
                    The amount of withholding must be calculated according to the provisions of Rule No. 803 (See www.maine.gov/revenue/rules) and must
                    constitute a reasonable estimate of Maine income tax due on the receipt of the payment. Amounts withheld must be paid over to Maine Revenue
                    Services on a periodic basis as provided by Title 36 M.R.S. Chapter 827 (§§ 5250 - 5255-B) and Rule No. 803 (18-125 C.M.R., ch. 803).803 (18-125 C.M.R., ch. 803).
                </p>
            </div>
 
            <div class="col-md-12">
                <p class="spanundel" style="color:black; text-align: center; margin: 5px; font-size: 18px; font-weight: 700; text-decoration: underline; margin-top:15px;">
                    Employer/Payer Information for Completing Form W-4ME
                </p>
                <p style="color:black;">
                    An employer/payer is required to submit a copy of Form W-4ME, along with a copy of any supporting information provided by the employee/payee, to
                    Maine Revenue Services if:
                </p>

                <table style="background-color:white; ">
                    <tr>
                        <td style="width:5%;"></td>
                        <td style="width:95%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center;">
                            A.
                        </td>
                        <td colspan ="1">
                            The employer/payer is required to submit a copy of federal Form W-4 to the Internal Revenue Service either by written notice or by published
                            guidance as required by federal regulation 26 CFR 31.3402(f)(2)-1(g); or
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center;">
                            B.
                        </td>
                        <td colspan ="1">
                            An employee performing personal services in Maine furnishes a Form W-4ME to the employer containing a non-Maine address and, for any reason,
                            claims no Maine income tax is to be withheld. This submission is not required if the employer reasonably expects that the employee will earn annual
                            Maine-source income of less than $3,000 or if the employee is a nonresident working in Maine for no more than 12 days for the calendar year and
                            is, therefore, exempt from Maine income tax withholding.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            Submit copies of Form W-4ME directly to the MRS Withholding Unit separately from any other tax filing.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            Employers/Payers must complete lines 7 through 10 only if required to submit a copy of Form W-4ME to Maine Revenue Services. 
                        </td>
                    </tr>
                </table>
                <table style="background-color:white;">
                    <tr>
                        <td style="width:5%;"></td>
                        <td style="width:5%;"></td>
                        <td style="width:90%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center;">
                            <i class="fa fa-check" ></i>
                        </td>
                        <td colspan="1">
                            Line 7
                        </td>
                        <td colspan="1">
                            Enter employer/payer name and business address.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center;">
                            <i class="fa fa-check" style="text-align:right;"></i>
                        </td>
                        <td colspan="1">
                            Line 8
                        </td>
                        <td colspan="1">
                            Enter employer/payer federal identifi cation number (EIN and/or SSN).
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center;">
                            <i class="fa fa-check" style="text-align:right;"></i>
                        </td>
                        <td colspan="1">
                            Line 9
                        </td>
                        <td colspan="1">
                            Enter employer/payer contact person who can answer questions about withholding (i.e. human resources person, company offi cer,
                            accountant, etc.).
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center;">
                            <i class="fa fa-check" style="text-align:right;"></i>
                        </td>
                        <td colspan="1">
                            Line 10
                        </td>
                        <td colspan="1">
                            Enter employer/payer contact person’s phone number.
                        </td>
                    </tr>
                </table>
                
                <table style="background-color:white; border-top:2px solid black; border-bottom:2px solid black; margin-top: 10px; margin-bottom:20px;" >
                    <tr>
                        <td style="width:3%;"></td>
                        <td style="width:3%;"></td>
                        <td style="width:96%;"></td>
                    </tr>
                    <tr>
                        <td colspan ="3" >
                            <p class="spanundel" style="color:black; text-align: center; margin: 5px; font-size: 18px; font-weight: 700; text-decoration: underline; margin-top:15px;">
                                Important Information for Employers/Payers
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="3">
                            <b>Missing or invalid Forms W-4, W-4P or W-4ME.</b>If any of the circumstances below occur, the employer or payer must withhold as if the employee or
                            payee were single and claiming no allowances. Maine income tax must be withheld at this rate until such time that the employee or payee provides a valid
                            Form W4-ME.
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="1" style="text-align:center; vertical-align:top;">
                            (1)
                        </td>
                        <td colspan="2">
                            The employee/payee has not provided a valid, signed Form W-4ME;
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="1" style="text-align:center; vertical-align:top;">
                            (2)
                        </td>
                        <td colspan="2">
                             The employee’s/payee’s Form W-4 or W-4P is determined to be invalid for purposes of federal withholding;
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="1" style="text-align:center; vertical-align:top;">
                            (3)
                        </td>
                        <td colspan="2">
                            The Assessor notifies the employer/payer that the employee’s/payee’s Form W-4ME is invalid; or
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="1" style="text-align:center; vertical-align:top;">
                            (4)
                        </td>
                        <td colspan="2">
                            The employee’s/payee’s Personal Withholding Allowance Variance Certifi cate has expired, a new variance certificate has not been approved and
                            submitted to the employer/payer and the payee has not provided the payer with a valid Form W-4ME. 
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="3">
                            <b>Exemptions from withholding Form W-4ME, line 6.</b>Generally, employers/payers must withhold from payments subject to Maine income tax unless an
                            exemption is claimed on line 6.
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="1">
                        </td>
                        <td colspan ="2">
                            <b>Federal exemption from withholding</b> (lines 6a and 6b). An employee/payee who is exempt from federal income tax withholding is also exempt from
                            Maine income tax withholding. This includes recipients of periodic retirement payments who are exempt from federal income tax withholding. The
                            employee/payee must check the applicable box on line 6. An employee/payee exempt from federal withholding that wants Maine withholding must
                            leave line 6 blank.
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="1">
                        </td>
                        <td colspan ="2">
                            <b>Resident employee exemption from Maine withholding</b> (line 6c). A resident employee who is subject to federal income tax withholding is exempt
                            from Maine income tax withholding if the employee had no Maine tax liability for the prior year and expects to have no Maine tax liability for the current
                            year. The exemption on line 6c expires at the end of each year. If the employee fails to submit a new Form W-4ME for the next calendar year, the
                            employer must begin withholding at the single rate with no allowances.
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="1">
                        </td>
                        <td colspan ="2">
                            <b>Withholding from payments to nonresident employees.</b> An employee who is exempt from Maine income tax because of the nontaxable thresholds
                            applicable to nonresidents is not required to complete and submit Form W-4ME; however, an employee becomes subject to Maine income tax withholding
                            immediately upon exceeding a threshold at any time during the year. Because all income earned in Maine is taxable by Maine once a threshold is
                            exceeded, employers should work with aff ected employees to ensure that Maine withholding is adequate to cover Maine income tax liability for the year.
                            This may require the employee submitting a new Form W-4ME with the employer.
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="1">
                        </td>
                        <td colspan ="2">
                            <b>Withholding exemption for periodic retirement payments.</b>  (line 6d). Recipients of periodic retirement payments as defi ned by IRC § 3405 that are
                            subject to federal income tax withholding are exempt from Maine income tax withholding if the recipient certifi es (by checking the box on line 6d) that he
                            or she had no Maine income tax liability for the prior year and expects to have no Maine income tax liability for the current year. The exemption remains
                            in eff ect until the recipient submits an updated Form W-4ME.
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="1">
                        </td>
                        <td colspan ="2">
                            <b>Exemptions under the Military Spouse’s Residency Relief Act (MSRRA).</b> If the box on line 6e is checked, the employer must:
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="1">
                        </td>
                        <td colspan ="1" style="text-align:center;vertical-align:top;">
                            (1)
                        </td>
                        <td colspan="1">
                            Ensure that a copy of the military member’s Leave and Earnings Statement (LES) is attached, and verify that the assignment location entered
                            on the LES is a location in Maine; and
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="1">
                        </td>
                        <td colspan ="1" style="text-align:center;vertical-align:top;">
                            (2)
                        </td>
                        <td colspan="1">
                            Review the employee’s military ID to ensure that the date on the ID is not more than four years prior to the date on the employee’s Form W-4ME,
                            and that the ID denotes the employee as a current military spouse. 
                        </td>
                    </tr>
                    <tr>
                        <td colspan ="1">
                        </td>
                        <td colspan ="2">
                            An exemption claimed on line 6e expires at the end of the calendar year. If the employee does not submit a new Maine Form W-4ME, the employer
                            must begin withholding for the first pay period in the following year at the maximum rate (single with one allowance).
                            <br />
                            <br />
                            See the employee instructions for line 6e above for more information about this exemption.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <p style="color:black; text-align:right;">
                                Revised: December 2020
                            </p>
                        </td>
                    </tr>
                </table>
                
            </div>

        </div>

        <div id="MaineForm" style="margin-left:1%; margin-right:5%;">
            <table id="MaineFormHeader" style="width: 100%; background-color:white; margin-top: 20px; border-top: 0px solid transparent; border-right: 0px solid transparent; border-left: 0px solid transparent;">
                <tbody>
                    <tr style="width: 20%; height: 80px;">
                        <td colspan="7" style="border-right: 2px solid black; border-bottom:2px solid black;">
                            <div style="text-align: center; font-size: 20px; font-weight: bold;">
                                <b>FORM
								<br/>
                                    W-4ME
                                </b>
                            </div>
                        </td>
                        <td colspan="16" style="width: 60%; border-right: 2px solid black; border-bottom:2px solid black;">
                            <div style="text-align: center; line-height: 10px; margin-bottom: 20px;">
                                <h3 style="margin: 10px;">
                                    <b style="font-size: 30px; font-weight: 900;">MAINE </b>
                                </h3>
                                <div style="text-align: center; font-size: 20px; font-weight: 700;">
                                    Employee’s Withholding Allowance Certificate
                                </div>
                            </div>
                        </td>

                        <td colspan="7" style="width: 20%; border-bottom:2px solid black;">
                            &nbsp;		
                        </td>
                    </tr>
                </tbody>
            </table>
            
            <table id="MaineDemographicsandStatus" style="width: 100%; background-color:white; font-size:large;">
                <tr >
                    <td style="width: 3%;"></td>
                    <td style="width:27%;"></td>
                    <td style="width: 5%;"></td>
                    <td style="width: 5%;"></td>
                    <td style="width:30%;"></td>
                    <td style="width: 3%;"></td>
                    <td style="width:27%;"></td>
                </tr>
                <tr style="vertical-align:top; height:40px;">
                    <td colspan="1">
                        1.
                    </td>
                    <td colspan="1" style="vertical-align:top;">
                        Type or print your first name
                        <br />
                        <br />
                        <b style="background-color:#f5f5f0; padding-left:5px;"><asp:Label ID="lblFirstName" runat="server" Width="98%"/></b>
                    </td>
                    <td colspan="1">
                        M.I.
                        <br />
                        <br />
                        <b style="background-color:#f5f5f0; padding-left:5px;"><asp:Label ID="lblMiddleInit" runat="server" Width="98%"/></b>
                    </td>
                    <td colspan="2" style="border-right:1px solid black;">
                        Last name
                        <br />
                        <br />
                        <b style="background-color:#f5f5f0; padding-left:5px;"><asp:Label ID="lblLastName" runat="server" Width="98%"/></b>
                    </td>
                    <td colspan="2">
                        2. Your social security number
                        <br />
                        <br />
                        <b style="background-color:#f5f5f0; padding-left:5px;"><asp:Label ID="lblSSNumber" runat="server" Width="98%"/></b>
                    </td>
                </tr>
                
            </table>
            <table style="width: 100%; background-color:white; font-size:large;">
                <tr >
                    <td style="width: 3%;"></td>
                    <td style="width:30%;"></td>
                    <td style="width:10%;"></td>
                    <td style="width:10%;"></td>
                    <td style="width: 7%;"></td>
                    <td style="width:40%;"></td>
                </tr>
                <tr style="border-top:1px solid black;">
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="3" >
                        Home address (number and street or rural route)
                        <div>
                            <br />
                            <b style="background-color:#f5f5f0; padding-left:5px;"><asp:Label ID="lblAddressCombined" runat="server" Width="98%"/></b>
                        </div>
                    </td>
                    <td colspan="2" rowspan="2" style="border-top:1px solid black; border-left:1px solid black;">
                        <div style="padding-left: 2px;">
                            3.&nbsp;&nbsp;
                            <asp:CheckBox ID="chkSingle" runat="server" Autopostback="true" OnCheckedChanged="chkSingle_CheckedChanged"/>
                            &nbsp;&nbsp;Single&nbsp;&nbsp;
                            <asp:CheckBox ID="chkMarried" runat="server" Autopostback="true" OnCheckedChanged="chkMarried_CheckedChanged"/> 
                            &nbsp;&nbsp;Married
                        </div>
                        <div style="padding-left: 30px;">
                            <asp:CheckBox ID="chkMarriedWithhold" runat="server" Autopostback="true" OnCheckedChanged="chkMarriedWithhold_CheckedChanged"/>
                            &nbsp;&nbsp;Married, but withhold at higher Single rate
                            <br />
                            <small><b>Note:</b> If married but legally separated, or spouse is a nonresident
							    alien, check the single box.</small>
                        </div>
                    </td>
                </tr>
                <tr style="border-top:1px solid black;">
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1" >
                        City or town
                        <div>
                            <br />
                            <b style="background-color:#f5f5f0; padding-left:5px;"><asp:Label ID="lblCity" runat="server" Width="98%"/></b>
                        </div>
                    </td>
                    <td colspan="1">
                        State
                        <div>
                            <br />
                            <b style="background-color:#f5f5f0; padding-left:5px;"><asp:Label ID="lblState" runat="server" Width="98%"/></b>
                        </div>
                    </td>
                    <td colspan="1">
                        Zip
                        <div>
                            <br />
                            <b style="background-color:#f5f5f0; padding-left:5px;"><asp:Label ID="lblZipCode" runat="server" Width="98%"/></b>
                        </div>
                    </td>
                     <td colspan="2">
                    </td>
                </tr>
        </table>

        <table style="width: 100%; background-color:white; font-size:large; border-top:1px solid black;">
            <tr>
                <td style="width: 3%;"></td>
                <td style="width:72%;"></td>
                <td style="width: 5%;"></td>
                <td style="width:20%"></td>
            </tr>
            <tr style="height:40px; border-bottom:1px solid black;">
                <td>
                    4.
                </td>
                <td>
                    Total number of allowances you are claiming from line E of the personal allowances worksheet below 
                </td>
                <td style="text-align:right; border-right:1px solid black;">
                    4.&nbsp;
                </td>
                <td>
                    &nbsp;&nbsp;&nbsp;<asp:TextBox ID="txtTotalExemptions" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" Class="center" Width="90%" AutoPostBack="true"/>
                </td>
            </tr>
            <tr style="height:40px; border-bottom:1px solid black;">
                <td>
                    5.
                </td>
                <td>
                    Additional amount, if any, you want withheld from your paycheck
                </td>
                <td style="text-align:right; border-right:1px solid black;">
                    5.&nbsp;
                </td>
                <td>
                    &nbsp;$&nbsp;<asp:TextBox ID="txtAdditionalWithholding" runat="server" BackColor="#EFF3FB" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="90%"></asp:TextBox>
                </td>
            </tr>
         </table>
               
        <table style="width: 100%; background-color:white; font-size:large; border-bottom:1px solid black;">
            <tr>
                <td style="width: 3%;"></td>
                <td style="width: 3%;"></td>
                <td style="width: 85%;"></td>
                <td style="width: 3%;"></td>
                <td style="width: 6%;"></td>
            </tr>
                <tr>
                    <td colspan="1">
                        6.
                    </td>
                    <td colspan="4">
                        If you <b>do not want</b> any state income tax withheld, check the appropriate box that applies to you (you must qualify - see instructions below). By 
                        signing below, you certify that you qualify for the exemption that you select:
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1" >
                        a
                    </td>
                    <td colspan="1">
                        You claimed “Exempt” on your federal Form W-4 
                    </td>
                    <td colspan="1">
                        6a.
                    </td>
                    <td colspan="1">
                        <asp:CheckBox ID="chk6a" runat="server" Text="&nbsp;" AutoPostBack="true" OnCheckedChanged="chk6a_CheckedChanged" />
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1" >
                        b
                    </td>
                    <td colspan="1">
                        You completed federal Form W-4P and checked the box on line 1 
                    </td>
                    <td colspan="1">
                        6b.
                    </td>
                    <td colspan="1">
                        <asp:CheckBox ID="chk6b" runat="server" Text="&nbsp;" AutoPostBack="true" OnCheckedChanged="chk6b_CheckedChanged"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1" >
                        c
                    </td>
                    <td colspan="1">
                        You are a resident employee with no Maine tax liability in prior and current years
                    </td>
                    <td colspan="1">
                        6c.
                    </td>
                    <td colspan="1">
                        <asp:CheckBox ID="chk6c" runat="server" Text="&nbsp;" AutoPostBack="true" OnCheckedChanged="chk6c_CheckedChanged"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1" >
                        d
                    </td>
                    <td colspan="1">
                        You are a recipient of periodic retirement payments with no tax liability in prior and current years 
                    </td>
                    <td colspan="1">
                        6d.
                    </td>
                    <td colspan="1">
                        <asp:CheckBox ID="chk6d" runat="server" Text="&nbsp;" AutoPostBack="true" OnCheckedChanged="chk6d_CheckedChanged"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1" >
                        e
                    </td>
                    <td colspan="1">
                        Your spouse is a member of the military assigned to a location in Maine and you qualify for exemption under the Military
					    Spouse’s Residency Relief Act. You must attach supporting documents. See instructions
                    </td>
                    <td colspan="1">
                        6e.
                    </td>
                    <td colspan="1">
                        <asp:CheckBox ID="chkMilitarySpouseRelief" runat="server" Text="&nbsp;" AutoPostBack="true" OnCheckedChanged="chkMilitarySpouseRelief_CheckedChanged"/>
                    </td>
                </tr>
        </table>
        
            <table style="width: 100%; background-color:white; font-size:large; border-bottom:1px solid black;">
                <tr style="width: 100%">
                    <td colspan="30">Under penalties of perjury, I certify that I am entitled to the number of withholding allowances or the exemption claimed on this 
                        certificate.
                    </td>
                </tr>

                <tr style="width: 100%">
                    <td colspan="30">
                        <b>EMPLOYEE’S/PAYEE’S SIGNATURE</b>
                    </td>
                </tr>

                <tr style="width: 100%">
                    <td colspan="5" style="width: 20%;">(Form is not valid unless you sign it.) <i class="fa fa-caret-right" style="margin-left: 10px; font-size: 20px;"></i>
                    </td>
                    <td colspan="15" style="width: 50%; margin-top: 15px;">&nbsp;
                            <asp:TextBox ID="txtSignature" runat="server" placeholder="Signature" Style="width: 60%; padding-left:10px;"></asp:TextBox>
                    </td>
                    <td colspan="10" style="width: 30%;">Date <i class="fa fa-caret-right" style="margin-left: 5px; margin-right: 10px; font-size: 20px;"></i>
                        <asp:TextBox ID="txtSignatureDate" runat="server" Style="width: 60%; margin-bottom: 10px; padding-left:10px;"></asp:TextBox>
                    </td>
                </tr>
            </table>

            <table style="width: 100%; background-color:white; font-size:large; border-bottom:1px solid black;">
                    <tr style="width: 100%; height: 30px; border-bottom: 2px solid; border-top: 2px solid; background: #DCDDDE;">
                        <td colspan="30">
                            <b>TO BE COMPLETED BY EMPLOYER/PAYER</b>  (see Instructions)
                        </td>
                    </tr>

                    <tr style="width: 100%; height: 30px; border-bottom: 2px solid; border-top: 2px solid; background: #DCDDDE;">

                        <td colspan="20">
                            <div>
                                7. Employer/Payer Name and Address ( Employer/Payer: Complete lines 7, 8, 9, and 10 only if sending to Maine Revenue Services )
                                <br />
                                <b style="padding-left:10px;"><asp:Label ID="lblEmployerFullName" runat="server" Style="width: 50%; padding-left:10px;" ></asp:Label></b>
                                <br />
                                <b style="padding-left:10px;"><asp:Label ID="lblEmployerFullAddress" runat="server" Style="width: 40%; padding-left:10px;"></asp:Label></b>
                            </div>
                        </td>

                        <td colspan="10" style="border-left: 2px solid;">
                            <div>
                                8. Identification Number
                            </div>
                            <b><asp:Label ID="lblIdentificationNo" runat="server" Style="width: 95%;"></asp:Label></b>
                        </td>

                    </tr>

                    <tr style="width: 100%; height: 70px; border-bottom: 2px solid; border-top: 2px solid; background: #DCDDDE;">
                        <td colspan="20" style="border-right: 2px solid;">
                            <div>
                                9. Employer/Payer Contact Person: 
                            </div>
                            <asp:Label ID="lblContact" runat="server" Style="padding-left:10px;"></asp:Label>
                        </td>

                        <td colspan="10">
                            <div>
                                10. Contact Person’s Phone Number: 
                            </div>                          
                        </td>

                    </tr>

                    <tr style="width: 100%; height: 50px; font-size: 14px; text-align: center; font-weight: 700;">
                        <td colspan="30">
                            <p style="text-align: center; margin: 0;">
                            </p>
                        </td>
                    </tr>
            </table>

            <table style="width: 100%; background-color:white; font-size:large; border-bottom:1px solid black;">
                    <tr>
                        <td style="width:3%;"></td>
                        <td style="width:82%;"></td>
                        <td style="width:3%;"></td>
                        <td style="width:12%;"></td>
                    </tr>
                    <tr>
                        <td colspan="5" style="font-size:x-large; font-weight:bold; text-align:center">
                            Personal Allowances Worksheet - for line 4 above

                        </td>
                    </tr>

                    <tr >
                        <td colspan="1" >
                            A.
                        </td>
                        <td colspan="1">
                            Enter “1” for yourself if no one else can claim you as a dependent. 
                        </td>
                        <td colspan="1" >
                            A.
                        </td>
                        <td colspan="1">
						    <asp:TextBox ID="txtWorksheetA" runat="server" BackColor="#EFF3FB" onkeypress="return onlyNumbers()" Class="center" Width="95%"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valretxtWorksheetA" runat="server" CSSClass="red" ControlToValidate="txtWorksheetA" ValidationExpression="\b(1|0)\b" ErrorMessage="<b>Only 0 and 1 are Valid</b>" Display="Dynamic" />
                        </td>
                    </tr>
                    <tr >
                        <td colspan="1" >
                            B.
                        </td>
                        <td colspan="1">
                            Enter “1” for your spouse if you will fi le as married fi ling jointly. You may choose to enter “0” if you are married and have
                            either a working spouse or more than one job. (Entering “0” may help avoid having too little tax withheld)
                        </td>
                        <td colspan="1" >
                            B.
                        </td>
                        <td colspan="1">
						    <asp:TextBox ID="txtWorksheetB" runat="server" BackColor="#EFF3FB" onkeypress="return onlyNumbers()" Class="center" Width="95%"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valretxtWorksheetB" runat="server" CSSClass="red" ControlToValidate="txtWorksheetB" ValidationExpression="\b(1|0)\b" ErrorMessage="<b>Only 0 and 1 are Valid</b>" Display="Dynamic" />
                        </td>
                    </tr>
                    <tr >
                        <td colspan="1" >
                            C.
                        </td>
                        <td colspan="1">
                            Enter “1” if you will be fi ling as Head of Household.
                        </td>
                        <td colspan="1" >
                            C.
                        </td>
                        <td colspan="1">
						    <asp:TextBox ID="txtWorksheetC" runat="server" BackColor="#EFF3FB" onkeypress="return onlyNumbers()" Class="center" Width="95%"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valretxtWorksheetC" runat="server" CSSClass="red" ControlToValidate="txtWorksheetC" ValidationExpression="\b(1|0)\b" ErrorMessage="<b>Only 0 and 1 are Valid</b>" Display="Dynamic" />
                        </td>
                    </tr>
                    <tr >
                        <td colspan="1" >
                            D.
                        </td>
                        <td colspan="1">
                            Enter the number of children and dependents eligible for the federal child tax credit or the federal credit for other dependents.
                        </td>
                        <td colspan="1" >
                            D.
                        </td>
                        <td colspan="1">
						    <asp:TextBox ID="txtWorksheetD" runat="server" BackColor="#EFF3FB" onkeypress="return onlyNumbers()" Class="center" Width="95%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr >
                        <td colspan="1" >
                            E.
                        </td>
                        <td colspan="1">
                            Add lines A through D. (Maximum number of allowances you may claim).
                        </td>
                        <td colspan="1" >
                            E.
                        </td>
                        <td colspan="1">
						    <asp:TextBox ID="txtWorksheetE" runat="server" BackColor="#EFF3FB" onkeypress="return onlyNumbers()" Class="center" Width="95%"></asp:TextBox>
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
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; content: "X"; color: black;}
        ol { list-style-type: lower-roman; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; color:black; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HREUnderLine {border-bottom:1px solid black;        }
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
        .HRELabel {background-color: #f5f5f0; font-size: large; vertical-align:bottom;}
        .HREBlack {color: black;}
    </style>
</asp:Content>

