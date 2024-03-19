*&---------------------------------------------------------------------*
*& Report ZSG_EXERCIS_DO_ENDDO_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_do_enddo_command_02.


DATA : gv_text_01  TYPE string VALUE'KIRMIZI'.

DO 5 TIMES.
  TRANSLATE GV_TEXT_01 TO LOWER CASE.
  WRITE / gv_text_01.

ENDDO.
