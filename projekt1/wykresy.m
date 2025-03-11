calls = [5, 10, 25, 50, 100, 200];
ammount = size(calls, 2);
time = zeros(size(calls, 1));
bledy = zeros(size(calls, 1));

for k = 1:ammount
    n = calls(k);
    A = zeros(n, n);
    b = zeros(n, 1);
    for i = 1:n
        for j = 1:n
            if (i == j)
                A(i, j) = 10;
            else
                if(j==i+2 || i==j-2)
                    A(i, j) = 4;
                else
                    A(i, j) = 0;
                end
            end
        end
        b(i) = 0.5 * 2.5 * i;
    end
    tic;
    [x, E] = factorization(calls(k));
    time(k) = toc;
    bledy(k) = E;
    %[x] = GS(A, b, 10e-8, 1000*n);
    %time(k) = toc;
    %bledy(k) = norm(A*x-b, 2);
end
figure(1);
plot(calls, time);
xlabel('Ilość obliczeń')
ylabel('Czas iteracji [s]')
title('Wykres czasu od ilości obliczeń')
figure(2);
plot(calls, bledy);
xlabel('Ilość obliczeń')
ylabel('Wielkość błędu')
title('Wykres wielkości błędu od ilości obliczeń')