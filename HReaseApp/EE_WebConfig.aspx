<%@Page Title="Employee WebConfig Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_WebConfig.aspx.vb" 
    Inherits="HReaseApp.EE_WebConfig" 
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>   
    </div>     
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainArticle" Runat="Server">
    <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>Employee WebConfig</b></h4>
            </div>
        </div>

       <div id="divNextButton" runat="server" class="hidden-xs" style="float:right; display:inline; width:10%; margin-top:-5px;">
            <asp:ImageButton ID="imgNext" runat="server" class="HRENext" ToolTip="NEXT" ImageUrl="../img/NextArrowInCircleBlueGreenTP.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreenTP.png';" OnClick="imgNext_Click" />
        </div>

        <div id="divProcessing" runat="server" visible="false">
            <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Width="100%" />
        </div>
         
        <div id="divMainArticalTitleandText" runat="server" class="well HRESlateBlue HRERewrap">
            <div id="divTitle" runat="server" >
                    <h4><asp:Label ID="lblMainArticleTitle" runat="server" Text=""></asp:Label></h4>           
            </div>
            <div id="divText" runat="server" class="HREWhite" style="border:none;">
                    <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div> 

       <%--Data Grid of Web Configurations - Calls on  CompanyClass.getCompanyWebConfig from Company.vb Class--%>
        <div class="well HREWhite"> 
            <div class="form-group" style="padding-right:2%;">
                <asp:GridView ID="grdEEWebConfig" runat="server" 
                    DataKeyNames="CompanyId,EmployeeId,ScreenId,IsAssigned" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Left" GridLines="None" BorderColor="#3276B1" CellPadding="1" EmptyDataText="No Screen Config For this Client">

                    <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                    <Columns>                        
                        
                        <asp:BoundField HeaderText="Screen Category" DataField="ScreenCategory" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField HeaderText="Long Description" DataField="ScreenLongDesc" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField HeaderText="Screen Path" DataField="ScreenPath" HtmlEncode="false" ReadOnly="false" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField HeaderText="CompanyId" DataField="CompanyId" Visible ="False" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField HeaderText="EmployeeId" DataField="EmployeeId" Visible ="False" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField HeaderText="ScreenId" DataField="ScreenId" Visible ="False" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        
                        <asp:TemplateField HeaderText="Assigned?" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkAssigned" runat="server" style="font-weight: bold" AutoPostBack="true" OnCheckedChanged="chkAssigned_CheckedChanged" Checked='<%# DataBinder.Eval(Container.DataItem, "IsAssigned")%>' Enabled="true" />                                  
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                    <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                </asp:GridView>
                <br />
                <br />
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
        .HRENext {padding:5px 5px 5px 15px; float:right; min-width:50px; max-width:90px; }
        .img {display: inline-block; width: auto; height: auto;}
    </style>
</asp:Content>