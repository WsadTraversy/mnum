function [G_out, q_out] = approximation(x, y, n)
    G = zeros(n:n);
    q = zeros(1, n);
    %Implementacja algorytmu
    for i = 1:n
        for k = 1:n
            G(i, k) = sum_G(i, k, x);
        end
    end
    for k = 1:n
            q(1, k) = sum_q(k, x, y);
    end
    G_out = G;
    q_out = q';
end

function out = sum_G(i, k, x)
    suma = 0;
    for j = 1:size(x, 2)
        suma = suma + x(1, j)^(i+k-2);
    end
    out = suma;
end

function out = sum_q(k, x, y)
    suma = 0;
    for j = 1:size(x, 2)
        suma = suma + y(1, j) * (x(1, j)^(k-1));
    end
    out = suma;
end