 <%@ Page Title="ACA Rules" 
     Language="vb" 
     AutoEventWireup="false" 
     MasterPageFile="~/AppMasterHeader.Master" 
     CodeBehind="Admin_CompanyACARules.aspx.vb" 
     Inherits="HReaseApp.Admin_CompanyACARules"
     MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
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
      <div class="HREwrapper">
        <div id="divPageTitle">
            <div >
                <br />
                <h4><b>Company ACA Rules</b></h4>
            </div>
        </div>

        <div id="divNextButton" runat="server" class="hidden-xs" style="float:right; display:inline; margin-top:-7px;">
            <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
            <asp:Image ID="Image1" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
        </div>

        <div id="divTopHeader" runat="server">   
           <div style="margin-left:20px;" id="div1" runat="server">   
            <div id="divCompanyList" runat="server" class="well HRESlateBlue HRERewrap form-inline">
                <span style="padding-left:10px; padding-right:10px; width:10%;">
                    Company:
                </span>

                <span style="min-width:300px!important; max-width:600px!important; width:50%!important;"> 
                    <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-control" DataValueField="CompanyId" DataTextField="CombinedCompanyName"  AutoPostBack="true" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged"></asp:DropDownList>
                

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
        </div>

        <div id="divCompanyName" runat="server" class="well" style="text-align:center; margin-right:5%;">
            <b><asp:Label ID="lblCompanyName" runat="server" Text="CompanyName"></asp:Label></b>
            <br /><br />
        </div>    

        <div id="divReviewACARules" class="well HRETan " runat="server">
            <div class="form-group ">
                <label for="lblMeasurementMethod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right ">Measurement Method: </label>
                <div class="col-xs-3 col-sm-3 col-md-1 col-lg-2 ">
                    <asp:Label ID="lblMeasurementMethod" runat="server" class="control-label"></asp:Label>
                </div>

                <label for="lblIntialPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right ">Initial Period: </label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblIntialPeriod" runat="server" class="control-label"></asp:Label>
                </div>
            </div>

            <div class="form-group ">
                <label for="lblMeasurementPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right ">Measurement Period: </label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblMeasurementPeriod" runat="server" class="control-label"></asp:Label>
                </div>

                <label for="lblStabilityPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">Stability Period:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblStabilityPeriod" runat="server" class="control-label"></asp:Label>
                </div>                     
            </div>

            <div class="form-group ">
                <label for="lblPeriodBegin" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right ">Measurement Period Begin: </label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblPeriodBegin" runat="server" class="control-label"></asp:Label>
                </div>

                <label for="lblAdmistrativePeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">Admistrative Period:</label>
                <div class="col-xs-3 col-sm-3 col-md-4 col-lg-4 ">
                    <asp:Label ID="lblAdmistrativePeriod" runat="server" class="control-label"></asp:Label>
                </div>  
            </div>

            <div class="form-group ">
                <label for="lblPeriodEnd" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right ">Measurement Period End: </label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblPeriodEnd" runat="server" class="control-label"></asp:Label>
                </div>

                <label for="lblFirstPayrollAvailable" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">First Payroll Available:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblFirstPayrollAvailable" runat="server" class="control-label"></asp:Label>
                </div>  
            </div>

            <div class="form-group">
                <label for="lblLastIRSReportDate" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">Last IRS Report:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblLastIRSReportDate" runat="server" class="control-label"></asp:Label>
                </div>    

                <label for="lblMostRecentPayroll" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">Most Recent Payroll Available:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblMostRecentPayroll" runat="server" class="control-label"></asp:Label>
                </div> 
            </div>

            <div class="form-group">
                <label for="lblNextIRSReport" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">Next IRS Report:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblNextIRSReport" runat="server" class="control-label"></asp:Label>
                </div>  
                    
                <label for="lblLastALECountBegin" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right ">ALE Count Begin Date: </label>
                    <div class="col-xs-3 col-sm-3 col-md-1 col-lg-1 ">
                        <asp:Label ID="lblLastALECountBegin" runat="server" class="control-label"></asp:Label>
                    </div>
            </div>

            <div class="form-group">
                <label for="lblLastALECount" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right">Last ALE Count:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:Label ID="lblLastALECount" runat="server" class="control-label"></asp:Label>
                </div>     
                  
                <label for="lblLastALECountEnd" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 right ">ALE Count End Date: </label>
                <div class="col-xs-3 col-sm-3 col-md-1 col-lg-1 ">
                    <asp:Label ID="lblLastALECountEnd" runat="server" class="control-label"></asp:Label>
                </div>
            </div>
                        
            <div class="form-group">              
                <div class=" col-lg-2  pull-right">
                    <asp:ImageButton ID="btnEditRules" runat="server" ImageUrl="img/GreenEditBtnNew.png" OnMouseOver="src='/img/GreenEditBtnOverNew.png';" OnMouseOut="src='/img/GreenEditBtnNew.png';" ImageAlign="AbsMiddle" OnClick="btnEditRules_Click" />
                </div>
            </div>

            <div id="divACACounts" runat="server"  >
            <div class="form-group">                    
                <table class="table table-bordered table-condensed" style="border:1px solid grey;">
                    <tr>
                        <td colspan ="12" class="text-center" style="color: navy;"> 
                            <strong>ALE Trend Monthly Average <br />
                                <span class="text-success">(# of Months)</span></strong></td>
                    </tr>
                    <tr>                        
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>1 </strong></td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>2 </strong></td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>3 </strong></td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>4 </strong></td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>5 </strong></td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>6 </strong></td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>7 </strong></td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>8 </strong></td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>9 </strong></td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>10 </strong></td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>11 </strong></td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center text-success"><strong>12 </strong></td>                       
                    </tr>
                    <tr>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                            <asp:Label ID="lblALETrend1MonthAve" runat="server" class="control-label text-center"></asp:Label>
                        </td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                            <asp:Label ID="lblALETrend2MonthAve" runat="server" class="control-label"></asp:Label>
                        </td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                            <asp:Label ID="lblALETrend3MonthAve" runat="server" class="control-label"></asp:Label>
                        </td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                            <asp:Label ID="lblALETrend4MonthAve" runat="server" class="control-label"></asp:Label>
                        </td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                            <asp:Label ID="lblALETrend5MonthAve" runat="server" class="control-label"></asp:Label>
                        </td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                            <asp:Label ID="lblALETrend6MonthAve" runat="server" class="control-label"></asp:Label>
                        </td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                            <asp:Label ID="lblALETrend7MonthAve" runat="server" class="control-label"></asp:Label>
                        </td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                            <asp:Label ID="lblALETrend8MonthAve" runat="server" class="control-label"></asp:Label>
                        </td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                            <asp:Label ID="lblALETrend9MonthAve" runat="server" class="control-label"></asp:Label>
                        </td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                            <asp:Label ID="lblALETrend10MonthAve" runat="server" class="control-label"></asp:Label>
                        </td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                            <asp:Label ID="lblALETrend11MonthAve" runat="server" class="text-center"></asp:Label>
                        </td>
                        <td class="col-xs-2 col-sm-1 col-md-1 col-lg-1 text-center">
                            <asp:Label ID="lblALETrend12MonthAve" runat="server" class="control-label"></asp:Label>
                        </td>
                    </tr>
 
            </table>
        </div>                
       
    </div>

        </div>
            
        
        <div id="divEdit" class="well HREWhite HRERewrap" runat="server">
            <div class="form-group">
                <label for="ddlMeasurementMethod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label">Measurement Method:</label>
                <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2">
                    <asp:DropDownList ID="ddlMeasurementMethod" runat="server" CssClass="form-control" DataValueField="ACAMethodTypeId" DataTextField="ShortDesc" TabIndex="1" ></asp:DropDownList>
                </div> 

                <label for="ddlIntialPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label" >Initial Period:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2">
                    <asp:DropDownList ID="ddlIntialPeriod" runat="server" CssClass="form-control" DataValueField="PeriodId" DataTextField="LongDesc" TabIndex="2"></asp:DropDownList>
                </div>  
            </div>

            <div class="form-group">
                <label for="ddlMeasurementPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label" >Measurement Period:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2">
                    <asp:DropDownList ID="ddlMeasurementPeriod" runat="server" CssClass="form-control" DataValueField="PeriodId" DataTextField="LongDesc" TabIndex="3"></asp:DropDownList>
                </div>
                
                <label for="ddlStabilityPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label" >Stability Period:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2">
                    <asp:DropDownList ID="ddlStabilityPeriod" runat="server" CssClass="form-control" DataValueField="PeriodId" DataTextField="LongDesc" TabIndex="4" ></asp:DropDownList>
                </div>
            </div>

            <div class="form-group ">             
                <label for="txtPeriodBegin" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label" >Measurement Period Begin:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:TextBox ID="txtPeriodBegin" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" Width="185" TabIndex="5"></asp:TextBox>
                </div>
                
                <label for="ddlAdminPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label" >Administrative Period:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2">
                    <asp:DropDownList ID="ddlAdminPeriod" runat="server" CssClass="form-control" DataValueField="PeriodId" DataTextField="LongDesc" TabIndex="6" ></asp:DropDownList>
                </div>
            </div>

            <div class="form-group ">
                <label for="txtPeriodEnd" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label" >Measurement Period End:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:TextBox ID="txtPeriodEnd" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" Width="185" TabIndex="7"></asp:TextBox>
                </div>
                
                <label for="txtFirstPayroll" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label" >First Payroll Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:TextBox ID="txtFirstPayroll" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" Width="185" TabIndex="8"></asp:TextBox>
                </div>
            </div>

            <div class="form-group ">
                 <label for="txtLastIRSReport" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label" >Last IRS Report Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:TextBox ID="txtLastIRSReport" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" Width="185" TabIndex="9"></asp:TextBox>
                </div>

                <label for="txtMostRecentPayroll" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label" >Most Recent Payroll Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:TextBox ID="txtMostRecentPayroll" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" Width="185" TabIndex="10"></asp:TextBox>
                </div>                
            </div>
              <div class="form-group ">
                 <label for="txtNextIRSReport" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label" >Next IRS Report Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:TextBox ID="txtNextIRSReport" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" Width="185" TabIndex="11"></asp:TextBox>
                </div>
                
                <label for="txtALECountBegin" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label" >ALE Count Begin Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:TextBox ID="txtALECountBegin" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" Width="185" TabIndex="12"></asp:TextBox>
                </div> 
            </div>

            <div class="form-group ">
                <label for="txtACAPeriod" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label ">Last ALE Count: </label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:TextBox ID="txtLastACACount" runat="server" CssClass="form-control" onfocus="(this.type='date')" Placeholder="mm/dd/yyyy" Width="185" TabIndex="13"></asp:TextBox>
                </div>

                <label for="txtALECountEnd" class="col-xs-3 col-sm-3 col-md-3 col-lg-3 control-label" >ALE Count End Date:</label>
                <div class="col-xs-3 col-sm-3 col-md-2 col-lg-2 ">
                    <asp:TextBox ID="txtALECountEnd" runat="server" CssClass="form-control" Width="185" TabIndex="14"></asp:TextBox>
                </div>                            
            </div>

            <div class="form-group">
                <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="img/GreenCancelBtnNew.png" OnMouseOver="src='/img/GreenCancelBtnOverNew.png';" OnMouseOut="src='/img/GreenCancelBtnNew.png';" ImageAlign="AbsMiddle" TabIndex="23" />
                </div>

                <div class="col-xs-5 col-sm-5 col-md-2 col-lg-2  pull-right">
                    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valRules" OnClick="btnSave_Click" />
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