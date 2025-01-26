package com.example.demo.modules.lessson.domain.usecases.subject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Course;
import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.domain.exceptions.EntityAlreadyExistsException;
import com.example.demo.modules.lessson.domain.exceptions.NotFoundException;
import com.example.demo.modules.lessson.domain.usecases.course.GetCourse;
import com.example.demo.modules.lessson.persistence.services.SubjectService;

import jakarta.transaction.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class PostSubject {

    @Autowired
    private SubjectService subjectService;

    @Autowired
    private GetCourse courseGetService;

    public PostSubject(SubjectService subjectService, GetCourse courseGetService) {
        this.subjectService = subjectService;
        this.courseGetService = courseGetService;
    }

    public void validateSubject(Subject subject, UUID courseId) {
        throwIfNameAlreadyExists(subject.getName());
        Course course = courseGetService.getOne(courseId);
        subject.setCourse(course);
        // Subject newSubject = subjectService.create(subject);
    }

    public Subject createSubject(Subject subject) {
        return subjectService.create(subject);
    }

    public void persistSubject(Subject subject, UUID courseId) throws EntityAlreadyExistsException,
            NotFoundException {
        throwIfNameAlreadyExists(subject.getName());
        Course course = courseGetService.getOne(courseId);
        subject.setCourse(course);
        // Subject newSubject = subjectService.create(subject);
        // return newSubject;
        subjectService.persistSubject(subject);
    }

    public void commitSubject() {
        subjectService.flushChanges();
    }

    private void throwIfNameAlreadyExists(String name) throws EntityAlreadyExistsException {
        if (subjectService.exists(name))
            throw new EntityAlreadyExistsException(String.format("A subject named %s already exists", name));
    }
}
