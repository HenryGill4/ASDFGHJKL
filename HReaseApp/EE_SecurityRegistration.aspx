<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AppMaster.master" CodeBehind="EE_SecurityRegistration.aspx.vb" Inherits="HReaseApp.EE_SecurityRegistration" %>

<asp:Content ID="MainBlock" ContentPlaceHolderID="MainBlock" runat="Server">
  <div id="wrapper">
      <!-- PAGE TITLE -->
			<header id="page-title">
				<div class="container">
					<h1>Registration</h1>
					<ul class="breadcrumb">
						<li><a href="Corporate/CorporateHome.aspx">Home</a></li>
                        <li><a href="CorporateLogin.aspx">Login</a></li>
						<li class="active">Registration</li>
					</ul>                   
				</div>
			</header>

          
      <section id="MainSection" class="container ">

        <h3>
            <asp:Label ID="lblMainArticleTitle" runat="server"></asp:Label>
        </h3>
        <div class="well white-row">
            <asp:Label ID="lblMainArticleText" runat="server"> </asp:Label>

         
            <div id="divLoginType" runat="server">
                <div class="row form-horizontal" >
                    <label for="rdEmployee" class="col-xs-5 col-sm-5 col-md-5 text-right control-label">Login Type:  </label>
                    <div class="col-xs-5 col-sm-5 col-md-5">
                       
                        <asp:RadioButton ID="rdEmployee" runat="server" GroupName="grpWho" CssClass="radio"  Text="Employee"  Checked ="true"   />
                        <asp:RadioButton ID="rdAdmin" runat="server" GroupName="grpWho" CssClass="radio"  Text="Administrator" />
                    </div>

                    <div class="col-xs-2 col-sm-2 col-md-2 pull-right right">
                        <asp:ImageButton ID="btnLoginTypeNext" runat="server" ImageUrl="img/BlueNextBtn.png" ImageAlign="AbsMiddle" OnMouseOver="src='/img/BlueNextBtnOver.png';" OnMouseOut="src='/img/BlueNextBtn.png';" TabIndex="5" width="95" />

                    </div>
                </div>
            </div>
        </div>
    

    <asp:ValidationSummary HeaderText="<h4>Please enter a value in the following fields:</h4>" DisplayMode="SingleParagraph" EnableClientScript="true" runat="server" CssClass="alert alert-danger text-danger text-center" ValidationGroup="vUserPass" />
    <asp:ValidationSummary HeaderText="<h4>Please enter a value in the following fields:</h4>" DisplayMode="SingleParagraph" EnableClientScript="true" runat="server" CssClass="alert alert-danger text-danger text-center" ValidationGroup="vSecQuestion" />
    <asp:ValidationSummary HeaderText="<h4>Please enter a value in the following fields:</h4>" DisplayMode="SingleParagraph" EnableClientScript="true" runat="server" CssClass="alert alert-danger text-danger text-center" ValidationGroup="vForgot" />

    <div id="divError" class='alert alert-danger text-center text-danger' runat="server" visible="false">
        <h4><asp:Label ID="lblError" runat="server" Text=""></asp:Label></h4>
    </div>

    <div id="divSuccessRegistration" class=' alert alert-success text-center text-success' runat="server" visible="false">
        <h4>You have successfully completed the Initial Registration Process and will be redirected to your Employee Dashboard. </h4>
    </div>

    <div id="divSuccessForgotPassword" class=' alert alert-success text-center text-success' runat="server" visible="false">
        <h4>You have successfully updated your Login information.  You will now be redirected to your Employee Dashboard.  </h4>
    </div>

    <div class="well-success" id="divForgot" runat="server">

        <div id="divRegistrationType" runat="server">
            <div class="form-horizontal">
                <br /><br />
                <label for="txtRegistrationKey" class="col-xs-6 col-sm-6 col-md-6 text-right control-label ">Did your employer provide you with a Registration Key:</label>
                <div class="col-xs-2 col-sm-2 col-md-2">
                    <asp:RadioButtonList ID="rdOnboarding" runat="server" CssClass="radio"  >
                        <asp:ListItem Value="1" Text="Yes" ></asp:ListItem>
                        <asp:ListItem Value="0" Text="No"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>
            <div class="form-group">
                <div class="col-xs-2 col-sm-2 col-md-2 pull-right right">
                    <asp:ImageButton ID="imgNextEmpType" runat="server" ImageUrl="img/BlueNextBtn.png" ImageAlign="AbsMiddle" OnMouseOver="src='/img/BlueNextBtnOver.png';" OnMouseOut="src='/img/BlueNextBtn.png';" TabIndex="5"  Width="95" OnClick="imgNextEmpType_Click" />
                </div>
            </div>
        </div>

        <div id="divOnboarding" runat="server">
           <h4> Please enter the Registration key provided by your employer.</h4>
            <div class="form-group">
                <label for="txtRegistrationKey" class="col-xs-5 col-sm-5 col-md-5 text-right control-label">Registration Key</label>
                <div class=" col-xs-4 col-sm-4 col-md-4">
                    <asp:TextBox ID="txtRegistrationKey" TabIndex="1" CssClass="form-control" runat="server" ValidationGroup="vForgotKey"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtRegistrationKey" ErrorMessage="<h4>Regstration Key</h4>" Text="" runat="server" Display="None" ValidationGroup="vForgotKey" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-xs-2 col-sm-2 col-md-2 pull-right right">
                    <asp:ImageButton ID="imgSearchRegEmp" runat="server" ImageUrl="img/BlueNextBtn.png" ImageAlign="AbsMiddle" OnMouseOver="src='/img/BlueNextBtnOver.png';" OnMouseOut="src='/img/BlueNextBtn.png';" TabIndex="5" ValidationGroup="vForgotKey" Width="95" OnClick="imgSearchRegEmp_Click" />
                </div>
            </div>
        </div>


        <div id="divManualSearch" runat="server">
             <h4> Please provide the following information.</h4>
            <div class="form-group">
                <label for="txtCompany" class="col-xs-5 col-sm-5 col-md-5 text-right control-label">Company Number</label>
                <div class="col-xs-4 col-sm-4 col-md-4">
                    <asp:TextBox ID="txtCompany" TabIndex="1" CssClass="form-control" runat="server" placeholder="9999" ValidationGroup="vForgot"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtCompany" ErrorMessage="<h4>Company Number</h4>" Text="" runat="server" Display="None" ValidationGroup="vForgot" />
                </div>
            </div>

            <div class="form-group">
                <label for="txtName" class="col-xs-5 col-sm-5 col-md-5 text-right control-label">Last Name</label>
                <div class="col-xs-4 col-sm-4 col-md-4">
                    <asp:TextBox ID="txtLastName" TabIndex="2" CssClass="form-control" runat="server" placeholder="Last Name" MaxLength="50" ValidationGroup="vForgot"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="txtLastName" ErrorMessage="<h4>Last Name</h4>" Text="" runat="server" Display="None" ValidationGroup="vForgot" />
                </div>
                <div class="col-xs-2 col-sm-2 col-md-2"></div>
            </div>

            <div id="divLoginTypeAdmin" runat="server">
                <div class="form-group">
                
                     <label for="txtEmail" class="col-xs-5 col-sm-5 col-md-5 text-right control-label">Email Address</label>
                    <div class="col-xs-4 col-sm-4 col-md-4">
                        <asp:TextBox ID="txtEmail" TabIndex="3" CssClass="form-control" runat="server" placeholder="anyoneanywhere.com" MaxLength="200" ValidationGroup="vForgot"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="txtEmail" ErrorMessage="<h4>Email Address</h4>" Text="" runat="server" Display="None" ValidationGroup="vForgot" />
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 pull-right right">
                        <asp:ImageButton ID="btnSearchAdmin" runat="server" ImageUrl="img/BlueNextBtn.png" ImageAlign="AbsMiddle" OnMouseOver="src='/img/BlueNextBtnOver.png';" OnMouseOut="src='/img/BlueNextBtn.png';" TabIndex="5" ValidationGroup="vForgot" Width="95" OnClick="btnSearchClick" />
                    </div>
                </div>
            </div>

            <div id="divLoginTypeEmployee" runat="server">
                <div class="form-group">
                    <%--<div class="col-md-5  control-label">
                        <asp:Label ID="lblDOB" runat="server" Text="Birthdate"></asp:Label>
                    </div>--%>
                     <label for="txtDOB" class="col-xs-5 col-sm-5 col-md-5 text-right control-label">Birthdate</label>
                    <div class="col-xs-4 col-sm-4 col-md-4">
                        <asp:TextBox ID="txtDOB" TabIndex="3" CssClass="form-control" runat="server" placeholder="MM/DD/YYYY" MaxLength="10"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="txtDOB" ErrorMessage="<h4>Birth Date</h4>" Text="" runat="server" Display="None" ValidationGroup="vForgot" />
                        <asp:CompareValidator ID="dateValidator" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtDOB" ErrorMessage="<h4>Please enter a valid date (mm/dd/yyyy).</h4>" Display="None" ValidationGroup="vForgot"></asp:CompareValidator>
                    </div>
                </div>
                <div class="form-group">             
                      <label for="txtSSN" class="col-xs-5 col-sm-5 col-md-5 text-right control-label">Last 4 digits of SSN</label>
                    <div class="col-xs-4 col-sm-4 col-md-4">
                        <asp:TextBox ID="txtSSN" TabIndex="4" CssClass="form-control" runat="server" placeholder="1234" MaxLength="4"></asp:TextBox>
                        <asp:RequiredFieldValidator ControlToValidate="txtSSN" ErrorMessage="<h4>Last 4 Digits of SSN</h4>" Text="" runat="server" Display="None" ValidationGroup="vForgot" />
                        <asp:RegularExpressionValidator ControlToValidate="txtSSN" ValidationExpression="\d{4}" ErrorMessage="<h4>Last 4 Digits of SSN</h4>" runat="server" Display="None" ValidationGroup="vForgot" />
                    </div>
                    <div class="col-xs-2 col-sm-2 col-md-2 pull-right right">
                        <asp:ImageButton ID="btnSearchEmp" runat="server" ImageUrl="img/BlueNextBtn.png" ImageAlign="AbsMiddle" OnMouseOver="src='/img/BlueNextBtnOver.png';" OnMouseOut="src='/img/BlueNextBtn.png';" TabIndex="5" ValidationGroup="vForgot" Width="95" OnClick="btnSearchClick" />
                    </div>
                </div>
            </div>
        </div>
       
   </div>
    
    <div id="divAskQuestions" class="container well-success" runat="server">
           <div class="row">
                <div class="col-md-1"></div>
               <div class="col-md-10 center">
                  <%-- <h3>Riddle me this, Riddle me that</h3>--%>
               </div>

           </div>
           <div class="row">
               <div class="form-group">
                   <div class="col-md-1"></div>
                   <asp:Label ID="lblForgotQuestion1" runat="server" for="txtForgotAnswer1" class="col-md-5 text-right control-label" Text="Question Text here"></asp:Label>
                   <div class="col-md-4">
                       <asp:TextBox ID="txtForgotAnswer1" TabIndex="1" CssClass="form-control" runat="server"></asp:TextBox><br />
                   </div>
               </div>
           </div>
           <div class="row">
               <div class="form-group">
                   <div class="col-md-1"></div>
                   <asp:Label ID="lblForgotQuestion2" runat="server" for="txtForgotAnswer1" class="col-md-5 text-right control-label" Text="Question Text here"></asp:Label>
                   <div class="col-md-4">
                       <asp:TextBox ID="txtForgotAnswer2" TabIndex="1" CssClass="form-control" runat="server"></asp:TextBox><br />
                   </div>
               </div>
           </div>

           <div class="row">
               <div class="form-group">
                   <div class="col-md-1"></div>
                   <asp:Label ID="lblForgotQuestion3" runat="server" class="col-md-5 control-label text-right" Text="Question Text here"></asp:Label>
                   <div class="col-md-4">
                       <asp:TextBox ID="txtForgotAnswer3" TabIndex="1" CssClass="form-control" runat="server"></asp:TextBox>
                   </div>
                   <div class="col-md-2 pull-right right">
                       <asp:ImageButton ID="btnCheckAnswers" runat="server" ImageUrl="img/BlueNextBtn.png" ImageAlign="AbsMiddle" OnMouseOver="src='/img/BlueNextBtnOver.png';" OnMouseOut="src='/img/BlueNextBtn.png';" TabIndex="5" width="95" />
                   </div>
               </div>
        </div>
       </div>



    <div class="well-success" id="divUserName" runat="server">
        <div class="row">
            <div class="form-group">               
                    <label for="txtUsername" class="col-xs-2 col-sm-2 col-md-2 control-label right">Username</label>               
                <div class="col-xs-4 col-sm-4 col-md-4">
                    <asp:TextBox ID="txtUsername" TabIndex="2" CssClass="form-control" runat="server" placeholder="Username" ValidationGroup="vUserPass"></asp:TextBox>                   
                </div>
                <div class="col-xs-6 col-sm-6 col-md-6 text-muted">
                    <asp:Label ID="lblUsernameInfo" runat="server"
                     Text ="Your Username must have at least 6 characters, cannot contain spaces, must begin with an alpha character, can contain mixed case alpha, digits, and the following special characters: (!@#$%&amp;+?). "></asp:Label>
                 </div>
            </div>
        </div>
         <div class="row"> <div class="col-md-2"><br /></div></div>

        <div class="row">
            <div class="form-group">               
                    <label for="txtPassword" class="col-xs-2 col-sm-2 col-md-2 control-label right">Password</label>
              <div class="col-xs-4 col-sm-4 col-md-4">
                    <asp:TextBox ID="txtPassword" TabIndex="4" CssClass="form-control" runat="server" TextMode="Password" placeholder="Password" MaxLength="50" ValidationGroup="vUserPass"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="valPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="<h4>Password</h4>" Display="None" ValidationGroup="vUserPass"></asp:RequiredFieldValidator>
                    <br />
                </div>
                <div class="col-xs-6 col-sm-6 col-md-6 text-muted">
                    <asp:Label ID="lblPasswordInfo" runat="server"
                      text =" Your Password must have at least 8 characters including one capital, one lowercase, one numeric, and one special character from the following list: (!@#$%&amp;+?)."></asp:Label>
                    </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group">
                <label for="txtConfirmPassword" class="col-xs-2 col-sm-2 col-md-2 control-label right">Confirm Password</label>
                <div class="col-xs-4 col-sm-4 col-md-4 ">
                    <asp:TextBox ID="txtConfirmPassword" TabIndex="5" CssClass="form-control" runat="server" TextMode="Password" placeholder="Confirm Password" MaxLength="50" ValidationGroup="vUserPass"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="valConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="<h4>Confirm Password</h4>" Display="None" ValidationGroup="vUserPass"></asp:RequiredFieldValidator>
                  
                </div>
                 <div class="col-xs-2 col-sm-2 col-md-2 pull-right right"> 
                    <asp:ImageButton ID="btnSaveUserName" runat="server" ImageUrl="img/BlueSaveBtnNew.png" ImageAlign="AbsMiddle" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" tabindex="5" Visible="false" ValidationGroup="vUserPass" /> 
                     </div>
            </div>
        </div>
        

        </div>

    <div class="well" id="divQuestions" runat="server">
         <div class="row"> <div class="col-md-2"><br /></div></div>
       
        <div class="form-group">
            <label for="lstSecurity1" class="col-xs-2 col-sm-2 col-md-2 control-label">Question</label>
            <div class="col-xs-6 col-sm-6 col-md-6  ">
                <asp:DropDownList ID="lstSecurity1" CssClass="form-control" runat="server" DataValueField="QuestionId" DataTextField="QuestionText" TabIndex="7" ValidationGroup="vSecQuestion" ></asp:DropDownList>
                <asp:RequiredFieldValidator ID="valSecurity1" runat="server" ControlToValidate="lstSecurity1" ErrorMessage="<h4>Security Question 1</h4>" Display="None" InitialValue="<< Please Select a Question >>" ValidationGroup="vSecQuestion"></asp:RequiredFieldValidator>
            </div>
         </div>
        <div class="form-group">
            <label for="txtAnswer1" class="col-xs-2 col-sm-2 col-md-2 control-label">Answer</label>
            <div class="col-xs-6 col-sm-6 col-md-6 ">
                <asp:TextBox ID="txtAnswer1" CssClass="form-control" runat="server" placeholder="Answer" MaxLength="50" TabIndex="8" ValidationGroup="vSecQuestion" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="valAnswer1" runat="server" ControlToValidate="txtAnswer1" ErrorMessage="<h4>Security Answer 1</h4>" Display="None" ValidationGroup="vSecQuestion"></asp:RequiredFieldValidator><br />
            </div>
        </div>

        <div class="form-group">
            <label for="lstSecurity2" class="col-xs-2 col-sm-2 col-md-2 control-label">Question</label>
            <div class="col-xs-6 col-sm-6 col-md-6">
                <asp:DropDownList ID="lstSecurity2" CssClass="form-control" runat="server" DataValueField="QuestionId" DataTextField="QuestionText" TabIndex="9" ValidationGroup="vSecQuestion"  ></asp:DropDownList>
                <asp:RequiredFieldValidator ID="valSecurity2" runat="server" ControlToValidate="lstSecurity2" ErrorMessage="<h4>Security Question 2</h4>" Display="None" InitialValue="<< Please Select a Question >>" ValidationGroup="vSecQuestion"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="form-group">
            <label for="txtAnswer2" class="col-xs-2 col-sm-2 col-md-2  control-label">Answer</label>
           <div class="col-xs-6 col-sm-6 col-md-6">
                <asp:TextBox ID="txtAnswer2" TabIndex="10" CssClass="form-control" runat="server" placeholder="Answer" MaxLength="50" ValidationGroup="vSecQuestion"  ></asp:TextBox>
                <asp:RequiredFieldValidator ID="valAnswer2" runat="server" ControlToValidate="txtAnswer2" ErrorMessage="<h4>Security Answer 2</h4>" Display="None" ValidationGroup="vSecQuestion"></asp:RequiredFieldValidator><br />
            </div>
        </div>

        <div class="form-group">
            <label for="lstSecurity3" class="col-xs-2 col-sm-2 col-md-2  control-label">Question</label>
             <div class="col-xs-6 col-sm-6 col-md-6">
                <asp:DropDownList ID="lstSecurity3" CssClass="form-control" runat="server" DataValueField="QuestionId" DataTextField="QuestionText" TabIndex="11" ValidationGroup="vSecQuestion"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="valSecurity3" runat="server" ControlToValidate="lstSecurity3" ErrorMessage="<h4>Security Question 3</h4>" Display="None" InitialValue="<< Please Select a Question >>" ValidationGroup="vSecQuestion"></asp:RequiredFieldValidator>
            </div>
        </div>
        <div class="form-group">
            <label for="txtAnswer3" class="col-xs-2 col-sm-2 col-md-2  control-label">Answer</label>
            <div class="col-xs-6 col-sm-6 col-md-6">
                <asp:TextBox ID="txtAnswer3" TabIndex="12" CssClass="form-control" runat="server" placeholder="Answer" MaxLength="50" ValidationGroup="vSecQuestion"></asp:TextBox>
                <asp:RequiredFieldValidator ID="valAnswer3" runat="server" ControlToValidate="txtAnswer3" ErrorMessage="<h4>Security Answer 3</h4>" Display="None" ValidationGroup="vSecQuestion"></asp:RequiredFieldValidator>
                <br />
            </div>
        
            <div class="col-xs-2 col-sm-2 col-md-2 pull-right right">
                <asp:ImageButton ID="btnRegister" runat="server" ImageUrl="img/BlueSaveBtnNew.png" ImageAlign="AbsMiddle" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" TabIndex="30" ValidationGroup="vSecQuestion" />
            </div>
        </div>
     
    </div>
 

          </section>
 </div>
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
