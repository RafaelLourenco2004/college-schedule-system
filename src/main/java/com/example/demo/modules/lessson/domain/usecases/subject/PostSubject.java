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

    @Autowired
    private GetSubject getSubject;

    // public PostSubject(SubjectService subjectService, GetCourse courseGetService)
    // {
    // this.subjectService = subjectService;
    // this.courseGetService = courseGetService;
    // }

    @Transactional
    public Subject create(Subject subject, List<UUID> dependencyIds, UUID courseId)
            throws EntityAlreadyExistsException, NotFoundException {
        throwIfNameAlreadyExists(subject.getName());

        // setDependencies(subject, dependencyIds);

        dependencyIds.stream().forEach((id) -> System.out.println(id.toString().toUpperCase()));
        Set<Subject> dependencies = dependencyIds.stream().map((id) -> getSubject.getOne(id))
                .collect(Collectors.toCollection(HashSet::new));

        dependencies.stream().forEach((dependency) -> subject.addDependency(dependency));

        Course course = courseGetService.getOne(courseId);
        subject.setCourse(course);

        Subject newSubject = subjectService.create(subject);

        dependencies.stream().forEach((dependency) -> {
            dependency.addDependent(newSubject);
            subjectService.update(dependency);
        });
        return newSubject;
    }

    // private void setDependencies(Subject subject, List<UUID> dependencyIds) {
    //     if (dependencyIds == null)
    //         return;

    //     dependencyIds.stream().forEach((id) -> System.out.println(id.toString().toUpperCase()));
    //     Set<Subject> dependencies = dependencyIds.stream().map((id) -> getSubject.getOne(id))
    //             .collect(Collectors.toCollection(HashSet::new));

    //     dependencies.forEach((dependency) -> {
    //         dependency.addDependent(subject);
    //         subject.addDependency(dependency);
    //     });
    // }

    // public Subject create(Subject subject, UUID courseId) throws
    // EntityAlreadyExistsException,
    // NotFoundException {
    // throwIfNameAlreadyExists(subject.getName());
    // Course course = courseGetService.getOne(courseId);
    // subject.setCourse(course);
    // Subject newSubject = subjectService.create(subject);
    // return newSubject;
    // }

    private void throwIfNameAlreadyExists(String name) throws EntityAlreadyExistsException {
        if (subjectService.exists(name))
            throw new EntityAlreadyExistsException(String.format("A subject named %s already exists", name));
    }
}
