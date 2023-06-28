<%@ Page Title="I9 Form" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_I9.aspx.vb" 
    Inherits="HReaseApp.EE_I9"  
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
     <div class="HREwrapper">
          <div id="divPageTitle">
            <div>
                <br />
                <h4><b>I-9 Form</b></h4>
            </div>
        </div>
        
        <div id="divTopHeader" class="form-group">                  
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
                <div id="divNextButton" style="float:right; margin-top:-3%;" >
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" Width="50%" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" />
                </div>
            </div>
        </div>       
       
      
        <div id="divInstructionTitle" class="well HRESlateBlue HRERewrap">
            <span><b>INSTRUCTIONS </b></span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px" />
        </div>

        <div id="divInstructions" class="row well instruction_toggle HREWhite HRERewrap" style="margin-bottom:20px; text-align:center; border:none;">
             Click on the below image to see full instructions<br />
             <a href="https://www.uscis.gov/sites/default/files/files/form/i-9instr.pdf" target="_blank">
             <img src="images/I9_Instructions.png" style="width:80%;" /></a>
        </div>

         <div id="divMainArticalTitleandText" runat="server" class="well HRERewrap">
            <div id="divTitle" runat="server" class="form-group HRELightBlue">
                    <h4><asp:Label ID="lblMainArticleTitle" runat="server" Text=""></asp:Label></h4>           
            </div>
            <div id="divText" runat="server" class="form-group HREWhite" >
                    <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div>
      
        <div id="divFormHeader">
            <table style="background-color:white;">
                <tr>
                        <td style="width:33%;" ></td>
                        <td style="width:33%;"></td>
                        <td style="width:33%;"></td>                   
                </tr> 
                <tr>
                    <td>
                        <img src="images/USDepartmentOfHomelandSecurityLogo.jpg" style="Width: 200px;"/>
                    </td>
                    <td style="text-align: center; color:black; font-size:medium;">
                        <b>Employment Eligibility Verification
                            <br /> 
                            Department of Homeland Security  </b>
                            <br />
                            U.S. Citizenship and Immigration Services
                    </td>
                    <td style="text-align: center; color:black;">
                        <b>USCIS </b>
                        <br />
                        <b>Form I-9</b>
                        <br />
                        OMB No. 1615-0047
                        <br />
                        Expires 10/31/2022
                    </td>
                </tr>
            </table>
        </div>
     
        <div id="divMainInstructions" style="margin-right:5%;">
            <div style="background-color:#EFF3FB;">
                &nbsp;
            </div>
            <div style="background-color:darkgrey; width:100%;">
                &nbsp;
            </div>
            <div style="background-color:#EFF3FB; height:10px; border-bottom:2px solid black;">
                &nbsp;
            </div>
            <div style="background-color:white; margin-top:10px;margin-bottom:10px;">
                <b> ►START HERE: Read instructions carefully before completing this form. The instructions must be available, either in paper or electronically,
                during completion of this form. Employers are liable for errors in the completion of this form.</b>
            </div>
            <div style="background-color:white; margin-top:10px; margin-bottom:10px;">
                <b> ANTI-DISCRIMINATION NOTICE:</b> It is illegal to discriminate against work-authorized individuals. 
                    Employers <b>CANNOT</b> specify which document(s) an employee may present to establish employment 
                    authorization and identity. The refusal to hire or continue to employ an individual because the 
                    documentation presented has a future expiration date may also constitute illegal discrimination.
            </div>
        </div>

        <div id="Section1" style="margin-right:5%;">
            <div id="divEEDemographics">
                <table style="background-color:white;">
                    <tr>
                        <td style="width:3%;" ></td>
                        <td style="width:15%;"></td>
                        <td style="width:15%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:15%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:15%;"></td>
                   </tr> 
                    <tr>
                        <th colspan="8" style="background-color:lightgray ;border: #5f5c5c 1px solid; font-size:x-large; padding: 3px;" >
                            <b>Section 1. Employee Information and Attestation </b>
                            <span style="font-weight:normal; font-size:large;"><i>(Employees must complete and sign Section 1 of 
                                Form I-9 no later than the <b>first day employment</b>, but not before accepting a job offer.)</i>
                            </span>
                        </th>
                    </tr>
                    <tr style="background-color:white;">
                        <td colspan="2" style="border-left: #5f5c5c 1px solid;">
                            Last Name <i>(Family Name)</i>
                        </td>
                        <td colspan="2">
                            First Name <i>(Given Name)</i>
                        </td>
                        <td colspan="1">
                            Middle Initial 
                        </td>
                        <td colspan="3" style="border-right: #5f5c5c 1px solid; border-left: #5f5c5c 1px solid;">
                            Other Last Names Used <i>(if any)</i>  &nbsp;
                            <asp:LinkButton runat="server" ID="btnOtherNameHelp" OnClick="btnOtherNameHelp_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                        </td>
                    </tr>                       
                    <tr>
                        <td colspan="2" style="background-color:#f5f5f5; border-left: #5f5c5c 1px solid;">
                            <b><asp:Label ID="lblLastName" runat="server" ></asp:Label></b>
                        </td>
                        <td colspan="2" style="background-color: #f5f5f5;">
                                <b><asp:Label ID="lblFirstName" runat="server" ></asp:Label></b>
                        </td>
                        <td colspan="1" style="background-color: #f5f5f5; padding-right:10px; border-right: #5f5c5c 1px solid;">
                            <b><asp:Label ID="lblMiddleInit" runat="server" ></asp:Label> </b>
                        </td>
                        <td colspan="3" style="border-right: #5f5c5c 1px solid;">
                            <b><asp:textbox ID="txtOtherName" runat="server"  Width ="100%" ></asp:textbox> </b>
                        </td>
                    </tr>                                      
                    <tr>
                        <td colspan="8" style="vertical-align: middle; border-right: #5f5c5c 1px solid; border-left: #5f5c5c 1px solid;   ">
                            <div id="divNameHelp" runat="server" visible="false"  style="background-color: #dff0d8; padding-top: 10px; padding-left: 10px; padding-bottom: 10px;margin-left:-6px;border-top: #5f5c5c 1px solid; ">
                                   
                                <asp:Label ID="lblNameHelpTitle" runat="server" Text="<strong>testing</strong>"></asp:Label>
                                <asp:LinkButton runat="server" ID="btnNameHelpClose" OnClick="btnHelpClose_Click" CssClass="pull-right " ><i class="glyphicon glyphicon-remove-circle btn-lg " aria-hidden="true" ></i></asp:LinkButton>
                                <br />   <br />
                                <asp:Label ID="lblNameHelpText" runat="server" Text="Help text here"></asp:Label>
                            </div>
                        </td>
                    </tr>                                       
                    <tr style="background-color:white;">
                        <td colspan="3" style="border-left: #5f5c5c 1px solid; border-top: #5f5c5c 1px solid;">
                            Address <i>(Street Number and Name)</i>
                        </td>
                        <td colspan="1" style="border-left: #5f5c5c 1px solid; border-top: #5f5c5c 1px solid;">
                            Apt. Number
                        </td >
                        <td colspan="2" style="border-left: #5f5c5c 1px solid; border-top: #5f5c5c 1px solid;">
                            City or Town
                        </td>
                        <td colspan="1" style="border-left: #5f5c5c 1px solid; border-top: #5f5c5c 1px solid;">
                            State
                        </td>
                        <td colspan="1" style="border-right: #5f5c5c 1px solid; border-left: #5f5c5c 1px solid; border-top: #5f5c5c 1px solid;">
                            Zip Code
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="background-color: #f5f5f5; border-bottom: #5f5c5c 1px solid; border-left: #5f5c5c 1px solid;">
                            <b> <asp:Label ID="lblAddress1" runat="server" ></asp:Label></b>
                        </td>
                        <td colspan="1" style="background-color: #f5f5f5; border-bottom: #5f5c5c 1px solid; border-left: #5f5c5c 1px solid;">
                             <b><asp:Label ID="lblAddress2" runat="server" ></asp:Label></b>
                        </td>
                        <td colspan="2" style="background-color: #f5f5f5; border-bottom: #5f5c5c 1px solid; border-left: #5f5c5c 1px solid;">
                           <b><asp:Label ID="lblCity" runat="server"></asp:Label></b>
                        </td>
                        <td colspan="1" style="background-color: #f5f5f5; border-bottom: #5f5c5c 1px solid; border-left: #5f5c5c 1px solid;">
                            <b><asp:Label ID="lblState" runat="server" ></asp:Label></b>
                        </td>
                        <td colspan="1" style="background-color: #f5f5f5; border-right: #5f5c5c 1px solid; border-left: #5f5c5c 1px solid;">
                            <b><asp:Label ID="lblZip" runat="server" ></asp:Label></b>
                        </td>

                    </tr>
                    <tr style="background-color:white;">
                        <td colspan="2" style="border-left: #5f5c5c 1px solid;">
                            Date of Birth <i>(mm/dd/yyyy)</i>
                        </td>
                        <td colspan="1" style="border-left: #5f5c5c 1px solid;">
                            U.S. Social Security Number
                        </td >
                        <td colspan="3" style="border-left: #5f5c5c 1px solid;">
                            Employee's Email Address
                        </td>
                        <td colspan="2" style="border-left: #5f5c5c 1px solid; border-right: #5f5c5c 1px solid;">
                            Employee's Telephone Number
                        </td>                    
                    </tr>
                    <tr>
                        <td colspan="2" style="background-color: #f5f5f5; border-left: #5f5c5c 1px solid; border-bottom: #5f5c5c 1px solid;">
                            <b><asp:Label ID="lblDOB" runat="server" ></asp:Label></b>
                        </td>
                        <td colspan="1" style="background-color: #f5f5f5; border-left: #5f5c5c 1px solid; border-bottom: #5f5c5c 1px solid;">
                            <b><asp:Label ID="lblSSN" runat="server" ></asp:Label></b>
                        </td >
                        <td colspan="3" style="background-color: #f5f5f5; border-left: #5f5c5c 1px solid; border-bottom: #5f5c5c 1px solid;">
                             <b><asp:Label ID="lblEmail" runat="server" ></asp:Label></b>
                        </td>
                        <td colspan="2" style="background-color: #f5f5f5; border-left: #5f5c5c 1px solid ;border-right: #5f5c5c 1px solid; border-bottom: #5f5c5c 1px solid;">
                             <b><asp:Label ID="lblPhone" runat="server" ></asp:Label></b>
                        </td>                    
                    </tr>
                    <tr>
                        <td colspan="8" style="background-color:#f8bac0;">
                            <div id="divEEDemoError" runat="server" >
                                <div >
                                    <div style ="font-weight:bold; font-size:large; padding:5px;">
                                        <asp:Label ID="lblEEDemoErrorTitle" runat="server" ></asp:Label>
                                    </div>
                                    <div class="col-lg-2" style="padding-top:10px; float:right;">
                                        <asp:Image ID="Image9" ImageUrl="../img/RedX.png" runat="server" style="width:80px" />
                                    </div>
                                    <div style="padding:20px;">
                                        <asp:Label ID="lblEEDemoErrorText" runat="server" ></asp:Label>
                                    </div>
                                </div> 
                                
                            </div>
                        </td>
                    </tr>

                    
                </table>
            </div>

            <div id="divDeclaration">
                <table class="col-md-12">     
                    <tr style="background-color:white;">
                        <td style="width:100%;" >
                            <br />
                        </td>
                    </tr>
                    <tr style="background-color:white;">
                        <td colspan="1">
                            <b>I am aware that federal law provides for imprisonment and/or fines for false statements or use of false documents in connection with the completion of this form.</b>
                        </td>
                    </tr>
                    <tr style="background-color:white;">
                        <td colspan="1">
                            <br />
                            <b>I attest, under penalty of perjury, that I am (check one of the following boxes):</b>
                        </td>
                    </tr>
                    
                </table>
            </div>

            <div id="divSection1Q&A">
                <table style="width:100%; background-color:white;">
                    <tr>
                        <td style="width:3%;">
                            <br />
                        </td>
                        <td style="width:3%;"></td>
                        <td style="width:44%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:10%;"></td>
                    </tr>
                    <tr>
                        <td colspan="8" style="vertical-align: middle; background-color:#f8bac0;">
                            <div id="divEECheckboxError" runat="server" visible="false" style="vertical-align: middle; background-color:#f8bac0;">
                                <div class="col-lg-2">
                                    <asp:Image ID="imgSmallRedX2" ImageUrl="../img/RedX.png" runat="server" Style="width:80px" />
                                </div>
                                <div style ="font-weight:bold; font-size:large; padding-top:15px; vertical-align:middle;">
                                    <asp:Label ID="lblEECheckboxTitle" runat="server" ></asp:Label>
                                    <br />
                                    <asp:Label ID="lblEECheckboxText" runat="server"></asp:Label>
                                </div>                                 
                            </div>
                        </td>
                    </tr>
                    <tr style="border:1px solid black; height:40px;">
                        <td colspan="8">
                            <asp:CheckBox ID="chkCitizen" runat="server" OnCheckedChanged="chkCitizen_CheckedChanged" AutoPostBack="true" />
                            &nbsp;&nbsp; 1.&nbsp;&nbsp; A citizen of the United States 
                            <asp:LinkButton runat="server" ID="btnCitizenhelp" OnClick="btnCitizen_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                        </td>
                    </tr>
                    <tr style="border:1px solid black; height:40px;">
                        <td colspan="8">
                            <asp:CheckBox ID="chkNonCitizen" runat="server" OnCheckedChanged="chkNonCitizen_CheckedChanged"  AutoPostBack ="true"/> 
                            &nbsp;&nbsp;2.&nbsp;&nbsp;  A noncitizen national of the United States <i>(See instructions)</i> &nbsp;
                            <asp:LinkButton runat="server" ID="btnNonCitizenHelp" OnClick="btnNonCitizenHelp_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                        </td>
                    </tr>              
                    <tr  style="border:1px solid black; height:40px;">
                        <td colspan="7">
                            <asp:Checkbox ID="chkPermResident" runat="server" OnCheckedChanged="chkPermResident_CheckedChanged"  AutoPostBack ="true" ></asp:Checkbox> 
                            &nbsp;&nbsp;3.&nbsp;&nbsp;  A lawful permanent resident &nbsp;
                            <asp:LinkButton runat="server" ID="btnPermResidentHelp" OnClick="btnPermResidentHelp_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                            &nbsp; (Alien Registration Number/USCIS Number) &nbsp;
                            <asp:LinkButton runat="server" ID="btnPermResidentHelp2" OnClick="btnPermResidentHelp2_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                           &nbsp;&nbsp; <asp:Label ID="lblAlien1" runat="server" Text=""  visible ="false"  ></asp:Label>
                            <asp:TextBox ID="txtPermResidentNumber" runat ="server"  BackColor="#EFF3FB"  style="width:200px" ></asp:TextBox>
                         </td>  
                         <td colspan="1" style="border-top:#5f5c5c 1px solid;border-right:#5f5c5c 1px solid; padding-right:20px;" >   
                            <asp:DropDownList ID="ddlPermResidentType" runat="server" Visible="true" CssClass="form-control" style="width:150px"  BackColor="#EFF3FB">                          
                                 <asp:ListItem Text="N/A" Value="N/A"></asp:ListItem>
                                <asp:ListItem Text="Alien Number" Value="Alien Number"></asp:ListItem>
                                <asp:ListItem Text="USCIS Number" Value ="USIS Number"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8" style="vertical-align: middle;  background-color:#f8bac0;">
                            <div id="divPermResError" runat="server" >
                                <div class="col-lg-2">
                                    <asp:Image ID="Image4" ImageUrl="../img/RedX.png" runat="server" Style="width:80px" />
                                </div>
                                <div style ="font-weight:bold; font-size:large; padding-top:15px; vertical-align:middle;">
                                    <asp:Label ID="lblPermResErrorTitle" runat="server" ></asp:Label>
                                    <br />
                                    <asp:Label ID="lblPermResErrorText" runat="server" ></asp:Label>
                                </div>                                 
                            </div>
                        </td>
                    </tr>
                    <tr style="border-left:1px solid black; border-right:1px solid black; height:40px;">
                        <td colspan="8" >
                            <asp:CheckBox ID="chkTempVisa" runat="server" OnCheckedChanged="chkTempVisa_CheckedChanged" AutoPostBack="true"></asp:CheckBox>
                            &nbsp;&nbsp;4.&nbsp;&nbsp;  An alien authorized to work &nbsp;
                            <asp:LinkButton runat="server" ID="btnTempVisaHelp" OnClick="btnTempVisaHelp_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                            until (expiration date, if applicable, mm/dd/yyyy) &nbsp;                        
                            <asp:LinkButton runat="server" ID="btnTempVisaHelp2" OnClick="btnTempVisaHelp2_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>&nbsp;&nbsp;
                            <asp:TextBox ID="txtTempVisaDate" runat="server" BackColor="#EFF3FB" style="width:15%;"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="border-left:1px solid black; border-right:1px solid black; height:40px;">
                        <td colspan="8" style=" border-left:#5f5c5c 1px solid; border-right:#5f5c5c 1px solid; padding-left:3%;">
                        Some aliens may write "N/A" in the expiration date field. <i>(See Instructions)</i>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8" style="border-left:#5f5c5c 1px solid; border-right:#5f5c5c 1px solid; vertical-align: middle;">
                            <div id="divHelp" runat="server" visible="false"  style="background-color:#dff0d8; padding-top: 10px; padding-left: 10px; padding-bottom: 10px;margin-left:-6px;border-top:#5f5c5c 1px solid;border-bottom:#5f5c5c 1px solid; ">
                                <asp:Label ID="lblHelpTitle" runat="server" Text="<strong>testing</strong>"></asp:Label>
                                <asp:LinkButton runat="server" ID="btnHelpClose" OnClick="btnHelpClose_Click" CssClass="pull-right " ><i class="glyphicon glyphicon-remove-circle btn-lg " aria-hidden="true" ></i></asp:LinkButton>
                                 <br />   <br />
                                <asp:Label ID="lblHelpText" runat="server" Text="Help text here"></asp:Label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8" style="vertical-align: middle; border-right:#5f5c5c 1px solid;  border-left: #5f5c5c 1px solid; ">
                            <div id="divAlienHelp" runat="server" visible="false" style="background-color: #dff0d8;  padding-top: 10px; padding-left: 10px; padding-bottom: 10px; border-top: #5f5c5c 1px solid; margin-left:-6px; margin-bottom:-10px;">
                                <asp:Label ID="lblAlienHelpTitle" runat="server" Text="<strong>testing</strong>"></asp:Label>
                                <asp:LinkButton runat="server" ID="btnAlienHelpClose" OnClick="btnHelpClose_Click" CssClass="pull-right " ><i class="glyphicon glyphicon-remove-circle btn-lg " aria-hidden="true" ></i></asp:LinkButton>
                                <br />   <br />
                                <asp:Label ID="lblAlienHelpText" runat="server" Text="Help text here"></asp:Label>                                 
                            </div>
                        </td>
                    </tr>     
                    <tr style="border-left:1px solid black; border-right:1px solid black; height:40px;">
                        <td colspan="8" style="padding-left:1%;">
                            <br /><i>Aliens authorized to work must provide one of the following doucment Numbers to complete Form I-9:
                            <br />An Alien Registration Number/USCIS Number <b">OR </b>Form I-94 Admission Number<b> OR </b> Foreign Passport Number.</i><br /><br />
                        </td>
                    </tr>
                    <tr style="border-left:1px solid black; border-right:1px solid black; height:40px;">
                        <td colspan="1" style="padding-left:1%;">
                            1.
                        </td>
                        <td colspan ="4" >
                            &nbsp;&nbsp;Alien Registration Number/USCIS Number:&nbsp;
                            <asp:LinkButton runat="server" ID="btnANumberHelp" OnClick="btnANumberHelp_Click" ><i class="glyphicon glyphicon-question-sign" aria-hidden="true" ></i></asp:LinkButton>
                             &nbsp;&nbsp; <asp:Label ID="lblAlien2" runat="server" Text="A" visible ="false"  ></asp:Label>
                             &nbsp;&nbsp;<asp:TextBox ID="txtAlienNumber" runat ="server" BackColor="#EFF3FB" Width="150px"  ></asp:TextBox>
                        </td>
                        <td colspan="3" style="border-right:1px solid #5f5c5c;" >   
                            <asp:DropDownList ID="ddlPermResidentType2" runat="server" Visible="false" CssClass="form-control" Width="150px"  BackColor="#EFF3FB">                          
                                 <asp:ListItem Text="N/A" Value="N/A"></asp:ListItem>
                                <asp:ListItem Text="Alien Number" Value="Alien Number"></asp:ListItem>
                                <asp:ListItem Text="USCIS Number" Value ="USIS Number"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr style="border-left:1px solid black; border-right:1px solid black; height:40px;">
                        <td colspan ="3" style="padding-left:20%;">
                            <div style="font-size: 18px ;"><b> OR </b></div>
                        </td>
                        <td colspan ="5" >                       
                        </td>
                    </tr>
                    <tr style="border-left:1px solid black; border-right:1px solid black; height:40px;">
                        <td colspan="1" style="padding-left:1%;">
                            2.
                        </td>
                        <td colspan ="3" >
                            &nbsp;&nbsp;Form I-94 Admission Number:&nbsp;
                            <asp:LinkButton runat="server" ID="btnI94Help" OnClick="btnI94Help_Click" ><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                            &nbsp;&nbsp;<asp:TextBox ID="txtAdmissionNumber" runat ="server"  BackColor="#EFF3FB"  style="width:150px" ></asp:TextBox>
                        </td>
                        <td colspan ="4" >
                               &nbsp;
                        </td>
                    </tr>
                    <tr style="border-left:1px solid black; border-right:1px solid black; height:40px;">
                        <td colspan ="3" style="padding-left:20%;">
                            <div style="font-size: 18px ;"><b> OR </b></div>
                        </td>
                        <td colspan ="5" >                       
                        </td>
                    </tr>
                    <tr style="border-left:1px solid black; border-right:1px solid black; height:40px;">
                        <td colspan="1" style="padding-left:1%;">
                            3.
                        </td>
                        <td colspan="3" >
                            &nbsp;&nbsp;Foreign Passport Number: &nbsp;
                            <asp:LinkButton runat="server" ID="btnPassportHelp" OnClick="btnPassportHelp_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                            &nbsp;&nbsp;<asp:TextBox ID="txtPassportNumber" runat="server" BackColor="#EFF3FB" style="width:150px"></asp:TextBox>         
                        </td>
                        <td colspan ="4" >
                               &nbsp;
                        </td>
                    </tr>
                    <tr style="border-left:1px solid black; border-right:1px solid black; height:40px;">
                        <td colspan="1" >
                            &nbsp;&nbsp;&nbsp;
                        </td>
                        <td colspan ="3">  
                            &nbsp;&nbsp;Country of Issuance:&nbsp;
                            <asp:LinkButton runat="server" ID="btnCountryIssuanceHelp" OnClick="btnCountryIssuanceHelp_Click" ><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>                       
                            &nbsp;&nbsp;<asp:DropDownList ID="ddlCountryofIssuance" runat="server" DataValueField="ShortDesc" DataTextField="LongDesc"  Visible="false" CssClass="form-control" Style="width:150px;" BackColor="#EFF3FB" >  </asp:DropDownList>                                                                
                        </td>
                        <td colspan ="4" >
                               &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8" style="vertical-align: middle;  background-color:#f8bac0;">
                            <div id="divEEAlienError" runat="server" >
                                <div class="col-lg-2">
                                    <asp:Image ID="Image5" ImageUrl="../img/RedX.png" runat="server" Width="8px" />
                                </div>
                                <div style ="font-weight:bold; font-size:large; padding-top:15px; vertical-align:middle;">
                                    <asp:Label ID="lblEEAlienErrorTitle" runat="server" ></asp:Label>
                                    <br />
                                    <asp:Label ID="lblEEAlienErrorText" runat="server" ></asp:Label>
                                </div>                                 
                            </div>
                        </td>
                    </tr>

                    <tr style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black; height:40px;">
                        <td colspan="8">
                            &nbsp;
                        </td>
                    </tr>

                </table>
            </div>

            <div id="divSignatureBlock">
                <table style="width:100%; background-color:white;">
                    <tr>
                        <td style="width:50%;">
                            &nbsp;
                        </td>
                        <td style="width:50%;">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8" style="background-color:#f8bac0;">
                            <div id="divEESignatureError" runat="server" >
                                <div class="col-lg-2" style="padding-top:10px;">
                                    <asp:Image ID="Image3" ImageUrl="../img/RedX.png" runat="server" style="width:80px" />
                                </div>
                                <div style ="font-weight:bold; font-size:large; padding:5px;">
                                    <asp:Label ID="lblEESignatureErrorTitle" runat="server" ></asp:Label><br />
                                </div>                                 
                            </div>
                        </td>
                    </tr>
                   <tr style="height:40px;">
                        <td style="border-left:1px solid black; border-right:1px solid black; border-top:1px solid black;">
                            Signature of Employee:&nbsp;
                            <asp:LinkButton runat="server" ID="btnEmpSignHelp" OnClick="btnEmpSignHelp_Click" ><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>                       
                        </td>                      
                        <td style="border-left:1px solid black; border-right:1px solid black; border-top:1px solid black;">
                            Today's Date <i>(mm/dd/yyyy)</i>: &nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td style="border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtEmployeeSignature" runat ="server" TabIndex="1" BackColor="#EFF3FB" style="width:100%; padding-left:1%;" ></asp:TextBox>
                        </td>
                        <td style="background:#EFF3FB; border-left:1px solid black; border-right:1px solid black; border-bottom:1px solid black;">
                            <asp:TextBox ID="txtEmployeeSignatureDate" runat ="server" TabIndex="2" BackColor="#EFF3FB"  style="width:100%; padding-left:1%;"></asp:TextBox>
                        </td>
                    </tr>
                    <%--Signature HELP TEXT--%>
                    <tr>
                        <td colspan="8" style="vertical-align: middle; border-right: #5f5c5c 1px solid; border-left: #5f5c5c 1px solid;">
                            <div id="divEmpSignature" runat="server" visible="false" style="background-color: #dff0d8;padding: 10px 0px 10px 10px;border-bottom:#5f5c5c 1px solid; margin-left: -6px; ">
                                <asp:Label ID="lblEmpSignHelpTitle" runat="server" Text="<strong>testing</strong>"></asp:Label>
                                <asp:LinkButton runat="server" ID="btnEmpSignHelpClose" OnClick="btnHelpClose_Click" CssClass="pull-right "><i class="glyphicon glyphicon-remove-circle btn-lg " aria-hidden="true" ></i></asp:LinkButton>
                                <br />
                                <br />
                                <asp:Label ID="lblEmpSignHelpText" runat="server" Text="Help text here"></asp:Label>
                            </div>
                        </td>
                    </tr>
                    
                </table>
            </div>

            <div id="divPreparerTranslator">
                <table style="background-color:white;">
                    <tr>
                        <td colspan="8">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8" style="background: #cac6c6; border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;border-left: #5f5c5c 1px solid; font-size:x-large;">
                            <b>Preparer and/or Translator Certification (check one):</b>&nbsp;
                            <asp:LinkButton runat="server" ID="btnPreparerHelp" OnClick="btnPreparerHelp_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="background: #cac6c6; border-left: #5f5c5c 1px solid; font-size:large;">
                            <asp:CheckBox ID="chkNoPreparer" runat="server" TabIndex="3" CssClass=" check " AutoPostBack="true" OnCheckedChanged="chkNoPreparer_CheckedChanged" ></asp:CheckBox>
                            &nbsp;&nbsp;I did not use a preparer or translator.
                        </td>
                        <td colspan="4" style="background: #cac6c6; border-right: #5f5c5c 1px solid; font-size:large;">
                            <asp:CheckBox ID="chkUsedPreparer" runat="server" TabIndex="4" CssClass=" check " AutoPostBack="true" OnCheckedChanged="chkUsedPreparer_CheckedChanged" ></asp:CheckBox>
                            &nbsp;&nbsp;A preparer(s) and/or translator(s) assisted the employee in completing Section 1.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8" style="background: #cac6c6; border-bottom: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;border-left: #5f5c5c 1px solid;  font-size:large;">
                            <i>(Fields below must be completed and signed when preparers and/or translators assist an employee in completing Section 1.)</i>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8" style="vertical-align: middle; border-right: #5f5c5c 1px solid; border-left: #5f5c5c 1px solid;">
                            <div id="divPreparerHelp" runat="server" visible="false" style="background-color: #dff0d8;padding: 10px 0px 10px 10px;border-bottom:#5f5c5c 1px solid; margin-left: -6px; ">
                                <asp:Label ID="lblPreparerHelpTitle" runat="server" Text="<strong>testing</strong>"></asp:Label>
                                <asp:LinkButton runat="server" ID="btnPreparerHelpClose" OnClick="btnHelpClose_Click" CssClass="pull-right "><i class="glyphicon glyphicon-remove-circle btn-lg " aria-hidden="true" ></i></asp:LinkButton>
                                <br />
                                <br />
                                <asp:Label ID="lblPreparerHelpText" runat="server" Text="Help text here"></asp:Label>
                            </div>
                        </td>
                    </tr>
                    <tr style="background-color:white;">
                        <td>
                            &nbsp
                        </td>
                    </tr>
                    <tr style="background-color:white;">
                        <td colspan="8">
                            <b>I attest, under penalty of perjury, that I have assisted in the completion of this form and that to the best of my knowledge the information is true and correct</b>
                            <br />
                        </td>
                    </tr>
                    <tr style="background-color:white;">
                        <td>
                            &nbsp
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8" style="background-color:#f8bac0;">
                            <div id="divEEPreparerError" runat="server" >
                                <div >
                                    <div style ="font-weight:bold; font-size:large; padding:5px;">
                                        <asp:Label ID="lblEEPreparerErrorTitle" runat="server" ></asp:Label>
                                    </div>
                                    <div class="col-lg-2" style="padding-top:10px; float:right;">
                                        <asp:Image ID="Image6" ImageUrl="../img/RedX.png" runat="server" style="width:80px" />
                                    </div>
                                    <div style="padding:20px;">
                                        <asp:Label ID="lblEEPreparerErrorText" runat="server" ></asp:Label>
                                    </div>
                                </div> 
                                
                            </div>
                        </td>
                    </tr>
                    <tr style="background-color:white;">
                        <td colspan="5" style="border-left:1px solid black; border-right:1px solid black; border-top:1px solid black; ">
                            Signature of Preparer or Translator:&nbsp;
                                <asp:LinkButton runat="server" ID="btnSignaturePrepare" TabIndex="5" OnClick="btnSignaturePrepare_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                        </td>
                        <td colspan="3" style="border-right:1px solid black; border-top:1px solid black; ">
                            Date <i>(mm/dd/yyyy)</i>: &nbsp;&nbsp;                         
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5" style="border-left:1px solid black; border-right:1px solid black;">
                            <asp:TextBox ID="txtPRSignature" runat="server" TabIndex="6" BackColor="#f5f5f5" Enabled="false" style="width:100%; padding-left:1%;"></asp:TextBox>
                        </td>
                        <td colspan="3" style="border-right:1px solid black;">
                            <asp:TextBox ID="txtPRSignatureDate" runat="server" TabIndex="7" BackColor="#f5f5f5" Enabled="false" style="width:100%; padding-left:1%;"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="background-color:white;">
                        <td colspan="4" style="border-left:1px solid black; border-right:1px solid black; border-top:1px solid black;">
                            Last Name <i>(Family Name)</i> &nbsp;
                            <asp:LinkButton runat="server" ID="btnPRLastNameHelp" OnClick="btnPRLastNameHelp_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                        </td>
                        <td colspan="4" style="border-left:1px solid black; border-right:1px solid black; border-top:1px solid black;">
                            First Name <i>(Given Name)</i> &nbsp;
                            <asp:LinkButton runat="server" ID="btnPRFirstNameHelp" OnClick="btnPRFirstNameHelp_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                        </td>
                    </tr>
                    <tr style="background-color:white;">
                        <td colspan="4" style="border-left:1px solid black; border-right:1px solid black; border-top:1px solid black;">
                            <asp:TextBox ID="txtPRLastName" runat="server" TabIndex="8" BackColor="#f5f5f5" Enabled="false" style="width:100%; padding-left:1%;"></asp:TextBox>
                        </td>
                        <td colspan="4" style="border-left:1px solid black; border-right:1px solid black; border-top:1px solid black;">
                            <asp:TextBox ID="txtPRFirstName" runat="server" TabIndex="9" BackColor="#f5f5f5" Enabled="false" style="width:100%; padding-left:1%;"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="background-color:white;">
                        <td colspan="4" style="border-left:1px solid black; border-right:1px solid black; border-top:1px solid black;">
                            Address <i>(Street Number and Name)</i>&nbsp;
                            <asp:LinkButton runat="server" ID="btnPRAddressHelp" OnClick="btnPRAddressHelp_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                        </td>                    
                        <td colspan="2" style="border-left:1px solid black; border-top:1px solid black;">
                            City or Town &nbsp;
                            <asp:LinkButton runat="server" ID="btnPRCityHelp" OnClick="btnPRCityHelp_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black;">
                            State &nbsp;
                            <asp:LinkButton runat="server" ID="btnPRStateHelp" OnClick="btnPRStateHelp_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-top:1px solid black; border-right:1px solid black;">
                            Zip Code &nbsp;
                            <asp:LinkButton runat="server" ID="btnPRZipHelp" OnClick="btnPRZipHelp_Click"><i class="glyphicon glyphicon-question-sign" aria-hidden="true"></i></asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                         <td colspan="4" style="border-bottom: #5f5c5c 1px solid;border-left: #5f5c5c 1px solid;">
                            <asp:Textbox ID="txtPRAddress" runat="server" TabIndex="10" BackColor="#f5f5f5" Enabled="false" style="width:100%; padding-left:1%;"></asp:Textbox>
                        </td>
                        <td colspan="2" style="border-bottom: #5f5c5c 1px solid;border-left: #5f5c5c 1px solid;">
                        <asp:Textbox ID="txtPRCity" runat="server" TabIndex="11" BackColor="#f5f5f5" Enabled="false" style="width:100%; padding-left:1%;"></asp:Textbox>
                        </td>
                        <td style="border-bottom: #5f5c5c 1px solid;border-left: #5f5c5c 1px solid;">
                            <asp:DropDownList ID="ddlPRState" runat="server" CssClass="selectpicker" TabIndex="13" BackColor="#f5f5f5" Enabled="false" DataValueField="ShortDesc" DataTextField="ShortDesc" Width="80px"></asp:DropDownList>
                        </td>
                        <td style="border-bottom: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;border-left: #5f5c5c 1px solid;">
                            <asp:Textbox ID="txtPRZip" runat="server" TabIndex="13" BackColor="#f5f5f5" Enabled="false" style="width:100%; padding-left:1%;"></asp:Textbox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8" style="vertical-align: middle; border-right: #5f5c5c 1px solid; border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">
                            <div id="divPreparerHelp2" runat="server" visible="false" style="background-color: #dff0d8;padding: 10px 0px 10px 10px;border-bottom:#5f5c5c 1px solid; margin-left: -6px; ">
                                <asp:Label ID="lblPreparerHelpTitle2" runat="server" Text="<strong>testing</strong>"></asp:Label>
                                <asp:LinkButton runat="server" ID="btnPreparerHelpClose2" OnClick="btnHelpClose_Click" CssClass="pull-right "><i class="glyphicon glyphicon-remove-circle btn-lg " aria-hidden="true" ></i></asp:LinkButton>
                                <br />
                                <br />
                                <asp:Label ID="lblPreparerHelpText2" runat="server" Text="Help text here"></asp:Label>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>

            <div id="divSaveSection1" class="form-group">
                <div class="col-md-12" style="padding-right:6%;">
                        <%--<asp:ImageButton ID="btnSaveSection1" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22"/>--%>
                    <asp:Button ID="btnSave_Section1" text="SAVE SECTION 1" runat="server" TabIndex="15" CssClass="btn btn-primary pull-right" OnClick="btnSave_Section1_Click" />   
                </div>
            </div>
        </div>
  
        <div id="divSection2" runat="server" style="margin-right:5%;">
            <div id="Sec2Header">
                <table style="background-color:white;">
                    <tr style="background-color:white; border-top:10px solid black;">
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <th colspan="8" style="background-color:lightgray;border: 1px solid black; font-size:x-large;">
                            <b>Section 2. Employer or Authorized Representative Review and Verification</b>
                            <span style="font-size:large;"><i>(Employers or their authorized representative must 
                                complete and sign Section 2 within 3 business days of the employee's first day of 
                                employment. You must physically examine one document from List A OR a combination of one 
                                document from List B and one document from List C as listed on the "Lists of Acceptable 
                                Documents.")</i>
                            </span>
                        </th>  
                    </tr>
                    <tr style="background-color:white;">
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </div>

            <div id="divSec2SubHeader">
                <table style="border:3px solid black; background-color:white;">
                  <tr>
                        <td style="width:20%;"></td>
                        <td style="width:20%;"></td>
                        <td style="width:20%;"></td>
                        <td style="width:10%;"></td>
                        <td style="width:30%;"></td>
                    </tr>                               
                    <tr>
                        <td colspan="1" >
                            <br />
                            <b>Employee Info from Section 1:</b>&nbsp;&nbsp;
                            <br />
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-right:1px solid black;">
                            Last Name <i>(Family Name)</i>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-right:1px solid black;">
                            First Name <i>(Given Name)</i>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-right:1px solid black;">
                            M.I.
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-right:1px solid black;">
                            Citizenship/Immigration Status:
                        </td>
                    </tr>
                    <tr style="background-color:white; font-weight:bold; height:40px;">
                        <td colspan="1">

                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-right:1px solid black; background-color: #f5f5f5;">
                            <asp:Label ID="lblEELastName" runat="server" Text="Employee Last name"></asp:Label>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-right:1px solid black; background-color: #f5f5f5;">
                            <asp:Label ID="lblEEFirstName" runat="server" Text="Employee First name"></asp:Label>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-right:1px solid black; background-color: #f5f5f5;">
                            <asp:Label ID="lblEEMI" runat="server" Text="Employee Middle Initial"></asp:Label>
                        </td>
                        <td colspan="1" style="border-left:1px solid black; border-right:1px solid black; background-color: #f5f5f5;">
                            <asp:Label ID="lblCitizenship" runat="server" Text="Citizenship"></asp:Label>
                        </td>
                    </tr>  
                </table>
            </div>
            
            <div id="divSec2Main">
                <table style="background-color:white; width:100%;">  
                    <tr>
                        <td colspan="8" style="vertical-align: middle; background-color:#f8bac0;">
                            <div id="divERSection2ErrorTop" runat="server" >
                                <div class="col-lg-2" style="padding-top:10px;">
                                    <asp:Image ID="Image2" ImageUrl="../img/RedX.png" runat="server" style="width:80px" />
                                </div>
                                <div style ="font-weight:bold; font-size:large; padding-top:5px;" >
                                    <asp:Label ID="lblSection2ErrorTop" runat="server" ></asp:Label>
                                </div>                                 
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:center">
                            <b>List A<br />Identity and Employment Authorization</b>
                        </td>
                        <td style="text-align:center">
                            <b>OR<br /></b>
                        </td>
                        <td colspan="2" style="text-align:center">
                            <b>List B<br />Identity</b>
                        </td>
                        <td style="text-align:center">
                            <b>AND<br /></b>
                        </td>
                        <td colspan="2" style="text-align:center">
                            <b>List C<br />Employment Authorization</b>
                        </td>
                    </tr>
                    <tr>
                        <td  style="border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;">
                            Document Title:&nbsp;
                            <asp:LinkButton runat="server" ID="bntListADocumentHelp" OnClick="bntListADocumentHelp_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;"></td>
                        <td  colspan="2" style="border-top: #5f5c5c 1px solid;">
                            Document Title:&nbsp;
                            <asp:LinkButton runat="server" ID="bntListBDocumentHelp" OnClick="bntListBDocumentHelp_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>
                        </td>
                            <td style="border-top: #5f5c5c 1px solid;"></td>
                        <td colspan="2" style="border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                            Document Title:&nbsp;
                            <asp:LinkButton runat="server" ID="bntListCDocumentHelp" OnClick="bntListCDocumentHelp_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td  style="border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">
                            <asp:DropDownList ID="ddlListADocument" runat="server" BackColor="#EFF3FB" style="width:100%" CssClass="form-control" DataValueField="I9DocumentId" DataTextField="I9DocumentName"  OnSelectedIndexChanged="ddlListADocument_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                            <%--<asp:textbox ID="txtListADocument1" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>--%>
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                        </td>
                        <td  colspan="2" style="border-bottom: #5f5c5c 1px solid;">
                            <asp:DropDownList ID="ddlListBDocument" runat="server" BackColor="#EFF3FB" style="width:100%" CssClass="form-control"  DataValueField="I9DocumentId" DataTextField="I9DocumentName" OnSelectedIndexChanged="ddlListBDocument_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                        </td>
                        <td style="border-bottom: #5f5c5c 1px solid;"></td>
                        <td colspan="2" style="border-bottom: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                            <asp:DropDownList ID="ddlListCDocument" runat="server" BackColor="#EFF3FB" style="width:100%" CssClass="form-control"  DataValueField="I9DocumentId" DataTextField="I9DocumentName" OnSelectedIndexChanged="ddlListCDocument_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
                            <%--<asp:textbox ID="txtListCDocument" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>--%>
                        </td>
                    </tr>
                    <tr>
                        <td  style="border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;">
                            Issuing Authority:&nbsp;
                            <asp:LinkButton runat="server" ID="btnListAIssuingHelp" OnClick="btnListAIssuingHelp_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>

                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;"></td>
                        <td  colspan="2" style="border-top: #5f5c5c 1px solid;">
                            Issuing Authority:&nbsp;
                            <asp:LinkButton runat="server" ID="btnListBIssuingHelp" OnClick="btnListBIssuingHelp_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>

                        </td>
                            <td ></td>
                        <td colspan="2" style="border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                                Issuing Authority:&nbsp;
                            <asp:LinkButton runat="server" ID="btnListCIssuingHelp" OnClick="btnListCIssuingHelp_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>

                        </td>
                    </tr>
                    <tr>
                        <td  style="border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">
                            <asp:DropDownList ID="ddlListAAuthority" runat="server" BackColor="#EFF3FB" style="width:100%" CssClass="form-control" DataValueField="I9DocumentAuthorityId" DataTextField="IssuingAuthority" AutoPostBack="true"></asp:DropDownList>
                            <asp:textbox ID="txtListAAuthority" runat="server" BackColor="#EFF3FB" style="width:100%" Visible="false"></asp:textbox>
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                        </td>
                        <td  colspan="2" style="border-bottom: #5f5c5c 1px solid;">
                            <asp:DropDownList ID="ddlListBAuthority" runat="server" BackColor="#EFF3FB" style="width:100%" CssClass="form-control" DataValueField="I9DocumentAuthorityId" DataTextField="IssuingAuthority" AutoPostBack="true"></asp:DropDownList>
                            <asp:textbox ID="txtListBAuthority" runat="server" BackColor="#EFF3FB" style="width:100%" Visible="false"></asp:textbox>
                        </td>
                        <td style="border-bottom: #5f5c5c 1px solid;" ></td>
                        <td colspan="2" style="border-bottom: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                                <asp:DropDownList ID="ddlListCAuthority" runat="server" BackColor="#EFF3FB" style="width:100%" CssClass="form-control" DataValueField="I9DocumentAuthorityId" DataTextField="IssuingAuthority" AutoPostBack="true"></asp:DropDownList>

                                <asp:textbox ID="txtListCAuthority" runat="server" BackColor="#EFF3FB" style="width:100%" Visible="false"></asp:textbox>
                        </td>
                    </tr>
                    <tr>
                        <td  style="border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;">
                            Document Number:&nbsp;
                            <asp:LinkButton runat="server" ID="btnListADocNumberHelp" OnClick="btnListADocNumberHelp_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>

                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;"></td>
                        <td  colspan="2" style="border-top: #5f5c5c 1px solid;">
                            Document Number:&nbsp;
                            <asp:LinkButton runat="server" ID="btnListBDocNumberHelp" OnClick="btnListBDocNumberHelp_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>

                        </td>
                        <td > &nbsp;</td>
                        <td colspan="2" style="border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                            Document Number:&nbsp;
                            <asp:LinkButton runat="server" ID="btnListCDocNumberHelp" OnClick="btnListCDocNumberHelp_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>

                        </td>
                    </tr>
                    <tr>
                        <td  style="background-color: #EFF3FB;border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">
                            <asp:textbox ID="txtListADocNum1" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                        </td>
                        <td  colspan="2" style="background-color: #EFF3FB;border-bottom: #5f5c5c 1px solid;">
                            <asp:textbox ID="txtListBDocNum" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                        </td>
                        <td style="border-bottom: #5f5c5c 1px solid;" > &nbsp;</td>
                        <td colspan="2" style="background-color: #EFF3FB;border-bottom: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                                <asp:textbox ID="txtListCDocNum" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                        </td>
                    </tr>
                    <tr>
                        <td  style="border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;">
                            Expiration Date<i>(if any) (mm/dd/yyyy)</i>:&nbsp;
                            <asp:LinkButton runat="server" ID="btnListAExpirationDate" OnClick="btnListAExpirationDate_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>

                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;"></td>

                        <td  colspan="2" style="border-top: #5f5c5c 1px solid;">
                            Expiration Date<i>(if any) (mm/dd/yyyy)</i>:&nbsp;
                            <asp:LinkButton runat="server" ID="btnListBExpirationDate" OnClick="btnListBExpirationDate_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>

                        </td>
                        <td > &nbsp;</td>
                        <td colspan="2" style="border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                            Expiration Date<i>(if any) (mm/dd/yyyy)</i>:&nbsp;
                            <asp:LinkButton runat="server" ID="btnListCExpirationDate" OnClick="btnListCExpirationDate_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>

                        </td>
                    </tr>
                    <tr>
                        <td  style="background-color: #EFF3FB;border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 2px solid;">
                            <asp:textbox ID="txtListAExpDate1" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                        </td>
                        <td  colspan="2" style="background-color: #EFF3FB;border-bottom: #5f5c5c 2px solid;">
                            <asp:textbox ID="txtListBExpDate" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                        </td>
                        <td style="border-bottom: #5f5c5c 2px solid;" > &nbsp;</td>
                        <td colspan="2" style="background-color: #EFF3FB;border-bottom: #5f5c5c 2px solid;border-right: #5f5c5c 1px solid;">
                                <asp:textbox ID="txtListCExpDate" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                        </td>
                    </tr>
                    <tr>
                        <td  style="border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;">
                            Document Title:
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;"></td>
                        <td  colspan="5" rowspan="15" style="border-right: #5f5c5c 1px solid; border-top: #5f5c5c 1px solid; vertical-align:top;">
                               
                            <%--help section 2 goes here--%>
                            <div id="divHelpSection2" runat="server" visible="false"  style="background-color: #dff0d8; padding-top: 10px; padding-left: 10px; padding-bottom: 10px;margin-left:-6px;border-top:#5f5c5c 1px solid;border-bottom:#5f5c5c 1px solid; ">
                                <asp:Label ID="lblSection2Title" runat="server" Text="<strong>testing</strong>"></asp:Label>
                                <asp:LinkButton runat="server" ID="btnHelpSection2Close" OnClick="btnHelpClose_Click" CssClass="pull-right " ><i class="glyphicon glyphicon-remove-circle btn-lg " aria-hidden="true" ></i></asp:LinkButton>
                                <br />   <br />
                                <asp:Label ID="lblSection2Text" runat="server" Text="Help text here"></asp:Label>
                            </div>
                        </td>
                            
                    </tr>
                    <tr>
                        <td  style="background-color: #EFF3FB;border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">
                            <asp:textbox ID="txtListADocument2" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                        </td>
                        
                            
                    </tr>
                    <tr>
                        <td  style="border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;">
                            Issuing Authority:
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;"></td>
                           
                    </tr>
                    <tr>
                        <td  style="background-color: #EFF3FB;border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">
                            <asp:textbox ID="txtListAAuthority2" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                        </td>
                        
                    </tr>
                    <tr>
                        <td  style="border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;">
                            Document Number:
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;"></td>
                           
                    </tr>
                    <tr>
                        <td  style="background-color: #EFF3FB;border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">
                            <asp:textbox ID="txtListADocNum2" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                        </td>
                          
                    </tr>
                    <tr>
                        <td  style="border-left: #5f5c5c 1px solid;">
                            Expiration Date<i>(if any) (mm/dd/yyyy)</i>:
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;"></td>                          
                    </tr>
                    <tr>
                        <td  style="background-color: #EFF3FB;border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 2px solid;">
                            <asp:textbox ID="txtListAExpDate2" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                        </td>
                          
                    </tr>
                    <tr>
                        <td  style="border-left: #5f5c5c 1px solid;">
                            Document Title:
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;"></td>  
                    </tr>
                    <tr>
                        <td  style="background-color: #EFF3FB;border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">
                            <asp:textbox ID="txtListADocument3" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                        </td>
                    </tr>
                    <tr>
                        <td  style="border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;">
                            Issuing Authority:
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;"></td>
                    </tr>
                    <tr>
                        <td  style="background-color: #EFF3FB;border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">
                            <asp:textbox ID="txtListAAuthority3" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                        </td>
                          
                    </tr>
                    <tr>
                        <td  style="border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;">
                            Document Number:
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;"></td>                                                  
                        
                    </tr>
                    <tr>
                        <td  style="background-color: #EFF3FB;border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">
                            <asp:textbox ID="txtListADocNum3" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                        </td>                                          
                          
                    </tr>
                    <tr>
                        <td  style="border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;">
                            Expiration Date<i>(if any) (mm/dd/yyyy)</i>:
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;"></td>
                         
                    </tr>
                    <tr>
                        <td  style="background-color: #EFF3FB;border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 2px solid;">
                            <asp:textbox ID="txtListAExpDate3" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                        </td>
                        <td style="background-color:#cac6c6;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;border-bottom: #5f5c5c 2px solid;">
                        </td>
                        <td  colspan="5" style="border-bottom: #5f5c5c 2px solid;border-right: #5f5c5c 1px solid;" >                           
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8" style="vertical-align: middle; background-color:#f8bac0;">
                            <div id="divERSection2ErrorBottom" runat="server" >
                                <div class="col-lg-2" style="padding-top:10px;">
                                    <asp:Image ID="Image7" ImageUrl="../img/RedX.png" runat="server" style="width:80px" />
                                </div>
                                <div style ="font-weight:bold; font-size:large; padding-top:5px;">
                                    <asp:Label ID="lblSection2ErrorBottom" runat="server"></asp:Label>
                                </div>                                 
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7">
                            <br />
                            <strong>Certification:  I attest, under penalty of perjury, that (1) I have examined the document(s) presented by the above-named employee, (2) the above-listed document(s) appear to be genuine and to relate to the employee named, and (3) to the best of my knowledge the employee is authorized to work in the United States.
                                </strong>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7">
                            <b>The employee's first day of employment <i>(mm/dd/yyyy)</i>:</b>
                            <asp:TextBox ID="txtHireDate" runat="server" style="width:100px" BackColor="#EFF3FB"></asp:TextBox>
                                <b><i>(See instructions for exemptions.)</i></b>

                        </td>
                    </tr>                      
                    <tr>
                        <td colspan="7">
                            <table style="width:100%; padding:2px; background-color:white;">
                                <tr>
                                <td style="width:33%;" ></td>
                                <td style="width:10%;"></td>
                                <td style="width:8%;"></td>
                                <td style="width:10%;"></td>
                                <td style="width:8%;" ></td>
                                <td style="width:11%;"></td>
                                <td style="width:8%;"></td>
                                    <td style="width:12%;"></td>
                            </tr>
                            <tr>
                                <td colspan="1" style="border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                                    Signature of Employer or Authorized Representative
                                </td>
                                <td  colspan="4" style="border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                                    Date <i>(mm/dd/yyyy)</i>
                                </td>
                                    <td  colspan="3" style="border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                                    Title of Employer or Authorized Representative
                                </td>
                            </tr>
                                <tr>
                                <td colspan="1" style="background-color: #EFF3FB;border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                                        <asp:textbox ID="txtEmployerSignature" TabIndex="20" runat="server" BackColor="#EFF3FB" style="width:100%; padding-left:1%;"></asp:textbox>
                                </td>
                                <td  colspan="4" style="background-color: #EFF3FB;border-right: #5f5c5c 1px solid;">
                                        <asp:textbox ID="txtEmployerSignatureDate" runat="server" TabIndex="21" BackColor="#EFF3FB" style="width:100%; padding-left:1%;"></asp:textbox>
                                </td>
                                    <td  colspan="3" style="background-color: #EFF3FB;border-right: #5f5c5c 1px solid;">
                                    <asp:textbox ID="txtEmployerTitle" runat="server" TabIndex="22" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                                </td>
                            </tr>
                            <tr>
                                <td style="border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                                    Last Name <i>(Family Name)</i>
                                </td>
                                <td  colspan="3" style="border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                                    First Name <i>(Given Name)</i>
                                </td>
                                    <td  colspan="4" style="border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                                    Employer's Business or Organization Name
                                </td>
                            </tr>
                            <tr>
                                <td  colspan="1" style="border-left: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid; background-color: #f5f5f5;">
                                        <asp:Textbox ID="txtAdminLastName" runat="server" TabIndex="23" BackColor="#EFF3FB" Width="100%"></asp:Textbox>
                                </td>
                                <td  colspan="3" style="border-right: #5f5c5c 1px solid; background-color: #f5f5f5;">
                                        <asp:Textbox ID="txtAdminFirstName" runat="server" TabIndex="24" BackColor="#EFF3FB" Width="100%"></asp:Textbox>
                                </td>
                                <td  colspan="4" style="border-right: #5f5c5c 1px solid; background-color: #f5f5f5; font-weight:bold;">
                                        <asp:Label ID="lblCompanyName" runat="server" ></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td  colspan="3" style="border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                                    Employer's Business or Organization Address
                                </td>
                                <td  colspan="3" style="border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                                    City or Town
                                </td>
                                    <td   style="border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                                    State
                                </td>
                                    <td  style="border-top: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                                    Zip
                                </td>
                            </tr>
                            <tr style="font-weight:bold;">
                                <td  colspan="3" style="border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid; background-color: #f5f5f5;">
                                        <asp:Label ID="lblCompanyAddress" runat="server" ></asp:Label>
                                </td>
                                <td  colspan="3" style="border-bottom: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid; background-color: #f5f5f5;">
                                    <asp:Label ID="lblCompanyCity" runat="server" ></asp:Label>
                                </td>
                                    <td   style="border-bottom: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid; background-color: #f5f5f5;">
                                    <asp:Label ID="lblCompanyState" runat="server" ></asp:Label>
                                </td>
                                    <td  style="border-bottom: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid; background-color: #f5f5f5;">
                                    <asp:Label ID="lblCompanyZip" runat="server" ></asp:Label>
                                </td>
                            </tr>                                  
                            </table>
                                    <br />
                                    <asp:Button ID="btnSave_Section2" text="SAVE SECTION 2" TabIndex="30" runat="server" CssClass="btn btn-primary pull-right" OnClick="btnSave_Section2_Click" />
                        </td>

                    </tr>

                </table>
            </div>
        </div>

        <div id="divSection3" runat="server" style="margin-right:5%;">
            <div id="divSection3Main">
                <table style="background-color:white;">
                    <tr>
                        <td colspan="7">
                            <br />
                            <table style="width:100%; padding:2px;">
                                <tr>
                                    <td style="width:30%;"></td>
                                    <td style="width:20%;"></td>
                                    <td style="width:10%;"></td>
                                    <td style="width:10%;"></td>
                                    <td style="width:20%;"></td>
                                </tr>
                                <tr>
                                    <th colspan="5" style="background-color: #cac6c6; border: #5f5c5c 1px solid; padding: 6px 6px 6px 6px;">
                                        Section 3. Reverification and Rehires

                                        <a  class="btn btn-default pull-right" href="https://www.uscis.gov/sites/default/files/files/form/i-9instr.pdf" target="_blank">Instructions</a>
                            <div style="font: italic 14px 'Arial';line-height: 16px;">
                                (To be completed and signed by employer or authorized representative.)</div>

                                    </th>
                                </tr>
                                <tr>
                                    <td colspan="3" style="background-color:lightgrey; border-right: #5f5c5c 1px solid; border-left: #5f5c5c 1px solid; border-bottom: #5f5c5c 1px solid;">
                                        <b>A.</b>&nbsp;New Name <i>(if applicable)</i>
                                        &nbsp;<asp:LinkButton runat="server" ID="btnNewNameHelp" OnClick="btnNewNameHelp_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>
                                    </td>
                                    <td colspan="2" style="background-color:lightgrey;border-right: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">
                                        <b>B.</b>&nbsp;Date of Rehire <i>(if applicable) 
                                        &nbsp;<asp:LinkButton runat="server" ID="btnRehireDateHelp" OnClick="btnRehireDateHelp_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>
                                        </i>
          
                                    </td>
                                </tr>
                                <tr style="background-color:white;">
                                    <td style="border-left: #5f5c5c 1px solid; ">                                           
                                        Last Name <i>(Family Name)</i>
                                    </td>
                                    <td>First Name <i>(Given Name)</i>
                                    </td>
                                    <td style="border-right: #5f5c5c 1px solid;">Middle Init
                                    </td>

                                    <td colspan="2" style="border-right: #5f5c5c 1px solid;">
                                        Date of Rehire (mm/dd/yyyy)
                                          
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-color: #EFF3FB; border-left: #5f5c5c 1px solid; border-bottom: #5f5c5c 1px solid;">
                                        <asp:TextBox ID="txtRHLastName" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:TextBox>
                                    </td>
                                    <td style="background-color: #EFF3FB; border-bottom: #5f5c5c 1px solid;">
                                        <asp:TextBox ID="txtRHFirstName" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:TextBox>
                                    </td>
                                    <td style="background-color: #EFF3FB; border-right: #5f5c5c 1px solid; border-bottom: #5f5c5c 1px solid;">
                                        <asp:TextBox ID="txtRHiddleInit" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:TextBox>
                                    </td>
                                    <td colspan="2" style="background-color: #EFF3FB; border-right: #5f5c5c 1px solid; border-bottom: #5f5c5c 1px solid;">
                                        <asp:TextBox ID="txtDateofRehire" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:TextBox>
                                    </td>

                                </tr>
                                <tr>
                                    <td colspan="5" >
                                        <%--help section 3 top goes here--%>
                                        <div id="divHelpSection3Top" runat="server" visible="false" style="background-color: #dff0d8; padding: 10%; margin-left: -6px; border: #5f5c5c 1px solid; ">
                                            <asp:Label ID="lblHelpSection3TopTitle" runat="server" Text="<strong>testing</strong>"></asp:Label>
                                            <asp:LinkButton runat="server" ID="btnHelpSection3" OnClick="btnHelpClose_Click" CssClass="pull-right "><i class="glyphicon glyphicon-remove-circle btn-lg " aria-hidden="true" ></i></asp:LinkButton>
                                            <br />
                                            <br />
                                            <asp:Label ID="lblHelpSection3TopText" runat="server" Text="Help text here"></asp:Label>
                                        </div>
                                    </td>
                                    </tr>
                                <tr>
                                    <td colspan="5" style="border: #5f5c5c 1px solid;background-color:lightgrey;">
                                        <b>C.</b>&nbsp;If employee's previous grant of employment authorization has expired, provide the information for the document from List A or List C the employee presented that establishes current employment authorization in the space provided below.
                                    </td>
                                </tr>
                                <tr style="background-color:white;">
                                    <td style="border-left: #5f5c5c 1px solid; border-right: #5f5c5c 1px solid;">
                                        Document Title
                                        &nbsp;<asp:LinkButton runat="server" ID="btnRVDocTitleHelp" OnClick="btnRVDocTitleHelp_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>
                                    </td>
                                    <td colspan="2" style="border-right: #5f5c5c 1px solid;">Document Number
                                        &nbsp;<asp:LinkButton runat="server" ID="btnRVDocNumHelp" OnClick="btnRVDocNumHelp_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>
                                    </td>
                                    <td colspan="2" style="border-right: #5f5c5c 1px solid;">
                                        Expiration Date <i>(if any) (mm/dd/yyyy) </i>
                                        &nbsp;<asp:LinkButton runat="server" ID="btnRVDocExpDateHelp" OnClick="btnRVDocExpDateHelp_Click" ><i class="glyphicon glyphicon-question-sign " aria-hidden="true" ></i></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-color: #EFF3FB; border-left: #5f5c5c 1px solid; border-right: #5f5c5c 1px solid; border-bottom: #5f5c5c 1px solid;">
                                        <asp:TextBox ID="txtS3DocTitle" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:TextBox>
                                    </td>
                                    <td colspan="2" style="background-color: #EFF3FB; border-bottom: #5f5c5c 1px solid; border-right: #5f5c5c 1px solid;">
                                        <asp:TextBox ID="txtS3DocNumber" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:TextBox>
                                    </td>

                                    <td colspan="2" style="background-color: #EFF3FB; border-bottom: #5f5c5c 1px solid; border-right: #5f5c5c 1px solid;">
                                        <asp:TextBox ID="txtS3DocExpDate" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="5">
                                        <%--help section 3 bottom goes here--%>
                                        <div id="divHelpSection3Bottom" runat="server" visible="false" style="background-color: #dff0d8; padding: 10px 10px 10px 10px; margin-left:-6px; border: #5f5c5c 1px solid;">
                                            <asp:Label ID="lblHelpSection3BottomTitle" runat="server" Text="<strong>testing</strong>"></asp:Label>
                                            <asp:LinkButton runat="server" ID="btnHelpSection3Bottom" OnClick="btnHelpClose_Click" CssClass="pull-right "><i class="glyphicon glyphicon-remove-circle btn-lg " aria-hidden="true" ></i></asp:LinkButton>
                                            <br />
                                            <br />
                                            <asp:Label ID="lblHelpSection3BottomText" runat="server" Text="Help text here"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr style="background-color:white;">
                                    <td colspan="5">
                                        <b>I attest, under penalty of perjury, that to the best of my knowledge, this employee is authorized to work in the United States, and if the employee presented document(s), the document(s) I have examined appear to be genuine and to relate to the individual.</b>
                                    </td>
                                </tr>
                                <tr style="background-color:white;">
                                    <td style="border-left: #5f5c5c 1px solid; border-top: #5f5c5c 1px solid; border-right: #5f5c5c 1px solid;">
                                        Signature of Employer or Authorized Representative
                                    </td>
                                    <td style="border-top: #5f5c5c 1px solid; border-right: #5f5c5c 1px solid;">
                                        Date <i>(mm/dd/yyyy)</i>
                                    </td>
                                    <td colspan="3" style="border-top: #5f5c5c 1px solid; border-right: #5f5c5c 1px solid;">
                                        Title of Employer or Authorized Representative
                                    </td>
                                </tr>
                                <tr>
                                    <td style="background-color: #EFF3FB; border-left: #5f5c5c 1px solid; border-bottom: #5f5c5c 1px solid; border-right: #5f5c5c 1px solid;">
                                        <asp:TextBox ID="txtS3Signature" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:TextBox>
                                    </td>
                                    <td style="background-color: #EFF3FB; border-bottom: #5f5c5c 1px solid; border-right: #5f5c5c 1px solid;">
                                        <asp:textbox ID="txtS3SignatureDate" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:textbox>
                                    </td>
                                    <td colspan="3" style="background-color: #EFF3FB; border-bottom: #5f5c5c 1px solid; border-right: #5f5c5c 1px solid;">
                                        <asp:TextBox ID="txtS3Title" runat="server" BackColor="#EFF3FB" style="width:100%"></asp:TextBox>
                                    </td>
                                </tr>
                            <tr>
                                <td colspan="8" style="background-color:#f8bac0;">
                                    <div id="divERSection3Error" runat="server" >
                                        <div class="col-lg-2" style="padding-top:10px;">
                                            <asp:Image ID="Image8" ImageUrl="../img/RedX.png" runat="server" style="width:80px" />
                                        </div>
                                        <div style ="font-weight:bold; font-size:large; padding:5px;">
                                            <asp:Label ID="lblSection3Error" runat="server" ></asp:Label>
                                        </div>                                 
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
            <div id="divSec3Save" class="form-group">
                <div class="col-md-12" style="padding-right:6%;">
                    <asp:Button ID="btnSave_Section3" text="SAVE SECTION 3" runat="server" CssClass="btn btn-primary pull-right" OnClick="btnSave_Section3_Click" />
                </div>
     `      </div>
        </div>

        <div id="divDocuments" runat="server" style="margin-right:5%;">
            <table class="table" style="width:100%; background-color:#fff;">
                <tr>
                    <td style="width:32%"></td>
                    <td style="width:1%"></td>
                    <td style="width:32%"></td>
                    <td style="width:1%"></td>
                    <td style="width:30%"></td>
                    <td style="width:3%"></td>
                </tr>
                <tr>
                    <th colspan="5" style="text-align:center;">
                        LIST OF ACCEPTABLE DOCUMENTS<br />
                        All documents must be UNEXPIRED
                    </th>
                </tr>
                <tr>
                    <td colspan="5" style="text-align:center">
                        Employees may present one selection from List A<br />
                        or a combination of one selection from List B and one selection from List C.
                    </td>
                </tr>
                <tr>
                    <th style="border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid; text-align:center">
                        LIST A<br />
                        Documents that Establish<br />Both Identity and<br />Employment Authorization
                    </th>
                    <th style="vertical-align:bottom; border-top: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;text-align:center">
                        OR
                    </th>
                     <th style="border-top: #5f5c5c 1px solid; border-bottom: #5f5c5c 1px solid; text-align:center;">
                        LIST B<br />
                        Documents that Establish<br />Identity
                    </th>
                    <th style="vertical-align:bottom; border-top: #5f5c5c 1px solid; border-bottom: #5f5c5c 1px solid; text-align:center">
                        AND
                    </th>
                     <th style="border-right: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;text-align:center">
                        LIST C<br />
                        Documents that Establish<br />Employment Authorization
                    </th>
                </tr>
                <tr>
                    <td style="border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">
                        <table class="table" >
                            <tr>
                                <td style="width:3%"></td>
                                <td style="width:3%"></td>
                                <td style="width:3%"></td>
                                <td style="width:94%"></td>
                            </tr>
                            <tr>
                                <td>
                                    <b>1.</b>
                                </td>
                                <td colspan="3" >
                                    U.S. Passport or U.S. Passport Card
                                </td>
                            </tr>
                            <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>2.</b>
                                </td>
                                <td colspan="3" style="border-top: #5f5c5c 1px solid;">
                                    Permanent Resident Card or Alien Registration Receipt Card (Form I-551)
                                </td>
                            </tr>
                            <tr>
                                <td style="border-bottom: #5f5c5c 1px solid;">
                                    <b>3.</b>
                                </td>
                                <td colspan="3" style="border-top: #5f5c5c 1px solid;">
                                    Foreign passport that contains a temporary I-551 stamp or temporary I-551 printed notation on a machinereadable immigrant visa
                                </td>
                            </tr>
                            <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>4.</b>
                                </td>
                                <td colspan="3" style="border-top: #5f5c5c 1px solid;">
                                   Employment Authorization Document that contains a photograph (Form I-766)
                                </td>
                            </tr>
                            <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>5.</b>
                                </td>
                                <td colspan="3" style="border-top: #5f5c5c 1px solid;">
                                   Employment Authorization Document that contains a photograph (Form I-766)
                                </td>
                            </tr>
                            <tr>
                                <td> </td>
                                 <td><b>a.</b> </td>
                                <td colspan="2" >
                                   Foreign passport; and
                                </td>
                            </tr>
                            <tr>
                                <td> </td>
                                 <td><b>b.</b> </td>
                                <td colspan="2" >
                                   Form I-94 or Form I-94A that has the following:
                                </td>
                            </tr>
                             <tr>
                                <td> </td>
                                 <td></td>
                                <td >(1)</td>
                                 <td>The same name as the passport;and</td>
                            </tr>
                            <tr>
                                <td> </td>
                                 <td></td>
                                <td >(2)</td>
                                 <td>An endorsement of the alien's nonimmigrant status as long as that period of endorsement has not yet expired and the proposed employment is not in conflict with any restrictions or limitations identified on the form.</td>
                            </tr>
                             <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>6.</b>
                                </td>
                                <td colspan="3" style="border-top: #5f5c5c 1px solid;">
                                   Passport from the Federated States of Micronesia (FSM) or the Republic of the Marshall Islands (RMI) with Form I-94 or Form I-94A indicating nonimmigrant admission under the Compact of Free Association Between the United States and the FSM or RMI                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="border-right: #5f5c5c 1px solid;border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;background-color:#cac6c6">
                       
                    </td>

                    <td style="border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">
                        <table style="width:100%" class="table">
                            <tr>
                                <td style="width:3%"></td>                               
                                <td style="width:97%"></td>
                            </tr>
                            <tr>
                                <td>
                                    <b>1.</b>
                                </td>
                                <td >
                                    Driver's license or ID card issued by a State or outlying possession of the United States provided it contains a photograph or information such as name, date of birth, gender, height, eye color, and address
                                </td>
                            </tr>
                            <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>2.</b>
                                </td>
                                <td  style="border-top: #5f5c5c 1px solid;">
                                    ID card issued by federal, state or local government agencies or entities, provided it contains a photograph or information such as name, date of birth, gender, height, eye color, and address
                                </td>
                            </tr>
                             <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>3.</b>
                                </td>
                                <td  style="border-top: #5f5c5c 1px solid;">
                                   School ID card with a photograph
                                </td>
                            </tr>
                             <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>4.</b>
                                </td>
                                <td  style="border-top: #5f5c5c 1px solid;">
                                   Voter's registration card
                                </td>
                            </tr>
                             <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>5.</b>
                                </td>
                                <td  style="border-top: #5f5c5c 1px solid;">
                                   U.S. Military card or draft record
                                </td>
                            </tr>
                            <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>6.</b>
                                </td>
                                <td  style="border-top: #5f5c5c 1px solid;">
                                   Military dependent's ID card
                                </td>
                            </tr>
                            <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>7.</b>
                                </td>
                                <td  style="border-top: #5f5c5c 1px solid;">
                                   U.S. Coast Guard Merchant Mariner Card
                                </td>
                            </tr>
                            <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>8.</b>
                                </td>
                                <td  style="border-top: #5f5c5c 1px solid;">
                                   Native American tribal document
                                </td>
                            </tr>
                            <tr>
                                <td colspan ="2" style="text-align:center;border-top: #5f5c5c 1px solid;">
                                    <b>For persons under age 18 who are unable to present a document listed above:</b>
                                </td>
                            </tr>

                            <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>10.</b>
                                </td>
                                <td  style="border-top: #5f5c5c 1px solid;">
                                   School record or report card
                                </td>
                            </tr>
                             <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>11.</b>
                                </td>
                                <td  style="border-top: #5f5c5c 1px solid;">
                                   Clinic, doctor, or hospital record
                                </td>
                            </tr>
                            <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>12.</b>
                                </td>
                                <td  style="border-top: #5f5c5c 1px solid;">
                                   Day-care or nursery school record
                                </td>
                            </tr>
                            </table>
                        </td>
                    <td style="border-bottom: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;border-left: #5f5c5c 1px solid;">  </td>
                    <td style="border-bottom: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;">
                        <table class="table">
                            <tr>
                                <td style="width:3%"></td>
                                <td style="width:3%"></td>
                                <td style="width:3%"></td>
                                <td style="width:80%"></td>
                                <td style="width:2%"></td>
                            </tr>
                            <tr>
                                <td>
                                    <b>1.</b>
                                </td>
                                <td colspan="3">A Social Security Account Number card, unless the card includes one of the following restrictions:
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    (1)
                                </td>
                                <td colspan="2">NOT VALID FOR EMPLOYMENT
                                </td>
                            </tr>
                             <tr>
                                <td></td>
                                <td>
                                    (2)
                                </td>
                                <td colspan="2">VALID FOR WORK ONLY WITH INS AUTHORIZATION
                                </td>
                            </tr>
                             <tr>
                                <td></td>
                                <td>
                                    (3)
                                </td>
                                <td colspan="2">VALID FOR WORK ONLY WITH DHS AUTHORIZATION
                                </td>
                            </tr>
                            <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>2.</b>
                                </td>
                                <td colspan="3" style="border-top: #5f5c5c 1px solid;">
                                    Certification of Birth Abroad issued by the Department of State (Form FS-545)
                                </td>
                            </tr>
                             <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>3.</b>
                                </td>
                                <td colspan="3" style="border-top: #5f5c5c 1px solid;">
                                   Certification of Report of Birth issued by the Department of State (Form DS-1350)
                                </td>
                            </tr>
                             <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>4.</b>
                                </td>
                                <td colspan="3" style="border-top: #5f5c5c 1px solid;">
                                  Original or certified copy of birth certificate issued by a State, county, municipal authority, or territory of the United States bearing an official seal 
                                </td>
                            </tr>
                            <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>5.</b>
                                </td>
                                <td colspan="3" style="border-top: #5f5c5c 1px solid;">
                                  Native American tribal document
                                </td>
                            </tr>
                             <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>6.</b>
                                </td>
                                <td colspan="3" style="border-top: #5f5c5c 1px solid;">
                                  U.S. Citizen ID Card (Form I-197)
                                </td>
                            </tr>
                             <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>7.</b>
                                </td>
                                <td colspan="3" style="border-top: #5f5c5c 1px solid;">
                                  Identification Card for Use of Resident Citizen in the United States (Form I-179)
                                </td>
                            </tr>
                             <tr>
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>8.</b>
                                </td>
                                <td colspan="3" style="border-top: #5f5c5c 1px solid;">
                                  Employment authorization document issued by the Department of Homeland Security
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th colspan="5" style="text-align: center">Illustrations of many of these documents appear in Part 8 of the Handbook for Employers (M-274).<br />
                        <br />
                        Refer to Section 2 of the instructions, titled "Employer or Authorized Representative Review<br />
                        and Verification," for more information about acceptable receipts.
                    </th>
                </tr>
            </table>
    </div>

    </div>

    <script>
            var toggleIsHide = true;

            $(".instruction_toggle").hide();
            $(".instruction_toggle_btn").click(function () {
                if (toggleIsHide == true) {
                    $(this).attr("src", "img/minus.png");
                } else {
                    $(this).attr("src", "img/plus.png")
                }
                $(".instruction_toggle").toggle();
                toggleIsHide = !toggleIsHide;
            });

     </script>
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


