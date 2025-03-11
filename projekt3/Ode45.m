[t, x] = ode45(@dx, [0; 20], [0.001, -0.001]);
%plot(t, x(:,2), '-', t, x(:,1), '-');
plot(t, x(:,1), '-');
%xlabel('Time t');
%ylabel('Solution x');
%legend('x_1', 'x_2');
%plot(x(:, 1), x(:, 2));
%plot(t, x(:,1), '-', t, x(:,2), '-')
xlabel('Czas');
ylabel('Wartość funkcji');
%legend('x_1', 'x_2');
title('Wykres x1(t)')
grid on;


function dx_dt = dx(t, x)
    dx_dt = zeros(2, 1);
    dx_dt(1) = x(2) + x(1)*(0.6 - x(1)^2 - x(2)^2);
    dx_dt(2) = -x(1) + x(2)*(0.6 - x(1)^2 - x(2)^2);
end
