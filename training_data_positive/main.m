clc;clear all;close all;
%fileId = fopen('features.mat','w');
%fprintf(fileId,'Features \n');
cd training_data_positive
F=dir('*.wav');

numberOfClusters=20;
%arrneg=zeros(13,100,length(F));
finalbagOfWords_neg=[];
finalbagOfWords=[];
temp_array=[];
MFCC_trans = cell(length(F),1);
for i=1:length(F),

name=F(i).name;
%class(cellstr(name))
MFCCs=calcmfcc(name);
%arrneg(:,:,i)=[MFCCs zeros(13,100-(size(MFCCs,2)))];
MFCCs_trans{i}=MFCCs';
temp_array=[temp_array;MFCCs_trans{i}];
%save('arr.mat','MFCCs')

%[~,clusterCentroids]=kmeans(MFCCs_trans,numberOfClusters,'MaxIter',200);  
%bagOfWords= findBagofWords( clusterCentroids,MFCCs_trans);    %finds bag of words for 1st person
%finalbagOfWords=[finalbagOfWords;bagOfWords];        
%fprintf(fileId,'\n ------------------------- \n ');
%fprintf(fileId,'%12.8f\n',MFCCs');

end
%[~,clusterCentroids_pos]=kmeans(MFCCs_trans,numberOfClusters,'MaxIter',200);  
%bagOfWords_pos= findBagofWords( clusterCentroids_pos,MFCCs_trans);    %finds bag of words for 1st person
%finalbagOfWords=[finalbagOfWords;bagOfWords];  
temp_array_neg=[];
cd ..
cd /home/akshay/Documents/winter_school/HOF/tennis/negative1
G=dir('*.wav');
MFCCs_trans_neg=cell(length(G),1);
for j=1:length(G),
name=G(j).name;
MFCCs_trans_neg{j}=calcmfcc(name);


MFCCs_trans_neg{j}=MFCCs_trans_neg{j}';
%%size(MFCCs_trans_neg{i})
temp_array_neg=[temp_array_neg;MFCCs_trans_neg{j}];
end


%clusterCentroids=[clusterCentroids_pos;clusterCentroids_neg];
temp_array_final=[temp_array;temp_array_neg];

[~,clusterCentroids]=kmeans(temp_array_final,numberOfClusters,'MaxIter',200,'Start','cluster','EmptyAction','singleton');  

labels = zeros( length(F) + length(G), 1 );
bagOfWords = zeros( length(F) + length(G), numberOfClusters );
for i = 1:length(F)
    bagOfWords(i,:)= findBagofWords( clusterCentroids,MFCCs_trans{i}); %finds bag of words for 1st person
    %temp_norm= findBagofWords( clusterCentroids,MFCCs_trans{1});
    
    bagOfWords(i,:)=bagOfWords(i,:)/sum(bagOfWords(i,:));
    
    %temp_norm_after=bagOfWords(1,:)/sum(bagOfWords(1,:));
    labels(i,1) = 1;
end

mean_pos=mean(bagOfWords(1:length(F),:)); 
var_pos=var(bagOfWords(1:length(F),:));
for j = 1:length(G),
   
    bagOfWords(j + length(F),:)= findBagofWords( clusterCentroids,MFCCs_trans_neg{j});    %finds bag of words for 1st person
    %temp_norm= findBagofWords( clusterCentroids,MFCCs_trans_neg{1});
    %bagOfWords(j + length(F),:)=bagOfWords(j + length(F),:)/size(MFCCs_trans_neg{j},1);
    bagOfWords(j + length(F),:)=bagOfWords(j + length(F),:)/sum(bagOfWords(j+length(F),:));
    %temp_norm_after=bagOfWords(1 + length(F),:)/sum(bagOfWords(1+length(1),:));
    
    labels(j+length(F),1) = 0;
end
%temp_norm;
%temp_norm_after;

for i=1:numberOfClusters,
     temp_mean=mean(bagOfWords(:,i));
     temp_var=var(bagOfWords(:,i));
     bagOfWords(:,i)=(bagOfWords(:,i)-temp_mean)/sqrt(temp_var);
end
 
mean_neg= mean(bagOfWords(1:length(F)+length(G),:));
var_neg=var(bagOfWords(1:length(F)+length(G),:));
temp_score=(mean_pos-mean_neg);
temp_score=sum(temp_score.*temp_score)/20;
score=abs(temp_score-sqrt(mean(var_pos)));

    %finalbagOfWords_neg=[finalbagOfWords_neg;bagOfWords_neg]; 

permutation = randperm(size(bagOfWords,1));
bagOfWords = bagOfWords(permutation,:);
labels=labels(permutation,:);


%totalbagOfWords=[finalbagOfWords;finalbagOfWords_neg];

%fclose(fileId);
%size(arrneg)
cd ..
cd test/
save('labels.mat','labels');

save('cluster.mat','clusterCentroids');
save('arr.mat','bagOfWords');

%fclose(fileId);
%size(arrneg)

%save('arrneg.mat','arrneg')



