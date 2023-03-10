<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EilatStockUpdatesLog.aspx.vb" Inherits="WebSite.EilatStockUpdatesLog" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>ניהול מלאי</title>  
    <link href="../Styles/style.css" rel="stylesheet" type="text/css" />
    <link href="../style/dhtmlgoodies_calendar.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/dhtmlgoodies_calendar.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/dhtmlgoodies_calendar.js" language="javascript" type="text/jscript"></script>  
  <script>  
  </script>
</head>
<body dir="rtl">
    <form id="EilatStockLog" runat="server" >   
        <table cellpadding="0" cellspacing="1"  border="0" bgcolor="#f0f7f2" bordercolor="#000099">

        <tr>
          <td><font class="bfsize14">לוג עדכוני מלאי באילת</font></td>
        </tr>

        <tr><td height="10"><asp:CustomValidator Class="bfsize11" ID="valGeneral" runat="server" EnableClientScript="false"></asp:CustomValidator></td></tr>
        
          <tr>
            <td>
              <table>
                <tr>
                  <td width="90" style="height: 24px">
                    <font class="fsize10">שם סניף</font>
                  </td>
                  <td align="left" style="height: 24px">
                    <asp:DropDownList ID="ddlShopName" runat="server" Width="200" AutoPostBack="true"></asp:DropDownList>
                  </td>
                </tr>   
              </table>
            </td>
          </tr>

        <tr>
          <td>
            <table>
              <tr>              
                <td width="90" style="height: 24px"><font class="fsize10">מק"ט מלאי</font></td>            
                <td align=left style="height: 24px">
                  <asp:TextBox ID="tbxStockPfId" Width="190" runat="server" /></td>
              </tr>              
            </table>
          </td>
        </tr>
                                            
        <tr><td>
      <table >
        <tr>

         <td>
          <table border="0" cellpadding="0" cellspacing="0" width="250">
            <tr id="trFromDate">             
              <td width="50"><font class="fsize10"><b>מתאריך:<b></font></td>                                           
              <td>
                <asp:TextBox runat="server" CssClass="date" id="txtFromDate" Width="132"   />
                <asp:Image ID="imgFromDate" src="../images/calendar/CalendarTimeIcon5.jpg" AlternateText="Date-Time Calendar" style="cursor:hand;" runat="server" />                            
              </td>                       
            </tr>
            <tr style="padding-bottom:5px">
              <td colspan="3"><asp:CustomValidator ID="valFromDate" runat="server" EnableClientScript="false" Visible="false" CssClass="ValidationMsg"></asp:CustomValidator></td>
            </tr>                      
          </table>
         </td>
          
         <td>
          <table border="0" cellpadding="0" cellspacing="0" width="250">
            <tr id="tr1">             
              <td width="60"><font class="fsize10"><b>עד תאריך:<b></font></td>                 
              <td>
                <asp:TextBox runat="server" CssClass="date" id="txtToDate" Width="132" />
                <asp:Image ID="imgToDate" src="../images/calendar/CalendarTimeIcon5.jpg" AlternateText="Date-Time Calendar" style="cursor:hand;" runat="server" />                            
              </td>                       
            </tr>
            <tr style="padding-bottom:5px">
              <td colspan="3"><asp:CustomValidator ID="valToDate" runat="server" EnableClientScript="false" Visible="false" CssClass="ValidationMsg"></asp:CustomValidator></td>
            </tr>                      
          </table>         
        </td>          
      </tr>      
        </table></td></tr>

           <tr>
             <td>
              <table>
                <tr>
                  <td width="90"></td>                                    
                  <td><asp:Button Width="100" ID="btnSearch" runat="server" Text="עדכן חיפוש" /></td>    
                </tr>                      
              </table>    
            </td>
          </tr>
      
          <tr><td><hr /><a href="" style="color:Green;font-family:Arial;font-size:11px;font-weight:bolder"></a></td></tr>

          <div runat="server" id="dvResults">
          <tr>
             <td align=right>
              <table border="0">              
                <tr>                  
                  <td align=right colspan=2>
                   <asp:GridView ID="gvProducts" runat="server"
                    AutoGenerateColumns="False"                                        
                    HeaderStyle-HorizontalAlign=Right
                    HeaderStyle-CssClass="bfsize10"
                    HeaderStyle-BackColor="#bacbdb"
                    BackColor=White
                    PageSize=15
                    AllowPaging="false">
                    <Columns>                                                            
                <asp:TemplateField HeaderText="מקט מלאי">
                  <ItemTemplate>
                    <asp:HyperLink Width="80" ID="lnkStockPfId" Text='<%# Eval("stock_pf_id") %>' runat="server" CssClass="fsize10" Target=_blank />
                  </ItemTemplate>                                            
                </asp:TemplateField>            
                 <asp:TemplateField HeaderText="שם מוצר">
                  <ItemTemplate>
                    <asp:Label Width="150" ID="lnkProdName" Text='<%# Eval("prod_name") %>' runat="server" CssClass="fsize10" />
                  </ItemTemplate>                                            
                </asp:TemplateField>                                  
                <asp:TemplateField HeaderText="דגם">
                  <ItemTemplate>
                    <asp:Label Width="80" ID="lnkModel" Text='<%# Eval("model") %>' runat="server" CssClass="fsize10" />
                  </ItemTemplate>                                            
                </asp:TemplateField>      
                <asp:TemplateField HeaderText="סוג מלאי">
                  <ItemTemplate>
                    <asp:Label Width="50" ID="lnkStockType" Text='<%# GetStockTypeName(Eval("stock_type")) %>' runat="server" CssClass="fsize10" />
                  </ItemTemplate>                                            
                </asp:TemplateField>                
                 <asp:TemplateField HeaderText="נכנס">
                  <ItemTemplate>
                    <asp:Label Width="40" ID="lnkIntoStock" Text='<%# DisplayStockTranQuantity(Eval("quantity"), Eval("tran_type"), 1) %>' runat="server" CssClass="fsize10" />
                  </ItemTemplate>                                            
                </asp:TemplateField>
                <asp:TemplateField HeaderText="יצא">
                  <ItemTemplate>
                    <asp:Label Width="40" ID="lnkOutOfStock" Text='<%# DisplayStockTranQuantity(Eval("quantity"), Eval("tran_type"), 2) %>' runat="server" CssClass="fsize10" />
                  </ItemTemplate>                                            
                </asp:TemplateField>      
                <asp:TemplateField HeaderText="יתרה">
                  <ItemTemplate>
                    <asp:Label Width="40" ID="lnkBalance" Text='<%# Eval("balance") %>' runat="server" CssClass="fsize10" />
                  </ItemTemplate>                                            
                </asp:TemplateField>                                                                                      
                <asp:TemplateField HeaderText="תאריך עדכון">
                  <ItemTemplate>
                    <asp:Label Width="120" ID="lnklogDate" Text='<%# Eval("log_date") %>' runat="server" CssClass="fsize10" />
                  </ItemTemplate>                                                          
                </asp:TemplateField>
                <asp:TemplateField HeaderText="סוג עדכון">
                  <ItemTemplate>
                    <asp:Label Width="130" ID="lnkUpdateType" Text='<%# GetUpdateTypeName(Eval("update_type"), Eval("stock_order_type"), Eval("stock_order_id"), Eval("order_id_show")) %>' runat="server" CssClass="fsize10"/>                    
                  </ItemTemplate>                                                                
                </asp:TemplateField>                                          
                <asp:TemplateField HeaderText="שם מעדכן">
                  <ItemTemplate>
                    <asp:Label Width="70" ID="lnkSalesRate" Text='<%#Eval("created_by_user_name") %>' runat="server" CssClass="fsize10" />
                  </ItemTemplate>
                </asp:TemplateField>                                            
                <asp:TemplateField HeaderText="הערות ">
                  <ItemTemplate>
                    <asp:Label Width="120" ID="lnkRemarks" Text='<%# Eval("remarks") %>' runat="server" CssClass="fsize10"/>                    
                  </ItemTemplate>                                                                
                </asp:TemplateField>
                <asp:TemplateField HeaderText="שם סניף">
                  <ItemTemplate>
                    <asp:Label Width="120" ID="storeName" Text='<%# EvaluateStoreName(Eval("eilat_branch_id")) %>' runat="server" CssClass="fsize10"/>                    
                  </ItemTemplate>                                                                
                </asp:TemplateField>                          
              </Columns>            
              <FooterStyle BackColor="AliceBlue" CssClass="bsize10" HorizontalAlign="Center" />
              <HeaderStyle BackColor="#BACBDB" CssClass="bfsize10" HorizontalAlign="Right" />
            </asp:GridView>      
                  </td>    
                </tr>
              </table>    
            </td>
          </tr>
        </div>
      </table>
    </form>
</body>
</html>
