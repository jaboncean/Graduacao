
clear all
close all
clc

latsup1 = -18.105
latinf1 = -21.356
lonleste1 = -41.6930
lonoeste1 = -38.2250

latsup2 = -16.817
latinf2 = -22.526
lonleste2 = -43.106
lonoeste2 = -36.779

latsup3 = -14.379
latinf3 = -24.830
lonleste3 = -45.611
lonoeste3 = -34.005



latpnboia = -19.935850
lonpnboia = -39.704230
latvix = -20.297938
lonvix = -40.295979

figure(1)
geoplot([latsup1 latinf1],[lonleste1 lonleste1],'b-','linewidth',4)
hold on
geoplot([latsup1 latinf1],[lonoeste1 lonoeste1],'b-','linewidth',4)
geoplot([latsup1 latsup1],[lonleste1 lonoeste1],'b-','linewidth',4)
geoplot([latinf1 latinf1],[lonleste1 lonoeste1],'b-','linewidth',4)
% geoplot(latvix,lonvix, 'g*','linewidth',1)
text(-24.5,-34.5,'d01 (27km)',...
      'HorizontalAlignment','right',...
      'VerticalAlignment','bottom','Color','blue','FontWeight','bold','FontSize',18)
  
text(-22.260,-36.968,'d02 (9km)',...
      'HorizontalAlignment','right',...
      'VerticalAlignment','bottom','Color','blue','FontWeight','bold','FontSize',16)

text(-21.11,-38.53,'d03 (3km)',...
      'HorizontalAlignment','right',...
      'VerticalAlignment','bottom','Color','blue','FontWeight','bold','FontSize',14)
  


geoplot([latsup2 latinf2],[lonleste2 lonleste2],'b-','linewidth',4)
hold on
geoplot([latsup2 latinf2],[lonoeste2 lonoeste2],'b-','linewidth',4)
geoplot([latsup2 latsup2],[lonleste2 lonoeste2],'b-','linewidth',4)
geoplot([latinf2 latinf2],[lonleste2 lonoeste2],'b-','linewidth',4)

geoplot([latsup3 latinf3],[lonleste3 lonleste3],'b-','linewidth',4)
hold on
geoplot([latsup3 latinf3],[lonoeste3 lonoeste3],'b-','linewidth',4)
geoplot([latsup3 latsup3],[lonleste3 lonoeste3],'b-','linewidth',4)
geoplot([latinf3 latinf3],[lonleste3 lonoeste3],'b-','linewidth',4)




% figure(2)
% geoplot(latpnboia,lonpnboia, 'g*','linewidth',1)
% hold on
% 
% 
% geolimits([latinf1 latsup1],[lonoeste1 lonleste1])

geolimits([-30 -5],[-50 -30])
geobasemap('landcover')
set(gca,'fontsize',16,'fontweight','bold')