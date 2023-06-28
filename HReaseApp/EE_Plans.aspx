<%@ Page Title="Benefit Enrollment" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeaderSplit.Master" 
    CodeBehind="EE_Plans.aspx.vb" 
    Inherits="HReaseApp.EE_Plans" 
    EnableViewState="true" 
    MaintainScrollPositionOnPostback="true" %>

<%-- 11/19/2021 - SKG - Last change was to make Waive Modal textboxes TextBoxMode MultiLine --%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
    <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainBlock" Runat="Server" >
    <meta name="viewport" content="initial-scale = 1.0, maximum-scale = 1.0, user-scalable = no, width = device-width"/>
    <style>
      @keyframes spinner {
        0% {
          transform: translate3d(-50%, -50%, 0) rotate(0deg);
        }
        100% {
          transform: translate3d(-50%, -50%, 0) rotate(360deg);
        }
      }
      .spin::before {
        animation: 1.5s linear infinite spinner;
        animation-play-state: inherit;
        border: solid 5px #cfd0d1;
        border-bottom-color: #1c87c9;
        border-radius: 50%;
        content: "";
        height: 40px;
        width: 40px;
        position: absolute;
        top: 10%;
        left: 10%;
        transform: translate3d(-50%, -50%, 0);
        will-change: transform;
      }
     
    .custompagination {
      display: inline-block;
      padding-left: 0;
      margin: 20px 0;
    }
    .custompagination > li {
      display: inline;
    }
    .custompagination > li > a,
    .custompagination > li > span {
      position: relative;
      float: left;
      padding: 6px 12px;
      line-height: 1.42857143;
      color: #337ab7;
      text-decoration: none;
      background-color: #fff;
      border: 1px solid #ddd;
      border-top-left-radius: 4px;
      border-top-right-radius: 4px;
      border-bottom: none;
    }
    
    .custompagination > li > a:hover,
    .custompagination > li > span:hover,
    .custompagination > li > a:focus,
    .custompagination > li > span:focus {
      z-index: 3;
      color: #23527c;
      background-color: #eee;
      border-color: #ddd;
    }
    .custompagination > .active > a,
    .custompagination > .active > span,
    .custompagination > .active > a:hover,
    .custompagination > .active > span:hover,
    .custompagination > .active > a:focus,
    .custompagination > .active > span:focus {
      z-index: 2;
      color: #fff;
      cursor: default;
      background-color: #337ab7;
      border-color: #337ab7;
      border-top-left-radius: 4px;
      border-top-right-radius: 4px;
      border-bottom: none;
    }
    .custompagination > .disabled > span,
    .custompagination > .disabled > span:hover,
    .custompagination > .disabled > span:focus,
    .custompagination > .disabled > a,
    .custompagination > .disabled > a:hover,
    .custompagination > .disabled > a:focus {
      color: #777;
      cursor: not-allowed;
      background-color: #fff;
      border-color: #ddd;
    }
        .form-group {
          margin-bottom: 5px;
        }
        .modal {
            position: fixed;
            top: 20px;
            left: 0 !important;
            z-index: 2000;
            display: none;
        }
        .modal-dialog {
          z-index:2000;
          width: 80%;
          padding: 10px 10px 0px 10px;
          margin-right: auto;
          margin-left: auto;
        }
        .modal-content {
            position: relative;
            background-color: #ffffff;
            border: 1px solid #999999;
            border: 1px solid rgba(0, 0, 0, 0.2);
            border-radius: 6px;
            outline: none;
            -webkit-box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
            box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
            background-clip: padding-box;
            height: auto; /* allow to fit content (if smaller)... */
            /*max-height: 1000px;  ... but make sure it does not overflow browser window */
            /* allow vertical scrolling if required */
            overflow-x: auto;
            overflow-y: auto;
        }
        .modal-body {
            position: relative;
            padding: 10px 10px 0px 10px;
            background-color: white;
            /*overflow-x: auto;*/
        }
        .modal-footer {
          padding: 5px 7px 5px 5px;
          margin-top: 0px;
          text-align: right;
          border-top: 1px solid #e5e5e5;
        }
         @media only screen and (max-width: 780px) {
             .mobile-rescale{
                 max-width:95% !important;
                 text-align:center !important;
                 font-size: 14px !important;
                 padding:4% !important;
             } 
            .mobile-margin{
                margin:auto !important;
                padding:4% !important;
            }
            .mobile-hide{
                display: none !important;
            }
        }
    </style>

    <script type="text/javascript">      
        $(document).ready(function () {
            $(".noautocomplete").attr("autocomplete", "off");
        });
        function Waivechk1(checkbox) {
            if (checkbox.checked) {
                var a = '';
                $('input:text[id$=txtResponseQD2a]').val(a);
                $('input:text[id$=txtResponseQD2b]').val(a);
                $('input:text[id$=txtResponseQD2c]').val(a);
                $('input:text[id$=txtResponseQD2d]').val(a);
                $('input:text[id$=txtResponseQD3a]').val(a);
                $('input:text[id$=txtResponseQD3b]').val(a);
                $('input:text[id$=txtResponseQD3c]').val(a);
                $('input:text[id$=txtResponseQD3d]').val(a);
                $('input:text[id$=txtResponseQD4a]').val(a);
                $('input:text[id$=txtResponseQD4b]').val(a);
                $('input:text[id$=txtResponseQD4c]').val(a);
                $('input:text[id$=txtResponseQD4d]').val(a);

                $('input:text[id$=txtResponseQD1a]').prop('placeholder', 'REQUIRED');
                $('input:text[id$=txtResponseQD1b]').prop('placeholder', 'REQUIRED');
                $('input:text[id$=txtResponseQD1c]').prop('placeholder', 'REQUIRED');
                $('input:text[id$=txtResponseQD1d]').prop('placeholder', 'REQUIRED');

                /*$('input:button[id$=btnSaveWaiveQuestions]').val('TEST');*/

                //document.getElementById("btnSaveWaiveQuestions").prop('text','pleasework');

            }
        }
        function Waivechk2(checkbox) {
            if (checkbox.checked) {
                var a = '';
                $('input:text[id$=txtResponseQD1a]').val(a);
                $('input:text[id$=txtResponseQD1b]').val(a);
                $('input:text[id$=txtResponseQD1c]').val(a);
                $('input:text[id$=txtResponseQD1d]').val(a);
                $('input:text[id$=txtResponseQD3a]').val(a);
                $('input:text[id$=txtResponseQD3b]').val(a);
                $('input:text[id$=txtResponseQD3c]').val(a);
                $('input:text[id$=txtResponseQD3d]').val(a);
                $('input:text[id$=txtResponseQD4a]').val(a);
                $('input:text[id$=txtResponseQD4b]').val(a);
                $('input:text[id$=txtResponseQD4c]').val(a);
                $('input:text[id$=txtResponseQD4d]').val(a);

                $('input:text[id$=txtResponseQD2a]').prop('placeholder', 'REQUIRED');
                $('input:text[id$=txtResponseQD2b]').prop('placeholder', 'REQUIRED');
                $('input:text[id$=txtResponseQD2c]').prop('placeholder', 'REQUIRED');
                $('input:text[id$=txtResponseQD2d]').prop('placeholder', 'REQUIRED');
                 
            }
        }
        function Waivechk3(checkbox) {
            if (checkbox.checked) {
                var a = '';
                $('input:text[id$=txtResponseQD1a]').val(a);
                $('input:text[id$=txtResponseQD1b]').val(a);
                $('input:text[id$=txtResponseQD1c]').val(a);
                $('input:text[id$=txtResponseQD1d]').val(a);
                $('input:text[id$=txtResponseQD2a]').val(a);
                $('input:text[id$=txtResponseQD2b]').val(a);
                $('input:text[id$=txtResponseQD2c]').val(a);
                $('input:text[id$=txtResponseQD2d]').val(a);
                $('input:text[id$=txtResponseQD4a]').val(a);
                $('input:text[id$=txtResponseQD4b]').val(a);
                $('input:text[id$=txtResponseQD4c]').val(a);
                $('input:text[id$=txtResponseQD4d]').val(a);

                $('input:text[id$=txtResponseQD3a]').prop('placeholder', 'REQUIRED');
                $('input:text[id$=txtResponseQD3b]').prop('placeholder', 'REQUIRED');
                $('input:text[id$=txtResponseQD3c]').prop('placeholder', 'REQUIRED');
                $('input:text[id$=txtResponseQD3d]').prop('placeholder', 'REQUIRED');
            }
        }
        function Waivechk4(checkbox) {
            if (checkbox.checked) {
                var a = '';
                $('input:text[id$=txtResponseQD1a]').val(a);
                $('input:text[id$=txtResponseQD1b]').val(a);
                $('input:text[id$=txtResponseQD1c]').val(a);
                $('input:text[id$=txtResponseQD1d]').val(a);
                $('input:text[id$=txtResponseQD2a]').val(a);
                $('input:text[id$=txtResponseQD2b]').val(a);
                $('input:text[id$=txtResponseQD2c]').val(a);
                $('input:text[id$=txtResponseQD2d]').val(a);
                $('input:text[id$=txtResponseQD3a]').val(a);
                $('input:text[id$=txtResponseQD3b]').val(a);
                $('input:text[id$=txtResponseQD3c]').val(a);
                $('input:text[id$=txtResponseQD3d]').val(a);
                $('input:text[id$=txtResponseQD4a]').prop('placeholder', 'REQUIRED');
                $('input:text[id$=txtResponseQD4b]').prop('placeholder', 'REQUIRED');
                $('input:text[id$=txtResponseQD4c]').prop('placeholder', 'REQUIRED');
                $('input:text[id$=txtResponseQD4d]').prop('placeholder', 'REQUIRED');
                         
            }
        }
    </script>
    <div class="HREwrapper">
        <p id="demo"></p>
        <div id="divPageTitle" >
            <div>
                <br />
                <h4><b>Benefit Plan Elections</b></h4>
            </div>
        </div>
            
        <div id="divPlanTypeTabs" runat="server" style="padding:20px 0px 0px 0px;">
            <ul id="BenTabs" runat="server" class="custompagination">
                <asp:Literal ID="ltrBenTabs" runat="server" ></asp:Literal>      
            </ul>
        </div>

        <div id="divTopHeader" class="form-group">                  
            <div id="divError" runat="server" visible ="false" style="vertical-align:middle; display:inline; padding-left:50px;">
                <div style="float:left;">
                    <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="50px" />
                </div>
                <br /><br />
                <div id="divErrorLabel" style="text-align:left; color:red; font-size:large; padding-left:20px;">
                    <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
                </div>
            </div>
            <div id="divSuccess" runat="server" visible ="false" style="vertical-align:middle; display:inline; padding-left:50px;">
                <div style="float:left;">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" />
                </div>
                <div id="divSuccessLabel" style="text-align:center; color:green; font-size:x-large;">
                    <b><asp:Label ID="lblSuccess" runat="server" Text="Form Complete"></asp:Label></b>
                </div>
            </div>
        </div> 
        
        <div id="divMainForm" runat="server">   
            <div id="divBenefits" runat="server" >
                <div id="divTopPlanBanner" class="form-group well HRESlateBlue HRERewrap">
                    <div class="col-sm-8 col-md-8" style="float:left; margin-left:-3%;">
                        <h4><b><asp:Label ID="lblPlanType"  runat="server"> </asp:Label> </b>  </h4>            
                        <h5><b>Existing Election: </b><asp:Label ID="lblCurrentElection" runat="server"></asp:Label></h5>
                    </div>
                    <div style="float:right; padding-right:2%;">
                        <h5> <asp:Label ID="lblEventType" runat="server" > </asp:Label></h5>
                        <h5> <asp:Label ID="lblEventDate" runat="server" ></asp:Label></h5>
                    </div>
                </div>

                <div id="divLearnSection" runat="server" class="form-group HREWhite HRERewrap">
                    <div class="col-xs-12 col-sm-12 col-md-11 col-lg-11">
                        <div id="divLearn"  runat="server">
                            <div class="form-group">
                                <div id="divStep1" class="col-md-10 ">
                                    <h4><asp:Label ID="lblLearnTop" runat="server" Text="Step 1:  Learn about your Options"></asp:Label></h4>
                                </div>
                                <div id="divShowHide" class="col-md-1 pull-right right">
                                    <asp:ImageButton ID="imgHideLearn" runat="server" ImageUrl="../img/minus.png" BorderStyle="None" ImageAlign="Right" Visible="true" Width="25px" OnClick="imgHideLearn_Click" />
                                    <asp:ImageButton ID="imgShowLearn" runat="server" ImageUrl="../img/plus.png" BorderStyle="None" ImageAlign="Right" Visible="false" Width="25px" OnClick="imgShowLearn_Click" />
                                </div>
                            </div>             
                            <div id="divLearnInfo" runat="server">
                                <div id="divLearnComment" runat="server" class="form-group">
                                    <div class="col-md-12 ">
                                        <h4><asp:Label ID="lblCommentTitle" runat="server" Text="Title Goes here" /></h4>
                                    </div>
                                    <div class="col-md-12 ">
                                        <asp:Label ID="lblCommentShort" runat="server" Text="Short Comment Text goes here" />
                                        <asp:Label ID="lblComment" runat="server" Text="Comment Text goes here" />
                                    </div>
                                </div>
                                
                                <div id="divDocuments" runat="server" class="form-group">
                                    <div class="col-md-12">
                                        <div>                                                                           
                                            <h4>
                                                <asp:Label ID="lblDocumentType" runat="server"></asp:Label>
                                            </h4>
                                            <div class="col-md-12">
                                                <asp:Repeater ID="ddlPlanDocuments" runat="server" OnItemDataBound="ddlPlanDocuments_ItemDataBound"  >
                                                    <HeaderTemplate>
                                                        <table>
                                                    </HeaderTemplate>
                                                    <ItemTemplate >
                                                        <tr>
                                                            <td>
                                                                <%# Container.DataItem("DocumentName")%>
                                                            </td>
                                                        </tr>
                                                    </ItemTemplate>
                                                    <FooterTemplate></table></FooterTemplate>
                                                </asp:Repeater>                                           
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div id="divRateComparison" runat="server" class="form-group">
                                        <br />
                                    <div class="col-xs-12 col-sm-12 col-md-7 col-lg-7">
                                        <h4>
                                            <asp:Label ID="lblRateOptions" runat="server" Text="Plan Rate Comparison"></asp:Label></h4>
                                    </div>
                                    <div class="col-xs-12 col-sm-12 col-md-5 col-lg-5 text-muted  right pull-right small">
                                        <asp:Label ID="lblPayFrequency3" runat="server" Text=" "></asp:Label>
                                    </div>


                                    <div class=" col-xs-12 col-sm-12 col-md-12" style="max-height: 320px; overflow-y: scroll;">
                                        <asp:GridView ID="grdRateOptions" runat="server"
                                            DataKeyNames=" PlanId, PlanLongDesc" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                                            GridLines="None" BorderColor="#3276B1"
                                            CellPadding="4"
                                            EmptyDataText="No Rate Options found.">
                                        
                                            <Columns>
                                                <asp:BoundField HeaderText="Plan Id" DataField="PlanId" Visible="false" />
                                                <asp:TemplateField HeaderText="Plan Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPlanName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PlanLongDesc")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField HeaderText="Coverage" DataField="Coverage" />
                                                <asp:BoundField HeaderText="EE Cost" DataField="EECost" DataFormatString="{0:c}" HtmlEncode="False" ItemStyle-CssClass="text-right" HeaderStyle-CssClass="text-right" />
                                                <asp:BoundField HeaderText="ER Cost" DataField="ERCost" DataFormatString="{0:c}" HtmlEncode="False" ItemStyle-CssClass="text-right" HeaderStyle-CssClass="text-right" />
                                                <asp:BoundField HeaderText="Total Cost" DataField="TotalCost" DataFormatString="{0:c}" HtmlEncode="False" ItemStyle-CssClass="text-right" HeaderStyle-CssClass="text-right" />
                                                <asp:BoundField HeaderText=" " DataField="" Visible="true" />
                                            </Columns>
                                            <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                            <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                                        </asp:GridView>
                                    </div>
                                </div>
                          
                                <div id="divMoreBtn" class="form-group" style="padding-top:10px;">
                                    <div class="col-md-12  text-center">
                                        <%--<asp:ImageButton ID="btnMoreDocument" runat="server" ImageUrl="/img/BlueMoreBtn.png" ImageAlign="Middle" Visible="false" OnMouseOver="src='/img/BlueMoreBtnOver.png';" OnMouseOut="src='/img/BlueMoreBtn.png';" OnClick="btnMoreDocument_Click"></asp:ImageButton>--%>
                                        <asp:Button ID="btnMoreDocument" runat="server" CssClass="mobile-rescale btn-primary btn-lg " Text="Click here to see more information" onclick="btnMoreDocument_Click" onsubmit="ShowLoading()"/>
                                        <br />
                                    </div>
                                </div>
                            </div>
                    
                        </div>
                    </div>
                </div>

                <div id="divElectOrDecline" runat="server" class="form-group HRELightBlue" style="border:1px solid grey; margin-right:5%;">
                    <div class="col-xs-12 col-sm-12 col-md-11 col-lg-11">
                        <div id="divPlans" runat="server">
                            <div id="divStep2" class="col-md-10">
                                <%--Elect or Waive - No Modal on either--%>
                                <div id="divElectWaiveNoModal" runat="server"> 
                                    <h4>
                                        <asp:Label ID="lblElectorDecline" runat="server" Text="Step 2: Elect or Decline Coverage"></asp:Label></h4>
                                    <div class="form-group">
                                        <div class="col-xs-2 col-sm-2 col-md-3">
                                        </div>
                                        <div class="col-xs-10 col-sm-10 col-md-10  radio">
                                            <asp:RadioButton ID="rdElect" runat="server" Text="I choose to Elect Coverage" GroupName="grpElectWaiveNoModal" AutoPostBack="True"/><br />
                                            <asp:RadioButton ID="rdWaive" runat="server" Text="I choose to Decline Coverage" GroupName="grpElectWaiveNoModal" AutoPostBack="True" />
                                        </div>
                                    </div>
                                </div>
                                <%--Elect No Modal - Waive has Info Only Modal--%>
                                <div id="divWaiveWithInfoModal" class="well-success" runat="server">
                                    <h4>
                                        <asp:Label ID="lblElectDeclineInfo" runat="server" Text="Step 2:  Elect or Decline Coverage"></asp:Label></h4>
                                    <div class="form-group">
                                        <div class="col-xs-2 col-sm-2 col-md-3">
                                        </div>
                                        <div class="col-xs-10 col-sm-10 col-md-9  radio">
                                            <asp:RadioButton ID="rdElectInfo2" runat="server" Text=""   GroupName="grpWaiveE" AutoPostBack="True"/>&nbsp;I choose to Elect Coverage<br />
                                            <asp:RadioButton ID="rdWaiveInfo2" runat="server" Text="" GroupName="grpWaiveE" data-toggle="modal" data-target="#ModalWaiveInfoOnly" onclientclick="return false" />&nbsp;I choose to Decline Coverage
                                        </div>
                                    </div>
                                </div>
                                <%--Elect No Modal - Waive has Modal--%>
                                <div id="divWaiveWithModal" runat="server">
                                    <h4><asp:Label ID="lblElectorDeclinemodal" runat="server" Text="Step 2:  Elect or Decline Coverage"></asp:Label></h4>
                                    <div class="form-group">
                                        <div class="col-xs-2 col-sm-2 col-md-3">
                                        </div>
                                        <div class="col-xs-10 col-sm-10 col-md-9  radio">
                                            <asp:RadioButton ID="rdElectModal" runat="server" Text="I choose to Elect Coverage" GroupName="grpWaive" AutoPostBack="True" OnCheckedChanged="rdElect_CheckedChanged"/><br />
                                            <asp:RadioButton ID="rdWaiveModal" runat="server" Text="I choose to Decline Coverage" GroupName="grpWaive" data-toggle="modal" data-target="#ModalWaive" onclientclick="return false" />
                                        </div>
                                    </div>
                                </div>                                
                                <%--Elect has Modal - Waive has no Modal--%>
                                <div id="divElectWithModal" class="well-success" runat="server">
                                    <h4>
                                        <asp:Label ID="lblElectorDeclineOther" runat="server" Text="Step 2:  Elect or Decline Coverage"></asp:Label></h4>
                                    <div class="form-group">
                                        <div class="col-xs-2 col-sm-2 col-md-3">
                                        </div>
                                        <div class="col-xs-10 col-sm-10 col-md-9  radio">
                                            <asp:RadioButton ID="rdElectOther" runat="server" Text="" GroupName="grpWaiveO" data-toggle="modal" data-target="#ModalInfoOnly" onclientclick="return false" AutoPostBack="True" OnCheckedChanged="rdElectOther_CheckedChanged"/>&nbsp;I choose to Elect Coverage <br />
                                            <asp:RadioButton ID="rdWaiveOther" runat="server" Text="" GroupName="grpWaiveO" AutoPostBack="True" OnCheckedChanged="rdWaiveOther_CheckedChanged"/>&nbsp;I choose to Decline Coverage 
                                        </div>
                                    </div>
                                </div>
                                <%--Elect has Modal - Waive has Info Only Modal--%>
                                <div id="divElectWaiveBothWithInfoModal" class="well-success" runat="server">
                                    <h4>
                                        <asp:Label ID="lblElectInfoDeclineInfo" runat="server" Text="Step 2:  Elect or Decline Coverage"></asp:Label></h4>
                                    <div class="form-group">
                                        <div class="col-xs-2 col-sm-2 col-md-3">
                                        </div>
                                        <div class="col-xs-10 col-sm-10 col-md-9  radio">
                                            <asp:RadioButton ID="rdElectInfo" runat="server" Text=""   GroupName="grpWaiveD" data-toggle="modal" data-target="#ModalInfoOnly" OnClientClick="return false"/>&nbsp;I choose to Elect Coverage<br />
                                            <asp:RadioButton ID="rdWaiveInfo" runat="server" Text="" GroupName="grpWaiveD" data-toggle="modal" data-target="#ModalWaiveInfoOnly" onclientclick="return false" />&nbsp;I choose to Decline Coverage 
                                        </div>
                                    </div>
                                </div>
                                <%--Elect and Waive both have Modals--%>
                                <div id="divElectWaiveBothWithModal" class="well-success" runat="server">
                                    <h4>
                                        <asp:Label ID="lblElectDeclineBothModal" runat="server" Text="Step 2:  Elect or Decline Coverage"></asp:Label></h4>
                                    <div class="form-group">
                                        <div class="col-xs-2 col-sm-2 col-md-3">
                                        </div>
                                        <div class="col-xs-10 col-sm-10 col-md-9  radio">
                                            <asp:RadioButton ID="rdElectBoth" runat="server" Text=""   GroupName="grpWaiveC" data-toggle="modal" data-target="#ModalInfoOnly" OnClientClick="return false"/>&nbsp;I choose to Elect Coverage<br />
                                            <asp:RadioButton ID="rdWaiveBoth" runat="server" Text="" GroupName="grpWaiveC" data-toggle="modal" data-target="#ModalWaive" OnClientClick="return false"/>&nbsp;I choose to Decline Coverage
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div id="DivWaiveQuestions" runat="server" class="form-group HREWhite HRERewrap">
                    <div id="DivWaiveHeader">
                        <div class="col-md-10 ">
                            <h4>Step 3: Declare Reasons for Waiving</h4>
                        </div>
                    </div>
                    <div id="DivQandA" class="form-group">
                            <table style="width:100%; background-color:white; border-color:white;">
                            <tr>
                                <td style="width:5%;"></td>
                                <td style="width:50%;"></td>
                                <td style="width:30%;"></td>
                                <td style="width:7%;"></td>
                                <td style="width:2%;"></td>
                            </tr>
                            <tr>
                                <td colspan="4" style="padding-bottom:10px;">
                                    <asp:Label ID="mlblWaiveText1" runat="server"></asp:Label>  
                                </td>
                                <td colspan ="1">
                                </td>
                            </tr>                            
                            <tr>
                                <td colspan="4" style="padding-bottom:10px;">
                                    <asp:Label ID="mlblWaiveText2" runat="server"></asp:Label>  
                                </td>
                                <td colspan ="1">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1" style="vertical-align:top;" class="center">
                                    <asp:RadioButton ID="chkWaiveQ1" runat="server" GroupName="RadioGroupWaiveQs" onclick="Waivechk1(this)" AutoPostBack = "false"/>
                                </td>
                                <td colspan="3">
                                    <asp:Label id="mlblWaiveQ1" runat="server"  for="mrbWaiveQ1" ></asp:Label>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQuestionId1" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1">
                                    <asp:Label id="mlblWaiveQD1a" runat="server" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD1a" runat="server" Min-Width="300px" Width="100%" Height="25px" Text=""/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId1a" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1">
                                    <asp:Label id="mlblWaiveQD1b" runat="server" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD1b" runat="server" Min-Width="300px" Width="100%" Height="25px" Text=""/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId1b" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1">
                                    <asp:Label id="mlblWaiveQD1c" runat="server" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD1c" runat="server" Min-Width="300px" Width="100%" Height="25px" Text=""/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId1c" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1">
                                    <asp:Label id="mlblWaiveQD1d" runat="server" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD1d" runat="server" Min-Width="300px" Width="100%" Height="25px" Text=""/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId1d" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="1" style="vertical-align:top;" class="center">
                                    <asp:RadioButton ID="chkWaiveQ2" runat="server" GroupName="RadioGroupWaiveQs" onclick="Waivechk2(this)" AutoPostBack = "false"/>
                                </td>
                                <td colspan="3">
                                    <asp:Label id="mlblWaiveQ2" runat="server" for="mrbWaiveQ1" ></asp:Label>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQuestionId2" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1" >
                                    <asp:Label id="mlblWaiveQD2a" runat="server" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD2a" runat="server" Min-Width="300px" Width="100%" Height="25px" Text=""/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId2a" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1" >
                                    <asp:Label id="mlblWaiveQD2b" runat="server" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD2b" runat="server" Min-Width="300px" Width="100%" Height="25px" Text=""/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId2b" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1" >
                                    <asp:Label id="mlblWaiveQD2c" runat="server" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD2c" runat="server" Min-Width="300px" Width="100%" Height="25px" Text=""/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId2c" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1" >
                                    <asp:Label id="mlblWaiveQD2d" runat="server" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD2d" runat="server" Min-Width="300px" Width="100%" Height="25px" Text=""/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId2d" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="1" style="vertical-align:top;" class="center">
                                    <asp:RadioButton ID="chkWaiveQ3" runat="server" GroupName="RadioGroupWaiveQs" onclick="Waivechk3(this)" AutoPostBack = "false"/>
                                </td>
                                <td colspan="3">
                                    <asp:Label id="mlblWaiveQ3" runat="server" for="mrbWaiveQ1" ></asp:Label>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQuestionId3" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1" >
                                    <asp:Label id="mlblWaiveQD3a" runat="server" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD3a" runat="server" Min-Width="300px" Width="100%" Height="25px" Text=""/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId3a" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1" >
                                    <asp:Label id="mlblWaiveQD3b" runat="server" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD3b" runat="server" Min-Width="300px" Width="100%" Height="25px" Text=""/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId3b" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1" >
                                    <asp:Label id="mlblWaiveQD3c" runat="server" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD3c" runat="server" Min-Width="300px" Width="100%" Height="25px" Text=""/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId3c" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1" >
                                    <asp:Label id="mlblWaiveQD3d" runat="server" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD3d" runat="server" Min-Width="300px" Width="100%" Height="25px" Text=""/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId3d" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="1" style="vertical-align:top;" class="center">
                                    <asp:RadioButton ID="chkWaiveQ4" runat="server" GroupName="RadioGroupWaiveQs" onclick="Waivechk4(this)" AutoPostBack = "false"/>
                                </td>
                                <td colspan="3">
                                    <asp:Label id="mlblWaiveQ4" runat="server"  for="mrbWaiveQ1" ></asp:Label>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQuestionId4" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1" >
                                    <asp:Label id="mlblWaiveQD4a" runat="server"/>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD4a" runat="server" Min-Width="300px" Width="100%" Height="25px" Text="" TextMode="multiline"/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId4a" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1" >
                                    <asp:Label id="mlblWaiveQD4b" runat="server" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD4b" runat="server" Min-Width="300px" Width="100%" Height="25px" Text=""/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId4b" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1" >
                                    <asp:Label id="mlblWaiveQD4c" runat="server" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD4c" runat="server" Min-Width="300px" Width="100%" Height="25px" Text=""/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId4c" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                </td>
                                <td colspan="1" >
                                    <asp:Label id="mlblWaiveQD4d" runat="server" />
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtResponseQD4d" runat="server" Min-Width="300px" Width="100%" Height="25px" Text=""/>
                                </td>
                                <td colspan ="1">
                                    <asp:Label id="mlblModalQDId4d" runat="server" visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5">
                                    <%--<asp:Textbox ID="TextCompleteMessage" runat="server"></asp:Textbox>--%>
                                </td>
                            </tr>
                            
                            <tr>
                                <td colspan="1"></td>
                                <td colspan="3" style="padding-bottom:10px;">
                                    <asp:Label ID="mlblWaiveText3" runat="server"></asp:Label>  
                                </td>
                                <td colspan="1">
                                    
                                </td>
                            </tr>
                        <tr>
                            <td colspan="3">
                                <div id="DivWaiveError" runat="server" visible ="false" style="vertical-align:middle; display:inline; padding-left:50px;" >
                                    <div id="DivWaiveErrorMessage" style="text-align:left; color:red; font-size:large; padding-left:20px; vertical-align:top;">
                                        <asp:Image ID="ImageRedX" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                                        <asp:Label ID="LblWaiveErrorMessage" runat="server" Text="Please choose reason for Waiving and provide all required details."></asp:Label>
                                    </div>                                    
                                </div>
                            </td>
                            <td colspan="2" style="vertical-align:bottom;">
                                <asp:Button ID="btnSaveWaiveQuestions" Text="SAVE"  runat="server" CssClass="btn btn-primary" />   
                            </td>
                        </tr>
                        </table>
                    </div>
                </div>

                <div id="divDepBen" runat="server" class="form-group HRETan" style="border:1px solid grey; margin-right:5%;">
                    <div id="divBeneficiary" runat="server" class="col-xs-12 col-sm-12 col-md-11 col-lg-11">
                        <div id="divBeneHeader" runat="server">
                            <div id="divStep3" class="col-md-10 ">
                                <h4><asp:Label ID="lbldivBeneficiaries" runat="server" Text="Choose Beneficiaries "></asp:Label></h4>
                            </div>
                            <div id="divBenPageLink" class="col-xs-6  col-sm-6 col-md-6 right" style="float:right;">
                                <asp:LinkButton ID="btnLinkAddBen" runat="server" Text="Add or Edit" Visible="true" PostBackUrl="~/EE_DepBen.aspx"/>
                            </div>
                        </div>

                        <div id="divBenGrid" class="form-group">
                            <div class="col-xs-12 col-sm-12 col-md-12">
                                <asp:GridView ID="grdBeneficiaries" runat="server"
                                    DataKeyNames="DepBenId, RelationshipType" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                                    GridLines="None" BorderColor="#3276B1"
                                    CellPadding="4"
                                    EmptyDataText="** Beneficiary is Required and must be added before Plan can be saved **"
                                    AlternatingRowStyle-CssClass="grdNormalAltrow">
                                    <RowStyle CssClass="grdNormalrow" HorizontalAlign="Center" />
                                    <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                    <Columns>
                                        <asp:BoundField HeaderText="DepId" DataField="DepBenId" Visible="false"></asp:BoundField>
                                        <asp:BoundField HeaderText="Name" DataField="DependentName"></asp:BoundField>
                                        <asp:BoundField HeaderText="Rel" DataField="RelationshipType"></asp:BoundField>
                                        <asp:TemplateField HeaderText="Primary" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rbPrimary" runat="server" GroupName="rdgrpPrimary" OnCheckedChanged="UpdateBenificiaryRB" AutoPostBack="true" Text=" " />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Contingent" HeaderStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rbContingent" runat="server" GroupName="rdgrpPrimary" OnCheckedChanged="UpdateBenificiaryRB" AutoPostBack="true" Text="" TextAlign="left" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Neither">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rbNeither" runat="server" GroupName="rdgrpPrimary" Text="" OnCheckedChanged="UpdateBenificiaryRB" AutoPostBack="true" TextAlign="right" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Percentage">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlPercent" CssClass="selectpicker" runat="server" Width="100px"></asp:DropDownList>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
              
                    <div id="divPlanDependents" runat="server">
                        <div id="divDepSection" class="col-xs-12 col-sm-12 col-md-11 col-lg-11">
                            <div id="divDepHeader">
                                <div id="divStep2or3" class="col-md-10 ">
                                    <h4><asp:Label ID="lbldivDependents" runat="server" Text="Choose Dependents to cover"></asp:Label></h4>
                                </div>
                                <div id="divDepPageLink" class="col-xs-6  col-sm-6 col-md-6 right" style="float:right;">
                                    <asp:LinkButton ID="LinkDepEdit" runat="server" Text="Add or Edit" Visible="true" PostBackUrl="~/EE_DepBen.aspx"/>
                                </div>
                            </div>
                            
                            <div id="divDepTobacco" class="form-group">
                                <div class="col-xs-12 col-sm-12 col-md-12">
                                    <asp:Label ID="lblDependentTobacco" runat="server" CssClass="text-info"></asp:Label>
                                </div>
                            </div>
                            
                            <div id="divDepGrid" class="form-group">
                                <div class="col-xs-12 col-sm-12 col-md-12">
                                    <asp:GridView ID="grdCoveredDependents" runat="server"
                                        DataKeyNames="DepBenId" AutoGenerateColumns="False" Width="100%"
                                        GridLines="None" BorderColor="#3276B1"
                                        CellPadding="4"
                                        EmptyDataText="No Dependents found."
                                        AlternatingRowStyle-CssClass="grdNormalAltrow">
                                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                        <Columns>
                                            <asp:BoundField HeaderText="Dep Id" DataField="DepBenId" Visible="false" />
                                            <asp:TemplateField HeaderText="Covered" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Center">
                                                <ItemStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkCovered" runat="server" 
                                                        AutoPostBack="true" OnCheckedChanged="chkDepCovered_OnCheckedChanged" 
                                                        Checked="false" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Name" DataField="DependentName" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField HeaderText="Relationship" DataField="RelationshipType" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField HeaderText="Birth Date" DataField="DOB" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:TemplateField HeaderText="Tobacco User" HeaderStyle-HorizontalAlign="Left" ItemStyle-Wrap="false" >
                                                <ItemTemplate >
                                                    <asp:Label ID="lblTobacco" runat="server" Text='<%# Eval("TobaccoUser")%>' Visible="false" />
                                                    <asp:Label ID="lblDepBenId" runat="server" Text='<%# Eval("DepBenId")%>' Visible="false" />
                                                    <div class=" form-horizontal">
                                                    <asp:DropDownList ID="ddlTobacco" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlTobacco_OnSelectedIndexChanged" CssClass="selectpicker" Width="75px"  ></asp:DropDownList>
                                                        </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>                  
                    </div>
                </div>

                <div id="divPlanQuestions" runat="server" class="form-group HREWhite HRERewrap">
                    <div id="divPlanQs" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div id="divPQHeader">
                            <div id="divStep23or4" class="col-md-9 ">
                                <h4><asp:Label ID="lbldivPlanQuestions" runat="server" Text="Plan Questions"></asp:Label></h4>
                            </div>
                            <div class="col-lg-3 right">
                                <asp:Button ID="btnEditResponses" runat="server" Text="Edit Your Answers" CssClass="btn-danger" Visible="false" OnClick="btnEditResponses_Click" />
                            </div>
                        </div>
                        <div id="divPQGrid" class="form-group">
                            <div class="col-xs-12 col-sm-12 col-md-12">
                                <asp:GridView ID="grdPlanQuestions" runat="server"
                                    DataKeyNames="QuestionId, Employee, Spouse, Child,EEResponse,SPResponse,CHResponse,AnswerType, DetailQuestions, QuestionDetailInstructions" 
                                    AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                                    GridLines= "None" 
                                    BorderColor="#3276B1"
                                    CellPadding="4"
                                    EmptyDataText="No Questions found."
                                    AlternatingRowStyle-CssClass="grdNormalAltrow">
                                    <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                    <Columns>
                                        <asp:BoundField HeaderText="Question Id" DataField="QuestionId" Visible="false" />
                                        <asp:BoundField HeaderText="Question" DataField="QuestionText" Visible="true" HtmlEncode="false"></asp:BoundField>
                                        <asp:TemplateField HeaderText="Employee"  >
                                            <ItemTemplate>
                                                <asp:RadioButtonList ID="rbEmployee" CssClass="radiobtnvertical" runat="server"   QuestionID='<%# Eval("QuestionID") %>'  OnSelectedIndexChanged="BuildQuestionDetailsAgain" >   <%--AutoPostBack="true"  OnSelectedIndexChanged="CheckCompletePlanQuestions"--%>
                                               
                                                    <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                                </asp:RadioButtonList>

                                           
                                                <asp:DropDownList ID="ddlEE" runat="server"  CssClass="selectpicker"></asp:DropDownList>  <%--OnSelectedIndexChanged="CheckCompletePlanQuestions" AutoPostBack="True"--%>
                                                <asp:CheckBoxList ID="chkEE" runat="server" class=" checkbox-inline" ></asp:CheckBoxList>
                                                <asp:Label ID="lblEE" runat ="server"  CssClass="text-success"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Spouse                  " ControlStyle-BackColor ="#fcf8e3"  ItemStyle-BackColor="#fcf8e3">   
                                            <ItemTemplate >
                                                <asp:RadioButtonList ID="rbSpouse" CssClass="radiobtnvertical" runat="server" OnSelectedIndexChanged="BuildQuestionDetailsAgain"  >  <%--OnSelectedIndexChanged="CheckCompletePlanQuestions" AutoPostBack="true"--%>
                                                    <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                                </asp:RadioButtonList>
                                                    <asp:DropDownList ID="ddlSP" runat="server"  CssClass="form-control"></asp:DropDownList> <%--OnSelectedIndexChanged="CheckCompletePlanQuestions" AutoPostBack="True"--%>
                                                <asp:Label ID="lblSP" runat ="server"  CssClass="text-success"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Children "  >
                                            <ItemTemplate>
                                                <asp:RadioButtonList ID="rbChild" CssClass="radiobtnvertical" runat="server" OnSelectedIndexChanged="BuildQuestionDetailsAgain" >  <%--OnSelectedIndexChanged="CheckCompletePlanQuestions" AutoPostBack="true"--%>
                                                    <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="No" Value="0"></asp:ListItem>
                                                </asp:RadioButtonList>
                                                <asp:DropDownList ID="ddlCH" runat="server"  CssClass="form-control"></asp:DropDownList>  <%--OnSelectedIndexChanged="CheckCompletePlanQuestions" AutoPostBack="True"--%>
                                                <asp:Label ID="lblCH" runat ="server"  CssClass="text-success"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                            <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Panel ID="pnlQuestionDetails" runat="server" Visible ="false"   >
                                                </tr><td colspan="5" class=" well-white">
                                                    <b> <asp:Label ID="lblInstructions" runat ="server"  /></b>
                                                        <asp:GridView ID="grdQuestionDetails" runat="server"
                                                        AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                                                        GridLines="None" BorderColor="#3276B1" BorderStyle="Inset" BorderWidth="1px"
                                                        CellPadding="4">
                                                        <Columns>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <div class="right">* Required fields</div>
                                                    </td>
                                            </asp:Panel>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                        <asp:BoundField HeaderText="Employee" DataField="Employee" Visible="false" />
                                        <asp:BoundField HeaderText="Spouse" DataField="Spouse" Visible="false" />
                                        <asp:BoundField HeaderText="Child" DataField="Child" Visible="false" />
                                        <asp:BoundField HeaderText="EEResponse" DataField="EEResponse" Visible="false" />
                                        <asp:BoundField HeaderText="SPResponse" DataField="SPResponse" Visible="false" />
                                        <asp:BoundField HeaderText="CHResponse" DataField="CHResponse" Visible="false" />
                                        <asp:BoundField HeaderText="AnswerType" DataField="AnswerType" Visible="false" />
                                        <asp:BoundField HeaderText="DetailQuestions" DataField="DetailQuestions" Visible="false" />
                                        <asp:BoundField HeaderText="QuestionDetailInstructions" DataField="QuestionDetailInstructions" Visible="false" />
                                    </Columns>
                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                    <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                                </asp:GridView>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-9 right">
                                <asp:Label ID="lblPlanQuestions" runat="server" CssClass="text-danger" Text="Please ensure that all of the questions are complete." Visible="false" />
                            </div>
                            <div class="col-lg-3 right">
                                <br />
                                <asp:Button ID="btnSavePlanQuestions" runat="server" text="Save Your Answers" CssClass="btn-danger" Visible="false" OnClick="btnSavePlanQuestions_Click" />                         
                            </div>
                        </div>
                    </div>
                </div>
      
                <div id="divOptionsSection" runat="server" class="form-group HREWhite" style="margin-right:5%;">
                    <div class="col-xs-12 col-sm-12 col-md-11 col-lg-11">
                        <div id="divOptions" runat="server">
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                    <h4><asp:Label ID="lbldivPlanOptions" runat="server" Text="Step 2:  Choose Plan Option"></asp:Label></h4>
                                </div>
                                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 text-muted  right pull-right small">
                                    <b><asp:Label ID="lblPayFrequency" runat="server" Text="All Costs shown Per Pay Period"></asp:Label></b>
                                </div>
                            </div>

                            <div id="divOptionsGrid" class="form-group">
                                <div class=" col-xs-12 col-sm-12 col-md-12">
                                    <asp:GridView ID="grdOptions" 
                                        runat="server"
                                        DataKeyNames="RateId, PlanId, BenefitFinal,InputBenefitAmountAdmin, InputBenefitAmountEE, InputEERateEE, InputEERateAdmin,InputERRateAdmin,BundledPlanId,MinValue,MaxValue,PlanModalId, IncrementBased, LatestEventDate, PCPRequired, MonthlyEECost, MonthlyERCost, PlanLongDesc, PlanModalType" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                                        GridLines="None" 
                                        BorderColor="#3276B1" 
                                        CellPadding="4"
                                        EmptyDataText="No Options found."
                                        AlternatingRowStyle-CssClass="grdNormalAltrow">
                                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                        <Columns>
                                            <asp:BoundField HeaderText="Rate Id" DataField="RateId" Visible="false" />
                                            <asp:BoundField HeaderText="Plan Id" DataField="PlanId" Visible="false" />
                                            <asp:TemplateField HeaderText="Plan">
                                                <ItemStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:RadioButton ID="rbOption" runat="server" CssClass="radiobtn" GroupName="rdgrpOption" OnCheckedChanged="rbOption_onCheckedChanged" AutoPostBack="true"  />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Plan Name" DataField="PlanLongDesc" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Button ID="btnBenefitAmount" Text="Contribution" class="button btn-success" data-toggle="modal" runat="server" Visible="false" Enabled="false" type="button" AutoPostBack="false" OnClientClick="return false" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField HeaderText="Coverage" DataField="Coverage" />
                                            <asp:BoundField HeaderText="EE Cost" DataField="EECost" DataFormatString="{0:c}" HtmlEncode="False" ItemStyle-CssClass="text-right" HeaderStyle-CssClass="text-right" />
                                            <asp:BoundField HeaderText="ER Cost" DataField="ERCost" DataFormatString="{0:c}" HtmlEncode="False" ItemStyle-CssClass="text-right" HeaderStyle-CssClass="text-right" />
                                            <asp:BoundField HeaderText="BenefitFinal" DataField="BenefitFinal" Visible="false" />
                                            <asp:BoundField HeaderText="InputBenefitAdmin" DataField="InputBenefitAmountAdmin" Visible="false" />
                                            <asp:BoundField HeaderText="InputBenefitEE" DataField="InputBenefitAmountEE" Visible="false"  />
                                            <asp:BoundField HeaderText="InputEERateEE" DataField="InputEERateEE" Visible="false" />
                                            <asp:BoundField HeaderText="InputEERateAdmin" DataField="InputEERateAdmin" Visible="false" />
                                            <asp:BoundField HeaderText="InputERRateAdmin" DataField="InputERRateAdmin" Visible="false" />
                                            <asp:BoundField HeaderText="BundledPlanId" DataField="BundledPlanId" Visible="false" />
                                            <asp:BoundField HeaderText="MinValue" DataField="MinValue" Visible="false" />
                                            <asp:BoundField HeaderText="MaxValue" DataField="MaxValue" Visible="false" />
                                            <asp:BoundField HeaderText="PlanModalId" DataField="PlanModalId" Visible="false" />
                                            <asp:BoundField HeaderText="IncrementBased" DataField="IncrementBased" Visible="false" />
                                            <asp:BoundField HeaderText="EventDate" DataField="LatestEventDate" Visible="false" />
                                            <asp:BoundField HeaderText="PCPRequired" DataField="PCPRequired" Visible="false" />
                                            <asp:BoundField DataField="MonthlyEECost" Visible="false" />
                                            <asp:BoundField DataField="MonthlyERCost" Visible="false"/>
                                            <asp:BoundField HeaderText="PlanModalType" DataField="PlanModalType" Visible="false" />
                                            <asp:BoundField HeaderText=" " DataField="" Visible="true" />
                                        </Columns>
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="divPCPSection" runat ="server" class="form-group HREWhite HRERewrap">
                    <div class="col-xs-11 col-sm-11 col-md-11 col-lg-11">
                        <div id="divPCP" runat="server" class="HRESlateBlue" style="padding-bottom:5px;">
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <h4><asp:Label ID="lbldivPCP" runat="server" Text="Provide Primary Care Physician's (PCP) Number"></asp:Label></h4>
                                </div>
                                <div style=" padding:20px; font-style:italic;">
                                    PCP Codes must be exactly as indicated on the Insurance Carrier's Website.  
                                    Please review documents and links from <b>Step 1</b> to locate the PCP code for each person.  
                                    Generally, these codes are only added when the plan is first elected, thereafter, 
                                    please contact the insurance carrier to make changes.
                                    <span style="color:red; padding:20px;">If you are a current patient with this doctor, you must also check the box for Current Patient.</span>
                                </div>
                                
                            </div>
                            
                            <div id="divPCPGrid" class="form-group success">
                                <div class="col-xs-12 col-sm-12 col-md-12">
                                    <asp:GridView ID="grdPCP" runat="server"
                                        DataKeyNames="Emplid, DepBenId" AutoGenerateColumns="False" Width="100%"
                                        GridLines="None" BorderColor="#3276B1"
                                        CellPadding="4"
                                        EmptyDataText=""
                                        AlternatingRowStyle-CssClass="grdNormalAltrow"
                                        >
                                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                        <Columns>
                                            <asp:BoundField HeaderText="Emplid" DataField="Emplid" Visible="false" />
                                            <asp:BoundField HeaderText="Dep Id" DataField="DepBenId" Visible="false" />
                                            <asp:BoundField HeaderText="Name" DataField="Name" />
                                            <asp:BoundField HeaderText="Relationship" DataField="Relationship"  />
                                            <asp:TemplateField HeaderText="PCP Number">
                                                <ItemTemplate>

                                                    <asp:TextBox ID="txtPCPNumber" runat="server" AutoCompleteType="None" CssClass="form-control" Width="100%" Text='<%# Eval("EEPCPCode")%>'> ></asp:TextBox>  
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Current Patient">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkCurrentPatient" runat="server" CssClass="checkbox glyphicon-object-align-top center" Checked='<%# DataBinder.Eval(Container.DataItem, "CurrentPatient")%>' Enabled="true"  > </asp:CheckBox>  
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Center"/>
                                    </asp:GridView>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            
                <div id="DivNext" runat="server">
                    <div class="form-group">
                        <div id="DivBottomNext" runat="server" >
                            <asp:ImageButton ID="ImgBottomNext" runat="server" CssClass="HRENext" ToolTip="NEXT" ImageUrl="../img/NextArrowInCircleBlueGreenTP.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreenTP.png';" OnClick="imgNext_Click" />
                        </div>
                        <div id="DivBottomProcessing" runat="server" visible="false">
                            <asp:Image ID="ImgBottomProcessing" runat="server" src='/img/processing.gif' Width="100%" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    </div>

    <%--WAIVE MODAL SECTION BTW: MODALS CANNOT HAVE runat="server"--%>
    <div id="ModalWaive" class = "modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalWaiveLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <%--<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>--%>
                    <h4 class="modal-title " id="myModalWaiveLabel">
                        <asp:Label ID="mlblWaiveTitle" runat="server" Text="Waiver of Group Insurance Benefits"></asp:Label>
                    </h4>
                </div>
                <div class="modal-body ">
                    <div>
                        <asp:RadioButtonList ID="mrbWaiveType" runat="server" AutoPostBack="False"  >
                            <asp:ListItem Text="&nbsp;&nbsp;I am electing not to have health insurance at this time" Value="Question1" selected="True"  ></asp:ListItem>
                            <asp:ListItem Text="&nbsp;&nbsp;I have other health insurance" Value="Question2"></asp:ListItem>                                              
                        </asp:RadioButtonList>
                    </div>
                </div>
        
                <div class="form-group">
                    <asp:Label id="mlblWaiveQuestion3" runat="server"  text="Name of insurance company:"  for="mtxtQuestion1" class="col-md-3 text-right control-label" ></asp:Label>
                    <div class="col-md-6">
                        <asp:TextBox ID="mtxtWaiveQuestion3" runat="server" Width="90%" BorderColor="white"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label id="mlblWaiveQuestion4" runat="server"  text="Name of primary insured:"  for="mtxtQuestion2" class="col-md-3 text-right control-label"></asp:Label>
                    <div class="col-md-6">
                        <asp:TextBox ID="mtxtWaiveQuestion4" runat="server" Width="90%" BorderColor="white"></asp:TextBox>
                    </div>
                </div>
                <%--<div class="form-group">                                
                    <asp:Label ID="mlblWaiveText2" runat="server"  class="col-md-12" Visible ="false"></asp:Label>  
                </div>
                <div class="form-group" style="padding: 0px 5px 0px 5px; text-align:left;">                                
                    <asp:Label ID="mlblWaiveText3" runat="server"  class="col-md-12"></asp:Label>  
                </div> --%> 
                <div class="modal-footer">
                    <asp:ImageButton ID="mimgWaiveSave" ImageUrl="../img/BlueSaveBtnNew.png" runat="server" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ></asp:ImageButton>
                    <asp:ImageButton ID="mimgWaiveCancel" ImageUrl="../img/GreenCancelBtnNew.png" runat="server" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" data-dismiss="modal"></asp:ImageButton>                             
                </div>
            </div>
        </div>
    </div>

    <%--HSA MODAL SECTION --%>
    <div id="ModalHSA" class="modal fade " tabindex="-1" role="dialog" aria-labelledby="myModalHSALabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <%--<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>--%>
                    <h4 class="modal-title " id="myModalHSALabel">
                        <asp:Label ID="mlblHSATitle" runat="server" Text="Health Saving Account Election Form"></asp:Label>
                    </h4>
                </div>
                <div class="modal-body ">
                    <div class="well ">
                        <div class=" form-group">
                            <div class="col-md-12">
                                <asp:ValidationSummary HeaderText="<h4>Please enter a value in the following field(s):</h4>" DisplayMode="SingleParagraph" EnableClientScript="true" runat="server" CssClass="alert alert-danger text-danger text-center" ValidationGroup="valHSAAmt" />                                
                            </div>
                        </div>
                        <div class="form-group" style="padding: 0px 5px 0px 5px; text-align:left; background-color: white;">                                
                            <asp:Label ID="mlblHSAText1" runat="server" class="col-md-12 "></asp:Label>  
                        </div>
                        <div id="mdivElectionAmt" class="form-group" style="padding: 10px 5px 0px 5px; text-align:left;">
                            <div class="col-md-4">
                                <strong>My Annual Election for <asp:Label ID="mlblHSAPlanYear" runat="server" Text="2999"></asp:Label> is:</strong>
                            </div>
                            <div class="col-md-4 HREWhite">
                                <asp:TextBox ID="mtxtHSAAnnualElection" runat="server" CssClass="HREWhite"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="mvalrequiredHSAAmt" ControlToValidate="mtxtHSAAnnualElection" ErrorMessage="<h4>Annual Election Amount</h4>" Text="" runat="server" Display="None" ValidationGroup="valHSAAmt" />
                                <asp:RegularExpressionValidator ID="mvalHSAAmt" runat="server" ControlToValidate="mtxtHSAAnnualElection" ValidationExpression="^[0-9]\d*(\.\d+)?$" ErrorMessage="<h4> Annual Election Amount must be numeric</i></h4>" ValidationGroup="valHSAAmt" Display="None" />
                            </div>
                        </div>
                        <div id="mdivBankInfo" runat="server">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <asp:Label ID="mlblHSAText2" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="form-group" style="padding-left:20px;">
                                <div class="col-sm-1 col-md-1"></div>
                                <div class="col-xs-11 col-sm-11 col-md-11 ">
                                    <asp:CheckBox ID="mchkUMBAccount" runat="server" Text="I want to establish, or I already have an HSA Account" CssClass="checkbox"></asp:CheckBox>
                                </div>
                            </div>
                        </div>
                        <div id="mdivQuestion345" runat="server">
                            <div class="form-group">
                                <div class="col-xs-12 col-sm-12 col-md-12 ">
                                    <asp:Label ID="mlblHSAText3" runat="server" ></asp:Label>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label7" runat="server" Text="Bank Name:" for="mtxtHSAQuestion1" class="col-md-2 text-right control-label"></asp:Label>
                                <div class="col-md-5">
                                    <asp:TextBox ID="mtxtHSAQuestion1" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label8" runat="server" Text="Account #:" for="mtxtHSAQuestion2" class="col-md-2 text-right control-label"></asp:Label>
                                <div class="col-md-4">
                                    <asp:TextBox ID="mtxtHSAQuestion2" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="Label5" runat="server" Text="Routing #:" for="mtxtHSAQuestion3" class="col-md-2 text-right control-label"></asp:Label>
                                <div class="col-md-4">
                                    <asp:TextBox ID="mtxtHSAQuestion3" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                    </div>                                    
                </div>  
                <div class="modal-footer">
                      <asp:ImageButton ID="mbtnHSASave" ImageUrl="../img/BlueSaveBtnNew.png" runat="server" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ValidationGroup="valHSAAmt" OnClick="mbtnHSASave_Click"></asp:ImageButton>
                      <asp:ImageButton ID="mbtnHSACancel" ImageUrl="../img/GreenCancelBtnNew.png" runat="server" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" data-dismiss="modal"></asp:ImageButton>
                </div>
            </div>
        </div>
    </div>

    <%--BENEFIT AMOUNT MODAL SECTION--%>
        <%--intCompanyId: <asp:Label ID="Label1" runat="server" class="col-md-12"></asp:Label>  
        intEmployeeId: <asp:Label ID="Label2" runat="server" class="col-md-12"></asp:Label>  
        intPlanTypeId: <asp:Label ID="Label3" runat="server" class="col-md-12"></asp:Label>  
        intPlanId: <asp:Label ID="Label4" runat="server" class="col-md-12"></asp:Label>  
        intRateId: <asp:Label ID="Label13" runat="server" class="col-md-12"></asp:Label>  
        mtxtEECost: <asp:Label ID="Label6" runat="server" class="col-md-12"></asp:Label>  
        mtxtBenAmt: <asp:Label ID="Label9" runat="server" class="col-md-12"></asp:Label>  
        SessionCBD: <asp:Label ID="Label10" runat="server" class="col-md-12"></asp:Label>  
        SessionEventTypeId: <asp:Label ID="Label11" runat="server" class="col-md-12"></asp:Label>  
        SessionUserId: <asp:Label ID="Label12" runat="server" class="col-md-12"></asp:Label>  --%>
                
    <div class="modal  fadeIn" id="ModalBenefitAmount" tabindex="-1" role="dialog" aria-labelledby="myModalBenAmt" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <%--<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>--%>
                    <h4 class="modal-title " id="myModalBenAmt">
                        <asp:Label ID="mlblBenAmtTitle" runat="server"></asp:Label></h4>
                </div>
                <div class="modal-body ">
                    <div class=" HREWhite">
                        <div class=" form-group">
                            <div class="col-md-12">
                                <asp:ValidationSummary HeaderText="<h4>Please enter a value in the following field(s):</h4>" DisplayMode="SingleParagraph" EnableClientScript="true" runat="server" CssClass="alert alert-danger text-danger text-center" ValidationGroup="valBenAmt" />
                            </div>
                        </div>
                        <div class="form-group">                                
                            <asp:Label ID="mlblBenAmtText1" runat="server" class="col-md-12"></asp:Label>  
                        </div>
                        <div class="form-group">                                
                            <asp:Label ID="mlblBenAmtText2" runat="server" class="col-md-12 "></asp:Label>  
                        </div>
                        <div class="form-group">                                
                            <asp:Label ID="mlblBenAmt" runat="server" Text="Enter <strong>Annual</strong> Benefit Amount"  for="mtxtBenAmt" class="col-md-5 text-right control-label"></asp:Label>
                            <div class="col-md-3">
                                <asp:TextBox ID="mtxtBenAmt" runat="server"  CssClass="form-control center" Text ="0"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="mtxtBenAmt" ErrorMessage="<h4>Benefit Amount</h4>" Text="" runat="server" Display="None" ValidationGroup="valBenAmt" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="mtxtBenAmt" ValidationExpression="^[0-9]\d*(\.\d+)?$" ErrorMessage="<h4> Benefit Amount Cost must be numeric</i></h4>" ValidationGroup="valBenAmt" Display="None" />
                            </div>
                        </div>
                        <div class="form-group">                           
                            <asp:Label ID="mlblEECost" runat="server"  Text="Enter <strong>Per Pay Period</strong> Amount"  for="mtxtEECost" class="col-md-5 text-right control-label"></asp:Label>
                            <div class="col-md-3">
                                <asp:TextBox ID="mtxtEECost" runat="server"  CssClass="form-control center" Text ="0.00"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="mtxtEECost" ErrorMessage="<h4>Employee Cost</h4>" Text="" runat="server" Display="None" ValidationGroup="valBenAmt" />
                                <asp:RegularExpressionValidator ID="valEECost" runat="server" ControlToValidate="mtxtEECost" ValidationExpression="[0-9]\d*(\.\d+)?$" ErrorMessage="<h4> Employee Cost must be numeric</i></h4>" ValidationGroup="valBenAmt" Display="None" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-muted  center">
                                <br />
                                <asp:Label ID="mlblPayFrequency" runat="server" Text="All Costs shown per pay period"></asp:Label><br />
                                <asp:Label ID="mlblMinMax" runat="server" Text="Min and Max Values would show here"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group">                                
                            <asp:Label ID="mlblBenAmtText3" runat="server" class="col-md-12"></asp:Label>  
                            
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:ImageButton ID="mbtnBenAmtSave" ImageUrl="../img/BlueSaveBtnNew.png" runat="server" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" autopostback="true" ValidationGroup="valBenAmt"></asp:ImageButton>
                    
                    <asp:ImageButton ID="mbtnBenAmtCancel" ImageUrl="../img/GreenCancelBtnNew.png" runat="server" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" data-dismiss="modal"></asp:ImageButton>  
                </div>
            </div>
        </div>
    </div>

    <%--INFORMATION ONLY MODAL SECTION--%>
    <div id="ModalInfoOnly" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalInfoLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    INFORMATION ACKNOWLEDGEMENT
                    <h4 class="modal-title"  id="myModalInfoLabel">
                        <asp:Label ID="mlblInfoTitle" runat="server" Text=""></asp:Label></h4>
                </div>
                <div class="modal-body ">
                    <div class="well ">
                        <div class="form-group">
                            <asp:Label ID="mlblInfoText1" runat="server" class="col-md-12 "></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="mlblInfoText2" runat="server" class="col-md-12 "></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="mlblInfoText3" runat="server" class="col-md-12"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    
                    <asp:ImageButton ID="mbtnInfoAcknowledge" ImageUrl="../img/GreenAcknowledgeBtnNew.png" runat="server" OnMouseOver="src='/img/GreenAcknowledgeOverNew.png';" OnMouseOut="src='/img/GreenAcknowledgeBtnNew.png';" ></asp:ImageButton>
                    <asp:ImageButton ID="mbtnInfoCancel" ImageUrl="../img/GreenCancelBtnNew.png" runat="server" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" data-dismiss="modal"></asp:ImageButton>
                </div>
            </div>
        </div>
    </div>

    <%--INFORMATION WAIVE MODAL SECTION--%>
    <div id="ModalWaiveInfoOnly" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="myModalWaiveInfoLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <%--<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>--%>
                    <h4 class="modal-title"  id="myModalWaiveInfoLabel">
                        <asp:Label ID="mlblWaiveInfoTitle" runat="server" Text="Waive Info Modal"></asp:Label></h4>
                </div>
                <div class="modal-body ">
                    <div class="well ">
                        <div class="form-group">
                            <asp:Label ID="mlblWaiveInfoText1" runat="server" class="col-md-12 "></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="mlblWaiveInfoText2" runat="server" class="col-md-12 "></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="mlblWaiveInfoText3" runat="server" class="col-md-12"></asp:Label>
                        </div>
                    </div>
                    <%--modalbodycontainer--%>
                </div>
                <div class="modal-footer">
                    INFO WAIVE MODAL FOOTER
                    <asp:ImageButton ID="mbtnWaiveInfoAcknowledge" ImageUrl="../img/GreenAcknowledgeBtnNew.png" runat="server" OnMouseOver="src='/img/GreenAcknowledgeOverNew.png';" OnMouseOut="src='/img/GreenAcknowledgeBtnNew.png';"></asp:ImageButton>
                   <asp:ImageButton ID="mbtnWaiveInfoCancel" ImageUrl="../img/GreenCancelBtnNew.png" runat="server" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" data-dismiss="modal"></asp:ImageButton>                
                </div>
            </div>
        </div>
        
    </div>

    <%--NEW GENERIC MODAL SECTION--%>
    <div id="ModalGeneric" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalGenericLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    GENERIC MODAL
                    <h4 class="modal-title"  id="myModalGenericLabel">
                        <asp:Label ID="LabelModalTitle" runat="server" Text=""></asp:Label></h4>
                </div>
                <div class="modal-body ">
                    <div class="well ">
                        <div class="form-group">
                            <asp:Label ID="LabelModalText1" runat="server" class="col-md-12 "></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="LabelModalText2" runat="server" class="col-md-12 "></asp:Label>
                        </div>
                        <div class="form-group">
                            <asp:Label ID="LabelModalText3" runat="server" class="col-md-12"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">                    
                    <asp:ImageButton ID="ImageButton1" ImageUrl="../img/GreenAcknowledgeBtnNew.png" runat="server" OnMouseOver="src='/img/GreenAcknowledgeOverNew.png';" OnMouseOut="src='/img/GreenAcknowledgeBtnNew.png';" ></asp:ImageButton>
                    <asp:ImageButton ID="ImageButton2" ImageUrl="../img/GreenCancelBtnNew.png" runat="server" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" data-dismiss="modal"></asp:ImageButton>
                    <asp:ImageButton ID="ImageButton3" ImageUrl="../img/BlueSaveBtnNew.png" runat="server" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" autopostback="true" ValidationGroup="valBenAmt"></asp:ImageButton>
                    
                </div>
            </div>
        </div>
    </div>

    <div >
        ModalIdInSession:&nbsp; <asp:Label ID="LabelModalId" runat="server" Visible="false" ></asp:Label>
        <%--TestRB&nbsp; <asp:RadioButton ID="RadioButton1" runat="server" Text="" data-toggle="modal" data-target="#ModalGeneric" OnClientClick="return false"/>--%>
    </div>

   <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

        .HREDisabled {}
        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px 10px 10px 10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HRENext {padding:5px 5px 5px 5px; float:right; min-width:50px; max-width:90px; }
        .img {display: inline-block; width: auto; height: auto;}
    </style>
