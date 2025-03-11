function [time, x, e, hi] = DorPri45(tspan, xinitial, h)
    hmin = 10e-5; hmax = 10e-3;
    epsw = 10^-8; epsb = 10^-8;
    time = zeros(1, 1);
    x1 = xinitial(1); x2 = xinitial(2);
    x(1,:) = [x1 x2];
    hi = zeros(1);
    e = zeros(1, 2);
    i = 1;
    t = tspan(1);

    while t < tspan(2)
        k11 = dx1(x1, x2);
        k12 = dx2(x1, x2);
        
        k21 = dx1(x1 + (1/5)*h, x2 + h*(1/5)*k11);
        k22 = dx2(x1 + (1/5)*h, x2 + h*(1/5)*k12);
        
        k31 = dx1(x1 + (3/10)*h, x2 + h*((3/40)*k11 + (9/40)*k21));
        k32 = dx2(x1 + (3/10)*h, x2 + h*((3/40)*k12 + (9/40)*k22));
        
        k41 = dx1(x1 + (4/5)*h, x2 + h*((44/45)*k11 - (56/15)*k21 + (32/9)*k31));
        k42 = dx2(x1 + (4/5)*h, x2 + h*((44/45)*k12 - (56/15)*k22 + (32/9)*k32));
        
        k51 = dx1(x1 + (8/9)*h, x2 + h*((19372/6561)*k11 - (25360/2187)*k21 + (64448/6561)*k31 - (212/729)*k41));
        k52 = dx2(x1 + (8/9)*h, x2 + h*((19372/6561)*k12 - (25360/2187)*k22 + (64448/6561)*k32 - (212/729)*k42));
        
        k61 = dx1(x1 + h, x2 + h*((9017/3168)*k11 - (355/33)*k21 + (46732/5247)*k31 + (49/176)*k41 - (5103/18656)*k51));
        k62 = dx2(x1 + h, x2 + h*((9017/3168)*k12 - (355/33)*k22 + (46732/5247)*k32 + (49/176)*k42 - (5103/18656)*k52));
       
        x1h = x1 + h*((35/384)*k11 + (500/1113)*k31 + (125/192)*k41 - (2187/6784)*k51 + (11/84)*k61);
        x2h = x2 + h*((35/384)*k12 + (500/1113)*k32 + (125/192)*k42 - (2187/6784)*k52 + (11/84)*k62);
        
        delta1 = delta(k11, k31, k41, k51, k61, h);
        delta2 = delta(k12, k32, k42, k52, k62, h);

        eps1 = abs(x1)*epsw + epsb;
        eps2 = abs(x2)*epsw + epsb;
        s1 = (eps1/abs(delta1))^(1/5);
        s2 = (eps2/abs(delta2))^(1/5);
        h1 = min(s1, s2)*h;
        if (h1 <hmin)
            h1 = hmin;
        elseif (h1 > hmax)
            h1 = hmax;
        end

        t = t + h1;
        x1 = x1h;
        x2 = x2h;
        h = h1;
        time(i) = t;
        hi(i) = h1;
        x(i,:) = [x1h, x2h];
        e(i,:) = [eps1, eps2];
        i = i + 1;
    end
end

function [delta_out] = delta(k1, k3, k4, k5, k6, h)
    err1 = h*((35/384-5179/57600)*k1);
    err2 = h*(500/1113*k3);
    err3 = h*((500/1113-7571/16695)*k3 + 125/192*k4*h);
    err4 = h*((125/192-393/640)*k4 - 2187/6784*k5*h);
    err5 = h*((-2187/6784+92097/339200)*k5 + 11/84*k6*h);
    err6 = h*(11/84-187/2100)*k6;
    delta_out = h*(err1+err2+err3+err4+err5+err6);
end

function [dx1] = dx1(x1, x2)
    dx1 = x2 + x1*(0.6 - (x1)^2 - (x2)^2);
end

function [dx2] = dx2(x1, x2)
    dx2 = -x1 + x2*(0.6 - (x1)^2 - (x2)^2);
end
