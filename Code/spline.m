pick=[1,4,10,11,13,17,44];
k = 3;   % order 5, i.e., we are working with quartic splines
x = age_sorted;
y = SD_age_wise;
plot(x,y); ylim([0.1,0.22]);hold on; scatter(age_sorted,SD_age_wise,'filled');
 sp = spapi( optknt(x(pick),3), x, y );
  fnplt(sp,2,'g');
 hold on
 plot(x,y,'o')
 hold off
