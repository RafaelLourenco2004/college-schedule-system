package com.example.demo.modules.lessson.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
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
import com.example.demo.modules.lessson.domain.usecases.lesson.GetLesson;
import com.example.demo.modules.lessson.domain.usecases.student.GetStudent;
import com.example.demo.modules.lessson.domain.usecases.student.PostStudent;
import com.example.demo.modules.lessson.domain.usecases.student.UpdateStudent;

@RestController
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private PostStudent postStudent;

    @Autowired
    private UpdateStudent updateStudent;

    @Autowired
    private GetStudent getStudent;

    @Autowired
    private GetLesson getLesson;

    @PostMapping("/{courseId}")
    public ResponseEntity<StudentDto> create(@RequestBody StudentDto dto,
            @PathVariable("courseId") UUID courseId) {
        Student newStudent = postStudent.create(dto.getId(), dto.getName(), courseId);
        return ResponseEntity.status(HttpStatus.CREATED).body(StudentMapper.toDto(newStudent));
    }

    @PostMapping("/schedule/{studentId}")
    public ResponseEntity<StudentDto> postStudentSchedule(@RequestBody List<LessonId> lessonIds,
            @PathVariable("studentId") String studentId) {
        List<Lesson> lessons = lessonIds.stream()
                .map((lessonId) -> getLesson.getOne(lessonId))
                .collect(Collectors.toCollection(ArrayList::new));

        Student student = updateStudent.postSchedule(studentId, lessons);
        return ResponseEntity.status(HttpStatus.OK).body(StudentMapper.toDto(student));
    }

    @GetMapping("/{studentId}")
    public ResponseEntity<StudentDto> getOne(@PathVariable("studentId") String studentId) {
        Student student = getStudent.getOne(studentId);
        return ResponseEntity.status(HttpStatus.OK).body(StudentMapper.toDto(student));
    }

    @GetMapping()
    public ResponseEntity<List<StudentDto>> getAll() {
        List<Student> students = getStudent.getAll();
        List<StudentDto> dtos = students.stream().map((student) -> StudentMapper.toDto(student)).toList();
        return ResponseEntity.status(HttpStatus.OK).body(dtos);
    }
}
