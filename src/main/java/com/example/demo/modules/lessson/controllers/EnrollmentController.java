package com.example.demo.modules.lessson.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.modules.lessson.domain.dtos.StudentDto;
import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonId;
import com.example.demo.modules.lessson.domain.entities.Student;
import com.example.demo.modules.lessson.domain.mappers.StudentMapper;
import com.example.demo.modules.lessson.domain.usecases.enrollment.StudentEnrollment;
import com.example.demo.modules.lessson.domain.usecases.lesson.GetLesson;

@RestController
@RequestMapping("/enrollment")
public class EnrollmentController {

    @Autowired
    private StudentEnrollment studentEnrollment;

    @Autowired
    private GetLesson getLesson;

    @PostMapping("/{studentId}")
    public ResponseEntity<StudentDto> enrollStudent(@RequestBody List<LessonId> lessonIds,
            @PathVariable("studentId") String studentId) {
        List<Lesson> lessons = lessonIds.stream()
                .map((lessonId) -> getLesson.getOne(lessonId))
                .collect(Collectors.toCollection(ArrayList::new));

        Student student = studentEnrollment.enrollStudent(studentId, lessons);
        return ResponseEntity.status(HttpStatus.OK).body(StudentMapper.toDto(student));
    }
}
