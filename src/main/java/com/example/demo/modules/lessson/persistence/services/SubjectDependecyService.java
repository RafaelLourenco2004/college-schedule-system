package com.example.demo.modules.lessson.persistence.services;

import java.util.UUID;

public interface SubjectDependecyService {
    
    void setDependency(UUID dependencyId, UUID dependentId);
}
