clear
clc
%Carga de Datos
load("data\data.mat");
tarjet = ceil(conv(UCI_T, [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]/31));
largo = size(tarjet,2); % largo = 82
corte = floor(largo/5);
tarjet1 = tarjet(1,1:corte);
tarjet2 = tarjet(1,corte+1:2*corte);
tarjet3 = tarjet(1,2*corte+1:3*corte);
tarjet4 = tarjet(1,3*corte+1:4*corte);
tarjet5 = tarjet(1,4*corte+1:end);

% Definición de Cte
MULTI = 13;
ADITI = 17;
%M = 256;
seed = 3; %se propone una seed inicial, pero está cambiará en el tiempo para las siguientes iteraciones de los generadores


load("data\min_max_iniciales.mat");
min_max1 = min_max_iniciales;
min_max2 = min_max_iniciales;
min_max3 = min_max_iniciales;

%Cantidad de simulaciones y porcentaje de corte del top
sims = 1000;
corte = 0.2;

i = 1;
while sims > 2^i
    i = i + 1;
end
m = 2^i;

%Grados minimos y máximos iniciales
grado_max_ini = 19;
grado_min = 4;
grado_max = 19;

%vector x
x1 = 1:size(tarjet1,2);
x2 = 1:size(tarjet2,2);
x3 = 1:size(tarjet3,2);

iteraciones = 0;
top_general_vals = [];
top_general_coefs = [];
historico_min = [];
historico_max = [];
while iteraciones < 10000
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
    
    top_general_vals = [top_general_vals; top_vals];
    aa = size(top_coefs,2);
    top_coefs(:,aa+1:grado_max_ini+2) = 0;

    top_general_coefs = [top_general_coefs; top_coefs];
    top_general_vals = sortrows(top_general_vals,1);
    top_general_coefs = sortrows(top_general_coefs,1);
    top_general_coefs = top_general_coefs(1:corte*end,:);
    
    %Obtención de maximos y minimos en grados
    grado_min = min(top_vals(:,2));
    grado_max = max(top_vals(:,2));
    
    %Obtención de máximos y mínimos por coeficientes
    min_max1 = [];
    for i=3:grado_max+3
        nuevo_min_max = get_min_max(top_general_coefs(:,i));
        historico_min = [historico_min, nuevo_min_max(1,:)];
        historico_max = [historico_max, nuevo_min_max(2,:)];
        min_max1 = [min_max1,nuevo_min_max];
    end

    iteraciones = iteraciones + 1;
    if var(top_general_vals(1:200,1)) < 10^-8
        10101
        break;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se puede ver que los datos con menor MSE llegan a ser de grado 4.
% Lo que indica que se ajusta de manera cúbica. Por ende fitness podría
% obtener otras medidas de errores respecto a curvas cubicas

