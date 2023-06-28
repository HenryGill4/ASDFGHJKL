<%@ Page Title="" Language="VB" MasterPageFile="~/Corporate/CorporateMaster.master" AutoEventWireup="false" CodeFile="OurTeam.aspx.vb" Inherits="OurTeam" %>


<asp:Content ID="Content3" ContentPlaceHolderID="body" Runat="Server">
    <article id="wrapper">

			<!-- PAGE TITLE -->
			<header id="page-title">
				<div class="container">
					<h1>About Us</h1>

					<ul class="breadcrumb">
						<li><a href="CorporateHome.aspx">About us</a></li>
				
						<li class="active">Our Team </li>
					</ul>
				</div>
			</header>

			<section class="container">

				<!-- WELCOME -->
				<article>
					<h2>Our Team</h2>
					    <p class="lead">We believe that you need to have a strong understanding of Employee Benefits before you can build a product to support it. Our team has an average of 15 years of Employee Benefit Experience! 
                       </p> 
                    <p class="lead">Since every team member is also a shareholder, all employees care significantly about the product and the services. </p>
                    <p class="lead text-center text-primary"><strong> You benefit!</strong> </p>

                       <div class="col-md-2 col-lg-3"></div> 
                       <div class="col-md-8 col-lg-6 center">
                            <img class="img-responsive img-rounded  center" src="assets/images/OurTeam/Group.jpeg" />
                            <br /><br />
                       </div>
				</article>
				<!-- WELCOME -->

			

				<!-- /WHO WE ARE and SKILLS -->
               
                <div class="divider"><!-- divider -->
					<i class="fa fa-star"></i>
				</div>

				<!-- TEAM -->
				<article>
					<div class="col-md-12 col-lg-12">					
                        <div class="row">
                        <img class="img-responsive img-rounded appear-animation pull-left inner img-rounded" src="assets/images/OurTeam/Sue.jpeg" width="140" data-animation="rotateIn" />
						
						<h4>Sue Gill</h4>
						<small class="styleColor">CEO</small>
						<p>Benefit Reflection, is Sue’s third startup. The first two resulted in multimillion
                        dollar sales. In 1997 Susanne and a partner formed PeopleSolutions, a software
                        consulting firm specializing in PeopleSoft technology implementations and support. In 1999
                        the firm was sold to Oxford Solutions for over $5 million. In 2000, Susanne and her husband
                        founded HR-ease, an online enrollment system for Healthcare and other employee benefits
                        management. HR Ease was sold to Mutual of Omaha Insurance Company in 2012. In early
                        2014, Susanne founded BenefitReflection as a new generation of benefits administration
                        software that is capable of supporting all industry types.  In 2017, Susanne led the organization through 
                         a rebranding back to HR Ease in conjunction with private equity funding.
                        </p>  
                        <p>Sue graduated with a BS from Saint Mary’s Notre Dame in 1988, and is a CPA</p>
						<hr/>

						<%--<img class="img-responsive img-rounded appear-animation pull-left inner img-rounded" src="assets/images/freebies/Paul2.png" width="140"  data-animation="rotateInUpLeft">
						<h4>Paul Harvey</h4>
                        <small class="styleColor">President</small>
                            <p>
                                Paul has over 20 years of insurance and managed care experience ranging from agent and producer to senior and executive management. Paul was President and CEO of SelectSource, the Florida Bankers Insurance Trust (FBIT), a VEBA, and Trust Management Group (TMG) for almost 10 years  He was responsible for the turnaround of and now one of the most respected Third Party Administrators in FL. On behalf of SelectSource and FBIT, Paul negotiated over 15 insurer fee agreements resulting in lower employer and broker fees.   He established a single employer insurance exchange between the Florida Bankers Association and BCBSFL.  The success of SelectSource during this period drew an unsolicited offer from a large insurance company.  
                            </p>
                            <p>
                                Paul graduated from West Point and is Airborne, Ranger and Rotary Wing (helicopter) qualified.
                            </p>
                            <p>
                                Paul and Sue have worked together for over 12 years as a vendor/client, co-executives and entrepreneurs.
                            </p>
						<hr/>--%>

                            <img class="img-responsive img-rounded appear-animation pull-left inner img-rounded" src="assets/images/OurTeam/Bill.jpeg" width="140" data-animation="rotateInDownLeft" />
                            <h4>Bill Lewis</h4>
                            <small class="styleColor">CIO</small>
                            <p>
                                Bill has over 30 years of benefit technology experience and has developed and managed multiple, large-scale benefit program implementations.  He has managed the configuration and deployment of applications for benefit administration and enrollment services based on proprietary software as well as several commercially available systems.  Bill has extensive experience with employer, carrier, and payroll automated interfaces and his experience includes managing web based EDI interchanges for Medicare enrollment and claim transaction routing systems.  He has migrated organizations to cloud based architectures for operational functions such as project and workflow management and document storage.  Additionally, Bill is an active board member and committee participant with the Florida Sterling Council, a 501© not-for-profit endorsed by the Executive Office of the Governor that helps organizations improve operational effectiveness and quality using a management model based on the National Baldrige Quality Award Program.</p>
                                <p>Bill has worked at Mass Mutual, Travelers, Orion Capital, ACS, FBMC Benefits Management, Beneport and his start-up, Business Technology Connection where he has provided technology and implementation consulting services to benefit administrators, brokers, and enrollment firms throughout Florida.

                                </p>
                            <hr/>

                            <img class="img-responsive appear-animation pull-left inner img-rounded" src="assets/images/OurTeam/Bev.jpeg" width="140" data-animation="rotateInUpLeft" />
                            <%--me.jpg--%>
                            <h4>Beverley Smith</h4>
                            <small class="styleColor">Director of Application Development</small>
                            <p>
                                Beverley has a diverse background in
                            software development, and has worked with many proprietary HRIS and Eligibility systems.
                            Beverley is a pioneer in the Benefits technology field developing applications in Oracle, SQL,
                            and ASP.net for companies such as HR Ease, EB-Gateway, Mutual of Omaha, and Ceridian.
                            Beverley led the EDI team for a large telecommunication client to produce Benefits Eligibility feeds to Insurance
                            companies as early as 1996. In addition to her expertise in EDI, she also developed a Resource
                            Management tool in ASP.net for Lucent Technologies.
                            </p>
                            <p>
                             Beverley has been with the company since inception and is the architect and lead developer of the HR Ease system.
                            </p>
                            <hr />

                            <img class="img-responsive appear-animation pull-left inner img-rounded" src="assets/images/OurTeam/Tara.jpeg" width="140" data-animation="rotateInDownRight" />
                            <%--me.jpg--%>
                            <h4>Tara Nania</h4>
                            <small class="styleColor">Senior Business Systems Analyst</small>
                            <p>Tara has over 11 years of benefit experience between the Broker, Group, Individual and Technology side.  Most recently, she worked on a proprietary software that integrated individuals with the Federally Facilitated Marketplace and State Based Exchanges for ACA.  Additionally, she worked on the Private Exchanges connecting small businesses to healthcare coverage for their employees.  Tara has extensive working knowledge of EDI 820, 834 and 837 file formats.  </p>
                            
                            <p>Tara is a certified Employee HealthCare Benefits Associate through AHIP and pursuing her certification in Business Analysis through IIBA.</p>

                            <hr />

                             <img class="img-responsive appear-animation pull-left inner img-rounded" src="assets/images/OurTeam/RobM.jpeg" width="140" data-animation="rotateInUpRight" />
                            <%--me.jpg--%>
                            <h4>Rob Morrone</h4>
                            <small class="styleColor">Senior Systems Architect</small>
                            <p>
                                Rob is a native of Southern California, an honorably discharged Air Force Sergeant, a senior software/database engineer and systems architect.  He has developed software and database solutions in a variety of vertical markets, including manufacturing, freight logistics, finance, and commercial software.  American Overseas Air Freight, Pandair Freight, L.E. Coppersmith, Todd Shipyards, Yokohama Tire, Bowne International, Microsoft and Jabil Circuit have all depended on Rob’s experience, talent and abilities in architecting software, data and systems solutions.
                            </p>
                            <p>
                               Rob has specialized in SQL Server environments since Microsoft first licensed the Sybase database software.  HR Ease leverages his expertise with data modeling, SQL Server and systems architecture in Microsoft Azure to manage a state of the art cloud environment. 
                            </p>

                            <hr/>

                            <img class="img-responsive appear-animation pull-left inner img-rounded" src="assets/images/OurTeam/Kevin.png" width="140" data-animation="rotateInDownLeft" />
                            <%--me.jpg--%>
                            <h4>Kevin Smith</h4>
                            <small class="styleColor">SQL Developer</small>
                            <p>
                                Kevin has been an information technology professional for nearly 20 years developing proprietary applications, reports and database solutions in Visual Studio, Crystal Reports and SQL Server.  Most recently, Kevin worked for a Florida based national PPO network where he developed proprietary healthcare claims processing applications and EDI interfaces for EDI 834 Enrollment and 837 Claims Transactions.
                            </p>
                            <p>
                                Kevin has worked at Nortel Networks, Cendant, and Unum Provident, and is a veteran of the US Army and National Guard with several distinguished awards.
                            </p>

                            <hr/>

                             <img class="img-responsive appear-animation pull-left inner img-rounded" src="assets/images/OurTeam/John.jpeg" width="140" data-animation="rotateIn" />
                            <%--me.jpg--%>
                            <h4>John Tedesco</h4>
                            <small class="styleColor">Business Development Manager</small>
                            <p>
                                John Tedesco has a diverse and well-rounded background in the fields of employee benefits, insurance, business ownership, consulting, account management, and has his Florida 2-15 insurance license. In addition, he has experience in team building, success coaching, and leadership. He has a passion to add a personal touch to all his client’s needs, and is driven by accountability, open communication, client satisfaction, and a strong determination and desire to do what is right for his clients.
                            </p>
                            <p>
                                John has represented Fortune 100 companies, individuals, as well as opening and developing new markets (territories) for companies expanding their scope of services.  
                              <br />
                                <br />
                                <br />
                                <br />
                            </p>

                            <hr/>

						<img class="img-responsive appear-animation pull-left inner img-rounded" src="assets/images/freebies/joinourteam.png" width="140" data-animation="tada" />
						<h4>Join our team</h4>
						<p>Our success as a company depends on the strength of our team. We work closely with our employees to build an innovative, creative and rewarding work environment.</p>

                         <p>  If you want to work in a collaborative environment where opportunities are offered, skills are stretched and excellence is rewarded, you might be exactly what we’re looking for.  To learn more about upcoming positions please <a href="mailto:info@benefitreflection.com">Email Us</a> with your qualifications.
						</p>
                            <h4>Available positions</h4>
                            <ul>
                                <li> <a href="https://www.linkedin.com/jobs/view/266454718?refId=37893cf0-d06c-465a-bfe1-c7ce2fbad258&trk=jobshomev2_jymbii" target="_blank">Microsoft SQL Developer</a>  
                                   <br /> Job Description <br />

