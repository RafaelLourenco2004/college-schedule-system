CREATE TABLE lesson.course (
    course_id UUID PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    total_credits INT NOT NULL
)