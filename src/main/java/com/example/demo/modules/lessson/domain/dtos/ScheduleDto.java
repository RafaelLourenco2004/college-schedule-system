package com.example.demo.modules.lessson.domain.dtos;

import java.util.List;
import java.util.UUID;

import com.example.demo.modules.lessson.domain.entities.LessonId;
import com.example.demo.modules.lessson.domain.entities.LessonTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ScheduleDto {
    
    private List<LessonId> lessonIds;
    
    private LessonTime startTime;

    private LessonTime endTime;
}