Progressive employee benefits technology and service provider seeks experienced SQL Developer to support our rapid growth. Successful candidate will be primarily responsible for researching and debugging existing MS SQL Server stored procedures and recommending technical enhancements to resolve issues and/or improve performance and results of data exchange with client and vendor systems, and develop custom SQL reports to meet customer requirements.
                                    <br /><a href="https://www.linkedin.com/jobs/view/266454718?refId=37893cf0-d06c-465a-bfe1-c7ce2fbad258&trk=jobshomev2_jymbii" target="_blank">Read more and Apply</a> 
                                </li> 
                            </ul>
						<hr/>

						<%--<img class="img-responsive appear-animation pull-left inner" src="assets/images/freebies/camera-shy.jpg" width="140" data-animation="flash">
						<h4>flash</h4>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur pellentesque <strong>neque eget diam</strong> posuere porta. Quisque ut nulla at nunc  lacinia. Proin adipiscing porta tellus, ut feugiat nibh adipiscing sit amet. In eu justo a felis faucibus ornare vel id metus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In eu libero ligula. Fusce eget metus lorem, ac viverra leo. Nullam convallis, arcu vel.</p>
						<hr>

						<img class="img-responsive appear-animation pull-left inner" src="assets/images/freebies/camera-shy.jpg" width="140" data-animation="shake">
						<h4>shake</h4>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur pellentesque <strong>neque eget diam</strong> posuere porta. Quisque ut nulla at nunc  lacinia. Proin adipiscing porta tellus, ut feugiat nibh adipiscing sit amet. In eu justo a felis faucibus ornare vel id metus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In eu libero ligula. Fusce eget metus lorem, ac viverra leo. Nullam convallis, arcu vel.</p>
						<hr>

						<img class="img-responsive appear-animation pull-left inner" src="assets/images/freebies/camera-shy.jpg" width="140" data-animation="bounce">
						<h4>bounce</h4>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur pellentesque <strong>neque eget diam</strong> posuere porta. Quisque ut nulla at nunc  lacinia. Proin adipiscing porta tellus, ut feugiat nibh adipiscing sit amet. In eu justo a felis faucibus ornare vel id metus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In eu libero ligula. Fusce eget metus lorem, ac viverra leo. Nullam convallis, arcu vel.</p>
						<hr>

						<img class="img-responsive appear-animation pull-left inner" src="assets/images/freebies/camera-shy.jpg" width="140" data-animation="tada">
						<h4>tada</h4>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur pellentesque <strong>neque eget diam</strong> posuere porta. Quisque ut nulla at nunc  lacinia. Proin adipiscing porta tellus, ut feugiat nibh adipiscing sit amet. In eu justo a felis faucibus ornare vel id metus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In eu libero ligula. Fusce eget metus lorem, ac viverra leo. Nullam convallis, arcu vel.</p>
						<hr>--%>






