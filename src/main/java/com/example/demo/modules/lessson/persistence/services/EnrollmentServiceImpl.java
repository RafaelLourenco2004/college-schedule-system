package com.example.demo.modules.lessson.persistence.services;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.persistence.repositories.EnrollmentRepository;

@Service
public class EnrollmentServiceImpl implements EnrollmentService{

    @Autowired
    private EnrollmentRepository repository;
    
    @Override
    public void deleteEnrollment(UUID subjectId, UUID classroomId, String studentId) {
        repository.deleteEnrollment(subjectId, classroomId, studentId);
    }
    
}
