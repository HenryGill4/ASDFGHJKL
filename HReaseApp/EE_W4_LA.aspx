<%@ Page Title="KY State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_LA.aspx.vb" 
    Inherits="HReaseApp.EE_W4_LA" 
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
    </script>
    <style>
        .success-label {
            color: #000;
            background-color: #398439;
            background-color: #dff0d8;
            display: block;
            padding: 5px;
            text-align: center;
        }

        span.number {
            padding-right: 6px;
            padding-left: 6px;
        }

        .table-bordered > thead > tr > th, .table-bordered > tbody > tr > th, .table-bordered > tfoot > tr > th, .table-bordered > thead > tr > td, .table-bordered > tbody > tr > td, .table-bordered > tfoot > tr > td {
            border: 2px solid;
        }

        span.line {
            padding-left: 16px;
            padding-right: 20px;
        }

        .note {
            margin-left: 78px;
        }

        label {
            font-weight: normal;
        }



        input[type=text], textarea {
            outline: none;
            border: none;
            min-height: 25px;
        }

        input[type="checkbox"] {
            width: 16px;
            height: 16px;
            cursor: pointer;
        }

        input[type=checkbox] + label {
            margin: 0.2em;
            cursor: pointer;
            padding: 0.2em;
        }

        input[type=checkbox] {
            display: none;
        }

            input[type=checkbox] + label:before {
                content: "X";
                border: 0.1em solid #000;
                border-radius: 0.2em;
                width: 1em;
                height: 1em;
                padding: 0px 4px;
                vertical-align: bottom;
                color: transparent;
                transition: .500ms;
                margin-left: 3px;
                font-weight: 600;
            }

            input[type=checkbox]:checked + label:before {
                color: #000;
                content: "X"
            }

            p.label {
                color: #7e8998;
                font-size: 14px;
                margin: 5px 0px;
            }

         .wrapper {
               width:100%;
		        margin:0 auto;
		        overflow:hidden;
                padding:20px;
            }

        .row {
            margin: 0px;
        }

        .input_color {
            background-color: #EFF3FB;
            border: 1px solid #aeb3bd !important;
        }
    </style>

    <div class="HREwrapper">
        <div class="form-group" style="height:100px;">       
            <div style="float:left;">
            <br />
            <h4><asp:Label ID="lblEmployeeName" runat="server"></asp:Label></h4> 
            </div>
            <div id="divError" class="form-group alert alert-danger text-center text-danger divError" runat="server" visible="false">
                <div style="font-size:large; text-align:center;">
                    <asp:Image ID="Image1" ImageUrl="../img/RedX.png" runat="server" style="width:90px" border="none" /> 
                    <br/>
                    <h4>ERROR:
                    <asp:Label ID="lblError" runat="server" Text="There was an error.<br/>"></asp:Label></h4>
                </div>
            </div>
            <div id="divSuccess" runat="server" class="col-md-12 text-center"  visible ="false">
                <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" cssclass=" img" />
                <h3><br /><b><span style="color: green">
                <asp:Label ID="lblSuccess" runat="server" Text="Louisianna State Tax Form Complete.<br/>"></asp:Label>
                </span></b></h3>
            </div>
                <%-- next arrow full screen --%>
            <div style="float:right; padding-right:10%;">
                    <div class="fixed hidden-xs">
                        <asp:ImageButton ID="imgNext" runat="server" ImageUrl="../img/NextArrowInCircleBlueGreen.png" Width="50%" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click"/>
                    </div>
                </div>
                <%-- next arrow mobile screen --%>
                <div class="col-xs-3 col-sm-3 hidden-lg hidden-md pull-right right" style="padding-right:30%;">
                    <asp:ImageButton ID="imgNextMobile" runat="server" ImageUrl="../img/NextArrowInCircleBlueGreen.png" Width="150px" Height="150px" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                </div>
        </div>

        <div class="row well" style="margin-top: 20px;">
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px" />
        </div>

        <div class="row well instruction_toggle">
            <div class="col-md-12">
                <b>Purpose:</b> Complete form L-4 so that your employer can withhold the correct amount of state income tax from your salary.
                <br />  <br />
                <b> Instructions: </b>
                    Employees who are subject to state withholding should complete the personal allowances worksheet indicating the number of withholding
                    personal exemptions in Block A and the number of dependency credits in Block B.
                <br /> <br />
                <ul list-style-type: disc;>
                         <li>
                             Employees must file a new withholding exemption certificate within 10 days if the number of their exemptions decreases, except if the change is the result
                            of the death of a spouse or a dependent.
                         </li>
                          <li>
                               Employees may file a new certificate any time the number of their exemptions increases.
                         </li>
                         <li>
                            Line 8 should be used to increase or decrease the tax withheld for each pay period. Decreases should be indicated as a negative amount.
                         </li>
                      </ul>              
                     <br />
                         Penalties will be imposed for willfully supplying false information or willful failure to supply information that would reduce the withholding exemption.
                      <br />
                        This form must be filed with your employer. If an employee fails to complete this withholding exemption certificate, the employer must withhold Louisiana
                         income tax from the employee’s wages without exemption.
                     <br /> <br />
                     <b>Note to Employer:</b> Keep this certificate with your records. If you believe that an employee has improperly claimed too many exemptions or dependency credits, please
                        forward a copy of the employee’s signed L-4 form with an explanation as to why you believe that the employee improperly completed this form and any other supporting documentation.
                        The information should be sent to the Louisiana Department of Revenue, Criminal Investigations Division, PO Box 2389, Baton Rouge, LA 70821-2389.
                    <br />
                <p style="height:5px; border-bottom:3px solid; height: 5px; border-bottom: 3px solid; padding: 10px 0px 15px 0px;">
                    &nbsp;
                </p>
          </div>
          <div class="col-md-10">
                <b>Block A</b> <br />

                <ul list-style-type: disc;>
                    <li>Enter “0” to claim neither yourself nor your spouse, and check “No exemptions or dependents claimed” under number 3 below.
                        You may enter “0” if you are married, and have a working spouse or more than one job to avoid having too little tax withheld.</li>
                    <li>Enter “1” to claim yourself, and check “Single” under number 3 below. if you did not claim this exemption in connection with other
                        employment, or if your spouse has not claimed your exemption. Enter “1” to claim one personal exemption if you will file as head
                        of household, and check “Single” under number 3 below.</li>
                    <li>Enter “2” to claim yourself and your spouse, and check “Married” under number 3 below.</li>
                </ul>
            </div>

            <div class="col-md-2">
                <div style="margin-top:30px;">
                <b>A.</b> &nbsp; <asp:TextBox ID="txtBlockATextBox1" runat="server" Style="width: 85%; max-height: 50px; height: 50px;" placeholder="" TextMode="MultiLine"  CssClass="input_color"></asp:TextBox>
                </div>
            </div>

            <div class="col-md-10">
                <b>Block B</b> <br />
                <ul list-style-type: disc;>
                    <li>
                        Enter the number of dependents, not including yourself or your spouse, whom you will claim on your tax return. If no dependents are claimed, enter “0.”
                    </li>
               </ul>
            </div>
            <div class="col-md-2">
                <div>
                    <b>B.</b> &nbsp; <asp:TextBox ID="txtBlockBTextBox1" runat="server" Style="width: 85%; max-height: 50px; height: 50px;" placeholder="" TextMode="MultiLine"  CssClass="input_color"></asp:TextBox>
                </div>
            </div>
        </div>

        <div class="row" style="padding:10px 0px;">
            <table style="width:100%; table-layout:fixed;">
                <tbody>
                    <tr>
                        <td colspan="6" rowspan="2" style="padding: 10px;border: 1px solid;">
                            <img src="/images/LouisiannaDeptOfRevLogo.png" style="width: 100%;"/>
                        </td>
                        <td colspan="12" style="padding: 18px; color: white; background: black; border: 1px solid black; font-size: 16px; "> 
                            <b> Employee Withholding Exemption Certificate (L-4) </b>
                        </td>
                        <td colspan="12"> 
                        </td>
                    </tr>
                    <tr>
                        <td colspan="12" style="padding: 0px 20px; font-size: 14px; border: 1px solid;"> 
                            Louisiana Department of Revenue 
                        </td>
                        <td colspan="13"> 
                            &nbsp;
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="row">
            <table style="width: 100%;">
               <tr style="width: 100%;border-top: 1px solid; border-bottom:1px solid;">
                    <td style="width: 15%;border-right: 1px solid;padding-top: 20px;">
                        <div> 
                             <span>
                                Form
                              </span>
							 <span style="font-size: 28px; line-height: 2px; font-weight: bold;"> L-4 </span>
                             <br/>
                             <div style="font-size: 13px;line-height: 15px;padding-top: 5px;">
                             Louisiana <br/>
                             Department of <br/>
                             Revenue <br/>
                             </div>
                        </div>
                    </td>
                    <td style="width: 70%;">
                        <div class="header" style="text-align: center;">
                            <h2 style="font-size: 23px;line-height: 2px;font-weight: bold;padding-top: 30px;"> 
                                Employee’s Withholding Allowance Certificate </h2>
                        </div>
                    </td>
                    <td style="width: 15%;"> &nbsp; </td>
                </tr>
            </table>
        </div>
      
        <div class="row">
            <table class="table-bordered" style="width:100%; table-layout:fixed;">
                <tr>
                    <td colspan="5">
                    </td>
                     <td colspan="25">
                    </td>
                </tr>
                <tr>
                    <td colspan="15">
                        <p class="label">
                            1. Type or print first name and middle initial
                        </p>
                         <b><asp:Label ID="lblFName" runat="server" Style=" width: 87%;" ></asp:Label></b>
                    </td>
                     <td colspan="15">
                          <p class="label"> 
                              Last name 
                          </p>
                         <b><asp:Label ID="lblLName" runat="server" Style=" width: 87%;" ></asp:Label></b>
                    </td>
                </tr>
                <tr>
                    <td colspan="15">
                          <p class="label">
                           2. Social Security Number
                          </p>
                        <b><asp:Label ID="lblSSNumber" runat="server" style="text-align: right; width: 87%;"></asp:Label></b>
                    </td>
                     <td colspan="15">
                          <p class="label">
                          3. Select one
                          </p>
                         <div>
                            <asp:CheckBox ID="ChkNoExp" runat="server" Text="&nbsp; No exemptions or dependents claimed" TextAlign="right" Style="font-weight: normal;" />

                            <asp:CheckBox ID="ChkSingle" runat="server" Text="&nbsp; Single" TextAlign="right" AutoPostBack="true" OnCheckedChanged="ChkSingle_CheckedChanged" Style="font-weight: normal;" />

                            <asp:CheckBox ID="ChkMarried" runat="server" Text="&nbsp; Married" TextAlign="right" AutoPostBack="true" OnCheckedChanged="ChkMarried_CheckedChanged" Style="font-weight: normal;" />
                         </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="30">
                          <p class="label">
                             4. Home address (number and street or rural route)
                          </p>
                        <b><asp:Label ID="lblAddressCombined" runat="server" Style="width: 95%; max-height: 50px; height: 50px;"></asp:Label></b>
                    </td>
                </tr>
                 <tr>
                    <td colspan="17">
                         <p class="label">
                            5. City
                         </p>
                        <b><asp:Label ID="lblCity" runat="server"  Style="width: 85%; display: block;" ></asp:Label></b>
                    </td>
                       <td colspan="6">
                            <p class="label">
                           State
                                </p>
                           <b><asp:Label ID="lblState" MaxLength="2" runat="server"  Style=" width: 90%; float: right; margin-right: 2%;"> </asp:Label></b>
                    </td>
                       <td colspan="7">
                            <p class="label">
                           ZIP
                           </p>
                           <b><asp:Label ID="lblZipCode" runat="server"  Style=" width: 75%; display: block;"></asp:Label></b>
                    </td>
                </tr>
                <tr>
                    <td colspan="23">
                         <p class="label">
                             6. Total number of exemptions claimed in Block A
                             </p>
                    </td>
                       <td colspan="7">
                            <p class="label">
                                6. 
                             </p>
                           <asp:TextBox ID="txtTotalExemptions" runat="server" placeholder="" Style="width: 85%; display: block;" CssClass="input_color"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="23">
                         <p class="label">
                             7. Total number of dependents claimed in Block B
                             </p>
                    </td>
                       <td colspan="7">
                          <p class="label">
                             7. 
                          </p>

                            <asp:TextBox ID="txtNumberOfDependents" runat="server" placeholder="" Style="width: 85%; display: block;" CssClass="input_color"></asp:TextBox>
                    </td>
                </tr>

                 <tr>
                    <td colspan="23">
                         <p class="label">
                             8. Increase or decrease in the amount to be withheld each pay period. Decreases should be indicated as a negative amount.
                             </p>
                    </td>
                       <td colspan="7">
                            <p class="label">
                                8. 
                             </p>
                           
                            <asp:TextBox ID="txtAdditionalWithholding" runat="server" placeholder="" Style="width: 85%; display: block;" CssClass="input_color"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <td colspan="30">
                         <p class="label">
                            I declare under the penalties imposed for filing false reports that the number of exemptions and dependency credits claimed on this certificate do not exceed
                            the number to which I am entitled.
                         </p>
                    </td>
                </tr>
                 <tr>
                    <td colspan="23">
                         <p class="label">
                             Employee’s signature
                         </p>
                        <asp:TextBox ID="txtSignature" runat="server" placeholder="Signature" Style="width: 85%; display: block;" CssClass="input_color"></asp:TextBox>
                    </td>
                       <td colspan="7">
                          <p class="label">
                             Date
                          </p>
                           <asp:TextBox ID="SignatureDate" CssClass="datepicker" Style="width: 85%; display: block;" runat="server"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <td colspan="30" style="text-align:center;">
                       <b>
                           The following is to be completed by employer.
                       </b> 
                    </td>
                </tr>
                 <tr>
                    <td colspan="15">
                    <p class="label">
                         9. Employer’s name and address
                    </p>
                    <b><asp:Label ID="lblEmployerFullAddress" runat="server" Style="width: 85%; max-height: 50px; height: 50px;" placeholder="" TextMode="MultiLine" Rows="2"></asp:Label></b>
                    </td>
                    <td colspan="15">
                         <p class="label">
                               10. Employer’s state withholding account number
                         </p>
                           <b><asp:Label ID="lblEmployerAC" runat="server" Style="width: 85%;"></asp:Label></b>
                    </td>
                </tr>
            </table>
        </div>
        <div class="row">
            <div class="clearfix">&nbsp;</div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" OnClick="btnSave_Click" />
            </div>
            <div class="clearfix">&nbsp;</div>
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

        var objNumberandDigit = ".0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz";
        var objWholeNumber = "-0123456789,.";
        var objCharacter = "ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz";

        function isRule(oComp, sRule, nLength, fdecimal) {
            if (fdecimal == "" || typeof (fdecimal) == "undefined") { fdecimal = false; }

            //If the object is not specified return false
            if (typeof (oComp) == 'undefined' || oComp == null || oComp == '') {
                alert('Error: Input object not specified.');
                return false;
            }
            //If neither rule nor max length is specified, return false
            else if (typeof (sRule) == 'undefined' && typeof (nLength) == 'undefined') {
                alert('Error: No rule/maximum length for input object specified.');
                return false;
            }

            var noErrorFlg = true;

            //If object is specified and either of rule is specified,
            if (typeof (sRule) != 'undefined' && sRule != null) {
                var temp;
                sRule = sRule + "";
                var discardChars = false;
                if (sRule.length > 0 && sRule.charAt(0) == "~") { sRule = sRule.substring(1); discardChars = true; }

                if (typeof (oComp) == "undefined" || typeof (sRule) == "undefined") { return false; }

                for (var i = 0; i < oComp.value.length; i++) {
                    temp = oComp.value.charAt(i);

                    if ((!discardChars && sRule.indexOf(temp) == -1) || (discardChars && sRule.indexOf(temp) >= 0)) {
                        //alert("Field disobeys entry rule.  Following are the valid characters:\n" + sRule);
                        //alert("Invalid Character!");
                        oComp.value = oComp.value.substring(0, i);// + (oComp.value.length > i ? oComp.value.substring(i+1):"");
                        noErrorFlg = false;
                        break;
                    }
                }
            }

            if (nLength) {
                if (fdecimal) {
                    nLength -= fdecimal;
                    var dp = oComp.value.indexOf(".");
                    var p1;
                    var p2 = "";
                    if (dp >= 0) { p1 = oComp.value.substring(0, dp); p2 = oComp.value.substring(dp + 1); }
                    else { p1 = oComp.value; }

                    if (p1.length > nLength) {
                        oComp.value = oComp.value.substring(0, nLength);
                        return noErrorFlg;
                    }
                    for (var i = 0; i < p2.length; i++) {
                        var ch = p2.charAt(i);
                        if (ch < '0' || ch > '9') { oComp.value = p1 + "." + p2.substring(0, i); return noErrorFlg; }
                    }
                    if (p2.length > fdecimal) { oComp.value = p1 + "." + p2.substring(0, fdecimal); }
                } else if (oComp.value.length > nLength) {
                    oComp.value = oComp.value.substring(0, nLength);
                }
            }
            return noErrorFlg;
        }


        
    </script>
    <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
    </style>
</asp:Content>
