*&---------------------------------------------------------------------*
*& Report ZSG_EXERCISE_CONCATENATE_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_concatenate_command_02.

DATA : gv_adı             TYPE string VALUE'Salih',
       gv_soyadı          TYPE string VALUE 'Gültekin',
       gv_sınıf           TYPE string VALUE '12-A',
       gv_bolum           TYPE string VALUE 'Türkçe-Matematik',
       gv_okul            TYPE string VALUE 'Adıyaman Lisesi',
       gv_ogrenci_bılgısı TYPE string.

CONCATENATE gv_adı ',' gv_soyadı ',' gv_sınıf ',' gv_bolum ',' gv_okul'.'
INTO gv_ogrenci_bılgısı RESPECTING BLANKS.

WRITE: 'Öğrenci Bilgisi:' , gv_ogrenci_bilgisi.
