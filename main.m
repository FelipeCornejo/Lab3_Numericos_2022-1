clear
clc
%Carga de Datos
load("data\data.mat");
load("data\min_max_iniciales.mat");
tarjet = ceil(conv(UCI_T, [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]/31));
largo = size(tarjet,2);

particiones = 3;
topp = floor(largo/particiones);

tic;
% Definición de Cte
MULTI = 13;
ADITI = 17;
%M = 256;

grado_max_ini = 19;
%Cantidad de simulaciones y porcentaje de corte del top
sims = 1000;
corte = 0.2;

i = 1;
while sims > 2^i
    i = i + 1;
end
m = 2^i;

parte = 1;
top1_particion_vals = [];
top1_particion_coefs = [];
while parte<=particiones
        
    seed = 3; %se propone una seed inicial, pero está cambiará en el tiempo para las siguientes iteraciones de los generadores

    %Se corta respecto a la parte respectiva a calzar.
    if parte*topp > largo
        tarjet1 = tarjet(1,topp*(parte-1)+1:end);
    else
        suelo = topp*(parte-1)+1;
        techo = parte*topp;
        tarjet1 = tarjet(1,suelo:techo);
    end
    parte = parte + 1;

    %vector x
    x1 = 1:size(tarjet1,2);
    
    %se retoman los mínimos y máximos iniciales
    min_max1 = min_max_iniciales;
    
    %Grados minimos y máximos iniciales
    grado_min = 4;
    grado_max = 19;
        
    iteraciones = 0;
    top_general_vals = [];
    top_general_coefs = [];
    while iteraciones < 10000
        grados = randi([grado_min,grado_max],sims,1);
        
        %Generadores de números
        coeficientes = [];
        for grado=1:grado_max
            %[coefs,seed] = gen_lineal(MULTI,ADITI,sims,seed,m,min_max1(:,grado));
            [coefs,seed] = gen_multi(MULTI,sims,seed,m,min_max1(:,grado));
            %[coefs,seed] = gen_aditivo(ADITI,sims,seed,m,min_max1(:,grado));
            coeficientes = [coeficientes,coefs'];
        end
        
        coeficientes_grado = [grados,coeficientes];
    
        valores_poli = poli(x1,coeficientes_grado);
        
        [seleccion,errores] = fitness(valores_poli,tarjet1,0);
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
            min_max1 = [min_max1,nuevo_min_max];
        end
    
        iteraciones = iteraciones + 1;
        if var(top_general_vals(1:10,1)) < 10^-8
            10
            break;
        end
    end
    top1_particion_vals = [top1_particion_vals;top_general_vals(1,:)];
    top1_particion_coefs = [top1_particion_coefs;top_general_coefs(1,:)];
end

tiempo_final =toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Se puede ver que los datos con menor MSE llegan a ser de grado 4.
% Lo que indica que se ajusta de manera cúbica. Por ende fitness podría
% obtener otras medidas de errores respecto a curvas cubicas

