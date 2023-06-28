<%@ Page Title="MI State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_MI.aspx.vb" 
    Inherits="HReaseApp.EE_W4_MI" 
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

        // This function will allow users to insert only numbers in the textboxes.
        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
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

       function makeMoney(source){
          //Grab the value from the element
          var money = parseFloat(source.value,10).toFixed(2);
      
          //Format your value
          source.value = money.toString();
        }
    </script>

   <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>MI Form MI-W4</b></h4>
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
            <div style="font-size: x-large; text-align:center;padding-top:10px; padding-bottom:10px; border-bottom:1px solid black;">
                <b>INSTRUCTIONS TO EMPLOYEE’S
                    <br />  
                    MICHIGAN WITHHOLDING EXEMPTION CERTIFICATE (Form MI-W4) </b>
            </div>
            <div class="form-group HREWhite" >
                <div class="col-md-6" style="color:black;">
					<p>You must submit a Michigan withholding exemption 
                        certificate (form MI-W4) to your employer on or before 
                        the date that employment begins. If you fail or refuse 
                        to submit this certificate, your employer must withhold 
                        tax from your compensation without allowance for any 
                        exemptions. Your employer is required to notify the 
                        Michigan Department of Treasury if you have claimed 10 
                        or more personal or dependency exemptions or claimed 
                        that you are exempt from withholding. </p>
					<p>You MUST provide a new MI-W4 to your employer 
                        within 10 days if your residency status changes or if 
                        your exemptions decrease because: a) your spouse, for 
                        whom you have been claiming an exemption, is divorced 
                        or legally separated from you or claims his/her own 
                        exemption(s) on a separate certificate, or b) a dependent 
                        no longer qualifies under the Internal Revenue Code. </p>
					<p><b>Line 5:</b> If you check “Yes,” enter your date of hire.</p>
					<p><b>Line 6:</b> Personal and dependency exemptions. The 
                        number of exemptions claimed here may not exceed 
                        the number of exemptions you are entitled to claim on a 
                        <i>Michigan Individual Income Tax Return</i> (Form MI-1040). 
                        Dependents include qualifying children and qualifying 
                        relatives under the Internal Revenue Code, even if your 
                        AGI exceeds the limits to claim federal tax credits for 
                        them. </p>
                    <p>Do not claim the same exemptions more than once or tax 
                        will be under-withheld. Specifically, <b>not claim:</b></p>
                    <ul>
                        <li>Your personal exemption if someone else will claim 
                            you as their dependent. </li>
                        <li>Your personal exemption with more than one 
                            employer at a time. </li>
                        <li>Your spouse’s personal exemption if they claim it 
                            with their employer.</li>
                        <li>Your dependency exemptions if someone else (for 
                            example, your spouse) is claiming them with their 
                            employer. </li>
                    </ul>
				</div>
                <div class="col-md-6">
                    <p><b>Line 7:</b> You may designate additional withholding if you 
                           expect to owe more than the amount withheld. </p>
                    <p><b>Line 8a:</b> You may claim exemption from Michigan income 
                            tax withholding if all of the following conditions are met: </p>
                        <ol>
                            <li>) Your employment is intermittent, temporary, or less 
                                    than full time;</li>
                            <li>) Your personal and dependency exemptions exceed 
                                    your annual taxable compensation;</li>
                            <li>) You claimed exemption from federal withholding; and</li>
                            <li>) You did not incur a Michigan income tax liability for 
                                    the previous year.</li>
                        </ol>
                    <p><b>Line 8b:</b> Reasons wages might be exempt from
                        withholding include:</p>
                        <ul><li>You are a nonresident spouse of military personnel
                                stationed in Michigan.</li>
                            <li>You are a resident of one of the following reciprocal
                                states while working in Michigan: Illinois, Indiana,
                                Kentucky, Minnesota, Ohio, or Wisconsin. </li>
                            <li>You are an enrolled member of a federallyrecognized tribe that does not have a tax
                                agreement with the state of Michigan, you reside
                                within that tribe’s Indian Country (as defined in 18
                                USC 1151), and compensation from this job will be
                                earned within that Indian Country. </li>
                        </ul>
                    <p><b>Line 8c:</b> For questions about Renaissance Zones,
                            contact your local assessor’s office. </p>
				</div>
			</div>
            
           <br />
           <br />
		</div>

        <div id="divMainForm" style="margin-left:1%; margin-right:5%;">
            <div>
                <table style="width:100%; background-color:white;">
                    <tr>
                        <td style="font-size: 35px; font-weight: bold;">
                            MI-W4
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td style="font-size: 13px;"> 
                            (Rev. 12-20)
                        </td>
                    </tr>
                    <tr>
                        <td style="font-size: 20px;  font-weight: bold; padding: 10px 0px;">
                            EMPLOYEE'S MICHIGAN WITHHOLDING EXEMPTION CERTIFICATE
                            <br /> 
                            STATE OF MICHIGAN - DEPARTMENT OF TREASURY
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <i>This certificate is for Michigan income tax withholding purposes only. <b>Read instructions on page 2 before completing this form. </b></i>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                </table>
            </div>

            <div>
                <table style="width: 100%; background-color:white; font-size:large; border-bottom:2px solid black;">
                    <tr>
                        <td style="width:55%;"></td>
                        <td style="width:25%;"></td>
                        <td style="width:20%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1">                        
                            <div style="vertical-align:top;"> 
                                Issued under P.A. 281 of 1967. 
                            </div>
                        </td>
                        <td colspan="1" style="border-left:2px solid black; border-top:2px solid black;">
                            <i class="fa fa-caret-right fa-6" aria-hidden="true" style="padding: 2px;"></i>
                                1. Full Social Security Number
                                <br/>
                            <b><asp:Label ID ="lblSSNWithDashes" runat="server" Width="100%" Style="padding-left:4%; color:dimgrey" CssClass="HRETan"></asp:Label></b>
                        </td>
                        <td colspan="1" style="border-left:2px solid black; border-top:2px solid black; border-right:2px solid black;">
                            <i class="fa fa-caret-right fa-6" aria-hidden="true" style="padding: 2px;"></i>
                                2. Date of Birth
                                <br />
                            <b><asp:Label ID="lblBirthDate" runat="server" Width="100%" Style="padding-left:4%; color:dimgrey" CssClass="HRETan"/></b>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <table style="width: 100%; background-color:white; font-size:large; border:1px solid black;">
                    <tr>
                        <td style="width:55%;"></td>
                        <td style="width:45%;"></td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border: 2px solid black;">
                            <i class="fa fa-caret-right fa-6" aria-hidden="true" style="margin-left: 5px;"></i>
                                3. Name (First, Middle Initial, Last)
                                <br />
                            <b><asp:Label ID= "lblEmployeeFullName" Style="padding-left:4%; color:dimgrey" runat="server" Width="100%" CssClass="HRETan" /></b>
                        </td>
                        <td colspan="1"><span style="padding-left: 10px; ">
                                4. Driver’s License Number or State ID</span>
                            <br />
                            <asp:TextBox ID="txtDriversLicenseNo" runat="server" Style="padding-left:5%;" Width="100%"/>
                        </td>
                    </tr>
                </table>
            </div>
            <div >
                <table style="width: 100%; background-color:white; font-size:large; margin-top:-1.1px;">
                    <tr>
                        <td style="width:40%;"></td>
                        <td style="width:7%;"></td>
                        <td style="width:8%;"></td>
                        <td style="width:25%;"></td>
                        <td style="width:20%;"></td>
                    </tr>
                    <tr style="border-right:1px solid black;">
                        <td colspan="3" style="border:1px solid black; border-top:2px solid black; ">
                            Home Address (No., Street, P.O. Box or Rural Route)
                            <br />
                            <b><asp:Label ID="lblAddressCombined" runat="server" Style="padding-left:4%; color:dimgrey" Width="100%" CssClass="HRETan"/></b>
                        </td>
                        <td colspan="1" style="border-top:1px solid black; border-left:1px solid black; border-right:1px solid black; font-size: medium;">
                            <i class="fa fa-caret-right fa-6" aria-hidden="true" style="padding-left: 10px;"></i>
                            5. Are you a new employee?
                            <br />
                            <asp:CheckBox ID="chkNewEmployeeYes" runat="server" Text="&nbsp;Yes" Style="padding-left: 15px;" AutoPostBack="true" OnCheckedChanged="chkNewEmployeeYes_CheckedChanged" />
                            <span style="font-weight: normal;"> If Yes, enter date of hire... </span>
                        </td>
                        <td colspan="1" style="border:2px solid black; vertical-align:top; font-size: medium; text-align:center;">
                                (mm/dd/yyyy)
                                <br />
                                <b><asp:Label ID="lblHireDate" runat="server" Style="padding-left:4%; color:dimgrey;" Width="100%" CssClass="HRETan center"/></b>
                        </td>
                    </tr>

                
                    <tr>
                        <td colspan="1" style="border:1px solid black;">
                            City or Town
                            <br />
                            <b><asp:Label ID="lblEECity" runat="server" Style="padding-left:5%; color:dimgrey" Width="100%" CssClass="HRETan"/></b>
                        </td>
                        <td colspan="1" style="border:1px solid black;">
                            State
                            <br />
                            <b><asp:Label ID="lblEEState" runat="server" Style="padding-left:4%; color:dimgrey" Width="100%" CssClass="HRETan" /></b>
                        </td>
                        <td colspan="1" style="border:1px solid black;">
                            ZIP Code
                            <br />
                            <b><asp:Label ID="lblZIP" runat="server" Style="padding-left:4%; color:dimgrey" Width="100%" CssClass="HRETan" /></b>
                        </td>
                        <td colspan="1" style ="border-right:none; vertical-align:top; border-bottom:1px solid black;">
                            <asp:CheckBox ID="chkNewEmployeeNo" runat="server" Text="&nbsp;No" Style="padding-left: 15px;" AutoPostBack="true" OnCheckedChanged="chkNewEmployeeNo_CheckedChanged"/>
                        </td>
                        <td colspan="1" style="border-right:1px solid black; border-bottom:1px solid black;">
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <table style="width: 100%; background-color:white; font-size:large; border:1px solid black;">
                    <tr>
                        <td style="width:2%;"></td>
                        <td style="width:58%;"></td>
                        <td style="width:15%;"></td>
                        <td style="width:2%;"></td>
                        <td style="width:3%;"></td>
                        <td style="width:20%;"></td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            &nbsp;
                        </td>
                        <td colspan="1" style="border-left:2px solid black; border-top:2px solid black; border-right:2px solid black;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="vertical-align:top;">
                            6.
                        </td>
                        <td colspan ="1" style="vertical-align:top;">
                            Enter the number of personal and dependent exemptions you are claiming (see instructions)
                        </td>
                        <td colspan="1">
                        </td>
                        <td colspan="1" style="vertical-align:bottom;">
                            <i class="fa fa-caret-right fa-6" aria-hidden="true"></i>
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right; padding-right:1%;">
                            6.
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:center; border-left:2px solid black;border-bottom:2px solid black; border-right:2px solid black;">
                            <asp:TextBox ID="txtTotalExemptions" runat="server" onkeypress="return onlyNumbers()" Width="100%" CssClass="center"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            &nbsp;
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black;">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="vertical-align:top;">
                            7.
                        </td>
                        <td colspan ="1" style="vertical-align:top;">
                            Additional amount you want deducted from each pay (if employer agrees)
                        </td>
                        <td colspan="1">
                        </td>
                        <td colspan="1">
                        </td>
                        <td colspan ="1" style="vertical-align:bottom; text-align:right; padding-right:1%;">
                            7.
                        </td>
                        <td colspan="1" style="vertical-align:bottom; text-align:center; border-left:1px solid black;border-bottom:1px solid black; border-right:1px solid black;">
                            $<asp:TextBox ID="txtAdditionalWithholding" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)" Class="center" Width="95%"/>
                        </td>
                    </tr>
                
                    <tr>
                        <td colspan="6">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="vertical-align:top;">
                            8.
                        </td>
                        <td colspan ="5">
                            I claim exemption from withholding because (see instructions):
                            <br /><br />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="5" style="color:black;">
                            a.&nbsp;&nbsp;<asp:CheckBox ID="chkExemptA" runat="server" Text="&nbsp;&nbsp;A Michigan income tax liability is not expected this year." />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="5">
                            b.&nbsp;&nbsp;<asp:CheckBox ID="chkExemptB" runat="server" Text="&nbsp;&nbsp;Wages are exempt from withholding.  Explain:"/>
                           <asp:TextBox ID="txt8b" runat="server" Width="70%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="5">
                            c.&nbsp;&nbsp;<asp:CheckBox ID="chkExemptC" runat="server" Text="&nbsp&nbsp;Permanent home (domicile) is located in the following Renaissance Zone:"/>
                            <asp:TextBox ID="txt8c" runat="server" Width="56%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            &nbsp;
                        </td>
                    </tr>
                    <tr >
                        <td colspan="6" style="border:1px solid black; padding: 6px 6px 6px 6px">
                            <b>EMPLOYEE:</b> If you fail or refuse to file this form, your employer must withhold Michigan income tax from your wages without allowance for any
                                exemptions. Keep a copy of this form for your records. See additional instructions on page 2. 
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" style="border:1px solid black; padding: 6px 6px 6px 6px">
                            <i> Under penalty of perjury, I certify that the number of withholding exemptions claimed on this certificate does not exceed the number I am allowed to
                                claim. If claiming exemption from withholding, I certify that I do not anticipate a Michigan income tax liability this year.</i> 
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="border-right:1px solid black;">
                            9. Employee's Signature 
                            <br />
                            <asp:TextBox ID="txtSignature" runat="server" Style="padding-left:2%;" Width="99%"/>
                        </td>
                        <td colspan="2">
                            <i class="fa fa-caret-right fa-6" aria-hidden="true" style="padding-left: 10px;"></i>
                            Date
                            <br />
                            <asp:TextBox ID="SignatureDate" runat="server" CssClass="center" Width="99%" />
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <br />
            <div>
                <table style="width: 100%; background-color:white; font-size:large;">
                    <tr>
                        <td style="width:55%;"></td>
                        <td style="width:30%;"></td>
                        <td style="width:7%;"></td>
                        <td style="width:8%;"></td>
                    </tr>
                    <tr style ="border:1px solid black;">
                        <td colspan="4" style="padding:6px 6px 6px 6px;">
                            <b>EMPLOYER:</b> Complete the below section. 
                        </td>
                    </tr>
                    <tr style="border:1px solid black;">
                        <td colspan="1">
                            10. Employer’s Name
                            <br />
                            <b><asp:Label ID="lblEmployerName" runat="server" Style="padding-left: 10px;" CssClass="HRETan" Width="100%"/></b>
                        </td>
                        <td colspan="3" style="border: 2px solid black;">
                            <i class="fa fa-caret-right fa-6" aria-hidden="true" style="padding-left: 10px;" ></i>
                            11. Federal Employer Identification Number
                            <br />
                            <b><asp:Label ID="lblEmployerFEIN" runat="server" Style="padding-left: 10px;" CssClass="HRETan" Width="100%"/></b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border:1px solid black;">
                            Address (No., Street, P.O. Box or Rural Route)
                            <br />
                            <b><asp:Label ID="lblEmployerAddress" runat="server" Style="padding-left: 10px;" CssClass="HRETan" Width="100%"/></b>
                        </td>
                        <td colspan="1">
                            City or Town
                            <br />
                            <b><asp:Label ID="lblEmployerCity" runat="server" Style="padding-left: 10px;" CssClass="HRETan" Width="100%"/></b>
                        </td>
                        <td colspan="1" style="border-right: 1px solid black;">
                            State
                            <br />
                            <b><asp:Label ID="lblEmployerState" runat="server" Style="padding-left: 10px;" CssClass="HRETan" Width="100%"/></b>
                        </td>
                        <td colspan="1" style="border-right: 1px solid black;">
                            ZIP Code
                            <br />
                            <b><asp:Label ID="lblEmployerZip" runat="server" Style="padding-left: 10px;" CssClass="HRETan" Width="100%"/></b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="border:1px solid black;">
                            Name of Contact Person
                            <br />
                            <b><asp:Label ID="lblAdminName" runat="server" Style="padding-left: 10px;" CssClass="HRETan" Width="100%"/></b>
                        </td>
                        <td colspan="3" style="border:1px solid black;">
                            Contact Phone Number
                            <br />
                            <b><asp:Label ID="lblAdminPhone" runat="server" Style="padding-left: 10px;" CssClass="HRETan" Width="100%"/></b>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="border:1px solid black; padding:10px 10px 10px 10px">
                            <b>INSTRUCTIONS TO EMPLOYER: </b> Keep a copy of this certificate with your records. All new hires must be reported to the State of Michigan. See
                                <b>www.mi-newhire.com</b> for information.
                            <br />
                            <br />
                            In addition, a copy of this form must be sent to the Michigan Department of Treasury if the employee claims 10 or more exemptions or claims they are
                            exempt from withholding. Send a copy to: 
                            <br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Michigan Department of Treasury
                            <br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Tax Technical Section
                            <br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P.O. Box 30477 
                            <br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lansing, MI 48909

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
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border-top: none; border-left: none; border-right: none; border-bottom: 1px solid black; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; content: "X"; color: black;}
        ol { list-style-type: lower-roman; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; color:black; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
        .HRELabel {background-color: #f5f5f0; font-size: large; vertical-align:bottom;}
        .HREBlack {color: black;}
    </style>
     
</asp:Content>
