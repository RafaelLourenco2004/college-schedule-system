package com.example.demo.modules.lessson.domain.dtos;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class LessonDatesDto {
    
    private List<LessonDateDto> dates;

    public boolean areThereDates(){
        return dates.isEmpty();
    }

}
