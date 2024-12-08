package com.example.demo.modules.lessson.persistence.repositories;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.modules.lessson.domain.entities.Lesson;

@Repository
public interface LessonRepository extends JpaRepository<Lesson, UUID> {
    
}
