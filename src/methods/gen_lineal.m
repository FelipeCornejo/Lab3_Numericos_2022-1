%multi: factor multiplicativo
%aditivo: factor aditivo
%n: cantidad de datos a generar
%seed: semilla inicial (valor inicial de los numeros aleatorios)
%mini: Minimo de la función a generar
%maxi: Maximo de la función a generar
function [x,tiempo] = gen_lineal(multi,aditivo,n,seed,mini,maxi)

% Metodo congruencial lineal
% Yi = multi * Yi-1 + aditivo mod m
% donde m es un valor relacionado con la longitud de la secuencia

% Luego el valor aleatorio en el espacio [0,1) es xi = yi/M
% Se multiplicará por un factor entre maxi y mini para obtener numeros
% entre [0 y delta(, donde delta será maxi-mini

%Diapo 9, https://uvirtual.usach.cl/moodle/pluginfile.php/744924/mod_resource/content/1/Unidad_VII_MetodosEstocasiticos.pdf

    tic
    delta = maxi-mini;
    i = 1;
    while n > 2^i
        i = i + 1;
    end
    m = 2^i;
    for I=1:n
        u = multi*seed+aditivo;
        y(I) = mod(u,m);
        x(I) = delta*(y(I)/(m - 1));
        seed = y(I);
    end
    tiempo = toc;
end

