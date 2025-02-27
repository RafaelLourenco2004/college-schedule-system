package com.example.demo.modules.lessson.domain.usecases.lesson.date;

import java.util.UUID;

import com.example.demo.modules.lessson.domain.entities.LessonDate;

public interface LessonDateFactory {

    LessonDate getLessonDate(UUID id, UUID subjectId, UUID classroomId, String startTime,
            String endTime, String weekday);
}
