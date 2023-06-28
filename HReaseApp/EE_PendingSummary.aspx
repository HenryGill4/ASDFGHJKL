<%@ Page Title="EE Pending Benefits Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_PendingSummary.aspx.vb" 
    Inherits="HReaseApp.EE_PendingSummary" %>


<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <div id ="divtopmenu">
        <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal> 
    </div>
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
    <div id="divtabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    

</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" runat="Server"> 
    <script type="text/javascript">
        function divPrint() {
        // Logic determines which div should be printed.
            $("#divtopmenu").addClass("hidden");
            $("#divtabs").addClass("hidden");
            $("#divFormHeader").addClass("hidden");
            $("#divSearchDate").addClass("hidden");
            $("#divActionBar").addClass("hidden");
            $("#divBenefitHeader").addClass("printable");
            $("#divSummary").addClass("printable");
        window.print();
        }
   
    </script>

    <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>Benefits Summary</b></h4>
            </div>
        </div>
        
        <div id="divTopHeader" class="form-group" style=" margin-top:-40px;">                  
            <div id="divError" runat="server" visible="false" class="HREError">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
            </div>
            <div class="form-group" style="display:inline;">
                <div id="divSuccess" runat="server" visible ="true" class="HRESuccess">
                    <asp:Image id="imgSuccess" Visible="false" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" ImageAlign="Left" />
                    <asp:Label ID="lblSuccess" runat="server" Visible="false" Text="Form Complete" Width="50%"></asp:Label>
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
                </div>
            </div>
        </div>     
         
        <div id="divMainArticalTitleandText" class="well HRERewrap">
            <div id="divTitle" runat="server" class="form-group HRESlateBlue">
                    <h4><asp:Label ID="lblMainArticleTitle" runat="server" Text=""></asp:Label></h4>           
            </div>
            <div id="divText" runat="server" class="form-group HREWhite" >
                    <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div>

        <div id="divBenefitHeader" class="center" style="border:none;">
            <div id="divSearchDate" style="display:inline;">
                 <label for="txtSearchDate" >Search As of Date:</label>
                 <asp:TextBox ID="txtSearchDate" runat="server" CssClass="center" onfocus="(this.type='date')" onblur="{this.type='text'}" Placeholder="mm/dd/yyyy" TabIndex="1" Width="180px" OnTextChanged="txtSearchDate_TextChanged" ></asp:TextBox>
                 <asp:CompareValidator ID="cmvalSearch" runat="server" Type="Date" Operator="DataTypeCheck" ControlToValidate="txtSearchDate" ErrorMessage="<h4>Search Date is not formated correctly <i>mm/dd/yyyy</i></h4>" Display="None" ValidationGroup="valSearch"></asp:CompareValidator>
                 <asp:ImageButton ID="btnSearch" runat="server" CssClass="SearchIcon" ImageUrl="../img/Search.png" Width="30px" ValidationGroup="valSearch"/>
            </div>
            <table style="background-color:white; margin-top:-10px; padding-right:30px;">
                <tr>
                    <td style="width:50%;"></td>
                    <td style="width:50%;"></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <b><asp:Label ID="lblFullEmployeeName" runat="server"></asp:Label></b>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">
                        <asp:Label ID="lblAddress" runat="server"></asp:Label>
                    </td>
                    <td colspan ="1" style="float:right; padding-right:10%;">
                        <asp:Label ID="lblPayFrequency" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan ="2">
                        <asp:Label ID="lblCity" runat="server"></asp:Label>
                        <asp:Label ID="lblState" runat="server"></asp:Label>
                        <asp:Label ID="lblZip" runat="server" ></asp:Label>
                    </td>
                </tr>
            </table>

        </div>

        <div id ="divActionBar">
            <br />
            <table style="background-color:white;">
                <tr>
                    <td style="width: 70px; background-color:#f5f5f0; color:navy; border: 1px solid grey; text-align:center;" >Current</td>
                    <td style="width: 70px; background-color:#FFF; color:red; border: 1px solid grey; text-align:center;" >Pending</td>
                    <td style="width: 70px; background-color:#FFF; color:Silver; border: 1px solid grey; text-align:center;" >None</td>
                    <td style="float:right; margin-right:6%;">
                        <asp:ImageButton ID="btnHistory" runat="server" CssClass="hidden-print" ImageUrl="../img/history.png" background="#fff" BackColor="White" BorderStyle="None" Visible="true" Height='40px' data-toggle='modal' data-target='#ModalBenefitSummary' ToolTip="Click for complete election history" OnClientClick="return false" />
                        <asp:ImageButton ID='btnPrint' runat='server' ImageUrl='../img/printer.jpg' BorderStyle='None' Height='40px' ToolTip="Print" />

                    </td>
                </tr>
            </table>
        </div>

        <div id="divSummary">
            <asp:Table ID="tblSummary" runat="server" CssClass="HRESummaryTable">
            </asp:Table>
            
        </div>

        <div id="divModals">
        <%--  Add Employee Notes Modal--%>
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
            <div class="modal fade" id="ModalEmployeeNotes" tabindex="-1" role="dialog" aria-labelledby="myModalEmpNotes" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h2 class="modal-title text-success" id="myModalInfoLabel">
                            <asp:Label ID="mlblInfoTitle" runat="server" Text="Employee Notes"></asp:Label></h2>
                        </div>
                    <div class="modal-body ">
                        <div class="container well ">
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

        <%--  Add Employee Benefit History Modal--%>
        <div class="modal fade container-fluid" id="ModalBenefitSummary" tabindex="-1" role="dialog" aria-labelledby="myModalBenSum" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close Modal</span></button>
                        <h4 class="modal-title text-success" >
                        <asp:Label ID="mlblBenSumTitle" runat="server" Text="Benefit Summary"></asp:Label></h4>
                               
                    </div>
                    <div class="modal-body ">
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
                    </div>
                    <div class="modal-footer">
                        <asp:ImageButton ID="mbtnBenSumClose" data-dismiss="modal" ImageUrl="../img/GreenCloseBtn.png" runat="server" OnMouseOver="src='/img/GreenCloseBtnOver.png';" OnMouseOut="src='/img/GreenCloseBtn.png';" TabIndex="-1"></asp:ImageButton>
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
        .HRENext {padding:15px 5px 5px 5px; float:right; min-width:50px; max-width:90px; }
        .img {display: inline-block; width: auto; height: auto;}
        .SearchIcon {vertical-align:bottom;}
        .HRETopBorder {border-top:2px solid gray; }
        .HRERightBorder {border-right:1px solid gray; }
        .HRESummaryTable{border-left:1px solid gray; border-right:1px solid gray; width:95%; background-color: white; }
        .HREPending {background-color: white; padding:10px 10px 10px 10px; color:red; }
        .HREExisting {background-color: #f5f5f0; padding:10px 10px 10px 10px; color:Navy; }
        .HRENone {background-color: white; padding:10px 10px 10px 10px; color:Silver; }
       
    </style>
</asp:Content>



