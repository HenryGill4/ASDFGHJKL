<%@ Page Title="MS State Withholding" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_MS.aspx.vb" 
    Inherits="HReaseApp.EE_W4_MS" 
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
    <meta name="viewport" content="initial-scale = 1.0, maximum-scale = 1.0, user-scalable = no, width = device-width"/>
    <script type="text/javascript">

        function HusbandOver65(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingleOver65]').prop("checked", false);
                $('input:checkbox[id$=chkBlindSingle]').prop("checked", false);
                $('input:text[id$=txtCount1]').val(1);
                $('input:text[id$=txtCount3]').val(0);
                $('input:text[id$=txtCount6]').val(0);

                var a = 1

            }
            else {
                $('input:text[id$=txtCount1]').val(0);

                var a = 0

            }

            var b = $('input:text[id$=txtCount2]').val()
            var c = $('input:text[id$=txtCount4]').val()
            var d = $('input:text[id$=txtCount5]').val()

            var g = parseFloat(a) + parseFloat(b) + parseFloat(c) + parseFloat(d)
            var h = g * 1500
            $('input:text[id$=txtCountTotal]').val(g);
            $('input:text[id$=txtBlindTotal]').val(h);

        };

        function WifeOver65(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingleOver65]').prop("checked", false);
                $('input:checkbox[id$=chkBlindSingle]').prop("checked", false);
                $('input:text[id$=txtCount2]').val(1);
                $('input:text[id$=txtCount3]').val(0);
                $('input:text[id$=txtCount6]').val(0);

                var a = 1

            }
            else {
                $('input:text[id$=txtCount2]').val(0);

                var a = 0

            }

            var b = $('input:text[id$=txtCount1]').val()
            var c = $('input:text[id$=txtCount4]').val()
            var d = $('input:text[id$=txtCount5]').val()

            var g = parseFloat(a) + parseFloat(b) + parseFloat(c) + parseFloat(d)
            var h = g * 1500
            $('input:text[id$=txtCountTotal]').val(g);
            $('input:text[id$=txtBlindTotal]').val(h);

        };

        function SingleOver65(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkHusbandOver65]').prop("checked", false);
                $('input:checkbox[id$=chkWifeOver65]').prop("checked", false);
                $('input:checkbox[id$=chkBlindHusband]').prop("checked", false);
                $('input:checkbox[id$=chkBlindWife]').prop("checked", false);
                $('input:text[id$=txtCount3]').val(1);
                $('input:text[id$=txtCount1]').val(0);
                $('input:text[id$=txtCount2]').val(0);
                $('input:text[id$=txtCount4]').val(0);
                $('input:text[id$=txtCount5]').val(0);

                var a = 1

            }
            else {
                $('input:text[id$=txtCount3]').val(0);

                var a = 0

            }

            var b = $('input:text[id$=txtCount6]').val()

            var g = parseFloat(a) + parseFloat(b)
            var h = g * 1500
            $('input:text[id$=txtCountTotal]').val(g);
            $('input:text[id$=txtBlindTotal]').val(h);

        };

        function BlindHusband(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingleOver65]').prop("checked", false);
                $('input:checkbox[id$=chkBlindSingle]').prop("checked", false);
                $('input:text[id$=txtCount4]').val(1);
                $('input:text[id$=txtCount3]').val(0);
                $('input:text[id$=txtCount6]').val(0);

                var a = 1

            }
            else {
                $('input:text[id$=txtCount4]').val(0);

                var a = 0

            }

            var b = $('input:text[id$=txtCount1]').val()
            var c = $('input:text[id$=txtCount2]').val()
            var d = $('input:text[id$=txtCount5]').val()

            var g = parseFloat(a) + parseFloat(b) + parseFloat(c) + parseFloat(d)
            var h = g * 1500
            $('input:text[id$=txtCountTotal]').val(g);
            $('input:text[id$=txtBlindTotal]').val(h);

        };
        function BlindWife(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingleOver65]').prop("checked", false);
                $('input:checkbox[id$=chkBlindSingle]').prop("checked", false);
                $('input:text[id$=txtCount5]').val(1);
                $('input:text[id$=txtCount3]').val(0);
                $('input:text[id$=txtCount6]').val(0);

                var a = 1

            }
            else {
                $('input:text[id$=txtCount5]').val(0);

                var a = 0

            }

            var b = $('input:text[id$=txtCount1]').val()
            var c = $('input:text[id$=txtCount2]').val()
            var d = $('input:text[id$=txtCount4]').val()

            var g = parseFloat(a) + parseFloat(b) + parseFloat(c) + parseFloat(d)
            var h = g * 1500
            $('input:text[id$=txtCountTotal]').val(g);
            $('input:text[id$=txtBlindTotal]').val(h);

        };

        function BlindSingle(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkHusbandOver65]').prop("checked", false);
                $('input:checkbox[id$=chkWifeOver65]').prop("checked", false);
                $('input:checkbox[id$=chkBlindHusband]').prop("checked", false);
                $('input:checkbox[id$=chkBlindWife]').prop("checked", false);
                $('input:text[id$=txtCount6]').val(1);
                $('input:text[id$=txtCount1]').val(0);
                $('input:text[id$=txtCount2]').val(0);
                $('input:text[id$=txtCount4]').val(0);
                $('input:text[id$=txtCount5]').val(0);

                var a = 1

            }
            else {
                $('input:text[id$=txtCount6]').val(0);

                var a = 0

            }

            var b = $('input:text[id$=txtCount3]').val()

            var g = parseFloat(a) + parseFloat(b)
            var h = g * 1500
            $('input:text[id$=txtCountTotal]').val(g);
            $('input:text[id$=txtBlindTotal]').val(h);
        };


        function single(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSpouseNotEmployed]').prop("checked", false);
                $('input:checkbox[id$=chkSpouseIsEmployed]').prop("checked", false);
                $('input:checkbox[id$=chkHeadOfHousehold]').prop("checked", false);
                $('input:text[id$=txtSingleAmount]').val(6000);
                $('input:text[id$=txtSpouseNotEmployedAmount]').val(0);
                $('input:text[id$=txtSpouseISEmployedAmount]').val(0);
                $('input:text[id$=txtHeadOfHouseholdAmount]').val(0);
                $('input:text[id$=txtTotalExemptions]').val(0)

                var a = '6000'

                if ($('input:text[id$=txtDependentAmount]').val() == '') { var b = '0' };
                { var b = $('input:text[id$=txtDependentAmount]').val() };

                if ($('input:text[id$=txtBlindTotal]').val() == '') { var c = '0' };
                { var c = $('input:text[id$=txtBlindTotal]').val() };

                var sum = (parseFloat(a) + parseFloat(b) + parseFloat(c))
                $('input:text[id$=txtTotalExemptions]').val(sum);

                /*$('input:text[id$=txtSignature]').val(c);*/
            }
        }
        function SpouseNotEmployed(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingle]').prop("checked", false);
                $('input:checkbox[id$=chkSpouseIsEmployed]').prop("checked", false);
                $('input:checkbox[id$=chkHeadOfHousehold]').prop("checked", false);
                $('input:text[id$=txtSingleAmount]').val(0);
                $('input:text[id$=txtSpouseNotEmployedAmount]').val(12000);
                $('input:text[id$=txtSpouseISEmployedAmount]').val(0);
                $('input:text[id$=txtHeadOfHouseholdAmount]').val(0);
                $('input:text[id$=txtTotalExemptions]').val(0)

                var a = '12000'

                if ($('input:text[id$=txtDependentAmount]').val() == '') { var b = '0' };
                { var b = $('input:text[id$=txtDependentAmount]').val() };

                if ($('input:text[id$=txtBlindTotal]').val() == '') { var c = '0' };
                { var c = $('input:text[id$=txtBlindTotal]').val() };

                var sum = (parseFloat(a) + parseFloat(b) + parseFloat(c))
                $('input:text[id$=txtTotalExemptions]').val(sum);
            }
        }
        function SpouseIsEmployed(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingle]').prop("checked", false);
                $('input:checkbox[id$=chkSpouseNotEmployed]').prop("checked", false);
                $('input:checkbox[id$=chkHeadOfHousehold]').prop("checked", false);
                $('input:text[id$=txtSingleAmount]').val(0);
                $('input:text[id$=txtSpouseNotEmployedAmount]').val(0);
                /*$('input:text[id$=txtSpouseISEmployedAmount]').val();*/
                $('input:text[id$=txtHeadOfHouseholdAmount]').val(0);
                $('input:text[id$=txtTotalExemptions]').val(0)

                if ($('input:text[id$=txtSpouseISEmployedAmount]').val() == '') { var a = '0' };
                { var a = $('input:text[id$=txtSpouseISEmployedAmount]').val() };

                if ($('input:text[id$=txtDependentAmount]').val() == '') { var b = '0' };
                { var b = $('input:text[id$=txtDependentAmount]').val() };

                if ($('input:text[id$=txtBlindTotal]').val() == '') { var c = '0' };
                { var c = $('input:text[id$=txtBlindTotal]').val() };

                var sum = (parseFloat(a) + parseFloat(b) + parseFloat(c))
                $('input:text[id$=txtTotalExemptions]').val(sum);

            }
        }
        function HeadOfHousehold(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingle]').prop("checked", false);
                $('input:checkbox[id$=chkSpouseNotEmployed]').prop("checked", false);
                $('input:checkbox[id$=chkSpouseIsEmployed]').prop("checked", false);
                $('input:text[id$=txtSingleAmount]').val(0);
                $('input:text[id$=txtSpouseNotEmployedAmount]').val(0);
                $('input:text[id$=txtSpouseISEmployedAmount]').val(0);
                $('input:text[id$=txtHeadOfHouseholdAmount]').val(9500);
                $('input:text[id$=txtTotalExemptions]').val(0)

                var a = '9500'

                if ($('input:text[id$=txtDependentAmount]').val() == '') { var b = '0' };
                { var b = $('input:text[id$=txtDependentAmount]').val() };

                if ($('input:text[id$=txtBlindTotal]').val() == '') { var c = '0' };
                { var c = $('input:text[id$=txtBlindTotal]').val() };

                var sum = (parseFloat(a) + parseFloat(b) + parseFloat(c))
                $('input:text[id$=txtTotalExemptions]').val(sum);
            }
        }

        $(function () {
            var Boxd = $('input:text[id$=txtNumberOfDependents]').keyup(foo);

            var Box1 = $('input:text[id$=txtSingleAmount]').keyup(foo);
            var Box2a = $('input:text[id$=txtSpouseNotEmployedAmount]').keyup(foo);
            var Box2b = $('input:text[id$=txtSpouseISEmployedAmount]').keyup(foo);
            var Box3 = $('input:text[id$=txtHeadOfHouseholdAmount]').keyup(foo);
            var Box4 = $('input:text[id$=txtDependentAmount]').keyup(foo);
            var Box5 = $('input:text[id$=txtBlindTotal]').keyup(foo);

            $('input:text[id$=hdnPW]').val(document.getElementById('divResPW').childNodes[1].innerHTML);

            function foo() {
                var dmult = Boxd.val();

                var t = (parseFloat(dmult) * 1500);
                $('input:text[id$=txtDependentAmount]').val(t);

                var a = Box1.val();
                var b = Box2a.val();
                var c = Box2b.val();
                var d = Box3.val();
                var e = Box4.val();
                var f = Box5.val();

                var sum = add(a, b, c, d, e, f);
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

    <div class="HREwrapper" style=" text-align:center; ">
        
        <div id="PageTitle" class="HRERewrap">
            <div style="text-align:center;">
                <br />
                <h4><b>Mississippi Form 89-350</b></h4>
            </div>
            <p>&nbsp;</p>
        </div>

        <div id="TopHeader" class="form-group" style=" margin-top:-40px;">                  
            <div id="divError" runat="server" class="HREError" visible="false">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server"></asp:Label>
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

        <div id="divInstructionTitle" class="well HRESlateBlue HRERewrap" style="width:95%; margin-bottom:5%;" >
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px;" />

        </div>

        <div id="divInstructions" class="HRETan instruction_toggle" style="margin:0 auto; width:95%;">
            <div style="font-size: x-large; text-align:center;padding-top:10px; padding-bottom:10px; border-bottom:2px solid black;">
                <b>INSTRUCTIONS</b>
            </div>
            <div class="form-group HREWhite" style="color:black;">
                <div class="col-md-6" style="border-right: 1px solid black;">
                    <table style="background-color:transparent;">
                        <tr>
                            <td colspan="20">
                                <div style="margin-bottom: 5px; margin-top: 5px;">
                                    1. <u>The personal exemptions allowed:</u>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td colspan="6">(a) Single Individuals   
                            </td>
                            <td colspan="4">$6,000 

                            </td>

                            <td colspan="5">(d) Dependents
                            </td>
                            <td colspan="4">$1,500 
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td colspan="6">(b) Married Individuals (Jointly) 
                            </td>
                            <td colspan="4">$12,000
                            </td>
                            <td colspan="5">(e) Age 65 andOver
                            </td>
                            <td colspan="4">$1,500 
                            </td>
                        </tr>

                        <tr>
                            <td>&nbsp;</td>
                            <td colspan="6">(c) Head of family 
                            </td>
                            <td colspan="4">$9,500 
                            </td>
                            <td colspan="5">(f) Blindness 
                            </td>
                            <td colspan="4">$1,500 
                            </td>
                        </tr>
                        <tr>
                            <td colspan="20">
                                <div class="under-line" style="margin-bottom: 5px; margin-top: 5px;">
                                    <u>2. Claiming personal exemptions: </u>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td>&nbsp; </td>
                            <td colspan="19">(a) Single Individuals enter $6,000 on Line 1. 
                            </td>
                        </tr>

                        <tr>
                            <td>&nbsp; </td>
                            <td colspan="19">
                                <div class="under-line" style="margin-bottom: 5px; margin-top: 5px;">
                                    <u>(b) Manied individuals are allowed a joint exemption of $12.000.</u>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp; </td>
                            <td colspan="19">If the spouse is not employed, enter $12,000 on Line 2(a). If the spouse is employed, the exemption of $12,000 may be divided between taxpayer and spouse in any manner they choose - in multiples of $500. For example, the taxpayer may claim $6,500 and the spouse claims $5,500; or the taxpayer may claim $8,000 and the spouse claims $4,000. The total claimed by the taxpayer and spouse may nol exceed $12,000. Enter amount claimed by
					    you on Line 2(b)
                    
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp; </td>
                            <td colspan="19">
                                <div class="under-line" style="margin-bottom: 5px; margin-top: 5px;">
                                    <u>(c) Head of Family</u>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp; </td>
                            <td colspan="19">
                                A head of family is a single individual who maintains a home which is the principal place of abode for himself and at l
                                east one other dependent. Single individuals qualifying as a head of family enter $9,500 on Line 3. If the taxpayer has more than one dependent, additional
					            exemptions are applicable. See item (d).
                    
                            </td>
                        </tr>

                        <tr>
                            <td>&nbsp; </td>
                            <td colspan="19">
                                <u>(d) An additional exemption of $1.500 may generally be claimed for each dependent of the
					                    taxpayar.</u>  A dependent is any relative who receives chief support from the taxpayer and who qualifies as a dependent for Federal income tax 
                                        purposes. Head of Family individuals may claim an additional exemption for each dependent excluding the one which is required for head of family status. For example, a head of family taxpayer has 2 dependent children and his dependent molher living wilh him. The taxpayer may claim 2 additional exemptions. Married or single individuals may claim an addilional exemption for each dependent, but
                            </td>
                        </tr>

                    </table>
                </div>

                <div class="col-md-6">
                    <table style="background-color:transparent;">
                        <tr>
                            <td>&nbsp; </td>
                            <td colspan="19">should not include themselves or their spouse. Married taxpayers may divide the number of their 
                                dependents belween them in any manner they choose; for example, a married couple has 3 children 
                                who qualify as dependents. The taxpayer may claim 2 dependents and the spouse 1; or the taxpayer 
                                may claim 3 dependenls and the spouse none. Enter the amount of dependenl exemption on Line 4.
                            </td>
                        </tr>

                        <tr>
                            <td style="vertical-align: text-bottom;">
                                (e) 
                            </td>
                            <td colspan="19">
                                <u>An additional exemption of $1,500 may be claimed by either taxpayerior spouso or both if
					                either or both have reached the age of 65 before the close of the taxable year.</u>  
                                    No additional exemption is authorized for dependents by reason of age. Check applicable 
                                    blocks on Line 5.
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: text-bottom;">(f) </td>
                            <td colspan="19">
                                    An addilional exemption of $1,500 may be claimed by either taxpayer or spouse or both if 
                                    either or both are blind. No additional exemption is authorized for dependents by reason of 
                                    blindness. Check applicable blocks on Line 5. Multiply number of blocks checked on Line 5 
                                    by $1,500 and enter amount of exemption claimed
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: text-bottom;">
                                3.
                            </td>
                            <td colspan="19">
                                <u>Total Exemption Claimed:</u>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td colspan="19">
                                    Add the amount of exemptions claimed in each category and enter the total on Line 6. This 
                                    amount will be used as a basis for Withholding income tax under the appropriate withholding
					                tables .
                            </td>
                        </tr>

                        <tr>
                            <td style="vertical-align: text-bottom;">
                                4.
                            </td>
                            <td colspan="19">
                                <b>A NEW EXEMPTION CERTIFICATE MUST BE FILED WITH YOUR EMPLOYER WITHIN
					                30 DAYS AFTER ANY CHANGE IN YOUR EXEMPTION STATUS.
                                </b>
                            </td>
                        </tr>

                        <tr>
                            <td style="vertical-align: text-bottom;">5. </td>
                            <td colspan="19">
                                <b>PENALTIES ARE IMPOSED FOR WILLFULLY SUPPLYING FALSE INFORMATION.
                                </b>
                            </td>
                        </tr>

                        <tr>
                            <td style="vertical-align: text-bottom;">6. </td>
                            <td colspan="19">
                                <b>IF THE EMPLOYEE FAILS TO FILE AN EXEMPTION CERTIFICATE WITH HIS
					                EMPLOYER, INCOME TAX MUST BE WITHHELD BY THE EMPLOYER ON TOTAL
					                WAGES WITHOUT THE BENEFIT OF EXEMPTION. 
                                </b>
                            </td>
                        </tr>

                        <tr>
                            <td style="vertical-align: text-bottom;">7. </td>
                            <td colspan="19">
                                <small>To comply with the Mililary Spouse Residency Relief Act (PL111-97) signed on November 11, 2009</small>

                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
<div id="MainFormHeader" style="text-align:left; margin-bottom:.5%; width:90%;">                
                <b>Form 89-350-20-8-1-000 (Rev. 08/20) </b>
            </div>
        <div id="MainForm" class="align-center" style="font-size:large;width:100%; margin:0 auto; text-align:center;">
            <div class="new-wrap ">
                <div class="leftbox mobile-hide">
                    <table class="lefttd" style="border-top:3px solid black; border-left:3px solid black; width: 100%; position:relative;">
                  
                        <tr>
                             <td colspan="1" style="text-align: center;  padding-bottom:24%; border-bottom:3px solid black;">
                                 <br />
                            <img src="images/mississippi-logo.png"  style="height:70%; width:70%; margin-top: 5px;" />
                            <br/>

                        </td>
                        </tr>
                        <tr>
                            <td style="border:1px solid black; padding:15%;">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="tdpadd" colspan="1" style="background: #BFBFBF; border: 1px solid black; ">
                                <b>EMPLOYEE:</b>
                            </td>

                        </tr>
                        <tr>
                            <td colspan="1" style="border: 1px solid black; vertical-align: top; padding-bottom:31%;">
                                <b>File this form with your employer.</b> Otherwise, you must withhold Mississippi income tax from the full amount of your wages.
                            </td>
                        </tr>
                        <tr>
                           <td class="tdpadd" colspan="1" style="background: #BFBFBF; border: 1px solid black; ">
                                <b>EMPLOYER:</b>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-bottom:53%; border:1px solid black;">
                                    <b>Keep this certificate with your records. </b>If the employee is believed to have claimed excess exemption, the Department of Revenue should be advised.
                                
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" style="border: 1px solid black; padding:4% 0 4% 0;">
                                <b>Military Spouses Residency Relief Act Exemption from Mississippi Withholding</b>
                            </td>
                        </tr>
                    </table>

                </div>
            
              <div class="grid-item">
                <table style="border-top:3px solid black;">
                    <tr style="border-right:3px solid black;">
                        
                        <td style="width:10%;"></td>
                        <td style="width:5%;"></td>
                        <td style="width:50%;"></td>
                        <td style="width:5%;"></td>
                    </tr>
                    <tr style="border-right:3px solid black;">
                            <td colspan="4" style="font-size: 30px; font-weight: 600; font-family: monospace; border-right:3px solid black;">
                            <div style="border-bottom: 2px solid; padding:1% 0 1% 0; text-align:center">
                                MISSISSIPPI EMPLOYEE'S WITHHOLDING EXEMPTION CERTIFICATE 
                            </div>
                        </td>
                        
                    </tr>
                    <tr style="border-right:3px solid black;">
                        <td colspan="4">
                            <div class="toprow" style="margin-bottom:2%; margin-top:2%;">
                                <div class="grid-item" style="padding-right:0px;"><b>Employee's Name </b><b><asp:Label ID="lblFullName" CssClass="underline HRETan lblname" runat="server" Width="70%"/></b></div>
                                <div class="grid-item"><b>SSN </b><b><asp:Label ID="lblSSNumber" CssClass="underline HRETan text-nowrap" runat="server" Width="60%" /></b></div>
                        </div>
                        </td>
                       
                    </tr>
                    
                    <tr style="border-right:3px solid black;">
                        <td colspan="4">
                            <div class="grid-container" style="align-content:center; font-size:17px; word-wrap:normal; margin-bottom:3%;">
                                <div class="grid-item" style="align-content:flex-start;">
                                    <b>Employee's Residence</b>
                                </div>
                                <div class="grid-item text-center"> 
                                    <label style="width:90%; display:block;">
                                        <b><asp:Label ID="lblFullAddress" CssClass="underline HRETan" runat="server" Width="100%"/><br /></b>
                                        <b>Number and Street</b>
                                    </label>
                                </div>
                                <div class="grid-item text-center">
                                    <label style="width:90%; display:block;">
                                    <b><asp:Label ID="lblCity" CssClass="underline HRETan" runat="server" Width="90%"/><br /></b>
                                    <b>City or Town</b>
                                    </label>
                                </div>
                                <div class="grid-item text-center">
                                    <label style="width:90%; display:block;">
                                    <b><asp:Label ID="lblState" CssClass="underline HRETan" runat="server" Width="90%"/><br /></b>
                                        <b>State</b>
                                    </label>
                                </div>
                                <div class="grid-item text-center">
                                    <label style="width:90%; display:block;">
                                    <b><asp:Label ID="lblZipCode" CssClass="underline HRETan" runat="server" Width="90%"/><br /></b>
                                        <b>Zip Code</b>
                                    </label>
                                </div>
                            </div>
                        </td>
                       
                    </tr>

                    <tr style="border: 1px solid black">
                       
                        <td colspan="4" style="background: #BFBFBF;">
                            <div style="text-align: center;"><b>CLAIM YOUR WITHHOLDING PERSONAL EXEMPTION</b></div>
                        </td>
                    </tr>
                    <tr text-align:"center" style="border: 1px solid black">
                        <td colspan="1" style="border: 1px solid black; text-align: center;"><b>Marital Status </b>
                        </td>
                        <td colspan="2" style="border: 1px solid black; text-align: center;"><b>Personal Exemption Allowed </b>
                        </td>
                        <td colspan="1" style="border: 1px solid black; text-align: center;"><b>Amount claimed </b>
                        </td>
                    </tr>
                    <tr style="border: 1px solid black;">
                       
                        <td colspan="1" style="border: 1px solid black;"><b>1. Single</b>
                        </td>
                        <td colspan="1">&nbsp;
                        </td>
                        <td colspan="1" style="border-right: 1px solid black;">
                            <label class="checkbox-inline">
                                <asp:CheckBox ID="chkSingle" runat="server" onclick="single(this)"/>
                                Enter $6,000 as exemption .... ►
                            </label>
                        </td>
                        <td colspan="1"><span class="text-nowrap">$ 
                            <asp:TextBox ID="txtSingleAmount" runat="server" Style="display: inline; width: 70%;" CssClass="input-bg center "></asp:TextBox>
                            </span>
                        </td>
                    </tr>
                    <tr style="border: 1px solid black">
                        
                        <td colspan="1" rowspan="2" style="border: 1px solid black;">
                            <b>2. Marital Status</b>
                            <br />
                            <small><b>Check One</b></small>
                        </td>
                        <td colspan="1" style="border: 1px solid black">(a)
                        </td>
                        <td colspan="1" style="border: 1px solid black">
                            <label class="checkbox-inline">
                                <asp:CheckBox ID="chkSpouseNotEmployed" runat="server" onclick="SpouseNotEmployed(this)" />
                                Spouse NOT employed: Enter $12,000 .... ►
                            </label>
                        </td>
                        <td colspan="1" class="text-nowrap">$
					        <asp:TextBox ID="txtSpouseNotEmployedAmount" runat="server" Style="display: inline; width: 70%; padding-left:0px;" CssClass="input-bg center"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="border: 1px solid black">
                        <td colspan="1" style="border: 1px solid black">(b)
                        </td>
                        <td colspan="1" style="border: 1px solid black">
                            <label class="checkbox-inline">
                                <asp:CheckBox ID="chkSpouseIsEmployed" runat="server" onclick="SpouseIsEmployed(this)" />
                                Spouse IS employed: Enter that part of $12,000 claimed by you in multiples of $500. See instructions 2(b) below . 
                            </label>
                        </td>
                        <td colspan="1" class="text-nowrap" style="border: 1px solid black">$
					    <asp:TextBox ID="txtSpouseISEmployedAmount" runat="server" Style="display: inline; width: 70%;" CssClass="input-bg center" onblur="SpouseIsEmployed(this)"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="border: 1px solid black">
                        <td colspan="1" style="border: 1px solid black;"><b>3. Head of Family</b>
                        </td>
                        <td colspan="1">&nbsp;
                        </td>
                        <td colspan="1" style="border-right: 1px solid black">
                            <label class="checkbox-inline">
                                <asp:CheckBox ID="chkHeadOfHousehold" runat="server" onclick="HeadOfHousehold(this)"/>
                                Enter $9,500 as exemption. To qualify as head of family, you must be single and have a dependent living in the home with you. See instructions 2(c) and 2 (d) below ... ►
                            </label>

                        </td>
                        <td colspan="1">$
					    <asp:TextBox ID="txtHeadOfHouseholdAmount" runat="server" Style="display: inline; width: 70%;" CssClass="input-bg center"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="border: 1px solid black">
                        
                        <td colspan="1" style="border: 1px solid black;">
                             
                            <b>4. Dependents </b>
                                <div style="text-align: center; padding-top: 8px; display:flex !important; width:80%; ">
                                    <asp:TextBox ID="txtNumberOfDependents" runat="server" Style="height:50px; width:95% !important; margin-bottom: 0px; border: 1px solid !important; text-align: center; vertical-align: middle;"  placeholder="Number Claimed" CssClass="input-bg"></asp:TextBox>
					            </div>
                        </td>
                        <td colspan="2" style="border: 1px solid black">You may claim $1,500 for each dependent*, other than for taxpayer and spouse, who receives chief support from you and who qualifies as a dependent for Federal income tax purposes.
                            <br />
					        * A head of family may claim $1,500 for each dependent excluding the one which qualifies you as head of family. Multiply number of dependents claimed by you by $1,500. Enter amount claimed...
					
                        </td>
                        <td colspan="1" style="border: 1px solid black; display:center;">$
					        <asp:TextBox ID="txtDependentAmount" runat="server" Style="display: inline; width: 70%;" CssClass="input-bg text-center"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="border: 1px solid black">
                        <td colspan="1" style="border: 1px solid black;">
                            <b>5. Age and Blindness</b>
                        </td>
                        <td colspan="2" style="border-right: 1px solid black">
                            <div>
                                • Age 65 or older &nbsp;
						
						    <label class="checkbox-inline">
                                <asp:CheckBox ID="chkHusbandOver65" runat="server" Text="&nbsp;Husband" TextAlign="right" onclick="HusbandOver65(this)" />

                            </label>

                                <label class="checkbox-inline">
                                    <asp:CheckBox ID="chkWifeOver65" runat="server" Text="&nbsp;Wife" TextAlign="right" onclick="WifeOver65(this)" />

                                </label>

                                <label class="checkbox-inline">
                                    <asp:CheckBox ID="chkSingleOver65" runat="server" Text="&nbsp;Single" TextAlign="right" onclick="SingleOver65(this)" />

                                </label>

                            </div>

                            <div>
                                • Blind &nbsp;
						    <label class="checkbox-inline">
                                <asp:CheckBox ID="chkBlindHusband" runat="server" Text="&nbsp;Husband" TextAlign="right" onclick="BlindHusband(this)" />
                            </label>

                                <label class="checkbox-inline">
                                    <asp:CheckBox ID="chkBlindWife" runat="server" Text="&nbsp;Wife" TextAlign="right" onclick="BlindWife(this)" />
                                </label>

                                <label class="checkbox-inline">
                                    <asp:CheckBox ID="chkBlindSingle" runat="server" Text="&nbsp;Single" TextAlign="right" onclick="BlindSingle(this)" />
                                </label>

                            </div>

                            <div>
                                Multiply the number of blocks checked by $1,500. Enter the amount claimed ... ►
                            </div>
                            <div>
                                <b>* Note:</b> &nbsp;
						            No exemption allowed for age or blindness for dependents. 
                            </div>

                        </td>
                        <td colspan="1">$
					        <asp:TextBox ID="txtBlindTotal" runat="server" Style="display: inline; width: 70%;" placeholder="" CssClass="input-bg center"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="border: 1px solid black">
                        <td colspan="3" style="border-right: 1px solid black;">
                            <b>6. TOTAL AMOUNT OF EXEMPTION CLAIMED - Lines 1 through 5... ►</b>
                        </td>
                        <td colspan="1">
                            <b>$</b>
                            <asp:TextBox ID="txtTotalExemptions" runat="server" Style="display: inline; width: 70%;" placeholder="REQUIRED" text-align="center" CssClass="input-bg center"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="border: 1px solid black">
                        <td colspan="3" style="border-right: 1px solid black">
                            <b>7. Additional dollar amount of withholding per pay period if agreed to by your employer
                            </b>
                        </td>
                        <td colspan="1">
                            <b>$</b>
                            <asp:TextBox ID="txtAdditionalWithholding" runat="server" Style="display: inline; width: 70%;" CssClass="input-bg center"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="border: 1px solid black">
                        
                        <td colspan="3">8. If you meet the conditions set forth under the Service Member
					    Civil Relief, as amended by the Military Spouses Residency Relief Act, and have no Mississippi tax liability, write <b>"Exempt"</b> on Line 8. You must attach a copy of the Federal Form DD-2058 and a copy of your Military Spouse ID Card to this form so your employer can validate the exemption claim.. ►
					
                        </td>
                        <td colspan="1">
                            <span style="width:fit-content; outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important;">
                            <asp:CheckBox ID="ChkMilitarySpouse" CssClass="text-nowrap" runat="server" Text="&nbsp;EXEMPT" TextAlign="right"/>

                            </span>
                        </td>
                    </tr>
                   
                </table>
                  </div>  

            
        </div>

        <div class="row">
            <div class="col-md-12">
                I declare under the penalties imposed for filing false reports that the amount of exemption claimed on this certificate does not exceed the amount to which I am entitled or I am entitled to claim exempt status.
            </div>
            <div class="col-md-7">
                <b>Employee's Signature:</b> &nbsp;
		<asp:TextBox ID="txtSignature" runat="server" placeholder="Signature" Style="width: 70%;" CssClass=""></asp:TextBox>
            </div>
            <div class="col-md-5">
                <b>Date:</b> &nbsp; 
		<asp:TextBox ID="SignatureDate" CssClass="datepicker" runat="server" Style="width: 85%;"></asp:TextBox>
            </div>
        </div>

        <div class="row">
            <div class="clearfix">&nbsp;</div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valw4" OnClick="btnSave_Click" />
            </div>
            <div class="clearfix">&nbsp;</div>
        </div>
   
    <div style="visibility:hidden;">
                                txtCount1: <asp:TextBox ID="txtCount1" runat="server" Visible="true" ></asp:TextBox><br />
                                txtCount2: <asp:TextBox ID="txtCount2" runat="server" Visible="true" ></asp:TextBox><br />
                                txtCount3: <asp:TextBox ID="txtCount3" runat="server" Visible="true" ></asp:TextBox><br />
                                txtCount4: <asp:TextBox ID="txtCount4" runat="server" Visible="true" ></asp:TextBox><br />
                                txtCount5: <asp:TextBox ID="txtCount5" runat="server" Visible="true" ></asp:TextBox><br />
                                txtCount6: <asp:TextBox ID="txtCount6" runat="server" Visible="true" ></asp:TextBox><br />
                                txtCountTotal: <asp:TextBox ID="txtCountTotal" runat="server" Visible="true" ></asp:TextBox>
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
        @media only screen and (max-width: 479px) {
            .mobile-hide {
                display: none !important;
            }
        }

        .grid-item {
        }

        .tdpadd {
            padding: 4% 0 4% 0;
        }

        .leftbox {
            width: 100%;
            
            z-index: -1;
        }

        .new-wrap {
            width: 95%;
            margin: auto;
            display: inline-grid;
            grid-template-columns: 20% 80%;
            align-content: space-around;
        }

        label {
            margin: 0;
            margin-right: 0;
        }

        .lblname {
            padding-right: 0px !important;
        }

        .toprow {
            display: grid;
            grid-template-columns: 60% 40%;
            gap: 1px;
            margin: 0 auto;
        }

        .grid-container {
            z-index: 1;
            display: grid;
            grid-template-columns: 22% 30% 20% 13% 15%;
            column-gap: 1px;
            margin: 0 auto;
            align-content: center;
        }

        input[type=text], textarea {
            padding: 0px 0px 0px 0px;
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
        }

        table {
            background-color: white;
            color: black;
            justify-self: center;
            margin: 0 auto;
        }

        td {
            word-wrap: normal;
            padding: 1% 0% 1% 0%;
        }

        .underline {
            border-bottom: 1px solid !important;
            width: 100%;
            display: inline-block;
            padding-left: 5px;
        }

        .HREwrapper {
            margin: 0 auto;
            text-align: center;
            width: 95%;
        }

        .HRESlateBlue {
            background-color: #ccd5e4;
        }

        .HREWhite {
            background-color: white;
            border: 1px solid grey;
            padding: 10px;
        }

        .HREOffWhite {
            background-color: #F9F9F9;
        }

        .HRETan {
            background-color: #f5f5f0 !important;
        }

        .HRELightBlue {
            background-color: #EFF3FB;
        }

        .HRERewrap {
            margin: 0 auto;
        }

        .HREpadR10 {
            padding-right: 20px;
        }

        .row {
            margin: 0 auto;
        }
    </style>
</asp:Content>
