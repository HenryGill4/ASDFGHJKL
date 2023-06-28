<%@ Page Title="KY State Withholding Page"
    Language="vb"
    AutoEventWireup="false"
    MasterPageFile="~/AppMasterHeader.Master"
    CodeBehind="EE_W4_KY.aspx.vb" Inherits="HReaseApp.EE_W4_KY"
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
        .allowancesSheet {
            width: 100%;
            height: 635px;
            padding: 50px;
            border: 1px solid #333;
            margin-left: -2px;
        }

        input[type=text], textarea {
            outline: none;
            min-height: 25px;
            background-color: #f0f4fa;
            border: 1px solid #e0eaf7 !important;
        }


        .hr {
            display: block;
            overflow: hidden;
            border-style: inset;
            border-width: 1px;
            border-top: 5px solid #0c0d0e;
        }

        .vlsm {
            border-left: 5px solid #0c0d0e;
            height: 389px;
            position: absolute;
            left: 22%;
            /* margin-left: -3px; */
            top: 298px;
        }

        .hrSecon {
            display: block;
            overflow: hidden;
            border-style: inset;
            border-width: 1px;
            border-top: 1px solid #0c0d0e;
        }

        .ewvwnueBox {
            width: 100%;
            height: 635px;
            padding: 50px;
            border: 1px solid #333;
            margin-left: -2px;
        }

        .wrapper {
            width: 100%;
            margin: 0 auto;
            overflow: hidden;
            padding: 20px;
        }

        p {
            color: black;
        }
    </style>
   
    <div class="HREwrapper">
        <div id="PageTitle">
            <div>
                <br />
                <h4><b>Kentucky W-4</b></h4>
                <br />
                <br />
            </div>
        </div>

        <div id="divTopHeader" class="form-group" style="margin-top: -40px;">
            <div id="divError" runat="server" visible="false" class="HREError">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
            </div>
            <div class="form-group" style="display: inline;">
                <div id="divSuccess" runat="server" visible="false" class="HRESuccess">
                    <asp:Image ID="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" ImageAlign="Left" />
                    <asp:Label ID="lblSuccess" runat="server" Text="Form Complete" Width="50%"></asp:Label>
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
                </div>
            </div>
        </div>

        <div id="InstructionHeaderBar" class="well HRESlateBlue HRERewrap" style="text-align: center; margin: auto;">
            <span><b>INSTRUCTIONS </b></span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px; padding-bottom: 10px;" />

        </div>

        <div id="Instructions" class="form-group instruction_toggle HREWhite" style="">
            <div class="col-md-12" style="color: black; font-size: x-large; line-height: normal;">
                <p style="text-align: center; font-size: xx-large; font-weight: 700; padding-bottom: 1%; padding-top: .8%;">
                    Instructions to Employees<br />
                </p>
                <p>
                    All Kentucky wage earners are taxed at a flat 5% tax rate with an allowance for the standard deduction.
                </p>
                <p>
                    You may be exempt from withholding if any of the four conditions below are met:
                </p>
                <table>
                    <tr>
                        <td stlye="width:5%;">
                            <strong>1.</strong>
                        </td>
                        <td style="width: 95%;">
                            <span>You may be exempt from withholding for 2022 if both the following apply:
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <ul>
                                <li stlye="color:black;">For 2021, you had a right to a refund of all Kentucky income tax withheld because you had no Kentucky income tax<br />
                                    liability, and
                                </li>
                                <li stlye="color:black;">For 2022, you expect a refund of all your Kentucky income tax withheld.
                                </li>
                            </ul>
                        </td>
                    </tr>
                </table>
                <span>
                    <strong>Income Tax Liability Thresholds—</strong>The 2021 filing threshold amount based upon federal poverty level is expected to be $12,880 for a
                            family size of one (singe, or married living apart from your spouse for the entire year), $17,420 for a family of two (single with one
                            dependent child or a married couple), $21,690 for a family of three (single with two dependent children or a married couple with
                            one dependent child) and $26,500 for a family of four or more (single with three dependent children or a married couple with two
                            or more dependent children). Modified gross income is equal to your federal adjusted gross income plus any interest income from
                            other states municipal bonds and pension income from a qualifying lump-sum distribution. If your combined modified gross income
                            is expected to be less than the threshold amount for your family size, then you (and your spouse, if applicable) may not have an
                            income tax liability.
                </span>
                <p>
                    <br />
                    If both the above statements apply, you are exempt and may check box 1. Your exemption for 2022 expires February 15, 2023.
                </p>
                <table>
                    <tr>
                        <td style="width: 5%; vertical-align: top;">
                            <strong>2.</strong>
                        </td>
                        <td style="width: 95%;">
                            <span>Under the provisions of Public Law 105–261, pay and compensation earned at the Fort Campbell, Kentucky, military base is
                                exempt from Kentucky income tax if you are not a resident of Kentucky. KRS 141.010(32) defines “resident” as an individual
                                domiciled within this state or an individual who is not domiciled in this state, but maintains a place of abode in this state and
                                spends in the aggregate more than one hundred eighty-three (183) days of the taxable year in this state.
                            </span>
                        </td>
                    </tr>
                </table>
                <span>
                    <br />
                    Check box 2 if you certify that you are not a resident of Kentucky and only earn wages as an employee at Fort Campbell, Kentucky.
                    This exemption must be revoked within 10 days of a move or change of address to Kentucky.<br />
                </span>
                <table style="margin-top: 1%;">
                    <tr>
                        <td style="width: 5%; vertical-align: top;">
                            <strong>3.</strong>
                        </td>
                        <td style="width: 95%;">
                            <span>You may be exempt from withholding, if you meet the conditions set for under the Servicemember Civil Relief Act as
                               amended by the Military Spouses Residence Relief Act. You must complete the worksheet below to determine if you are
                               eligible.
                            </span>
                        </td>
                    </tr>
                </table>
                <span>
                    <br />
                    In order to qualify you must complete this form in full, certify that the you are not subject to Kentucky withholding tax because
                    you met the conditions set forth below, and provide a copy of your spouse’s military picture ID issued to the employee by the
                    U.S. Department of Defense.<br />
                </span>
                <table style="margin-top: 1%; border-top: 5px solid black; border-bottom: 5px solid black;">
                    <tr>
                        <td colpan="4">
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%; float: right; padding-right: 35px;">
                            <strong>1.</strong>
                        </td>
                        <td style="width: 65%;">My spouse is a military servicemember
                        </td>
                        <td style="width: 10%;">(check one)
                        </td>
                        <td style="width: 20%;">
                            <asp:CheckBox ID="MSYes" runat="server" AutoPostBack="true" />&nbsp;&nbsp;Yes
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:CheckBox ID="MSNo" runat="server" AutoPostBack="true" />&nbsp;&nbsp;No
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%; float: right; padding-right: 35px;">
                            <strong>2.</strong>
                        </td>
                        <td style="width: 65%;">I am NOT a military servicemember
                        </td>
                        <td style="width: 10%;">(check one)
                        </td>
                        <td style="width: 20%;">
                            <asp:CheckBox ID="NotMilitaryYes" runat="server" AutoPostBack="true" />&nbsp;&nbsp;Yes
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:CheckBox ID="NotMilitaryNo" runat="server" AutoPostBack="true" />&nbsp;&nbsp;No
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%; float: right; padding-right: 35px;">
                            <strong>3.</strong>
                        </td>
                        <td style="width: 65%;">My military servicemember spouse has a current military order assigning him or her
                           to a military location in Kentucky
                        </td>
                        <td style="width: 10%;">(check one)
                        </td>
                        <td style="width: 20%;">
                            <asp:CheckBox ID="MSinKYyes" runat="server" AutoPostBack="true" />&nbsp;&nbsp;Yes
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:CheckBox ID="MSinKYno" runat="server" AutoPostBack="true" />&nbsp;&nbsp;No
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%; float: right; padding-right: 35px;">
                            <strong>4.</strong>
                        </td>
                        <td style="width: 65%;">I and my military servicemember spouse live at the same address
                        </td>
                        <td style="width: 10%;">(check one)
                        </td>
                        <td style="width: 20%;">
                            <asp:CheckBox ID="MSsameAddressYes" runat="server" AutoPostBack="true" />&nbsp;&nbsp;Yes
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:CheckBox ID="MSsameAddressNo" runat="server" AutoPostBack="true" />&nbsp;&nbsp;No
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%; float: right; padding-right: 35px;">
                            <strong>5.</strong>
                        </td>
                        <td style="width: 65%;">My military servicemember’s state of domicile is a state other than Kentucky and I am
                           electing to use that state of domicile<br />
                            If yes, enter the 2-letter state code of the servicemember’s state of domicile <span style="border-bottom: 3px solid black;">
                                <asp:TextBox Width="10%" ID="MSotherstatetxt" runat="server" AutoPostBack="true" /></span>
                        </td>
                        <td style="width: 10%;">(check one)
                        </td>
                        <td style="width: 20%;">
                            <asp:CheckBox ID="MSotherStateYes" runat="server" AutoPostBack="true" />&nbsp;&nbsp;Yes
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:CheckBox ID="MSotherStateNo" runat="server" AutoPostBack="true" />&nbsp;&nbsp;No
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 5%; float: right; padding-right: 35px;">
                            <strong>5.</strong>
                        </td>
                        <td style="width: 65%;">I am present in Kentucky solely to be with my military servicemember spouse
                        </td>
                        <td style="width: 10%;">(check one)
                        </td>
                        <td style="width: 20%;">
                            <asp:CheckBox ID="HereForMSYes" runat="server" AutoPostBack="true" />&nbsp;&nbsp;Yes
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:CheckBox ID="HereForMSNo" runat="server" AutoPostBack="true" />&nbsp;&nbsp;No
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="padding-bottom: .5%;">
                            <br />
                            <strong>If you checked “YES” to all the statements above, your earned income is exempt from Kentucky withholding tax.</strong>
                        </td>
                    </tr>
                </table>
                <span>
                    <br />
                    <br />
                    Check box 3 if you checked “YES” to all the statements listed in the worksheet. You are exempt from Kentucky income tax
                    withholding. This exemption will terminate if any of the answers to the questions changes to “NO”. In general, the exemption
                    termination date will be the earlier of:
                </span>
                <ul>
                    <li>The day the military servicemember is no longer in the military;
                    </li>
                    <li>The day the employee enlists in the military;
                    </li>
                    <li>The day the employee and the military servicemember no longer live at the same address; or
                    </li>
                    <li>The day the military servicemember’s permanent duty station changes to a location outside of Kentucky.
                    </li>
                </ul>
                <table style="margin-top: 1%; margin-bottom: 1%;">
                    <tr>
                        <td style="width: 5%; vertical-align: top;">
                            <strong>4.</strong>
                        </td>
                        <td style="width: 95%;">
                            <span>You may be exempt from withholding if you work in Kentucky but reside in one of the following reciprocal states: Illinois,
                                Indiana, Michigan, West Virginia, Wisconsin, Virginia and you commute daily or Ohio and you are not a shareholder–
                                employee who is a “twenty (20) percent or greater” direct or indirect equity investor in a S corporation.<br />
                                <br />
                                In order to qualify you must complete the worksheet below:
                            </span>
                        </td>
                    </tr>
                </table>
                <div style="border-top: 5px solid black; border-bottom: 5px solid black; margin-bottom: 1%;">
                    <div style="padding: 3%;">
                        <span>I have not been a resident of Kentucky during the year. (Check block in front of applicable statement.) I work in Kentucky and reside in:<br />
                            <br />
                        </span>
                        <span style="padding-right: 4%;">
                            <asp:CheckBox ID="Illinois" runat="server" />&nbsp;&nbsp;&nbsp;Illinois,</span>
                        <span style="padding-right: 4%;">
                            <asp:CheckBox ID="Indiana" runat="server" />&nbsp;&nbsp;&nbsp;Indiana,</span>
                        <span style="padding-right: 3%;">
                            <asp:CheckBox ID="Michigan" runat="server" />&nbsp;&nbsp;&nbsp;Michigan,</span>
                        <span style="padding-right: 2%;">
                            <asp:CheckBox ID="WestVirginia" runat="server" />&nbsp;&nbsp;&nbsp;West Virginia,</span>
                        <span>
                            <asp:CheckBox ID="Wisconsin" runat="server" />&nbsp;&nbsp;&nbsp;Wisconsin,<br />
                        </span>
                        <span>
                            <asp:CheckBox ID="VACommute" runat="server" />&nbsp;&nbsp;&nbsp;Virginia and commute daily to my place of employment in Kentucky. (Must commute daily to apply.)<br />
                        </span>
                        <span>
                            <asp:CheckBox ID="OhioNotaShareHolder" runat="server" />&nbsp;&nbsp;&nbsp;Ohio and I am not a shareholder-employee who is a “twenty (20) percent or greater” direct or indirect equity investor in an S corporation.</span>
                    </div>

                </div>
                <span style="margin-bottom: 3%;">Check box 4 if you certify you work in Kentucky and reside in a reciprocal state.<br />
                    <br />
                </span>
                <span style="margin-bottom: 4%;">
                    <strong>If you meet any of the four exemptions you are exempted from Kentucky withholding. However, you must complete this form
                        and file it with your employer before withholding can be stopped. You will need to maintain a copy of the K-4 for your permanent
                        records.
                    </strong>
                </span>
                <div style="border-top: 4px solid black; border-bottom: 4px solid black; margin-top: 3%;">
                    <div style="padding-top: 3%; padding-bottom: 3%;">
                        <p style="text-align: center;">
                            <strong>Instructions to Employers</strong>
                        </p>
                        <span>Form K-4 is only required to document that an employee has requested an exemption from withholding OR to
                            document that an employee has requested additional withholding in excess of the amounts calculated using the
                            formula or tables. If neither situation applies, then an employer is not required to maintain Form K-4.<br />
                            <br />
                            Upon receipt of this form, properly completed, you are authorized to discontinue withholding for an employee who
                            qualifies for one of the four exemptions. Retain a copy of all K-4’s received from employees.
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <div class="clearfix">&nbsp;</div>

        <div class="col-md-12" style="width: 100%; margin-left: 10px; margin-right: 10px; font-size:x-large; line-height: normal;">
            <table style="margin-top:2%; margin-bottom:2%;">
                <tr>
                    <td style="width:15%;"></td>
                    <td style="width:35%;"></td>
                    <td style="width:35%;"></td>
                    <td style="width:15%;"></td>
                </tr>
                <tr>
                    <td colspan="1" style="border-right:4px solid black; text-align:center; font-size:xx-large !important;">
                        <strong>K-4</strong>
                    </td>
                    <td colspan="2" style="text-align:center; font-size:xx-large; border-right:4px solid black;">
                        <strong>KENTUCKY’S WITHHOLDING<br />
                        CERTIFICATE</strong>
                    </td>
                    <td colspan="1" style="font-size:xx-large !important; text-align:center;">
                        <strong>2022</strong>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="HRETan" style="text-align:center; border-right:4px solid black; border-top:4px solid black;">
                        <span>Social Security Number<br /><br /></span>
                        <strong><asp:Label ID="lblSSNumber" runat="server" /></strong>

                    </td>
                    <td colspan="4" style="border-top:4px solid black;">

                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="HRETan" style="border-top:4px solid black; border-right:4px solid black; padding-left:1%;">
                        <span>
                          Name—Last, First, Middle Initial<br /><br />
                        </span>
                        <strong><asp:Label ID="lblFullName" runat="server" /></strong>
                    </td>
                    <td colspan="4">

                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="HRETan" style="border-top:4px solid black; border-right:4px solid black; padding-left:1%;">
                        <span>
                         Mailing Address (Number and Street including Apartment Number or P.O. Box)<br /><br />
                        </span>
                        <strong><asp:Label ID="lblHomeAddress" runat="server" /></strong>
                    </td>
                    <td colspan="4">

                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="border-top:4px solid black; border-right:4px solid black; padding-left:1%; border-bottom:4px solid black;" class="HRETan">
                        <span style="float:left">
                            City, Town or Post Office<br /><br />
                            <strong><asp:Label ID="lblCity" runat="server" /></strong>
                        </span>
                        <span style="float:right; padding-right:4%;">
                            ZIP Code<br /><br />
                            <strong><asp:Label ID="lblZIP" runat="server" /></strong>
                        </span>
                        <span style="float:right; padding-right:6%;">
                            State<br /><br />
                            <strong><asp:Label ID="lblState" runat="server" /></strong>
                        </span>
                        
                    </td>
                    <td colspan="4" style="border-bottom:4px solid black;">

                    </td>
                </tr>
            </table>
            <span style="padding-left:1%; float:left;">
                All Kentucky wage earners are taxed at a flat 5% rate with a standard deduction allowance of $2,770. The Department
                of Revenue annually adjust the standard deduction in accordance with KRS 141.081(2)(a).<br /><br />
            </span>
            <span style="padding-left:1%;">
                Check if exempt:<br />
            </span>
            <ol id="chkexmptlist" style="margin-top:2%;">
                <li style="padding:2%;">
                    <asp:CheckBox id="ChkExmpt1" runat="server" onclick="checkboxchecked()"/>
                    &nbsp;&nbsp;&nbsp;Kentucky income tax liability is not expected this year (see instructions)
                </li>
                <li style="padding:2%;">
                    <asp:CheckBox ID="ChkExmpt2" runat="server"  />
                    <%--<input type="checkbox" id="myCheck" name="vehicle" value="1" />--%>
                    &nbsp;&nbsp;&nbsp;You qualify for the Fort Campbell Exemption Certificate. I am a resident of
                   <span style=" text-align:center; padding-left:3%; float:inline-end;">
                <span style="border-bottom:2px solid black; text-align:center;">
                <asp:TextBox ID="TextBox1" Text="State" runat="server"/>
                </span>
                
            </span>
                </li>
                <li style="padding:2%;">
                    <asp:CheckBox id="ChkExmpt3" runat="server" value="true" />
                   &nbsp;&nbsp;&nbsp;You qualify for the nonresident military spouse exemption 
                </li>
                <li style="padding:2%;">
                    <asp:CheckBox ID="ChkExmpt4" runat="server" />
                   &nbsp;&nbsp;&nbsp;You work in Kentucky and reside in a reciprocal state
                </li>
            </ol>
            <span style="margin-top:1%; margin-bottom:2%;">
                &nbsp;&nbsp;&nbsp;Additional withholding per pay period under agreement with employer
                <span style="padding-left:5%;">
                    $<asp:TextBox ID="txtAdditionalWithholding" runat="server" />
                </span>
                <br /><br />
            </span>
            <span style="margin-bottom:5%;">
                Under penalties of perjury, I declare that I have examined this certificate and, to the best of my knowledge and belief,
                it is true, correct, and complete.<br /><br />
            </span>
            <span style="float:left; text-align:center; width:50%;">
                <span style="border-bottom:2px solid black; text-align:center;">
                <asp:TextBox Width="95%" ID="txtSignature" runat="server" /><br />
                </span>
                Signature
            </span>
            <span style="float:Right; text-align:center; width:50%;">
                <span style="border-bottom:2px solid black; text-align:center;">
                <asp:TextBox Width="95%"  ID="SignatureDate" runat="server"/><br />
                </span>
                Date<br /><br />
            </span>

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
        
        
        function checkBoxChecked() {

            if (document.getElementById("ChkExmpt1").value == true) {
                var a = 1
                console.log(a)
            } else {
                var a = 0
                console.log(a)
            }




        }
           
        
        


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
            color: black !important;
            border-collapse: collapse;
            border-spacing: 0px 5px;
        }

        p {
            color: black !important;
        }

        li {
            color: black !important;
        }

        div {
            color: black !important;
        }

        .HREwrapper {
            margin-left: 5%;
            margin-right: 5%;
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
    </style>
</asp:Content>
