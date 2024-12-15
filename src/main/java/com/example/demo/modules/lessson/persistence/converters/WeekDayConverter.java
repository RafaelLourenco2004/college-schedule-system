package com.example.demo.modules.lessson.persistence.converters;

import com.example.demo.modules.lessson.domain.entities.Weekday;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class WeekDayConverter implements AttributeConverter<Weekday, String>{

    @Override
    public String convertToDatabaseColumn(Weekday attribute) {
        return attribute.getWeekDay();
    }

    @Override
    public Weekday convertToEntityAttribute(String dbData) {
        return Weekday.toWeekDay(dbData);
    }
    
}
