<%@ Page Title="VA State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_VA.aspx.vb" 
    Inherits="HReaseApp.EE_W4_VA" 
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

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

    $(function () {
            var textBox1 = $('input:text[id$=txtClaim]').keyup(foo);
            var textBox2 = $('input:text[id$=txtStatus]').keyup(foo);
            var textBox3 = $('input:text[id$=txtDependents]').keyup(foo);

            function foo() {
                var box1 = textBox1.val();
                var box2 = textBox2.val();
                var box3 = textBox3.val();

                var sum = add(box1, box2, box3);
                $('input:text[id$=txtPersonalExemptions]').val(sum);

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

    $(function () {
            var textBox1 = $('input:text[id$=txtClaim]').keyup(foo);
            var textBox2 = $('input:text[id$=txtStatus]').keyup(foo);
            var textBox3 = $('input:text[id$=txtDependents]').keyup(foo);

            function foo() {
                var box1 = textBox1.val();
                var box2 = textBox2.val();
                var box3 = textBox3.val();

                var sum = add(box1, box2, box3);
                $('input:text[id$=txtApplicationLineA]').val(sum);

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

    $(function () {
            var textBox5a = $('input:text[id$=txtExemptionsForAge]').keyup(foo);
            var textBox5b = $('input:text[id$=txtExemptionsForAge2]').keyup(foo);
            var textBox6a = $('input:text[id$=txtExemptionsBlindness]').keyup(foo);
            var textBox6b = $('input:text[id$=txtExemptionsBlindness2]').keyup(foo);
            
            function foo() {
                var box5a = textBox5a.val();
                var box5b = textBox5b.val();
                var box6a = textBox6a.val();
                var box6b = textBox6b.val();

                var sum = add(box5a, box5b, box6a, box6b);
                $('input:text[id$=txtSubTotalExemptions]').val(sum);

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

        $(function () {
            var textBox5a = $('input:text[id$=txtExemptionsForAge]').keyup(foo);
            var textBox5b = $('input:text[id$=txtExemptionsForAge2]').keyup(foo);
            var textBox6a = $('input:text[id$=txtExemptionsBlindness]').keyup(foo);
            var textBox6b = $('input:text[id$=txtExemptionsBlindness2]').keyup(foo);
            
            function foo() {
                var box5a = textBox5a.val();
                var box5b = textBox5b.val();
                var box6a = textBox6a.val();
                var box6b = textBox6b.val();

                var sum = add(box5a, box5b, box6a, box6b);
                $('input:text[id$=txtApplicationLineB]').val(sum);

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

        $(function () {
            var textBox1 = $('input:text[id$=txtClaim]').keyup(foo);
            var textBox2 = $('input:text[id$=txtStatus]').keyup(foo);
            var textBox3 = $('input:text[id$=txtDependents]').keyup(foo);
            var textBox5a = $('input:text[id$=txtExemptionsForAge]').keyup(foo);
            var textBox5b = $('input:text[id$=txtExemptionsForAge2]').keyup(foo);
            var textBox6a = $('input:text[id$=txtExemptionsBlindness]').keyup(foo);
            var textBox6b = $('input:text[id$=txtExemptionsBlindness2]').keyup(foo);

            function foo() {
                var box1 = textBox1.val();
                var box2 = textBox2.val();
                var box3 = textBox3.val();
                var box5a = textBox5a.val();
                var box5b = textBox5b.val();
                var box6a = textBox6a.val();
                var box6b = textBox6b.val();

                var sum = add(box1, box2, box3, box5a, box5b, box6a, box6b);
                $('input:text[id$=txtTotalWSExemptions]').val(sum);

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

        $(function () {
            var textBox1 = $('input:text[id$=txtClaim]').keyup(foo);
            var textBox2 = $('input:text[id$=txtStatus]').keyup(foo);
            var textBox3 = $('input:text[id$=txtDependents]').keyup(foo);
            var textBox5a = $('input:text[id$=txtExemptionsForAge]').keyup(foo);
            var textBox5b = $('input:text[id$=txtExemptionsForAge2]').keyup(foo);
            var textBox6a = $('input:text[id$=txtExemptionsBlindness]').keyup(foo);
            var textBox6b = $('input:text[id$=txtExemptionsBlindness2]').keyup(foo);

            function foo() {
                var box1 = textBox1.val();
                var box2 = textBox2.val();
                var box3 = textBox3.val();
                var box5a = textBox5a.val();
                var box5b = textBox5b.val();
                var box6a = textBox6a.val();
                var box6b = textBox6b.val();

                var sum = add(box1, box2, box3, box5a, box5b, box6a, box6b);
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

        $(function () {
            var textBox1a = $('input:text[id$=txtApplicationLineA]').keyup(foo);
            var textBox1b = $('input:text[id$=txtApplicationLineB]').keyup(foo);
           
            function foo() {
                var box1a = textBox1a.val();
                var box1b = textBox1b.val();

                var sum = add(box1a, box1b);
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

    <style>
       input[type="checkbox"] {
		width: 20px;
		height: 20px;
        background: #EFF3FB;
		}

        input[type="text"] {		
        background: #EFF3FB;
        border: 0px;
        margin-top:3%;
        height:30px;
        text-align:center;
		}
        
        .nofill {		
            background-color: white !important;
            border:1px solid black !important;
            margin-top:1% !important;
        }
		
		.wrapper {
	    margin-right:10%;
	    overflow:hidden;
        padding:20px;
        }

        table {
            background-color:white;
        }

        .underline {
            border-bottom: 1px solid !important;
            width: 100%;
            display: inline-block;
        }
    </style>

    <div class="HREwrapper">
        <div id="divTopHeader" class="form-group" style="height:100px;">       
            <div style="float:left;">
                <br />
                <h4><asp:Label ID="lblEmployeeName" runat="server"></asp:Label></h4> 
            </div>
            <div id="divError" class="form-group alert alert-danger text-center text-danger divError" runat="server" visible="false">
                <div style="font-size:large; text-align:center;">
                    <asp:Image ID="Image2" ImageUrl="../img/RedX.png" runat="server" style="width:90px" border="none" /> 
                    <br/>
                    <h4>ERROR:
                    <asp:Label ID="lblError" runat="server" Text="There was an error.<br/>"></asp:Label></h4>
                </div>
            </div>
            <div id="divSuccess" runat="server" class="col-md-12 text-center"  visible ="false">
                <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" cssclass=" img" />
                <h3><br /><b><span style="color: green">
                <asp:Label ID="lblSucess" runat="server" Text="Virginia State Tax Form Complete.<br/>"></asp:Label>
                </span></b></h3>
            </div>
            <%-- next arrow full screen --%>
            <div style="float:right; padding-right:2%;">
                <div class="fixed hidden-xs">
                    <asp:ImageButton ID="imgNext" runat="server" ImageUrl="../img/NextArrowInCircleBlueGreen.png" Width="50%" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click"/>
                </div>
            </div>
        </div>

        <div id="divInstructionTitle" class="row well">
            <span><b>INSTRUCTIONS </b></span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px" />
        </div>

        <%-- next arrow mobile screen --%>
        <div class="col-xs-3 col-sm-3 hidden-lg hidden-md pull-right right" style="padding-right:30%;">
            <asp:ImageButton ID="imgNextMobile" runat="server" ImageUrl="../img/NextArrowInCircleBlueGreen.png" Width="150px" Height="150px" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
        </div>

        <div id="divInstructions" class="row well instruction_toggle" style="margin-bottom:20px;">
            <h4 class="text-center" style="font-weight: bold;">FORM VA-4 INSTRUCTIONS</h4>

            <p>Use this form to notify your employer whether you are subject to Virginia income tax withholding and how many exemptions you are allowed to claim. 
                You must file this form with your employer when your employment begins. If you do not file this form, your employer must withhold Virginia income tax as if you had no exemptions.
            </p>
                <div class="clearfix">&nbsp;</div>
                    <h4 class="text-center" style="font-weight: bold;">PERSONAL EXEMPTION WORKSHEET</h4>

                    <p><b>You may not claim more personal exemptions on form VA-4 than you are allowed to claim on your income tax return unless you have received written permission to do so from the 
                        Department of Taxation.</b>
                    </p>

            <p>
                <span class="line">Line 1. </span>You may claim an exemption for yourself.
            </p>

            <p>
                <span class="line">Line 2. </span>You may claim an exemption for your spouse if he or she is not already claimed on his or her own certificate.
            </p>
            <p>
                <span class="line">Line 3.</span>Enter the number of dependents you are allowed to claim on your income tax return. 
            <br />
                NOTE: A spouse is not a dependent.
            </p>
            <p>
                <span class="line">Line 5 - </span>
                If you will be age 65 or over by January 1, you may claim one exemption on Line 5(a). If you claim an exemption for your spouse on Line 2, and your spouse will also be age 65 or over by January 1, you may claim an additional exemption on Line 5(b).
            </p>

            <p>
                <span class="line">Line 6 - </span>
                If you are legally blind, you may claim an exemption on Line 6(a). If you claimed an exemption for your spouse on Line 2, and your spouse is legally blind, you may claim an exemption on Line 6(b).
            </p>

            <h4 class="text-center" style="font-weight: bold;">FORM VA-4</h4>

            <p>Be sure to enter your social security number, name and address in the spaces provided. </p>

            <p>
                <span class="line">Line 1.</span>
                If you are subject to withholding, enter the number of exemptions from:		
            </p>

            <p class="note">
                (a)Subtotal of Personal Exemptions - line 4 of the Personal Exemption Worksheet
            </p>

            <p class="note">
                (b)Subtotal of Exemptions for Age and Blindness - line 7 of the Personal Exemption Worksheet
            </p>
            <p class="note">
                (c)Total Exemptions - line 8 of the Personal Exemption Worksheet
            </p>


            <p>
                <span class="line">Line 2.</span>
                If you wish to have additional tax withheld, and your employer has agreed to do so, enter the amount of additional tax on this line.
            </p>

            <p>
                <span class="line">Line 3.</span>
                If you are not subject to Virginia withholding, check the box on this line. You are not subject to withholding if you meet any one of the conditions listed below. Form VA-4 must be filed with your employer
                    <br />
                for each calendar year for which you claim exemption from Virginia withholding.
            </p>

            <p class="note">
                (a) You had no liability for Virginia income tax last year and you do not expect to have any liability for this year.
            </p>

            <p class="note">
                (b) You expect your Virginia adjusted gross income to be less than the amount shown below for your filing status:
            </p>
            <p class="note"></p>

                <table class="table table-bordered" style="width: 100%; margin: 0 auto;">
                    <tr>
                        <td>
                            <p>&nbsp;</p>
                        </td>
                        <td>
                            <p>Taxable Years</p>
                        </td>
                        <td>
                            <p>Taxable Years</p>
                        </td>
                        <td>
                            <p>Taxable Years</p>
                        </td>
                        <td>
                            <p>Taxable Years</p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>&nbsp;</p>
                        </td>
                        <td>
                            <p>2005, 2006</p>
                        </td>
                        <td>
                            <p>2008 and</p>
                        </td>
                        <td>
                            <p>2010 and</p>
                        </td>
                        <td>
                            <p>2012 and</p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>&nbsp;</p>
                        </td>
                        <td>
                            <p>and 2007</p>
                        </td>
                        <td>
                            <p>2009</p>
                        </td>
                        <td>
                            <p>2011</p>
                        </td>
                        <td>
                            <p>Beyond</p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>Single</p>
                        </td>
                        <td>
                            <p>$7,000</p>
                        </td>
                        <td>
                            <p>$11,250</p>
                        </td>
                        <td>
                            <p>$11,650</p>
                        </td>
                        <td>
                            <p>$11,950</p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>Married</p>
                        </td>
                        <td>
                            <p>$14,000</p>
                        </td>
                        <td>
                            <p>$22,500</p>
                        </td>
                        <td>
                            <p>$23,300</p>
                        </td>
                        <td>
                            <p>$23,900</p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>Married, filing a separate</p>
                        </td>
                        <td>
                            <p>$7,000</p>
                        </td>
                        <td>
                            <p>$11,250</p>
                        </td>
                        <td>
                            <p>$11,650</p>
                        </td>
                        <td>
                            <p>$11,950</p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>return</p>
                        </td>
                        <td>
                            <p>&nbsp;</p>
                        </td>
                        <td>
                            <p>&nbsp;</p>
                        </td>
                        <td>
                            <p>&nbsp;</p>
                        </td>
                        <td>
                            <p>&nbsp;</p>
                        </td>
                    </tr>
                </table>

            <p class="note">
                (c) You live in Kentucky or the District of Columbia and commute on a daily basis to your place of employment in Virginia.
            </p>
            <p class="note">
                (d) You are a domiciliary or legal resident of Maryland, Pennsylvania or West Virginia whose only Virginia source income is from salaries and wages and such salaries and wages are subject to income taxation by your state of domicile.
            </p>

            <p>
                <span class="line">Line 4.</span>
                Under the Servicemember Civil Relief Act, as amended by the Military Spouses Residency Relief Act, you may be exempt from Virginia income tax on your wages if (i) your spouse is a member of the armed forces present in Virginia in compliance with military orders; (ii) you are present in Virginia solely to be with your spouse; and (iii)you maintain your domicile in another state. If you claim exemption under the SCRA check the box on Line 4 and attach a copy of your spousal military identification card to Form VA-4.
            </p>

        </div>

        <div id="divVAFormHeader" class="row">
            <table style="width:100%;">
                <tr style="width: 100%;">
                    <td style="width: 15%;">
                        <h4>
                            <span style="font-size: 30px; line-height: 2px; font-weight: 900;">FORM VA-4</span>
                        </h4>
                    </td>
                    <td style="width: 70%; text-align: center; line-height: 30px; padding: 10px 0px;">
                        <div style="font-size: 22px; font-weight: 700;">
                            COMMONWEALTH OF VIRGINIA
                            <br/>
                            DEPARTMENT OF TAXATION
                        </div>
                        <div style="font-size: 28px; font-weight: 700;">
                            PERSONAL EXEMPTION WORKSHEET
                        </div>
                        <div style="font-size: 22px;">
                            (See back for instructions)
                        </div>
                    </td>
                    <td style="width: 15%;">&nbsp;</td>
                </tr>
            </table>
        </div>

        <div id="divVAFormPWWorksheet" class="row">
            <table style="width:100%;">
                <tr>
                    <td style="width:3%;">&nbsp;</td>
                    <td style="width:3%;"></td>
                    <td style="width:49%;"></td>
                    <td style="width:20%;"></td>
                    <td style="width:5%;"></td>
                    <td style="width:20%;"></td>
                </tr>
                <tr style="height: 20px;">
                    <td colspan="1" style="vertical-align:top;">
                        1.
                    </td>
                    <td colspan="2" style="vertical-align:top;"> 
                        If you wish to claim yourself, write "1"
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom;">
                        <asp:TextBox ID="txtClaim" runat="server" Style="width: 100%; min-width:40px; text-align: center; padding-right: 1%;" placeholder="1 or 0" CssClass="input_color" onkeypress="return onlyNumbers();" ></asp:TextBox>
                    </td>
                    <td colspan="2">
                    </td>
                </tr>
                <tr style="height: 20px;">
                    <td colspan="1" style="vertical-align:top;">
                        2.
                    </td>
                    <td colspan="2" style="vertical-align:top;"> 
                         If you are married and your spouse is not claimed on his or her own certificate, write “1” 
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom;">
                        <asp:TextBox ID="txtStatus" runat="server" Style="width: 100%; min-width:40px; text-align: center; padding-right: 1%;" placeholder="1 or 0" CssClass="input_color" onkeypress="return onlyNumbers();" ></asp:TextBox>
                    </td>
                    <td colspan="2">
                    </td>
                </tr>
                <tr style="height: 20px;">
                    <td colspan="1" style="vertical-align:top;">
                        3.
                    </td>
                    <td colspan="2" style="vertical-align:top;"> 
                          Write the number of dependents you will be allowed to claim  on your income tax return (do not include your spouse) 
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom;">
                        <asp:TextBox ID="txtDependents" runat="server" Style="width: 100%; min-width:40px; text-align: center; padding-right: 1%;" placeholder="Numeric" CssClass="input_color" onkeypress="return onlyNumbers();" ></asp:TextBox>
                    </td>
                    <td colspan="2">
                    </td>
                </tr>
                <tr style="height: 20px;">
                    <td colspan="1" style="vertical-align:top;">
                        4.
                    </td>
                    <td colspan="2" style="vertical-align:top;"> 
                           Subtotal Personal Exemptions (add lines 1 through 3)
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom;">
                        <asp:TextBox ID="txtPersonalExemptions" runat="server" ReadOnly="true" Style="width: 100%; min-width:40px; text-align: center; padding-right: 1%;" placeholder="Sum of 1+2+3" CssClass="input_color" onkeypress="return onlyNumbers();" ></asp:TextBox>
                    </td>
                    <td colspan="2">
                    </td>
                </tr>
                <tr style="height: 20px;">
                    <td colspan="1" style="vertical-align:top;">
                        5.
                    </td>
                    <td colspan="2" style="vertical-align:top;"> 
                           Exemptions for age
                    </td>
                    <td colspan="3">
                    </td>
                </tr>
                <tr style="height: 20px;">
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="vertical-align:top; text-align:center;"> 
                        (a)
                    </td>
                    <td colspan="1" style="vertical-align:top;">
                        If you will be 65 or older on January 1, write “1” 
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom;">
                        <asp:TextBox ID="txtExemptionsForAge" runat="server" Style="width: 100%; min-width:40px; text-align: center; padding-right: 1%;" placeholder="1 or 0" CssClass="input_color" onkeypress="return onlyNumbers();" ></asp:TextBox>
                    </td>
                    <td colspan="2">
                    </td>
                </tr>
                <tr style="height: 20px;">
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="vertical-align:top; text-align:center;"> 
                        (b)
                    </td>
                    <td colspan="1" style="vertical-align:top;">
                        If you claimed an exemption on line 2 and your spouse will be 65 or older on January 1, write “1”
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom;">
                        <asp:TextBox ID="txtExemptionsForAge2" runat="server" Style="width: 100%; min-width:40px; text-align: center; padding-right: 1%;" placeholder="1 or 0" CssClass="input_color" onkeypress="return onlyNumbers();" ></asp:TextBox>
                    </td>
                    <td colspan="2">
                    </td>
                </tr>
                <tr style="height: 20px;">
                    <td colspan="1" style="vertical-align:top;">
                        6.
                    </td>
                    <td colspan="2" style="vertical-align:top;"> 
                        Exemptions for blindness
                    </td>
                    <td colspan="3">
                    </td>
                </tr>
                <tr style="height: 20px;">
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="vertical-align:top; text-align:center;"> 
                        (a)
                    </td>
                    <td colspan="1" style="vertical-align:top;">
                        If you are legally blind, write “1”
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom;">
                        <asp:TextBox ID="txtExemptionsBlindness" runat="server" Style="width: 100%; min-width:40px; text-align: center; padding-right: 1%;" placeholder="1 or 0" CssClass="input_color" onkeypress="return onlyNumbers();" ></asp:TextBox>
                    </td>
                    <td colspan="2">
                    </td>
                </tr>
                <tr style="height: 20px;">
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="vertical-align:top; text-align:center;"> 
                        (b)
                    </td>
                    <td colspan="1" style="vertical-align:top;">
                        If you claimed an exemption on line 2 and your spouse is legally blind, write “1” 
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom;">
                        <asp:TextBox ID="txtExemptionsBlindness2" runat="server" Style="width: 100%; min-width:40px; text-align: center; padding-right: 1%;" placeholder="1 or 0" CssClass="input_color" onkeypress="return onlyNumbers();" ></asp:TextBox>
                    </td>
                    <td colspan="2">
                    </td>
                </tr>                
                <tr style="height: 20px;">
                    <td colspan="1" style="vertical-align:top;">
                        7.
                    </td>
                    <td colspan="4" style="vertical-align:top;"> 
                        Subtotal exemptions for age and blindness (add lines 5 through 6)
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom;">
                        <asp:TextBox ID="txtSubTotalExemptions" runat="server" ReadOnly="true" Style="width: 100%; min-width:40px; text-align: center; padding-right: 1%;" placeholder="Sum of 5a+5b+6a+6b" CssClass="input_color" onkeypress="return onlyNumbers();" ></asp:TextBox>
                    </td>
                </tr>
                <tr style="height: 20px;">
                    <td colspan="1" style="vertical-align:top;">
                        8.
                    </td>
                    <td colspan="4" style="vertical-align:top;"> 
                        Total of Exemptions - add line 4 and line 7
                    </td>
                    <td colspan="1" class="underline" style="vertical-align:bottom;">
                        <asp:TextBox ID="txtTotalWSExemptions" runat="server" ReadOnly="true" Style="width: 100%; min-width:40px; text-align: center; padding-right: 1%;" placeholder="Sum of 4+7" CssClass="input_color" onkeypress="return onlyNumbers();" ></asp:TextBox>
                    </td>
                </tr>
                
            </table>
        </div>

        <div class="clearfix">
            &nbsp;&nbsp;&nbsp;
        </div>
        <div class="hr"></div>
        <div class="clearfix">
            &nbsp;&nbsp;&nbsp;
        </div>

        <div id="divVAMainFormHeader" class="row">
            <div style="width: 100%;">
                <div style="display: inline-block; font-size: 20px; font-weight: 700; width: 20%;">
                    FORM VA-4
                </div>
                <div style="display: inline-block; font-size: 20px; font-weight: 700; text-align: center;">
                    EMPLOYEE’S VIRGINIA INCOME TAX WITHHOLDING EXEMPTION CERTIFICATE
                </div>
            </div>
        </div>

        <div id="divVAMainFormDemo" class="row">
            <table class="table-custom table-bordered" style="width: 100%; table-layout: fixed;">
                <tr style="width: 100%">
                    <td colspan="9" style="width: 30%;">
                        <span>Your Social Security Number
                        </span>
                        <div style="background-color: #EFF3FB;">
                            <b><asp:label ID="lblSSNumber" runat="server" Style="padding-left:5px; text-align: right; display: inline; width: 90%;" onkeypress="return onlyNumbers();"></asp:label></b>
                        </div>
                    </td>

                    <td colspan="11" style="width: 70%;">
                        <span>Name</span>
                        <div style="background-color: #EFF3FB;">
                            <b><asp:label ID="lblFullName" runat="server" Style="padding-left:5px; display: inline; width: 90%;" placeholder="" CssClass=""></asp:label></b>
                        </div>
                    </td>

                </tr>

                <tr style="width: 100%">
                    <td colspan="20" style="width: 100%;">
                        <span>Street Address</span>
                        <div style="background-color: #EFF3FB;">
                            <b><asp:label ID="lblAddress" runat="server" Style="padding-left:5px; display: inline; width: 95%; height: 50px; margin: 0px;"
                                placeholder="" TextMode="MultiLine" CssClass=""></asp:label></b>
                        </div>
                    </td>
                </tr>
                <tr style="width: 100%">
                    <td colspan="10" style="width: 50%;">
                        <span>City</span>
                        <div style="background-color: #EFF3FB;">
                            <b><asp:label ID="lblCity" runat="server" Style="padding-left:5px; width: 90%;" placeholder="" CssClass=""></asp:label></b>
                        </div>
                    </td>

                    <td colspan="5" style="width: 25%;">
                        <span>State</span>
                        <div style="background-color: #EFF3FB;">
                            <b><asp:label ID="lblState" runat="server" Style="padding-left:5px; width: 90%;" placeholder="" CssClass=""></asp:label></b>
                        </div>
                    </td>
                    <td colspan="5" style="width: 25%;">
                        <span>Zip Code</span>
                        <div style="background-color: #EFF3FB;">
                           <b><asp:label ID="lblZipCode" runat="server" Style="padding-left:5px; width: 90%;" placeholder="" CssClass=""></asp:label></b>

                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <div id="divMainFormMiddleHeader" class="row">
            <div style="font-size: 20px;">
                <br />
                COMPLETE THE APPLICABLE LINES BELOW
            </div>
        </div>

        <div id="divVAMainFormMiddle" class="row">
            <table>
                <tr>
                    <td style="width:3%;">&nbsp;</td>
                    <td style="width:3%;"></td>
                    <td style="width:49%;"></td>
                    <td style="width:20%;"></td>
                    <td style="width:5%;"></td>
                    <td style="width:20%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        1.
                    </td>
                    <td colspan="5" style="vertical-align:top;">
                        If subject to withholding, enter the number of exemptions claimed on:
                    </td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="vertical-align:top;">
                        (a)
                    </td>
                    <td colspan="3">
                        Subtotal of Personal Exemptions - line 4 of the Personal Exemption Worksheet
                    </td>
                    <td colspan="1" class="underline">
                        <asp:TextBox ID="txtApplicationLineA" runat="server" Style="width: 100%; min-width:40px; text-align: center; padding-right: 1%;" placeholder="" CssClass=""></asp:TextBox>
                    </td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="vertical-align:top;">
                        (b)
                    </td>
                    <td colspan="3">
                         Subtotal of Exemptions for Age and Blindness line 7 of the Personal Exemption Worksheet 
                    </td>
                    <td colspan="1" class="underline">
                        <asp:TextBox ID="txtApplicationLineB" runat="server" Style="width: 100%; min-width:40px; text-align: center; padding-right: 1%;" placeholder="" CssClass=""></asp:TextBox>
                    </td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1">
                    </td>
                    <td colspan="1" style="vertical-align:top;">
                        (c)
                    </td>
                    <td colspan="3">
                          Total Exemptions - line 8 of the Personal Exemption Worksheet
                    </td>
                    <td colspan="1" class="underline">
                        <asp:TextBox ID="txtTotalExemptions" runat="server" Style="width: 100%; min-width:40px; text-align: center; padding-right: 1%;" placeholder="" CssClass=""></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        2.
                    </td>
                    <td colspan="4" style="vertical-align:top;">
                         Enter the amount of additional withholding requested (see instructions)
                    </td>
                    <td colspan="1" class="underline">
                        <asp:TextBox ID="txtAdditionalWithholding" runat="server" Style="width: 100%; min-width:40px; text-align: center; padding-right: 1%;" placeholder="" CssClass=""></asp:TextBox>
                    </td>
                </tr>
               <tr>
                    <td colspan="1" style="vertical-align:top;">
                        3.
                    </td>
                    <td colspan="4" style="vertical-align:top;">
                          I certify that I am not subject to Virginia withholding. l meet the conditions set forth in the instructions (check here) 
                    </td>
                    <td colspan="1" class="underline">
                        <asp:CheckBox ID="chkExempt" runat="server" placeholder="" CssClass="" AutoPostBack="true" OnCheckedChanged="chkExempt_CheckedChanged"></asp:CheckBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="vertical-align:top;">
                        4.
                    </td>
                    <td colspan="4" style="vertical-align:top;">
                        Under the Service member Civil Relief Act, as amended by the Military Spouses
                    </td>
                    <td colspan="1" class="underline">
                        <asp:CheckBox ID="chkMilitarySpouse" runat="server" placeholder="" CssClass="" AutoPostBack="true" OnCheckedChanged="chkMilitarySpouse_CheckedChanged"></asp:CheckBox>
                    </td>
                </tr>
         
            </table>
        </div>

        <div id="divVASignatureBlock" class="row">
             <table>
                <tr>
                    <td style="width:60%;"></td>
                    <td style="width:40%;"></td>
                </tr>
                <tr>
                    <td colspan="1">
                        Employee’s Signature &nbsp;&nbsp;
				        <asp:TextBox ID="txtSignature" runat="server" placeholder="Type Name to Represent Signature" Style="width: 60%; padding-left:1%;" CssClass="left" ></asp:TextBox>
                    </td>
                    <td colspan="1">
                        Date &nbsp;&nbsp; 
					    <asp:TextBox ID="txtSignatureDate" runat="server" placeholder="MM/DD/YYYY" Style="width: 60%;" CssClass="input_color"></asp:TextBox>
                    </td>
                </tr>
            </table>
            
            <div class="col-md-12">
                EMPLOYER: Keep exemption certificates with your records. If you believe the employee has claimed too many exemptions, notify the Department of
                Taxation, P.O. Box 1115, Richmond, Virginia 23218-1115, telephone (804) 367-8037. Note: Employers may establish a system to electronically receive
                Forms VA-4 from employees, provided the system meets Internal Revenue Service requirements as specified in § 31.3402(f)(5)-1(c) of the Treasury
                Regulations (26 CFR).
            </div>
        </div>

        <div id="divSave" class="row">
            <div class="clearfix">&nbsp;</div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" OnClick="btnSave_Click" />
            </div>
            <div class="clearfix">&nbsp;</div>
        </div>

        <div class="clearfix">&nbsp;</div>
        <div class="clearfix">&nbsp;</div>

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
