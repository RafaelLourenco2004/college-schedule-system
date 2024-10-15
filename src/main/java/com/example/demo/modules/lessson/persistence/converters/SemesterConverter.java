package com.example.demo.modules.lessson.persistence.converters;

import com.example.demo.modules.lessson.domain.entities.Semester;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class SemesterConverter implements AttributeConverter<Semester, String>{

    @Override
    public String convertToDatabaseColumn(Semester attribute) {
        return attribute.getSemester();
    }

    @Override
    public Semester convertToEntityAttribute(String dbData) {
        return Semester.toSemester(dbData);
    }
    
}
