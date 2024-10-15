package com.example.demo.modules.lessson.persistence.services;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

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
        return repository.create(
                UUID.randomUUID(),
                subject.getName(),
                subject.getSemester().getSemester(),
                subject.getCredit());
    }

    @Override
    public boolean exists(String name) {
        return repository.existsByName(name);
    }

    @Override
    public List<Subject> getAll() {
        return repository.findAll();
    }

    @Override
    public Optional<Subject> getOne(UUID id) {
        return repository.findById(id);
    }

}
