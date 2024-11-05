package com.example.demo.modules.lessson.domain.usecases.lesson.date;

import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.entities.Weekday;

import java.time.LocalTime;

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
    public LessonDate getLessonDate(String time, String duration, String weekday) {
        LocalTime newTime = timePatternFormatter.getTime(time);
        Duration newDuration = durationPatternFormatter.getDuration(duration);
        return new LessonDate(Weekday.toWeekDay(weekday), newTime, newDuration);
    }

}
