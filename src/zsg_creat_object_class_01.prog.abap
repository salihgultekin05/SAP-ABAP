*&---------------------------------------------------------------------*
*& Report ZSG_CREAT_OBJECT_CLASS_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_creat_object_class_01.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS : p_num_01 TYPE i,
               p_num_02 TYPE i,
               p_sembol TYPE c LENGTH 1.
SELECTION-SCREEN END OF BLOCK a1.

DATA : go_calculator TYPE REF TO zsgcalculator,
       gv_sonuc      TYPE i.
CREATE OBJECT go_calculator.

IF p_sembol = '+'.

  go_calculator->topla(
    EXPORTING
      iv_num_topla_01 = p_num_01
      iv_num_topla_02 = p_num_02
    IMPORTING
      ev_result       = gv_sonuc ).

ELSEIF p_sembol = '-'.
  go_calculator->cikar(
    EXPORTING
      iv_num_cikar_01 = p_num_01
      iv_num_cikar_02 = p_num_02
    IMPORTING
      ev_result       = gv_sonuc ).

ELSEIF p_sembol = '*'.
  go_calculator->carp(
    EXPORTING
      iv_num_carp_01 = p_num_01
      iv_num_carp_02 = p_num_02
    IMPORTING
      ev_result      = gv_sonuc ).

ELSEIF p_sembol = '/'.

  IF p_num_02 NE 0.
    go_calculator->bol(
      EXPORTING
        iv_num_bol_01  = p_num_01
        iv_num_bol_02  = p_num_02
      IMPORTING
        ev_result      = gv_sonuc ).
  ELSE.
    MESSAGE '2.SAYI 0 OLAMAZ' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

ELSE.
  MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
ENDIF.

WRITE : gv_sonuc.
