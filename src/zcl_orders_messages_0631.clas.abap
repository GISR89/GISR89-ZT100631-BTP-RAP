CLASS zcl_orders_messages_0631 DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .
    INTERFACES if_abap_behv_message .

    CONSTANTS:
      gc_msgid TYPE symsgid VALUE 'ZMC_ORDER_MESSAG_631',

      BEGIN OF created_invalid,
        msgid TYPE symsgid VALUE 'ZMC_ORDER_MESSAG_631',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF created_invalid,

      BEGIN OF createddate_invalid,
        msgid TYPE symsgid VALUE 'ZMC_ORDER_MESSAG_631',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF createddate_invalid,

      BEGIN OF deliverydate_invalid,
        msgid TYPE symsgid VALUE 'ZMC_ORDER_MESSAG_631',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF deliverydate_invalid,

      BEGIN OF not_authorized,
        msgid TYPE symsgid VALUE 'ZMC_ORDER_MESSAG_631',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF not_authorized.

    METHODS constructor
      IMPORTING
        textid       LIKE if_t100_message=>t100key OPTIONAL
        attr1        TYPE string OPTIONAL
        attr2        TYPE string OPTIONAL
        attr3        TYPE string OPTIONAL
        attr4        TYPE string OPTIONAL
        previous     LIKE previous OPTIONAL
        id           TYPE sysuuid_x16 OPTIONAL
        email        TYPE zde_email_0631 OPTIONAL
        firstname    TYPE zde_firstname_0631 OPTIONAL
        lastname     TYPE zde_lastname_0631 OPTIONAL
        country      TYPE zde_country_0631 OPTIONAL
        createon     TYPE zde_createon_0631 OPTIONAL
        deliverydate TYPE zde_deliverydate_0631 OPTIONAL
        orderstatus  TYPE zde_orderstatus_0631 OPTIONAL
        imageurl     TYPE zde_imageurl_0631 OPTIONAL
        severity     TYPE if_abap_behv_message=>t_severity OPTIONAL
        uname        TYPE syuname OPTIONAL.

    DATA :
      mv_attr1        TYPE string,
      mv_attr2        TYPE string,
      mv_attr3        TYPE string,
      mv_attr4        TYPE string,
      mv_id           TYPE sysuuid_x16,
      mv_email        TYPE zde_email_0631,
      mv_firstname    TYPE zde_firstname_0631,
      mv_lastname     TYPE zde_lastname_0631,
      mv_country      TYPE zde_country_0631,
      mv_createon     TYPE zde_createon_0631,
      mv_deliverydate TYPE zde_deliverydate_0631,
      mv_orderstatus  TYPE zde_orderstatus_0631,
      mv_imageurl     TYPE zde_imageurl_0631,
      mv_uname        TYPE syuname.

  PROTECTED    SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_orders_messages_0631 IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).

    me->mv_attr1                 = attr1.
    me->mv_attr2                 = attr2.
    me->mv_attr3                 = attr3.
    me->mv_attr4                 = attr4.
    me->mv_id                    =  id.
    me->mv_email                 =  email.
    me->mv_firstname             =  firstname.
    me->mv_lastname              =  lastname.
    me->mv_country               =  country.
    me->mv_createon              =  createon.
    me->mv_deliverydate          =  deliverydate.
    me->mv_orderstatus           =  orderstatus.
    me->mv_imageurl              =  imageurl.


    if_abap_behv_message~m_severity = severity.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
