<%@ Page Title="VMQandA" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="VMQandA.aspx.vb" 
    Inherits="HReaseApp.VMQandA"
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" Runat="Server">
    <style>
          .buttonChangeDoc {
              color: white;
              background-color: #639ED5;
              box-shadow: 0px 0px 0px 0px;
              padding: 3px 3px;
              width: 80px;
              height: 30px;
              font-weight:500;
              font-size:small;
              vertical-align:middle;
              margin:1px 1px 1px 0px;
              float:left;
        }
    </style>
    <div class="HREwrapper">      
        <div id="DivTopHeader" class="form-group HRERewrap">      
            <div id="DivErrorSection" runat="server" class="HREError" visible="false">
                <asp:Image ID="ImageError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="LabelError" runat="server"></asp:Label>
            </div>
            <div id="DivSuccessSection" runat="server" visible ="false" class="form-group" style="display:inline;">
                <div class="HRESuccess">
                    <asp:Image id="ImageSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="30px" ImageAlign="Left" />
                    <asp:Label ID="LabelSuccess" runat="server"  Text="Complete" Width="50%"></asp:Label>
                    <%--<asp:ImageButton ID="ImageNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="ImageNext_Click" />
                    <asp:Image ID="ImageProcessing" runat="server" Visible="false" src='/img/processing.gif' ImageAlign="Right" Width="80px" />--%>
                </div>
            </div>
        </div>           
      
        <div id="MainArticalTitleandTextDiv" class="well HRERewrap">
            <div id="TitleDiv" runat="server" class="form-group HRESlateBlue">
                    <h4><asp:Label ID="MainArticleTitleLabel" runat="server" Text="" style="margin-left:-25px;"></asp:Label></h4>           
            </div>
            <div id="TextDiv" runat="server" class="form-group HREWhite" style="margin-left:-25px; max-height: 320px; overflow-y: scroll;">
                    <asp:Label ID="MainArticleTextLabel" runat="server"></asp:Label>
            </div>
        </div>

        <div id="DivQandA" class="form-group" style="margin-left:-35px;  font-size:large;">
            <div id="DivQ1" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div id="DivQuestion1" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-11 col-sm-12 col-md-11 col-lg-11 left bold">
                        <asp:Label ID="Question1" runat="server"></asp:Label>
                    </div>
                    <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                        <asp:Label ID="QuestionId1" runat="server" Visible="false" ></asp:Label>
                    </div>                    
                </div>
                <div id="DivQ1Buttons" runat="server" class="btn-group-vertical toggle col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 center">
                        <asp:Button ID="ButtonQ1Yes" runat="server" Text="&nbsp;&nbsp;Yes" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ1Yes_Click" />
                    </div>
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 left">
                        <asp:Button ID="ButtonQ1No" runat="server" Text="&nbsp;&nbsp;No" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ1No_Click" />
                    </div>
                </div>
                <p>
                    &nbsp;
                </p>
                <div id="DivDetailQ1" runat="server">
                    <div id="DivDetailQ1A" runat="server" >
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right; vertical-align:middle;">
                            <asp:Label id="DetailQuestion1A" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ1A" runat="server" Width="100%" TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-12 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId1A" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ1B" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion1B" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5" style="vertical-align:bottom; margin-top:10px; margin-bottom:10px;">
                            <asp:TextBox ID="ResponseDetailQ1B" runat="server" Width="200px" Type="Date" />
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId1B" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ1C" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion1C" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ1C" runat="server" Width="100%" TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId1C" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ1D" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion1D" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ1D" runat="server" Width="100%" TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId1D" runat="server" visible="false" ></asp:Label>

                        </div>
                    </div>
                    <p>
                        &nbsp;
                    </p>
                    <div id="DivUpload1" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right; color:darkcyan;">
                            Upload Document:
                        </div>
                        <div class="col-xs-7 col-sm-5 col-md-5 col-lg-5" style="margin-top:7px;">
                            <asp:FileUpload ID="FileUploadDocument1" runat="server" Text="Upload Support" CssClass="form-control" Width="100%" ViewStateMode="Enabled" />
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1" style="margin-top:10px;font-size:x-large;">
                            <asp:Label ID ="LabelFileUpload1" runat="server" Visible="false" Type="text" Width="100%"></asp:Label>
                            <asp:ImageButton ID="ButtonSaveSectionQ1" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" AutoPostBack="true" OnClick="ButtonSaveSectionQ1_Click" />
                        </div>    
                    </div> 
                    <div id="DivExistingDocument" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12 center">
                        <asp:Label ID ="LabelUploadedDocument1" runat="server" Visible="true" Type="text" Width="100%"></asp:Label>
                        <asp:Button ID="ButtonChangeDoc" Text="Change Document" runat="server" Enabled="true" EnableViewState="true" Class="buttonChangeDoc" autopostback="true" OnClick="ButtonChangeDoc_Click" />
                    </div>
                   
                </div>
            </div>
            <p>
                &nbsp;
            </p>
            <div id="DivQ2" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div id="DivQuestion2" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-11 col-sm-10 col-md-10 col-lg-10 left bold">
                        <asp:Label ID="Question2" runat="server"></asp:Label>
                    </div>
                    <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1 right">
                        <asp:Label ID="QuestionId2" runat="server" Visible="false"></asp:Label>
                    </div>                    
                </div>
                <div id="DivQ2Buttons" runat="server" class="btn-group-vertical toggle col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 center">
                        <asp:Button ID="ButtonQ2Yes" runat="server" Text="&nbsp;&nbsp;Yes" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ2Yes_Click" />
                    </div>
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 left">
                        <asp:Button ID="ButtonQ2No" runat="server" Text="&nbsp;&nbsp;No" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ2No_Click" />
                    </div>
                </div>
                <p>
                    &nbsp;
                </p>
                <div id="DivDetailQ2" runat="server">
                    <div id="DivDetailQ2A" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion2A" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ2A" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId2A" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ2B" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion2B" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5" style="vertical-align:bottom; margin-top:10px; margin-bottom:10px;">
                            <asp:TextBox ID="ResponseDetailQ2B" runat="server" Width="200px" Type="Date"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId2B" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ2C" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion2C" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ2C" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId2C" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ2D" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion2D" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ2D" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId2D" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <p>
                        &nbsp;
                    </p>
                    <div id="DivUpload2" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right; color:darkcyan;">
                            Upload Supporting Document:
                        </div>
                        <div class="col-xs-7 col-sm-5 col-md-5 col-lg-5" style="margin-top:7px;">
                            <asp:FileUpload ID="FileUpload2" runat="server" CssClass="form-control" Width="100%" ViewStateMode="Enabled" />
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1" style="margin-top:10px;font-size:x-large;">
                            <asp:Label ID ="LabelFileUpload2" runat="server" Visible="false" Type="text" Width="100%"></asp:Label>
                            <asp:ImageButton ID="ButtonSaveSectionQ2" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" AutoPostBack="true" OnClick="ButtonSaveSectionQ2_Click" />
                        </div>    
                    </div>   
                </div>
            </div>
            <p>
                &nbsp;
            </p>
            <div id="DivQ3" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div id="DivQuestion3" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-11 col-sm-10 col-md-10 col-lg-10 left bold">
                        <asp:Label ID="Question3" runat="server"></asp:Label>
                    </div>
                    <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1 right">
                        <asp:Label ID="QuestionId3" runat="server" Visible="false"></asp:Label>
                    </div>                    
                </div>
                <div id="DivQ3Buttons" runat="server" class="btn-group-vertical toggle col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 center">
                        <asp:Button ID="ButtonQ3Yes" runat="server" Text="&nbsp;&nbsp;Yes" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ3Yes_Click" />
                    </div>
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 left">
                        <asp:Button ID="ButtonQ3No" runat="server" Text="&nbsp;&nbsp;No" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ3No_Click" />
                    </div>
                </div>
                <p>
                    &nbsp;
                </p>
                <div id="DivDetailQ3" runat="server">
                    <div id="DivDetailQ3A" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion3A" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ3A" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId3A" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ3B" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion3B" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5" style="vertical-align:bottom; margin-top:10px; margin-bottom:10px;">
                            <asp:TextBox ID="ResponseDetailQ3B" runat="server" Width="200px" Type="Date"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId3B" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ3C" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion3C" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ3C" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId3C" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ3D" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion3D" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ3D" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId3D" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <p>
                        &nbsp;
                    </p>
                    <div id="DivUpload3" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right; color:darkcyan;">
                            Upload Supporting Document:
                        </div>
                        <div class="col-xs-7 col-sm-5 col-md-5 col-lg-5" style="margin-top:7px;">
                            <asp:FileUpload ID="FileUpload3" runat="server" CssClass="form-control" Width="100%" ViewStateMode="Enabled" />
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1" style="margin-top:10px;font-size:x-large;">
                            <asp:Label ID ="LabelFileUpload3" runat="server" Visible="false" Type="text" Width="100%"></asp:Label>
                            <asp:ImageButton ID="ButtonSaveSectionQ3" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" AutoPostBack="true" OnClick="ButtonSaveSectionQ3_Click" />
                        </div>    
                    </div>   
                </div>
            </div>
            <p>
                &nbsp;
            </p>
            <div id="DivQ4" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div id="DivQuestion4" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-11 col-sm-10 col-md-10 col-lg-10 left bold">
                        <asp:Label ID="Question4" runat="server"></asp:Label>
                    </div>
                    <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1 right">
                        <asp:Label ID="QuestionId4" runat="server" Visible="false"></asp:Label>
                    </div>                    
                </div>
                <div id="DivQ4Buttons" runat="server" class="btn-group-vertical toggle col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 center">
                        <asp:Button ID="ButtonQ4Yes" runat="server" Text="&nbsp;&nbsp;Yes" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ4Yes_Click" />
                    </div>
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 left">
                        <asp:Button ID="ButtonQ4No" runat="server" Text="&nbsp;&nbsp;No" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ4No_Click" />
                    </div>
                </div>
                <p>
                    &nbsp;
                </p>
                <div id="DivDetailQ4" runat="server">
                    <div id="DivDetailQ4A" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion4A" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ4A" runat="server" Width="100%"  TextMode="MultiLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId4A" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ4B" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion4B" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5" style="vertical-align:bottom; margin-top:10px; margin-bottom:10px;">
                            <asp:TextBox ID="ResponseDetailQ4B" runat="server" Width="200px" Type="Date"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId4B" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ4C" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion4C" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ4C" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId4C" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ4D" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion4D" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ4D" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId4D" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <p>
                        &nbsp;
                    </p>
                    <div id="DivUpload4" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right; color:darkcyan;">
                            Upload Supporting Document:
                        </div>
                        <div class="col-xs-7 col-sm-5 col-md-5 col-lg-5" style="margin-top:7px;">
                            <asp:FileUpload ID="FileUpload4" runat="server" CssClass="form-control" Width="100%" ViewStateMode="Enabled" />
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1" style="margin-top:10px;font-size:x-large;">
                            <asp:Label ID ="LabelFileUpload4" runat="server" Visible="false" Type="text" Width="100%"></asp:Label>
                            <asp:ImageButton ID="ButtonSaveSectionQ4" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" AutoPostBack="true" OnClick="ButtonSaveSectionQ4_Click" />
                        </div>    
                    </div>   
                </div>
            </div>    
            <p>
                &nbsp;
            </p>
            <div id="DivQ5" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div id="DivQuestion5" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-11 col-sm-10 col-md-10 col-lg-10 left bold">
                        <asp:Label ID="Question5" runat="server"></asp:Label>
                    </div>
                    <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1 right">
                        <asp:Label ID="QuestionId5" runat="server" Visible="false"></asp:Label>
                    </div>                    
                </div>
                <div id="DivQ5Buttons" runat="server" class="btn-group-vertical toggle col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 center">
                        <asp:Button ID="ButtonQ5Yes" runat="server" Text="&nbsp;&nbsp;Yes" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ5Yes_Click" />
                    </div>
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 left">
                        <asp:Button ID="ButtonQ5No" runat="server" Text="&nbsp;&nbsp;No" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ5No_Click" />
                    </div>
                </div>
                <p>
                    &nbsp;
                </p>
                <div id="DivDetailQ5" runat="server">
                    <div id="DivDetailQ5A" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion5A" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ5A" runat="server" Width="100%"  TextMode="MultiLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId5A" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ5B" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion5B" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5" style="vertical-align:bottom; margin-top:10px; margin-bottom:10px;">
                            <asp:TextBox ID="ResponseDetailQ5B" runat="server" Width="200px" Type="Date"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId5B" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ5C" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion5C" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ5C" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId5C" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ5D" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion5D" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ5D" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId5D" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <p>
                        &nbsp;
                    </p>
                    <div id="DivUpload5" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right; color:darkcyan;">
                            Upload Supporting Document:
                        </div>
                        <div class="col-xs-7 col-sm-5 col-md-5 col-lg-5" style="margin-top:7px;">
                            <asp:FileUpload ID="FileUpload5" runat="server" CssClass="form-control" Width="100%" ViewStateMode="Enabled" />
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1" style="margin-top:10px;font-size:x-large;">
                            <asp:Label ID ="LabelFileUpload5" runat="server" Visible="false" Type="text" Width="100%"></asp:Label>
                            <asp:ImageButton ID="ButtonSaveSectionQ5" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" AutoPostBack="true" OnClick="ButtonSaveSectionQ5_Click" />
                        </div>    
                    </div>   
                </div>
            </div>
            <p>
                &nbsp;
            </p>
            <div id="DivQ6" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div id="DivQuestion6" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-11 col-sm-10 col-md-10 col-lg-10 left bold">
                        <asp:Label ID="Question6" runat="server"></asp:Label>
                    </div>
                    <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1 right">
                        <asp:Label ID="QuestionId6" runat="server" Visible="false"></asp:Label>
                    </div>                    
                </div>
                <div id="DivQ6Buttons" runat="server" class="btn-group-vertical toggle col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 center">
                        <asp:Button ID="ButtonQ6Yes" runat="server" Text="&nbsp;&nbsp;Yes" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ6Yes_Click" />
                    </div>
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 left">
                        <asp:Button ID="ButtonQ6No" runat="server" Text="&nbsp;&nbsp;No" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ6No_Click" />
                    </div>
                </div>
                <p>
                    &nbsp;
                </p>
                <div id="DivDetailQ6" runat="server">
                    <div id="DivDetailQ6A" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion6A" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ6A" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId6A" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ6B" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion6B" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5" style="vertical-align:bottom; margin-top:10px; margin-bottom:10px;">
                            <asp:TextBox ID="ResponseDetailQ6B" runat="server" Width="200px" Type="Date"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId6B" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ6C" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion6C" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ6C" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId6C" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ6D" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion6D" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ6D" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId6D" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <p>
                        &nbsp;
                    </p>
                    <div id="DivUpload6" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right; color:darkcyan;">
                            Upload Supporting Document:
                        </div>
                        <div class="col-xs-7 col-sm-5 col-md-5 col-lg-5" style="margin-top:7px;">
                            <asp:FileUpload ID="FileUpload6" runat="server" CssClass="form-control" Width="100%" ViewStateMode="Enabled" />
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1" style="margin-top:10px;font-size:x-large;">
                            <asp:Label ID ="LabelFileUpload6" runat="server" Visible="false" Type="text" Width="100%"></asp:Label>
                            <asp:ImageButton ID="ButtonSaveSectionQ6" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" AutoPostBack="true" OnClick="ButtonSaveSectionQ6_Click" />
                        </div>    
                    </div>   
                </div>
            </div>    
            <p>
                &nbsp;
            </p>
            <div id="DivQ7" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div id="DivQuestion7" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-11 col-sm-10 col-md-10 col-lg-10 left bold">
                        <asp:Label ID="Question7" runat="server"></asp:Label>
                    </div>
                    <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1 right">
                        <asp:Label ID="QuestionId7" runat="server" Visible="false"></asp:Label>
                    </div>                    
                </div>
                <div id="DivQ7Buttons" runat="server" class="btn-group-vertical toggle col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 center">
                        <asp:Button ID="ButtonQ7Yes" runat="server" Text="&nbsp;&nbsp;Yes" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ7Yes_Click" />
                    </div>
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 left">
                        <asp:Button ID="ButtonQ7No" runat="server" Text="&nbsp;&nbsp;No" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ7No_Click" />
                    </div>
                </div>
                <p>
                    &nbsp;
                </p>
                <div id="DivDetailQ7" runat="server">
                    <div id="DivDetailQ7A" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion7A" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ7A" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId7A" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ7B" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion7B" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5" style="vertical-align:bottom; margin-top:10px; margin-bottom:10px;">
                            <asp:TextBox ID="ResponseDetailQ7B" runat="server" Width="200px" Type="Date"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId7B" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ7C" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion7C" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ7C" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId7C" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ7D" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion7D" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ7D" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId7D" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <p>
                        &nbsp;
                    </p>
                    <div id="DivUpload7" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right; color:darkcyan;">
                            Upload Supporting Document:
                        </div>
                        <div class="col-xs-7 col-sm-5 col-md-5 col-lg-5" style="margin-top:7px;">
                            <asp:FileUpload ID="FileUpload7" runat="server" CssClass="form-control" Width="100%" ViewStateMode="Enabled" />
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1" style="margin-top:10px;font-size:x-large;">
                            <asp:Label ID ="LabelFileUpload7" runat="server" Visible="false" Type="text" Width="100%"></asp:Label>
                            <asp:ImageButton ID="ButtonSaveSectionQ7" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" AutoPostBack="true" OnClick="ButtonSaveSectionQ7_Click" />
                        </div>    
                    </div>   
                </div>
            </div>    
            <p>
                &nbsp;
            </p>
            <div id="DivQ8" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div id="DivQuestion8" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-11 col-sm-10 col-md-10 col-lg-10 left bold">
                        <asp:Label ID="Question8" runat="server"></asp:Label>
                    </div>
                    <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1 right">
                        <asp:Label ID="QuestionId8" runat="server" Visible="false"></asp:Label>
                    </div>                    
                </div>
                <div id="DivQ8Buttons" runat="server" class="btn-group-vertical toggle col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 center">
                        <asp:Button ID="ButtonQ8Yes" runat="server" Text="&nbsp;&nbsp;Yes" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ8Yes_Click" />
                    </div>
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 left">
                        <asp:Button ID="ButtonQ8No" runat="server" Text="&nbsp;&nbsp;No" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ8No_Click" />
                    </div>
                </div>
                <p>
                    &nbsp;
                </p>
                <div id="DivDetailQ8" runat="server">
                    <div id="DivDetailQ8A" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion8A" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ8A" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId8A" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ8B" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion8B" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5" style="vertical-align:bottom; margin-top:10px; margin-bottom:10px;">
                            <asp:TextBox ID="ResponseDetailQ8B" runat="server" Width="200px" Type="Date"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId8B" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ8C" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion8C" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ8C" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId8C" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ8D" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion8D" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ8D" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId8D" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <p>
                        &nbsp;
                    </p>
                    <div id="DivUpload8" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right; color:darkcyan;">
                            Upload Supporting Document:
                        </div>
                        <div class="col-xs-8 col-sm-5 col-md-5 col-lg-5" style="margin-top:8px;">
                            <asp:FileUpload ID="FileUpload8" runat="server" CssClass="form-control" Width="100%" ViewStateMode="Enabled" />
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1" style="margin-top:10px;font-size:x-large;">
                            <asp:Label ID ="LabelFileUpload8" runat="server" Visible="false" Type="text" Width="100%"></asp:Label>
                            <asp:ImageButton ID="ButtonSaveSectionQ8" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" AutoPostBack="true" OnClick="ButtonSaveSectionQ8_Click" />
                        </div>    
                    </div>   
                </div>
            </div>    
            <p>
                &nbsp;
            </p>
            <div id="DivQ9" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div id="DivQuestion9" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-11 col-sm-10 col-md-10 col-lg-10 left bold">
                        <asp:Label ID="Question9" runat="server"></asp:Label>
                    </div>
                    <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1 right">
                        <asp:Label ID="QuestionId9" runat="server" Visible="false"></asp:Label>
                    </div>                    
                </div>
                <div id="DivQ9Buttons" runat="server" class="btn-group-vertical toggle col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 center">
                        <asp:Button ID="ButtonQ9Yes" runat="server" Text="&nbsp;&nbsp;Yes" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ9Yes_Click" />
                    </div>
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 left">
                        <asp:Button ID="ButtonQ9No" runat="server" Text="&nbsp;&nbsp;No" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ9No_Click" />
                    </div>
                </div>
                <p>
                    &nbsp;
                </p>
                <div id="DivDetailQ9" runat="server">
                    <div id="DivDetailQ9A" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion9A" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ9A" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId9A" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ9B" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion9B" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5" style="vertical-align:bottom; margin-top:10px; margin-bottom:10px;">
                            <asp:TextBox ID="ResponseDetailQ9B" runat="server" Width="200px" Type="Date"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId9B" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ9C" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion9C" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ9C" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId9C" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ9D" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion9D" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ9D" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId9D" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <p>
                        &nbsp;
                    </p>
                    <div id="DivUpload9" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right; color:darkcyan;">
                            Upload Supporting Document:
                        </div>
                        <div class="col-xs-9 col-sm-5 col-md-5 col-lg-5" style="margin-top:9px;">
                            <asp:FileUpload ID="FileUpload9" runat="server" CssClass="form-control" Width="100%" ViewStateMode="Enabled" />
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1" style="margin-top:10px;font-size:x-large;">
                            <asp:Label ID ="LabelFileUpload9" runat="server" Visible="false" Type="text" Width="100%"></asp:Label>
                            <asp:ImageButton ID="ButtonSaveSectionQ9" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" AutoPostBack="true" OnClick="ButtonSaveSectionQ9_Click" />
                        </div>    
                    </div>   
                </div>
            </div>    
            <p>
                &nbsp;
            </p>
            <div id="DivQ10" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div id="DivQuestion10" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-11 col-sm-10 col-md-10 col-lg-10 left bold">
                        <asp:Label ID="Question10" runat="server"></asp:Label>
                    </div>
                    <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1 right">
                        <asp:Label ID="QuestionId10" runat="server" Visible="false"></asp:Label>
                    </div>                    
                </div>
                <div id="DivQ10Buttons" runat="server" class="btn-group-vertical toggle col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 center">
                        <asp:Button ID="ButtonQ10Yes" runat="server" Text="&nbsp;&nbsp;Yes" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ10Yes_Click" />
                    </div>
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 left">
                        <asp:Button ID="ButtonQ10No" runat="server" Text="&nbsp;&nbsp;No" Font-Bold="true" Font-Size="Large" CssClass="HREButtonInActive" AutoPostBack="true" OnClick="ButtonQ10No_Click" />
                    </div>
                </div>
                <p>
                    &nbsp;
                </p>
                <div id="DivDetailQ10" runat="server">
                    <div id="DivDetailQ10A" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion10A" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ10A" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId10A" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ10B" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion10B" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5" style="vertical-align:bottom; margin-top:10px; margin-bottom:10px;">
                            <asp:TextBox ID="ResponseDetailQ10B" runat="server" Width="200px" Type="Date"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId10B" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ10C" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion10C" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ10C" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId10C" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <div id="DivDetailQ10D" runat="server">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right;">
                            <asp:Label id="DetailQuestion10D" runat="server"  />
                        </div>
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                            <asp:TextBox ID="ResponseDetailQ10D" runat="server" Width="100%"  TextMode="SingleLine"/>
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1">
                            <asp:Label id="DetailQuestionId10D" runat="server" visible="false" ></asp:Label>
                        </div>
                    </div>
                    <p>
                        &nbsp;
                    </p>
                    <div id="DivUpload10" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 margin-top10" style="text-align:right; color:darkcyan;">
                            Upload Supporting Document:
                        </div>
                        <div class="col-xs-10 col-sm-5 col-md-5 col-lg-5" style="margin-top:10px;">
                            <asp:FileUpload ID="FileUpload10" runat="server" CssClass="form-control" Width="100%" ViewStateMode="Enabled" />
                        </div>
                        <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1" style="margin-top:10px;font-size:x-large;">
                            <asp:Label ID ="LabelFileUpload10" runat="server" Visible="false" Type="text" Width="100%"></asp:Label>
                            <asp:ImageButton ID="ButtonSaveSectionQ10" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" AutoPostBack="true" OnClick="ButtonSaveSectionQ10_Click" />
                        </div>    
                    </div>   
                </div>
            </div>    

        </div>
        
        <div id="divDocumentsLoaded" class="well HREWhite HRERewrap">
            <b>Documents Loaded:</b>
            <br/><br/>
            
            <asp:GridView ID="grdEEDocs" runat="server" 
                DataKeyNames="EmployeeDocumentId,CompanyId,EmployeeId,DocumentCategoryId,DocumentTypeId,DocumentSubTypeId" 
                AutoGenerateColumns="False" 
                Width="100%" 
                Visible="false"
                HorizontalAlign="Center"
                GridLines="None" 
                BorderColor="#3276B1"
                CellPadding="4">    
                        <Columns >
                            <asp:BoundField HeaderText="EmployeeDocumentId" DataField="EmployeeDocumentId" Visible="false"></asp:BoundField>     
                            <asp:BoundField HeaderText="DocumentCategoryId" DataField="DocumentCategoryId" Visible="false"></asp:BoundField>
                            <asp:BoundField HeaderText="DocumentTypeId" DataField="DocumentTypeId" Visible="false"></asp:BoundField>
                            <asp:BoundField HeaderText="DocumentSubTypeId" DataField="DocumentSubTypeId" Visible="false"></asp:BoundField>
                            
                            <asp:BoundField HeaderText="Support Type" DataField="DocumentType"></asp:BoundField>
                            <asp:BoundField HeaderText="Document Type" DataField="DocumentSubType"></asp:BoundField>
                            <asp:BoundField HeaderText="Document Name" DataField="DocumentName"></asp:BoundField>

                            <asp:BoundField HeaderText="Document Link" DataField="DocumentLink" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>

                           <%--<asp:TemplateField>
                                <ItemTemplate>
                                     <asp:Button ID="btnDelete" runat="server" Text="Delete" Visible="true" HtmlEncode="false" AutoPostBack="true" OnClick="btnSaveDelete_Click"  />
                                    <br />
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                        </Columns>                       
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Center"  />
                    </asp:GridView>

        </div>

        <div id="divDocumentsNeeded" class="well HREWhite HRERewrap">
            
            <asp:GridView ID="grdEEDocsNeeded" runat="server" 
                DataKeyNames="CompanyId,EmployeeId,DocumentTypeId,DocumentType" 
                AutoGenerateColumns="False" 
                Width="100%" 
                Visible ="false"
                HorizontalAlign="Center"
                GridLines="None" 
                BorderColor="#3276B1"
                CellPadding="4">    
                        <Columns >
                            <asp:BoundField HeaderText="DocumentTypeId" DataField="DocumentTypeId" Visible="false"></asp:BoundField>
                            <asp:BoundField HeaderText="Document Type" DataField="DocumentType"></asp:BoundField>
                            <asp:BoundField HeaderText="Document Needed" DataField="DocumentNeeded"></asp:BoundField>                 
                        </Columns>                       
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Center"  />
                    </asp:GridView>

        </div>

