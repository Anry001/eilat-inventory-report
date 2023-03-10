<%@ Page Language="VB" AutoEventWireup="false" Inherits="WebSite.WSStock_eilat_update_stock" 
  MasterPageFile="~/WSMainMaster.Master" Title="����� ���� " 
  EnableEventValidation="false" ValidateRequest="false" 
  CodeBehind="eilat_update_stock.aspx.vb" %>

<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">
     <div class="panel panel-default">
            <div class="panel-body form-horizontal">

                <div class="form-group">
                    <label for="SourceBranchDropDownList" class="col-sm-2 control-label">
                    סניף מקור
                    </label>
                    <div class="col-sm-7">
                        <asp:DropDownList ID="SourceBranchDropDownList" CssClass="form-control" runat="server" AutoPostBack="true"></asp:DropDownList>
                    </div>
                </div>

               <div class="form-group">
                    <label for="DestinationBranchDropDownList" class="col-sm-2 control-label">
                   סניף יעד
                    </label>
                    <div class="col-sm-7">
                        <asp:DropDownList ID="DestinationBranchDropDownList" CssClass="form-control" runat="server" AutoPostBack ="true"></asp:DropDownList> 
                    </div>
                </div>

                <div class="form-group">
                    <label for="AmountToTransferTextBox" class="col-sm-2 control-label">
                      כמות למעבר
                    </label>
                    <div class="col-sm-7">
                        <asp:TextBox ID="AmountToTransferTextBox" CssClass="form-control" runat="server" />
                    </div>
                </div>

                <asp:LinkButton CssClass="btn btn-primary fl" ID="UpdateAmountToTransferButton" runat="server">
                עדכן וסגור 
                <i class="fa fa-search" aria-hidden="true"></i>
                </asp:LinkButton>

                  <asp:Label CssClass="lbl" ID="ErrorMsg" runat="server" Text=""></asp:Label>    <%--the current code snippet--%>

            </div>
        </div>
</asp:Content>

<%--<asp:Content ID="Content3" ContentPlaceHolderID="Scripts" runat="server">   
<script language='javascript'> 
  //window.parent.location.href = window.parent.location.href;
  //window.close();
  </script>
</asp:Content>--%>
