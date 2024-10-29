package com.example.demo.modules.lessson.domain.usecases.course;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Course;
import com.example.demo.modules.lessson.domain.exceptions.NotFoundException;
import com.example.demo.modules.lessson.persistence.services.ICourseService;

import java.util.UUID;
import java.util.List;

@Service
public class CourseGetService {

    private ICourseService service;

    public CourseGetService(ICourseService service) {
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
