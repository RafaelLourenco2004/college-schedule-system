package com.example.demo.modules.lessson.domain.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class LessonDto {
    
    private SubjectDto subject;
    
    private ClassroomDto classroom;

    private LessonDateDto date;
}
