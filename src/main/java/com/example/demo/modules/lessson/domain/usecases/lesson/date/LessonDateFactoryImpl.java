package com.example.demo.modules.lessson.domain.usecases.lesson.date;

import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.entities.Weekday;

import java.time.LocalTime;
import java.util.UUID;

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
    public LessonDate getLessonDate(UUID id, String startTime, String endTime, String weekday) {
        LocalTime newStartTime = timePatternFormatter.getTime(startTime);
        LocalTime newEndTime = timePatternFormatter.getTime(endTime);
        // Duration newDuration = durationPatternFormatter.getDuration(duration);
        return new LessonDate(id, Weekday.toWeekDay(weekday), newStartTime, newEndTime);
    }

}
