*&---------------------------------------------------------------------*
*& Report ZSG_FOR_ALL_ENTRIES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsg_for_all_entries.

DATA : gv_carrid  TYPE s_carr_id,
       gs_scarr   TYPE scarr,
       gs_spfli   TYPE spfli,
       gs_sflight TYPE sflight,
       gt_scarr   TYPE TABLE OF scarr,
       gt_spfli   TYPE TABLE OF spfli,
       gt_sflight TYPE TABLE OF sflight.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS : so_carid FOR gv_carrid.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  SELECT * FROM scarr INTO TABLE gt_scarr WHERE carrid IN so_carid.

  IF gt_scarr IS NOT INITIAL.

    WRITE : TEXT-002.

    LOOP AT gt_scarr INTO gs_scarr.
      WRITE : / gs_scarr-carrid , gs_scarr-carrname, gs_scarr-currcode, gs_scarr-url.
      CLEAR: gs_scarr.
    ENDLOOP.

    SELECT * FROM spfli   INTO TABLE gt_spfli   FOR ALL ENTRIES IN gt_scarr WHERE carrid = gt_scarr-carrid.
    SELECT * FROM sflight INTO TABLE gt_sflight FOR ALL ENTRIES IN gt_scarr WHERE carrid = gt_scarr-carrid.

  ENDIF.

  IF gt_spfli IS NOT INITIAL.
    SKIP.
    WRITE : TEXT-003.

    LOOP AT gt_spfli INTO gs_spfli.
      WRITE : / gs_spfli-carrid  , gs_spfli-connid   , gs_spfli-countryfr, gs_spfli-cityfrom,
                gs_spfli-airpfrom, gs_spfli-countryto, gs_spfli-cityto   , gs_spfli-airpto,
                gs_spfli-fltime  , gs_spfli-deptime  , gs_spfli-arrtime  , gs_spfli-distance,
                gs_spfli-distid  , gs_spfli-fltype   , gs_spfli-period  .

    ENDLOOP.
  ENDIF.

  SKIP.
  ULINE.

  IF gt_sflight IS NOT INITIAL.
    WRITE : TEXT-004.

    LOOP AT gt_sflight INTO gs_sflight.

      WRITE : / gs_sflight-carrid     , gs_sflight-connid     , gs_sflight-fldate  , gs_sflight-price,
                gs_sflight-currency   , gs_sflight-planetype  , gs_sflight-seatsmax, gs_sflight-seatsocc,
                gs_sflight-paymentsum , gs_sflight-seatsmax_b , gs_sflight-seatsocc_b, gs_sflight-seatsmax_f,
                gs_sflight-seatsocc_f.

    ENDLOOP.

  ENDIF.
