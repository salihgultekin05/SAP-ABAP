*&---------------------------------------------------------------------*
*& Report ZSG_EXERCISE_CONSTANTS_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_constants_command_02.

CONSTANTS : gc_time_01   TYPE t VALUE '012100',
            gc_name      TYPE c LENGTH 30 VALUE 'Salih Gültekin',
            gc_adress    TYPE c LENGTH 30 VALUE'Kırlangıç Sokak 11',
            gc_number_01 TYPE i VALUE '124',
            gc_number_02 TYPE n LENGTH 3 VALUE'123',
            gc_date      TYPE d VALUE '20170710',
            gc_time_02   TYPE t VALUE '173025',
            gc_number_03 TYPE p DECIMALS 10 VALUE '123.12'.

WRITE : gc_time_01,
      / gc_name,
      / gc_adress,
      / gc_number_01,
      / gc_number_02,
      / gc_date,
      / gc_time_02,
      / gc_number_03.
