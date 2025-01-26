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

    private static final String INSERT_ENROLLMENT_QUERY = "INSERT INTO lesson.student_subject_enrollment " +
            "(subject_id, classroom_id, student_id) VALUES (:subject_id, :classroom_id, :student_id)";

    private static final String DELETE_ENROLLMENT_QUERY = "DELETE FROM lesson.student_subject_enrollment " +
            "WHERE subject_id = :subjectId AND classroom_id = :classroomId AND student_id = :studentId";

    public void createEnrollment(UUID subject_id, UUID classroomId, String studenId) {
        Query query = entityManager.createNativeQuery(INSERT_ENROLLMENT_QUERY);
        query.setParameter("subject_id", subject_id);
        query.setParameter("classroom_id", classroomId);
        query.setParameter("student_id", studenId);
        query.executeUpdate();
    }

    @Transactional
    public void deleteEnrollment(UUID subjectId, UUID classroomId, String studentId) {
        Query query = entityManager.createNativeQuery(DELETE_ENROLLMENT_QUERY);
        query.setParameter("subjectId", subjectId);
        query.setParameter("classroomId", classroomId);
        query.setParameter("studentId", studentId);
        query.executeUpdate();
    }
}
