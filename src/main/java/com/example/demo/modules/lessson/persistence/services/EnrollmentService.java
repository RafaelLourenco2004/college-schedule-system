package com.example.demo.modules.lessson.persistence.services;

import java.util.Collection;
import java.util.List;

import com.example.demo.modules.lessson.domain.entities.Lesson;

public interface EnrollmentService {

    void deleteEnrollment(Lesson lesson, String studentId);

    void deleteEnrollments(Collection<Lesson> lessons, String studentId);

    void createEnrollment(Lesson lesson, String studentId);

    void createEnrollments(List<Lesson> lessons, String studentId);
}
