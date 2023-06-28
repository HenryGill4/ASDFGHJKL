<%@ Page Title="EE Profile for both EEs and Administrators"
    Language="vb"
    AutoEventWireup="false"
    MasterPageFile="~/AppMasterHeader.Master"
    CodeBehind="EE_Profile.aspx.vb"
    Inherits="HReaseApp.EE_Profile"
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
    <script type="text/javascript">
        $(document).ready(function () {
            $('.formattedbirthdate').before(function () {
                $(this).prop('type', 'date');
                var a = $('input:text[id$=TxtDOBFormatted]').val();
                $(this).val(a);
            });
        });
        $(document).ready(function () {
            $('.formattedhiredate').before(function () {
                $(this).prop('type', 'date');
                var a = $('input:text[id$=TxtHireDateFormatted]').val();
                $(this).val(a);
            });
        });
        $(document).ready(function () {
            $('.formattedrehiredate').before(function () {
                $(this).prop('type', 'date');
                var a = $('input:text[id$=TxtReHireDateFormatted]').val();
                $(this).val(a);
            });
        });
        $(document).ready(function () {
            $('.formattedeligdate').before(function () {
                $(this).prop('type', 'date');
                var a = $('input:text[id$=TxtEligDateFormatted]').val();
                $(this).val(a);
            });
        });
        $(document).ready(function () {
            $('.formattedrehireeligdate').before(function () {
                $(this).prop('type', 'date');
                var a = $('input:text[id$=TxtRehireEligDateFormatted]').val();
                $(this).val(a);
            });
        });
        $(document).ready(function () {
            $('.formattedbenefitclassdate').before(function () {
                $(this).prop('type', 'date');
                var a = $('input:text[id$=TxtBenefitClassEffDateFormatted]').val();
                $(this).val(a);
            });
        });
        $(document).ready(function () {
            $('.formattedtermdate').before(function () {
                $(this).prop('type', 'date');
                var a = $('input:text[id$=TxtTermDateFormatted]').val();
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
        function onlyNumbers(evt) {
            var e = event || evt; // for trans-browser compatibility
            var charCode = e.which || e.keyCode;

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

    </script>
    <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>Employee Profile</b></h4>
            </div>

            <div id="divEEImage" runat="server" style="float: left; margin-right: 50px;">
                <asp:ImageButton ID="imgEmployee" runat="server" Width="100px" alt="" class="img-rounded" ImageUrl="images/default_person.jpg" ToolTip="Click to Update" OnClick="imgEmployee_Click" />
                <br />
                <label style="font-size: small;">click picture to update</label>
            </div>
            <div id="divUpdatePic" runat="server" class="well HRELightBlue HRERewrap" style="margin-top: 50px; width: 50%;">
                <h4>Update Profile Picture:</h4>
                <br />
                <asp:FileUpload ID="fuLoadPic" runat="server" Width="70%" CssClass="text-success" ViewStateMode="Enabled" />
                <asp:ImageButton ID="btnCancelPic" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" ImageAlign="Right" OnClick="btnCancelPic_Click" />
                &nbsp;&nbsp;
                <asp:ImageButton ID="btnSavePic" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" OnClick="btnSavePic_Click" /><br />
                <asp:Label ID="lblFileUpload" runat="server" Text="" class=" text-danger" Visible="false"></asp:Label>
                <br />
                <br />
            </div>
            <br />
        </div>

        <div id="divTopHeader" class="form-group">
            <div id="divError" runat="server" visible="false" style="vertical-align: middle; display: inline;">
                <h3><b><span style="color: red;">
                    <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" border="none" Width="50px" />
                    &nbsp;&nbsp;
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
                </span></b></h3>
            </div>
            <div id="divSuccess" runat="server" visible="false" style="vertical-align: middle; display: inline; padding-left: 50px;">
                <div style="float: left;" class="mobile-hide">
                    <asp:Image ID="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" />
                </div>
                <div id="divSuccessLabel" class="mobile-hide" style="text-align: center; color: green; font-size: x-large;">
                    <b>
                        <asp:Label ID="lblSuccess" runat="server" Text="Form Complete"></asp:Label></b>
                </div>
                <div id="divNextButton" style="float: right; margin-top: -3%;">
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" Width="50%" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" />
                </div>
            </div>
        </div>

        <div id="divMainArticalTitleandText" class="well HRERewrap">
            <div id="divTitle" runat="server" class="form-group HRESlateBlue">
                <h4>
                    <asp:Label ID="lblMainArticleTitle" runat="server" Text=""></asp:Label></h4>
            </div>
            <div id="divText" runat="server" class="form-group HREWhite">
                <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div>

        <%----Contact Review------%>
        <div id="divContactReview" class="well HRETan HRERewrap" runat="server">
            <div class="form-group">
                <div class="col-xs-12 col-sm-12 col-md-10 left">
                    <h4>Contact Information:</h4>
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
                    <span class=" control-label"><b>Name and Address</b></span><br />
                    <asp:Label ID="lblFullName" runat="server" class="control-label"></asp:Label><br />
                    <asp:Label ID="lblAddress" runat="server" class="control-label"></asp:Label>
                    <asp:Label ID="lblAddress2" runat="server" class=" control-label"></asp:Label><br />
                    <asp:Label ID="lblCity" runat="server" class=" control-label"></asp:Label>&nbsp<asp:Label ID="lblState" runat="server" class=" control-label"></asp:Label>
                    <asp:Label ID="lblZip" runat="server" class="control-label"></asp:Label>
                    &nbsp
                <asp:Label ID="lblZipExtension" runat="server" class=" control-label"></asp:Label><br />
                    <asp:Label ID="lblCountry" runat="server" class=" control-label"></asp:Label><br />
                    <br />
                </div>

                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
                    <span class=" control-label"><b>Phone</b></span><br />
                    <asp:Label ID="lblHomePhone" runat="server" class="control-label"></asp:Label><br />
                    <asp:Label ID="lblWorkPhone" runat="server" class="control-label"></asp:Label><br />
                    <asp:Label ID="lblMobilePhone" runat="server" class=" control-label"></asp:Label><br />
                    <span class="small text-success">*  Primary Phone</span><br />
                    <br />
                </div>


                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
                    <span class=" control-label"><b>Email</b></span><br />
                    <asp:Label ID="lblEmail1" runat="server" class="control-label"></asp:Label><br />
                    <asp:Label ID="lblEmail2" runat="server" class="control-label"></asp:Label><br />
                    <span class="text-success">*  Primary Email</span>
                </div>

                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4 right">
                    <asp:ImageButton ID="btnEditContact" runat="server" ImageUrl="img/GreenEditBtnNew.png" OnMouseOver="src='/img/GreenEditBtnOverNew.png';" OnMouseOut="src='/img/GreenEditBtnNew.png';" ImageAlign="AbsMiddle" />
                </div>
            </div>
        </div>

        <%----Contact Edit------%>
        <asp:Panel ID="pnlEditContact" runat="server" DefaultButton="btnSaveContact">
            <div id="divContactEdit" class="well HREWhite HRERewrap" runat="server">
                <div class="form-group">
                    <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2 pull-left">
                        <p class="form-control-static text-success ">
                            <a style="color: red; font-weight: bold;">*</a>
                            Required fields
                        </p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="ddlPrefix" class="col-xs-3 col-sm-2 col-md-1 col-lg-1 control-label">
                        Prefix:</label>
                    <div class="col-xs-9 col-sm-2 col-md-1 col-lg-1">
                        <asp:DropDownList ID="ddlPrefix" runat="server" CssClass="selectpicker" TabIndex="5" DataValueField="ShortDesc" DataTextField="LongDesc" ToolTip="Prefix" Style="width: auto;"></asp:DropDownList>
                    </div>

                    <div class="col-xs-3 col-sm-2 col-md-1 col-lg-1"></div>
                    <div class="col-xs-9 col-sm-10 col-md-2 col-lg-pull-1">
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" TabIndex="6" placeholder="First" ToolTip="First Name"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="txtFirstName" ErrorMessage="<p style='color:red;'>First Name</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                    </div>
                    <div class="col-xs-3 col-sm-2  col-md-1 col-lg-1"></div>
                    <div class="col-xs-9 col-sm-10 col-md-2 col-lg-pull-2">
                        <asp:TextBox ID="txtMiddleName" runat="server" CssClass="form-control" TabIndex="7" placeholder="Middle" ToolTip="Middle Name"></asp:TextBox>
                    </div>

                    <div class="col-xs-3 col-sm-2 col-md-1 col-lg-1"></div>
                    <div class="col-xs-9 col-sm-8 col-md-2 col-lg-pull-3">
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" TabIndex="8" placeholder="Last" ToolTip="Last Name"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="txtLastName" ErrorMessage="<p style='color:red;'>Last Name</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                    </div>
                    <div class="col-xs-3 col-sm-2 col-md-1 col-lg-1"></div>
                    <div class="col-xs-9 col-sm-2 col-md-1 col-lg-pull-3 right">
                        <asp:DropDownList ID="ddlSuffix" runat="server" CssClass="selectpicker" TabIndex="9" DataValueField="ShortDesc" DataTextField="LongDesc" ToolTip="Suffix"></asp:DropDownList>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-2">
                        <br />
                    </div>
                </div>

                <div class="form-group has-success">
                    <label for="txtAddress1" class="col-xs-3 col-sm-3 col-md-1 col-lg-1">
                        <a style="color: red; margin-left: -5px; font-weight: bold;">*</a>
                        Address:</label>
                    <div class="col-xs-9 col-sm-9 col-md-5 col-lg-6">
                        <asp:TextBox ID="txtAddress1" runat="server" CssClass="form-control" TabIndex="10" placeholder="Line 1" ToolTip="Address Line 1"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="txtAddress1" ErrorMessage="<p style='color:red;'>Address Line 1</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-xs-3 col-sm-3 col-md-1 col-lg-1 ">
                    </div>
                    <div class="col-xs-9 col-sm-9 col-md-5 col-lg-6">
                        <asp:TextBox ID="txtAddress2" runat="server" CssClass="form-control" TabIndex="11" placeholder="Line 2" ToolTip="Address Line 2"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group has-success">
                    <label for="txtCity" class="col-xs-3 col-md-1  control-label  "><a style="color: red; font-weight: bold;">*</a>City:</label>
                    <div class="col-xs-8 col-sm-9 col-md-5 col-lg-6">
                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" TabIndex="12" placeholder="City"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="txtCity" ErrorMessage="<p style='color:red;'>City</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                    </div>
                </div>

                <div class="form-group has-success">
                    <label for="ddlState" class="col-xs-3 col-sm-2 col-md-1 control-label"><a style="color: red; font-weight: bold;">*</a>State:</label>
                    <div class="col-xs-8 col-sm-9 col-md-5 col-lg-6">
                        <asp:DropDownList ID="ddlState" runat="server" CssClass="selectpicker" TabIndex="13" DataValueField="ShortDesc" DataTextField="ShortDesc" Width="80px"></asp:DropDownList>
                    </div>
                </div>
                <div class="form-group has-success">
                    <label for="ddlCountry" class="col-xs-3 col-sm-2  col-md-1 control-label "><a style="color: red; font-weight: bold;">*</a>Country:</label>
                    <div class="col-xs-8 col-sm-9 col-md-5 col-lg-6">
                        <asp:DropDownList ID="ddlCountry" runat="server" CssClass="selectpicker" TabIndex="14" DataValueField="ShortDesc" DataTextField="ShortDesc" Width="80px"></asp:DropDownList>
                    </div>
                </div>

                <div class="form-group  ">
                    <div class="has-success">
                        <label for="txtZip" class="col-xs-3 col-md-1  control-label"><a style="color: red; font-weight: bold;">*</a>ZIP:</label>
                        <div class="col-xs-3 col-sm-3 col-md-2 col-lg-1">
                            <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" TabIndex="15" placeholder="Zip" Width="80px" MaxLength="5" onkeypress="return onlyNumbers();"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valrZip" runat="server" ControlToValidate="txtZip" ValidationExpression="^\d{5,}$" ErrorMessage="<p style='color:red; '>ZIP code must be five digits</p>" ValidationGroup="valContact" Display="Dynamic" />
                        </div>
                    </div>
                    <div class="col-xs-3 col-sm-3 col-md-2 col-lg-1 pull-left">
                        <asp:TextBox ID="txtZipExt" runat="server" CssClass="form-control" TabIndex="16" placeholder="Plus 4" Width="80px" MaxLength="4" onkeypress="return onlyNumbers();"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="valZipext" runat="server" ControlToValidate="txtZipExt" ValidationExpression="^\d{4,}$" ErrorMessage="<p style='color:red; '>ZIP code extension must be four digits</p>" ValidationGroup="valContact" Display="Dynamic" />
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-2">
                        <br />
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-xs-2 col-sm-2 col-md-1"></div>
                    <div class="col-xs-10 col-md-10 small">Click radio button to choose Primary contact number</div>

                </div>

                <div class="form-group ">
                    <label for="txtHomePhone" class="col-xs-2 col-sm-2 col-md-1 control-label">Phone:</label>
                    <div class="col-xs-10 col-sm-10 col-md-3">
                        <div class="input-group ">
                            <span class="input-group-addon">
                                <asp:RadioButton ID="rbtnCellPhone" GroupName="grpPrimaryPhone" runat="server" />
                            </span>
                            <asp:TextBox ID="txtCellPhone" runat="server" Class="phone" CssClass="form-control" TabIndex="17" placeholder="Mobile Phone" ToolTip="Mobile Phone" onkeypress="phone" AutoPostBack="true"></asp:TextBox>
                            <%--<asp:RegularExpressionValidator ID="valrCellPhone" runat="server" ControlToValidate="txtCellPhone" ValidationExpression="^(\(?\s*\d{3}\s*[\)\-\.]?\s*)?[2-9]\d{2}\s*[\-\.]\s*\d{4}$" ErrorMessage="<p style='color:red;'>Cell phone should be US format of ten digits entered as ###-###-####.</h4>" ValidationGroup="valContact" Display="None" />--%>
                        </div>

                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-1 ">
                    </div>
                    <div class="col-xs-10 col-sm-10 col-md-3 ">
                        <div class="input-group ">
                            <span class="input-group-addon">
                                <asp:RadioButton ID="rbtnHomePhone" GroupName="grpPrimaryPhone" runat="server" />
                            </span>
                            <asp:TextBox ID="txtHomePhone" runat="server" Class="phone" CssClass="form-control" TabIndex="18" placeholder="Home Phone" ToolTip="Home Phone" onkeypress="phone" AutoPostBack="true"></asp:TextBox>
                            <%--<asp:RegularExpressionValidator ID="regHomePhone" runat="server" ControlToValidate="txtHomePhone" ValidationExpression="^(\(?\s*\d{3}\s*[\)\-\.]?\s*)?[2-9]\d{2}\s*[\-\.]\s*\d{4}$" ErrorMessage="<p style='color:red;'>Cell phone should be US format of ten digits entered as ###-###-####.</h4>" ValidationGroup="valContact" Display="None" />--%>
                        </div>
                    </div>

                    <div class="col-xs-2 col-sm-2 col-md-1 ">
                    </div>

                    <div class="col-xs-10 col-sm-10 col-md-3 ">
                        <div class="input-group ">
                            <span class="input-group-addon">
                                <asp:RadioButton ID="rbtnWorkPhone" GroupName="grpPrimaryPhone" runat="server" />
                            </span>
                            <asp:TextBox ID="txtWorkPhone" runat="server" Class="phone" CssClass="form-control" TabIndex="19" placeholder="Work Phone" ToolTip="Work Phone" onkeypress="phone" AutoPostBack="true"></asp:TextBox>
                            <%--<asp:RegularExpressionValidator ID="regWorkPhone" runat="server" ControlToValidate="txtWorkPhone" ValidationExpression="^(\(?\s*\d{3}\s*[\)\-\.]?\s*)?[2-9]\d{2}\s*[\-\.]\s*\d{4}$" ErrorMessage="<p style='color:red;'>Cell phone should be US format of ten digits entered as ###-###-####.</h4>" ValidationGroup="valContact" Display="None" />--%>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-xs-2 col-sm-2 col-md-1"></div>
                    <div class="col-xs-10 col-md-10 small">
                        <br />
                        Click radio button to choose Primary Email
                    </div>

                </div>

                <div class="form-group">
                    <div class="has-success">
                        <label for="txtEmail1" class="col-xs-2 col-sm-2 col-md-1 control-label "><a style="color: red; font-weight: bold;">*</a>Email:</label>
                        <div class="col-xs-10 col-sm-10 col-md-3">
                            <div class="input-group ">
                                <span class="input-group-addon">
                                    <asp:RadioButton ID="rbtnEmail1" GroupName="grpPrimaryEmail" runat="server" />
                                </span>
                                <asp:TextBox ID="txtEmail1" runat="server" CssClass="form-control " TabIndex="20" placeholder="Email"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="valrEmail1" runat="server" ControlToValidate="txtEmail1" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorMessage="<p style='color:red;'>Email 1 is not formatted correctly <i>(email@provider.com) </i></p>" ValidationGroup="valContact" Display="Dynamic" />
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-2 col-sm-2 col-md-1">
                    </div>
                    <div class="col-xs-10 col-sm-10 col-md-3">
                        <div class="input-group ">
                            <span class="input-group-addon">
                                <asp:RadioButton ID="rbtnEmail2" GroupName="grpPrimaryEmail" runat="server" />
                            </span>
                            <asp:TextBox ID="txtEmail2" runat="server" CssClass="form-control" TabIndex="21" placeholder="Email2"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valrEmail2" runat="server" ControlToValidate="txtEmail2" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorMessage="<p style='color:red;'>Email 2 is not formatted correctly <i>(email@provider.com) </i></h4>" ValidationGroup="valContact" Display="None" />
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                        <asp:ImageButton ID="btnCancelContact" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" ImageAlign="AbsMiddle" TabIndex="23" OnClick="btnCancel_Click" />
                    </div>

                    <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                        <asp:ImageButton ID="btnSaveContact" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valContact" />
                    </div>
                </div>

            </div>
        </asp:Panel>

        <%------  Demographics Review-----%>
        <div id="divDemographicReview" class="well HRETan HRERewrap" runat="server">
            <div class="form-group">
                <div class="col-xs-12 col-sm-12 col-md-10 left">
                    <h4>Demographic Information:</h4>
                </div>
            </div>
            <div class="form-group">
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
                    <b>SSN: </b>
                    <asp:Label ID="lblSSN" runat="server"></asp:Label><br />
                    <b>Date of Birth:</b>
                    <asp:Label ID="lblDateofBirth" runat="server"></asp:Label><br />
                    <b>Employee Number: </b>
                    <asp:Label ID="lblEmployeeNumber" runat="server"></asp:Label><br />
                    <b>Education Level:</b>
                    <asp:Label ID="lblEducationLevel" runat="server"></asp:Label><br />

                    <%--<b>Height: </b>
                    <asp:Label ID="lblHeight" runat="server"></asp:Label><br />--%>
                </div>

                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
                    <b>Gender: </b>
                    <asp:Label ID="lblGender" runat="server"></asp:Label><br />
                    <b>Marital Status: </b>
                    <asp:Label ID="lblMaritalStatus" runat="server"></asp:Label><br />
                    <b>Tobacco User:</b>
                    <asp:Label ID="lblTobacco" runat="server"></asp:Label><br />
                    <%--<b>Weight:</b><asp:Label ID="lblWeight" runat="server"></asp:Label><br />--%>
                </div>
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
                    <b>Language:</b>
                    <asp:Label ID="lblLanguage" runat="server"></asp:Label><br />
                    <b>Ethnicity:</b>
                    <asp:Label ID="lblEthnicGroup" runat="server"></asp:Label><br />
                    <b>Military Status:</b>
                    <asp:Label ID="lblMilitary" runat="server"></asp:Label><br />
                </div>
            </div>
            <div class="form-group">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 right">
                    <asp:ImageButton ID="btnEditDemo" runat="server" ImageUrl="img/GreenEditBtnNew.png" OnMouseOver="src='/img/GreenEditBtnOverNew.png';" OnMouseOut="src='/img/GreenEditBtnNew.png';" ImageAlign="AbsMiddle" />
                </div>
            </div>
        </div>

        <%--Demographic Edit--%>
        <asp:Panel ID="pnlEditDemographic" runat="server" DefaultButton="btnSaveDemo">
            <div id="divDemographicEdit" runat="server" class="well HREWhite HRERewrap">
                <div class="form-group">
                    <div></div>
                    <div style="float: left;"><span style="color: red;">*</span>Required Fields</div>
                </div>
                <div style="width: 100%;">
                    <div class="form-group">
                        <div class="has-success">
                            <div>
                                <label for="txtSSN" class="col-xs-6 col-sm-2 col-md-2 col-lg-2 control-label">
                                    <a style="color: red;">*</a>
                                    SSN:</label>
                            </div>
                            <div class="col-xs-6 col-sm-10 col-md-2 col-lg-2" style="margin-bottom: 3px;">
                                <div class="input-group ">
                                    <asp:TextBox ID="txtSSN" runat="server" MaxLength="11" CssClass="form-control" TabIndex="20" ToolTip=" Enter 9 digit number" Placeholder="###-##-####" Width="185px"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="has-success">
                            <label for="ddlGender" class="col-xs-6 col-sm-2 col-md-1 col-lg-2 control-label ">
                                <a style="color: red;">*</a>
                                Gender:</label>
                            <div class="col-xs-6 col-sm-10 col-md-1 col-lg-2" style="margin-bottom: 3px;">
                                <div class="input-group">
                                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control" TabIndex="21" DataValueField="GenderId" DataTextField="LongDesc" ToolTip="Gender" Width="185px"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="has-success">
                            <label for="ddlLanguage" class="col-xs-6 col-sm-2 col-md-1 col-lg-2 control-label">
                                &nbsp;&nbsp;&nbsp;Language:</label>
                            <div class="col-xs-6 col-sm-10 col-md-1 col-lg-2" style="margin-bottom: 3px;">
                                <div class="input-group">
                                    <asp:DropDownList ID="ddlLanguage" runat="server" CssClass="form-control" TabIndex="22" DataValueField="LanguageId" DataTextField="LongDesc" ToolTip="Language" Width="185px"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="has-success">
                            <label for="txtDoB" class="col-xs-6 col-sm-2 col-md-2 control-label ">
                                <a style="color: red;">*</a>
                                Birth Date:</label>
                            <div class="col-xs-6 col-sm-10 col-md-2 " style="margin-bottom: 3px;">
                                <div class="input-group " style="font-size: 14px;">
                                    <asp:TextBox ID="txtDoB" runat="server" CssClass="container formattedbirthdate" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" TabIndex="23" Width="185px"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="has-success">
                            <label for="ddlMaritalStatus" class="col-xs-6 col-sm-2 col-md-2 col-lg-2 control-label ">
                                &nbsp;&nbsp;&nbsp;Marital Status:</label>
                            <div class="col-xs-6 col-sm-10 col-md-1 col-lg-2">
                                <div class="input-group" style="margin-bottom: 3px;">
                                    <asp:DropDownList ID="ddlMaritalStatus" runat="server" CssClass="form-control" TabIndex="24" DataValueField="MaritalStatusId" DataTextField="LongDesc" ToolTip="Marital Status" Width="185px"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="has-success">
                            <label for="ddlEthnicity" class="col-xs-6 col-sm-2 col-md-1 col-lg-2 control-label">
                                &nbsp;&nbsp;&nbsp;Ethnicity:</label>
                            <div class="col-xs-6 col-sm-10 col-md-1 col-lg-2" style="margin-bottom: 3px;">
                                <div class="input-group">
                                    <asp:DropDownList ID="ddlEthnicity" runat="server" CssClass="form-control" TabIndex="25" DataValueField="EthnicGroupId" DataTextField="ShortDesc" ToolTip="Ethnicity" Width="185px"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="has-success">
                            <label for="txtEENumber" class="col-xs-6 col-sm-2 col-md-2 control-label ">
                                <a style="color: red;">*</a>
                                Employee Number:</label>
                            <div class="col-xs-6 col-sm-10 col-md-2" style="margin-bottom: 3px;">
                                <div class="input-group ">
                                    <asp:TextBox ID="txtEENumber" runat="server" CssClass="form-control " TabIndex="26" placeholder="" Width="185px"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="has-success">
                            <label for="ddlMilitaryStatus" class="col-xs-6 col-sm-2 col-md-2 col-lg-2 control-label ">
                                &nbsp;&nbsp;&nbsp;Military:</label>
                            <div class="col-xs-6 col-sm-10 col-md-1 col-lg-2" style="margin-bottom: 3px;">
                                <div class="input-group">
                                    <asp:DropDownList ID="ddlMilitaryStatus" runat="server" CssClass="form-control" TabIndex="27" DataValueField="MilitaryStatusId" DataTextField="ShortDesc" ToolTip="Military Status" Width="185px"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="has-success">
                            <label for="ddlEducationLevel" class="col-xs-6 col-sm-2 col-md-1 col-lg-2 control-label">
                                &nbsp;&nbsp;&nbsp;Education:</label>
                            <div class="col-xs-6 col-sm-10 col-md-1 col-lg-2" style="margin-bottom: 3px;">
                                <div class="input-group">
                                    <asp:DropDownList ID="ddlEducationLevel" runat="server" CssClass="form-control" TabIndex="28" DataValueField="EducationLevelId" DataTextField="ShortDesc" ToolTip="Education" Width="185px"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="has-success">
                            <div class="col-xs-12 col-sm-12 col-md-12">
                                <asp:CheckBox ID="chkTobacco" runat="server" Text="&nbsp;Tobacco User" class=" check" TabIndex="39" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                        <asp:ImageButton ID="btnCancelDemo" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" ImageAlign="AbsMiddle" TabIndex="45" OnClick="btnCancel_Click" />
                    </div>

                    <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                        <asp:ImageButton ID="btnSaveDemo" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="44" ValidationGroup="valDemographics" />
                    </div>
                </div>
            </div>
        </asp:Panel>

        <%------  Admin Review-----%>
        <div id="divAdminReview" class="well HRETan HRERewrap" runat="server" visible="false">
            <div class="form-group">
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 left">
                    <h4>Additional HR Demographic Information:</h4>
                </div>

                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 right">
                    <asp:LinkButton ID="btnLinkReset" runat="server" Text="Reset Security" class="text-danger" Visible="true" data-toggle="modal" Data-target="#ModalReset" />
                </div>
            </div>

            <%--  COLUMN 1  --%>
            <div class="form-group">
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
                    <b>Original Hire Date: </b>
                    <asp:Label ID="lblHireDate" runat="server"></asp:Label><br />
                    <strong>Latest </strong><b>Hire Date:  </b>
                    <asp:Label ID="lblRehireDate" runat="server"></asp:Label><br />
                    <b>Original Eligibility Date: </b>
                    <asp:Label ID="lblEligibilityDate" runat="server"></asp:Label><br />
                    <b>Latest Eligibility Date:  </b>
                    <asp:Label ID="lblReEligDate" runat="server"></asp:Label><br />
                    <b>Benefit Class Effective Date:</b>
                    <asp:Label ID="lblBenefitClassEffDate" runat="server"></asp:Label><br />
                    <b>Termination Date: </b>
                    <asp:Label ID="lblTerminationDate" runat="server"></asp:Label><br />
                    <b>Termination Reason:</b>
                    <asp:Label ID="lblTerminationReason" runat="server"></asp:Label><br />
                    <b>Length of Cobra: </b>
                    <asp:Label ID="lblCobra" runat="server"></asp:Label>
                </div>

                <%--  COLUMN 2  --%>
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
                    <b>Pay Type: </b>
                    <asp:Label ID="lblPaytype" runat="server"></asp:Label><br />
                    <b>Pay Rate: </b>
                    <asp:Label ID="lblSalary" runat="server"></asp:Label>
                    &nbsp;&nbsp;<b>Per: </b>
                    <asp:Label ID="lblSalaryTypeDesc" runat="server"></asp:Label><br />
                    <b>Benefit Salary:</b>
                    <asp:Label ID="lblBenefitSalary" runat="server"></asp:Label><br />
                    <b>Status: </b>
                    <asp:Label ID="lblStatus" runat="server"></asp:Label><br />
                    <b>Benefit Class: </b>
                    <asp:Label ID="lblBenefitClass" runat="server"></asp:Label><br />
                    <b>Pay Frequency: </b>
                    <asp:Label ID="lblPayFrequency" runat="server"></asp:Label><br />
                    <b>Deduction Freq:</b>
                    <asp:Label ID="lblDeductionFrequency" runat="server"></asp:Label><br />
                    <b>Standard Hours: </b>
                    <asp:Label ID="lblStandardHours" runat="server"></asp:Label><br />

                </div>

                <%--  COLUMN 3  --%>
                <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
                    <b>Occupation:  </b>
                    <asp:Label ID="lblOccupation" runat="server"></asp:Label><br />
                    <b>Department: </b>
                    <asp:Label ID="lblDepartment" runat="server"></asp:Label><br />
                    <b>Division:  </b>
                    <asp:Label ID="lblDivision" runat="server"></asp:Label><br />
                    <b>Category:</b>
                    <asp:Label ID="lblCategory" runat="server"></asp:Label><br />
                    <b>Other:</b>
                    <asp:Label ID="lblOther" runat="server"></asp:Label><br />
                    <b>Manager: </b>
                    <asp:Label ID="lblManager" runat="server"></asp:Label><br />
                    <b>Owner: </b>
                    <asp:Label ID="lblOwner" runat="server"></asp:Label><br />
                    <b>In Onboarding:</b>
                    <asp:Label ID="lblInOnboarding" runat="server"></asp:Label><br />
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 right">
                    <asp:Label ID="lblTestPerson" runat="server" class="text-danger" Text="<b>Test Employee</b> - will NOT appear in Reports, Carrier Feeds or Invoices."> </asp:Label>
                </div>

                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 right">
                    <asp:ImageButton ID="btnAdminEdit" runat="server" ImageUrl="img/GreenEditBtnNew.png" OnMouseOver="src='/img/GreenEditBtnOverNew.png';" OnMouseOut="src='/img/GreenEditBtnNew.png';" ImageAlign="AbsMiddle" />
                </div>
            </div>
        </div>

        <%--  -------  Admin Edit  ------------%>
        <asp:Panel ID="pnlEditAdmin" runat="server" DefaultButton="btnAdminSave">
            <div id="divAdminEdit" class="well HREWhite HRERewrap" runat="server">
                <div class="form-group">
                    <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                        <p class="form-control-static text-success "><a style="color: red; font-weight: bold;">*</a> Required fields</p>

                    </div>
                </div>

                <div class="form-group">
                    <div class="has-success">
                        <label for="txtHireDate" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                            <a style="color: red; font-weight: bold;">*</a>
                            Original Hire:</label>
                        <div class="col-xs-6 col-sm-6 col-md-4 col-lg-4" style="margin-bottom: 2px; padding-left: 3px; font-size: 14px;">
                            <asp:TextBox ID="txtHireDate" runat="server" CssClass="container formattedhiredate center" onfocus="(this.type='date')" Width="170" Placeholder="mm/dd/yyyy" TabIndex="50"></asp:TextBox>
                        </div>
                    </div>
                    <label for="txtRehire" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                        &nbsp;&nbsp;&nbsp;Latest Hire:</label>
                    <div class="col-xs-6 col-sm-6 col-md-4 col-lg-4" style="margin-bottom: 2px; padding-left: 3px; font-size: 14px;">
                        <asp:TextBox ID="txtRehire" runat="server" CssClass="container formattedrehiredate center" onfocus="(this.type='date')" Width="170" Placeholder="mm/dd/yyyy" TabIndex="51"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <div class="has-success">
                        <label for="txtEligDate" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                            <a style="color: red; font-weight: bold;">*</a>
                            Original Eligiblity:</label>
                        <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 2px; padding-left: 3px; font-size: 14px;">
                            <asp:TextBox ID="txtEligDate" runat="server" CssClass="container formattedeligdate center" onfocus="(this.type='date')" Width="170" Placeholder="mm/dd/yyyy" TabIndex="52"></asp:TextBox>
                        </div>
                    </div>
                    <label for="txtReHireElig" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                        &nbsp;&nbsp;&nbsp;Latest Eligibility:</label>
                    <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 2px; padding-left: 3px; font-size: 14px;">
                        <asp:TextBox ID="txtReHireElig" runat="server" CssClass="container formattedrehireeligdate center" onfocus="(this.type='date')" Width="170" Placeholder="mm/dd/yyyy" TabIndex="53"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group has-success">
                    <div class="has-success">
                        <label for="txtBenefitClassEffDate" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                            <a style="color: red; font-weight: bold;">*</a>
                            Class Effective:</label>
                        <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 2px; padding-left: 3px; font-size: 14px;">
                            <asp:TextBox ID="txtBenefitClassEffDate" runat="server" CssClass="container formattedbenefitclassdate center" onfocus="(this.type='date')" Width="170" Placeholder="mm/dd/yyyy" TabIndex="54"></asp:TextBox>
                        </div>
                    </div>
                    <label for="ddlBenefitClass" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                        <a style="color: red; font-weight: bold;">*</a>
                        Benefit Class:</label>
                    <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 2px; padding-left: 3px; font-size: 14px;">
                        <asp:DropDownList ID="ddlBenefitClass" runat="server" CssClass="form-control" DataValueField="ClassId" DataTextField="LongDesc" Width="175" TabIndex="55"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="valrBenefitClass" runat="server" InitialValue="Null" ErrorMessage="Benefit Class must be selected" ControlToValidate="ddlBenefitClass" ValidationGroup="valAdmin" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>

                <div class="form-group">
                    <label for="txtSalary" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                        &nbsp;&nbsp;&nbsp;Pay Rate:</label>
                    <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 3px; padding-left: 3px; font-size: 14px;">
                        <div class="input-group">
                            <span class="input-group-addon">$</span>
                            <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control text-left" MaxLength="50" Visible="true" Width="140" TabIndex="56"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="valrSalary" runat="server" ControlToValidate="txtSalary" ValidationExpression="^[0-9]\d*(\.\d+)?$" ErrorMessage="<p style='color:red;'>Pay Rate must be numeric</h4>" ValidationGroup="valAdmin" Display="None" />
                        </div>
                    </div>
                    <div class="has-success">
                        <label for="ddlStatus" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                            <a style="color: red; font-weight: bold;">*</a>
                            Status:</label>
                        <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 3px; padding-left: 3px; font-size: 14px;">
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control" DataValueField="EmploymentStatusId" DataTextField="LongDesc" Width="175" TabIndex="57"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="valrStatus" runat="server" InitialValue="Null" ErrorMessage="Employee Status must be selected" ControlToValidate="ddlStatus" ValidationGroup="valAdmin" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="ddlPayPer" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                        &nbsp;&nbsp;&nbsp;Pay Rate Per:</label>
                    <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 3px; padding-left: 3px; font-size: 14px;">
                        <asp:DropDownList ID="ddlPayPer" runat="server" CssClass="form-control" DataValueField="SalaryTypeId" DataTextField="LongDesc" Width="170" TabIndex="58"></asp:DropDownList>
                    </div>
                    <div class="has-success">
                        <label for="ddlPayFrequency" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                            <a style="color: red; font-weight: bold;">*</a>
                            Pay Frequency:</label>
                        <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 3px; padding-left: 3px; font-size: 14px;">
                            <asp:DropDownList ID="ddlPayFrequency" runat="server" CssClass="form-control" DataValueField="PayFrequencyId" DataTextField="LongDesc" Width="170" TabIndex="59"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="valrPayFrequency" runat="server" InitialValue="Null" ErrorMessage="Pay Frequency must be selected" ControlToValidate="ddlPayFrequency" ValidationGroup="valAdmin" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>

                <div class=" form-group ">
                    <div class="has-success">
                        <label for="ddlPaytype" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                            <a style="color: red; font-weight: bold;">*</a>
                            Pay Type:</label>
                        <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 3px; padding-left: 3px; font-size: 14px;">
                            <asp:DropDownList ID="ddlPaytype" runat="server" CssClass="form-control selectpicker text-right col-md-5" DataValueField="PayTypeId" DataTextField="LongDesc" Width="170" TabIndex="60"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="valrPayType" runat="server" InitialValue="Null" ErrorMessage="Pay Type must be selected" ControlToValidate="ddlPaytype" ValidationGroup="valAdmin" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="has-success">
                        <label for="ddlDeductionFrequency" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                            <a style="color: red; font-weight: bold;">*</a>
                            Deduction Frequency:</label>
                        <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 3px; padding-left: 3px; font-size: 14px;">
                            <asp:DropDownList ID="ddlDeductionFrequency" runat="server" CssClass="form-control selectpicker " DataValueField="PayFrequencyId" DataTextField="LongDesc" Width="170" TabIndex="61"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" InitialValue="Null" ErrorMessage="Deduction Frequency must be selected" ControlToValidate="ddlDeductionFrequency" ValidationGroup="valAdmin" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>

                <div class="form-group ">
                    <div class="has-success">
                        <label for="txtBenefitSalary" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                            <a style="color: red; font-weight: bold;">*</a>
                            Annual Benefit Salary:</label>
                        <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="padding-left: 3px; font-size: 14px;">
                            <div class="input-group">
                                <span class="input-group-addon">$</span>
                                <asp:TextBox ID="txtBenefitSalary" runat="server" CssClass="form-control" MaxLength="50" Visible="true" Placeholder="Required" Width="140" TabIndex="62"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="valrBenefitSalary" runat="server" InitialValue="Null" ErrorMessage="Benefit Salary" ControlToValidate="txtBenefitSalary" ValidationGroup="valAdmin" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="valreBenefitSalary" runat="server" ControlToValidate="txtBenefitSalary" ValidationExpression="^[1-9]\d*(\.\d+)?$" ErrorMessage="<p style='color:red;'>Benefit Salary field must be numeric</h4>" ValidationGroup="valAdmin" Display="None" />
                            </div>
                            <br />
                        </div>
                    </div>

                    <label for="ddlDivision" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                        &nbsp;&nbsp;&nbsp;Division:
                    </label>

                    <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="padding-left: 3px; font-size: 14px;">
                        <asp:DropDownList ID="ddlDivision" runat="server" CssClass="form-control" DataValueField="EmployeeDivisionId" DataTextField="LongDesc" Width="170" TabIndex="63"></asp:DropDownList>
                    </div>
                </div>

                <div class="form-group">
                    <label for="txtStandardHours" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                        &nbsp;&nbsp;&nbsp;Standard Hours:</label>
                    <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 3px; padding-left: 3px; font-size: 14px;">
                        <asp:TextBox ID="txtStandardHours" runat="server" CssClass="form-control" MaxLength="50" Visible="true" Width="170" TabIndex="64"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="valStandardHours" runat="server" ControlToValidate="txtStandardHours" ValidationExpression="^[0-9]\d*(\.\d+)?$" ErrorMessage="<p style='color:red;'>Standard Hours must be numeric</h4>" ValidationGroup="valAdmin" Display="None" />
                    </div>
                    <label for="ddlDepartment" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                        &nbsp;&nbsp;&nbsp;Department:</label>
                    <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 3px; padding-left: 3px; font-size: 14px;">
                        <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control" DataValueField="EmployeeDepartmentId" DataTextField="LongDesc" Width="170" TabIndex="65"></asp:DropDownList>
                    </div>
                </div>

                <div class="form-group">
                    <label for="txtTerminationDate" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                        &nbsp;&nbsp;&nbsp;Termination Date:</label>
                    <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 3px; padding-left: 3px; font-size: 14px;">
                        <asp:TextBox ID="txtTerminationDate" runat="server" CssClass="container formattedtermdate center" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" Width="170" TabIndex="66"></asp:TextBox>
                    </div>
                    <label for="ddlCategory" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                        &nbsp;&nbsp;&nbsp;Category:</label>
                    <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 3px; padding-left: 3px; font-size: 14px;">
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" DataValueField="CompanyCategoryId" DataTextField="LongDesc" Width="170" TabIndex="67"></asp:DropDownList>
                    </div>
                </div>

                <div class="form-group">
                    <label for="ddlTerminationReason" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                        &nbsp;&nbsp;&nbsp;Termination Reason:</label>
                    <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 3px; padding-left: 3px; font-size: 14px;">
                        <asp:DropDownList ID="ddlTerminationReason" runat="server" CssClass="form-control" DataValueField="EventTypeId" DataTextField="ShortDesc" Width="170" TabIndex="68"></asp:DropDownList>
                    </div>
                    <label for="txtManager" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                        &nbsp;&nbsp;&nbsp;Manager:</label>
                    <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 3px; padding-left: 3px; font-size: 14px;">
                        <asp:TextBox ID="txtManager" runat="server" CssClass="form-control" MaxLength="50" Visible="true" Width="170" TabIndex="69"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label for="ddlCobraLength" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                        &nbsp;&nbsp;&nbsp;Length of COBRA:</label>
                    <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 3px; padding-left: 3px; font-size: 14px;">
                        <asp:DropDownList ID="ddlCobraLength" runat="server" CssClass="form-control" DataValueField="ShortDesc" DataTextField="LongDesc" Width="170" TabIndex="70"></asp:DropDownList>
                    </div>
                    <label for="txtOccupation" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                        &nbsp;&nbsp;&nbsp;Occupation:</label>
                    <div class="col-xs-6 col-sm-6 col-md-5 col-lg-4" style="margin-bottom: 3px; padding-left: 3px; font-size: 14px;">
                        <asp:TextBox ID="txtOccupation" runat="server" CssClass="form-control" MaxLength="100" Visible="true" Width="170" TabIndex="71"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group">
                    <label for="txtOther" class="col-xs-6 col-sm-6 col-md-2 col-lg-2 control-label">
                        &nbsp;&nbsp;&nbsp;Other Data:</label>
                    <div class="col-xs-6 col-sm-6 col-md-10 col-lg-8 center" style="margin-bottom: 3px; padding-left: 3px; font-size: 14px;">
                        <asp:TextBox ID="txtOther" runat="server" CssClass="form-control" Visible="true" Width="93%" TabIndex="72"></asp:TextBox>
                    </div>
                    <br />
                </div>

                <div class="form-group">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-2 checkbox ">
                        &nbsp;
                    </div>
                    <div class="col-xs-12 col-sm-3 col-md-3 col-lg-1 checkbox center">
                        <asp:CheckBox ID="chkOwner" runat="server" Text="Owner" TabIndex="73" />
                    </div>

                    <div class="col-xs-12 col-sm-3 col-md-3 col-lg-2 checkbox center">
                        <asp:CheckBox ID="chkTest" runat="server" Text="Test Person" TabIndex="74" />
                    </div>

                    <div class="col-xs-12 col-sm-3 col-md-3 col-lg-2 checkbox center">
                        <asp:CheckBox ID="chkOnboarding" runat="server" Text="In Onboarding" TabIndex="75" />
                    </div>
                </div>

                <div class="form-group">

                    <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                        <asp:ImageButton ID="btnCancelAdmin" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" ImageAlign="AbsMiddle" TabIndex="76" OnClick="btnCancel_Click" />
                    </div>

                    <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                        <asp:ImageButton ID="btnAdminSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="77" Autopostback="True" OnClick="btnAdminSave_Click" />
                    </div>

                    <div class="col-xs-6 col-sm-6 col-md-3  "></div>

                </div>
            </div>
        </asp:Panel>
        <div style="visibility: hidden;">
            TxtDOBFormatted:
            <asp:TextBox ID="TxtDOBFormatted" runat="server" Visible="true"></asp:TextBox>
            TxtHireDateFormatted:
            <asp:TextBox ID="TxtHireDateFormatted" runat="server" Visible="true"></asp:TextBox>
            TxtReHireDateFormatted:
            <asp:TextBox ID="TxtReHireDateFormatted" runat="server" Visible="true"></asp:TextBox>
            TxtEligDateFormatted:
            <asp:TextBox ID="TxtEligDateFormatted" runat="server" Visible="true"></asp:TextBox>
            TxtRehireEligDateFormatted:
            <asp:TextBox ID="TxtRehireEligDateFormatted" runat="server" Visible="true"></asp:TextBox>
            TxtBenefitClassEffDateFormatted:
            <asp:TextBox ID="TxtBenefitClassEffDateFormatted" runat="server" Visible="true"></asp:TextBox>
            TxtTermDateFormatted:
            <asp:TextBox ID="TxtTermDateFormatted" runat="server" Visible="true"></asp:TextBox>
        </div>
    </div>

    <%--end of Tab Content--%>

    <div class="modal fade" id="ModalReset" tabindex="-1" role="dialog" aria-labelledby="myModalReset" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title text-success" id="ModalTitle">
                        <asp:Label ID="mlblResetTitle" runat="server" Text="Reset Security"></asp:Label></h4>
                </div>
                <div class="modal-body ">
                    <div class="well">
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-12 col-md-12">
                                <asp:Label ID="mResetlbl1" runat="server" class="col-md-12  h3" Text="Reset Employee Security"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-12 col-md-12">
                                <asp:Label ID="mResetlbl2" runat="server" class="col-md-12  h4"
                                    Text="<b>Please Note:</b>  Pressing <b> SAVE</b> will reset the Employee's password and Security Answers requiring them to complete Initial Registration to gain access to the system.   "></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-12 col-md-12">
                                <asp:Label ID="mResetlbl3" runat="server" class="col-md-12 h4" Text="Press <b>CLOSE</b> to exit without resetting the Employee"></asp:Label>

                            </div>
                        </div>
                        <%-- <div class="form-group">
                            <asp:Label ID="Label6" runat="server" class="col-md-12"></asp:Label>
                        </div>--%>
                    </div>
                </div>
                <div class="modal-footer">

                    <asp:ImageButton ID="mbtnResetSave" ImageUrl="../img/BlueSaveBtnNew.png" runat="server" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';"></asp:ImageButton>
                    <asp:ImageButton ID="mbtnResetCancel" data-dismiss="modal" ImageUrl="../img/BlueCloseBtn.png" runat="server" OnMouseOver="src='/img/BlueCloseBtnOver.png';" OnMouseOut="src='/img/BlueCloseBtn.png';" TabIndex="-1"></asp:ImageButton>
                </div>
            </div>
        </div>
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


    <script>
        $(document).ready(function () {
            $('.SSN').blur(function () {
                var val = $(this).val();
                var newvalue = val.replace(/(\d{3})(\d{2})(\d{4})/, "$1-$2-$3");
                $(this).val(newvalue);
            });
        });

        $(document).ready(function () {
            $('.phone').blur(function () {
                var val = $(this).val();
                var newvalue = val.replace(/(\d{3})(\d{3})(\d{4})/, "$1-$2-$3");
                $(this).val(newvalue);
            });
        });
    </script>
    <style>
        input[type=text], textarea {
            outline: none;
            min-height: 25px;
            background-color: #f0f4fa;
            border-top: 1px solid #e0eaf7 !important;
            border-left: 1px solid #e0eaf7 !important;
            border-right: 1px solid #e0eaf7 !important;
            border-bottom: 1px solid black;
        }

        input[type="checkbox"] {
            width: 16px;
            height: 16px;
            cursor: pointer;
            background: #f0f4fa;
        }

        .underline {
            border-bottom: 1px solid;
            width: 100%;
            display: inline-block;
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

        @media only screen and (max-width: 479px) {
            .mobile-hide {
                display: none;
            }

            .well {
                padding: 15px 1% 10px 1% !important;
                margin: 3% auto 1% auto !important;
            }

            .col-xs-1, .col-sm-1, .col-md-1, .col-lg-1, .col-xs-2, .col-sm-2, .col-md-2, .col-lg-2, .col-xs-3, .col-sm-3, .col-md-3, .col-lg-3, .col-xs-4, .col-sm-4, .col-md-4, .col-lg-4, .col-xs-5, .col-sm-5, .col-md-5, .col-lg-5, .col-xs-6, .col-sm-6, .col-md-6, .col-lg-6, .col-xs-7, .col-sm-7, .col-md-7, .col-lg-7, .col-xs-8, .col-sm-8, .col-md-8, .col-lg-8, .col-xs-9, .col-sm-9, .col-md-9, .col-lg-9, .col-xs-10, .col-sm-10, .col-md-10, .col-lg-10, .col-xs-11, .col-sm-11, .col-md-11, .col-lg-11, .col-xs-12, .col-sm-12, .col-md-12, .col-lg-12 {
                padding: .8% .5% 0px .5% !important;
            }
        }
    </style>
</asp:Content>