</asp:Content>
  
<asp:Content ID="SideMenu1" ContentPlaceHolderID="SideMenu1" runat="Server">
    <div class="HREwrapper">              
        <div id="divNextButton" runat="server" class="hidden-xs" style="margin-top:20px;">
            <asp:ImageButton ID="imgNext" runat="server" class="HRENext" ToolTip="NEXT" ImageUrl="../img/NextArrowInCircleBlueGreenTP.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreenTP.png';" OnClick="imgNext_Click" />
        </div>

        <div id="divProcessing" runat="server" visible="false">
            <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Width="100%" />
        </div>

        <div id="divProgressBarSection" runat="server" class="col-md-12 text-info text-center" style="background-color:white; margin-left:-20%; margin-right:5%;">
            <span class="text-success">% Complete</span>
            <div class="progress-striped progress-bar-info active">  
                <div id="divProgressBar" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="10" aria-valuemax="100" style="width: 0%" runat="server">
                    <strong><asp:Label ID="lblProgress" Text="60" runat="server"></asp:Label></strong>
                </div>
            </div>
        </div>

        <div id="divSummary" runat="server" class="well HREWhite HRERewrap" style="margin-left:-20%; margin-right:25%; border:none;">
            <h4 style="float:left;">Contribution Summary</h4> 
            <b style="float:right;"><asp:Label ID="lblPayFrequency2" runat="server" CssClass="text-muted center small" Text="All Costs shown per pay period"></asp:Label></b>
            <div class="row" >
                <div class="col-md-12">             
                    <asp:GridView ID="grdSummary" runat="server"  AutoGenerateColumns="false" Width="100%" HeaderStyle-CssClass="text-success" BorderStyle="None">
                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                        <Columns>
                            <asp:BoundField HeaderText="Plan Type" DataField="PlanTypeShortDesc"></asp:BoundField>
                            <asp:BoundField HeaderText="EE Cost" DataField="EECost" DataFormatString="{0:c}" HtmlEncode="False" ItemStyle-cssClass="text-right" HeaderStyle-CSSClass="center"></asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                            <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
    <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px 10px 10px 10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HRENext {padding:5px 5px 5px 5px; float:right; min-width:50px; max-width:90px; }
        .img {display: inline-block; width: auto; height: auto;}
    </style>
</asp:Content>

<asp:Content ID="Dependents" ContentPlaceHolderID="Benefit" runat="Server" >
    <div id="divCalculator" runat="server" class="form-group">
        <h4 style="float:left; margin-left:-10%; color:midnightblue">Total Employee Contribution </h4>
        <h4 style="float:right; margin-right:33%; color:midnightblue"><b><asp:Label ID="lblSum" runat="server" Text="" ></asp:Label></b></h4>
    </div>
    <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 2px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }
        
        table {background-color:white; color:black; border-color:white; border-collapse:separate; border-spacing: 0px 5px;}
        
        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px 10px 10px 10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HRENext {padding:5px 5px 5px 5px; float:right; min-width:50px; max-width:90px; }
        .img {display: inline-block; width: auto; height: auto;}
    </style>
</asp:Content>

<asp:Content ID="Client" ContentPlaceHolderID="Client" runat="Server">
    <div style="position:fixed; height:300px">

    </div>
</asp:Content>



