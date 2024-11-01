package com.example.demo.modules.lessson.domain.usecases.lesson.creation;

import java.time.LocalTime;

import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;

public interface TimePatternFormatter {
    
    LocalTime getTime(String time) throws InvalidAttributeValueException;
}
