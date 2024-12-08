package com.example.demo.modules.lessson.domain.entities;

import java.time.LocalTime;
import java.time.Duration;
import java.util.UUID;

import com.example.demo.modules.lessson.domain.interfaces.ILessonDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "lesson_date", schema = "lesson", catalog = "lesson")
public class LessonDate implements ILessonDate {

    @Id
    @Column(name = "lesson_date_id")
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    private Weekday weekday;

    private LocalTime startTime;

    private Duration duration; 

    @ManyToOne()
    @JoinColumns({@JoinColumn(name = "subject_id"), @JoinColumn(name = "classroom_id")})
    private Lesson lesson;

    public LessonDate(Weekday weekday, LocalTime startTime, Duration duration) {
        this.weekday = weekday;
        this.startTime = startTime;
        this.duration = duration;
    }

    public UUID getId() {
        return id;
    }

    @Override
    public String getWeekDay() {
        return weekday.getWeekDay();
    }

    @Override
    public LocalTime getStartTime() {
        return startTime;
    }

    @Override
    public Duration getDuration() {
        return duration;
    }

}
