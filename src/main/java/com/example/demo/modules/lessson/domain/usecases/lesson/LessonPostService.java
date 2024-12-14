package com.example.demo.modules.lessson.domain.usecases.lesson;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Classroom;
import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;
import com.example.demo.modules.lessson.domain.exceptions.NotFoundException;
import com.example.demo.modules.lessson.domain.usecases.classroom.ClassroomGetService;
import com.example.demo.modules.lessson.domain.usecases.subject.SubjectGetService;
import com.example.demo.modules.lessson.persistence.services.ILessonService;

import java.util.List;
import java.util.UUID;

@Service
public class LessonPostService {

    @Autowired
    private SubjectGetService subjectService;

    @Autowired
    private ClassroomGetService classroomService;

    @Autowired
    private ILessonService lessonService;

    public Lesson createLesson(UUID subjectId, UUID classroomId, List<LessonDate> dates)
            throws NotFoundException, InvalidAttributeValueException {
        Subject subject = subjectService.getOne(subjectId);
        Classroom classroom = classroomService.getOne(classroomId);

        if (!subject.getSemester().equals(classroom.getSemester()))
            throw new InvalidAttributeValueException(
                    "Subjects and classes from different semesters cannot be correlated.");

        // Lesson lesson = new Lesson(subject, classroom, date);
        Lesson lesson = new Lesson(subject, classroom);
        lesson.setDates(dates);
        Lesson newLesson = lessonService.create(lesson);
        return newLesson;
    }

}
