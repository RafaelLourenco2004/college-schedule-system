package com.example.demo.modules.lessson.domain.dtos;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonProperty.Access;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class StudentDto {

    private String id;

    private String name;

    @JsonProperty(access = Access.READ_ONLY)
    private List<LessonDto> lessons;

    public StudentDto(String id, String name) {
        this.id = id;
        this.name = name;
    }

}
