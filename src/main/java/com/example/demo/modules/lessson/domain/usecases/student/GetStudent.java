package com.example.demo.modules.lessson.domain.usecases.student;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Student;
import com.example.demo.modules.lessson.domain.exceptions.NotFoundException;
import com.example.demo.modules.lessson.persistence.services.StudentService;

@Service
public class GetStudent {

    @Autowired
    private StudentService studentService;

    public Student getOne(String id) {
        Student student = studentService.getOne(id).orElseThrow(
                () -> new NotFoundException(String.format("Could not find student of id %s", id)));
        return student;
    }

    public List<Student> getAll(){
        return studentService.getAll();
    }
}
