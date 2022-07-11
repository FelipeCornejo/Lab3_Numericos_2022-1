clear
clc
%Carga de Datos
load("data\data.mat");
tarjet = ceil(conv(UCI_T, [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]/29));
largo = size(tarjet,2); % largo = 82
corte = floor(largo/3);
tarjet1 = tarjet(1,1:corte);
tarjet2 = tarjet(1,corte+1:2*corte);
tarjet3 = tarjet(1,2*corte+1:end);

% Definición de Cte
MULTI = 13;
ADITI = 17;
%M = 256;

i = 1;
while largo > 2^i
    i = i + 1;
end
m = 2^i; 

seed = 3; %se propone una seed inicial, pero está cambiará en el tiempo para las siguientes iteraciones de los generadores


load("data\min_max_iniciales.mat");
min_max1 = min_max_iniciales;
min_max2 = min_max_iniciales;
min_max3 = min_max_iniciales;

%Cantidad de simulaciones y porcentaje de corte del top
sims = 1000;
corte = 0.2;

%Grados minimos y máximos iniciales
grado_min = 4;
grado_max = 19;

%vector x
x1 = 1:size(tarjet1,2);
x2 = 1:size(tarjet2,2);
x3 = 1:size(tarjet3,2);

iteraciones = 0;
top_general_vals = [];
top_general_coefs = [];
while iteraciones < 100
    grados = randi([grado_min,grado_max],sims,1);
    
    %Generadores de números
    coeficientes = [];
    for grado=1:grado_max
        [coefs, tiempo_lineal,seed] = gen_lineal(MULTI,ADITI,sims,seed,m,min_max1(:,grado));
        coeficientes = [coeficientes,coefs'];
    end
    
    coeficientes_grado = [grados,coeficientes];
    
    valores_poli = poli(x1,coeficientes_grado);
    
    [seleccion,errores] = fitness(valores_poli,tarjet1);
    seleccion = sortrows(seleccion,1);
    top_vals = seleccion(1:end*corte,:);
    coeficientes_error = [errores,coeficientes_grado];
    coeficientes_error = sortrows(coeficientes_error,1);
    top_coefs = coeficientes_error(1:end*corte,:);
    
    %Obtención de maximos y minimos en grados
    grado_min = min(top_vals(:,2));
    grado_max = max(top_vals(:,2));
    
    %Obtención de máximos y mínimos por coeficientes
    min_max1 = [];
    for i=3:grado_max+4
        nuevo_min_max = get_min_max(top_coefs(:,i));
        min_max1 = [min_max1,nuevo_min_max];
    end
    
    top_general_vals = [top_general_vals; top_vals];
    top_general_coefs = [top_general_coefs; top_coefs];
    top_general_vals = sortrows(top_general_vals,1);
    top_general_coefs = sortrows(top_general_coefs,1);

    iteraciones = iteraciones + 1;
    if var(top_vals(:,1)) < 10^-5
        10101
        break;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


