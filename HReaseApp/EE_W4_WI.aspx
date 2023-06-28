<%@ Page Title="WI State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_WI.aspx.vb" 
    Inherits="HReaseApp.EE_W4_WI" 
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

    <script>
	//
        // This function will allow users to insert only numbers in the textboxes.
        //

        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

        //
        // This function is to calculate all the values of textboxes.
        //

        $(function () {
            var textBox1 = $('input:text[id$=txtLine1A]').keyup(foo);
            var textBox2 = $('input:text[id$=txtLine1B]').keyup(foo);
            var textBox3 = $('input:text[id$=txtLine1C]').keyup(foo);
              
            $('input:text[id$=hdnPW]').val(document.getElementById('divPW').childNodes[1].innerHTML);

            function foo() {
                var a = textBox1.val();
                var b = textBox2.val();
                var c = textBox3.val();
                
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
                <h4><b>Wisconsin Form WT-4</b></h4>
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

        <div id="divInstructionTitle" class="well HRESlateBlue HRERewrap" >
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px;" />

        </div>

        <div id="divInstructions" class="HRETan instruction_toggle" style="margin-right:5%;">
            <div style="font-size: x-large; padding-top:10px; padding-bottom:10px;">
                <b>EMPLOYEE INSTRUCTIONS:</b>
            </div>
            <div class="form-group HREWhite" >
                <div class="col-md-6" style="color:black;">
					    <p>
						    <b>• WHO MUST FILE: </b>
						    <br/>
						    Effective on or after January 1, 2020, every newly-hired employee is
                            required to provide a completed Form WT-4 to each of his or her employ‑
                            ers. Form WT-4 will be used by your employer to determine the amount
                            of Wisconsin income tax to be withheld from your paychecks. If you
                            have more than one employer, you should claim a smaller number or no
                            exemptions on each Form WT-4 provided to employers other than your
                            principal employer so that the total amount withheld will be closer to your
                            actual income tax liability
					    </p>
                        <p>
                            You must complete and provide your employer a new Form WT-4 within
                            10 days if the number of exemptions previously claimed DECREASES.
                        </p>
                        <p>
                            You may complete and provide to your employer a new form WT-4 at any
                            time if the number of your exemptions INCREASES.
                        </p>
                        <p>
                            Your employer may also require you to complete this form to report your
                            hiring to the Department of Workforce Development.
                        </p>
					    <p>
						    <b>• UNDER WITHHOLDING:</b><br/>
						    If sufficient tax is not withheld from your wages, you may incur additional
                            interest charges under the tax laws. In general, 90% of the net tax shown
                            on your income tax return should be withheld.
					    </p>
					    <p>
						    <b>• OVER WITHHOLDING:</b><br/>
						    If you are using Form WT-4 to claim the maximum number of exemptions
                            to which you are entitled and your withholding exceeds your expected
                            income tax liability, you may use Form WT-4A to minimize the over
                            withholding.
					    </p>
                        <p><b>WT-4 Instructions –</b>  Provide your information in the employee section</p>
				    <p>
					    <b>• LINE 1:</b><br/>
					    (a)-(c) Number of exemptions – Do not claim more than the correct number
					    of exemptions. If you expect to owe more income tax for the year than will
                    </p>
				    </div>

			    <div class="col-md-6">
                    <br />
				    <p>
					    be withheld if you claim every exemption to which you are entitled, you may
                        increase your withholding by claiming a smaller number of exemptions on
                        lines 1(a)‑(c) or you may enter into an agreement with your employer to have
                        additional amounts withheld (see instruction for line 2).
				    </p>
                    <p>
                        (c) Dependents – Those persons who qualify as your dependents for federal
                        income tax purposes may also be claimed as dependents for Wisconsin
                        purposes. The term “dependents” does not include you or your spouse.
                        Indicate the number of dependents that you are claiming in the space provided.
                    </p>
				    <p>
					    <b>• LINE 2:</b><br/>
					    Additional withholding – If you have claimed “zero” exemptions on line 1, but
                        still expect to have a balance due on your tax return for the year, you may
                        wish to request your employer to withhold an additional amount of tax for each
                        pay period. If your employer agrees to this additional withholding, enter the
                        additional amount you want deducted from each of your paychecks on line 2.
				    </p>
				    <p>
					    <b>• LINE 3:</b><br/>
					    Exemption from withholding – You may claim exemption from withholding of
                        Wisconsin income tax if you had no liability for income tax for last year, and
                        you expect to incur no liability for income tax for this year. You may not claim
                        exemption if your return shows tax liability before the allowance of any credit
                        for income tax withheld. If you are exempt, your employer will not withhold
                        Wisconsin income tax from your wages.
				    </p>
				    <p>
                        You must revoke this exemption (1) within 10 days from the time you expect
                        to incur income tax liability for the year or (2) on or before December 1 if you
                        expect to incur Wisconsin income tax liabilities for the next year. If you want to
                        stop or are required to revoke this exemption, you must complete and provide
                        a new Form WT‑4 to your employer showing the number of withholding exemp‑
                        tions you are entitled to claim. This certificate for exemption from withholding
                        will expire on April 30 of next year unless a new Form WT‑4 is completed and
                        provided to your employer before that date.
				    </p>
			    </div>
                <br />
                <br />
		    </div>
        </div>
     
        <div id="divWIFormHeader" style="margin-right:5%; background-color:white;">
		    <table style="width:100%; background-color:white; ">
			       <tr style="width: 100%;">
					    <td style="width: 100%;">
						    <h5 style="font-weight: 900; font-size:20px; float:right; padding-right: 1%;">
                                WT&#8209;4
						    </h5>
					    </td>
				    </tr>
				    <tr style="width: 100%;">
					    <td style="width: 100%;">
						    <h3 style="text-align: center; font-weight: 900;">
                                Employee’s Wisconsin Withholding Exemption Certificate/New Hire Reporting
						    </h3>
					    </td>
				    </tr>                    
		    </table>
        </div>

        <div id="divWIFormDemo" style="margin-right:5%;">
          <table style="width:100%; background-color:white; ">
			    <tbody>
                    <tr>
                        <td style="width:30%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:20%;"></td>
                        <td style="width: 5%;"></td>
                        <td style="width:25%;"></td>
                    </tr>
                    <tr>
                        <td style="font-size:24px;" >
			                <b>Employee’s Section</b> (Print clearly)
                            <br />
                        </td>
		            </tr>
				    <tr>
                        <td colspan="3" style="border-left:1px solid black; border-top:1px solid black;">
                            <small>Employee’s legal name (first name, middle initial, last name)</small>
                            <br />
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblFullName" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
					   <td colspan="1" style="border-left:1px solid black; border-top:1px solid black;">
                            <small>Social security number</small>
                            <br />
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblSSN" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
                        <td colspan="2" rowspan="3" style="vertical-align:top; padding:1%; border:1px solid black;">
                            <asp:CheckBox ID="chkSingle" runat="server" Text="&nbsp;Single"  AutoPostBack="true" OnCheckedChanged="chkSingle_CheckedChanged" />
                            <br />
					        <asp:CheckBox ID="chkMarried" runat="server" Text="&nbsp;Married" AutoPostBack="true" OnCheckedChanged="chkMarried_CheckedChanged" />
			                <br />
                            <asp:CheckBox ID="chkMarriedWithhold" runat="server" Text="&nbsp;Married, but withhold at higher Single rate." AutoPostBack="true" OnCheckedChanged="chkMarriedwithhold_CheckedChanged" />
                            <br />
                            <div>
                                <span style="margin-left:30px; position:absolute;"><b>Note:</b> if married, but legally separated, check the Single box.
                                </span>
                            </div>
                        </td>
                   </tr>
                    <tr>
                        <td colspan="3" style="border-left:1px solid black; border-top:1px solid black;">
                            <small>Employee’s address (number and street)</small>
                            <br />
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblAddressCombined" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
					   <td colspan="1"  style="border-left:1px solid black; border-top:1px solid black;">
                            <small>Date of birth</small>
                            <br />
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblDOB" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
                        <td colspan="2">
                        </td>
                    </tr>
					  <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-bottom:1px solid black;">
                            <small>City</small>
                            <br />
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblCity" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
					   <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-bottom:1px solid black;">
                            <small>State</small>
                            <br />
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblState" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
                        <td colspan="1"style="border-left:1px solid black; border-top:1px solid black; border-bottom:1px solid black;">
                            <small>Zip code</small>
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblZipCode" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-bottom:1px solid black;">
                            <small>Date of hire </small>
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblDateOfHire" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
                        <td colspan="2">
                        </td>
                    </tr>   
                </tbody>
            </table>
        </div>

        <div id="divWIMainForm" style="margin-right:5%; background-color:white; ">
            <div id="divPW">
                <table style="font-size:large; color:black; background-color:white;">
                    <tr>
                        <td style="width: 3%;"></td>
                        <td style="width: 5%;"></td>
                        <td style="width: 62%;"></td>
                        <td style="width: 20%;"></td>
                        <td style="width: 10%;"></td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <br />
	                        <h4><b>FIGURE YOUR TOTAL WITHHOLDING EXEMPTIONS BELOW</b></h4>
                            <br />
                        </td>
                    </tr> 
                    <tr>
                        <td colspan="5">
                            Complete Lines 1 through 3
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            1.
                        </td>
                        <td colspan="1">
                            (a)
                        </td>
                        <td colspan="1">
                            Exemption for yourself – enter 1
                        </td>
                        <td colspan="1" class="underline" style="text-align:center;">
                            <asp:TextBox ID="txtLine1A" runat="server" Width="30%" CssClass="center" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>                        
                        <td colspan="1">                
                            &nbsp;
                        </td>
                        <td colspan="1">
                            (b)
                        </td>
                        <td colspan="1">
                            Exemption for your spouse – enter 1
                        </td>
                        <td colspan="1" class="underline" style="text-align:center;">
                            <asp:TextBox ID="txtLine1B" runat="server" Width="30%" CssClass="center" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>                        
                        <td colspan="1">                
                            &nbsp;
                        </td>
                        <td colspan="1">
                            (c)
                        </td>
                        <td colspan="1">
                            Exemption(s) for dependent(s) – you are entitled to claim an exemption for each dependent
                        </td>
                        <td colspan="1" class="underline" style="text-align:center;">
                            <asp:TextBox ID="txtLine1C" runat="server" Width="30%" CssClass="center" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>                        
                        <td colspan="1">                
                            &nbsp;
                        </td>
                        <td colspan="1">
                            (d)
                        </td>
                        <td colspan="1">
                            Total – add lines (a) through (c)
                        </td>
                        <td colspan="1">
                            <asp:TextBox ID="txtTotalExemptions" runat="server" Width="100%" CssClass="nofill" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>                        
                        <td colspan="1">                
                            2.
                        </td>
                        <td colspan="2">
                            Additional amount per pay period you want deducted (if your employer agrees)
                        </td>
                   
                        <td colspan="1" class="underline" style="text-align:center;">
                            <asp:TextBox ID="txtAdditionalWithholding" runat="server" Width="30%" CssClass="center" onkeypress="return onlyNumbers();"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>                        
                        <td colspan="1">                
                            3.
                        </td>
                        <td colspan="2">
                            I claim complete exemption from withholding (see instructions). Enter “Exempt”
                        </td>
                   
                        <td colspan="1" class="underline" style="text-align:center;">
                            <asp:TextBox ID="txtExempt" runat="server" Width="90%" CssClass="center" AutoPostBack="true" OnTextChanged="txtExempt_TextChanged"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
               
        <div id="divSignatureBlock" style="font-size:medium; margin-top:10px; margin-bottom:10px; color:black; margin-right:5%;">
            I CERTIFY that the number of withholding exemptions claimed on this certificate does not exceed the number to which I am entitled. If claiming complete exemption from
	        withholding, I certify that I incurred no liability for Wisconsin income tax for last year and that I anticipate that I will incur no liability for Wisconsin income tax for this year.
            <br />
            Signature &nbsp;
            <asp:TextBox ID="txtSignature" Class="underline" runat="server" Style="width: 45%;"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp; Date Signed &nbsp;
            <asp:TextBox ID="SignatureDate" Class="underline" runat="server" Style="width: 35%;"></asp:TextBox>
        </div>
     
        <div id="divSave" style="margin-right:5%;">
            <div class="clearfix">&nbsp;</div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" OnClick="btnSave_Click" />
            </div>
            <div class="clearfix">&nbsp;</div>
        </div>

        <div id="divWIERSection" style="margin-right:5%;">
            <table style="width:100%; border-right:1px solid black; background-color:white; ">
			    <tbody>
                    <tr>
                        <td style="width:35%;"></td>
                        <td style="width:15%;"></td>
                        <td style="width:20%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:20%;"></td>
                    </tr>
                    <tr>
                        <td style="font-size:24px;" >
			                <b>Employer’s Section</b> 
                            <br />
                        </td>
		            </tr>
				    <tr>
                        <td colspan="4" style="border-left:1px solid black; border-top:1px solid black;">
                            <small>Employer’s name</small>
                            <br />
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblemployerfullname" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
					    <td colspan="1" style="border-left:1px solid black; border-top:1px solid black;">
                            <small>Federal Employer ID Number</small>
                            <br />
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblEmployerFEIN" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
                        
                    </tr>
                    <tr>
                        <td colspan="2" style="border-left:1px solid black; border-top:1px solid black;">
                            <small>Employer’s payroll address (number and street)</small>
                            <br />
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblemployerfulladdress" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
					    <td colspan="1"  style="border-left:1px solid black; border-top:1px solid black;">
                            <small>City</small>
                            <br />
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblEmployerCity" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
					    <td colspan="1"  style="border-left:1px solid black; border-top:1px solid black;">
                            <small>State</small>
                            <br />
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblEmployerState" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
					    <td colspan="1"  style="border-left:1px solid black; border-top:1px solid black;">
                            <small>Zip code</small>
                            <br />
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblEmployerZipCode" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-bottom:1px solid black;">
                            <small>Completed by</small>
                            <br />
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblEmployerCompletedBy" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
					    <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-bottom:1px solid black;">
                            <small>Title</small>
                            <br />
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblEmployerTitle" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
                        <td colspan="1"style="border-left:1px solid black; border-top:1px solid black; border-bottom:1px solid black;">
                            <small>Phone number</small>
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblEmployerPhoneNo" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
                        <td colspan="2" style="border-left:1px solid black; border-top:1px solid black; border-bottom:1px solid black;">
                            <small>Email </small>
                            <div style="background-color:#EFF3FB;">
                                <br />
                                &nbsp;&nbsp;<b><asp:Label ID="lblEmployerEmailID" runat="server" Style="width: 98%;" /></b>
                            </div>
                        </td>
                    </tr>   
                </tbody>
            </table>
        </div>
	         
        <div id="divERInstructionHeader" class="well HRESlateBlue HRERewrap" style="margin-top:20px;">
	        <span><b>EMPLOYER INSTRUCTIONS </b></span>
	        <img src="img/plus.png" class="instruction_toggle_btn1" style="float: right; width: 30px" />
        </div>

        <div id="divERInstructions" class=" HRETan instruction_toggle1" style="margin-top: 11px; margin-right:5%;">
            <div class="form-group HREWhite" >
                <div class="col-md-6"  style="margin-top: 1.5%;">
			        <strong>EMPLOYER INSTRUCTIONS for Department of Revenue:</strong>
			        <ul>
				        <li>If you do not have a Federal Employer Identification Number (FEIN), contact
				            the Internal Revenue Service to obtain a FEIN.</li>
			            <li>If the Employee has claimed more than 10 exemptions OR has claimed
				            complete exemption from withholding and earns more than $200.00 a week
				            or is believed to have claimed more exemptions than he or she is entitled to,
				            mail a copy of this certificate to: Wisconsin Department of Revenue, Audit
				            Bureau, PO Box 8906, Madison WI 53708 or fax (608) 267‑0834.</li>
			            <li>Keep a copy of this certificate with your records. If you have questions about the
				            Department of Revenue requirements, call (608) 266‑2772 or (608) 266‑2776</li>
			        </ul>
                </div>
			    <div class="col-md-6"  style="margin-top: 1.5%;">
			        <strong>EMPLOYER INSTRUCTIONS for New Hire Reporting:</strong>
			            <ul>
				            <li> This report contains the required information for reporting a New Hire to
				                Wisconsin. If you are reporting new hires electronically, you do not need to
				                forward a copy of this report to the Department of Workforce Development.
				                Visit <a href="http://dwd.wisconsin.gov/uinh">  http://dwd.wisconsin.gov/uinh </a> to report new hires.</li>
			                <li>If you do not report new hires electronically, mail the original form to the Depart‑
				                ment of Workforce Development, New Hire Reporting, PO Box 14431, Madison
				                WI 53708-0431 or fax toll free to 1‑800‑277‑8075.</li>
			                <li>If you have questions about New Hire requirements, call toll free (888) 300‑HIRE
				                (888‑300‑4473). Visit <a href="dwd.wisconsin.gov/uinh"> dwd.wisconsin.gov/uinh </a> for more information.</li>
			            </ul>
                </div>
            </div>
	    </div>

        <div id="divFormFooter" style="margin-right:5%;">
	        <span style="float: left;"><small>W-204 (R. 6-20)</small></span>
	        <span style="float: right;"><small>Wisconsin Department of Revenue</small></span>
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
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; text-align:center; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

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
        .HRELabel {background-color: #f5f5f0; font-size: large; vertical-align:bottom;}
        .underline {border-bottom: 1px solid !important; width: 100%; display: inline-block; }
    </style>
</asp:Content>
