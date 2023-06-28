<%@ Page Title="Onboarding Finalize and Accept Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master"  
    CodeBehind="EE_Onboarding_Accept.aspx.vb" 
    Inherits="HReaseApp.EE_Onboarding_Accept" 
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" runat="Server">
     <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>Onboarding Acceptance</b></h4>
            </div>
        </div>

        <div id="divTopHeader" class="form-group">                  
            <div id="divError" runat="server" visible="false" class="HREError">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
            </div>
            <div class="form-group" style="display:inline;">
                <div id="divSuccess" runat="server" visible ="false" class="HRESuccess">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" ImageAlign="Left" />
                    <asp:Label ID="lblSuccess" runat="server" Text="Form Complete" Width="50%"></asp:Label>
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
                </div>
            </div>
        </div> 

        <br /><br />

        <div class="form-group">
            <div id="divCol1" runat="server" class="form-group" >
                <div id="divMainArticalTitleandText" runat="server" class="well HRESlateBlue">
                    <div id="divTitle" runat="server" class="form-group HRESlateBlue">
                            <h4><asp:Label ID="lblMainArticleTitle" runat="server" Text=""></asp:Label></h4>           
                    </div>
                    <div id="divText" runat="server" class="form-group HREWhite" >
                            <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
                    </div>
                </div>
                <div id="divSignatureAndDate" runat="server" class="well HREWhite">
                    <div id="divSignatureLine" class="form-group" style="padding-top:20px;">
                        <asp:Label ID="lblSignature" runat="server" Visible="true" Text="Employee Signature:" for="txtSignature" class="col-sm-2 text-right control-label"></asp:Label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtSignature" runat="server"  Visible="true" CssClass="form-control"></asp:TextBox>
                        </div>
                        <asp:Label ID="lblSignatureDate" runat="server"  Visible="true" Text="Date:" for="txtSignatureDate" class="col-sm-1 text-right control-label"></asp:Label>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtSignatureDate" runat="server"  Visible="true" CssClass="form-control"></asp:TextBox>
                        </div>   
                        <div class="form-group HREpadR10">
                            <asp:ImageButton ID="btnAccept" runat="server" ImageUrl="../img/GreenAcceptBtnNew.png" OnMouseOver="src='/img/GreenAcceptBtnOverNew.png';" OnMouseOut="src='/img/GreenAcceptBtnNew.png';"  BorderStyle="None"  Onclick="btnAccept_Click" />
                        </div>
                    </div>
                </div>  
            </div>
            <div id="divCol2" runat="server" class="form-group " style=" padding-left:5%; padding-right:5%;">
                 <div id="divOnboardingProgress" class="HREWhite HRERewrap" style="margin-left:-50px;">
                     <div id ="divProgressBarSection" runat="server" >
                        <div id="divCompletePercent">
                            <b>Onboarding Progress</b>
                            <div class="progress progress-striped active">
                                <div id="divProgressBar" class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="0" aria-valuemin="10" aria-valuemax="100" style="width: 0%" runat="server">
                                    <strong>
                                        <asp:Label ID="lblProgress" Text="00" runat="server"></asp:Label></strong>
                                </div>
                            </div>
                        </div>                          
                        <div id="divProgressList" runat="server">
                            <asp:GridView ID="grdOnboardingProgress" runat="server"
                                    DataKeyNames="EmployeeId, StepOrder, StepType, StepDescription, StepComplete, PercentComplete, EEPercentComplete" AutoGenerateColumns="False" Width="98%" HorizontalAlign="Center"
                                    GridLines="none" 
                                    BorderColor="white"
                                    CellPadding="4"
                                    EmptyDataText="No Progress">
                                    <Columns>
                                        <asp:BoundField HeaderText="Employee Id" DataField="EmployeeId" Visible="false" />
                                        <asp:BoundField HeaderText="Step" DataField="StepOrder" Visible="true" ItemStyle-Width="10%"  ItemStyle-VerticalAlign="top"/>
                                        <asp:BoundField HeaderText="Step Type" DataField="StepType" Visible="false" />
                                        <asp:BoundField HeaderText="Description" DataField="StepDescription" Visible="true" ItemStyle-Width="50%" ItemStyle-Wrap="true" />
                                        <asp:BoundField HeaderText="Step Complete" DataField="StepComplete" Visible="false" />
                                        <asp:BoundField HeaderText="Percent Complete" DataField="PercentComplete" Visible="false" />
                                        <asp:BoundField HeaderText="EE Percent Complete" DataField="EEPercentComplete" Visible="false" />
                                   
                                    </Columns>
                                    <alternatingrowstyle backcolor="whitesmoke" forecolor="DarkBlue" />
                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                    <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />

                                </asp:GridView>
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
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px 10px 10px 10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HRENext {padding:5px 5px 5px 5px; float:right; min-width:50px; max-width:90px; vertical-align:bottom; margin-top:20px;}
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
        .img {display: inline-block; width: auto; height: auto;}
    </style>
</asp:Content>
