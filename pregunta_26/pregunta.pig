/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname 
   FROM 
       u 
   WHERE 
       SUBSTRING(firstname, 0, 1) >= 'm';

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
sub_data = FOREACH data GENERATE name;
filtered = FILTER sub_data BY SUBSTRING(name, 0, 1) MATCHES '[M-Z]';
STORE filtered INTO 'output' using PigStorage(',');