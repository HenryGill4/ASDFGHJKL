<%@ Page Title="Relationship Page for Deps Bens and Emergency Contacts"
    Language="vb"
    AutoEventWireup="false"
    MasterPageFile="~/AppMasterHeader.Master"
    CodeBehind="EE_DepBen.aspx.vb"
    Inherits="HReaseApp.EE_DepBen"
    EnableEventValidation="false"
    MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" runat="Server">
    <div id="tabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>
    </div>
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" runat="server">
    <script>
        $(document).ready(function () {
            $('.formattedbirthdate').before(function () {
                $(this).prop('type', 'date');
                var a = $('input:text[id$=TxtDOBFormatted]').val();
                $(this).val(a);
            });
        });
        function ValidateDateFormat(input, keyCode) {
            var dateString = input.value;
            if (keyCode == 16) {
                isShift = false;
            }
            //var regex = /(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$/;
            var regex = /^(0[1-9]|1[0-2])\/(0[1-9]|1\d|2\d|3[01])\/(19|20)\d{2}$/;

            //Check whether valid MM/dd/yyyy Date Format.
            if (regex.test(dateString) || dateString.length == 0) {
                ShowHideError(input, "none");
            }
            if (regex.test(dateString) || dateString.length == 0) {
                ShowHideError(input, "none");
            }
            else {
                ShowHideError(input, "block");
            }
        };

        function ShowHideError(textbox, display) {
            var row = textbox.parentNode.parentNode;
            var errorMsg = row.getElementsByTagName("span")[0];
            if (errorMsg != null) {
                errorMsg.style.display = display;
            }
        };
        function goBack() {
            window.history.back()
        }
        $(document).ready(function () {
            $('.SSN').blur(function () {
                var val = $(this).val();
                var newvalue = val.replace(/(\d{3})(\d{2})(\d{4})/, "$1-$2-$3");
                $(this).val(newvalue);
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

        function addressSameAsEE(checkbox) {
            if (checkbox.checked) {
                var a = $('input:text[id$=TextEEAddress1]').val();
                var b = $('input:text[id$=TextEEAddress2]').val();
                var c = $('input:text[id$=TextEECity]').val();
                var e = $('input:text[id$=TextEEZip]').val();
                var f = $('input:text[id$=TextEEZipExt]').val();

                $('input:text[id$=txtAddress1]').val(a);
                $('input:text[id$=txtAddress2]').val(b);
                $('input:text[id$=txtCity]').val(c);
                $('input:text[id$=txtZip]').val(e);
                $('input:text[id$=txtZipExt]').val(f);
            }
            else {
                var h = "";

                $('input:text[id$=txtAddress1]').val(h);
                $('input:text[id$=txtAddress2]').val(h);
                $('input:text[id$=txtCity]').val(h);
                $('input:text[id$=txtZip]').val(h);
                $('input:text[id$=txtZipExt]').val(h);
            }
        }
    </script>

    <div class="HREwrapper">
        <div id="DivPageTitle" class="center" style="padding-top: 20px;">
            <br />
            <h4><b>Relationships</b></h4>
        </div>

        <div id="DivNextButton" runat="server" class="responsive-text-center" style="float: right; display: inline; margin-top: -7px;">
            <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
            <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
        </div>

        <div id="DivTopHeader" runat="server">
            <div id="DivError" runat="server" visible="false" class="HREError">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server"></asp:Label>
            </div>
            <div id="DivMainArticalTitleandText" runat="server" class="well HRESlateBlue HRERewrap form-inline" style="padding: 10px 10px 10px 10px;">
                <div id="DivTitle" runat="server">
                    <h4>
                        <asp:Label ID="lblMainArticleTitle" runat="server" Text=""></asp:Label></h4>
                </div>
                <div id="DivText" runat="server" class="form-group HREWhite" style="border: none; width: 100%;">
                    <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
                </div>
            </div>
        </div>

        <div id="DivDependentReview" runat="server" class="HREWhite" style="border: none; margin-right: 5%;">
            <div id="DivActiveCheckbox" class="form-group">
                <div class="col-xs-5 col-sm-5 col-md-2 pull-right checkbox">
                    <asp:CheckBox ID="chkActivesOnly" runat="server" Text="&nbsp;&nbsp;Actives Only" TextAlign="right" Checked="true" AutoPostBack="true" />
                </div>
            </div>

            <div id="DivDepBenGrid" class="form-group">
                <div>
                    <asp:GridView ID="grdDepBen" runat="server"
                        DataKeyNames="DepBenId"
                        AutoGenerateColumns="False" Width="100%"
                        HorizontalAlign="Center"
                        GridLines="None" BorderColor="#3276B1"
                        CellPadding="4"
                        EmptyDataText="No Dependent/Beneficiaries were found."
                        AlternatingRowStyle-CssClass="grdNormalAltrow"
                        OnSelectedIndexChanged="OnSelectedIndexChanged">

                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                        <Columns>
                            <asp:BoundField HeaderText="DepId" DataField="DepBenId" Visible="false"></asp:BoundField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <span class="glyphicon glyphicon-edit"></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Name" DataField="DependentName"></asp:BoundField>
                            <asp:BoundField HeaderText="Type" DataField="DepBenType"></asp:BoundField>
                            <asp:BoundField HeaderText="Relationship" DataField="RelationshipType"></asp:BoundField>
                            <asp:BoundField HeaderText="SSN" DataField="SSN" ItemStyle-Wrap="False"></asp:BoundField>
                            <asp:BoundField HeaderText="Date of Birth" DataField="DOB"></asp:BoundField>
                        </Columns>
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Center" />
                    </asp:GridView>
                    <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
                </div>
            </div>

            <div id="DivSelectOrAdd" class="form-group">
                <div class="col-xs-10 col-sm-10 col-md-10 center">
                    <asp:Label ID="lblHightlight1" CssClass="text-success" runat="server" Visible="false"></asp:Label>
                </div>
                <div class="margin-right col-xs-2 col-sm-2 col-md-2 pull-right">
                    <asp:ImageButton ID="btnAddDependent" runat="server" CssClass="left" ImageUrl="img/BlueAddBtnNew.png" OnMouseOver="src='/img/BlueAddBtnOver2.png';" OnMouseOut="src='/img/BlueAddBtnNew.png';" ImageAlign="AbsMiddle" />
                </div>
            </div>
        </div>

        <asp:Panel ID="pnlEditDepBen" runat="server" DefaultButton="btnSaveDep">
            <div id="DivDependentEdit" runat="server" class="HREWhite" style="margin-right: 5%;">
                <div id="DivCheckActive" class="form-group ">
                    <div style="float: left;"><span style="color: red;">*</span>Required Fields</div>
                    <div style="float: right;">
                        <asp:CheckBox ID="chkActive" runat="server" Text="&nbsp;&nbsp;Active" TextAlign="right" Checked="true" AutoPostBack="true" />
                    </div>
                </div>

                <div id="DepTypeandRelationship" class=" form-group">
                    <label for="ddlDependentType" class="col-xs-4 col-sm-2 col-md-3 col-lg-1 control-label">
                        <a style="color: red;">*</a>
                        Type:</label>
                    <div class="col-xs-8 col-sm-10 col-md-9 col-lg-5" style="margin-bottom: 3px;">
                        <asp:DropDownList ID="ddlDependentType" runat="server" CssClass="form-control selectpicker" DataValueField="DepBenTypeId" DataTextField="LongDesc" AutoPostBack="true" OnSelectedIndexChanged="ddlDependentType_SelectedIndexChanged" TabIndex="1"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="valreDepType" runat="server" InitialValue="Null" ErrorMessage="<p style='color:red;'>Relationship Type must be selected</p>" ControlToValidate="ddlDependentType" ValidationGroup="valAdmin" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <label for="ddlRelationship" class="col-xs-4 col-sm-2 col-md-3 col-lg-2 control-label">
                        <a style="color: red;">*</a>
                        Relationship:</label>
                    <div class="col-xs-8 col-sm-10 col-md-9 col-lg-4" style="margin-bottom: 3px;">
                        <asp:DropDownList ID="ddlRelationship" runat="server" CssClass="form-control selectpicker " DataValueField="RelationshipId" DataTextField="LongDesc" AutoPostBack="true" OnSelectedIndexChanged="ddlRelationship_SelectedIndexChanged" TabIndex="2"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="valreddlRelationship" runat="server" InitialValue="Null" ErrorMessage="<p style='color:red;'>Deduction Frequency must be selected</p>" ControlToValidate="ddlRelationship" ValidationGroup="valAdmin" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>

                <div id="Name" runat="server" class="form-group">
                    <label for="ddlPrefix" class="col-xs-4 col-sm-2 col-md-3 col-lg-1 control-label">
                        &nbsp;&nbsp;&nbsp;Prefix:</label>
                    <div class="col-xs-8 col-sm-10 col-md-9 col-lg-1" style="justify-items: left; margin-bottom: 3px;">
                        <asp:DropDownList ID="ddlPrefix" runat="server" CssClass="selectpicker" DataValueField="ShortDesc" DataTextField="LongDesc" ToolTip="Prefix" TabIndex="3"></asp:DropDownList>
                    </div>
                    <label for="txtFirstName" class="col-xs-4 col-sm-2 col-md-2 col-lg-1 control-label">
                        <a style="color: red;">*</a>
                        First:</label>
                    <div class="col-xs-8 col-sm-2 col-md-2 col-lg-2" style="margin-bottom: 3px;">
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" ToolTip="First Name" TabIndex="4"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="txtFirstName" ErrorMessage="<p style='color:red;'>First Name is required</p>" Text="" runat="server" Display="Dynamic" ValidationGroup="valContact" />
                    </div>
                    <label for="txtMiddleName" class="col-xs-4 col-sm-2 col-md-2 col-lg-1 control-label">
                        &nbsp;&nbsp;&nbsp;Middle:</label>
                    <div class="col-xs-8 col-sm-2 col-md-2 col-lg-1" style="margin-bottom: 3px;">
                        <asp:TextBox ID="txtMiddleName" runat="server" CssClass="form-control" ToolTip="Middle Name" TabIndex="5"></asp:TextBox>
                    </div>
                    <label for="txtLastName" class="col-xs-4 col-sm-2 col-md-2 col-lg-1 control-label">
                        <a style="color: red;">*</a>
                        Last:</label>
                    <div class="col-xs-8 col-sm-2 col-md-2 col-lg-2" style="margin-bottom: 3px;">
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" ToolTip="Last Name" TabIndex="6"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="txtLastName" ErrorMessage="<p style='color:red;'>Last Name is required</p>" Text="" runat="server" Display="Dynamic" ValidationGroup="valContact" />
                    </div>
                    <label for="ddlSuffix" class="col-xs-4 col-sm-2 col-md-3 col-lg-1 control-label">
                        &nbsp;&nbsp;&nbsp;Suffix:</label>
                    <div class="col-xs-8 col-sm-10 col-md-9 col-lg-1" style="margin-bottom: 3px;">
                        <asp:DropDownList ID="ddlSuffix" runat="server" CssClass="selectpicker" DataValueField="ShortDesc" DataTextField="ShortDesc" ToolTip="Suffix" TabIndex="7"></asp:DropDownList>
                    </div>
                </div>

                <div id="DepRequiredInfo" runat="server" class="form-group">
                    <label for="txtSSN" class="col-xs-4 col-sm-2 col-md-3 col-lg-1 control-label">
                        &nbsp;&nbsp;&nbsp;SSN:</label>
                    <div class="col-xs-8 col-sm-10 col-md-9 col-lg-2" style="margin-bottom: 3px;">
                        <asp:TextBox ID="txtSSN" runat="server" MaxLength="11" CssClass="form-control" TabIndex="7" ToolTip=" Enter 9 digit number" Placeholder="###-##-####"></asp:TextBox>
                    </div>
                    <label for="txtDoB" class="col-xs-4 col-sm-2 col-md-3 col-lg-2 control-label ">
                        &nbsp;&nbsp;&nbsp;Birth Date:</label>
                    <div class="col-xs-8 col-sm-10 col-md-9 col-lg-2" style="margin-bottom: 3px;">
                        <asp:TextBox ID="txtDoB" runat="server" CssClass="container formattedbirthdate" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" TabIndex="8" Width="175"></asp:TextBox>
                    </div>
                    <label for="ddlGender" class="col-xs-4 col-sm-2 col-md-3 col-lg-2 control-label ">
                        &nbsp;&nbsp;&nbsp;Gender:</label>
                    <div class="col-xs-8 col-sm-10 col-md-9 col-lg-2" style="margin-bottom: 3px;">
                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control" TabIndex="9" DataValueField="GenderId" DataTextField="LongDesc" ToolTip="Gender"></asp:DropDownList>
                    </div>
                </div>
                <div style="visibility: hidden;">
                    <asp:TextBox ID="txtDOBDateFormat" runat="server" Visible="true"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="chkTobacco" class="col-xs-3 col-sm-2 col-md-1 col-lg-2 control-label">
                        &nbsp;
                    </label>
                    <div class="col-xs-7 col-sm-10 col-md-1 col-lg-2">
                        <asp:CheckBox ID="chkTobacco" runat="server" Width="200px" Text="&nbsp;&nbsp;Tobacco User" />
                    </div>
                    <label for="chkStudent" class="col-xs-3 col-sm-2 col-md-2 col-lg-2 control-label">
                        &nbsp;
                    </label>
                    <div class="col-xs-7 col-sm-10 col-md-2 col-lg-2">
                        <asp:CheckBox ID="chkStudent" runat="server" Text="&nbsp;&nbsp;Student" />
                    </div>
                    <label for="chkDisabled" class="col-xs-3 col-sm-2 col-md-2 col-lg-2 control-label">
                        &nbsp;
                    </label>
                    <div class="col-xs-7 col-sm-10 col-md-2 col-lg-2">
                        <asp:CheckBox ID="chkDisabled" runat="server" Text="&nbsp;&nbsp;Disabled" />
                    </div>
                </div>
                <div style="visibility: hidden;">
                    TxtDOBFormatted:
                    <asp:TextBox ID="TxtDOBFormatted" runat="server" Visible="true"></asp:TextBox>
                </div>
                <div id="Address" runat="server" class="form-group">
                    <div class="form-group">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                            <asp:CheckBox ID="chkSameAsEmp" runat="server" Text="&nbsp;&nbsp;Same Address as Employee" onclick="addressSameAsEE(this)" TabIndex="14"></asp:CheckBox>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="txtAddress1" class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label">
                            Address:</label>
                        <div class="col-xs-8 col-sm-10 col-md-1 col-lg-1" style="margin-bottom: 3px;">
                            <asp:TextBox ID="txtAddress1" runat="server" CssClass="container" Width="510px" ToolTip="Address Line 1" TabIndex="15"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtAddress2" class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label">
                            &nbsp;</label>
                        <div class="col-xs-8 col-sm-10 col-md-1 col-lg-1" style="margin-bottom: 3px;">
                            <asp:TextBox ID="txtAddress2" runat="server" CssClass="container" Width="510px" placeholder="Line 2" ToolTip="Address Line 2" TabIndex="16"> </asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="txtCity" class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label">
                            City:</label>
                        <div class="col-xs-8 col-sm-10 col-md-1 col-lg-1" style="margin-bottom: 3px;">
                            <asp:TextBox ID="txtCity" runat="server" CssClass="container" Width="510px" placeholder="City" ToolTip="City" TabIndex="17"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ddlState" class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label">
                            State:</label>
                        <div class="col-xs-8 col-sm-10 col-md-1 col-lg-1" style="min-width: 120px; margin-bottom: 10px;">
                            <asp:DropDownList ID="ddlState" runat="server" CssClass="selectpicker" DataValueField="ShortDesc" DataTextField="ShortDesc" Width="80px" TabIndex="18"></asp:DropDownList>
                        </div>
                        <label for="txtZip" class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label">
                            ZIP:</label>
                        <div class="col-xs-2 col-sm-2 col-md-1 col-lg-1">
                            <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" MaxLength="5" Width="80px" TabIndex="19"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 col-sm-2 col-md-1 pull-left ">
                            <asp:TextBox ID="txtZipExt" runat="server" CssClass="form-control" Width="80px" TabIndex="20"></asp:TextBox>
                        </div>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtZip" ValidationExpression="\d{5}" ErrorMessage="<p style='color:red;'>Zip Code is not formatted correctly <i>(12345) </i></p>" ValidationGroup="valDependent" Display="None" />
                        <asp:RegularExpressionValidator ID="valZipext" runat="server" ControlToValidate="txtZipExt" ValidationExpression="\d{4}" ErrorMessage="<p style='color:red;'>Zip Code Ext is not formatted correctly <i>(1234) </i></p>" ValidationGroup="valDependent" Display="None" />
                    </div>
                    <div class="form-group">
                        <label for="ddlCountry" class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label">
                            Country:</label>
                        <div class="col-xs-8 col-sm-10 col-md-3 col-lg-3" style="min-width: 300px;">
                            <asp:DropDownList ID="ddlCountry" runat="server" CssClass="selectpicker" DataValueField="ShortDesc" DataTextField="LongDesc" TabIndex="21"></asp:DropDownList>
                        </div>
                    </div>
                    <div>
                        <asp:TextBox ID="TextEEAddress1" runat="server" CssClass="hidden"></asp:TextBox>
                        <asp:TextBox ID="TextEEAddress2" runat="server" CssClass="hidden"></asp:TextBox>
                        <asp:TextBox ID="TextEECity" runat="server" CssClass="hidden"></asp:TextBox>
                        <asp:DropDownList ID="ddlEEState" runat="server" CssClass="hidden"></asp:DropDownList>
                        <asp:TextBox ID="TextEEZip" runat="server" CssClass="hidden"></asp:TextBox>
                        <asp:TextBox ID="TextEEZipExt" runat="server" CssClass="hidden"></asp:TextBox>
                        <asp:DropDownList ID="ddlEECountry" runat="server" CssClass="hidden"></asp:DropDownList>
                    </div>
                </div>

                <div id="Phone" class="form-group">
                    <label for="txtPhone" class="col-xs-4 col-sm-2 col-md-1 col-lg-1 control-label">
                        Phone:</label>
                    <div class="col-xs-8 col-sm-10 col-md-1 col-lg-1 phone">
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="container phone" Width="200px" MaxLength="10" ToolTip="Phone" TabIndex="22"></asp:TextBox>
                    </div>
                </div>
                <div id="Email" class="has-success">
                    <label for="txtEmail1" class="col-xs-2 col-sm-2 col-md-1 control-label ">Email:</label>
                    <div class="col-xs-10 col-sm-10 col-md-3">
                        <div class="input-group ">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control " TabIndex="23" placeholder="email@provider.ext"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valrEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorMessage="<p style='color:red;'>Email is not formatted correctly <i>(email@provider.com)</i></p>" ValidationGroup="valDependent" />
                        </div>
                    </div>
                </div>

                <div id="SaveOrCancel" class="form-group">
                    <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                        <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" ImageAlign="AbsMiddle" />
                    </div>

                    <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                        <asp:ImageButton ID="btnSaveDep" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" ValidationGroup="valDependent" TabIndex="24" />
                    </div>
                </div>

                <div id="DivBottomComment" runat="server" class="row" visible="false">
                    <div class="col-md-12">
                        <div class="well-success">
                            <h2>
                                <asp:Label ID="lblBottomDocumentTitle" runat="server"></asp:Label>
                            </h2>
                            <asp:Label ID="lblBottomDocument" runat="server"> </asp:Label>
                        </div>
                    </div>
                </div>

            </div>
        </asp:Panel>
    </div>
    <%--  Add Employee Notes Modal--%>
    <%-- <asp:AsyncPostBackTrigger ControlID="grdEmployeeNotes" EventName="SelectedIndexChanged" />
     <asp:PostBackTrigger ControlID="mtxtNewComment" />--%>
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <div class="modal fade" id="ModalEmployeeNotes" tabindex="-1" role="dialog" aria-labelledby="myModalEmpNotes" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title text-success" id="myModalInfoLabel">
                        <asp:Label ID="mlblInfoTitle" runat="server" Text="Employee Notes"></asp:Label></h4>
                </div>
                <div class="modal-body ">
                    <div class="well ">
                        <div class="form-group">
                            <asp:Label ID="mlblInfoText1" runat="server" class="col-md-12 " Text=""></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="mlblInfoText2" runat="server" class="col-md-12 "></asp:Label>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-12 col-md-12">

                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" EnableViewState="true" UpdateMode="Conditional">
                                    <Triggers>
                                    </Triggers>
                                    <ContentTemplate>
                                        <div class="form-group">
                                            <div class="col-xs-12 col-md-2 col-lg-2 control-label">
                                                <asp:Label ID="mlblAddNew" runat="server" Visible="false" Text="Note:" />
                                                <asp:Label ID="mlblHiddenNoteId" runat="server" Visible="false" />
                                            </div>
                                            <div class="col-xs-12 col-md-10 col-lg-10">
                                                <asp:TextBox ID="mtxtNewComment" runat="server" CssClass="form-control" TabIndex="-1" placeholder="Additional Comment" TextMode="MultiLine" Width="90%" Height="15%" MaxLength="5000" Visible="false"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group">

                                            <div class="col-xs-4 col-sm-4 col-md-2 pull-right">

                                                <asp:ImageButton ID="mbtnAdd" ImageAlign="right" ImageUrl="../img/BlueAddBtnNew.png" runat="server" OnMouseOver="src='/img/BlueAddBtnOver2.png';" OnMouseOut="src='/img/BlueAddBtnNew.png';" CausesValidation="False" TabIndex="-1" />

                                                <asp:ImageButton ID="mbtnSave" ImageAlign="right" ImageUrl="../img/GreenSaveBtn.png" runat="server" OnMouseOver="src='/img/GreenSaveBtnOver.png';" OnMouseOut="src='/img/GreenSaveBtn.png';" CausesValidation="False" Visible="false" TabIndex="-1" />
                                            </div>
                                        </div>

                                        <asp:GridView ID="grdEmployeeNotes"
                                            runat="server"
                                            DataKeyNames="EmployeeNoteId, EmployeeId" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                                            GridLines="None" BorderColor="#3276B1"
                                            CellPadding="4"
                                            EmptyDataText="No Notes for Employee found."
                                            AlternatingRowStyle-CssClass="grdNormalAltrow"
                                            EnableViewState="true">

                                            <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                            <Columns>
                                                <asp:BoundField HeaderText="EmployeeNoteId" DataField="EmployeeNoteId" Visible="False" />
                                                <asp:BoundField HeaderText="EmployeeId " DataField="EmployeeId" Visible="False" />
                                                <asp:BoundField HeaderText="Comment" DataField="Note" ItemStyle-Width="70%" Visible="True" />
                                                <asp:BoundField HeaderText="Admin" DataField="AdminName" Visible="True" ItemStyle-Width="20%" />
                                                <asp:BoundField HeaderText="Date" DataField="CreateDate" Visible="True" />
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="ButtonEdit" runat="server" CssClass="btn-primary" Text="Edit" OnClick="ButtonEdit_Click" CausesValidation="false" TabIndex="-1" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>

                                            <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                            <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                                        </asp:GridView>
                                        <asp:LinkButton ID="LinkButton2" runat="server"></asp:LinkButton>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="mlblInfoText3" runat="server" class="col-md-12"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:ImageButton ID="mbtnClose" data-dismiss="modal" ImageUrl="../img/GreenCloseBtn.png" runat="server" OnMouseOver="src='/img/GreenCloseBtnOver.png';" OnMouseOut="src='/img/GreenCloseBtn.png';" TabIndex="-1"></asp:ImageButton>
                </div>
            </div>
        </div>
    </div>

    <style>
        input[type=text], textarea {
            outline: none;
            min-height: 25px;
            background-color: #f0f4fa;
            border: 1px solid #e0eaf7 !important;
        }

        input[type="checkbox"] {
            width: 16px;
            height: 16px;
            cursor: pointer;
            background: #f0f4fa;
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
            padding: 10px 10px 10px 10px;
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

        .HRERewrap {
            margin-right: 5%;
        }

        .HREpadR10 {
            padding-right: 20px;
            float: right;
        }

        .HRENext {
            padding: 5px 5px 5px 15px;
            float: right;
            min-width: 50px;
            max-width: 90px;
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

        .img {
            display: inline-block;
            width: auto;
            height: auto;
        }

        @media only screen and (max-width: 479px) {
            table {
                margin: 0px !important;
            }

            tr {
                font-size: 12px !important;
            }

            #DivDependentReview {
                margin: auto !important;
                padding: 0px !important;
            }

            .HREwrapper {
                width: 98% !important;
                margin: auto !important;
            }

            .margin-right {
                margin-right: 5px !important;
                padding: 0px !important;
            }
        }
    </style>
</asp:Content>


