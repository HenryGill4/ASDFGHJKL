<%@ Page Title="" Language="VB" MasterPageFile="~/Corporate/CorporateMaster.master" AutoEventWireup="false" CodeFile="Advantages.aspx.vb" Inherits="Advantages" %>

<asp:Content ID="body" ContentPlaceHolderID="body" Runat="Server">
 
		<!-- WRAPPER -->
		<div id="wrapper">

			<!-- PAGE TITLE -->
			<header id="page-title">
				<div class="container">
					<h1>Competitive Advantages</h1>
                    

					<ul class="breadcrumb">
						<li><a href="CorporateHome.aspx">Home</a></li>
						<li><a href="#">Advantages</a></li>
						<li class="active">Summary</li>
					</ul>

                   
				</div>
			</header>

            <section id="portfolio" class="container">
                <h2>Have you ever had the opportunity to start over? </h2>

               <%-- <p class="lead">Given the complexity of healthcare today it is essential that the system used to navigate through these murky and changing waters is user friendly and straightforward.</p>--%>
               <%--<h3 class="text-primary">Have you ever had the opportunity to start over? </h3>--%> 
                
               <p  class="lead">Our original program was developed in 2000 and grew to over 1,000 clients with over 100,000 employee records when we were acquired by an insurance company in 2012.  
                   A couple of years later we decided to start over and with over 40 years of benefits systems experience, we could reflect back on and reimagine a program that was far better than what we (or anyone else) envisioned.
                   While our competition labors under clunky architecture or with programmers that have little or no benefits experience, we developed an advanced system architecture that facilitates many competitive advantages.  </p>  
                

                <div class="row margin-top20">
                    <div class="col-xs-5 col-sm-5 col-md-5">
                        <div class="owl-carousel controlls-over product-image" data-plugin-options='{"items": 1, "singleItem": true, "navigation": true, "pagination": true, "transitionStyle":"fadeUp"}'>
                            <img alt="" class=" img-rounded margin-top50" src="assets/images/freebies/iceberg.jpg" width="100%" />

                           <%-- <div>
								<img alt="" class="img-responsive" src="assets/images/demo/portfolio/tumblr_mopqj9QUeq1st5lhmo1_12801.jpg">
							</div>--%>
                        </div>
                    </div>

                    <div class="col-xs-7 col-sm-7 col-md-7">
                            <br /><br />
                        
                         <h4 class="text-primary">What makes us different the rest</h4>
                        <p>Envision an iceberg, while you can see the part above the water most of the mass exists below the surface. Behind the scenes is where most systems begin to struggle;  importing, exporting, reporting, calculating and interpreting data is painstakingly difficult to be accurate. 
                            Our competitive advantages include:
                        </p>

                        <ul class="list-icon star-o color circle">
                            <li class="margin-bottom10"><a href="Adv-Implementation.aspx">Compressed Implementation Time and Effort</a></li>
                            <li class="margin-bottom10"><a href="Adv-Configuration.aspx">Flexible Configuration</a></li>
                            <li class="margin-bottom10"><a href="Adv-Engagement.aspx">Employee Communication and Engagement</a></li>
                            <li class="margin-bottom10"><a href="Adv-Integration.aspx">Fully Managed Data Integration</a></li>
                            <li ><a href="Adv_Infrastructure.aspx">Cloud-based Hosted Infrastructure</a></li>

                        </ul>

                        <%--<a href="#" class="btn btn-primary btn-lg btn-margin-top"><i class="fa fa-external-link"></i> Live Preview</a>--%>
                    </div>
                </div>

<%--                   <div class="divider"><!-- divider -->
					<i class="fa fa-star"></i>
				</div>--%>
                <%--CALL US Call out--%>
                <div class="bs-callout text-center styleSecondBackground">
                    <h3>Let us <strong>simplify</strong> your enrollment process</h3><br />
                        <a href="/corporate/contactus.aspx"  class="btn btn-danger btn-lg">Schedule Demo</a>

                </div>

                <%--	<hr />--%>

                <%--<div class="divider"><!-- divider -->
					<i class="fa fa-star"></i>
				</div>--%>
            </section>



          
              <!-- Remove "margin-footer" if you use this on the middle of the page -->
			<section class="cover margin-footer parallax" data-stellar-background-ratio="0.7" style="background-image: url('assets/images/jim/BirdonWire.jpg');">
				<span class="overlay"></span>

				<div class="container">

					<div class="owl-carousel text-center" data-plugin-options='{"items": 1, "singleItem": true, "navigation": false, "pagination": false, "autoPlay": true, "transitionStyle":"backSlide"}'><!-- transitionStyle: fade, backSlide, goDown, fadeUp,  -->
						<div class="testimonial">
							<p>I appreciate that the HR ease team always has our new clients up and running ahead of schedule, which reflects well on us as the face to the client.  </p>
							<cite><strong>Partner </strong>, of a national enrollment company</cite>
						</div>

						<div class="testimonial">
							<p>I was pleasantly surprised.  Once the payroll interface was set up, our new client implementations take less than a week.</p>
							<cite><strong>PEO</strong>, Owner</cite>
						</div>

						<%--<div class="testimonial">
							<p>Praesent est laborum dolo rumes fugats untras. Etha rums ser quidem rerum facilis dolores nemis onis fugats vitaes nemo minima rerums unsers sadips amets.</p>
							<cite><strong>Dorin Doe</strong>, Customer</cite>
						</div>

						<div class="testimonial">
							<p>Donec tellus massa, tristique sit amet condim vel, facilisis quis sapien. Praesent id enim sit amet odio vulputate eleifend in in tortor. Donec tellus massa.</p>
							<cite><strong>Melissa Doe</strong>, Customer</cite>
						</div>--%>

					</div>

				</div>
			</section>


		</div>
		<!-- /WRAPPER -->

</asp:Content>

