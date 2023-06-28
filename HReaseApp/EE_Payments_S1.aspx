<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AppMasterHeaderSplit.Master"  CodeBehind="EE_Payments_S1.aspx.vb" Inherits="HReaseApp.EE_Payments_S1" %>



<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainBlock" runat="Server">
     
    <div id="divAccept" runat="server" class="container-fluid" >
        <div class="form-group">
            <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">
                <br />
                <h3>
                    <asp:Label ID="lblMainArticleTitle" runat="server"></asp:Label>
                </h3>

            </div>
           <%-- <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 pull-right right">
                <asp:ImageButton ID="imgNext" runat="server" ImageUrl="../img/BlueArrowNext.png" OnMouseOver="src='/img/BlueArrowNextOver.png';" OnMouseOut="src='/img/BlueArrowNext.png';" background="#fff" BackColor="White" BorderStyle="None" Visible="true" PostBackUrl="~/EE_Welcome.aspx" />
            </div>--%>
        </div>
                
       <div class=" form-group">
            <div class="col-md-12">
                <asp:ValidationSummary HeaderText="<h4>Please enter a value in the following fields:</h4>" DisplayMode="SingleParagraph" EnableClientScript="true" runat="server" CssClass="alert alert-danger text-danger text-center" ValidationGroup="valAccept"/>
                <div id="divError" class='alert alert-danger text-center text-danger' runat="server" visible="false">
                    <h4>
                        <asp:Label ID="lblError" runat="server" Text=""></asp:Label></h4>
                </div>
            </div>
        </div>
         
