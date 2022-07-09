%x: vector independiente x
%coef: matriz de coeficientes
function [valores_totales] = poli(x,coef)
valores_totales = [];
maxi = max(coef(:,1));
    for i=1:size(coef,1)
        valores = [];
        grado = coef(i,1);
        sum = coef(i,2);
        for j=2:grado
            sum = sum + coef(i,j)*(x(j)^j-1);
            valores = [valores, sum];
        end
        for g=grado:maxi
            valores = [valores, 0];
        end
    valores_totales = [valores_totales; valores];
    end
    
    
end

