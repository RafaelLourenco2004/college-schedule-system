package com.example.demo.modules.lessson.persistence.services;

import java.util.UUID;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Classroom;
import com.example.demo.modules.lessson.persistence.repositories.ClassroomRepository;

@Service
public class ClassroomService implements IClassroomService{

    private ClassroomRepository repository;
    
    @Override
    public Classroom create(Classroom classroom) {
        return repository.save(classroom);
    }

    @Override
    public boolean exists(String name) {
        return repository.existsByName(name);
    }
    
}
