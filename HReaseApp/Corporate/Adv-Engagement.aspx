<%@ Page Title="" Language="VB" MasterPageFile="~/Corporate/CorporateMaster.master" AutoEventWireup="false" CodeFile="Adv-Engagement.aspx.vb" Inherits="Adv_Engagement" %>


<asp:Content ID="Content3" ContentPlaceHolderID="body" Runat="Server">
    <!-- WRAPPER -->
    <div id="wrapper">

        <!-- PAGE TITLE -->
        <header id="page-title">

            <div class="container">
                <h1>Competitive Advantages</h1>

                <ul class="breadcrumb">
                    <li><a href="CorporateHome.aspx">Home</a></li>
                    <li><a href="Advantages.aspx">Advantages</a></li>
                    <li class="active">Communication & Engagement</li>
                </ul>
            </div>
        </header>

        <section class="container">

            <h2>Employee Communication & Engagement</h2>

            <p class="lead">
                Our Employee Self-Service system provides a user friendly dashboard that leads employees through the entire enrollment process in a familiar application approach. 
            </p>


           
            <div class="form-group">
               

                <div class="col-sm 8 col-md-8 margin-right-10">
                    <h3>Communication is the key</h3>
                    <%--<p>Our Employee Self-Service system provides a user friendly dashboard that leads employees through the onboarding or enrollment process in a familiar application approach.</p>--%>
                    <p>The fully configurable screens allow our customers to customize messaging, add additional documents and links, and include video throughout the entire enrollment journey.</p>
                    <p>Your employees will have access to every tool necessary, including plan comparisons, in order to research and choose the right benefit plans that are suitable to their needs.</p>
                    <p>Additional features like email capability, enrollment reminders and automatic confirmation of changes will provide your employees with the confidence in their enrollment decision.</p>

                    <div class="col-md-1"></div>
                    <div class="col-md-11">
                    <p class="text-primary">

                        <strong>Some of our fully customizable features include:</strong>
                    </p>
                    <ul class="list-icon star-o color circle ">
                        <li class="margin-bottom10">User Dashboard</li>
                        <li class="margin-bottom10">Configurable Messaging</li>
                        <li class="margin-bottom10">All HR and Plan Documents including carrier links, videos and tutorials</li>

                        <li class="margin-bottom10">Plan Information and Comparisons</li>
                        <li class="margin-bottom10">Email Capability</li>
                        <li class="margin-bottom10">Enrollment Reminders</li>
                        <li class="margin-bottom10">Confirmation of Changes</li>


                    </ul>
                    </div>

                </div>
                <div class="col-sm-4 col-md-4 margin-top20 hidden-xs">

                    <%-- <a class="pull-left inner lightbox" href="assets/images/demo/test_2.jpg" data-plugin-options='{"type":"image"}'>--%>
                    <img class="img-responsive pull-left" src="assets/images/jim/WWPWPhoto8.jpg" alt="image" width="100%" />
                    <%--</a>--%>
                </div>
            </div>



            <%--CALL US Call out--%>
            <div class="bs-callout text-center  styleSecondBackground">
                <h3>Provide your employees with every tool imaginable so that they <strong>feel confident </strong><br />in their enrollment choices.</h3><br />
                        <a href="/corporate/contactus.aspx"  class="btn btn-danger btn-lg">Schedule Demo</a>
            </div>




        </section>




        <!-- Remove "margin-footer" if you use this on the middle of the page -->
        <section class="cover margin-footer parallax" data-stellar-background-ratio="0.8" style="background-image: url('assets/images/placeit/GuywithCell.jpg');">
            <span class="overlay"></span>

            <div class="container">

                <div class="owl-carousel text-center" data-plugin-options='{"items": 1, "singleItem": true, "navigation": false, "pagination": false, "autoPlay": true, "transitionStyle":"fadeUp"}'>
                    <!-- transitionStyle: fade, backSlide, goDown, fadeUp,  -->
                    <div class="testimonial">
                        <p>The HR ease system was easy to use and provided information that helped me make the best choices for my benefits.  Thank you for making the whole process quick and easy!</p>
                        <cite><strong>Newly Hired</strong>, Employee</cite>
                    </div>

                    <div class="testimonial">
                        <p>Having the plan comparisons at my fingertips made my Open Enrollment decisions easier.</p>
                        <cite><strong></strong>Employee feedback</cite>
                    </div>

                  <%--  <div class="testimonial">
                        <p>The Learn more section of the Plan documents and rate charts right on the Elect pages were extremly helpful.  Thank you!</p>
                        <cite><strong>Employee</strong></cite>
                    </div>--%>

                    <%--<div class="testimonial">
                        <p>Donec tellus massa, tristique sit amet condim vel, facilisis quis sapien. Praesent id enim sit amet odio vulputate eleifend in in tortor. Donec tellus massa.</p>
                        <cite><strong>Melissa Doe</strong>, Customer</cite>
                    </div>--%>

                </div>

            </div>
        </section>


    </div>
    <!-- /WRAPPER -->

</asp:Content>