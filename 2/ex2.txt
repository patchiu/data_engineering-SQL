
/* Q1 */

DROP TABLE IF EXISTS VisitDrug;
DROP TABLE IF EXISTS Drug;
DROP TABLE IF EXISTS Visit;
DROP TABLE IF EXISTS Patient;


CREATE TABLE Patient(
	PatientNo  NUMERIC(3)  PRIMARY KEY,
	PatientName  VARCHAR(50)  NOT NULL,
	PatientAddress VARCHAR(100),
	PatientPhone NUMERIC(8) NOT NULL, 
	HKID  VARCHAR(8) UNIQUE,
	OtherDocumentNo VARCHAR(50)
);


CREATE TABLE Visit(
	VisitNo  NUMERIC(8) PRIMARY KEY,
	VisitDate  DATE  NOT NULL,
	ConsultationFee NUMERIC(3),
	PatientNo NUMERIC(3),

	FOREIGN KEY (PatientNo) REFERENCES Patient(PatientNo)
	ON DELETE RESTRICT
);

CREATE TABLE Drug(
	DrugCode  NUMERIC(3) PRIMARY KEY,
	DrugName  VARCHAR(50) ,
	StovkLevel NUMERIC(5)
);

CREATE TABLE VisitDrug(
	VisitNo  NUMERIC(8) ,
	DrugCode  NUMERIC(3)  NOT NULL,
	PrescribedQuantity NUMERIC(3),

	PRIMARY KEY (VisitNo, DrugCode),


	FOREIGN KEY (VisitNo) REFERENCES Visit(VisitNo)
	ON DELETE CASCADE,

	FOREIGN KEY (DrugCode) REFERENCES Drug(DrugCode)
	ON DELETE RESTRICT

);

/* Q2 */
INSERT INTO Patient VALUES (101,'Chan Tai Man','88 Oxford Road',27893389,'A1234567',NULL);
INSERT INTO Patient VALUES (102,'Wong Lee Ho','50 Super Ave',91934567,NULL,'BP10030001');
INSERT INTO Patient VALUES (103,'Ho Ho Tor','88 Oxford Road',27893389,'C1357246',NULL);


INSERT INTO Visit VALUES (20090301,'2020-09-03',500,101);
INSERT INTO Visit VALUES (20090502,'2020-09-05',400,101);
INSERT INTO Visit VALUES (20102001,'2020-10-20',300,102);
INSERT INTO Visit VALUES (20102002,'2020-10-20',300,103);
INSERT INTO Visit VALUES (20102505,'2020-10-25',200,103);


INSERT INTO Drug VALUES (901,'Panadol',1000);
INSERT INTO Drug VALUES (902,'Vitamin C',500);
INSERT INTO Drug VALUES (903,'LingZhi Pill',50);


INSERT INTO VisitDrug VALUES(20090301,901,20);
INSERT INTO VisitDrug VALUES(20090502,901,15);
INSERT INTO VisitDrug VALUES(20090502,902,50);
INSERT INTO VisitDrug VALUES(20102002,902,50);
INSERT INTO VisitDrug VALUES(20102505,901,20);


SELECT * FROM Patient ;
SELECT * FROM Visit ;
SELECT * FROM Drug ;
SELECT * FROM VisitDrug ;




/* Q3 */

/* a */
INSERT INTO Drug VALUES (903,'xxxxx',99);
/*duplicate key value violates unique constraint "drug_pkey"*/
/*Key (drugcode)=(903) already exists.*/

/* b */
INSERT INTO Visit VALUES (20090302,'2020-09-03',500,104);
/*insert or update on table "visit" violates foreign key constraint "visit_patientno_fkey" */
/*Key (patientno)=(104) is not present in table "patient".*/

/* c */
DELETE FROM Drug WHERE DrugCode = 901;
/*ERROR:  update or delete on table "drug" violates foreign key constraint "visitdrug_drugcode_fkey" on table "visitdrug"*/
/*DETAIL:  Key (drugcode)=(901) is still referenced from table "visitdrug".*/



/* d */
DELETE FROM Drug WHERE DrugCode = 903;

/* e */
DELETE FROM visit WHERE VisitNo = '20090502';


