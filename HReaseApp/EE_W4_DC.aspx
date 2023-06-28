<%@ Page Title="DC State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_DC.aspx.vb" 
    Inherits="HReaseApp.EE_W4_DC" 
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
        function exempt(textbox) {
            if (textbox != '') {
                //alert('EXEMPT was entered');
                var a = '';
                var b = '0';
                var c = 'EXEMPT'
                $('input:checkbox[id$=chkSingle]').prop("checked", false);
                $('input:checkbox[id$=chkMarriedFilingJoint]').prop("checked", false);
                $('input:checkbox[id$=chkHeadOfHousehold]').prop("checked", false);
                $('input:checkbox[id$=chkMarriedFillingSeparateOnSameRtn]').prop("checked", false);
                $('input:text[id$=txtSecALineI]').val(a);
                $('input:text[id$=txtSecBLineM]').val(a);
                $('input:text[id$=txtTotalExemptions]').val(b);
                $('input:text[id$=txtAdditionalwithholding]').val(b);
                $('input:text[id$=txtExempt]').val(c);
            }
        }

    </script>

    <div class="HREwrapper">
        <div id="PageTitle" class="HRERewrap">
            <div style="text-align:center;">
                <br />
                <h4><b>Washington DC Form D-4</b></h4>
            </div>
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

        <div id="divInstructionTitle" class="well HRESlateBlue HRERewrap" style="text-align:center; padding-bottom:20px;">
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px;" />

        </div>

        <div id="divInstructions" class="instruction_toggle" style="margin-left:.2%; margin-right:5%;">
            <div class="col-md-12" style="border-bottom: 2px solid black;">
            <div class="col-md-6" style="padding-top:10px; padding-left:10px; padding-right:10px;">
                <p style="color:red;">
                    <strong>Taxpayer Identification Number(s) (TIN) </strong>
                    You must have a TIN, whether it is a Federal Employer Identification
                    Number (FEIN), Social Security Number (SSN), Individual Taxpayer
                    Identification Number (ITIN) or Preparer Tax Identification Number
                    (PTIN).
                </p>
                <p style="color:black;">
                    <strong>Who must file a Form D-4?</strong>
                    Every new employee who resides in DC and is required to have DC
                    income taxes withheld, must fi ll out Form. D-4 and file it with his/
                    her employer.
                </p>
                <p style="color:black;">
                    If you are not liable for DC income taxes because you are a
                    nonresident or military spouse, you must file Form D-4A, Certifi cate
                    of Non-residence in the District of Columbia, with your employer.
                </p>
                <p style="color:black;">
                    <strong>When should you file?</strong>
                    File Form D-4 whenever you start new employment. Once filed with
                    your employer, it will remain in effect until you file a new certificate.
                    You may file a new withholding allowance certificate any time the
                    number of withholding allowances you are entitled to increases.
                </p>
                <p style="color:black;">
                    You must file a new certificate within 10 days if the number of
                    withholding allowances you claimed decreases.
                </p>
            </div>
            <div class="col-md-6" style="padding-top:10px;padding-left:10px; padding-right:10px;" >
                <p style="color:black;">
                    <strong>How many withholding allowances should you claim?</strong>
                    Use the worksheet on the front of this form to figure the number of
                    withholding allowances you should claim. If you want less
                    money withheld from your paycheck, you may claim additional
                    allowances by completing Section B of the worksheet, Lines j
                    through n. However, if you claim too many allowances, you may
                    owe additional taxes at the end of the year.
                </p>
                <p style="color:black;">
                    <strong>Should I have an additional amount deducted from my paycheck?</strong>
                    In some instances, even if you claim zero withholding allowances,
                    you may not have enough tax withheld. You may, upon agreement
                    with your employer, have more tax withheld by entering on Line 3,
                    a dollar amount of your choosing.
                </p>
                <p style="color:black;">
                    <strong>What to file </strong>
                    After completing Form D-4, detach the top portion and file it with
                    your employer. Keep the bottom portion for your records.
                </p>
            </div>
            </div>
        </div>
    
        <div id="MainForm" class="row" style="font-size:large; margin-left:.2%; margin-right:5%; border:1px solid black; padding:10px 10px 10px 10px;">
            <div id="MainFormHeader" >
                <div class="col-md-12" >
                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-2 nowrap" style="vertical-align:bottom;">
                        <img src="images/Columbia-DC-flag.png" width="150"/>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-2 nowrap" style="padding-top:20px; vertical-align:bottom;">
                        <p style="color:black; padding-left:7px; vertical-align:bottom;">
                            Government of the
                            <br/>
                            District of Columbia
                        </p>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-7" style="text-align:center; font-size: x-large; padding-top:30px; vertical-align:bottom;">
                        <h4>
                            <b><asp:Label ID="LblTaxYear" runat="server" CssClass="nowrap" /></b>
                            D-4 DC Withholding Allowance Certificate
                        </h4>
                    
                    </div>
                </div>
            </div>

            <div id="SSNNameAndAddress">
                <div class="form-group">
                    <div class="col-md-12">
                        <span>Taxpayer identification number (TIN) See instructions</span>
                        <br />
                        <b><asp:Label ID="LblTIN" runat="server" CssClass="HRETan" Width="50%"></asp:Label></b>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                        <span>First name</span>
                        <br />
                        <b><asp:Label ID="LblFirstName" runat="server" CssClass="HRETan" Width="100%"> </asp:Label></b>
                        <br />
                    </div>
                    <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2">
                        <span>M.I.</span>
                        <br />
                        <b><asp:Label ID="LblMiddleInitial" runat="server" CssClass="HRETan" Width="100%" ></asp:Label></b>
                        <br />
                    </div>
                    <div class="col-xs-12 col-sm-2 col-md-2 col-lg-6">
                        <span>Last name</span>
                        <br />
                        <b><asp:Label ID="LblLastName" runat="server" CssClass="HRETan" Width="100%"></asp:Label></b>
                        <br />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <span>Home address (number, street and suite/apartment number if applicable)</span>
                        <br />
                        <b><asp:Label ID="LblFullAddress" runat="server" CssClass="HRETan" Width="100%"></asp:Label></b>
                        <br />
                    </div> 
                </div>
                <div class="form-group">
                    <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                        <span>City</span>
                        <br />
                        <b><asp:Label ID="LblCity" runat="server" CssClass="HRETan" Width="100%"> </asp:Label></b>
                        <br />
                    </div>
                    <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2">
                        <span>State</span>
                        <br />
                        <b><asp:Label ID="LblState" runat="server" CssClass="HRETan" Width="100%" ></asp:Label></b>
                        <br />
                    </div>
                    <div class="col-xs-12 col-sm-2 col-md-2 col-lg-6">
                        <span>Zip code +4</span>
                        <br />
                        <b><asp:Label ID="LblZipCode" runat="server" CssClass="HRETan" Width="100%"></asp:Label></b>
                        <br />
                    </div>
                </div>
                
            </div>
        
            <div id="Questions1to5" style="margin-top:5px; border-bottom:4px solid black;">
                <table style="width: 100%;">
                    <tr>
                        <td style="width:3%;">&nbsp;</td>
                        <td style="width:27%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:15%;"></td>
                        <td style="width:45%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; vertical-align:text-top;">
                            1
                        </td>
                        <td colspan ="1">
                            Tax filing status (Fill in only one)
                        </td>
                        <td colspan="1">
                            <asp:CheckBox ID="chkSingle" runat="server" Text="&nbsp;Single &nbsp;" CssClass="nowrap" TextAlign="right" autopostback="true" OnCheckedChanged="chkSingle_CheckedChanged" Style="font-weight: normal;" TabIndex="1"/>
                        </td>
                        <td colspan="2">
							<asp:CheckBox ID="chkMarriedFilingJoint" runat="server" Text="&nbsp;Married/domestic partners filing jointly/qualifying widow(er) with dependent child" TextAlign="right" autopostback="true" OnCheckedChanged="chkMarriedFilingJoint_CheckedChanged" Width="100%" />
                        </td>
                    </tr>
                    <tr style="margin-bottom:3px;">
                        <td colspan="1">
                        </td>
                        <td colspan="1">
                            <asp:CheckBox ID="chkHeadOfHousehold" runat="server" Text="&nbsp;Head of household" TextAlign="right" autopostback="true" OnCheckedChanged="chkHeadOfHousehold_CheckedChanged" Style="font-weight: normal;" />
                        </td>
                        <td colspan="2">
                            <asp:CheckBox ID="chkMarriedFilingSeparate" runat="server" Text="&nbsp;Married filing separately " TextAlign="right" autopostback="true" OnCheckedChanged="chkMarriedFilingSeparate_CheckedChanged" Style="font-weight: normal;" />
                        </td>
                        <td colspan="1">
                            <asp:CheckBox ID="chkMarriedFillingSeparateOnSameRtn" runat="server" Text="&nbsp;Married/domestic partners filing separately on same return" TextAlign="right" autopostback="true" OnCheckedChanged="chkMarriedFillingSeparateOnSameRtn_CheckedChanged" Style="font-weight: normal;" />
                        </td>
                    </tr>                   
                    <tr>
                        <td colspan="1" style="text-align:center; vertical-align:text-top;">
                            2
                        </td>
                        <td colspan="4">
                            Total number of withholding allowances from worksheet below.
                        </td>
                    </tr>
                    <tr style="text-align:left;">                        
                        <td colspan="1">
                        </td>
                        <td colspan="1">
                            <b>Enter total from Sec. A, Line i &nbsp; &nbsp; </b>
                            <asp:TextBox ID="txtSecALineI" runat="server" Width="70px" CssClass="center" onkeypress="return onlyNumbers();" TabIndex="6"></asp:TextBox>
                        </td>
                        <td colspan="2">                            
                            <b>Enter total from Sec. B, Line m &nbsp; &nbsp;</b>
                            <asp:TextBox ID="txtSecBLineM" runat="server" Width="70px" CssClass="center" onkeypress="return onlyNumbers();" TabIndex="7"></asp:TextBox>
                        </td>
                        <td colspan="1">                            
                            <b>Total number of withholding allowances , Line n &nbsp; &nbsp;</b>
                            <asp:TextBox ID="txtTotalExemptions" runat="server" Width="70px" CssClass="center" onkeypress="return onlyNumbers()" TabIndex="8"></asp:TextBox>                       
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; vertical-align:text-top;">
                            3 
                        </td>
                        <td colspan="4">
                            Additional amount, if any, you want withheld from each paycheck 
							$ <asp:TextBox ID="txtAdditionalwithholding" runat="server" Width="200px" placeholder=" if applicable, enter monetary amount" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" TabIndex="9"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; vertical-align:text-top;">
                            4 
                        </td>
                        <td colspan="4">
                            Before claiming exemption from withholding, read below. If qualified, write “EXEMPT” in this box.
                            <asp:TextBox ID="txtExempt" runat="server" Width="200px" CssClass="center" ></asp:TextBox>
                            <%--onblur="exempt(this)"--%>
                            <asp:RegularExpressionValidator ID="valretxtExempt" runat="server" CSSClass="red" ControlToValidate="txtExempt" ValidationExpression="\b(EXEMPT|exempt|Exempt)\b" ErrorMessage="<b>Only the word EXEMPT is valid</b>" Display="Dynamic" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:center; vertical-align:text-top;">
                            5 
                        </td>
                       <td colspan="4">
                            My domicile is a state other than the District of Columbia
							&nbsp; &nbsp;
							<asp:CheckBox ID="chkDomicileYes" runat="server" Text="&nbsp;Yes" TextAlign="right" AutoPostBack="true" OnCheckedChanged="chkDomicileYes_CheckedChanged" Style="font-weight: normal;" />
                            <asp:CheckBox ID="chkDomicileNo" runat="server" Text="&nbsp;No" TextAlign="right" AutoPostBack="true" OnCheckedChanged="chkDomicileNo_CheckedChanged" Style="font-weight: normal;" />
                            &nbsp; &nbsp;
							If yes, give name of state of domicile
					        <asp:TextBox ID="txtDomicileName" runat="server" Style="display: inline; width: 20%;" CssClass="center"></asp:TextBox>
                            <br />                           
                            <small>I am exempt because: last year I did not owe any DC income tax and had a right to a full refund of all DC income tax withheld from me; and this year I do
							    not expect to owe any DC income tax and expect a full refund of all DC income tax withheld from me; and I qualify for exempt status on federal Form W-4.
                            </small>  
                            <br />
                            <small>If claiming exemption from withholding, are you a full-time student? 
							    &nbsp; &nbsp; &nbsp;
							    <asp:CheckBox ID="chkStudentYes" runat="server" Text="&nbsp;Yes" TextAlign="right" AutoPostBack="true" OnCheckedChanged="chkStudentYes_CheckedChanged" Style="font-weight: normal;" />
                                <asp:CheckBox ID="chkStudentNo" runat="server" Text="&nbsp;No" TextAlign="right" AutoPostBack="true" OnCheckedChanged="chkStudentNo_CheckedChanged" Style="font-weight: normal;" />
                            </small>  
                        </td>
                    </tr>
            </table>
        </div>    
            
            <div id="Signatureblock" class="form-group">
                <table style="width: 100%; margin-left: 10px;">
                    <tr>
                        <td style="width:50%;"></td>
                        <td style="width:30%;"></td>
                        <td style="width:20%;"></td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <span style="font-size: 20pt">
                                Signature &nbsp; &nbsp; &nbsp;
                            </span>
                            Under penalties of law, I declare that the information provided on this certificate is, to the best of my knowledge, correct.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            <small> Employee’s signature </small>
                        </td>
                        <td colspan="1">
                            <small>Date</small>
                        </td>
                        <td colspan="1">
                        </td>
                    </tr> 
                    <tr>
                        <td colspan="1">
                            <asp:TextBox ID="txtSignature" runat="server" placeholder="Type name to represent Signature" Width="90%" TabIndex="10"></asp:TextBox>
                        </td>
                        <td colspan="1">
                            <asp:TextBox ID="SignatureDate" runat="server" Width="98%" CssClass="center" TabIndex="11"/> 
                        </td>
                        <td colspan="1">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <span style="font-size: 20pt">
                                Employer &nbsp; &nbsp; &nbsp;
                            </span>
                                Keep this certificate with your records. If 10 or more exemptions are claimed or if you suspect this certificate contains false information please send a copy to: Office of Tax and Revenue, 1101 4th St., SW, Washington, DC 20024 Attn: Compliance Administration
                        </td>
                    </tr>                  
                </table>
            </div>
          
             <div class="row">
                <div class="clearfix">&nbsp;</div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 Text-center">
                    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" Onclick="btnSave_Click"/>
                </div>
                <div class="clearfix">&nbsp;</div>
            </div>
        </div>
       
        <div id="AllowanceWorksheetHeader" class="row" style="font-size:large; margin-left:.2%; margin-right:5%; padding:10px 10px 10px 10px;">
            <table border="0" style="width: 100%; margin-top: 20px;">
                <tbody>
                    <tr>
                        <td colspan="8">
                            <div style="width: 100%;">
                                <span style="width: 50%;">
                                    <img src="images/Columbia-DC-flag.png"/>
                                </span>
                                <span style="width: 50%; display: inline-block; vertical-align: middle;">
                                    Government of the
                                    <br/>
                                    District of Columbia
                                </span>
                            </div>

                        </td>
                        <td colspan="22">
                            <h4>
                                 <span style="">
                                    <strong>D-4 DC Withholding Allowance Worksheet</strong>
                                </span>
                            </h4>
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>
   
        <div id="AllowanceWorksheet" class="row" style="font-size:large; margin-left:.2%; margin-right:5%; border:1px solid black; padding:10px 10px 10px 10px;">
            <table style="width: 100%; border:2px" >
                <tbody>
                    <tr>
                        <td style="width:5%;">&nbsp;</td>
                        <td style="width:75%;"></td>
                        <td style="width:5%;"></td>
                        <td style="width:12%;"></td>
                        <td style="width:3%;"></td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <b>Section A Number of withholding allowances</b>
                        </td>
                    </tr>
                         
                    <tr style="vertical-align: top;">
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> a </b>
                        </td>
                        <td colspan="1" style="vertical-align: top;">
                            Enter 1 for yourself 
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> a </b>
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: right; display: inline-block;">
                            <asp:TextBox ID="txtAllowanceA" runat="server" Width="70px" CssClass="center" onkeypress="return onlyNumbers();"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressiontxtAllowanceA" runat="server" CSSClass="red" ControlToValidate="txtAllowanceA" ValidationExpression="\b(0|1)\b" ErrorMessage="<b>Only 0 or 1 are valid</b>" Display="Dynamic" />
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="vertical-align: top;">
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> b </b>
                        </td>
                        <td colspan="1" style="vertical-align: top;">
                            Enter 1 if you are filing as a head of household  
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> b </b>
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: right; display: inline-block;">
                            <asp:TextBox ID="txtAllowanceB" runat="server" Width="70px" CssClass="center" onkeypress="return onlyNumbers();"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressiontxtAllowanceB" runat="server" CSSClass="red" ControlToValidate="txtAllowanceB" ValidationExpression="\b(0|1)\b" ErrorMessage="<b>Only 0 or 1 are valid</b>" Display="Dynamic" />
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="vertical-align: top;">
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> c </b>
                        </td>
                        <td colspan="1" style="vertical-align: top;">
                            Enter 1 if you are 65 or over
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> c </b>
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: right; display: inline-block;">
                            <asp:TextBox ID="txtAllowanceC" runat="server" Width="70px" CssClass="center" onkeypress="return onlyNumbers();"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressiontxtAllowanceC" runat="server" CSSClass="red" ControlToValidate="txtAllowanceC" ValidationExpression="\b(0|1)\b" ErrorMessage="<b>Only 0 or 1 are valid</b>" Display="Dynamic" />
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="vertical-align: top;">
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> d </b>
                        </td>
                        <td colspan="1" style="vertical-align: top;">
                            Enter 1 if you are blind
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> d </b>
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: right; display: inline-block;">
                            <asp:TextBox ID="txtAllowanceD" runat="server" Width="70px" CssClass="center" onkeypress="return onlyNumbers();"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressiontxtAllowanceD" runat="server" CSSClass="red" ControlToValidate="txtAllowanceD" ValidationExpression="\b(0|1)\b" ErrorMessage="<b>Only 0 or 1 are valid</b>" Display="Dynamic" />
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="vertical-align: top;">
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> e </b>
                        </td>
                        <td colspan="1" style="vertical-align: top;">
                            Enter number of dependents
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> e </b>
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: right; display: inline-block;">
                            <asp:TextBox ID="txtAllowanceE" runat="server" Width="70px" CssClass="center" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="vertical-align: top;">
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> f </b>
                        </td>
                        <td colspan="1" style="vertical-align: top;">
                            Enter 1 for your spouse or registered domestic partner filing jointly or filing separately on same return or if you are a qualifying widow(er)
							with dependent child
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> f </b>
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: right; display: inline-block;">
                            <asp:TextBox ID="txtAllowanceF" runat="server" Width="70px" CssClass="center" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="vertical-align: top;">
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> g </b>
                        </td>
                        <td colspan="1" style="vertical-align: top;">
                            Enter 1 if married or registered domestic partner filing jointly or filing separately on same return and your spouse or registered domestic
							partner is 65 or over 
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> g </b>
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: right; display: inline-block;">
                            <asp:TextBox ID="txtAllowanceG" runat="server" Width="70px" CssClass="center" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="vertical-align: top;">
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> h </b>
                        </td>
                        <td colspan="1" style="vertical-align: top;">
                            Enter 1 if married or registered domestic partner filing jointly or filing separately on same return and your spouse or registered domestic
							partner is blind
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> h </b>
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: right; display: inline-block;">
                            <asp:TextBox ID="txtAllowanceH" runat="server" Width="70px" CssClass="center" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="vertical-align: top;">
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> i </b>
                        </td>
                        <td colspan="1" style="vertical-align: top;">
                            Number of allowances Add Lines a through h, enter here and on Line 2 above, next to "Enter total from Sec. A, Line i"
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> i </b>
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: right; display: inline-block;">
                            <asp:TextBox ID="txtAllowanceI" runat="server" Width="70px" CssClass="center" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                        <td colspan="1"></td>
                    </tr>

                    <tr style="width: 100%;">
                        <td colspan="5">
                            <b><small> If you want to claim additional withholding allowances, complete Section B below</small></b>
                        </td>
                    </tr>

                    <tr style="width: 100%;">
                        <td colspan="5">
                            <b> Section B Additional withholding allowances
                            </b>
                        </td>
                    </tr>
                    <tr style="vertical-align: top;">
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> j </b>
                        </td>
                        <td colspan="1" style="vertical-align: top;">
                            Enter estimate of your itemized deductions  
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> j </b>
                        </td>
                        <td colspan="2" style="vertical-align: top; text-align: right; display: inline-block;">
                            <asp:TextBox ID="txtAllowanceJ" runat="server" Width="200px" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="vertical-align: top;">
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> k </b>
                        </td>
                        <td colspan="1" style="vertical-align: top;">
                            Enter $6,500 if single, married/registered domestic partners filing separately or a dependent. Enter $9,550 if head of household. Enter $13,000 if married/registered domestic partner filing jointly, married filing separately on the same return, or qualifying widow(er) with dependent child. 						  
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> k </b>
                        </td>
                        <td colspan="2" style="vertical-align: top; text-align: right; display: inline-block;">
                            <asp:TextBox ID="txtAllowanceK" runat="server" Width="200px" ></asp:TextBox>
                        </td>
                    </tr> 
                    <tr style="vertical-align: top;">
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> l </b>
                        </td>
                        <td colspan="1" style="vertical-align: top;">
                            Subtract Line k from Line j
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> l </b>
                        </td>
                        <td colspan="2" style="vertical-align: top; text-align: right; display: inline-block;">
                            <asp:TextBox ID="txtAllowanceL" runat="server" Width="200px" ></asp:TextBox>
                        </td>
                    </tr> 
                    <tr style="vertical-align: top;">
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> m </b>
                        </td>
                        <td colspan="1" style="vertical-align: top;">
                            Divide Line l by $4,150. Round to the nearest whole number, enter here and on Line 2 above, next to "Enter total from Sec.B, Line m".
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> m </b>
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: right; display: inline-block;">
                            <asp:TextBox ID="txtAllowanceM" runat="server" Width="70px" CssClass="center" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                        <td colspan="1"></td>
                    </tr>
                    <tr style="vertical-align: top;">
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> n </b>
                        </td>
                        <td colspan="1" style="vertical-align: top;">
                            Add Lines m and i, enter here and on Line 2 above, next to "Total number of withholding allowances, Line n".
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: center;">
                            <b> n </b>
                        </td>
                        <td colspan="1" style="vertical-align: top; text-align: right; display: inline-block;">
                            <asp:TextBox ID="txtAllowanceN" runat="server" Width="200px" CssClass="center" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                        <td colspan="1"></td>
                    </tr> 
                </tbody>
            </table>
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
        input[type=text], textarea {outline: none; min-height: 30px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 20px; height: 20px; cursor: pointer; background: #f0f4fa; display: inline-block; padding-left:3px; padding-right: 3px; color: black;}
        table {background-color:white; border-collapse: separate; border-spacing: 0 5px;}
        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; padding-left:5px;}
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
    </style>
</asp:Content>
