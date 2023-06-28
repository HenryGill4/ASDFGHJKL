<%@ Page Title="Employee Post Offer Questionnaire" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_PostOfferQuestionnaire.aspx.vb" 
    Inherits="HReaseApp.EE_PostOfferQuestionnaire"
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
                <h4><b>Employment Post Offer Questionnaire</b></h4>
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
         
        <div id="divMainArticalTitleandText" class="well HRERewrap">
            <div id="divTitle" runat="server" class="form-group HRESlateBlue">
                    <h4><asp:Label ID="lblMainArticleTitle" runat="server" Text=""></asp:Label></h4>           
            </div>
            <div id="divText" runat="server" class="form-group HREWhite" >
                    <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div>

        <div class="well HREWhite HRERewrap" style="border: 1px solid black;">
            <table style="text-align:center; width:100%; border:1px solid black;">
              <tbody>
                <tr>
                  <td style="text-align: justify; padding:2%; background-color:white;">Fully and accurately providing the information below shall assist in ensuring a safe work environment for you and your colleagues. The
                    completion of this form and the information supplied shall only be used to make your employment more enjoyable and productive. This questionnaire will be kept confidential, securely filed and only accessed by individuals who are on a need-to-know basis. To ensure you
                    supply us with the most up-to-date information, please continue to update this information throughout the term of your employment.

                  </td>
                </tr>
              </tbody>
            </table>
            <table style="text-align:center; width:100%; border:1px solid black;">
              <caption style="padding: 1.5%; border:1px solid black;">
                PERSONAL INFORMATION
              </caption>
              <tbody>
                <tr>
                  <td style="width:25%; background-color:white; border: 1px solid black;" >
                        First Name:&nbsp;&nbsp;
                      <div style="width:99%; height: 50px; background-color:#DDE4FF; padding-left:2%;" >
                            <label><b><asp:Label ID="lblFirstName" runat="server" /></b></label>
                        </div>
                  </td>
                  <td style="width:25%; background-color:white; border: 1px solid black;">
                        Last Name:&nbsp;&nbsp;
                        <div style="width:99%; height: 50px; background-color:#DDE4FF; padding-left:2%;">
                            <label><b><asp:Label ID="lblLastName" runat="server" /></b></label>
                        </div>
                  </td>
                  <td style="width:50%; background-color:white; border: 1px solid black; height:auto;">
                        Client Worksite:
                        <div style="width:99%; height: 50px; background-color:#DDE4FF; padding-left:2%;" >
                            <label><b><asp:Label ID="lblCompanyName" runat="server" />
                                <br />
                            <asp:Label ID="lblCompanyFullAddress" runat="server" /></b></label>
                        </div>
                  </td>
                </tr>
              </tbody>
            </table>
            <table style="text-align:center; width:100%; border:1px solid black; background-color:white;">
                <caption style="padding: 1.5%; border:1px solid black;">
                EMPLOYMENT HISTORY
                </caption>
                <tbody>
                    <tr style="vertical-align:top;">                        
                        <td style="width:1%; padding:5px; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                            1. 
                        </td>
                        <td style="width:30%; padding:5px; border-top: 1px solid black; border-right: 1px solid black; border-bottom:1px solid black;">
                            Have you ever received treatment for a back, neck or knee condition or head injury?
                        </td>
                        <td style="width:7%; padding:5px; border: 1px solid black;">
                            <p>
                            <asp:CheckBox ID="chkYes1" runat="server" Text="&nbsp;Yes&nbsp;" autopostback="true" OnCheckedChanged="chkYes1_CheckedChanged" />
                            <br/>
                            <asp:CheckBox ID="chkNo1" runat="server" Text="&nbsp;No&nbsp;" autopostback="true" OnCheckedChanged="chkNo1_CheckedChanged" />
                            <br/>
                            </p>
                        </td>
                        <td style="width:20%; padding:5px; border: 1px solid black;">
                                <asp:CheckBox ID="chkNotSerious1" runat="server" Text="&nbsp;Not Serious&nbsp;" autopostback="true" OnCheckedChanged="chkNotSerious1_CheckedChanged"/>
                                <asp:CheckBox ID="chkSerious1" runat="server" Text="&nbsp;Serious&nbsp;" autopostback="true" />
                                <br/>
                                <asp:CheckBox ID="chkHadSurgery1" runat="server" Text="&nbsp;Had Surgery&nbsp;" autopostback="true" OnCheckedChanged="chkHadSurgery1_CheckedChanged"/>
                                <br/>
                        </td>
                        <td style="width:10%; padding:5px; border: 1px solid black;">
                            Date of
                            <br/>
                            injury:
                        </td>
                        <td style="width:10%; padding:5px; border: 1px solid black;">
                            <asp:TextBox ID="txtDate15" runat="server" style="width:99%; background-color:#DDE4FF;" />
                        </td>
                        <td style="width:10%; padding:5px; border: 1px solid black;">
                            <p>Date of last treatment:
                            </p>
                        </td>
                        <td style="width:10%; padding:5px; border: 1px solid black;">
                            <asp:TextBox ID="txtDate16" runat="server" style="width:99%; background-color:#DDE4FF;" />
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td style="width:1%; padding:5px; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                            2. 
                        </td>
                        <td style="width:30%; padding:5px; border-top: 1px solid black; border-right: 1px solid black; border-bottom:1px solid black;">
                            Suffered Aches or pains of the back?
                        </td>
                        <td style="width:7%; padding:5px; border: 1px solid black;">
                            <p>
                            <asp:CheckBox ID="chkYes2" runat="server" Text="&nbsp;Yes&nbsp;" autopostback="true" OnCheckedChanged="chkYes2_CheckedChanged"/>
                            <br/>
                            <asp:CheckBox ID="chkNo2" runat="server" Text="&nbsp;No&nbsp;" autopostback="true" OnCheckedChanged="chkNo2_CheckedChanged"/>
                            <br/>
                            </p>
                        </td>
                        <td style="width:13%; padding:5px; border: 1px solid black;">
                                <asp:CheckBox ID="chkNotSerious2" runat="server" Text="&nbsp;Not Serious&nbsp;" autopostback="true" OnCheckedChanged="chkNotSerious2_CheckedChanged"/>
                                <asp:CheckBox ID="chkSerious2" runat="server" Text="&nbsp;Serious&nbsp;" autopostback="true" OnCheckedChanged="chkSerious2_CheckedChanged"/>
                                <br/>
                                <asp:CheckBox ID="chkHadSurgery2" runat="server" Text="&nbsp;Had Surgery&nbsp;" autopostback="true" OnCheckedChanged="chkHadSurgery2_CheckedChanged" />
                                <br/>
                        </td>
                        <td style="width:10%; padding:5px; border: 1px solid black;">
                            Date of
                            <br/>
                            injury:
                        </td>
                        <td style="width:10%; padding:5px; border: 1px solid black;">
                            <asp:TextBox ID="txtDate17" runat="server" style="width:99%; background-color:#DDE4FF;" />
                        </td>
                        <td style="width:10%; padding:5px; border: 1px solid black;">
                            <p>Date of last treatment:
                            </p>
                        </td>
                        <td style="width:10%; padding:5px; border: 1px solid black;">
                            <asp:TextBox ID="txtDate18" runat="server" style="width:99%; background-color:#DDE4FF;" />
                        </td>
                    </tr>
              </tbody>
            </table>
            <table style="text-align:center; width:100%; border:1px solid black; background-color:white;">
              <tbody>
                <tr style="vertical-align:top;">
                    <td style="width:1%; padding:5px; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                        3. 
                    </td>
                    <td style="width:50%; padding:5px; border-top: 1px solid black; border-right: 1px solid black; border-bottom:1px solid black;">
                        Has any injury or illness ever prevented you from gainful employment?
                    </td>
                    <td style="width:7%; padding:5px; border: 1px solid black;">
                        <p>
                        <asp:CheckBox ID="chkYes3" runat="server" Text="&nbsp;Yes&nbsp;" autopostback="true" OnCheckedChanged="chkYes3_CheckedChanged"/>
                        <br/>
                        <asp:CheckBox ID="chkNo3" runat="server" Text="&nbsp;No&nbsp;" autopostback="true" OnCheckedChanged="chkNo3_CheckedChanged"/>
                        <br/>
                        </p>
                    </td>
                    <td style="width:20%; padding:5px; border: 1px solid black;">
                            <asp:CheckBox ID="chkNotSerious3" runat="server" Text="&nbsp;Not Serious&nbsp;" autopostback="true" OnCheckedChanged="chkNotSerious3_CheckedChanged"/>
                            <asp:CheckBox ID="chkSerious3" runat="server" Text="&nbsp;Serious&nbsp;" autopostback="true" OnCheckedChanged="chkSerious3_CheckedChanged"/>
                            <br/>
                            <asp:CheckBox ID="chkHadSurgery3" runat="server" Text="&nbsp;Had Surgery&nbsp;" autopostback="true" OnCheckedChanged="chkHadSurgery3_CheckedChanged"/>
                            <br/>
                    </td>
                    <td style="width:10%; padding:5px; border: 1px solid black;">
                    Date of incident:
                    </td>
                    <td style="width:10%; padding:5px;">
                      <asp:TextBox ID="txtDate19" runat="server" style="width:99%; background-color:#DDE4FF;" />
                    </td>
                </tr>
              </tbody>
            </table>
            <table style="text-align:center; width:100%; border:1px solid black; background-color:white;">
                <tbody>
                    <tr style="vertical-align:top;">
                        <td style="width:1%; padding:5px; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                            4. 
                        </td>
                        <td style="width:51%; padding:5px; text-align:left; border-top: 1px solid black; border-right: 1px solid black; border-bottom:1px solid black;">
                            Do you require any reasonable accommodations to perform the essential functions of your job?
                        </td>
                        <td style="width:7%; padding:5px; border: 1px solid black;">
                            <p>
                                <asp:CheckBox ID="chkYes4" runat="server" Text="&nbsp;Yes&nbsp;" autopostback="true" OnCheckedChanged="chkYes4_CheckedChanged"/>
                                <br/>
                                <asp:CheckBox ID="chkNo4" runat="server" Text="&nbsp;No&nbsp;" autopostback="true" OnCheckedChanged="chkNo4_CheckedChanged"/>
                            <br/>
                            </p>
                        </td>
                        <td style="width:45%; padding:5px; vertical-align: text-top; border: 1px solid black;">
                            <p>
                                If yes, please explain:
                            <br />
                                <asp:TextBox ID="Explain4" runat="server" style="width:99%; height:50px; background-color:#DDE4FF;" TextMode="MultiLine" Wrap="True" />
                            </p>
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td style="width:1%; padding:5px; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                            5. 
                        </td>
                        <td style="width:51%; text-align:left; border-top: 1px solid black; border-right: 1px solid black; border-bottom:1px solid black;">
                            Do you have any limitation(s) which may affect your ability to perform the essential functions of your job correctly?
                        </td>
                        <td style="width:7%; padding:5px; border: 1px solid black;">
                            <p>
                                <asp:CheckBox ID="chkYes5" runat="server" Text="&nbsp;Yes&nbsp;" autopostback="true" OnCheckedChanged="chkYes5_CheckedChanged" />
                                <br/>
                                <asp:CheckBox ID="chkNo5" runat="server" Text="&nbsp;No&nbsp;" autopostback="true" OnCheckedChanged="chkNo5_CheckedChanged"/>
                            <br/>
                            </p>
                        </td>
                        <td style="width:45%; padding:5px; vertical-align: text-top; border: 1px solid black;">
                            <p>
                                If yes, please explain:
                            <br />
                                <asp:TextBox ID="Explain5" runat="server" style="width:99%; height:50px; background-color:#DDE4FF;" TextMode="MultiLine" Wrap="True" />
                            </p>
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td style="width:1%; padding:5px; border-left:1px solid black; border-top: 1px solid black; border-bottom: 1px solid black;">
                            6. 
                        </td>
                        <td style="width:51%; padding:5px; text-align:left; border-top: 1px solid black; border-right: 1px solid black; border-bottom:1px solid black;">
                            Allergies or reactions to any serum or drug?
                        </td>
                        <td style="width:7%; border: 1px solid black;">
                            <p>
                                <asp:CheckBox ID="chkYes6" runat="server" Text="&nbsp;Yes&nbsp;" autopostback="true" OnCheckedChanged="chkYes6_CheckedChanged"/>
                                <br/>
                                <asp:CheckBox ID="chkNo6" runat="server" Text="&nbsp;No&nbsp;" autopostback="true" OnCheckedChanged="chkNo6_CheckedChanged"/>
                                <br/>
                            </p>
                        </td>
                        <td style="width:45%; vertical-align: text-top; border: 1px solid black;">
                            <p>
                                If yes, please explain:
                            <br />
                                <asp:TextBox ID="Explain6" runat="server" style="width:99%; height:50px; background-color:#DDE4FF;" TextMode="MultiLine" Wrap="True" />
                            </p>
                        </td>
                    </tr>
       
              </tbody>
            </table>
            <table style="text-align:center; width:100%; border:1px solid black; background-color:white;">
                <caption style="padding: 1.5%; border:1px solid black;">
                DETAIL – If you answered “Yes” to any item from #1 through #6 you must complete the following for each.
              </caption>
                <tbody>
                    <tr>
                        <td style="width:7%; text-align:center;border:1px solid black;">
                            Item
                                <br />
                            Number
                                <br />
                            Above
                        </td>
                        <td style="width:11%; text-align:center;border:1px solid black;">
                            Date of
                            <br />
                            Diagnosis
                        </td>
                        <td style="width:11%; text-align:center;border:1px solid black;">
                            Date of Last
                            <br />
                            Treatment
                        </td>
                        <td style="width:11%; text-align: center; border:1px solid black;">
                            Are you still receiving treatment?
                        </td>
                        <td style="width:28%; text-align: center; border:1px solid black;">
                            Does this, or will this ever affect your
                            ability to perform the essential functions 
                            of your work?
                        </td>
                        <td style="width:24%; text-align: center; border:1px solid black;">
                            Briefly describe the condition, injury or illness:</td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td>
                            <asp:TextBox ID="txtNumber28" runat="server" style="width:95%; background-color:#DDE4FF;" CssClass="center" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtDate20" runat="server" style="width:95%; background-color:#DDE4FF;" CssClass="center" />
                        </td>
                        <td style="border-right:1px solid black;">
                            <asp:TextBox ID="txtDate21" runat="server" style="width:95%; background-color:#DDE4FF;" CssClass="center" />
                        </td>       
                        <td>
                            <div style="border-bottom:1px solid black; text-align:center;">
                                <asp:CheckBox ID="chkYes7" runat="server" Text="&nbsp;Yes&nbsp;" autopostback="true" OnCheckedChanged="chkYes7_CheckedChanged"/>
                                <asp:CheckBox ID="chkNo7" runat="server" Text="&nbsp;No&nbsp;" autopostback="true" />
                                <br />
                            </div>
                            <div style="text-align:left;">
                                <asp:CheckBox ID="chkSometimes7" runat="server" Text="&nbsp;Sometimes&nbsp;" autopostback="true" OnCheckedChanged="chkSometimes7_CheckedChanged"/>
                                <br />
                                <asp:CheckBox ID="chkOften7" runat="server" Text="&nbsp;Often&nbsp;" autopostback="true" OnCheckedChanged="chkOften7_CheckedChanged"/>
                            </div>
                        </td>
                        <td style="text-align:center; border:1px solid black;">
                            <div style="border-bottom:1px solid black; text-align:center;">
                                <asp:CheckBox ID="chkYes8" runat="server" Text="&nbsp;Yes&nbsp;" autopostback="true" OnCheckedChanged="chkYes8_CheckedChanged"/>
                                <asp:CheckBox ID="chkNo8" runat="server" Text="&nbsp;No&nbsp;" autopostback="true" OnCheckedChanged="chkNo8_CheckedChanged"/>
                                <br />
                            </div>
                            <div style="padding-top:10px;">
                                <asp:CheckBox ID="chkSometimes8" runat="server" Text="&nbsp;Sometime&nbsp;" autopostback="true" OnCheckedChanged="chkSometimes8_CheckedChanged"/>
                                <asp:CheckBox ID="chkOften8" runat="server" Text="&nbsp;Often&nbsp;" autopostback="true" OnCheckedChanged="chkOften8_CheckedChanged"/>
                                <asp:CheckBox ID="chkMaybe8" runat="server" Text="&nbsp;Maybe&nbsp;" autopostback="true" OnCheckedChanged="chkMaybe8_CheckedChanged"/>
                            </div>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDetail47" runat="server" style="width:99%; height:50px; background-color:#DDE4FF;" TextMode="MultiLine" Wrap="True" />
                        </td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td>
                            <asp:TextBox ID="txtNumber29" runat="server" style="width:99%; background-color:#DDE4FF;" CssClass="center" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtDate22" runat="server" style="width:99%; background-color:#DDE4FF;" CssClass="center" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtDate23" runat="server" style="width:99%; background-color:#DDE4FF;" CssClass="center" />
                        </td>       
                        <td style="text-align:center; border:1px solid black;">
                            <div style="border-bottom:1px solid black; text-align:center;">
                                <asp:CheckBox ID="chkYes9" runat="server" Text="&nbsp;Yes&nbsp;" autopostback="true" OnCheckedChanged="chkYes9_CheckedChanged"/>
                                <asp:CheckBox ID="chkNo9" runat="server" Text="&nbsp;No&nbsp;" autopostback="true" OnCheckedChanged="chkNo9_CheckedChanged"/>
                                <br />
                            </div>
                            <div style="text-align:left;">
                                <asp:CheckBox ID="chkSometimes9" runat="server" Text="&nbsp;Sometimes&nbsp;" autopostback="true" OnCheckedChanged="chkSometimes9_CheckedChanged"/>
                                <br />
                                <asp:CheckBox ID="chkOften9" runat="server" Text="&nbsp;Often&nbsp;" autopostback="true" OnCheckedChanged="chkOften9_CheckedChanged"/>
                            </div>
                        </td>
                        <td style="text-align:center; border:1px solid black;">
                            <div style="border-bottom:1px solid black; text-align:center;">
                                <asp:CheckBox ID="chkYes10" runat="server" Text="&nbsp;Yes&nbsp;" autopostback="true" OnCheckedChanged="chkYes10_CheckedChanged"/>
                                <asp:CheckBox ID="chkNo10" runat="server" Text="&nbsp;No&nbsp;" autopostback="true" OnCheckedChanged="chkNo10_CheckedChanged"/>
                                <br />
                            </div>
                            <div style="padding-top:10px;">
                                <asp:CheckBox ID="chkSometimes10" runat="server" Text="&nbsp;Sometime&nbsp;" autopostback="true" OnCheckedChanged="chkSometimes10_CheckedChanged"/>
                                <asp:CheckBox ID="chkOften10" runat="server" Text="&nbsp;Often&nbsp;" autopostback="true" OnCheckedChanged="chkOften10_CheckedChanged"/>
                                <asp:CheckBox ID="chkMaybe10" runat="server" Text="&nbsp;Maybe&nbsp;" autopostback="true" OnCheckedChanged="chkMaybe10_CheckedChanged"/>
                            </div>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDetail48" runat="server" style="width:99%; height:50px; background-color:#DDE4FF;" TextMode="MultiLine" Wrap="True"  />
                        </td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td>
                            <asp:TextBox ID="txtNumber30" runat="server" style="width:99%; background-color:#DDE4FF;" CssClass="center" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtDate24" runat="server" style="width:99%; background-color:#DDE4FF;" CssClass="center" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtDate25" runat="server" style="width:99%; background-color:#DDE4FF;" CssClass="center" />
                        </td>       
                        <td style="text-align:center; border:1px solid black;">
                            <div style="border-bottom:1px solid black; text-align:center;">
                                <asp:CheckBox ID="chkYes11" runat="server" Text="&nbsp;Yes&nbsp;" autopostback="true" OnCheckedChanged="chkYes11_CheckedChanged"/>
                                <asp:CheckBox ID="chkNo11" runat="server" Text="&nbsp;No&nbsp;" autopostback="true" OnCheckedChanged="chkNo11_CheckedChanged"/>
                            </div>
                            <div style="text-align:left;">
                                <asp:CheckBox ID="chkSometimes11" runat="server" Text="&nbsp;Sometimes&nbsp;" autopostback="true" OnCheckedChanged="chkSometimes11_CheckedChanged"/>
                                <br />
                                <asp:CheckBox ID="chkOften11" runat="server" Text="&nbsp;Often&nbsp;" autopostback="true" OnCheckedChanged="chkOften11_CheckedChanged"/>
                            </div>
                        </td>
                        <td style="text-align:center; border:1px solid black;">
                            <div style="border-bottom:1px solid black; text-align:center;">
                                <asp:CheckBox ID="chkYes12" runat="server" Text="&nbsp;Yes&nbsp;" autopostback="true" OnCheckedChanged="chkYes12_CheckedChanged"/>
                                <asp:CheckBox ID="chkNo12" runat="server" Text="&nbsp;No&nbsp;" autopostback="true" OnCheckedChanged="chkNo12_CheckedChanged"/>
                                <br />
                            </div>
                            <div style="padding-top:10px;">
                                <asp:CheckBox ID="chkSometimes12" runat="server" Text="&nbsp;Sometime&nbsp;" autopostback="true" OnCheckedChanged="chkSometimes12_CheckedChanged"/>
                                <asp:CheckBox ID="chkOften12" runat="server" Text="&nbsp;Often&nbsp;" autopostback="true" OnCheckedChanged="chkOften12_CheckedChanged"/>
                                <asp:CheckBox ID="chkMaybe12" runat="server" Text="&nbsp;Maybe&nbsp;" autopostback="true" OnCheckedChanged="chkMaybe12_CheckedChanged"/>
                            </div>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDetail49" runat="server" style="width:99%; height:50px; background-color:#DDE4FF;" TextMode="MultiLine" Wrap="True"  />
                        </td>
                    </tr>
                    <tr style="border-bottom:1px solid black;">
                        <td>
                            <asp:TextBox ID="txtNumber31" runat="server" style="width:99%; background-color:#DDE4FF;" CssClass="center" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtDate26" runat="server" style="width:99%; background-color:#DDE4FF;" CssClass="center" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtDate27" runat="server" style="width:99%; background-color:#DDE4FF;" CssClass="center" />
                        </td>
                        <td style="text-align:center; border:1px solid black;">
                            <div style="border-bottom:1px solid black; text-align:center;">
                                <asp:CheckBox ID="chkYes13" runat="server" Text="&nbsp;Yes&nbsp;" autopostback="true" OnCheckedChanged="chkYes13_CheckedChanged"/>
                                <asp:CheckBox ID="chkNo13" runat="server" Text="&nbsp;No&nbsp;" autopostback="true" OnCheckedChanged="chkNo13_CheckedChanged"/>
                                <br />
                            </div>
                            <div style="text-align:left;">
                                <asp:CheckBox ID="chkSometimes13" runat="server" Text="&nbsp;Sometimes&nbsp;" autopostback="true" OnCheckedChanged="chkSometimes13_CheckedChanged"/>
                                <br/>
                                <asp:CheckBox ID="chkOften13" runat="server" Text="&nbsp;Often&nbsp;" autopostback="true" OnCheckedChanged="chkOften13_CheckedChanged"/>
                            </div>
                        </td>
                        <td style="text-align:center; border:1px solid black;">
                            <div style="border-bottom:1px solid black; text-align:center;">
                                <asp:CheckBox ID="chkYes14" runat="server" Text="&nbsp;Yes&nbsp;" autopostback="true" OnCheckedChanged="chkYes14_CheckedChanged"/>
                                <asp:CheckBox ID="chkNo14" runat="server" Text="&nbsp;No&nbsp;" autopostback="true" OnCheckedChanged="chkNo14_CheckedChanged"/>
                                <br />
                            </div>
                            <div style="padding-top:10px;">
                                <asp:CheckBox ID="chkSometimes14" runat="server" Text="&nbsp;Sometime&nbsp;" autopostback="true" OnCheckedChanged="chkSometimes14_CheckedChanged"/>
                                <asp:CheckBox ID="chkOften14" runat="server" Text="&nbsp;Often&nbsp;" autopostback="true" OnCheckedChanged="chkOften14_CheckedChanged"/>
                                <asp:CheckBox ID="chkMaybe14" runat="server" Text="&nbsp;Maybe&nbsp;" autopostback="true" OnCheckedChanged="chkMaybe14_CheckedChanged"/>
                            </div>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDetail50" runat="server" style="width:99%; height:50px; background-color:#DDE4FF;" TextMode="MultiLine" Wrap="True" />
                        </td>
                    </tr>
              </tbody>
            </table>
            <table style="text-align:center; width:100%; border:1px solid black; background-color:white; border:1px solid black;">
              <caption style="padding: 1.5%;">
                HISTORICAL ACKNOWLEDGMENT
              </caption>
              <tbody>
                <tr>
                  <td>I understand and agree that if I am injured on the job, regardless of how minor the injury may seem, I shall report the alleged injury
                    immediately to my supervisor and the Abel Risk Management Department at 609-860-0400. I acknowledge that my employer participates
                    in Drug-Free Workplace and Managed Care Programs, I shall participate in the Managed Care Program and I shall only be treated by a
                    Managed Care Provider authorized by my Employer. I certify the above answers to be true and correct. I understand that any false,
                    misleading or concealing of responses to the questions shall be sufficient reason for denial of benefits of any kind and basis for immediate
                    separation of employment. I hereby affirm that I have received a conditional offer of employment. I fully understand that the purpose of
                    my voluntarily completing this document is: (1) to determine whether I currently have the qualifications necessary to perform the essential
                    functions of the job that has been offered; (2) to determine whether and what reasonable accommodations may be necessary, if any and
                  (3) to determine whether I can perform the job without posing a significant direct threat to the health and safety of myself or others.</td>
                </tr>
              </tbody>
            </table>
            <table style="text-align:center; width:100%; border:1px solid black; background-color:white;">
                <tbody>
                    <tr>
                        <td style="width:72%">
                            Employee Signature:
                            <asp:TextBox ID="txtSignature" runat="server" style="width:99%; background-color:#DDE4FF; padding-left:1%;" />
                        </td>
                        <td style="width:28%">
                            Date Signed:
                            <asp:TextBox ID="txtSignatureDate" runat="server" style="width:99%; background-color:#DDE4FF; padding-left:1%;" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="row">
            <div class="clearfix">&nbsp;
            </div>
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 text-center" style="text-align: right;">
                <asp:ImageButton ID="btnSave" runat="server" ImageUrl="img/BlueSaveBtnNew.png" OnMouseOver="src='/img/BlueSaveBtnOverNew.png';" OnMouseOut="src='/img/BlueSaveBtnNew.png';" ImageAlign="Right" OnClick="btnSave_Click" />
            </div>
            <div class="clearfix">&nbsp;
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
</asp:Content >

