*&---------------------------------------------------------------------*
*& Report ZSG_CASE_ENDCASE_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_case_endcase_02.


PARAMETERS : p_num1 TYPE n LENGTH 1.

CASE p_num1.
  WHEN 1.
    WRITE: 'Yeşil renk seçildi.'.
  WHEN 2.
    WRITE: 'Kırmızı renk seçildi.'.
  WHEN 3.
    WRITE: 'Sarı renk seçildi.'.
  WHEN OTHERS.
    WRITE: 'Geçersiz renk kodu. Lütfen 1, 2 veya 3 girin!!!'.
ENDCASE.
