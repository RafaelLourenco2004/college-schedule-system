package com.example.demo.modules.lessson.domain.usecases.subject;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.persistence.services.SubjectService;

@Service
public class SubjectDependencyManager {

    @Autowired
    private SubjectService subjectService;

    public void addDependecies(Subject subject, List<Subject> dependencies) {

        dependencies.stream().forEach((dependency) -> {
            subject.addDependency(dependency);
        });

        dependencies.stream().forEach((dependency) -> {
            dependency.addDependent(subject);
            subjectService.update(dependency);
        });

    }
}
