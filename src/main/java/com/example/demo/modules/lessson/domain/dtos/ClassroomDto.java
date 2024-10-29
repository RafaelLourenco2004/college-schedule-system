package com.example.demo.modules.lessson.domain.dtos;

import java.util.UUID;

import com.example.demo.modules.lessson.domain.entities.Semester;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ClassroomDto {
    
    private UUID id;

    private String name;

    private Integer capacity;

    private Semester semester;

    private CourseDto course;
}