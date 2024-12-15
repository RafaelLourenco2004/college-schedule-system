package com.example.demo.modules.lessson.domain.mappers;

import java.util.List;

import com.example.demo.modules.lessson.domain.dtos.LessonDateDto;
import com.example.demo.modules.lessson.domain.dtos.LessonDto;
import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonDate;

public class LessonMapper {

    public static LessonDto toDto(Lesson lesson) {
        LessonDto dto = new LessonDto();

        dto.setSubject(SubjectMapper.toDto(lesson.getSubject()));
        dto.setClassroom(ClassroomMapper.toDto(lesson.getClassroom()));

        List<LessonDateDto> dates = lesson.getDates().stream()
                .map((date) -> toLessonDateDto(date))
                .toList();

        dto.setDates(dates);

        return dto;
    }

    private static LessonDateDto toLessonDateDto(LessonDate date) {
        LessonDateDto dto = new LessonDateDto();

        dto.setWeekday(date.getWeekDay().getWeekDay());
        dto.setStartTime(date.getStartTime().toString());
        dto.setEndTime(date.getEndTime().toString());
        // dto.setDuration(date.getDuration().toString());

        return dto;
    }
}
