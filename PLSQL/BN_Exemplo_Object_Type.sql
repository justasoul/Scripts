-- Drop type BN_person_typ;

-- Create --
--------------------------------------------------------------------------------
CREATE or replace TYPE BN_person_typ AS OBJECT (
  idno           NUMBER,
  first_name     VARCHAR2(20),
  last_name      VARCHAR2(25),
  email          VARCHAR2(25),
  phone          VARCHAR2(20),
  MAP MEMBER FUNCTION get_idno RETURN NUMBER 
    , MEMBER PROCEDURE display_details    ( SELF IN OUT NOCOPY BN_person_typ )
    , MEMBER PROCEDURE BN_display_details ( SELF IN OUT NOCOPY BN_person_typ, pv_header varchar2 )
);
/

CREATE or replace TYPE BODY BN_person_typ AS
  MAP MEMBER FUNCTION get_idno RETURN NUMBER IS
  BEGIN
    RETURN idno;
  END;

  MEMBER PROCEDURE display_details ( SELF IN OUT NOCOPY BN_person_typ ) IS
  BEGIN
    -- use the PUT_LINE procedure of the DBMS_OUTPUT package to display details
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(idno) || ' ' || first_name || ' ' || last_name);
    DBMS_OUTPUT.PUT_LINE(email || ' '  || phone);
  END;

  MEMBER PROCEDURE BN_display_details ( SELF IN OUT NOCOPY BN_person_typ, pv_header varchar2) IS
  BEGIN
    -- use the PUT_LINE procedure of the DBMS_OUTPUT package to display details
    dbms_output.put_line(pv_header);
    dbms_output.put_line('---------------------------');
    DBMS_OUTPUT.PUT_LINE(TO_CHAR(idno) || ' ' || first_name || ' ' || last_name);
    DBMS_OUTPUT.PUT_LINE(email || ' '  || phone);
  END;

END;
/


-- USAGE --
--------------------------------------------------------------------------------

DEclare
  lo_temp BN_person_typ := new BN_person_typ(1, 'Bruno', 'Nunes', 'blabla@bla.pt', '999999999');
begin

  -- lo_temp.idno := 1;

  dbms_output.put_line('=> lo_temp.idno: ' || lo_temp.idno);
  lo_temp.display_details;
  dbms_output.put_line(' ');
  dbms_output.put_line(' ');
  lo_temp.BN_display_details('HEADER');
 
end; 