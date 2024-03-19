*&---------------------------------------------------------------------*
*& Report ZSG_CREAT_OBJECT_CLASS_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_creat_object_class_02.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME NO INTERVALS.
  PARAMETERS : p_num1  TYPE i,
               p_num2  TYPE i,
               p_islem TYPE C LENGTH 1.
SELECTION-SCREEN END OF BLOCK a1.

DATA : go_calculater TYPE REF TO zsgcalculator_02 ,
       gv_sonuc      TYPE i.

CREATE OBJECT go_calculater.

go_calculater->hesapla(
  EXPORTING
    iv_sembol = p_islem
    iv_num_01 = p_num1
    iv_num_02 = p_num2
  IMPORTING
    ev_result = gv_sonuc
  EXCEPTIONS
    gecersiz_islem_kodu = 1
    others              = 2 ).

IF SY-SUBRC EQ 1.
  MESSAGE 'GEÇERSİZ İŞLEM KODU' TYPE 'S' DISPLAY LIKE 'E'.
  EXIT.
ENDIF.

WRITE : gv_sonuc.
