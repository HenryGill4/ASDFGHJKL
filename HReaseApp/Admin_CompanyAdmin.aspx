<%@ Page Title="DO NOT USE THIS AS IT HAS BEEN REPLACED BY ADMIN_COMPANYADMINSELECT" Language="vb" AutoEventWireup="false" MasterPageFile="~/AppMasterHeader.Master" CodeBehind="Admin_CompanyAdmin.aspx.vb" Inherits="HReaseApp.Admin_CompanyAdmin" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="ltrTopMenu" runat="server"></asp:Literal>   
</asp:Content>



<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="ltrTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>


<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" Runat="Server">
  
    <div class="container ">
        <div class="form-group">
                <div class="col-xs-8 col-sm-8 col-md-6 left">
                    <br /><h3>
                        Administrator</h3>
                </div>
                 <div style="float:right; padding-right:10%;">
                    <div class="fixed">
                        <asp:ImageButton ID="imgNext" runat="server" ImageUrl="../images/ArrowBlueNext.png" Width="100%" OnMouseOver="src='/images/ArrowGreyNext.png';" OnMouseOut="src='/images/ArrowBlueNext.png';" OnClick="imgNext_Click"/>
                    </div>
                </div>
                <%-- next arrow mobile screen --%>
                <div class="col-xs-3 col-sm-3 hidden-lg hidden-md pull-right right" style="padding-right:30%;">
                    <asp:ImageButton ID="imgNextMobile" runat="server" ImageUrl="../images/ArrowBlueNext.png" Width="150px" Height="150px" OnMouseOver="src='/images/ArrowGreyNext.png';" OnMouseOut="src='/images/ArrowBlueNext.png';" OnClick="imgNext_Click" />
                </div>
            </div>
       
        <div class=" form-group">
            <div class="col-md-12">
                <asp:ValidationSummary HeaderText="<h4>Please enter a value in the following fields:</h4>" DisplayMode="SingleParagraph" EnableClientScript="true" runat="server" CssClass="alert alert-danger text-danger text-center" ValidationGroup="valAdmin" />
                <div id="divError" runat="server" visible="false">
                 <div  class="col-xs-4 col-sm-4 col-md-3 col-lg-3 center" >
                     <asp:Image id="Image1" ImageUrl="../img/RedX.png" runat="server" Width="175px" cssclass="img center" border="none"/>
                     <%--<asp:ImageButton id="btnFail" ImageUrl="../img/RedX.png" runat="server" Width="175px" cssclass=" img" />--%>
                   </div>
                   <div class="h1Error text-center col-xs-8 col-sm-8 col-md-9col-lg-9 " ><br />
                       <asp:label id="lblError" runat="server" text = "Opps!  There was an error.<br/>"></asp:label>  
                   </div>                        
                 </div>             
            </div>
        </div>
