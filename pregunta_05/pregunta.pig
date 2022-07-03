/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<

*/

data = load 'data.tsv' as (letter:chararray, var:chararray, codes:chararray);
sub_data =  foreach data generate var;
flatten_sub_data = foreach sub_data generate FLATTEN(TOKENIZE(var)) as letters;
filtered = filter flatten_sub_data by not (letters matches '{');
filtered1 = filter filtered by not (letters matches '}');
grouped = group filtered1 by letters;
count = FOREACH grouped GENERATE group, COUNT(filtered1);
store count into 'output' using PigStorage(',');

