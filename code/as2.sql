DECLARE
    v_hotel_code VARCHAR(2) := 'H1';
    v_user_id VARCHAR2(5) := 'T1000';
    v_checkin_date DATE := TO_DATE('06-06-2017','DD-MM-YYYY');
    v_checkout_date DATE := TO_DATE('16-06-2017','DD-MM-YYYY');
    v_room_type VARCHAR2(15) := 'Deluxe';
    v_noofrooms NUMBER := 1;
    t_count NUMBER;
    t_b NUMBER;
    t_avail_rooms NUMBER;
    t_booking_id VARCHAR2(9);
BEGIN
    SELECT COUNT(*) into t_count FROM HOTEL_DETAILS WHERE HOTEL_CODE = v_hotel_code;
    IF (t_count <> 1) THEN
        DBMS_OUTPUT.PUT_LINE('Invalid Hotel Code');
        RETURN;
    ELSIF (v_checkin_date >= v_checkout_date) THEN
        DBMS_OUTPUT.PUT_LINE('Invalid Check Out date');
        RETURN;
    END IF;
    
    SELECT COUNT(*) into t_count FROM LOGIN_DETAILS WHERE USER_ID = v_user_id;
    
    IF (t_count <> 1) THEN
        DBMS_OUTPUT.PUT_LINE('Invalid User ID');
        RETURN;
    END IF;
    
    SELECT COUNT(*) into t_count FROM HOTEL_AVAILABILITY WHERE HOTEL_CODE = v_hotel_code and ROOM_TYPE = v_room_type;

    IF (t_count <> 1) THEN
        DBMS_OUTPUT.PUT_LINE('Invalid room type for the entered hotel code');
        RETURN;
    END IF;
        
    SELECT AVAILABLE_ROOMS into t_avail_rooms FROM HOTEL_AVAILABILITY WHERE HOTEL_CODE = v_hotel_code and ROOM_TYPE = v_room_type;

    IF (t_avail_rooms < v_noofrooms) THEN
        DBMS_OUTPUT.PUT_LINE('Number of rooms insufficient');
        RETURN;
    END IF;
        
    SELECT COALESCE(SUM(NO_OF_ROOMS),0) INTO t_count from hotel_booking where HOTEL_CODE=v_hotel_code and ROOM_TYPE = v_room_type and ((checkin_date <= v_checkin_date and checkout_date >= v_checkin_date) or (checkin_date <= v_checkout_date and checkout_date >= v_checkout_date));

    t_avail_rooms := t_avail_rooms - t_count;
    
    IF (t_avail_rooms < v_noofrooms) THEN
        DBMS_OUTPUT.PUT_LINE('No rooms available for the entered date');
        RETURN;
    END IF;

    SELECT COUNT(*) into t_count from hotel_booking where HOTEL_CODE=v_hotel_code;
    
    t_booking_id := '115'||v_hotel_code||TO_CHAR(t_count+1,'FM0000');
    
    SELECT COUNT(*) INTO t_b FROM HOTEL_booking WHERE booking_confirmation_no = t_booking_id;
    
    WHILE (t_b <> 0) LOOP
        t_count := t_count + 1;
        t_booking_id := '115'||v_hotel_code||TO_CHAR(t_count+1,'FM0000');
        SELECT COUNT(*) INTO t_b FROM HOTEL_booking WHERE booking_confirmation_no = t_booking_id;
    END LOOP;
    
    SELECT RATE_PER_DAY into t_count from hotel_availability where hotel_code=v_hotel_code and room_type = v_room_type;
    
    t_count := t_count * v_noofrooms * (v_checkout_date - v_checkin_date); 

    INSERT INTO HOTEL_BOOKING VALUES (v_hotel_code, v_user_id, v_checkin_date, v_checkout_date, v_room_type, v_noofrooms, t_count, t_booking_id);
    
   DBMS_OUTPUT.PUT_LINE('Hotel booked successfully Booking ID -> '|| t_booking_id || '|| Amount -> ' || t_count);
EXCEPTION
-- this section is optional
   WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('Error Code is ' || TO_CHAR(sqlcode )  );
     DBMS_OUTPUT.PUT_LINE('Error Message is ' || sqlerrm   );        
END;
/