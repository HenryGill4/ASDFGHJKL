<%@ Page Title="Company Business Rules" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="Admin_CompanyBusinessRules.aspx.vb" 
    Inherits="HReaseApp.Admin_CompanyBusinessRules" 
    ValidateRequest="false" 
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
    <script type="text/javascript" src="Scripts/tinymce/tinymce.min.js"></script>
    <script type="text/javascript">
        tinymce.init({
            selector: 'textarea',
            height: 400,
            theme: 'modern',
            plugins: [
                'advlist autolink lists link image charmap print preview hr anchor pagebreak',
                'searchreplace wordcount visualblocks visualchars code fullscreen',
                'insertdatetime media nonbreaking save table contextmenu directionality',
                'emoticons template paste textcolor colorpicker textpattern imagetools codesample toc help'
            ],
            menubar: false,
            toolbar1: 'undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | forecolor backcolor | bullist numlist outdent indent | link preview',

            image_advtab: true,
            templates: [
                { title: 'Test template 1', content: 'Test 1' },
                { title: 'Test template 2', content: 'Test 2' }
            ], content_css: [
                '//fonts.googleapis.com/css?family=Open+Sans:300,400,700,800',
                'Corporate/assets/css/essentials.css'
            ]

        });
    </script>

    <div class="HREwrapper">
        <div id="divPageTitle">
            <div >
                <br />
                <h4><b>Company Business Rules</b></h4>
            </div>
        </div>

        <div id="divNextButton" runat="server" class="hidden-xs" style="float:right; display:inline; margin-top:-7px;">
            <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
            <asp:Image ID="Image1" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
        </div>

        <div id="divTopHeader" runat="server">   
            <div id="divCompanyList" runat="server" class="well HRESlateBlue HRERewrap form-inline" style="margin-right:5%;">
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
        </div>

        <div id="divCompanyName" runat="server" class="well" style="text-align:center; margin-right:5%;">
            <b><asp:Label ID="lblCompanyName" runat="server" Text="CompanyName"></asp:Label></b>
            <br /><br />
        </div> 

        <div id="divBusinessRules" class="well HRETan" runat="server">
            <div id="divSectionTitle" style="text-align:center;">
                <h4><b>Default Benefit Rules:</b></h4>
            </div>
            
            <div id="divEditButton" class="form-group">
                <div class="HREpadR10">
                    <asp:ImageButton ID="btnEditRules" runat="server" ImageUrl="img/GreenEditBtnNew.png" OnMouseOver="src='/img/GreenEditBtnOverNew.png';" OnMouseOut="src='/img/GreenEditBtnNew.png';" ImageAlign="AbsMiddle" OnClick="btnEditRules_Click" />
                </div>
            </div>

            <div id="divRow1DefaultRules" class="form-group">
                <label for="lblInitialWait" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">
                    Initial Eligibility Wait:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 ">
                    <asp:Label ID="lblInitialWait" runat="server" class="control-label"></asp:Label>   
                </div>
                <label for="lblDefaultDeductionFrequency" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">
                    Deduction Frequency:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 " >
                    <asp:Label ID="lblDefaultDeductionFrequency" runat="server" class="control-label"></asp:Label>
                </div>
            </div>
          
            <div id="divRow2DefaultRules" class="form-group">
                <label for="lblRehireWait" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">Rehire Eligibility Wait:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 ">
                    <asp:Label ID="lblRehireWait" runat="server" class="control-label"></asp:Label>   
                </div>
                <label for="lblDefaultPayFrequency" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">Pay Frequency:</label>
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 " >
                        <asp:Label ID="lblDefaultPayFrequency" runat="server" class="control-label"></asp:Label>
                    </div>
            </div>

            <div id="divOEandIETitles" class="form-group">
                 <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right " style="color: green;">
                    <b>Open Enrollment</b>
                </div>
                <div class="col-xs-2 col-sm-2 col-md-3 col-lg-3 "></div>             
                  <div class="col-xs-4 col-sm-4 col-md-2 col-lg-2 right" style="color: darkorange;">
                    <b>Initial Enrollment:</b>
                </div>
            </div>

            <div class="form-group">
                <label for="lblOEBegin" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right" style="color: green;">
                    Begin Date:</label>

                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 " style="color: green;">
                    <asp:Label ID="lblOEBegin" runat="server" class="control-label"></asp:Label>
                </div>
                 <label for="lblIEDaysPre" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right" style="color: darkorange;">
                    Window Open:</label>

                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 " style="color: darkorange;">
                    <asp:Label ID="lblIEDaysPre" runat="server" class="control-label"></asp:Label>
                Days Prior to IE Effective Date
                </div>
            </div>

            <div class="form-group">
                <label for="lblOEEnd" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right" style="color: green;">End Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 ">
                    <asp:Label ID="lblOEEnd" runat="server" class="control-label" Style="color: green;"></asp:Label>
                </div>
                 <label for="lblIEDaysPost" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right" style="color: darkorange;">
                     Window Closed:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblIEDaysPost" runat="server" class="control-label" Style="color: darkorange;"></asp:Label>                           
                    <span style="color:darkorange; text-align:left;">
                        Days After IE Effective Date</span>
                </div>
            </div>

            <div class="form-group ">
                <label for="lblOEEffectiveDate" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right" style="color: green;">
                    Effective Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 ">
                    <asp:Label ID="lblOEEffectiveDate" runat="server" class="control-label" Style="color: green;"></asp:Label>
                </div>
               <div class="col-xs-6 col-sm-6 col-md-5 col-lg-5 "></div>
            </div>

            <div class="form-group ">
                <label for="ChkShowERRates" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">
                    Show Employ<b>er</b> Rates:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 ">
                    <asp:Label ID="LblShowEmployerRates" runat="server" class="control-label" ></asp:Label>
                </div>
            </div>

            <%-- OE Exceptions Panel--%>
            <asp:Panel ID="pnlOEExceptions" runat ="server">
                <div class="form-group ">
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 text-right"   >
                        <b style="color: green;">OE Exceptions:</b>
                    </div>
                
                    <div class="col-xs-6 col-sm-6 col-md-8">
                        <asp:GridView runat="server" ID="grdOEExceptions" AutoGenerateColumns="False"
                            GridLines="None" BorderColor="#3276B1"
                            CellPadding="0">
                              <%--<AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>--%>
                            <Columns>
                                <asp:BoundField HeaderText="Plan Type" DataField="PlanType" Visible="true" />
                                 <asp:BoundField HeaderText="Month" DataField="Month" Visible="true" />
                                 <asp:BoundField HeaderText="Allow During ALL OE Periods" DataField="AllowOEPeriods" Visible="true"   />
                           </Columns>
                              <FooterStyle BackColor="WhiteSmoke" HorizontalAlign="Left" />
                              <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                              <RowStyle CssClass="grdNormalrow" HorizontalAlign="Center" />
                        </asp:GridView>
                    </div>
                </div>
            </asp:Panel>

            <div id="divPreTaxLabel" class="form-group ">
                <label for="lblPreTax" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right ">
                    Owners Subject to PreTax Rule: </label>
                <div class="col-xs-3 col-sm-3 col-md-1 col-lg-1 ">
                   <asp:Label ID="lblPreTax" runat="server" class="control-label"></asp:Label>
                </div>
            </div>
 
            <div id="divBenefitsContactInfo" class="form-group">
                <label for="lblResourceInfo" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">
                    Benefits Contact Information:</label>
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8" style="background-color:white;">
                    <asp:Label ID="lblResourceInfo" runat="server"></asp:Label>
                </div>
            </div>

            <div id="divAdditionalCompanySetup" class="form-group">
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right " style="color: green;">
                    <b style="color: green;"> Additional Company Setup:</b>  
                </div>
            </div>

            <div id="divBilledCompany" class="form-group">
                <label for="lblBilledCo" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">
                    Billed CompanyId:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                    <asp:Label ID="lblBilledCompany" runat="server" class=" control-label"></asp:Label><br />
                </div>
                <label for="lblEmailForInvoicing" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">
                    Email Invoice To:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
                    <asp:Label ID="lblEmailForInvoicing" runat="server" class=" control-label"></asp:Label><br />
                </div>
            </div> 

            <div id="divNotesReveiw" runat="server" class="form-group">
                <label for="lblNotes" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">
                    Company Notes:</label>
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">
                    <asp:Label ID="lblNotes" runat="server"></asp:Label>
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2"></div>
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 ">

                    <asp:Label ID="lblInherit" runat="server" CssClass="text-success" Text=""></asp:Label>
                </div>
            </div>
        </div>

        <div id="divEdit" class="well HREWhite HRERewrap" runat="server" >
            <div id="divSection1Title" style="text-align:center;">
                <h4 style="color:darkblue;"><b>Default Benefit Rules:</b></h4>
            <div class="HREpadR10">
                    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" ImageAlign="AbsMiddle" />
                </div>
                <div class="HREpadR10">
                    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right"  ValidationGroup="valRules" />
                </div>
            </div>
            
            <div id="CompanyDefault1" runat="server" class="form-group">
                <label for="ddlInitialWait" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">
                    Initial Eligibility Wait:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 " style="min-width:250px;">
                    <asp:DropDownList ID="ddlInitialWait" runat="server" CssClass="form-control" TabIndex="1" DataValueField="PeriodId" DataTextField="LongDesc"></asp:DropDownList>
                </div>
                <label for="ddlDefaultDeductionFrequency" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">
                    Deduction Frequency:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="min-width:250px;">
                    <asp:DropDownList ID="ddlDefaultDeductionFrequency" runat="server" CssClass="form-control" TabIndex="3" DataValueField="PayFrequencyId" DataTextField="LongDesc"></asp:DropDownList>
                </div>
            </div>

            <div id="CompanyDefault2" runat="server" class="form-group">
                <label for="ddlRehireWait" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">Rehire Eligibility Wait:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="min-width:250px;">
                    <asp:DropDownList ID="ddlRehireWait" runat="server" CssClass="form-control" TabIndex="2" DataValueField="PeriodId" DataTextField="LongDesc"></asp:DropDownList>
                </div>

                <label for="ddlDefaultPayFrequency" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">Pay Frequency:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="min-width:250px;">
                    <asp:DropDownList ID="ddlDefaultPayFrequency" runat="server" CssClass="form-control" TabIndex="4" DataValueField="PayFrequencyId" DataTextField="LongDesc"></asp:DropDownList>
                </div>
            </div>

            <div class="form-group">
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right " style="color: green;">
                    <b>Open Enrollment</b>
                </div>
                <div class="col-xs-2 col-sm-2 col-md-3 col-lg-3 "></div>
                <div class="col-xs-4 col-sm-4 col-md-2 col-lg-2 right" style="color: darkorange;">
                    <b>Initial Enrollment:</b>
                </div>
            </div>

            <div class="form-group">
                <label for="lblOEBegin" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right" style="color: green;">
                    Begin Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="color: green; text-align:left;">
                    <asp:TextBox ID="txtOEBegin" runat="server" CssClass="form-control" TabIndex="5" onfocus="(this.type='date')" onblur="{this.type='text'}" Style="padding-left:10px; font-size:14px; width:160px; border:1px solid lightgray;" class="radius3" Placeholder="mm/dd/yyyy"></asp:TextBox>
                </div>
                <label for="lblIEDaysPre" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right" style="color: darkorange;">
                    Days Prior to IE Effective Date to <br /><b>Open</b> Window:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">
                    <asp:TextBox ID="txtIEDaysPre" runat="server" CssClass="form-control" TabIndex="8" TextMode="number" ToolTip="Days" Width="100px"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtIEDaysPre" ErrorMessage="<h4>Intial Enrollment Days Pre</h4>" Text="" runat="server" Display="None" ValidationGroup="valRules" />
                    <asp:CompareValidator runat="server" Operator="DataTypeCheck" Type="Integer" ControlToValidate="txtIEDaysPre" ErrorMessage="<h4>Intial Enrollment Days Pre must be a whole number</h4>" Display="None" ValidationGroup="valRules" />        
                </div>
            </div>

            <div class="form-group">
                <label for="lblOEEnd" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right" style="color: green;">
                    End Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="color: green; text-align:left;">
                    <asp:TextBox ID="txtOEEnd" runat="server" CssClass="form-control" TabIndex="6" onfocus="(this.type='date')" onblur="{this.type='text' this.data='lblOEEnd'}" Style="padding-left:10px; font-size:14px; width:160px; border:1px solid lightgray;" class="radius3" ></asp:TextBox>
                </div>

                 <label for="lblIEDaysPost" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right" style="color: darkorange;">
                     Days after IE Effective Date to <br /><b>Close</b> Window:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">
                    <asp:TextBox ID="txtIEDaysPost" runat="server" CssClass="form-control" TabIndex="9" TextMode="Number" ToolTip="Days" Width="100px"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtIEDaysPost" ErrorMessage="<h4>Intial Enrollment Days Post</h4>" Text="" runat="server" Display="None" ValidationGroup="valRules" />
                    <asp:CompareValidator runat="server" Operator="DataTypeCheck" Type="Integer" ControlToValidate="txtIEDaysPost" ErrorMessage="<h4>Intial Enrollment Days Post must be a whole number</h4>" Display="None" ValidationGroup="valRules" />
                </div>
            </div>

            <div class="form-group ">               
                <label for="lblOEEffectiveDate" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right" style="color: green;">
                    Effective Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="color: green; text-align:left;">
                    <asp:TextBox ID="txtOEEffectiveDate" runat="server" CssClass="form-control" TabIndex="7" onfocus="(this.type='date')" onblur="{this.type='text'}" Style="padding-left:10px; font-size:14px; width:160px; border:1px solid lightgray;" class="radius3" Placeholder="mm/dd/yyyy"></asp:TextBox>
                </div>
                 <div class="col-xs-6 col-sm-6 col-md-5 col-lg-5 "></div>
            </div>

            <div id ="DivShowERRates" runat ="server" class="form-group">
                <label for="LblShowEmployerRates" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right" >
                    Show Employ<b>er</b> Rates:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="text-align:left;">
                    <asp:CheckBox ID="ChkShowERRates" runat="server" AutoPostBack="true" />
                </div>
            </div>

            <asp:Panel ID="pnlOEExceptionEdit" runat="server" style="padding:10px 0px 10px 0px;">
                <div class="form-group">
                    <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right" >
                        <b style="color: green;"> OE Exceptions:</b>
                    </div>
                    <div class="col-xs-6 left">
                        <asp:GridView runat="server" ID="grdOEExceptionEdit" AutoGenerateColumns="False"  
                            HorizontalAlign="Center"
                            DataKeyNames="OEExceptionsId"
                            GridLines="None" BorderColor="#3276B1"
                            CellPadding="1"
                            OnRowDataBound="grdOEExceptionEdit_RowDataBound"
                            OnRowEditing="grdOEExceptionEdit_RowEditing"
                            OnRowCancelingEdit="grdOEExceptionEdit_RowCancelingEdit"
                            OnRowUpdating="grdOEExceptionEdit_RowUpdating" 
                            OnRowCommand="grdOEExceptionEdit_RowCommand"
                            ShowFooter="true">
                        
                              <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                            <Columns>
                                <asp:TemplateField HeaderText="Plan Type">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPlanTypeGrid" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PlanType")%>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlPlanTypeGrid" runat="server" CssClass="form-control" DataValueField="Plantypeid" DataTextField="ShortDesc"  />
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:DropDownList ID="ddlNewPlanTypeGrid" runat="server" CssClass="form-control" DataValueField="Plantypeid" DataTextField="ShortDesc"   />
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Month">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMonth" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Month")%>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlMonth" runat="server" CssClass="form-control"  Width="100px"  />
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:DropDownList ID="ddlNewMonth" runat="server" CssClass="form-control" Width="100px"  />
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="All OE Periods">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAllowOE" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "AllowOEPeriods")%>' />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                         <asp:DropDownList ID="ddlAllow" runat="server" CssClass="form-control"  Width="100px"   />                                     
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:DropDownList ID="ddlNewAllow" runat="server" CssClass="form-control"    Width="100px" />  
                                    </FooterTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Update">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit"></asp:LinkButton>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:LinkButton ID="lnkSave" runat="server" Text="Save" CommandName="Update"></asp:LinkButton>
                                        <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel"></asp:LinkButton>
                                    </EditItemTemplate>
                                    <FooterTemplate>
                                        <asp:LinkButton ID="lnkAdd" runat="server" CommandName="Add" Text="Save New" />
                                    </FooterTemplate>
                                </asp:TemplateField>
                           </Columns>
                              <FooterStyle BackColor="WhiteSmoke" HorizontalAlign="Left" />
                              <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                              <RowStyle CssClass="grdNormalrow" HorizontalAlign="Center" />
                        </asp:GridView>
                    </div>
                </div>
           </asp:Panel>

            <div id="divOwnersPretaxrule" class="form-group">
                <label for="lblPreTax" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">
                    Owners Subject to PreTax Rule: </label>
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 ">
                    <asp:RadioButtonList ID="rbPreTax" runat="server" TabIndex="10" RepeatLayout="Table" RepeatDirection="Horizontal" BorderColor="WhiteSmoke">
                        <asp:ListItem Text="&nbsp;Yes" Value="True"></asp:ListItem>
                        <asp:ListItem Text="&nbsp;No" Value="False"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>           
            
            <div id="divBenefitContactInfo" class="form-group">
                <label for="txtResourceInfo" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">
                    Benefit Contact Information:</label>
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8  ">
                    <asp:TextBox ID="txtResourceInfo" runat="server" CssClass="form-control" TabIndex="11" TextMode="MultiLine" Rows="5" ToolTip=""></asp:TextBox>
                </div>
            </div>

            <div id="divInvoicing" runat="server" class="form-group">
                <label for="ddlBilledCompany" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">
                    Billed Company:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 ">
                    <asp:DropDownList ID="ddlBilledCompany" runat="server" CssClass="form-control" TabIndex="12" DataValueField="CompanyId" DataTextField="CompanyName"></asp:DropDownList>
                </div>

                <label for="txtEmailforInvoice" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 control-label">Invoice Email:</label>
                <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3  ">
                    <asp:TextBox ID="txtEmailforInvoice" runat="server" CssClass="form-control" TabIndex="13"></asp:TextBox>
                </div>
            </div>
            
            <div id="divNotesEdit" runat="server" class="form-group">
                <label for="txtNotes" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 right">
                    Company Notes:</label>
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8  ">
                    <asp:TextBox ID="txtNotes" runat="server" CssClass="form-control" TabIndex="14" TextMode="MultiLine" Rows="5" ToolTip=""></asp:TextBox>
                </div>
            </div>
            
        </div>

        <div id="divChild" runat="server" class="well HRELightBlue">
            <div class="form-group">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 ">
                    <h4>Choose Child Companies to inherit Business Rules from <b>
                        <asp:Label ID="lblCompanyNameB" runat="server" Text="Company Name"></asp:Label></b> </h4>
                </div>

                <div class="col-xs-12 col-sm-12 col-md-10 col-lg-10 ">

                    <asp:GridView ID="grdChildCompanies" runat="server"
                        DataKeyNames="ParentCompanyId, ChildCompanyId" AutoGenerateColumns="False" Width="75%" HorizontalAlign="center"
                        GridLines="None" BorderColor="#3276B1"
                        CellPadding="4">
                        <%--  OnRowDataBound="grdChildCompanies_RowDataBound" --%>
                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                        <Columns>
                            <asp:BoundField HeaderText="Parent Company Id" DataField="ParentCompanyId" Visible="false" />
                            <asp:BoundField HeaderText="Child Company Id" DataField="ChildCompanyId" Visible="false" />
                            <asp:TemplateField HeaderText="Inherit Rules" ItemStyle-Width="20%" ItemStyle-CssClass="center">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkInherit" runat="server" AutoPostBack="true" Checked='<%# DataBinder.Eval(Container.DataItem, "InheritParentDetail")%>' OnCheckedChanged="chkInherit_CheckedChanged" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Child Company" DataField="ChildCompanyName" Visible="true" ItemStyle-Width="75%"></asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                    </asp:GridView>
                </div>
                <div class="col-xs-4 col-sm-4  hidden-md hidden-lg ">
                </div>
                <div class="col-xs-8 col-sm-8 col-md-2 col-lg-2 ">
                    <asp:CheckBox ID="chkInheritAll" runat="server" AutoPostBack="true" Checked='false' OnCheckedChanged="chkInheritAll_CheckedChanged" Text="Select all" TextAlign="Right" CssClass=" checkbox" />
                </div>

            </div>
        </div>
   
    </div>
     <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px 10px 10px 10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HRENext {padding:5px 5px 5px 5px; float:right; min-width:50px; max-width:90px; }
        .img {display: inline-block; width: auto; height: auto;}
    </style>
</asp:Content>
