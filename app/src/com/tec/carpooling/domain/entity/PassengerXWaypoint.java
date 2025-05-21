package com.tec.carpooling.domain.entity;


/**
 *
 * @author hidal
 */
public class PassengerXWaypoint {
    private long passengerId;
    private long waypointId;

    public PassengerXWaypoint() {}

    public PassengerXWaypoint(long passengerId, long waypointId) {
        this.passengerId = passengerId;
        this.waypointId = waypointId;
    }

    public long getPassengerId() { return passengerId; }
    public void setPassengerId(long passengerId) { this.passengerId = passengerId; }

    public long getWaypointId() { return waypointId; }
    public void setWaypointId(long waypointId) { this.waypointId = waypointId; }
}


/*public class PassengerXWaypoint {
    private long passengerId; // Corresponde a PU.PASSENGER.person_id
    private long waypointId;

    public PassengerXWaypoint() { }

    public long getPassengerId() { return passengerId; }
    public void setPassengerId(long passengerId) { this.passengerId = passengerId; }
    public long getWaypointId() { return waypointId; }
    public void setWaypointId(long waypointId) { this.waypointId = waypointId; }

     @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PassengerXWaypoint that = (PassengerXWaypoint) o;
        return passengerId == that.passengerId && waypointId == that.waypointId;
    }
    @Override
    public int hashCode() { return Objects.hash(passengerId, waypointId); }
    @Override
    public String toString() { return "PassengerXWaypoint{passengerId=" + passengerId + ", waypointId=" + waypointId + "}"; }
}*/