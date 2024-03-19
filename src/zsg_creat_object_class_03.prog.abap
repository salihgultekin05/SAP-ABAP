*&---------------------------------------------------------------------*
*& Report ZSG_CREAT_OBJECT_CLASS_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_creat_object_class_03.

*TYPES: BEGIN OF gty_table,
*         box.
*         INCLUDE STRUCTURE zsg_stravelag_03.
*TYPES : END OF gty_table.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.

  PARAMETERS: p_ag_num TYPE s_agncynum,
              p_name   TYPE s_agncynam,
              p_street TYPE s_street,
              p_pbox   TYPE s_postbox,
              p_pcode  TYPE postcode,
              p_city   TYPE city,
              p_cntry  TYPE s_country,
              p_region TYPE s_region,
              p_tel    TYPE s_phoneno,
              p_curr   TYPE s_curr_ag.
SELECTION-SCREEN END OF BLOCK a1.

DATA: go_stravelag_new_entry_alv TYPE REF TO zsg_starvelag_new_entry_alv,
      gt_fcat                    TYPE slis_t_fieldcat_alv,
      gs_layout                  TYPE slis_layout_alv,
      gt_stravelag               TYPE ZCM_TT_STRAVELAG2.

START-OF-SELECTION.

  CREATE OBJECT go_stravelag_new_entry_alv.

  go_stravelag_new_entry_alv->new_entry(
    EXPORTING
      iv_agencynum = p_ag_num
      iv_name      = p_name
      iv_street    = p_street
      iv_postbox   = p_pbox
      iv_postcode  = p_pcode
      iv_city      = p_city
      iv_country   = p_cntry
      iv_region    = p_region
      iv_telephone = p_tel
      iv_currency  = p_curr ).

  go_stravelag_new_entry_alv->pref_sel_data(
    IMPORTING
      et_stravelag_table = gt_stravelag
  ).

  go_stravelag_new_entry_alv->pref_fcat(
    IMPORTING
      et_fcat = gt_fcat
    EXCEPTIONS
      no_fcat = 1
      OTHERS  = 2
  ).
  IF sy-subrc <> 0.
    MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
    LEAVE PROGRAM.
  ENDIF.

  go_stravelag_new_entry_alv->pref_layout(
    EXPORTING
      iv_zebra         = abap_true
      iv_colwidth_optm = abap_true
    IMPORTING
      es_layout        = gs_layout
  ).

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      is_layout          = gs_layout
      it_fieldcat        = gt_fcat
    TABLES
      t_outtab           = gt_stravelag
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

  go_stravelag_new_entry_alv->pref_show_data(
    EXPORTING
      it_fcat            = gt_fcat
      is_layout          = gs_layout
      it_stravelag_tablo = gt_stravelag                " TT FOR THE STRAVELAG
  ).
