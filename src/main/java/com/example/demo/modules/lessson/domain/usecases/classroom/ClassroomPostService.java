package com.example.demo.modules.lessson.domain.usecases.classroom;

import java.util.UUID;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Classroom;
import com.example.demo.modules.lessson.domain.entities.Course;
import com.example.demo.modules.lessson.domain.exceptions.EntityAlreadyExistsException;
import com.example.demo.modules.lessson.domain.usecases.course.CourseGetService;
import com.example.demo.modules.lessson.persistence.services.IClassroomService;

@Service
public class ClassroomPostService {

    private IClassroomService service;

    private CourseGetService courseGetService;

    public ClassroomPostService(IClassroomService service, CourseGetService courseGetService) {
        this.service = service;
        this.courseGetService = courseGetService;
    }

    public Classroom create(Classroom classroom, UUID course_id) {
        Course course = courseGetService.getOne(course_id);
        classroom.setCourse(course);

        String className = generatedClassName(classroom);
        throwIfAlreadyExists(className);
        classroom.setName(className);

        return service.create(classroom);
    }

    private String generatedClassName(Classroom classroom) {
        String courseAcronym = classroom.getCourseAcronymId();
        return courseAcronym.concat(String.format("-%s", classroom.getName()));
    }

    private void throwIfAlreadyExists(String name) {
        if (service.exists(name))
            throw new EntityAlreadyExistsException(
                    String.format("A classroom named %s already exists.", name));
    }
}
