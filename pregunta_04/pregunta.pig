/*
Pregunta
===========================================================================

El archivo `data.csv` tiene la siguiente estructura:

  driverId       INT
  truckId        INT
  eventTime      STRING
  eventType      STRING
  longitude      DOUBLE
  latitude       DOUBLE
  eventKey       STRING
  correlationId  STRING
  driverName     STRING
  routeId        BIGINT
  routeName      STRING
  eventDate      STRING

Escriba un script en Pig que carge los datos y obtenga los primeros 10 
registros del archivo para las primeras tres columnas, y luego, ordenados 
por driverId, truckId, y eventTime. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

         >>> Escriba su respuesta a partir de este punto <<<
*/
data = LOAD 'data.csv' using PigStorage(',') AS (driverId:INT,
  truckId:INT,
  eventTime:chararray,
  eventType:chararray,
  longitude:DOUBLE,
  latitude:DOUBLE,
  eventKey:chararray,
  correlationId:chararray,
  driverName:chararray,
  routeId:long,
  routeName:chararray,
  eventDate:chararray);
top = limit data 10;
sub_data =  foreach top generate driverId,truckId,eventTime;
ordered = order sub_data by driverId,truckId,eventTime asc;
STORE ordered INTO 'output' using PigStorage(',');