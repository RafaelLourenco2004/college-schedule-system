package com.example.demo.modules.lessson.domain.usecases.lesson.creation;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Classroom;
import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;
import com.example.demo.modules.lessson.domain.exceptions.NotFoundException;
import com.example.demo.modules.lessson.persistence.services.IClassroomService;
import com.example.demo.modules.lessson.persistence.services.ISubjectService;

import java.util.UUID;

@Service
public class LessonCreation {

    private ISubjectService subjectService;

    private IClassroomService classroomService;

    public LessonCreation(ISubjectService subjectService, IClassroomService classroomService) {
        this.subjectService = subjectService;
        this.classroomService = classroomService;
    }

    public Lesson createLesson(UUID subjectId, UUID classroomId) throws NotFoundException,
            InvalidAttributeValueException {
        Subject subject = getSubject(subjectId);
        Classroom classroom = getClassroom(classroomId);

        if (!subject.getSemester().equals(classroom.getSemester()))
            throw new InvalidAttributeValueException(
                    "Subjects and classes from different semesters cannot be correlated.");

        Lesson lesson = new Lesson(subject, classroom, null);
        return lesson;
    }

    private Subject getSubject(UUID id) throws NotFoundException {
        return subjectService.getOne(id).orElseThrow(
                () -> new NotFoundException("Subject could not be found"));
    }

    private Classroom getClassroom(UUID id) throws NotFoundException {
        return classroomService.getOne(id).orElseThrow(
                () -> new NotFoundException("Classroom could not be found"));
    }
}
