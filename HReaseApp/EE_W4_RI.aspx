<%@ Page Title="RI State Withholding Page"
    Language="vb"
    AutoEventWireup="false"
    MasterPageFile="~/AppMasterHeader.Master"
    CodeBehind="EE_W4_RI.aspx.vb"
    Inherits="HReaseApp.EE_W4_RI"
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

             if (charCode > 31 && (charCode < 48 || charCode > 57))
                 return false;
             return true;
         }
    
         $(function () {

             $('input:text[id$=hdnPW]').val(document.getElementById('jssecond').innerHTML);

             var textBox1 = $('input:text[id$=txtBox1A]').keyup(foo);
             var textBox2 = $('input:text[id$=txtBox1B]').keyup(foo);
             var textBox3 = $('input:text[id$=txtTotalDependents]').keyup(foo);
             var textBox4 = $('input:text[id$=txtBox1D]').keyup(foo);
             
             

           



             function foo() {
                 var a = textBox1.val();
                 var b = textBox2.val();
                 var c = textBox3.val();
                 var d = textBox4.val();
                 var sum = add(a, b, c, d);
                 
                 $('input:text[id$=txtBox1E]').val(sum);
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
    <div id="jssecond" style="width: 100%; text-align: center;">
        <div class="HREwrapper" style="text-align: center; width: 95%; align-self: center;">
            <div id="PageTitle" style="width: 98%; margin-left: auto; margin-right: auto;">
                <div style="text-align: center; width: 100%;">
                    <br />

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

            <div id="InstructionHeaderBar" class="well HRESlateBlue HRERewrap" style="text-align: center; width: 95%; margin-bottom: 3%;">
                <span><b>INSTRUCTIONS </b></span>
                <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px; padding-bottom: 10px;" />

            </div>


            <div id="Instructions" class="instruction_toggle HREWhite" style="margin: auto; width: 95%; margin-bottom: 2%;">
                <div style="color: black; font-size: x-large; margin: auto; text-align: left; line-height: normal; padding: 1%; height: auto !important;">

                    <p style="text-align: center; font-size: xx-large;">
                        <strong>State of Rhode Island Division of Taxation</strong>
                    </p>
                    <p style="text-align: center; margin-bottom: 3%; font-size: xx-large;">
                        <strong>Employee’s Withholding Allowance Certificate</strong>
                        <br />
                    </p>
                    <span class="Heavy">Federal Form W-4 can no longer be used for Rhode Island withholding purposes. You must complete Form RI W-4 for
                            your employer(s). Once you have completed Form RI W-4 for your employer, Form RI W-4 only needs to be completed if
                            you are making changes to your withholding allowance or have a new employer. Form RI W-4 must be completed each
                            year if you claim “EXEMPT” or “EXEMPT-MS” on line 3 below.<br />
                        <br />

                    </span>
                    <span class="Heavy">If you have more than one job or your spouse works, you should figure the total number of allowances you are entitled
                            to claim. Your withholding usually will be more accurate if you claim all of your allowances on the Form RI W-4 for the
                            highest-paying job and claim zero on all of your other RI W-4 forms. You may reduce the number of allowances or
                            request that your employer withhold an additional amount from your pay, which may help avoid having too little tax
                            withheld. Also, keep in mind that if your annual wages exceed $241,850, your exemption amount will be phased out and
                            be equal to zero.<br />
                        <br />

                    </span>
                    <span>
                        <strong>Line 1: Figure your personal allowances (including allowances for dependents)
                        </strong>
                    </span>
                    
                        <table style="width: 100%; background-color: white; margin-bottom: 2%;">
                            <tbody style="font-size: 18px;">

                                <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                    <td style="width: 80%; padding-bottom: 2%;">
                                        <span style="float: left; padding-right: 2%;">
                                            <strong>A.</strong>
                                        </span>
                                        <span style="float: left; width: 80%;">No one else can claim me as a dependent. If yes, enter “1” on line 1A
                                        </span>
                                    </td>
                                    <td style="width: 20%; padding-bottom: 2%;">
                                        <span style="float: left; padding-right: 5%;">
                                            <strong>1A.</strong>
                                        </span>
                                        <span style="float: left; width: 80%;">
                                            <asp:TextBox ID="txtBox1A" runat="server" Style="border-bottom: 1px solid;"  />
                                        </span>
                                    </td>
                                </tr>
                                <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                    <td style="width: 80%; padding-bottom: 20px;">
                                        <span style="float: left; padding-right: 2%;">
                                            <strong>B.</strong>
                                        </span>
                                        <span style="float: left; width: 80%;">I can claim my spouse as a dependent. If yes, enter “1” on line 1B
                                        </span>
                                    </td>
                                    <td style="width: 20%;">
                                        <span style="float: left; padding-right: 5%;">
                                            <strong>1B.</strong>
                                        </span>
                                        <span style="float: left; width: 80%;">
                                            <asp:TextBox ID="txtBox1B" runat="server" Style="border-bottom: 1px solid;" />

                                        </span>
                                    </td>
                                </tr>
                                <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                    <td style="width: 80%; padding-bottom: 20px;">
                                        <span style="float: left; padding-right: 2%;">
                                            <strong>C.</strong>
                                        </span>
                                        <span style="float: left; width: 80%;">Enter the number of dependents (other than you or your spouse) you will claim on your tax return
                                        </span>
                                    </td>
                                    <td style="width: 20%;">
                                        <span style="float: left; padding-right: 5%;">
                                            <strong>1C.</strong>
                                        </span>
                                        <span style="float: left; width: 80%;">
                                            <asp:TextBox ID="txtTotalDependents" runat="server" Style="border-bottom: 1px solid;" />
                                        </span>
                                    </td>
                                </tr>
                                <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                    <td style="width: 80%; padding-bottom: 20px; margin-right: 10%;">
                                        <span style="float: left; padding-right: 2%;">
                                            <strong>D.</strong>
                                        </span>
                                        <span style="float: left; width: 80%;">Enter any additional allowances (review carefully to avoid underwithholding)
                                        </span>
                                    </td>
                                    <td style="width: 20%;">
                                        <span style="float: left; padding-right: 5%;">
                                            <strong>1D.</strong>
                                        </span>
                                        <span style="float: left; width: 80%;">
                                            <asp:TextBox ID="txtBox1D" runat="server" Style="border-bottom: 1px solid;" />
                                        </span>
                                    </td>
                                </tr>
                                <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
                                    <td style="width: 80%;">
                                        <span style="float: left; padding-right: 2%;">
                                            <strong>E.</strong>
                                        </span>
                                        <span style="float: left; width: 80%;">Add lines A, B, C and D and enter here. However, if line E is more than 10, enter 10.
                                        This is the total number of personal allowances to which you are entitled. Enter on line 1 below
                                        </span>
                                    </td>
                                    <td style="width: 20%;">
                                        <span style="float: left; padding-right: 5%;">
                                            <strong>1E.</strong>
                                        </span>
                                        <span style="float: left; width: 80%;">
                                            <asp:TextBox ID="txtBox1E" runat="server" Style="border-bottom: 1px solid;"/>
                                            <br />
                                        </span>
                                    </td>
                                </tr>

                            </tbody>
                        </table>
                    
                    <span style="margin-bottom: 2%;">
                        <strong>Line 2: Additional withholding amounts<br />
                        </strong>
                        If you want additional withholding taken out of your pay, enter that dollar amount which is to be withheld
                        <strong>each pay period</strong> on line
                        2 below.<br />
                        <br />
                    </span>
                    <span>
                        <strong>Line 3: Exempt Taxpayer
                            <br />
                            <br />
                        </strong>
                    </span>
                    
                        <span style="width:100%;">
                        <strong>Exempt Status #1<br />
                        </strong>
                        If you meet both of the conditions below, you may claim exemption from Rhode Island withholding for 2022:<br />
                        <span style="padding-left: 2%; padding-right: 20%; float: left;">a) Last year I had a right to a refund of all Rhode Island income tax withheld because I had <strong>no</strong>
                            tax liability <strong>AND<br />
                            </strong>
                            b) This year I expect a refund of all Rhode Island income tax because I expect to have <strong>no</strong> tax liability.<br />
                            <strong>If you meet both of the above conditions, write “EXEMPT” on line 3 below.<br />
                                <br />
                            </strong>
                        </span>
                        </span>
                        <span style="width:100%;">
                        <span>
                            <strong>Exempt Status #2<br />
                            </strong>
                        </span>
                        <span>If you are the spouse of a servicemember stationed in Rhode Island, your wages may be exempt under the Military Spouses
                        Residency Relief Act. If you meet both of the conditions below, you may claim exemption from Rhode Island withholding for
                        2022.<br />

                        </span>

                        <span style="padding-left: 2%; float: left;">a) You moved to Rhode Island solely to be with your servicemember spouse in compliance with military orders sending the servicemember
                            to Rhode Island <strong>AND<br />
                            </strong>
                            b) You have the same non-Rhode Island domicile as your servicemember spouse.<br />
                            <strong>If you meet both of the above conditions, write “EXEMPT-MS” on line 3 below.<br />
                                <br />
                            </strong>
                        </span>
                        </span>
                    <p>
                        &nbsp
                    </p>
                    
                   
                </div>
            </div>
            <table style="margin-top: 2%; margin-bottom: 2%; line-height: normal; font-size: large;">
                <tr>
                    <td style="width: 15%;"></td>
                    <td style="width: 35%;"></td>
                    <td style="width: 35%;"></td>
                    <td style="width: 15%;"></td>
                </tr>
                <tr style="border-top: 4px solid black; border-bottom: 4px solid black;">
                    <td colspan="1" style="border-right: 4px solid black; text-align: center; font-size: xx-large !important; padding-top: 2%; padding-bottom: 2%;">
                        <strong>RI W-4</strong>
                    </td>
                    <td colspan="2" style="text-align: center; font-size: xx-large; border-right: 4px solid black; padding-top: 2%; padding-bottom: 2%;">
                        <strong>State of Rhode Island Division of Taxation<br />
                            Employee’s Withholding Allowance Certificate
                        </strong>
                    </td>
                    <td colspan="1" style="font-size: xx-large !important; text-align: center; padding-top: 2%; padding-bottom: 2%;">
                        <strong>2022</strong>
                    </td>
                </tr>

                <tr>
                    <td colspan="2" class="HRETan" style="border-top: 4px solid black; border-right: 4px solid black; padding-left: 1%;">
                        <span>Name—Last, First, Middle Initial<br />
                            <br />
                        </span>
                        <strong>
                            <asp:Label ID="lblFullName" runat="server" /></strong>
                    </td>
                    <td rowspan="4" colspan="2" style="border-bottom: 4px solid black;">
                        <div style="padding-bottom: 1%; padding-left: 1%;">

                            <span>1. Enter the number of allowances from line 1E above
                            </span>
                            <span style="float: right;">1.&nbsp&nbsp
                            <asp:TextBox ID="txtTotalExemptions" runat="server" /></span>
                            <p>&nbsp</p>
                            <span>2. Enter any additional dollar amount which you would like
                                    <br />
                                withheld from your pay . &nbsp</span>
                            <span style="float: right;">2.&nbsp&nbsp
                            <asp:TextBox ID="txtAdditionalWithholding" runat="server" placeholder="$" /></span>

                            <p>&nbsp</p>
                            <span>3. If you meet the conditions above, write “EXEMPT” or
                                    <br />
                                “EXEMPT-MS” whichever applies .</span>
                            <span style="float: right;">3.&nbsp&nbsp
                            <asp:TextBox ID="txtExempt" runat="server" /></span>
                        </div>
                        <div class="col-md-12" style="border-top: 2px solid #000000; padding: 0px">
                            <div style="padding-left: 10px">
                                <p style="line-height: normal;">
                                    <strong>Employee:&nbsp&nbsp</strong>File this form with your employer to indicate the number of dependents or
                                    other personal exemptions to be claimed as allowances for your Rhode Island withholding.
                                    You should make a copy for your own records.
                                </p>
                                <p style="line-height: normal;">
                                    <strong>Employer:&nbsp&nbsp</strong>Keep this certificate with your payroll records. The form must be available to
                                    the Division of Taxation upon request.
                                </p>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="HRETan" style="border-top: 4px solid black; border-right: 4px solid black; padding-left: 1%;">
                        <span>Mailing Address (Number and Street including Apartment Number or P.O. Box)<br />
                            <br />
                        </span>
                        <strong>
                            <asp:Label ID="lblAddressCombined" runat="server" /></strong>
                    </td>

                </tr>
                <tr>
                    <td colspan="2" style="border-top: 4px solid black; border-right: 4px solid black; padding-left: 1%; border-bottom: 4px solid black;" class="HRETan">
                        <span style="float: left">City, Town or Post Office<br />
                            <br />
                            <strong>
                                <asp:Label ID="lblCity" runat="server" /></strong>
                        </span>
                        <span style="float: right; padding-right: 4%;">ZIP Code<br />
                            <br />
                            <strong>
                                <asp:Label ID="lblState" runat="server" /></strong>
                        </span>
                        <span style="float: right; padding-right: 6%;">State<br />
                            <br />
                            <strong>
                                <asp:Label ID="lblZip" runat="server" /></strong>
                        </span>

                    </td>

                </tr>
                <tr>
                    <td colspan="2" class="HRETan" style="border-top: 4px solid black; border-right: 4px solid black; border-bottom: 4px solid black; padding-left: 1%; border-bottom: 4px solid black;">
                        <span>Social Security Number<br />
                            <br />
                        </span>
                        <strong>
                            <asp:Label ID="lblSSN" runat="server" /></strong>
                    </td>
                </tr>

                <tr>
                    <td colspan="4" style="border-bottom: 4px solid black; text-align: center; padding:1%; vertical-align:middle;">
                        <span><strong>Under penalties of perjury, I declare that I have examined this certificate, and to the best of my knowledge and belief, it is true, correct and complete.</strong></span>
                    </td>
                </tr>
                <tr>
                    <td colspan="1" style="padding: 1%; border-bottom: 5px solid black;">

                        <div style="float: left;">
                            <span><b>Employee </b></span>
                            <br />
                            <span><b>Signature</b></span>
                        </div>
                        <div style="float: right; padding-right: 10%;">
                            <span style="font-size: 40px; vertical-align: middle;">⇨</span>

                        </div>

                    </td>
                    <td colspan="3" style="padding: 1%; vertical-align: middle; border-bottom: 5px solid black;">
                        <span style="float: left; width: 65%;">
                            <span><b>Signature</b></span>
                            <asp:TextBox ID="txtSignature" runat="server" Style="padding: 3px; width: 80%;" />
                        </span>
                        <span style="float: right; width: 30%;">
                            <span><b>Date</b></span>
                            <asp:TextBox ID="txtSignatureDate" runat="server" Style="width: 80%;" />
                        </span>

                    </td>
                </tr>

            </table>


            <div id="divFormFooter" class="row HRERewrap">
                <br />
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
        .row {
            margin: auto;
        }

        .Heavy {
            font-weight: 600;
        }

        .vertalign {
            vertical-align: middle;
            padding-top: 1.5%;
            padding-bottom: 1.5%;
        }

        .height1 {
            height: contain;
        }

        .allowancesSheet {
            width: 100%;
            height: 635px;
            padding: 50px;
            border: 1px solid #333;
            margin-left: -2px;
        }

        input[type="checkbox"] {
            width: 70px;
            height: 70px;
            cursor: pointer;
            background: #f0f4fa;
            display: inline-block;
            padding-left: 3px;
            padding-right: 3px;
            color: black;
        }

        input[type=text], textarea {
            outline: none;
            min-height: 20px;
            background-color: #f0f4fa;
            border: 1px solid #e0eaf7 !important;
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
            color: black !important;
        }

        li {
            color: black !important;
        }

        div {
            color: black !important;
            margin: auto !important;
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


