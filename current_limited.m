% пусковой и логический орган токовой защиты
function [tf_arr1, tf_arr2] = current_limited(signals,current_set)
% signals - структура сигналов
% current_set - уставка токовой защиты

% инициализация сигнала срабатывания
tf_arr1 = zeros(size(signals.T));
tf_arr2 = zeros(size(signals.T));

k_return = 0.95;    % инициализация коэффициента возврата для защиты
flag_tf = false;    % флаг срабатывания защиты

c = 0;              % счетчик срабатываний 
t_point = zeros(2,1);
delay = 0.03;       % жадержка на повтор

for i = 1:1:size(signals.T)
    % первый пусковой орган
    if(signals.I_rms(i,1) >= current_set)
        flag_tf = true;  
    elseif((signals.I_rms(i,1) <= current_set*k_return)&&(flag_tf))
        flag_tf = false;
    end
    if(flag_tf)
        tf_arr1(i,1) = 1;
        
        if (c >= 2)
        if(((t_point(2,1) - t_point(1,1)) < delay))
            tf_arr2(i,1) = 1;
        else
            c = 0;
        end
        end  
    end
    
    % второй пусковой орган 
    if(i > 1)
        if ((tf_arr1(i - 1,1) < tf_arr1(i,1)))
            c = c + 1;
            t_point(c,1) = signals.T(i,1);
        end
    end
end
end