package com.example.demo.modules.lessson.domain.mappers;

import com.example.demo.modules.lessson.domain.dtos.SubjectDto;
import com.example.demo.modules.lessson.domain.entities.Semester;
import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;
import com.example.demo.modules.lessson.domain.exceptions.MissingFieldException;

import java.util.Optional;

public class SubjectMapper {

    public static Subject toSubject(SubjectDto dto)
            throws MissingFieldException, InvalidAttributeValueException {
        Subject subject = new Subject();

        subject.setName((String) getOrthrowIfMissing(dto.getName()));
        subject.setCredit((Integer) getOrthrowIfMissing(dto.getCredit()));
        subject.setSemester(Semester.toSemester((String) getOrthrowIfMissing(dto.getSemester())));

        return subject;

    }

    private static Object getOrthrowIfMissing(Object o) throws MissingFieldException {
        return Optional.ofNullable(o).orElseThrow(
                () -> new MissingFieldException("All fields of subject must be provided"));
    }

    public static SubjectDto toDto(Subject subject) {
        SubjectDto dto = new SubjectDto();
        dto.setId(subject.getId());
        dto.setName(subject.getName());
        dto.setCredit(subject.getCredit());
        dto.setSemester(subject.getSemester().getSemester());
        return dto;
    }
}
