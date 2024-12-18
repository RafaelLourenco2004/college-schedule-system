package com.example.demo.modules.lessson.persistence.services;

import com.example.demo.modules.lessson.domain.entities.Student;

public interface IStudentService {
    
    Student create(Student student);
    boolean existsById(String id);
}
