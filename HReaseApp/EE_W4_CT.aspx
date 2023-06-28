<%@ Page Title="CT State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false"
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_CT.aspx.vb" 
    Inherits="HReaseApp.EE_W4_CT" 
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

     <style>
            input[type=text], textarea {
                outline: none;
                min-height: 25px;
                background-color: #f0f4fa;
                border: 1px solid #e0eaf7 !important;
            }


            div, span {
                text-align: start;
            }

            input[type="checkbox"] {
                width: 15px;
                height: 15px;
            }

            table.rotTable1 tr td:nth-child(5) {
                border-right: 1px solid;
            }

            table.rotTable1 tr td:nth-child(10) {
                border-right: 1px solid;
            }

            table.rotTable1 tr td:nth-child(1) {
                border-right: 1px solid;
            }

            table.rotTable tr td:nth-child(5) {
                border-right: 1px solid;
            }

            table.rotTable tr td:nth-child(10) {
                border-right: 1px solid;
            }

            table.rotTable tr td:nth-child(1) {
                border-right: 1px solid;
            }



            table.rotTable1 tr:nth-child(5) {
                border-bottom: 1px solid;
            }

            table.rotTable1 tr:nth-child(9) {
                border-bottom: 1px solid;
            }

            table.rotTable1 tr:nth-child(13) {
                border-bottom: 1px solid;
            }

            table.rotTable1 tr:nth-child(17) {
                border-bottom: 1px solid;
            }

            table.rotTable1 tr:nth-child(21) {
                border-bottom: 1px solid;
            }

            table.rotTable1 tr:nth-child(25) {
                border-bottom: 1px solid;
            }


            table.rotTable1 tr td:nth-child(1) {
                border-left: 1px solid;
            }

            table.rotTable1 tr td:nth-child(14) {
                border-right: 1px solid;
            }

            table.rotTable1 tr:nth-child(1) {
                border-top: 1px solid;
                border-bottom: 1px solid;
            }

            #rotate {
                -moz-transform: rotate(-90.0deg); /* FF3.5+ */
                -o-transform: rotate(-90.0deg); /* Opera 10.5 */
                -webkit-transform: rotate(-90.0deg); /* Saf3.1+, Chrome */
                filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=0.083); /* IE6,IE7 */
                -ms-filter: "progid:DXImageTransform.Microsoft.BasicImage(rotation=0.083)"; /* IE8 */
            }

            #rotate1 {
                -moz-transform: rotate(-90.0deg); /* FF3.5+ */
                -o-transform: rotate(-90.0deg); /* Opera 10.5 */
                -webkit-transform: rotate(-90.0deg); /* Saf3.1+, Chrome */
                filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=0.083); /* IE6,IE7 */
                -ms-filter: "progid:DXImageTransform.Microsoft.BasicImage(rotation=0.083)"; /* IE8 */
            }

            .wrapper {
               width:100%;
		        margin:0 auto;
		        overflow:hidden;
                padding:20px;
            }

            .statusBorder {
                border-collapse: collapse;
            }

            .statusBorder {
                border: 1px solid black !important;
            }

            .statusBorderHed {
                border: 2px solid black !important;
            }
        </style>

    <div class="HREwrapper">
        <div class="form-group" style="height:100px;">       
            <div style="float:left;">
                <br />
                <h4><asp:Label ID="lblEmployeeName" runat="server"></asp:Label></h4> 
            </div>
            <div id="divError" class="form-group alert alert-danger text-center text-danger divError" runat="server" visible="false">
                <div style="font-size:large; text-align:center;">
                    <asp:Image ID="Image1" ImageUrl="../img/RedX.png" runat="server" style="width:90px" border="none" /> 
                    <br/>
                    <h4>ERROR:
                    <asp:Label ID="lblError" runat="server" Text="There was an error.<br/>"></asp:Label></h4>
                </div>
            </div>
            <div id="divSuccess" runat="server" class="col-md-12 text-center"  visible ="false">
                <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" cssclass=" img" />
                <h3><br /><b><span style="color: green">
                <asp:Label ID="lblSuccess" runat="server" Text="Connecticut State Tax Form Complete.<br/>"></asp:Label>
                </span></b></h3>
            </div>
                <%-- next arrow full screen --%>
            <div style="float:right; padding-right:10%;">
                    <div class="fixed hidden-xs">
                        <asp:ImageButton ID="imgNext" runat="server" ImageUrl="../img/NextArrowInCircleBlueGreen.png" Width="50%" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click"/>
                    </div>
                </div>
                <%-- next arrow mobile screen --%>
                <div class="col-xs-3 col-sm-3 hidden-lg hidden-md pull-right right" style="padding-right:30%;">
                    <asp:ImageButton ID="imgNextMobile" runat="server" ImageUrl="../img/NextArrowInCircleBlueGreen.png" Width="150px" Height="150px" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                </div>
        </div>

        <div class="row well">
            <h4><span style="font-weight:bold;">INSTRUCTIONS</span>
                <span style="float: right">
                    <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px" />
                </span>
            </h4> 
        </div>

        <div class="well instruction_toggle" style="margin-top: 20px;margin-left:10px; margin-right:10px;">
            <div class="row well">
                <div>
                    <span><b>Employee General Instructions</b></span>
                </div>
                <div class="col-md-6">
                    <p>
                        <b>Form CT-W4,</b><i>Employee’s Withholding Certificate,</i>provides your
				    employer with the necessary information to withhold the correct
				    amount of Connecticut income tax from your wages to ensure that
				    you will not be underwithheld or overwithheld.
                    </p>
                    <p>
                        You are required to pay Connecticut income tax as income is earned
				    or received during the year. You should complete a new Form CT-W4
				    at least once a year or if your tax situation changes.
                    </p>
                    <p>
                        If your circumstances change, such as you receive a bonus or your
				    filing status changes, you must furnish your employer with a new
				    Form CT-W4 within ten days of the change.
                    </p>
                    <p>
                        <b>Gross Income</b><br />
                        For Form CT-W4 purposes, <b><i>gross income</i></b> means all income from
				    all sources, whether received in the form of money, goods, property,
				    or services, not exempt from federal income tax, and includes any
				    additions to income from Schedule 1 of <b>Form CT-1040</b>, <i>Connecticut
				    Resident Income Tax Return</i> or Form <b>CT-1040NR/PY</b>, <i>Connecticut
				    Nonresident and Part-Year Resident Return</i>.
                    </p>
                    <p>
                        <b>Filing Status</b>
                        Generally, the filing status you expect to report on your Connecticut
					    income tax return is the same as the filing status you expect to report
					    on your federal income tax return. However, special rules apply to
					    married individuals who file a joint federal return but have a different
					    residency status. Nonresidents and part-year residents should see
				        the instructions to Form CT-1040NR/PY.
                    </p>
                    <p>
                        <b>Check Your Withholding</b><br />
                        You may be underwithheld if any of the following apply:
                    </p>
                    <ul>
                        <li>You have more than one job;</li>
                        <li>You qualify under <i>Certain Married Individuals</i>; <b>or</b></li>
                        <li>You have substantial nonwage income.</li>
                    </ul>
                    <p></p>
                    <p>
                        If you are underwithheld, you should consider adjusting your
					    withholding or making estimated payments using Form CT-1040ES,
					    Estimated Connecticut Income Tax Payment Coupon for Individuals.
					    You may also select Withholding Code “D” to elect the highest level
					    of withholding.
					
                    </p>
                    <p>
                        If you owe $1,000 or more in Connecticut income tax over and above
					    what has been withheld from your income for the prior taxable year,
					    you may be subject to interest on the underpayment at the rate of 1%
				        per month or fraction of a month.
                    </p>
                    <p>
                        To help determine if your withholding is correct, see
				    <b>Informational Publication 2019(7),</b> <i>Is My Connecticut Withholding
				        Correct? </i>
                    </p>
                    <p>
                        <b>Certain Married Individuals</b> 
                        If you are a married individual filing jointly and you and your spouse both select 
                        Withholding Code “A,” you may have too much or too little Connecticut income tax withheld 
                        from your pay. This is because the phase-out of the personal exemption and credit is based 
                        on your combined incomes. The withholding tables cannot reflect your exact withholding
                        requirement without considering the income of your spouse. 
                        <br />
                        To minimize this problem, and determine if you need to adjust your withholding using Line 2 
                        or Line 3, see IP 2019(7). 
                    </p>
                    <p>
                        <b>Nonresident Employees Working Partly Within and Partly
				        Outside of Connecticut</b><br />
                        If you work partly within and partly outside of Connecticut for the same
				        employer, you should also complete <b>Form CT-W4NA</b>, Employee’s
				        Withholding or Exemption Certificate - Nonresident Apportionment,
				        and provide it to your employer. The information on Form CT-W4NA
				        and Form CT-W4 will help your employer determine how much to
				        withhold from your wages for services performed within Connecticut.
				        To obtain Form CT-W4NA, visit the Department of Revenue Services
				        (DRS) website at www.ct.gov/DRS or request the form from your
				        employer. Any nonresident who expects to have no Connecticut
				        income tax liability should choose Withholding Code “E.”
                    </p>
                    
                </div>

                <div class="col-md-6">
                    <p>
                        <b>Armed Forces Personnel and Veterans</b><br />
                        If you are a Connecticut resident, your armed forces pay is subject
				    to Connecticut income tax withholding unless you qualify as a
				    nonresident for Connecticut income tax purposes. If you qualify as
				    a nonresident, you may request that no Connecticut income tax be
				    withheld from your armed forces pay by entering Withholding Code “E”
				    on Line 1.
                    </p>
                    <p>
                        <b>Military Spouses Residency Relief Act (MSRRA)</b><br />
                        If you are claiming an exemption from Connecticut income tax under
					    the MSRRA, you must provide your employer with a copy of your
					    military spouse’s Leave and Earnings Statement (LES) and a copy
				        of your military dependent ID card.
                    </p>
                    <p>
                        See Informational Publication 2015(24), Connecticut Income Tax
				        Information for Armed Forces Personnel and Veterans
                    </p>
                    <p>
                        <b>Employer Instructions</b><br />
                        For any employee who does not complete Form CT-W4, you are required
					    to withhold at the highest marginal rate of 6.99% without allowance
					    for exemption. You are required to keep Form CT-W4 in your files for
					    each employee. See Informational Publication 2019(1), Connecticut
				        Employer’s Tax Guide, Circular CT, for complete instructions.
                    </p>
                    <p>
                        <b>Report Certain Employees Claiming Exemption From Withholding
				        to DRS</b><br />
                        Employers are required to file copies of Form CT-W4 with DRS for
				        certain employees claiming “E” (no withholding is necessary). See
				        IP 2019(1). Mail copies of Forms CT-W4 meeting the conditions listed
				        in IP 2019(1) under Reporting Certain Employees to:
                    </p>
                    <div>
                        Department of Revenue Services<br />
                        PO Box 2931<br />
                        Hartford CT 06104-2931
                    </div>
                    <p></p>
                    <p>
                        <b>Report New and Rehired Employees to the Department of Labor
				        New employees</b>are workers not previously employed by your
				        business, or workers rehired after having been separated from your
				        business for more than sixty consecutive days.
                    </p>
                    <p>
                        Employers with offices in Connecticut or transacting business in
					    Connecticut are required to report new hires to the Department of
					    Labor (DOL) within 20 days of the date of hire. 
			    <br />
                        New hires can be reported by:
                    </p>
                    <p></p>
                    <ul>
                        <li>Using the Connecticut New Hire Reporting website at
					    www.ctnewhires.com;
                        </li>
                        <li>Faxing copies of completed Forms CT-W4 to 800-816-1108; or
                        </li>
                        <li>Mailing copies of completed Forms CT-W4 to:
                        </li>
                    </ul>
                    <div>
                        Department of Labor<br />
                        Office of Research, Form CT-W4<br />
                        200 Folly Brook Boulevard<br />
                        Wethersfield CT 06109
                    </div>
                    <p></p>
                    <p>
                        For more information on DOL requirements or for alternative reporting
				    options, visit the DOL website at www.ctdol.state.ct.us or call DOL
				    at 860-263-6310.<br />
                        <b>For More Information</b><br />
                        Call DRS during business hours, Monday through Friday:<br />
                    </p>
                    <ul>
                        <li>800-382-9463 (Connecticut calls outside the Greater Hartford
				    calling area only); or </li>
                        <li>860-297-5962 (from anywhere).</li>

                    </ul>
                    <br />
                    TTY, TDD, and Text Telephone users only may transmit inquiries
			    anytime by calling 860-297-4911.<p></p>
                    <p>
                        <b>Forms and Publications</b><br />
                        Visit the DRS website at www.ct.gov/DRS to download and print
				    Connecticut tax forms and publications.
                    </p>

                </div>

                <div class="col-md-12">
                    <span>Form CT-W4 (Rev. 12/17)</span>
                </div>
            </div>
        </div>

            <table style="width:100%;">
                    <tbody>
                        <tr style="width: 100%;margin-left:10px;margin-right:10px;">
                            <td style="width: 30%;">
                                <div>
                                    &nbsp;&nbsp;Department of Revenue Services<br/>
                                    &nbsp;&nbsp;State of Connecticut<br/>
                                    <br/>
                                    &nbsp;&nbsp;(Rev. 12/18)
                                </div>
                            </td>
                            <td style="width: 50%;">
                                <div style="font-size: 25px; font-weight: 700; text-align: center;">
                                    Form CT-W4
                                </div>
                                <div style="font-size: 20px; font-weight: 700; text-align: center;">
                                    Employee’s Withholding Certificate
                                </div>
                                <div style="text-align: center;">
                                    Complete this form in blue or black ink only.
                                </div>
                            </td>
                            <td style="width: 20%;">
                                <div style="text-align: right; vertical-align: text-top; height: 100px; padding-top: 10px;">
                                    <b>Effective January 1, 2019 &nbsp;&nbsp;</b>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
     
            <div class="row">
                    <div class="col-md-6">
                        • Read instructions on Page 2 before completing this form.<br />
                        • Select the filing status you expect to report on your Connecticut
				income tax return. See instructions.
                    </div>
                    <div class="col-md-6">
                        • Choose the statement that best describes your gross income.<br />
                        • Enter the Withholding Code on Line 1 below.
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <table  style="width:100%;border: 1px solid;" class="">
                            <tbody>
                                <tr style="width: 100%; align-content:center;">
                                    <td class="statusBorder statusBorderHed ">
                                        <b>Married Filing Jointly</b> 
                                    </td>
                                    <td class="statusBorder statusBorderHed" style="text-align:center">
                                        <small><b>Withholding Code</b></small>
                                    </td>
                                </tr>
                                <tr style="width: 100%;">
                                    <td class="statusBorder">Our expected combined annual gross income is less than or
								equal to $24,000 or I am claiming exemption under the Military E Spouses Residency Relief Act (MSRRA)* and no withholding
								is necessary
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>E</b>
                                    </td>
                                </tr>
                                <tr style="width: 100%;">
                                    <td class="statusBorder">My spouse is employed and our expected combined annual
								gross income is greater than $24,000 and less than or equal 
								to $100,500. See Certain Married Individuals, Page 2.
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>A</b>
                                    </td>
                                </tr>
                                <tr style="width: 100%;">
                                    <td class="statusBorder">My spouse is not employed and our expected combined annual gross income is greater than $24,000.
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>C</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">My spouse is employed and our expected combined annual gross income is greater than $100,500.
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>D</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">I have significant nonwage income and wish to avoid having too little tax withheld.
								
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>D</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">I am a nonresident of Connecticut with substantial other income.
								
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>D</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;text-align:center">
                                    <td class="statusBorder statusBorderHed">

                                        <b>Qualifying Widow(er) With Dependent Child</b>


                                    </td>
                                    <td class="statusBorder statusBorderHed">
                                        <small><b>Withholding Code</b></small>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">My expected annual gross income is less than or equal to
								$24,000 or I am claiming exemption under the MSRRA* and 
								no withholding is necessary.
								
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>E</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">My expected annual gross income is greater than $24,000
								
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>C</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">I have significant nonwage income and wish to avoid having too little tax withheld.
								
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>D</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">I am a nonresident of Connecticut with substantial other income.
								
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>D</b>
                                    </td>
                                </tr>

                            </tbody>
                        </table>
                    </div>

                    <div class="col-md-6">
                        <table style="width:100%; border: 1px solid; background-color: white" >
                            <tbody>
                                <tr style="width: 100%; text-align:center">
                                    <td class="statusBorder statusBorderHed" style="width: 100%; text-align:center">
                                        <b>Married Filing Separately</b>

                                    </td>
                                    <td class="statusBorder statusBorderHed" style="width: 100%; text-align:center">
                                        <small><b>Withholding Code</b></small>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">My expected annual gross income is less than or equal to
								$12,000 or I am claiming exemption under the MSRRA* and 
								no withholding is necessary.
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>E</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">My expected annual gross income is greater than $12,000.
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>A</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">I have significant nonwage income and wish to avoid having  too little tax withheld.
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>D</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">I am a nonresident of Connecticut with substantial other income.
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>D</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder statusBorderHed" style="width: 100%; text-align:center">

                                        <b>Single</b>
                                    </td>
                                    <td class="statusBorder statusBorderHed" style="width: 100%; text-align:center">
                                        <small><b>Withholding Code</b></small>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">My expected annual gross income is less than or equal to  $15,000 and no withholding is necessary.
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>E</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">My expected annual gross income is greater than $15,000.	
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>F</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">I have significant nonwage income and wish to avoid having  too little tax withheld.
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>D</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">I am a nonresident of Connecticut with substantial other income.
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>D</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder statusBorderHed" style="width: 100%; text-align:center">
                                        <b>Head of Household</b>

                                    </td>
                                    <td class="statusBorder statusBorderHed" style="width: 100%; text-align:center">
                                        <small><b>Withholding Code</b></small>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">My expected annual gross income is less than or equal to  $19,000 and no withholding is necessary.
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>E</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">My expected annual gross income is greater than $19,000
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>B</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">I have significant nonwage income and wish to avoid having  too little tax withheld.
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>D</b>
                                    </td>
                                </tr>

                                <tr style="width: 100%;">
                                    <td class="statusBorder">I am a nonresident of Connecticut with substantial other income.
                                    </td>
                                    <td class="statusBorder" style="text-align:center">
                                        <b>D</b>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-md-12" style="margin: 5px 0px; border-bottom: 1px solid; padding: 0;">
                        * If you are claiming the Military Spouses Residency Relief Act (MSRRA) exemption, see instructions on Page 2.
                    </div>
                </div>
           
            <table style="width:100%; background-color: white;">
                    <tbody>
                        <tr style="width: 100%;padding-left:10px;vertical-align:top;">
                            <td colspan="30" style="width: 90%;">
                                &nbsp;&nbsp;&nbsp;<b>Employees: </b>See Employee General Instructions on Page 2. Keep a copy for your records
                            </td>
                        </tr>

                        <tr style="width:100%; vertical-align:top;">
                            <td colspan="1" style="width: 2%;">
                                1.
                            </td>
                            <td colspan="16" style="width: 60%;">
                                Withholding Code: Enter Withholding Code letter chosen from above. 
                            </td>

                            <td colspan="7" style="width: 17%;">
                                1.&nbsp;<asp:TextBox ID="txtWithholdingCode" runat="server" Style="border-bottom: 1px solid; width: 90%;" placeholder="" CssClass="input-bg"></asp:TextBox>
                            </td>
                            <td colspan="6" rowspan="2" style="width: 15%;">
                                <label class="checkbox-inline">
                                    <asp:CheckBox ID="chkMilitarySpouseRelief" runat="server" Text="" />
                                    Check if you are claiming
								    the MSRRA exemption
								    and enter state of legal
								    residence/domicile:
								
                                </label>
                            </td>
                        </tr>

                        <tr style="width:100%;vertical-align:top;">
                            <td colspan="1" style="width: 2%;">
                                2.
                            </td>
                            <td colspan="16" style="width: 60%;">
                                Additional withholding amount per pay period: If any, see Page 3 instructions.
                            </td>

                            <td colspan="7" style="width: 17%;">
                                2.&nbsp;<asp:TextBox ID="txtAdditionalWithholding" runat="server" Style="border-bottom: 1px solid; width: 90%;" placeholder="$" CssClass="input-bg"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="width:100%;height: 40px;vertical-align:top;">
                            <td colspan="1" style="width: 2%;">
                                3.
                            </td>
                            <td colspan="16" style="width: 60%;">
                                Reduced withholding amount per pay period: If any, see Page 3 instructions.
                            </td>

                            <td colspan="7" style="width: 17%;">
                                3.&nbsp;<asp:TextBox ID="txtReducedAmount" runat="server" Style="border-bottom: 1px solid; width: 90%;" placeholder="$" CssClass="input-bg"></asp:TextBox>
                            </td>
                            <td colspan="6" style="width: 15%;">
                                <asp:TextBox ID="IsAppliState" runat="server" Style="border-bottom: 1px solid; width: 100%;" placeholder="Enter State" CssClass="input-bg"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="width:100%; margin-left:20px; border: 1px solid; height: 60px;">
                            <td colspan="8" style="width: 25%;">
                                <div>First name</div>
                                <b><asp:Label ID="lblFName" runat="server" Style="width: 100%;"></asp:Label></b>
                            </td>
                            <td colspan="4" style="width: 10%; text-align: center;">
                                <div style="text-align: center;">
                                    MI
                                </div>
                                <b><asp:Label ID="lblMI" runat="server" Style="width: 100%;" ></asp:Label></b>
                            </td>
                            <td colspan="8" style="width: 25%; border-right: 1px solid;">
                                <div>Last Name</div>
                                <b><asp:Label ID="lblLName" runat="server" Style="width: 95%;"></asp:Label></b>
                            </td>

                            <td colspan="10" style="text-align: center; width: 40%; border-right: 1px solid;">
                                <div style="">
                                    Your social security number
                                </div>
                                <span>
                                    <b><asp:Label ID="lblSSNumber" runat="server" Style="width: 100%;"></asp:Label></b>
                                </span>
                            </td>
                        </tr>
                        <tr style="width:100%; border: 1px solid;">
                            <td colspan="30" style="width: 100%; border-right: 1px solid;">
                                <div>Home address (number and street, apartment number, suite number, PO Box)</div>
                                <b><asp:Label ID="lblFullAddress" runat="server" Style="width: 100%;"></asp:Label></b>
                            </td>
                        </tr>

                        <tr style="width:100%; border-bottom: 1px solid; border-left: 1px solid; border-right: 1px solid;">
                            <td colspan="10" style="width: 35%; border-bottom: 1px solid; border-left: 1px solid;">
                                <div>
                                    City or town
                                </div>
                                <b><asp:Label ID="lblCity" runat="server" Style="width: 95%;"></asp:Label></b>
                            </td>
                            <td colspan="5" style="width: 20%; text-align: center;">
                                <div style="text-align: center;">
                                    State
                                </div>

                                <b><asp:Label ID="lblState" runat="server" Style="width: 95%;" ></asp:Label></b>
                            </td>
                            <td colspan="15" style="width: 45%; border-right: 1px solid;">
                                <div>Zip code</div>
                                <b><asp:Label ID="lblZipCode" runat="server" Style="width: 100%;" ></asp:Label></b>
                            </td>
                        </tr>
                        <tr style="width: 100%;">
                            <td colspan="30" style="width: 100%;">
                                <div>

                                    <b>Declaration:</b> I declare under penalty of law that I have examined this certificate and, to the best of my knowledge and belief, it is true, complete, and
								    correct. I understand the penalty for reporting false information is a fine of not more than $5,000, imprisonment for not more than five years, or both.
                                </div>

                            </td>
                        </tr>

                        <tr style="width:100%; border: 1px solid;">
                            <td colspan="20" style="width: 60%;">
                                <div>Employee’s signature</div>
                                <asp:TextBox ID="txtSignature" runat="server" Style="padding-left:5px; width: 80%;" placeholder="Type Full Name here to represent your Signature" CssClass="input-bg"></asp:TextBox>
                            <p> </p>
                            </td>
                            <td colspan="10" style="width: 40%; border: 1px solid;">
                                <div>Date</div>
                                <asp:TextBox ID="SignatureDate" runat="server" Style="padding-left:5px;width: 80%;" placeholder="" CssClass="input-bg"></asp:TextBox>
                            <p> </p>
                            </td>
                        </tr>


                        <tr style="width: 100%;">
                            <td colspan="30" style="width: 100%;">
                                <div><b>Employers:</b> See Employer Instructions.</div>
                            </td>
                        </tr>

                        <tr style="width:100%;height: 40px;">
                            <td colspan="10" style="width: 34%;">
                                <div>Is this a new or rehired employee?</div>
                            </td>
                            <td colspan="10" style="width: 32%;">
                                <label class="checkbox-inline">
                                    <asp:CheckBox ID="chkNo" runat="server" Text="" />
                                    No
								
                                </label>
                                <label class="checkbox-inline">
                                    <asp:CheckBox ID="chkYes" runat="server" Text="" />
                                    Yes
								
                                </label>
                            </td>
                            <td colspan="10" style="width: 32%;">Date of hired:
                            <asp:TextBox ID="lblHiredDate" runat="server" Style="" placeholder="" CssClass="input-bg"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="width: 100%; border: 1px solid;">
                            <td colspan="20" style="width: 60%;">
                                <div>Employer’s business name</div>
                                <b><asp:Label ID="lblEmployerFullName" runat="server" Style="width: 95%;"></asp:Label></b>
                            </td>
                            <td colspan="10" style="width: 40%; border-left: 1px solid; border-right: 1px solid;">
                                <div>Federal Employer Identification Number</div>
                                <b><asp:Label ID="lblEmployerFEIN" runat="server" Style="width: 100%;" ></asp:Label></b>
                            </td>
                        </tr>

                        <tr style="width: 100%; border: 1px solid;">
                            <td colspan="30" style="width: 100%; border-right: 1px solid;">
                                <div>Employer’s business address</div>
                                <b><asp:Label ID="lblEmployerFullAddress" runat="server" Style="width: 100%;"></asp:Label></b>
                            </td>
                        </tr>

                        <tr style="width: 100%; border: 1px solid;">
                            <td colspan="8" style="width: 33%;">
                                <div>City/town</div>
                                <b><asp:Label ID="lblEmployerCity" runat="server" Style="width: 95%;" ></asp:Label></b>
                            </td>
                            <td colspan="5" style="width: 15%;">
                                <div>State</div>
                                <b><asp:Label ID="lblEmployerState" runat="server" Style="width: 95%;" ></asp:Label></b>
                            </td>
                            <td colspan="17" style="width: 50%; border-right: 1px solid;">
                                <div>ZIP code</div>
                                <b><asp:Label ID="lblEmployerZipCode" runat="server" Style="width: 100%;" ></asp:Label></b>
                            </td>
                        </tr>

                        <tr style="width: 100%; border: 1px solid;">
                            <td colspan="20" style="width: 65%;">
                                <div>Contact person</div>
                                <b><asp:Label ID="lblEmployerContactPerson" runat="server" Style="width: 95%;" ></asp:Label></b>
                                <p> </p>
                             </td>
                            <td colspan="30" style="width: 35%; border-left: 1px solid;">
                                <div>Telephone number</div>
                                <b><asp:Label ID="lblEmployerTelNo" runat="server" Style="" ></asp:Label></b>
                                <p> </p>
                            </td>
                        </tr>
            
           
                    </tbody>
                </table>

            <div class="row">
                <div class="clearfix">&nbsp;</div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
                    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" OnClick="btnSave_Click" />
                </div>
                <div class="clearfix">&nbsp;</div>
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
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
    </style>
</asp:Content>
