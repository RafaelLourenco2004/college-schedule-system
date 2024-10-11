CREATE TABLE lesson.classroom (
    classroom_id UUID PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    capacity INT NOT NULL,
    semester lesson.semester NOT NULL
)