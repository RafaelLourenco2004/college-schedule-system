package com.example.demo.modules.lessson.domain.usecases.classroom;

import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Classroom;
import com.example.demo.modules.lessson.domain.exceptions.NotFoundException;
import com.example.demo.modules.lessson.persistence.services.IClassroomService;

import java.util.UUID;
import java.util.List;

@Service
public class ClassroomGetService {

    private IClassroomService service;

    public ClassroomGetService(IClassroomService service) {
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
