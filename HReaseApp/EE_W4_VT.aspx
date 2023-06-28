<%@ Page Title="VT State Withholding Page" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_W4_VT.aspx.vb" 
    Inherits="HReaseApp.EE_W4_VT" 
    MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" runat="Server">
    <div id="tabs">
        <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>
    </div>
</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainArticle" runat="Server">
 
    <%--<style>

        input[type=text] {
            background-color: #f0f4fa;
            border: 1px solid #e0eaf7 !important;
        }


        input[type="checkbox"] {
            width: 16px;
            height: 16px;
            cursor: pointer;
            padding-right:.8%;
        }

        p > b {
            font-size: 23px;
        }

        p {
            font-size: 22px;
        }

       .wrapper {
               width:100%;
		        margin:0 auto;
		        overflow:hidden;
                padding:20px;
            }

        .underline{
            border-bottom: 1px solid;
            width: 100%;
            display: inline-block;
        }
        .underline1 {
            border-bottom: 1px solid;
            width: 100%;
            display: inline-block;
        }
    </style>--%>

    <div style="width:100%; text-align:center;">
      <div class="HREwrapper" style="text-align:center; width:90%; align-self:center;" >
        <div id="PageTitle" style="width:98%; margin-left:auto; margin-right:auto;">
            <div style="text-align:center; width:100%;">
                <br />
               
                <br /><br />
            </div>
        </div>

        <div id="divTopHeader" class="form-group" style=" margin-top:-40px;">                  
            <div id="divError" runat="server" visible="false" class="HREError">
                <asp:Image ID="imgError" ImageUrl="../img/RedX.png" runat="server" Width="30px" />
                <asp:Label ID="lblError" runat="server" Text="There was an error."></asp:Label>
            </div>
            <div class="form-group" style="display:inline;">
                <div id="divSuccess" runat="server" visible ="false" class="HRESuccess">
                    <asp:Image id="imgSuccess" ImageUrl="../img/GreenCheck.png" runat="server" Width="50px" ImageAlign="Left" />
                    <asp:Label ID="lblSuccess" runat="server"  Text="Form Complete" Width="50%"></asp:Label>
                    <asp:ImageButton ID="imgNext" runat="server" ToolTip="NEXT" ImageAlign="Right" Width="80px" ImageUrl="../img/NextArrowInCircleBlueGreen.png" OnMouseOver="src='/img/NextArrowInCircleGreyNew.png';" OnMouseOut="src='/img/NextArrowInCircleBlueGreen.png';" OnClick="imgNext_Click" />
                    <asp:Image ID="imgProcessing" runat="server" src='/img/processing.gif' Visible="false" Width="80px" />
                </div>
            </div>
        </div>

         <div id="InstructionHeaderBar" class="well HRESlateBlue HRERewrap" style="text-align:center; width:95%; margin-bottom:3%;">
            <span> <b>INSTRUCTIONS </b> </span>
            <img src="img/plus.png" class="instruction_toggle_btn" style="float: right; width: 30px; padding-bottom:10px;" />

        </div>

        <div id="Instructions" class="instruction_toggle HREWhite" style="margin:auto; width:95%; margin-bottom:2%;">
            <div style="color:black; font-size:x-large; margin:auto; text-align:left; line-height:normal;">

                <p style="text-align:center; font-size:40px; line-height:80%;">
                    <strong>General Information</strong>
                </p>
                <span style="padding-left:1%; float:left;">
                    Form W-4VT is designed so that you can have as much “take-home pay” as possible without an income tax liability due to Vermont when you file your tax return. 
                    Each withholding allowance you claim on Line 5 above will reduce the amount of income you are taxed on and therefore the amount of Vermont income tax withheld 
                    each paycheck.<br /><br />
                </span>
                <p style="margin-top:2%; padding-left:1%;">
                    Here are some things to remember as you complete this form:<br />
                </p>
                <ul style="padding:2%; padding-left:7%; padding-top:1%; line-height:normal;">
                    <li style="margin-bottom:1%;">
                        Generally, dependents are children under 19 (or up to 24 if they are a full-time student) and any relatives who live with you and you support financially.
                    </li>
                    
                    <li style="margin-bottom:1%;">
                        If you and your spouse both claim your dependents on your respective W-4VTs, not enough income tax will be withheld, and you might end up with taxes due when you file. 
                        Only one spouse should claim the dependents.
                    </li>
                    <li style="margin-bottom:1%;">
                        If you entered an additional amount to be withheld on the federal W-4, consider entering 30% of that amount on Line 6.
                    </li>
                    <li style="margin-bottom:1%;">
                        If you have more than one employer, consider claiming zero allowances with the employer(s) where you earn less income.
                    </li>
                </ul>

            </div>
         
        </div>
       <div id="PersonalAllowancesHeaderBar" class="well HRESlateBlue HRERewrap" style="align-self:center; max-height:100px;  margin:auto; width:95%; margin-top:1% !important;" align="center">
	                 <span><b>PERSONAL ALLOWANCES WORKSHEET</b></span>
	                 <img src="img/plus.png" class="instruction_toggle_btn1" style="vertical-align:middle; float: right; width: 30px; max-height:100px; padding-bottom:10px;" />
                </div>
         <div id="PersonalAllowancesWorksheet" class="form-group instruction_toggle1 HREWhite" style="margin:auto; width:95%; text-align:center; border:1px solid black;">
            <div id="WorksheetInstructions" align="center" style=" width: 100%; text-align:center; ">
        <table style="width: 100%; margin-top:1%; background-color:white;">
            <tbody>
                <tr style="width: 100%; margin-left: 10px; margin-right: 10px;">
               
                    <td style="text-align: center; padding-top:1.5%; padding-bottom:1.5%;">
                        <div style="padding-top:5px;">
                            
                             <span style="font-size: xx-large; font-weight: 700; line-height: 0px;">
                             Vermont Allowances Worksheet
                            </span>
                        </div>
                    </td>
                    
                </tr>
            </tbody>
        </table>
    
    <div id="jsfirst" class="HREWhite" style="width: 100%; margin-right:0px; border:0px; margin-bottom:10%;text-align:center;" >
        

        <table style="width: 100%; background-color:white;  ">
            <tbody style="font-size:18px;">
                
                
                <tr style="width: 100%;margin-left: 10px; margin-right: 10px;">
                    <td style="width: 80%; padding-bottom:2%; margin-right:10%;">
                        <span style="float:left; padding-right:2%;">
                        <strong >1.</strong>
                        </span>
                        <span style="float:left; width:80%;">
                            Enter “1” for yourself if no one can claim you as a dependent
                        </span>
                    </td>
                    <td style="width: 20%; vertical-align:bottom; padding-bottom:2%;">
                       <span style="float:left; padding-right:2%;">
                        <strong>1.&nbsp;</strong>
                        </span>
                        <span style="float:left; width:fit-content; border-bottom: 2px solid;">
                            <asp:TextBox CssClass="center" ID="txtPW_BoxA" runat="server" style="border-bottom: 1px solid;" />
                        </span>
                    </td>
                </tr>
                <tr style="width: 100%;margin-left: 10px; margin-right: 10px; height:inherit;">
                    <td style="width: 80%; padding-bottom:2%;">
                        <span style="float:left; padding-right:2%;">
                        <strong >2.</strong>
                        </span>
                        <span style="float:left; width:80%;">
                           Enter “1” if you are filing jointly and your spouse does not work
                        </span>
                    </td>
                    <td style="width: 20%; vertical-align:bottom; padding-bottom:2%;">
                        <span style="float:left; padding-right:2%;">
                        <strong>2.&nbsp;</strong>
                        </span>
                        <span style="float:left; width:fit-content; vertical-align:bottom;  border-bottom: 2px solid;">
                        <asp:TextBox CssClass="center" ID="txtPW_BoxB" runat="server" style="border-bottom: 1px solid;" />
                        <br />
                        </span>
                    </td>
                </tr>
                <tr style="width: 100%;margin-left: 10px; margin-right: 10px;">
                    <td style="width: 80%; padding-bottom:2%; margin-right:10%;">
                        <span style="float:left; padding-right:2%;">
                        <strong >3.</strong>
                        </span>
                        <span style="float:left; width:80%;">
                           Enter the number of dependents you plan to claim on your tax return. If you file
                           jointly, then only one of you should claim the dependents on your W-4VT
                        </span>
                    </td>
                    <td style="width: 20%; vertical-align:bottom; padding-bottom:2%;">
                       <span style="float:left; padding-right:2%;">
                        <strong>3.&nbsp;</strong>
                        </span>
                        <span style="float:left; width:fit-content; border-bottom: 2px solid;">
                            <asp:TextBox CssClass="center" ID="txtPW_BoxC" runat="server" style="border-bottom: 1px solid;" />
                        </span>
                    </td>
                </tr>
                <tr style="width: 100%;margin-left: 10px; margin-right: 10px;">
                    <td style="width: 80%; padding-bottom:2%; margin-right:10%;">
                        <span style="float:left; padding-right:2%;">
                        <strong >4.</strong>
                        </span>
                        <span style="float:left; width:80%;">
                           Enter “1” if you plan to file as “head of household”
                        </span>
                    </td>
                    <td style="width: 20%; vertical-align:bottom; padding-bottom:2%;">
                       <span style="float:left; padding-right:2%;">
                        <strong>4.&nbsp;</strong>
                        </span>
                        <span style="float:left; width:fit-content; border-bottom: 2px solid;">
                            <asp:TextBox CssClass="center" ID="txtPW_BoxD" runat="server" style="" />
                        </span>
                    </td>
                </tr><tr style="width: 100%;margin-left: 10px; margin-right: 10px;">
                    <td style="width: 80%; padding-bottom:2%; margin-right:10%;">
                        <span style="float:left; padding-right:2%;">
                        <strong >5.</strong>
                        </span>
                        <span style="float:left; width:80%;">
                           Total number of Vermont allowances. (Add Lines 1 through 4 and enter total here.)
                        </span>
                    </td>
                    <td style="width: 20%; vertical-align:bottom; padding-bottom:2%;">
                       <span style="float:left; padding-right:2%;">
                        <strong>5.&nbsp;</strong>
                        </span>
                        <span style="float:left; width:fit-content; border-bottom: 2px solid; ">
                            <asp:TextBox CssClass="center" ID="txtTotalExemptions" runat="server" style="border-bottom: 1px solid;" />
                        </span>
                    </td>
                </tr>
                <tr style="width: 100%;margin-left: 10px; margin-right: 10px;">
                    <td style="width: 80%; padding-bottom:2%; margin-right:10%;">
                        <span style="float:left; padding-right:2%;">
                        <strong >6.</strong>
                        </span>
                        <span style="float:left; width:80%;">
                           Enter an additional amount, if any, you want withheld from each check
                        </span>
                    </td>
                    <td style="width: 20%; vertical-align:bottom; padding-bottom:2%;">
                        <span style="float:left; padding-right:2%;">
                        <strong >6.&nbsp;</strong>
                        </span>
                        <span style="float:left; width:fit-content; border-bottom: 2px solid;">
                            <asp:TextBox CssClass="center" ID="txtAdditionalWithholding" runat="server" style="border-bottom: 1px solid;" />
                        </span>
                    </td>
                </tr>

                <tr style="width: 100%;margin-left: 10px; margin-right: 10px;">
                    <td style="width: 80%; padding-bottom:2%; margin-right:10%;">
                        <span style="float:left; padding-right:2%;">
                        <strong >Exempt:</strong>
                        </span>
                        <span style="float:left; width:80%;">
                           If you had a right to a refund of all your Vermont income tax withheld last year because you
                           had no tax liability and you also expect to have no liability this year, write “Exempt” here
                        </span>
                    </td>
                    <td style="width: 20%; vertical-align:bottom; padding-bottom:2%; padding-left:2%;">
                        
                        <span style="float:left; width:fit-content; border-bottom: 2px solid;">
                            <asp:TextBox ID="TextBox1" runat="server" style="border-bottom: 1px solid;" />
                        </span>
                    </td>
                </tr>

            </tbody>
        </table>

        </div>
        </div>
        </div>

       <div style="width:95%; align-content:center;">

           <p style="text-align:center; font-size:40px; margin-top:2% !important;">
               Vermont Department of Taxes
           </p>
           <p style="text-align:center; font-size:45px; margin-top:2.5% !important;">
               <strong>Employee’s Withholding Allowance Certificate - Form W-4VT</strong>
           </p>
           <p style="text-align:center; font-size:40px; margin-top:3.5% !important;">
               All Vermont employees should complete this form.
           </p>
           <p style="text-align:center; font-size:40px; margin-top:2% !important;">
               <strong>To be filed with your employer.</strong>
           </p>

           <table style="border:4px solid black; margin-top:3%; margin-bottom:3%; border-collapse:collapse !important; font-size:x-large;">
               <tr>
                   <td class="HRETan" style="width:35%; padding-top:0.5%;  padding-left:2%; border:3px solid black; padding-bottom:.4%;">
                       <span>
                           Last Name<br /><br />
                       </span>
                       <span>
                           <strong><asp:label ID="lblLName" runat="server" Style="width: 70%;" /></strong>
                       </span>
                   </td>
                   <td class="HRETan" style="width:30%; padding-top:0.5%;  padding-left:2%; border:3px solid black; padding-bottom:.4%;">
                        <span>
                           First Name<br /><br />
                       </span>
                       <span>
                           <strong><asp:label ID="lblFName" runat="server" Style="width: 70%;" /></strong>
                       </span>
                   </td>
                   <td class="HRETan" style="width:10%; text-align:center; border:3px solid black; margin:auto !important; padding-top:0.5%; padding-bottom:.4%;">
                        <span>
                        Initial<br /><br />
                       </span>
                       <span>
                           <strong><asp:label ID="lblMiddleInitial" runat="server" Style="width: 70%;" /></strong>
                       </span>
                   </td>
                   <td class="HRETan" style="width:25%; padding-top:0.5%;  padding-left:2%; border:3px solid black; padding-bottom:.4%;">
                        <span>
                           Social Security Number<br /><br />
                       </span>
                       <span>
                           <strong><asp:label ID="lblSSNumber" runat="server" Style="width: 70%;" /></strong>
                       </span>
                   </td>
               </tr>
               <tr>
                   <td colspan="4" style="padding-top:0.5%; padding-bottom:2%; text-align:center;">
                       <p style="padding-left:2%; text-align:left;">
                        Filing Status - Check ONE<br />
                       </p>
                      
                       <div style="width:80%; align-self:center;">
                      <span class="height1">
                       <span style=" float:left;">
                           <asp:CheckBox ID="chkSingle" runat="server" AutoPostBack="true"  OnCheckedChanged="chkSingle_CheckedChanged"/>&nbsp;&nbsp;
                          </span>  
                           <span class="vertalign" style="padding-right:5%; float:left;">Single<br /></span>
                      </span>
                      <span class="height1"> 
                           <span style=" float:left;">
                           <asp:CheckBox ID="chkMarried" runat="server" Autopostback="true" OnCheckedChanged="chkMarried_CheckedChanged"/>&nbsp;&nbsp;
                            </span>
                           <span class="vertalign" style="padding-right:5%; float:left;">Married/Civil Union<br />
                            Filing Jointly</span>
                      </span>
                      <span class="height1">
                           <span style=" float:left;">
                           <asp:CheckBox ID="MarriedFilingSep" runat="server"  autopostback="true" OnCheckedChanged="MarriedFilingSep_CheckedChanged"/>&nbsp;&nbsp;
                           </span>
                           <span class="vertalign" style="padding-right:4%; float:left;">Married/Civil Union<br />
                            Filing Separately</span>
                       </span>
                       <span class="height1">
                           <span style=" float:left;">
                           <asp:CheckBox ID="chkMarriedWithholdHigher" runat="server"  autopostback="true" OnCheckedChanged="chkMarriedWithholdHigher_CheckedChanged"/>&nbsp;&nbsp;
                           </span>
                           <span class="vertalign" style=" float:left;">Married, but withhold<br />at higher single rate</span>
                       </span>
                       </div>

                      
                   </td>
               </tr>
           </table>

           <table style="font-size:x-large;">
               <tr>
                   <td style="font-size:xx-large; padding-bottom:.8%;">
                    <span><strong>Signature</strong></span>
                   </td>
               </tr>
               <tr>
                   <td style="padding-top:.5%; padding-left:1%; padding-right:1%; border:5px solid black; padding-bottom:.5%;">
                       <p style="margin-bottom:4%;">
                           I certify that I am entitled to the number of withholding allowances claimed on this certificate.
                       </p>
                       
                       <div style="width:98%; align-content:center;">
                           
                           <div style="width:95%; border-bottom:3px solid black; height:contain;">
                            <asp:TextBox ID="txtSignature" runat="server" style="margin-right:1%; width:58%; margin-bottom:3px;" placeholder="Type in your Full Name to represent your signature." />
                            <asp:TextBox ID="txtSignatureDate" runat="server" style=" Width: 40.5%; margin-bottom:3px; margin-right:0px;" />
                           </div>
                           <div style="width:95%; height:contain;">
                           <span style="width:58% !important; float:left;">
                               Employee’s Signature
                           </span>
                           <span style="width:40.5% !important; margin-left:1.5%; float:left;">
                               Date
                           </span>
                               </div>
                           </div>
                       
                   </td>
               </tr>
           </table>






       </div>

       <%-- <div style="border: 2px solid black;">
                <div class="underline" style="width: 100%; border-bottom:1px solid black;">
                    <div class="" style="width: 10%; float: left">
                        <p style="background-color: #000; color: #fff;  text-align: center; height: 50px;"><b>Part-1</b></p>
                    </div>
                    <div class="" style="width: 50%; float: left; padding-left: 2%;">
                        <p style="font-size: large; padding-top: 15px; padding-right:5%;">
                            First Name:
                        <b><asp:label ID="lblFName" runat="server" Style="width: 22%; padding-right:5%;" /></b>
                            Initial:
                        <b><asp:label ID="lblMiddleInitial" runat="server" Style="width: 12%; padding-right:5%;" /></b>
                            Last Name:
                        <b><asp:label ID="lblLName" runat="server" Style="width: 21%;" /></b>
                        </p>
                    </div>
                    <div class="" style="width: 10%; float: left">
                        <div>
                            <p style="background-color: #000; color: #fff; padding: 10px; text-align: center; height: 50px;"><b>Part-2</b></p>
                        </div>
                    </div>
                    <div class="" style="width: 30%; float: right; padding-left: 2%;">
                        <p style="font-size: large; padding-top: 15px;">
                            Social Security Number:
                        <b><asp:label ID="lblSSNumber" runat="server" Style="width: 25%;" /></b>
                        </p>
                    </div>
                </div>
           
            <div class="underline" style="margin-bottom: 2px;">
                <div class="" style="width: 100%; margin-top: 3px; clear: both;">
                    <div class="" style="padding: 0px; width: 150px; float: left">
                        <div>
                            <p style="background-color: #000; color: #fff; padding: 10px; text-align: center; margin-bottom: 0px; "><b>Part-3</b></p>
                        </div>
                    </div>
                    <div class="" style="width: 900px; float: left">
                        <p style="font-size: 16px; padding-top: 15px; padding-left:11px;">
                            Employee Number:
                        <asp:TextBox ID="lblEmployeeNo" runat="server" Style="width: 84%" />
                        </p>
                        <span style="font-size: 14px">(or other employer information required by employer)</span>
                    </div>
                </div>
            </div>
            <div class="" style="margin-bottom: 2px; clear: both;">
                <div class="underline1" style="width: 100%; margin-bottom: 3px;">
                    <div class="" style="padding: 0px; width: 150px; float: left">
                        <div>
                            <p style="background-color: #000; color: #fff; padding: 10px; text-align: center; margin-bottom: 0px"><b>Part-4</b></p>
                        </div>
                    </div>
                    <div class="" style="width: 70%; float: left; margin-top: 20px; padding-left:12px;">
                       <p><b>a.</b>Is your Vermont filing status:</p>
                        <span style="font-size: 18px; padding-right: 95px; padding-left: 96px;">
                            <asp:CheckBox ID="chkSingle" runat="server" Text="Single" AutoPostBack="true"  OnCheckedChanged="chkSingle_CheckedChanged"/>
                        </span>
                        <span style="font-size: 18px; padding-right: 65px;">
                            <asp:CheckBox ID="chkMarried" runat="server" Text="Married" Autopostback="true" OnCheckedChanged="chkMarried_CheckedChanged"/></span>
                        <span style="font-size: 18px; padding-right: 65px;">&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:CheckBox ID="chkMarriedWithholdHigher" runat="server" Text="Married, but withhold at the higher Single rate" autopostback="true" OnCheckedChanged="chkMarriedWithholdHigher_CheckedChanged"/>
                        </span>
                        <p style="font-size: 18px; padding-left: 263px;">
                            <asp:CheckBox ID="chkCivilUnion" runat="server" Text="Civil Union" />
                            <span style="font-size: 18px; padding-left: 58px">
                                <asp:CheckBox ID="chkCivilUnionHigher" runat="server" Text="Civil Union, but withhold at the higher Single rate" />
                            </span>
                        </p>
                        <p>
                             <b>b.</b>Total number of Vermont Withholding allowances .
                            <asp:TextBox ID="txtTotalExemptions" runat="server" Style="border: 1px solid #000; width: 140px; text-align:center;" />
                        </p>
                        <p>
                            <b>c.</b> Additional amount, if any, of Vermont tax to be withheld from each paycheck.
                            <asp:TextBox ID="txtAdditionalWithholding" runat="server" Style="width: 12%; text-align:center;" />
                        </p>
                       
                       </div>      
                    </div>
                </div>


                <div class="" style="margin-bottom: 3px; border-top: 1px solid #000; width: 100%;">
                    <div class="row" style="width:100%;">  
                        <div style="padding: 0px; width: 10%; float: left">
                            <p style="background-color: #000; color: #fff; padding: 10px; text-align: center; margin-bottom: 0px"><b>Part-5</b></p>                
                        </div>                   
                
                        <div class="notice" style="width:90%;" >
                            <p style="float:left; padding-left:1.4%;">I certify that I am entitled to the number of withholding allowances claimed on this certificate</p>
                        </div>
                    </div>
                    <div class="row" style="width:100%;">
                        <div class="row" style="margin-top:20px;">
                            <div class="col-md-12" style="padding-left:10%;">
                                <div class="col-md-8">
                                    <b class="underline" ><asp:TextBox ID="txtSignature" runat="server" style="padding-left:5px; width:100%;" placeholder="Type in your Full Name to represent your signature." /></b>
                                    <p> Signature </p>
                                </div>
                                <div class="col-md-4"style="padding-left:0px;">
                                    <b class="underline"><asp:TextBox ID="txtSignatureDate" runat="server" style="padding-left:5px; Width: 100%" /></b>
                                    <p> Date </p>
                                </div>
                           </div>    
	                    </div>
                    </div>
            </div>--%>

             <div id="divFormFooter" class="row HRERewrap">
                    <br />
                    <br />
                    <div style="float: right;">
                        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" TabIndex="22" ValidationGroup="valw4" OnClick="btnSave_Click" />
                    </div>
                </div>

    </div>
            
    </div>    
    
    <script>
        var toggleIsHide = true;
        var toggleIsHide1 = true;
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

        $(".instruction_toggle1").hide();
        $(".instruction_toggle_btn1").click(function () {
            if (toggleIsHide1 == true) {
                $(this).attr("src", "img/minus.png");
            } else {
                $(this).attr("src", "img/plus.png")
            }
            $(".instruction_toggle1").toggle();
            toggleIsHide1 = !toggleIsHide1;
        });
    </script>
    <style>
        .vertalign{
            vertical-align:middle;
            padding-top:1.5%;
            padding-bottom:1.5%;
        }
        .height1{
            height:contain;
        }
        .allowancesSheet {
            width: 100%;
            height: 635px;
            padding: 50px;
            border: 1px solid #333;
            margin-left: -2px;
        }

        input[type="checkbox"] {
            width: 70px;
            height: 70px;
            cursor: pointer;
            background: #f0f4fa;
            display: inline-block;
            padding-left: 3px;
            padding-right: 3px;
            color: black;
            
        }

        input[type=text], textarea {
            outline: none;
            min-height: 20px;
            background-color: #f0f4fa;
            border: 1px solid #e0eaf7 !important;
        }
        
        input[type="label"] {
            background-color: #f5f5f0;
        }

         table {
            background-color: white;
            color: black !important;
            border-collapse: collapse;
            border-spacing: 0px 5px;
        }

        .hr {
            display: block;
            overflow: hidden;
            border-style: inset;
            border-width: 1px;
            border-top: 5px solid #0c0d0e;
        }

        .vlsm {
            border-left: 5px solid #0c0d0e;
            height: 389px;
            position: absolute;
            left: 22%;
            /* margin-left: -3px; */
            top: 298px;
        }

        .hrSecon {
            display: block;
            overflow: hidden;
            border-style: inset;
            border-width: 1px;
            border-top: 1px solid #0c0d0e;
        }

        .ewvwnueBox {
            width: 100%;
            height: 635px;
            padding: 50px;
            border: 1px solid #333;
            margin-left: -2px;
        }

        .wrapper {
            width: 100%;
            margin: 0 auto;
            overflow: hidden;
            padding: 20px;
        }

         p {
            color: black !important;
        }

         li {
            color: black !important;
            
        }

         div {
            color: black !important;
            margin:auto !important;
        }

         .HREwrapper {
            margin-left: 5%;
            margin-right: 5%;
        }

        .HRESlateBlue {
            background-color: #ccd5e4;
        }

        .HREWhite {
            background-color: white;
            border: 1px solid grey;
            padding: 10px;
        }

        .HREOffWhite {
            background-color: #F9F9F9;
        }

        .HRETan {
            background-color: #f5f5f0;
            padding-left: 5px;
        }

        .HRELightBlue {
            background-color: #EFF3FB;
        }

        .HRERewrap {
            margin-right: 5%;
        }

        .HREpadR10 {
            padding-right: 20px;
            float: right;
        }

        .underline {
            border-bottom: 1px solid !important;
            width: 100%;
            display: inline-block;
        }

        .HREError {
            color: red;
            font-weight: bold;
            background-color: #f2dede;
            padding: 10px 10px 10px 10px;
            margin-right: 5%;
            text-align: center;
        }

        .HRESuccess {
            color: green;
            font-weight: bold;
            font-size: x-large;
            background-color: #fff;
            padding: 10px 10px 10px 10px;
            text-align: center;
        }

    </style>
   
</asp:Content>
