/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data = LOAD 'data.tsv' AS (letter:chararray, date:chararray, nummber:int);
letters = FOREACH data GENERATE letter;
grouped = GROUP letters BY letter;
count = FOREACH grouped GENERATE group, COUNT(letters);
STORE count INTO 'output' using PigStorage(',');

