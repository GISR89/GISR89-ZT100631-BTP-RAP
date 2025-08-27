CLASS zcl_virtual_code_0631 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit_calc_element_read.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_virtual_code_0631 IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA lt_input  TYPE STANDARD TABLE OF zc_orders_0631 WITH DEFAULT KEY.


    lt_input = CORRESPONDING #( it_original_data ).

    LOOP AT lt_input ASSIGNING FIELD-SYMBOL(<fs_input>).
      CASE <fs_input>-orderstatus.
        WHEN 1. <fs_input>-status = 'Open'. " Open
        WHEN 2. <fs_input>-status = 'Accepted'. " Accepted
        WHEN 3. <fs_input>-status = 'Canceled'. " Canceled
        WHEN OTHERS. <fs_input>-status = '-'.
      ENDCASE.

      ct_calculated_data = CORRESPONDING #( lt_input ).

    ENDLOOP.

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.



  ENDMETHOD.

ENDCLASS.
