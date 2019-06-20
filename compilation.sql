spool compilation.log
/*
Created By Shrikesh K. Pandey
Date : 22/04/2008
Purpose : Compile all invalid objects in Database
Version : Base Version


*/
SET SERVEROUTPUT ON SIZE 1000000
DECLARE
UID   VARCHAR2(100);
BEGIN
/*  For Compilation of PACKAGE And PACKAGE BODY */
uid :='TANGIBLE';
  FOR cur_rec IN (SELECT owner,
                         object_name,
                         object_type,
                         DECODE(object_type, 'PACKAGE', 1,
                                             'PACKAGE BODY', 2, 2) AS recompile_order
                    FROM dba_objects
                   WHERE object_type IN ('PACKAGE', 'PACKAGE BODY')
                     AND OWNER='TANGIBLE'
                     AND status != 'VALID'
                   ORDER BY 4)
  LOOP
    BEGIN
     dbms_output.put_line('Compiling ....     '||cur_rec.object_type||'  '||cur_rec.object_name);
      
	  IF cur_rec.object_type = 'PACKAGE' THEN
        EXECUTE IMMEDIATE 'ALTER ' || cur_rec.object_type || 
            ' "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE';
      ElSE
        EXECUTE IMMEDIATE 'ALTER PACKAGE "' || cur_rec.owner || 
            '"."' || cur_rec.object_name || '" COMPILE BODY';
      END IF;
      
	  dbms_output.put_line('Compiled  '||cur_rec.object_name);
      
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(cur_rec.object_type || ' : ' || cur_rec.owner || 
                             ' : ' || cur_rec.object_name);
    END;
  END LOOP;
  
  /*  For Compilation of Other Objects */
	
    FOR cur_rec IN (SELECT owner,
     					   object_name,
	   					   object_type
                      FROM dba_objects
                     WHERE object_type IN ('VIEW','TRIGGER','FUNCTION','PROCEDURE')
                       AND OWNER='TANGIBLE'
                       AND status != 'VALID'
                     ORDER BY 2)
				  
  LOOP
    BEGIN
    
    dbms_output.put_line('Compiling ....     '||cur_rec.object_type||'  '||cur_rec.object_name);
    
       EXECUTE IMMEDIATE 'ALTER ' || cur_rec.object_type || 
            ' "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE';
    
     dbms_output.put_line('Compiled  '||cur_rec.object_name);
		
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(cur_rec.object_type || ' : ' || cur_rec.owner || 
                             ' : ' || cur_rec.object_name);
    END;
  END LOOP;				  
  
END;
/
SHOW ERRORS
spool off
exit
