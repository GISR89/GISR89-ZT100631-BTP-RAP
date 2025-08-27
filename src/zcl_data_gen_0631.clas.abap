CLASS zcl_data_gen_0631 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS insert_demo_data
      IMPORTING out TYPE REF TO if_oo_adt_classrun_out
      RAISING   cx_uuid_error.
ENDCLASS.



CLASS zcl_data_gen_0631 IMPLEMENTATION.
  METHOD insert_demo_data.

    DATA: ls_order TYPE ztb_orders_0631,
          ls_item  TYPE ztb_items_0631.

    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

    DO 10 TIMES.

      " Generar UUID con clase estándar
      DATA(lv_id) = cl_system_uuid=>create_uuid_x16_static( ).

      " --- Llenar datos de la orden ---
      CLEAR ls_order.
      ls_order-client       = sy-mandt.
      ls_order-id           = lv_id.
      ls_order-email        = |cliente{ sy-index }@test.com|.
      ls_order-firstname    = |Nombre{ sy-index }|.
      ls_order-lastname     = |Apellido{ sy-index }|.
      ls_order-country      = 'Germany'.
      ls_order-createon     = lv_today.
      ls_order-deliverydate = lv_today + 10.
      ls_order-orderstatus  = 1.
      ls_order-imageurl     = |IMG{ sy-index }|.

      " Insertar en tabla de órdenes
      INSERT ztb_orders_0631 FROM @ls_order.

      " --- Llenar datos del item relacionado ---
      CLEAR ls_item.
      ls_item-client            = sy-mandt.
      ls_item-id                = cl_system_uuid=>create_uuid_c36_static( ).
      ls_item-id_order          = lv_id.
      ls_item-name              = |Producto{ sy-index }|.
      ls_item-description       = |Descripción producto { sy-index }|.
      ls_item-releasedate       = lv_today - 30.
      ls_item-discontinueddate  = lv_today + 365.
      ls_item-price             = sy-index * 10.
      ls_item-height            = sy-index * '1.5'.
      ls_item-width             = sy-index * '2.0'.
      ls_item-depth             = sy-index * '0.5'.
      ls_item-quantity          = 100 + sy-index.
      ls_item-unitofmeasure     = 'CM'.

      " Insertar en tabla de ítems
      INSERT ztb_items_0631 FROM @ls_item.


    ENDDO.

    COMMIT WORK.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    TRY.
        me->insert_demo_data( out ).
      CATCH cx_uuid_error INTO DATA(lx_uuid).
        out->write( |Error creando UUID: { lx_uuid->get_text( ) }| ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
