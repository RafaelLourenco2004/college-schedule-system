package com.example.demo.modules.lessson.persistence.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Student;
import com.example.demo.modules.lessson.persistence.repositories.StudentRepositoty;

@Service
public class StudentService implements IStudentService {

    @Autowired
    private StudentRepositoty repositoty;

    @Override
    public Student create(Student student) {
        return repositoty.save(student);
    }

    @Override
    public boolean existsById(String id) {
        return repositoty.existsById(id);
    }

}
