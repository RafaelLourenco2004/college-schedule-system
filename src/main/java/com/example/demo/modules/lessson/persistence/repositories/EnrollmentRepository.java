package com.example.demo.modules.lessson.persistence.repositories;

import java.util.UUID;

import org.springframework.stereotype.Repository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;

@Repository
public class EnrollmentRepository {

    @PersistenceContext
    private EntityManager entityManager;

    private final String DELETE_ENROLLMENT_QUERY = "DELETE FROM lesson.student_subject_enrollment " +
            "WHERE subject_id = :subjectId AND classroom_id = :classroomId AND student_id = :studentId";

    @Transactional
    public void deleteEnrollment(UUID subjectId, UUID classroomId, String studentId) {
        Query query = entityManager.createNativeQuery(DELETE_ENROLLMENT_QUERY);
        query.setParameter("subjectId", subjectId);
        query.setParameter("classroomId", classroomId);
        query.setParameter("studentId", studentId);
        query.executeUpdate();
    }
}
