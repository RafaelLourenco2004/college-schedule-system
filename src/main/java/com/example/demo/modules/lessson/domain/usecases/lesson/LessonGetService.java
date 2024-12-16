package com.example.demo.modules.lessson.domain.usecases.lesson;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Lesson;
import com.example.demo.modules.lessson.persistence.services.ILessonService;

@Service
public class LessonGetService {
    
    @Autowired
    private ILessonService lessonService;

    public List<Lesson> getAll(){
        return lessonService.getAll();
    }
}
