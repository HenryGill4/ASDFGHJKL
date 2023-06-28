<%@ Page Title="" Language="VB" MasterPageFile="~/Corporate/CorporateMaster.master" AutoEventWireup="false" CodeFile="PS_Onboarding.aspx.vb" Inherits="PS_Onboarding" %>

<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">
    <meta name="keywords" content="Employee Onboarding Software, online W-4 Form, online I-9 Declaration, Direct Deposit form online, " />
    <!-- WRAPPER -->
    <div id="wrapper">

        <!-- PAGE TITLE -->
        <header id="page-title">

            <div class="container">
                <h1>Products & Services</h1>

                <ul class="breadcrumb">
                    <li><a href="CorporateHome.aspx">Home</a></li>
                    <li><a href="Products.aspx">Products & Services</a></li>
                    <li class="active">Employee Onboarding</li>
                </ul>
            </div>
        </header>

        <section class="container">

            <h2>New Employee Onboarding</h2>

            <p class="lead">Welcoming a new employee has never been so easy with our Employee Onboarding feature.  </p>
            <div class="row">
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <p class="text-primary">
                        Administrators enter just 10 data elements into our system and your new employee receives a custom login key to login in and complete all of their personal information, eliminating all previously necessary paperwork.  
                    </p>
                    <div class="col-md-1"></div>
                    <div class="col-md-11">
                        <ul class="list-icon star-o color circle ">
                            <li class="margin-bottom10 ">W-4 Form</li>
                            <li class="margin-bottom10">I-9 Declaration</li>
                            <li class="margin-bottom10">Direct Deposit form</li>
                            <li class="margin-bottom10">HR Forms and Information</li>
                            <li class="margin-bottom10">Data is automatically interface with payroll</li>
                            <li class="margin-bottom10">Automated Acknowledgements</li>
                        </ul>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <div class="owl-carousel controlls-over "
                        <%--data-plugin-options='{"items": 1, "singleItem": true, "navigation": true, "pagination": true, "transitionStyle":"fadeUp"}'--%>
                        data-plugin-options='{"autoPlay":3000, "stopOnHover":true, "items": 1, "singleItem": true, "navigation": false, "pagination": false, "transitionStyle":"fadeUp", "itemsScaleUp":true}'>

                        <div>
                            <img class="img-responsive  img-rounded" src="assets/images/freebies/shakinghands.jpg" alt="" data-bgposition="right center" data-bgfit="cover" border="0" />
                            <%-- data-bgfit="cover">--%>
                        </div>
                        <div>
                            <img class="img-responsive img-rounded" src="assets/images/freebies/W4.png" alt="">
                        </div>
                        <div>
                            <img class="img-responsive img-rounded" src="assets/images/freebies/I9.png" alt="">
                        </div>
                        <div>
                            <img class="img-responsive img-rounded" src="assets/images/freebies/DirectDeposit.png" alt="">
                        </div>

                    </div>

                </div>
            </div>



            <%--CALL US Call out--%>
            <div class="bs-callout text-center  styleSecondBackground">
                <h3><strong>Eliminate</strong> new hire paperwork</h3><br />
                     <a href="/corporate/contactus.aspx"  class="btn  btn-danger btn-lg">Schedule Demo</a>
               
                <%-- <h3>Contact us to schedule your personalized<strong> Demonstration.</strong>
                        <a href="#" target="_blank" class="btn btn-danger btn-lg">OK, GOT IT!</a></h3>--%>
            </div>




            <%--                <div class="row ">
                    <div class="col-md-2 text-center">
                        <i class="featured-icon half empty fa fa-heart-o"></i>

                    </div>

                    <div class="col-md-10 lead">
                        <br />
                        Standalone employer group implementation is <strong>30 days</strong>
                    </div>
                </div>

                <div class="row margin-top20">
                    <div class="col-md-2 text-center">
                        <i class="nomargin featured-icon fa fa-clock-o"></i>  
                    </div>

                    <div class="col-md-10">
                        <br />
                        <h4>2’nd Implementation as part of a Payroll, PEO or Broker integration/partnership is <strong>7 days</strong></h4>
                    </div>
                </div>--%>


            <%-- dropcaps
                 <p class="dropcap">Demographic import protocols identify loading errors and facilitate quicker resolution</p>--%>

            <!-- divider -->
            <%--   <div class="divider">
                    <i class="fa fa-star"></i>
                </div>--%>
        </section>




        <!-- Remove "margin-footer" if you use this on the middle of the page -->
        <%--<section class="cover margin-footer parallax" data-stellar-background-ratio="0.7" style="background-image: url('assets/images/jim/BirdonWire.jpg');">--%>
            <section class="cover margin-footer parallax" data-stellar-background-ratio="0.9" style="background-image: url('assets/images/placeit/IpadonCoffeeTable.jpg');">
            <span class="overlay"></span>

            <div class="container">

                <div class="owl-carousel text-center" data-plugin-options='{"items": 1, "singleItem": true, "navigation": true, "pagination": false, "autoPlay": false, "transitionStyle":"fadeUp"}'>
                    <!-- transitionStyle: fade, backSlide, goDown, fadeUp,  -->
                   <div class="testimonial text-center">
                        <p>
It was so nice to go through the online onboarding and enrollment process without having to fill out confusing forms.  The HR ease system was easy to use and provided information that helped me make the best choices for my benefits.  Thank you for making the whole process quick and easy!   </p>
                        <cite><strong>A newly hired</strong>, Employee</cite>
                    </div>


                   <%-- <div class="testimonial">
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

