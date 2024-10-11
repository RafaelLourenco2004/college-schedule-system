CREATE TABLE lesson.lesson (
    subject_id UUID NOT NULL,
    classroom_id UUID NOT NULL,
    lesson_date_id UUID NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES lesson.subject(subject_id),
    FOREIGN KEY (classroom_id) REFERENCES lesson.classroom(classroom_id),
    FOREIGN KEY (lesson_date_id) REFERENCES lesson.lesson_date(lesson_date_id),
    PRIMARY KEY (subject_id, classroom_id, lesson_date_id)
)