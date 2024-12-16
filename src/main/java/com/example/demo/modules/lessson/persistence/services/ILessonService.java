package com.example.demo.modules.lessson.persistence.services;

import java.util.List;

import com.example.demo.modules.lessson.domain.entities.Lesson;

public interface ILessonService {
    
    Lesson create(Lesson lesson);
    List<Lesson> getAll();
}
