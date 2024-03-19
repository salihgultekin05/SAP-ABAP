*&---------------------------------------------------------------------*
*& Report ZSG_EXERCISE_CONCATENATE_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_concatenate_command_01.

"bir veya daha fazla karakter dizisini birleştirmekiçin kullanılır.Yani İki veya daha fazla karakter dizisini tek bir karakter dizisine birleştirir.

DATA : gv_mahalle TYPE string,
       gv_cadde   TYPE string,
       gv_no      TYPE string,
       gv_pk      TYPE string,
       gv_ilce    TYPE string,
       gv_il      TYPE string,
       gv_adres   TYPE string.

gv_mahalle = 'Cumhuriyet Mahallesi'.
gv_cadde   = 'Atatürk Caddesi'.
gv_no      = '13'.
gv_pk      = '73054'.
gv_ilce    = 'Merkez'.
gv_il      = 'Adıyaman'.

CONCATENATE gv_mahalle ',' gv_cadde ',' gv_no ',' gv_pk ',' gv_ilce ',' gv_il '.'
       INTO gv_adres RESPECTING BLANKS.

WRITE: 'Adres:' , gv_adres.
