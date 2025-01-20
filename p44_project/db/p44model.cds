namespace shimano.snah.p44;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity P44Shipments : managed {
    key mbol                     : String(100);
        p44ShipmentID            : String(100);
        p44Status                : String(50);
        p44StatusDate            : String(50);
        podActualTimeOfArrival   : String(50);
        podCarrierETA            : String(50);
        podP44ETA                : String(50);
        podVesselName            : String(100);
        polActualTimeofDeparture : String(50);
        polVesselName            : String(100);
        portOfDischarge          : String(100);
        portOfLoading            : String(100);
        scac                     : String(50);
        note                     : String(255);
        closedFlag               : String(50);
        txnCreatedDate           : String(50) @cds.on.insert: $now;
        txnUpdatedDated          : String(50) @cds.on.update: $now;
        ShipmentLink             : String;
        p44Containers            : Association to many P44Containers
                                       on p44Containers.p44Shipment = $self;
};

// entity P44Containers {
//     key transactionId   : Integer;
//         containerId     : String(50);
//         productType     : String(25);
//         txnCreatedDate  : String(50) @cds.on.insert: $now;
//         txnUpdatedDated : String(50) @cds.on.update: $now;
//         p44Shipment     : Association to P44Shipments;
//         P44Invoice      : Association to many P44Invoices
//                               on P44Invoice.p44Invoice = $self;
// };

// entity P44Invoices {
//     key invoiceNumber   : String(255);
//         containerId     : String(50);
//         txnCreatedDate  : String(50) @cds.on.insert: $now;
//         txnUpdatedDated : String(50) @cds.on.update: $now;
//         p44Invoice      : Association to P44Containers

// }


entity P44Containers {
        transactionId   : Integer;
    key containerId     : String(50);
        productType     : String(25);
        txnCreatedDate  : String(50) @cds.on.insert: $now;
        txnUpdatedDated : String(50) @cds.on.update: $now;
        p44Shipment     : Association to P44Shipments;
        ShipmentID      : String(100);
        ShipmentLink    : String;
        // Association to P44Invoices
        invoices        : Association to many P44Invoices
                              on invoices.containerId = $self.containerId;
};

entity P44Invoices {
    key invoiceNumber   : String(255);
        containerId     : String(50);
        txnCreatedDate  : String(50) @cds.on.insert: $now;
        txnUpdatedDated : String(50) @cds.on.update: $now;

        // (Optional) Reverse association to P44Containers, if needed
        container       : Association to P44Containers
                              on container.containerId = $self.containerId;
};
