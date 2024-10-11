package com.example.demo.modules.lessson.persistence.services;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.persistence.repositories.SubjectRepository;

@Service
public class SubjectService implements ISubjectService {

    private SubjectRepository repository;

    public SubjectService(SubjectRepository repository) {
        this.repository = repository;
    }

    @Override
    public Subject create(Subject subject) {
        return repository.save(subject);
    }

}
