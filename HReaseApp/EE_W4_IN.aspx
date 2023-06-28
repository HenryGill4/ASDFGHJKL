<%@ Page Title="IN State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_IN.aspx.vb" 
    Inherits="HReaseApp.EE_W4_IN" 
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
        function makeMoney(source) {
            //Grab the value from the element
            var money = parseFloat(source.value, 10).toFixed(2);

            //Format your value
            source.value = money.toString();
        };
        $(function () {
            var Boxa = $('input:text[id$=TextBox1]').keyup(foo);
            var Boxb = $('input:text[id$=TextBox2]').keyup(foo);
            var Boxc = $('input:text[id$=TextBox3]').keyup(foo);
            var Boxd = $('input:text[id$=TextBox4]').keyup(foo);

            function foo() {
                var a = Boxa.val();
                var b = Boxb.val();
                var c = Boxc.val();
                var d = Boxd.val();

                var e = 0
                e = add(a, b, c, d);
                $('input:text[id$=TextBox5]').val(e);

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
            <div style="text-align:center;">
                <br />
                <h4><b>Indiana Form WH-4</b></h4>
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

        <div id="DivInstructions" class="instruction_toggle" style="text-align:center; margin-right:5%; font-size: medium; padding:10px 10px 20px 10px; border:1px solid black; margin-bottom:30px;">
            <h4 class="text-center" style="font-weight: bold;">Instructions for Completing Form WH-4</h4>

            <p>This form should be completed by all resident and nonresident employees having income subject to Indiana state and/or county income tax.</p>
            <p>Print or type your full name, Social Security number or ITIN and home address. Enter your Indiana county of residence and county of principal employment as of January 1 of the current year. If you neither lived nor worked in Indiana on January 1 of the current year, enter ‘not applicable’ on the line(s). If you move to (or work in) another county after January 1, your county status will not change until the next calendar tax year.</p>
            <p><b>Nonresident alien limitation.</b> A nonresident alien is allowed to claim only one exemption for withholding tax purposes. If you are a nonresident alien, enter “1” on line 1, then skip to line 7. You are considered to be a nonresident alien if you are not a citizen of the United States and do not meet the green card test and the substantial presence test (get Publication 519 from 
                <a href="www.irs.gov">www.irs.gov</a> for information about these tests).</p>

            <p>All other employees should complete lines 1 through 7.</p>
            <p>
                <span class="line">Lines 1 & 2 - </span>You are allowed to claim one exemption for yourself and one for your spouse (if he/she does not claim the exemption for him/herself). If a parent or legal guardian claims you on their federal tax return, you may still claim an exemption for yourself for Indiana purposes. You cannot claim more than the correct number of exemptions; however, you are permitted to claim a lesser number of exemptions if you wish additional withholding to be deducted.
            </p>

            <p>
                <span class="line">Line 3 - </span>Dependent Exemptions: You are allowed one exemption for each of your dependents based on state and federal guidelines. To qualify as your dependent, a person must receive more than one-half of his/her support from you for the tax year and must have less than $1,000 gross income during the tax year (unless the person is your child and is under age 19 or under age 24 and a full-time student at least during 5 months of the tax year at a qualified educational institution).
            </p>
            <p>
                <span class="line">Line 4 - </span>
                Additional Exemptions. You are also allowed one exemption each for you and/or your spouse if either is 65 or older and/or blind.
            </p>

            <p>
                <span class="line">Line 5 - </span>
                Add the total of exemptions claimed on lines 1, 2, 3, and 4. Enter the total in the box provided.
            </p>

            <p>
                <span class="line">Line 6 - </span>
                Additional Dependent Exemptions. An additional exemption is allowed for certain dependent children that are included on line 3. The dependent child must be a son, stepson, daughter, stepdaughter and/or foster child.
            </p>

            <p>
                <span class="line">Lines 7 & 8 - </span>
                If you would like an additional amount to be withheld from your wages each pay period, enter the amount on the line provided. <b>NOTE:</b> An entry on this line does not obligate your employer to withhold the amount. You are still liable for any additional taxes due at the end of the tax year. If the employer does withhold the ad- ditional amount, it should be submitted along with the regular state and county tax withholding.
            </p>

            <div style="text-align:left;">
                You may file a new Form WH-4 at any time if the number of exemptions <b>increases</b>. You must file a new Form WH-4 within 10 days if the number of exemptions previously claimed by you <b>decreases</b> for any of the following reasons:
                <br />
                <div style="margin-left:20px; text-wrap:inherit;">
                    <span style="margin-left:-20px; text-align:left;">
                        (a)
                    </span>
                    you divorce (or are legally separated from) your spouse for whom you have been claiming an exemption or your spouse claims him/herself on a separate Form WH-4; or
                </div>
                <div style="margin-left:20px; text-wrap:inherit;">
                    <span style="margin-left:-20px; text-align:left;">
                        (b)
                    </span>
                     someone else takes over the support of a dependent you claim or you no longer provide more than one-half of the person’s support for the tax year
                </div>
            </div>
            <br />
            <p>
                Penalties are imposed for willingly supplying false information or information which would reduce the withholding exemption.
            </p>
        </div>

        <div id="DivMainForm" style="border: 1px solid black; padding: 5px 5px 5px 5px; margin-right:5%;">
            <table id="MainFormHeader" style="width:100%;">
                <tr style="width: 100%;">
                    <td style="width: 5%;">
                        <img src="images/logo-crm13.png" style="width: 100px;"/>
                        </td>
                    <td style="width: 15%; font-size:12px; min-width:100px;">
                        <h4>Form 
							<b> WH-4</b>                            
                            <br />
                            State Form 48845 
                            <br />
                            (R7 / 9-20) 
                        </h4>
                    </td>
                    <td style="width:70%; text-align: center;">
                        <p style="font-size: 22px; font-weight: bold;">
                                State of Indiana</p>
                            <p style="font-size: 24px; font-weight: bold;">
                                Employee’s Withholding Exemption and County Status Certificate</p>
                            <p style="font-size: 16px; font-weight: bold;">
                                This form is for the employer’s records. Do not send this form to the Department of Revenue.</p>
                            <p style="font-size: 16px; font-weight: bold;">
                                The completed form should be returned to your employer.</p>
                     
                    </td>
                    <td style="width:10%;">
                         &nbsp;
                    </td>
                </tr>
            </table>

            <table id="MainFormPersonalInfo" style="width:100%;">
                <tr>
                    <td style="width:40%;"></td>
                    <td style="width:10%;"></td>
                    <td style="width:15%;"></td>
                    <td style="width:15%;"></td>
                    <td style="width:20%;"></td>
                </tr>
                <tr>
                    <td colspan="2" style="vertical-align:bottom; width:100%;" >
                        Full Name&nbsp;
                        <span class="HRETan" style="width:80%; min-width:100px; padding-left:5px;border-bottom:1px solid black;">
                            <b><asp:Label ID="LabelFullName" runat="server" Width="80%"></asp:Label></b>
                        </span>
                    </td>
                    <td colspan="3" style="padding-left:5px; vertical-align:bottom; width:100%;" >
                        Social Security Number or ITIN&nbsp;
                        <span class="HRETan center" style="width:60%; min-width:100px; padding-left:5px; border-bottom:1px solid black; display:inline-block;">
                            <b><asp:Label ID="LabelSSNumber" runat="server" ></asp:Label></b>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="padding-top:20px; vertical-align:bottom;" >
                        Home Address&nbsp;
                        <span class="underline HRETan" style="width:77%; min-width:100px; padding-left:2px; display:inline-block;">
                            <b><asp:Label ID="LabelHomeAddress" runat="server" ></asp:Label></b>
                        </span>
                    </td>
                    <td colspan="2" style="padding-top:20px; padding-left:2px; vertical-align:bottom;">
                        City&nbsp;
                        <span class="underline HRETan" style="width:85%; min-width:100px; display:inline-block;">
                            <b>&nbsp;<asp:Label ID="LabelCity" runat="server" ></asp:Label></b>
                        </span>
                    </td>
                    <td colspan="1" style="padding-top:20px; padding-left:2px; vertical-align:bottom; text-align:center;">
                        State&nbsp;
                        <span class="underline HRETan center" style="width:70%; min-width:10px; display:inline-block; ">
                            <b><asp:Label ID="LabelState" runat="server" ></asp:Label></b>
                        </span>
                    </td>
                    <td colspan="1" style="padding-top:20px;padding-left:2px; vertical-align:bottom;" >
                        Zip Code&nbsp;
                        <span class="underline HRETan center" style="width:70%; min-width:20px; display:inline-block; ">
                            <b><asp:Label ID="LabelZip" runat="server" ></asp:Label></b>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" style="padding-top:20px; padding-left:2%;" >
                        Indiana County of Residence as of January 1:&nbsp;
                        <span class="underline" style="width:40%; display:inline-block;">
                            &nbsp;&nbsp;<asp:TextBox ID="TextCountyOfResidence" runat="server" Width="100%" MinWidth="50px"/>
                        </span>
                        &nbsp;&nbsp;(See instructions)
                    </td>
                </tr>
                <tr>
                    <td colspan="5" style="padding-top:20px; padding-left:2%;" >
                        Indiana County of Residence as of January 1:&nbsp;
                        <span class="underline" style="width:40%; display:inline-block;">
                            &nbsp;&nbsp;<asp:TextBox ID="TextCountyOfEmployment" runat="server" Width="100%" MinWidth="50px"/>
                        </span>
                        &nbsp;&nbsp;(See instructions)
                    </td>
                </tr>
                <tr>
                     <td colspan="5" style="padding-top:20px; padding-bottom:20px; border-bottom: 2px solid black; padding-left:10px; padding-right:10px;" >
                         &nbsp;
                    </td>
                </tr>
            </table>
            <table id="MainFormQ&A">
                <tr>
                    <td style="width:3%;"></td>
                    <td style="width:32%;"></td>
                    <td style="width:40%;"></td>
                    <td style="width:2%;"></td>
                    <td style="width:15%;"></td>
                    <td style="width:3%"></td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6" class="center" style="padding-bottom:10px;">
                        How to Claim Your Withholding Exemptions
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:right;" >
                        1.
                    </td>
                    <td colspan="2" style="vertical-align:top;" >
                        You are entitled to one exemption. If you wish to claim the exemption, enter “1” ...
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom; max-width:30px;">
                       <asp:TextBox ID="TextBox1" runat="server" CssClass="center" Width="100%" onkeypress="return onlyZeroOrOne()"></asp:TextBox>
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="5" style="vertical-align:top; padding-bottom:10px;">
                        <b>Nonresident aliens </b>must skip lines 2 through 6. See instructions
                    </td>
                </tr>
                <tr>
                    <td colspan="6" style="line-height:2px;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:right;">
                        2.
                    </td>
                    <td colspan="2" style="vertical-align:top;">
                        If you are married and your spouse does not claim his/her exemption, you may claim it, enter “1” ...
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom; max-width:30px; ">
                       <asp:TextBox ID="TextBox2" runat="server" CssClass="center" Width="100%" onkeypress="return onlyZeroOrOne()"></asp:TextBox>
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6" style="line-height:5px;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:right;">
                        3.
                    </td>
                    <td colspan="2" style="vertical-align:top;">
                        You are allowed one (1) exemption for each dependent. Enter number claimed ...
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1" class="underline center" style="vertical-align:bottom; max-width:30px;" >
                       <asp:TextBox ID="TextBox3" runat="server" CssClass="center" Width="100%" onkeypress="return onlyNumbers()"></asp:TextBox>
                    </td>
                    <td colspan="1" style="padding-bottom:10px;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6" style="line-height:5px;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:right;">
                        4.
                    </td>
                    <td colspan="4">
                        <div style="text-align:left;">
                            Additional exemptions are allowed if:
                            <br />
                            <div style="margin-left:30px; text-wrap:inherit;">
                                <span style="margin-left:-30px; text-align:left;">
                                    (a)
                                </span>
                                you and/or your spouse are over the age of 65 and/or
                            </div>
                            <div style="margin-left:30px; text-wrap:inherit;">
                                <span style="margin-left:-30px; text-align:left;">
                                    (b)
                                </span>
                                 if you and/or your spouse are legally blind.
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="5" style="vertical-align:middle; text-align:left;">      
                        Check box(es) for additional exemptions:&nbsp; 
                        <div style="display:inline-block;">
                            <asp:CheckBox ID="CheckboxOver65" runat="server" Text="You are 65 or older &nbsp;" TextAlign="Left" />  
                        </div>
                        <div style="display:inline-block;">
                            <asp:CheckBox ID="CheckboxBlind" runat="server" Text="&nbsp; or blind &nbsp;" TextAlign="Left"/>                        
                        </div>
                        <div style="display:inline-block;">
                            <asp:CheckBox ID="CheckboxSpouse65" runat="server" Text="&nbsp; Spouse is 65 or older &nbsp;" TextAlign="Left"/>
                        </div>
                        <div style="display:inline-block;">
                            <asp:CheckBox ID="CheckboxSpouseBlind" runat="server" Text="&nbsp; or blind &nbsp;" TextAlign="Left" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="2" style="vertical-align:middle;">
                        Enter the total number of boxes checked ...
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="1" class="underline center" style="vertical-align:bottom; max-width:30px;">
                       <asp:TextBox ID="TextBox4" runat="server" CssClass="center" Width="100%" onkeypress="return onlyNumbers()" ></asp:TextBox>
                    </td>
                    <td colspan="1" style="padding-bottom:10px;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6" style="line-height:5px;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:right;">
                        5.
                    </td>
                    <td colspan="2" style="vertical-align:top;">
                        Add lines 1, 2, 3, and 4. Enter the total here ...
                    </td>
                    <td colspan="1" style="text-align:right; padding-right:2px;">
                        <strong>▶ </strong>
                    </td>
                    <td colspan="1" class="center blackborder" style="vertical-align:bottom; border:1px solid black; margin-left:10px; max-width:30px;">
                       <asp:TextBox ID="TextBox5" runat="server" CssClass="center" Width="100%" onkeypress="return onlyNumbers()"></asp:TextBox>
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6" style="line-height:5px;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:right;">
                        6.
                    </td>
                    <td colspan="2" style="vertical-align:top;">
                        You are entitled to claim an additional exemption for each qualifying dependent (see instructions) ...
                    </td>
                    <td colspan="1" style="text-align:right; padding-right:2px;">
                        <strong>▶ </strong>
                    </td>
                    <td colspan="1" class="center" style="vertical-align:bottom; border: 1px solid black; max-width:30px;" >
                       <asp:TextBox ID="TextBox6" runat="server" CssClass="center" Width="100%" onkeypress="return onlyNumbers()"></asp:TextBox>
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6" style="line-height:5px;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:right;">
                        7.
                    </td>
                    <td colspan="2" style="vertical-align:top;">
                        Enter the amount of additional state withholding (if any) you want withheld each pay period ...
                    </td>
                    <td colspan="1" style="vertical-align:bottom; text-align:right; ">
                        <strong>$</strong>
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom; min-width:80px; width:100%; max-width:30px;">
                       <asp:TextBox ID="TextBox7" runat="server" CssClass="center" Width="100%" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                    <td colspan="1" >
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6" style="line-height:5px;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top; text-align:right;">
                        8.
                    </td>
                    <td colspan="2" style="vertical-align:top;">
                        Enter the amount of additional state withholding (if any) you want withheld each pay period ...
                    </td>
                    <td colspan="1" style="vertical-align:bottom; text-align:right;">
                        <strong>$</strong>
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom; min-width:80px; width:100%; max-width:30px;" >
                       <asp:TextBox ID="TextBox8" runat="server" CssClass="center" Width="100%" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6" style="line-height:5px;">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        &nbsp;
                    </td>
                    <td colspan="4" style="vertical-align:top;">
                        I hereby declare that to the best of my knowledge the above statements are true
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6" style="line-height:5px;">
                        &nbsp;
                    </td>
                </tr>
            </table>
            <table id="SignatureBlock">
                <tr>
                    <td style="width:10%;"></td>
                    <td style="width:50%;"></td>
                    <td style="width:10%;"></td>
                    <td style="width:29%;"></td>
                    <td style="width:1%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="text-align:right; padding-right:2px; vertical-align:bottom;" >
                        Signature: &nbsp;
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom; width:100%; display: inline-block;" >
                         <asp:TextBox ID="TextSignature" runat="server" CSSClass="bottom" Width="100%"></asp:TextBox>
                    </td>
                    <td colspan="1" style="text-align:right; padding-right:2px; vertical-align:top; padding-left:10px;">
                        Date:
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom; min-width:40px; width:100%; text-align:center; display: inline-block;" >                        
                        <asp:TextBox ID="SignatureDate" runat="server" CssClass="center" Width="100%"></asp:TextBox>
                    </td> 
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="6" style="line-height:20px;">
                        &nbsp;
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
        input[type=text], textarea {outline: none; min-height: 25px; min-width: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; vertical-align:bottom; }
        input[type="checkbox"] {width: 20px; height: 20px; cursor: pointer; background: #f0f4fa; padding:1px 1px 1px 1px; vertical-align:middle; }
        table {background-color:white; min-height: 25px; color:black; border:none; border-collapse:separate; border-spacing: 0px 0px; font-size:large;}
        p {color:black; text-align:left;}
        div ul li {color:black;}
        div ol li {color:black;}
        div {color:black; }
        .underline {border-bottom: 1px solid black; width: 100%; vertical-align:bottom; }
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
