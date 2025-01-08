package com.example.demo.modules.lessson.persistence.services;


import com.example.demo.modules.lessson.domain.entities.Classroom;

import java.util.UUID;
import java.util.List;
import java.util.Optional;

public interface ClassroomService {
    
    Classroom create(Classroom classroom);
    boolean exists(String id);
    Optional<Classroom> getOne(UUID id);
    List<Classroom> getAll();
}
