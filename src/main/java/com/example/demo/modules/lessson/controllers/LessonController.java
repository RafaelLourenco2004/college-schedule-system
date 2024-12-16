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

import com.example.demo.modules.lessson.domain.dtos.LessonDatesDto;
import com.example.demo.modules.lessson.domain.dtos.LessonDto;
import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.mappers.LessonMapper;
import com.example.demo.modules.lessson.domain.usecases.lesson.LessonDatePostService;
import com.example.demo.modules.lessson.domain.usecases.lesson.LessonGetService;
import com.example.demo.modules.lessson.domain.usecases.lesson.LessonPostService;

@RestController
@RequestMapping("/lesson")
public class LessonController {

    @Autowired
    private LessonPostService lessonPostService;

    @Autowired
    private LessonDatePostService lessonDatePostService;

    @Autowired
    private LessonGetService lessonGetService;
        
    @PostMapping("/{subjectId}/{classroomId}")
    public ResponseEntity<LessonDto> create(@RequestBody LessonDatesDto datesDto,
            @PathVariable("subjectId") UUID subjectId, @PathVariable("classroomId") UUID classroomId) {

        Lesson lesson = lessonPostService.getLesson(subjectId, classroomId);

        List<LessonDate> dates = datesDto.getDates().stream()
                .map((date) -> lessonDatePostService.getLessonDate(subjectId, classroomId, date.getStartTime(), 
                        date.getEndTime(), date.getWeekday()))
                .toList();
                
        Lesson newLesson = lessonPostService.createLesson(lesson);
        dates.stream().forEach((date) -> lessonDatePostService.create(date) );
        newLesson.setDates(dates);

        return ResponseEntity.status(HttpStatus.CREATED).body(LessonMapper.toDto(newLesson));
    }

    @GetMapping()
    public ResponseEntity<List<LessonDto>> getAll(){
        List<Lesson> lessons = lessonGetService.getAll();
        List<LessonDto> dtos = lessons.stream()
                .map((lesson) -> LessonMapper.toDto(lesson))
                .toList();
        return ResponseEntity.status(HttpStatus.OK).body(dtos);
    }

}
