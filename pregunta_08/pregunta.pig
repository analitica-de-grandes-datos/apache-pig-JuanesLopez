/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' AS (letters:chararray, list:chararray, codes:chararray);
sub_data = FOREACH data GENERATE list, codes;
tokenize_data = FOREACH sub_data GENERATE FLATTEN(TOKENIZE(list, ',')) AS list, FLATTEN(TOKENIZE(codes, ',')) AS codes;
clear = FOREACH tokenize_data GENERATE REPLACE(list, '([^a-zA-Z])', '') AS list, REPLACE(codes, '([^a-zA-Z])', '') AS keys;
merged = FOREACH clear GENERATE TOTUPLE(list, keys) as col;
grouped = GROUP merged BY col;
counted = FOREACH grouped GENERATE group, COUNT(merged) AS count;
--ordened = ORDER count BY letters, list, codes asc;
STORE counted INTO 'output' using PigStorage(',');