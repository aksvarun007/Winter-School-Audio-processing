function []=test_NB()

%size(MFCCs)
numberOfClusters=20;
%[~,clusterCentroids]=kmeans(MFCCs_trans,numberOfClusters,'MaxIter',200);
load('cluster.mat');


A=dir('*.wav');
MFCCs_trans_test=cell(length(A),1);
test_bagOfWords=zeros(length(A),numberOfClusters);
temp_test_array=[];
temp_mean=0;
temp_var=0;
for i=1:length(A),
    name=A(i).name;
    MFCCs=calcmfcc(name);
    MFCCs_trans_test{i}=MFCCs';
    temp_test_array=[temp_test_array;MFCCs_trans_test{i}];

    test_bagOfWords(i,:)= findBagofWords( clusterCentroids,MFCCs_trans_test{i}); %finds bag of words for 1st person
    %temp_norm= findBagofWords( clusterCentroids,MFCCs_trans{1});
    
    test_bagOfWords(i,:)=test_bagOfWords(i,:)/sum(test_bagOfWords(i,:));
end

for j=1:numberOfClusters,
    temp_mean=mean(test_bagOfWords(:,j));
    temp_var=var(test_bagOfWords(:,j));
    if temp_var~=0,
        
        test_bagOfWords(:,j)=(test_bagOfWords(:,j)-temp_mean)/sqrt(temp_var);
    end
    %temp_norm_after=bagOfWords(1,:)/sum(bagOfWords(1,:));
    %labels(j,1) = 1;
end
test_bagOfWords;
    %size(MFCCs_trans_test)
    %test_bagOfWords= findBagofWords(clusterCentroids,MFCCs_trans_test);%finds bag of words for 1st person

    %test_bagOfWords=test_bagOfWords/size(MFCCs_trans,1);

save('test.mat','test_bagOfWords')