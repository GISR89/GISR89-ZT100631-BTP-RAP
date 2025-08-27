@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Entity Items'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_ITEMS_0631 
as projection on ZR_ITEMS_0631
{
    key Id,
    key IdOrder,
    Name,
    Description,
    Releasedate,
    Discontinueddate,
    Price,
     @Semantics.quantity.unitOfMeasure : 'Unitofmeasure'
    Height,
     @Semantics.quantity.unitOfMeasure : 'Unitofmeasure'
    Width,
    Depth,
    Quantity,
    Unitofmeasure,
    LocalCreatedBy,
    LocalCreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt,
    _Orders: redirected to parent zi_orders_0631
}
