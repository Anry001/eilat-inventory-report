Imports WallaShops.Objects.Web
Imports WallaShops.Objects
Imports WallaShops.Utils
Imports System.Web.UI

Partial Class WSStock_eilat_update_stock
  Inherits WSBaseManagerWebPage

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    If Not IsPostBack Then
      initDropDownLists()
    End If

  End Sub

  Private Sub populateDropDownList(dropDownList As DropDownList)

    Dim dtBranches As DataTable = WSStockUtils.GetEilatBranches()
    dropDownList.DataSource = dtBranches
    dropDownList.DataTextField = "name"
    dropDownList.DataValueField = "branch_id"
    dropDownList.DataBind()
    dropDownList.Items.Insert(0, New ListItem("-- בחר --", "-1"))

  End Sub

  Private Sub initDropDownLists()

    populateDropDownList(SourceBranchDropDownList)
    populateDropDownList(DestinationBranchDropDownList)

  End Sub

  Private Sub UpdateAmountToTransferButton_Click(sender As Object, e As EventArgs) Handles UpdateAmountToTransferButton.Click

    Dim onAirAmount As Integer = 0
    Dim onAirAmountOfOriginBranch As DataTable = WSStockUtils.GetEilatStockItems(GetQueryStringParam("sid"), "")

    If SourceBranchDropDownList.SelectedValue = "10" Then
      onAirAmount = WSStringUtils.ToInt(onAirAmountOfOriginBranch.Rows(0).ItemArray(4))
    ElseIf SourceBranchDropDownList.SelectedValue = "20" Then
      onAirAmount = WSStringUtils.ToInt(onAirAmountOfOriginBranch.Rows(0).ItemArray(5))
    End If

    If WSStringUtils.ToInt(SourceBranchDropDownList.SelectedIndex) = 0 Or WSStringUtils.ToInt(DestinationBranchDropDownList.SelectedIndex) = 0 Then
      ErrorMsg.Text = "אנא מלא סניף מקור וסניף יעד"
    ElseIf WSStringUtils.ToInt(AmountToTransferTextBox.Text) > onAirAmount Then
      ErrorMsg.Text = "כמות המוצרים שבחרת עולה על המלאי הקיים, אנא הכנס כמות מתאימה"
    Else
      WSStockUtils.UpdateEilatProductStockAmount(GetQueryStringParam("sid"), SourceBranchDropDownList.SelectedValue, WSStockTypes.OnAir, WSStockTransactionTypes.OutOfStock, WSStockUpdateTypes.Manual, WSStringUtils.ToInt(AmountToTransferTextBox.Text), New WSStockTransactionExtendedParams(), "העברת מלאי בין סניפים")
      WSStockUtils.UpdateEilatProductStockAmount(GetQueryStringParam("sid"), DestinationBranchDropDownList.SelectedValue, WSStockTypes.OnAir, WSStockTransactionTypes.InToStock, WSStockUpdateTypes.Manual, WSStringUtils.ToInt(AmountToTransferTextBox.Text), New WSStockTransactionExtendedParams(), "קבלת מלאי מלאי בין סניפים")
      WSStockUtils.UpdateEilatProductStockAmount(GetQueryStringParam("sid"), SourceBranchDropDownList.SelectedValue, WSStockTypes.Regular, WSStockTransactionTypes.OutOfStock, WSStockUpdateTypes.Manual, WSStringUtils.ToInt(AmountToTransferTextBox.Text), New WSStockTransactionExtendedParams(), "העברת מלאי בין סניפים")
      WSStockUtils.UpdateEilatProductStockAmount(GetQueryStringParam("sid"), DestinationBranchDropDownList.SelectedValue, WSStockTypes.Regular, WSStockTransactionTypes.InToStock, WSStockUpdateTypes.Manual, WSStringUtils.ToInt(AmountToTransferTextBox.Text), New WSStockTransactionExtendedParams(), "קבלת מלאי מלאי בין סניפים")
      CloseMe()
    End If

  End Sub

  Private Sub CloseMe()

    Dim scriptFunction As StringBuilder = New StringBuilder()
    scriptFunction.Append("<script language='javascript'>")
    scriptFunction.Append("window.parent.location.href = window.parent.location.href;")
    scriptFunction.Append("window.close();")
    scriptFunction.Append("</script>")
    ClientScript.RegisterStartupScript(Me.GetType(), "AddItemClose", scriptFunction.ToString())

  End Sub

  Private Sub SourceBranchDropDownList_SelectedIndexChanged(sender As Object, e As EventArgs) Handles SourceBranchDropDownList.SelectedIndexChanged

    populateDropDownList(DestinationBranchDropDownList)
    DestinationBranchDropDownList.Items.RemoveAt(SourceBranchDropDownList.SelectedIndex)

  End Sub

End Class