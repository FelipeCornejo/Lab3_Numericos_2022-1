%multi: factor multiplicativo
%n: cantidad de datos a generar
%seed: semilla inicial (valor inicial de los numeros aleatorios)
%m: modulo de la iteración
%mini: Minimo de la función a generar
%maxi: Maximo de la función a generar
function [coeficientes,tiempo] = gen_multi(multi,n,seed,m,mini,maxi,sims)

% Metodo congruencial lineal
% Yi = multi * Yi-1 mod m
% donde m es un valor relacionado con la longitud de la secuencia

% Luego el valor aleatorio en el espacio [0,1) es xi = yi/M
% Se multiplicará por un factor entre maxi y mini para obtener numeros
% entre [0 y delta(, donde delta será maxi-mini

%Diapo 9, https://uvirtual.usach.cl/moodle/pluginfile.php/744924/mod_resource/content/1/Unidad_VII_MetodosEstocasiticos.pdf

    tic
    coeficientes = [];
    for i=1:sims
        delta = maxi-mini;
        for I=1:n
            u = multi*seed;
            y(I) = mod(u,m);
            x(I) = delta*(y(I)/(m - 1));
            seed = y(I);
        end
        coeficientes = [coeficientes;x];
    end
    tiempo = toc;
end