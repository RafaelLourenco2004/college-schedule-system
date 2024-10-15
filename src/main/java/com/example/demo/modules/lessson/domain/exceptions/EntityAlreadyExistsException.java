package com.example.demo.modules.lessson.domain.exceptions;

public class EntityAlreadyExistsException extends RuntimeException {

    private String message;

    public EntityAlreadyExistsException(String message) {
        super(message);
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
