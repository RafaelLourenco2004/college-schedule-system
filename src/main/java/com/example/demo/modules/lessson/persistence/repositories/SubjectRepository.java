package com.example.demo.modules.lessson.persistence.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.demo.modules.lessson.domain.entities.Subject;
import java.util.UUID;

@Repository
public interface SubjectRepository extends JpaRepository<Subject, UUID> {

    @Query(value = "INSERT INTO lesson.subject (subject_id, name, semester, credit, course_id) " +
            "VALUES (:id, :name, CAST(:semester AS lesson.semester), :credit, :course_id) RETURNING *", 
            nativeQuery = true)
    Subject create(@Param("id") UUID id, @Param("name") String name, @Param("semester") String semester,
            @Param("credit") Integer credit, @Param("course_id") UUID courseId);

    @Query(value = "UPDATE lesson.subject SET name = :name, semester = CAST(:semester AS lesson.semester), "+
        "credit = :credit, course_id = :course_id WHERE subject_id = :id RETURNING *", 
            nativeQuery = true)
    Subject update(@Param("id") UUID id, @Param("name") String name, @Param("semester") String semester,
            @Param("credit") Integer credit, @Param("course_id") UUID courseId);

    boolean existsByName(String name);

}