<%--         <div class="form-group">
                 <div id="divSuccess" runat="server" class="col-md-12 text-center"  visible ="false">
                     <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="175px" cssclass=" img" />
                     <h1><br />Congratulations, you have completed the enrollment process</h1>
                 </div>
            </div>--%>

             <div class="form-group"  id="divFail" runat="server" visible ="false" >
                 <div  class="col-xs-4 col-sm-4 col-md-3 col-lg-3 center " >
                     <asp:Image id="imgFail" ImageUrl="../img/RedX.png" runat="server" Width="175px" cssclass=" img" border="none"/>
                     <%--<asp:ImageButton id="btnFail" ImageUrl="../img/RedX.png" runat="server" Width="175px" cssclass=" img" />--%>
                   </div>
                   <div class=" h2Error text-center col-xs-8 col-sm-8 col-md-9 col-lg-9 " ><br />
                       <asp:label id="lblErrorMessage" runat="server" text = "Opps!  There was an error.<br/>"></asp:label>  
                   </div>                        
                 </div>
        

        <div class="well-success">

            
             <div class="form-group">
                  <div class="col-md-12">
                 <asp:Label ID="lblMainArticleText" runat="server" Font-Size="Larger" >Please Validate and if necessary modify your Credit Card Billing Information before clicking the Accept Button </asp:Label>
                    </div>
            </div>

            <%-- Capture Initials Area--%>
        

            <div class="form-group">

               <div class="form-group">
                   <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                        <p class="form-control-static text-success "><a style="COLOR: red">*</a> Required fields</p>
                   </div>
               </div>

                <div class="form-group">

                    <label for="txtFirstName" class="col-xs-2 col-sm-2 col-md-2 control-label"><a style="COLOR: red">*</a>Name:</label>
                    <div class="col-xs-10 col-sm-7 col-md-2 right  has-success">
                    <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" TabIndex="6" placeholder="First" ToolTip="First Name"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtFirstName" ErrorMessage="<h4>First Name</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                    </div>

                    <div class="col-xs-2 col-sm-2 col-md-1"></div>

                    <div class="col-xs-10 col-sm-8 col-md-2 right has-success ">
                    <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" TabIndex="8" placeholder="Last" ToolTip="Last Name"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtLastName" ErrorMessage="<h4>Last Name</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                    </div>
                </div>

                        <div class="form-group has-success">
                            <label for="txtAddress1" class="col-xs-2 col-md-2 control-label"><a style="COLOR: red">*</a>Address:</label>
                            <div class="col-xs-8 col-sm-8 col-md-5 ">
                                <asp:TextBox ID="txtAddress1" runat="server" CssClass="form-control" TabIndex="10" placeholder="Line 1" ToolTip="Address"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="txtAddress1" ErrorMessage="<h4>Address Line 1</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="txtAddress2" class="col-xs-2 col-md-2 control-label"><a style="COLOR: red">*</a>Address 2:</label>
                            <div class="col-xs-8 col-sm-8 col-md-5 ">
                                <asp:TextBox ID="txtAddress2" runat="server" CssClass="form-control" TabIndex="10" placeholder="Line 1" ToolTip="Address Line 2"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="txtAddress2" ErrorMessage="<h4>Address Line 2</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                            </div>
                        </div>

                        <div class="form-group has-success">
                            <label for="txtCity" class="col-xs-2 col-md-2  control-label  "><a style="COLOR: red">*</a>City:</label>
                            <div class="col-xs-8 col-sm-8  col-md-5 ">
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" TabIndex="12" placeholder="City"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="txtCity" ErrorMessage="<h4>City</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                            </div>
                        </div>

                        <div class="form-group has-success">
                            <label for="ddlState" class="col-xs-2 col-sm-2 col-md-2 control-label"><a style="COLOR: red">*</a>State:</label>
                            <div class="col-xs-10 col-sm-10 col-md-1 ">
                                <asp:DropDownList ID="ddlState" runat="server" CssClass="selectpicker" TabIndex="13" DataValueField="ShortDesc" DataTextField="ShortDesc" Width="80px"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="form-group has-success">
                            <label for="ddlCountry" class="col-xs-2 col-sm-2  col-md-2 control-label "><a style="COLOR: red">*</a>Country:</label>
                            <div class="col-xs-10  col-sm-10 col-md-2 ">
                                <asp:DropDownList ID="ddlCountry" runat="server" CssClass="selectpicker" TabIndex="14" DataValueField="ShortDesc" DataTextField="ShortDesc" Width="80px"></asp:DropDownList>
                            </div>
                        </div>

                       <div class="form-group  ">
                            <div class="has-success">
                                <label for="txtZip" class="col-xs-2 col-md-2  control-label"><a style="COLOR: red">*</a>Zip:</label>
                                <div class="col-xs-2 col-md-1">
                                    <asp:TextBox ID="txtZip" runat="server" CssClass="form-control " TabIndex="15" placeholder="Zip" Width="80px" MaxLength="5"></asp:TextBox>
                                </div>
                            </div>

                            <asp:RequiredFieldValidator ControlToValidate="txtZip" ErrorMessage="<h4>Zip</h4>" Text="" runat="server" Display="None" ValidationGroup="valContact" />
                            <asp:RegularExpressionValidator ID="valrZip" runat="server" ControlToValidate="txtZip" ValidationExpression="\d{5}" ErrorMessage="<h4> Zip Code is not formatted correctly <i>(12345) </i></h4>" ValidationGroup="valContact" Display="None" />
                        </div>


                        <div class="form-group ">
                            <label for="txtPhone" class="col-xs-2 col-sm-2 col-md-2 control-label">Phone:</label>
                            <div class="col-xs-10 col-sm-10 col-md-3">
                                 <div class="input-group ">
                                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" TabIndex="17" placeholder="Phone" ToolTip="Phone"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="valPhone" runat="server" ControlToValidate="txtPhone" ValidationExpression="^(\(?\s*\d{3}\s*[\)\-\.]?\s*)?[2-9]\d{2}\s*[\-\.]\s*\d{4}$" ErrorMessage="<h4>Phone number is not formatted correctly<i>(999-999-9999 or (999)999-9999) </i></h4>" ValidationGroup="valContact" Display="None" />
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="has-success">
                                <label for="txtEmail" class="col-xs-2 col-sm-2 col-md-2 control-label "><a style="COLOR: red">*</a>Email:</label>
                                <div class="col-xs-10 col-sm-10 col-md-3">
                                    <div class="input-group ">
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control " TabIndex="20" placeholder="Email"></asp:TextBox>
                                        <%-- ^(.+)@([^\.].*)\.([a-z]{2,})$--%>
                                        <asp:RegularExpressionValidator ID="valrEmail1" runat="server" ControlToValidate="txtEmail" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" ErrorMessage="<h4>Email is not formatted correctly<i>(email@provider.com) </i></h4>" ValidationGroup="valContact" Display="None" />
                                    </div>
                                </div>
                            </div>
                        </div>

            <div class="form-group">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 right">
                    <asp:ImageButton ID="btnAccept" runat="server" ImageUrl="../img/GreenAcceptBtn.png" OnMouseOver="src='/img/GreenAcceptBtnOver2.png';" OnMouseOut="src='/img/GreenAcceptBtn.png';"  BorderStyle="None"  Width="125px" ValidationGroup="valAccept"/>
                    <%--<asp:ImageButton ID="btnAccept" runat="server" ImageUrl="../img/GreenAcceptBtn.png" OnMouseOver="src='/img/GreenAcceptBtnOver2.png';" OnMouseOut="src='/img/GreenAcceptBtn.png';"  BorderStyle="None"  Width="125px" ValidationGroup="valAccept" />--%>
                    <%--<asp:Button   runat="server"    Text="Next" ID="submitStepOne"  OnClientClick="stepOneSubmit_Click" ></asp:Button>--%>
                </div>
            </div>

            </div>
             <div class="form-group">
                 <br />
            </div>



           



        </div>

    </div>
         
