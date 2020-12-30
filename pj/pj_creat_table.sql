DROP TABLE IF EXISTS gymnast CASCADE;
DROP TABLE IF EXISTS staff CASCADE;
DROP TABLE IF EXISTS competitive_team CASCADE;
DROP TABLE IF EXISTS gymnastics_meet CASCADE;
DROP TABLE IF EXISTS private_lesson CASCADE;
DROP TABLE IF EXISTS gymnast_team_record CASCADE;
DROP TABLE IF EXISTS gymnast_meet_record CASCADE;
DROP TABLE IF EXISTS monthly_bill CASCADE;


CREATE TABLE gymnast (
gymnast_no NUMERIC(6) NOT NULL,
gymnast_name char(30) NOT NULL,
gymnast_age NUMERIC(2) ,
gymnast_gender char(1) CHECK (gymnast_gender='m' OR gymnast_gender='f'),
gymnast_ph_no NUMERIC(8) NOT NULL,
PRIMARY KEY (gymnast_no)
);

CREATE TABLE staff (
staff_id  NUMERIC(6) NOT NULL,
staff_name char(30) NOT NULL,
staff_age NUMERIC(2) ,
staff_gender char(1) CHECK (Staff_gender='m' OR Staff_gender='f'),
staff_ph_no NUMERIC(8) NOT NULL,
staff_salary NUMERIC(6),
staff_position char(30),
PRIMARY KEY (Staff_id)
);

CREATE TABLE competitive_team (
team_level NUMERIC(2) NOT NULL CHECK (team_level BETWEEN 1 AND 10),
min_age_req NUMERIC(2) NOT NULL,
monthly_fee NUMERIC(6) ,
staff_id  NUMERIC(6) ,
PRIMARY KEY (team_level),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE SET NULL
);

CREATE TABLE gymnastics_meet (
meet_id NUMERIC(9) NOT NULL,
meet_date  DATE NOT NULL,
meet_start_time TIME ,
meet_location  char(30) ,
meet_fee NUMERIC(3),
PRIMARY KEY (meet_id)
);

CREATE TABLE private_lesson (
staff_id  NUMERIC(6) NOT NULL,
gymnast_no NUMERIC(6) NOT NULL,
lesson_date DATE NOT NULL,
lesson_start_time TIME NOT NULL,
lesson_duration NUMERIC(1),
PRIMARY KEY (staff_id, gymnast_no, lesson_date, lesson_start_time),
FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE,
FOREIGN KEY (gymnast_no) REFERENCES gymnast(gymnast_no)	ON DELETE CASCADE
);

CREATE TABLE gymnast_team_record (
gymnast_no NUMERIC(6) NOT NULL,
team_level NUMERIC(2) NOT NULL CHECK (team_level BETWEEN 1 AND 10),
joining_date DATE,	
leaving_date DATE,
PRIMARY KEY (gymnast_no, team_level),
FOREIGN KEY (team_level) REFERENCES competitive_team(team_level) ON DELETE CASCADE,
FOREIGN KEY (gymnast_no) REFERENCES gymnast(gymnast_no)	ON DELETE CASCADE
);

CREATE TABLE gymnast_meet_record (
meet_id NUMERIC(9) NOT NULL,
gymnast_no NUMERIC(6) NOT NULL,
gymnast_scores NUMERIC(2) NOT NULL CHECK (gymnast_scores BETWEEN 0 AND 50),
PRIMARY KEY (meet_id,gymnast_no),
FOREIGN KEY (meet_id) REFERENCES gymnastics_meet(meet_id) ON DELETE CASCADE,
FOREIGN KEY (gymnast_no) REFERENCES gymnast(gymnast_no)	ON DELETE CASCADE
);

CREATE TABLE monthly_bill (
bill_id NUMERIC(9) NOT NULL,
gymnast_no NUMERIC(6) NOT NULL,
issue_date DATE,
due_date DATE,	
PRIMARY KEY (bill_id),
FOREIGN KEY (gymnast_no) REFERENCES gymnast(gymnast_no) ON DELETE CASCADE	
);


