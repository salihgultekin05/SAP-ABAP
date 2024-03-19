*&---------------------------------------------------------------------*
*& Report ZSG_ALV_SELECTION_BOX
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_alv_selection_box.
"GELEN EKRANDAKİ TABLOLARDA SEÇİM YAPMAMIZA OLANAK TANIYAN BİR İŞLEMDİR.
"EGER SEÇİM KUTUCUĞU TANIMLANACAK İSE TYPES TANIMLAYIP BUNU LAYOUT DA
"ÖRNEĞİN   gs_layout-box_fieldname     = 'BOX'. ŞEKLİNDE TANIMLAMAMIZ GEREKİR.


TYPES : BEGIN OF gty_table,
          box.
          INCLUDE STRUCTURE zsg_table_01.
TYPES : END OF gty_table.

DATA :gt_table    TYPE TABLE OF gty_table,
      gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv.

START-OF-SELECTION.

  SELECT * FROM zsg_table_01 INTO CORRESPONDING FIELDS OF TABLE gt_table.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'zsg_table_01'
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

  gs_layout-zebra             = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname     = 'BOX'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      is_layout          = gs_layout
      it_fieldcat        = gt_fieldcat
    TABLES
      t_outtab           = gt_table
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.
  IF sy-subrc IS NOT INITIAL.
    EXIT.
  ENDIF.
