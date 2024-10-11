package com.example.demo.modules.lessson.domain.dtos;

import com.example.demo.modules.lessson.domain.entities.Semester;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class SubjectDto {
    
    private UUID id;

    private String name;

    private Integer credit;

    private String semester;
}
