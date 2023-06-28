<%@ Page Title="" Language="VB" MasterPageFile="~/Corporate/CorporateMaster.master" AutoEventWireup="false" CodeFile="Adv_Infrastructure.aspx.vb" Inherits="Adv_Infrastructure" %>

<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">

    <!-- WRAPPER -->
    <div id="wrapper">

        <!-- PAGE TITLE -->
        <header id="page-title">

            <div class="container">
                <h1>Competitive Advantages</h1>

                <ul class="breadcrumb">
                    <li><a href="CorporateHome.aspx">Home</a></li>
                    <li><a href="Advantages.aspx">Advantages</a></li>
                    <li class="active">Cloud-based Infrastructure</li>
                </ul>
            </div>
        </header>

        <section class="container">

            <h2>Cloud-based Fully Hosted Intrastructure</h2>

            <p class="lead">Simply put, cloud computing is computing based on the internet.   Probably the most understated benefit of the cloud is that it has transformed our IT team  into a proactively innovative bunch that focuses a lot less on manual system administration, and a lot more on developing and enhancing our products and services. </p>



            <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-10">

                    <a class="pull-right right inner lightbox"  data-plugin-options='{"type":"image"}'>
                        <img class="img-responsive img-rounded margin-top50" src="assets/images/freebies/cloud-benefits-revised.jpg" alt="image"  width="400px" />     <%--src="assets/images/freebies/Cloud.png"--%>
                    </a>
                    <p class="text-primary">

                        <strong>Advantages of the Cloud</strong>
                    </p>
                    <p><strong>Accessibility</strong>  
                        From tablets to smartphones, netbooks to desktops, we’re using more devices on a daily basis than ever before, and toggling files between each of these devices can be cumbersome and complex. Not so with online storage services. You can access your account from any internet connection, whether you're on a mobile browser or your work computer.</p>

                    <p><strong>Flexibility</strong>
                        The ability for us to expand in size and bandwidth can be achieved instantly to meet the demand because of the vast capacity of the service’s remote servers.  Unlimited storage capability and scalability ensures that all of your valuable data is stored safely and securely.</p>

                    <p>
                        <strong>Security</strong>
                        Cloud storage serves as an added layer of data protection for your precious and irreplaceable data. Backups are kept in very secure data centers in multiple geographic areas that is physically removed from the originals.  With online storage services, data is encrypted both during transmission and while at rest, ensuring no unauthorized users can access the files.   Also, the data is being automatically backed up, providing additional security and peace of mind. Because of the data center hosting, you’re getting the added benefit of disaster recovery.
                    </p>
                    <p>
                        <strong>Protection </strong>
                        Cloud computing providers provide Disaster recovery plans and are able to resolve issue nearly 4x faster than businesses not using the cloud service.  Because our servers are automatically backed up in the case of a catastrophic data loss event the data can be restored with almost zero downtime.
                    </p>


                </div>
            </div>



            <%--CALL US Call out--%>
            <div class="bs-callout text-center  styleSecondBackground">
                <h3>"Line-of-business leaders everywhere are bypassing IT departments to get applications from the cloud (also known as software as a service, or SaaS) and paying for them like they would a magazine subscription. And when the service is no longer required, they can cancel that subscription with no equipment left unused in the corner." <br />
                    <i>-<strong>Daryl Plummer</strong>, Gartner analyst</i></h3>
                <br />
                        <a href="/corporate/contactus.aspx"  class="btn btn-danger btn-lg">Schedule Demo</a>
               
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
        <section class="cover margin-footer parallax" data-stellar-background-ratio="0.7" style="background-image: url('assets/images/jim/BirdsReflection.jpg');">
            <span class="overlay"></span>

            <div class="container">

                <div class="owl-carousel text-center" data-plugin-options='{"autoPlay":5000, "stopOnHover":true, "items": 1, "singleItem": true, "navigation": false, "pagination": false, "transitionStyle":"goDown", "itemsScaleUp":true}'>         
                    <!-- transitionStyle: fade, backSlide, goDown, fadeUp,  -->
                    <div class="testimonial">
                        <p>As a programmer, I get to focus on system enhancements as opposed to system maintenance.</p>
                        <cite><strong>Senior Programmer</strong>, HR ease</cite>
                    </div>

                    <div class="testimonial">
                        <p>I don’t need a hard disk in my computer if I can get to the server faster… carrying around these non-connected computers is byzantine by comparison.</p>
                        <cite><strong>Steve Jobs</strong>, late chairman of Apple (1997)</cite>
                    </div>

                    <div class="testimonial">
                        <p>Cloud computing is often far more secure than traditional computing, because companies like Google and Amazon can attract and retain cyber-security personnel of a higher quality than many governmental agencies.</p>
                        <cite><strong>Vivek Kundra</strong>, former federal CIO of the United States</cite>
                    </div>

                  <%--  <div class="testimonial">
                        <p>Donec tellus massa, tristique sit amet condim vel, facilisis quis sapien. Praesent id enim sit amet odio vulputate eleifend in in tortor. Donec tellus massa.</p>
                        <cite><strong>Melissa Doe</strong>, Customer</cite>
                    </div>--%>

                </div>

            </div>
        </section>


    </div>
    <!-- /WRAPPER -->

</asp:Content>