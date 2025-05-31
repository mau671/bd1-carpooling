-- ============================================================================
-- PACKAGE: PU_PASSENGERXTRIPXPAYMENT_PKG
-- Description: Manages payment methods associated with a passenger's trip
-- ============================================================================
CREATE OR REPLACE PACKAGE PU.PU_PASSENGERXTRIPXPAYMENT_PKG AS

    -- Assign a payment method to a passenger's trip
    PROCEDURE assign_payment_method(
        p_passenger_x_trip_id IN NUMBER,
        p_payment_method_id   IN NUMBER
    );

    -- Update payment method for a passenger's trip
    PROCEDURE update_payment_method(
        p_passenger_x_trip_id     IN NUMBER,
        p_new_payment_method_id   IN NUMBER
    );

    -- Delete payment method for a passenger's trip
    PROCEDURE delete_payment_method(
        p_passenger_x_trip_id IN NUMBER
    );

    -- Get the payment method for a passenger's trip
    FUNCTION get_payment_method(
        p_passenger_x_trip_id IN NUMBER
    ) RETURN SYS_REFCURSOR;

END PU_PASSENGERXTRIPXPAYMENT_PKG;
/

CREATE OR REPLACE PACKAGE BODY PU.PU_PASSENGERXTRIPXPAYMENT_PKG AS

    -- Assign a payment method
    PROCEDURE assign_payment_method(
        p_passenger_x_trip_id IN NUMBER,
        p_payment_method_id   IN NUMBER
    ) IS
        v_new_id PU.PASSENGERXTRIPXPAYMENT.id%TYPE;
    BEGIN
        SELECT PU.PASSENGERXTRIPXPAYMENT_SEQ.NEXTVAL INTO v_new_id FROM DUAL;

        INSERT INTO PU.PASSENGERXTRIPXPAYMENT (
            id, passenger_x_trip_id, payment_method_id
        ) VALUES (
            v_new_id, p_passenger_x_trip_id, p_payment_method_id
        );

        COMMIT;
    END;

    -- Update payment method
    PROCEDURE update_payment_method(
        p_passenger_x_trip_id   IN NUMBER,
        p_new_payment_method_id IN NUMBER
    ) IS
    BEGIN
        UPDATE PU.PASSENGERXTRIPXPAYMENT
        SET payment_method_id = p_new_payment_method_id
        WHERE passenger_x_trip_id = p_passenger_x_trip_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20406, 'No payment method found for this PassengerXTrip.');
        END IF;

        COMMIT;
    END;

    -- Delete payment method
    PROCEDURE delete_payment_method(
        p_passenger_x_trip_id IN NUMBER
    ) IS
    BEGIN
        DELETE FROM PU.PASSENGERXTRIPXPAYMENT
        WHERE passenger_x_trip_id = p_passenger_x_trip_id;

        COMMIT;
    END;

    -- Get payment method info
    FUNCTION get_payment_method(
        p_passenger_x_trip_id IN NUMBER
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT PX.id,
                   PX.passenger_x_trip_id,
                   PX.payment_method_id,
                   PM.name AS payment_method_name
            FROM PU.PASSENGERXTRIPXPAYMENT PX
            JOIN ADM.PAYMENTMETHOD PM ON PM.id = PX.payment_method_id
            WHERE PX.passenger_x_trip_id = p_passenger_x_trip_id;

        RETURN v_cursor;
    END;

END PU_PASSENGERXTRIPXPAYMENT_PKG;
/