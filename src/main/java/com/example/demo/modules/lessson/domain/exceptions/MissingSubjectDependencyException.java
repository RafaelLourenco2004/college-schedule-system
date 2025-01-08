package com.example.demo.modules.lessson.domain.exceptions;

public class MissingSubjectDependencyException extends RuntimeException {

    private String message;

    public MissingSubjectDependencyException(String message) {
        super(message);
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

}
