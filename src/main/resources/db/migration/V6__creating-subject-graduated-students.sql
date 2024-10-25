CREATE TABLE lesson.subject_graduated_students (
    subject_id UUID NOT NULL,
    student_id VARCHAR(100) NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES lesson.subject(subject_id),
    FOREIGN KEY (student_id) REFERENCES lesson.student(student_id),
    PRIMARY KEY (subject_id, student_id)
)