</asp:Content>





<asp:Content ID="SideMenu1" ContentPlaceHolderID="SideMenu1" runat="Server">
    <div class="container-fluid">
        <br /><br />
        <div class="row">
            <div class="col-md-11 text-info text-center">
                <span class="text-success">% Complete</span>
                <div class="progress progress-striped active">
                    <div id="divProgressBar" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="30" aria-valuemin="20" aria-valuemax="100" style="width: 98%" runat="server">
                        <strong>
                            <asp:Label ID="lblProgress" Text="98" runat="server"></asp:Label></strong>
                    </div>
                </div>
            </div>
        </div>


        <div id="divSummary" class="well">          
            
                <h4> Contribution Summary</h4>
         
            <div class="row">
                <div class="col-md-12">

                    <asp:GridView ID="grdSummary" runat="server" AutoGenerateColumns="false" Width="95%" HeaderStyle-CssClass="text-success" BorderStyle="None">
                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                        <Columns>
                            <asp:BoundField HeaderText="Plan Type" DataField="PlanTypeShortDesc"></asp:BoundField>
                            <asp:BoundField HeaderText="EE Cost" DataField="EECost" DataFormatString="{0:c}" HtmlEncode="False" ItemStyle-CssClass="text-right" HeaderStyle-CssClass="center"></asp:BoundField>
                            <%-- <asp:BoundField HeaderText="ER Cost" DataField="ERCost" DataFormatString="{0:c}" HtmlEncode="False"></asp:BoundField>--%>
                        </Columns>
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                    </asp:GridView>
                </div>
            </div>              
        </div>
    </div>
</asp:Content>

<asp:Content ID="Dependents" ContentPlaceHolderID="Benefit" runat="Server">
     <div class="container-fluid">
    <div id="divCalculator" class="well-white" runat="server">
       
            <h4>Total Employee Contribution </h4>
        
        <div class="row">
            <div id="calculator" class="calculator">
                <h4>
                    <asp:Label ID="lblSum" runat="server" Text="123456" CssClass="lblposition"></asp:Label></h4>
            </div>
        </div>
    </div>
</div>
</asp:Content>

 <asp:Content ID="Client" ContentPlaceHolderID="Client" runat="Server">
  </asp:Content>