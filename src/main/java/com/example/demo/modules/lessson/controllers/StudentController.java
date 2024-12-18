package com.example.demo.modules.lessson.controllers;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.modules.lessson.domain.dtos.StudentDto;
import com.example.demo.modules.lessson.domain.entities.Student;
import com.example.demo.modules.lessson.domain.mappers.StudentMapper;
import com.example.demo.modules.lessson.domain.usecases.student.StudentPostService;

@RestController
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private StudentPostService studentPostService;

    @PostMapping("/{courseId}")
    public ResponseEntity<StudentDto> create(@RequestBody StudentDto dto,
            @PathVariable("courseId") UUID courseId) {
        Student newStudent = studentPostService.create(dto.getId(), dto.getName(), courseId);
        return ResponseEntity.status(HttpStatus.CREATED).body(StudentMapper.toDto(newStudent));
    }
}
