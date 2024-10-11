package com.example.demo.modules.lessson.domain.usecases.subject;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.persistence.services.ISubjectService;


@Service
public class createSubject {
    
    private ISubjectService subjectService;

    public createSubject(ISubjectService subjectService) {
        this.subjectService = subjectService;
    }

    // public Subject create(){
        
    // }
}
