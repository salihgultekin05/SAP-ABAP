*&---------------------------------------------------------------------*
*& Report ZSG_ALV_DISPLAY_IN_REPORT_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_alv_display_in_report_01.

"DEBUGG EKRANINDA GT_FİELDCAT İÇERİSİNDE
"ROWPOST    (KOLONLARDA SIRALAMA YAPAR),
"EDİT       (SEÇİLEN KOLONLARDA İŞLEM YAPMAYI SAĞLAR),
"CHECHBOX   (SEÇİLEN KOLONDA CHECKBOX KUTUCUGU AÇAR İÇİNDE VERİ TUTAN HÜCRELERDE KULLANILMAZ),
"JUST       (SEÇİLEN KOLONU SAĞA SOLA ORTAYA SIRALAR),
"LZERO      (SEÇİLEN SATIRDA NUM TİPİNDEKİ DEĞİŞKENLERİN SOLA DOĞRU SIFIRA TAMAMLAR)
"NO_ZERO    (İNT TİPİNDEKİ DEĞER 0 İSE SATIRI BOŞ GÖSTERİR)
"EMPHASIZE  (İLGİLİ KOLONUN YEŞİL RENKTE VURGULANMASINI SAĞLAR)
"NO_OUT     (SEÇİLEN KOLONU GİZLER.)
"HOTSPOT    (SEÇİLEN KOLONDAKİ DEĞERİ ÜZERİ TIKLANABİLİR HALE GETİRİR.)

DATA: gt_table    TYPE TABLE OF zsg_table_01,
      gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv.

START-OF-SELECTION.
  SELECT * FROM zsg_table_01 INTO TABLE gt_table.

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
  IF sy-subrc NE 0.
    EXIT.
  ENDIF.
