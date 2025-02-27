package com.example.demo.modules.lessson.domain.mappers;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import com.example.demo.modules.lessson.domain.dtos.SubjectDto;
import com.example.demo.modules.lessson.domain.entities.Semester;
import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;
import com.example.demo.modules.lessson.domain.exceptions.MissingFieldException;

public class SubjectMapper {

    public static Subject toSubject(SubjectDto dto)
            throws MissingFieldException, InvalidAttributeValueException {
        Subject subject = new Subject();

        subject.setName((String) Utils.getOrThrowIfMissing(dto.getName(), "subject"));
        subject.setCredit((Integer) Utils.getOrThrowIfMissing(dto.getCredit(), "subject"));
        subject.setSemester(Semester.toSemester((String) Utils.getOrThrowIfMissing(dto.getSemester(),
                "subject")));

        return subject;

    }

    public static SubjectDto toDto(Subject subject) {
        SubjectDto dto = new SubjectDto();
        dto.setId(subject.getId());
        dto.setName(subject.getName());
        dto.setCredit(subject.getCredit());
        dto.setSemester(subject.getSemester().getSemester());
        dto.setCourse(CourseMapper.toDto(subject.getCourse()));
        return dto;
    }

    public static List<SubjectDto> allToDto(Collection<Subject> subjects) {
        List<SubjectDto> dtos = subjects.stream()
                .map((subject) -> toDto(subject))
                .collect(Collectors.toCollection(ArrayList::new));
        return dtos;
    }
}
