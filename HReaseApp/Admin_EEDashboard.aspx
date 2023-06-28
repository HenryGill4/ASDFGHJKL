<%@ Page Title="Admin_EEDashboard" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="Admin_EEDashboard.aspx.vb" 
    Inherits="HReaseApp.Admin_EEDashboard"
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server" >
    <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server" ></asp:Literal>      
    </div>    
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" runat="Server">
    <div class="container">
        <div class="col-xs-8 col-sm-8 col-md-6 left">
            <br />
            <h3>Employee Dashboard</h3>
            <br />
            <h4><asp:Label ID="lblEmployeeName" runat="server"></asp:Label></h4>
            <h4><asp:Label ID="lblEmployeeFullName" runat="server" Text=""></asp:Label></h4>
            <div class="col-xs-8 col-sm-8 ">
                <img id="imgProfilePic" runat="server" src="images/default_person.jpg" width="56" alt="" />
            </div>
            <div class="col-xs-8 col-sm-8 col-md-6">
                <div class="row">
                    <asp:Label ID="lblAddress" runat="server" class=" control-label"></asp:Label>
                </div>
                <div class="row">
                    <asp:Label ID="lblAddress2" runat="server" class=" control-label"></asp:Label>
                </div>
                <div class="row">
                    <asp:Label ID="lblCity" runat="server" class=" control-label"></asp:Label>
                    <asp:Label ID="lblState" runat="server" class=" control-label"></asp:Label>
                    &nbsp
                <asp:Label ID="lblZip" runat="server" class=" control-label"></asp:Label>
                    &nbsp
                </div>
                <div class="row">
                    <asp:Label ID="lblPhone" runat="server" class=" control-label"></asp:Label>
                </div>
                <div class="row" style="padding-bottom:5%;">
                    <asp:Label ID="lblEmail" runat="server" class=" control-label"></asp:Label>
                </div>
            </div>
            <%--<div class="row">
                <div class="col-xs-8 col-sm-8">
                    <br />
                    <asp:ImageButton ID="btnEditProfile" runat="server" ImageUrl="img/BlueEditBtn.png" OnMouseOver="src='/img/BlueEditBtnOver.png';" OnMouseOut="src='/img/BlueEditBtn.png';" ImageAlign="AbsMiddle" PostBackUrl="~/EE_Profile.aspx" />
                </div>
            </div>--%>
        </div>

        <div class="col-xs-2 col-sm-2 col-md-4 pull-right right" style="padding-top:5%;">
            <asp:ImageButton ID="imgNext" runat="server" ImageUrl="../img/BlueArrowNext.png" OnMouseOver="src='/img/BlueArrowNextOver.png';" OnMouseOut="src='/img/BlueArrowNext.png';" background="#fff" BackColor="White" BorderStyle="None" ImageAlign="AbsMiddle" Visible="true" OnClick="imgNext_Click" />
        </div>
        <%--<div class="col-md-4 pull-right right" style="float:right; padding-top:1%;">
            <b>Create Registration Key</b><br />
            <asp:ImageButton ID="imgRegistration" runat="server" ImageUrl="../img/License-Key.png" BorderStyle="None" Visible="true" Height='40px' data-toggle='modal' data-target='#ModalRegistration' ToolTip="Registration Key" OnClientClick="return-true" />           
            <br />
        </div>--%>
        <div class="Screen List">       
            <div class="col-lg-12 pull-right;" style="font-size:large;Width:70%;vertical-align:top;">
                <asp:GridView ID="grdEEWebConfig" runat="server"
                    DataKeyNames="CompanyId,EmployeeId,ScreenId,IsAssigned"
                    AutoGenerateColumns="False" 
                    HorizontalAlign="Left"
                    GridLines="None" BorderColor="#3276B1"
                    CellPadding="1"
                    EmptyDataText="No Company Configuration Established">
                       
                    <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>                   
                    <Columns>                        
                        <asp:BoundField HeaderText="EmployeeWebConfigId" DataField="EmployeeWebConfigId" Visible="false" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>                       
                        <asp:BoundField HeaderText="CompanyWebConfigId" DataField="CompanyWebConfigId" Visible="false" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField HeaderText="CompanyId" DataField="CompanyId" Visible="false" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField HeaderText="EmployeeId" DataField="EmployeeId" Visible="false" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField HeaderText="ScreenId" DataField="ScreenId" Visible ="true" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField HeaderText="ScreenName" DataField="ScreenName" Visible ="false" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField HeaderText="Category" DataField="ScreenCategory" Visible ="true" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField HeaderText="ScreenShortDesc" DataField="ScreenShortDesc" Visible ="false" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField HeaderText="ScreenLongDescr" DataField="ScreenLongDesc" Visible ="false" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField HeaderText="Screen Description and Link" DataField="ScreenPath" Visible ="True" HtmlEncode="false" ReadOnly="true" ></asp:BoundField>
                        <%--<asp:BoundField HeaderText="IsAssigned" DataField="IsAssigned" Visible ="false" HtmlEncode="false" ReadOnly="false" ItemStyle-HorizontalAlign="Center"></asp:BoundField>--%>  
                        <asp:BoundField HeaderText="LastAccessed" DataField="LastAccessed" Visible ="false" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>
                        <asp:BoundField HeaderText="DataComplete" DataField="DataComplete" Visible ="false" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>

                        <asp:TemplateField HeaderText="Assigned?" HeaderStyle-HorizontalAlign="Center" >
                            <ItemTemplate>
                                <asp:CheckBox ID="chkAssigned" Runat="server" style="font-weight: bold; margin-left:40%;" AutoPostBack="true"  OnCheckedChanged="ButtonEdit_Click" Checked='<%# Bind("IsAssigned") %>'  />                                  
                            </ItemTemplate>
                            </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left"/>
                    <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left"/>
                </asp:GridView>
            </div>
        </div>
 
       <%-- <div class="col-xs-2 col-sm-2 col-md-4">
            <div id="divDependents" runat="server">
                <div class="row">                    
                    <div class="col-xs-2 col-sm-2 col-md-4">
                        <h4>Relationships</h4>
                        <img src="images/default_deps.png" width="60" alt="" />
                        
                    </div>

                    <div class="col-xs-2 col-sm-2 col-md-4 ">
                        <asp:GridView ID="grdDependents" runat="server" DataKeyField="DepBenId" AutoGenerateColumns="false" Width="65%" HeaderStyle-CssClass="grdNormalrow" EmptyDataRowStyle-CssClass="grdNormalrow" GridLines="None" BorderColor="#3276B1">
                            <Columns>
                                <asp:BoundField DataField="DepBenId" Visible="false"></asp:BoundField>
                                <asp:BoundField DataField="DependentName" Visible="true"></asp:BoundField>
                                <asp:BoundField DataField="Relationship" Visible="true"></asp:BoundField>
                            </Columns>
                            <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                            <EmptyDataTemplate>
                                No Dependents/Beneficiaries on record
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <br />
                        <asp:ImageButton ID="btnEditDeps" runat="server" ImageUrl="img/BlueEditBtn.png" OnMouseOver="src='/img/BlueEditBtnOver.png';" OnMouseOut="src='/img/BlueEditBtn.png';" ImageAlign="AbsMiddle" PostBackUrl="~/EE_DepBen.aspx" />
                    </div>
                </div>
            </div>
        </div>
       --%> 

        
            
    <!--  EMPLOYEE NOTES MODAL -->
    <div class="modal fade" id="ModalEmployeeNotes" tabindex="-1" role="dialog" aria-labelledby="myModalEmpNotes" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title text-success" id="myModalInfoLabel">
                        <asp:Label ID="mlblInfoTitle" runat="server" Text="Employee Notes"></asp:Label></h4>
                </div>
                <div class="modal-body ">
                    <div class="well ">
                    <div class="form-group">
                        <asp:Label ID="mlblInfoText1" runat="server" class="col-md-12 " Text=""></asp:Label>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="mlblInfoText2" runat="server" class="col-md-12 "></asp:Label>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-12 col-sm-12 col-md-12">
                            <asp:ScriptManager ID="ScriptManager1" runat="server" />
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" EnableViewState="true" UpdateMode="Always">
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="grdEmployeeNotes" EventName="SelectedIndexChanged" />
                                    <asp:PostBackTrigger ControlID="mtxtNewComment" />

                                </Triggers>
                                <ContentTemplate>
                                    <div class="form-group">
                                        <div class="col-xs-12 col-md-2 col-lg-2 control-label">
                                            <asp:Label ID="mlblAddNew" runat="server" Visible="false" Text="Note:" />
                                            <asp:Label ID="mlblHiddenNoteId" runat="server" Visible="false" />
                                        </div>
                                        <div class="col-xs-12 col-md-10 col-lg-10">
                                            <asp:TextBox ID="mtxtNewComment" runat="server" CssClass="form-control" TabIndex="1" placeholder="Additional Comment" TextMode="MultiLine" Width="90%" Height="15%" MaxLength="5000" Visible="false"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-xs-4 col-sm-4 col-md-2 pull-right">

                                            <asp:ImageButton ID="mbtnAdd" ImageAlign="right" ImageUrl="../img/BlueAddBtnNew.png" runat="server" OnMouseOver="src='/img/BlueAddBtnOver2.png';" OnMouseOut="src='/img/BlueAddBtnNew.png';" CausesValidation="False" />

                                            <asp:ImageButton ID="mbtnSave" ImageAlign="right" ImageUrl="../img/GreenSaveBtn.png" runat="server" OnMouseOver="src='/img/GreenSaveBtnOver.png';" OnMouseOut="src='/img/GreenSaveBtn.png';" CausesValidation="False" Visible="false" />
                                        </div>
                                    </div>

                                    <asp:GridView ID="grdEmployeeNotes"
                                        runat="server"
                                        DataKeyNames="EmployeeNoteId, EmployeeId" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                                        GridLines="None" BorderColor="#3276B1"
                                        CellPadding="4"
                                        ShowFooter="true"
                                        EmptyDataText="No Notes for Employee found."
                                        AlternatingRowStyle-CssClass="grdNormalAltrow"
                                        EnableViewState="true">
                                        <%--  OnSelectedIndexChanged ="OnSelectedIndexChanged"--%>
                                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                        <Columns>
                                            <asp:BoundField HeaderText="EmployeeNoteId" DataField="EmployeeNoteId" Visible="False" />
                                            <asp:BoundField HeaderText="EmployeeId " DataField="EmployeeId" Visible="False" />
                                            <asp:BoundField HeaderText="Comment" DataField="Note" ItemStyle-Width="70%" Visible="True" />
                                            <asp:BoundField HeaderText="Admin" DataField="AdminName" Visible="True" ItemStyle-Width="20%" />
                                            <asp:BoundField HeaderText="Date" DataField="CreateDate" Visible="True" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:Button ID="ButtonEdit" runat="server" CssClass="btn-primary" Text="Edit" OnClick="ButtonEdit_Click" CausesValidation="false" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                                    </asp:GridView>
                                    <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label ID="mlblInfoText3" runat="server" class="col-md-12"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <asp:ImageButton ID="mbtnClose" data-dismiss="modal" ImageUrl="../img/GreenCloseBtn.png" runat="server" OnMouseOver="src='/img/GreenCloseBtnOver.png';" OnMouseOut="src='/img/GreenCloseBtn.png';"></asp:ImageButton>
            </div>
        </div>
    </div>
