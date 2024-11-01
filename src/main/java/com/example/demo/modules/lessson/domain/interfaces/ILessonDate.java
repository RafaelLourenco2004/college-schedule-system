package com.example.demo.modules.lessson.domain.interfaces;

import java.time.LocalTime;
import java.time.Duration;

public interface ILessonDate {

    String getWeekDay();

    LocalTime getStartTime();

    Duration getDuration();

}
