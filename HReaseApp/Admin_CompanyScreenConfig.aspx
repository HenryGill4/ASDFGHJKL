<%@ Page Title="Company Screen Configuration Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="Admin_CompanyScreenConfig.aspx.vb" 
    Inherits="HReaseApp.Admin_CompanyScreenConfig" 
    ValidateRequest="false" 
    MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="tabs" runat="Server">
    <div id="tabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>       
    </div>
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" Runat="Server">
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
    <script type="text/javascript" src="Scripts/tinymce/tinymce.min.js"></script>
        <script type="text/javascript">
            tinymce.init({
            selector: 'textarea',
            height: 400,
            theme: 'modern',
            plugins: [
                'advlist autolink lists link image charmap print preview hr anchor pagebreak',
                'searchreplace wordcount visualblocks visualchars code fullscreen',
                'insertdatetime media nonbreaking save table contextmenu directionality',
                'emoticons template paste textcolor colorpicker textpattern imagetools codesample toc help'
            ],
            menubar: false,
            toolbar1: 'undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | forecolor backcolor | bullist numlist outdent indent | link preview  | image',

            image_advtab: true,
            templates: [
                { title: 'Test template 1', content: 'Test 1' },
                { title: 'Test template 2', content: 'Test 2' }
            ], content_css: [
                '//fonts.googleapis.com/css?family=Open+Sans:300,400,700,800',
                'Corporate/assets/css/essentials.css'
            ]

        });
    </script>

    <div class="HREwrapper">
        <div id="divPageTitle">
            <div >
                <br />
                <h4><b>Company Screen Configuration</b></h4>
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

        <div id="divScreenConfig" class="well HREWhite" >
            <div id="divReviewScreens"  class="form-group">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 " style="font-size:14px;">                            
                    <asp:GridView ID="grdScreenConfig" runat="server" 
                        
                        DataKeyNames="ScreenConfigBlockId,ScreenConfigId, CompanyId, ScreenId, BlockId,IsAParent,ParentCompany" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center" 
                        GridLines="None" BorderColor="#3276B1"
                        CellPadding="4"
                        EmptyDataText="Will never happen"
                        OnRowCommand="grdScreenConfig_RowCommand" 
                        OnRowEditing="grdScreenConfig_RowEditing"
                        OnRowCancelingEdit="grdScreenConfig_RowCancelingEdit"
                        OnRowUpdating="grdScreenConfig_RowUpdating">

                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                        <Columns >
                            
                            <asp:BoundField HeaderText="ScreenConfigBlockId" DataField="ScreenConfigId" Visible="false" />
                            <asp:BoundField HeaderText="ScreenConfigId" DataField="ScreenConfigId" Visible="false" />
                            <asp:BoundField HeaderText="IsAParent" DataField="IsAParentDocument" Visible="false" />
                            <asp:BoundField HeaderText="ParentCompany" DataField="ParentCompany" Visible="false" />
                           
                            <asp:TemplateField HeaderText="" itemStyle-HorizontalAlign="center">
                                <ItemTemplate >                              
                                     <asp:Label ID="lblParent" runat="server" Visible="false" Text='<%# DataBinder.Eval(Container.DataItem, "ParentCompany")%>'  CssClass="nowrap"/>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField HeaderText="Category" DataField="ScreenCategory" HtmlEncode="false" ReadOnly="true"  ItemStyle-Width="120px"></asp:BoundField>                        
                            <asp:BoundField HeaderText="Tab Name" DataField="ScreenName" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center" ></asp:BoundField>       
                            <asp:BoundField HeaderText="Location" DataField="BlockName" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                            
                            <asp:ButtonField runat="server" ButtonType="Image"  ImageUrl="../img/plus.png"  CommandName="View"     ControlStyle-Width ="25px"/>
                            <asp:ButtonField runat="server" ButtonType="Image"  ImageUrl="../img/minus.png" CommandName="Hide"  ControlStyle-Width ="25px"/>
                            
                            <asp:BoundField HeaderText="Screen Link" DataField="ScreenPath" HtmlEncode="false" ReadOnly="true"  ItemStyle-Width="150px"></asp:BoundField>
                            <asp:BoundField HeaderText="Configured For" DataField="ParentCompany" HtmlEncode="false" ReadOnly="true"  ItemStyle-Width="200px"></asp:BoundField>
                            
                            <asp:TemplateField HeaderText="Begin Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblBeginDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtBeginGrid" runat="server" CssClass="form-control" Width="105px" Text='<%# DataBinder.Eval(Container.DataItem, "BeginDate")%>' />
                                     <%--<asp:RequiredFieldValidator ID="valBeginDate" runat="server"  ControlToValidate="txtBeginGrid" ValidationGroup="valBlock" ErrorMessage=" <h4>Begin Date cannot be blank </h4>"></asp:RequiredFieldValidator>--%>
                                     <asp:CompareValidator id="cmvalBeginDate" runat="server"  Type="Date" Operator="DataTypeCheck" ControlToValidate="txtBeginGrid"  ErrorMessage="<h4>Begin Date is not formatted correctly (mm/dd/yyyy)</h4>"  Display="None" ValidationGroup="valDocs"></asp:CompareValidator>
                                 </EditItemTemplate>                                
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="End Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblEndDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEndGrid" runat="server" CssClass="form-control" Width="105px" Text='<%# DataBinder.Eval(Container.DataItem, "EndDate")%>' />
                                  <%--  <asp:RequiredFieldValidator ID="valEndDate" runat="server" ErrorMessage="<h4>End Date</h4>" ControlToValidate="txtEndGrid" ValidationGroup="valBlock" Display="None" ></asp:RequiredFieldValidator>  --%> 
                                    
                                      <asp:CompareValidator id="cmvalEndDate" runat="server"  Type="Date" Operator="DataTypeCheck" ControlToValidate="txtEndGrid"  ErrorMessage="<h4>End Date is not formatted correctly (mm/dd/yyyy)</h4>"  Display="None" ValidationGroup="valDocs"></asp:CompareValidator>
                             
                                 </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Update">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEdit" runat="server" Text="Update" CommandName="Edit" CommandArgument='<%# Container.DataItemIndex %>'></asp:LinkButton>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="lnkSave" runat="server" Text="Save" CommandName="Update" ValidationGroup="valBlock"></asp:LinkButton>
                                    <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel"></asp:LinkButton>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Panel ID="pnlReviewContent" runat="server" Visible="false"  class="HREWhite " style="border:none; padding:5px 10px 5px 5px;">
                                        </tr>

                                        <tr>
                                            <td colspan="3">

                                            </td>
                                            <td colspan="8">
                                                <h4><strong>Title: </strong></h4>
                                                <asp:Label ID="lblBlockTitle" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BlockTitle")%>' />
                                                 <br />
                                                <br />
                                            </td>
                                             <td colspan="1">                                          
                                        </td>
                                        </tr>
                                        <tr >

                                        <td colspan="3" style="text-align:center;">
                                            <h4><strong>Location:</strong></h4>
                                            Area marked by Red Block
                                            <br /><br />
                                           <img src='<%# DataBinder.Eval(Container.DataItem, "BlockImage")%>'  class="img-thumbnail" />   
                                             <br />
                                                <br />

                                            <asp:CheckBox ID="chkDocuments" runat="server" CssClass="check checkbox-inline" Text ="Show Documents in Content" />
                                                                                       
                                        </td>
                                        <td colspan="8">
                                            <h4><strong>Content:</strong> </h4>
                                         <asp:Label ID="lblContent" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "BlockContent")%>' ></asp:Label>
                                            <br />
                                           
                                        </td>

                                        <td colspan="1">                                          
                                        </td>

                                       </tr> 
                                    </asp:Panel>

                                    <asp:Panel ID="pnlEditContent" runat="server"  Visible="false">
                                        </tr>
                                         <td colspan="3" >
                                           
                                           
                                        </td>
                                        <td colspan="8" >
                                          <h4><strong>Title: </strong></h4>
                                            <asp:TextBox ID="txtBlockTitle" runat="server" CssClass="form-control"   Text='<%# DataBinder.Eval(Container.DataItem, "BlockTitle")%>'  />
                                            <br />
                                             <br />
                                        </td>
                                        <td colspan="1" >                                          
                                        </td>
                                       </tr>                                           

                                        <tr>
                                       <td colspan="3" style="vertical-align:top; text-align:center;">
                                            <h4><strong>Location:</strong></h4>
                                            Area marked by Red Block
                                            <br /><br />
                                            <img src='<%# DataBinder.Eval(Container.DataItem, "BlockImage")%>'  class="img-thumbnail" />   
                                             <br />
                                                <br />
                                           
                                        </td>
                                        <td colspan="8" >
                                            <h4><strong>Content:</strong> </h4>
                                            
                                            <asp:textbox ID="txtContent" runat="server" CssClass="form-control" Text='<%# DataBinder.Eval(Container.DataItem, "BlockContent")%>' TextMode="MultiLine" Rows="5" ></asp:textbox>                                         
                                            <br />
                                            <br />
                                        </td>
                                        <td colspan="1" >
                                            <%--<asp:Button ID="btnSaveContent" runat ="server" CssClass="btn-sm btn-success" Text="Save" CommandName="SaveContent" />--%>
                                        </td>
                                       </tr>                                                                                          
                                    </asp:Panel> 
                                </ItemTemplate>
                            </asp:TemplateField>
                     

                        </Columns>
                        <FooterStyle BackColor="yellow" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                    </asp:GridView>
                    <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
                    <br />
                    <br />
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
        .HRENext {padding:5px 5px 5px 5px; float:right; width:50%; }
        .img {display: inline-block; width: auto; height: auto;}
    </style>
</asp:Content>
