function x_out = newtoncall(f, x0, x1)
    format long
    x_out = zeros(8, 1) ;
    maxI = 10e3;
    delta = 0.01;
    a = x0 + delta ;
    j = 1;
    while a < x1
        [c, ff ,iexe , texe] = newton (f, a, eps , maxI);
        b = c + delta ;
        if (b > a && b < x1)
            a = b;
        end
        root = 0;
        for p = 1:j
            if (abs(x_out(p) - c) < 10e2*eps)
                root = 1;
            end
        end
        if (root == 0)
            if(c <= x1 && c >= x0)
                x_out(j) = c;
                j = j + 1;
            end
        end
    end
    a = a + delta;
end