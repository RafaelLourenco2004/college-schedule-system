package com.example.demo.modules.lessson.domain.usecases.lesson.date;

import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.entities.Weekday;
import com.example.demo.modules.lessson.domain.exceptions.InvalidAttributeValueException;

import java.time.LocalTime;
import java.util.UUID;
import java.util.Optional;


import org.springframework.stereotype.Service;

import java.time.Duration;

@Service
public class LessonDateFactoryImpl implements LessonDateFactory {

    private TimePatternFormatter timePatternFormatter;

    private DurationPatternFormatter durationPatternFormatter;

    public LessonDateFactoryImpl() {
        this.timePatternFormatter = new TimePattternFomatterImpl();
        this.durationPatternFormatter = new DurationPatternFormatterImpl();
    } 

    @Override
    public LessonDate getLessonDate(UUID id, UUID subjectId, UUID classroomId, String startTime,
            String endTime, String weekday) {
        LocalTime newStartTime = timePatternFormatter.getTime(startTime);
        LocalTime newEndTime = timePatternFormatter.getTime(endTime);

        return new LessonDate(id, getWeekday(weekday), newStartTime, newEndTime);
    }

    private Weekday getWeekday(String weekDay){
        return Optional.of(Weekday.toWeekDay(weekDay)).orElseThrow(
            () -> new InvalidAttributeValueException("There is no such week day.")
        );
    }

}
