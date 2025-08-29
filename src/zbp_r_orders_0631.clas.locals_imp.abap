CLASS lhc_Orders DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Orders RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Orders RESULT result.

    METHODS setStatusToOpen FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Orders~setStatusToOpen.

    METHODS validateFields FOR VALIDATE ON SAVE
      IMPORTING keys FOR Orders~validateFields.

    CONSTANTS:
      BEGIN OF order_status,
        open     TYPE zde_orderstatus_0631 VALUE 1, "Open
        accepted TYPE zde_orderstatus_0631 VALUE 2, "Accepted
        canceled TYPE zde_orderstatus_0631 VALUE 3, "Canceled
      END OF order_status.


ENDCLASS.

CLASS lhc_Orders IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.

    "CB9980002421

    DATA(lv_technical_name) = cl_abap_context_info=>get_user_technical_name(  ).

    "lv_technical_name = 'DIFFERENT'.

    IF requested_authorizations-%create EQ if_abap_behv=>mk-on.

      IF lv_technical_name EQ 'CB9980002421'.
        result-%create = if_abap_behv=>auth-allowed.
      ELSE.

        result-%create = if_abap_behv=>auth-unauthorized.

        APPEND VALUE #( %msg = NEW zcl_orders_messages_0631( textid      = /dmo/cm_flight_messages=>not_authorized
                                                             severity    = if_abap_behv_message=>severity-error )
                        %global = if_abap_behv=>mk-on ) TO reported-orders.

      ENDIF.

    ENDIF.

    IF requested_authorizations-%update      EQ if_abap_behv=>mk-on OR
       requested_authorizations-%action-Edit EQ if_abap_behv=>mk-on.


      IF lv_technical_name EQ 'CB9980002421'.
        result-%update      = if_abap_behv=>auth-allowed.
        result-%action-Edit = if_abap_behv=>auth-allowed.
      ELSE.

        result-%update      = if_abap_behv=>auth-unauthorized.
        result-%action-Edit = if_abap_behv=>auth-unauthorized.

        APPEND VALUE #( %msg = NEW zcl_orders_messages_0631( textid      = /dmo/cm_flight_messages=>not_authorized
                                                             severity    = if_abap_behv_message=>severity-error )
                        %global = if_abap_behv=>mk-on ) TO reported-orders.

      ENDIF.

    ENDIF.

    IF requested_authorizations-%delete EQ if_abap_behv=>mk-on.

      IF lv_technical_name EQ 'CB9980002421'.
        result-%delete = if_abap_behv=>auth-allowed.
      ELSE.

        result-%delete = if_abap_behv=>auth-unauthorized.

        APPEND VALUE #( %msg = NEW zcl_orders_messages_0631( textid      = /dmo/cm_flight_messages=>not_authorized
                                                             severity    = if_abap_behv_message=>severity-error )
                        %global = if_abap_behv=>mk-on ) TO reported-orders.

      ENDIF.
    ENDIF.

  ENDMETHOD.

  METHOD setStatusToOpen.

    "lectura de la entidad
    READ ENTITIES OF zr_orders_0631 IN LOCAL MODE
    ENTITY Orders
    FIELDS ( Orderstatus
             Createon )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_orders).

    DELETE lt_orders WHERE Createon IS NOT INITIAL.

    CHECK lt_orders IS NOT INITIAL.

    MODIFY ENTITIES OF zr_orders_0631 IN LOCAL MODE
      ENTITY Orders
      UPDATE
      FIELDS ( Orderstatus
               Createon )
      WITH VALUE #( FOR Orders IN lt_orders ( %tky = orders-%tky
                                              Orderstatus = order_status-open
                                              Createon = cl_abap_context_info=>get_system_date( ) ) ).

  ENDMETHOD.

  METHOD validateFields.

    "lectura de la entidad
    READ ENTITIES OF zr_orders_0631 IN LOCAL MODE
    ENTITY Orders
    FIELDS ( Createon
             Deliverydate )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_orders).

    LOOP AT lt_orders INTO DATA(order).

      APPEND VALUE #(  %tky               = order-%tky
                         %state_area        = 'VALIDATE_DATES' ) TO reported-orders.

      IF order-Createon IS INITIAL.
        APPEND VALUE #(  %tky   = order-%tky ) TO failed-orders.

        APPEND VALUE #( %tky               = order-%tky
                       %state_area        = 'VALIDATE_DATES'
                        %msg              = NEW zcl_orders_messages_0631(
                                                               textid   = zcl_orders_messages_0631=>created_invalid
                                                               severity = if_abap_behv_message=>severity-error )
                       %element-Createon = if_abap_behv=>mk-on ) TO reported-orders.
      ENDIF.

      IF order-Deliverydate IS INITIAL.
        APPEND VALUE #(  %tky   = order-%tky ) TO failed-orders.

        APPEND VALUE #( %tky              = order-%tky
                       %state_area        = 'VALIDATE_DATES'
                        %msg              = NEW zcl_orders_messages_0631(
                                                               textid   = zcl_orders_messages_0631=>deliverydate_invalid
                                                               severity = if_abap_behv_message=>severity-error )
                       %element-Createon = if_abap_behv=>mk-on ) TO reported-orders.

      ENDIF.

      IF order-Createon < cl_abap_context_info=>get_system_date( ) AND order-Deliverydate IS NOT INITIAL .
        APPEND VALUE #(  %tky   = order-%tky ) TO failed-orders.

        APPEND VALUE #( %tky              = order-%tky
                       %state_area        = 'VALIDATE_DATES'
                        %msg              = NEW zcl_orders_messages_0631(
                                                               textid   = zcl_orders_messages_0631=>createddate_invalid
                                                               severity = if_abap_behv_message=>severity-error )
                       %element-Createon = if_abap_behv=>mk-on ) TO reported-orders.

      ENDIF.

      IF order-Deliverydate < order-Createon AND order-Createon IS NOT INITIAL
                                             AND order-Deliverydate IS NOT INITIAL.
        APPEND VALUE #(  %tky   = order-%tky ) TO failed-orders.

        APPEND VALUE #( %tky              = order-%tky
                       %state_area        = 'VALIDATE_DATES'
                        %msg              = NEW zcl_orders_messages_0631(
                                                               textid   = zcl_orders_messages_0631=>deliverydate_invalid
                                                               severity = if_abap_behv_message=>severity-error )
                       %element-Createon = if_abap_behv=>mk-on ) TO reported-orders.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
