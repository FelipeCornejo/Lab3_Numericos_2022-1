clear
clc
%Carga de Datos
load("data\data.mat");
tarjet = ceil(conv(UCI_T, [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]/29));
largo = size(tarjet,2); % largo = 820

% Definición de Cte
MULTI = 137;
ADITI = 1;
M = 256;
seed = 3; %se propone una seed inicial, pero está cambiará en el tiempo para las siguientes iteraciones de los generadores
MINI = 0;
MAXI = max(tarjet);

%Cantidad de simulaciones y porcentaje de corte del top
sims = 100;
corte = 0.2;

%Grados minimos y máximos iniciales
grado_min = 4;
grado_max = 19;

%vector x
x = 1:largo;

grados = randi([grado_min,grado_max],100,1);
coeficientes = [];
tiempo_total = 0;

%Generadores de números
%Cambiar 1000 por grado_max
[coefs_lineal, tiempo_lineal,seed] = gen_lineal(MULTI,ADITI,1000,seed,M,MINI,MAXI,sims);
%[coefs_aditi, tiempo_aditi,seed] = gen_aditivo(ADITI,1000,seed,M,MINI,MAXI,sims);
%[coefs_multi, tiempo_multi,seed] = gen_multi(MULTI,1000,seed,M,MINI,MAXI,sims);

coefs_lineal = coefs_lineal./1000; %para reducir los valores entre 0 y 10
coeficientes = [grados, coefs_lineal];
[valores] = poli(x,coeficientes);


