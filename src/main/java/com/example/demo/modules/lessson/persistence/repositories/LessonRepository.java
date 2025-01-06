package com.example.demo.modules.lessson.persistence.repositories;


import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonId;

public interface LessonRepository extends JpaRepository<Lesson, LessonId>{
    
}
