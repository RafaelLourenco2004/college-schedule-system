package com.example.demo.modules.lessson.domain.usecases.lesson.date;

import com.example.demo.modules.lessson.domain.entities.LessonDate;

public interface LessonDateFactory {
    
    LessonDate getLessonDate(String time, String duration, String weekday);
}
