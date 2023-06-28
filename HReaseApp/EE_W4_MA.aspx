<%@ Page Title="MA State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_MA.aspx.vb" 
    Inherits="HReaseApp.EE_W4_MA" 
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
    <script>
        // This function will allow users to insert only numbers 1 or 2 in the textboxes.
        function onlyOneOrTwo(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode == 49 || charCode == 50)
                return true;
            return false;
        }

        // This function will allow users to insert only numbers 4 or 5 in the textboxes.
        function onlyFourOrFive(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode == 52 || charCode == 53)
                return true;
            return false;
        }

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
            var textBox1 = $('input:text[id$=txtBox1]').keyup(foo);
            var textBox2 = $('input:text[id$=txtBox2]').keyup(foo);
            var textBox3 = $('input:text[id$=txtNumberOfDependents]').keyup(foo);

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
        function disableinput() {
            return false;
        }
    </script>
    
    <div class="HREwrapper">
        <div id="PageTitle">
            <div>
                <br />
                <h4><b>Massachusetts Form M-4</b></h4>
                <br /><br />
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

        <div id="InstructionTitle" class="well HRESlateBlue HRERewrap" style="text-align:center; padding-bottom:20px;">
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px;" />
            <br />
        </div>

        <div id="Instructions" class="instruction_toggle" style="margin-right:5%; font-size: large; padding:10px 10px 10px 10px;">        
            <div class="col-md-12" style="text-align:center; font-size:x-large;">
                <br/><br/>
                <b>THE COMMONWEALTH OF MASSACHUSETTS, DEPARTMENT OF REVENUE </b>
                <br/><br/>
            </div>

            <div class="col-md-6" style="padding-left:10px; padding-right:10px;">
                <p style="color:black;">
                    <b>A. Number.  </b> 
                    The more exemptions you claim on this certificate, the less tax
                    withheld from your employer. If you claim more exemptions than you are
                    entitled to, civil and criminal penalties may be imposed. However, you may
                    claim a smaller number of exemptions without penalty. If you do not file a
                    certificate, your employer must withhold on the basis of no exemptions.
                </p>
                <p style="color:black;">
                    If you expect to owe more income tax than will be withheld, you may either
                    claim a smaller number of exemptions or enter into an agreement with your
                    employer to have additional amounts withheld.
                </p>
                <p style="color:black;">
                    You should claim the total number of exemptions to which you are entitled to
                    prevent excessive overwithholding, unless you have a significant amount of
                    other income. Underwithholding may result in owing additional taxes to the
                    Commonwealth at the end of the year.
                </p>
                <p style="color:black;">
                    If you work for more than one employer at the same time, you must not claim
                    any exemptions with employers other than your principal employer.
                </p>
                <p style="color:black;">
                    If you are married and if your spouse is subject to withholding, each may
                    claim a personal exemption.
                </p>
                <p style="color:black;">
                    <b>B. Changes.  </b> 
                        You may file a new certificate at any time if the number of
                        exemptions increases. You must file a new certificate within 10 days if the
                        number of exemptions previously claimed by you decreases. For example,
                        if during the year your dependent son’s income indicates that you will not
                </p>
            </div>

            <div class="col-md-6" style="padding-left:10px; padding-right:10px;">
                <p style="color:black;">
                    provide over half of his support for the year, you must file a new certificate.
                </p>
                <p style="color:black;">
                    <b>C. Spouse.  </b> 
                    If your spouse is not working or if she or he is working but not
                    claiming the personal exemption or the age 65 or over exemption, generally you may claim those exemptions in line 2. However, if you are planning to
                    file separate annual tax returns, you should not claim withholding exemptions for your spouse or for any dependents that will not be claimed on your
                    annual tax return.
                </p>
                <p style="color:black;">
                    If claiming a spouse, write “4” in line 2. Entering “4” makes a withholding system adjustment for the $4,400 exemption for a spouse.
                </p>
                <p style="color:black;">
                    <b>D. Dependent(s).  </b> 
                    You may claim an exemption in line 3 for each individual
                    who qualifies as a dependent under the Federal Income Tax Law. In addition,
                    if one or more of your dependents will be under age 12 at year end, add “1”
                    to your dependents total for line 3.
                </p>
                <p style="color:black;">
                    You are not allowed to claim “federal withholding deductions and adjustments” under the Massachusetts withholding system.
                </p>
                <p style="color:black;">
                    If you have income not subject to withholding, you are urged to have additional amounts withheld to cover your tax liability on such income. See line
                    5.
                </p>
            </div>
            
            <div class="col-md-12" style="border-bottom:2px solid black; margin-bottom:20px;">
                <br/>
            </div>

        </div>

        <div id="MainForm" class="row" style="font-size:large; margin-left:.2%; margin-right:5%; border:1px solid black; padding:10px 10px 10px 10px;">
            <div id="MainFormHeader">
                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 nowrap">
                    <h4>
                        <b>FORM
						<br />
                        M-4
                        </b>
                    </h4>
                </div>
                <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9" style="text-align:center; font-size: x-large;">
                    <b>MASSACHUSETTS EMPLOYEE’S WITHHOLDING EXEMPTION CERTIFICATE</b>
                </div>
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2" style="float:right;">
                        <b style="vertical-align:top;">Rev. 11/19</b>
                        <img src="/images/MassDeptOfRevLogo.png" width="110"/>
                </div>

            </div>
                         
            <div id="NameAndAddress">
                <div class="col-md-12" style="display:inline-block;">
                    <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" style="text-align:left;">
                        Print full name
                    </div >
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-pull-1" style="width:450px; ">
                        <b><asp:Label ID="lblFullName" runat="server" CssClass="HRETan underline" padding="10 10 10 10"/></b>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-2 col-lg-pull-1" style="text-align:left;width:185px;">
                        Social Security no.
                    </div >
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-pull-1" style="width:450px;">
                        <b><asp:Label ID="lblSSNumber" runat="server" CssClass="HRETan underline nowrap" /></b>
                    </div>
                </div>
                <div class="col-md-12" style="margin-top:5px;">&nbsp;</div>
                <div class="col-md-12" style="display:inline-block;">
                    <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" style="text-align:left; margin-right:40px;">
                        Print home address
                    </div >
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-pull-1" style="width:410px;">
                        <b><asp:Label ID="lblHomeAddress" runat="server" CssClass="HRETan underline"/></b>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-2 col-lg-pull-1" style="text-align:left; width:50px;">
                        City
                    </div >
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-pull-1" style="width:410px;">
                        <b><asp:Label ID="lblCity" runat="server" CssClass="HRETan underline"/></b>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-2 col-lg-pull-1" style="text-align:left; width:50px;">
                        State
                    </div >
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-pull-1" style="width:150px;">
                        <b><asp:Label ID="lblState" runat="server" CssClass="HRETan underline"/></b>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-2 col-lg-pull-1" style="text-align:left; width:50px;">
                        Zip
                    </div >
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-pull-1" style="width:160px;">
                        <b><asp:Label ID="lblZipCode" runat="server" CssClass="HRETan underline"/></b>
                    </div>
                </div>
            </div>

            <div>&nbsp;</div>

            <div class="row">
                <table style="width: 100%;">
                    
                </table>
            </div>

            <div>&nbsp;</div>

            <div id="divMAMainForm">
                <table style="width: 100%; background-color:white; border-top: 4px solid; border-bottom: 4px solid;" >
                    <tr style="width: 100%">
                        <td class="" style="border-right: 4px solid; width:23%; vertical-align:top;">
                            <div class="col-md-12" style="padding-left: 0px;">
                                <span style="font-weight: bold; font-size:x-large;">
                                    Employee:</span><br />
                                <span style="text-align: justify;">
                                    File this form with your employer. Other wise, Massachusetts Income Taxes will be
                                    withheld from your wages without exemptions.
                                </span>
                                <br /><br />
                                <span style="font-weight: bold; font-size:x-large;">
                                    Employer:</span><br />
                                <span style="text-align: justify;">
                                    Keep this certificate with your
                                    records. If the em ployee is
                                    believed to have claimed
                                    excessive exemp tions, the
                                    Massachusetts De partment
                                    of Revenue should be so
                                    advised.
                                </span>
                            </div>
                        </td>
                        <td style="width:100%;">
                           <div id="divPW">
                                <div  class="col-md-12" style="width:100%; text-align:center; font-size:x-large; margin-top:10px; margin-bottom: 10px;">
                                   <b>HOW TO CLAIM YOUR WITHHOLDING EXEMPTIONS</b>
                                </div>
                                <table>
                                   <tr>
                                       <td style="width:3%;"></td>
                                       <td style="width:87%;"></td>
                                       <td style="width:7%;"></td>
                                       <td style="width:3%;"></td>
                                   </tr>
                                   <tr>
                                       <td colspan="1" style="vertical-align:top;">
                                           1.
                                       </td>
                                       <td colspan="1" style="vertical-align:top; min-width:200px;">
                                           Your personal exemption. Write the figure “1.” If you are age 65 or over or will be before next year, write “2”
                                       </td>
                                       <td colspan="1" class="underline" style="vertical-align:bottom; margin-bottom:7px; width:90%;" >
                                           <asp:TextBox ID="txtBox1" runat="server" onkeypress="return onlyOneOrTwo();" MaxLength="1" CssClass="center" Width="100%"></asp:TextBox>
                                       </td>
                                       <td colspan="1" >
                                           &nbsp;
                                       </td>
                                   </tr>
                                   <tr>
                                       <td colspan="1" style="vertical-align:top;">
                                           2.
                                       </td>
                                       <td colspan="1" style="vertical-align:top; min-width:200px;">
                                           If married and if exemption for spouse is allowed, write the figure “4.” If your spouse is age 65 or over or will
                                            be before next year and if otherwise qualified, write “5.” See Instruction C.
                                       </td>
                                       <td colspan="1" class="underline" style="vertical-align:bottom; margin-bottom:7px; width:90%;" >
                                           <asp:TextBox ID="txtBox2" runat="server" onkeypress="return onlyFourOrFive();" MaxLength="1" CssClass="center" Width="100%"></asp:TextBox>
                                       </td>
                                       <td colspan="1" >
                                           &nbsp;
                                       </td>
                                   </tr>
                                   <tr>
                                       <td colspan="1" style="vertical-align:top;">
                                           3.
                                       </td>
                                       <td colspan="1" style="vertical-align:top; min-width:200px;">
                                           Write the number of your qualified dependents. See Instruction D.
                                       </td>
                                       <td colspan="1" class="underline" style="vertical-align:bottom; margin-bottom:7px; width:90%;" >
                                           <asp:TextBox ID="txtNumberOfDependents" runat="server" onkeypress="return onlyNumbers();" CssClass="center" Width="100%"></asp:TextBox>
                                       </td>
                                       <td colspan="1" >
                                           &nbsp;
                                       </td>
                                   </tr>
                                   <tr>
                                       <td colspan="1" style="vertical-align:top;">
                                           4.
                                       </td>
                                       <td colspan="1" style="vertical-align:top; min-width:200px;">
                                           Add the number of exemptions which you have claimed above and write the total.
                                       </td>
                                       <td colspan="1" style="vertical-align:bottom; margin-bottom:7px; width:90%;" >
                                           <asp:TextBox ID="txtTotalExemptions" runat="server" CssClass="center" Width="90%" Backcolor="#E0E0E0" onkeypress="return disableinput()"></asp:TextBox>
                                       </td>
                                       <td colspan="1" >
                                           &nbsp;
                                       </td>
                                   </tr>
                                   <tr>
                                       <td colspan="1" style="vertical-align:top;">
                                           5.
                                       </td>
                                       <td colspan="2" style="vertical-align:top; margin-bottom:7px;">
                                           Additional withholding per pay period under agreement with employer $
                                           <asp:TextBox ID="txtAdditionalWithholding" runat="server" onkeypress="return onlyNumbers()" onfocusout="return isDecimal(evt)" onblur="makeMoney(this)"></asp:TextBox>
                                       </td>
                                       <td colspan="1" >
                                           &nbsp;
                                       </td>
                                   </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td style="width:3%;"></td>
                                        <td style="width:3%;"></td>
                                        <td style="width:3%;"></td>
                                        <td style="width:30%;"></td>
                                        <td style="width:3%;"></td>
                                        <td style="width:3%;"></td>
                                        <td style="width:55%;"></td>

                                    </tr>
                                    <tr>
                                        <td colspan="2" style="text-align:right; vertical-align:top;">
                                            A.
                                        </td>
                                        <td colspan="1" style="text-align:center; vertical-align:top;">
                                            <asp:CheckBox ID="chkA" runat="server" Style="margin-left: 5px; width:70%;" />
                                        </td>
                                        <td colspan="4" style="text-align:left; vertical-align:top;">
                                            Check if you will file as head of household on your tax return.
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="text-align:right; vertical-align:top;">
                                            B.
                                        </td>
                                        <td colspan="1" style="text-align:center; vertical-align:top;">
                                            <asp:CheckBox ID="chkB" runat="server" Style="margin-left: 5px; width:70%;" />
                                        </td>
                                        <td colspan="1" style="text-align:left; vertical-align:top;">
                                            Check if you are blind.
                                        </td>
                                        <td colspan="1" style="text-align:right; vertical-align:top;">
                                            C.
                                        </td>
                                        <td colspan="1" style="text-align:center; vertical-align:top;">
                                            <asp:CheckBox ID="chkC" runat="server" Style="margin-left: 5px; width:70%;" />
                                        </td>
                                        <td colspan="1" style="text-align:left; vertical-align:top;">
                                            Check if spouse is blind and not subject to withholding.
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="text-align:right; vertical-align:top;">
                                            D.
                                        </td>
                                        <td colspan="1" style="text-align:center; vertical-align:top;">
                                            <asp:CheckBox ID="chkD" runat="server" Style="margin-left: 5px; width:70%;" />
                                        </td>
                                        <td colspan="4" style="text-align:left; vertical-align:top;">
                                            Check if you are a full-time student engaged in seasonal, part-time or temporary employment whose estimated annual income
                                            will not exceed $8,000.
                                        </td>
                                    </tr>
                                </table> 
                                <div style="font-weight: bold; font-size: 15px; text-align:center; width:90%;">
                                    EMPLOYER: DO NOT withhold if Box D is checked
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>      
            </div>

            <div class="col-md-12" style="font-size:large; text-align:left;">
                I certify that the number of withholding exemptions claimed on this certificate does not exceed the number to which I am entitled.
            </div>
            <div>&nbsp;</div>
            <div class="col-md-12" style="display:inline-block;">
                <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" style="text-align:left;">
                    Date
                </div>
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-pull-1" style="width:450px; ">
                     <asp:TextBox ID="SignatureDate" runat="server" ></asp:TextBox>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-2 col-lg-pull-2" style="text-align:left;width:185px;">
                    Signed
                </div>
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-pull-2">
                    <asp:TextBox ID="txtSignature" runat="server" Width="500"></asp:TextBox>
                </div>
            </div>
            <div>&nbsp;</div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center; font-size: x-large;">
                    <b>THIS FORM MAY BE REPRODUCED</b>
                </div>
            <div>&nbsp;</div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" OnClick="btnSave_Click" />
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
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }
        table {background-color:white;}
        .underline {border-bottom: 1px dashed !important; width: 100%; display: inline-block; padding-left: 5px;}
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
    </style>
           
</asp:Content>
