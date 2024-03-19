*&---------------------------------------------------------------------*
*& Report ZSG_EXERCIS_DO_ENDDO_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSG_DO_ENDDO_01.

"bir döngü başlatmak için genellikle "DO ... ENDDO" bloğu kullanılır.
" Döngünün şartları ve içinde gerçekleşen işlemler belirli bir iş mantığına ve ihtiyaca bağlı olarak değişebilir.

DATA: counter TYPE I VALUE '0'.

DO 20 TIMES.
  counter = counter + 1.
  WRITE: / 'Counter:', counter.
ENDDO.
