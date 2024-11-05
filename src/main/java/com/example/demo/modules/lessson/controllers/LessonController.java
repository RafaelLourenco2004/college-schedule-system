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

import com.example.demo.modules.lessson.domain.dtos.LessonDateDto;
import com.example.demo.modules.lessson.domain.dtos.LessonDto;
import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.mappers.LessonMapper;
import com.example.demo.modules.lessson.domain.usecases.lesson.LessonPostService;
import com.example.demo.modules.lessson.domain.usecases.lesson.date.LessonDateFactory;

@RestController
@RequestMapping("/lesson")
public class LessonController {

    @Autowired
    private LessonPostService postService;

    @Autowired
    private LessonDateFactory dateFactory;

    @PostMapping("/{subjectId}/{classroomId}")
    public ResponseEntity<LessonDto> create(@RequestBody LessonDateDto dateDto, @PathVariable UUID subjectId,
            @PathVariable UUID classroomId) {
        LessonDate date = dateFactory.getLessonDate(
                dateDto.getTime(),
                dateDto.getDuration(),
                dateDto.getWeekday());

        Lesson lesson = postService.createLesson(subjectId, classroomId, date);
        return ResponseEntity.status(HttpStatus.CREATED).body(LessonMapper.toDto(lesson));
    }
}
