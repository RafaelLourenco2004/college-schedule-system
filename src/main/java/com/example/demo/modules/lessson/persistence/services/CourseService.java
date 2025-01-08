package com.example.demo.modules.lessson.persistence.services;

import com.example.demo.modules.lessson.domain.entities.Course;
import java.util.List;
import java.util.UUID;
import java.util.Optional;

public interface CourseService {
    
    Course create(Course course);
    boolean exists(String name);
    List<Course> getAll();
    Optional<Course> getOne(UUID id);
}
