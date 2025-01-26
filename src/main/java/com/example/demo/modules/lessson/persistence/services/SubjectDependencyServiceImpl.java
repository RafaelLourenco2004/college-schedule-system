package com.example.demo.modules.lessson.persistence.services;

import java.util.UUID;

import org.springframework.stereotype.Service;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Service
public class SubjectDependencyServiceImpl implements SubjectDependecyService {

    @PersistenceContext
    private EntityManager entityManager;

    private static final String INSERT_DEPENDENCY_QUERY = "INSERT INTO lesson.subject_dependency " +
            "(dependency_id, dependent_id) VALUES (:dependency_id, :dependent_id)";

    @Override
    public void setDependency(UUID dependencyId, UUID dependentId) {
        Query insertQuery = entityManager.createNativeQuery(INSERT_DEPENDENCY_QUERY);
        insertQuery.setParameter("dependency_id", dependencyId);
        insertQuery.setParameter("dependent_id", dependentId);
        insertQuery.executeUpdate();
    }

}
