CREATE TABLE lesson.student (
    student_id VARCHAR(8) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    course_id UUID NOT NULL,
    FOREIGN KEY (course_id) REFERENCES lesson.course(course_id) 
)