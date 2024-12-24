package com.example.demo.modules.lessson.persistence.services;

import java.util.List;
import java.util.Optional;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonId;

public interface ILessonService {
    
    Lesson create(Lesson lesson);
    List<Lesson> getAll();
    Optional<Lesson> getOne(LessonId id);
}
