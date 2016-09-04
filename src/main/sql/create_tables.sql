-- National Voter File Database Tables
-- This file contains the DDL for creating the tables, views, and indexes for
-- the national voter file data warehouse


DROP TABLE IF EXISTS DATE_DIM;
CREATE TABLE DATE_DIM
(
  DATE_ID INTEGER NOT NULL PRIMARY KEY
, DATE_VALUE DATE NOT NULL
, DATE_FULL VARCHAR(29)
, DATE_LONG VARCHAR(19)
, DATE_MEDIUM VARCHAR(15)
, DATE_SHORT VARCHAR(8)
, DAY_ABBREVIATION VARCHAR(3)
, DAY_IN_MONTH INTEGER
, DAY_IN_YEAR INTEGER
, DAY_NAME VARCHAR(9)
, MONTH_ABBREVIATION CHAR(3)
, MONTH_NAME VARCHAR(9)
, MONTH_NUMBER INTEGER
, QUARTER_NAME CHAR(2)
, QUARTER_NUMBER INTEGER
, WEEK_IN_MONTH INTEGER
, WEEK_IN_YEAR INTEGER
, YEAR2 CHAR(2)
, YEAR4 CHAR(4)
, YEAR_MONTH_ABBREVIATION CHAR(8)
, YEAR_MONTH_NUMBER CHAR(7)
, YEAR_QUARTER CHAR(7)
, IS_FIRST_DAY_IN_MONTH BOOLEAN
, IS_LAST_DAY_IN_MONTH BOOLEAN
, IS_LAST_DAY_IN_WEEK BOOLEAN
, IS_FIRST_DAY_IN_WEEK BOOLEAN
)
;
DROP INDEX IF EXISTS DATE_DIM_DATE_IDX;
CREATE UNIQUE INDEX DATE_DIM_DATE_IDX on DATE_DIM(DATE_VALUE);

DROP TABLE IF EXISTS REPORTER_DIM;
CREATE TABLE REPORTER_DIM
  (
    REPORTER_ID   SERIAL NOT NULL PRIMARY KEY ,
    REPORTER_NAME VARCHAR (50) ,
    REPORTER_TYPE VARCHAR (50)
  ) ;

  
DROP TABLE IF EXISTS PERSON_DIM;
CREATE TABLE PERSON_DIM
  (
    PERSON_ID     SERIAL NOT NULL PRIMARY KEY ,
    BIRTHDATE     DATE 
  ) ;

DROP INDEX IF EXISTS PERSON_BIRTHDAY_IDX; 
CREATE INDEX PERSON_BIRTHDAY_IDX on PERSON_DIM(BIRTHDATE);
DROP SEQUENCE IF EXISTS PERSON_SEQUENCE;
CREATE SEQUENCE PERSON_SEQUENCE;

DROP TABLE IF EXISTS VOTER_DIM;
CREATE TABLE VOTER_DIM
  (
    VOTER_ID            	SERIAL NOT NULL PRIMARY KEY,
    PERSON_KEY          	INTEGER NULL ,
    STATE_VOTER_REF   	VARCHAR (20) NULL ,
    COUNTY_VOTER_REF	VARCHAR(20) NULL,
    TITLE               	VARCHAR (5) NULL,
    FIRST_NAME               	VARCHAR (50) NULL ,
    MIDDLE_NAME               VARCHAR (50) NULL ,
    LAST_NAME               	VARCHAR (50) NULL ,
    NAME_SUFFIX          	VARCHAR (10) NULL ,
    GENDER              	VARCHAR (1) NULL,
    BIRTHDATE     		DATE NULL,
    REGISTRATION_DATE   	DATE NULL,
    REGISTRATION_STATUS 	VARCHAR (15) NULL,
    ABSTENTEE_TYPE      	VARCHAR (1) NULL,
    PARTY               	VARCHAR (6) NULL,
    EMAIL               	VARCHAR (50) NULL,
    PHONE               	VARCHAR (12) NULL,
    DO_NOT_CALL_STATUS  	VARCHAR (1) NULL,
    LANGUAGE_CHOICE     	VARCHAR (3) NULL,
    VERSION		INTEGER NOT NULL DEFAULT(0),
    VALID_FROM		DATE NOT NULL DEFAULT('1900-01-01'),
    VALID_TO		DATE NOT NULL DEFAULT('2199-12-31')
  ) ;
DROP INDEX IF EXISTS STATE_VOTER_REF_IDX; 
  CREATE INDEX STATE_VOTER_REF_IDX ON VOTER_DIM(STATE_VOTER_REF);

  DROP INDEX IF EXISTS VOTER_PERSON_KEY_IDX; 
  CREATE INDEX VOTER_PERSON_KEY_IDX ON VOTER_DIM(PERSON_KEY);


