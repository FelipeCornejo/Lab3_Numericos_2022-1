function [seleccion,errores] = fitness(vectorIN, tarjet)

[fila,~] = size(vectorIN);
errores = [];
for i=1:fila
    errores = [errores; mse(tarjet-vectorIN(i,2:end))];
    
end
seleccion = [errores, vectorIN];

