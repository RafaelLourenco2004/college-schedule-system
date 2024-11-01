package com.example.demo.modules.lessson.persistence.services;


import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Classroom;
import com.example.demo.modules.lessson.persistence.repositories.ClassroomRepository;

import java.util.List;
import java.util.UUID;
import java.util.Optional;

@Service
public class ClassroomService implements IClassroomService{

    private ClassroomRepository repository;
    
    public ClassroomService(ClassroomRepository repository) {
        this.repository = repository;
    }

    @Override
    public Classroom create(Classroom classroom) {
        return repository.create(
            UUID.randomUUID(),
            classroom.getName(),
            classroom.getCapacity(),
            classroom.getSemester().getSemester(),
            classroom.getCourse().getId()
        );
    }

    @Override
    public boolean exists(String name) {
        return repository.existsByName(name);
    }

    @Override
    public Optional<Classroom> getOne(UUID id) {
        return repository.findById(id);
    }

    @Override
    public List<Classroom> getAll() {
        return repository.findAll();
    }
    
}
