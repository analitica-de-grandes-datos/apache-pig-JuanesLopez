/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

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
sub_data = FOREACH data GENERATE GetYear(ToDate(date,'yyyy-MM-dd')) AS year;
grouped = GROUP sub_data BY year;
count = FOREACH grouped GENERATE group, COUNT(sub_data);
STORE count INTO 'output' using PigStorage(',');