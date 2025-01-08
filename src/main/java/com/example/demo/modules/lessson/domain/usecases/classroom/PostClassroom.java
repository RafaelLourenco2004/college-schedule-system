package com.example.demo.modules.lessson.domain.usecases.classroom;

import java.util.UUID;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Classroom;
import com.example.demo.modules.lessson.domain.entities.Course;
import com.example.demo.modules.lessson.domain.exceptions.EntityAlreadyExistsException;
import com.example.demo.modules.lessson.domain.usecases.course.GetCourse;
import com.example.demo.modules.lessson.persistence.services.ClassroomService;

@Service
public class PostClassroom {

    private ClassroomService service;

    private GetCourse courseGetService;

    public PostClassroom(ClassroomService service, GetCourse courseGetService) {
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
