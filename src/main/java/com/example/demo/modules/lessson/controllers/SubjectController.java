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

import com.example.demo.modules.lessson.domain.dtos.SubjectDto;
import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.domain.mappers.SubjectMapper;
import com.example.demo.modules.lessson.domain.usecases.subject.PostSubject;
import com.example.demo.modules.lessson.domain.usecases.subject.SubjectDependencyManager;
import com.example.demo.modules.lessson.domain.usecases.subject.GetSubject;

@RestController
@RequestMapping("/subject")
public class SubjectController {

    @Autowired
    private PostSubject postSubject;

    @Autowired
    private SubjectDependencyManager subjectDependencyManager;

    @Autowired
    private GetSubject getSubject;

    @PostMapping("/{courseId}")
    public ResponseEntity<SubjectDto> create(@RequestBody SubjectDto dto,
            @PathVariable UUID courseId) throws Exception {

        Subject subject = SubjectMapper.toSubject(dto);
        postSubject.validateSubject(subject, courseId);

        List<Subject> dependecies = new ArrayList<>();
        if (dto.getDependenciesId() != null) {
            dependecies = dto.getDependenciesId().stream()
                    .map((id) -> getSubject.getOne(id))
                    .collect(Collectors.toCollection(ArrayList::new));
        }
        Subject newSubject = postSubject.createSubject(subject);
        subjectDependencyManager.addDependecies(newSubject, dependecies);

        SubjectDto newDto = SubjectMapper.toDto(subject);
        List<SubjectDto> subjectDependecies = SubjectMapper.allToDto(subject.getDependencies());
        newDto.setDependencies(subjectDependecies);

        return ResponseEntity.status(HttpStatus.CREATED).body(newDto);
    }

    @GetMapping()
    public ResponseEntity<List<SubjectDto>> getAll() {
        List<Subject> subjects = getSubject.getAll();

        List<SubjectDto> dtos = SubjectMapper.allToDto(subjects);
        for (int i = 0; i < subjects.size(); i++) {
            dtos.get(i).setDependencies(SubjectMapper.allToDto(subjects.get(i).getDependencies()));
        }
        return ResponseEntity.status(HttpStatus.OK).body(dtos);
    }

    @GetMapping("/{id}")
    public ResponseEntity<SubjectDto> getOne(@PathVariable("id") UUID id) {
        Subject subject = getSubject.getOne(id);
        SubjectDto dto = SubjectMapper.toDto(subject);
        List<SubjectDto> dependencies = SubjectMapper.allToDto(subject.getDependencies());
        dto.setDependencies(dependencies);
        return ResponseEntity.status(HttpStatus.OK).body(dto);
    }

}
