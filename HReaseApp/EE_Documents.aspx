<%@ Page Title="EE Documents" 
    Language="vb" 
    AutoEventWireup="false" 
    MasterPageFile="~/AppMasterHeader.Master" 
    CodeBehind="EE_Documents.aspx.vb" 
    Inherits="HReaseApp.EE_Documents" 
    MaintainScrollPositionOnPostback="true"%>

<asp:Content ID="TopMenu" ContentPlaceHolderID="mainMenu" Runat="Server">
    <asp:Literal ID="LiteralTopMenu" runat="server"></asp:Literal>   
</asp:Content>

<asp:Content ID="Tab" ContentPlaceHolderID="Tabs" Runat="Server">
      <div id="tabs">
           <asp:Literal ID="LiteralTab" runat="server"></asp:Literal>   
    </div> 
</asp:Content>

<asp:Content ID="MainArticle" ContentPlaceHolderID="MainArticle" runat="server" onload="I9Hide()">
    
    <div class="HREwrapper">
        <div id="divPageTitle">
            <div>
                <br />
                <h4><b>Employee Document Management</b></h4>
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

        <div id="divMainArticalTitleandText" runat="server" class="well HRESlateBlue HRERewrap">
            <div id="divTitle" runat="server" class="form-group HRESlateBlue">
                    <h4><asp:Label ID="lblMainArticleTitle" runat="server" Text=""></asp:Label></h4>           
            </div>
            <div id="divText" runat="server" class="form-group HREWhite" >
                    <asp:Label ID="lblMainArticleText" runat="server"></asp:Label>
            </div>
        </div>
         
        <div id="divDocumentsLoaded" class="well HREWhite HRERewrap">
            <b>Documents Loaded:</b>
            <br/><br/>
            
            <asp:GridView ID="grdEEDocs" runat="server" RowStyle-BackColor="#f5f5f5"
                DataKeyNames="EmployeeDocumentId,CompanyId,EmployeeId,DocumentCategoryId,DocumentTypeId,DocumentSubTypeId" 
                AutoGenerateColumns="False" 
                Width="100%" 
                HorizontalAlign="Center"
                GridLines="None" 
                BorderColor="#3276B1"
                CellPadding="4">    
                        <Columns >
                            <asp:BoundField HeaderText="EmployeeDocumentId" DataField="EmployeeDocumentId" Visible="false"></asp:BoundField>     
                            <asp:BoundField HeaderText="DocumentCategoryId" DataField="DocumentCategoryId" Visible="false"></asp:BoundField>
                            <asp:BoundField HeaderText="DocumentTypeId" DataField="DocumentTypeId" Visible="false"></asp:BoundField>
                            <asp:BoundField HeaderText="DocumentSubTypeId" DataField="DocumentSubTypeId" Visible="false"></asp:BoundField>
                            
                            <asp:BoundField HeaderText="Support Type" DataField="DocumentType"></asp:BoundField>
                            <asp:BoundField HeaderText="Document Type" DataField="DocumentSubType"></asp:BoundField>
                            <asp:BoundField HeaderText="Document Name" DataField="DocumentName"></asp:BoundField>

                            <asp:BoundField HeaderText="Document Link" DataField="DocumentLink" HtmlEncode="false" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></asp:BoundField>

                           <asp:TemplateField ItemStyle-Width="18%">
                                <ItemTemplate>

                                    <button type="button" class="roundbtn" style="margin: 10px auto 10px auto !important;" data-toggle="modal" data-target="#DeleteWarning" >Delete</button>
                                    <div class="modal fade" id="DeleteWarning" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h6 class="modal-title" ></h6>
                                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <h4>Are you sure you want to delete this file?</h4>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" Visible="true" HtmlEncode="false" CssClass="btn btn-primary" AutoPostBack="true" OnClick="btnSaveDelete_Click" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                   
                              
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>                       
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Center"  />
                    </asp:GridView>
            
        </div>
        
        <div id="divDocumentsNeeded" class="well HREWhite HRERewrap" >
            <b>Documents Needed:</b>
            <br/><br/>
            
            <asp:GridView ID="grdEEDocsNeeded" runat="server" 
                DataKeyNames="CompanyId,EmployeeId,DocumentTypeId,DocumentType" 
                AutoGenerateColumns="False" 
                Width="100%" 
                HorizontalAlign="Center"
                GridLines="None" 
                BorderColor="#3276B1"
                CellPadding="4">    
                        <Columns >
                            <asp:BoundField HeaderText="DocumentTypeId" DataField="DocumentTypeId" Visible="false"></asp:BoundField>
                            <asp:BoundField HeaderText="Document Type" DataField="DocumentType"></asp:BoundField>
                            <asp:BoundField HeaderText="Document Needed" DataField="DocumentNeeded"></asp:BoundField>                 
                        </Columns>                       
                        <HeaderStyle CssClass="grdHeaderrow" HorizontalAlign="Left" />
                        <RowStyle CssClass="grdNormalrow" HorizontalAlign="Center"  />
                    </asp:GridView>

        </div>

        <div id="divImportNewDoc" class="well HRELightBlue HRERewrap" style="text-align:left;" >
            <table style="background-color:transparent;">
                <tr>
                    <td style="width:20%;"></td>
                    <td style="width:30%;"></td>
                    <td style="width:20%;"></td>
                    <td style="width:20%;"></td>
                    <td style="width:2%;"></td>
                    <td style="width:8%;"></td>
                </tr>
                <tr>
                    <td colspan="5">
                        <b>Upload New Documents:</b>
                        <br/><br/>
                    </td>
                </tr>
                <tr>
                    <td colspan ="1">
                        <asp:DropDownList ID="ddlDocumentTypeList" runat="server" CssClass="form-control" DataValueField="DocumentTypeId" DataTextField="LongDesc" AutoPostBack="true" OnSelectedIndexChanged="ddlDocumentTypeList_SelectedIndexChanged"></asp:DropDownList>
                    </td>
                    
                    <td colspan ="1">
                        <asp:DropDownList ID="ddlDocumentSubTypeList" runat="server" CssClass="form-control" DataValueField="DocumentSubTypeId" DataTextField="LongDesc"></asp:DropDownList>
                    </td>
                    
                    <td colspan="2">
                        <asp:FileUpload ID="fuUploadDoc" runat="server" CssClass="form-control" ViewStateMode="Enabled" />

                    </td>
                    <td colspan="1" style="display:none;">
                        <asp:Label ID ="lblFileUpload" runat="server" CssClass="form-control" Visible="false" ></asp:Label>
                    </td>
                   
                    <td colspan="4" style="margin:auto; padding-right:10px;">
                        <asp:Button ID="btnSaveNew" runat="server" cssclass="roundbtn fix2" Text="Save" Visible="true"  autopostback="true" OnClick="btnUpload_click" />
                    </td>
                </tr>
                
        </table>
        </div>
        <script>
            function ShowI9() {
                document.getElementById("divI9Documents").classList.toggle("I9Show");
                document.getElementById("plus1").classList.toggle("hidden");
                document.getElementById("minus1").classList.toggle("hidden");
            }
        </script>
        <%--<button class="browse btn btn-secondary " type="button"><i class="fa fa-folder"></i></button>--%>
        <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet' />
        <div id="divI9Documents" class="well HREWhite HRERewrap">
            <div onclick="ShowI9()" id="I9showbtn" style="width:30px; height:30px; float:right; margin-right:80px; padding-top:15px; z-index:100;">
                <i id="plus1" class='bx bx-plus-circle' style="font-size:80px;"></i>
                <i id="minus1" class='bx bx-minus-circle hidden' style="font-size:80px;"></i>
            </div>
            <table style="background-color: #FFF;">
                <tr>
                    <td style="width:2%;"></td>
                    <td style="width:32%;"></td>
                    <td style="width:1%;"></td>
                    <td style="width:32%;"></td>
                    <td style="width:1%;"></td>
                    <td style="width:30%;"></td>
                    <td style="width:2%;"></td>
                </tr>
                <tr>
                    <th colspan="7" style="text-align:center; padding-top:10px;">
                        LIST OF ACCEPTABLE I-9 DOCUMENTS<br />
                        All documents must be UNEXPIRED
                    </th>
                </tr>
                <tr>
                    <td colspan="7" style="text-align:center">
                        Employees may present one selection from List A<br />
                        or a combination of one selection from List B and one selection from List C.
                    </td>
                </tr>
                <tr>
                    <td colspan="1"></td>
                    <td colspan="1" style="border-left: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid; text-align:center">
                        LIST A<br />
                        Documents that Establish<br />Both Identity and<br />Employment Authorization
                    </td>
                    <td colspan="1" style="vertical-align:bottom; border-top: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;text-align:center">
                        OR
                    </td>
                    <td colspan="1" style="border-top: #5f5c5c 1px solid; border-bottom: #5f5c5c 1px solid; text-align:center;">
                        LIST B<br />
                        Documents that Establish<br />Identity
                    </td>
                    <td colspan="1" style="vertical-align:bottom;border-top: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;text-align:center">
                        AND
                    </td>
                     <td colspan="1" style="border-right: #5f5c5c 1px solid;border-top: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;text-align:center">
                        LIST C<br />
                        Documents that Establish<br />Employment Authorization
                    </td>
                    <td colspan="1"></td>
                </tr>
                <tr>
                    <td colspan="1"></td>
                    <td style="border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid; padding-left:10px;">
                        <table class="table" style="background-color:white;">
                            <tr>
                                <td style="width:3%"></td>
                                <td style="width:3%"></td>
                                <td style="width:3%"></td>
                                <td style="width:91%"></td>
                            </tr>
                            <tr style="border-bottom: #5f5c5c 1px solid;">
                                <td colspan ="1">
                                    <b>1.</b>
                                </td>
                                <td colspan="3">
                                    U.S. Passport or U.S. Passport Card
                                </td>
                            </tr>
                            <tr style="border-bottom: #5f5c5c 1px solid;">
                                <td colspan ="1" >
                                    <b>2.</b>
                                </td>
                                <td colspan="3">
                                    Permanent Resident Card or Alien Registration Receipt Card (Form I-551)
                                </td>
                            </tr>
                            <tr style="border-bottom: #5f5c5c 1px solid;">
                                <td colspan="1">
                                    <b>3.</b>
                                </td>
                                <td colspan="3">
                                    Foreign passport that contains a temporary I-551 stamp or temporary I-551 printed notation on a machinereadable immigrant visa
                                </td>
                            </tr>
                            <tr style="border-bottom: #5f5c5c 1px solid;">
                                <td colspan="1">
                                    <b>4.</b>
                                </td>
                                <td colspan="3" >
                                   Employment Authorization Document that contains a photograph (Form I-766)
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1">
                                    <b>5.</b>
                                </td>
                                <td colspan="3">
                                   Employment Authorization Document that contains a photograph (Form I-766)
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1"> </td>
                                <td colspan="1">
                                    <b>a.</b> 
                                </td>
                                <td colspan="2" >
                                   Foreign passport; and
                                </td>
                            </tr>
                            <tr>
                                <td colspan="1"> </td>
                                <td colspan="1">
                                    <b>b.</b> 
                                </td>
                                <td colspan="2" >
                                   Form I-94 or Form I-94A that has the following:
                                </td>
                            </tr>
                             <tr>
                                <td colspan="1"></td>
                                <td colspan="1"></td>
                                <td colspan="1">(1)</td>
                                <td colspan="1">The same name as the passport;and</td>
                            </tr>
                            <tr style="border-bottom: #5f5c5c 1px solid;">
                                <td colspan="1"></td>
                                <td colspan="1"></td>
                                <td colspan="1">(2)</td>
                                <td colspan="1">An endorsement of the alien's nonimmigrant status as long as that period of endorsement has not yet expired and the proposed employment is not in conflict with any restrictions or limitations identified on the form.</td>
                            </tr>
                             <tr style="border-bottom: #5f5c5c 1px solid;">
                                <td colspan="1">
                                    <b>6.</b>
                                </td>
                                <td colspan="3" style="border-top: #5f5c5c 1px solid;">
                                   Passport from the Federated States of Micronesia (FSM) or the Republic of the Marshall Islands (RMI) with Form I-94 or Form I-94A indicating nonimmigrant admission under the Compact of Free Association Between the United States and the FSM or RMI                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="background-color:#cac6c6; border-right: #5f5c5c 1px solid;border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">
                    </td>

                    <td style="border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">
                        <table style="width:100%; background-color:white; vertical-align:top;" class="table">
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
                            <tr style="border-bottom:#5f5c5c 1px solid;">
                                <td style="border-top: #5f5c5c 1px solid;">
                                    <b>12.</b>
                                </td>
                                <td  style="border-top: #5f5c5c 1px solid;">
                                   Day-care or nursery school record
                                </td>
                            </tr>
                            </table>
                        </td>
                    <td style="background-color:#cac6c6; border-right: #5f5c5c 1px solid;border-left: #5f5c5c 1px solid;border-bottom: #5f5c5c 1px solid;">         
                    </td>
                    <td style="border-bottom: #5f5c5c 1px solid;border-right: #5f5c5c 1px solid;"">
                        <table class="table" style="background-color:white;">
                            <tr>
                                <td style="width:3%"></td>
                                <td style="width:3%"></td>
                                <td style="width:3%"></td>
                                <td style="width:89%"></td>
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
                                <td colspan="3" style="border-top: 1px solid #5f5c5c;">
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
                             <tr style="border-bottom:#5f5c5c 1px solid;">
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
                    <th colspan="7" style="text-align: center">
                        Illustrations of many of these documents appear in Part 8 of the Handbook for Employers (M-274).<br />
                        <br />
                        Refer to Section 2 of the instructions, titled "Employer or Authorized Representative Review<br />
                        and Verification," for more information about acceptable receipts.
                    </th>
                </tr>
            </table>
      </div>
    </div>
    <style>
        .I9Show{
            height:auto !important;
            overflow-y:hidden!important;
            transition:ease-in;
        }
        
        #divI9Documents{
            height:143px;
            overflow-y:hidden;
        }
        .modal-body{
            padding: 10px !important;
        }
        .modal-footer {
            padding: 10px;
            margin:0px !important;
        }
        .modal-dialog{
            left: 0;
            width: 40%;
            top:38%;
        }
        .popup {
            position: relative !important;
            top:0;
            left:0;
            right:0;
            display: none;
            max-width: 276px;
            padding: 1px;
            font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
            font-size: 14px;
            font-style: normal;
            font-weight: normal;
            line-height: 1.42857143;
            text-align: left;
            text-align: start;
            text-decoration: none;
            text-shadow: none;
            text-transform: none;
            letter-spacing: normal;
            word-break: normal;
            word-spacing: normal;
            word-wrap: normal;
            white-space: normal;
            background-color: #fff;
            -webkit-background-clip: padding-box;
            background-clip: padding-box;
            border: 1px solid #ccc;
            border: 1px solid rgba(0, 0, 0, .2);
            border-radius: 6px;
            -webkit-box-shadow: 0 5px 10px rgb(0 0 0 / 20%);
            box-shadow: 0 5px 10px rgb(0 0 0 / 20%);
            line-break: auto;
        }
        .float-left{
            float:left!important;
        }
        .float-right{
            float:right !important;
        }
        .fix2{
            width:100%;
            overflow:visible;
        }
        .fix1{
            width:95%!important;
        }
        .roundbtn {
            background-image: linear-gradient(#337ab7, #0b68b7, #337ab7);
            border: none;
            color: white;
            padding: 3%;
            width: 80%;
            font-size: 15px;
            margin: auto;
            border-radius: 8px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        }

            .roundbtn:hover {
                background-image: linear-gradient(#0b68b7, #0a5fa9, #0b68b7) !important;
            }

            .roundbtn:active {
                box-shadow: 0 1px #666;
                transform: translateY(2px);
            }
            
        input[type=text], textarea {outline: none; min-height: 25px; background-color: #f0f4fa; border: 1px solid #e0eaf7 !important; text-align:center; }
        input[type="checkbox"] {width: 16px; height: 16px; cursor: pointer; background: #f0f4fa; }

        .HREwrapper {margin-left: 5%; margin-right: 5%; }
        .HRESlateBlue {background-color: #ccd5e4; }
        .HREWhite {background-color: white; border: 1px solid grey; padding:10px; }
        .HREOffWhite {background-color: #F9F9F9; }
        .HRETan {background-color: #f5f5f0; }
        .HRELightBlue {background-color: #EFF3FB; }
        .HRERewrap {margin-right: 5%; }
        .HREpadR10 {padding-right: 20px; float:right; }
        .HREError {color: red; font-weight: bold; background-color: #f2dede; padding:10px 10px 10px 10px; margin-right: 5%; text-align:center;}
        .HRESuccess {color: green; font-weight: bold; font-size: x-large; background-color: #fff; padding:10px 10px 10px 10px; text-align:center;}
        .HRELabel {background-color: #f5f5f0; font-size: large; vertical-align:bottom;}
    </style>
</asp:Content>