</div>


    <%----Contact Review------%>
    <div id="divReviewPick" class="container well " runat="server">
        <div  class="form-group">
            <label for="ddlAdminType" class="col-xs-4 col-sm-4  col-md-4 col-lg-4 control-label">Administrator Type:</label>
            <div class="col-xs-7 col-sm-7 col-md-5 col-lg-5">
                <asp:DropDownList ID="ddlAdminType" runat="server" CssClass="form-control" TabIndex="1" DataValueField="AdminTypeId" DataTextField="ShortDesc" AutoPostBack="true" Width="400px" OnSelectedIndexChanged="ddlAdminType_SelectedIndexChanged"></asp:DropDownList>
            </div>
        </div>

        <div  class="form-group">
            <label for="ddlCompany" class="col-xs-4 col-sm-4  col-md-4 col-lg-4 control-label">Company:</label>
            <div class="col-xs-7 col-sm-7 col-md-5 col-lg-5">
                <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-control" TabIndex="2" DataValueField="CompanyId" DataTextField="CompanyName" AutoPostBack="true" Width="400px" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged"></asp:DropDownList>
            </div>          
        </div>

        <div class="form-group">
            <label for="ddlAdmin" class="col-xs-4 col-sm-4  col-md-4 col-lg-4 control-label">Administrator:</label>
            <div class="col-xs-7 col-sm-7 col-md-5 col-lg-5">
                <asp:DropDownList ID="ddlAdmins" runat="server" CssClass="form-control" TabIndex="3" DataValueField="AdminId" DataTextField="FullName" AutoPostBack="true" Width="400px" OnSelectedIndexChanged="ddlAdmins_SelectedIndexChanged"></asp:DropDownList>
            </div>                                    
        </div>
        <div class="form-group">
             <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                <asp:ImageButton ID="btnAddAdmin" runat="server" ImageUrl="img/BlueAddBtnNew.png" OnMouseOver="src='/img/BlueAddBtnOverNew1.png';" OnMouseOut="src='/img/BlueAddBtnNew.png';" ImageAlign="Bottom" />
            </div>
        </div>
    </div>

    <%--Review Admin Contact Info--%>
    <div id="divReviewContact" class="container well-success" runat="server" visible ="false">

        <div class="form-group">
            <div class="col-xs-12 col-sm-12 col-md-10 left">
                <h4>Contact Information:</h4>
            </div>
        </div>

        <div class="form-group"> 
            <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
                <h5><b>Name and Address</b></h5>
                <asp:Label ID="lblAdminName" runat="server" class="control-label"></asp:Label><br />
                <asp:Label ID="lblAddress" runat="server" class="control-label"></asp:Label>
                <asp:Label ID="lblAddress2" runat="server" class=" control-label"></asp:Label><br />
                <asp:Label ID="lblCity" runat="server" class=" control-label"></asp:Label>&nbsp<asp:Label ID="lblState" runat="server" class=" control-label"></asp:Label>
                <asp:Label ID="lblZip" runat="server" class=" control-label"></asp:Label>
                &nbsp
                    <asp:Label ID="lblZipExtension" runat="server" class=" control-label"></asp:Label><br />
                <asp:Label ID="lblCountry" runat="server" class=" control-label"></asp:Label><br />
                <asp:Label ID="lblRegion" runat="server" class=" control-label"></asp:Label><br />
                <br />
            </div>

            <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
                <h5 ><b>Phone & Email</b></h5>
                <b>Office:</b>
                <asp:Label ID="lblWorkPhone" runat="server"></asp:Label>&nbsp;&nbsp <b>Ext:</b>&nbsp; 
                    <asp:Label ID="lblExtension" runat="server"></asp:Label><br />

                <b>Mobile:</b><asp:Label ID="lblMobile" runat="server"></asp:Label><br />
                <b>Fax:</b>
                <asp:Label ID="lblFax" runat="server"></asp:Label><br />
                <b>Email:</b>
                <asp:Label ID="lblEmail" runat="server"></asp:Label>
            </div>
            
            <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 ">
               <h5 ><b>Other</b></h5>
                <b>Admin Type:</b>
                <asp:Label ID="lblAdminType" runat="server"></asp:Label><br />
                <b>Role Type:</b>
                <asp:Label ID="lblRoleType" runat="server"></asp:Label><br />
                <b>Begin Date:</b>
                <asp:Label ID="lblAdminBeginDate" runat="server"></asp:Label><br />
                <b>End Date:</b>
                <asp:Label ID="lblAdminEndDate" runat="server"></asp:Label><br />
                <b>Active User:</b>
                <asp:Label ID="lblActive" runat="server"></asp:Label><br />
            </div>
        </div>

        <div class="form-group">
            <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                <asp:ImageButton ID="btnEditAdmin" runat="server" ImageUrl="img/GreenEditBtnNew.png" OnMouseOver="src='/img/GreenEditBtnOverNew.png';" OnMouseOut="src='/img/GreenEditBtnNew.png';" ImageAlign="Bottom" />
            </div>           
        </div>
    </div>

    <%----Admin Contact Edit------%>
    <div id="divEdit" class="container well-success" runat="server">
        <div class="form-group">
            <label for="lblAdminId" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 control-label">Admin Id:</label>
            <div class="col-xs-2 col-sm-2 col-md-2  ">
                 <p class="form-control-static"> <asp:Label ID="lblAdminId" runat="server" class="control-label"></asp:Label></p>  
            </div>
             <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                 <p class="form-control-static text-success "> * Required fields</p>  
             </div> 
        </div>

        <div class="form-group  has-success">
            <label for="txtFirstName" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 control-label">Name:</label>
            <div class="col-xs-4 col-sm-4 col-md-3 right ">
                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" TabIndex="10" placeholder="First" ToolTip="First Name"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="txtFirstName" ErrorMessage="<h4>First Name</h4>" Text="" runat="server" Display="None" ValidationGroup="valAdmin" />
            </div>
            <%--<div class="col-xs-2 col-sm-2 col-md-1"></div>--%>
            <div class="col-xs-4 col-sm-4 col-md-3 right ">
                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" TabIndex="11" placeholder="Last" ToolTip="Last Name"><span class=" text-muted" ><i>* Required</i></span></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="txtLastName" ErrorMessage="<h4>Last Name</h4>" Text="" runat="server" Display="None" ValidationGroup="valAdmin" />
            </div>
        </div>

        <div class="form-group">
            <label for="ddlEAdminType" class="col-xs-3 col-sm-3 col-md-2 col-lg-2 control-label">Admin Type:</label>
            <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2">
                 <p class="form-control-static"><asp:Label ID="lblEAdminType" runat="server" class="control-label"></asp:Label></p>                
            </div>
        </div>

        <%-- REMOVED THIS AND MADE A SEPARATE SECTION FOR COMPANY ADMIN INFO
            <div class="form-group">   
                <label for="ddlECompany" class="col-xs-4 col-sm-4  col-md-2 col-lg-2 control-label">Company:</label>
                <div class="col-xs-7 col-sm-7 col-md-5 col-lg-5">
                    <asp:DropDownList ID="ddlECompany" runat="server" CssClass="form-control" TabIndex="4" DataValueField="CompanyId" DataTextField="CompanyName"></asp:DropDownList>
                    <asp:Label ID="lblECompany" runat="server" class="control-label"  Visible="false"></asp:Label>

                    <asp:LinkButton ID="lnkCompany" runat="server"  data-toggle="modal" data-target="#ModalEnroller" CssClass="text-success"> 
                <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
                         Assign to Companies
                     </asp:LinkButton> 
                </div>
            </div>--%>

        <div class="form-group">
            <label for="ddlRoleType" class="col-xs-3 col-sm-3 col-md-2 control-label">Role Type:</label>
            <div class="col-xs-5 col-sm-5 col-md-3 ">
                <asp:DropDownList ID="ddlRoleType" runat="server" CssClass="form-control" TabIndex="13" DataValueField="RoleTypeId" DataTextField="ShortDesc" AutoPostBack ="true">
                </asp:DropDownList>
            </div>
        </div>

        <div class="row">
            <div class="col-md-2">
                <br />
            </div>
        </div>
        <div class="form-group">
            <label for="txtRegion" class="col-xs-3 col-sm-3 col-md-2 control-label">Region:</label>
            <div class="col-xs-8 col-sm-8 col-md-5 ">
                <asp:TextBox ID="txtRegion" runat="server" CssClass="form-control" TabIndex="14" placeholder="Region"></asp:TextBox>
            </div>
        </div>

        <div class="form-group">
            <label for="txtAddress1" class="col-xs-3 col-sm-3 col-md-2 control-label">Address:</label>
            <div class="col-xs-8 col-sm-8 col-md-5 ">
                <asp:TextBox ID="txtAddress1" runat="server" CssClass="form-control" TabIndex="15" placeholder="Line 1"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ControlToValidate="txtAddress1" ErrorMessage="<h4>Address Line 1</h4>" Text="" runat="server" Display="None" ValidationGroup="valAdmin" />--%>
            </div>
        </div>

        <div class="form-group">
            <div class="col-xs-3 col-sm-3 col-md-2 ">
            </div>
            <div class="col-xs-8 col-sm-8 col-md-5 ">
                <asp:TextBox ID="txtAddress2" runat="server" CssClass="form-control" TabIndex="16" placeholder="Line 2"></asp:TextBox>
            </div>
        </div>

        <div class="form-group">
            <label for="txtCity" class="col-xs-3 col-sm-3 col-md-2 control-label">City:</label>
            <div class="col-xs-8  col-sm-8 col-md-5 ">
                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" TabIndex="17" placeholder="City"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ControlToValidate="txtCity" ErrorMessage="<h4>City</h4>" Text="" runat="server" Display="None" ValidationGroup="valAdmin" />--%>
            </div>
        </div>

        <div class="form-group">
            <label for="ddlState" class="col-xs-3 col-sm-3 col-md-2 control-label">State:</label>
            <div class="col-xs-2 col-sm-2  col-md-1 ">
                <asp:DropDownList ID="ddlState" runat="server" CssClass="selectpicker" TabIndex="18" DataValueField="ShortDesc" DataTextField="ShortDesc" Width="80px"></asp:DropDownList>
            </div>

            <label for="ddlCountry" class="col-xs-2 col-sm-2 col-md-2  control-label ">Country:</label>
            <div class="col-xs-2 col-sm-2 col-md-1 ">
                <asp:DropDownList ID="ddlCountry" runat="server" CssClass="selectpicker" TabIndex="19" DataValueField="ShortDesc" DataTextField="ShortDesc" Width="80px"></asp:DropDownList>
            </div>
        </div>

        <div class="form-group">
            <label for="txtZip" class="col-xs-3 col-sm-3 col-md-2 control-label">Zip:</label>
            <div class="col-xs-2 col-sm-2 col-md-1">
                <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" TabIndex="20" placeholder="Zip" Width="80px" MaxLength="5"></asp:TextBox>
            </div>
            <div class="col-xs-2 col-sm-2 col-md-1 pull-left ">
                <asp:TextBox ID="txtZipExt" runat="server" CssClass="form-control" TabIndex="21" placeholder="Plus 4" Width="80px" MaxLength="4"></asp:TextBox>
            </div>
            <%--<asp:RequiredFieldValidator ControlToValidate="txtZip" ErrorMessage="<h4>Zip</h4>" Text="" runat="server" Display="None" ValidationGroup="valAdmin" />--%>
            <asp:RegularExpressionValidator ID="valrZip" runat="server" ControlToValidate="txtZip" ValidationExpression="\d{5}" ErrorMessage="<h4> Zip Code is not formatted correctly <i>(12345) </i></h4>" ValidationGroup="valAdmin" Display="None" />
            <asp:RegularExpressionValidator ID="valZipext" runat="server" ControlToValidate="txtZipExt" ValidationExpression="\d{4}" ErrorMessage="<h4> Zip Code Ext is not formatted correctly <i>(1234) </i></h4>" ValidationGroup="valAdmin" Display="None" />
        </div>

        <div class="row">
            <div class="col-md-2">
                <br />
            </div>
        </div>


        <div class="form-group">
            <label for="txtOffice" class="col-xs-3 col-sm-3 col-md-2 control-label">Work Phone:</label>
            <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2">
                <asp:TextBox ID="txtOffice" runat="server" CssClass="form-control" TabIndex="22" placeholder="555-555-5555"></asp:TextBox>
                <asp:RegularExpressionValidator ID="regWorkPhone" runat="server" ControlToValidate="txtOffice" ValidationExpression="^(\(?\s*\d{3}\s*[\)\-\.]?\s*)?[2-9]\d{2}\s*[\-\.]\s*\d{4}$" ErrorMessage="<h4>Work phone number is not formatted correctly <i>(999-999-9999 or (999)999-9999) </i></h4>" ValidationGroup="valAdmin" Display="None" />
            </div>
            <label for="txtExtension" class="col-xs-3 col-sm-3 col-md-2 control-label">Extension:</label>
            <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                <asp:TextBox ID="txtExtension" runat="server" CssClass="form-control" TabIndex="23" placeholder="9999"></asp:TextBox>
            </div>
        </div>

        <div class="form-group">
            <label for="txtMobile" class="col-xs-3 col-sm-3 col-md-2 control-label">Mobile Phone:</label>
            <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2">
                <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" TabIndex="24" placeholder="555-555-5555"></asp:TextBox>
                <asp:RegularExpressionValidator ID="regMobilePhone" runat="server" ControlToValidate="txtMobile" ValidationExpression="^(\(?\s*\d{3}\s*[\)\-\.]?\s*)?[2-9]\d{2}\s*[\-\.]\s*\d{4}$" ErrorMessage="<h4>Mobile phone number is not formatted correctly <i>(999-999-9999 or (999)999-9999) </i></h4>" ValidationGroup="valAdmin" Display="None" />
            </div>
             <label for="txtExtension" class="col-xs-3 col-sm-3 col-md-2 control-label">Fax:</label>
            <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                <asp:TextBox ID="txtFax" runat="server" CssClass="form-control" TabIndex="25" placeholder="555-555-5555"></asp:TextBox>
                  <asp:RegularExpressionValidator ID="regFaxPhone" runat="server" ControlToValidate="txtFax" ValidationExpression="^(\(?\s*\d{3}\s*[\)\-\.]?\s*)?[2-9]\d{2}\s*[\-\.]\s*\d{4}$" ErrorMessage="<h4>Fax number is not formatted correctly <i>(999-999-9999 or (999)999-9999) </i></h4>" ValidationGroup="valAdmin" Display="None" />

            </div>
        </div>
      
        <div class="form-group  has-success   ">
            <label for="txtEmail" class="col-xs-3 col-sm-3 col-md-2 control-label">Email Address:</label>
            <div class="col-xs-8 col-sm-8 col-md-4">  
                                          
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TabIndex="26" placeholder="abc@company.com" aria-describedby="inputSuccess2Status">                         

                        </asp:TextBox> 
                <%-- <span class="input-group-addon glyphicon glyphicon-exclamation-sign"></span>--%>
                <asp:RequiredFieldValidator ControlToValidate="txtEmail" ErrorMessage="<h4>Email Address</h4>" Text="" runat="server" Display="None" ValidationGroup="valAdmin" />
                <asp:RegularExpressionValidator ID="valrEmail1" runat="server" ControlToValidate="txtEmail" ValidationExpression="^(.+)@([^\.].*)\.([a-z]{2,})$" ErrorMessage="<h4>Email is not formatted correctly<i>(email@provider.com) </i></h4>" ValidationGroup="valAdmin" Display="None" />
            </div>
       </div>
       
        <div class="form-group  has-success">
            <label for="txtAdminBeginDate" class="col-xs-3 col-sm-3 col-md-2 control-label">Begin Date:</label>
            <div class="col-xs-3 col-sm-3 col-md-2 ">
                <asp:TextBox ID="txtAdminBeginDate" runat="server" CssClass="form-control" TabIndex="27" placeholder="mm/dd/yyyy" ToolTip="Begin Date of Admin"></asp:TextBox>
                <asp:RequiredFieldValidator ControlToValidate="txtAdminBeginDate" ErrorMessage="<h4>Begin Date</h4>" Text="" runat="server" Display="None" ValidationGroup="valAdmin" />
                <asp:CompareValidator ID="cmvalBeginDate" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtAdminBeginDate" ErrorMessage="<h4>Begin Date is not formatted correctly (mm/dd/yyyy)</h4>" Display="None" ValidationGroup="valAdmin"></asp:CompareValidator>

            </div>
        </div>

        <div class="form-group">
            <label for="txtAdminEndDate" class="col-xs-3 col-sm-3 col-md-2 control-label">End Date:</label>
            <div class="col-xs-3 col-sm-3 col-md-2 ">
                <asp:TextBox ID="txtAdminEndDate" runat="server" CssClass="form-control" TabIndex="28" placeholder="mm/dd/yyyy" ToolTip="End Date of Admin" AutoPostBack="true" OnTextChanged="UpdateEndDate"></asp:TextBox>
                <asp:CompareValidator ID="cmvalEndDate" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtAdminEndDate" ErrorMessage="<h4>End Date is not formatted correctly (mm/dd/yyyy)</h4>" Display="None" ValidationGroup="valAdmin"></asp:CompareValidator>
            </div>
            <div class="col-xs-4 col-sm-4 col-md-6 pull-right">
                <asp:CheckBox ID="chkActive" runat="server" CssClass="checkbox" TabIndex="29" Text="Active" TextAlign="Right"></asp:CheckBox>

            </div>
           
        </div>
         <div class="form-group">
              <div class="col-xs-3 col-sm-3 col-md-2 "></div>
              <div class="col-xs-3 col-sm-3 col-md-6 ">
               <asp:label id="lblErrorActive" runat="server" CssClass="text-danger text-center" text = "Opps!  There was an error." Visible="false"></asp:label>  
                  </div>

              <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2  pull-right">
                <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" ImageAlign="AbsMiddle" TabIndex="35" />
            </div>

            <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2  pull-right">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="36" ValidationGroup="valAdmin"  />
            </div>
             </div>





    </div>

    <%--   Lower section Assigned Companies--%>
    <div id="divCompanies" class="container well-success" runat="server" visible ="false">
        <div class="form-group">
            <div class="col-xs-10 col-sm-10 col-md-8 col-lg-8 ">
                <h4>Assigned Companies:</h4>
                <br />
                <asp:GridView ID="grdCurrentCompanies" runat="server"
                    DataKeyNames="CompanyAdminId, CompanyId" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                    GridLines="None" BorderColor="#3276B1"
                    CellPadding="4"
                    EmptyDataText="Not currently assigned.">
                    <%--  OnSelectedIndexChanged="OnSelectedIndexChanged"> --%>
                    <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                    <Columns>
                        <asp:BoundField HeaderText="Company Id" DataField="CompanyId" Visible="false" />
                        <asp:BoundField HeaderText="Company Admin Id" DataField="CompanyAdminId" Visible="false" />
                        <asp:BoundField HeaderText="Company Name" DataField="CompanyName" Visible="true" HtmlEncode="false"></asp:BoundField>
                        <asp:TemplateField HeaderText="Begin Date">
                            <ItemTemplate>
                                <asp:Label ID="lblBeginDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' />
                                <asp:TextBox ID="txtBeginDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' Width="100px"  CssClass="form-control"/>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="End Date">
                            <ItemTemplate>
                                <asp:Label ID="lblEndDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' />
                                <asp:TextBox ID="txtEndDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' Width="100px" CssClass="form-control" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--                                <asp:BoundField HeaderText="Begin Date" DataField="BeginDate" Visible="true" HtmlEncode="false"></asp:BoundField>
                            <asp:BoundField HeaderText="End Date" DataField="EndDate" Visible="true" HtmlEncode="false"></asp:BoundField>--%>
                    </Columns>
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                    <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                </asp:GridView>
            </div>
        </div>

        <div class="form-group">
            <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">

                <asp:ImageButton ID="btnEditCompanyAdmin" runat="server" ImageUrl="img/GreenEditBtnNew.png" OnMouseOver="src='/img/GreenEditBtnOverNew.png';" OnMouseOut="src='/img/GreenEditBtnNew.png';" ImageAlign="AbsBottom" />
                <asp:ImageButton ID="btnCancelCompanyAdmin" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" ImageAlign="AbsMiddle" TabIndex="40" />
            </div>
            <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                <asp:ImageButton ID="btnAddCompanyAdmin" runat="server" ImageUrl="img/BlueAddBtnNew.png" OnMouseOver="src='/img/BlueAddBtnOverNew1.png';" OnMouseOut="src='/img/BlueAddBtnNew.png';" ImageAlign="Right" data-toggle="modal" data-target="#ModalEnroller" OnClientClick="return false"/>
                <asp:ImageButton ID="btnSaveCompanyAdmin" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="41" ValidationGroup="valAdmin" />
            </div>
        </div>
    </div>

    <%--  Add Companies Modal--%>
    <div class="modal fade" id="ModalEnroller" tabindex="-1" role="dialog" aria-labelledby="myModalEnroller" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title text-success" id="myModalInfoLabel">
                        <asp:Label ID="mlblInfoTitle" runat="server" Text="Assign Company"></asp:Label></h4>
                </div>
                <div class="modal-body ">
                    <div class="well ">
                        <div class="form-group">
                            <asp:Label ID="mlblInfoText1" runat="server" class="col-md-12 " Text="Assign or unassign Enroller to Company"></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="mlblInfoText2" runat="server" class="col-md-12 "></asp:Label>
                        </div>
                        <div class="form-group">
                           <div class=" col-xs-12 col-sm-12 col-md-12" style="max-height: 300px; overflow-y: scroll;">
                               <%-- <asp:ScriptManager ID="ScriptManager1" runat="server" />
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>--%>

                                        <asp:GridView ID="grdAssignNewCompany" runat="server"
                                            DataKeyNames="CompanyId, CompanyAdminId, Assign" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                                            GridLines="None" BorderColor="#3276B1"
                                            CellPadding="4"
                                            EmptyDataText="No Companies found."
                                            AlternatingRowStyle-CssClass="grdNormalAltrow">
                                            <%--  OnSelectedIndexChanged="OnSelectedIndexChanged"> --%>
                                            <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                            <Columns>
                                                <asp:BoundField HeaderText="Company Id" DataField="CompanyId" Visible="false" />
                                                <asp:BoundField HeaderText="Company Admin Id" DataField="CompanyAdminId" Visible="false" />
                                                <asp:TemplateField HeaderText="Assign">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkAssign" runat="server" Checked='<%# IIf(DataBinder.Eval(Container.DataItem, "Assign").ToString().Equals("True"), "True", "False")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="Company Name" DataField="CompanyName" Visible="true" HtmlEncode="false"></asp:BoundField>
                                            </Columns>
                                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                            <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                            <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                                        </asp:GridView>
                                 <%--   </ContentTemplate>
                                </asp:UpdatePanel>--%>
                            </div>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="mlblInfoText3" runat="server" class="col-md-12"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:ImageButton ID="mbtnSave" ImageUrl="../img/GreenSaveBtn.png" runat="server" OnMouseOver="src='/img/GreenSaveBtnOver.png';" OnMouseOut="src='/img/GreenSaveBtn.png';"></asp:ImageButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>


