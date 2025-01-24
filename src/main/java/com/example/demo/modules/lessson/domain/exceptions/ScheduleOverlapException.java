package com.example.demo.modules.lessson.domain.exceptions;

public class ScheduleOverlapException extends RuntimeException {

    private String message;

    public ScheduleOverlapException(String message) {
        super(message);
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
