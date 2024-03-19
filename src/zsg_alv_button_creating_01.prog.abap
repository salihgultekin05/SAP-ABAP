*&---------------------------------------------------------------------*
*& Report ZSG_ALV_BUTTON_CREATING_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_alv_button_creating_01.

"ALV İÇERİSİNDE BUTON OLUŞTURMADA 'REUSE_ALV_GRID_DISPLAY' İÇERİSİNDE
"I_CALLBACK_PF_STATUS_SET,
"I_CALLBACK_USER_COMMAND
"KOMUTLARI AKTİF HALE GETİRMEKTİR. DAHA SONRA BU SATIRLARA OLUŞTURULAN İSİMLER 1- STATUS TANIMLAMA 2- UCOMM TANIMLAMA. 26.SATIRDA TANIM ÖRNEĞİ.

TYPES : BEGIN OF gty_table_001,
          box.
          INCLUDE STRUCTURE zsg_table_01.
TYPES : END OF gty_table_001.

DATA : gt_table      TYPE TABLE OF gty_table_001,
       gt_selected   TYPE TABLE OF gty_table_001,
       gs_selected   TYPE gty_table_001,
       gt_fieldcat   TYPE slis_t_fieldcat_alv, " table type
       gs_fieldcat   TYPE slis_fieldcat_alv,   " structure
       gt_fcat_popup TYPE slis_t_fieldcat_alv,
       gs_fcat_popup TYPE slis_fieldcat_alv,
       gv_answer     TYPE c LENGTH 1,
       gs_layout     TYPE slis_layout_alv,
       gv_e_mail     TYPE c LENGTH 80.

PERFORM select_from_db.
PERFORM fieldcat.
PERFORM layout.
PERFORM display_alv.

FORM status_01 USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'STATUS_01'.
ENDFORM.




FORM select_from_db.
  SELECT * FROM zsg_table_01 INTO CORRESPONDING FIELDS OF TABLE gt_table.
ENDFORM.

FORM uc_01 USING lv_ucom     TYPE sy-ucomm
                 ls_selfield TYPE slis_selfield.
  CASE lv_ucom.
    WHEN 'LEAVE'. " STATUSTE TANIMLADIĞIMIZ GERİ SEKMESİNİ AKTİVE EDER.
      LEAVE PROGRAM.
    WHEN 'SORT_NAME'.   "BUTONA BASINCA TOBLOYU İSME GÖRE SIRALAR.
      SORT gt_table BY name ASCENDING.
      PERFORM display_alv.
    WHEN '&IC1'. "BURADA Kİ İŞLEMDE ID SEKMESİNE 2 DEFA TIKLAYINCA POPUP AÇILIP ORADAKİ BİLGİLERİ GÜNCELLEMEMİZEYARIYOR.
      IF ls_selfield-fieldname = 'ID'.
        SELECT * FROM zsg_table_01 INTO CORRESPONDING FIELDS OF TABLE gt_selected WHERE id = ls_selfield-value.

        IF gt_fcat_popup IS INITIAL.
          LOOP AT gt_fieldcat INTO gs_fieldcat.
            IF gs_fieldcat-key IS INITIAL AND gs_fieldcat-fieldname NE 'SALARY'.
              gs_fieldcat-edit  = abap_true.
              gs_fieldcat-input = abap_true.
            ENDIF.
            APPEND gs_fieldcat TO gt_fcat_popup.
            CLEAR : gs_fieldcat.
          ENDLOOP.
        ENDIF.

        CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
          EXPORTING
            i_title               = TEXT-001
            i_screen_start_column = 5
            i_screen_start_line   = 5
            i_screen_end_column   = 168
            i_screen_end_line     = 8
            i_tabname             = 'GT_SELECTED'
            it_fieldcat           = gt_fcat_popup
            i_callback_program    = sy-repid
          IMPORTING
            e_exit                = gv_answer
          TABLES
            t_outtab              = gt_selected
          EXCEPTIONS
            program_error         = 1
            OTHERS                = 2.
        IF sy-subrc NE 0.
          EXIT.
        ENDIF.

        IF gv_answer IS INITIAL.
          READ TABLE gt_selected INTO gs_selected INDEX 1.
          IF sy-subrc IS INITIAL.
            UPDATE zsg_table_01 SET name     = gs_selected-name
                                    surname  = gs_selected-surname
                                    job      = gs_selected-job
                                    currency = gs_selected-currency
                                    gsm      = gs_selected-gsm
                                    e_mail   = gs_selected-e_mail
                                    WHERE id = gs_selected-id.

            PERFORM select_from_db.
            PERFORM display_alv.
          ENDIF.
        ENDIF.
      ELSEIF ls_selfield-fieldname = 'E_MAIL'.

        CALL FUNCTION 'ZSG_FM_ALV_01'
          IMPORTING
            ev_e_mail = gv_e_mail
            ev_answer = gv_answer.
        IF gv_e_mail IS NOT INITIAL AND gv_answer IS INITIAL.
          UPDATE  zsg_table_01 SET   e_mail   = gv_e_mail
                               WHERE e_mail   = ls_selfield-value.
          PERFORM select_from_db.
          SORT gt_table BY id.
          PERFORM display_alv.

        ENDIF.

      ENDIF .
*  	WHEN OTHERS.
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
  LOOP AT gt_fieldcat INTO gs_fieldcat.
    CASE gs_fieldcat-fieldname .
      WHEN 'E_MAIL'.
        gs_fieldcat-hotspot = abap_true.
        MODIFY gt_fieldcat FROM gs_fieldcat TRANSPORTING hotspot WHERE fieldname = 'E_MAIL'.

*	WHEN .
*	WHEN OTHERS.
    ENDCASE.
  ENDLOOP.
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
      i_callback_pf_status_set = 'STATUS_01'
      i_callback_user_command  = 'UC_01'
    TABLES
      t_outtab                 = gt_table
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc IS NOT INITIAL.
    EXIT.
  ENDIF.
ENDFORM.
