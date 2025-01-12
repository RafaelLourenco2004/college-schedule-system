package com.example.demo.modules.lessson.domain.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;
import java.util.UUID;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonProperty.Access;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class SubjectDto {
    
    // @JsonProperty(access = Access.READ_ONLY)
    private UUID id;

    private String name;

    private Integer credit;

    private String semester;

    @JsonProperty(access = Access.READ_ONLY)
    private CourseDto course;
    
    private List<SubjectDto> dependencies;
}
