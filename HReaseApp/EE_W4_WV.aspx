<%@ Page Title="WV State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_WV.aspx.vb" 
    Inherits="HReaseApp.EE_W4_WV" 
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
        function onlyZeroOrOne(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode == 48 || charCode == 49)
                return true;
            return false;

        }

        function onlyZeroOneOrTwo(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode == 48 || charCode == 49 || charCode == 50)
                return true;
            return false;

        }

        //
        // This function is to calculate all the values of textboxes.
        //

        $(function () {
            var textBox1 = $('input:text[id$=txtIfSingle]').keyup(foo);
            var textBox2 = $('input:text[id$=txtIfMarriedABC]').keyup(foo);
            var textBox3 = $('input:text[id$=txtNumberOfDependents]').keyup(foo);

            $('input:text[id$=hdnPW]').val(document.getElementById('divWVMainForm').childNodes[1].innerHTML);

            function foo() {
                var a = textBox1.val();
                var b = textBox2.val();
                var c = textBox3.val();
                
                var sum = add(a, b, c);
                $('input:text[id$=txtTotalExemptions]').val(sum);

                //if (a = '0') {
                //    alert('getting here')
                //    var e = '0'
                //    $('input:text[id$=txtMarriedABC]').val(e);
                //}
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

   	
    <div style="width:100%; text-align:center;">
   <div class="HREwrapper" style="text-align:center; width:95%; align-self:center;" >
        <div id="PageTitle" style="width:98%; margin-left:auto; margin-right:auto;">
            <div style="text-align:center; width:100%;">
                <br />
               
                <br /><br />
            </div>
        </div>

        <div id="divTopHeader" class="form-group" style=" margin-top:-40px; margin-left:auto; margin-right:auto; width:100%;">                  
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

        

        <div id="InstructionHeaderBar" class="well HRESlateBlue HRERewrap" style="text-align:center; width:95%; margin-bottom:0px;">
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px; padding-bottom:10px;" />

        </div>

        <div id="Instructions" class="form-group instruction_toggle HREWhite" style="margin:auto; width:95%; margin-bottom:2%; ">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:justify; padding-right:5%;">
 			<p>Complete this form and present it to your employer to avoid any delay in adjusting the amount of state income tax to be 
                 withheld from your wages.</p>
            <p>If you do not complete this form, the amount of tax that is now being withheld from your pay may not be sufficient to 
                cover the total amount of tax due the state when filing your personal income tax return after the close of the year.  
                You may be subject to a penalty on tax owed the state.</p>
            <p>Individuals are permitted a maximum of one exemption for themselves, plus an additional exemption for their spouse and any 
                dependent other than their spouse that they expect to claim on their tax return.</p>
            <p><b>If you are married and both you and your spouse work and you file a joint income tax return, or if you are working two 
                or more  jobs, the revised withholding tables should result in a more accurate amount of tax being withheld.</b></p>
            <p>If you are Single, Head of Household, or Married and your spouse does not work, and you are receiving wages from only one 
                job, and you wish to have your tax withheld at a lower rate, you must check the box on line 5.</p>
            <p>When requesting withholding from pension and annuity payments you must present this completed form to the payor. 
                Enter the amount you want withheld on line 6.</p>
            <p>If you determine the amount of tax being withheld is insufficient, you may reduce the number of exemptions you are 
                claiming or request additional taxes be withheld from each payroll period. Enter the additional amount you want to have
                withheld on line 6.</p>
            </div>
        </div>
               <div style="width:95%; text-align:center; margin:auto;">

        <div id="divWVMainFormHeader" style="text-align:center; margin-bottom:2.5%;">
            <div style="margin-top:2.5%;">
                <img src="images/WV_State_Logo.jpg" />
            </div>

            <div style="font-size: 26px; font-weight: 600;">
                WEST VIRGINIA EMPLOYEE’S WITHHOLDING EXEMPTION CERTIFICATE
                <br />
                FORM WV/IT-104 
            </div>
            <div class="dashed">
                &nbsp;
            </div>'
            <div>
                <b style="font-size: 18px; font-weight: 600; float:left;">
                    WV/IT-104 
                    <br />
                    Rev. 12/20
                </b>
                <h4 style="text-align: center;">
                    <b>WEST VIRGINIA EMPLOYEEE’S WITHHOLDING EXEMPTION CERTIFICATE</b>
                </h4>
               
            </div>
        </div>
                
            <table>
                <tr>
                    <td style="width:40%;"></td>
                    <td style="width:15%;"></td>
                    <td style="width:20%;"></td>
                    <td style="width:20%;"></td>
                    <td style="width: 5%;"></td>
                </tr>
                <tr>
                    <td colspan="2" >
                        Name
                        <b><asp:Label ID="lblEmployeeName1" cssClass="underline HRETan" Width="80%" runat ="server"></asp:Label></b>
                    </td>
                    <td colspan="1"> 
                        &nbsp;
                    </td>
                    <td colspan="2" >
                        Social Security Number
                        <b><asp:Label ID="lblSSNwithDashes" cssClass="underline HRETan" Width="100%" runat="server"></asp:Label></b>
                    </td>
                    <td colspan="1"> 
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="5" >
                        Address
                        <b><asp:Label ID="lblAddress" cssClass="underline HRETan" runat="server" Style="width: 90%;"></asp:Label></b>
                    </td>
                    <td colspan="1"> 
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="1" >
                        <span style="float:left; width:100%">City
                        <strong><asp:Label ID="lblCity" cssClass="underline HRETan" runat="server" Style="width: 90%;"></asp:Label></strong>

                        </span>
                    </td>
                    <td colspan="2"> 
                        <span style="float:left; width:100%">State
                        <strong><asp:Label ID="lblState" cssClass="underline HRETan" runat="server" Style="width: 70%;"></asp:Label></strong>
                        </span>
                    </td>
                    <td colspan="2">
                        Zip Code
                        <b><asp:Label ID="lblZipCode" cssClass="underline HRETan" runat="server" Style="width: 65%;"></asp:Label></b>  
                    </td>
                    <td colspan="1"> 
                        &nbsp;
                    </td>
                </tr>
            </table>
        </>    

        
            <table style="font-size:large;">
                <tr>
                    <td style="width: 3%;">&nbsp;</td>
                    <td style="width:7%;"></td>
                    <td style="width:75%;"></td>
                    <td style="width:15%;"></td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1" style="text-align:right;">
                        1.&nbsp;&nbsp;
                    </td>
                    <td colspan="2" >
                        If SINGLE, and you claim an exemption, enter "1", if you do not, enter "0"
                    </td>
                    <td colspan="1">
                        <span style="border-bottom:4px solid black">
                        <asp:TextBox ID="txtIfSingle" runat="server" CssClass="center" onkeypress="return onlyZeroOrOne()" ></asp:TextBox>
                            </span>
                    </td>
                </tr>
                 <tr>
                    <td colspan="1" style="text-align:right; vertical-align:top;">
                        2.&nbsp;&nbsp;
                    </td>
                    <td colspan="2">
                        If MARRIED, one exemption each for husband and wife if not claimed on another certificate.
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="2" style="text-align:right;vertical-align:top;">
                        (a)&nbsp;
                    </td>
                    <td colspan="1" >
                        If you claim both of these exemptions, enter “2”
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="2" style="text-align:right;vertical-align:top;">
                        (b)&nbsp;
                    </td>
                    <td colspan="1" >
                        If you claim one of these exemptions, enter “1”
                    </td>
                    <td colspan="1" style="vertical-align:top;">
                        <span style="border-bottom:4px solid black">
                        <asp:TextBox ID="txtIfMarriedABC" runat="server" CssClass="center" onkeypress="return onlyZeroOneOrTwo()" ></asp:TextBox>
                        </span>
                    </td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="2" style="text-align:right;vertical-align:top;">
                        (c)&nbsp;
                    </td>
                    <td colspan="1" >
                        If you claim neither of these exemptions, enter “0”
                    </td>
                    <td colspan="1">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1" style="text-align:right;">
                        3.&nbsp;&nbsp;
                    </td>
                    <td colspan="2" >
                        If you claim exemptions for one or more dependents, enter the number of such exemptions
                    </td>
                    <td colspan="1">
                        <span style="border-bottom:4px solid black">
                        <asp:TextBox ID="txtNumberOfDependents" runat="server" CssClass="center" ></asp:TextBox>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1" style="text-align:right;">
                        4.&nbsp;&nbsp;
                    </td>
                    <td colspan="2" >
                        Add the number of exemptions which you have claimed above and enter the total
                    </td>
                    <td colspan="1" > 
                        <span  style="border:2px solid black; padding:1px;">
                        <asp:TextBox  ID="txtTotalExemptions"  runat="server" CssClass="center" ></asp:TextBox>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1" style="text-align:right;">
                        5.&nbsp;&nbsp;
                    </td>
                    <td colspan="2" >
                        If you are Single, Head of Household, or Married and your spouse does not work, and you are receiving
                        wages from only one job, and you wish to have your tax withheld at a lower rate, check here
                    </td>
                    <td colspan="1" style="text-align:center; vertical-align:middle;" >
                        <span >
                        <asp:CheckBox ID="chkWithheldLower" runat="server" Text="&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;"></asp:CheckBox>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr style="vertical-align:top;">
                    <td colspan="1" style="text-align:right;">
                        6.&nbsp;&nbsp;
                    </td>
                    <td colspan="2" >
                        Additional withholding per pay period under agreement with employer, enter amount here
                    </td>
                    <td colspan="1">
                        <asp:TextBox ID="txtAdditionalWithholding" Class="underline" runat="server" CssClass="center" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                   <td colspan="4" >
                        <u>Note that special withholding allowances provided on Federal Form W-4 may not be claimed on your West Virginia Form WV/IT-104 </u>
                        I CERTIFY, under penalties provided by law, that the number of exemptions claimed in this certificate is not in excess of those to which I am entitled.
                    </td>
                </tr>
                <tr style="width:100%; border-bottom:2px solid black;">
                    <td colspan="4" style="padding-bottom:2%;">
                        <span style="float:left; width:50%;">
                            Date
                            <asp:TextBox ID="txtSignatureDate" Class="underline" runat="server" Width="80%" ></asp:TextBox>
                        </span>
                   
                        <span style="float:left; width:50%;">
                            Signature
                            <asp:TextBox ID="txtSignature" Class="underline" runat="server" Width="80%" ></asp:TextBox>
                        </span>
                    </td>
                </tr>
            </table>
       
        <div id="divSave" class="row">
            <div class="clearfix">&nbsp;</div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" OnClick="btnSave_Click" />
            </div>
            <div class="clearfix">&nbsp;</div>
        </div>
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
       
        input[type=text], textarea {outline: none; min-height: 20px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 20px; height: 20px; cursor: pointer; background: #f0f4fa; display: inline-block; padding-left:3px; padding-right: 3px; color: black;}
        input[type="label"] {background-color: #f5f5f0;}
        table {background-color:white; color:black;  border-collapse:collapse;}
        p {color:black;}
        li {color:black;}
        
        
        .HREwrapper {
            margin-left: auto; margin-right: auto;
            width:75%;

        }
        .HRESlateBlue {
            background-color: #ccd5e4; 

        }
        .HREWhite {
            background-color: white; border: 1px solid grey; padding:10px; 

        }
        .HREOffWhite {
            background-color: #F9F9F9; 

        }
        .HRETan {
            background-color: #f5f5f0; padding-left:5px;

        }
        .HRELightBlue {
            background-color: #EFF3FB; 

        }
        .HRERewrap {
            margin-right: 5%; 

        }
        .HREpadR10 {
            padding-right: 20px; float:right; 

        }
        .underline {
            border-bottom: 1px solid !important; width: 100%; display: inline-block;

        }
        .HREError {
            color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;

        }
        .HRESuccess {
            color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;

        }
        .row{
            text-align:center;
        }
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

        table td{
            padding-left:0px;
        }
        table {
            background-color: white;
        }

        p {
            color: black;
        }

        li {
            color: black;
        }

        div {
            color: black;
        }

        .HREwrapper {
            text-align:center;
            width:95%;
            
        }

        .HRESlateBlue {
            background-color: #ccd5e4;
        }

        .HREWhite {
            background-color: white;
            border: 1px solid grey;
            padding: 10px;
            margin-right:0px;
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
            padding-right:10px;
        }

        .HRERewrap {
            margin: auto;
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

        .cels {
            padding-top: 5px;
            padding-left: 4px;
        
        }
        
        .HRESlateBlue {
            background-color: #ccd5e4; 

        }
        .HREWhite {
            background-color: white; border: 1px solid grey; padding:10px; 

        }
        .HREOffWhite {
            background-color: #F9F9F9; 

        }
        .HRETan {
            background-color: #f5f5f0; 

        }
        .HRELightBlue {
            background-color: #EFF3FB; 

        }
        .HRERewrap {margin-right: auto; }
        .HREpadR10 {
            padding-right: 20px; float:right; 

        }
        
    </style>
</asp:Content>

