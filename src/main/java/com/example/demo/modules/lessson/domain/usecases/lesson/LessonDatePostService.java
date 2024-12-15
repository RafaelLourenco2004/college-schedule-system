package com.example.demo.modules.lessson.domain.usecases.lesson;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.usecases.lesson.date.LessonDateFactory;
import com.example.demo.modules.lessson.persistence.services.ILessonDateService;

@Service
public class LessonDatePostService {

    @Autowired
    private ILessonDateService lessonDateService;

    @Autowired
    private LessonDateFactory dateFactory;

    public LessonDate create(UUID subjectId, UUID classroomId, String startTime,
            String endTime, String weekDay) {
        LessonDate date = dateFactory.getLessonDate(
                UUID.randomUUID(),
                subjectId,
                classroomId,
                startTime,
                endTime,
                weekDay);
        
        LessonDate newDate = lessonDateService.create(date);
        return newDate;
    }
}
