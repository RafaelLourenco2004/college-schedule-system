package com.example.demo.modules.lessson.domain.entities;

import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Embeddable
public class LessonId {

    @Column(name = "subject_id")
    private UUID subjectId;

    @Column(name = "classroom_id")
    private UUID classroomId;

    public LessonId(UUID subjectId, UUID classroomId) {
        this.subjectId = subjectId;
        this.classroomId = classroomId;
    }

}
