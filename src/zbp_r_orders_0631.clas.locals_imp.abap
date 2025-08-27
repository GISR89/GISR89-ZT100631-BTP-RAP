CLASS lhc_Orders DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Orders RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Orders RESULT result.

    METHODS setStatusToOpen FOR DETERMINE ON SAVE
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
                                              Createon = cl_abap_context_info=>get_system_date( )  ) ).

  ENDMETHOD.

  METHOD validateFields.



  ENDMETHOD.

ENDCLASS.
