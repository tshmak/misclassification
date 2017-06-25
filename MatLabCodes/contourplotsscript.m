size = [13 3];
position = [0 0 size];
close;
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'Units', 'inches');
set(gcf, 'Position', position);
set(gcf, 'Color', 'white');
set(gcf, 'PaperUnits','inches');
set(gcf, 'PaperSize', size);
set(gcf, 'PaperPosition',position);


colormap winter

subplot(1,3,1);
contourf(graph1pi0, graph1sens1, graph1, 20);
colorbar;
xlabel('{\pi0}')
ylabel('{sens1}')

subplot(1,3,2);
contourf(graph2pi0, graph2spec1, graph2, 20);
colorbar;
xlabel('{\pi0}')
ylabel('{spec1}')

subplot(1,3,3);
contourf(graph3sens1, graph3spec1, graph3, 20);
colorbar;
xlabel('{sens1}')
ylabel('{spec1}')

set([findall(1,'type','text') ; findall(1,'type','axes')],'fontSize',14)
% set([findall(1,'type','text') ; findall(1,'type','axes')],'fontWeight','bold')
refresh