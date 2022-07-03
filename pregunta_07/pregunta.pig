/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data = LOAD 'data.tsv' AS (letters:chararray, list:chararray, codes:chararray);
tokenize_data = FOREACH data GENERATE letters, TOKENIZE(list, ',') AS list, TOKENIZE(codes, ',') AS codes;
count = FOREACH tokenize_data GENERATE letters, COUNT(list) AS list, COUNT(codes) AS codes;
ordened = ORDER count BY letters, list, codes asc;
STORE ordened INTO 'output' using PigStorage(',');