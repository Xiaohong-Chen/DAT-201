CREATE TABLE public.advancedMath
(
  amid integer NOT NULL DEFAULT nextval('educationdataid_seq'),
  districtname text,
  schoolname text,
  aun text,
  schl text,
  dataelement text,
  value numeric,
  CONSTRAINT ampk PRIMARY KEY (amid)
)

\copy advancedMath (districtname, schoolname, aun, schl, dataelement, value) FROM '/home/cogconnect2/Desktop/DAT_201_FinalProject/Data/advanced_Mathematics.csv' WITH (FORMAT CSV, DELIMITER ',', HEADER TRUE);


CREATE SEQUENCE IF NOT EXISTS aveincome_seq
START WITH 1
INCREMENT BY 1
MINVALUE 1
NO MAXVALUE
CACHE 1;

CREATE TABLE public.aveIncome
(
  aiid integer NOT NULL DEFAULT nextval('aveincome_seq'),
  geoid text,
  geoid2 integer,
  schooldistrictname text,
  aveincome numeric,
  CONSTRAINT aipk PRIMARY KEY (aiid)
);

\copy aveIncome (geoid, geoid2, schooldistrictname, aveincome) FROM '/home/cogconnect2/Desktop/DAT_201_FinalProject/Data/ave_Income.csv' WITH (FORMAT CSV, DELIMITER ',', HEADER TRUE);



CREATE TABLE aveMathScore
AS (Select districtname, aun, avg(value) as avemathpoint from advancedMath where dataelement ='Percent  Advanced  Mathematics/Algebra 1  (All Student)' group by aun, districtname
);

ALTER TABLE aveMathScore ADD COLUMN amsid SERIAL PRIMARY KEY;


CREATE TABLE assemble
AS (SELECT aveMathScore.districtname, aveMathScore.aun, aveMathScore.avemathpoint, aveIncome.aveincome FROM aveMathScore INNER JOIN aveIncome on aveMathScore.districtname = aveIncome.schooldistrictname
);

ALTER TABLE assemble ADD COLUMN asseid SERIAL PRIMARY KEY;