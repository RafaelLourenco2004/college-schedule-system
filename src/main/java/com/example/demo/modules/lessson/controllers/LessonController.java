package com.example.demo.modules.lessson.controllers;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
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
import com.example.demo.modules.lessson.domain.usecases.lesson.PostLessonDate;
import com.example.demo.modules.lessson.domain.usecases.lesson.DeleteLesson;
import com.example.demo.modules.lessson.domain.usecases.lesson.GetLesson;
import com.example.demo.modules.lessson.domain.usecases.lesson.PostLesson;

@RestController
@RequestMapping("/lesson")
public class LessonController {

    @Autowired
    private PostLesson postLesson;

    @Autowired
    private PostLessonDate postLessonDate;

    @Autowired
    private GetLesson getLesson;

    @Autowired
    private DeleteLesson deleteLesson;
        
    @PostMapping("/{subjectId}/{classroomId}")
    public ResponseEntity<LessonDto> create(@RequestBody LessonDatesDto datesDto,
            @PathVariable("subjectId") UUID subjectId, @PathVariable("classroomId") UUID classroomId) {

        Lesson lesson = postLesson.getLesson(subjectId, classroomId);

        List<LessonDate> dates = datesDto.getDates().stream()
                .map((date) -> postLessonDate.getLessonDate(subjectId, classroomId, date.getStartTime(), 
                        date.getEndTime(), date.getWeekday()))
                .toList();
                
        Lesson newLesson = postLesson.createLesson(lesson);
        dates.stream().forEach((date) -> postLessonDate.create(date) );
        newLesson.setDates(dates);

        return ResponseEntity.status(HttpStatus.CREATED).body(LessonMapper.toDto(newLesson));
    }

    @GetMapping()
    public ResponseEntity<List<LessonDto>> getAll(){
        List<Lesson> lessons = getLesson.getAll();
        List<LessonDto> dtos = lessons.stream()
                .map((lesson) -> LessonMapper.toDto(lesson))
                .toList();
        return ResponseEntity.status(HttpStatus.OK).body(dtos);
    }

    @DeleteMapping("/{subjectId}/{classroomId}")
    public ResponseEntity<String> delete(@PathVariable UUID subjectId, @PathVariable UUID classroomId){
        deleteLesson.delete(subjectId, classroomId);
        return ResponseEntity.status(HttpStatus.OK).body("");
    }

}
