/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data = LOAD 'data.csv' using PigStorage(',') AS (N:int,
                                                name:chararray,
                                                lastname:chararray,
                                                date:chararray,
                                                color:chararray,
                                                number:int);
sub_data = FOREACH data GENERATE date, ToString(ToDate(date, 'yyyy-MM-dd'),'dd') AS dd, ToString(ToDate(date, 'yyyy-MM-dd'),'d') AS d, LOWER(ToString(ToDate(date, 'yyyy-MM-dd'),'EEE')) AS day_S;
replace = FOREACH sub_data GENERATE date, dd, d, (day_S == 'mon'? 'lun':(day_S == 'tue'? 'mar':(day_S == 'wed'? 'mie':(day_S == 'thu'? 'jue':(day_S == 'fri'? 'vie':(day_S == 'sat'? 'sab':(day_S == 'sun'? 'dom':'falso'))))))) AS day_S, (day_S == 'mon'? 'lunes':(day_S == 'tue'? 'martes':(day_S == 'wed'? 'miercoles':(day_S == 'thu'? 'jueves':(day_S == 'fri'? 'viernes':(day_S == 'sat'? 'sabado':(day_S == 'sun'? 'domingo':'falso'))))))) AS EEEE;
STORE replace INTO 'output' using PigStorage(',');
