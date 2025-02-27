CREATE TABLE lesson.lesson_date (
    lesson_date_id UUID NOT NULL PRIMARY KEY,
    subject_id UUID NOT NULL,
    classroom_id UUID NOT NULL,
    week_day lesson.week_day NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    FOREIGN KEY (subject_id, classroom_id) REFERENCES lesson.lesson(subject_id, classroom_id)
)
-- CREATE TABLE lesson.lesson_date (
--     lesson_date_id UUID NOT NULL PRIMARY KEY,
--     lesson_id UUID NOT NULL,
--     week_day lesson.week_day NOT NULL,
--     start_time TIME NOT NULL,
--     end_time TIME NOT NULL,
--     FOREIGN KEY (lesson_id) REFERENCES lesson.lesson(lesson_id)
-- )