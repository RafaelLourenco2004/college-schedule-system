package com.example.demo.modules.lessson.domain.entities;

import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

@Embeddable
public class LessonId {

    @Column(name = "subject_id")
    private UUID subjectId;

    @Column(name = "classroom_id")
    private UUID classroomId;

    @Column(name = "lesson_date_id")
    private UUID lesson_date_id;

    public LessonId(UUID subjectId, UUID classroomId, UUID lesson_date_id) {
        this.subjectId = subjectId;
        this.classroomId = classroomId;
        this.lesson_date_id = lesson_date_id;
    }

}
