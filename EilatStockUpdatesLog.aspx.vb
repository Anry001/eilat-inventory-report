Imports WallaShops.Objects
Imports WallaShops.Utils
Imports WallaShops.Objects.Web

Public Class EilatStockUpdatesLog
  Inherits WSBaseManagerStock

  Public ReadOnly Property StockPfId() As String

    Get
      Return GetQueryStringParam("pi")
    End Get

  End Property

  Public ReadOnly Property ShopId() As String

    Get
      Return GetQueryStringParam("si")
    End Get

  End Property

#Region "Initialization"

  Private Sub InitializeControlsOnStartup()

    InitializeDropDownList(ddlShopName)
    InitializeDates()
    dvResults.Visible = False
    tbxStockPfId.Text = IIf(StockPfId <> "", StockPfId, "")

  End Sub

  Private Sub InitializeDropDownList(dropDownList As DropDownList)

    Dim dtBranches As DataTable = WSStockUtils.GetEilatBranches()
    dropDownList.DataSource = dtBranches
    dropDownList.DataTextField = "name"
    dropDownList.DataValueField = "branch_id"
    dropDownList.DataBind()
    dropDownList.Items.Insert(0, New ListItem("-- בחר --", "-1"))

  End Sub

  Protected Function InitOrdersSearchParams() As WSObjectDictionary

    Dim SearchParams As New WSObjectDictionary()
    SearchParams.Add("eilatBranchId", IIf(ddlShopName.SelectedValue <> -1, ddlShopName.SelectedValue, DBNull.Value))
    SearchParams.Add("StockPfId", IIf(tbxStockPfId.Text <> "", tbxStockPfId.Text, DBNull.Value))
    SearchParams.Add("DateFrom", WSStringUtils.ToDateTime(txtFromDate.Text))
    SearchParams.Add("DateTo", WSStringUtils.ToDateTime(txtToDate.Text))
    Return SearchParams

  End Function

  Sub InitializeDates()
    imgFromDate.Attributes.Add("onclick", "javascript:displayCalendar(document.getElementById('txtFromDate'),'hh:ii dd/mm/yyyy',this,true)")
    imgToDate.Attributes.Add("onclick", "javascript:displayCalendar(document.getElementById('txtToDate'),'hh:ii dd/mm/yyyy',this,true)")
    txtFromDate.Text = "00:00 " & Now.AddDays(-7).ToShortDateString
    txtToDate.Text = "23:59 " & Now.ToShortDateString

  End Sub

#End Region

#Region "Page Events"

  Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    If Not Page.IsPostBack Then
      InitializeControlsOnStartup()
      If StockPfId <> "" Then
        ReadData()
      End If
    End If

  End Sub

  Sub ReadData()

    Dim searchParams As WSObjectDictionary
    searchParams = InitOrdersSearchParams()
    gvProducts.DataSource = StockFactory.GetEilatStockUpdateLog(searchParams)
    gvProducts.DataBind()
    dvResults.Visible = IIf(gvProducts.Rows.Count > 0, True, False)

  End Sub

  Private Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click

    If ValidateRangeOfDates() Then
      If Page.IsValid Then
        ReadData()
      End If
    End If

  End Sub

  Protected Sub gvProducts_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvProducts.RowDataBound

    If e.Row.RowType = DataControlRowType.DataRow Then
    End If

  End Sub

#End Region

  Public Function ValidateRangeOfDates() As Boolean

    Dim fromDate As Date = WSStringUtils.ToDateTime(txtFromDate.Text)
    Dim toDate As Date = WSStringUtils.ToDateTime(txtToDate.Text)

    If WSStringUtils.ToInt(Math.Abs((fromDate - toDate).TotalDays)) > 30 Then
      valGeneral.ErrorMessage = "אנא מלאו טווח תאריכים שלא עולה על חודש"
      valGeneral.IsValid = False
      Return False
    Else Return True
    End If

  End Function

  Public Function GetStockTypeName(ByVal stock_type As Object) As String

    Select Case CType(WSStringUtils.ToInt(stock_type), WSStockTypes)
      Case WSStockTypes.Broken
        Return "תקול"
      Case WSStockTypes.OnAir
        Return "באוויר"
      Case WSStockTypes.Regular
        Return "רגיל"
      Case Else
        Return ""
    End Select

  End Function

  Public Function DisplayStockTranQuantity(ByVal quantity As Integer, ByVal tran_type As WSStockTransactionTypes, ByVal feild_type As Integer) As String

    If feild_type = 1 Then
      Return IIf(tran_type = WSStockTransactionTypes.InToStock, quantity, "")
    Else
      Return IIf(tran_type = WSStockTransactionTypes.OutOfStock, quantity, "")
    End If

  End Function

  Public Function GetUpdateTypeName(ByVal update_type As WSStockUpdateTypes, ByVal stock_order_type As Object, ByVal stock_order_id As Object, ByVal order_id_show As Object) As String

    Select Case CType(WSStringUtils.ToInt(update_type), WSStockUpdateTypes)
      Case WSStockUpdateTypes.Manual
        Return "עדכון ידני"
      Case WSStockUpdateTypes.SalesOrder, WSStockUpdateTypes.CreditSalesOrder
        Return "הזמנת לקוח" & "-" & order_id_show
      Case WSStockUpdateTypes.SalesOrderItem
        Return "פריט הזמנת לקוח" & "-" & order_id_show
      Case WSStockUpdateTypes.StockCounting
        Return "ספירת מלאי"
      Case WSStockUpdateTypes.StockOrder
        Return IIf(CType(WSStringUtils.ToInt(stock_order_type), WSStockOrderType) = WSStockOrderType.PurchaseOrder, "הזמנת רכש", "תעודת החזרה") & "-" & stock_order_id
      Case WSStockUpdateTypes.Automatic
        Return IIf(Not IsDBNull(order_id_show), "הזמנת לקוח" & "-" & order_id_show, "")
      Case Else
        Return ""
    End Select

  End Function

  Function DisplayPrice(ByVal price As Object) As String

    Return WSStringUtils.GetPrice(price, WSCurrencies.ILS)

  End Function

  Function DisplayDouble(ByVal number As Object) As String

    Return FormatNumber(number, 2)

  End Function

  Public Function EvaluateStoreName(ByVal eilat_branch_id As String) As String

    Dim branchId = WSStringUtils.ToInt(eilat_branch_id)
    If branchId = 10 Then
      Return "הטיילת"
    ElseIf branchId = 20 Then
      Return "רויאל גרדן"
    Else Return ""
    End If

  End Function

End Class