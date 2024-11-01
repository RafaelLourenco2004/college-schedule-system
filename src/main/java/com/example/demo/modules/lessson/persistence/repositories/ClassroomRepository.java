package com.example.demo.modules.lessson.persistence.repositories;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.modules.lessson.domain.entities.Classroom;

@Repository
public interface ClassroomRepository extends JpaRepository<Classroom, UUID> {

    @Query(value = "INSERT INTO lesson.classroom (classroom_id, name, capacity, semester, course_id) " +
            "VALUES (:id, :name, :capacity, CAST(:semester AS lesson.semester), :course_id) RETURNING *", 
            nativeQuery = true)
    Classroom create(@Param("id") UUID id, @Param("name") String name, @Param("capacity") Integer capacity,
            @Param("semester") String semester, @Param("course_id") UUID courseId);

    boolean existsByName(String name);
}
 