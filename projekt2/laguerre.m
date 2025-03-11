function [x_out] = laguerre(p0)
    format long;
    xk = 0;
    s = size(p0, 2) - 1;
    x0 = zeros(s, 1);
    i = 1; j = 1; l = 1;
    imax = 10;
    for n = s:-1:1
        %pochodne pierwszego i drugiego rzędu
        df = polyder(p0);
        df_2 = polyder(df);
        nominator = @(x)n * polyval(p0, x);
        denominator = @(x)sqrt((n-1)*((n-1)*(polyval(df, x)^2-n*polyval(p0, x)*polyval(df_2, x))));
        while abs(polyval(p0, xk)) > eps && j < imax
            if (abs(polyval(df, xk) + denominator(xk)) > abs(polyval(df, xk) - denominator(xk)))
                xk = xk - nominator(xk) / (polyval(df, xk) + denominator(xk));
            else
                xk = xk - nominator(xk) / (polyval(df, xk) - denominator(xk));
            end
            j = j+1;
        end
        j = 1;
        i = i + 1;
        %schemat hornera i zapisywanie wyniku
        if(abs(polyval(p0, xk)) < eps)
            x0(l) = xk;
            l = l + 1;
            q = zeros(n, 1);
            for k=1:n
                q_ii = 0;
                if(k~=1)
                    q_ii = q(k-1) ;
                end
                q(k) = p0(k) + (q_ii *xk);
            end
            p0= q';
        end
    end
    x_out = x0;
end