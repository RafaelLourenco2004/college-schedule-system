package com.example.demo.modules.lessson.domain.usecases.lesson.creation;

import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.entities.Weekday;

import java.time.LocalTime;
import java.time.Duration;

public class LessonDateFactoryImpl implements LessonDateFactory {

    private TimePatternFormatter timePatternFormatter;

    private DurationPatternFormatter durationPatternFormatter;

    public LessonDateFactoryImpl(TimePatternFormatter timePatternFormatter,
            DurationPatternFormatter durationPatternFormatter) {
        this.timePatternFormatter = timePatternFormatter;
        this.durationPatternFormatter = durationPatternFormatter;
    }

    @Override
    public LessonDate getLessonDate(String time, String duration, Weekday weekday) {
        LocalTime newTime = timePatternFormatter.getTime(time);
        Duration newDuration = durationPatternFormatter.getDuration(duration);
        return new LessonDate(weekday, newTime, newDuration);
    }

}
