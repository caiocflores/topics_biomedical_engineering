clc; close all; clear all;
warning('off');

% sinal a ser plotado
wt = 0:pi/100:4*pi;
v1 = 1*sin(wt);
v2 = 1*cos(wt);

h = figure;

p = plot(wt, v1, wt, v2);

% recebendo as props 
ax = gca;
fig = gcf; 

% alterando cores das curvas
p(1).Color = 'red';
p(2).Color = 'blue';

% alterando estilo da linha
p(1).LineStyle = '-';
p(2).LineStyle = '--';

% alterando a espessura da linha
p(1).LineWidth = 1;
p(2).LineWidth = 1;

% definindo os intervalos dos eixos
xlim([0 4*pi]);
ylim([-2 2]);

% definindo marcacoes e rotulos dos eixos
ax.XTick = (0:pi/2:4*pi);
ax.XTickLabel = ({'0', '\pi/2', '\pi', '3\pi/2', '2\pi',...
                  '5\pi/2', '3\pi', '7\pi/2', '4\pi'});
              
ax.YTick = (-2:0.5:2);

% definindo rotulos dos eixos
hx = xlabel('Frequência Angular vezes Tempo (rad)');
hy = ylabel ('Amplitude (V)');

% definindo legendas das curvas 
leg = legend('Tensão 1', 'Tensão 2');
leg.Location = 'northeast';
leg.Orientation = 'horizontal';

% titulo do grafico
tt = title('Tensão');
%ax.FontSizeMultiplier = 2;
%ax.FontWeight = 'normal';
%ax.horizontalAlignment = 'right';
set(tt, 'horizontal');
%ax.TitleHorizontalAlignment = 'left';

% definindo fonte (familia tipografica)
ax.FontName = 'Times New Roman';

% definindo tamanho da fonte
fonte = 12;
ax.FontSize = fonte;
hx.FontSize = fonte;
hy.FontSize = fonte; 
ax.LabelFontSizeMultiplier = 1; 
leg.FontSize = fonte;

% interpretando o texto em LaTeX
ax.XTickLabel = ({'0', '\pi/2', '\pi', '3\pi/2', '2\pi',...
                  '5\pi/2', '3\pi', '7\pi/2', '4\pi'});
hx = xlabel({'$\omega t$ (rad)'});
hy = ylabel({'Amplitude (V)'});
leg = legend('$v_{1}, v_{2}$');
hx.Interpreter = 'latex';
hy.Interpreter = 'latex';
leg.Interpreter = 'latex';
ax.TickLabelInterpreter = 'latex';

% define o tamanho da figura
fig.Units = 'pixels';
fig.Position(3) = 600;
fig.Position(4) = 300;
fig.PaperPositionMode = 'auto';

% grid
grid on;
ax.GridLineStyle = ':';
ax.GridAlpha = 1;
ax.GridColor = 'k';

% redefinindo cor dos elementos na cor preta
ax.XColor = 'k';
ax.YColor = 'k';
hx.Color = 'k';
hy.Color ='k';
leg.EdgeColor = 'k';
leg.TextColor = 'k';

% trocando o separador decimal
% eixo x
xsepdec = ax.XTickLabel;
for k=1:1:length(xsepdec)
    new_xsepdec = strrep(xsepdec(k,:), '.', ',');
    new_xsepdec_vector(k,:) = new_xsepdec;
end

ax.XTickLabel = new_xsepdec_vector;

% eixo y
ysepdec = ax.YTickLabel;
for k=1:1:length(ysepdec)
    new_ysepdec = strrep(ysepdec(k,:), '.', ',');
    new_ysepdec_vector(k,:) = new_ysepdec;
end

ax.XTickLabel = new_ysepdec_vector;

% removendo margens da figura
ax.LooseInset = [0 0 0 0];


% salvando imagem
saveas(gcf, sprintf('%s.png', mfilename));
