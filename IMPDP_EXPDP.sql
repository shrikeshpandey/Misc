expdp tangible/tangible@mshprod FULL=N DIRECTORY=DATA_PUMP_DIR DUMPFILE=MashNibExp.DMP SCHEMAS=tangible LOGFILE=MashNib_exp.log


impdp tangible/tangible@nibdev FULL=N DIRECTORY=DATA_PUMP_DIR DUMPFILE=MashNibExp.DMP REMAP_SCHEMA=tangible:tangible SCHEMAS=tangible LOGFILE=MashNibExpImp.LOG
TRANSFORM=SEGMENT_ATTRIBUTES:N:INDEX TRANSFORM=SEGMENT_ATTRIBUTES:N:CONSTRAINT


impdp  nibbase/nibbase@FIMRELEASE FULL=N DIRECTORY=DUMP_IMP DUMPFILE=NIBQCBASE.DMP REMAP_SCHEMA=nibqc:NIBBASE SCHEMAS=nibqc LOGFILE=NIBQCBASEImp.LOG TRANSFORM=SEGMENT_ATTRIBUTES:N:INDEX TRANSFORM=SEGMENT_ATTRIBUTES:N:CONSTRAINT


expdp system/infotech@orcl FULL=N DIRECTORY=DATA_PUMP_DIR DUMPFILE=EBILMIGR.DMP SCHEMAS=EBIL LOGFILE=EBILMIGR_EXP.log

expdp system/oracle@fimrelease FULL=N DIRECTORY=DATA_PUMP_DIR DUMPFILE=nibqc.DMP SCHEMAS=nibqc LOGFILE=nibqc_exp.log

--Migration dump
impdp  tangibleqc/tangibleqc@KFENBD FULL=N DIRECTORY=DATA_PUMP_DIR DUMPFILE=EBILMIGR.DMP REMAP_SCHEMA=ebil:tangibleqc SCHEMAS=ebil LOGFILE=tangibleqc.LOG TRANSFORM=SEGMENT_ATTRIBUTES:N:INDEX TRANSFORM=SEGMENT_ATTRIBUTES:N:CONSTRAINT

impdp  tangibledev/tangibledev@KFENBD FULL=N DIRECTORY=DATA_PUMP_DIR DUMPFILE=EBILMIGR.DMP REMAP_SCHEMA=ebil:tangibledev SCHEMAS=ebil LOGFILE=tangibledev.LOG TRANSFORM=SEGMENT_ATTRIBUTES:N:INDEX TRANSFORM=SEGMENT_ATTRIBUTES:N:CONSTRAINT

impdp  tangibledev/tangibledev@KFENBD FULL=N DIRECTORY=DATA_PUMP_DIR DUMPFILE=EBILMIGR.DMP REMAP_SCHEMA=ebil:tangibledev SCHEMAS=ebil LOGFILE=tangibledev.LOG TRANSFORM=SEGMENT_ATTRIBUTES:N:INDEX TRANSFORM=SEGMENT_ATTRIBUTES:N:CONSTRAINT