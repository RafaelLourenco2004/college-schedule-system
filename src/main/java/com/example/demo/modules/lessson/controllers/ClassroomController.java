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

import com.example.demo.modules.lessson.domain.dtos.ClassroomDto;
import com.example.demo.modules.lessson.domain.entities.Classroom;
import com.example.demo.modules.lessson.domain.mappers.ClassroomMapper;
import com.example.demo.modules.lessson.domain.usecases.classroom.GetClassroom;
import com.example.demo.modules.lessson.domain.usecases.classroom.PostClassroom;

import java.util.UUID;
import java.util.List;

@RestController
@RequestMapping("/classes")
public class ClassroomController {

    @Autowired
    private PostClassroom postClassroom;

    @Autowired
    private GetClassroom getClassroom;

    @PostMapping("/{courseId}")
    public ResponseEntity<ClassroomDto> create(@RequestBody ClassroomDto dto, @PathVariable UUID courseId) {
        Classroom classroom = ClassroomMapper.toClassroom(dto);
        Classroom newClassroom = postClassroom.create(classroom, courseId);
        return ResponseEntity.status(HttpStatus.CREATED).body(ClassroomMapper.toDto(newClassroom));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ClassroomDto> getOne(@PathVariable UUID id) {
        Classroom classroom = getClassroom.getOne(id);
        return ResponseEntity.status(HttpStatus.OK).body(ClassroomMapper.toDto(classroom));
    }

    @GetMapping()
    public ResponseEntity<List<ClassroomDto>> getAll() {
        List<Classroom> classrooms = getClassroom.getAll();
        List<ClassroomDto> dtos = classrooms.stream()
                .map((classroom) -> ClassroomMapper.toDto(classroom))
                .toList();
        return ResponseEntity.status(HttpStatus.OK).body(dtos);
    }
}
