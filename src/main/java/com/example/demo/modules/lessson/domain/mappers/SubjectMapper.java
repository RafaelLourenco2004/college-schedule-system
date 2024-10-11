package com.example.demo.modules.lessson.domain.mappers;

import com.example.demo.modules.lessson.domain.dtos.SubjectDto;
import com.example.demo.modules.lessson.domain.entities.Semester;
import com.example.demo.modules.lessson.domain.entities.Subject;
import java.util.Optional;

public class SubjectMapper {

    public static Subject toSubject(SubjectDto dto) throws Exception {
        Subject subject = new Subject();

        subject.setName(Optional.ofNullable(dto.getName()).orElseThrow(() -> new Exception()));
        subject.setCredit(Optional.ofNullable(dto.getCredit()).orElseThrow(() -> new Exception()));
        subject.setSemester(Optional.ofNullable(Semester.toSemester(dto.getSemester()))
                .orElseThrow(() -> new Exception()));

        return subject;

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
