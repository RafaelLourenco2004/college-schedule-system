package com.example.demo.modules.lessson.persistence.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.persistence.repositories.LessonRepository;

@Service
public class LessonService implements ILessonService {

    private LessonRepository repository;

    public LessonService(LessonRepository repository) {
        this.repository = repository;
    }

    public Lesson create(Lesson lesson) {
        return repository.save(lesson);
    }

    @Override
    public List<Lesson> getAll() {
        return repository.findAll();
    }
}
