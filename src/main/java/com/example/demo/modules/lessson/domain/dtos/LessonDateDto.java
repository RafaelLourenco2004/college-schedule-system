package com.example.demo.modules.lessson.domain.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class LessonDateDto {

    private String weekday;

    private String startTime;

    private String endTime;

    // private String duration;
}
