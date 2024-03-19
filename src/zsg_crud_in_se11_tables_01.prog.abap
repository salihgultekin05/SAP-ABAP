*&---------------------------------------------------------------------*
*& Report ZSG_CRUD_IN_SE11_TABLES_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_crud_in_se11_tables_01.

DATA : gs_structure TYPE zsg_table_01,
       gt_table     TYPE TABLE OF zsg_table_01.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS : p_id     TYPE zsg_table_01-id,
               p_name   TYPE zsg_table_01-name,
               p_sname  TYPE zsg_table_01-surname,
               p_job    TYPE zsg_table_01-job,
               p_slry   TYPE zsg_table_01-salary,
               p_cur    TYPE zsg_table_01-currency,
               p_gsm    TYPE zsg_table_01-gsm,
               p_email  TYPE zsg_table_01-e_mail,
               p_create RADIOBUTTON GROUP xyz,
               p_read   RADIOBUTTON GROUP xyz,
               p_update RADIOBUTTON GROUP xyz,
               p_delete RADIOBUTTON GROUP xyz.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  IF p_create = abap_true.

    IF p_id IS INITIAL.
      MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
    ELSE.

      SELECT SINGLE * FROM zsg_table_01 INTO gs_structure WHERE id = p_id.
      IF sy-subrc IS INITIAL.
        MESSAGE TEXT-003 TYPE 'S' DISPLAY LIKE 'E'.
      ELSE.
        gs_structure-id      = p_id    .
        gs_structure-name    = p_name  .
        gs_structure-surname = p_sname .
        gs_structure-job     = p_job   .
        gs_structure-salary  = p_slry  .
        gs_structure-currency    = p_cur  .
        gs_structure-gsm     = p_gsm   .
        gs_structure-e_mail  = p_email .

        INSERT zsg_table_01 FROM gs_structure.
        IF sy-subrc IS INITIAL.
          MESSAGE TEXT-004 TYPE 'S'.
        ELSE.
          MESSAGE TEXT-005 TYPE 'S' DISPLAY LIKE 'E'.
        ENDIF.
      ENDIF.
      CLEAR : gs_structure.
    ENDIF.

  ELSEIF p_read = abap_true.


    IF p_id IS INITIAL.

      SELECT * FROM zsg_table_01 INTO TABLE gt_table.
      IF sy-subrc IS INITIAL.
        LOOP AT gt_table INTO gs_structure.
          WRITE : gs_structure-id , gs_structure-name  , gs_structure-surname,
                  gs_structure-job, gs_structure-salary, gs_structure-currency,
                  gs_structure-gsm, gs_structure-e_mail.
          CLEAR : gs_structure.
          SKIP.
          ULINE.
        ENDLOOP.
      ELSE.
        MESSAGE TEXT-006 TYPE 'I'.
      ENDIF.

    ELSE.

      SELECT SINGLE * FROM zsg_table_01 INTO gs_structure WHERE id = p_id.
      IF sy-subrc IS INITIAL.
        WRITE : gs_structure-id , gs_structure-name  , gs_structure-surname,
                gs_structure-job, gs_structure-salary, gs_structure-currency,
                gs_structure-gsm, gs_structure-e_mail.
        CLEAR : gs_structure.
      ELSE.
        MESSAGE TEXT-007 TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.

    ENDIF.

  ELSEIF p_update = abap_true.


    IF p_id IS INITIAL.
      MESSAGE TEXT-008 TYPE 'S' DISPLAY LIKE 'E'.
    ELSE.
      SELECT SINGLE * FROM zsg_table_01 INTO gs_structure WHERE id = p_id.
      IF sy-subrc IS INITIAL.
        UPDATE zsg_table_01 SET name    = p_name
                                 surname = p_sname
                                 job     = p_job
                                 salary  = p_slry
                                 currency    = p_cur
                                 gsm     = p_gsm
                                 e_mail  = p_email
                           WHERE id      = p_id.
        IF sy-subrc IS INITIAL.
          MESSAGE TEXT-009 TYPE 'S'.
        ELSE.
          MESSAGE TEXT-010 TYPE 'S' DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE TEXT-011 TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
    ENDIF.


  ELSEIF p_delete = abap_true.

    IF p_id IS INITIAL.

      MESSAGE TEXT-012 TYPE 'S' DISPLAY LIKE 'E'.

    ELSE.

      SELECT SINGLE * FROM zsg_table_01 INTO gs_structure WHERE id = p_id.
      IF sy-subrc IS INITIAL.
        DELETE FROM zsg_table_01 WHERE id = p_id.
        IF sy-subrc IS INITIAL.
          MESSAGE TEXT-013 TYPE 'S'.
        ELSE.
          MESSAGE TEXT-014 TYPE 'S' DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE TEXT-015 TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
    ENDIF.

  ENDIF.
