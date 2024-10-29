package com.example.demo.modules.lessson.persistence.services;

import java.util.List;
import java.util.UUID;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Course;
import com.example.demo.modules.lessson.persistence.repositories.CourseRepository;

@Service
public class CourseService implements ICourseService {

    
    private CourseRepository repository;
    
    public CourseService(CourseRepository repository) {
        this.repository = repository;
    }
    
    @Override
    public Course create(Course course) {
        return repository.save(course);
    }

    @Override
    public boolean exists(String name) {
        return repository.existsByName(name);
    }

    @Override
    public List<Course> getAll() {
        return repository.findAll();
    }

    @Override
    public Optional<Course> getOne(UUID id) {
        return repository.findById(id);
    }

}
