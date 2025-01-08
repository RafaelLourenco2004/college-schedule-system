package com.example.demo.modules.lessson.persistence.services;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Student;
import com.example.demo.modules.lessson.persistence.repositories.StudentRepositoty;

@Service
public class StudentServiceImpl implements StudentService {

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

    @Override
    public Optional<Student> getOne(String id) {
        return repositoty.findById(id);
    }

    @Override
    public List<Student> getAll() {
        return repositoty.findAll();
    }

}
