clc
clear all
clc
s=what('/home/shruti/Desktop/Nonlinear_Govinda/FCs'); %change dir for your directory name
matfiles=s.mat;
bold=zeros(661,68,47);
for a=1:numel(matfiles)
x=char(matfiles(a));
y=strcat(x(1:end-13),'_ROIts_68');
signal{a}=load(x,y);
end
for j=1:47
    fn=fieldnames(signal{j}); 
    bold(:,:,j) = signal{j}.(fn{1});
end
save ('bold_file_new.mat','bold');