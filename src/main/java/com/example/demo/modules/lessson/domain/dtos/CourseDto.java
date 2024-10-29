package com.example.demo.modules.lessson.domain.dtos;

import java.util.UUID;

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
public class CourseDto {
    
    @JsonProperty(access = Access.READ_ONLY)
    private UUID id;

    private String name;

    private Integer totalCredits;

    private String acronymId;
}
