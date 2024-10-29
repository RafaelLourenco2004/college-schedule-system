package com.example.demo.modules.lessson.domain.usecases.subject;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.domain.exceptions.NotFoundException;
import com.example.demo.modules.lessson.persistence.services.ISubjectService;

@Service
public class SubjectGetService {
    
    @Autowired
    private ISubjectService subjectService;

    public List<Subject> getAll(){
        return subjectService.getAll();
    }

    public Subject getOne(UUID id) throws NotFoundException{
        Optional<Subject> subject = subjectService.getOne(id);
        return subject.orElseThrow(() -> new NotFoundException("Subject could not be found"));
    }
}