<%--							<div class="col-sm-6 col-md-3"><!-- item 1 -->
								<div class="item-box fixed-box">
									<figure>
										<img class="img-responsive" src="assets/images/demo/people/1.jpg" width="263" height="263" alt="">
									</figure>
									<div class="item-box-desc">
										
										<div class="row socials">
											<a href="#" class="social fa fa-facebook"></a>
											<a href="#" class="social fa fa-twitter"></a>
											<a href="#" class="social fa fa-google-plus"></a>
										</div>
									</div>
								</div>
							</div>

							<div class="col-sm-6 col-md-3"><!-- item 2 -->
								<div class="item-box fixed-box">
									<figure>
										<img class="img-responsive" src="assets/images/demo/people/2.jpg" width="263" height="263" alt="">
									</figure>
									<div class="item-box-desc">
										<h4>John Doe</h4>
										<small class="styleColor">Marketing</small>
										<p>This is a short text - the content remains the same!</p>
										<div class="row socials">
											<a href="#" class="social fa fa-facebook"></a>
											<a href="#" class="social fa fa-twitter"></a>
											<a href="#" class="social fa fa-google-plus"></a>
										</div>
									</div>
								</div>
							</div>

							<div class="col-sm-6 col-md-3"><!-- item 3 -->
								<div class="item-box fixed-box">
									<figure>
										<img class="img-responsive" src="assets/images/demo/people/3.jpg" width="263" height="263" alt="">
									</figure>
									<div class="item-box-desc">
										<h4>John Doe</h4>
										<small class="styleColor">Developer</small>
										<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.</p>
										<div class="row socials">
											<a href="#" class="social fa fa-facebook"></a>
											<a href="#" class="social fa fa-twitter"></a>
											<a href="#" class="social fa fa-google-plus"></a>
										</div>
									</div>
								</div>
							</div>

							<div class="col-sm-6 col-md-3"><!-- item 4 -->
								<div class="item-box fixed-box">
									<figure>
										<img class="img-responsive" src="assets/images/demo/people/4.jpg" width="263" height="263" alt="">
									</figure>
									<div class="item-box-desc">
										<h4>John Doe</h4>
										<small class="styleColor">Designer</small>
										<p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.</p>
										<div class="row socials">
											<a href="#" class="social fa fa-facebook"></a>
											<a href="#" class="social fa fa-twitter"></a>
											<a href="#" class="social fa fa-google-plus"></a>
										</div>
									</div>
								</div>
							</div>--%>

						</div>

					</div>
				</article>
				<!-- /TEAM -->


				<hr />


				
			</section>

		</article>
</asp:Content>

