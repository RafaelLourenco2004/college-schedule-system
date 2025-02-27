package com.example.demo.modules.lessson.persistence.repositories;

import java.time.LocalTime;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.modules.lessson.domain.entities.LessonDate;

@Repository
public interface LessonDateRepository extends JpaRepository<LessonDate, UUID> {

    @Query(value = "INSERT INTO lesson.lesson_date (lesson_date_id, subject_id, classroom_id, week_day, " +
            "start_time, end_time) VALUES (:id, :subject_id, :classroom_id, CAST(:week_day AS lesson.week_day), " +
            ":start_time, :end_time) RETURNING *", nativeQuery = true)
    LessonDate create(@Param("id") UUID id, @Param("subject_id") UUID subjectId,
            @Param("classroom_id") UUID classroomId, @Param("start_time") LocalTime startTime, 
            @Param("end_time") LocalTime endTime, @Param("week_day") String weekDay);
}