DROP TABLE IF EXISTS HOUSEHOLD_DIM CASCADE;
CREATE TABLE HOUSEHOLD_DIM
  (
    HOUSEHOLD_ID                 SERIAL NOT NULL PRIMARY KEY,
    ADDRESS_NUMBER               VARCHAR(15) ,
    ADDRESS_NUMBER_PREFIX        VARCHAR(2) ,
    ADDRESS_NUMBER_SUFFIX        VARCHAR(5) ,
    BUILDING_NAME                VARCHAR(50) ,
    CORNER_OF                    VARCHAR(50) ,
    INTERSECTION_SEPARATOR       VARCHAR(5) ,
    LANDMARK_NAME                VARCHAR(50) ,
    NOT_ADDRESS                  VARCHAR(30) ,
    OCCUPANCY_TYPE               VARCHAR(20) ,
    OCCUPANCY_IDENTIFIER         VARCHAR(20) ,
    PLACE_NAME                   VARCHAR(50) ,
    STATE_NAME                   VARCHAR(15) ,
    STREET_NAME                  VARCHAR(50) ,
    STREET_NAME_PRE_DIRECTIONAL  VARCHAR(10) ,
    STREET_NAME_PRE_MODIFIER     VARCHAR(10) ,
    STREET_NAME_PRE_TYPE         VARCHAR(10) ,
    STREET_NAME_POST_DIRECTIONAL VARCHAR(10) ,
    STREET_NAME_POST_MODIFIER    VARCHAR(10) ,
    STREET_NAME_POST_TYPE        VARCHAR(10) ,
    SUBADDRESS_IDENTIFIER        VARCHAR(10) ,
    SUBADDRESS_TYPE              VARCHAR(10) ,
    USPS_BOX_GROUP_ID            VARCHAR(10) ,
    USPS_BOX_GROUP_TYPE          VARCHAR(2) ,
    USPS_BOX_ID                  VARCHAR(10) ,
    USPS_BOX_TYPE                VARCHAR(10) ,
    ZIP_CODE                     VARCHAR(10),
    HASHCODE		   BIGINT NOT NULL
 ) ;
DROP INDEX IF EXISTS HOUSEHOLD_ZIP_IDX;
CREATE INDEX HOUSEHOLD_ZIP_IDX on HOUSEHOLD_DIM(ZIP_CODE);

DROP INDEX IF EXISTS HOUSEHOLD_HASH_IDX;
CREATE INDEX HOUSEHOLD_HASH_IDX on HOUSEHOLD_DIM(HASHCODE);

  
DROP TABLE IF EXISTS MAILING_ADDRESS_DIM CASCADE;
CREATE TABLE MAILING_ADDRESS_DIM
(
	MAILING_ADDRESS_ID 	SERIAL NOT NULL PRIMARY KEY
,	ADDRESS_LINE1	VARCHAR(110)
,	ADDRESS_LINE2	VARCHAR(50)
,	CITY		VARCHAR(50)
,	"STATE"		VARCHAR(20)
,	ZIP_CODE		VARCHAR(10)
,	COUNTRY   	VARCHAR(30)  
,	HASHCODE		BIGINT NOT NULL 
);
DROP INDEX IF EXISTS MAILING_ADDR_ZIP_IDX;
CREATE INDEX MAILING_ADDR_ZIP_IDX on MAILING_ADDRESS_DIM(ZIP_CODE);
DROP INDEX IF EXISTS MAILING_HASH_IDX;
CREATE INDEX MAILING_HASH_IDX on MAILING_ADDRESS_DIM(HASHCODE);


