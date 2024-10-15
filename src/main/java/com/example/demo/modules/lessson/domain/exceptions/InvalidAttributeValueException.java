package com.example.demo.modules.lessson.domain.exceptions;

public class InvalidAttributeValueException extends RuntimeException {

    private String message;

    public InvalidAttributeValueException(String message) {
        super(message);
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
