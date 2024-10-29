package com.example.demo.modules.lessson.domain.usecases.course;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Course;
import com.example.demo.modules.lessson.domain.exceptions.EntityAlreadyExistsException;
import com.example.demo.modules.lessson.persistence.services.ICourseService;

@Service
public class CoursePostService {

    private ICourseService courseService;

    public CoursePostService(ICourseService courseService) {
        this.courseService = courseService;
    }

    public Course create(Course course) throws EntityAlreadyExistsException{
        throwIfNameAlreadyExists(course.getName());
        return courseService.create(course);
    }

    private void throwIfNameAlreadyExists(String name) throws EntityAlreadyExistsException{
        if (courseService.exists(name))
            throw new EntityAlreadyExistsException(String.format("A course named %s already exists.", name));
    }

}
