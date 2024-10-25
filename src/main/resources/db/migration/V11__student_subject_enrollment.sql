CREATE TABLE lesson.student_subject_enrollment (
    subject_id UUID NOT NULL,
    classroom_id UUID NOT NULL,
    student_id VARCHAR(100) NOT NULL,
    -- FOREIGN KEY (subject_id) REFERENCES lesson.lesson(subject_id),
    -- FOREIGN KEY (classroom_id) REFERENCES lesson.lesson(classroom_id),
    FOREIGN KEY (subject_id, classroom_id) REFERENCES lesson.lesson(subject_id, classroom_id),
    FOREIGN KEY (student_id) REFERENCES lesson.student(student_id),
    PRIMARY KEY (subject_id, classroom_id, student_id)
)