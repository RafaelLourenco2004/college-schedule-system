package com.example.demo.modules.lessson.domain.usecases.lesson;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Classroom;
import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;
import com.example.demo.modules.lessson.domain.exceptions.NotFoundException;
import com.example.demo.modules.lessson.domain.usecases.classroom.ClassroomGetService;
import com.example.demo.modules.lessson.domain.usecases.subject.SubjectGetService;

import java.util.UUID;

@Service
public class LessonPostService {

    private SubjectGetService subjectService;

    private ClassroomGetService classroomService;

    public LessonPostService(SubjectGetService subjectService, ClassroomGetService classroomService) {
        this.subjectService = subjectService;
        this.classroomService = classroomService;
    }

    public Lesson createLesson(UUID subjectId, UUID classroomId, LessonDate date)
            throws NotFoundException, InvalidAttributeValueException {
        Subject subject = subjectService.getOne(classroomId);
        Classroom classroom = classroomService.getOne(classroomId);

        if (!subject.getSemester().equals(classroom.getSemester()))
            throw new InvalidAttributeValueException(
                    "Subjects and classes from different semesters cannot be correlated.");

        Lesson lesson = new Lesson(subject, classroom, date);
        return lesson;
    }

}
