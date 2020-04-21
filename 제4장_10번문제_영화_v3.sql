CREATE TABLE CUSTOMER(
	CUSTOMER_ID Integer,
	NAME CHAR(15),
         ADDRESS CHAR(30),
         PHONE CHAR(20));

CREATE TABLE VIDEO(
	VIDEO_ID Integer,
	TITLE CHAR(30),
	GENRE CHAR(30));

CREATE TABLE RESERVED(
	CUSTOMER_ID Integer,
	VIDEO_ID Integer,
        RENT_DATE DATE NOT NULL );

Insert into CUSTOMER Values(1, 'Á¶Àç¹Î','¼­¿ï½Ã ¾çÃµ±¸ ½ÅÁ¤µ¿','010-4918-5635');
Insert into CUSTOMER Values(2, 'Á¤ÈÆº¹','¼­¿ï½Ã ¼­ÃÊ±¸','010-6743-7455');
Insert into CUSTOMER Values(3, '±è±¤¹Î','¼­¿ï½Ã °­¼­±¸','010-3521-6644');

Insert into VIDEO Values(1, '¹ÝÁöÀÇÁ¦¿Õ', 'ÆÇÅ¸Áö');
Insert into VIDEO Values(2, '´ÙÅ¥1', '´ÙÅ¥¸àÅÍ¸®');
Insert into VIDEO Values(3, '´ÙÅ¥2', '´ÙÅ¥¸àÅÍ¸®');
Insert into VIDEO Values(4, 'ÆÇÅ¸2', 'ÆÇÅ¸Áö');
Insert into VIDEO Values(5, '¸á·Î1', '¸á·Î¹°');
Insert into VIDEO Values(6, '¸á·Î2', '¸á·Î¹°');
Insert into VIDEO Values(7, '´ÙÅ¥3', '´ÙÅ¥¸àÅÍ¸®');
Insert into VIDEO Values(8, '007 Sky Fall', '¾×¼Ç');

Insert into RESERVED values(1, 1,'2015/4/5');
Insert into RESERVED values(2, 2,'2015/3/30');
Insert into RESERVED values(2, 3,'2015/4/1');
Insert into RESERVED values(2, 7,'2015/4/10');
Insert into RESERVED values(1, 5,'2015/4/9');
Insert into RESERVED values(1, 8,'2015/4/9');
Insert into RESERVED values(1, 3,'2015/4/9');
