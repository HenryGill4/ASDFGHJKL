<%@ Page Title="KS State Withholding Page"
    Language="vb"
    AutoEventWireup="false"
    MasterPageFile="~/AppMasterHeader.Master"
    CodeBehind="EE_W4_KS.aspx.vb"
    Inherits="HReaseApp.EE_W4_KS"
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

        function single1(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkJoint]').prop("checked", false);
                $('input:checkbox[id$=chkJoint1]').prop("checked", false);
                $('input:checkbox[id$=chkSingle1]').prop("checked", true);
            }
        }
        function single2(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkJoint1]').prop("checked", false);
                $('input:checkbox[id$=chkJoint]').prop("checked", false);
                $('input:checkbox[id$=chkSingle]').prop("checked", true);
            }
        }
        function Joint1(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingle1]').prop("checked", false);
                $('input:checkbox[id$=chkSingle]').prop("checked", false);
                $('input:checkbox[id$=chkJoint1]').prop("checked", true);
            }
        }
        function Joint2(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingle]').prop("checked", false);
                $('input:checkbox[id$=chkSingle1]').prop("checked", false);
                $('input:checkbox[id$=chkJoint]').prop("checked", true);
            }
        }

        function exempt(checkbox) {
            if (checkbox.checked) {
                var a = '0'
                var a = parseFloat(a)
                //alert('Checkbox has been checked put this in TotalExemptions: ' + a);
                $('input:text[id$=txtTotalExemptions]').val(a);
                $('input:text[id$=txtAdditionalWithholding]').val(0.00)

            }
        }

        function notexempt(textbox) {
            if (textbox != '0') {
                //alert('Textbox is not empty');
                $('input:checkbox[id$=chkExempt]').prop("checked", false);
            }
        }


        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

        function onlyZeroOrOne(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode == 48 || charCode == 49)
                return true;
            return false;

        }

        function onlyTwoOrZero(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode == 48 || charCode == 50)
                return true;
            return false;

        }

        $(function () {

            $('input:text[id$=hdnPW]').val(document.getElementById('jsfirst').innerHTML);

            var textBox2 = $('input:text[id$=txtBoxB]').keyup(foo);
            var textBox3 = $('input:text[id$=txtBoxC]').keyup(foo);
            var textBox4 = $('input:text[id$=txtBoxD]').keyup(foo);
            var textBox5 = $('input:text[id$=txtBoxE]').keyup(foo);


            function foo() {
                var a = textBox2.val();
                var b = textBox3.val();
                var c = textBox4.val();
                var d = textBox5.val();
                var sum = add(a, b, c, d)
                $('input:text[id$=txtBoxF]').val(sum);
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


    </script>
    <div class="HREwrapper" style="text-align:center; width:95%; align-self:center;" >
        <div id="divPageTitle" runat="server">
            <div style="text-align:center;">
                <br />
                <h4><b>Kansas Form K-4</b></h4>
                <br />
                <br />
            </div>
        </div>
        <div id="divTopHeader" class="form-group" style=" margin-top:-40px; margin-left:auto; margin-right:auto; width:100%;">                  
            <div id="divError" runat="server" visible="false" class="HREError">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
            </div>
            <div class="form-group" style="display:inline;">
                <div id="divSuccess" runat="server" visible ="false" class="HRESuccess">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" ImageAlign="Left" />
                    <asp:Label ID="lblSuccess" runat="server" Text="&nbsp;&nbsp;&nbsp;&nbsp;Form Complete" Width="50%"></asp:Label>
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
            
             <table style="width: 100%; background-color: transparent; margin-left: 10px; margin-right: 10px;">
                    <tbody>
                        <tr style="width: 100%;margin-left: 10px; margin-right: 10px;">
                            <td style="width: 20%; padding-top:1.5%;">
                        <div style="line-height: 14px; vertical-align:middle;">
                            <span style="font-size: 35px; font-weight: 700;">
                                &nbsp;&nbsp;K-4</span><br />
                           &nbsp; <span style="font-size: 12px;">(Rev. 11-18)</span>
                        </div>
                    </td>
                    <td style="width: 60%; text-align: center; padding-top:1.5%;">
                        <div style="padding-top:5px;">
                            
                             <span style="font-size: large; font-weight: 700; line-height: 0px;">
                                <span style="font-size:200%;">KANSAS<br /></span>
                                 <span style="text-align:center;">
                               <br /> EMPLOYEE'S WITHHOLDING ALLOWANCE CERTIFICATE<br /><br /> 
                                </span>
                            </span>
                        </div>
                    </td>
                            <td style="width: 20%;">&nbsp;
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="row" style="margin-top: 20px; margin-left: 10px; margin-right: 10px;/* text-align: justify !important; */">
                <div class="col-md-4" style="padding-left: 0; text-align: justify !important;">
                    <p>
                        Use the following instructions to accurately
				        complete your K-4 form, then detach
				        the lower portion and give it to your
				        employer. For assistance, call the Kansas
			            Department of Revenue at 785-368-8222.
                    </p>
                    <p>
                        <b>Purpose of the K-4 form: </b>A completed
				        withholding allowance certificate will let
				        your employer know how much Kansas
				        income tax should be withheld from your
				        pay on income you earn from Kansas
				        sources. Because your tax situation may
				        change, you may want to re-figure your
			            withholding each year.
                    </p>
                    <p><b>Exemption from Kansas withholding: </b></p>
                    <p>
                        To qualify for exempt status you must
				        verify with the Kansas Department of
				        Revenue that: <b>1)</b> last year you had the
			            right to a refund of all STATE income tax
                    </p>
                </div>
                <div class="col-md-4" style="text-align: justify !important;">
                    <p>
                        withheld because you had no tax liability;
				        and <b>2)</b> this year you will receive a full
				        refund of all STATE income tax withheld
			            because you will have no tax liability.
                    </p>
                    <p>
                        <b>Basic Instructions:</b> If you are not exempt,
				        complete the Personal Allowance
				        Worksheet that follows. The total on line
				        F should not exceed the total exemptions
				        you claim under “Exemptions and
				        Dependents” on your Kansas income tax
			            return.
                    </p>
                    <p>
                        <b>NOTE:</b>Your status of “Single” or “Joint”
				        may differ from your status claimed on
				        your federal Form W-4). 
                    </p>
                    <p>
                        Using the information from your Personal
				        Allowance Worksheet, complete the
				        K-4 form below, sign it and provide it to
			            your employer. If your employer does not
                    </p>
                </div>
                <div class="col-md-4" style="padding-right: 0; text-align: justify !important;">
                    <p>
                        receive a K-4 form from you, they must
				        withhold Kansas income tax from your
				        wages without exemption at the “Single”
			            allowance rate.
                    </p>
                    <p>
                        <b>Head of household: </b>Generally, you may
				        claim head of household filing status on
				        your tax return only if you are unmarried
				        and pay more than 50% of the cost of
				        keeping up a home for yourself and for
			            your dependent(s).
                    </p>
                    <p>
                        <b>Non-wage income: </b>If you have a large
				        amount of non-wage Kansas source
				        income, such as interest or dividends,
				        consider making Kansas estimated tax
				        payments on Form K-40ES. Without
				        these payments, you may owe additional
				        Kansas tax when you file your state
			            income tax return.
                    </p>
                </div>
        </div>
    </div>
     
    <div id="PersonalAllowancesHeaderBar" class="well HRESlateBlue HRERewrap" style="align-self:center; max-height:100px;  margin:auto; width:95%; margin-top:1.5%;" align="center">
	                 <span><b>PERSONAL ALLOWANCES WORKSHEET</b></span>
	                 <img src="img/plus.png" class="instruction_toggle_btn1" style="vertical-align:middle; float: right; width: 30px; max-height:100px; padding-bottom:10px;" />
                </div>
         <div id="PersonalAllowancesWorksheet" class="form-group instruction_toggle1 HREWhite" style="margin:auto; width:95%; text-align:center; margin-top:1%; border:0px;">
            <div id="WorksheetInstructions" align="center" style="border-top: 2px solid black; width: 100%; text-align:center; ">
        <table style="width: 100%;background-color:white; border-bottom: 2px solid black;">
            <tbody>
                <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                    <td style="width: 20%; padding-top:1.5%;">
                        <div style="line-height: 14px; vertical-align:middle;">
                            <span style="font-size: 35px; font-weight: 700;">
                                &nbsp;&nbsp;K-4</span><br />
                           &nbsp; <span style="font-size: 12px;">(Rev. 11-18)</span>
                        </div>
                    </td>
                    <td style="width: 60%; text-align: center; padding-top:1.5%;">
                        <div style="padding-top:5px;">
                            
                             <span style="font-size: large; font-weight: 700; line-height: 0px;">
                                <span style="font-size:200%;">KANSAS<br /></span>
                                 <span style="text-align:center;">
                               <br /> EMPLOYEE'S WITHHOLDING ALLOWANCE CERTIFICATE<br /><br /> 
                                </span>
                            </span>
                        </div>
                    </td>
                    <td style="width: 20%;">&nbsp;
                    </td>
                </tr>
            </tbody>
        </table>
    
    <div id="jsfirst" class="HREWhite" style="width: 100%; margin-right:0px; border:0px; margin-bottom:2%;" align="center">
        <table style="width: 100%; background-color:white; ">
            <tbody style="font-size:18px;">

                <tr style="width: 100%; height: 90px;margin-left: 10px; margin-right: 10px;"">

                    <td style="width: 80%; padding-bottom:5px;">
                        <div style="width: 100%;">
                            <div class="col-md-3" style="padding-left: 0; width: 20%;">
                        <span style="float:left; padding-right:11%;">
                        <strong>A</strong>
                        </span>
                        <span style="float:left; width:fit-content;">
                            Allowance Rate: 
                        </span>
                            </div>
                            <div class="col-md-9" style="padding-left: 2%; width: 70%; float:left;">
                                If you are a single filer mark “Single”<br />
                                If you are married and <u>your</u> <u>spouse</u> <u>has</u> <u>income</u> mark “Single”<br />
                                If you are married and your spouse does not work mark “Joint” 
                            </div>
                        </div>
                    </td>

                    <td style="width: 20%; padding-bottom:5px;">
                        <span style="float:left; padding-right:8%;">
                        <strong>A.</strong>
                        </span>
                        <span style="float:left;">
                        <label class="" style="vertical-align:bottom;">
                            <asp:CheckBox ID="chkSingle" runat="server" onclick="single1(this)" Text="&nbsp;&nbsp;Single" />
                        </label>
                        <br />
                        <label class="" style="margin-left: auto;">
                            <asp:CheckBox ID="chkJoint" runat="server" onclick="Joint1(this)" Text="&nbsp;&nbsp;Joint" />
                        </label>
                        </span>
                    </td>

                </tr>

                <tr style="width: 100%;margin-left: 10px; margin-right: 10px; ">
                    <td style="width: 80%; padding-bottom:2%;">
                        <span style="float:left; padding-right:2%;">
                        <strong >B</strong>
                        </span>
                        <span style="float:left; width:80%;">
                            Enter “0” or “1” if you are married or single and no one else can claim you as a dependent (entering “0” may help
						you avoid having too little tax withheld)
                        </span>
                    </td>
                    <td style="width: 20%; padding-bottom:2%;">
                        <span style="float:left; padding-right:5%;">
                        <strong >B</strong>
                        </span>
                        <span style="text-align:center; width:80%;">
                            <asp:TextBox ID="txtBoxB" runat="server" style="border-bottom: 1px solid;" onkeypress="return onlyZeroOrOne()" CssClass="center"/>
                        </span> 
                    </td>
                </tr>
                <tr style="width: 100%;margin-left: 10px; margin-right: 10px;">
                    <td style="width: 80%; padding-bottom: 20px;">
                        <span style="float:left; padding-right:2%;">
                        <strong >C</strong>
                        </span>
                        <span style="float:left; width:80%;">Enter “0” or “1” if you are married and only have one job, and your spouse does not work (entering “0” may help
						you avoid having too little tax withheld).
                        </span>
                    </td>
                    <td style="width: 20%;">
                        <span style="float:left; padding-right:5%;">
                        <strong >C</strong>
                        </span>
                        <span style="text-align:center; width:80%;">
                            <asp:TextBox ID="txtBoxC" runat="server" style="border-bottom: 1px solid;" onkeypress="return onlyZeroOrOne()" CssClass="center"/>

                        </span>
                    </td>
                </tr>
                <tr style="width: 100%;margin-left: 10px; margin-right: 10px;">
                    <td style="width: 80%; padding-bottom: 20px;">
                        <span style="float:left; padding-right:2%;">
                        <strong >D</strong>
                        </span>
                        <span style="float:left; width:80%;">
                            Enter “2” if you will file head of household on your tax return (see conditions under Head of household above)
                        </span>
                    </td>
                    <td style="width: 20%;">
                        <span style="float:left; padding-right:5%;">
                        <strong >D</strong>
                        </span>
                        <span style="text-align:center; width:80%;">
                            <asp:TextBox ID="txtBoxD" runat="server" style="border-bottom: 1px solid;" onkeypress="return onlyTwoOrZero()" CssClass="center"/>
                        </span>
                    </td>
                </tr>
                <tr style="width: 100%;margin-left: 10px; margin-right: 10px;">
                    <td style="width: 80%; padding-bottom: 20px; margin-right:10%;">
                        <span style="float:left; padding-right:2%;">
                        <strong >E</strong>
                        </span>
                        <span style="float:left; width:80%;">Enter the number of dependents you will claim on your tax return. Do not claim yourself or your spouse or
						dependents that your spouse has already claimed on their form K-4.
                        </span>
                    </td>
                    <td style="width: 20%;">
                       <span style="float:left; padding-right:5%;">
                        <strong >E</strong>
                        </span>
                        <span style="text-align:center; width:80%;">
                            <asp:TextBox ID="txtBoxE" runat="server" style="border-bottom: 1px solid;" CssClass="center"/>
                        </span>
                    </td>
                </tr>
                <tr style="width: 100%;margin-left: 10px; margin-right: 10px;">
                    <td style="width: 80%;">
                        <span style="float:left; padding-right:2%;">
                        <strong >F</strong>
                        </span>
                        <span style="float:left; width:80%;"><strong>Add lines B through E</strong> and enter the total here .
                        </span>
                    </td>
                    <td style="width: 20%;">
                        <span style="float:left; padding-right:5%;">
                        <strong>F</strong>
                        </span>
                        <span style="text-align:center; width:80%;">
                            <asp:TextBox ID="txtBoxF" runat="server" style="border-bottom: 1px solid;" CssClass="center" />
                        <br />
                        </span>
                    </td>
                </tr>
                
            </tbody>
        </table>
        
        </div>
        </div>
        
    </div>
    <div style="width:100%; text-align:center;">
        <table style="width: 100%;background-color:white; border-bottom: 2px solid black; margin-bottom:2.5%;">
            <tbody>
                <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                    <td style="width: 20%; padding-top:1.5%;">
                        <div style="line-height: 14px; vertical-align:middle;">
                            <span style="font-size: 35px; font-weight: 700;">
                                &nbsp;&nbsp;K-4</span><br />
                           &nbsp; <span style="font-size: 12px;">(Rev. 11-18)</span>
                        </div>
                    </td>
                    <td style="width: 60%; text-align: center; padding-top:1.5%;">
                        <div style="padding-top:5px;">
                            
                             <span style="font-size: large; font-weight: 700; line-height: 0px;">
                                <span style="font-size:200%;">KANSAS<br /></span>
                                 <span style="text-align:center;">
                               <br /> EMPLOYEE'S WITHHOLDING ALLOWANCE CERTIFICATE<br /><br /> 
                                </span>
                            </span>
                        </div>
                    </td>
                    <td style="width: 20%;">&nbsp;
                    </td>
                </tr>
            </tbody>
        </table>
        <table style="width:95%; background-color:white; margin-left:auto; margin-right:auto; ">
            <thead style="text-align:center;" >       
                <tr style="text-align:center; width:100%;">
                    <td style="text-align:center;" colspan="6">
                        <h3>
                            <b>Kansas Employee’s Withholding Allowance Certificate</b>
                        </h3>
                    </td>
                               
                </tr>  
                <tr style="text-align:center; width:100%;">
                    <td style="text-align:center; width:100%;" colspan="6">
                        <h6 style="width:50%; text-align:center; margin-left:25%; margin-right:25%;">
                                        Whether you are entitled to claim a certain number of allowances or exemption from withholding is subject to review by the
								        Kansas Department of Revenue. Your employer may be required to send a copy of this form to the Department of Revenue. 
                        </h6>
                    </td>
                </tr>
            </thead>    
            <tr>
                <td style="width:2%"></td>
                <td style="width:33%"></td>
                <td style="width:25%"></td>
                <td style="width:25%"></td>
                <td style="width:2%"></td>
                <td style="width:13%"></td>
            </tr>
            <tr style="width: 100%; border-top:solid 1px black;">
                <td colspan="1" class="cels HRETan" style="vertical-align:top; text-align:center; border-bottom:1px solid black;">
                    &nbsp;<b>1</b>&nbsp;
                </td>
                <td colspan="1" class="cels HRETan" style="border-right: 1px solid black; border-bottom:1px solid black;">
                    <span> Print your First Name and Middle Initial <br /><strong>
                        <asp:Label ID="lblFName" runat="server" style="width: 95%; vertical-align:bottom;" /></strong></span>
                    
                </td>
                <td colspan="1" class="cels HRETan" style="border-right: 1px solid black; border-bottom:1px solid black;">
                    <span>Last Name <br /><span><strong>
                        <asp:Label ID="lblLName" runat="server" style="width: 95%;vertical-align:bottom;" /></strong></span></span>
                    
                </td>
                <td colspan="3" class="cels HRETan" style="padding-left:15px; border-bottom:1px solid black;">
                    <span><b style="padding-right:8px; float:left;">2</b>Social Security Number <br /><span style="float:left; padding-left:16px;"><strong>
                        <asp:Label ID="lblSSNumber" runat="server" style="width:95%; " /></strong></span> </span>

                </td>
            </tr>
            <tr style="width: 100%;">
                <td class="cels HRETan" colspan="1" style="border-bottom:1px solid black;" >
                </td>
                <td class="cels HRETan" colspan="2" style="border-right: 1px solid black; border-bottom:1px solid black;">
                     <span>Mailing Address <br /><span><strong><asp:Label ID="lblMailAddress" runat="server" /></strong></span></span> 
                    
                </td>
                <td class="cels" colspan="3" style="border-left:1px solid black;padding-left:15px;">
                    <span>
                        <b style="padding-right:8px; float:left;">3</b>
                        <span style="float:left;">
                            Allowance Rate 
                            <br />
                            Mark the allowance rate selected in line A above.
                        </span>
                    </span>                  
                </td>
            </tr>
            
            <tr>
                <td class="cels HRETan" colspan="1">
                </td>
                <td class="cels HRETan" colspan="2" style="border-right: 1px solid black;">
                    <span style="vertical-align:bottom;"><strong><asp:Label ID="lblCityStateZip" runat="server" style="width: 80%;" /></strong></span>
                </td>
                <td  colspan="3" style="text-align:center; padding-bottom:15px;">
                    
                        <label class="checkbox-inline" style=" padding-right: 20%;">
                            <asp:CheckBox ID="chkSingle1"  runat="server"  onclick="single2(this)"  />
                            <span style="padding-left:10px;">Single</span>
                        </label>
                        <label class="checkbox-inline" >
                            <asp:CheckBox ID="chkJoint1"  runat="server"   onclick="Joint2(this)"/>
                            <span style="padding-left:10px;">Joint</span>
                        </label>
                         
                    
                    
                </td>

            </tr>
            <tr style="width: 100%; border-top:1px solid black; border-bottom:1px solid black; text-align:center;">
                 <td class="cels" colspan="1" style="text-align:center;">
                     &nbsp;<b>4</b>&nbsp; 
                </td>
                <td class="cels" colspan="3">Total number of allowances you are claiming (from line F above) .
                </td>
                <td class="cels" colspan="1" style="text-align: center; border: 1px solid black;">
                    <b>4</b></td>
                <td class="cels" colspan="1" style="text-align:right;">
                    <asp:TextBox ID="txtTotalExemptions" runat="server" style="width: 80%; text-align:center;" onblur="notexempt(this)"/>
                </td>
            </tr>

            <tr style="width: 100%;">
                <td class="cels" colspan="1" style="border-bottom: 1px solid black; text-align:center;">
                    &nbsp;<b>5</b>&nbsp; 
                </td>
                <td class="cels" colspan="3" style="border-bottom: 1px solid black;">
                    Enter any additional amount you want withheld from each paycheck (this is optional) .
                </td>

                <td class="cels" colspan="1" style="text-align: center; border: 1px solid black;">
                    <b>5</b></td>
                <td class="cels" colspan="1" style="text-align: right; border-bottom: 1px solid black;">
                    $<asp:TextBox ID="txtAdditionalWithholding" runat="server" style="width: 80%; text-align:right; padding-right:5px;" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" />
                </td>

            </tr>

            <tr style="width: 100%;">
                <td class="cels" colspan="1" style="vertical-align:top; text-align:center;">
                    &nbsp;<b>6</b>&nbsp;
                </td>
                <td class="cels" colspan="3"> 
                    I claim exemption from withholding. (You must meet the conditions explained in the "Exemption from withholding"<br />
					instructions above.) If you meet the conditions above, write "Exempt" on this line<br />
					<b>Note: The Kansas Department of Revenue will receive your federal W-2 forms for all years claimed Exempt. </b>
                    
                </td>
                <td class="cels" colspan="1" style="width:2%; text-align: center; border-left: 1px solid black; border-right:1px solid black;">
                    <b>6</b>
                </td>
                <td class="cels" colspan="1" style="width:13%;text-align:left; padding-left:3%; vertical-align:middle;">
                    <asp:CheckBox ID="chkExempt" runat="server" CssClass="text-center bold" Text="&nbsp;EXEMPT" onclick="exempt(this)"/>
                </td>

            </tr>
            <tr style="width: 100%; border-top:1px solid black;">
                <td class="cels" colspan="1">
                </td>
                <td class="cels" colspan="3"><span>Under penalties of perjury, I declare that I have examined this certificate and to the best of my knowledge and belief it is true, correct, and complete.<br /><strong>SIGN HERE</strong>	
                    <asp:TextBox ID="txtSignature" runat="server" placeholder="Signature" Style="width: 60%;" ></asp:TextBox></span> 
                </td>
                <td class="cels" colspan="2" style="vertical-align:bottom;">
                    <span>Date<br /><asp:TextBox ID="SignatureDate" runat="server" Cssclass="center"></asp:TextBox></span>
                </td>
            </tr>
            <tr style="width: 100%;">
                <td class="cels" colspan="1">

                </td>
                <td class="cels" colspan="3"></td>
                <td colspan="2">
                </td>

            </tr>

            <tr style="width: 100%;border-top:1px solid black; border-bottom:1px solid black">
               <td  class="cels HRETan" colspan="1" style="vertical-align:top; text-align:center;">
                    &nbsp;<strong>7</strong>&nbsp;
                </td>
                <td  class="cels HRETan" style="vertical-align:top;" colspan="3">
                    Employer's name and address
                    <br/>
                    <span style="width:100%;">
                    <strong><asp:Label ID="lblEmployerName" runat="server" style="width: 50%; padding-right:15px;" />
                         </strong>
                    <strong><asp:Label ID="lblEmployerAddress" runat="server" style="width: 30%;" />
                         </strong>
                    <strong><asp:Label ID="lblEmployerCityStateZip" runat="server" style="width: 20%;" /></strong>

                    </span>
                </td>
                <td class="cels HRETan" style="vertical-align:top;" colspan="2">
                    <div class="align-center center"><span>&nbsp;<strong>8</strong> &nbsp; EIN (Employer ID Number)</span>
                    <br/>
                    <span style="text-align:center; width:100%;"> 
                        <b><asp:Label ID="lblEmployerFEIN" runat="server" style="width: 80%; text-align:center;" /></b>
                    </span>
                   </div>
                </td>

            </tr>

        </table>
    </div>
     
    <div id="divFormFooter" class="row HRERewrap">
        <br />
        <div style="float:right;">
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

        table {
            background-color: white;
            color: black;
            border-collapse: collapse;
        }

        p {
            color: black;
        }

        li {
            color: black;
        }


        .HREwrapper {
            margin-left: auto;
            margin-right: auto;
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
            background-color: #f5f5f0;
            padding-left: 5px;
        }

        .HRELightBlue {
            background-color: #EFF3FB;
        }

        .HRERewrap {
            margin-right: 5%;
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

        .row {
            text-align: center;
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

        table td {
            padding-left: 0px;
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
            margin-right: 0px;
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
            padding-right: 10px;
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
            background-color: white;
            border: 1px solid grey;
            padding: 10px;
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

        .HRERewrap {
            margin-right: auto;
        }

        .HREpadR10 {
            padding-right: 20px;
            float: right;
        }
    </style>
</asp:Content>
