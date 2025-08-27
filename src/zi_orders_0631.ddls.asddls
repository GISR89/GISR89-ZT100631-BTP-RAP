@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Entity Orders'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zi_orders_0631 
provider contract transactional_interface
as projection on ZR_ORDERS_0631
{
    key Id,
    Email,
    Firstname,
    Lastname,
    Country,
    Createon,
    Deliverydate,
    Orderstatus,
    Imageurl,
    LocalCreatedBy,
    LocalCreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt,
    _Items: redirected to composition child ZI_ITEMS_0631
}
