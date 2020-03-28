# VTA_REMITOS
	"ID"		      --> SEQ_VTA_REMITOS 
	"CAB_TIPO_ID"     >> CAB_TIPO  1201,1002,
	"CLIENTE_ID"      >> CLIENTES 
	"CLI_DFISCAL_ID"  >> CLI_DFISCAL 
	"CLI_DEPOSITO_ID" >> CLI_DEPOSITO 
	"FLETE_ID"        >> FLETES 
	"FECHA" DATE 
	"NRO_REMITO"  
	"OBS" 
	"CTA" NUMBER      >> 1,2		
	"STATUS"        [VTA_REMITO_STATUS]
	"CREATED","CREATED_BY"  
	"UPDATED","UPDATED_BY" 
	"BLOCKED","BLOCKED_BY" 


# VTA_REMITOS_DETALLE
	"ID"  			  --> SEQ_VTA_REMITOS_DETALLE
	"VTA_REMITO_ID"   >> VTA_REMITOS 
	"VTA_PEDIDO_ID"   >> VTA_PEDIDOS 
	"ARTICULO_ID"     >> ARTICULOS 
	"CANTIDAD" NUMBER
	"PRECIO" NUMBER
	"DETALLE" VARCHAR2(4000)

## VTA_REMITO_STATUS
 1|PREPARADO S/NRO
 3|IMPRESO   C/NRO
 8|NO SE ENTREGO
 9|RECIBIDO OK
10|FACTURADO
-1|ANULADO
 0|SALDO INICIAL 
 
#
 V0_VTA_REMITOS 
- ID
- FECHA
- MES  >> TO_CHAR(FECHA,YYYY/MM)
- CAB_TIPO_ID 
- NRO_REMITO
- CLIENTE_ID
- CLI_DFISCAL_ID
- CLI_DEPOSITO_ID
- FLETE_ID
- OBS
- STATUS
- CTA
- NETO  (SELECT SUM(CANTIDAD*PRECIO) FROM VTA_REMITOS_DETALLE)

# V1_VTA_REMITOS 
- FACTURADO
- VTA_FACTURA_IDS
- FACTURAS
- ITEMS_NULL >> COUNT(1) FROM VTA_REMITOS_DETALLE PRECIO IS NULL 