package com.example.demo.modules.lessson.domain.usecases.subject;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.persistence.services.SubjectDependecyService;

import jakarta.transaction.Transactional;

@Service
public class SubjectDependencyManager {

    @Autowired
    private SubjectDependecyService subjectDependecyService;

    @Transactional
    public void addDependecies(Subject subject, List<Subject> dependencies) {

        for (Subject dependecy : dependencies) {
            subjectDependecyService.setDependency(dependecy.getId(), subject.getId());
        }

    }
}
