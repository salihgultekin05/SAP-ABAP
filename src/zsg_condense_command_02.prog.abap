*&---------------------------------------------------------------------*
*& Report ZSG_EXERCISE_CONDENSE_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSG_CONDENSE_COMMAND_02.

"Ne işe yarar.bak 01

data : gv_text_01 TYPE c LENGTH 200 VALUE'Kim      demiş  seni          sevmediğimi               kim           haykırır bu kadar       yüksek      sesle.'.

CONDENSE gv_text_01.
WRITE : gv_text_01.

*********************************************************************************************************************************************************
CONDENSE gv_text_01 NO-GAPS. " buradaki nogaps komutu ise tüm boşlukları ortadan kaldırır.

write : gv_text_01.

" düzensiz boşluk bulunan metin düzenli hake geldi.

.
