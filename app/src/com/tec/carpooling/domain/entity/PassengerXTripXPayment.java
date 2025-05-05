package com.tec.carpooling.domain.entity;

import java.util.Objects;

public class PassengerXTripXPayment {
    private long id;
    private long passengerXTripId; // FK a PU.PASSENGERXTRIP.id
    private long paymentMethodId; // FK a ADM.PAYMENTMETHOD.id

    public PassengerXTripXPayment() { }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public long getPassengerXTripId() { return passengerXTripId; }
    public void setPassengerXTripId(long passengerXTripId) { this.passengerXTripId = passengerXTripId; }
    public long getPaymentMethodId() { return paymentMethodId; }
    public void setPaymentMethodId(long paymentMethodId) { this.paymentMethodId = paymentMethodId; }

     @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PassengerXTripXPayment that = (PassengerXTripXPayment) o;
        return id == that.id;
    }
    @Override
    public int hashCode() { return Objects.hash(id); }
    @Override
    public String toString() { return "PassengerXTripXPayment{id=" + id + ", passengerXTripId=" + passengerXTripId + ", paymentMethodId=" + paymentMethodId + "}"; }
}