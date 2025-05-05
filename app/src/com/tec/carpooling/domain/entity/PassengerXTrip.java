package com.tec.carpooling.domain.entity;

import java.math.BigDecimal; // Para 'amount'
import java.util.Objects;

public class PassengerXTrip {
    private long id;
    private long passengerId; // Corresponde a PU.PASSENGER.person_id
    private long tripId;
    private BigDecimal amount;

    public PassengerXTrip() { }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public long getPassengerId() { return passengerId; }
    public void setPassengerId(long passengerId) { this.passengerId = passengerId; }
    public long getTripId() { return tripId; }
    public void setTripId(long tripId) { this.tripId = tripId; }
    public BigDecimal getAmount() { return amount; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }

     @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PassengerXTrip that = (PassengerXTrip) o;
        return id == that.id;
    }
    @Override
    public int hashCode() { return Objects.hash(id); }
    @Override
    public String toString() { return "PassengerXTrip{id=" + id + ", passengerId=" + passengerId + ", tripId=" + tripId + "}"; }
}