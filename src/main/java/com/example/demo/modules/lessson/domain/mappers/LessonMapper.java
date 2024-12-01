package com.example.demo.modules.lessson.domain.mappers;

import com.example.demo.modules.lessson.domain.dtos.LessonDateDto;
import com.example.demo.modules.lessson.domain.dtos.LessonDto;
import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonDate;

public class LessonMapper {

    public static LessonDto toDto(Lesson lesson) {
        LessonDto dto = new LessonDto();

        dto.setSubject(SubjectMapper.toDto(lesson.getSubject()));
        dto.setClassroom(ClassroomMapper.toDto(lesson.getClassroom()));
        // dto.setDate(toLessonDateDto(lesson.getDates()));

        return dto;
    }

    private static LessonDateDto toLessonDateDto(LessonDate date) {
        LessonDateDto dto = new LessonDateDto();

        dto.setWeekday(date.getWeekDay());
        dto.setTime(date.getStartTime().toString());
        dto.setDuration(date.getDuration().toString());

        return dto;
    }
}
