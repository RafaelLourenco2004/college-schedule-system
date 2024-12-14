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

    @Column(name = "week_day")
    private Weekday weekday;
    
    @Column(name = "start_time")
    private LocalTime startTime;
    
    @Column(name = "end_time")
    private LocalTime endTime;

    // private Duration duration; 

    // @ManyToOne()
    // @JoinColumns({@JoinColumn(name = "subject_id"), @JoinColumn(name = "classroom_id")})
    // private Lesson lesson;

    @Column(name = "subject_id")
    private UUID subjectId;

    @Column(name = "classroom_id")
    private UUID classroom_id;

    public LessonDate(UUID id, Weekday weekday, LocalTime startTime, LocalTime endTime) {
        this.id = id;
        this.weekday = weekday;
        this.startTime = startTime;
        this.endTime = endTime;
    }
    // public LessonDate(Weekday weekday, LocalTime startTime, Duration duration) {
    //     this.weekday = weekday;
    //     this.startTime = startTime;
    //     this.duration = duration;
    // }

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

    public LocalTime getEndTime(){
        return endTime;
    }

    public void setSubjectId(UUID subjectid){
        this.subjectId = subjectid;
    }

    public void setClassroomId(UUID classroomId){
        this.classroom_id = classroomId;
    }

    // @Override
    // public Duration getDuration() {
    //     return duration;
    // }

}
