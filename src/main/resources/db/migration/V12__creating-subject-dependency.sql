CREATE TABLE lesson.subject_dependency (
    subject_id UUID NOT NULL,
    required_subject_id UUID NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES lesson.subject(subject_id),
    FOREIGN KEY (required_subject_id) REFERENCES lesson.subject(subject_id),
    PRIMARY KEY (subject_id, required_subject_id)
)