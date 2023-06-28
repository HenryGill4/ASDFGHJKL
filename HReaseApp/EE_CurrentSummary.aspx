<%@ Page Title="EE Current Benefits Summary" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_CurrentSummary.aspx.vb" 
    Inherits="HReaseApp.EE_CurrentSummary" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
    <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" Runat="Server">

    <style>
        .wrapper {
               width:100%;
		        margin:0 auto;
		        overflow:hidden;
                padding:20px;
            }
    </style>

     <div class = "HREWrapper" >
         <div class="form-group">
             <div style="float:left;">
                <br />
                <h4><asp:Label ID="lblEmployeeName" runat="server"></asp:Label></h4> 
             </div>
                
            <%-- next arrow full screen --%>
            <div style="float:right; padding-right:10%;">
                    <div class="fixed hidden-xs">
                        <asp:ImageButton ID="imgNext" runat="server" ImageUrl="../img/NextArrowInCircleBlueGreen.png" Width="50%" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click"/>
                    </div>
                </div>
                <%-- next arrow mobile screen --%>
                <div class="col-xs-3 col-sm-3 hidden-lg hidden-md pull-right right" style="padding-right:30%;">
                    <asp:ImageButton ID="imgNextMobile" runat="server" ImageUrl="../img/NextArrowInCircleBlueGreen.png" Width="150px" Height="150px" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                </div>

         </div>

         <div class=" form-group">
             <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 ">
                 <asp:ValidationSummary HeaderText="<h4>ERROR:</h4>" DisplayMode="SingleParagraph" EnableClientScript="true" runat="server" CssClass="alert alert-danger text-danger text-center" ValidationGroup="valSearch" />
                 <div id="divError" class='alert alert-danger text-center text-danger' runat="server" visible="false">
                     <h4>
                         <asp:Label ID="lblError" runat="server"></asp:Label></h4>
                 </div>
             </div>
         </div>

         <div class=" form-group">
             <label for="txtSearchDate" class="col-xs-4 col-sm-4 col-md-4 control-label right">As of Date:</label>

             <div class="col-xs-3 col-sm-3 col-md-3  col-lg-2 ">
                 <asp:TextBox ID="txtSearchDate" runat="server" CssClass="form-control" TabIndex="1" placeholder="mm/dd/yyyy"></asp:TextBox>
                 <asp:CompareValidator ID="cmvalSearch" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtSearchDate" ErrorMessage="<h4>Search Date is not formated correctly <i>mm/dd/yyyy</i></h4>" Display="None" ValidationGroup="valSearch"></asp:CompareValidator>
             </div>
             <div class="col-xs-2 col-sm-2 col-md-2  ">
                 <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="../img/GreenRefreshBtn.png" OnMouseOver="src='/img/GreenRefreshBtnOver.png';" OnMouseOut="src='/img/GreenRefreshBtn.png';" ValidationGroup="valSearch" />
             </div>
         </div>

         <div id="divSummary">

             <div class="form-group" style="margin-right:6%;">
                 <div class="col-md-9 col-lg-9 big">

                     <b>
                     <asp:Label ID="lblFullEmployeeName" runat="server"></asp:Label></b><br />
                     <asp:Label ID="lblAddress" runat="server"></asp:Label><br />
                     <asp:Label ID="lblCity" runat="server" class=" control-label"></asp:Label>
                     <asp:Label ID="lblState" runat="server" class=" control-label"></asp:Label>
                     &nbsp<asp:Label ID="lblZip" runat="server" class=" control-label  "></asp:Label>&nbsp
                 </div>
                 <%-- </div>
             <div class="form-group">--%>
                 <div class="col-xs-6 col-sm-6 col-md-6 col-md-6 text-muted  ">
                     <br />
                     <asp:Label ID="lblPayFrequency" runat="server" Text="No Current Benefits"></asp:Label>
                 </div>
                 <div class="form-group  hidden-print">
                     <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 right">
                         <%--<asp:Button ID="btnPrint" runat="server" Text=" Print This Page " CssClass="btn-success" Width="110px" />--%>
                         <asp:ImageButton ID="btnHistory" runat="server" CssClass="hidden-print" ImageUrl="../img/history.png" background="#fff" BackColor="White" BorderStyle="None" Visible="true" Height='40px' data-toggle='modal' data-target='#ModalBenefitSummary' ToolTip="Click for complete election history" OnClientClick="return false" />
                         <asp:ImageButton ID='btnPrint' runat='server' CssClass="hidden-print" ImageUrl='../img/printer.jpg' BorderStyle='None' Height='40px' ToolTip="Click for printer friendly version" />
                     </div>
                 </div>

                 <%-- <div class="form-group">--%>
                 <%-- <div class="col-xs-12 col-sm-12 col-md-12  ">--%>
                 <%-- <div id="divSummaryTable" >--%>
                 <asp:Table ID="tblSummary" runat="server" CssClass="table" ViewStateMode="Disabled">
                 </asp:Table>
                 <%--</div>--%>
                 <%-- </div>--%>
             </div>
         </div>

         <%--  Add Employee Benefit Summary Modal--%>
               <div class="modal fade container-fluid" id="ModalBenefitSummary" tabindex="-1" role="dialog" aria-labelledby="myModalBenSum" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                               <%-- <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span>
                                   <span class="sr-only">Close</span></button>
                               --%> 
                                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close Modal</span></button>
                               
                                <h4 class="modal-title text-success" >
                                    <asp:Label ID="mlblBenSumTitle" runat="server" Text="Benefit Summary"></asp:Label></h4>
                               
                            </div>
                            <div class="modal-body ">
                             <%--   <div class=" well">--%>
                                     <div class="pull-right hidden-print">
                                        <asp:ImageButton ID='btnPrintHistory' runat='server' ImageUrl='../img/printer.jpg' BorderStyle='None' Height='40px' ToolTip ="Click for printer friendly version" />
                                    </div>
                                     
                                    <div class="form-group">
                                        <div class="col-xs-6 col-sm-6 col-md-6 col-md-6 text-muted  ">
                                            <br />
                                            <asp:Label ID="lblPayFrequencyModal" runat="server" Text="No Current Benefits"></asp:Label>
                                        </div>


                                        <div class="col-xs-12 col-sm-12 col-md-12">
                                          <asp:Table ID="tblHistory" runat="server" CssClass="table" ViewStateMode="Disabled"></asp:Table>
                                         </div>
                                    </div> 
                                  <%-- </div> --%>                             
                            </div>
                            <div class="modal-footer">
                                <asp:ImageButton ID="mbtnBenSumClose" data-dismiss="modal" ImageUrl="../img/GreenCloseBtn.png" runat="server" OnMouseOver="src='/img/GreenCloseBtnOver.png';" OnMouseOut="src='/img/GreenCloseBtn.png';" TabIndex="-1"></asp:ImageButton>
                            </div>
                        </div>
                    </div>
                </div>

    </div>

     <%--  Add Employee Notes Modal--%>
     <%-- <asp:AsyncPostBackTrigger ControlID="grdEmployeeNotes" EventName="SelectedIndexChanged" />
     <asp:PostBackTrigger ControlID="mtxtNewComment" />--%>
    <asp:ScriptManager ID="ScriptManager1" runat="server"  />
               <div class="modal fade container-fluid" id="ModalEmployeeNotes" tabindex="-1" role="dialog" aria-labelledby="myModalEmpNotes" aria-hidden="true" style="margin-right:5%;">
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
                                         
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" EnableViewState="true" UpdateMode="Conditional" >
                                                <Triggers>
                                                 

                                               </Triggers>
                                                <ContentTemplate>
                                                    <div class="form-group">
                                                        <div class="col-xs-12 col-md-2 col-lg-2 control-label">
                                                            <asp:Label ID="mlblAddNew" runat="server" Visible="false" Text="Note:" />
                                                            <asp:Label ID="mlblHiddenNoteId" runat="server" Visible="false" />
                                                        </div>
                                                        <div class="col-xs-12 col-md-10 col-lg-10">
                                                            <asp:TextBox ID="mtxtNewComment" runat="server" CssClass="form-control" TabIndex="-1" placeholder="Additional Comment" TextMode="MultiLine" Width="90%" Height="15%" MaxLength="5000" Visible="false"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        
                                                        <div class="col-xs-4 col-sm-4 col-md-2 pull-right">

                                                            <asp:ImageButton ID="mbtnAdd" ImageAlign="right" ImageUrl="../img/BlueAddBtnNew.png" runat="server" OnMouseOver="src='/img/BlueAddBtnOver2.png';" OnMouseOut="src='/img/BlueAddBtnNew.png';" CausesValidation="False" TabIndex="-1"/>

                                                            <asp:ImageButton ID="mbtnSave" ImageAlign="right" ImageUrl="../img/GreenSaveBtn.png" runat="server" OnMouseOver="src='/img/GreenSaveBtnOver.png';" OnMouseOut="src='/img/GreenSaveBtn.png';" CausesValidation="False" Visible="false" TabIndex="-1" />
                                                        </div>
                                                    </div>

                                                    <asp:GridView ID="grdEmployeeNotes"
                                                        runat="server"
                                                        DataKeyNames="EmployeeNoteId, EmployeeId" AutoGenerateColumns="False" Width="100%" HorizontalAlign="Center"
                                                        GridLines="None" BorderColor="#3276B1"
                                                        CellPadding="4"
                                                        EmptyDataText="No Notes for Employee found."
                                                        AlternatingRowStyle-CssClass="grdNormalAltrow"
                                                        EnableViewState="true">
                                                       
                                                        <AlternatingRowStyle CssClass="grdNormalAltrow"></AlternatingRowStyle>
                                                        <Columns>
                                                            <asp:BoundField HeaderText="EmployeeNoteId" DataField="EmployeeNoteId" Visible="False" />
                                                            <asp:BoundField HeaderText="EmployeeId " DataField="EmployeeId" Visible="False" />
                                                            <asp:BoundField HeaderText="Comment" DataField="Note" ItemStyle-Width="70%" Visible="True" />
                                                            <asp:BoundField HeaderText="Admin" DataField="AdminName" Visible="True" ItemStyle-Width="20%" />
                                                            <asp:BoundField HeaderText="Date" DataField="CreateDate" Visible="True" />
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Button ID="ButtonEdit" runat="server" CssClass="btn-primary" Text="Edit" OnClick="ButtonEdit_Click" CausesValidation="false" TabIndex="-1" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                                                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Left" />
                                                    </asp:GridView>
                                                    <asp:LinkButton ID="LinkButton2" runat="server"></asp:LinkButton>
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
                                <asp:ImageButton ID="mbtnClose" data-dismiss="modal" ImageUrl="../img/GreenCloseBtn.png" runat="server" OnMouseOver="src='/img/GreenCloseBtnOver.png';" OnMouseOut="src='/img/GreenCloseBtn.png';" TabIndex="-1"></asp:ImageButton>
                            </div>
                        </div>
                    </div>
                </div>
    <style>
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
    </style>
</asp:Content>





