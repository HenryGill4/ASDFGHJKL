<%@ Page Title="MD State Withholding Page" 
    Language="vb" AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_MD.aspx.vb" 
    Inherits="HReaseApp.EE_W4_MD"
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
        function single(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedSingle]').prop("checked", false);
                $('input:checkbox[id$=chkMarried]').prop("checked", false);
            }
        }
        function married(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingle]').prop("checked", false);
                $('input:checkbox[id$=chkMarriedSingle]').prop("checked", false);
            }
        }
        function marriedsingle(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingle]').prop("checked", false);
                $('input:checkbox[id$=chkMarried]').prop("checked", false);
            }
        }
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
    </script>

    <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>Maryland Form MW507</b></h4>
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
                    <td colspan="3" style="border-bottom: 2px solid black;">
                        <p style="font-size: 20px; font-weight: 900;">
                            MARYLAND
                            <br/>
                            FORM
                        </p>
                        <p style="font-size: 35px; font-weight: 900;">
                            MW507
                        </p> 
                    </td>
                </tr>
                <tr>
                    <td colspan ="1" style="vertical-align:top;">                                  
                        <p>
                            <b>Purpose.</b> Complete Form MW507 so that your employer can withhold the correct Maryland income tax from your pay. Consider completing a new Form MW507
                                each year and when your personal or financial situation changes.
                        </p>
                        <p>
                            <b>Basic Instructions.</b> Enter on line 1 below, the number of personal exemptions
                                you will claim on your tax return. However, if you wish to claim more exemptions,
                                or if your adjusted gross income will be more than $100,000 if you are filing
                                single or married filing separately ($150,000, if you are filing jointly or as head
                                of household), you must complete the Personal Exemption Worksheet on page
                                2. Complete the Personal Exemption Worksheet on page 2 to further adjust your
                                Maryland withholding based on itemized deductions, and certain other expenses
                                that exceed your standard deduction and are not being claimed at another job or
                                by your spouse. However, you may claim fewer (or zero) exemptions.
                        </p>
                        <p>
                            <b>Additional withholding per pay period under agreement with employer.</b> If
                                you are not having enough tax withheld, you may ask your employer to withhold
                                more by entering an additional amount on line 2.
                        </p>
                        <p>
                            <b>Exemption from withholding.</b>You may be entitled to claim an exemption from
                                the withholding of Maryland income tax if:
                        </p>
                        <ol style="list-style: none;">
                            <li>a. Last year you did not owe any Maryland Income tax and had a right to a full
                                refund of any tax withheld; AND,</li>
                            <li>b. This year you do not expect to owe any Maryland income tax and expect to have
                                a right to a full refund of all income tax withheld.</li>
                        </ol>
                        <p>
                            If you are eligible to claim this exemption, complete Line 3 and your employer will
                            not withhold Maryland income tax from your wages.
                        </p>
                        <p>
                            Students and Seasonal Employees whose annual income will be below the minimum
                            filing requirements should claim exemption from withholding. This provides
                            more income throughout the year and avoids the necessity of filing a Maryland
                            income tax return.
                        </p>
                        <p>
                            <b>Certification of nonresidence in the State of Maryland.</b>Complete Line 4. This
                                line is to be completed by residents of the District of Columbia, Virginia or West
                                Virginia who are employed in Maryland and who do not maintain a place of abode
                                in Maryland for 183 days or more.
                        </p>
                        <p>
                            Residents of Pennsylvania who are employed in Maryland and who do not maintain
                            a place of abode in Maryland for 183 days or more, should complete line 5 to exempt
                            themselves from the state portion of the withholding tax. These employees
                            are still liable for withholding tax at the rate in effect for the Maryland county in
                            which they are employed, unless they qualify for an exemption on either line 6 or
                            line 7. Pennsylvania residents of York and Adams counties may claim an exemption
                            from the local withholding tax by completing line 6. Pennsylvania residents
                            living in other local jurisdictions which do not impose an earnings or income tax
                            on Maryland residents may claim an exemption by completing line 7. Employees
                            qualifying for exemption under 6 or 7, should also write “EXEMPT” on line 4.
                        </p>
                        <p>
                            Line 4 is <b>NOT</b> to be used by residents of other states who are working in Maryland,
                            because such persons are liable for Maryland income tax and withholding from
                        </p>
                    </td>
                    <td style="width:3%;"></td>
                    <td style="width: 47%; padding-right: 3px; vertical-align:top;">      
                        <p>their wages is required.</p>
                        <p>
                            If you are domiciled in the District of Columbia, Pennsylvania or Virginia and maintain
                            a place of abode in Maryland for 183 days or more, you become a statutory
                            resident of Maryland and you are required to file a resident return with Maryland
                            reporting your total income. You must apply to your domicile state for any tax
                            credit to which you may be entitled under the reciprocal provisions of the law. If
                            you are domiciled in West Virginia, you are not required to pay Maryland income
                            tax on wage or salary income, regardless of the length of time you may have
                            spent in Maryland.
                        </p>

                        <p>
                            Under the Servicemembers Civil Relief Act, as amended by the Military Spouses
                            Residency Relief Act, you may be exempt from Maryland income tax on your
                            wages if (i) your spouse is a member of the armed forces present in Maryland in
                            compliance with military orders; (ii) you are present in Maryland solely to be with
                            your spouse; and (iii) you maintain your domicile in another state. If you claim
                            exemption under the SCRA enter your state of domicile (legal residence) on Line
                            8; enter “EXEMPT” in the box to the right on Line 8; and attach a copy of your
                            spousal military identification card to Form MW507. <b>In addition, you must also
                            complete and attach Form MW507M.</b>
                        </p>
                        <p>
                            <b>Duties and responsibilities of employer.</b> Retain this certificate with your records.
                                You are required to submit a copy of this certificate and accompanying
                                attachments to the Compliance Division, Compliance Programs Section, 301 West
                                Preston Street, Baltimore, MD 21201, when received if:
                        </p>
                        <ol>
                            <li>You have any reason to believe this certificate is incorrect;</li>                            
                            <li>The employee claims more than 10 exemptions;</li>
                            <li>The employee claims an exemption from withholding because he/she had no tax liability for the preceding tax year, expects to incur no tax liability this year and the wages are expected to exceed $200 a week;</li>
                            <li>The employee claims an exemption from withholding on the basis of nonresidence;or</li>
                            <li>The employee claims an exemption from withholding under the Military Spouses Residency Relief Act. </li>

                        </ol>
                        <p>
                            Upon receipt of any exemption certificate (Form MW507), the Compliance Division
                            will make a determination and notify you if a change is required.
                        </p>
                        <p>
                            Once a certificate is revoked by the Comptroller, the employer must send any new
                            certificate from the employee to the Comptroller for approval before implementing
                            the new certificate.
                        </p>
                        <p>
                            If an employee claims exemption under 3 above, a new exemption certificate must
                            be filed by February 15th of the following year.
                        </p>
                        <p>
                            <b>Duties and responsibilities of employee.</b> If, on any day during the calendar
                            year, the number of withholding exemptions that the employee is entitled to claim
                            is less than the number of exemptions claimed on the withholding exemption certificate
                            in effect, the employee must file a new withholding exemption certificate
                            with the employer within 10 days after the change occurs.
                        </p>
                    </td>
                </tr>
            </table>
        </div>

        <div id="PersonalAllowancesHeaderBar" class="well HRESlateBlue HRERewrap" style="text-align:center; max-height:100px;">
	        <span><b>PERSONAL ALLOWANCES WORKSHEET</b></span>
	        <img src="img/plus.png" class="instruction_toggle_btn1" style="float: right; width: 30px; max-height:100px; padding-bottom:10px;" />
        </div>

        <div id="PersonalAllowancesWorksheet" class="form-group instruction_toggle1" style="margin-right:5%;">
            <table style ="width: 100%">
                <tr>
                    <td style="width:5%;"></td>
                    <td style="width:80%;"></td>
                    <td style="width:5%;"></td>
                    <td style="width:10%;"></td>
                </tr>
                <tr>
                    <td colspan="4" style="border-bottom: 2px solid black; width: 100%;">
                        <p style="font-size: 20px; font-weight: 900;">
                            MARYLAND
                            <br/>
                            FORM
                        </p>
                        <p style="font-size: 35px; font-weight: 900;">
                            MW507
                        </p> 
                    </td>
                </tr>
                <tr style ="width: 100%">
                    <td style="width: 4%; vertical-align: top;">
                        <b>a.</b>
                    </td>
                    <td style="width: 76%">Multiply the number of your personal exemptions by the value of each exemption from the table below.
                        (Generally the value of your exemption will be $3,200; however, if your federal adjusted gross income is
                        expected to be over $100,000, the value of your exemption may be reduced.  <b>Do not claim any personal
                        exemptions you currently claim at another job, or any exemptions being claimed by your spouse.</b>
                                                To qualify as your dependent, you must be entitled to an exemption for the dependent on your federal
                        income tax return for the corresponding tax year. <b>NOTE:</b> Dependent taxpayers may not claim themselves as
                        an exemption
                    </td>
                    <td style="width: 18%; vertical-align: bottom;">a.
                        <asp:TextBox ID="TextEWOneFirst" runat="server" Style="width: 80%;" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>

                <tr style ="width: 100%">
                    <td style="width: 4%; vertical-align: top;">
                        <b>b.</b>
                    </td>
                    <td style="width: 76%">Multiply the number of additional exemptions you are claiming for dependents age 65 or over by the value of
                        each exemption from the table below
                    </td>
                    <td style="width: 18%; vertical-align: bottom;">b.
                        <asp:TextBox ID="TextEWTwoFirst" runat="server" Style="width: 80%;" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>

                <tr style ="width: 100%">
                    <td style="width: 4%; vertical-align: top;">
                        <b>c.</b>
                    </td>
                    <td style="width: 76%">Enter the estimated amount of your itemized deductions (excluding state and local income taxes) that
                        exceed the amount of your standard deduction, alimony payments, allowable childcare expenses, qualified
                        retirement contributions, business losses and employee business expenses for the year. Do not claim any
                        additional amounts you currently claim at another job or any amounts being claimed by your spouse. <b>NOTE:</b>
                                                Standard deduction allowance is 15% of Maryland adjusted gross income with a minimum of $1,500 and a
                        maximum of $2,250
                    </td>
                    <td style="width: 18%; vertical-align: bottom;">c.
                        <asp:TextBox ID="TextEWThreeFirst" runat="server" Style="width: 80%;" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>

                <tr style ="width: 100%">
                    <td style="width: 4%; vertical-align: top;">
                        <b>d.</b>
                    </td>
                    <td style="width: 76%">Enter $1,000 for additional exemptions for taxpayer and/or spouse age 65 or over and/or blind. . . . . . . . . .
                    </td>
                    <td style="width: 18%; vertical-align: bottom;">d.
                        <asp:TextBox ID="TextEWFourFirst" runat="server" Style="width: 80%;" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>

                <tr style ="width: 100%">
                    <td style="width: 4%; vertical-align: top;">
                        <b>e.</b>
                    </td>
                    <td style="width: 76%">Add total of lines <b>a</b> through <b>d</b>
                    </td>
                    <td style="width: 18%; vertical-align: bottom;">e.
                        <asp:TextBox ID="TextEWFiveFirst" runat="server" Style="width: 80%;" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>

                <tr style ="width: 100%">
                    <td style="width: 4%; vertical-align: top;">
                        <b>f.</b>
                    </td>
                    <td style="width: 76%">Divide the amount on line e by $3,200. <b>Drop any fraction. Do not round up.</b>  This is the <b>maximum</b>
                        number of exemptions you may claim for withholding tax purposes
                    </td>
                    <td style="width: 18%; vertical-align: bottom;">f.
                        <asp:TextBox ID="TextBox1" runat="server" Style="width: 80%;" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <hr />
            <table class="table-bordered UserTable" style="width: 100%; table-layout: fixed;">
                <tr style="width: 100%;">
                    <td class="doletTablecss" rowspan="2" colspan="2">If your federal AGI is</td>
                    <td class="doletTablecss" colspan="4" style="padding: 20px 0px;">If you will file your tax return</td>
                </tr>
                <tr style="width: 100%;">
                    <td class="" colspan="2" style="text-align: center; font-size: 20px; /* padding: 40px 0px 10px 0px; */
                        vertical-align: text-bottom;">Single or Married Filing Separately<br/>
                        <b class="doletTablecss">Your Exemption is</b></td>
                    <td class="" colspan="2" style="text-align: center; font-size: 20px;">Joint, Head of Household
                        or Qualifying Widow(er)<br/>
                        <b class="doletTablecss">Your Exemption is</b>
                    </td>
                </tr>

                <tr style="width: 100%;">
                    <td class="doletTablecss" colspan="2" style="padding: 20px 0px 5px;">$100,000 or less </td>
                    <td class="doletTablecss" colspan="2" style="padding: 20px 0px 5px;">$3,200</td>
                    <td class="doletTablecss" colspan="2" style="padding: 20px 0px 5px;">$3,200</td>
                </tr>

                <tr style="width: 100%;">
                    <td class="doletTablecss" colspan="1" style="padding: 20px 0px 5px;">Over</td>
                    <td class="doletTablecss" colspan="1" style="padding: 20px 0px 5px;">But not over</td>
                    <td class="doletTablecss" colspan="2" style="background: #D1D2D4;">&nbsp;</td>
                    <td class="doletTablecss" colspan="2" style="background: #D1D2D4;">&nbsp;</td>
                </tr>
                <tr style="width: 100%;">
                    <td class="doletTablecss" colspan="1" style="padding: 20px 0px 5px;">$100,000 </td>
                    <td class="doletTablecss" colspan="1" style="padding: 20px 0px 5px;">$125,000 </td>
                    <td class="doletTablecss" colspan="2" style="padding: 20px 0px 5px;">$1,600 </td>
                    <td class="doletTablecss" colspan="2" style="padding: 20px 0px 5px;">$3,200</td>
                </tr>
                <tr style="width: 100%;">
                    <td class="doletTablecss" colspan="1" style="padding: 20px 0px 5px;">$125,000 </td>
                    <td class="doletTablecss" colspan="1" style="padding: 20px 0px 5px;">$150,000 </td>
                    <td class="doletTablecss" colspan="2" style="padding: 20px 0px 5px;">$800 </td>
                    <td class="doletTablecss" colspan="2" style="padding: 20px 0px 5px;">$3,200</td>
                </tr>
                <tr style="width: 100%;">
                    <td class="doletTablecss" colspan="1" style="padding: 20px 0px 5px;">$150,000 </td>
                    <td class="doletTablecss" colspan="1" style="padding: 20px 0px 5px;">$175,000</td>
                    <td class="doletTablecss" colspan="2" style="padding: 20px 0px 5px;">$0 </td>
                    <td class="doletTablecss" colspan="2" style="padding: 20px 0px 5px;">$1,600</td>
                </tr>
                <tr style="width: 100%;">
                    <td class="doletTablecss" colspan="1" style="padding: 20px 0px 5px;">$175,000</td>
                    <td class="doletTablecss" colspan="1" style="padding: 20px 0px 5px;">$200,000</td>
                    <td class="doletTablecss" colspan="2" style="padding: 20px 0px 5px;">$0 </td>
                    <td class="doletTablecss" colspan="2" style="padding: 20px 0px 5px;">$800</td>
                </tr>
                <tr style="width: 100%;">
                    <td class="doletTablecss" colspan="2" style="padding: 20px 0px 5px;">In excess of $200,000</td>
                    <td class="doletTablecss" colspan="2" style="padding: 20px 0px 5px;">$0</td>
                    <td class="doletTablecss" colspan="2" style="padding: 20px 0px 5px;">$0</td>
                </tr>
                <tr style="width: 100%;">
                    <td colspan="6" style="border-top:1px solid black; border-bottom:1px solid black; font-weight:bold; text-align:center;">
                        <h3><b>FEDERAL PRIVACY ACT INFORMATION</b></h3>
                    </td>
                </tr>
                <tr style="width: 100%;">
                    <td colspan="6" style="border-top:1px solid black; border-bottom:1px solid black;">
                        <p style="font-size: 18px;">
                            Social Security numbers must be included. The mandatory disclosure of your Social Security number is
                            authorized by the provisions set forth in the Tax-General Article of the Annotated Code of Maryland. Such
                            numbers are used primarily to administer and enforce the individual income tax laws and to exchange
                            income tax information with the Internal Revenue Service, other states and other tax officials of this state.
                            Information furnished to other agencies or persons shall be used solely for the purpose of administering tax
                            laws or the specific laws administered by the person having statutory right to obtain it.
                        </p>
                    </td>
                </tr>
            </table>
            <hr />
        </div>
       
        <div id="DivFormHeader">
            <table>
                <tr>
                    <td style="width:30%;"></td>
                    <td style="width:70%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:middle;">                        
                        <span style="font-weight: bold; margin-left: 69px;">FORM</span><br />
                        <span style="font-weight: bold; font-size: 35px; margin-left: 31px;">MW507</span>
                    </td>
                    <td colspan="1" style="vertical-align:middle;">
                         <h3><b>Employee’s Maryland Withholding Exemption Certificate</b></h3>
                    </td>
                </tr>
            </table>
        </div>

        <div id="DivFormBody" style="margin-right:5%;">
            <table id="TopFormTable" style="text-align:left; width: 100%; border: 1px solid black; padding: 2px; border-spacing: 0px 5px; padding: 3px 3px 3px 3px;" >
                <tr>
                    <td style="width: 40%; padding-left: 5px; border-bottom:1px solid black;">
                        Print full name
                        <br />
                        <b><asp:Label ID="lblFullName" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                    <td style="width: 60%; padding-left: 5px; border-left: 1px solid black; border-bottom:1px solid black;">
                        Social Security Number
                        <br />
                        <b><asp:Label ID="lblSSNumber" runat="server" Width="100%" CssClass="HRETan"></asp:Label></b>
                    </td>
                </tr>
                <tr>
                    <td style="width: 40%; padding-left: 5px; border-bottom:1px solid black;">
                        Street Address, City, State, ZIP
                        <br />
                        <b><asp:Label ID="lblFullAddress" runat="server" Width="100%" CssClass="HRETan" ></asp:Label></b>
                    </td>
                    <td style="width: 60%; padding-left: 5px; border-left: 1px solid black; border-bottom:1px solid black; padding-right:40px;">
                        County of residence (Nonresidents enter Maryland county (or Baltimore City) where you are employed.)
                        <br />
                        <asp:TextBox ID="TextCounty" runat="server" TabIndex="1"  Width="100%" CssClass="HRETan"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="col-xs-12 col-lg-3">
                        <asp:CheckBox ID="chkSingle" runat="server" TextAlign="Left"  Text="&nbsp;&nbsp;Single" TextWrapping="Wrap" Width="200px" onclick="single(this)" />
                        <asp:CheckBox ID="chkMarried" runat="server" TextAlign="Left" Text="&nbsp;&nbsp;Married (surviving spouse or unmarried Head of Household) Rate" TextWrapping="Wrap" Width="440px" onclick="married(this)"/>
                        <asp:CheckBox ID="chkMarriedSingle" runat="server" TextAlign="Left" Text="&nbsp;&nbsp;MarriedSingle, but withhold at Single rate" TextWrapping="Wrap" Width="400px" onclick="marriedsingle(this)"/>                   
                    </td>
                </tr>
            </table>
            <br />
            <table id="MainFormTable" style="text-align:left; width: 100%; border-spacing: 0px 5px; padding: 3px 3px 3px 3px;" >
                <tr>
                    <td style="width:2%;"></td>
                    <td style="width:2%;"></td>
                    <td style="width:2%;"></td>
                    <td style="width:80%;"></td>
                    <td style="width:4%;"></td>
                    <td style="width:10%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:center;">
                        1.
                    </td>
                    <td colspan="3" style="vertical-align:top;">
                        Total number of exemptions you are claiming not to exceed line f in Personal Exemption Worksheet on page 2.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; text-align:right;">
                        1.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; min-width:100px;">
                        <asp:TextBox ID="TextTotalExemptions" runat="server" TabIndex="2" CssClass="center" Width="90%" onkeypress="return onlyNumbers()" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:center;">
                        2.
                    </td>
                    <td colspan="3" style="vertical-align:top;">
                        Additional withholding per pay period under agreement with employer.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; text-align:right;">
                        2.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; min-width:100px;">
                        <asp:TextBox ID="TextAdditionalWithholding" runat="server" TabIndex="2" CssClass="center" Width="90%" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:center;">
                        3.
                    </td>
                    <td colspan="3" style="vertical-align:top;">
                        I claim exemption from withholding because I do not expect to owe Maryland tax. See instructions above and check boxes that apply.<br />
                    </td>   
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>      
                    <td colspan="1">&nbsp;</td>
                    <td colspan="1" style="vertical-align:top;">
                        <asp:CheckBox ID="ChkA" runat="server" />
                    </td>
                    <td colspan ="1" style="vertical-align:top;">
                        a.
                    </td>
                    <td colspan ="1" style="vertical-align:top;">
                        Last year I did not owe any Maryland income tax and had a right to a full refund of all income tax withheld and
                    </td>
                    <td colspan="2">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="1">&nbsp;</td>
                    <td colspan ="1" style="vertical-align:top;">
                        <asp:CheckBox ID="ChkB" runat="server" />
                    </td>
                    <td colspan ="1" style="vertical-align:top;">
                        b.
                    </td>
                    <td colspan ="1" style="vertical-align:top;">
                        This year I do not expect to owe any Maryland income tax and expect to have the right to a full refund of all income tax withheld.<br />
                        (This includes seasonal and student employees whose annual income will be below the minimum filing requirements).
                        If both a and b apply, enter year applicable
                        <asp:TextBox ID="TextYear" runat="server" TabIndex="4" Style="width: 12%;" placeholder=""></asp:TextBox> 
                        (year effective) Enter “EXEMPT” here 
                    </td>
                    <td colspan="1" style="vertical-align:bottom; text-align:right;">
                        3.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; min-width:100px;">
                        <asp:TextBox ID="TextExempt" runat="server" TabIndex="2" CssClass="center" Width="90%" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:center;">
                        4.
                    </td>
                    <td colspan="3" style="vertical-align:top;">
                        I claim exemption from withholding because I am domiciled in one of the following states. Check state that applies.
                        <br />
                        <asp:CheckBox ID="chkFourOne" runat="server" Text="&nbsp;&nbsp;District of Columbia &nbsp;" TextWrapping="Wrap" Width="200"/>
                        <asp:CheckBox ID="chkFourTwo" runat="server" Text="&nbsp;&nbsp;Virginia &nbsp;" TextWrapping="Wrap" Width="150"/>  
                        <asp:CheckBox ID="chkFourThree" runat="server" Text="&nbsp;&nbsp;West Virginia &nbsp;" TextWrapping="Wrap" Width="150"/>
                        <br />
                        I further certify that I do not maintain a place of abode in Maryland as described in the instructions above. Enter “EXEMPT” here.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; text-align:right;">
                        4.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; min-width:100px;">
                        <asp:TextBox ID="TextECFourFirst" runat="server" TabIndex="2" CssClass="center" Width="90%" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:center;">
                        5.
                    </td>
                    <td colspan="3" style="vertical-align:top;">
                        I claim exemption from Maryland <b>state</b> withholding because I am domiciled in the Commonwealth of Pennsylvania and I do not
                        maintain a place of abode in Maryland as described in the instructions on Form MW507. Enter “EXEMPT” here.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; text-align:right;">
                        5.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; min-width:100px;">
                        <asp:TextBox ID="TextECFiveFirst" runat="server" TabIndex="2" CssClass="center" Width="90%" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:center;">
                        6.
                    </td>
                    <td colspan="3" style="vertical-align:top;">
                        I claim exemption from Maryland local tax because I live in a <b>local</b> Pennysylvania jurisdiction within York or Adams counties.
                        Enter “EXEMPT” here and on line 4 of Form MW507.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; text-align:right;">
                        6.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; min-width:100px;">
                        <asp:TextBox ID="TextECSixFirst" runat="server" TabIndex="2" CssClass="center" Width="90%" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:center;">
                        7.
                    </td>
                    <td colspan="3" style="vertical-align:top;">
                        I claim exemption from Maryland local tax because I live in a local Pennsylvania jurisdiction that does not impose an earnings or income
                        tax on Maryland residents. Enter “EXEMPT” here and on line 4 of Form MW507.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; text-align:right;">
                        7.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; min-width:100px;">
                        <asp:TextBox ID="TextECSevenFirst" runat="server" TabIndex="2" CssClass="center" Width="90%" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:center;">
                        8.
                    </td>
                    <td colspan="3" style="vertical-align:top;">
                        I certify that I am a legal resident of the state of
                        <asp:TextBox ID="TextECEightFirst" runat="server" TabIndex="2" CssClass="center" Width="20%" ></asp:TextBox>
                        and am not subject to Maryland withholding because l meet the requirements set forth under the Servicemembers Civil Relief Act, as amended by the Military Spouses Residency Relief Act. Enter “EXEMPT” here.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; text-align:right;">
                        8.
                    </td>
                    <td colspan="1" style="vertical-align:bottom; min-width:100px;">
                        <asp:TextBox ID="TextECEightSecond" runat="server" TabIndex="2" CssClass="center" Width="90%" ></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
        <div id="DivSignatureSection" style="margin-right:5%;">
            <table id="SignatureRow" style="width:100%; border-top:1px solid black; border-bottom:1px solid black;">
                <tr>
                    <td style="width:60%;"></td>
                    <td style="width:40%;"></td>
                </tr>
                <tr>
                    <td colspan="2" style="vertical-align:top;">
                        <b>Under the penalty of perjury</b>, I further certify that I am entitled to the number of withholding allowances claimed on line 1 above, or if claiming exemption 
                        from withholding, that I am entitled to claim the exempt status on whichever line(s) I completed.
                    </td>
                </tr>
                <tr >
                    <td colspan="1" style="border-top:1px solid black; border-bottom: 1px solid black; height: 40px;">
                            Employee’s Signature<br />
                            <asp:TextBox ID="TextSignature" runat="server" Width="95%" placeholder=" Type Signature"  />
                    </td>
                    <td colspan="1" style="min-width:180px; border-top:1px solid black; border-bottom: 1px solid black; height: 40px;">
                            Date <br />
                            <asp:TextBox ID="SignatureDate" runat="server" Width="90%" />
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="padding-left:5px;">
                        Employer’s name and address including ZIP code (For employer use only)<br />
                        <b><asp:Label ID="lblEmployerName" runat="server" Width="95%" CssClass="HRETan" /></b>
                        <b><asp:Label ID="lblEmployerFullAddress" runat="server" Width="95%" CssClass="HRETan" /></b>
                    </td>
                    <td colspan="1" style="min-width:180px; padding-left:5px;">
                        Federal Employer Identification Number <br />
                        <b><asp:Label ID="lblEmployerFEIN" runat="server" Width="70%" CssClass="HRETan"/> </b>
                    </td>
                </tr>
            </table>
            <div style="margin-top: 10px;">
                COM/RAD-036 &nbsp; &nbsp; &nbsp; &nbsp; 12/20
            </div> 
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
        table {background-color:white; min-height: 25px; color:black; border:none; border-collapse:separate; border-spacing: 0px 5px;}
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
