package com.example.demo.modules.lessson.domain.usecases.subject;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Course;
import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.domain.exceptions.EntityAlreadyExistsException;
import com.example.demo.modules.lessson.domain.exceptions.NotFoundException;
import com.example.demo.modules.lessson.domain.usecases.course.CourseGetService;
import com.example.demo.modules.lessson.persistence.services.ISubjectService;

import java.util.UUID;

@Service
public class SubjectPostService {

    private ISubjectService subjectService;

    private CourseGetService courseGetService;

    public SubjectPostService(ISubjectService subjectService, CourseGetService courseGetService) {
        this.subjectService = subjectService;
        this.courseGetService = courseGetService;
    }

    public Subject create(Subject subject, UUID courseId) throws EntityAlreadyExistsException,
            NotFoundException {
        throwIfNameAlreadyExists(subject.getName());
        Course course = courseGetService.getOne(courseId);
        subject.setCourse(course);
        Subject newSubject = subjectService.create(subject);
        return newSubject;
    }

    private void throwIfNameAlreadyExists(String name) throws EntityAlreadyExistsException {
        if (subjectService.exists(name))
            throw new EntityAlreadyExistsException(String.format("A subject named %s already exists", name));
    }
}
