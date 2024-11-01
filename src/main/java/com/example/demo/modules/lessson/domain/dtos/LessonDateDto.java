package com.example.demo.modules.lessson.domain.dtos;

import com.example.demo.modules.lessson.domain.entities.Weekday;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class LessonDateDto {
    
    @NotNull(message = "Week day has to be provided.")
    private Weekday weekday;

    private String time;

    private String duration;
}
