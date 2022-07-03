/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' AS (letter:chararray, var:chararray, codes:chararray);
sub_data =  FOREACH data GENERATE codes;
flatten_sub_data = FOREACH sub_data GENERATE FLATTEN(TOKENIZE(codes)) as dic;
clear = FOREACH flatten_sub_data GENERATE REPLACE(dic,'([^a-zA-Z])','') AS keys;
grouped = GROUP clear by keys;
count = FOREACH grouped GENERATE group, COUNT(clear);
store count into 'output' using PigStorage(',');