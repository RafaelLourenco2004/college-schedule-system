package com.example.demo.modules.lessson.domain.usecases.lesson.creation;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;

import lombok.NoArgsConstructor;

@NoArgsConstructor
public class TimePattternFomatterImpl implements TimePatternFormatter {

    @Override
    public LocalTime getTime(String time) throws InvalidAttributeValueException {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
            LocalTime newTime = LocalTime.parse(time, formatter);
            return newTime;
        } catch (DateTimeParseException e) {
            throw new InvalidAttributeValueException(
                    "The specified time must follow the following pattern: HH:mm");
        }
    }

}
