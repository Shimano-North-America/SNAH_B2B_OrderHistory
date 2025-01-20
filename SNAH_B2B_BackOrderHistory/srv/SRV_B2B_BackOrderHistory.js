const cds = require('@sap/cds');
const res = require('express/lib/response');

module.exports = cds.service.impl(async function (srv) {
    const db = await cds.connect.to("db");
    const {
        B2B_BackOrderHistory
    } = db.entities;

    this.on("POST", 'GetBackOrderHistory', async (req) => {
        debugger;
        const {
            soldTo,
            shipTo,
            search,
            searchBy,
            fromDate,
            toDate,
            status,
            sort,
            dir,
            currentPage,
            pageSize,
            orderType
        } = req.data;

        try {
            let query = SELECT.from(B2B_BackOrderHistory).columns("ERPORDERNUMBER",
                "ITEMNUMBER",
                "ORDERSTATUS",
                "PONUMBER",
                "ERPORDERTYPE",
                "BILLTO",
                "SHIPTO",
                "ORDERDATE",
                "PRODUCTCODE",
                "LOCALSKU",
                "DEALERPRICE",
                "TOTALPRICE",
                "CURRENCY",
                "QUANTITYORDERED",
                "QUANTITYBACKORDER").where({
                BILLTO: soldTo
            });
            if (shipTo && shipTo.length > 0) {
                query.where({
                    SHIPTO: {
                        in: shipTo
                    }
                });
            }
            // if (fromDate && toDate) {
            //     query.where({
            //         ORDERDATE: {
            //             between: fromDate,
            //             and: toDate
            //         }
            //     });
            // } else if (fromDate && !toDate) {
            //     query.where({
            //         ORDERDATE: {
            //             '=': fromDate
            //         }
            //     });
            // }

            // // fromDate && toDate changes
            // if (fromDate && toDate) {
            //     query.where({
            //         ORDERDATE: {
            //             between: new Date(fromDate).toISOString(),
            //             and: new Date(toDate).toISOString()
            //         }
            //     });
            // } else if (fromDate && !toDate) {
            //     query.where({
            //         ORDERDATE: {
            //             '=': new Date(fromDate).toISOString()
            //         }
            //     });
            // } else if (!fromDate && toDate) {
            //     query.where({
            //         ORDERDATE: {
            //             '<=': new Date(toDate).toISOString()
            //         }
            //     });
            // }

            // fromDate & toDate conditions
            const currentDate = new Date().toISOString();
            if (fromDate && toDate) {
                query.where({
                    ORDERDATE: {
                        between: new Date(fromDate).toISOString(),
                        and: new Date(toDate).toISOString()
                    }
                });
            } else if (fromDate && !toDate) {
                query.where({
                    ORDERDATE: {
                        between: new Date(fromDate).toISOString(),
                        and: currentDate
                    }
                });
            } else if (!fromDate && toDate) {
                query.where({
                    ORDERDATE: {
                        '<=': new Date(toDate).toISOString()
                    }
                });
            }

            if (status && status.length > 0) {
                query.where({
                    ORDERSTATUS: {
                        in: status
                    }
                });
            }
            if (orderType && orderType.length > 0) {
                query.where({
                    ERPORDERTYPE: {
                        in: orderType
                    }
                });
            }
            // Adding the Search condition based on the SearchBy parameter
            if (search && searchBy) {
                let searchColumn = searchBy;
                if (searchBy === "orderNumber") {
                    searchColumn = "ERPORDERNUMBER";
                };
                query.where({
                    [searchColumn]: {
                        like: `%${search}%`
                    }
                });
            };
            let sortColumn = sort;
            if (sort === "orderNumber") {
                sortColumn = "ERPORDERNUMBER";
            };
            query.orderBy(`${sortColumn} ${dir}`);
            debugger;
            // getting the data from the HANA DB
            const result = await cds.run(query);
            const totalResults = result.length;
            const totalPages = Math.ceil(totalResults / pageSize);
            const startIndex = currentPage * pageSize;
            const endIndex = startIndex + pageSize;
            const paginatedResults = result.slice(startIndex, endIndex);
            debugger;
            if (result.length !== 0) {
                const entries = paginatedResults.map(backOrders => ({
                    productCode: backOrders.PRODUCTCODE,
                    quantity: backOrders.QUANTITYBACKORDER,
                    currency: backOrders.CURRENCY,
                    dealerPrice: backOrders.DEALERPRICE,
                    totalPrice: backOrders.TOTALPRICE,
                    erpOrderNumber: backOrders.ERPORDERNUMBER,
                    orderDate: backOrders.ORDERDATE,
                    orderStatus: backOrders.ORDERSTATUS
                }));
                let data = {
                    entries,
                    currentPage: Number(currentPage),
                    pageSize: Number(pageSize),
                    totalPages: totalPages,
                    totalResults: totalResults
                };
                return data;
            } else {
                req.reject(404, "Data Not Found");
            };

        } catch (err) {
            console.error(err);
            req.reject(err.code, err.message || "An unexpected error occurred");
        }
    });
});