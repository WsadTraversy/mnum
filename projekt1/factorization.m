function [x, E] = factorization(n)
    % macierze symetryczne, dodatnio określone
    % tworzenie  macierzy L, D, LT z macierzy A
    % A(x, y) - x: wiersze, y: kolumny
    % values = [1, 2, 4; 2, 13, 23; 4, 23, 77]
    [A, b] = matrix_creator(n);
    L = zeros(size(A));
    D = zeros(size(A));
    LT = zeros(size(A));
    L(1, 1) = 1;
    D(1, 1) = A(1, 1);
    LT(1, 1) = 1;
    % implementacja algorytmu
    for a = 2:size(A, 1)
        L(a, 1) = A(a, 1)/D(1, 1);
    end
    for i = 2:size(A, 1)
        for j = i:size(A, 2)
            if i == j
                D(i, i) = A(i, i) - sum_D(D, L, i);
                L(i, i) = 1;
                LT(i, i) = 1;
            else
                L(j, i) = (A(j, i) - sum_L(D, L, i, j))/D(i, i);
            end
        end
    end
    LT = L';
    x = equation(L, D, LT, b);
    E = norm(A*x - b);
end

function out = sum_D(B, C, i)
    suma = 0;
    for k = 1:i-1
        suma = suma + C(i, k)*C(i, k)*B(k, k);
    end
    out = suma;
end

function out = sum_L(B, C, i, j)
    suma = 0;
    for k = 1:i-1
        suma = suma + C(j, k)*B(k, k)*C(i, k);
    end
    out = suma;
end

function out = equation(L, D, LT, b)
    y = inv(L) * b;
    z = inv(D) * y;
    out = inv(LT) * z;
end

function [out_A, out_b] = matrix_creator(n)
    % tworzenie macierzy zgodnie z poleceniem
    A = zeros(n:n);
    b = zeros(n,1);
    for i = 1:n
        b(i, 1) = 2.5 + 0.6*i;
        for j = 1:n
            if i == j
                A(i, i) = 3*n^2 + (1.5*i + 2)*n;
            else
                A(i, j) = (i + j) + 1;
            end
        end
    end
    out_A = A;
    out_b = b;
end