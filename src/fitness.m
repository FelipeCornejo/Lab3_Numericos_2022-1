function [seleccion,fit] = fitness(vectorIN, tarjet,tipo)

[fila,~] = size(vectorIN);
mse_total = [];
r_square = [];
adr_square = [];
M = mean(tarjet);
corr_r = [];
if tipo == 0

    for i=1:fila
        % Opciones para la funcion fitness https://skill-lync.com/student-projects/curve-fitting-using-matlab-55
        % Solución con derivadas parciales: http://www.sc.ehu.es/sbweb/fisica3/datos/regresion/regresion.html 
        
    
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
        % MSE
        mse_test = mse(tarjet-vectorIN(i,2:end));
        mse_total = [mse_total; mse_test];
        %Coef Correlación
        [r,~] = corr(vectorIN(i,2:end)',tarjet');
        corr_r = [corr_r; r];
    
    end
    %Función objetivo debería minimizar MSE y Maximizar (a 1) R
    %Por tanto al realizar la suma entre ambos, lo mejor que puede salir es
    %1//
    %Por tanto f(mse,r) = min(mse) + max(r) = 0 + 1 = 1, pero en el peor
    %caso si mse es 1 y r fuera 0, entonces el resultado igual es 1.
    %para mantener el equilibrio del algoritmo para escoger el error más
    %chico como el mejor set de datos entonces se modificará la función
    %objetivo a f(mse,r) = min(mse) + (1-max(r))*k, donde k será 10^4 el
    %cual es el factor donde los datos convergen. Así f(mse,r) solo
    %afectará en mayor medida cuando llegue a esos valores críticos.
    fit = mse_total+(1-abs(corr_r))*10^4;
    
    seleccion = [fit, vectorIN];
else
    for i=1:fila
        %Coef Correlación
        [r,~] = corr(vectorIN(i,2:end)',tarjet');
        corr_r = [corr_r; r];
    end
    seleccion = [fit,vectorIN];

end
