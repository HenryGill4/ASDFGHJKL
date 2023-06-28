<%@ Page Title="" Language="VB" MasterPageFile="~/Corporate/CorporateMaster.master" AutoEventWireup="false" CodeFile="PS_Reporting.aspx.vb" Inherits="PS_Reporting" %>

<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="Server">

    <!-- WRAPPER -->
    <div id="wrapper">

        <!-- PAGE TITLE -->
        <header id="page-title">

            <div class="container">
                <h1>Products & Services</h1>

                <ul class="breadcrumb">
                    <li><a href="CorporateHome.aspx">Home</a></li>
                    <li><a href="Products.aspx">Products & Services</a></li>
                    <li class="active">Reporting</li>
                </ul>
            </div>
        </header>

        <section class="container">

            <h2>Advanced Reporting </h2>

            <p class="lead">Keeping track of all of your data is easy with over 80 Standard reports that are easily organized on your custom dashboard, as a favorite, standard, or even hidden. Reports can be filtered, sorted, and generated in Excel, Word, or pdf. You can schedule reports for emailing or posting to ftp. </p>
            <div class="row">
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <p class="text-primary">
                        All reports generate in just a few moments and are realtime. No limitations on history!
                    </p>
                    <div class="col-md-1"></div>
                    <div class="col-md-11">
                        <ul class="list-icon star-o color circle ">
                            <li class="margin-bottom10 ">Over 80 Standard Reports</li>
                            <li class="margin-bottom10">Easily Organized</li>
                            <li class="margin-bottom10">Filter and/or sort on any field</li>
                            <li class="margin-bottom10">Generate to various formats</li>
                            <li class="margin-bottom10">Ability to run for one client or across several</li>
                        </ul>
                    </div>
                </div>
                <div class=" col-xs-12 col-sm-6 col-md-6">
                    <div class="owl-carousel controlls-over "
                        <%--data-plugin-options='{"items": 1, "singleItem": true, "navigation": true, "pagination": true, "transitionStyle":"fadeUp"}'--%>
                        data-plugin-options='{"autoPlay":4000, "stopOnHover":true, "items": 1, "singleItem": true, "navigation": false, "pagination": false, "transitionStyle":"fadeUp", "itemsScaleUp":true}'>

                       <%-- <div>
                            <img class="img-responsive img-rounded" src="assets/images/freebies/health-reports.jpg" alt="" data-bgposition="right center" data-bgfit="cover" border="0" />
                          
                        </div>--%>
                        <div>
                            <img class="img-responsive img-rounded" src="assets/images/freebies/Reports-Standard2.JPG" alt=""/>
                        </div>
                        <div>
                            <img class="img-responsive img-rounded" src="assets/images/freebies/Reports-Organize.JPG" alt=""/>
                        </div>
                        <div>
                            <img class="img-responsive img-rounded" src="assets/images/freebies/Reports-Run2.JPG" alt=""/>
                        </div>

                    </div>

                </div>
            </div>



            <%--CALL US Call out--%>
            <div class="bs-callout text-center  styleSecondBackground">
                <h3><strong>Access</strong> to your data has never been easier</h3><br />
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
        <section class="cover margin-footer parallax" data-stellar-background-ratio="0.7" style="background-image: url('assets/images/placeit/Guywithcell.jpg');">
            <span class="overlay"></span>

            <div class="container">

                <div class="owl-carousel text-center" data-plugin-options='{"items": 1, "singleItem": true, "navigation": true, "pagination": false, "autoPlay": False, "transitionStyle":"fadeUp"}'>
                    <!-- transitionStyle: fade, backSlide, goDown, fadeUp,  -->
                    <div class="testimonial">
                        <p></p>
                        <%--<cite><strong>John Doe</strong>, Customer</cite>--%>
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