</div>
     
    <%--Registration Modal--%>
        <%--<div class="modal fade" id="ModalRegistration" tabindex="-1" role="dialog" aria-labelledby="myModalRegistrationLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title text-success" id="myModalRegistrationLabel">
                            <asp:Label ID="mlblRegistrationTitle" runat="server" Text="Info Modal"></asp:Label></h4>
                    </div>
                    <div class="modal-body ">
                        <div class="right">
                          <asp:ImageButton ID='btnPrint' runat='server' ImageUrl='../img/printer.jpg' BorderStyle='None' Height='40px' ToolTip ="Click for printer friendly version" />
                        </div>
                        <div class="well ">
                            <div class="form-group">
                                <asp:Label ID="mlblEmployeeName" runat="server" class=" col-md-12 "></asp:Label>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="mlblCompanyName" runat="server" class="col-md-12 "></asp:Label><br />
                                <br />
                            </div>

                            <div class="form-group">
                                <asp:Label ID="mlblRegistrationText1" runat="server" class="col-md-12 "></asp:Label>
                               
                            </div>
                            <div class="form-group">
                                <label class="col-xs-4 col-sm-4  col-md-3 col-lg-3  control-label">Registration Key:</label>
                                 <asp:Label ID="mlblRegistrationKey" runat="server" class="col-md-8 "></asp:Label><br />
                            </div>

                            <div class="form-group">
                                <label class="col-xs-4 col-sm-4  col-md-3 col-lg-3 control-label">Client URL: </label>
                                <asp:Label ID="mlblClientURL" runat="server" class="col-md-8 "></asp:Label><br />
                            </div>

                            <div class="form-group">
                                <asp:Label ID="mlblRegistrationText2" runat="server" class="col-md-12 "></asp:Label>
                            </div>
                            <div class="form-group">
                                <asp:Label ID="mlblRegistrationText3" runat="server" class="col-md-12"></asp:Label>
                            </div>
                        </div>--%>
                        <%--modalbodycontainer--%>
                    <%--</div>
                    <div class="modal-footer">--%>
                        <%--<asp:ImageButton ID="mbtnRegistrationAcknowledge" ImageUrl="../img/GreenAcknowledgeBtn.png" runat="server" OnMouseOver="src='/img/GreenAcknowledgeOver.png';" OnMouseOut="src='/img/GreenAcknowledgeBtn.png';" Width="125px"></asp:ImageButton>--%>
                        <%--<asp:ImageButton ID="mbtnRegistrationCancel" ImageUrl="../img/GreenCloseBtn.png" runat="server" OnMouseOver="src='/img/GreenCloseBtnOver.png';" OnMouseOut="src='/img/GreenCloseBtn.png';"></asp:ImageButton>--%>

                    <%--</div>
                </div>
            </div>
        </div>--%>
         <%--<div class="form-group  hidden-print">
                     <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 right">--%>
                         <%--<asp:Button ID="btnPrint" runat="server" Text=" Print This Page " CssClass="btn-success" Width="110px" />--%>
                         <%--<asp:ImageButton ID="btnHistory" runat="server" CssClass="hidden-print" ImageUrl="../img/history.png" background="#fff" BackColor="White" BorderStyle="None" Visible="true" Height='40px' data-toggle='modal' data-target='#ModalBenefitSummary' ToolTip="Click for complete election history" OnClientClick="return false" />
                         <asp:ImageButton ID='ImageButton1' runat='server' CssClass="hidden-print" ImageUrl='../img/printer.jpg' BorderStyle='None' Height='40px' ToolTip="Click for printer friendly version" />
                     </div>
                 </div>--%>
</div>
</asp:Content>

