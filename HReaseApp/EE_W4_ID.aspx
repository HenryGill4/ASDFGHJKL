<%@ Page Title="ID State Withholding Page"
    Language="vb"
    AutoEventWireup="false"
    MasterPageFile="~/AppMasterHeader.Master"
    CodeBehind="EE_W4_ID.aspx.vb"
    Inherits="HReaseApp.EE_W4_ID"
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

        function makeMoney(source) {
            //Grab the value from the element
            var money = parseFloat(source.value, 10).toFixed(2);

            //Format your value
            source.value = money.toString();
        }

        $(function () {

            $('input:text[id$=hdnPW]').val(document.getElementById('jsfirst').innerHTML);          

            var textBox1 = $('input:text[id$=TEBox1]').keyup(foo);
            var textBox2 = $('input:text[id$=TEBox2]').keyup(foo);
            var textBox3 = $('input:text[id$=TEBox3]').keyup(foo);
            var textBox4 = $('input:text[id$=TEBox4]').keyup(foo);
            var textBox5 = $('input:text[id$=TEBox5]').keyup(foo);
            var textBox9 = $('input:text[id$=TEBox9]').keyup(foo);

            function foo() {

                var a = textBox1.val();
     
                var sum = (a * 12550);
                var sum = parseFloat(sum, 10).toFixed(2)

                $('input:text[id$=TEBox2]').val(sum);

                var b = textBox2.val();
                var c = textBox3.val();
                var i = Math.min(b, c)
                var i = parseFloat(i, 10).toFixed(2)

                $('input:text[id$=TEBox4]').val(i);

                var e = textBox5.val();
                var mult = (e * 3154)
                var mult = parseFloat(mult, 10).toFixed(2)

                $('input:text[id$=TEBox6]').val(mult);

                var textBox6 = $('input:text[id$=TEBox6]').keyup(foo);

                var d = textBox4.val();
                var f = textBox6.val();
                var j = d - f
                var j = parseFloat(j, 10).toFixed(2)

                $('input:text[id$=TEBox7]').val(j);

                var textBox7 = $('input:text[id$=TEBox7]').keyup(foo);

                var g = textBox7.val();
                var k = (g * 0.065)
                var k = parseFloat(k, 10).toFixed(2)

                $('input:text[id$=TEBox8]').val(k);

                var h = textBox9.val();
                var h = parseFloat(h, 10).toFixed(2)

                $('input:text[id$=textBox9]').val(h);
                $('input:text[id$=AdditionalWithholding]').val(h);

            }

            function IsNumeric(input) {
                return (input - 0) == input && input.length > 0;
            }

        });

        function single(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=MarriedCheckbox]').prop("checked", false);
                $('input:checkbox[id$=MarriedWithholdCheckbox]').prop("checked", false);
            }
        }
        function married(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=SingleCheckbox]').prop("checked", false);
                $('input:checkbox[id$=MarriedWithholdCheckbox]').prop("checked", false);
            }
        }
        function marriedwithholdhigher(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=SingleCheckbox]').prop("checked", false);
                $('input:checkbox[id$=MarriedCheckbox]').prop("checked", false);
            }
        }


    </script>

     <div class="HREwrapper">
        <div id="PageTitle">
            <div>
                <br />
                <h4><b>Idaho Form ID W-4</b></h4>
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

        <div id="InstructionHeaderBar" class="well HRESlateBlue HRERewrap" style="text-align:center;">
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px; padding-bottom:10px;" />

        </div>

        <div id="Instructions" class="form-group instruction_toggle HREWhite" style="margin-right:5%;">
            <div style="text-align:center; ">
                <img src="images/header.jpg" style="width:100%; height:auto;"/>
            </div>   
            <br />
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <p> 
                    Complete Form ID W-4 so your employer can withhold the correct amount of state income tax from your 
                    paycheck. Sign the form and give it to your employer.
                    <b>Use the information on the back</b> to calculate your Idaho allowances and any additional 
                    amount you need withheld from each paycheck.  If you plan to itemize deductions, use the worksheet at 
                    <b><a href="https://tax.idaho.gov/w4" target="_blank">tax.idaho.gov/w4.</a></b>
                    
                </p>

                <p>
                    <b>Withholding Status</b>
                </p>

                <span>
                    Check the &quot;<strong>A</strong>&quot; box (Single) if you&#39;re:
                </span>

                <ul id="l1">
                    <li data-list-text="•">
                        Single with one job or single with multiple jobs
                    </li>

                    <li data-list-text="•">
                        Filing as head of household
                    </li>
                </ul>

                <span>
                    Check the &quot;<strong>B</strong>&quot; box (Married) if you&#39;re:
                </span>

                <ul id="l2">
                    <li data-list-text="•">
                        Married filing jointly with one job and your spouse doesn&#39;t work
                    </li>
                    <li data-list-text="•">
                        A qualifying widow(er)
                    </li>
                </ul>

                <span>
                    Check the &quot;<strong>C</strong>&quot; box (Married, but withhold at Single rate) if you&#39;re:
                </span>

                <ul id ="l3">
                    <li data-list-text="•">
                        Married filing jointly and both people work (or you have multiple jobs)
                    </li>
                    <li data-list-text="•">
                        Married filing separately
                    </li>
                </ul>
            </div>
        </div>

        <div id="PersonalAllowancesHeaderBar" class="well HRESlateBlue HRERewrap" style="text-align:center; max-height:100px;">
	            <span><b>PERSONAL ALLOWANCES WORKSHEET</b></span>
	            <img src="img/plus.png" class="instruction_toggle_btn1" style="vertical-align:middle; float: right; width: 30px; max-height:100px; padding-bottom:10px;" />
        </div>
        
        <div id="PersonalAllowancesWorksheet" class="form-group instruction_toggle1 HREWhite" style="margin-right:5%;">
            <div id="WorksheetInstructions" class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
               <img src="images/lowerheader.jpg" style="width: 100%; height: auto;" />
                <p>
                    <b>1.&nbsp; Total number of allowances you&#39;re claiming.</b>
                </p>
                
                <p>                        
                    Enter the number of children in your household age 16 or under as of December 31, 2022. 
                    If you have no qualifying children, enter &quot;0.&quot; If your filing status will be head of household 
                    on your tax return, add &quot;2&quot; to the number of qualifying children. 
                    <b>Don&#39;t </b>claim allowances for you or your spouse. You can claim fewer allowances but not more.
                </p>

                <p>
                    If you&#39;re married, claim your allowances on the W-4 for the highest-paying job for the most accurate 
                    withholding. If you&#39;re married filing jointly, only one of you should claim the allowances. 
                    The other should claim zero allowances.
                </p>
                        
                <p>
                    If you work for more than one employer at the same time, you should claim zero allowances on your W-4 with 
                    any employer other than your principal employer.
                </p>
                        
                <p>
                    Write <b>Exempt </b>on line 1 if you meet <b>both </b>of the following conditions:
                </p>

                <ul id="l5">
                    <li data-list-text="•">
                        Last year I had no Idaho income tax liability <b>and</b>
                    </li>
                    <li data-list-text="•">
                        This year I expect to have no Idaho income tax liability
                    </li>
                </ul>

                <br />

                <p style="color:steelblue">
                    <b>Nonresident Aliens</b>            
                </p>

                <p>
                    <b>Exempt income.</b> If you&#39;re a nonresident alien and all your income is exempt from withholding, 
                    write &quot;Exempt&quot; on line 1.
                </p>

                <p>
                    <b>Exempt income from a treaty.</b> If a treaty exempts a portion of your income from withholding, 
                    complete federal Form 8233 to claim your treaty benefits, and complete the Idaho W-4 to withhold on 
                    income that&#39;s not exempt by your treaty.
                </p>

                <p>
                    <b>Idaho taxable income.</b> If you&#39;re a nonresident alien and have Idaho taxable income, do all of these:
                </p>

                <ol id="l4">
                    <li data-list-text="1." >                        
                            Check the &quot;Single&quot; withholding status box regardless of your marital status.
                    </li>
                    <li data-list-text="2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;">
                        Enter O on line 1.
                    </li>
                    <li data-list-text="3.&nbsp;&nbsp;">
                        Using the Pay Period table below, enter the additional amount of income tax to be withheld for each pay 
                        period on line 2. <i>Exception: </i>If you&#39;re a student or business apprentice from India, report $0 
                        on line 2.
                    </li>
                </ol>
               
                <br />

                <table id="payperiodtable" style="border-collapse: collapse; width: 100%; text-align:center;">
                    <tr>
                        <td style="width: 40%; min-width:100px;"></td>
                        <td style="width: 15%;"></td>
                        <td style="width: 15%;"></td>
                        <td style="width: 15%;"></td>
                        <td style="width: 15%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border:2px solid black;">
                                Pay Period Table
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border:2px solid black;">
                            If your pay period is:
                        </td>
                        <td colspan="1" style="border:2px solid black; vertical-align:bottom;">
                            Weekly
                        </td>
                        <td colspan="1" style="border:2px solid black; vertical-align:bottom;">
                            Bi-Weekly
                        </td>
                        <td colspan="1" style="border:2px solid black; vertical-align:bottom;">
                            Semi-Monthly
                        </td>
                        <td colspan="1" style="border:2px solid black; vertical-align:bottom;">
                            Monthly
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border:2px solid black;">
                            Enter this amount on line 2:
                        </td>
                        <td colspan="1" style="border:2px solid black; text-align:right; padding-right:5px;">
                            $16
                        </td>
                        <td colspan="1" style="border:2px solid black; text-align:right; padding-right:5px;">
                            $31
                        </td>
                        <td colspan="1" style="border:2px solid black; text-align:right; padding-right:5px;">
                            $34
                        </td>
                        <td colspan="1" style="border:2px solid black; text-align:right; padding-right:5px;">
                            $68
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            The withholding table calculations for employers include the standard deduction. 
                            Because nonresident aliens don&#39;t qualify for the standard deduction, the Pay Period table 
                            helps ensure that employers withhold enough.
                        </td>
                    </tr>
                </table>

                <br />

                <p>
                    <b>2.&nbsp;&nbsp;Additional amount, if any, you need withheld from each paycheck.</b>
                </p>

                <p>
                    <b>If you&#39;re single or married filing separately and have more than one job at a time,</b> 
                        complete the worksheet below to calculate any additional amount you need withheld from each paycheck.
                </p>

            </div>

            <div id="pwWorksheettable" style="border-bottom: 2px solid black;">
                
                <table id="jsfirst" style="width: 100%; text-align:left;">
                    <tr>
                        <td style="width:5%;"></td>
                        <td style="width:75%;"></td>
                        <td style="width:5%;"></td>
                        <td style="width:10%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1" class="aligntopright">
                            1.&nbsp;&nbsp;
                        </td>
                        <td colspan="1" class="aligntopleft">
                            Other than your primary job, how many jobs do you expect to have at the same time
                            during 2022? (Don&#39;t count your primary job)
                        </td>  
                        <td colspan="1">&nbsp;</td>
                        <td colspan="1">
                                <asp:TextBox ID="TEBox1" runat="server" CssClass="aligntextfieldbottomcenter" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align: right; float:right;" class="aligntopright">
                            2.&nbsp;&nbsp;
                        </td>
                        <td colspan="1" style="text-align:left;" class="aligntopleft">
                            Multiply the number on line 1 by $12,550
                        </td>  
                        <td colspan="1" class="alignbottomright">
                            $
                        </td>
                        <td colspan="1">
                                <asp:TextBox ID="TEBox2" runat="server" CssClass="aligntextfieldbottomright" onkeypress="return onlyNumbers();" onblur="makeMoney(this)"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align: right; float:right;" class="aligntopright">
                            3.&nbsp;&nbsp;
                        </td>
                        <td colspan="1" style="text-align:left;" class="aligntopleft">
                            Enter an estimate of your 2022 income from other jobs (not including your primary job)
                        </td>  
                        <td colspan="1" class="alignbottomright">
                            $
                        </td>
                        <td colspan="1">
                                <asp:TextBox ID="TEBox3" runat="server" CssClass="aligntextfieldbottomright" onkeypress="return onlyNumbers();" onblur="makeMoney(this)"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align: right; float:right;" class="aligntopright">
                            4.&nbsp;&nbsp;
                        </td>
                        <td colspan="1" style="text-align:left;" class="aligntopleft">
                            Enter the smaller of lines 2 or 3
                        </td>  
                        <td colspan="1" class="alignbottomright">
                            $
                        </td>
                        <td colspan="1">
                                <asp:TextBox ID="TEBox4" runat="server" CssClass="aligntextfieldbottomright" onkeypress="return onlyNumbers();" onblur="makeMoney(this)"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align: right; float:right;" class="aligntopright">
                            5.&nbsp;&nbsp;
                        </td>
                        <td colspan="1" style="text-align:left;" class="aligntopleft">
                            If you completed the itemized deduction worksheet for Idaho 
                            (<a href="https://tax.idaho.gov/w4" target="_blank">tax.idaho.gov/w4</a>), 
                            enter the number from line 4. Otherwise, enter "0"
                        </td>  
                        <td colspan="1" class="alignbottomright">
                            $
                        </td>
                        <td colspan="1">
                                <asp:TextBox ID="TEBox5" runat="server" CssClass="aligntextfieldbottomright" onkeypress="return onlyNumbers();" onblur="makeMoney(this)"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align: right; float:right;" class="aligntopright">
                            6.&nbsp;&nbsp;
                        </td>
                        <td colspan="1" style="text-align:left;" class="aligntopleft">
                            Multiply the number on line 5 by $3,154
                        </td>  
                        <td colspan="1" class="alignbottomright">
                            $
                        </td>
                        <td colspan="1">
                                <asp:TextBox ID="TEBox6" runat="server" CssClass="aligntextfieldbottomright" onkeypress="return onlyNumbers();" onblur="makeMoney(this)"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align: right; float:right;" class="aligntopright">
                            7.&nbsp;&nbsp;
                        </td>
                        <td colspan="1" style="text-align:left;" class="aligntopleft">
                            Subtract line 6 from line 4
                        </td>  
                        <td colspan="1" class="alignbottomright">
                            $
                        </td>
                        <td colspan="1">
                                <asp:TextBox ID="TEBox7" runat="server" CssClass="aligntextfieldbottomright" onkeypress="return onlyNumbers();" onblur="makeMoney(this)"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align: right; float:right;" class="aligntopright">
                            8.&nbsp;&nbsp;
                        </td>
                        <td colspan="1" style="text-align:left;" class="aligntopleft">
                            Multiply line 7 by 6.5% (.065). This is the additional amount you need to withhold annually
                        </td>  
                        <td colspan="1" class="alignbottomright">
                            $
                        </td>
                        <td colspan="1">
                                <asp:TextBox ID="TEBox8" runat="server" CssClass="aligntextfieldbottomright" onkeypress="return onlyNumbers();" onblur="makeMoney(this)"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align: right; float:right;" class="aligntopright">
                            9.&nbsp;&nbsp;
                        </td>
                        <td colspan="1" style="text-align:left;" class="aligntopleft">
                            Divide the amount on line 8 by the number of your remaining pay periods in 2022. 
                            Enter the number on line 2 of the W-4 as the additional amount you need withheld 
                            from each paycheck
                        </td>  
                        <td colspan="1" class="alignbottomright">
                            $
                        </td>
                        <td colspan="1">
                                <asp:TextBox ID="TEBox9" runat="server" CssClass="aligntextfieldbottomright" onkeypress="return onlyNumbers();" onblur="makeMoney(this)"></asp:TextBox>
                        </td>
                    </tr>
                </table>

                <br />
                <br />

            </div>
            <div>
                <hr />
                <br />
                    <p style="padding-top: 7pt; text-align: center;">
                        Contact us:</p>
                    <p style="padding-top: 2pt; text-align: center;">
                        In the Boise area: (208) 334-7660 I Toll free: (800) 972-7660</p>
                    <p style="text-align: center;">
                        Hearing impaired (TDD) (800) 377-3529</p>
                    <p style="text-align: center;">
                        <b><a href="https://tax.idaho.gov/contact" target="_blank">tax.idaho.gov/contact</a></b></p>
                    <br />
                    
            </div><p style="padding-top: 2pt; text-align: left; padding-left: 25px;">
                        EFO00307 09-15-2021
                    </p>
        </div>

        <div id="MainForm" class="form-group" style="margin-right:5%;">
             <div style="text-align:center;">
                <img src="images/header.jpg" style="width:100%; height:auto;"/>
            </div>
         
            <br />

            <div id="MainFormInput">
                <div>
                    <h3>
                        <b>WITHHOLDING STATUS</b> (see instructions)
                    </h3>
                </div>
                <div style="font-size: 20px; display: inline-block;">
                    <label for="SingleCheckbox"><span style="font-weight:bold; font-size:20px;">A</span></label>
                        <asp:CheckBox ID="SingleCheckbox" runat="server" Text="&nbsp;(Single)&nbsp;&nbsp;" TextAlign="Right" onclick="single(this)" />                
                    
                    <label for="MarriedCheckbox"><span style="font-weight:bold;">B</span></label>
                        <asp:CheckBox ID="MarriedCheckbox" runat="server" Text="&nbsp;(Married)&nbsp;&nbsp;" TextAlign="Right" onclick="married(this)" />                
                    
                    <label for="MarriedWithholdCheckbox"><span style="font-weight:bold;">C</span></label>
                        <asp:CheckBox ID="MarriedWithholdCheckbox" runat="server" Text="&nbsp;(Married, but withhold at Single rate)&nbsp;&nbsp;" TextAlign="Right" onclick="marriedwithholdhigher(this)" />                
                    
                </div>

                <br />
                <br />

                <table id="MainFormQ1andQ2" style="width: 80%; text-align:left;">
                    <tr>
                        <td style="width:5%"></td>
                        <td style="width:80%"></td>
                        <td style="width:1%"></td>
                        <td style="width:14%"></td>
                    </tr>
                    <tr>
                        <td colspan="1" class="aligntopright">
                            1.&nbsp;&nbsp;
                        </td>
                        <td colspan="2" class="aligntopleft">
                            Total number of Idaho allowances you&#39;re claiming
                        </td>
                        <td colspan="1" class="aligntextfieldbottomcenter">
                            <asp:TextBox ID="TotalExemptions" runat="server" CssClass="center" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" />
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td colspan="1" class="aligntopright">
                            2.&nbsp;&nbsp;
                        </td>
                        <td colspan="1" class="aligntopleft">
                            Additional amount (if any) you need withheld from each paycheck (Enter whole dollars)
                        </td>
                        <td colspan="1" class="alignbottomright">
                            $
                        </td>
                        <td colspan="1" class="aligntextfieldbottomright">
                            <asp:TextBox ID="AdditionalWithholding" runat="server" CssClass="right" BackColor="#EFF3FB" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"/>
                        </td>
                    </tr>
                </table>

                <br />
            </div>
           
            <div id="MainFormLabels">
                    <table style="width:100%; border-collapse: collapse;">
                        <tbody style="padding: 2px; margin-bottom: 0; padding: 0;">
                            <tr>
                                <td style="width: 20%;"></td>
                                <td style="width: 30%;"></td>
                                <td style="width: 10%;"></td>
                                <td style="width: 30%;"></td>
                                <td style="width: 10%;"></td>
                            </tr>
                            <tr>
                                <td colspan="3">&nbsp;</td>
                                <td colspan="2" style="border-top: 1.5px solid black; border-right: 1.5px solid black; border-left: 1.5px solid black;">
                                    Your Social Security number (required)
                                    <br />
                                    <b><asp:Label ID="SSNumber" runat="server" CssClass="HRETan center" Width="100%"/>
                                    </b>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="border-top: 1.5px solid black; border-left: 1.5px solid black;">
                                    Your first name and initial
                                    <br />
                                    <b><asp:Label ID="FirstName" runat="server" CssClass="HRETan left" Width="100%"/>
                                    </b>
                                </td>
                                <td colspan="3" style="border-top: 1.5px solid black; border-right: 1.5px solid black; border-left: 1.5px solid black;">
                                    Last name
                                    <br />
                                    <b><asp:Label ID="LastName" runat="server" CssClass="HRETan left" Width="100%" />
                                    </b>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5" style="border-top: 1.5px solid black; border-right: 1.5px solid black; border-left: 1.5px solid black;">
                                    Current mailing address
                                    <br />
                                    <b> <asp:Label ID="AddressCombined" runat="server" CssClass="HRETan left" Width="100%" />
                                    </b>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="border-top: 1.5px solid black; border-left: 1.5px solid black; border-bottom: 1.5px solid black;">
                                    City
                                    <br />
                                    <b><asp:Label ID="City" runat="server" CssClass="HRETan left" Width="100%" />
                                    </b>
                                </td>
                                <td colspan="1" style="border-top: 1.5px solid black; border-left: 1.5px solid black; border-bottom: 1.5px solid black;">
                                    State
                                    <br />
                                    <b><asp:Label ID="State" runat="server" CssClass="HRETan center" Width="100%" />
                                    </b>
                                </td>
                                <td colspan="2" style="border-top: 1.5px solid black; border-right: 1.5px solid black; border-left: 1.5px solid black; border-bottom: 1.5px solid black;">
                                    Zip
                                    <br />
                                    <b><asp:Label ID="ZipCode" runat="server" CssClass="HRETan center" Width="100%" />
                                    </b>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            
             <br />
            
             <div style="width: 93%; padding-bottom: 5px;">
                <p style="font-size: 17px; text-align: left;">
                    Under penalties of perjury, I declare that to the best of my knowledge and belief I can 
                    claim the number of withholding allowances on line 1 above.
                </p>
            </div>

            <table style="width: 100%; border-collapse: collapse;">
                <tbody>
                    <tr>
                        <td style="width: 65%; border: 1.5px solid black;">
                            Your signature
                            <br />
                            <asp:TextBox ID="Signature" runat="server" Width="100%"></asp:TextBox>
                        </td>
                        <td style="width: 35%; border: 1.5px solid black; min-width:100px;">
                            Date
                            <br />
                            <asp:TextBox ID="SignatureDate" runat="server" Cssclass="center" Width="100%"></asp:TextBox>
                        </td>
                    </tr>

                </tbody>
            </table>
            <p style="padding-top: 10pt; text-align: left;">
                EFO00307 09-15-2021
            </p>
            <div id="divFormFooter" class="row">
                <br />
                <div style="float: right;">
                    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valw4" OnClick="btnSave_Click" />
                </div>
                
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
        input[type=text], textarea {outline: none; min-height: 25px; min-width: 30px; background-color: #f0f4fa; border-top:none; border-right:none; border-left:none; border-bottom:1px solid black; vertical-align:bottom;}
        input[type="checkbox"] {width: 20px; height: 20px; cursor: pointer; background: #f0f4fa; background-color: #f0f4fa; display:inline; vertical-align:top;}
        table {background-color:white; min-height: 25px; color:black; border:none; border-collapse:separate; border-spacing: 0px 0px; font-size:inherit;}
        table tr td {vertical-align:bottom;}
        p {color:black; vertical-align:top;}
        div ul li {color:black;}
        div ol li {color:black;}
        div {color:black; }
        .underline {border-bottom: 1px solid !important; width: 100%; display: inline-block;  vertical-align:bottom;}
        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; padding-top:5px; padding-left:5px; padding-right:5px; height:30px; } 
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
        .aligntopleft {vertical-align:top;}
        .aligntopright {vertical-align:top; text-align:right; padding:2px;}
        .alignbottomright {vertical-align:bottom; text-align:right; padding:2px;}
        .aligntextfieldbottomcenter {vertical-align:bottom; text-align:center;min-width:30px; max-width:100px; padding-right:3%; margin-bottom:10px;}
        .aligntextfieldbottomright {vertical-align:bottom; text-align:right;min-width:30px; max-width:100px; padding-right:3%; margin-bottom:10px;}

    </style>
</asp:Content>