<%--        <div class="row">
            <div class="clearfix">&nbsp;</div>
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 text-center">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valw4" Onclick="btnSave_Click" />
            </div>
            <div class="clearfix">&nbsp;</div>
        </div>--%>
        
    </div> 
    

    <style>
        input[type=text], textarea {outline: none; font-size:large; vertical-align:middle; min-height: 40px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; padding-left: 5px; margin-top:7px; margin-bottom:2px; min-width:250px; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }
        .HREButtonActive {width: 130px; height: 40px; background-color: #609dd2; color: white; border-color: lightgrey; border-radius: 5px;}
        .HREButtonInActive {width: 130px; height: 40px; background-color: white; color: black; border-color: lightgrey; border-radius: 5px;}
        .HREChooseFile {width: 500px; height: 40px; background-color: green; color: black; border-color: lightseagreen; border-radius: 5px;}
        .HREButtonUpload {width: 300px; height: 50px; background-color: darkblue; color: white; border-color: lightblue; border-radius: 5px;}
        table {background-color:white; color:black; border-color:white; border-collapse:separate; border-spacing: 0px 5px;}
        /*input[type="radio"] {opacity: 0; position: fixed; width: 0; text-align:left;}*/
        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px 10px 10px 10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HRENext {padding:5px 5px 5px 15px; float:right; min-width:50px; max-width:90px; }
        .img {display: inline-block; width: auto; height: auto;}
    </style>
</asp:Content>


