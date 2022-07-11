function [seleccion,fit] = fitness(vectorIN, tarjet)

[fila,~] = size(vectorIN);
mse_total = [];
r_square = [];
adr_square = [];
M = mean(tarjet);
for i=1:fila
    % Opciones para la funcion fitness https://skill-lync.com/student-projects/curve-fitting-using-matlab-55
    % Solución con derivadas parciales: http://www.sc.ehu.es/sbweb/fisica3/datos/regresion/regresion.html 
    % MSE
    mse_test = mse(tarjet-vectorIN(i,2:end));

%     % R-Square: El coeficiente de determinación es la proporción de la varianza total de la variable explicada por la regresión.
%     % El coeficiente de determinación, también llamado R cuadrado, refleja la bondad del ajuste de un modelo a la variable que pretender explicar.
%     regresion = sum((vectorIN(i,2:end)-M).^2);
%     r_square_test = regresion/(mse_test + regresion);
%     
% 
%     % Adjusted R-Square: R2 shows how well terms (data points) fit a curve or line. Adjusted R2 also indicates how well terms fit a curve or line
%     % but adjusts for the number of terms in a model. 
%     adr_square_test = 1 - (((1-r_square_test)*(length(tarjet)-1))/(length(tarjet)-1-1));
% 
%     %se añaden a las listas
%     adr_square = [adr_square; adr_square_test];
%     r_square = [r_square; r_square_test];
    mse_total = [mse_total; mse_test];
end

fit = mse_total;
seleccion = [fit, vectorIN];

