
hist(young_sd)
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','facealpha',0.0);
hold on;
hist(old_sd)


% hist(young_sd,20)
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor','g','EdgeColor','w','facealpha',0.75)
% hold on;
% hist(midage_sd,20)
% h1 = findobj(gca,'Type','patch');
% set(h1,'FaceColor','y','EdgeColor','w','facealpha',0.75)
% hold on;
% hist(old_sd,20)
% h2 = findobj(gca,'Type','patch');
% set(h2,'FaceColor','r','EdgeColor','w','facealpha',0.75)
