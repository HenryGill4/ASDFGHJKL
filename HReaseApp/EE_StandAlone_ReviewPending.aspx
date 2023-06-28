<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EE_StandAlone_ReviewPending.aspx.vb" Inherits="HReaseApp.EE_StandAlone_ReviewPending" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   
    <title>Benefit Reflection</title>

        <meta charset="utf-8" />
        <meta name="author" content="BevSmith " />

		<!-- mobile settings -->
		<meta name="viewport" content="width=device-width, maximum-scale=1, initial-scale=1, user-scalable=0" />

		<!-- WEB FONTS Original line but had to separate because of stupid IE
		<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700,800" rel="stylesheet" type="text/css" />
             -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:700" rel="stylesheet" type="text/css" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:800" rel="stylesheet" type="text/css" />
		<!-- CORE CSS -->
		<%--<link href="Corporate/assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />--%>
        <link href="Corporate/assets/plugins/bootstrap/css/bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="Corporate/assets/css/font-awesome.css" rel="stylesheet" type="text/css" />
        <link href="Corporate/assets/plugins/owl-carousel/owl.carousel.css" rel="stylesheet" type="text/css" />
        <link href="Corporate/assets/plugins/owl-carousel/owl.theme.css" rel="stylesheet" type="text/css" />
        <link href="Corporate/assets/plugins/owl-carousel/owl.transitions.css" rel="stylesheet" type="text/css" />
        <link href="Corporate/assets/plugins/magnific-popup/magnific-popup.css" rel="stylesheet" type="text/css" />
        <link href="Corporate/assets/css/animate.css" rel="stylesheet" type="text/css" />
        <link href="Corporate/assets/css/superslides.css" rel="stylesheet" type="text/css" />

		<!-- REVOLUTION SLIDER -->
		<link href="Corporate/assets/plugins/revolution-slider/css/settings.css" rel="stylesheet" type="text/css" />

		<!-- THEME CSS -->
		<link href="Corporate/assets/css/essentials.css" rel="stylesheet" type="text/css" />
        <link href="Corporate/assets/css/layout.css" rel="stylesheet" type="text/css" />
        <link href="Corporate/assets/css/layout-responsive.css" rel="stylesheet" type="text/css" />
        <link href="Corporate/assets/css/color_scheme/darkblue.css" rel="stylesheet" type="text/css" /><!-- orange: default style -->
		<!--<link id="css_dark_skin" href="Corporate/assets/css/layout-dark.css" rel="stylesheet" type="text/css" />--><!-- DARK SKIN -->
        	
		<!-- Morenizr -->
		<script type="text/javascript" src="Corporate/assets/plugins/modernizr.min.js"></script>
        
 
</head>

<body class="appboxed" > 
    <form id="frmReviewPending" runat="server"  class=" form-horizontal">

            <div id="wrapper" style="background-color:#fff;">
                 <div class="container ">
                     <div class="col-xs-6 col-sm-4 col-md-4 pull-right">
                         <asp:ImageButton ID="imgClose" runat="server" ImageUrl="../img/BlueCloseBtn.png" OnMouseOver="src='/img/BlueCloseBtnOver.png';" OnMouseOut="src='/img/BlueCloseBtn.png';" background="#fff" BorderStyle="None" ImageAlign="right" Visible="true" onclick="imgClose_Click" />
                     </div>
                 </div>


                 <div id="divSummary" class="container well-white">
                      <div class="form-group">
                         <div class="col-xs-12 col-sm-12 col-md-12">
                             <h3>
                                 <asp:Label ID="lblEmployeeName" runat="server"></asp:Label></h3>
                         </div>                       
                     </div>

                     <div class="form-group">
                         <div class="col-md-5 text-muted ">
                             <asp:Label ID="lblPayFrequency" runat="server"></asp:Label>
                         </div>
                         <div class="col-xs-6 col-sm-4 col-md-4 pull-right">
                             <table id="tblLegend" class="table">
                                 <tr>
                                     <td style="width: 33.3%;" class="grdNormalAltrow text-center">Existing</td>
                                     <td style="width: 33.3%;" class="grdPendingrow text-center">Pending</td>
                                     <td style="width: 33.3%;" class="grdMissingrow text-center">No Election</td>
                                 </tr>
                             </table>
                         
                         </div>

                          
                     </div>
                     <div id="divSummaryTable" class="col-xs-12 col-sm-12 col-md-12 ">
                         <asp:Table ID="tblSummary" runat="server" CssClass="table-condensed">
                         </asp:Table>
                     </div>
                 </div>
             </div>
     
    </form>
</body>
</html>
