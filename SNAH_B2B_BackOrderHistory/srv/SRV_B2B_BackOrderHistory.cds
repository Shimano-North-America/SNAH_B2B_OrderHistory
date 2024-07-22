service ERP_BACKORDERHISTORY {
    @cds.persistence.exists
    entity GetBackOrderHistory {
        entries      : array of {
            productCode    : String
            @Core.Description: 'Product Code';
            quantity       : Decimal(13, 3)
            @Core.Description: 'Quantity';
            currency       : String(3)
            @Core.Description: 'Currency Code';
            dealerPrice    : Decimal(10, 2)
            @Core.Description: 'Dealer Price';
            totalPrice     : Decimal(10, 2)
            @Core.Description: 'Total Price';
            erpOrderNumber : String(10)
            @Core.Description: 'ERP Order Number';
            orderDate      : Timestamp
            @Core.Description: 'Order Date';
            orderStatus    : String(1)
            @Core.Description: 'Order Status';
        };
        soldTo       : String(10)
            @Core.Description: 'Sold To';
        shipTo       : array of String(10)
            @Core.Description: 'Ship To';
        search       : String
            @Core.Description: 'Search Value';
        searchBy     : String
            @Core.Description: 'Search By';
        fromDate     : String
            @Core.Description: 'From Date';
        toDate       : String
            @Core.Description: 'To Date';
        status       : array of String
            @Core.Description: 'Order Status';
        sort         : String
            @Core.Description: 'Sort by - Field';
        dir          : String(4)
            @Core.Description: 'Sort - Direction';
        currentPage  : Integer
            @Core.Description: 'Current Page';
        pageSize     : Integer
            @Core.Description: 'Page Size';
        orderType    : array of String
            @Core.Description: 'Order Type';
        totalPages   : String
            @Core.Description: 'Total Pages';
        totalResults : String
            @Core.Description: 'Total Results';
    }

}
