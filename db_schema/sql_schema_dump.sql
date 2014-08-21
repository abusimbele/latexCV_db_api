CREATE SCHEMA application;

CREATE TABLE application.`Address` ( 
	address_id           int UNSIGNED NOT NULL  AUTO_INCREMENT,
	street_name          varchar(90)  NOT NULL  ,
	street_number        varchar(10)  NOT NULL  ,
	zipcode              varchar(30)  NOT NULL  ,
	city_name            varchar(90)  NOT NULL  ,
	country_name         varchar(60)  NOT NULL  ,
	country_code         varchar(3)  NOT NULL  ,
	CONSTRAINT pk_address PRIMARY KEY ( address_id )
 );

CREATE INDEX fk_Address_1_idx ON application.`Address` ( address_id, street_name, street_number, zipcode, city_name, country_name, country_code );

CREATE TABLE application.`Grades` ( 
	grades_id            int UNSIGNED NOT NULL  AUTO_INCREMENT,
	grade_value          tinyint UNSIGNED NOT NULL  ,
	description          varchar(45)    ,
	CONSTRAINT pk_grades PRIMARY KEY ( grades_id )
 );

CREATE TABLE application.`Skills` ( 
	skills_id            int UNSIGNED NOT NULL  AUTO_INCREMENT,
	name                 varchar(40)  NOT NULL  ,
	description          varchar(200)  NOT NULL  ,
	CONSTRAINT pk_skills PRIMARY KEY ( skills_id )
 );

CREATE TABLE application.`Tasks` ( 
	tasks_id             int UNSIGNED NOT NULL  AUTO_INCREMENT,
	task_name            varchar(45)    ,
	CONSTRAINT pk_tasks PRIMARY KEY ( tasks_id )
 );

CREATE TABLE application.email_addresses ( 
	email_id             int UNSIGNED NOT NULL  AUTO_INCREMENT,
	email_address        varchar(40)  NOT NULL  ,
	CONSTRAINT idx_email_addresses PRIMARY KEY ( email_id ),
	CONSTRAINT pk_email_addresses PRIMARY KEY ( email_id ),
	CONSTRAINT idx_email_address UNIQUE ( email_address ) 
 ) engine=InnoDB;

CREATE TABLE application.gender ( 
	gender_id            char(1)  NOT NULL  ,
	name                 varchar(13)  NOT NULL  ,
	CONSTRAINT pk_gender PRIMARY KEY ( gender_id )
 ) engine=InnoDB;

CREATE TABLE application.graduation ( 
	graduation_id        int UNSIGNED NOT NULL  AUTO_INCREMENT,
	name                 varchar(40)  NOT NULL  ,
	description          varchar(200)  NOT NULL  ,
	CONSTRAINT pk_graduation PRIMARY KEY ( graduation_id )
 ) engine=InnoDB;

CREATE TABLE application.institution_type ( 
	institution_type_id  int UNSIGNED NOT NULL  AUTO_INCREMENT,
	name                 varchar(50)    ,
	description          varchar(200)  NOT NULL  ,
	CONSTRAINT pk_institution_type PRIMARY KEY ( institution_type_id )
 ) engine=InnoDB;

CREATE TABLE application.sectors ( 
	sector_id            int UNSIGNED NOT NULL  AUTO_INCREMENT,
	name                 varchar(100)    ,
	description          varchar(200)    ,
	CONSTRAINT pk_sectors PRIMARY KEY ( sector_id )
 ) engine=InnoDB;

CREATE TABLE application.social_platforms ( 
	social_platforms_id  int UNSIGNED NOT NULL  AUTO_INCREMENT,
	name                 varchar(40)  NOT NULL  ,
	platform_type        varchar(40)  NOT NULL  ,
	CONSTRAINT pk_social_plattforms PRIMARY KEY ( social_platforms_id )
 ) engine=InnoDB;

CREATE TABLE application.`Users` ( 
	user_id              int UNSIGNED NOT NULL  AUTO_INCREMENT,
	forename             varchar(40)  NOT NULL  ,
	surname              varchar(40)  NOT NULL  ,
	birthdate            date  NOT NULL  ,
	gender               char(1)  NOT NULL  ,
	CONSTRAINT pk_users PRIMARY KEY ( user_id )
 );

CREATE INDEX idx_users ON application.`Users` ( gender );

