<%@ Page Title="AR State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false"  
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_AR.aspx.vb" 
    Inherits="HReaseApp.EE_W4_AR"   
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>   
    </div>     
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainArticle" Runat="Server">
    <script type="text/javascript">
        function ckyes(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkNo]').prop("checked", false);
            }
        }
        function ckno(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkYes]').prop("checked", false);
            }
        }
        function claimyourself(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chk1b]').prop("checked", false);
                $('input:checkbox[id$=chk1c]').prop("checked", false);
                $('input:text[id$=txtchk1a]').val(1);
                $('input:text[id$=txtchk1b]').val(0);
                $('input:text[id$=txtchk1c]').val(0);

                if ($('input:text[id$=txtNoOfChildren]').val() == '') { var a = '0' };
                { var a = $('input:text[id$=txtNoOfChildren]').val() };

                var sum = (parseFloat(a) + 1);
                $('input:text[id$=txtTotalExemptions]').val(sum);
                $('input:text[id$=txtchk1a]').val("1")

            }
        }
        function claimyourselfandspouse(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chk1a]').prop("checked", false);
                $('input:checkbox[id$=chk1c]').prop("checked", false);
                $('input:text[id$=txtchk1a]').val(0);
                $('input:text[id$=txtchk1b]').val(2);
                $('input:text[id$=txtchk1c]').val(0);

                if ($('input:text[id$=txtNoOfChildren]').val() == '') { var a = '0' };
                { var a = $('input:text[id$=txtNoOfChildren]').val() };

                var sum = (parseFloat(a) + 2);
                $('input:text[id$=txtTotalExemptions]').val(sum);
            }
        }
        function claimhoh(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chk1a]').prop("checked", false);
                $('input:checkbox[id$=chk1b]').prop("checked", false);
                $('input:text[id$=txtchk1a]').val(0);
                $('input:text[id$=txtchk1b]').val(0);
                $('input:text[id$=txtchk1c]').val(2);

                if ($('input:text[id$=txtNoOfChildren]').val() == '') { var a = '0' };
                { var a = $('input:text[id$=txtNoOfChildren]').val() };

                var sum = (parseFloat(a) + 2);
                $('input:text[id$=txtTotalExemptions]').val(sum);
            }
        }
       
        function single(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkMarriedFilingJoint]').prop("checked", false);
                $('input:checkbox[id$=chkHeadOfHousehold]').prop("checked", false);
            }
        }
        function married(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingle]').prop("checked", false);
                $('input:checkbox[id$=chkHeadOfHousehold]').prop("checked", false);
            }
        }
        function hoh(checkbox) {
            if (checkbox.checked) {
                $('input:checkbox[id$=chkSingle]').prop("checked", false);
                $('input:checkbox[id$=chkMarriedFilingJoint]').prop("checked", false);
            }
        }
        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
        $(function () {
            var aSingle = $('input:text[id$=txtchk1a]').keyup(foo);
            var bMarried = $('input:text[id$=txtchk1b]').keyup(foo);
            var cHoH = $('input:text[id$=txtchk1c]').keyup(foo);
            var DepCt = $('input:text[id$=txtNoOfChildren]').keyup(foo);

            $('input:text[id$=hdnPW]').val(document.getElementById('divPWPrint').childNodes[1].innerHTML);

            function foo() {
                var a = aSingle.val();
                var b = bMarried.val();
                var c = cHoH.val();
                var d = DepCt.val();
                var sum = add(a, b, c, d);
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
        function disableinput() {
            return false;
        }
       
    </script>
    
    <div class="HREwrapper">
        <div id="PageTitle">
            <div>
                <br />
                <h4><b>Arkansas Form AR4EC</b></h4>
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
            <div class="col-md-6">
                <p style="margin-bottom: 20px;">
                    <b>TYPES OF INCOME</b>- This form can be used for withholding on all types
				    of income, including pensions and annuities.
                </p>

                <p style="margin-bottom: 20px;">
                    <b>NUMBER OF EXEMPTIONS</b>– (Husband and/or Wife) Do not claim more
					than the correct number of exemptions. However, if you expect to owe more
					income tax for the year, you may increase your withholding by claiming a
					smaller number of exemptions and/or dependents, or you may enter into an
					agreement with your employer to have additional amounts withheld. This is
					especially important if you have more than one employer, or if both husband
				    and wife are employed.
                </p>


                <p style="margin-bottom: 20px;">
                    <b>DEPENDENTS</b>– To qualify as your dependent (line 2 of form), a person
					must (a) receive more than 1/2 of their support from you for the year, (b)
					not be claimed as a dependent by such person’s spouse, (c) be a citizen
					or resident of the United States, and (d) have your home as their principal
					residence and be a member of your household for the entire year or be
					related to you as follows: son, daughter, grandchild, stepson, stepdaughter,
					son-in-law or daughter-in-law; your father, mother, grandparent, stepfather,
					stepmother, father-in-law or mother-in-law; your brother, sister, stepbrother,
					stepsister, half brother, half sister, brother-in-law or sister-in-law; your uncle,
				    aunt, nephew or niece (but only if related by blood).
                </p>


                <p style="margin-bottom: 20px;">
                    <b>CHANGES IN EXEMPTIONS OR DEPENDENTS</b>– You may file
					a new certificate at any time if the number of exemptions or dependents
					INCREASES. You must file a new certificate within 10 days if the number
					of exemptions or dependents previously claimed by you DECREASES for
				    any of the following reasons:
                </p>
                <p><small>AR4EC (R 11/17/2021)</small></p>
            </div>
            <div class="col-md-6">
                <p style="margin-bottom: 20px;">
                    <span style="padding-left: 30px;">(a)&nbsp; Your spouse for whom you have been claiming an
						exemption is divorced or legally separated from you, or claims
						his or her own exemption on a separate certificate, <b>or</b>
                    </span>
                    <br/>

                    <span style="padding-left: 30px;">(b)&nbsp; The support you provide to a dependent for whom you claimed
						an exemption is expected to be less than half of the total support for the year.
						OTHER DECREASES in exemptions or dependents, such as the death of a
						spouse or a dependent, does not affect your withholding until next year, but
						requires the filing of a new certificate by December 1 of the year in which
						they occur.
                    </span>
                </p>

                <p>
                    You may claim additional amounts of withholding tax if desired. This will
				apply most often when you have income other than wages.
                </p>
                <p>
                    You qualify for the low income tax rates if your <b>total</b> income from all
				sources is:
                </p>

                <div style="">
                    <span style="width: 50%;">(a) &nbsp; Single </span>
                    <span style="text-align: right; width: 50%; float: right;">$13,055 &nbsp; &nbsp; to&nbsp; &nbsp;  $15,700</span>
                </div>
                <div style="">
                    <span style="width: 50%;">(b) &nbsp; Married Filing Jointly  </span>
                    <span style="text-align: right; width: 50%; float: right;">$22,016 &nbsp; &nbsp; to&nbsp; &nbsp;  $26,100</span><br/>
                    <span style="padding-left: 30px;">(1 or less dependents)</span>
                </div>

                <div style="">
                    <span style="width:50%;">(c)&nbsp;  Married Filing Jointly</span>
                    <span style="text-align: right; width: 50%; float: right;">$26,497&nbsp; &nbsp;  to &nbsp; &nbsp; $32,200</span><br/>
                    <span style="padding-left: 30px;">(2 or more dependents)</span>
                </div>
                <div style="">
                    <span style="width:50%;">(d) &nbsp; Head of Household/Qualifying Widow(er) </span>
                    <span style="text-align: right; width: 50%; float: right;">$18,561 &nbsp; &nbsp; to &nbsp; &nbsp; $22,600</span><br/>
                    <span style="padding-left: 30px;">(1 or less dependents)</span>

                </div>

                <div style="">
                    <span style="width:50%;">(e) &nbsp; Head of Household/Qualifying Widow(er) </span>
                    <span style="text-align: right; width: 50%; float: right;">$22,126&nbsp; &nbsp;  to&nbsp; &nbsp;  $26,000 
                    </span>
                    <br/>
                    <span style="padding-left: 30px;">(2 or more dependents) </span>

                </div>

                <div style="margin-top:20px; text-align: center;">
                    <span style="font-size: 16px; font-weight: 900;">For additional information consult your employer or write to:</span><br/>
                    <span style="">Arkansas Withholding Tax Section</span><br/>
                    <span>P. O. Box 8055</span><br/>
                    <span>Little Rock, Arkansas 72203-8055</span>
                </div>
            </div>
        </div>

        <div id="MainForm" style="margin-right:5%;">
            <div id="MainFormHeader" style="margin-bottom:10px;">
                <table style="width:100%; color:black; border:none;">
                    <tr>
                        <td style="width: 15%;"></td>
                        <td style="width: 70%;"></td>
                        <td style="width: 15%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1" style="font-size: 22px; line-height: 2px; font-weight: bold;">
                            <h2><b>AR4EC</b></h2>
                            &nbsp;
                        </td>
                        <td colspan="1" style="text-align: center;">
                            <h2><span class="header" style="vertical-align:bottom; text-align: center; font-size: 16px; line-height: 2px; font-weight: bold;">
                                 <b>STATE OF ARKANSAS</b>
                                </span>

                            </h2>
                            <h2><span class="header2" style="vertical-align:top; font-size: 23px; line-height: 2px; font-weight: bold;">
                                 <b>Employee’s Withholding Exemption Certificate</b>
                                 </span>
                            </h2>
                        </td>
                        <td colspan="1" style="text-align: center;">
                            <img src="img/AR_Employees_Withholding_Exemption_Certificate_AR4EC.jpg" style="Width: 60%"/>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="MainFormNameAddressSSN">
                <table style="width:100%; color:black; border:none;">
                    <tr>
                        <td style="width: 15%;"></td>
                        <td style="width: 35%;"></td>
                        <td style="width: 5%;"></td>
                        <td style="width: 20%;"></td>
                        <td style="width: 5%;"></td>
                        <td style="width: 5%;"></td>
                        <td style="width: 5%;"></td>
                        <td style="width: 5%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            &nbsp;&nbsp;Print Full Name &nbsp;
                        </td>
                        <td colspan="1" class="HRETan" style="border-bottom:1px solid black;">
                            <b><asp:Label ID="lblFullName" runat="server"></asp:Label> </b>
                        </td>
                        <td colspan="2">
                            &nbsp;&nbsp;Social Security Number &nbsp;
                        </td>
                        <td colspan="4" class="HRETan" style="border-bottom:1px solid black;">
                            <b><asp:Label ID="lblSSNumber" runat="server"></asp:Label> </b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            &nbsp;&nbsp;Print Home Address&nbsp;
                        </td>
                        <td colspan="1" class="HRETan" style="border-bottom:1px solid black;">
                            <b><asp:Label ID="lblHomeAddress" runat="server"></asp:Label> </b>
                        </td>
                        <td colspan="1">
                            &nbsp;&nbsp;City&nbsp;
                        </td>
                        <td colspan="1" class="HRETan" style="border-bottom:1px solid black;">
                            <b><asp:Label ID="lblCity" runat="server"></asp:Label> </b>
                        </td>
                        <td colspan="1">
                            &nbsp;&nbsp;State&nbsp;
                        </td>
                        <td colspan="1" class="HRETan" style="border-bottom:1px solid black;">
                            <b><asp:Label ID="lblState" runat="server"></asp:Label> </b>
                        </td>
                        <td colspan="1">
                            &nbsp;&nbsp;Zip&nbsp;
                        </td>
                        <td colspan="1" class="HRETan" style="border-bottom:1px solid black;">
                            <b><asp:Label ID="lblZipCode" runat="server"></asp:Label> </b>
                        </td>
                    </tr>
                </table>          
            </div>
            <div id="MainWithholdingForm">
                <table style="width: 100%; border: 2px solid; margin-top: 20px; background-color:white;">
                    <tr>
                        <td style="width: 15%;"></td>
                        <td style="width: 3%;"></td>
                        <td style="width: 2%;"></td>
                        <td style="width: 63%;"></td>
                        <td style="width: 2%;"></td>
                        <td style="width: 15%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1" rowspan="10" style="border-right: 2px solid; vertical-align: top;">
                            <p style="line-height: 30px; padding: 10px;">
                                <b>Employee:</b> 
                                <br />
                                File this form with your employer. Otherwise, your employer must withhold state income tax 
                                from your wages without exemptions or dependents.
                            </p>

                            <p style="line-height: 30px; padding: 10px;">
                                <b>Employer:</b> 
                                <br />
                                Keep this certificate with your records.</p>

                        </td>                       
                        <td colspan="4" style="border-right: 2px solid; text-align: center; padding-top:10px;">
                            <span style="font-size: 24px; font-weight: 800;">
                                How to Claim Your Withholding</span>
                                <div style="margin-bottom: 20px; font-size: 20px">
                                    <i>See instructions below</i>
                                </div>
                        </td>
                        <td colspan="1" style="text-align: center;">
                            Number of Exemptions Claimed
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            1. &nbsp;
                        </td>
                        <td colspan="3" style="border-right: 2px solid;">
                            CHECK ONE OF THE FOLLOWING FOR EXEMPTIONS CLAIMED
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1">
                            a.
                        </td>
                        <td colspan="1">
                            <asp:CheckBox ID="chk1a" runat="server" onclick="claimyourself(this)" />
                                &nbsp; You claim yourself. <i>(Enter one exemption)</i>
                        </td>
                        <td colspan="1" style="border-right: 2px solid;">
                            &nbsp;1a.&nbsp; 
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtchk1a" runat="server" Enabled="false"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1">
                            b.
                        </td>
                        <td colspan="1">
                            <asp:CheckBox ID="chk1b" runat="server" onclick="claimyourselfandspouse(this)" />
                                &nbsp; You claim yourself and your spouse. <i>(Enter two exemptions)</i>
                        </td>
                        <td colspan="1" style="border-right: 2px solid;">
                            &nbsp;1b.&nbsp; 
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtchk1b" runat="server" Enabled="false"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1">
                            c.
                        </td>
                        <td colspan="1">
                            <asp:CheckBox ID="chk1c" runat="server" onclick="claimhoh(this)" />
                                &nbsp; Head of Household, and you claim yourself. <i>(Enter two exemptions)</i>
                        </td>
                        <td colspan="1" style="border-right: 2px solid;">
                            &nbsp;1c.&nbsp; 
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtchk1c" runat="server" Enabled="false"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            2. &nbsp;
                        </td>
                        <td colspan="2">
                            NUMBER OF CHILDREN or DEPENDENTS. <i>(Enter one exemption per dependent)</i>
                        </td>
                        <td colspan="1" style="border-right: 2px solid;">
                            &nbsp;2.&nbsp; 
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtNoOfChildren" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            3. &nbsp;
                        </td>
                        <td colspan="2">
                            TOTAL EXEMPTIONS. (Add Lines 1a, b, c, and 2)
                            <br />
                            If no exemptions or dependents are claimed, enter zero.
                        </td>
                        <td colspan="1" style="border-right: 2px solid; vertical-align:bottom;">
                            &nbsp;3.&nbsp; 
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:1px solid black; vertical-align:bottom;">
                            <asp:TextBox ID="txtTotalExemptions" runat="server" onkeypress="return onlyNumbers();"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            4. &nbsp;
                        </td>
                        <td colspan="2">
                            Additional amount, if any, you want deducted from each paycheck. <i>(Enter one exemption per dependent)</i>
                        </td>
                        <td colspan="1" style="border-right: 2px solid;">
                            &nbsp;4.&nbsp; 
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtAdditionalWithholding" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            5. &nbsp;
                        </td>
                        <td colspan="2">
                            I qualify for the low-income tax rates. <i>(See below for details)</i>
                            <br />
                            Please check filing status: 
                            <asp:CheckBox ID="chkSingle" runat="server" Text="&nbsp;  Single" onclick="single(this)"/>&nbsp;&nbsp;&nbsp;
                            <asp:CheckBox ID="chkMarriedFilingJoint" runat="server" Text="&nbsp; Married Filing Jointly " onclick="married(this)" />&nbsp; 
                            <asp:CheckBox ID="chkHeadOfHousehold" runat="server" Text="&nbsp;  Head of Household" onclick="hoh(this)"/>
                        </td>
                        <td colspan="1" style="border-right: 2px solid; vertical-align:bottom;">
                            &nbsp;5.&nbsp; 
                        </td>
                        <td colspan="1" style="text-align:center; border-bottom:1px solid black; vertical-align:bottom; padding-bottom:10px;">
                            <asp:CheckBox ID="chkYes" runat="server" Text="&nbsp;Yes" onclick="ckyes(this)"/>
                            <asp:CheckBox ID="chkNo" runat="server" Text="&nbsp;No" onclick="ckno(this)"/>
                        </td>
                    </tr>
            </table>
        </div>
            <div id="divSignatureAndDate">
                <table style="width: 100%; background-color:white; border:none;">
                    <tr style="width: 100%; height: 50px;">
                        <td colspan="5" style="width: 100%">
                            <p>
                                I certify that the number of exemptions and dependents claimed on this certificate does not exceed the number to which I am entitled.
                            </p>
                        </td>
                    </tr>

                    <tr style="width: 100%;">
                        <td style="width: 70%; padding-left: 10px;">
                            &nbsp; Signature: &nbsp; 
                            <span class="underline" style="width: 70%;">
                                &nbsp;<asp:TextBox runat="server" ID="txtSignature" placeholder="Type name to represent Signature" Style="width: 100%;" />
                            </span>
                        </td>
                        <td style="width: 30%;">
                            &nbsp; Date &nbsp; 
                            <span class="underline" style="width: 70%;">
                                &nbsp;<asp:TextBox runat="server" ID="SignatureDate" Style="border-bottom: 1px solid; width: 100%;" />
                            </span>
                        </td>
                    </tr>
                </table>
            </div>
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
        input[type=text], textarea {outline: none; min-height: 20px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; text-align:center;}
        input[type="checkbox"] {width: 20px; height: 20px; cursor: pointer; background: #f0f4fa; display: inline-block; padding-left:3px; padding-right: 3px; color: black;}
        input[type="label"] {background-color: #f5f5f0;}
        table {background-color:white; color:black; border:2px solid black; border-collapse:collapse; border-spacing: 0px;}
        p {color:black;}
        li {color:black;}
        div {color:black; }
        
        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; padding-left:5px;}
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .underline {border-bottom: 1px solid !important; width: 100%; display: inline-block; }
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
    </style>

</asp:Content>
