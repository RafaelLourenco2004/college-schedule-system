CREATE TABLE lesson.subject (
    subject_id UUID NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    credit INT NOT NULL,
    semester lesson.semester NOT NULL,
    course_id UUID NOT NULL,
    FOREIGN KEY (course_id) REFERENCES lesson.course(course_id)
    
)