package com.example.demo.modules.lessson.domain.usecases.course;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Course;
import com.example.demo.modules.lessson.domain.exceptions.NotFoundException;
import com.example.demo.modules.lessson.persistence.services.CourseService;

import java.util.UUID;
import java.util.List;

@Service
public class GetCourse {

    private CourseService service;

    public GetCourse(CourseService service) {
        this.service = service;
    }

    public Course getOne(UUID id) throws NotFoundException{
        return service.getOne(id).orElseThrow(
                () -> new NotFoundException("Course could not be found"));
    }

    public List<Course> getAll(){
        return service.getAll();
    }

}
