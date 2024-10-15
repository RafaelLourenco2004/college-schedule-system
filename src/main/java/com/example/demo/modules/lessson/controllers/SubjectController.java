package com.example.demo.modules.lessson.controllers;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.modules.lessson.domain.dtos.SubjectDto;
import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.domain.mappers.SubjectMapper;
import com.example.demo.modules.lessson.domain.usecases.subject.CreateSubject;
import com.example.demo.modules.lessson.domain.usecases.subject.GetSubject;

@RestController
@RequestMapping("/subject")
public class SubjectController {

    @Autowired
    private CreateSubject create;

    @Autowired
    private GetSubject get;

    @PostMapping()
    public ResponseEntity<SubjectDto> create(@RequestBody SubjectDto dto) throws Exception {
        Subject subject = SubjectMapper.toSubject(dto);
        Subject newSubject = create.create(subject);
        return ResponseEntity.status(HttpStatus.CREATED).body(SubjectMapper.toDto(newSubject));
    }

    @GetMapping()
    public ResponseEntity<List<SubjectDto>> getAll() {
        List<Subject> subjects = get.getAll();
        List<SubjectDto> dtos = subjects.stream()
                .map((subject) -> SubjectMapper.toDto(subject))
                .toList();
        return ResponseEntity.status(HttpStatus.OK).body(dtos);
    }

    @GetMapping("/{id}")
    public ResponseEntity<SubjectDto> getOne(@PathVariable("id") UUID id) {
        Subject subject = get.getOne(id);
        return ResponseEntity.status(HttpStatus.OK).body(SubjectMapper.toDto(subject));
    }

}
