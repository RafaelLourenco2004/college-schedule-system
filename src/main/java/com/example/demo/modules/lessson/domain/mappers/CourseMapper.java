package com.example.demo.modules.lessson.domain.mappers;

import com.example.demo.modules.lessson.domain.dtos.CourseDto;
import com.example.demo.modules.lessson.domain.entities.Course;
import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;
import com.example.demo.modules.lessson.domain.exceptions.MissingFieldException;


public class CourseMapper {

    public static CourseDto toDto(Course course) {
        CourseDto dto = new CourseDto();

        dto.setId(course.getId());
        dto.setName(course.getName());
        dto.setTotalCredits(course.getTotalCredits());
        dto.setAcronymId(course.getAcronymId());
        return dto;
    }

    public static Course toCourse(CourseDto dto) throws MissingFieldException,
            InvalidAttributeValueException {
        Course course = new Course();

        course.setName((String) Utils.getOrThrowIfMissing(dto.getName(), "course"));
        course.setTotalCredits((Integer) Utils.getOrThrowIfMissing(dto.getTotalCredits(), "course"));
        course.setAcronymId((String) Utils.getOrThrowIfMissing(dto.getAcronymId(), "course"));
        return course;
    }
}
