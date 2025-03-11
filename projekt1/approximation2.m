function [eps_inf, eps_2, x] = approximation2(n)
    xi = [-10:2:10];
    yi = [-9.387, -6.358, -3.438, -1.747, 0.058, 0.827, -0.439, -6.353, -18.781, -40.790, -79.163];
    [A, b] = approximation(xi, yi, n); %A,b - macierze aproksymacji
    x = factorization2(A, b); %obliczenie wektora x za pomocą dekompozycji LDLT
    %x = GS(A, b, 10e-8, 1000*n); %obliczenie wektora x za pomocą GS
    %obliczanie wektora x za pomocą SVD
    %[U, S, V] = svd(A);
    %x = V*(diag(diag(S).^-1)*(U.'*b));
    eps_inf = norm(A*x-b, "inf"); %obliczenie błędu w normie maksimum
    eps_2 = norm(A*x-b, 2); %obliczenie błędu w normie euklidesowej
    plot(-10:0.1:10, polyval(flip(x), -10:0.1:10)); %wykres
end