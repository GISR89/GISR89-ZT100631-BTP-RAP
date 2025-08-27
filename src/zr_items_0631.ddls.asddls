@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Items Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_ITEMS_0631
  as select from ztb_items_0631 as Items
  
  association to parent ZR_ORDERS_0631 as _Orders on $projection.IdOrder = _Orders.Id
  
{
  key id                    as Id,
  key id_order              as IdOrder,
      name                  as Name,
      description           as Description,
      releasedate           as Releasedate,
      discontinueddate      as Discontinueddate,
      price                 as Price,
      @Semantics.quantity.unitOfMeasure : 'Unitofmeasure'
      height                as Height,
      @Semantics.quantity.unitOfMeasure : 'Unitofmeasure'
      width                 as Width,
      depth                 as Depth,
      quantity              as Quantity,
      unitofmeasure         as Unitofmeasure,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      _Orders
}