CREATE TABLE application.email_address_user_intermediate ( 
	email                int UNSIGNED NOT NULL  ,
	user                 int UNSIGNED NOT NULL  ,
	CONSTRAINT idx_email_address_user_intermediate_0 PRIMARY KEY ( email ),
	CONSTRAINT pk_email_address_user_intermediate PRIMARY KEY ( email )
 ) engine=InnoDB;

CREATE INDEX idx_email_address_user_intermediate ON application.email_address_user_intermediate ( user );

CREATE TABLE application.instituition ( 
	institution_id       int UNSIGNED NOT NULL  AUTO_INCREMENT,
	name                 varchar(60)    ,
	institution_type     int UNSIGNED   ,
	graduation           int UNSIGNED NOT NULL  ,
	address              int UNSIGNED NOT NULL  ,
	CONSTRAINT pk_instituition PRIMARY KEY ( institution_id )
 ) engine=InnoDB;

CREATE INDEX idx_instituition ON application.instituition ( institution_type );

CREATE INDEX idx_instituition_0 ON application.instituition ( graduation );

CREATE INDEX idx_instituition_1 ON application.instituition ( address );

CREATE TABLE application.organizations ( 
	organization_id      int UNSIGNED NOT NULL  AUTO_INCREMENT,
	name                 varchar(100)    ,
	sector               int UNSIGNED NOT NULL  ,
	CONSTRAINT pk_organizations PRIMARY KEY ( organization_id )
 ) engine=InnoDB;

CREATE INDEX idx_organizations ON application.organizations ( sector );

CREATE TABLE application.user_address_intermediate ( 
	user_address_intermediate_id int UNSIGNED NOT NULL  AUTO_INCREMENT,
	addresses            int UNSIGNED NOT NULL  ,
	users                int UNSIGNED NOT NULL  ,
	CONSTRAINT pk_user_address_intermediate PRIMARY KEY ( user_address_intermediate_id ),
	CONSTRAINT idx_user_address_intermediate UNIQUE ( addresses ) ,
	CONSTRAINT idx_user_address_intermediate_0 UNIQUE ( users ) 
 ) engine=InnoDB;

CREATE TABLE application.user_social_platforms_intermediate ( 
	user_social_platforms_intermediate_id int UNSIGNED NOT NULL  AUTO_INCREMENT,
	user                 int UNSIGNED NOT NULL  ,
	social_platform      int UNSIGNED NOT NULL  ,
	CONSTRAINT pk_user_social_platforms_intermediate PRIMARY KEY ( user_social_platforms_intermediate_id )
 ) engine=InnoDB;

CREATE INDEX idx_user_social_platforms_intermediate ON application.user_social_platforms_intermediate ( user );

CREATE INDEX idx_user_social_platforms_intermediate_0 ON application.user_social_platforms_intermediate ( social_platform );

CREATE TABLE application.users_skills_intermediate ( 
	id                   int UNSIGNED NOT NULL  AUTO_INCREMENT,
	users                int UNSIGNED NOT NULL  ,
	skills               int UNSIGNED NOT NULL  ,
	grade                int UNSIGNED NOT NULL  ,
	CONSTRAINT pk_users_skills_intermediate PRIMARY KEY ( id )
 ) engine=InnoDB;

CREATE INDEX idx_users_skills_intermediate ON application.users_skills_intermediate ( users );

CREATE INDEX idx_users_skills_intermediate_0 ON application.users_skills_intermediate ( skills );

CREATE INDEX idx_users_skills_intermediate_1 ON application.users_skills_intermediate ( grade );

CREATE TABLE application.`Professional_experience` ( 
	professional_experience_id int  NOT NULL  ,
	from                 date    ,
	to                   date    ,
	position             varchar(45)    ,
	users                int UNSIGNED NOT NULL  ,
	organization         int UNSIGNED NOT NULL  ,
	CONSTRAINT pk_professional_experience PRIMARY KEY ( professional_experience_id )
 );

CREATE INDEX idx_professional_experience ON application.`Professional_experience` ( users );

CREATE INDEX idx_professional_experience_0 ON application.`Professional_experience` ( organization );

CREATE TABLE application.education ( 
	education_id         int UNSIGNED NOT NULL  AUTO_INCREMENT,
	begin_date           date  NOT NULL  ,
	end_date             date  NOT NULL  ,
	educational_institution int UNSIGNED NOT NULL  ,
	degree               float(3,2) UNSIGNED   ,
	user                 int UNSIGNED NOT NULL  ,
	subject_area         varchar(40)    ,
	CONSTRAINT pk_education PRIMARY KEY ( education_id )
 ) engine=InnoDB;

