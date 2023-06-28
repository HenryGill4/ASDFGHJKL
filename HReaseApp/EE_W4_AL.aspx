<%@ Page Title="AL State Withholding Page" 
    Language="vb"
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_AL.aspx.vb"
    Inherits="HReaseApp.EE_W4_AL" 
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

    <style>
        span.capital-letter {
            font-size: 120% !important;
        }
    </style>
    <div class="HREwrapper">
        <div id="PageTitle" class="HRERewrap">
            <div style="text-align:center;">
                <br />
                <h4><b>Alabama Form A-4</b></h4>
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

        <div id="divInstructions" class="well HRESlateBlue HRERewrap" style="margin-top: 20px;">
            <div>
                <h4><span style="font-weight:bold;">INSTRUCTIONS</span>
                <span style="float: right;"><img class="instruction_toggle_btn" id="instruction_btn" src="img/plus.png" style="float: right; width: 30px;" />
                </span>
                </h4>
            </div>

            <div class="row HRETextWhite instruction_toggle" id="instruction" style="border:1px solid white; text-align: center;">
                <div class="col-md-12">
                    <a href="http://www.revenue.alabama.gov" target="_blank">www.revenue.alabama.gov</a>
                </div>
            </div>   
       </div>

        <div id="MainForm" class="well HREWhite HRERewrap" style="font-size:12px; color:black; padding:5px;">
            <table id="divFormHeader" style="width: 100%; background-color:white;">
                <tr>
                    <td width:15%;></td>
                    <td width:70%;></td>
                    <td width:15%;></td>
                </tr>
                <tr>
                    <td colspan="1" style="text-align:center;">
                        &nbsp;<b>FORM</b><br/>
					    <h1><b>A-4</b></h1>
                        &nbsp;(REV 3/2014)
                    </td>
                    <td colspan="1">
                        <div style="text-align: center;">
                            <div style="font-family: serif; margin-top: 20px; font-size: 23px; letter-spacing: -1px;">
                                <span class="capital-letter">A</span>LABAMA
                                <span class="capital-letter">D</span>EPARTMENT OF 
                                <span class="capital-letter">R</span>EVENUE 
                            </div>
                            <div>
                                50 North Ripley Street • Montgomery, AL 36104 • InfoLine (334) 242-1300
                                <br />
                                <a href="http://www.revenue.alabama.gov" target="_blank">www.revenue.alabama.gov</a>
                            </div>
                            <div>
                                <h2 style="font-family: serif;">Employee’s Withholding Exemption Certificate</h2>
                            </div>
                        </div>
                    </td>
                    <td colspan="1" style="text-align:center;">
                        <img src="images/AZ_StateLogo.png" />
                    </td>
                </tr>
            </table>

            <div style="margin-left:3%; margin-right:3%; padding: 5px; border-bottom: 1px solid black; border-top: 1px solid black" >
                Every employee, on or before the date of commencement of employment, shall furnish his or her employer with a signed Alabama withholding
                        exemption certificate relating to the number of withholding exemptions which he or she claims, which in no event shall exceed the
                        number to which the employee is entitled. In the event the employee inflates the number of exemptions allowed by this Chapter on Form
                        A4, the employee shall pay a penalty of five hundred dollars ($500) for such action pursuant to Section 40-29-75.
            </div>
            
            <div style="font-size:18px; margin-left:3%; margin-right:3%; padding: 5px; border-bottom: 1px solid black;" >
                <b>Part I – To be completed by the employee</b>
            </div>
            
            <div id="divMainForm" style="margin-left:3%; margin-right:3%; padding: 5px;">
                <table id="divEEHeader" style="background-color:white; width:100%; border-bottom:1px solid black;">
                    <tr>
                        <td style="width:40%;" ></td>
                        <td style="width:30%;" ></td>
                        <td style="width:20%;" ></td>
                        <td style="width:10%;" ></td>
                    </tr>
                    <tr style="height:40px; vertical-align:top;">
                        <td colspan="2" >
                            EMPLOYEE NAME
                        </td>
                        <td colspan="2">
                            EMPLOYEE SOCIAL SECURITY NUMBER
                        </td>
                    </tr>
                    <tr >
                        <td colspan="2">
                            <b><asp:Label ID="lblFullName" runat="server"></asp:Label></b>
                        </td>
                        <td colspan="2">
                            <b><asp:Label ID="lblSSNumber" runat="server"/></b>
                        </td>
                    </tr>

                    <tr style="border-top: 1px solid black; height: 40px; vertical-align:top;">
                        <td colspan="1" >
                                STREET ADDRESS
                        </td>
                        <td colspan="1" >
                                CITY
                        </td>
                        <td colspan="1" >
                                STATE
                        </td>
                        <td colspan="1">
                                ZIP
                        </td>
                    </tr>
                    <tr >
                        <td colspan="1">
                            <b><asp:Label ID="lblHomeAddress" runat="server"></asp:Label></b>
                        </td>
                        <td colspan="1">
                            <b><asp:Label ID="lblCity" runat="server"/></b>
                        </td>
                        <td colspan="1">
                            <b><asp:Label ID="lblState" runat="server"/></b>
                        </td>
                        <td colspan="1">
                            <b><asp:Label ID="lblZipCode" runat="server" MaxLength="5"  /></b>
                        </td>
                    </tr>
                </table>

                <table id="divWithholdingData" style="background-color:white; width:100%; border-bottom:1px solid black;">
                    <tr>
                        <td style="width:3%;" ></td>
                        <td style="width:62%;" ></td>
                        <td style="width:5%;" ></td>
                        <td style="width:30%;" ></td>
                    </tr>
                    <tr >
                        <td colspan="4" style="text-align: center; font-size:18px;">
                            <br />
                            <b>HOW TO CLAIM YOUR WITHHOLDING EXEMPTIONS</b>
                            <br /><br />
                        </td>
                    </tr>

                    <tr style="vertical-align: top; text-align:left;">
                        <td colspan="1">
                            &nbsp;1.
                        </td>
                        <td colspan="1" >
                            If you claim no personal exemption for yourself and wish to withhold at the highest rate, write the figure “0”, sign and date Form A-4 and file it with your employer.
                        </td>
                        <td colspan="1"></td>
                        <td colspan="1" style="text-align: right; padding-right:10px;">
                            <asp:TextBox ID="txtClaimNoExemptions" runat="server" placeholder=" Number 0 Only" class="center" />
                        </td>
                    </tr>

                    <tr style="vertical-align: top;">
                        <td colspan="1">
                            &nbsp;2.
                        </td>
                        <td colspan="1">If you are SINGLE or MARRIED FILING SEPARATELY, a $1,500 personal exemption is allowed. Write the letter “S” if claiming the SINGLE exemption or
						    “MS” if claiming the MARRIED FILING SEPARATELY exemption.
                        </td>
                        <td colspan="1"></td>
                        <td colspan="1" style="text-align: right; padding-right:10px;">
                            <asp:TextBox ID="txtTaxFilingStatusLine1" runat="server" placeholder=" S or MS only" class="center" Autopostback="true" OnTextChanged="txtTaxFilingStatusLine1_TextChanged"/>
                        </td>
                    </tr>

                    <tr style="vertical-align: top;">
                        <td colspan="1">
                            &nbsp;3.
                        </td>
                        <td colspan="1">If you are MARRIED or SINGLE CLAIMING HEAD OF FAMILY, a $3,000 personal exemption is allowed. Write the letter “M” if you are claiming an exemption for both yourself and
						    your spouse or “H” if you are single with qualifying dependents and are claiming the HEAD OF FAMILY exemption.
                        </td>
                        <td colspan="1"></td>
                        <td colspan="1" style="text-align: right; padding-right:10px;">
                            <asp:TextBox ID="txtTaxFilingStatusLine2" runat="server" placeholder=" M or H only" class="center"  Autopostback="true" OnTextChanged="txtTaxFilingStatusLine2_TextChanged"/>
                        </td>
                    </tr>

                    <tr style="vertical-align: top;">
                        <td colspan="1">
                            &nbsp;4.
                        </td>
                        <td colspan="1">Number of dependents (other than spouse) that you will provide more than one-half of the support for during the year. See instructions for dependent qualifications.
                        </td>
                        <td colspan="1"></td>
                        <td colspan="1" style="text-align: right; padding-right:10px;">
                            <asp:TextBox ID="txtNumberOfDependents" runat="server" placeholder=" Number only" class="center"  />
                        </td>
                    </tr>

                    <tr style="vertical-align: top;">
                        <td colspan="1">
                            &nbsp;5.
                        </td>
                        <td colspan="1" >Additional amount, if any, you want deducted each pay period.
                        </td>
                        <td colspan="1" ></td>
                        <td colspan="1" style="text-align: right; padding-right:10px;" >
                            <asp:TextBox ID="txtAdditionalWithholding" runat="server" Text="$" placeholder=" Monetary Amount" class="center" />
                        </td>
                    </tr>

                    <tr style="vertical-align: top;">
                        <td colspan="1" >
                            &nbsp;6.
                        </td>
                        <td colspan="1" >
                            <b>This line to be completed by your employer:</b>Total exemptions (example: employee claims “M” on line 3 and
                            “2” on line 4. Employer should use column M-2 (married with 2 dependents) in the withholding tables)
                        </td>
                        <td colspan="1"></td>
                        <td colspan="1" style="text-align: right; padding-right:10px; vertical-align:bottom;">
                            <asp:TextBox ID ="txtTotalExemptions" runat="server" placeholder=" Number - REQUIRED" class="center" Autopostback="true" OnTextChanged="txtTotalExemptions_TextChanged"/>
                        </td>
                    </tr>
            
                    <tr >
                        <td colspan="4" style="padding: 5px 0px 10px 0px;">
                            <br />
                            Under penalties of perjury, I declare that I have examined this certificate and to the best of my knowledge and belief, it is true, correct, and complete. 
                            <br />
                        </td>
                    </tr>
                
                    <tr style="border-bottom: 3px solid black; height: 40px;">
                        <td colspan="2" >
                                <b>Employee’s Signature</b>&nbsp;&nbsp;
                                <asp:TextBox ID="txtSignature" runat="server" Width="80%" placeholder=" Type Signature to represent you certify this information to be correct."  />
                        </td>
                        <td colspan="2">
                                <b>Date</b>&nbsp;&nbsp;
                                <b><asp:TextBox ID="SignatureDate" runat="server" Width="70%" /></b>
                        </td>

                    </tr>
                </table>

                <div style="font-size:18px; padding: 5px; border-bottom: 1px solid black;" >
                    <b>Part II – To be completed by the employer</b>
                </div>

                <table style="background-color:white; width:100%; border-bottom:1px solid black;">
                    <tr>
                        <td style="width:40%;" ></td>
                        <td style="width:30%;" ></td>
                        <td style="width:20%;" ></td>
                        <td style="width:10%;" ></td>
                    </tr>
                    <tr style="height:40px; vertical-align:top;">
                        <td colspan="2" >
                            EMPLOYER NAME
                        </td>
                        <td colspan="2">
                            EMPLOYER IDENTIFICATION NUMBER (EIN)
                        </td>
                    </tr>
                    <tr >
                        <td colspan="2">
                            <b><asp:Label ID="lblEmployerName" runat="server"></asp:Label></b>
                        </td>
                        <td colspan="2">
                            <b><asp:Label ID="lblEmployerFEIN" runat="server"/></b>
                        </td>
                    </tr>

                    <tr style="border-top: 1px solid black; height: 40px; vertical-align:top;">
                        <td colspan="1" >
                                ADDRESS
                        </td>
                        <td colspan="1" >
                                CITY
                        </td>
                        <td colspan="1" >
                                STATE
                        </td>
                        <td colspan="1">
                                ZIP
                        </td>
                    </tr>
                    <tr >
                        <td colspan="1">
                            <b><asp:Label ID="lblEmployerAddress" runat="server"></asp:Label></b>
                        </td>
                        <td colspan="1">
                            <b><asp:Label ID="lblEmployerCity" runat="server"/></b>
                        </td>
                        <td colspan="1">
                            <b><asp:Label ID="lblEmployerState" runat="server"/></b>
                        </td>
                        <td colspan="1">
                            <b><asp:Label ID="lblEmployerZip" runat="server" MaxLength="5"  /></b>
                        </td>
                    </tr>
                </table>

                <div style="border-bottom:3px solid black;">
                            Employers are required to keep this certificate on file. If the employee is believed to have claimed more exemption than legally entitled or
                            claims 8 or more dependent exemptions, the employer should contact the Department at the following address or phone number for verification:
                            Alabama Department of Revenue, Withholding Tax Section, P.O. Box 327480, Montgomery, AL 36132-7480, by phone at (334)
                            242-1300, or by fax at (334) 242-0112. If the employee does not qualify for the exemptions claimed upon verification, the employer is required
                            to withhold at the highest rate until the employee submits a corrected Form A4 reflecting the proper exemption they are entitled to
                            claim.
                </div>
                <div style="border-bottom:3px solid black;">
                            <b>DEPENDENTS: </b>To qualify as your dependent (Line 4 above), a person must receive more than one-half of his or her support from you
                                for the year and must be related to you as follows:
                                Your son or daughter (including legally adopted children), grandchild, stepson, stepdaughter, son-in-law, or daughter-in-law;
                                Your father, mother, grandparent, stepfather, stepmother, father-in-law, or mother-in-law;
                                Your brother, sister, stepbrother, stepsister, half-brother, half-sister, brother-in-law, or sister-in-law;
                                Your uncle, aunt, nephew, or niece (but only if related by blood).
                </div>
            </div>
            
            <div class="row">
                <div class="clearfix">&nbsp;</div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
                    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" OnClick="btnSave_Click" />
                </div>
                <div class="clearfix">&nbsp;</div>
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


        <%--function FunReset() {
            $('#<%=lblFullName.ClientID %>').val('');
                       $('#<%=txtClaimWithholdingsBox1.ClientID %>').val('');
                       $('#<%=txtClaimWithholdingsBox2.ClientID %>').val('');
                       $('#<%=txtClaimWithholdingsBox3.ClientID %>').val('');
                       $('#<%=txtClaimWithholdingsBox4.ClientID %>').val('');
                       $('#<%=txtClaimWithholdingsBox5.ClientID %>').val('');
                       $('#<%=txtClaimWithholdingsBox6.ClientID %>').val('');
                       $('#<%=txtClaimWithholdingsBox7.ClientID %>').val('');
                       $('#<%=txtTotalExemptions.ClientID %>').val('');
                       
        }--%>


    </script>
    <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border-bottom: 1px solid black; border-top: 0px; border-left: 0px; border-right: 0px; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }  
        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; margin: 10px 5px 10px 5px; padding:5px;}
        .HRETextWhite {background-color: white; margin-right:10px; padding:10px;}
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
    </style>
</asp:Content>
