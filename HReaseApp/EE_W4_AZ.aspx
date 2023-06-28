<%@ Page Title="Employee State WH Form AZ" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_AZ.aspx.vb" 
    Inherits="HReaseApp.EE_W4_AZ" 
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
    <div class="HREwrapper">
        <table style="margin-bottom:10px; background-color: white;" >
            <tr>
                <td style="width:100%;"></td>
            </tr>
        </table>
        <div id="PageTitle" class="col-md-12">
            <div style="text-align:center;display:inline;">
                <h4><b>Arizona Form A-4</b></h4>
            </div>
        </div>

         <div id="TopHeader" class="form-group" style="display:inline;">                  
            <div id="divError" runat="server" class="HREError" visible="false">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </div>
            <div class="form-group" style="display:inline;">
                <div id="divSuccess" runat="server" visible ="false" class="HRESuccess">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="60px" ImageAlign="Left" />
                    <asp:Label ID="lblSuccess" runat="server"  Text="Form Complete" Width="200px"></asp:Label>
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="60px" Height="60px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="60px" Height="60px" />
                    <br /><br />
                </div>
            </div>
        </div>   


        <div id="divInstructionTitle" class="well HRESlateBlue HRERewrap" >
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px;" />

        </div>

        <div id="divInstructions" class="HRETan instruction_toggle" style="margin-right:5%;">
            <div style="font-size: x-large; text-align:center;padding-top:10px; padding-bottom:10px; border-bottom:2px solid black;">
                <b>Employee's Intructions</b>
            </div>
           <div class="form-group HREWhite" style="color:black;">
                <div class="col-md-6" style="border-right:1px solid #000;">
					<p>Arizona law requires your employer to withhold Arizona income tax from your wages for work done in Arizona.  The amount withheld is applied to your Arizona income tax due when you file your tax return.  The amount withheld is a percentage of your gross taxable wages from every paycheck.  You may also have your employer withhold an extra amount from each paycheck.  Complete this form to select a percentage and any extra amount to be withheld from each paycheck</p>
					<p><b>What are my “Gross Taxable Wages”? </b></p>
					<p>For withholding purposes, your “gross taxable wages” are the wages that will generally be in box 1 of your federal Form W-2.  It is your gross wages less any pretax deductions, such as your share of health insurance premiums.</p>
					<p><b>New Employees </b></p>
                    <p>Complete this form within the first five days of your employment to select an Arizona withholding percentage.  You may also have your employer withhold an extra amount from each paycheck.  If you do not file this form, the department requires your employer to withhold 2.0% of your gross taxable wages.</p>
                    <p><b>Current Employees </b></p>
                    <p>If you want to change your current amount withheld, you must file this form to change the Arizona withholding percentage or to change the extra amount withheld.</p>
                    <p><b>What Should I do With Form A-4?</b></p>
                    <p>Give your completed Form A-4 to your employer.</p>
				</div>
                <div class="col-md-6">
                    <p><b>Electing a Withholding Percentage of Zero</b></p>
                    <p>You may elect an Arizona withholding percentage of zero
                        if you expect to have no Arizona income tax liability for the
                        current year. Arizona tax liability is gross tax liability less any
                        tax credits, such as the family tax credit, school tax credits, or
                        credits for taxes paid to other states. If you make this election,
                        your employer will not withhold Arizona income tax from your
                        wages for payroll periods beginning after the date you file the
                        form. To keep this election for the next calendar year, you must
                        give your employer an updated Form A-4. If you do not, your
                        employer may withhold Arizona income tax from your wages
                        and salary until you submit an updated Form A-4.</p>
                    <p>Zero withholding does not relieve you from paying Arizona
                        income taxes that might be due at the time you file your Arizona
                        income tax return. If you have an Arizona tax liability when
                        you file your return or if at any time during the current year
                        conditions change so that you expect to have a tax liability, you
                        should promptly file a new Form A-4 and choose a withholding
                        percentage that applies to you.</p>
                    <p><b>Voluntary Withholding Election by Certain Nonresident Employees </b></p>
                    <p>Compensation earned by nonresidents while physically
                        working in Arizona for temporary periods is subject to Arizona
                        income tax. However, under Arizona law, compensation paid
                        to certain nonresident employees is not subject to Arizona
                        income tax withholding. These nonresident employees need
                        to review their situations and determine if they should elect to
                        have Arizona income taxes withheld from their Arizona source
                        compensation. Nonresident employees may request that their
                        employer withhold Arizona income taxes by completing this
                        form to elect Arizona income tax withholding.</p>
					
				</div>
			</div>
		</div>
	
		<div id="divMainFormHeader" style="margin-right:5%;">
            <table style="border-top:2px solid #000;border-bottom:2px solid #000;margin-bottom:50px; background-color: white;font-size:medium;" >
                <tr>
                    <td style="width:5%;"></td>
                    <td style="width:20%;"></td>
                    <td style="width:65%;"></td>
                    <td style="width:10%;"></td>
                </tr>
                <tr>
                    <td colspan="1" rowspan="2">
                    </td>
                    <td colspan="1" rowspan="2" style="background-color:black; color:white; text-align:center;">
                        <span style="font-size: 20px;font-family: monospace;"> Arizona Form </span> 
                        <br />
                        <span style="font-size:40px;font-family: monospace; font-weight:900;"> A-4 </span>
                    </td>
                    <td colspan="1" rowspan="2" style="text-align:center; font-weight: 700; font-family: cursive; font-size:x-large;">
                        Employee’s Arizona Withholding Election
                    </td>
                    <td colspan="1" rowspan="2" style=" font-size:30px; font-weight:bold; vertical-align:middle; background-color:ghostwhite; text-align:center;">
                         <asp:Label ID="lblTaxYear" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
       
        <div id="divMainForm" style="margin-right:5%;">
            <table style="margin-bottom: 20px; background-color: white;">
                    <tr>
                        <td style="width:60%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:30%;"></td>
                    </tr>                    
                    <tr style="border:1px solid #000;color:black;">
                        <td colspan="4" style="border-right:1px solid black; font-size:large; text-align:center; padding:0px 5px;">
                            <b><span style="color:black;">Arizona tax rates have decreased. As a result, we are revising withholding percentages and are
                            requiring taxpayers to complete a new Form A-4 for 2023.</span> </b>
                        </td>
                    </tr>
                    <tr style="border:1px solid #000;">
                        <td colspan="2" style="border-right:1px solid black;">
		                    <p>Type or print your Full Name</p>
				            <span style="padding-left:1%;" >
                                <b><asp:Label ID="lblFullName" runat="server" class="HRELabel" Width="98%"/></b>
                            </span>
                        </td>
			            <td colspan="1" >
				            <p>Your Social Security Number</p>
                            <span style="padding-left:1%;text-align:center;">
				                <b><asp:Label ID="lblSSNumber" runat="server" class="HRELabel" Width="98%"/></b>
                            </span>
			            </td>
                    </tr>
                    <tr style="border:1px solid #000;">
                        <td colspan="3">
                            <p>&nbsp;Home Address – number and street or rural route</p>
                            <span style="padding-left:1%;">
			                    <b><asp:Label ID="lblAddressCombined" runat="server" class="HRELabel" Width="99%"/></b>
                            </span>
                        </td>
		            </tr>
                    <tr style="border:1px solid #000;">
                        <td style="border-right:1px solid black;">
                            <p>&nbsp;City or Town</p>
                            <span style="padding-left:1%;">
				                <b>&nbsp;<asp:Label ID="lblCity" runat="server" class="HRELabel" Width="98%"/></b>
                            </span>
			            </td>
                        <td style="border-right:1px solid black;">
			                <p>State</p>
				            <b style="padding-left:1%;"><asp:Label ID="lblState" runat="server" class="HRELabel" Width="98%" /></b>
			            </td>
                        <td >
			                <p>ZIP Code</p>
				            <b style="padding-left:1%;"><asp:Label ID="lblZipCode" runat="server" class="HRELabel" Width="98%"/></b>
			            </td>
                    </tr>
            </table>

	        <div class="col-md-12" style="width: 100%; font-weight: 200; font-size: 20px; margin-top:15px; margin-left: 10px;margin-right: 10px;">
                <span style="margin-top:10px; margin-bottom:10px;">
		            <b>Choose either box 1 or box 2:</b>
                </span>
		        <div class="col-md-12" style="font-weight: 200; font-size: 20px" >
                    <asp:Checkbox ID="chkPercent" runat="server" autopostback="true" OnCheckedChanged="chkPercent_CheckedChanged" />
                        &nbsp;<b>1</b> &nbsp;Withhold from gross taxable wages at the percentage checked <b>(check only one percentage)</b>:
                </div>
            
		        <div class="col-md-12" style="margin-top:10px; margin-bottom:10px; margin-left:10px;font-size:large;">
                    <div class="col-md-1" style="margin-left:20px;"><asp:RadioButton ID="rbTWPercentage1" GroupName="GTWpercentage" runat="server" />&nbsp; 0.5% &nbsp;</div>
			        <div class="col-md-1" style="margin-left:30px;"><asp:RadioButton ID="rbTWPercentage2" GroupName="GTWpercentage" runat="server" />&nbsp; 1.0% &nbsp;</div>
			        <div class="col-md-1" style="margin-left:20px;"><asp:RadioButton ID="rbTWPercentage3" GroupName="GTWpercentage" runat="server" />&nbsp; 1.5% &nbsp;</div>
			        <div class="col-md-1" style="margin-left:20px;"><asp:RadioButton ID="rbTWPercentage4" GroupName="GTWpercentage" runat="server" />&nbsp; 2.0% &nbsp;</div>
			        <div class="col-md-1" style="margin-left:20px;"><asp:RadioButton ID="rbTWPercentage5" GroupName="GTWpercentage" runat="server" />&nbsp; 2.5% &nbsp;</div>
                    <div class="col-md-1" style="margin-left:20px;"><asp:RadioButton ID="rbTWPercentage6" GroupName="GTWpercentage" runat="server" />&nbsp; 3.0% &nbsp;</div>
			        <div class="col-md-1" style="margin-left:20px;"><asp:RadioButton ID="rbTWPercentage7" GroupName="GTWpercentage" runat="server" />&nbsp; 3.5%</div>
			        
		        </div>

		        <div class="col-md-12">
                    <div class="col-md-12" style="margin-left:20px;margin-bottom:10px">
		                <asp:Checkbox ID="chkToWithholdFlatAmt" runat="server" autopostback="true" OnCheckedChanged="chkToWithholdFlatAmt_CheckedChanged"/>
                            &nbsp;Check this box and enter an extra amount to be withheld from each paycheck:
                        <div style="display: inline; text-align:center;">  &nbsp;$
                            <asp:TextBox ID="txtAdditionalWithholding" runat="server" Width="100px"/>
                          </div>
		            </div>
                </div>

                <div class="col-md-12">
		            <asp:Checkbox ID="chkExempt" runat="server" autopostback="true" OnCheckedChanged="chkExempt_CheckedChanged"/>
                    &nbsp;<b>2 </b> &nbsp; I elect an Arizona withholding percentage of zero, and I certify that I expect to have 
                            no Arizona tax liability for the current taxable year.
                    
                    <br /><br />
	            </div>
            </div>
           
            <div id="DivSignatureSection">
                <table id="SignatureRow" style="width:100%;" class="HREWhite">
                    <tr>
                        <td colspan="4" style="vertical-align:top;">
                            I certify that I have made the election marked above.
                        </td>
                    </tr>
                    <tr>
                        <td style="width:20%;"></td>
                        <td style="width:50%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:20%;"></td>
                    </tr>
                    <tr style="border-bottom: 3px solid black; height: 40px;">
                        <td colspan="2" >
                            <asp:TextBox ID="txtSignature" runat="server" Width="99%" placeholder="Enter your Full Name"  />
                            <p>&nbsp;&nbsp;SIGNATURE </p>
                        </td>
                        <td colspan="2" style="min-width:180px;">
                                <asp:TextBox ID="txtSignatureDate" runat="server" Width="99%" CssClass="center"/>
                                <p>&nbsp;&nbsp;DATE </p>
                        </td>

                    </tr>
                
                </table>
        </div>

        </div>

        <div id="divFormFooter" class="row HRERewrap">
            <br />
            <div style="float:left;">
                ADOR 10121(22)
            </div>
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
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; text-align:left; padding-left:5px; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }
        table {background-color:white; color:black; border-collapse:collapse;font-size:small; }
        tr {vertical-align:top;}
        
        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0;}
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
        .HRELabel {background-color: #f5f5f0; font-size: medium; margin-bottom:3px; vertical-align:bottom;}
    </style>
</asp:Content>
