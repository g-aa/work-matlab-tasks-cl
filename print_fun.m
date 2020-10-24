% функция вывода результатов работы
function print_fun(signals,i_cl)
% signals - структура сигналов

CL = i_cl*ones(size(signals.T));    % уставка срабатывания

% настройка графического окна
set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);

% вывод мгновенных значений тока и напряжений
subplot(4,1,1);
plot(signals.T,signals.I,'LineWidth',2,'color',[255 140 0]/255);
grid on;
xlabel('время, с');
ylabel('i(t), кА');
title('График мгновенного значения тока i(t)');

% вывод среднеквадратичного значения сигнала
subplot(4,1,2);
plot(signals.T,[signals.I_rms, CL],'LineWidth',2);
legend('I rms', 'уставка срабатывания');
grid on;
xlabel('время, с');
ylabel('I rms, кА');
title('График средне квадратичных значений тока I rms');

% вывод сигнала срабатывания токового органа
subplot(4,1,3);
plot(signals.T,signals.TF_signal,'LineWidth',2,'color',[3, 130, 43]/255);
grid on;
ylim([0,2])
xlabel('время, с');
ylabel('срабатывание органа');
title('Сигнал срабатывания органа токовой защиты');

% вывод сигнала срабатывания токового органа v2
subplot(4,1,4);
plot(signals.T,signals.TF2_signal,'LineWidth',2,'color',[3, 130, 43]/255);
grid on;
ylim([0,2])
xlabel('время, с');
ylabel('срабатывание органа');
title('Сигнал срабатывания органа токовой защиты');
end