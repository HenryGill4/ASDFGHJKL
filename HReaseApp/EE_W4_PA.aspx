<%@ Page Title="PA State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_PA.aspx.vb" 
    Inherits="HReaseApp.EE_W4_PA" 
    MaintainScrollPositionOnPostback="true" %>


<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" runat="Server">
    <div id="tabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>
    </div>
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" runat="Server">
    <style>
        input[type="text"] {		
        background: #EFF3FB;
        border: 0px;
        padding-left:5px;
        margin: 1px 1px 1px 1px;
        height:30px;
        text-align:left;
		}

        table {
            background-color:white;
        }
                  
        .wrapper {
	    margin-right:10%;
	    overflow:hidden;
        padding:20px;
        }
    </style>

    <div class="HREwrapper">
        <div class="form-group" style="height:100px;">       
            <div style="float:left;">
                <br />
                <h4><asp:Label ID="lblEmployeeName" runat="server"></asp:Label></h4> 
            </div>
            <div id="divError" class="form-group alert alert-danger text-center text-danger divError" runat="server" visible="false">
                <div style="font-size:large; text-align:center;">
                    <asp:Image ID="Image1" ImageUrl="../img/RedX.png" runat="server" style="width:90px" border="none" /> 
                    <br/>
                    <h4>ERROR:
                    <asp:Label ID="lblError" runat="server" Text="There was an error.<br/>"></asp:Label></h4>
                </div>
            </div>
            <div id="divSuccess" runat="server" class="col-md-12 text-center"  visible ="false">
                <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" cssclass=" img" />
                <h3><br /><b><span style="color: green">
                <asp:Label ID="lblSuccess" runat="server" Text="Pennsylvania Residency Certification Form Complete.<br/>"></asp:Label>
                </span></b></h3>
            </div>
            <%-- next arrow full screen --%>
            <div style="float:right; padding-right:2%;">
                <div class="fixed hidden-xs">
                    <asp:ImageButton ID="imgNext" runat="server" ImageUrl="../img/NextArrowInCircleBlueGreen.png" Width="50%" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click"/>
                </div>
            </div>
         
        </div>

        <%-- next arrow mobile screen --%>
        <div class="col-xs-3 col-sm-3 hidden-lg hidden-md pull-right right" style="padding-right:30%;">
            <asp:ImageButton ID="imgNextMobile" runat="server" ImageUrl="../img/NextArrowInCircleBlueGreen.png" Width="150px" Height="150px" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
        </div>

        <span><b>CLGS-32-6(05/17)</b></span>

		<div class="row" style="margin-top:10px;">
			<div class="col-md-3" style="">
				<img src="images/PA_State_Logo.png" height="50" width="50" />
			</div>
			<div class="col-md-6 text-center">
				<div style="margin-bottom: 10px;">
                    <b style="font-size: 30px;">RESIDENCY CERTIFICATION FORM </b>
				</div>
				<div>
                    <b style="font-size: 30px;">Local Earned Income Tax Withholding</b>
				</div>
			</div>
			<div class="col-md-3">
			</div>
			<div class="col-md-12">
				<hr style="border: 1px solid black; margin-bottom: 3px; margin-top: 15px;" />
				<hr style="border: 1px solid black; margin-bottom: 3px; margin-top: 5px;" />
			</div>
		</div>

        <div class="row text-center">
            <p style="margin:0;padding:15px;">
                <b style="font-size: 16px; display: block;">TO EMPLOYERS/TAXPAYERS:</b>
                <span>This form is to be used by employers and/or taxpayers to report essential information for the collection and distribution of Local Earned Income Taxes
				to the local EIT collector. This form must be utilized by employers when a new employee is hired or when a current employee notifies employer
				of a name and/or address change. Use the Address Search Application at www.newPA.com/Act32 to determine PSD codes, EIT rates and
				tax collector contact information.</span>
			</p>
		</div>
	
	    <div id="divEmployeeInfo" class="row" style="margin-bottom:40px;">
            <table style="border:2px solid black;">
			    <tr>
				    <td colspan="20" style="background: black;">
					    <p style="color: #fff; margin-bottom: 0px; text-align:center; font-weight:bold;">
                            EMPLOYEE INFORMATION – RESIDENCE LOCATION</p>
				    </td>
			    </tr>
			    <tr>
				    <td colspan="14" style="border-left:1px solid black; border-top: 1px solid black; padding-left:5px;">
					    NAME (Last Name, First Name, Middle Initial) 
					</td>
				    <td colspan="6" style="border-left:1px solid black; border-top: 1px solid black; border-right: 2px solid black; padding-left:5px;">
					    SOCIAL SECURITY NUMBER
				    </td>
			    </tr>
                <tr>
                    <td colspan="14" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px;">
                        <b><asp:Label ID="lblLastFirstMiddle" runat="server"/></b>
                    </td>
                    <td colspan="4" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; border-right: 2px solid black; height:30px; padding-left:10px;">
                           <b><asp:Label ID="lblSSNumber" runat="server"/></b>
                    </td>
                </tr>
			    <tr>
				    <td colspan="20" style="border-left:1px solid black; border-top: 1px solid black; border-right: 1px solid black; padding-left:5px;">
					    STREET ADDRESS <b>(No PO Box, RD or RR)</b>
				    </td>
			    </tr>
                <tr>
                    <td colspan="20" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px;" >
                        <b><asp:Label ID="lblAddress1" runat="server" /></b>
                     </td>
			    </tr>
			    <tr>
				    <td colspan="20" style="border-left:1px solid black; border-top: 1px solid black; border-right: 1px solid black; padding-left:5px;">
					    ADDRESS LINE 2					
				    </td>
			    </tr>
                <tr>
                    <td colspan="20" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; border-right: 1px solid black; height:30px; padding-left:10px;" >
                        <b><asp:Label ID="lblAddress2" runat="server" /></b>
                     </td>
			    </tr>
			    <tr>
				    <td colspan="8" style="border-left:1px solid black; border-top: 1px solid black; padding-left:5px;">
					    CITY
				    </td>
				    <td colspan="3" style="border-left:1px solid black; border-top: 1px solid black; padding-left:5px;">
					    STATE
				    </td>
				    <td colspan="4" style="border-left:1px solid black; border-top: 1px solid black; padding-left:5px;">
				        ZIP
                    </td>
				    <td colspan="5" style="border-left:1px solid black; border-top: 1px solid black; border-right: 1px solid black; padding-left:5px;">
					    <div class="input-label">DAYTIME PHONE NUMBER</div>
				    </td>
			    </tr>
                <tr>
                    <td colspan="8" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px;" >
                        <b><asp:Label ID="lblCity" runat="server" /></b>
                    </td>
                    <td colspan="3" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px;" >
                        <b><asp:Label ID="lblState" runat="server" /></b>
                    </td>
                    <td colspan="4" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px;" >
                        <b><asp:Label ID="lblZipCode" runat="server" /></b>
                    </td>
                    <td colspan="5" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; border-right: 1px solid black; height:30px; padding-left:10px;" >
                        <b><asp:Label ID="lblMobilePhoneNo" runat="server" /></b>
                    </td>
			    </tr>
			    <tr>
				    <td colspan="20" style="border-left:1px solid black; border-top: 1px solid black; border-right: 1px solid black; padding-left:5px;">
					    MUNICIPALITY (City, Borough or Township)
				    </td>
			    </tr>
                <tr>
                    <td colspan="20" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:TextBox ID="txtMuncipality" runat="server" Width="100%" /></b>
                     </td>
			    </tr>
			    <tr>
                    <td colspan="9" style="border-left:1px solid black; border-top: 1px solid black; padding-left:5px;">
					    COUNTY
				    </td>
                    <td colspan="5" style="border-left:1px solid black; border-top: 1px solid black; padding-left:5px;">
					    RESIDENT PSD CODE
				    </td>
                    <td colspan="6" style="border-left:1px solid black; border-top: 1px solid black; border-right: 1px solid black; padding-left:5px;">
					    TOTAL RESIDENT EIT RATE
				    </td>
                </tr>
                <tr>
                    <td colspan="9" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:TextBox ID="txtCounty" runat="server" Width="100%"/></b>
                    </td>
                    <td colspan="5" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:TextBox ID="txtResidentPSDCode" runat="server" Width="100%"/></b>
                    </td>
			        <td colspan="5" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; border-right: 2px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:TextBox ID="txtResidentEITRate" runat="server" Width="100%"/></b>
                    </td>
	    	    </tr>
			
		    </table>
	
	    </div>
		
        <div id="divEmployerInfo" class="row" style="margin-bottom:40px;">
            <table style="border:2px solid black;">
			    <tr>
				    <td colspan="20" style="background: black;">
					    <p style="color: #fff; margin-bottom: 0px; text-align:center; font-weight:bold;">
                            EMPLOYER INFORMATION – EMPLOYMENT LOCATION</p>
				    </td>
			    </tr>
			    <tr>
				    <td colspan="14" style="border-left:1px solid black; border-top: 1px solid black; padding-left:5px;">
					    EMPLOYER BUSINESS NAME (Use Federal ID Name)
					    </td>
				    <td colspan="6" style="border-left:1px solid black; border-top: 1px solid black; border-right: 2px solid black; padding-left:5px;">
					    EMPLOYER FEIN
				    </td>
			    </tr>
                <tr>
                    <td colspan="14" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px;">
                        <b><asp:Label ID="lblEmployerName" runat="server"/></b>
                     </td>
                    <td colspan="4" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; border-right: 2px solid black; height:30px; padding-left:10px;">
                           <b><asp:Label ID="lblEmployerFEIN" runat="server"/></b>
                    </td>
                </tr>
			    <tr>
				    <td colspan="20" style="border-left:1px solid black; border-top: 1px solid black; border-right: 1px solid black; padding-left:5px;">
					    STREET ADDRESS WHERE ABOVE EMPLOYEE REPORTS TO WORK (No PO Box, RD or RR) 
				    </td>
			    </tr>
                <tr>
                    <td colspan="20" style="vertical-align:middle; text-align:left; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b style="text-align:left;"><asp:Textbox ID="txtEmployerAddress1" runat="server" Width="100%" /></b>
                     </td>
			    </tr>
			    <tr>
				    <td colspan="20" style="border-left:1px solid black; border-top: 1px solid black; border-right: 1px solid black; padding-left:5px;">
					    ADDRESS LINE 2					
				    </td>
			    </tr>
                <tr>
                    <td colspan="20" style="vertical-align:middle; text-align:left; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:Textbox ID="txtEmployerAddress2" runat="server" Width="100%" /></b>
                     </td>
			    </tr>
			    <tr>
				    <td colspan="8" style="border-left:1px solid black; border-top: 1px solid black; padding-left:5px;">
					    CITY
				    </td>
				    <td colspan="3" style="border-left:1px solid black; border-top: 1px solid black; padding-left:5px;">
					    STATE
				    </td>
				    <td colspan="4" style="border-left:1px solid black; border-top: 1px solid black; padding-left:5px;">
				        ZIP
                    </td>
				    <td colspan="5" style="border-left:1px solid black; border-top: 1px solid black; border-right: 1px solid black; padding-left:5px;">
					    <div class="input-label">PHONE NUMBER</div>
				    </td>
			    </tr>
                <tr>
                    <td colspan="8" style="vertical-align:middle; text-align:left; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:Textbox ID="txtEmployerCity" runat="server" Width="100%" /></b>
                    </td>
                    <td colspan="3" style="vertical-align:middle; text-align:left; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:Textbox ID="txtEmployerState" runat="server" Width="100%" /></b>
                    </td>
                    <td colspan="4" style="vertical-align:middle; text-align:left; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:Textbox ID="txtEmployerZipCode" runat="server" Width="100%" /></b>
                    </td>
                    <td colspan="5" style="vertical-align:middle; text-align:left; border-left:1px solid black; border-bottom: 1px solid black; border-right: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:Textbox ID="txtEmployerPhone" runat="server" Width="100%" /></b>
                    </td>
			    </tr>	
			    <tr>
				    <td colspan="20" style="border-left:1px solid black; border-top: 1px solid black; border-right: 1px solid black; padding-left:5px;">
					    MUNICIPALITY (City, Borough or Township)
				    </td>
			    </tr>
                <tr>
                    <td colspan="20" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:TextBox ID="txtEmployerMuncipal" runat="server" Width="100%" /></b>
                     </td>
			    </tr>
			    <tr>
                    <td colspan="9" style="border-left:1px solid black; border-top: 1px solid black; padding-left:5px;">
					    COUNTY
				    </td>
                    <td colspan="5" style="border-left:1px solid black; border-top: 1px solid black; padding-left:5px;">
					    WORK LOCATION PSD CODE
				    </td>
                    <td colspan="6" style="border-left:1px solid black; border-top: 1px solid black; border-right: 1px solid black; padding-left:5px;">
					    WORK LOCATION NON-RESIDENT EIT RATE
				    </td>
                </tr>
                <tr>
                    <td colspan="9" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:TextBox ID="txtERCounty" runat="server" Width="100%"/></b>
                    </td>
                    <td colspan="5" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:TextBox ID="txtEmployerLocationPSDCode" runat="server" Width="100%"/></b>
                    </td>
			        <td colspan="5" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; border-right: 2px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:TextBox ID="txtEmployerWLNonResEITRate" runat="server" Width="100%"/></b>
                    </td>
	    	    </tr>
			
		    </table>
        </div>
       
        <div id="divCertification" class="row" style="margin-bottom:40px;">
            <table style="border:2px solid black;">
			    <tr>
				    <td colspan="20" style="background: black;">
					    <p style="color: #fff; margin-bottom: 0px; text-align:center; font-weight:bold;">
                            CERTIFICATION
					    </p>
				    </td>
			    </tr>
                <tr>
                    <td colspan="20" style="vertical-align:middle; text-align:center; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:40px; padding-right:40px;">
                        Under penalties of perjury, I (we) declare that I (we) have examined this information, including all accompanying
                        schedules and statements and to the best of my (our) belief, they are true, correct and complete.
                    </td>
			    </tr>
                <tr>
                    <td colspan="15" style="border-left:1px solid black; border-top: 1px solid black; padding-left:5px;">
                        SIGNATURE OF EMPLOYEE
                    </td>
                    <td colspan="5" style="border-left:1px solid black; border-top: 1px solid black; border-right: 1px solid black; padding-left:5px;">
                        DATE (MM/DD/YYYY)
                    </td>
			    </tr>
                <tr>
                    <td colspan="15" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:TextBox ID="txtSignature" runat="server" Width="100%"/></b>
                    </td>
                    <td colspan="5" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:TextBox ID="SignatureDate" runat="server" Width="100%"/></b>
                    </td>
	    	    </tr>
                <tr>
                    <td colspan="10" style="border-left:1px solid black; border-top: 1px solid black; padding-left:5px;">
                        PHONE NUMBER
                    </td>
                    <td colspan="10" style="border-left:1px solid black; border-top: 1px solid black; border-right: 1px solid black; padding-left:5px;">
                        EMAIL ADDRESS
                    </td>
			    </tr>
                <tr>
                    <td colspan="10" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:TextBox ID="txtEEPhone" runat="server" Width="100%"/></b>
                    </td>
                    <td colspan="10" style="vertical-align:middle; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px; padding-right:10px;" >
                        <b><asp:TextBox ID="txtEmail" runat="server" Width="100%"/></b>
                    </td>
	    	    </tr>
                <tr>
                    <td colspan="20" style="vertical-align:middle; text-align:center; border-left:1px solid black; border-bottom: 1px solid black; height:30px; padding-left:10px;">
                        For information on obtaining the appropriate MUNICIPALITY (City, Borough, Township), PSD CODES and EIT (Earned Income Tax) RATES,
                        please refer to the Pennsylvania Department of Community & Economic Development website:
                        <br/><br />
                        <a href="https://dced.pa.gov/Act32"><h4><b>dced.pa.gov/Act32</b></h4></a>
                    </td>
			    </tr>
            </table>
        </div>
		
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" OnClick="btnSave_Click" />
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
