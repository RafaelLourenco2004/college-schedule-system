package com.example.demo.modules.lessson.domain.usecases.lesson;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Classroom;
import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;
import com.example.demo.modules.lessson.domain.exceptions.NotFoundException;
import com.example.demo.modules.lessson.domain.usecases.classroom.GetClassroom;
import com.example.demo.modules.lessson.domain.usecases.subject.GetSubject;
import com.example.demo.modules.lessson.persistence.services.LessonService;

import java.util.UUID;

@Service
public class PostLesson {

    @Autowired
    private GetSubject subjectService;

    @Autowired
    private GetClassroom classroomService;

    @Autowired
    private LessonService lessonService;


    public Lesson getLesson(UUID subjectId, UUID classroomId)
            throws NotFoundException, InvalidAttributeValueException {
        Subject subject = subjectService.getOne(subjectId);
        Classroom classroom = classroomService.getOne(classroomId);

        if (!subject.getSemester().equals(classroom.getSemester()))
            throw new InvalidAttributeValueException(
                    "Subjects and classes from different semesters cannot be correlated.");

        Lesson lesson = new Lesson(subject, classroom);
        return lesson;
    }

    public Lesson createLesson(Lesson lesson){
        return lessonService.create(lesson);
    }

}
