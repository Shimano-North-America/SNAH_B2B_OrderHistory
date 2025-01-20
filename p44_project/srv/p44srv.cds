using {shimano.snah.p44} from '../db/p44model';

service P44Srv {
    entity P44ShipmentsSRV  as projection on p44.P44Shipments;
    entity P44ContainersSRV as projection on p44.P44Containers;
    entity P44InvoicesSRV as projection on p44.P44Invoices;
}
