package com.example.demo.modules.lessson.persistence.services;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.persistence.repositories.CoustomSubjectRepository;

public interface SubjectService extends CoustomSubjectRepository{
    
    Subject create(Subject subject);
    Subject update(Subject subject);
    boolean exists(String name);
    List<Subject> getAll();
    Optional<Subject> getOne(UUID id);
}
