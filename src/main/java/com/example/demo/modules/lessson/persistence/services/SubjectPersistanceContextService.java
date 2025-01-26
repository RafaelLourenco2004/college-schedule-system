package com.example.demo.modules.lessson.persistence.services;

import com.example.demo.modules.lessson.domain.entities.Subject;
import com.example.demo.modules.lessson.persistence.repositories.CoustomSubjectRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

public class SubjectPersistanceContextService implements CoustomSubjectRepository{

    @PersistenceContext
    private EntityManager entityManager;
    
    @Override
    @Transactional
    public void persistSubject(Subject subject) {
        entityManager.persist(subject);
    }
    
    @Override
    @Transactional
    public void flushChanges() {
        entityManager.flush();
    }
    
}
