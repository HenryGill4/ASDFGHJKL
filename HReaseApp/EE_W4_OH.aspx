<%@ Page Title="OH State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_OH.aspx.vb" 
    Inherits="HReaseApp.EE_W4_OH" 
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

        // This function will allow users to insert only numbers in the textboxes.
        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
  
        // This function will allow users to insert only numbers 0 or 1 in the textboxes.
        function onlyZeroOrOne(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;
            
            if (charCode == 48 || charCode == 49) 
                return true;
            return false;

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

        function exempt(checkbox) {
                if (checkbox.checked) {
                    //alert('Checkbox has been ticked!');
                    var a = '';
                    var b = '0';
                    $('input:text[id$=txtBox1]').val(a);
                    $('input:text[id$=txtBox2]').val(a);
                    $('input:text[id$=txtNumberOfDependents]').val(a);
                    $('input:text[id$=txtAdditionalWithholding]').val(b);
                    $('input:text[id$=txtTotalExemptions]').val(b);
                }
        }

        function notexempt(textbox) {
                if (textbox !='') {
                    //alert('Textbox is not empty');
                    $('input:checkbox[id$=chkExempt1]').prop("checked", false);
                    $('input:checkbox[id$=chkExempt2]').prop("checked", false);
                    $('input:checkbox[id$=chkExempt3]').prop("checked", false);
                    $('input:checkbox[id$=chkExempt4]').prop("checked", false);
                    $('input:checkbox[id$=chkMilitarySpouse]').prop("checked", false);
                }
        }
        
        $(function () {
            var Box1 = $('input:text[id$=txtBox1]').keyup(foo);
            var Box2 = $('input:text[id$=txtBox2]').keyup(foo);
            var Box3 = $('input:text[id$=txtNumberOfDependents]').keyup(foo);
              
            $('input:text[id$=hdnPW]').val(document.getElementById('divResPW').childNodes[1].innerHTML);

            function foo() {
                var a = Box1.val();
                var b = Box2.val();
                var c = Box3.val();
                
                var sum = add(a, b, c);
                $('input:text[id$=txtTotalExemptions]').val(sum);
                
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
                <h4><b>Ohio Form IT 4</b></h4>
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
            <br />
        </div>

        <div id="divInstructions" class="instruction_toggle" style="margin-right:5%;">
            <table style="background-color:white; width:100%;">
               <tr>
                    <td style="width:47%;"></td>
                    <td style="width:3%;"></td>
                    <td style="width:47%;"></td>
                </tr>
               <tr>
                    <td colspan="3">
                        <p style="color:red; text-align:center;">
                            As of 12/7/20 this new version of the IT 4 combines and replaces the following forms: IT 4 (previous version), IT 4NR, IT 4 MIL, and IT MIL SP
                        </p>
                        <p class="spanundel" style="color:black; text-align: center; margin: 5px; font-size: 18px; font-weight: 700; text-decoration: underline; margin-bottom:20px;">
                            IT 4 Instructions
                            <br />
                        </p>
                    </td>
                </tr>
               <tr style="vertical-align:top; border-bottom:2px solid black;">
                    <td colspan ="1">
                        <p style="color:black;">
                            Most individuals are subject to Ohio income tax on their 
                            wages, salaries, or other compensation. To ensure this 
                            tax is paid, employers maintaining an office or transacting 
                            business in Ohio must withhold Ohio income tax, and school 
                            district income tax if applicable, from each individual who is 
                            an employee.
                        </p>
                        <p style="color:black;">
                            Such employees who are subject to Ohio income tax (and 
                            school district income tax, if applicable) should complete 
                            sections I, II, and IV of the IT 4 to have their employer withhold 
                            the appropriate Ohio taxes from their compensation. If the 
                            employee does not complete the IT 4 and return it to his/her 
                            employer, the employer:
                        </p>
                       <ul>
                            <li style="color:black;">
                                Will withhold Ohio tax based on the employee claiming 
                                <b><u>zero exemptions</u></b>, and
                            </li>
                            <li style="color:black;">
                                <b><u>Will not</u></b> withhold school district income tax, even if the 
                                employee lives in a taxing school district.
                            </li>
                        </ul>
                        <p style="color:black;">
                            An individual may be subject to an interest penalty for 
                            underpayment of estimated taxes (on form IT/SD 2210) 
                            based on under-withholding.
                        </p>
                        <p style="color:black;">
                            Certain employees may be <b>exempt</b> from Ohio withholding 
                            because their income is not subject to Ohio tax. Such 
                            employees should complete sections I, III, and IV of the IT 
                            4 <b><u>only</u></b>.
                        </p>
                        <p style="color:black;">
                            <b>The IT 4 does not need to be filed with the Department 
                            of Taxation</b>. Your employer must maintain a copy as part of 
                            its records.
                        </p>
                        <p style="color:black;">
                            R.C. 5747.06(A) and Ohio Adm.Code 5703-7-10.
                        </p>
                        <p style="color:black; text-align:center; font-weight:bold;">
                            <u>Section I</u>
                        </p>
                        <p style="color:black;">
                            Enter the four-digit school district number of your primary 
                            address. If you do not know your school district of residence 
                            or its school district number, use <i>The Finder</i> at <b>tax.ohio.gov</b>. 
                            You can also verify your school district by contacting your 
                            county auditor or county board of elections.
                        </p>
                        <p style="color:black;">
                            If you move during the tax year, complete an updated IT 
                            4 immediately reflecting your new address and/ or school 
                            district of residence.
                        </p>
                        <p style="color:black; text-align:center; font-weight:bold;">
                            <u>Section II</u>
                        </p>
                        <p style="color:black;">
                            <u>Line 1:</u> If you can be claimed on someone else’s Ohio income 
                            tax return as a dependent, then you are to enter “0” on this 
                            line. Everyone else may enter “1”.
                        </p>
                        <p style="color:black;">
                            <u>Line 2:</u>  If you are single, enter “0” on this line. If you are 
                            married and you and your spouse file separate Ohio Income 
                            tax returns as “Married filing Separately” then enter “0” on 
                            this line.
                        </p>
                        <p style="color:black;">
                            <u>Line 3:</u> You are allowed one exemption for each dependent. 
                            Your dependents for Ohio income tax purposes are the 
                            same as your dependents for federal income tax purposes. 
                            See R.C. 5747.01(O).
                        </p>
                        <p style="color:black;">
                            <u>Line 5:</u> If you expect to owe more Ohio income tax than the 
                            amount withheld from your compensation, you can request 
                            that your employer withhold an additional amount of Ohio 
                            income tax. This amount should be reported in whole dollars. 
                        </p>
                    </td>
                    <td colspan="1">

                    </td>
                    <td colspan="1">                            
                        <p style="color:black;">
                            <b>Note:</b> If you do not request additional withholding from your 
                            compensation, you may need to make estimated income tax 
                            payments using form IT 1040ES or estimated school district 
                            income tax payments using the SD 100ES. Individuals who 
                            commonly owe more in Ohio income taxes than what is 
                            withheld from their compensation include:
                        </p>
                        <ul>
                            <li style="color:black;">
                                Spouses who file a joint Ohio income tax return and both 
                                report income, and
                            </li>
                            <li style="color:black;">
                                Individuals who have multiple jobs, all of which are 
                                subject to Ohio withholding.
                            </li>
                        </ul>
                        <p style="color:black; text-align:center; font-weight:bold;">
                            <u>Section III</u>
                        </p>
                        <p style="color:black;">
                            This section is for individuals whose income is deductible 
                            or excludable from Ohio income tax, and thus employer 
                            withholding is not required. Such employee should check 
                            the appropriate box to indicate which exemption applies to 
                            him/her. Checking the box will cause your employer to not 
                            withhold Ohio income tax and/or school district income tax. 
                            The exemptions include:
                        </p>
                        <ul>
                            <li style="color:black;">
                                <u>Reciprocity Exemption:</u> If you are a resident of Indiana, 
                                Kentucky, Pennsylvania, Michigan or West Virginia and 
                                you work in Ohio, you do not owe Ohio income tax on 
                                your compensation. Instead, you should have your 
                                employer withhold income tax for your resident state. 
                                R.C. 5747.05(A)(2).
                            </li>
                            <li style="color:black;">
                                <u>Resident Military Servicemember Exemption:</u> If you are 
                                an Ohio resident and a member of the United States 
                                Army, Air Force, Navy, Marine Corps, or Coast Guard (or 
                                the reserve components of these branches of the military) 
                                or a member of the National Guard, you do not owe 
                                Ohio income tax or school district income tax on your 
                                active duty military pay and allowances received while 
                                stationed outside of Ohio.
                            </li>
                        </ul>
                        <p style="color:black;">
                            This exemption does not apply to compensation for nonactive 
                            duty status or received while you are stationed in Ohio. 
                        </p>
                        <p style="color:black;">
                            R.C. 5747.01(A)(21). 
                        </p>
                        <ul>
                            <li style="color:black;">
                                <u>Nonresident Military Servicemember Exemption:</u> If 
                                you are a nonresident of Ohio and a member of the 
                                uniformed services (as defined in 10 U.S.C. §101), 
                                you do not owe Ohio income tax or school district 
                                income tax on your military pay and allowances.
                            </li>
                            <li style="color:black;">
                                <u>Nonresident Civilian Spouse of a Military Servicemember 
                                Exemption:</u>  If you are the civilian spouse of a military 
                                servicemember, your pay may be exempt from Ohio 
                                income tax and school district income tax if all of the 
                                following are true:
                                <ul>
                                    <li style="color:black;">
                                        Your spouse is a nonresident of Ohio;
                                    </li>
                                    <li style="color:black;">
                                        You and your spouse are residents of the same state;
                                    </li>
                                    <li style="color:black;">
                                        Your spouse is stationed in Ohio on military orders; and
                                    </li>
                                    <li style="color:black;">
                                        You are present in Ohio solely to be with your spouse.
                                    </li>
                                </ul>
                            </li>
                        </ul>
                        <p style="color:black;">
                            You <u>must</u> provide a copy of the employee’s spousal military 
                            identification card issued to the employee by the Department 
                            of Defense when completing the IT 4.
                        </p>
                    </td>                    
                </tr>
                <tr>
                    <td colspan="3">
                        <p style="color:red; text-align:center;">
                            As of 12/7/20 this new version of the IT 4 combines and replaces the following forms: IT 4 (previous version), IT 4NR, IT 4 MIL, and IT MIL SP
                        </p>
                    </td>
                </tr>
                <tr style="border-bottom:2px solid black;">
                    <td colspan="1">                        
                        <p style="color:black;">
                            Note: For more information on taxation of military 
                            servicemembers and their civilian spouses, see 50a U.S.C. 
                            §571.
                        </p>
                        <ul>
                            <li style="color:black;">
                                <u>Statutory Withholding Exemptions:</u> Compensation 
                                earned in any of the following circumstances is not 
                                subject to Ohio income tax or school district income tax 
                                withholding:
                                <ul>
                                    <li style="color:black;">
                                        Agricultural labor (as defined in 26 U.S.C. §3121(g));
                                    </li>
                                    <li style="color:black;">
                                        Domestic service in a private home, local college 
                                        club, or local chapter of a college fraternity or 
                                        sorority;
                                    </li>
                                    <li style="color:black;">
                                        Services performed by an employee who is regularly 
                                        employed by an employer to perform such service if 
                                        she or he earns less than $300 during a calendar 
                                        quarter;
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </td>
                    <td colspan="1">

                    </td>
                    <td colspan ="1">
                        <ul>
                            <li style="color:black;">
                                <ul>
                                    <li style="color:black;">
                                        Newspaper or shopping news delivery or distribution 
                                        directly to a consumer, performed by an individual 
                                        under the age of 18;
                                    </li>
                                    <li style="color:black;">
                                        Services performed for a foreign government or an 
                                        international organization; and
                                    </li>
                                    <li style="color:black;">
                                        Services performed outside the employer’s trade or 
                                        business if paid in any medium other than cash.
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </td>
                </tr>

            </table>
                            
            <br />
            <br />
        </div>

        <div id="divMainForm" style="margin-right:5%;">
            <div id="divSectionI">
                <table style="background-color:white; width:100%; color:black;">
                   <tr>
                        <td style="width:65%;"></td>
                        <td style="width:35%;"></td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <p style="color:red; text-align:center;">
                                As of 12/7/20 this new version of the IT 4 combines and replaces the following forms: IT 4 (previous version), IT 4NR, IT 4 MIL, and IT MIL SP
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            <p style="float: left; color:black; font-size:x-large;">
                                <span style="border-right: 1px solid #000; font-size: 48px;padding: 0px 10px 0px 10px;">
                                    O<b>hio</b></span>
                                <span style="font-size: 18px;display: inline-block;padding: 10px;">
                                    <b>Department of 
                                    <br /> 
                                    Taxation </b>
                                </span>
                            </p>
                        </td>
                        <td colspan="1" style="float: right; font-size:medium;">
                            <b style="font-size:large;">IT 4 </b>
                            <br />                        
                            Rev. 12/20
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="font-size: 28px; text-align:center; padding: 10px;">
                            <b>Employee’s Withholding Exemption Certificate</b>
                        </td>
                    </tr>
                    <tr style="font-size: medium;">
                        <td colspan="2">
                            <br />
                            <br />
                            Submit form IT 4 to your employer on or before the start date of employment so your employer will withhold and remit Ohio income tax 
                            from your compensation. If applicable, your employer will also withhold school district income tax. You must file an updated IT 4 when any 
                            of the information listed below changes (including your marital status or number of dependents). You should contact your employer for 
                            instructions on how to complete an updated IT 4. <b>Your employer may require you to complete this form electronically.</b>
                        </td>
                    </tr>
                    <tr >
                        <td colspan="2" style="font-size: 28px; font-weight:bold;">
                            <br />
                            Section I: Personal Information
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr style="font-size: large;">
                        <td colspan="1" style="border:2px solid black; padding-top:5px; vertical-align:bottom;">
                            Employee Name: 
                            <br />
                            <b><asp:Label ID="lblFullName" runat="server" Width="98%" Height="30px" CssClass="HRETan" Style="padding-top:10px;"/></b>
                        </td>
                        <td colspan="1" style="border:2px solid black; padding:5px; vertical-align:bottom;">
                            Employee SSN:
                            <br />
                            <b><asp:Label ID="lblSSN" runat="server" Width="98%" Height="30px" CssClass="HRETan" Style="padding-top:10px;"/></b>
                        </td>
                    </tr>
                    <tr style="font-size: large;">
                        <td colspan="2" style="border:2px solid black; padding:5px; vertical-align:bottom;">
                            Address, city, state, ZIP code: 
                            <br />
                            <b><asp:Label ID="lblFullAddress" runat="server" Width="98%" Height="30px" CssClass="HRETan" Style="padding-top:10px;"/></b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border:2px solid black; padding:5px; vertical-align:bottom;">
                            School district of residence (See The Finder at tax.ohio.gov): 
                            <br />
                            <asp:TextBox ID="txtPublicSchoolDisttResidence" runat="server" Style="width: 98%;" Height="30px" />
                        </td>
                        <td colspan="1" style="border:2px solid black; padding:5px; vertical-align:bottom;">
                            School district number (####):
                            <br />
                            <asp:TextBox ID="txtSchoolDisttNo" runat="server" Style="width: 98%;" Height="30px" />
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divSectionII">
                <table style="background-color:white; width:100%; color:black; font-size: large;">
                   <tr>
                        <td style="width:3%;"></td>
                        <td style="width:85%;"></td>
                        <td style="width:10%;"></td>
                    </tr>
                    <tr >
                        <td colspan="3" style="font-size: 28px; font-weight:bold;">
                            <br />
                            Section II: Claiming Withholding Exemptions
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="vertical-align:top; text-align:center;">
                            1.
                        </td>
                        <td colspan="1" >
                            Enter “0“ if you are a dependent on another individual’s Ohio return; otherwise enter “1”
                        </td>
                        <td colspan="1" style="vertical-align:bottom;" >
                            <asp:TextBox ID="txtBox1" runat="server" Placeholder="0 or 1 only" MaxLength="1" onkeypress="return onlyZeroOrOne()" onblur="notexempt(this)" Class="center" Width="95%" />                           
                        </td>
                    </tr>
                    
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="vertical-align:top; text-align:center;">
                            2.
                        </td>
                        <td colspan="1" >
                            Enter “0” if single or if your spouse files a separate Ohio return; otherwise enter “1“
                        </td>
                        <td colspan="1" style="vertical-align:bottom;">
                            <asp:TextBox ID="txtBox2" runat="server" Placeholder="0 or 1 only" MaxLength="1" onkeypress="return onlyZeroOrOne()" onblur="notexempt(this)" Class="center" Width="95%" />                            
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="vertical-align:top; text-align:center;">
                            3.
                        </td>
                        <td colspan="1" >
                            Number of dependents
                        </td>
                        <td colspan="1" style="vertical-align:bottom;">
                            <asp:TextBox ID="txtNumberOfDependents" runat="server" onkeypress="return onlyNumbers()" onblur="notexempt(this)" Class="center" Width="95%" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="vertical-align:top; text-align:center;">
                            4.
                        </td>
                        <td colspan="1" >
                            Total withholding exemptions (sum of line 1, 2, and 3)
                        </td>
                        <td colspan="1" style="vertical-align:bottom;">
                            <asp:TextBox ID="txtTotalExemptions" runat="server" onkeypress="return onlyNumbers()" onblur="notexempt(this)" Class="center" Width="95%" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="vertical-align:top; text-align:center;">
                            5.
                        </td>
                        <td colspan="1" >
                            Additional Ohio income tax withholding per pay period (optional)
                        </td>
                        <td colspan="1" style="vertical-align:bottom;">
                            <asp:TextBox ID="txtAdditionalWithholding" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" onkeyup="notexempt(this)" Class="center" Width="95%" />
                        </td>
                    </tr>
                </table>
            </div>

            <div id="divSectionIII">
                <table style="background-color:white; width:100%; color:black; font-size: large;">
                   <tr>
                        <td style="width:5%;"></td>
                        <td style="width:95%;"></td>
                    </tr>
                    <tr >
                        <td colspan="2" style="font-size: 28px; font-weight:bold;">
                            <br />
                            Section III: Withholding Waiver
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" >
                            <br />
                            I am <b>not</b> subject to Ohio or school district income tax withholding because (check all that apply):
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>                        
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkExempt1" runat="server" onclick="exempt(this)"/>
                        </td>
                        <td colspan="1">
                            I am a full-year resident of Indiana, Kentucky, Michigan, Pennsylvania, or West Virginia.
                        </td>
                    </tr>                    
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>                        
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkExempt2" runat="server" onclick="exempt(this)"/>
                        </td>
                        <td colspan="1">
                            I am a resident military servicemember who is stationed outside Ohio on active duty military orders.
                        </td>
                    </tr>                    
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>                        
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkExempt3" runat="server" onclick="exempt(this)" />
                        </td>
                        <td colspan="1">
                            I am a nonresident military servicemember who is stationed in Ohio due to military orders.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>                        
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkMilitarySpouse" runat="server" onclick="exempt(this)" />
                        </td>
                        <td colspan="1">
                            I am a nonresident civilian spouse of a military servicemember and I am present in Ohio solely due to my 
                            spouse’s military orders.
                        </td>
                    </tr>                    
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>                        
                        <td colspan="1" style="text-align:center;">
                            <asp:CheckBox ID="chkExempt4" runat="server" onclick="exempt(this)" />
                        </td>
                        <td colspan="1">
                            I am exempt from Ohio withholding under R.C. 5747.06(A)(1) through (6).
                        </td>
                    </tr>                    
                    <tr>
                        <td colspan="2">
                            &nbsp;
                        </td>
                    </tr>
                    <tr >
                        <td colspan="2" style="font-size: 28px; font-weight:bold;">
                            <br />
                            Section IV: Signature <span style="font-weight:normal;"> (required)</span>
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="font-size: large;">
                            <br />
                            Under penalties of perjury, I declare that, to the best of my knowledge and belief, the information is true, correct and complete.
                            <br />
                            <br />
                        </td>
                    </tr>
                </table>
                <table style="background-color: white;"> 
                    <tr style="font-size:large;">
                        <td colspan="1" style="border-bottom: 2px solid black; width:80%;">
                            Signature
                            <asp:TextBox ID="txtSignature" runat="server" Width="100%"/>
                        </td>
                        <td colspan="1" style="border-bottom: 2px solid black; width:20%;">
                            Date
                            <asp:TextBox ID="txtSignatureDate" runat="server" Width="100%" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="row">
            <div class="clearfix">&nbsp;</div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" OnClick="btnSave_Click" />
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
