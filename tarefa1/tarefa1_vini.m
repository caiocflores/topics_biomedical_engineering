close all
clear globals
clc
files =  ["f2o03m","f2y03m"];

for j = 1:length(files)
  fig = figure('visible','off');
  file_name = files(j);
  [ylabels,x,val,interval] = plotATM(file_name);
  titles = ["Respira��o", "Eletrocardiograma", "Press�o arterial"];
  time = 5*60;
  
  samples  = time / interval;
  num_signals = size(val,1);
  
  for i = 1:size(val,1)
      subplot(num_signals,1,i);
      plot(x(1:samples)/60, val(i,1:samples));
      title(titles(i));
      xlabel('Tempo (min)');
      ylabel(ylabels(i))  
	  
  end
  sgtitle(file_name)
  saveas(fig,file_name,"png")
  

end