package com.example.demo.modules.lessson.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.modules.lessson.domain.dtos.LessonDto;
import com.example.demo.modules.lessson.domain.dtos.ScheduleDto;
import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.mappers.LessonMapper;
import com.example.demo.modules.lessson.domain.usecases.class_schedule.ScheduleSetUp;

@RestController
@RequestMapping("/schedule")
public class ScheduleController {

    @Autowired
    private ScheduleSetUp setClassSchedule;

    @PostMapping
    public ResponseEntity<List<LessonDto>> setSchedule(@RequestBody ScheduleDto scheduleDto) {
        List<Lesson> schedule = setClassSchedule.setUpSchedule(
                scheduleDto.getRequiredLessonIds(),
                scheduleDto.getStartTime(),
                scheduleDto.getEndTime());
        // List<Lesson> schedule = setClassSchedule.setSchedule(
        //         scheduleDto.getRequiredLessonIds(),
        //         scheduleDto.getStartTime(),
        //         scheduleDto.getEndTime());
        List<LessonDto> dtos = schedule.stream().map((lesson) -> LessonMapper.toDto(lesson)).toList();
        return ResponseEntity.status(HttpStatus.CREATED).body(dtos);
    }
}
