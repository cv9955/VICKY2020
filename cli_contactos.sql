CREATE TABLE "VIC"."CLI_CUENTAS"
  (
    "ID"          NUMBER NOT NULL ENABLE,
    "CLIENTE_ID"  NUMBER NOT NULL ENABLE,
    "STATUS"      NUMBER,
    "CREATED"     DATE,
    "CREATED_BY"  VARCHAR2(20 BYTE),
    "UPDATED"     DATE,
    "UPDATED_BY"  VARCHAR2(20 BYTE),
    "TITLE"       VARCHAR2(50 BYTE) NOT NULL ENABLE,
    "DESCRIPTION" VARCHAR2(200 BYTE),
    CONSTRAINT "CLI_CUENTAS_PK" PRIMARY KEY ("ID") USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "VICKY" ENABLE,
    CONSTRAINT "CLI_CUENTAS_FK1" FOREIGN KEY ("CLIENTE_ID") REFERENCES "VIC"."CLIENTES" ("ID") ENABLE
  )
  SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE
  (
    INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT
  )
  TABLESPACE "VICKY" ;
CREATE OR REPLACE EDITIONABLE TRIGGER "VIC"."CLI_CUENTAS_TRG" BEFORE
  INSERT OR
  UPDATE ON CLI_CUENTAS FOR EACH ROW BEGIN IF INSERTING THEN :NEW.CREATED :=SYSDATE;
  :NEW.CREATED_BY                                                         := NVL(V('APP_USER'),USER);
  :NEW.STATUS                                                             := 1;
  IF :NEW.ID                                                              IS NULL THEN
    SELECT CLI_CUENTAS_SEQ.NEXTVAL INTO :NEW.ID FROM SYS.DUAL;
  END IF;
END IF;
IF UPDATING THEN
  :NEW.UPDATED    :=SYSDATE;
  :NEW.UPDATED_BY := NVL(V('APP_USER'),USER);
END IF;
END;
/
ALTER TRIGGER "VIC"."CLI_CUENTAS_TRG" ENABLE;