package com.example.demo.modules.lessson.domain.usecases.lesson.date;

import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;
import java.time.Duration;

public interface DurationPatternFormatter {
    
    public Duration getDuration(String str) throws InvalidAttributeValueException;
}
