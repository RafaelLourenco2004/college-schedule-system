package com.example.demo.modules.lessson.persistence.services;

import java.util.UUID;

import com.example.demo.modules.lessson.domain.entities.Classroom;

public interface IClassroomService {
    
    Classroom create(Classroom classroom);
    boolean exists(String id);
}
