%x: vector independiente x
%coef: matriz de coeficientes
function [valores_totales] = poli(x,coef)
valores_totales = [];
grados = coef(:,1);
coeficientes = coef(:,2:end);
n = size(coef,1);
for i=1:n
    
    coeficientes_calcular = fliplr(coeficientes(i,1:grados(i)));
    valores = polyval(coeficientes_calcular,x);
    valores_totales = [valores_totales; valores];

end
valores_totales = [coef(:,1),valores_totales];
    
end

