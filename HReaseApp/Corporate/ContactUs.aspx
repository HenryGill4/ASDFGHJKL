<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Corporate/CorporateMaster.master" CodeBehind="ContactUs.aspx.vb" Inherits="HReaseApp.ContactUs" %>

<asp:Content ID="Content3" ContentPlaceHolderID="body" Runat="Server">
    
        <!-- WRAPPER -->
		<div id="wrapper">
            	<header id="page-title" class="nopadding">
                    <div class="fullwidthbanner-container roundedcorners">
                        <div class="fullwidthbanner">
                            <ul>
                                <!-- SLIDE 1  -->
                                <li data-transition="fade" data-slotamount="2" data-masterspeed="1000" data-delay="4000">
                                    <!-- MAIN IMAGE -->                                   
                                    <img src="assets/images/placeit/Guyatdesk.jpg" alt="" data-bgposition="center top" data-bgfit="cover" data-bgrepeat="no-repeat"/>
                                </li>
                            </ul>
                            <%--<img class="img-responsive" src="assets/images/placeit/Guyatdesk.jpg" alt="" />--%>
                        </div>
                    </div>
			</header>

			<section id="contact" class="container">
				<div class="row">
					<!-- FORM -->
					<div class="col-md-8">
						<h2>Request a Demo</h2>
						<form id="contactForm" class="white-row" runat="server">
                                <div class="text-center col-xs-12 col-sm-12 col-md-12 col-lg-12 ">
                                    <br />
                                    <asp:ValidationSummary HeaderText="<h4>Please enter a value in the following fields:</h4>" DisplayMode="SingleParagraph" EnableClientScript="true" runat="server" CssClass="alert alert-danger text-center" />
                                    <br />
                                </div>
                         

                            <div id="divError" runat="server" class="form-group" Visible =" false">
                                <div class="alert alert-danger text-center col-xs-12 col-sm-12 col-md-12 col-lg-12 ">
                                    <br />
                                    <asp:Label ID="lblError" runat="server" Text="Opps!  There was an error.<br/>" ></asp:Label>
                                </div>
                            </div>

                             <div id="divSuccess" runat="server" class="form-group" visible ="false">
                                <div class="alert alert-success text-center col-xs-12 col-sm-12 col-md-12 col-lg-12 ">
                                    <h4>Your email has successfully been sent. <br /> A sales team member will be in contact with you soon.<br />Thank you</h4>
                                </div>
                                </div>

							<div class="row">
								<div class="form-group">
									<div class="col-md-4">
										<label>Full Name *</label>
										<asp:textbox  runat="server"  id="txtFullName" placeholder="First Lastname" value="" maxlength="100" CssClass="form-control" ></asp:textbox>
                                        <asp:RequiredFieldValidator ControlToValidate="txtFullName" ErrorMessage="<h4>Full Name</h4>" Text="" runat="server" Display="None"  />
									</div>
									<div class="col-md-4">
										<label>E-mail Address *</label>
										<asp:textbox  id="txtcontact_Email" runat="server" type="email" value="" placeholder="email@yourdomain.com" maxlength="100" CssClass="form-control"  ></asp:textbox>
                                        <asp:RequiredFieldValidator ControlToValidate="txtcontact_Email" ErrorMessage="<h4>Email Address</h4>" Text="" runat="server" Display="None"  />
                                         <asp:RegularExpressionValidator ID="valrEmail1" runat="server" ControlToValidate="txtcontact_Email" ValidationExpression="^(.+)@([^\.].*)\.([a-z]{2,})$" ErrorMessage="<h4>Please ensure that your Email is formatted correctly<i>(email@provider.com) </i></h4>"  Display="None" />
									</div>
									<div class="col-md-4">
										<label>Phone</label>
										<asp:textbox   id="txtcontact_phone" runat="server" value="" placeholder="999-999-9999" maxlength="100" CssClass="form-control"></asp:textbox>
                                       
									</div>
								</div>
							</div>
							<div class="row">
								<div class="form-group">
									<div class="col-md-12">
										<label>Company Name *</label>
										<asp:textbox  id="txtCompanyName" runat="server" value="" placeholder="Please enter your Company Name"  maxlength="100" CssClass="form-control" ></asp:textbox>
                                          <asp:RequiredFieldValidator ControlToValidate="txtCompanyName" ErrorMessage="<h4>Company Name</h4>" Text="" runat="server" Display="None"  />
									</div>
								</div>
							</div>

							<div class="row">
								<div class="form-group">
									<div class="col-md-12">
										<label>How did you hear about us? *</label>
										<asp:DropDownList ID="ddlHowdidyouhear" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="<< Please Select >>" Value ="Choose"></asp:ListItem>
                                            <asp:ListItem Text="Facebook" Value ="Facebook"></asp:ListItem>
                                            <asp:ListItem Text="LinkedIn" Value ="LinkedIn"></asp:ListItem>
                                            <asp:ListItem Text="News Article" Value ="News"></asp:ListItem>                                          
                                            <asp:ListItem Text="Tradeshow" Value ="Trade"></asp:ListItem>
                                            <asp:ListItem Text="Web Search" Value ="Web"></asp:ListItem>
                                            <asp:ListItem Text="Word of Mouth" Value ="Word"></asp:ListItem>
                                              <asp:ListItem Text="Other" Value ="Other"></asp:ListItem>
										</asp:DropDownList>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">

									

									<asp:button id="contact_submit" runat="server" text="Send Request" cssclass="btn btn-primary btn-lg" OnClick="contact_submit_Click"/>
								</div>
							</div>
						</form>
					
					</div>
					<!-- /FORM -->


					<!-- INFO -->
                    <div class="col-md-4">
                        <h2>Contact Us</h2>
                        <p>
                            Please contact us with any questions or to request further information. 
                        </p>
                       
                        <div class="divider half-margins">
                            <!-- divider -->
                            <i class="fa fa-star"></i>
                        </div>

                        
                        <%--<div class="col-md-4">
                           <span class="block">  <strong><i class="fa fa-map-marker"></i>&nbsp;&nbsp;Address:</strong></span>
                        </div>--%>
                        <%--<div class="col-md-8">
                            <span class="block">1715 N Westshore Blvd<br /> Suite 200<br />
                                Tampa FL 33607
                            </span>
                        </div>--%>


                        <div class="col-md-4">
                            <strong><i class="fa fa-phone"></i>&nbsp;&nbsp;Phone:</strong>
                        </div>
                        <div class="col-md-8">
                           813-498-4300
                        </div>

                        <div class="col-md-4">
                            <strong><i class="fa fa-envelope"></i>&nbsp;&nbsp;Email:</strong>
                        </div>
                        <div class="col-md-8">
                            <a href="mailto:info@hrease.com">Info@hrease.com</a>
                            <br /> <br />
                        </div>
                          
                      <%--  <p>
                            <span class="block"><strong><i class="fa fa-map-marker"></i>&nbsp;&nbsp;Address:</strong> 1715 N Westshore Suite 200, Tampa FL 33607</span>
                            <span class="block"><strong><i class="fa fa-phone"></i>&nbsp;&nbsp;Phone:</strong> 813-498-4300</span>
                            <span class="block"><strong><i class="fa fa-envelope"></i>&nbsp;&nbsp;Email:</strong> <a href="mailto:info@hrease.com">Info@hrease.com</a></span>
                        </p>--%>

                        <div class="divider half-margins">
                            <!-- divider -->
                            <i class="fa fa-star"></i>
                        </div>


                        <h4 class="font300">On Line </h4>

                        <a class="btn btn-social-icon btn-facebook" href="https://www.facebook.com/hrease/" target="_blank">
                            <span class="fa fa-facebook"></span>
                        </a>
                        &nbsp; &nbsp; &nbsp; 
                             <a class="btn btn-social-icon btn-linkedin" href="https://www.linkedin.com/company-beta/16191287" target="_blank">
                                 <span class="fa fa-linkedin"></span>
                             </a>

                        <div class="divider half-margins">
                            <!-- divider -->
                            <i class="fa fa-star"></i>
                        </div>
                        <%--<h4 class="font300">Business Hours</h4>
						<p>
							<span class="block"><strong>Monday - Friday:</strong> 10am to 6pm</span>
							<span class="block"><strong>Saturday:</strong> 10am to 2pm</span>
							<span class="block"><strong>Sunday:</strong> Closed</span>
						</p>--%>
                    </div>
					<!-- /INFO -->

				</div>

			</section>

		</div>
		<!-- /WRAPPER -->
						

      <%--  </a>--%>

</asp:Content>

