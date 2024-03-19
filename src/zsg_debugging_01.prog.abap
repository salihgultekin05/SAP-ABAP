*&---------------------------------------------------------------------*
*& Report ZSG_DEBUGGING_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_debugging_01.

PARAMETERS :p_num1  TYPE i,
            p_num2  TYPE i,
            p_trnsc TYPE c LENGTH 1.
DATA :gv_result        TYPE p DECIMALS 2,
      gv_result_string TYPE string,
      gv_message       TYPE string.

IF p_trnsc = '+'.
  gv_result = p_num1 + p_num2.
ELSEIF p_trnsc = '*'.
  gv_result = p_num1 * p_num2.
ELSEIF p_trnsc = '/'.
  gv_result = p_num1 / p_num2.
ELSEIF p_trnsc = '-'.
  gv_result = p_num1 - p_num2.
ELSE .
  MESSAGE TEXT-001 TYPE 'S' DISPLAY LIKE 'E'.
  EXIT.
ENDIF.

BREAK user18. " sadece user18 deebuggıng ekranına düşer.
*BREAK-POINT."tüm kullanıcılar deebuggıng ekranına düşer.
gv_result_string = gv_result.

CONCATENATE TEXT-002 gv_result_string INTO gv_message SEPARATED BY space.

MESSAGE gv_message TYPE 'S'.
