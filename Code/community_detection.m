function [ci0,Q_max]=community_detection(x)
    
   % x=reshape(mean2(x)*ones(68,68,1)-std_met(:,:,j),68,68);
    for i=1:1000
             [Ci0 Q0]= community_louvain(x,1,[],'negative_sym');
             Ci_iter(i,:)=Ci0;
             Q(i)=Q0;
    end
      Ci=transpose(Ci_iter);
      D=agreement(Ci);
      ci0=consensus_und(D,80,100);
      [~,Q_max]=max(Q);
      [Ci_sorted,Ci_I]=sort(ci0);
%figure;
    imagesc(x(Ci_I,Ci_I));
    hold on;
    [X,Y,INDSORT] = grid_communities(ci0);
    imagesc(x(INDSORT,INDSORT));           % plot ordered adjacency matrix
    hold on;                                 % hold on to overlay community visualization
    plot(X,Y,'g','linewidth',5);
           
end
% %fpcn=rois(ci0==ci0(22));
% %dmn=rois(ci0==ci0(31));