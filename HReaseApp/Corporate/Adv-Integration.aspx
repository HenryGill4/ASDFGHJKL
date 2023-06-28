<%@ Page Title="" Language="VB" MasterPageFile="~/Corporate/CorporateMaster.master" AutoEventWireup="false" CodeFile="Adv-Integration.aspx.vb" Inherits="Adv_Integration" %>

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
                    <li class="active">Data Integration</li>
                </ul>
            </div>
        </header>

        <section class="container">

            <h2>Fully Managed Data Integration</h2>

            <p class="lead">
               Our combination of technical and business processes allows us to easily integrate with all of your trusted data sources.  We import/export payroll and carrier EDI information with today’s secure standards using data encryption and ftp/sftp transmissions.  Our fully automated system will track, log, produce email notification and reporting tools and securely archive every bit of your employee’s valuable data.  
            </p>

            <div class="row">
                <div class="col-md-6 margin-top50">
                      <div class="owl-carousel controlls-over" 
                           <%--data-plugin-options='{"items": 1, "singleItem": true, "navigation": true, "pagination": true, "transitionStyle":"fadeUp"}'--%>
                           data-plugin-options='{"autoPlay":6000, "stopOnHover":true, "items": 1, "singleItem": true, "navigation": false, "pagination": false, "transitionStyle":"fade", "itemsScaleUp":true}'>         
							<div>
								<img class="img-responsive  img-rounded" src="assets/images/jim/CausewayBoat.jpg"alt="">
							</div>
							<div>
								<img class="img-responsive img-rounded" src="assets/images/freebies/RADIS.png" width="100%" alt="">
							</div>
							<%--<div>
								<img class="img-responsive" src="assets/images/freebies/ACASampleReportRun.JPG"  alt="">
							</div>--%>
                          <%-- <div>
								<img class="img-responsive" src="assets/images/freebies/ACAWaive.JPG"  alt="">
							</div>--%>
                           
						</div>

                </div>

                <div class="col-md-6 margin-top20">
                    <h4><strong>R</strong>eporting and
                        <strong>D</strong>ata
                        <strong>I</strong>ntegration
                        <strong>S</strong>oftware


                    </h4>
                    <p>We import/export payroll and carrier EDI information with today’s secure standards using data encryption and ftp/sftp transmissions. 
                         Our fully automated system will track, log, produce email notification and reporting tools and securely archive every bit of your employee’s valuable data.</p>


                    <div class="col-md-1"></div>
                    <div class="col-md-11">
                    <p class="text-primary">
                        <strong>Some of our fully customizable features include:</strong>
                    </p>
                    <ul class="list-icon star-o color circle ">
                        <li class="margin-bottom10">Carrier EDI</li>
                        <li class="margin-bottom10">Imports and Exports</li>
                        <li class="margin-bottom10">Transmitted with ftp/sftp</li>

                        <li class="margin-bottom10">Encrypt/Decrypt</li>
                        <li class="margin-bottom10">Archive, Log and Report</li>
                        <li class="margin-bottom10">Email Capabilities</li>
                        <li class="margin-bottom10">Fully Automated</li>


                    </ul>

                    </div>
                </div>
               
            </div>



            <%--CALL US Call out--%>
            <div class="bs-callout text-center  styleSecondBackground">
                <h3><strong>RADIS </strong>controls all of your B2B data transactions, internal data integration, processing and reporting in a secure environment. </h3><br />
                        <a href="/corporate/contactus.aspx"  class="btn btn-danger btn-lg">Schedule Demo</a>
            </div>




        </section>




        <!-- Remove "margin-footer" if you use this on the middle of the page -->
        <section class="cover margin-footer parallax" data-stellar-background-ratio="0.7" style="background-image: url('assets/images/jim/BirdonWire.jpg');">
            <span class="overlay"></span>

            <div class="container">

                <div class="owl-carousel text-center" data-plugin-options='{"items": 1, "singleItem": true, "navigation": false, "pagination": false, "autoPlay": true, "transitionStyle":"backSlide"}'>
                    <!-- transitionStyle: fade, backSlide, goDown, fadeUp,  -->
                    <div class="testimonial">
                        <p>It was very convenient to receive an email notice each week when our files were delivered and sitting on our server. </p>
                        <cite><strong>Administrator</strong>, PEO client</cite>
                    </div>

                    <div class="testimonial">
                        <p>I felt very confident about my elections when I received an email confirmation of all my benefit choices.</p>
                        <cite><strong>New hired</strong>, Employee</cite>
                    </div>

                   <%-- <div class="testimonial">
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


