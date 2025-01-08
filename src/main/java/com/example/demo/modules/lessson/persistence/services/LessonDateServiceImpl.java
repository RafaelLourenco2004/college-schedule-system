package com.example.demo.modules.lessson.persistence.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.LessonDate;
import com.example.demo.modules.lessson.persistence.repositories.LessonDateRepository;

@Service
public class LessonDateServiceImpl implements LessonDateService{

    @Autowired
    private LessonDateRepository repository;
    
    @Override
    public LessonDate create(LessonDate date) {
        return repository.create(
            date.getId(),
            date.getSubjectId(),
            date.getClassroom_id(),
            date.getStartTime(),
            date.getEndTime(),
            date.getWeekDay().getWeekDay()
        );
    }
    
}
