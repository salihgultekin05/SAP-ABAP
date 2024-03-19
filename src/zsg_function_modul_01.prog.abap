*&---------------------------------------------------------------------*
*& Report ZSG_FUNCTION_MODUL_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_function_modul_01.

"İLK OLARAK SE37 EKRANINDA BİR FONKSİYON GRUBU (GOTO-----> FUNCTION GRUP------>CREAT) ARDINDAN FONKSİYON MODULÜ OLUŞTURULUR.
"FONKSİYON MODULU İÇERİSİNE GEREKLİ DATALAR İNPORT KISMINA, İŞLENİLEN DATA İSE EXPORT KISMINA YAZILDIKTAN SONRA,
"SOURCE CODE KISMINA İSE YAPILACAK KOD BLOĞU YAZILIR. VE AKTİF HALE GETİRİLİR.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS : p_num1 TYPE i,
               p_num2 TYPE i.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  DATA : gv_result TYPE i.


  CALL FUNCTION 'ZSG_FM_2DEG_TOPLAMA'
    EXPORTING
      iv_number_1 = p_num1
      iv_number_2 = p_num2
    IMPORTING
      ev_result   = gv_result.

  WRITE : TEXT-002,gv_result.
