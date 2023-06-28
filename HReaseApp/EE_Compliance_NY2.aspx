<%@ Page Title="NY Salary Notice to Exempt Employees" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_Compliance_NY2.aspx.vb" 
    Inherits="HReaseApp.EE_Compliance_NY2"
    MaintainScrollPositionOnPostback="True"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
    <div id="tabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>      
    </div>    
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" runat="server">
    <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>New York Notice for Exempt Employees</b></h4>
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
         
        <div id="divMainArticalTitleandText" runat="server" class="well HRESlateBlue HRERewrap">
            <div id="divTitle" runat="server" class="form-group HRESlateBlue">
                    <h4><asp:Label ID="lblMainArticleTitle" runat="server" Text=""></asp:Label></h4>           
            </div>
            <div id="divText" runat="server" class="form-group HREWhite" >
                    <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div>

        <div id="NYComplianceForm1" runat="server">
            <div class="well HREWhite HRERewrap" style="color:black; font-size:medium;">
                <div id="formheader" class="row" style="margin-bottom: 20px;">
                    <div id="newyorklogo" style="float:left; width:10%;">
                        <img alt="newyorklogo" class="auto-style1" src="images/NY_State_Logo.png" />
                    </div>             
                    <div id="title" style="width:90%; float:none; padding-left:10%; text-align:center;">
                        <b>Notice and Acknowledgement of Pay Rate and Payday
                            <br />Under Section 195.1 of the New York State Labor Law
                            <br />Notice for Exempt Employees</b>     
                    </div> 
                </div>

                <div id="mainform" class="row" style=" width:100%;">
                    <div id="column1" style="float:left; width: 30%; padding-left:20px;">
                        <div style="padding:10px; border: 1px solid black;">
                            <div style="padding-bottom:10px; font-size:large;">
                                <b>1. Employer Information</b> 
                            </div>
                            <div style="padding-bottom:20px;">
                                Name:
                            </div>
                            <div style="padding-left:10px; padding-bottom:20px;" >
                                <b><asp:Label ID="lblCompanyName" runat="server" /></b>
                            </div>                
                            <div style="padding-bottom:20px;">
                                Doing Business As (DBA) Name(s):
                            </div>
                            <div  style="padding-left:10px; padding-bottom:20px;">
                                <b><asp:Label ID="lblDBA" runat="server" /></b>
                            </div>
                            <div style="padding-bottom:20px;">
                                FEIN (optional):
                            </div>
                            <div style="padding-left:10px; padding-bottom:20px;">
                                <b><asp:Label ID="lblFEIN" runat="server" rows="3" TextMod="Multiline" Style="vertical-align:top;" /></b>
                            </div>
                            <div style="padding-bottom:20px;">
                                Physical Address:
                            </div>
                            <div style="padding-left:10px; padding-bottom:20px;">
                                <b><asp:Label ID="lblCompanyAddress1" runat="server" /></b>
                                <br />
                                <b><asp:Label ID="lblCompanyCityStateZip" runat="server" /></b>
                            </div>
                            <div style="padding-bottom:20px;">
                                Mailing Address:
                            </div>
                            <div style="padding-left:10px; padding-bottom:20px;">
                                <b><asp:Label ID="lblMailingAdd" runat="server"  /></b>
                            </div>
                            <div style="padding-bottom:20px;">
                                Phone:
                            </div>
                            <div style="padding-left:10px; padding-bottom:20px;" >
                                <b><asp:Label ID="lblPhoneNumber" runat="server"  /></b>
                            </div>              
                        </div> 
                        <div style="padding:10px;">
                            <div style="padding-bottom:10px; font-size:large;">
                                <b>2. Notice given:</b>
                            </div>
                            <div style="padding-left:20px; color:black;">
                                <asp:CheckBox ID="chkProvidedAtHire" runat="server" Text="" Checked="true" Enabled="false" />
                                    &nbsp;At hiring
                                    <br />
                                <asp:CheckBox ID="chkProvidedAtChange" runat="server" Text="" Enabled="false"/>
                                    &nbsp;Before a change in pay rate(s), allowances claimed or payday
                             </div>
                        </div>
                    </div>
                    
                    <div id="column2" style="float:left; width:30%; padding-left:3%;">
                        <div style="padding:10px;">
                                <b>3. Employee’s pay rate(s): State if pay is based on an hourly, salary, day rate, piece rate, or other basis.</b>
                            <div style="padding:20px; ">
                                $<b class="text-underline" style="width:50px; padding-left:2px;">
                                    <asp:Label ID="lblEmployeePayRate" runat="server"/> 
                                &nbsp;annual salary</b>
                            </div>
                           <div>
                               Employers may not pay a non-hourly rate to
                                a non-exempt employee in the Hospitality
                                Industry, except for commissioned
                                salespeople.
                           </div>
                            <div class="form-group">
                                <b>4. Allowances taken: </b>
                                <div class="form-group" style="width:90%; padding-left:10%; float:left;">
                                    <div style="padding-bottom:3px;">
                                        <asp:CheckBox ID="chkNone" runat="server" />
                                        None
                                        <br />
                                    </div>
                                    <div style="padding-bottom:3px;">
                                        <asp:CheckBox ID="chkTips" runat="server" />
                                        &nbsp;Tips&nbsp;
                                        <asp:TextBox ID="txtTipsPerHour" runat="server" Width="60%" />
                                        &nbsp;per hour
                                        <br />  
                                    </div>
                                    <div style="padding-bottom:3px;">
                                        <asp:CheckBox ID="chkMeals" runat="server" />
                                        &nbsp;Meals&nbsp;
                                        <asp:TextBox ID="txtMealsPerMeal" runat="server" Width="60%" />
                                        &nbsp;per meal
                                        <br />
                                    </div>
                                    <div style="padding-bottom:3px;">
                                        <asp:CheckBox ID="chkLodging" runat="server" />
                                        &nbsp;Lodging&nbsp;
                                        <asp:TextBox ID="txtLodging" runat="server" Width="60%" />
                                        <br />
                                    </div>
                                    <div style="padding-bottom:3px;">
                                        <asp:CheckBox ID="chkOther" runat="server" />
                                        &nbsp;Other&nbsp;
                                        <asp:TextBox ID="txtOther" runat="server" Width="60%" />
                                    </div>
                                </div> 
                            </div>
                            <div class="form-group">
                                <b>5. Regular payday: </b>
                                    &nbsp;<asp:TextBox ID="txtPayday" runat="server" />
                            </div>      
                            <div class="form-group" >
                                <b>6. Pay is:</b>
                            </div>
                            <div class="form-group" style="text-align:left; padding-left:10%;">
                                <asp:CheckBox ID="chkWeekly" runat="server" Enabled="false" />
                                &nbsp;Weekly
                                <br />
                                <asp:CheckBox ID="chkBiweekly" runat="server" Enabled="false" />
                                &nbsp;Bi-Weekly
                                <br />
                                <asp:CheckBox ID="chkOther2" runat="server" Enabled="false" />
                                &nbsp;Other
                            </div>
                           <div class="form-group" style="text-align:left; padding-left:3%;">
                                <b>7. Overtime Pay Rate:</b>
                            </div>
                            <div class="form-group" style="text-align:left; padding-left:3%;">
                                1½ times their regular rate of pay for all
                                hours worked over 40 in a workweek, with
                                few exceptions. A limited number of
                                employees must only be paid overtime at
                                1½ times the minimum wage rate, or not at
                                all.
                             </div>
                            <div>
                                This employee is exempt from overtime
                                under the following exemption (optional):
                                <asp:Textbox ID="txtOvertime" runat="server" width="100%" Class="underline"/>
                            </div>                   
                        </div>
                    </div>

                    <div id="column3" style="float:right; width:30%; padding-right:2%;">
                        <div>
                            <b>8. Employee Acknowledgement:</b>
                            <br />On this day I have been notified of my pay rate, overtime rate (if eligible), allowances, and designated pay day on the date given below.  I told my employer what my primary language is.
                        </div>
                        <div>
                            <b>Check one:</b>
                            <br />
                                <asp:CheckBox ID="chkEnglish" runat="server" autopostback="true" OnCheckedChanged="chkEnglish_CheckedChanged"/>
                                &nbsp;I have been given this pay notice in English because it is my primary language. 
                        </div>
                        <div style="margin-bottom:20px;">
                            <asp:CheckBox ID="chkNotEnglish" runat="server" autopostback="true" OnCheckedChanged="chkNotEnglish_CheckedChanged"/>
                                &nbsp;My primary language is&nbsp;&nbsp;
                            <asp:TextBox ID="txtLanguage" runat="server" />
                                &nbsp;&nbsp;I have been given this pay notice in English only, because the Department of Labor does not yet offer a pay notice form in my primary language.
                        </div>
                        <div style="padding-left:2px;" class="underline" >
                                <b><asp:Label ID="lblEEName" runat="server"/></b>
                        </div>
                        <div style="margin-bottom:20px;">
                            Print Employee Name
                        </div>
                        <div style="padding-left:2px;" >
                            <asp:TextBox ID="txtSignature" runat="server" placeholder="Please enter name" Width="100%"/>
                        </div>
                        <div style="margin-bottom:20px;">
                            Employee Signature
                        </div>
                        <div style="padding-left:2px;" >
                            <asp:TextBox ID="txtSignatureDate" runat="server" Width="100%" />
                        </div>
                        <div style="margin-bottom:20px;">
                            Date
                        </div>
                        <div style="padding-left:2px;" >
                            <asp:TextBox ID="txtPreparer" runat="server" Width="100%" />
                        </div>
                        <div style="margin-bottom:20px;">
                            Preparer's Name and Title
                        </div>
                        <div>
                            <b>The employee must receive a signed copy of this form. The employer must keep the original for 6 years.</b>
                        </div>
                        <div>
                            <b>Please note:</b> It is unlawful for an employee to be paid less than an employee of the opposite sex for equal work. Employers also may not prohibit employees from discussing wages with their<br /> co-workers.  
                        </div>
                    </div>

                </div>

                <div id="savebutton" class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center">
                        <br /><br />
                        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" OnClick="btnSave_Click" />
                    </div>
                </div>

                <div id="formfooter">
                    LS 59 (01/17)
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
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
    </style>   
</asp:Content>