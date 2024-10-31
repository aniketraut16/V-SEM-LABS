create database B22_Lab5;
use B22_Lab5;
create table students (
    student_id int primary key,
    name varchar(20),
    date_of_birth date ,
    email varchar(50) unique check (email like '%_@_%._%')
);

delimiter $$

create trigger check_dob_before_insert
before insert on students
for each row
begin
    if new.date_of_birth > current_date then
        signal sqlstate '45000'
        set message_text = 'Date of birth cannot be in the future.';
    end if;
end$$

delimiter ;

create table courses (
    course_id int  primary key,
    course_name varchar(20),
    credits numeric(2,1) check (credits between 1 and 5)
);

create table enrollment (
    enrollment_id int unique primary key,
    student_id int,
    course_id int,
    grade varchar(1) check (grade in ('A', 'B', 'C', 'D', 'F')),
    foreign key (student_id) references students(student_id) on delete cascade,
    foreign key (course_id) references courses(course_id)
);

-- Violates the uniqueness of `student_id` (primary key constraint)
INSERT INTO students (student_id, name, date_of_birth, email)
VALUES (1, 'Duplicate ID', '2002-10-10', 'duplicate@example.com');

-- Violates email format (should fail because of the `CHECK` constraint)
INSERT INTO students (student_id, name, date_of_birth, email)
VALUES (4, 'Invalid Email Format', '2001-11-11', 'invalid-email-format');

-- Violates the date_of_birth trigger (DOB in the future)
INSERT INTO students (student_id, name, date_of_birth, email)
VALUES (5, 'Future DOB', '2025-01-01', 'futuredob@example.com');

-- Violates email uniqueness constraint
INSERT INTO students (student_id, name, date_of_birth, email)
VALUES (6, 'Duplicate Email', '2001-02-02', 'johndoe@example.com');

-- Violates the uniqueness of `course_id` (primary key constraint)
INSERT INTO courses (course_id, course_name, credits)
VALUES (101, 'Duplicate Course ID', 3.0);

-- Violates `credits` range check (credits should be between 1 and 5)
INSERT INTO courses (course_id, course_name, credits)
VALUES (104, 'Invalid Credits', 6.0);

-- Violates `credits` range check with a negative value
INSERT INTO courses (course_id, course_name, credits)
VALUES (105, 'Negative Credits', -2.0);

-- Violates the uniqueness of `enrollment_id` (primary key constraint)
INSERT INTO enrollment (enrollment_id, student_id, course_id, grade)
VALUES (1001, 2, 102, 'A');

-- Violates foreign key constraint (non-existent `student_id`)
INSERT INTO enrollment (enrollment_id, student_id, course_id, grade)
VALUES (1005, 999, 101, 'A');

-- Violates foreign key constraint (non-existent `course_id`)
INSERT INTO enrollment (enrollment_id, student_id, course_id, grade)
VALUES (1006, 1, 999, 'B');

-- Violates `grade` constraint (invalid grade value)
INSERT INTO enrollment (enrollment_id, student_id, course_id, grade)
VALUES (1007, 1, 101, 'Z');

