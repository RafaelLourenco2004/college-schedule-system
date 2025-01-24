package com.example.demo.modules.lessson.persistence.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.domain.entities.LessonId;
import com.example.demo.modules.lessson.persistence.repositories.LessonDateRepository;
import com.example.demo.modules.lessson.persistence.repositories.LessonRepository;

@Service
public class LessonServiceImpl implements LessonService {

    @Autowired
    private LessonRepository repository;

    @Autowired
    private LessonDateRepository lessonDateRepository;

    public Lesson create(Lesson lesson) {
        return repository.save(lesson);
    }

    @Override
    public List<Lesson> getAll() {
        return repository.findAll();
    }

    @Override
    public Optional<Lesson> getOne(LessonId id) {
        return repository.findById(id);
    }

    @Override
    public void delete(Lesson lesson) {
        List<LessonDate> dates = lesson.getDates();
        dates.stream().forEach((date) -> lessonDateRepository.delete(date));
        repository.deleteById(lesson.getId());
    }

    // @Override
    // public List<Lesson> getAllLessonsWithinTimeRange(String start, String time) {
    //     List<Lesson> lessons = getAll();
        

    // }
}
