<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EilatInventoryReport.aspx.vb" Inherits="WebSite.EilatInventoryReport" MasterPageFile="~/WSMainMaster.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
    <div class="col-sm-7">
      <div class="modal fade" id="UpdateStock" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header">
            <a class="close" data-dismiss="modal">×</a>
            <h2>העברת מלאי בין מחסנים</h2>
          </div>
          <iframe id="transerStockFrame" src="" style="width: 100%;"></iframe>
        </div>
      </div>
    </div>
        <div class="panel panel-default">

            <div class="panel-heading">
                חיפוש מוצר
            </div>

            <div class="panel-body form-horizontal">

               <%-- <div class="form-group">
                    <label for="ddlStatusName" class="col-sm-2 control-label">
                        חנות
                    </label>
                    <div class="col-sm-7">
                        <asp:DropDownList ID="ddlStatusName" CssClass="form-control" runat="server"></asp:DropDownList>
                    </div>
                </div>--%>

                <div class="form-group">
                    <label for="OrderIDTextBox" class="col-sm-2 control-label">
                        מק"ט מוצר
                    </label>
                    <div class="col-sm-7">
                        <asp:TextBox ID="OrderIDTextBox" CssClass="form-control" runat="server" />
                    </div>
                </div>

                <div class="form-group">
                    <label for="ProductNameLabel" class="col-sm-2 control-label">
                        שם מוצר
                    </label>
                    <div class="col-sm-7">
                        <asp:TextBox ID="ProductNameTextBox" CssClass="form-control" runat="server" />
                    </div>
                </div>

               <div class="form-group">
                  
                    <div class="col-sm-8">
                        <asp:CheckBox ID="cbxIsInStock" CssClass="form-control" Text="נמצא במלאי" runat="server" Checked="true" />
                    </div>
                </div>

                <asp:LinkButton CssClass="btn btn-primary fl" ID="UpdateSearchButton" runat="server">
                עדכן חיפוש <i class="fa fa-search" aria-hidden="true"></i>
                </asp:LinkButton>

            </div>
        </div>
    </div>
    <asp:GridView ID="gvStockItems" runat="server" CssClass="table-condensed table table-striped" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand">

        <%---------------------------------------------------------------------------------------------------------------------------------------------------------------------%>

        <%--                                           work area!@?!@?!@?!@?!@?!@?!@?                                                                                        --%>

        <%---------------------------------------------------------------------------------------------------------------------------------------------------------------------%>

        <Columns>

            <asp:TemplateField HeaderText="שם סניף">
                <ItemTemplate>
                    <asp:Label Width="130" CssClass="bfsize09" ID="BranchNameLabel" runat="server" Text='<%# Eval("site_name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="מקט מלאי">
                <ItemTemplate>
                    <asp:Label Width="130" CssClass="bfsize09" ID="StockPfIdLabel" runat="server" Text='<%# Eval("stock_pf_id") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="שם מוצר">
                <ItemTemplate>
                    <asp:Label Width="130" CssClass="bfsize09" ID="ProductNameLabel" runat="server" Text='<%# Eval("prod_name")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="כמות מלאי פיזי">
                <ItemTemplate>
                    <asp:Label Width="130" CssClass="bfsize09" ID="PhysicallyInStockQuantityLabel" runat="server" Text='<%# Eval("inv_real_stock_amount")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="כמות מלאי זמין למכירה">
                <ItemTemplate>
                    <asp:Label Width="130" CssClass="bfsize09" ID="CurrentlyOnAirQuantityLabel" runat="server" Text='<%# Eval("onair_stock_amount")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="מספר מכירה">
                <ItemTemplate>
                    <asp:Label Width="130" CssClass="bfsize09" ID="SellingIDLabel" runat="server" Text='<%# Eval("auction_id")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="כמות מלאי סניף טיילת">
                <ItemTemplate>
                    <asp:Label Width="130" CssClass="bfsize09" ID="TCurrentlyOnAirQuantityLabel" runat="server" Text='<%# Eval("eilat_10_inv_onair")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>


            <asp:TemplateField HeaderText="כמות מלאי סניף רויאל">
                <ItemTemplate>
                    <asp:Label Width="130" CssClass="bfsize09" ID="RCurrentlyOnAirQuantityLabel" runat="server" Text='<%# Eval("eilat_20_inv_onair")%>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="העברת מלאי">
                <ItemTemplate>

                  <asp:Label runat="server" Width="100" CssClass="btn-xs btn-primary text-center" ID="imgActions" ClientIDMode="Static">
                  <i class="fa fa-pencil"></i>
                  </asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>


    
    <!-- Modal Popup -->
   <%-- <div id="MyPopup" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        &times;</button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body">
                    <div class="panel-body form-horizontal">

                        <div class="form-group">
                            <label for="tbxTransferStockPfId" class="col-sm-2 control-label">
                                מק"ט מלאי
                            </label>
                            <div class="col-sm-7">
                                <input name="tbxTransferStockPfId" type="text" id="tbxTransferStockPfId" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="tbxTransferQuantity" class="col-sm-2 control-label">
                                כמות
                            </label>
                            <div class="col-sm-7">
                                <input name="tbxTransferQuantity" type="text" id="tbxTransferQuantity" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="ddlTransferSourceWarehouse" class="col-sm-2 control-label">
                                מחסן מקור
                            </label>
                            <div class="col-sm-7">
                                <select name="ddlTransferSourceWarehouse" id="ddlTransferSourceWarehouse" class="form-control">
                                    <option selected="selected" value="0">-- בחר מחסן --</option>
                                    <option value="10">טיילת</option>
                                    <option value="20">רויאל</option>


                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="ddlTransferTargetWarehouse" class="col-sm-2 control-label">
                                מחסן יעד
                            </label>
                            <div class="col-sm-7">
                                <select name="ddlTransferTargetWarehouse" id="ddlTransferTargetWarehouse" class="form-control">
                                    <option selected="selected" value="0">-- בחר מחסן --</option>
                                    <option value="10">טיילת</option>
                                    <option value="20">רויאל</option>
 

                                </select>
                            </div>
                        </div>
                        <a id="btnTransfer" class="btn btn-primary fl" href="javascript:__doPostBack('btnTransfer','')">בצע העברה <i class="fa fa-check" aria-hidden="true"></i>
                        </a>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">
                        Close</button>
                </div>
            </div>
        </div>
    </div>--%>
    <!-- Modal Popup -->
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Scripts" runat="server">
    <script type="text/jscript">
      $(function () {
      });
      
      function ShowStockUpdate(stockPfId) {        
        var url = "eilat_update_stock.aspx?&hideMenus=1&sid=" + stockPfId;
        $("#transerStockFrame").attr('src', url);
        $("#transerStockFrame").load(function () {
          $("#transerStockFrame").attr('height', document.body.clientHeight - 200);
        });
        $("#UpdateStock").modal("show");
        return false;
        }
    </script>
</asp:Content>

