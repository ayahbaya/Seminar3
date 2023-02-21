CREATE TABLE email (
 email_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 email VARCHAR(200) NOT NULL
);

ALTER TABLE email ADD CONSTRAINT PK_email PRIMARY KEY (email_id);


CREATE TABLE instrument (
 instrument_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 type CHAR(100) NOT NULL,
 price INT NOT NULL,
 brand CHAR(100) NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instrument_id);


CREATE TABLE person (
 person_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 personal_number     VARCHAR(12) DEFAULT 'UNIQUE' NOT NULL,
  first_name  VARCHAR(100) NOT NULL,
 last_name VARCHAR(200),
  adress  VARCHAR(200) NOT NULL
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);


CREATE TABLE person_email (
 person_id INT NOT NULL,
 email_id INT NOT NULL
);

ALTER TABLE person_email ADD CONSTRAINT PK_person_email PRIMARY KEY (person_id,email_id);


CREATE TABLE student (
 student_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_id INT NOT NULL,
 skill_level CHAR(100)
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE instructor (
 instructor_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);


CREATE TABLE instructor_instruments (
 instructor_id INT NOT NULL,
 instrument_id INT NOT NULL
);

ALTER TABLE instructor_instruments ADD CONSTRAINT PK_instructor_instruments PRIMARY KEY (instructor_id,instrument_id);


CREATE TABLE parent (
 person_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE parent ADD CONSTRAINT PK_parent PRIMARY KEY (person_id,student_id);


CREATE TABLE rent_instrument (
 rent_instrument_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 student_id INT NOT NULL,
 instrument_id INT NOT NULL,
 start_date TIMESTAMP(6) NOT NULL,
 end_date TIMESTAMP(6) NOT NULL
);

ALTER TABLE rent_instrument ADD CONSTRAINT PK_rent_instrument PRIMARY KEY (rent_instrument_id);


CREATE TABLE sibling (
 person_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE sibling ADD CONSTRAINT PK_sibling PRIMARY KEY (person_id,student_id);


CREATE TABLE ensemble_lesson (
 ensemble_lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instructor_id INT NOT NULL,
 genre  VARCHAR(50) NOT NULL,
 min_students INT NOT NULL,
 max_students  INT NOT NULL,
 date_time TIMESTAMP(6) NOT NULL
);

ALTER TABLE ensemble_lesson ADD CONSTRAINT PK_ensemble_lesson PRIMARY KEY (ensemble_lesson_id);


CREATE TABLE ensemble_students (
 ensemble_lesson_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE ensemble_students ADD CONSTRAINT PK_ensemble_students PRIMARY KEY (ensemble_lesson_id,student_id);


CREATE TABLE group_lesson (
 group_lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instrument_id INT NOT NULL,
 instructor_id INT NOT NULL,
 min_places INT NOT NULL,
 max_places INT NOT NULL,
 date_time TIMESTAMP(6) NOT NULL,
 skill_level CHAR(100)
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (group_lesson_id);


CREATE TABLE group_students (
 group_lesson_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE group_students ADD CONSTRAINT PK_group_students PRIMARY KEY (group_lesson_id,student_id);


CREATE TABLE individual_lesson (
 individua_lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 instructor_id INT NOT NULL,
 student_id INT NOT NULL,
 instrument_id INT NOT NULL,
 price VARCHAR(100) NOT NULL,
 date_time TIMESTAMP(6) NOT NULL,
 skill_level CHAR(100)
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (individua_lesson_id);


ALTER TABLE person_email ADD CONSTRAINT FK_person_email_0 FOREIGN KEY (person_id) REFERENCES email (email_id);
ALTER TABLE person_email ADD CONSTRAINT FK_person_email_1 FOREIGN KEY (email_id) REFERENCES person (person_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE instructor_instruments ADD CONSTRAINT FK_instructor_instruments_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE instructor_instruments ADD CONSTRAINT FK_instructor_instruments_1 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);


ALTER TABLE parent ADD CONSTRAINT FK_parent_0 FOREIGN KEY (person_id) REFERENCES person (person_id);
ALTER TABLE parent ADD CONSTRAINT FK_parent_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE rent_instrument ADD CONSTRAINT FK_rent_instrument_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE rent_instrument ADD CONSTRAINT FK_rent_instrument_1 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);


ALTER TABLE sibling ADD CONSTRAINT FK_sibling_0 FOREIGN KEY (person_id) REFERENCES person (person_id);
ALTER TABLE sibling ADD CONSTRAINT FK_sibling_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE ensemble_lesson ADD CONSTRAINT FK_ensemble_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE ensemble_students ADD CONSTRAINT FK_ensemble_students_0 FOREIGN KEY (ensemble_lesson_id) REFERENCES ensemble_lesson (ensemble_lesson_id);
ALTER TABLE ensemble_students ADD CONSTRAINT FK_ensemble_students_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_1 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE group_students ADD CONSTRAINT FK_group_students_0 FOREIGN KEY (group_lesson_id) REFERENCES group_lesson (group_lesson_id);
ALTER TABLE group_students ADD CONSTRAINT FK_group_students_1 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_2 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
