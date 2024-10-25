package com.example.demo.modules.lessson.domain.usecases.subject;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.domain.exceptions.EntityAlreadyExistsException;
import com.example.demo.modules.lessson.persistence.services.ISubjectService;


@Service
public class CreateSubject {

    private ISubjectService subjectService;

    public CreateSubject(ISubjectService subjectService) { 
        this.subjectService = subjectService;
    }

    public Subject create(Subject subject) throws EntityAlreadyExistsException {
        throwIfNameAlreadyExists(subject.getName());
        Subject newSubject = subjectService.create(subject);
        return newSubject;
    }
 
    private void throwIfNameAlreadyExists(String name) throws EntityAlreadyExistsException {
        if (subjectService.exists(name))
            throw new EntityAlreadyExistsException(String.format("A subject named %s already exists", name));
    }
}
