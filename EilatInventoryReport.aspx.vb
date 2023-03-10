Imports System.Data
Imports WallaShops.Objects.Web
Imports WallaShops.Objects
Imports WallaShops.Utils
Imports WallaShops.Shops

Public Class EilatInventoryReport
  Inherits WSBaseManagerWebPage

  Sub ReadData()
    gvStockItems.DataSource = WSStockUtils.GetEilatStockItems(OrderIDTextBox.Text, ProductNameTextBox.Text, cbxIsInStock.Checked)
    gvStockItems.DataBind()
  End Sub

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    If Not Page.IsPostBack Then
      ReadData()
    End If
  End Sub

  Protected Sub GridView1_RowCommand(sender As Object, e As GridViewCommandEventArgs)
    If e.CommandName = "Select" Then
      Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
      Dim row As GridViewRow = gvStockItems.Rows(rowIndex)
      Dim stockPfId As String = CType(row.FindControl("StockPfIdLabel"), Label).Text
      ClientScript.RegisterStartupScript(Me.GetType(), "myFunction", "$(function () {$('#MyPopup').modal();})", True)
    End If
  End Sub

  Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles UpdateSearchButton.Click
    ReadData()
  End Sub

  Private Sub gvStockItems_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvStockItems.RowDataBound
    If e.Row.RowType = DataControlRowType.DataRow Then
      Dim StockPfId As String = CType(e.Row.FindControl("StockPfIdLabel"), Label).Text
      CType(e.Row.FindControl("imgActions"), Label).Attributes.Add("onclick", "ShowStockUpdate('" & StockPfId & "')")
    End If

  End Sub

  Function DisplayStatusName(ByVal status As Object) As String
    Dim orderShopStatus As WSOrderEilatStatus = DirectCast(WSStringUtils.ToInt(status), WSOrderEilatStatus)
    Return WSStringUtils.GetDescription(orderShopStatus)

  End Function

End Class