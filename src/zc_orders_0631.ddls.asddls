@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption Entity Orders'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
define root view entity ZC_ORDERS_0631
  provider contract transactional_query
  as projection on ZR_ORDERS_0631
{
  key     Id,
          Email,
          Firstname,
          Lastname,
          Country,
          Createon,
          Deliverydate,
          Orderstatus,

          @EndUserText.label: 'Status'
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIRTUAL_CODE_0631'
  virtual Status : abap.char(10),

          Imageurl,
          LocalCreatedBy,
          LocalCreatedAt,
          LocalLastChangedBy,
          LocalLastChangedAt,
          LastChangedAt,
          _Items : redirected to composition child ZC_ITEMS_0631
}
