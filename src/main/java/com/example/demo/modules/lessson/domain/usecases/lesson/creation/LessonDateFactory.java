package com.example.demo.modules.lessson.domain.usecases.lesson.creation;

import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.entities.Weekday;

public interface LessonDateFactory {
    
    LessonDate getLessonDate(String time, String duration, Weekday weekday);
}
