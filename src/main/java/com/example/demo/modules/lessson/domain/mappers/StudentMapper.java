package com.example.demo.modules.lessson.domain.mappers;

import com.example.demo.modules.lessson.domain.dtos.StudentDto;
import com.example.demo.modules.lessson.domain.entities.Student;

public class StudentMapper {
    
    public static StudentDto toDto(Student student){
        StudentDto dto = new StudentDto(student.getId(), student.getName());
        return dto;
    }
}
