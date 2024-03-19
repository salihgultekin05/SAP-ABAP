*&---------------------------------------------------------------------*
*& Report ZSG_ALV_BUTTON_CREATING_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_alv_button_creating_02.

" PF-STATUS U STANDARD YAPMA.

TYPES : BEGIN OF gty_table_001,
          box.
          INCLUDE STRUCTURE zsg_table_01.
TYPES : END OF gty_table_001.

DATA : gt_table    TYPE TABLE OF gty_table_001,
       gt_fieldcat TYPE slis_t_fieldcat_alv, " table type
       gs_layout   TYPE slis_layout_alv,
       gv_answer   TYPE c LENGTH 1.

PERFORM select_from_db.
PERFORM fieldcat.
PERFORM layout.
PERFORM display_alv.

FORM status_02 USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'STATUS_02'.
ENDFORM.


FORM uc_02 USING lv_ucom     TYPE sy-ucomm
                 ls_selfield TYPE slis_selfield.
  CASE lv_ucom.
    WHEN 'SIL'.
      IF ls_selfield-fieldname = 'ID'.
        DELETE gt_table WHERE id = ls_selfield-value.

        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
            text_question  = TEXT-001
          IMPORTING
            answer         = gv_answer
          EXCEPTIONS
            text_not_found = 1
            OTHERS         = 2.
        IF sy-subrc IS NOT INITIAL.
          EXIT.
        ENDIF.

        IF gv_answer = 1.
          DELETE FROM zsg_table_01 WHERE id = ls_selfield-value.
        ENDIF.

        PERFORM display_alv.

      ENDIF.
    WHEN 'GERI'.
      LEAVE PROGRAM.
  ENDCASE.

ENDFORM.


FORM fieldcat.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZSG_TABLE_01'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc IS NOT INITIAL.
    EXIT.
  ENDIF.

ENDFORM.

FORM layout.
  gs_layout-zebra             = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname     = 'BOX'.
ENDFORM.

FORM display_alv.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      is_layout                = gs_layout
      it_fieldcat              = gt_fieldcat
      i_callback_pf_status_set = 'STATUS_02'
      i_callback_user_command  = 'UC_02'
    TABLES
      t_outtab                 = gt_table
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc IS NOT INITIAL.
    EXIT.
  ENDIF.
ENDFORM.

FORM select_from_db.
  SELECT * FROM zsg_table_01 INTO CORRESPONDING FIELDS OF TABLE gt_table.
ENDFORM.
