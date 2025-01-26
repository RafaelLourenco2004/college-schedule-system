package com.example.demo.modules.lessson.persistence.services;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.persistence.repositories.EnrollmentRepository;

@Service
public class EnrollmentServiceImpl implements EnrollmentService {

    @Autowired
    private EnrollmentRepository repository;

    @Override
    public void deleteEnrollment(Lesson lesson, String studentId) {
        repository.deleteEnrollment(lesson.getSubject().getId(), lesson.getClassroom().getId(), studentId);
    }

    @Override
    public void deleteEnrollments(Collection<Lesson> lessons, String studentId) {
        lessons.stream().forEach((lesson) -> deleteEnrollment(lesson, studentId));
    }

    @Override
    public void createEnrollment(Lesson lesson, String studentId) {
        repository.createEnrollment(lesson.getSubject().getId(), lesson.getClassroom().getId(), studentId);
    }

    @Override
    public void createEnrollments(List<Lesson> lessons, String studentId) {
        lessons.stream().forEach((lesson) -> createEnrollment(lesson, studentId));
    }

}
