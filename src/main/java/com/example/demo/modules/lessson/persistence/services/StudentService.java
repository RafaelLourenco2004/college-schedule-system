package com.example.demo.modules.lessson.persistence.services;

import java.util.List;
import java.util.Optional;

import com.example.demo.modules.lessson.domain.entities.Student;

public interface StudentService {
    
    Optional<Student> getOne(String id);
    List<Student> getAll();
    Student create(Student student);
    boolean existsById(String id);
}
