package com.example.demo.modules.lessson.domain.entities;

import java.time.LocalTime;
import java.util.UUID;

import com.example.demo.modules.lessson.persistence.converters.WeekDayConverter;

import jakarta.persistence.Column;
import jakarta.persistence.Convert;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "lesson_date", schema = "lesson", catalog = "lesson")
public class LessonDate {

    @Id
    @Column(name = "lesson_date_id")
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "subject_id")
    private UUID subjectId;

    @Column(name = "classroom_id")
    private UUID classroom_id;

    @Column(name = "start_time")
    private LocalTime startTime;

    @Column(name = "end_time")
    private LocalTime endTime;

    @Column(name = "week_day")
    @Convert(converter = WeekDayConverter.class)
    private Weekday weekday;

    public LessonDate(UUID id, Weekday weekday, LocalTime startTime, LocalTime endTime) {
        this.id = id;
        this.weekday = weekday;
        this.startTime = startTime;
        this.endTime = endTime;
    }

    public UUID getId() {
        return id;
    }

    public Weekday getWeekDay() {
        return weekday;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public UUID getSubjectId() {
        return subjectId;
    }

    public UUID getClassroom_id() {
        return classroom_id;
    }

    public void setSubjectId(UUID subjectid) {
        this.subjectId = subjectid;
    }

    public void setClassroomId(UUID classroomId) {
        this.classroom_id = classroomId;
    }

}
