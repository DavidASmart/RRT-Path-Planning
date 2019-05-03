% Square
x1 = 55:105;
y1 = 67.5*ones(size(x1));
y2 = 112.5*ones(size(x1));
y3 = 67.5:112.5;
x3 = 55*ones(size(y3));
x4 = 105*ones(size(y3));

plot(x1,y1,'Color',[0.5 0.5 0.5],'LineWidth',2)
hold on
plot(x1,y2,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(x3,y3,'Color',[0.5 0.5 0.5],'LineWidth',2)
plot(x4,y3,'Color',[0.5 0.5 0.5],'LineWidth',2)

% Circle
t = 0:360;
x5 = 15*cosd(t)+180;
y5 = 15*sind(t)+120;

plot(x5,y5,'Color',[0.5 0.5 0.5],'LineWidth',2)
axis([0 250 0 150])
hold off