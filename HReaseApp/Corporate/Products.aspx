<%@ Page Title="" Language="VB" MasterPageFile="~/Corporate/CorporateMaster.master" AutoEventWireup="false" CodeFile="Products.aspx.vb" Inherits="Products" %>

<asp:Content ID="body" ContentPlaceHolderID="body" Runat="Server">
    <!-- WRAPPER -->
		<div id="wrapper">

			<!-- PAGE TITLE -->
			<header id="page-title"> <!-- style="background-image:url('assets/images/demo/parallax_bg.jpg')" -->
				<!--
					Enable only if bright background image used
					<span class="overlay"></span>
				-->

				<div class="container">
					<h1>Product & Services</h1>

					<ul class="breadcrumb">
						<li><a href="index.html">Home</a></li>
						<li><a href="#">Products & Services</a></li>
						<li class="active">Summary</li>
					</ul>
				</div>
			</header>

			<section class="container">

				<h2>Our Products and Services</h2>

				<p class="lead">At HR ease we understand that the same key does not fit every lock. This drives our philosophy to take customer service out of the box and craft our products and services around the needs of our clients.<br /> We make the effort to unlock the full potential in what we can do for you.</p>


<%--				<div class="divider"><!-- divider -->
					<i class="fa fa-star"></i>
				</div>--%>


				<!-- BORN TO BE A WINNER -->
				<article class="row">
					<div class="col-sm-6 col-md-6 hidden-xs">
                        <br />
						<div class="owl-carousel controlls-over" data-plugin-options='{"items": 1, "singleItem": true, "navigation": false, "pagination": true, "transitionStyle":"fadeUp"}'>
							<div>
								<img class="img-responsive img-rounded  margin-top80" src="assets/images/placeit/HRallthree_cropped.png"   alt=""/>
							</div>							
						</div>
					</div>
                    <div class="col-xs-12 col-sm-6 col-md-6">
                        <h4 class="text-primary">What we offer</h4>
                        <p>Our suite of Products/Services can be bundled or purchased individually.</p>

                        <ul class="list-icon star-o color circle">
                            <li class="margin-bottom10"><a href="PS_BenefitAdmin.aspx">Benefits Administration</a></li>
                            <li class="margin-bottom10"><a href="PS_ACACompliance.aspx">Affordable Care Act (ACA) Compliance</a></li>
                            <li class="margin-bottom10"><a href="PS_Cobra.aspx">Consolidated Omnibus Budget Reconciliation Act (COBRA) Administration</a></li>
                            <li class="margin-bottom10"><a href="PS_Onboarding.aspx">New Employee Onboarding</a></li>
                            <li class="margin-bottom10"><a href="PS_Reporting.aspx">Advance Reporting features</a></li>
                            <li class="margin-bottom10"><a href="adv-integration.apsx">Reporting and Data Integration Software (RADIS)</a></li>
                            <li class="margin-bottom10"><a href="PS_OtherServices.aspx">Dependent Verification</a></li>
                            <li class="margin-bottom10"><a href="PS_OtherServices.aspx">Evidence of Insurability Managment</a></li>
                            <li class="margin-bottom10"><a href="PS_OtherServices.aspx">Data Auditing </a></li>
                            <li ><a href="PS_OtherServices.aspx">Customer Care Center </a></li>
                        </ul>

                    </div>
				</article>  
				<!-- /BORN TO BE A WINNER -->
                 <%--<div class="divider"><!-- divider -->
					<i class="fa fa-star"></i>
				</div>--%>
				 <%--CALL US Call out--%>
                <div class="bs-callout text-center styleSecondBackground">
                    <h3>We make <strong>Benefits</strong> that easy.</h3><br />
                        <a href="/corporate/contactus.aspx"  class="btn btn-danger btn-lg">Schedule Demo</a>

                </div>

				<!-- FEATURED BOXES 3 -->
				<%--<div class="row">
					<div class="col-md-3">
						<div class="featured-box nobg border-only">
							<div class="box-content">
								<i class="fa fa-user"></i>
								<h4>Loved by Customers</h4>
								<p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus.</p>
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="featured-box nobg border-only">
							<i class="fa fa-book"></i>
							<h4>Well Documented</h4>
							<p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus.</p>
						</div>
					</div>
					<div class="col-md-3">
						<div class="featured-box nobg border-only">
							<i class="fa fa-trophy"></i>
							<h4>Winner</h4>
							<p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus.</p>
						</div>
					</div>
					<div class="col-md-3">
						<div class="featured-box nobg border-only">
							<i class="fa fa-cogs"></i>
							<h4>Customizable</h4>
							<p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus. </p>
						</div>
					</div>
				</div>--%>
				<!-- /FEATURED BOXES 3 -->

				<%--<hr />

				<h2>What else Atropos can offer?</h2>

				<p class="lead">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur pellentesque neque eget diam posuere porta. Quisque ut nulla at nunc vehicula lacinia. Proin adipiscing porta tellus, ut feugiat nibh adipiscing sit amet.</p>

				<div class="tabs">

					<!-- tabs 
					<ul class="nav nav-tabs">
						<li class="active"><a href="#service-1" data-toggle="tab"><i class="fa fa-heart-o"></i> Service 1</a></li>
						<li><a href="#service-2" data-toggle="tab"><i class="fa fa-smile-o"></i> Service 2</a></li>
						<li><a href="#service-3" data-toggle="tab"><i class="fa fa-microphone"></i> Service 3</a></li>
						<li><a href="#service-4" data-toggle="tab"><i class="fa fa-windows"></i> Service 4</a></li>
						<li><a href="#service-5" data-toggle="tab"><i class="fa fa-flask"></i> Service 5</a></li>
					</ul>--%>

					<!-- tabs content -->
					<%--<div class="tab-content">
						<div class="tab-pane active" id="service-1">
							<i class="featured-icon pull-left fa fa-heart-o"><!-- service icon --></i>
							<p>Praesent est laborum dolo rumes fugats untras. Etha rums ser quidem rerum facilis dolores nemis onis fugats vitaes nemo minima rerums unsers sadips amets. Ut enim ad minim veniam, quis nostrud Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci amets uns. Etharums ser quidem rerum. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Asunt in anim uis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla dolores ipsums fugiats. Etha rums ser quidem rerum facilis dolores nemis onis fugats vitaes nemo minima rerums unsers sadips amets. Ut enim ad minim veniam, quis nostrud neque porro quisquam est. Asunt in anim uis aute irure dolor in reprehenderit in voluptate velit.</p>
							<p>Praesent id enim sit amet odio vulputate eleifend in in tortor. Donec tellus massa, tristique sit amet condim vel, facilisis quis sapien. Praesent id enim sit amet odio vulputate eleifend in in tortor.</p>
						</div>

						<div class="tab-pane" id="service-2">
							<i class="featured-icon pull-left fa fa-smile-o"><!-- service icon --></i>
							<p>Praesent est laborum dolo rumes fugats untras. Etha rums ser quidem rerum facilis dolores nemis onis fugats vitaes nemo minima rerums unsers sadips amets. Ut enim ad minim veniam, quis nostrud Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci amets uns. Etharums ser quidem rerum. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Asunt in anim uis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla dolores ipsums fugiats. Etha rums ser quidem rerum facilis dolores nemis onis fugats vitaes nemo minima rerums unsers sadips amets. Ut enim ad minim veniam, quis nostrud neque porro quisquam est. Asunt in anim uis aute irure dolor in reprehenderit in voluptate velit.</p>
							<p>Praesent id enim sit amet odio vulputate eleifend in in tortor. Donec tellus massa, tristique sit amet condim vel, facilisis quis sapien. Praesent id enim sit amet odio vulputate eleifend in in tortor.</p>
							<p>Donec tellus massa, tristique sit amet condim vel, facilisis quis sapien. Praesent id enim sit amet odio vulputate eleifend in in tortor. Donec tellus massa.</p>
						</div>

						<div class="tab-pane" id="service-3">
							<i class="featured-icon pull-left fa fa-microphone"><!-- service icon --></i>
							<p>Praesent est laborum dolo rumes fugats untras. Etha rums ser quidem rerum facilis dolores nemis onis fugats vitaes nemo minima rerums unsers sadips amets. Ut enim ad minim veniam, quis nostrud Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci amets uns. Etharums ser quidem rerum. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Asunt in anim uis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla dolores ipsums fugiats. Etha rums ser quidem rerum facilis dolores nemis onis fugats vitaes nemo minima rerums unsers sadips amets. Ut enim ad minim veniam, quis nostrud neque porro quisquam est. Asunt in anim uis aute irure dolor in reprehenderit in voluptate velit.</p>
							<p>Donec tellus massa, tristique sit amet condim vel, facilisis quis sapien. Praesent id enim sit amet odio vulputate eleifend in in tortor. Donec tellus massa.</p>
						</div>

						<div class="tab-pane" id="service-4">
							<i class="featured-icon pull-left fa fa-windows"><!-- service icon --></i>
							<p>Praesent est laborum dolo rumes fugats untras. Etha rums ser quidem rerum facilis dolores nemis onis fugats vitaes nemo minima rerums unsers sadips amets. Ut enim ad minim veniam, quis nostrud Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci amets uns. Etharums ser quidem rerum. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Asunt in anim uis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla dolores ipsums fugiats. Etha rums ser quidem rerum facilis dolores nemis onis fugats vitaes nemo minima rerums unsers sadips amets. Ut enim ad minim veniam, quis nostrud neque porro quisquam est. Asunt in anim uis aute irure dolor in reprehenderit in voluptate velit.</p>
							<p>Praesent id enim sit amet odio vulputate eleifend in in tortor. Donec tellus massa, tristique sit amet condim vel, facilisis quis sapien. Praesent id enim sit amet odio vulputate eleifend in in tortor.</p>
						</div>

						<div class="tab-pane" id="service-5">
							<i class="featured-icon pull-left fa fa-flask"><!-- service icon --></i>
							<p>Praesent id enim sit amet odio vulputate eleifend in in tortor. Donec tellus massa, tristique sit amet condim vel, facilisis quis sapien. Praesent id enim sit amet odio vulputate eleifend in in tortor.</p>
							<p>Donec tellus massa, tristique sit amet condim vel, facilisis quis sapien. Praesent id enim sit amet odio vulputate eleifend in in tortor. Donec tellus massa.</p>
						</div>

					</div>

				</div>

				<hr />

				<div class="row">
					<div class="col-md-6">
						<h4>Why chose us?</h4>
						<ul class="list-icon star-o">
							<li>Fully responsive so your content will always look good on any screen size</li>
							<li>Awesome sliders give you the opportunity to showcase important content</li>
							<li>Unlimited color options with a backed color picker, including the gradients</li>
							<li>Multiple layout options for home pages, portfolio section &amp; blog section</li>
							<li>We offer free support because we care about your site as much as you do.</li>
						</ul>
					</div>

					<div class="col-md-6">
						<h4>What Atropos clients say?</h4>
						<div class="owl-carousel text-center" data-plugin-options='{"items": 1, "singleItem": true, "navigation": false, "pagination": true, "autoPlay": true, "transitionStyle":"fadeUp"}'><!-- transitionStyle: fade, backSlide, goDown, fadeUp,  -->
							<div class="testimonial white">
								<p>Praesent est laborum dolo rumes fugats untras. Etha rums ser quidem rerum facilis dolores nemis onis fugats vitaes nemo minima rerums unsers sadips amets.</p>
								<cite><strong>John Doe</strong>, Customer</cite>
							</div>

							<div class="testimonial white">
								<p>Donec tellus massa, tristique sit amet condim vel, facilisis quis sapien. Praesent id enim sit amet odio vulputate eleifend in in tortor. Donec tellus massa.</p>
								<cite><strong>Jessica Doe</strong>, Customer</cite>
							</div>

							<div class="testimonial white">
								<p>Praesent est laborum dolo rumes fugats untras. Etha rums ser quidem rerum facilis dolores nemis onis fugats vitaes nemo minima rerums unsers sadips amets.</p>
								<cite><strong>Dorin Doe</strong>, Customer</cite>
							</div>

							<div class="testimonial white">
								<p>Donec tellus massa, tristique sit amet condim vel, facilisis quis sapien. Praesent id enim sit amet odio vulputate eleifend in in tortor. Donec tellus massa.</p>
								<cite><strong>Melissa Doe</strong>, Customer</cite>
							</div>

						</div>
					</div>
				</div>

				<hr />--%>

				<!-- CALLOUT -->
				<%--<div class="bs-callout text-center nomargin-bottom">
					<h1>
						<strong>1800-555-1234</strong>
					</h1>

					<hr class="half-margins invisible" />

					<h3>
						<a href="contact-us.html" target="_blank" class="btn btn-primary btn-lg">Contact Us!</a>
					</h3>
				</div>--%>
				<!-- /CALLOUT -->

			</section>

            
              <!-- Remove "margin-footer" if you use this on the middle of the page -->
			<section class="cover margin-footer parallax" data-stellar-background-ratio="0.8" style="background-image: url('assets/images/placeit/GuyatDesk.jpg');">

				<span class="overlay"></span>

				<div class="container">

					<div class="owl-carousel text-center" data-plugin-options='{"items": 1, "singleItem": true, "navigation": true, "pagination": false, "autoPlay": true, "transitionStyle":"fadeUp"}'><!-- transitionStyle: fade, backSlide, goDown, fadeUp,  -->
						<div class="testimonial">
							<p><br /><br />
							<%--<cite><strong>John Doe</strong>, Customer</cite>--%>
						</div>

						<%--<div class="testimonial">
							<p>Donec tellus massa, tristique sit amet condim vel, facilisis quis sapien. Praesent id enim sit amet odio vulputate eleifend in in tortor. Donec tellus massa.</p>
							<cite><strong>Jessica Doe</strong>, Customer</cite>
						</div>

						<div class="testimonial">
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
