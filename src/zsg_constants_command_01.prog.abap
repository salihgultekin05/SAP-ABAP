*&---------------------------------------------------------------------*
*& Report ZSG_EXERCISE_CONSTANTS_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_constants_command_01.

"constantkelimesi ise bir sabit değişken tanımlamak için kullanılırsabit değişkenler bir program içinde değeri değişmeyen sabit kalan değişkenlerdir.
"BU DEĞİŞKENLER GELİŞTİRİCİ TARAFINDAN 1 KERE YAZILIP İSTENİLDİĞİNDE KULLANILIR. DEĞİŞTİRİLEMEZ.

CONSTANTS: gc_city   TYPE c LENGTH 10 VALUE 'Adıyaman',
           gc_user   TYPE string VALUE 'User_1',
           gc_nummer TYPE i VALUE 2017,
           gc_numnum TYPE n LENGTH 5 VALUE 123,
           gc_date   TYPE d VALUE '20170710',
           gc_time   TYPE t VALUE '235645',
           gc_pnum   TYPE p DECIMALS 4 VALUE '120.1544'.

WRITE : gc_city,
      / gc_user,
      / gc_nummer,
      / gc_numnum,
      / gc_date,
      /  gc_time,
      / gc_pnum.