DROP TABLE IF EXISTS PRECINCT_DIM CASCADE;
CREATE TABLE PRECINCT_DIM(
  PRECINCT_ID SERIAL NOT NULL PRIMARY KEY
, COUNTY_CODE VARCHAR(5)
, COUNTY_NAME VARCHAR(50)  NULL
, DISTRICT_ID BIGINT  NULL
, DISTRICT_CODE VARCHAR(15)
, PRECINCT_CODE BIGINT
, PRECINCT_NAME VARCHAR(50)
, COUNTY_DISTRICT_NAME VARCHAR(100)
, EMS_DISTRICT_NAME VARCHAR(100)
, FIRE_DISTRICT_NAME VARCHAR(100)
, JUDICIAL_DISTRICT_NAME VARCHAR(100)
, LEGISLATIVE_DISTRICT_NAME VARCHAR(100)
, LIBRARY_DISTRICT_NAME VARCHAR(100)
, OTHER_DISTRICT_NAME VARCHAR(100)
, PCO_DISTRICT_NAME VARCHAR(100)
, PARK_AND_REC_DISTRICT_NAME VARCHAR(100)
, PORT_DISTRICT_NAME VARCHAR(100)
, PUBLIC_HOSPITAL_DISTRICT_NAME VARCHAR(100)
, PUBLIC_UTILITY_DISTRICT_NAME VARCHAR(100)
, SCHOOL_DISTRICT_NAME VARCHAR(100)
, SEWER_DISTRICT_NAME VARCHAR(100)
, STATE_DISTRICT_NAME VARCHAR(100)
, TAX_DISTRICT_NAME VARCHAR(100)
, TRANSPORTATION_DISTRICT_NAME VARCHAR(100)
, WATER_DISTRICT_NAME VARCHAR(100)
, STATE_ABBREVIATION CHAR(2)  NULL
, STATE_NAME CHAR(50)  NULL
, OCD_NAME VARCHAR(100)
, OCD_ID VARCHAR(100)
, VERSION		INTEGER NOT NULL DEFAULT(0)
, VALID_FROM		DATE NOT NULL DEFAULT('1900-01-01')
, VALID_TO		DATE NOT NULL DEFAULT('2199-12-31')

)
;






DROP TABLE IF EXISTS STAFFER_DIM;
CREATE TABLE STAFFER_DIM
  (
    STAFFER_ID INTEGER NOT NULL PRIMARY KEY,
    FIRST_NAME VARCHAR(45) ,
    LAST_NAME  VARCHAR(45) ,
    USERNAME   VARCHAR(25)
  );


DROP TABLE IF EXISTS VOTER_REPORT_FACT;
CREATE TABLE VOTER_REPORT_FACT
  (
    VOTER_REPORT_ID       	SERIAL NOT NULL PRIMARY KEY , 
    VOTER_REPORT_DATE     	DATE NOT NULL,
    DATE_KEY		INTEGER NOT NULL REFERENCES DATE_DIM(DATE_ID),

    REPORT_STATUS         	VARCHAR(45) ,
    REPORTER_KEY          	INTEGER NOT NULL REFERENCES REPORTER_DIM(REPORTER_ID),
    VOTER_KEY	      	INTEGER NOT NULL REFERENCES VOTER_DIM(VOTER_ID),
    HOUSEHOLD_KEY	      	INTEGER NOT NULL REFERENCES HOUSEHOLD_DIM(HOUSEHOLD_ID) ,
    MAILING_ADDRESS_KEY	INTEGER NULL REFERENCES MAILING_ADDRESS_DIM(MAILING_ADDRESS_ID),    
    SOCIAL_MEDIA_ACCOUNT_KEY 	INTEGER NULL ,
    PRECINCT_KEY INTEGER NULL REFERENCES PRECINCT_DIM(PRECINCT_ID),
    COUNTY_KEY  		INTEGER NULL ,	
    WARD_KEY	      	INTEGER NULL ,
    CONGRESSIONAL_DISTRICT_KEY INTEGER NULL ,
    COUNTY_DISTRICT_KEY	INTEGER NULL ,
    STATE_KEY                 INTEGER NULL ,
    STATE_HOUSE_DISTRICT_KEY	INTEGER NULL ,
    SENATE_DISTRICT_KEY	INTEGER NULL ,
    STAFFER_KEY	          INTEGER NULL ,
    CAMPAIGN_KEY		INTEGER NULL
  ) ;

  
 CREATE TABLE ELECTION_DIM
(
    ELECTION_ID SERIAL NOT NULL PRIMARY KEY
 ,  "STATE" CHAR(2)
,   ELECTION_DATE DATE
,   ELECTION_TYPE VARCHAR(10)
)
;


CREATE TABLE VOTE_FACT
  (
    VOTE_FACT_ID       	SERIAL NOT NULL PRIMARY KEY , 
    VOTER_KEY	      	INTEGER NOT NULL REFERENCES VOTER_DIM(VOTER_ID),
    HOUSEHOLD_KEY	      	INTEGER NOT NULL REFERENCES HOUSEHOLD_DIM(HOUSEHOLD_ID) ,
    PRECINCT_KEY INTEGER NULL REFERENCES PRECINCT_DIM(PRECINCT_ID),
    ELECTION_KEY INTEGER NOT NULL REFERENCES ELECTION_DIM(ELECTION_ID)
  ) ;


DROP TABLE IF EXISTS STAFFER_DIM;
CREATE TABLE STAFFER_DIM
  (
    STAFFER_ID INTEGER NOT NULL PRIMARY KEY,
    FIRST_NAME VARCHAR(45) ,
    LAST_NAME  VARCHAR(45) ,
    USERNAME   VARCHAR(25)
  );
