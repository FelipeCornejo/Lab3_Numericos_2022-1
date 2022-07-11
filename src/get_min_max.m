function [min_max] = get_min_max(coeficientes)

%Por cada columna (un coeficiente) existe una distribución distinta de
%datos, por ende se deberá obtener un min y max de cada uno de las columnas
%para condicionar los valores máximos y mínimos de la siguiente generación
%de números aleatorios.

minn = min(coeficientes);
maxx = max(coeficientes);

min_max = [minn;maxx];

