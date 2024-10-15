package com.example.demo.modules.lessson.domain.exceptions;

public class MissingFieldException extends RuntimeException {

    private String message;

    public MissingFieldException(String message) {
        super(message);
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
