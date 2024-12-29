package com.example.demo.modules.lessson.domain.usecases.lesson;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonId;
import com.example.demo.modules.lessson.domain.exceptions.NotFoundException;
import com.example.demo.modules.lessson.persistence.services.ILessonService;

@Service
public class LessonDeleteService {

    @Autowired
    private ILessonService lessonService;

    public void delete(UUID subjectId, UUID classroomId) {
        LessonId id = new LessonId(subjectId, classroomId);
        Lesson lesson = lessonService.getOne(id).orElseThrow(
                () -> new NotFoundException("Could not find lesson"));
        lessonService.delete(lesson);
    }
}
