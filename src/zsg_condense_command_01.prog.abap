*&---------------------------------------------------------------------*
*& Report ZSG_EXERCISE_CONDENSE_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSG_CONDENSE_COMMAND_01.

"Bu komut bir karakter dizisindeki gereksiz boşlukları kaldırmak için kullanılır.
"Bu komut genellikle kullanıcı girişi ya da dış sistemlerden alınan verilerle çalışırken veri temizliği için kullanılır.Boşlukları temizleyerek verilerin düzenlenmesine yardımcı olur.

DATA : gv_text_01 TYPE c LENGTH 100 VALUE 'Bilinmez       bir      akşamın          ufkundayız    vakit          geç neye yarar.'.

WRITE :gv_text_01.


"buraya kadar yazılan -kodlar normal condense komutu tazılmadan yazılan kod.

CONDENSE gv_text_01.

WRITE : gv_text_01.

"yapılan komut ile text içinde bulunan düzensiz şekilde duran boşluklardan krtulmuş olduk.
