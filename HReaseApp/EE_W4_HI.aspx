<%@ Page Title="Employee State WH form HI" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_HI.aspx.vb" 
    Inherits="HReaseApp.EE_W4_HI" 
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

       function single(checkbox) {
           if (checkbox.checked) {
               $('input:checkbox[id$=chkMarried]').prop("checked", false);
               $('input:checkbox[id$=chkMarriedWHSR]').prop("checked", false);
               $('input:checkbox[id$=chkCertifiedDisabledPerson]').prop("checked", false);
               $('input:checkbox[id$=chkNRMilitarySpouse]').prop("checked", false);
           }
       }
       function married(checkbox) {
           if (checkbox.checked) {
               $('input:checkbox[id$=chkSingle]').prop("checked", false);
               $('input:checkbox[id$=chkMarriedWHSR]').prop("checked", false);
               $('input:checkbox[id$=chkCertifiedDisabledPerson]').prop("checked", false);
               $('input:checkbox[id$=chkNRMilitarySpouse]').prop("checked", false);
           }
       }
       function marriedwh(checkbox) {
           if (checkbox.checked) {
               $('input:checkbox[id$=chkSingle]').prop("checked", false);
               $('input:checkbox[id$=chkMarried]').prop("checked", false);
               $('input:checkbox[id$=chkCertifiedDisabledPerson]').prop("checked", false);
               $('input:checkbox[id$=chkNRMilitarySpouse]').prop("checked", false);
           }
       }
       function disabledperson(checkbox) {
           if (checkbox.checked) {
               $('input:checkbox[id$=chkSingle]').prop("checked", false);
               $('input:checkbox[id$=chkMarried]').prop("checked", false);
               $('input:checkbox[id$=chkMarriedWHSR]').prop("checked", false);
               $('input:checkbox[id$=chkNRMilitarySpouse]').prop("checked", false);

           }
       }
       function military(checkbox) {
           if (checkbox.checked) {
               $('input:checkbox[id$=chkSingle]').prop("checked", false);
               $('input:checkbox[id$=chkMarried]').prop("checked", false);
               $('input:checkbox[id$=chkMarriedWHSR]').prop("checked", false);
               $('input:checkbox[id$=chkCertifiedDisabledPerson]').prop("checked", false);

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

       function makeMoney(source) {
           //Grab the value from the element
           var money = parseFloat(source.value, 10).toFixed(2);

           //Format your value
           source.value = money.toString();
       }

       //$(function () {
       //    var Box1 = $('input:text[id$=txtIDBox1]').keyup(foo);
       //    var Box2 = $('input:text[id$=txtIDBox2]').keyup(foo);
       //    var Box4 = $('input:text[id$=txtIDBox4]').keyup(foo);
       //    var Box6 = $('input:text[id$=txtIDBox6]').keyup(foo);
       //    var Box9 = $('input:text[id$=txtIDBox9]').keyup(foo);
       //    var Box10 = $('input:text[id$=txtIDBox10]').keyup(foo);

       //    var Boxa = $('input:text[id$=txtA]').keyup(foo);
       //    var Boxb = $('input:text[id$=txtB]').keyup(foo);
       //    var Boxc = $('input:text[id$=txtC]').keyup(foo);
       //    var Boxd = $('input:text[id$=txtNumberOfDependents]').keyup(foo);
       //    var Boxe = $('input:text[id$=txtE]').keyup(foo);
       //    var Boxf = $('input:text[id$=txtF]').keyup(foo);

       //    function foo() {
       //        var a = Box1.val();
       //        var b = Box2.val();
       //        var c = Box4.val();
       //        var d = Box6.val();
       //        var e = Box9.val();
       //        var f = Box10.val();

       //        var a1 = Boxa.val();
       //        var b1 = Boxb.val();
       //        var c1 = Boxc.val();
       //        var d1 = Boxd.val();
       //        var e1 = Boxe.val();
       //        var f1 = Boxf.val();

       //        var sum3 = (a - b);
       //        var sum5 = (sum3 + parseFloat(c))
       //        var sum7 = (sum5 - parseFloat(d))
       //        var sum8 = parseFloat((sum7 / 4350).toFixed(0))
       //        $('input:text[id$=txtIDBox3]').val(sum3);
       //        $('input:text[id$=txtIDBox5]').val(sum5);
       //        $('input:text[id$=txtIDBox7]').val(sum7);
       //        $('input:text[id$=txtIDBox8]').val(sum8);

       //        if (sum3 < 0)
       //            //alert('Getting here');
       //            sum3 = 0
       //        var sum5 = (sum3 + parseFloat(c))
       //        var sum7 = (sum5 - parseFloat(d))
       //        var sum8 = parseFloat((sum7 / 4350).toFixed(0))
       //        $('input:text[id$=txtIDBox3]').val(sum3);
       //        $('input:text[id$=txtIDBox5]').val(sum5);
       //        $('input:text[id$=txtIDBox7]').val(sum7);
       //        $('input:text[id$=txtIDBox8]').val(sum8);

       //        var sumf = add(a1, b1, c1, d1, e1);
       //        $('input:text[id$=txtF]').val(sumf);

       //        if (f1 > 0)
       //            $('input:text[id$=txtIDBox9]').val(f1);

       //        var sum10 = (sum8 + parseFloat(e))
       //        $('input:text[id$=txtIDBox10]').val(sum10);

       //        if (sum10 < 0)
       //            sum10 = 0
       //        $('input:text[id$=txtIDBox10]').val(sum10);

       //        if (f1 > 0)
       //            $('input:text[id$=txtTotalExemptions]').val(f1);

       //        if (f > 0)
       //            $('input:text[id$=txtTotalExemptions]').val(f);

       //    }
       //    function add() {
       //        var sumf = 0;
       //        for (var i = 0, j = arguments.length; i < j; i++) {
       //            if (IsNumeric(arguments[i])) {
       //                sumf += parseFloat(arguments[i]);
       //            }
       //        }
       //        return sumf;
       //    }
       //    function IsNumeric(input) {
       //        return (input - 0) == input && input.length > 0;
       //    }
       //});

   </script>


   <div class="HREwrapper" style="text-align:center; width:95%; align-self:center;" >
        <div id="divPageTitle" runat="server">
            <div style="text-align:center;">
                <br />
                <h4><b>Hawaii Form HW-4</b></h4>
                <br />
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
                    <asp:Label ID="lblSuccess" runat="server"  Text="&nbsp;&nbsp;&nbsp;&nbsp;Form Complete" Width="50%"></asp:Label>
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
                </div>
            </div>
        </div>      

        <div id="InstructionHeaderBar" class="well HRESlateBlue HRERewrap" style="text-align:center; width:95%; margin-bottom:0px;">
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px; padding-bottom:10px;" />

        </div>

        <div id="Instructions" class="form-group instruction_toggle HREWhite" style="margin:auto; width:95%; margin-bottom:2%; ">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            
             <table style="width: 100%; background-color: transparent; margin:auto;">
                    <tr>
                        <td style=" text-align:center; font-size:large;">
                            <span><strong>STATE OF HAWAII — DEPARTMENT OF TAXATION</strong></span>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:100%; text-align:center;  padding-top:1%;">
                            <span style="width:20%;font-size:xx-large;"><strong>EMPLOYEE’S WITHHOLDING ALLOWANCE AND STATUS CERTIFICATE<br /></strong></span>
                            <span style="padding-top:10px; font-size:120%;"><strong>INSTRUCTIONS</strong></span>
                        </td>
                    </tr>
                    <tr>
                        <td style="width:100%; text-align:center; font-size:x-large; padding-bottom:1.5%; padding-top:1%; font-weight:300;">
                            <span><strong>(NOTE: References to “married” and “spouse” are also references to “in a civil union” and “civil union partner,” respectively.)</strong></span>
                        </td>
                    </tr>

                </table>
                <table style="background-color:white; width:100%; border-bottom:3px solid black;">
               <tr>
                    <td style="width:40%;"></td>
                    <td style="width:4%;"></td>
                    <td style="width:40%;"></td>
                </tr>
               <tr style="vertical-align:top;">
                    <td colspan ="1">
                        <p style="color:black;">
                            <b>MARITAL STATUS—</b>—If you are legally separated from your spouse under
                                a decree of divorce or separate maintenance, check the Single box.
                        </p>
                        <p style="color:black;">
                            If you file as <b>head of household</b> on your tax return, you are treated as
                            Single for withholding tax purposes. However, an additional withholding
                            allowance may be claimed for this filing status.
                        </p>
                        <p style="color:black;">
                            <b>NUMBER OF WITHHOLDING ALLOWANCES</b>——Do not claim more than
                                the correct number of withholding allowances. However, if by claiming
                                the correct number of withholding allowances you still expect to owe
                                more income tax for the year than will be withheld, you may increase the
                                amount withheld either by claiming fewer withholding allowances or by
                                entering into an agreement with your employer to withhold an additional
                                dollar amount.
                        </p>
                        <p style="color:black;">
                            <small><b><i>Note: Hawaii law does NOT allow “exempt” status for withholding purposes.</i></b></small>
                        </p>
                        <p style="color:black;">
                            <b>NONWAGE INCOME</b>——If you have a large amount of nonwage income,
                                from sources such as interest or dividends, you should consider making
                                estimated tax payments using Form N-200V or you may find that you owe
                                additional tax at the end of the year.
                        </p>
                        <p style="color:black;">
                            <b>TWO-EARNER/TWO JOBS</b>——If you have a working spouse or more than
                                one job, figure the total number of allowances you are entitled to claim
                                on all jobs using worksheets from only one Form HW-4. This total should
                                be divided among all jobs. Your withholding will usually be most accurate
                                when all allowances are claimed on the HW-4 filed for the highest paying
                                job and zero allowances are claimed for the others.
                        </p>
                        <p style="color:black;">
                            <b>FILING THE CERTIFICATE</b>—You must file this form with your employer
                                or your employer must withhold tax from your wages as if you were single
                                and claimed no withholding allowances.
                        </p>
                        <p style="color:black;">
                            <b>FILING A NEW CERTIFICATE</b>—You SHOULD file a new certificate if
                                you get married or are entitled to claim more withholding allowances. You
                                MUST file a new certificate within 10 days if ANY of the following occurs:
                        </p>
                        <ul>
                            <li style="color:black;">
                                (a) If you are divorced or legally separated
                            </li>
                            <li style="color:black;">
                                (b) If your spouse, for whom you have been claiming a withholding 
                                allowance, commences claiming his or her own withholding
                                allowance on a separate certificate.
                            </li>
                            <li style="color:black;">
                                (c) If a dependent for whom you claimed a withholding allowance no
                                longer qualifies as a dependent.
                            </li>
                        </ul>
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1">
                       <p style="color:black;">
                           You MUST file a new certificate on or before December 1 in case of the
                            death of your spouse or the death of a dependent, unless such event
                            occurs in December.
                       </p>
                       <p style="color:black;">
                           <b>WITHHOLDING ALLOWANCE FOR AGE</b>—You may claim an additional
                            withholding allowance for age if you are at least 65 years old and no
                            one can claim you as a dependent. If you are married and filing a joint
                            return, you may also claim an additional withholding allowance if your
                            spouse is at least 65 years old, no one else can claim your spouse as
                            a dependent, and your spouse is not already claiming such withholding
                            allowance for himself / herself on a Form HW-4.
                       </p>
                       <p style="color:black;">
                           <b>HEAD OF HOUSEHOLD</b>—Generally, you may claim head of household
                            filing status on your tax return only if you are unmarried and pay more
                            than 50% of the costs of keeping up a home for yourself and your
                            qualifying child or any other person who is your dependent.
                       </p>
                       <p style="color:black;">
                           <b>PENALTIES</b>—Penalties are imposed for willfully supplying false or
                            fraudulent information or for willfully failing to supply information.
                       </p>
                       <p style="color:black;">
                           <b>CERTIFIED DISABLED PERSON</b>—See the section, “What Is Not
                            Subject to Withholding” in Booklet A, Employer’s Tax Guide.
                       </p>
                       <p style="color:black;">
                           <b>NONRESIDENT MILITARY SPOUSE</b>—Under federal law, the State is
                            prohibited from subjecting the income received by a service member’s
                            nonresident spouse for services performed (i.e., wages) in Hawaii to
                            Hawaii’s income tax beginning tax year 2009 if certain conditions are
                            met. See Tax Information Release No. 2010-01 and Tax Announcement
                            No. 2019-01 for further details.
                       </p>
                       <p style="color:black;">
                           <b>FOR FURTHER INFORMATION</b>—Contact your employer or the
                            Department of Taxation at 808-587-4242 (toll-free at 1-800-222-3229).
                       </p>
                   </td>
                </tr>
            </table>
                
            </div>
        </div>
            
        <div id="PersonalAllowancesHeaderBar" class="well HRESlateBlue HRERewrap" style="align-self:center; max-height:100px;  margin:auto; width:95%; margin-top:1.5%;" align="center">
	            <span><b>PERSONAL ALLOWANCES WORKSHEET</b></span>
	            <img src="img/plus.png" class="instruction_toggle_btn1" style="vertical-align:middle; float: right; width: 30px; max-height:100px; padding-bottom:10px;" />
        </div>
         
        <div id="PersonalAllowancesWorksheet" class="form-group instruction_toggle1 HREWhite" style="margin:auto; width:95%; text-align:center; margin-top:1%; border:0px;">
             <div id="WorksheetInstructions" align="center" style="width: 100%; text-align: center;">
                 <span style="float: left; font-size: 170%; padding-bottom: 1%;"><strong>FORM HW-4
                     <br />
                     (REV. 2021)</strong></span>

                 <table style="width: 100%; margin-top: 1%; background-color: white; border-bottom: 5px solid black; border-top: 5px solid black;">
                     <tbody>
                         <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">

                             <td style="text-align: center; padding-top: 1.5%; padding-bottom: 1.5%;">
                                 <div style="padding-top: 5px;">

                                     <span style="font-size: xx-large; font-weight: 700; line-height: 0px;">HW-4 Worksheet to Figure Your Withholding Allowances
                                     </span>
                                 </div>
                             </td>

                         </tr>
                     </tbody>
                 </table>

                 <div id="jsfirst" class="HREWhite" style="width: 100%; margin-right: 0px; border: 0px; margin-bottom: 10%; text-align: center;">
                     <table style="width: 100%; background-color: white;">
                         <tbody style="font-size: 18px;">
                             <tr style="width: 100%; margin: auto;">
                                 <td style="width: 80%; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>A</strong>
                                     </span>
                                     <span style="float: left; width: 80%;">Enter “1” for <strong>yourself</strong> if no one else can claim you as a dependent.
                                     </span>
                                 </td>
                                 <td style="width: 20%; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 5%;">
                                         <strong>A</strong>
                                     </span>
                                     <span style="float: left; width: 80%; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtWFWABoxA" runat="server" Style="border-bottom: 1px solid;" onkeypress="return onlyZeroOrOne()" CssClass="center"/>
                                     </span>
                                 </td>
                             </tr>
                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                 <td style="width: 80%; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>B</strong>
                                     </span>
                                     <span style="float: left; padding-right: 2%; width: 10%;">Enter "1" if:
                                     </span>
                                     <span style="float: left; width: 75%;">1. You are single and have only one job <strong>OR</strong><br />
                                         2. You are married, have only one job, and your spouse does not work
                                     </span>
                                 </td>
                                 <td style="width: 20%; vertical-align: bottom; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 5%;">
                                         <strong>B</strong>
                                     </span>
                                     <span style="float: left; width: 80%; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtWFWABoxB" runat="server" Style="border-bottom: 1px solid;" onkeypress="return onlyZeroOrOne()" CssClass="center"/>

                                     </span>
                                 </td>
                             </tr>
                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px; height: fit-content;">
                                 <td style="width: 80%; padding-bottom: 2%">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>C</strong>
                                     </span>
                                     <span style="float: left; padding-right: 2%; width: 25%;">Enter “1” for your <strong>spouse</strong> if:
                                     </span>
                                     <span style="float: left; width: 60%;">1. No one else can claim your spouse as a dependent <strong>AND</strong><br />
                                         2. Your spouse is not claiming a withholding allowance for himself / herself<br />
                                         &nbsp;&nbsp;&nbsp;&nbsp;on a Form HW-4.
                                     </span>
                                 </td>
                                 <td style="width: 20%; vertical-align: bottom; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 5%; vertical-align: bottom;">
                                         <strong>C</strong>
                                     </span>
                                     <span style="float: left; width: 80%; vertical-align: bottom; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtWFWABoxC" runat="server" Style="border-bottom: 1px solid;" onkeypress="return onlyZeroOrOne()" CssClass="center"/>
                                     </span>
                                 </td>
                             </tr>
                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                 <td style="width: 80%; padding-bottom: 2%; margin-right: 10%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>D</strong>
                                     </span>
                                     <span style="float: left; width: 80%;">You may be able to claim additional withholding allowances for <strong>age</strong>. See Instructions on page 1.<br />
                                         Enter “1” if you or your spouse qualifies. Enter “2” if both you and your spouse qualify
                                     </span>
                                 </td>
                                 <td style="width: 20%; vertical-align: bottom; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 5%;">
                                         <strong>D</strong>
                                     </span>
                                     <span style="float: left; width: 80%; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtWFWABoxD" runat="server" Style="border-bottom: 1px solid;" onkeypress="return onlyOneOrTwo()" CssClass="center"/>
                                     </span>
                                 </td>
                             </tr>
                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px; height: inherit;">
                                 <td style="width: 80%; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>E</strong>
                                     </span>
                                     <span style="float: left; width: 80%;">Enter the number of <strong>dependents</strong> that you will claim on your tax return. (State qualifications<br />
                                         are the same as the federal)
                                     </span>
                                 </td>
                                 <td style="width: 20%; vertical-align: bottom; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 5%; vertical-align: bottom;">
                                         <strong>E</strong>
                                     </span>
                                     <span style="float: left; width: 80%; vertical-align: bottom; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtWFWABoxE" runat="server" Style="border-bottom: 1px solid;" onkeypress="return onlyNumbers()" CssClass="center"/>
                                         <br />
                                     </span>
                                 </td>
                             </tr>
                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                 <td style="width: 80%; padding-bottom: 2%; margin-right: 10%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>F</strong>
                                     </span>
                                     <span style="float: left; width: 80%;">Enter “1” if you will file as <strong>head of household</strong> on your tax return. See Instructions on page 1
                                     </span>
                                 </td>
                                 <td style="width: 20%; vertical-align: bottom; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 5%;">
                                         <strong>F</strong>
                                     </span>
                                     <span style="float: left; width: 80%; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtWFWABoxF" runat="server" Style="border-bottom: 1px solid;" onkeypress="return onlyZeroOrOne()" CssClass="center"/>
                                     </span>
                                 </td>
                             </tr>
                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                 <td style="width: 80%; padding-bottom: 2%; margin-right: 10%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>G</strong>
                                     </span>
                                     <span style="float: left; width: 80%;">Enter “1” if you estimate that you will have at least $250 of <strong>total tax credits</strong>
                                     </span>
                                 </td>
                                 <td style="width: 20%; vertical-align: bottom; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 5%;">
                                         <strong>G</strong>
                                     </span>
                                     <span style="float: left; width: 80%; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtWFWABoxG" runat="server" Style="border-bottom: 1px solid;" onkeypress="return onlyZeroOrOne()" CssClass="center"/>
                                     </span>
                                 </td>
                             </tr>
                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                 <td style="width: 80%; padding-bottom: 2%; margin-right: 10%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>H</strong>
                                     </span>
                                     <span style="float: left; width: 80%;">If you plan to <strong>itemize or claim adjustments to income</strong>, complete the worksheet below and enter the number of<br />
                                         withholding allowances here from line 8
                                     </span>
                                 </td>
                                 <td style="width: 20%; vertical-align: bottom; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 5%;">
                                         <strong>H</strong>
                                     </span>
                                     <span style="float: left; width: 80%; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtWFWABoxH" runat="server" Style="border-bottom: 1px solid;" onkeypress="return onlyNumbers()" CssClass="center"/>
                                     </span>
                                 </td>
                             </tr>
                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                 <td style="width: 80%; padding-bottom: 2%; margin-right: 10%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>I</strong>
                                     </span>
                                     <span style="float: left; width: 80%;">Total. Add lines A through H. Enter the total here and on line 4 of Form HW-4 on page 1. (<strong>Note:</strong> <i>This amount<br />
                                         may be different from the number of exemptions you claim on your return</i>)
                                     </span>
                                 </td>
                                 <td style="width: 20%; vertical-align: bottom; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 6%;">
                                         <strong>I</strong>
                                     </span>
                                     <span style="float: left; width: 80%; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtWFWABoxI" runat="server" Style="border-bottom: 1px solid;" onkeypress="return onlyNumbers()" CssClass="center"/>
                                     </span>
                                 </td>
                             </tr>
                         </tbody>
                     </table>
                 </div>
                 <table style="width: 100%; margin-top: 1%; background-color: white; border-bottom: 5px solid black; border-top: 5px solid black;">
                     <tbody>
                         <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">

                             <td style="text-align: center; padding-top: 1.5%; padding-bottom: 1.5%;">
                                 <div style="padding-top: 5px;">

                                     <span style="font-size: xx-large; font-weight: 700; line-height: 0px;">Deductions and Adjustments Worksheet                                
                                     </span>
                                 </div>
                             </td>
                         </tr>
                     </tbody>
                 </table>

                 <div id="jssecond" class="HREWhite" style="width: 100%; margin-right: 0px; border: 0px; margin-bottom: 8%; text-align: center; border-bottom: 4px solid black">
                     <table style="width: 100%; background-color: white;">
                         <tbody style="font-size: 18px;">

                             <tr>
                                 <td colspan="2" style="padding-bottom: 0.8%;">
                                     <span style="float: left;"><strong style="padding-right: 5px;">NOTE:</strong> Use this worksheet only if you plan to itemize deductions or claim adjustments to income.</span>
                                 </td>
                             </tr>

                             <tr style="width: 100%; margin: auto;">
                                 <td style="width: 80%; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>1.</strong>
                                     </span>
                                     <span style="float: left; width: 80%;">Enter an estimate of your current year’s itemized deductions. These include: qualifying home mortgage interest,<br />
                                         charitable contributions, state and local taxes, medical expenses in excess of 7.5% of your adjusted gross income<br />
                                         for taxable years beginning after December 31, 2018, and miscellaneous deductions. (You may have to reduce your
                            itemized deductions if your income is over $166,800 ($83,400 if married filing separately))
                                     </span>
                                 </td>
                                 <td style="width: 20%; padding-bottom: 2%; vertical-align: bottom; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>1&nbsp;&nbsp;$</strong>
                                     </span>
                                     <span style="float: left; width: 80%; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtDAWBox1" runat="server" Style="border-bottom: 1px solid;" />
                                     </span>
                                 </td>
                             </tr>
                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                 <td style="width: 80%; padding-bottom: 2%;">

                                     <span style="float: left; padding-right: 2%; padding-top: 7%;">
                                         <strong>2.</strong>
                                     </span>
                                     <span style="float: left; padding-right: 2%; padding-top: 7%;">Enter
                                     </span>

                                     <span style="font-size: 750%; float: left; width: fit-content; padding-top: 6%; padding-bottom: 7%;">{
                                     </span>
                                     <span style="float: left; padding-top: 3%; padding-bottom: 2%;">$4,400* if married filing jointly or surviving spouse<br />
                                         $3,212* if head of household<br />
                                         $2,200* if single<br />
                                         $2,200* if married filing separately
                                     </span>
                                     <span style="font-size: 750%; float: left; width: fit-content; padding-top: 6%; padding-bottom: 7%;">}
                                     </span>
                                 </td>
                                 <td style="width: 20%; vertical-align: middle; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>2&nbsp;&nbsp;$</strong>
                                     </span>
                                     <span style="float: left; width: 80%; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtDAWBox2" runat="server" Style="border-bottom: 1px solid;" />

                                     </span>
                                 </td>
                             </tr>

                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                 <td style="width: 80%; padding-bottom: 2%; margin-right: 10%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>3.</strong>
                                     </span>
                                     <span style="float: left; width: 80%;">Line 1 minus line 2. Enter the result, but not less than zero
                                     </span>
                                 </td>
                                 <td style="width: 20%; vertical-align: bottom; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>3&nbsp;&nbsp;$</strong>
                                     </span>
                                     <span style="float: left; width: 80%; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtDAWBox3" runat="server" Style="border-bottom: 1px solid;" />
                                     </span>
                                 </td>
                             </tr>
                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px; height: inherit;">
                                 <td style="width: 80%; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>4.</strong>
                                     </span>
                                     <span style="float: left; width: 80%;">Enter an estimate of your current year’s adjustments to income
                                     </span>
                                 </td>
                                 <td style="width: 20%; vertical-align: bottom; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>4&nbsp;&nbsp;$</strong>
                                     </span>
                                     <span style="float: left; width: 80%; vertical-align: bottom; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtDAWBox4" runat="server" Style="border-bottom: 1px solid;" />
                                         <br />
                                     </span>
                                 </td>
                             </tr>
                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                 <td style="width: 80%; padding-bottom: 2%; margin-right: 10%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>5.</strong>
                                     </span>
                                     <span style="float: left; width: 80%;">Add lines 3 and 4 and enter the total
                                     </span>
                                 </td>
                                 <td style="width: 20%; vertical-align: bottom; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>5&nbsp;&nbsp;$</strong>
                                     </span>
                                     <span style="float: left; width: 80%; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtDAWBox5" runat="server" Style="border-bottom: 1px solid;" />
                                     </span>
                                 </td>
                             </tr>
                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                 <td style="width: 80%; padding-bottom: 2%; margin-right: 10%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>6.</strong>
                                     </span>
                                     <span style="float: left; width: 80%;">Enter an estimate of your current year’s nonwage income (such as dividends or interest income)
                                     </span>
                                 </td>
                                 <td style="width: 20%; vertical-align: bottom; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>6&nbsp;&nbsp;$</strong>
                                     </span>
                                     <span style="float: left; width: 80%; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtDAWBox6" runat="server" Style="" />
                                     </span>
                                 </td>
                             </tr>
                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                 <td style="width: 80%; padding-bottom: 2%; margin-right: 10%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>7.</strong>
                                     </span>
                                     <span style="float: left; width: 80%;">Line 5 minus line 6. Enter the result, but not less than zero
                                     </span>
                                 </td>
                                 <td style="width: 20%; vertical-align: bottom; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>7&nbsp;&nbsp;$</strong>
                                     </span>
                                     <span style="float: left; width: 80%; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtDAWBox7" runat="server" Style="border-bottom: 1px solid;" />
                                     </span>
                                 </td>
                             </tr>
                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                 <td style="width: 80%; padding-bottom: 2%; margin-right: 10%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>8.</strong>
                                     </span>
                                     <span style="float: left; width: 80%;">Divide the amount on line 7 by $1,144**. (Use whole numbers only). Enter the result here and on the HW-4 worksheet,
                           line H above
                                     </span>
                                 </td>
                                 <td style="width: 20%; vertical-align: bottom; padding-bottom: 2%;">
                                     <span style="float: left; padding-right: 9%;">
                                         <strong>8</strong>
                                     </span>
                                     <span style="float: left; width: 80%; border-bottom: 2px solid;">
                                         <asp:TextBox ID="txtDAWBox8" runat="server" Style="border-bottom: 1px solid;" />
                                     </span>
                                 </td>
                             </tr>

                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                 <td colspan="2" style="width: 80%; padding-bottom: 2%; margin-right: 10%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>*</strong>
                                     </span>
                                     <span style="float: left; width: 90%;">Nonresidents and part-year residents: On line 2, enter the amount appropriate to your filing status multiplied by the ratio of your Hawaii adjusted
                           gross income to total adjusted gross income from all sources.
                                     </span>
                                 </td>
                             </tr>
                             <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                 <td colspan="2" style="width: 80%; padding-bottom: 2%; margin-right: 10%;">
                                     <span style="float: left; padding-right: 2%;">
                                         <strong>**</strong>
                                     </span>
                                     <span style="float: left; width: 90%;">Nonresidents and part-year residents: Divide the amount on line 7 by $1,144 multiplied by the ratio of your Hawaii adjusted gross income to total
                            adjusted gross income from all sources.
                                     </span>
                                 </td>
                             </tr>
                         </tbody>
                     </table>

                 </div>
             </div>

         </div>
       
        <div id="MainForm" style="margin-left:3%; margin-right:2%;">
           <table style="width:100%; align-self:center;">
               <tbody>
                   <tr>
                       <td style="width: 20%; vertical-align: top;" rowspan="2" colspan="1">
                           <span style="float: left; font-size: large;"><strong>FORM HW-4
                               <br />
                               (REV. 2021)</strong></span>
                       </td>
                       <td colspan="1" style="width: 60%; text-align: center; font-size: large; padding-bottom: 1%; padding-top: 1%;">
                           <span>
                               <strong>STATE OF HAWAII — DEPARTMENT OF TAXATION</strong><br />
                           </span>
                       </td>
                       <td colspan="1" style="width: 20%; text-align: center;" rowspan="2"></td>
                   </tr>
                   <tr>
                       <td style="font-size: x-large; text-align: center; width: 60%; padding-bottom: 2%;">
                           <span>
                               <strong>EMPLOYEE’S WITHHOLDING ALLOWANCE AND STATUS CERTIFICATE</strong>
                           </span>
                       </td>
                   </tr>
               </tbody>
           </table>
        
            <table style="width: 100%; border-collapse: collapse; margin: auto; padding: 1px; align-content: center;">
                <tbody style="margin-bottom: auto; width: 90%;">
                    <tr>
                        <td style="width: 50%;">&nbsp;</td>
                        <td style="width: 2%;">&nbsp;</td>
                        <td style="width: 10%;">&nbsp;</td>
                        <td style="width: 20%;">&nbsp;</td>
                        <td style="width: 2%;">&nbsp;</td>
                        <td style="width: 16%;">&nbsp;</td>

                    </tr>
                    <tr style="border-top: 3px solid black; border-bottom: 3px solid black;">
                        <td colspan="6" style="border-top: 3px solid black; border-bottom: 3px solid black; padding-top: 1%; padding-bottom: 1%; font-size: x-large;">
                            <span><strong>Section A</strong> (to be completed by the employee)</span>
                        </td>
                    </tr>

                    <tr style="border-top: 3px solid black; border-bottom: 3px solid black;">
                        <td colspan="1" style="padding-bottom: 2px; border-top: 3px solid black; border-bottom: 3px solid black;" class="HRETan">
                            <span style="float: left; padding-right: 2%;">
                                <strong>1</strong>
                            </span>
                            <span style="float: left; width: 80%;">
                                Type or print your full name
                            </span>
                            <span style="padding-left: 5px; padding-top: 3px;">
                                <strong>
                                    <br />
                                    <br />
                                    <asp:Label ID="lblFullName" runat="server" Style="width: 97%; float: right;" />
                                </strong>
                            </span>
                        </td>
                        <td colspan="1" style="text-align: center; vertical-align: top; border: 3px solid black; border-right: 0px !important;" class="HRETan">
                            <span><strong>2</strong></span>
                        </td>
                        <td colspan="4" style="padding-bottom: 2px; border-top: 3px solid black; border-bottom: 3px solid black;" class="HRETan">

                            <span style="float: left; width: 80%;">
                                Your social security number
                            </span>

                            <span style="padding-top: 3px;">
                                <strong>
                                    <br />
                                    <br />
                                    <asp:Label ID="lblSSNumber" runat="server" Style="width: 97%; float: left;" />
                                </strong>
                            </span>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="1" style="padding-bottom: 2px; border-top: 3px solid black; border-right: 3px solid black" class="HRETan">

                            <span style="float: left; width: 100%; padding-bottom: 2%;">Home address (number and street or rural route)
                            </span>

                            <span style="vertical-align: bottom;">
                                <strong>
                                    <asp:Label ID="lblAddressCombined" runat="server" Style="width: 97%; padding: 0px;" />
                                </strong>
                            </span>
                        </td>
                        <td rowspan="2" colspan="1" style="text-align: center; vertical-align: top; border-top: 3px solid black; padding-top: 5px; border-bottom: 3px solid black;">
                            <span style="margin-top: 5%"><strong>3</strong></span>
                        </td>
                        <td rowspan="2" colspan="1" style="text-align: left; vertical-align: top; padding-top: 5px; border-bottom: 3px solid black;">
                            <span>Marital Status</span>
                        </td>
                        <td rowspan="2" colspan="3" style="margin: auto; border-left: none !important; border-top: 3px solid black; border-bottom: 3px solid black; padding-top: 0px;">
                            <strong>
                                <label style="margin-top: 0px;">
                                    <asp:CheckBox ID="chkSingle" runat="server" Text="&nbsp;Single" onclick="single(this)" />
                                </label>
                                <label style="margin-top: 0px;">
                                    <asp:CheckBox ID="chkMarried" runat="server" Text="&nbsp;Married" onclick="married(this)" />
                                </label>
                                <br />
                                <label>
                                    <asp:CheckBox ID="chkMarriedWHSR" runat="server" Text="&nbsp;Married, but withhold at higher Single rate" onclick="marriedwh(this)" />
                                </label>
                                <label>
                                    <asp:CheckBox ID="chkCertifiedDisabledPerson" runat="server" Text="&nbsp;Certified Disabled Person (not subject to withholding)" onclick="disabledperson(this)" />
                                </label>
                                <label>
                                    <asp:CheckBox ID="chkNRMilitarySpouse" runat="server" Text="&nbsp;Nonresident Military Spouse (not subject to withholding)" onclick="military(this)" />
                                </label>
                            </strong>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="padding-bottom: 2px; border-top: 3px solid black; border-bottom: 3px solid black; border-right: 3px solid black;" class="HRETan">

                            <span style="float: left; width: 100%; vertical-align: top; padding-bottom: 2%;">City or town, state, and Postal/ZIP code<br />
                            </span>

                            <span style="vertical-align: bottom;">
                                <strong>
                                    <asp:Label ID="lblCityStateZipCode" runat="server" Style="width: 97%; padding: 0px;" />
                                </strong>
                            </span>
                        </td>

                    </tr>

                    <tr>
                        <td colspan="4" style="padding-bottom: 1%;">
                            <span style="float: left; padding-right: 2%; padding-top: .5%;">
                                <strong>4</strong>
                            </span>
                            <span style="float: left; width: 80%; padding-top: .5%;">Total number of allowances you are claiming (from line I of the worksheet on page 2).<br />
                                <strong>(Note: Hawaii law does NOT allow “EXEMPT” status for withholding purposes.)</strong>
                            </span>
                        </td>
                        <td colspan="1" style="text-align: center; vertical-align: bottom; border: 3px solid black; padding-bottom: 1%;">
                            <span><strong>4</strong></span>
                        </td>

                        <td colspan="2" style="border-top: 3px solid black; border-bottom: 3px solid black; vertical-align: bottom; padding-bottom: 1%;">
                            <span style="vertical-align: bottom;">
                                <strong>
                                    <asp:TextBox ID="txttotalexemptions" runat="server" />
                                </strong>
                            </span>
                        </td>

                    </tr>

                    <tr>
                        <td colspan="4" style="padding-bottom: 2px;">
                            <span style="float: left; padding-right: 2%;">
                                <strong>5</strong>
                            </span>
                            <span style="float: left; width: 80%;">Additional amount, if any, you want deducted each pay period
                            </span>
                        </td>
                        <td colspan="1" style="text-align: center; border: 3px solid black;">
                            <span><strong>5</strong></span>
                        </td>
                        <td colspan="2" style="border-top: 3px solid black; border-bottom: 3px solid black;">
                            <span style="vertical-align: bottom;">
                                <strong>
                                    <asp:TextBox ID="txtAdditionalAmt" runat="server" />
                                </strong>
                            </span>
                        </td>
                    </tr>
                    <tr style="border-top: 3px solid black;">
                        <td colspan="6" style="padding-top: 5px; border-top: 3px solid black; vertical-align: middle;">
                            <span>I declare, under the penalties set forth in section 231-36, HRS, that I have correctly indicated my marital status and that the number of withholding
                                    allowances claimed on this certificate does not exceed the number to which I am entitled.
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-bottom: 3px solid black; padding-bottom: 2px; padding-top: 1%;">
                            <span>
                                <strong>(Date)</strong>
                                <span>
                                    <asp:TextBox ID="SignatureDate" runat="server" BackColor="#EFF3FB" Width="75%"></asp:TextBox>

                                </span>
                            </span>
                        </td>
                        <td colspan="5" style="border-bottom: 3px solid black; padding-bottom: 2px; padding-top: 1%;">
                            <span>
                                <strong>(signed)</strong>
                                <span>
                                    <asp:TextBox ID="txtSigned" runat="server" BackColor="#EFF3FB" Width="75%"></asp:TextBox>

                                </span>
                            </span>

                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" style="padding-top: 3%; padding-bottom: 1%; border-bottom: 3px solid black; font-size: x-large;">
                            <span>
                                <strong>Section B</strong> (to be completed by the employer)
                            </span>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="3" style="padding-bottom: 2px; border-top: 3px solid black; border-bottom: 3px solid black;" class="HRETan">
                            <span style="float: left; padding-right: 2%;">
                                <strong>1</strong>
                            </span>
                            <span style="float: left; width: 80%;">
                                Employer’s name
                            </span>
                            <span style="padding-left: 5px; padding-top: 3px;">
                                <strong>
                                    <br />
                                    <br />
                                    <asp:Label ID="lblEmployerFullName" runat="server" Style="width: 97%; float: left;" />
                                </strong>
                            </span>
                        </td>
                        <td colspan="3" style="padding-bottom: 2px; border-top: 3px solid black; border-bottom: 3px solid black; border-left: 3px solid black;" class="HRETan">
                            <span style="float: left; padding-right: 2%; padding-left: 3px;">
                                <strong>2</strong>
                            </span>
                            <span style="float: left; width: 80%;">
                                Hawaii tax identification number
                            </span>
                            <span style="padding-left: 5px; padding-top: 3px; width: 100%; padding-left: 3px;">
                                <strong>
                                    <br />
                                    <br />
                                    <span style="float: left; padding-right: 2px; padding-left: 3px;">WH -</span>
                                    <asp:Label ID="lblEmployerHawaiiTaxID" runat="server" Style="width: fit-content; float: left;" />
                                </strong>
                            </span>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2" style="padding-bottom: 2px; border-top: 3px solid black; border-bottom: 3px solid black;" class="HRETan">

                            <span style="float: left; width: 80%;">Employer’s address
                            </span>



                            <span style="padding-left: 5px; padding-top: 3px;">
                                <strong>
                                    <br />
                                    <br />
                                    <asp:Label ID="lblEmployerCombinedAddress" runat="server" Style="width: 97%; float: Left;" />
                                </strong>
                            </span>
                        </td>

                        <td colspan="4" style="padding-bottom: 2px; border-top: 3px solid black; border-bottom: 3px solid black; border-left: 3px solid black; padding-left: 3px;" class="HRETan">

                            <span style="float: left; width: 80%;">
                                City or town, state, and Postal/ZIP code
                            </span>
                            <span style="padding-left: 5px; padding-top: 3px;">
                                <strong>
                                    <br />
                                    <br />
                                    <asp:Label ID="lblEmployerCityStateZipCode" runat="server" Style="width: 60%; float: left;" />
                                </strong>
                            </span>
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>
       
       <br />
       <div id="divFormFooter" class="row HRERewrap">
           <br />
           <br />
           <div style="float: right;">
               <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valw4" OnClick="btnSave_Click" />
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

       
        input[type=text], textarea {outline: none; min-height: 20px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; width:100%; }
        input[type="checkbox"] {width: 20px; height: 20px; cursor: pointer; background: #f0f4fa; display: inline-block; padding-left:3px; padding-right: 3px; color: black;}
        input[type="label"] {background-color: #f5f5f0;}
        table {background-color:white; color:black;  border-collapse:collapse;font-size:larger; word-spacing:normal;}
        p {color:black;}
        li {color:black;}
        
        
        .HREwrapper {
            margin-left: auto; margin-right: auto; 

        }
        .HRESlateBlue {
            background-color: #ccd5e4; 

        }
        .HREWhite {
            background-color: white; border: 1px solid grey; padding:10px; 

        }
        .HREOffWhite {
            background-color: #F9F9F9; 

        }
        .HRETan {
            background-color: #f5f5f0; padding-left:5px;

        }
        .HRELightBlue {
            background-color: #EFF3FB; 

        }
        .HRERewrap {
            margin-right: 5%; 

        }
        .HREpadR10 {
            padding-right: 20px; float:right; 

        }
        .underline {
            border-bottom: 1px solid !important; width: 100%; display: inline-block;

        }
        .HREError {
            color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;

        }
        .HRESuccess {
            color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;

        }
        .row{
            text-align:center;
        }
         input[type=text], textarea {
            outline: none;
            min-height: 20px;
            background-color: #f0f4fa;
            border: 1px solid #e0eaf7 !important;
        }

        input[type="checkbox"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
            background: #f0f4fa;
            display: inline-block;
            padding-left: 3px;
            padding-right: 3px;
            color: black;
        }

        input[type="label"] {
            background-color: #f5f5f0;
        }

        table td{
            padding-left:0px;
        }
        table {
            background-color: white;
        }

        p {
            color: black;
        }

        li {
            color: black;
        }

        div {
            color: black;
        }

        .HREwrapper {
            text-align:center;
            width:95%;
            
        }

        .HRESlateBlue {
            background-color: #ccd5e4;
        }

        .HREWhite {
            background-color: white;
            border: 1px solid grey;
            padding: 10px;
            margin-right:0px;
        }

        .HREOffWhite {
            background-color: #F9F9F9;
        }

        .HRETan {
            background-color: #f5f5f0;
            padding-left: 5px;
        }

        .HRELightBlue {
            background-color: #EFF3FB;
            padding-right:10px;
        }

        .HRERewrap {
            margin: auto;
        }

        .HREpadR10 {
            padding-right: 20px;
            float: right;
        }

        .underline {
            border-bottom: 1px solid !important;
            width: 100%;
            display: inline-block;
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

        .cels {
            padding-top: 5px;
            padding-left: 4px;
        
        }
        
        .HRESlateBlue {
            background-color: #ccd5e4; 

        }
        .HREWhite {
            background-color: white; border: 1px solid grey; padding:10px; 

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
        .HRERewrap {margin-right: auto; }
        .HREpadR10 {
            padding-right: 20px; float:right; 

        }
        
        </style>
</asp:Content>
