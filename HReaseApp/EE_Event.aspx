<%@ Page Title="EE Declares Event to Enroll" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_Event.aspx.vb" 
    Inherits="HReaseApp.EE_Event" 
    MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" Runat="Server">
    <script>
        $(document).ready(function () {
            $('.formattedeventdate').before(function () {
                $(this).prop('type', 'date');
                var a = $('input:text[id$=TxtDateFormatted]').val();
                $(this).val(a);
            });
        });
        function ValidateDateFormat(input, keyCode) {
            var dateString = input.value;
            if (keyCode == 16) {
                isShift = false;
            }
            //var regex = /(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$/;
            var regex = /^(0[1-9]|1[0-2])\/(0[1-9]|1\d|2\d|3[01])\/(19|20)\d{2}$/;

            //Check whether valid MM/dd/yyyy Date Format.
            if (regex.test(dateString) || dateString.length == 0) {
                ShowHideError(input, "none");
            }
            if (regex.test(dateString) || dateString.length == 0) {
                ShowHideError(input, "none");
            }
            else {
                ShowHideError(input, "block");
            }
        };

        function ShowHideError(textbox, display) {
            var row = textbox.parentNode.parentNode;
            var errorMsg = row.getElementsByTagName("span")[0];
            if (errorMsg != null) {
                errorMsg.style.display = display;
            }
        };
        function goBack()
        {
        window.history.back()
        }        
    </script>

    <div class="HREwrapper">
        <div id="PageTitle" class="HRERewrap">
            <div style="text-align:center;">
                <br />
                <h4><b>Declare Enrollment Event</b></h4>
            </div>
        </div>

        <div id="DivTopHeader" class="form-group" >              
            <div id="DivError" runat="server" visible="false" class="HREError" style="height:auto;">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
            </div>
            <div class="form-group" style="display:inline;">
                <div id="DivSuccess" runat="server" visible ="false" class="HRESuccess">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" ImageAlign="Left" />
                    <asp:Label ID="lblSuccess" runat="server"  Text="Form Complete" Width="50%"></asp:Label>
                    
                </div>
            </div>
        </div> 

        <div id="divMainArticalTitleandText" runat="server" class="HRESlateBlue HRERewrap">
            <div id="DivTextTitle" class="col-md-12" style="padding-top:20px;">
                <h4>
                    <b><asp:Label ID="lblMainArticleTitle" runat="server" /></b>
                </h4>
            </div>
            <div id="divText" runat="server" class="HREWhite" >
                <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div>    
     
        <div class="form-group">
            <div id="divCol1" runat="server" class="form-group col-md-6" >
                <div class="box boxText firstBox" style="margin-bottom:-50px;">
                    <br />
                    <h4>
                        <asp:Label ID="lblSideMenu1Title" runat="server" ></asp:Label>
                    </h4>
                    <p>
                        <asp:Label ID="lblSideMenu1text" runat="server"></asp:Label>
                    </p>
                    <asp:ImageButton ID="btnMenu1" runat="server" ImageUrl="/img/BlueMoreBtn.png" ImageAlign="Right" Visible="false" OnMouseOver="src='/img/BlueMoreBtnOver.png';" OnMouseOut="src='/img/BlueMoreBtn.png';" data-toggle="modal" data-target="#News1" OnClientClick="return false"></asp:ImageButton>
                </div>

                <div class="box subMenu">
                    <h4>
                        <asp:Label ID="lblSideMenu2Title" runat="server"></asp:Label>
                    </h4>
                    <p class="perex">
                        <asp:Label ID="lblSideMenu2text" runat="server"></asp:Label>
                    </p>
                    <asp:ImageButton ID="btnMenu2" ImageUrl="../img/BlueMoreBtn.png" runat="server" ImageAlign="Right" Visible="false" OnMouseOver="src='/img/BlueMoreBtnOver.png';" OnMouseOut="src='/img/BlueMoreBtn.png';" data-toggle="modal" data-target="#News2" OnClientClick="return false"></asp:ImageButton>
                </div>

                <div class="box subMenu">
                    <h4>
                        <asp:Label ID="lblSideMenu3Title" runat="server"></asp:Label>
                    </h4>
                    <p class="perex">
                        <asp:Label ID="lblSideMenu3text" runat="server"></asp:Label>
                    </p>
                    <asp:ImageButton ID="btnMenu3" ImageUrl="../img/BlueMoreBtn.png" runat="server" ImageAlign="Right" Visible="false" OnMouseOver="src='/img/BlueMoreBtnOver.png';" OnMouseOut="src='/img/BlueMoreBtn.png';" data-toggle="modal" data-target="#News3" OnClientClick="return false"></asp:ImageButton>
                </div> 
            </div>
                
            <div id="divCol2" runat="server" class="form-group col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6" style="padding-right:5%; padding-top:1%;">
                <div id="divEventTypeandDate" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12" style="border:2px solid black; padding:10px 10px 40px 10px;">
                    <div class="form-group top" style="display:inline; font-size:22px; margin-bottom:-10px;">
                           <b>Event Type</b>
                            <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right"  Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                            <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />                            
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6">
                        <label for="ddlOtherEventTypes" class="control-label ">
                            Event Type:</label>                            
                        <asp:DropDownList ID="ddlOtherEventTypes" runat="server" CssClass="form-control" TabIndex="1" DataValueField="EventTypeId" DataTextField="EventDesc" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="ddlOtherEventTypes_SelectedIndexChanged" ></asp:DropDownList>
                    </div>
                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6" ">                        
                        <asp:Label ID="lblEventDateError" runat="server" CssClass="red" Visible="false"></asp:Label>
                        <label for="txtEventDate" class="control-label " style="vertical-align:bottom;">
                            Event Date:</label>
                        <asp:TextBox ID="txtEventDate" runat="server" CssClass="form-control formattedeventdate" onfocus="(this.type='date')" TabIndex="2" MaxWidth="10"></asp:TextBox>
                        
                    </div>
                    <div style="visibility:hidden;">
                        <div>
                            TxtLatestEventDate: <asp:TextBox ID="TxtLatestEventDate" runat="server" Visible="true" ></asp:TextBox><br />
                            TxtIEDate: <asp:TextBox ID="TxtIEDate" runat="server" Visible="true" ></asp:TextBox><br />      
                            TxtOEDate: <asp:TextBox ID="TxtOEDate" runat="server" Visible="true" ></asp:TextBox><br />                  
                            TxtDateFormatted: <asp:TextBox ID="TxtDateFormatted" runat="server" Visible="true" ></asp:TextBox>                        
                            txtEventDate: <asp:TextBox ID="txtEventDate1" runat="server" Visible="true" ></asp:TextBox>
                        </div>
                    </div>
                </div>
                
            </div>

        <%--   Bottom Info area--%>
        <div id="divBottomComment" runat="server" class="row" visible="false">
            <div class="col-xs-12 col-sm-12 col-md-11">
                <div class="well">
                    <h2><asp:Label ID="lblBottomDocumentTitle" runat="server"></asp:Label>              </h2>
                    <asp:Label ID="lblBottomDocument" runat="server"> </asp:Label>
                </div>
            </div>
        </div>

        <%--MODAL SECTION--%>
    
        <div class="modal fade" id="News1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title text-success" id="myModalLabel1">
                            <asp:Label ID="lblModalTitle1" runat="server"></asp:Label></h4>
                    </div>
                    <div class="modal-body ">
                        <%--<div class="container ">--%>
                        <h4>
                            <asp:Label ID="lblModalText1" runat="server"></asp:Label></h4>
                        <%--</div>--%>
                    </div>
                    <div class="modal-footer">
                        <asp:ImageButton ID="imgModalClose1" ImageUrl="../img/GreenCloseBtn.png" runat="server" OnMouseOver="src='/img/GreenCloseBtnOver.png';" OnMouseOut="src='/img/GreenCloseBtn.png';" data-dismiss="modal"></asp:ImageButton>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="News2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title text-success" id="myModalLabel2">
                            <asp:Label ID="lblModalTitle2" runat="server"></asp:Label></h4>
                    </div>
                    <div class="modal-body ">
                        <%--<div class="container ">--%>
                        <h4>
                            <asp:Label ID="lblModalText2" runat="server"></asp:Label></h4>
                        <%--</div>--%>
                    </div>
                    <div class="modal-footer">
                        <asp:ImageButton ID="imgModalClose2" ImageUrl="../img/GreenCloseBtn.png" runat="server" OnMouseOver="src='/img/GreenCloseBtnOver.png';" OnMouseOut="src='/img/GreenCloseBtn.png';" data-dismiss="modal"></asp:ImageButton>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="News3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title text-success" id="myModalLabel3">
                            <asp:Label ID="lblModalTitle3" runat="server"></asp:Label></h4>
                    </div>
                    <div class="modal-body ">
                        <%--<div class="container ">--%>
                        <h4>
                            <asp:Label ID="lblModalText3" runat="server"></asp:Label></h4>
                        <%--</div>--%>
                    </div>
                    <div class="modal-footer">
                        <asp:ImageButton ID="Imagebutton2" ImageUrl="../img/GreenCloseBtn.png" runat="server" OnMouseOver="src='/img/GreenCloseBtnOver.png';" OnMouseOut="src='/img/GreenCloseBtn.png';" data-dismiss="modal"></asp:ImageButton>
                    </div>
                </div>
            </div>
        </div>   

    </div>
</div>

<style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; padding: 10px 10px 10px 10px;}
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px 10px 0px 10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HRENext {padding:5px 5px 5px 5px; float:right; min-width:50px; max-width:90px; }
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
        .img {display: inline-block; width: auto; height: auto;}

    </style>
</asp:Content>
