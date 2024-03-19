*&---------------------------------------------------------------------*
*& Report ZSG_ALV_COMBINATION2_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_alv_combination2_01.

"BURADA ALV ALMA YÖNTEMLERİNDE 2. KOMBİNASYONU GÖRECEĞİZ.

DATA : gt_table    TYPE TABLE OF zsg_table_01,
       gt_fieldcat TYPE lvc_t_fcat,
       gs_layout   TYPE lvc_s_layo.

START-OF-SELECTION.

  PERFORM select_database.
  PERFORM field_catalog.
  PERFORM layout.
  PERFORM display_alv.


FORM select_database.
  SELECT * FROM zsg_table_01 INTO TABLE gt_table.
ENDFORM.

FORM field_catalog.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZSG_TABLE_01'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc NE 0.
    EXIT.
  ENDIF.


ENDFORM.

FORM layout.
  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.

ENDFORM.

FORM display_alv.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program = sy-repid
      is_layout_lvc      = gs_layout
      it_fieldcat_lvc    = gt_fieldcat
    TABLES
      t_outtab           = gt_table

  exceptions
    program_error      = 1
    others             = 2.
  IF sy-subrc NE 0.
    EXIT.
  ENDIF.


ENDFORM.
