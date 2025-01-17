package com.example.demo.modules.lessson.persistence.services;

import java.util.UUID;

public interface EnrollmentService {
    
    void deleteEnrollment(UUID subjectId, UUID classroomId, String studentId);
}
