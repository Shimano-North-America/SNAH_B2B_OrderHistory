namespace B2B_BackOrderHistory;

entity B2B_BackOrderHistory
{
    key ERPORDERNUMBER : String(10)
        @Core.Description : 'ERP Order Number';
    key ITEMNUMBER : String
        @Core.Description : 'Item Number';
    ORDERSTATUS : String(1)
        @Core.Description : 'Order Status';
    PONUMBER : String
        @Core.Description : 'PO Number';
    ERPORDERTYPE : String
        @Core.Description : 'Order Type';
    BILLTO : String(10)
        @Core.Description : 'Bill To';
    SHIPTO : String(10)
        @Core.Description : 'Ship To';
    ORDERDATE : Timestamp
        @Core.Description : 'Order Date';
    PRODUCTCODE : String
        @Core.Description : 'Product Code - Global SKU';
    LOCALSKU : String
        @Core.Description : 'Product Code - Local SKU';
    DEALERPRICE : Decimal(10,2)
        @Core.Description : 'Dealer Price';
    TOTALPRICE : Decimal(10,2)
        @Core.Description : 'Total Price';
    CURRENCY : String(3)
        @Core.Description : 'Currency';
    QUANTITYORDERED : Decimal(13,3)
        @Core.Description : 'Quantity - Ordered';
    QUANTITYBACKORDER : Decimal(13,3)
        @Core.Description : 'Quantity - Backordered';
}
