<%@ Page Title="NJ State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_NJ.aspx.vb" 
    Inherits="HReaseApp.EE_W4_NJ" 
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
                <h4><b>New Jersey Form NJ-W4</b></h4>
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

        <div id="divInstructionTitle" class="well HRESlateBlue HRERewrap" >
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px;" />

        </div>

        <div id="divInstructions" class="well HRETan instruction_toggle" style="text-align:center; margin-right:5%;">
            <div class="HREWhite" style="text-align:left;">
               <p><b>BASIC INSTRUCTIONS</b></p>
                <p>
                    <span class="line">Line 1 </span>Enter your name, address and social security number in the spaces provided.
                </p>

                <p>
                    <span class="line">Line 2 </span>Check the box that indicates your filing status. If you checked Box 1 (Single) or Box 3 (Married/Civil Union Partner Separate) you will be withheld at
			    Rate A.
                </p>

                <p class="note" style="padding-left: 3%;">
                    Note:  If you have checked Box 2 (Married/Civil Union Couple Joint), Box 4 (Head of Household) or Box 5 (Qualifying
			        Widow(er)/Surviving Civil Union Partner) and either your spouse/civil union partner works or you have more than one job
			        or more than one source of income and the combined total of all wages is greater than $50,000, see instruction A below.
			        If you do not complete Line 3, you will be withheld at Rate B.
                </p>

                <p>
                    <span class="line">Line 3 </span>
                    If you have chosen to use the wage chart below, enter the appropriate letter.</p>
                <p>
                    <span class="line">Line 4 </span>
                        Enter the number of allowances you are claiming. Entering a number on this line will decrease the amount of withholding and could result in an
			            underpayment on your return.
                </p>
                <p>
                    <span class="line">Line 5 </span>
                    Enter the amount of additional withholdings you want deducted from each pay.</p>
                <p>
                    <span class="line">Line 6 </span>
                    Enter “EXEMPT” to indicate that you are exempt from New Jersey Gross Income Tax Withholdings, if you meet one of the following conditions:
                </p>
                    <ul style="padding-left: 4%;">
                        <li>Your filing status is <b>SINGLE or MARRIED/CIVIL UNION PARTNER SEPARATE </b>and your wages plus your taxable nonwage
				        income will be $10,000 or less for the current year.
                        </li>
                        <li>Your filing status is <b>MARRIED/CIVIL UNION COUPLE JOINT, </b>and your wages combined with your spouse’s/civil union
				        partner’s wages plus your taxable non wage income will be $20,000 or less for the current year.
                        </li>
                        <li>Your filing status is <b>HEAD OF HOUSEHOLD </b>or<b> QUALIFYING WIDOW(ER)/SURVIVING CIVIL UNION PARTNER</b>   and your wages plus your taxable nonwage income will be $20,000 or less for the current year.
                        </li>
                    </ul>

                <p>
                    Your exemption is good for <b>ONE</b> year only. You must complete and submit a form each year certifying you have no New Jersey Gross Income Tax liability and
			    claim exemption from withholding. If you have questions about eligibility, filing status, withholding rates, etc. when completing this form, call the Division of
			    Taxation’s Customer Service Center at 609-292-6400.
                </p>
                <p><b>Instruction A - Wage Chart</b></p>
                <p style="padding-left: 30px;">
                    This chart is designed to increase withholdings on your wages, if these wages will be taxed at a higher rate due to inclusion of other wages or income on
			    your NJ-1040 return. <b>It is not intended to provide withholding for other income or wages.</b> If you need additional withholdings for other income or wages
			    use Line 5 on the NJ-W4. This Wage Chart applies to taxpayers who are married/civil union couple filing jointly, heads of households or qualifying
			    widow(er)/surviving civil union partner.  <b>Single individuals or married/civil union partners filing separate returns do not need to use this chart.</b> If you
			    have indicated filing status #2, 4 or 5 on the above NJ-W4 and your taxable income is greater than $50,000, you should strongly consider using the Wage
			    Chart. (See the Rate Tables on the reverse side to estimate your withholding amount).
                </p>

                <div class="col-md-5" style="margin-top:50px;">
                    <table style="background-color:white;">
                        <tr>
                            <td colspan="2">
                                <div style="padding-left: 1%;">
                                    <br /><br />
                                    <h4 style="text-align: center; margin-bottom: 20px;"><b>HOW TO USE THE CHART</b></h4>
                                    <ol>
                                        <li style="margin-top: 20px; margin-bottom: 20px;">Find the amount of your wages in the left-hand column.</li>
                                        <li style="margin-top: 20px; margin-bottom: 20px;">Find the amount of the total for all other wages (including
						                    your spouse’s/civil union partner’s wages) along the top
					                        row.</li>
                                        <li style="margin-top: 20px; margin-bottom: 20px;">Follow along the row that contains your wages until you
					                        come to the column that contains the other wages.</li>
                                        <li style="margin-top: 20px; margin-bottom: 20px;">This meeting point indicates the Withholding Table that best
					                        reflects your income situation.</li>
                                        <li style="margin-top: 20px; margin-bottom: 20px;">If you have chosen this method, enter the “letter” of the
					                        withholding rate table on Line 3 of the NJ-W4.</li>
                                    </ol>
                                </div>
                            </td>
                        </tr>
                        <tr style="width: 100%; margin-top: 20px; margin-bottom: 20px;">
                            <td style="width: 15%; vertical-align: top;">
                            
                                    <h4><b><i>NOTE:</i></b></h4>
                            </td>
                            <td style="width: 85%">
                                <span style="">If your income situation substantially increases (or
					                    decreases) in the future, you should resubmit a
					                    revised NJ-W4 to your employer.
                                </span>
                            </td>
                        </tr>
                        <tr style="width: 100%; height: 100px;">
                            <td colspan="2">
                                <h4 style="text-align: center; margin-top: 10px;"><b>THIS FORM MAY BE REPRODUCED</b></h4>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-md-7" style="padding-right: 0px; margin-top:25px; background-color:white;">
                    <p style="text-align: center;"><b>WAGE CHART</b></p>
                    <table class="table-bordered WageChart" style="text-align: center; width: 100%; background-color:white;">
                        <tbody>
                            <tr>
                                <td colspan="2">Total of All
						    Other Wages</td>
                                <td>0<br/>10,000</td>
                                <td>10,000<br/>20,000</td>
                                <td>20,000<br/>30,000</td>
                                <td>30,000<br/>40,000</td>
                                <td>40,000<br/>50,000</td>
                                <td>50,000<br/>60,000</td>
                                <td>60,000<br/>70,000</td>
                                <td>70,000<br/>80,000</td>
                                <td>80,000<br/>90,000</td>
                                <td>OVER<br/>90,000</td>
                                </tr>
                        

                            <tr>
                                <td rowspan="10" style="text-align:center;">
                                    <h4 style="writing-mode: vertical-rl; text-orientation: upright;">
                                        <b>YOUR&nbsp;WAGES</b>
                                    </h4>
                                </td>
                                <td>0<br/>10,000</td>
                                <td>B</td>
                                <td>B</td>
                                <td>B</td>
                                <td>B</td>
                                <td>B</td>
                                <td>B</td>
                                <td>B</td>
                                <td>B</td>
                                <td>B</td>
                                <td>B</td>
                            </tr>

                            <tr>
                                <td>10,001<br/>20,000</td>
                                <td>B</td>
                                <td>B</td>
                                <td>B</td>
                                <td>B</td>
                                <td>C</td>
                                <td>C</td>
                                <td>C</td>
                                <td>C</td>
                                <td>C</td>
                                <td>C</td>
                            </tr>

                            <tr>
                                <td>20,001<br/>30,000</td>
                                <td>B</td>
                                <td>B</td>
                                <td>B</td>
                                <td>A</td>
                                <td>A</td>
                                <td>D</td>
                                <td>D</td>
                                <td>D</td>
                                <td>D</td>
                                <td>D</td>
                            </tr>

                            <tr>
                                <td>30,001<br/>40,000</td>
                                <td>B</td>
                                <td>B</td>
                                <td>A</td>
                                <td>A</td>
                                <td>A</td>
                                <td>A</td>
                                <td>A</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                            </tr>

                            <tr>
                                <td>40,001<br/>50,000</td>
                                <td>B</td>
                                <td>C</td>
                                <td>A</td>
                                <td>A</td>
                                <td>A</td>
                                <td>A</td>
                                <td>A</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                            </tr>

                            <tr>
                                <td>50,001<br/>60,000</td>
                                <td>B</td>
                                <td>C</td>
                                <td>D</td>
                                <td>A</td>
                                <td>A</td>
                                <td>A</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                            </tr>

                            <tr>
                                <td>60,001<br/>70,000</td>
                                <td>B</td>
                                <td>C</td>
                                <td>D</td>
                                <td>A</td>
                                <td>A</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                            </tr>

                            <tr>
                                <td>70,001<br/>80,000</td>
                                <td>B</td>
                                <td>C</td>
                                <td>D</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                            </tr>

                            <tr>
                                <td>80,001<br/>90,000</td>
                                <td>B</td>
                                <td>C</td>
                                <td>D</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                            </tr>

                            <tr>
                                <td>OVER<br/>90,000</td>
                                <td>B</td>
                                <td>C</td>
                                <td>D</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                                <td>E</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div id="divLinktoRateTable" class="col-md-12" style="border-top: 1px solid black; border-bottom:1px solid black; margin-bottom:20px; text-align:center; padding-bottom:10px;">
                    <p style="padding-top:10px;"><i>RATE TABLES FOR WAGE CHART</i></p>
                    <span style="text-align:center;"><a href="/Documents/Shared/W4NJ_2021_RateTables.pdf" target="_blank">Go To Rate Tables</a></span>
                </div>
            </div>
        </div>

        <div id="divWIFormHeader" style="margin-top:20px;">
            <table style="background-color:white; margin-right:5%;">
                <tr >
                    <td style="width: 15%;">
                        <h4>Form
							<span style="font-size: 20px; line-height: 2px; font-weight: bold;"> NJ-W4</span>
                                <br/>
                            (1-21)
                        </h4>
                    </td>
                      <td style="width: 70%;">
                        <span class="header" style="text-align: center;"></span>
                            <h4 style="font-size: 20px; font-weight: bold; text-align:center;">State of New Jersey - Division of Taxation</h4>
                            <h2 style="font-size: 23px; line-height: 2px; font-weight: bold; text-align:center;">Employee’s Withholding Allowance Certificate</h2>
                    </td>
                    <td style="width: 15%;">&nbsp;</td>
                </tr>
            </table>
        </div>
        
        <div style="margin-right:5%;">
          <table style="background-color:white;">
                <tr>
                    <td style="width:3%;">&nbsp;</td>
                    <td style="width:7%;"></td>
                    <td style="width:27%;"></td>
                    <td style="width:15%;"></td>
                    <td style="width:15%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:27%;"></td>
                </tr>
                <tr >
                    <td colspan="1" style="vertical-align:top; border-left:1px solid black; border-top:1px solid black;">
                        1.
                    </td>
                    <td colspan="1" style="vertical-align:top; border-top:1px solid black;"> 
                        SS#	
                    </td>
                    <td colspan="3" style="vertical-align:bottom; border-top:1px solid black;">
                        <b><asp:Label ID="lblSSNwithDashes" runat="server" class="HRELabel" Width="100%"></asp:Label></b>
                    </td>
                    <td colspan="1" rowspan="4" style="vertical-align:top; border-left:1px solid black; border-top:1px solid black; border-bottom:1px solid black;">
                        <h5 style="font-size: 16px; font-weight: bold;" class="number">
                            2.</h5> 
                    </td>
                    <td colspan="2" rowspan="4" style="vertical-align:top; border-top:1px solid black; border-right:1px solid black; border-bottom:1px solid black; font-weight: normal;"">
                          <h5> Filing Status: (Check only one box)</h5>
                        <ol style="list-style: none; padding-left: 6%;">
                            <li>1. &nbsp;<asp:CheckBox ID="chkSingle" runat="server" Text="&nbsp;Single" TextAlign="right" TabIndex="110" AutoPostBack="true" OnCheckedChanged="chkSingle_CheckedChanged" />
                            </li>

                            <li>2. &nbsp;<asp:CheckBox ID="chkMarriedJoint" runat="server" Text="&nbsp;Married/Civil Union Couple Joint" TextAlign="right" TabIndex="111" AutoPostBack="true" OnCheckedChanged="chkMarriedJoint_CheckedChanged" />
                            </li>

                            <li>3. &nbsp;<asp:CheckBox ID="chkMarriedSeparate" runat="server" Text="&nbsp;Married/Civil Union Partner Separate" TextAlign="right" TabIndex="112" AutoPostBack="true" OnCheckedChanged="chkMarriedSeparate_CheckedChanged" />
                            </li>

                            <li>4. &nbsp;<asp:CheckBox ID="chkHeadHousehold" runat="server" Text="&nbsp;Head of Household" TextAlign="right" TabIndex="111" AutoPostBack="true" OnCheckedChanged="chkHeadHousehold_CheckedChanged" />
                            </li>

                            <li>5. &nbsp;<asp:CheckBox ID="chkWidow" runat="server" Text="&nbsp;Qualifying Widow(er)/Surviving Civil Union Partner" TextAlign="right" TabIndex="112" AutoPostBack="true" OnCheckedChanged="chkWidow_CheckedChanged" />
                            </li>
                        </ol>
                    </td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1" style="border-left:1px solid black; border-top:1px solid black;">
                    </td>
                    <td colspan="1" style="text-align:left; border-top:1px solid black; vertical-align:top;">
                       Name
                    </td>
                    <td colspan="3" style="text-align:left; border-top:1px solid black; vertical-align:bottom;">
                        <b><asp:Label ID="lblEmployeeFullName" runat="server" class="HRELabel" Width="100%" ></asp:Label></b>
                    </td>
                    <td colspan="3">
                    </td>
                </tr>
                <tr style="vertical-align:top;" >
                    <td colspan="1" style="border-left:1px solid black; border-top:1px solid black;">
                    </td>
                    <td colspan="1" style="text-align:left; border-top:1px solid black; vertical-align:top;">
                        Address
                    </td>
                    <td colspan="3" style="text-align:left; border-top:1px solid black; vertical-align:bottom;">
                        <b><asp:Label ID="lblHomeAddress" runat="server" class="HRELabel" Width="100%" ></asp:Label></b>
                    </td>
                    <td colspan="3">
                    </td>
                </tr>
                <tr style="vertical-align:top; border-bottom:1px solid black;">
                    <td colspan="1" style="border-left:1px solid black; border-top:1px solid black;">
                    </td>
                    <td colspan="1" style="text-align:left; border-top:1px solid black; vertical-align:top;">
                        City
                    </td>
                    <td colspan="1" style="text-align:left; border-top:1px solid black; vertical-align:middle;">
                        <b><asp:Label ID="lblCity" runat="server" class="HRELabel" Width="100%" ></asp:Label></b>
                    </td>
                    <td colspan="1" style="text-align:left; border-top:1px solid black; vertical-align:top;">
                        State 
                        <b style="vertical-align:middle;"><asp:Label ID="lblState" runat="server" class="HRELabel" Width="100%" ></asp:Label></b>
                    </td>
                    <td colspan="1" style="text-align:left; border-top:1px solid black; vertical-align:top;">
                        Zip
                        <b style="vertical-align:middle;"><asp:Label ID="lblZip" runat="server" class="HRELabel" Width="100%" ></asp:Label></b>
                    </td>
                    <td colspan="3">
                    </td>
                </tr>
              </table>
            <table style="background-color:white; border:1px solid black;">
                <tr style="margin-bottom:10px;">
                    <td style="width:3%;"></td>
                    <td style="width:72%;"></td>
                    <td style="width:5%;"></td>
                    <td style="width:15%;"></td>
                    <td style="width:5%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        3.
                    </td>
                    <td colspan="1" style="border-right:1px solid black;">
                        If you have chosen to use the chart from instruction A, enter the appropriate letter here
                    </td>
                    <td colspan="1" style="vertical-align:bottom;">
                        3.
                    </td>
                    <td colspan="1" style="width: 100%; min-width:100px; text-align: center; padding-right: 1%; vertical-align:bottom;">
                        <asp:TextBox ID="txt1" runat="server"  placeholder="Letters Only" CssClass="input_color"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="valretxt1" runat="server" CSSClass="red" ControlToValidate="txt1" ValidationExpression="\b(A|B|C|D|E|a|b|c|d|e)\b" ErrorMessage="<b>Only the letters A, B, C, D, or E are Valid</b>" Display="Dynamic" />
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        4.
                    </td>
                    <td colspan="1" style="border-right:1px solid black;">
                        Total number of allowances you are claiming (see instructions)
                    </td>
                    <td colspan="1" style="vertical-align:bottom;">
                        4.
                    </td>
                    <td colspan="1" style="width: 100%; min-width:100px; text-align: center; padding-right: 1%; vertical-align:bottom;">
                        <asp:TextBox ID="txtTotalExemptions" runat="server" placeholder="Required" CssClass="input_color" onkeypress="return onlyNumbers();" ></asp:TextBox>
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        5.
                    </td>
                    <td colspan="1" style="border-right:1px solid black;">
                        Additional amount you want deducted from each pay
                    </td>
                    <td colspan="1" style="vertical-align:bottom;">
                        5.
                    </td>
                    <td colspan="1" style="width: 100%; min-width:100px; text-align: center; padding-right: 1%; vertical-align:bottom;">
                        <asp:TextBox ID="txtAdditionalWithholding" runat="server"  placeholder="Numeric Values Only" CssClass="input_color" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" ></asp:TextBox>
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        6.
                    </td>
                    <td colspan="1" style="border-right:1px solid black;">
                        I claim exemption from withholding of NJ Gross Income Tax and I certify that I have met the conditions in the instructions of the NJ-W4. If you have met the conditions, enter “EXEMPT” here . . .
                    </td>
                    <td colspan="1" style="vertical-align:bottom;">
                        6.
                    </td>
                    <td colspan="1" style="width: 100%; min-width:100px; text-align: center; padding-right: 1%; vertical-align:bottom;">
                        <asp:TextBox ID="txtExempt" runat="server"  placeholder="Enter EXEMPT if applicable" CssClass="input_color" AutoPostBack ="true" OnTextChanged="txtExempt_TextChanged"></asp:TextBox>
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>            
                <tr style="margin-top:5px; margin-bottom:20px; border-top:1px solid black; border-right:1px solid black;">
                    <td colspan="1" style="vertical-align:top;">
                        7.
                    </td>
                    <td colspan="4" style="border-right:1px solid black;">
                        Under penalties of perjury, I certify that I am entitled to the number of withholding allowances claimed on this certificate or entitled to claim exempt status.
                    </td>
                    
                </tr>
                <tr style="border-right:1px solid black;"><td colspan="5">&nbsp;&nbsp;</td></tr>
                
                <tr style="border-right:1px solid black;">
                    <td colspan="2" style="padding-left:1%;">
                        <span style="border-bottom: 1px solid black; width:90%; text-align:left;"> 
                            <asp:TextBox ID="txtSignature" runat="server" placeholder="Type Name to Represent Signature" cssClass="left" Width="100%"></asp:TextBox>
                        </span>
                        <br />
                       Employee’s Signature
                    </td>
                    <td colspan="3">
                        <span style="border-bottom: 1px solid black; width:90%; text-align:left;">  
					        <asp:TextBox ID="txtSignatureDate" runat="server" placeholder="MM/DD/YYYY" ></asp:TextBox>
                        </span>
                        <br />
                        Date
                    </td>
                </tr>
                <tr style="border-right:1px solid black;">
                    <td colspan="5">
                        &nbsp;
                    </td>
                </tr>
            </table>

            <table style="border:1px solid black;">
                <tr>
                    <td style="width:50%"></td>
                    <td style="width:50%"></td>
                </tr>
                <tr>
                    <td colspan="1">
                        Employer’s Name and Address
                        <br />
                        <b><asp:Label ID="lblCompanyName" runat="server" Style="text-align: left; padding-left: 1%; display: inline;" ></asp:Label></b>
                        <br />
                        <b><asp:Label ID="lblCompanyAddress" runat="server" Style="text-align: left; padding-left: 1%; display: inline;" ></asp:Label></b>
                        <br />
                        <b><asp:Label ID="lblCompanyCityStateZip" runat="server" Style="text-align: left; padding-left: 1%; display: inline;" ></asp:Label></b>
                    </td>
                    <td colspan="1" style="text-align: left; display: inline;" > 
                        Employer Identification Number 
                        <br />
                        <b><asp:Label ID="lblCompanyFEIN" runat="server" ></asp:Label></b>
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
        $(".chart_toggle").hide();
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
        .HRELabel {background-color: #f5f5f0; font-size: large; vertical-align:bottom;}
    </style>
</asp:Content>
