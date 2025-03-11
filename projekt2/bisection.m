function x = bisection(f, x0, x1)
    format long;
    delta = 0.001;
    imax = 10^4;
    a = x0; b = x0 + delta;
    i = 0; j= 1;
    % tworzenie podprzedzialow
    while(b < x1)
        %implementacja algorytmu bisekcji
        if(f(a) * f(b) < 10e-6)
            mid = (a + b)/2;
            i = 0;
            while (abs(f(mid)) > 10*eps && i < imax)
                i = i + 1;
                if (f(mid) * f(a)) < 0
                    b = mid;
                else
                    a = mid;
                end
                mid = (a + b)/2;
            end
            x(j, 1) = mid;
            j = j + 1;
        end
        a = a+delta;
        b = b+delta;
    end
end