CREATE INDEX idx_education ON application.education ( user );

CREATE INDEX idx_education_0 ON application.education ( educational_institution );

ALTER TABLE application.education MODIFY degree float(3,2) UNSIGNED    COMMENT 'ToDo: realtion to other table?';

CREATE TABLE application.professional_experience_tasks_intermediate ( 
	professional_experience_tasks_intermediate_id int UNSIGNED NOT NULL  AUTO_INCREMENT,
	task                 int UNSIGNED NOT NULL  ,
	professional_experience int  NOT NULL  ,
	CONSTRAINT pk_professional_experience_tasks_intermediate PRIMARY KEY ( professional_experience_tasks_intermediate_id )
 ) engine=InnoDB;

CREATE INDEX idx_professional_experience_tasks_intermediate ON application.professional_experience_tasks_intermediate ( task );

CREATE INDEX idx_professional_experience_tasks_intermediate_0 ON application.professional_experience_tasks_intermediate ( professional_experience );

ALTER TABLE application.`Professional_experience` ADD CONSTRAINT fk_professional_experience FOREIGN KEY ( users ) REFERENCES application.`Users`( user_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.`Professional_experience` ADD CONSTRAINT fk_professional_experience_0 FOREIGN KEY ( organization ) REFERENCES application.organizations( organization_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.`Users` ADD CONSTRAINT fk_users FOREIGN KEY ( gender ) REFERENCES application.gender( gender_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.education ADD CONSTRAINT fk_education FOREIGN KEY ( user ) REFERENCES application.`Users`( user_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.education ADD CONSTRAINT fk_education_0 FOREIGN KEY ( educational_institution ) REFERENCES application.instituition( institution_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.email_address_user_intermediate ADD CONSTRAINT fk_email_address_user_intermediate FOREIGN KEY ( user ) REFERENCES application.`Users`( user_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.email_address_user_intermediate ADD CONSTRAINT fk_email_address_user_intermediate_0 FOREIGN KEY ( email ) REFERENCES application.email_addresses( email_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.instituition ADD CONSTRAINT fk_instituition FOREIGN KEY ( institution_type ) REFERENCES application.institution_type( institution_type_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.instituition ADD CONSTRAINT fk_instituition_0 FOREIGN KEY ( graduation ) REFERENCES application.graduation( graduation_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.instituition ADD CONSTRAINT fk_instituition_1 FOREIGN KEY ( address ) REFERENCES application.`Address`( address_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.organizations ADD CONSTRAINT fk_organizations FOREIGN KEY ( sector ) REFERENCES application.sectors( sector_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.professional_experience_tasks_intermediate ADD CONSTRAINT fk_professional_experience_tasks_intermediate_0 FOREIGN KEY ( professional_experience ) REFERENCES application.`Professional_experience`( professional_experience_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.professional_experience_tasks_intermediate ADD CONSTRAINT fk_professional_experience_tasks_intermediate FOREIGN KEY ( task ) REFERENCES application.`Tasks`( tasks_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.user_address_intermediate ADD CONSTRAINT fk_user_address_intermediate FOREIGN KEY ( addresses ) REFERENCES application.`Address`( address_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.user_address_intermediate ADD CONSTRAINT fk_user_address_intermediate_0 FOREIGN KEY ( users ) REFERENCES application.`Users`( user_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.user_social_platforms_intermediate ADD CONSTRAINT fk_user_social_platforms_intermediate FOREIGN KEY ( user ) REFERENCES application.`Users`( user_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.user_social_platforms_intermediate ADD CONSTRAINT fk_user_social_platforms_intermediate_0 FOREIGN KEY ( social_platform ) REFERENCES application.social_platforms( social_platforms_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.users_skills_intermediate ADD CONSTRAINT fk_users_skills_intermediate FOREIGN KEY ( users ) REFERENCES application.`Users`( user_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.users_skills_intermediate ADD CONSTRAINT fk_users_skills_intermediate_0 FOREIGN KEY ( skills ) REFERENCES application.`Skills`( skills_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE application.users_skills_intermediate ADD CONSTRAINT fk_users_skills_intermediate_1 FOREIGN KEY ( grade ) REFERENCES application.`Grades`( grades_id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

