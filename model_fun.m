% описание функции 'model_fun' 
function [time, current] = model_fun(sets)
% sets - структура с параметрами модели электропередачи
% time - вектор столбец времени, s
% current - вектор столбец мгновенных значений токов, kA
% voltage - вектор столбец мгновенных значений напряжений, kV

i0 = 0; % начальное условие для моделирования

% временной интервал для моделирования
tspan = 0:sets.param.dt:sets.param.time; 

% решение уравнения модели электропередачи
[time, current] = ode45(@ft,tspan,i0);

    %функция правой части уравнения
    function [dit]=ft(t,i)

        % уравнение ЭДС источника:
        Et = sets.source.Es*sin(2*pi*sets.param.f*t + sets.source.psi*pi/180);

        % определение параметров системы для расчета
        if ((sets.param.tk_on <= t)&& (t < sets.param.tk_off))
            % во время короткого замыкания на линии:
            % вычисление параметра шунта КЗ (сопроивление дуги)
            Rkt = sets.shunt.Rk;    % неизменное во времени
            %Rkt = sets.shunt.Rk
            R_sum = sets.source.Rs + sets.line.R0*sets.shunt.length_k + Rkt;
            L_sum = sets.source.Ls + sets.line.L0*sets.shunt.length_k;
        else
            % во время нормального режима работы:
            R_sum = sets.source.Rs + sets.line.R0*sets.line.length + sets.load.Rn;
            L_sum = sets.source.Ls + sets.line.L0*sets.line.length + sets.load.Ln;
        end
        
        % результирующее уравнение:
        dit = Et/L_sum - (R_sum/L_sum)*i;
    end
end