<%@ Page Title="Admin Add New Employee" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="Admin_EEAdd.aspx.vb" 
    Inherits="HReaseApp.Admin_EEAdd" 
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
    <div id="tabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" Runat="Server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" rel="stylesheet" />
    <style>
        .chosen-container{
            min-width: 300px !important;
            max-width:600px !important; 
            width:50% !important;
        }
    </style>
    <script type="text/javascript">
        function focuseligdate(source) {
            var a = $('input:text[id$=TextEligDateUpdated]').val();
            $('input:text[id$=txtEligibilityDate]').prop('type', 'date');
            source.value = a;
        }
        
        $(function () {
            var a = $('input:text[id$=txtNewHireDate]').focusout(foo);
            function foo() {
                var x = a.val();
                $('input:text[id$=TextDOHUpdated]').val(x);
                
                function isItIE() {
                    user_agent = navigator.userAgent;
                    var is_it_ie = user_agent.indexOf("MSIE ") > -1 || user_agent.indexOf("Trident/") > -1;
                    return is_it_ie;
                }
                if (isItIE()) {                    
                    var b = $('input:text[id$=txtNewHireDate]').val()
                    $('input:text[id$=TextEligDateUpdated]').val(b);
                    
                } else {
                    var b = $('input:text[id$=TextDOHUpdated]').val()
                    $('input:text[id$=TextEligDateUpdated]').val(b);
                    
                }
                
                var bom = $('input:text[id$=TxtBeginOfMonthFollowing]').val();
                if (bom > 0) {
                    var plus = $('input:text[id$=TxtInitialWaitIncrement]').val();
                    var b = $('input:text[id$=TextEligDateUpdated]').val();

                    var d = new Date(b);
                    d.setDate(d.getDate() + parseFloat(plus));
                    var e = new Date(d);
                    e.setDate(e.getDate());
                    var month = e.getMonth() + 2;
                    var day = 1;
                    var year = e.getFullYear();
                    bom1 = 'Falling into True'+ bom
                    $('input:text[id$=TextBox1]').val(bom1);
                } else {
                    var plus = $('input:text[id$=TxtInitialWaitIncrement]').val();
                    var b = $('input:text[id$=TextEligDateUpdated]').val();

                    var d = new Date(b);
                    d.setDate(d.getDate() + parseFloat(plus));
                    var e = new Date(d);
                    e.setDate(e.getDate());
                    var month = e.getMonth() + 1;
                    var day = e.getDate() + 1;
                    var year = e.getFullYear();
                    $('input:text[id$=TextBox1]').val('Falling into False');
                };

                if (month < 10)
                    month = '0' + month;
                if (day < 10)
                    day = '0' + day;
                var f = month + '/' + day + '/' + year;
                $('input:text[id$=txtEligibilityDate]').val(f);
                $('input:text[id$=TextEligDateUpdated]').val(f);
            }
                   
        });
                               
        // This function will allow users to insert only numbers in the textboxes.

        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

        function isTwoDigitDecimal(evt) {
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
          var a = source.value.replace(',', '').replace('$','');
          var money = parseFloat(a,10).toFixed(2);
      
          source.value = money.toString();
        }
        $(document).ready(function () {
            $('.formattedhiredate').before(function () {
                $(this).prop('type', 'date');
                var a = $('input:text[id$=TextDOHFormatted]').val();
                $(this).val(a);
            });
        });

        $(document).ready(function () {
            $('.phone').keypress(function () {
                var e = event || evt; // for trans-browser compatibility
                var charCode = e.which || e.keyCode;

                if (charCode > 31 && (charCode < 48 || charCode > 57 || charCode == 40 || charCode == 41 || charCode == 45))
                    return false;
                else {
                    var val = $(this).val();
                    var newvalue = val.replace(/(\d{3})(\d{3})(\d{4})/, "($1) $2-$3");
                    $(this).val(newvalue);
                };
            });

        });
        function onlyPhoneCharacters(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57 || charCode == 40 || charCode == 41 || charCode == 45))
                return false;
            return true;
        }
    </script>
      
    <div class="HREwrapper">
        <div id="DivPageTitle" class="center" style="padding-top:20px;">
            <br />
            <h4><b>Employee Add</b></h4>
        </div>

        <div id="DivTopHeader" runat="server">   
            <div id="DivCompanyList" runat="server" class="well HRESlateBlue HRERewrap form-inline" style="margin-right:5%;">
                <span style="padding-left:10px; padding-right:10px; width:10%;">
                    Company:
                </span>
                <span style="min-width:300px; max-width:600px; width:50%;"> 
                    <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-control" DataValueField="CompanyId" DataTextField="CombinedCompanyName" AutoPostBack="true" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged"></asp:DropDownList>
                </span>
                <script>
                    $('#<%=ddlCompany.ClientID%>').chosen();
                </script>
                <span style="width:20%;">
                    &nbsp;&nbsp;<asp:CheckBox ID="chkActive" runat="server" Checked="true" Text="&nbsp;&nbsp;Active Companies &nbsp;&nbsp;" AutoPostBack="true" OnCheckedChanged="chkActive_CheckedChanged" Visible="true"></asp:CheckBox>
                </span>
                <br /><br />
            </div>  
            <div id="DivError" runat="server" visible="false" class="HREError">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
            </div>
            <div class="form-group" style="display:inline;">
                <div id="DivSuccess" runat="server" visible ="false" class="HRESuccess">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" ImageAlign="Left" />
                    <asp:Label ID="lblSuccess" runat="server"  Text="Form Complete" Width="50%"></asp:Label>
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
                </div>
            </div>
        </div>

        <div id="DivCompanyName" runat="server" class="well" style="text-align:center; margin-right:5%;">
            <b><asp:Label ID="lblCompanyName" runat="server" Text="CompanyName"></asp:Label></b>
            <br /><br />
        </div> 

        <div id="DivMainForm" runat="server" class="HREWhite HRErewrap" style="margin-right:5%;">            
            <div id="DivCoDefaultInfo" runat="server" style="margin-left:10px; margin-right:10px; margin-bottom:10px; border-bottom:1px solid darkgrey;" class="form-group" >
                <h4>
                    Please note the following Business Rules for 
                    <asp:Label ID="lblCompanyName1" runat="server"></asp:Label>
                </h4>
                <div style="margin-left:30px;">
                    <span style="color:steelblue;">Initial Eligibility Rule:</span>
                    <asp:Label ID="lblInitialWait" runat="server"></asp:Label>
                </div>
                <div style="margin-left:30px;">
                    <span style="color:steelblue;">Last Employee Number Used:</span>
                    <asp:Label ID="lblLastEmployeeNumberUsed" runat="server"></asp:Label>
                </div>
            </div>
            <div style="visibility:hidden;">
                TextDOHFormatted: <asp:TextBox ID="TextDOHFormatted" runat="server" Visible="true" ></asp:TextBox>
                TextDOHUpdated: <asp:TextBox ID="TextDOHUpdated" runat="server" Visible="true" ></asp:TextBox>
                TextEligDateFormated: <asp:TextBox ID="TextEligDateFormated" runat="server" Visible="true" ></asp:TextBox>
                TextEligDateUpdated: <asp:TextBox ID="TextEligDateUpdated" runat="server" Visible="true" ></asp:TextBox>
                TxtDefaultWaitPeriod:<asp:TextBox ID="TxtDefaultWaitPeriod" runat="server" Visible="true"></asp:TextBox>
                TxtInitialWaitIncrement:<asp:TextBox ID="TxtInitialWaitIncrement" runat="server" Visible="true"></asp:TextBox>
                TxtBeginOfMonthFollowing:<asp:TextBox ID="TxtBeginOfMonthFollowing" runat="server" Visible="true"></asp:TextBox>
                TextBox1:<asp:TextBox ID="TextBox1" runat="server" Visible="true" ></asp:TextBox>
                TextBox2:<asp:TextBox ID="TextBox2" runat="server" Visible="true" ></asp:TextBox>
                TextBox3:<asp:TextBox ID="TextBox3" runat="server" Visible="true" onfocus="(this.type='date')" onblur="(this.type='text')"></asp:TextBox>
                TextBox4:<asp:TextBox ID="TextBox4" runat="server" Visible="true" ></asp:TextBox>
                TextBox5:<asp:TextBox ID="TextBox5" runat="server" Visible="true" ></asp:TextBox>
            </div>
            <div class="form-group" style="margin-top:-60px;">
                <a style="color: red; text-align:center; vertical-align:middle;">*</a> Required fields
                <a style="float:right; vertical-align:middle;"><asp:Button ID="btnClearSearch" runat="server" Enabled="true" EnableViewState="true" Class="ClearSearchbtn" Text="Clear Data" autopostback="true" OnClick="btnClearSearch_Click" /></a>
                <table style="line-height:30px;" >
                    <tr>
                        <td style="width:10%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:25%;"></td>
                        <td style="width:15%;"></td>
                        <td style="width:28%;"></td>
                        <td style="width:12%;"></td>
                    </tr>
                    <tr >
                        <td colspan="1" style="text-align:right;">
                            <label for="txtEmployeeNumber">
                                <a style="color: red">*</a>Employee Number:&nbsp;
                            </label>
                        </td>
                        <td colspan="1">
                            <asp:TextBox ID="txtEENumber" runat="server" CssClass="form-control" Placeholder="Required" MaxLength="10" Visible="true" TabIndex="1" ></asp:TextBox>                    
                        </td>
                        <td colspan="4" >
                            
                        </td>
                    </tr>
                    <tr style="margin-top:10px;">
                        <td colspan="1" style="text-align:right;">
                             <label for="ddlPrefix" >
                                <a style="color: red">*</a>Name:&nbsp;
                             </label>
                        </td>
                        <td colspan="1">
                            <asp:DropDownList ID="ddlPrefix" runat="server" CssClass="selectpicker HREDDL" TabIndex="2" DataValueField="ShortDesc" DataTextField="LongDesc" ToolTip="Prefix" ></asp:DropDownList>
                        </td>
                         <td colspan="1" style="text-align:left;">
                             <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" TabIndex="3" placeholder="First" ToolTip="First Name"></asp:TextBox>
                        </td>
                         <td colspan="1">
                             <asp:TextBox ID="txtMiddleName" runat="server" CssClass="form-control" TabIndex="4" placeholder="Middle" ToolTip="Middle Name"></asp:TextBox>
                        </td>
                         <td colspan="1">
                             <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" TabIndex="5" placeholder="Last" ToolTip="Last Name"></asp:TextBox>
                        </td>
                         <td colspan="1">
                             <asp:DropDownList ID="ddlSuffix" runat="server" CssClass="selectpicker HREDDL" TabIndex="6" DataValueField="ShortDesc" DataTextField="LongDesc" ToolTip="Suffix" ></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:right;">
                            <label for="txtEmail" >
                                <a style="COLOR: red">*</a>Email:&nbsp;
                            </label>
                        </td>
                        <td colspan="2">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ToolTip="Email" Placeholder="email@domain.ext" TabIndex="7"></asp:TextBox>     
                            <asp:RegularExpressionValidator ID="valrEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorMessage="<p style='color:red; '>Please check email format.</p>" ValidationGroup="valContact" Display="Dynamic" />
                        </td>
                        <td colspan="1" style="text-align:right;">
                            <label for="txtMobilePhone">
                                Cell Phone:&nbsp;
                            </label>
                        </td>
                        <td colspan="1">
                            <asp:TextBox ID="txtMobilePhone" runat="server" CssClass="form-control phone" placeholder="Cell Phone" ToolTip="Cell Phone" TabIndex="8"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valrCellPhone" runat="server" ControlToValidate="txtMobilePhone" ValidationExpression="^(\(?\s*\d{3}\s*[\)\-\.]?\s*)?[2-9]\d{2}\s*[\-\.]\s*\d{4}$" Text="<h4>Cell phone should be US format of ten digits entered as ###-###-####.</h4>" ValidationGroup="valContact" Display="None" />
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr><td> </td></tr>
                    <tr>
                        <td colspan="1" style="text-align:right; vertical-align:top;">
                            <label for="txtHireDate" >
                                <a style="COLOR: red">*</a>
                                Hire Date:&nbsp;
                            </label>
                        </td>
                        <td colspan="2" style="padding-left:5px;">
                            <asp:TextBox ID="txtNewHireDate" runat="server" CssClass="container formattedhiredate" Width="200px" Placeholder="mm/dd/yyyy" TabIndex="9"/>
                            <asp:RequiredFieldValidator ID="valNewHireDate" runat="server" ErrorMessage="Hire Date is Required" ControlToValidate="txtNewHireDate" ValidationGroup="valDependent" Display="Dynamic" ></asp:RequiredFieldValidator>
                            <asp:RangeValidator id="RangeValidator1" ControlToValidate="txtNewHireDate" type="Date" minimumvalue="01/01/2020" MaximumValue="12/31/2999" ErrorMessage="<p style='color:red;'>The Date range should be between 1/1/2020 and today.</p>" display="Dynamic" runat="server"></asp:RangeValidator>
                        </td>

                        <td colspan="1" style="text-align:right; vertical-align:top;">
                            <label for="txtEligDate" >
                                <a style="COLOR: red">*</a>
                                Eligibility Date:&nbsp;
                            </label>
                        </td>
                        <td colspan="1" >
                            <asp:TextBox ID="txtEligibilityDate" runat="server" CssClass="container" onfocus="return focuseligdate(this)" Width="200px" Placeholder="mm/dd/yyyy" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="valEligibilityDate" runat="server" ErrorMessage="Eligibility Date is Required" ControlToValidate="txtEligibilityDate" ValidationGroup="valDependent" Display="Dynamic" ></asp:RequiredFieldValidator>
                            <asp:RangeValidator id="RangeValidator2" ControlToValidate="txtNewHireDate" type="Date" minimumvalue="01/01/2020" MaximumValue="12/31/2999" ErrorMessage="<p style='color:red;'>The Date range should be between 1/1/2020 and today.</p>" display="Dynamic" runat="server"></asp:RangeValidator>
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:right;">
                            <label for="txtSalary" >
                                <a style="COLOR: red">*</a>
                                Pay Rate:&nbsp;
                            </label>
                        </td>
                        <td colspan="2">
                            <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control text-left" Placeholder ="$.00" Visible="true" onkeypress="return currencyformat();" TabIndex="10" ></asp:TextBox>
                            <asp:RequiredFieldValidator ControlToValidate="txtSalary" ErrorMessage="<h4>Pay Rate</h4>" Text="" runat="server" Display="None" ValidationGroup="valAmt" />
                            <asp:RegularExpressionValidator ID="valPayRate" runat="server" ControlToValidate="txtSalary" ValidationExpression="^[0-9]\d*(\.\d+)?$" Style="color:red;" Text="* Pay Rate must be numeric and greater than $0.00" ErrorMessage="" ValidationGroup="valAmt" Display="Dynamic" EnableClientScript="true" />
                        </td>
                        <td colspan="1" style="text-align:right;">
                            <label for="ddlBenefitClass" >
                                <a style="COLOR: red">*</a>Benefit Class:
                            </label>
                        </td>
                        <td colspan="1">
                            <asp:DropDownList ID="ddlBenefitClass" runat="server" CssClass="form-control selectpicker HREDDL text-right col-md-5" DataValueField="ClassId" DataTextField="LongDesc" TabIndex="17" ></asp:DropDownList>
                        </td> 
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:right; vertical-align:top;">
                            <label for="ddlPayPer" >
                                <a style="color: red">*</a>
                                Pay Rate Per:&nbsp;
                            </label>
                        </td>
                        <td colspan="2">
                            <asp:DropDownList ID="ddlPayPer" runat="server" CssClass="selectpicker HREDDL" DataValueField="SalaryTypeId" DataTextField="LongDesc" TabIndex="11" ></asp:DropDownList>
                        </td>
                        <td colspan="1" style="text-align:right;">
                            <label for="ddlStatus" >
                                <a style="COLOR: red">*</a>
                                Status:&nbsp;
                            </label>
                        </td>
                        <td colspan="1">
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="selectpicker HREDDL" DataValueField="EmploymentStatusId" DataTextField="LongDesc" TabIndex="18" ></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="valrStatus" runat="server" InitialValue="Null" ErrorMessage="Employee Status must be selected" ControlToValidate="ddlStatus" ValidationGroup="valAdmin" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                        <td colspan="1">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:right;">
                            <label for="ddlPaytype" >
                                <a style="COLOR: red">*</a>
                                Pay Type:&nbsp;
                            </label>
                        </td>
                        <td colspan="2">
                            <asp:DropDownList ID="ddlPaytype" runat="server" CssClass="form-control selectpicker HREDDL text-right col-md-5" DataValueField="PayTypeId" DataTextField="LongDesc" TabIndex="12" ></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="valrPayType" runat="server" InitialValue="Null" ErrorMessage="Pay Type must be selected" ControlToValidate="ddlPaytype" ValidationGroup="valAdmin" Display="None"></asp:RequiredFieldValidator>
                        </td>
                        <td colspan="1" style="text-align:right;">
                            <label for="txtBenefitSalary" >
                                <a style="COLOR: red">*</a>Annual/Benefit Salary:
                            </label>
                        </td>
                        <td colspan="1">
                            <asp:TextBox ID="txtBenefitSalary" runat="server" CssClass="form-control text-left" Placeholder ="$.00" Visible="true" onkeypress="return currencyformat();" TabIndex="19" ></asp:TextBox>
                            <asp:RequiredFieldValidator ControlToValidate="txtBenefitSalary" ErrorMessage="Benefit Salary" Text="" runat="server" Display="None" ValidationGroup="valSalaryAmt" />
                            <asp:RegularExpressionValidator ID="valreBenefitSalary" runat="server" ControlToValidate="txtBenefitSalary" ValidationExpression="^[0-9]\d*(\.\d+)?$" Style="color:red;" Text="* Annual/Benefit Salary must be numeric and greater than $0.00" ErrorMessage="" ValidationGroup="valSalaryAmt" Display="Dynamic" EnableClientScript="true" />
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:right;">
                            <label for="ddlPayFrequency" >
                                <a style="COLOR: red">*</a>
                                Pay Frequency:&nbsp;</label>
                        </td>
                        <td colspan="2">
                            <asp:DropDownList ID="ddlPayFrequency" runat="server" CssClass="form-control selectpicker HREDDL " DataValueField="PayFrequencyId" DataTextField="LongDesc" TabIndex="13" ></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="valrPayFrequency" runat="server" InitialValue="Null" ErrorMessage="Pay Frequency must be selected" ControlToValidate="ddlPayFrequency" ValidationGroup="valAdmin" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                        <td colspan="1" style="text-align:right;">
                            <label for="ddlDeductionFrequency">
                                <a style="COLOR: red">*</a>Deduction Frequency:&nbsp;
                            </label>
                        </td>
                        <td colspan="1" >
                            <asp:DropDownList ID="ddlDeductionFrequency" runat="server" CssClass="form-control selectpicker HREDDL " DataValueField="PayFrequencyId" DataTextField="LongDesc" TabIndex="20" ></asp:DropDownList>
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:right;">
                            <label for="txtOccupation" >
                                <a style="COLOR: red">*</a>Occupation:&nbsp;
                            </label>
                        </td>
                        <td colspan="2" >
                           <asp:TextBox ID="txtOccupation" runat="server" CssClass="form-control" MaxLength="50" Visible="true" TabIndex="14" ></asp:TextBox>
                        </td>
                        <td colspan="1" style="text-align:right;">
                            <label for="txtStandardHours" >
                                Standard Hours:
                            </label>
                        </td>
                        <td colspan="1">
                            <asp:TextBox ID="txtStandardHours" runat="server" CssClass="form-control" MaxLength="62" Visible="true" TabIndex="21" ></asp:TextBox>
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>                    
                    <tr>
                        <td colspan="1" style="text-align:right;">
                            <label for="ddlDivision" >
                                Location:&nbsp;
                            </label>
                        </td>
                        <td colspan="2">
                            <asp:DropDownList ID="ddlDivision" runat="server" CssClass="selectpicker HREDDL" DataValueField="EmployeeDivisionId" DataTextField="LongDesc" TabIndex="15" ></asp:DropDownList>
                        </td>
                        <td colspan="1" style="text-align:right;">
                             <label for="ddlDepartment" >
                                Department:&nbsp;
                             </label>
                        </td>
                        <td colspan="1">
                            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="selectpicker HREDDL" DataValueField="EmployeeDepartmentId" DataTextField="LongDesc" TabIndex="22" ></asp:DropDownList>
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="1" style="text-align:right;">
                            <label for="txtManager" >
                                Manager:&nbsp;
                            </label>
                        </td>
                        <td colspan="2">
                            <asp:TextBox ID="txtManager" runat="server" CssClass="form-control" MaxLength="50" Visible="true" onblur="manager()" TabIndex="16" ></asp:TextBox> 
                        </td>
                        <td colspan="1" style="text-align:right;">
                            <label for="ddlCategory" >
                                Category:&nbsp;
                            </label>
                        </td>
                        <td colspan="1">
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="selectpicker HREDDL" DataValueField="CompanyCategoryId" DataTextField="LongDesc" TabIndex="23" ></asp:DropDownList>
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="1" >
                            <asp:CheckBox ID="chkOwner" runat="server" CssClass="checkbox-inline" Text="&nbsp;Owner" TextAlign="right" TabIndex="24" />
                        </td>
                        <td colspan="1" style="float:right;">
                            <asp:CheckBox ID="chkTest" runat="server" CssClass="checkbox-inline" Text="&nbsp;Test Person" TextAlign="right" TabIndex="25" />
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                        <td colspan="2" class="center">
                            <asp:CheckBox ID="chkOnboarding" runat="server" CssClass="checkbox-inline" Text="&nbsp;In Onboarding" TextAlign="right" TabIndex="26" />
                        </td>
                    </tr>
                </table>


            <div class="form-group">
                <%--<asp:ImageButton ID="mbtnRegistrationAcknowledge" ImageUrl="../img/GreenAcknowledgeBtn.png" runat="server" OnMouseOver="src='/img/GreenAcknowledgeOver.png';" OnMouseOut="src='/img/GreenAcknowledgeBtn.png';" Width="125px"></asp:ImageButton>--%>

                <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5  pull-right">
                    <%--<asp:ImageButton ID="btnCancel" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" ImageAlign="Right" TabIndex="0" OnClick="btnCancel_Click" />--%>
                    
                    <asp:ImageButton ID="btnAdmin" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="26" ValidationGroup="valAdmin" OnClick="btnAdminSave_Click" />
                </div>
            </div>

            <%--<input  type="button" value="Fire Validation" name="foo" onclick="Page_ClientValidate();alert('Valid: '+Page_IsValid);return false;" />--%>

            <%--<div id="DivHRE" runat="server">
                UserId in Session: &nbsp; <asp:Label ID="lblUserId" runat="server"></asp:Label><br />
                CompanyId in Session:&nbsp;<asp:Label ID="lblCompanyId" runat="server" /> <br />
                EmployeeId in Session:&nbsp;<asp:Label ID="lblEmployeeId" runat="server" />             
            </div>--%>
       </div>             

    </div>
   </div>
    <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; text-align:left; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }
        .HREDate {padding-left: 10px; }
        table {background-color:white; line-height:20px; }
        
        .HREGrey {background-color:#f0f4fa;}
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
        .HREDDL {background-color:#f0f4fa;}
        .ClearSearchbtn {border: none;
              color: white;
              background-color: #8CC85A;
              padding: 3px 3px;
              width: 100px;
              height: 40px;
              font-weight:700;
              font-size:medium;
              vertical-align:middle;
              margin:0px 1px 1px 1px;
        }
    </style>
</asp:Content>
