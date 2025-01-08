package com.example.demo.modules.lessson.domain.usecases.lesson;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.usecases.lesson.date.LessonDateFactory;
import com.example.demo.modules.lessson.persistence.services.LessonDateService;

@Service
public class PostLessonDate {

    @Autowired
    private LessonDateService lessonDateService;

    @Autowired
    private LessonDateFactory dateFactory;

    public LessonDate getLessonDate(UUID subjectId, UUID classroomId, String startTime,
            String endTime, String weekDay) {
        LessonDate date = dateFactory.getLessonDate(
                UUID.randomUUID(),
                subjectId,
                classroomId,
                startTime,
                endTime,
                weekDay);

        return date;
    }

    public LessonDate create(LessonDate date) {
        return lessonDateService.create(date);
    }
}
