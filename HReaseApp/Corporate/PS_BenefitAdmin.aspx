<%@ Page Title="" Language="VB" MasterPageFile="~/Corporate/CorporateMaster.master" AutoEventWireup="false" CodeFile="PS_BenefitAdmin.aspx.vb" Inherits="PS_BenefitAdmin" %>

<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">
        <meta name="keywords" content="Employee Self Service, Administrator Dashboard, Benefits Administration," />

    <!-- WRAPPER -->
    <div id="wrapper">

        <!-- PAGE TITLE -->
        <header id="page-title">

            <div class="container">
                <h1>Products & Services</h1>

                <ul class="breadcrumb">
                    <li><a href="CorporateHome.aspx">Home</a></li>
                    <li><a href="Products.aspx">Products & Services</a></li>
                    <li class="active">Benefits Administration</li>
                </ul>
            </div>
        </header>

        <section class="container">

            <h2>Benefits Administration </h2>

            <p class="lead">HR ease was designed from the ground up with Simplicity in mind. Employees and Administrators have significant power at their fingertips,  all displayed in simple User Dashboards with obvious Workflow to enroll or change benefit information.</p>



            <div class="row">
                <div class="col-md-1"></div>
                <div class="col-sm-6 col-md-6">
                    <br />
                    <br />
                    <p class="text-primary"><strong>Employee Self Service</strong></p>
                    <p>
                        Employees log in through secure portal to access a personalized User Dashboard and navigate to enrollment options and information.  Easy to use system enables employees to update their core data, add Dependents or Beneficaries, Research about their benefits, view Plan and Rate Comparisons, enroll online, and confirm thier elections.
                    </p>
                </div>
                <div class="col-sm-5 col-md-5  hidden-xs">
                    <img class="img-responsive" src="assets/images/freebies/laptopwelcome.png" alt="image" />
                </div>
            </div>

            <div class="row">
                <div class="col-md-1"></div>
                <div class="col-sm-5 col-md-5 hidden-xs">
                    <img class="img-responsive" src="assets/images/freebies/laptopadmin.png" alt="image" />
                </div>
                <div class="col-sm-6 col-md-6">
                    <br />
                    <br />
                    <p class="text-primary"><strong>Administrator Dashboard </strong></p>
                    <p>
                        Enrollers, Agents, and Client Administrators have one log in to access the Administrator Dashboard where they can manage all their clients and employees.  Admintrators can add new employees, approve employee elections, manage client customizable messaging, benefit plans and have access to configurable reports.
                    </p>
                </div>
                
            </div>

             <div class="row">
                  <div class="col-md-1"></div>              
                     <div class="col-sm-6 col-md-6  ">
                          <br />
                    <br />            
                     <p class="text-primary">
                        <strong>The following features are part of the architecture of HR ease system</strong>
                    </p>
                    <ul class="list-icon star-o color circle ">
                        <li >Secure</li>
                        <li >Customizable</li>
                        <li >Dashboard</li>
                        <li >Intuitive Navigation</li>
                        <li >Plan Comparisons</li>
                        <li >Configurable Reporting Comparisons</li>
                        <li >Invoice Reporting/Audit</li>
                        <li >Email alerts</li>
                    </ul>
                </div>
                  <div class="col-sm-5 col-md-5  margin-top100">

                   <%-- <a class="pull-left inner lightbox" href="assets/images/demo/test_2.jpg" data-plugin-options='{"type":"image"}'>--%>
                       <%-- <img class="img-responsive pull-left" src="assets/images/freebies/healthcaresolutions.png" alt="image" width="100%" />--%>
                   <img class="img-responsive img-rounded " src="assets/images/Placeit/LadywithCell.jpg"   alt="">
                    <%--</a>--%>
                </div>
            </div>



            <%--CALL US Call out--%>
            <div class="bs-callout text-center  styleSecondBackground">
                <h3>Designed with <strong>Simplicity</strong> in mind yet <strong>Powerful</strong> enough to handle <br />all of your complex business rules. </h3><br />
                     <a href="/corporate/contactus.aspx"  class="btn  btn-danger btn-lg">Schedule Demo</a>
                <%-- <h3>Contact us to schedule your personalized<strong> Demonstration.</strong>
                       
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
        <section class="cover margin-footer parallax img-responsive" data-stellar-background-ratio="1.0" style="background-image: url('assets/images/placeit/IpadonCoffeeTable.jpg');">
            <span class="overlay"></span>

            <div class="container">

                <%--<div class="owl-carousel text-center" data-plugin-options='{"items": 1, "singleItem": true, "navigation": true, "pagination": false, "autoPlay": true, "transitionStyle":"fadeUp"}'>--%>
                    <!-- transitionStyle: fade, backSlide, goDown, fadeUp,  -->
                    <div class="testimonial text-center">
                        <p>
It was so nice to go through the online onboarding and enrollment process without having to fill out confusing forms.  The HR ease system was easy to use and provided information that helped me make the best choices for my benefits.  Thank you for making the whole process quick and easy!   </p>
                        <cite><strong>A newly hired</strong>, Employee</cite>
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
                    </div>

                </div>--%>

            </div>
        </section>


    </div>
    <!-- /WRAPPER -->

</asp:Content>



