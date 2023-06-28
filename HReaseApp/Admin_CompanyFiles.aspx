<%@ Page Title="Company Files" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="Admin_CompanyFiles.aspx.vb" 
    Inherits="HReaseApp.Admin_CompanyFiles" 
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>   
    </div> 
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/chosen/1.8.7/chosen.min.css" rel="stylesheet" />
    <style>
        .chosen-container{
            min-width: 300px !important;
            max-width:600px !important; 
            width:50% !important;
        }
    </style>
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
        <div id="PageTitle" class="HRERewrap">
            <div style="text-align:center;">
                <br />
                <h4><b>Imports and Extracts</b></h4>
            </div>
        </div>
        
        <div id="divNextButton" runat="server" class="hidden-xs" style="float:right; display:inline; margin-top:-7px;">
            <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
            <asp:Image ID="Image1" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
        </div>

        <div id="divTopHeader" runat="server">   
            <div id="divCompanyList" runat="server" class="well HRESlateBlue HRERewrap form-inline">
                <span style="padding-left:10px; padding-right:10px; width:10%;">
                    Company:
                </span>
                <span style="min-width:300px; max-width:600px; width:50%;"> 
                    <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-control" DataValueField="CompanyId" DataTextField="CombinedCompanyName" AutoPostBack="true" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged"></asp:DropDownList>
                </span>
                <script>
                    $('#<%=ddlCompany.ClientID%>').chosen();
                </script>
                <span style="width:20%;">
                    &nbsp;&nbsp;<asp:CheckBox ID="chkActive" runat="server" Checked="true" Text="&nbsp;&nbsp;Active Companies &nbsp;&nbsp;" AutoPostBack="true" OnCheckedChanged="chkActive_CheckedChanged" Visible="true"></asp:CheckBox>
                </span>
                <br /><br />
            </div>   
        </div>

        <div id="divCompanyName" runat="server" class="well" style="text-align:center; margin-right:5%;">
            <b><asp:Label ID="lblCompanyName" runat="server" Text="CompanyName"></asp:Label></b>
            <br /><br />
        </div>    

        <div id="divErrorOrSuccess" class="form-group">                  
            <div id="divError" runat="server" visible ="false" style="vertical-align:middle; display:inline;">
                <h3><b><span style="color: red;">   
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" border="none" Width="50px" />
                    &nbsp;&nbsp;
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
                </span></b></h3>
            </div>
            <div id="divSuccess" runat="server" visible ="false" style="vertical-align:middle; display:inline;">
                <div style="float:left;">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" />
                </div>
                <div id="divSuccessLabel" style="text-align:center; color:green; font-size:x-large;">
                    <b><asp:Label ID="lblSuccess" runat="server" Text="Form Complete"></asp:Label></b>
                </div>
            </div>
        </div>  
        <div id="divMainArticalTitleandText" runat="server" class="well HRESlateBlue HRERewrap hidden" >
            <div id="divTitle" runat="server" class="form-group HRESlateBlue">
                    <h4><asp:Label ID="lblMainArticleTitle" runat="server" Text=""></asp:Label></h4>           
            </div>
            <div id="divText" runat="server" class="form-group HREWhite" >
                    <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div>

        <div id="DivUpload1" runat="server" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 margin-top10" style="text-align:left; color:darkcyan; font-size:large; font-weight: bold;">
                Upload New File:
            </div>
            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 margin-top10" >
                <asp:DropDownList ID="ddlFileTypeList" runat="server" CssClass="form-control" DataValueField="FileTypeId" DataTextField="LongDesc" AutoPostBack="true" OnSelectedIndexChanged="ddlFileTypeList_SelectedIndexChanged"></asp:DropDownList>
            </div>
            <br />
            <br />
            <div class="col-xs-7 col-sm-5 col-md-5 col-lg-5 margin-top10" >                
                <asp:TextBox ID="TextFileDescription" Placeholder ="Enter File Description" runat="server" CssClass="form-control left" DataValueField="LongDesc" ></asp:TextBox>
            </div>
            <div class="col-xs-7 col-sm-5 col-md-5 col-lg-5" style="margin-top:7px;">
                <asp:FileUpload ID="FileUpload1" runat="server" Text="Upload File" CssClass="form-control" Width="100%" ViewStateMode="Enabled" />
            </div>
            <div class="col-xs-12 col-sm-1 col-md-1 col-lg-1" style="margin-top:10px;font-size:x-large;">
                <asp:Label ID ="LabelFileUpload1" runat="server" Visible="false" Type="text" Width="100%"></asp:Label>
                <asp:Button ID="ButtonChangeDoc" Text="Upload File" runat="server" Enabled="true" EnableViewState="true" Class="buttonChangeDoc" autopostback="true" OnClick="btnUpload_Click" />
            </div>    
        </div> 
         
        <div id="divImportsLoaded" class="well HREWhite HRERewrap">
            <b>Files Loaded:</b>
            <br/><br/>
            
            <asp:GridView ID="grdImportFiles" runat="server" RowStyle-BackColor="#f5f5f5"
                DataKeyNames="CompanyFileId,CompanyId,FileCategoryId,FileTypeId,FileSubTypeId" 
                AutoGenerateColumns="False" 
                Width="100%" 
                HorizontalAlign="Center"
                GridLines="None" 
                BorderColor="#3276B1"
                CellPadding="4">    
                        <Columns >
                            <asp:BoundField HeaderText="CompanyFileId" DataField="CompanyFileId" Visible="false"></asp:BoundField>     
                            <asp:BoundField HeaderText="FileCategoryId" DataField="FileCategoryId" Visible="false"></asp:BoundField>
                            <asp:BoundField HeaderText="FileTypeId" DataField="FileTypeId" Visible="false"></asp:BoundField>
                            
                            <asp:BoundField HeaderText="Date Added" DataField="CreateDate"></asp:BoundField>
                            <asp:BoundField HeaderText="File Type" DataField="FileType"></asp:BoundField>
                            <asp:BoundField HeaderText="File Name" DataField="FileName"></asp:BoundField>
                            <asp:BoundField HeaderText="File Link" DataField="FileLink" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>

                            <%--<asp:TemplateField HeaderText="File">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" Text='<%# Eval("FileLink") %>' OnClick="FileDownload_Clicked"/>
                                </ItemTemplate>
                            </asp:TemplateField>--%>

                           <asp:TemplateField>
                                <ItemTemplate>
                                     <asp:Button ID="btnDelete" runat="server" Text="Delete" Visible="true" HtmlEncode="false" AutoPostBack="true" OnClick="btnSaveDelete_Click"  />
                                    <br />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Active" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkActive" runat="server" style="font-weight: bold" AutoPostBack="true"  Checked='<%# DataBinder.Eval(Container.DataItem, "Active") %>' OnCheckedChanged="chkActiveFlag_CheckedChanged"/>                                  
                                </ItemTemplate>
                            </asp:TemplateField>--%>

                        </Columns>                       
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Center"  />
                    </asp:GridView>

        </div>

        <div id="divExports" class="well HREWhite HRERewrap">
            <b>Files Produced by HR ease:</b>
            <br/><br/>
            
            <asp:GridView ID="grdExportFiles" runat="server" RowStyle-BackColor="#f5f5f5"
                DataKeyNames="CompanyFileId,CompanyId,FileCategoryId,FileTypeId" 
                AutoGenerateColumns="False" 
                Width="100%" 
                HorizontalAlign="Center"
                GridLines="None" 
                BorderColor="#3276B1"
                CellPadding="4">    
                        <Columns >
                            <asp:BoundField HeaderText="CompanyFileId" DataField="CompanyFileId" Visible="false"></asp:BoundField>     
                            <asp:BoundField HeaderText="FileCategoryId" DataField="FileCategoryId" Visible="false"></asp:BoundField>
                            <asp:BoundField HeaderText="FileTypeId" DataField="FileTypeId" Visible="false"></asp:BoundField>
                            
                            <asp:BoundField HeaderText="Date Added" DataField="FileCreated"></asp:BoundField>
                            <asp:BoundField HeaderText="File Type" DataField="FileType"></asp:BoundField>
                            <asp:BoundField HeaderText="File Name" DataField="FileName"></asp:BoundField>
                            <asp:BoundField HeaderText="File Link" DataField="FileLink" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>

                            <%--<asp:TemplateField HeaderText="Active" ItemStyle-Width="50px" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkActive" runat="server" style="font-weight: bold" AutoPostBack="true"  Checked='<%# DataBinder.Eval(Container.DataItem, "Active") %>' OnCheckedChanged="chkActiveFlag_CheckedChanged"/>                                  
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                        </Columns>                       
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Center"  />
                    </asp:GridView>

        </div>
       
    </div>
    <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; text-align:center; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
        .HRELabel {background-color: #f5f5f0; font-size: large; vertical-align:bottom;}
    </style>
</asp:Content>