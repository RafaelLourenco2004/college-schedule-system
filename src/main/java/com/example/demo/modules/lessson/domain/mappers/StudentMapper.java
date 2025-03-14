package com.example.demo.modules.lessson.domain.mappers;

import java.util.ArrayList;
import java.util.List;

import com.example.demo.modules.lessson.domain.dtos.LessonDto;
import com.example.demo.modules.lessson.domain.dtos.StudentDto;
import com.example.demo.modules.lessson.domain.entities.Student;

public class StudentMapper {

    public static StudentDto toDto(Student student) {
        StudentDto dto = new StudentDto(student.getId(), student.getName());

        List<LessonDto> lessons;
        if (student.getLessons() != null) { 
            lessons = student.getLessons().stream()    
                    .map((lesson) -> LessonMapper.toDto(lesson))
                    .toList();
        } else
            lessons = new ArrayList<>();

        dto.setLessons(lessons);

        return dto;
    }
}
