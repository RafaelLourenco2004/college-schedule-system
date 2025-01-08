package com.example.demo.modules.lessson.domain.usecases.classroom;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Classroom;
import com.example.demo.modules.lessson.domain.exceptions.NotFoundException;
import com.example.demo.modules.lessson.persistence.services.ClassroomService;

import java.util.UUID;
import java.util.List;

@Service
public class GetClassroom {

    private ClassroomService service;

    public GetClassroom(ClassroomService service) {
        this.service = service;
    }

    public Classroom getOne(UUID id) throws NotFoundException{
        return service.getOne(id).orElseThrow(
                () -> new NotFoundException("Classroom could not be found"));
    }

    public List<Classroom> getAll(){
        return service.getAll();
    }
}
