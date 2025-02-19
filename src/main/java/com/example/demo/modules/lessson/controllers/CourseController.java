package com.example.demo.modules.lessson.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.modules.lessson.domain.dtos.CourseDto;
import com.example.demo.modules.lessson.domain.entities.Course;
import com.example.demo.modules.lessson.domain.mappers.CourseMapper;
import com.example.demo.modules.lessson.domain.usecases.course.GetCourse;
import com.example.demo.modules.lessson.domain.usecases.course.PostCourse;

import java.util.UUID;
import java.util.List;

@RestController
@RequestMapping("/course")
public class CourseController {

    @Autowired
    private PostCourse postCourse;

    @Autowired
    private GetCourse getCourse;

    @PostMapping
    public ResponseEntity<CourseDto> create(@RequestBody CourseDto dto) {
        Course course = CourseMapper.toCourse(dto);
        Course newCourse = postCourse.create(course);
        return ResponseEntity.status(HttpStatus.CREATED).body(CourseMapper.toDto(newCourse));
    }

    @GetMapping("/{id}")
    public ResponseEntity<CourseDto> getOne(@PathVariable("id") UUID id) {
        Course course = getCourse.getOne(id);
        return ResponseEntity.status(HttpStatus.OK).body(CourseMapper.toDto(course));
    } 

    @GetMapping
    public ResponseEntity<List<CourseDto>> getAll() {
        List<Course> courses = getCourse.getAll();
        List<CourseDto> dtos = courses.stream()
                .map((course) -> CourseMapper.toDto(course))
                .toList();
        return ResponseEntity.status(HttpStatus.OK).body(dtos);
    }

}
